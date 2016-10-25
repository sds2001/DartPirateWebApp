import 'package:angular2/core.dart';
import 'name_service.dart';

@Component(
    selector: 'pirate-badge',
    templateUrl: 'badge_component.html',
    styleUrls: const ['badge_component.css'],
    providers: const [NameService])

class BadgeComponent implements OnInit{
  String badgeName = '';
  String buttonText = 'Aye! Gimme a name';
  bool isButtonEnabled = false;
  bool isInputEnabled = false;
  final NameService _nameService;

  BadgeComponent(this._nameService);

  void setBadgeName([String newName = '']){
    if (newName == null) return;
    badgeName = _nameService.getPirateName(newName);
  }

  void generateBadge(){
    badgeName = 'Anne Bonney';
    setBadgeName();
  }

  void updateBadge(String inputName) {
    setBadgeName(inputName);

    if(inputName.trim().isEmpty){
      buttonText = 'Aye! Gimme a name';
      isButtonEnabled = true;
    }else{
      buttonText = 'Type yer name!';
      isButtonEnabled = false;
    }
  }

  @override
  ngOnInit() async{
    try {
      await _nameService.readyThePirates();
      //on success
      isButtonEnabled = true;
      isInputEnabled = true;
    } catch (arrr) {
      badgeName = 'Arrr! No names.';
      print('Error initializing pirate names: $arrr');
    }
  }

  }
