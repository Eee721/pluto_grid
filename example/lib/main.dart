import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlutoGrid Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContextMenuOverlay(child:  PlutoGridExamplePage()),
    );
  }
}

/// PlutoGrid Example
//
/// For more examples, go to the demo web link on the github below.
class PlutoGridExamplePage extends StatefulWidget {
  const PlutoGridExamplePage({Key? key}) : super(key: key);

  @override
  State<PlutoGridExamplePage> createState() => _PlutoGridExamplePageState();
}

class _PlutoGridExamplePageState extends State<PlutoGridExamplePage> {
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'Id',
      field: 'id',
      type: PlutoColumnType.text(),
      // renderer: (r){
      //   return TextField(
      //     focusNode: FocusNode(
      //       onKey: (FocusNode node, RawKeyEvent event){
      //         print("custom key");
      //         return KeyEventResult.ignored;
      //       },
      //     ),
      //     onChanged: (v){
      //
      //     },
      //   );
      // }
    ),
    PlutoColumn(
      title: 'Name',
      field: 'name',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Age',
      field: 'age',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Role',
      field: 'role',
      type: PlutoColumnType.select(<String>[
        'Programmer',
        'Designer',
        'Owner',
      ]),
    ),
    PlutoColumn(
      title: 'Joined',
      field: 'joined',
      type: PlutoColumnType.date(),
    ),
    PlutoColumn(
      title: 'Working time',
      field: 'working_time',
      type: PlutoColumnType.time(),
    ),
    PlutoColumn(
      title: 'salary',
      field: 'salary',
      type: PlutoColumnType.currency(),
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          rendererContext: rendererContext,
          formatAsCurrency: true,
          type: PlutoAggregateColumnType.sum,
          format: '#,###',
          alignment: Alignment.center,
          titleSpanBuilder: (text) {
            return [
              const TextSpan(
                text: 'Sum',
                style: TextStyle(color: Colors.red),
              ),
              const TextSpan(text: ' : '),
              TextSpan(text: text),
            ];
          },
        );
      },
    ),
  ];

  final List<PlutoRow> rows = [
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 'user1'),
        'name': PlutoCell(value: 'Mike'),
        'age': PlutoCell(value: 20),
        'role': PlutoCell(value: 'Programmer'),
        'joined': PlutoCell(value: '2021-01-01'),
        'working_time': PlutoCell(value: '09:00'),
        'salary': PlutoCell(value: 300),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 'user2'),
        'name': PlutoCell(value: 'Jack'),
        'age': PlutoCell(value: 25),
        'role': PlutoCell(value: 'Designer'),
        'joined': PlutoCell(value: '2021-02-01'),
        'working_time': PlutoCell(value: '10:00'),
        'salary': PlutoCell(value: 400),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 'user3'),
        'name': PlutoCell(value: 'Suzi'),
        'age': PlutoCell(value: 40),
        'role': PlutoCell(value: 'Owner'),
        'joined': PlutoCell(value: '2021-03-01'),
        'working_time': PlutoCell(value: '11:00'),
        'salary': PlutoCell(value: 700),
      },
    ),
  ];



  /// columnGroups that can group columns can be omitted.
  final List<PlutoColumnGroup> columnGroups = [
    PlutoColumnGroup(title: 'Id', fields: ['id'], expandedColumn: true),
    PlutoColumnGroup(title: 'User information', fields: ['name', 'age']),
    PlutoColumnGroup(title: 'Status', children: [
      PlutoColumnGroup(title: 'A', fields: ['role'], expandedColumn: true),
      PlutoColumnGroup(title: 'Etc.', fields: ['joined', 'working_time']),
    ]),
  ];

  /// [PlutoGridStateManager] has many methods and properties to dynamically manipulate the grid.
  /// You can manipulate the grid dynamically at runtime by passing this through the [onLoaded] callback.
  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    for(int i = 100 ; i < 200 ;++i){
      rows.add(
        PlutoRow(
          cells: {
            'id': PlutoCell(value: 'user $i'),
            'name': PlutoCell(value: 'Suzi'),
            'age': PlutoCell(value: 40),
            'role': PlutoCell(value: 'Owner'),
            'joined': PlutoCell(value: '2021-03-01'),
            'working_time': PlutoCell(value: '11:00'),
            'salary': PlutoCell(value: 700),
          },
        ),
      );
    }
    // return Scaffold(
    //     body:FocusScope(
    //       onKey: (n,e){
    //         print("1");
    //         return KeyEventResult.ignored;
    //       },
    //       child: TextField(
    //         focusNode: FocusNode(
    //           onKey: (n,e){
    //             var keyManager = PlutoKeyManagerEvent(
    //               focusNode: n,
    //               event: e,
    //             );
    //
    //             if (keyManager.isKeyUpEvent) {
    //               return KeyEventResult.handled;
    //             }
    //
    //             final skip = !(keyManager.isVertical ||
    //                 // _moveHorizontal(keyManager) ||
    //                 keyManager.isEsc ||
    //                 keyManager.isTab ||
    //                 keyManager.isF3 ||
    //                 keyManager.isEnter);
    //             if (skip) {
    //               return KeyEventResult.ignored;
    //             }
    //
    //             return KeyEventResult.handled;
    //           },
    //         ),
    //         onChanged: (v){
    //
    //         },
    //       ),
    //     )
    // );

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: PlutoGrid(
          key: UniqueKey(),
            configuration: PlutoGridConfiguration.dark(
              style : PlutoGridStyleConfig.dark(
                activatedColor: Colors.green,
                hoverRowColor: Colors.red.withAlpha(40),
              ),
            ),
            columns: columns,
            rows: rows,
            columnGroups: columnGroups,
            onKeyEvent: (event){
              print("ctrl :${event.isCtrlPressed} , shift :${event.isShift} , char :${event.isCharacter}");
              return false;
            },
          // onHandleGridFocusOnKey: (n,e){
          //   return KeyEventResult.ignored;
          // },
          onRowSecondaryTap: (e){

          },
            onBackgroundSecondaryTap: (){

              // print("onBackgroundSecondaryTap");
              // ContextMenuOverlay.of(context).show(Container(
              //   width: 200,height: 100,color: Colors.redAccent,
              // ));
            },
            onLoaded: (PlutoGridOnLoadedEvent event) {
              stateManager = event.stateManager;
              stateManager.setShowColumnFilter(true);
              // stateManager.setSelecting(flag)
              stateManager.setCellSelectable(false);
              stateManager.setSelectingMode(PlutoGridSelectingMode.row);
              stateManager.setGridMode(PlutoGridMode.multiSelect);
            },
            onRowDoubleTap: (e){
              print(e.row);
            },
            onChanged: (PlutoGridOnChangedEvent event) {
              print(event);
            },
            onBackgroundDoubleTap: (){
              print("background double click");
            },
            // configuration: const PlutoGridConfiguration(),
          ),
        )
    );
  }
}
