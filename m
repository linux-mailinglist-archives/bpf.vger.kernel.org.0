Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B723B2C8F
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2019 20:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfINSY0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 14 Sep 2019 14:24:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59980 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726646AbfINSY0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 14 Sep 2019 14:24:26 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8EICrAT005582;
        Sat, 14 Sep 2019 11:23:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=htaMw5QNjuEgNmYrhqgOqo8AF6QtGkjuYYRfQT7uQGE=;
 b=qrbcBlu0eyXTbEUL0gF9q0xXKQJU4QTo0iakHlcZGaABZEyTbllzxlOwUq4kA7AYqePG
 HgAUC1LoTOtj7+IunZ9IS4PHJ+o5HU2rpvyq7YLJ0jtnydTph1ars5FdPoAdzaW78GJ2
 7pT8byl8T7wu8gJ+y/JIEDblZn3PvUjLLiY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2v0x1f10tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 14 Sep 2019 11:23:48 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Sat, 14 Sep 2019 11:23:46 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Sat, 14 Sep 2019 11:23:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQTKspK5MhI7HryTKlM+ni9LvuUpVVgqn/bd9UQlhk7s0gvm4TglBEtfLvE9pfN9cYLru1jwhVU0QYahIazQedHv00eh2x1bEQyXE21U74HhHGnwpO7+8PXDr7Hj82K3hdTkk75iXrc99ClZeCyYUAs0bv8x401Qf9icZJCxG/XUL91akCK4lD8wPG+PvSdrRlft9MzZgJl7fFgogJo6vro3uE3gnI9YwbgEPCmFm/49SnKJ/AUF6lVM5q0wG9Bh9vsyCU9nQ2OWpHJsSNOm1N4HcMIT9p54FDyoEL/VFT5c5FbpqzQPZTBg3MbTTNiJzt8zkjR52JoKqSONYL8dMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htaMw5QNjuEgNmYrhqgOqo8AF6QtGkjuYYRfQT7uQGE=;
 b=TH6nx9XSjLqfYYuW9Y+N6smgzGIln1PgtuXNGxgJ7O+m6ssifg7BLbMFx/hEqVBE3SU0z/HfeJwZXNsMT8oA0FcQ09Cn3Dw0KUxjdSRm6TVFNQbTygf2VgqEFjSqdW6evyj23t0zCWEsmnUfprUgsbljsOc+63w84Wndnt8+z7H8Cvr1tVFUp4bOUp0oSnGGKjWXNzpXE9jCZmsFZhV/IDYaL45GemsdnxlZbo8WdKrH1sYGSs7wYwqlQ5TP2XNm/5PQAW04lgReTfkKDAQSZtYlST5Dx6n//HkeKSyDGPKmo9excKVPQLes9+KemxpKWhsHooIREhwqBR3iXl+Kdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htaMw5QNjuEgNmYrhqgOqo8AF6QtGkjuYYRfQT7uQGE=;
 b=BU9t5u3QvvlgVZQ6bkziT3GTHUhT0ciKC3nayUDdjfNgnzcUHjtWkSQV9qqf68TGhpHAKsmoBf+QDYPnvNRwdbQB6B/ZvB6GTMLcZvLzocoBF9Ax3zMkFiyHgrlA0BFOdqnckFdPADqJp2GPSBPGgYMMmrpA0cTo2UlbZWUATVo=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYAPR15MB2583.namprd15.prod.outlook.com (20.179.155.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Sat, 14 Sep 2019 18:23:43 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::95ab:61a0:29f4:e07e]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::95ab:61a0:29f4:e07e%6]) with mapi id 15.20.2263.021; Sat, 14 Sep 2019
 18:23:43 +0000
From:   Yonghong Song <yhs@fb.com>
To:     KP Singh <kpsingh@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        "Michael Halcrow" <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        "Quentin Monnet" <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, "Joe Stringer" <joe@wand.net.nz>
Subject: Re: [RFC v1 09/14] krsi: Add a helper function for
 bpf_perf_event_output
