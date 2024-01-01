// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Quotes{
  static List<All_Quotes>quotes=[];
  
}

class All_Quotes {

  String? q;
  String? a;
  String? h;

  All_Quotes({
    this.q,
    this.a,
    this.h,
  });




  All_Quotes copyWith({
    String? q,
    String? a,
    String? h,
  }) {
    return All_Quotes(
      q: q ?? this.q,
      a: a ?? this.a,
      h: h ?? this.h,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'q': q,
      'a': a,
      'h': h,
    };
  }

  factory All_Quotes.fromMap(Map<String, dynamic> map) {
    return All_Quotes(
      q: map['q'] != null ? map['q'] as String : null,
      a: map['a'] != null ? map['a'] as String : null,
      h: map['h'] != null ? map['h'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory All_Quotes.fromJson(String source) => All_Quotes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'All_Quotes(q: $q, a: $a, h: $h)';

  @override
  bool operator ==(covariant All_Quotes other) {
    if (identical(this, other)) return true;
  
    return 
      other.q == q &&
      other.a == a &&
      other.h == h;
  }

  @override
  int get hashCode => q.hashCode ^ a.hashCode ^ h.hashCode;
}
