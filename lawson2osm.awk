
# EUCに変換してからこのスクリプトを使う。その後、UTF８に戻す。
# cat tenpomaster | nkf -e | awk -F, -f lawson2osm.awk | nkf -w > tenpomaster.osm

BEGIN {
    printf("<?xml version='1.0' encoding='UTF-8'?>\n");
    printf("<osm version='0.6'>\n");
}
{

    if($1 !~ /^[0-9]*$/) next

    cmd="echo "$11"|sed -e s/ー/-/g -e s/　*.$//g -e s/・/\\ /g| nkf -eZ|kakasi -Ha"
    cmd | getline t
    close(cmd)

    cmd2="echo "$17"|sed s/^0/+81-/g"
    cmd2|getline p
    close(cmd2)

    printf("  <node id='-%s' lat='%f' lon='%f'>\n",$1,$2/3600000,$3/3600000);
    printf("    <tag k='shop' v='convenience' />\n");
    printf("    <tag k='toilet' v='yes' />\n");
    printf("    <tag k='atm' v='yes' />\n");
    printf("    <tag k='internet_access' v='wlan' />\n");
    if($18==2){
	printf("    <tag k='name' v='ナチュラルローソン %s店' />\n",$9);
	printf("    <tag k='name:en' v=\"Natural Lawson %s\" />\n",t);
	printf("    <tag k='brand' v='ナチュラルローソン' />\n");
	printf("    <tag k='brand:en' v='Natural Lawson' />\n");
    }else if($18==4){
	printf("    <tag k='name' v='ローソンストア100 %s店' />\n",$9);
	printf("    <tag k='name:en' v=\"Lawson Store 100 %s\" />\n",t);
	printf("    <tag k='brand' v='ローソンストア100' />\n");
	printf("    <tag k='brand:en' v='Lawson Store 100' />\n");
    }else{
	printf("    <tag k='name' v='ローソン %s店' />\n",$9);
	printf("    <tag k='name:en' v=\"Lawson %s\" />\n",t);
	printf("    <tag k='brand' v='ローソン' />\n");
	printf("    <tag k='brand:en' v='Lawson' />\n");
    }
    printf("    <tag k='branch' v='%s店' />\n",$9);
    printf("    <tag k='branch:ja_kana' v='%sてん' />\n",$11);
    printf("    <tag k='branch:en' v=\"%s\" />\n",t);
    printf("    <tag k='operator' v='ローソン' />\n");
    printf("    <tag k='operator:en' v='Lawson' />\n");
    printf("    <tag k='phone' v='%s' />\n",p);
    if($19==1){
	printf("    <tag k='opening_hours' v='24/7' />\n");
    }else{
	if($20 > $21){
	    printf("    <tag k='opening_hours' v='Mo-Su %s-%d:%s' />\n",$20,substr($21,1,2)+24,substr($21,4,2));
	}else{
	    printf("    <tag k='opening_hours' v='Mo-Su %s-%s' />\n",$20,$21);
	}
    }
    if($5!=""){
	printf("    <tag k='start_date' v='%s-%s-%s' />\n",substr($5,1,4),substr($5,5,2),substr($5,7,2));
    }
    printf("    <tag k='addr:full' v='%s' />\n",$10);
    printf("    <tag k='ref' v='%s' />\n",$1);
    printf("    <tag k='source' v='Lawson' />\n",$1);
    printf("  </node>\n");
}
END {
    printf("</osm>\n");
}