Thread-Topic: [RFC v1 09/14] krsi: Add a helper function for
 bpf_perf_event_output
Thread-Index: AQHVZ87j6v3GbYMXv06g263hQotnj6crg3AA
Date:   Sat, 14 Sep 2019 18:23:43 +0000
Message-ID: <ebd61ee8-ef18-c00c-f909-9d74002bd9a0@fb.com>
References: <20190910115527.5235-1-kpsingh@chromium.org>
 <20190910115527.5235-10-kpsingh@chromium.org>
In-Reply-To: <20190910115527.5235-10-kpsingh@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0049.namprd22.prod.outlook.com
 (2603:10b6:300:12a::11) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::5517]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ed7626f-374c-45cd-814c-08d73940ac69
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2583;
x-ms-traffictypediagnostic: BYAPR15MB2583:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB25837E8073E10B50825A3F0BD3B20@BYAPR15MB2583.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 01604FB62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(8936002)(8676002)(6486002)(66476007)(7416002)(66556008)(64756008)(66446008)(86362001)(81156014)(81166006)(6436002)(66946007)(31686004)(486006)(476003)(6512007)(6506007)(7736002)(102836004)(386003)(99286004)(31696002)(2201001)(6246003)(53546011)(229853002)(76176011)(305945005)(53936002)(52116002)(14444005)(256004)(14454004)(36756003)(4326008)(2501003)(498600001)(2906002)(186003)(71200400001)(54906003)(71190400001)(110136005)(6116002)(2616005)(446003)(11346002)(25786009)(5660300002)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2583;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3KVHNneGpmP1vcNdgP8mZP1L7cFh6ymNl+tvUkv62JWeevOv03Ke2yKfIwejJa94D8XJcqjkDthrRSdtlyK2Asu1mfo5WZyYLFA6E3gJaS8p4WpwpN9sdU0C/U0QBlNW2x0U1XLhKwaJEpl/XddWjTj7idRMo7l7ngvsezYFYVNXV8W5Te5P/0iWr/KIm9tLZkez4bKNBQFqggNn1yYDfXNF4dRTY/yEY4xCjKejPTGMpklEwkoyDqRHb/EV0Q9GPf6OdZTPUF8sgscc0K3k1AMUQpN4ulfxCXWK0mS96rVUeZ/BeYxEM1PTQVogHhIlbmyoK5USXXF5CXthbmCktShQNuBiHEFwNsq2Bs0EtiKi92s6xa8LdQyuZgJ1EC61t+7ArX+vwWtESV+YF9B7r+3+DLna0CpPc5y+OamKM/k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93CFC7C27F1EA040B8F6184423B90C27@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed7626f-374c-45cd-814c-08d73940ac69
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2019 18:23:43.3447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XNBgp0CrEKWzqlmw732yw8wG112TZOSJA+NHh/hLF/DjrnnvpeczoWRxyKdreRJt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2583
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-14_06:2019-09-11,2019-09-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909140195
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDkvMTAvMTkgMTI6NTUgUE0sIEtQIFNpbmdoIHdyb3RlOg0KPiBGcm9tOiBLUCBTaW5n
aCA8a3BzaW5naEBnb29nbGUuY29tPg0KPiANCj4gVGhpcyBoZWxwZXIgaXMgbWFwcGVkIHRvIHRo
ZSBleGlzdGluZyBvcGVyYXRpb24NCj4gQlBGX0ZVTkNfcGVyZl9ldmVudF9vdXRwdXQuDQo+IA0K
PiBBbiBleGFtcGxlIHVzYWdlIG9mIHRoaXMgZnVuY3Rpb24gd291bGQgYmU6DQo+IA0KPiAjZGVm
aW5lIEJVRl9TSVpFIDY0Ow0KPiANCj4gc3RydWN0IGJwZl9tYXBfZGVmIFNFQygibWFwcyIpIHBl
cmZfbWFwID0gew0KPiAgICAgICAgICAudHlwZSA9IEJQRl9NQVBfVFlQRV9QRVJGX0VWRU5UX0FS
UkFZLA0KPiAgICAgICAgICAua2V5X3NpemUgPSBzaXplb2YoaW50KSwNCj4gICAgICAgICAgLnZh
bHVlX3NpemUgPSBzaXplb2YodTMyKSwNCj4gICAgICAgICAgLm1heF9lbnRyaWVzID0gTUFYX0NQ
VVMsDQo+IH07DQoNCmNvdWxkIHlvdSB1c2UgYSBtYXAgZGVmaW5pdGlvbiBzaW1pbGFyIHRvDQp0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdGVzdF9wZXJmX2J1ZmZlci5jPw0KDQpz
dHJ1Y3Qgew0KICAgICAgICAgX191aW50KHR5cGUsIEJQRl9NQVBfVFlQRV9QRVJGX0VWRU5UX0FS
UkFZKTsNCiAgICAgICAgIF9fdWludChrZXlfc2l6ZSwgc2l6ZW9mKGludCkpOw0KICAgICAgICAg
X191aW50KHZhbHVlX3NpemUsIHNpemVvZih1MzIpKTsNCn0gcGVyZl9tYXAgU0VDKCIubWFwcyIp
Ow0KDQo+IA0KPiBTRUMoImtyc2kiKQ0KPiBpbnQgYnBmX3Byb2cxKHZvaWQgKmN0eCkNCj4gew0K
PiAJY2hhciBidWZbQlVGX1NJWkVdOw0KPiAJaW50IGxlbjsNCj4gCXU2NCBmbGFncyA9IEJQRl9G
X0NVUlJFTlRfQ1BVOw0KPiANCj4gCS8qIHNvbWUgbG9naWMgdGhhdCBmaWxscyB1cCBidWYgd2l0
aCBsZW4gZGF0YSovDQo+IAlsZW4gPSBmaWxsX3VwX2J1ZihidWYpOw0KPiAJaWYgKGxlbiA8IDAp
DQo+IAkJcmV0dXJuIGxlbjsNCj4gCWlmIChsZW4gPiBCVSkNCkJVRl9TSVpFPw0KPiAJCXJldHVy
biAwOw0KPiANCj4gCWJwZl9wZXJmX2V2ZW50X291dHB1dChjdHgsICZwZXJmX21hcCwgZmxhZ3Ms
IGJ1ZiBsZW4pOw0KYnVmLCBsZW4/DQo+IAlyZXR1cm4gMDsNCj4gfQ0KPiANCj4gQSBzYW1wbGUg
cHJvZ3JhbSB0aGF0IHNob3djYXNlcyB0aGUgdXNlIG9mIGJwZl9wZXJmX2V2ZW50X291dHB1dCBp
cw0KPiBhZGRlZCBsYXRlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtQIFNpbmdoIDxrcHNpbmdo
QGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgIHNlY3VyaXR5L2tyc2kvb3BzLmMgfCAyMiArKysrKysr
KysrKysrKysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9rcnNpL29wcy5jIGIvc2VjdXJpdHkva3JzaS9vcHMu
Yw0KPiBpbmRleCBhNjE1MDhiNzAxOGYuLjU3YmQzMDRhMDNmNCAxMDA2NDQNCj4gLS0tIGEvc2Vj
dXJpdHkva3JzaS9vcHMuYw0KPiArKysgYi9zZWN1cml0eS9rcnNpL29wcy5jDQo+IEBAIC0xMTEs
NiArMTExLDI2IEBAIHN0YXRpYyBib29sIGtyc2lfcHJvZ19pc192YWxpZF9hY2Nlc3MoaW50IG9m
ZiwgaW50IHNpemUsDQo+ICAgCXJldHVybiBmYWxzZTsNCj4gICB9DQo+ICAgDQo+ICtCUEZfQ0FM
TF81KGtyc2lfZXZlbnRfb3V0cHV0LCB2b2lkICosIGxvZywNCg0KTWF5YmUgbmFtZSB0aGUgZmly
c3QgYXJndW1lbnQgYXMgJ2N0eCcgdG8gZm9sbG93IHR5cGljYWwgaGVscGVyIGNvbnZlbnRpb24/
DQoNCj4gKwkgICBzdHJ1Y3QgYnBmX21hcCAqLCBtYXAsIHU2NCwgZmxhZ3MsIHZvaWQgKiwgZGF0
YSwgdTY0LCBzaXplKQ0KPiArew0KPiArCWlmICh1bmxpa2VseShmbGFncyAmIH4oQlBGX0ZfSU5E
RVhfTUFTSykpKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArCXJldHVybiBicGZfZXZl
bnRfb3V0cHV0KG1hcCwgZmxhZ3MsIGRhdGEsIHNpemUsIE5VTEwsIDAsIE5VTEwpOw0KPiArfQ0K
PiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGJwZl9mdW5jX3Byb3RvIGtyc2lfZXZlbnRfb3V0
cHV0X3Byb3RvID0gIHsNCj4gKwkuZnVuYwkJPSBrcnNpX2V2ZW50X291dHB1dCwNCj4gKwkuZ3Bs
X29ubHkgICAgICAgPSB0cnVlLA0KPiArCS5yZXRfdHlwZSAgICAgICA9IFJFVF9JTlRFR0VSLA0K
PiArCS5hcmcxX3R5cGUgICAgICA9IEFSR19QVFJfVE9fQ1RYLA0KPiArCS5hcmcyX3R5cGUgICAg
ICA9IEFSR19DT05TVF9NQVBfUFRSLA0KPiArCS5hcmczX3R5cGUgICAgICA9IEFSR19BTllUSElO
RywNCj4gKwkuYXJnNF90eXBlICAgICAgPSBBUkdfUFRSX1RPX01FTSwNCj4gKwkuYXJnNV90eXBl
ICAgICAgPSBBUkdfQ09OU1RfU0laRV9PUl9aRVJPLA0KPiArfTsNCj4gKw0KPiAgIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgYnBmX2Z1bmNfcHJvdG8gKmtyc2lfcHJvZ19mdW5jX3Byb3RvKGVudW0gYnBm
X2Z1bmNfaWQNCj4gICAJCQkJCQkJIGZ1bmNfaWQsDQo+ICAgCQkJCQkJCSBjb25zdCBzdHJ1Y3Qg
YnBmX3Byb2cNCj4gQEAgLTEyMSw2ICsxNDEsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGJwZl9m
dW5jX3Byb3RvICprcnNpX3Byb2dfZnVuY19wcm90byhlbnVtIGJwZl9mdW5jX2lkDQo+ICAgCQly
ZXR1cm4gJmJwZl9tYXBfbG9va3VwX2VsZW1fcHJvdG87DQo+ICAgCWNhc2UgQlBGX0ZVTkNfZ2V0
X2N1cnJlbnRfcGlkX3RnaWQ6DQo+ICAgCQlyZXR1cm4gJmJwZl9nZXRfY3VycmVudF9waWRfdGdp
ZF9wcm90bzsNCj4gKwljYXNlIEJQRl9GVU5DX3BlcmZfZXZlbnRfb3V0cHV0Og0KPiArCQlyZXR1
cm4gJmtyc2lfZXZlbnRfb3V0cHV0X3Byb3RvOw0KPiAgIAlkZWZhdWx0Og0KPiAgIAkJcmV0dXJu
IE5VTEw7DQo+ICAgCX0NCj4gDQo=
