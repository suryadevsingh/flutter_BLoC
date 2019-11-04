import 'dart:async';
import 'Employee.dart';

class EmployeeBloc {


    List<Employee> _emplyeeList =[
    Employee(1,"Employee one",1000.0),
      Employee(2,"Employee two",2000.0),
      Employee(3,"Employee three",3000.0),
      Employee(4,"Employee four",4000.0),
      Employee(5,"Employee five",5000.0),

    ];

    final _employeeListStreamController = StreamController<List<Employee>>();

    final _employeeSalaryIncrementStreamController = StreamController<Employee>();

    final _employeeSalaryDecrementStreamController = StreamController<Employee>();




    Stream<List<Employee>> get employeeListStream => _employeeListStreamController.stream;
    StreamSink<List<Employee>> get employeeListSink => _employeeListStreamController.sink;

    StreamSink<Employee> get employeeSalaryIncrement => _employeeSalaryIncrementStreamController.sink;


    StreamSink<Employee> get employeeSalaryDecrement => _employeeSalaryDecrementStreamController.sink;

EmployeeBloc(){
  _employeeListStreamController.add(_emplyeeList);

  _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);

  _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
}


    _incrementSalary(Employee employee){

  double salary = employee.salary;
  double incrementedSalary = salary * 20/100;
  _emplyeeList[employee.id -1].salary = salary + incrementedSalary;
  employeeListSink.add(_emplyeeList);

    }
    _decrementSalary(Employee employee){

      double salary = employee.salary;
      double decrementedSalary = salary * 20/100;
      _emplyeeList[employee.id -1].salary = salary - decrementedSalary;
      employeeListSink.add(_emplyeeList);

    }


    void dispose(){
  _employeeSalaryIncrementStreamController.close();
  _employeeSalaryDecrementStreamController.close();
  _employeeListStreamController.close();
    }
}
