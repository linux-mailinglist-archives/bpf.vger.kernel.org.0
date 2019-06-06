Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B85379C7
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 18:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfFFQew (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 12:34:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43316 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726841AbfFFQew (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jun 2019 12:34:52 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56GXC0T029956;
        Thu, 6 Jun 2019 09:34:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=qMsoIZueHAbZDT7kvJr8GmOXO6OYefl8tBO/FyT0Lr0=;
 b=dWHkFeEe0k0s7pLO32E3hfD+ITOd/WPX6My9tzc+41g5ST9zt8A01IGSdfnDhCkru6AX
 MQWIl7qmV+j+itM5UuG76q6SCtiJ8iEWvasPi8gqXntUmFV3cJqT3tmRhavh2/92RWCI
 w6Lhc8wZ6FWOVxfy7z6YRlAa/rdao8wT6JY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sy5hk0884-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 06 Jun 2019 09:34:30 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Jun 2019 09:34:29 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 6 Jun 2019 09:34:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMsoIZueHAbZDT7kvJr8GmOXO6OYefl8tBO/FyT0Lr0=;
 b=RNXuWyeFB9znkuhXZk4QY+tPPyfZIrJBkFqo0hyBKdt0VADkpz8YHzBZc2OYMVl++1T4a9+yp4wRd50YE6HFwFVwPQRfNnyHQXDm0r7p4iy+cjgWizAUCTDkQXl5X82GRwqFJftaqlNs4Hr2XyWFBIm4MMjKapAJYP+GdVH/hGQ=
Received: from BYAPR15MB2968.namprd15.prod.outlook.com (20.178.237.149) by
 BYAPR15MB2503.namprd15.prod.outlook.com (52.135.199.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Thu, 6 Jun 2019 16:34:28 +0000
Received: from BYAPR15MB2968.namprd15.prod.outlook.com
 ([fe80::1ccd:3dd5:6b36:eeed]) by BYAPR15MB2968.namprd15.prod.outlook.com
 ([fe80::1ccd:3dd5:6b36:eeed%5]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 16:34:28 +0000
From:   Hechao Li <hechaol@fb.com>
To:     Song Liu <songliubraving@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 1/2] bpf: add a new API libbpf_num_possible_cpus()
Thread-Topic: [PATCH 1/2] bpf: add a new API libbpf_num_possible_cpus()
Thread-Index: AQHVG/Sg7FDnmH9HmUOPenp3NVSoo6aOHc+AgABAWIA=
Date:   Thu, 6 Jun 2019 16:34:28 +0000
Message-ID: <B13DA96F-4581-495C-963D-E01A45E1FDCD@fb.com>
References: <20190605231506.2983988-1-hechaol@fb.com>
 <20190605231506.2983988-2-hechaol@fb.com>
 <7A5FA7F0-AD1C-401B-A1F6-EB46BF9E93B7@fb.com>
In-Reply-To: <7A5FA7F0-AD1C-401B-A1F6-EB46BF9E93B7@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::2:d551]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a072045-2029-4fdc-678b-08d6ea9cd849
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2503;
x-ms-traffictypediagnostic: BYAPR15MB2503:
x-microsoft-antispam-prvs: <BYAPR15MB25038D04EA4A66D57BBAC719D5170@BYAPR15MB2503.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:586;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(396003)(39860400002)(189003)(199004)(6436002)(6636002)(4326008)(6486002)(6512007)(14454004)(6862004)(46003)(81156014)(6506007)(71190400001)(6116002)(478600001)(102836004)(5660300002)(8676002)(2906002)(37006003)(446003)(25786009)(229853002)(33656002)(305945005)(8936002)(11346002)(68736007)(76176011)(7736002)(76116006)(91956017)(66476007)(53936002)(476003)(2616005)(36756003)(486006)(83716004)(186003)(66946007)(71200400001)(64756008)(73956011)(54906003)(256004)(86362001)(66556008)(14444005)(316002)(99286004)(6246003)(66446008)(82746002)(53546011)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2503;H:BYAPR15MB2968.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AUj1cU87dhGwbvGQPvctpYkpssOPy1EFEg1rXIHKO5uJgIEpjMNLYLQPP4RxANzMp21Gn1Cdg+5JYuDKZ4zPafXKDzkpPMVIOk95AIEtJOn83x0p6Ir15DKOzudoDJSw0IrhyXMEx6HqWcpDdDRBj9xE3zuwRwoMC7Q6mA9gCMykSgfPC6/NBX1GQk5b4rxF+eV7nKncS1rZL8gqxqFuakHdbyhfK9tVI54a76TDkbBOBG4kpb7mGCj0u4ML4qdGH81ucmIm25CKtcroNc1/n7M6j7uRhXVH8Ez14oYIz8DYGKMysNVEU1zb5J/OHtqtsU7B5J3K4YPqO69ge45isw9pcAXvZgqSUBhbxff+gUsfsud9SziQedgngBOhKnbjaRvK+un0orc3NQNgHYJTcW4y2KHZxrHDSCnH25xBX4E=
Content-Type: text/plain; charset="utf-8"
Content-ID: <470CE1C2727ABB41961506177AE64EC1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a072045-2029-4fdc-678b-08d6ea9cd849
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 16:34:28.2441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hechaol@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2503
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060112
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

U29uZyBMaXUgPHNvbmdsaXVicmF2aW5nQGZiLmNvbT4gd3JvdGUgb24gV2VkIFsyMDE5LUp1bi0w
NSAyMjo1MToyNCAtMDcwMF06DQo+IA0KPiANCj4gPiBPbiBKdW4gNSwgMjAxOSwgYXQgNDoxNSBQ
TSwgSGVjaGFvIExpIDxoZWNoYW9sQGZiLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gVXNlIHRoZSBu
ZXdseSBhZGRlZCBicGZfbnVtX3Bvc3NpYmxlX2NwdXMoKSBpbiBicGZ0b29sIGFuZCBzZWxmdGVz
dHMNCj4gPiBhbmQgcmVtb3ZlIGR1cGxpY2F0ZSBpbXBsZW1lbnRhdGlvbnMuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogSGVjaGFvIExpIDxoZWNoYW9sQGZiLmNvbT4NCj4gPiAtLS0NCj4gPiB0
b29scy9icGYvYnBmdG9vbC9jb21tb24uYyAgICAgICAgICAgICB8IDUzICsrKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ID4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL2JwZl91dGlsLmgg
fCAzNyArKystLS0tLS0tLS0tLS0tLS0NCj4gPiAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKyksIDgwIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS90b29scy9icGYv
YnBmdG9vbC9jb21tb24uYyBiL3Rvb2xzL2JwZi9icGZ0b29sL2NvbW1vbi5jDQo+ID4gaW5kZXgg
ZjcyNjFmYWQ0NWMxLi4wYjFjNTY3NThjZDkgMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvYnBmL2Jw
ZnRvb2wvY29tbW9uLmMNCj4gPiArKysgYi90b29scy9icGYvYnBmdG9vbC9jb21tb24uYw0KPiA+
IEBAIC0yMSw2ICsyMSw3IEBADQo+ID4gI2luY2x1ZGUgPHN5cy92ZnMuaD4NCj4gPiANCj4gPiAj
aW5jbHVkZSA8YnBmLmg+DQo+ID4gKyNpbmNsdWRlIDxsaWJicGYuaD4gLyogbGliYnBmX251bV9w
b3NzaWJsZV9jcHVzICovDQo+ID4gDQo+ID4gI2luY2x1ZGUgIm1haW4uaCINCj4gPiANCj4gPiBA
QCAtNDM5LDU3ICs0NDAsMTMgQEAgdW5zaWduZWQgaW50IGdldF9wYWdlX3NpemUodm9pZCkNCj4g
PiANCj4gPiB1bnNpZ25lZCBpbnQgZ2V0X3Bvc3NpYmxlX2NwdXModm9pZCkNCj4gPiB7DQo+ID4g
LQlzdGF0aWMgdW5zaWduZWQgaW50IHJlc3VsdDsNCj4gPiAtCWNoYXIgYnVmWzEyOF07DQo+ID4g
LQlsb25nIGludCBuOw0KPiA+IC0JY2hhciAqcHRyOw0KPiA+IC0JaW50IGZkOw0KPiA+IC0NCj4g
PiAtCWlmIChyZXN1bHQpDQo+ID4gLQkJcmV0dXJuIHJlc3VsdDsNCj4gPiAtDQo+ID4gLQlmZCA9
IG9wZW4oIi9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L3Bvc3NpYmxlIiwgT19SRE9OTFkpOw0KPiA+
IC0JaWYgKGZkIDwgMCkgew0KPiA+IC0JCXBfZXJyKCJjYW4ndCBvcGVuIHN5c2ZzIHBvc3NpYmxl
IGNwdXMiKTsNCj4gPiAtCQlleGl0KC0xKTsNCj4gPiAtCX0NCj4gPiAtDQo+ID4gLQluID0gcmVh
ZChmZCwgYnVmLCBzaXplb2YoYnVmKSk7DQo+ID4gLQlpZiAobiA8IDIpIHsNCj4gPiAtCQlwX2Vy
cigiY2FuJ3QgcmVhZCBzeXNmcyBwb3NzaWJsZSBjcHVzIik7DQo+ID4gLQkJZXhpdCgtMSk7DQo+
ID4gLQl9DQo+ID4gLQljbG9zZShmZCk7DQo+ID4gKwlpbnQgY3B1cyA9IGxpYmJwZl9udW1fcG9z
c2libGVfY3B1cygpOw0KPiA+IA0KPiA+IC0JaWYgKG4gPT0gc2l6ZW9mKGJ1ZikpIHsNCj4gPiAt
CQlwX2VycigicmVhZCBzeXNmcyBwb3NzaWJsZSBjcHVzIG92ZXJmbG93Iik7DQo+ID4gKwlpZiAo
Y3B1cyA8PSAwKSB7DQo+ID4gKwkJcF9lcnIoImNhbid0IGdldCAjIG9mIHBvc3NpYmxlIGNwdXMi
KTsNCj4gPiAJCWV4aXQoLTEpOw0KPiA+IAl9DQo+ID4gLQ0KPiA+IC0JcHRyID0gYnVmOw0KPiA+
IC0JbiA9IDA7DQo+ID4gLQl3aGlsZSAoKnB0ciAmJiAqcHRyICE9ICdcbicpIHsNCj4gPiAtCQl1
bnNpZ25lZCBpbnQgYSwgYjsNCj4gPiAtDQo+ID4gLQkJaWYgKHNzY2FuZihwdHIsICIldS0ldSIs
ICZhLCAmYikgPT0gMikgew0KPiA+IC0JCQluICs9IGIgLSBhICsgMTsNCj4gPiAtDQo+ID4gLQkJ
CXB0ciA9IHN0cmNocihwdHIsICctJykgKyAxOw0KPiA+IC0JCX0gZWxzZSBpZiAoc3NjYW5mKHB0
ciwgIiV1IiwgJmEpID09IDEpIHsNCj4gPiAtCQkJbisrOw0KPiA+IC0JCX0gZWxzZSB7DQo+ID4g
LQkJCWFzc2VydCgwKTsNCj4gPiAtCQl9DQo+ID4gLQ0KPiA+IC0JCXdoaWxlIChpc2RpZ2l0KCpw
dHIpKQ0KPiA+IC0JCQlwdHIrKzsNCj4gPiAtCQlpZiAoKnB0ciA9PSAnLCcpDQo+ID4gLQkJCXB0
cisrOw0KPiA+IC0JfQ0KPiA+IC0NCj4gPiAtCXJlc3VsdCA9IG47DQo+ID4gLQ0KPiA+IC0JcmV0
dXJuIHJlc3VsdDsNCj4gPiArCXJldHVybiBjcHVzOw0KPiA+IH0NCj4gPiANCj4gPiBzdGF0aWMg
Y2hhciAqDQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9icGZf
dXRpbC5oIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL2JwZl91dGlsLmgNCj4gPiBpbmRl
eCBhMjkyMDZlYmJkMTMuLjlhZDljNzU5NWY5MyAxMDA2NDQNCj4gPiAtLS0gYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9icGYvYnBmX3V0aWwuaA0KPiA+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JwZi9icGZfdXRpbC5oDQo+ID4gQEAgLTYsNDQgKzYsMTcgQEANCj4gPiAjaW5jbHVk
ZSA8c3RkbGliLmg+DQo+ID4gI2luY2x1ZGUgPHN0cmluZy5oPg0KPiA+ICNpbmNsdWRlIDxlcnJu
by5oPg0KPiA+ICsjaW5jbHVkZSA8bGliYnBmLmg+DQo+ID4gDQo+ID4gc3RhdGljIGlubGluZSB1
bnNpZ25lZCBpbnQgYnBmX251bV9wb3NzaWJsZV9jcHVzKHZvaWQpDQo+ID4gew0KPiA+IC0Jc3Rh
dGljIGNvbnN0IGNoYXIgKmZjcHUgPSAiL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvcG9zc2libGUi
Ow0KPiA+IC0JdW5zaWduZWQgaW50IHN0YXJ0LCBlbmQsIHBvc3NpYmxlX2NwdXMgPSAwOw0KPiA+
IC0JY2hhciBidWZmWzEyOF07DQo+ID4gLQlGSUxFICpmcDsNCj4gPiAtCWludCBsZW4sIG4sIGks
IGogPSAwOw0KPiA+ICsJaW50IHBvc3NpYmxlX2NwdXMgPSBsaWJicGZfbnVtX3Bvc3NpYmxlX2Nw
dXMoKTsNCj4gPiANCj4gPiAtCWZwID0gZm9wZW4oZmNwdSwgInIiKTsNCj4gPiAtCWlmICghZnAp
IHsNCj4gPiAtCQlwcmludGYoIkZhaWxlZCB0byBvcGVuICVzOiAnJXMnIVxuIiwgZmNwdSwgc3Ry
ZXJyb3IoZXJybm8pKTsNCj4gPiArCWlmIChwb3NzaWJsZV9jcHVzIDw9IDApIHsNCj4gPiArCQlw
cmludGYoIkZhaWxlZCB0byBnZXQgIyBvZiBwb3NzaWJsZSBjcHVzOiAnJXMnIVxuIiwNCj4gPiAr
CQkgICAgICAgc3RyZXJyb3IoLXBvc3NpYmxlX2NwdXMpKTsNCj4gDQo+IFRoaXMgaXMgbm90IGNv
cnJlY3QuIFRoZSAtcG9zc2libGVfY3B1cyBpcyBub3QgZXJybm8sIHNvIHdlIGNhbm5vdCANCj4g
dXNlIGl0IHdpdGggc3RyZXJyb3IoKS4gDQo+IA0KPiBJIGd1ZXNzIHdlIGNhbiBqdXN0IGdvIHdp
dGgNCj4gDQo+IAlwcmludGYoIkZhaWxlZCB0byBnZXQgIyBvZiBwb3NzaWJsZSBjcHVzIVxuIik7
DQo+IA0KPiBUaGFua3MsDQo+IFNvbmcNCg0KSSB0aGluayBpdCB3b3JrcyBnaXZlbiB0aGF0IGxp
YmJwZl9udW1fcG9zc2libGVfY3B1cygpIHJldHVybnMgLWVycm5vDQpvbiBlcnJvciwgZG9lc24n
dCBpdD8NCg0KVGhhbmtzLA0KSGVjaGFvDQoNCj4gDQo+ID4gCQlleGl0KDEpOw0KPiA+IAl9DQo+
ID4gLQ0KPiA+IC0JaWYgKCFmZ2V0cyhidWZmLCBzaXplb2YoYnVmZiksIGZwKSkgew0KPiA+IC0J
CXByaW50ZigiRmFpbGVkIHRvIHJlYWQgJXMhXG4iLCBmY3B1KTsNCj4gPiAtCQlleGl0KDEpOw0K
PiA+IC0JfQ0KPiA+IC0NCj4gPiAtCWxlbiA9IHN0cmxlbihidWZmKTsNCj4gPiAtCWZvciAoaSA9
IDA7IGkgPD0gbGVuOyBpKyspIHsNCj4gPiAtCQlpZiAoYnVmZltpXSA9PSAnLCcgfHwgYnVmZltp
XSA9PSAnXDAnKSB7DQo+ID4gLQkJCWJ1ZmZbaV0gPSAnXDAnOw0KPiA+IC0JCQluID0gc3NjYW5m
KCZidWZmW2pdLCAiJXUtJXUiLCAmc3RhcnQsICZlbmQpOw0KPiA+IC0JCQlpZiAobiA8PSAwKSB7
DQo+ID4gLQkJCQlwcmludGYoIkZhaWxlZCB0byByZXRyaWV2ZSAjIHBvc3NpYmxlIENQVXMhXG4i
KTsNCj4gPiAtCQkJCWV4aXQoMSk7DQo+ID4gLQkJCX0gZWxzZSBpZiAobiA9PSAxKSB7DQo+ID4g
LQkJCQllbmQgPSBzdGFydDsNCj4gPiAtCQkJfQ0KPiA+IC0JCQlwb3NzaWJsZV9jcHVzICs9IGVu
ZCAtIHN0YXJ0ICsgMTsNCj4gPiAtCQkJaiA9IGkgKyAxOw0KPiA+IC0JCX0NCj4gPiAtCX0NCj4g
PiAtDQo+ID4gLQlmY2xvc2UoZnApOw0KPiA+IC0NCj4gPiAJcmV0dXJuIHBvc3NpYmxlX2NwdXM7
DQo+ID4gfQ0KPiA+IA0KPiA+IC0tIA0KPiA+IDIuMTcuMQ0KPiA+IA0KPg0KDQo=
