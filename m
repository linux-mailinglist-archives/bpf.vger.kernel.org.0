Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29FB1B2C4E
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2019 18:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfINQ5r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 14 Sep 2019 12:57:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52604 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727737AbfINQ5r (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 14 Sep 2019 12:57:47 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8EGs9UY017153;
        Sat, 14 Sep 2019 09:57:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=//rs23v68AU+/066WYhVeh/dqtB65y9ED64ytLwjE1k=;
 b=iTEQ8WM+t6vocR5IyyTUdADttLw8/AFHtOKB5Jh+xB4qgr0Cv1oyDlNsMRT6S1pnz/Go
 2X+C5e2QhdSY3ovpbaAnxIgjin+75MfuShLIzJy/tAN34B2qIn0inMQMPFgl3kd6gvQS
 /RoU30DVJruqqfrfqw3Gbm9iC+idKXc72jQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2v0x1f0u11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 14 Sep 2019 09:57:08 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 14 Sep 2019 09:57:07 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 14 Sep 2019 09:57:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1QJuR/d1h9SU/iMIiKcM8XnwW3YhFlfWYVTWcnxXgNOH/8FytZ26GKnxbqaPe0ww3B4w/eD216+B/GaUNNXRtd2GSakH9zYIxuEz9jPoDMJuEYXo7fGYoLc1dKOFjMNFH3tXghLiVPOz8IK8cmgWV42eo4BZQi/psQNwWbgDvNXsBhC1cN+w92+opW/UYXVaFS1v4TZIXCBXp9lEZdRdWilFKVUtn21di6EENrksYPTu2rrsWs0tBlaOIx+qC0JiSnWwFwJI7hH6o4EULnTWZ8dKCKNGDYn8BcB4pVwFLswEpOsawSjvMqGiF3hhMF1VO0B6QA0lNcsObyARXMzew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//rs23v68AU+/066WYhVeh/dqtB65y9ED64ytLwjE1k=;
 b=BGUKjpV8EtsPyPBgQVhtXhZ8j3jbPZqp8b5kGVIpZh80A0I27HB0wI7Yna3RnYixNpggKFeYnjtnmZzd8Z3n5WGcU0gA1Eh/yir/sLPywXjrjjv7v+itvq8ULqCEs5wARZeS9pmdTFGOC7hF/zYz3O/m+mkkvtcNvuEMJksXkbkRXcGS/8WdnDVkal3/2ZYsUniIUNZaZXKf34DZI2f4LpPR6xts+lRXvBr01Qh/rvARCSD5Ze3Z3Lo6Ck7t3+LhNfg0YoR55Lb+j/FewpDaPOZYiugJRZS6IQFkwonHj5oJOVxsU5aAvhzx+x/CJSS7B9e2KU44YkdQ/k7E/gIbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//rs23v68AU+/066WYhVeh/dqtB65y9ED64ytLwjE1k=;
 b=bulH4+8Vex+OCHpMUWxgXKouzPQBgF4E6p3sdejcSegenYQDYe78nxW5oQyUYmHhzJpKd0huIyJ8DlOlcRL8ZVvax1SFxFPCp9l/jzJWv3Z70KcD0a1jKXEc78HqeQQESzmpDUSxXhC/6ibBohYC2ouiQOPyMYo91iabLenqqX0=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYAPR15MB2567.namprd15.prod.outlook.com (20.179.155.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.20; Sat, 14 Sep 2019 16:56:52 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::95ab:61a0:29f4:e07e]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::95ab:61a0:29f4:e07e%6]) with mapi id 15.20.2263.021; Sat, 14 Sep 2019
 16:56:52 +0000
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
Subject: Re: [RFC v1 06/14] krsi: Implement eBPF operations, attachment and
 execution
Thread-Topic: [RFC v1 06/14] krsi: Implement eBPF operations, attachment and
 execution
Thread-Index: AQHVZ87TGQ2rzc/y1EW6zOg/S4OXiacraymA
Date:   Sat, 14 Sep 2019 16:56:52 +0000
Message-ID: <bb2d4453-f01f-8fb2-d901-a7a0a5eb4a4d@fb.com>
References: <20190910115527.5235-1-kpsingh@chromium.org>
 <20190910115527.5235-7-kpsingh@chromium.org>
In-Reply-To: <20190910115527.5235-7-kpsingh@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR07CA0063.namprd07.prod.outlook.com (2603:10b6:100::31)
 To BYAPR15MB3384.namprd15.prod.outlook.com (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::9917]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49438504-b66e-4d44-5912-08d739348a54
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2567;
x-ms-traffictypediagnostic: BYAPR15MB2567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB25673C717BE069DD0A3E628ED3B20@BYAPR15MB2567.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01604FB62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(366004)(39860400002)(346002)(189003)(199004)(11346002)(446003)(2616005)(386003)(7736002)(86362001)(305945005)(25786009)(7416002)(66446008)(64756008)(6116002)(36756003)(5660300002)(4326008)(2906002)(476003)(6512007)(256004)(14444005)(5024004)(53936002)(6246003)(66946007)(6436002)(478600001)(6486002)(486006)(52116002)(14454004)(76176011)(53546011)(102836004)(6506007)(71200400001)(71190400001)(8676002)(31686004)(229853002)(66556008)(66476007)(2501003)(99286004)(31696002)(81156014)(81166006)(8936002)(110136005)(316002)(54906003)(2201001)(186003)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2567;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Yo5WArAKKJoqAgnoMUvgwD/+IXOCuUJrG5IpNx71mzL7J9rgnbC1h8R22SouxTH+fbFREPTV69Kf43RfYnZNWAfKk3MISTrEfeqXzenG1iY/7XBEOnDK5QfnQsMizb99NOa2LF1wBRUTxkV+wrwlVd/0NjgjmWIwtm/rcyvwz/zPmiCgIrwTUKn3Pn/FyyvZHz3M6Bi6UWPiH6Z1lzPUgR1pXeihhWxZMaE2IGI1DiBur6YQhi2kqBqFgntrJlSuOjb9VRboaELcJo8dqq6icV8TgvBMukLucivmVfED1IgW5VBtnoQRcaFgLucZnqhtA1IdoOq/qZNPsgk//rIOWt9jkIKyhPbT6ClC8Y1m3p8X34dJDANBJs9kSjx9oBYXHU4N9ckTgSttBRBxNzA1r0Cw2G8Nb3X+kaE9Z7Zl9AU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D51B14C07C1A248A46CAA00C4FB945A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 49438504-b66e-4d44-5912-08d739348a54
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2019 16:56:52.0509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xBQYrRhzPpC+NXviZVG+qWNoDkwxUJM3ezRXts6gNzEb3rMP3MIkK2M7W2aKHFGl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2567
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-14_05:2019-09-11,2019-09-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909140180
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDkvMTAvMTkgMTI6NTUgUE0sIEtQIFNpbmdoIHdyb3RlOg0KPiBGcm9tOiBLUCBTaW5n
aCA8a3BzaW5naEBnb29nbGUuY29tPg0KPiANCj4gQSB1c2VyIHNwYWNlIHByb2dyYW0gY2FuIGF0
dGFjaCBhbiBlQlBGIHByb2dyYW0gYnk6DQo+IA0KPiAgICBob29rX2ZkID0gb3BlbigiL3N5cy9r
ZXJuZWwvc2VjdXJpdHkva3JzaS9wcm9jZXNzX2V4ZWN1dGlvbiIsIE9fUkRXUikNCj4gICAgcHJv
Z19mZCA9IGJwZihCUEZfUFJPR19MT0FELCAuLi4pDQo+ICAgIGJwZihCUEZfUFJPR19BVFRBQ0gs
IGhvb2tfZmQsIHByb2dfZmQpDQo+IA0KPiBXaGVuIHN1Y2ggYW4gYXR0YWNoIGNhbGwgaXMgcmVj
ZWl2ZWQsIHRoZSBhdHRhY2htZW50IGxvZ2ljIGxvb2tzIHVwIHRoZQ0KPiBkZW50cnkgYW5kIGFw
cGVuZHMgdGhlIHByb2dyYW0gdG8gdGhlIGJwZl9wcm9nX2FycmF5Lg0KPiANCj4gVGhlIEJQRiBw
cm9ncmFtcyBhcmUgc3RvcmVkIGluIGEgYnBmX3Byb2dfYXJyYXkgYW5kIHdyaXRlcyB0byB0aGUg
YXJyYXkNCj4gYXJlIGd1YXJkZWQgYnkgYSBtdXRleC4gVGhlIGVCUEYgcHJvZ3JhbXMgYXJlIGV4
ZWN1dGVkIGFzIGEgcGFydCBvZiB0aGUNCj4gTFNNIGhvb2sgdGhleSBhcmUgYXR0YWNoZWQgdG8u
IElmIGFueSBvZiB0aGUgZUJQRiBwcm9ncmFtcyByZXR1cm4NCj4gYW4gZXJyb3IgKC1FTk9QRVJN
KSB0aGUgYWN0aW9uIHJlcHJlc2VudGVkIGJ5IHRoZSBob29rIGlzIGRlbmllZC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEtQIFNpbmdoIDxrcHNpbmdoQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgIGlu
Y2x1ZGUvbGludXgva3JzaS5oICAgICAgICAgICAgICB8ICAxOCArKysrKysNCj4gICBrZXJuZWwv
YnBmL3N5c2NhbGwuYyAgICAgICAgICAgICAgfCAgIDMgKy0NCj4gICBzZWN1cml0eS9rcnNpL2lu
Y2x1ZGUva3JzaV9pbml0LmggfCAgNTEgKysrKysrKysrKysrKysrDQo+ICAgc2VjdXJpdHkva3Jz
aS9rcnNpLmMgICAgICAgICAgICAgIHwgIDEzICsrKy0NCj4gICBzZWN1cml0eS9rcnNpL2tyc2lf
ZnMuYyAgICAgICAgICAgfCAgMjggKysrKysrKysNCj4gICBzZWN1cml0eS9rcnNpL29wcy5jICAg
ICAgICAgICAgICAgfCAxMDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgNiBm
aWxlcyBjaGFuZ2VkLCAyMTMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9rcnNpLmgNCj4gDQo+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L2tyc2kuaCBiL2luY2x1ZGUvbGludXgva3JzaS5oDQo+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uYzdkMTc5MGQwYzFmDQo+IC0tLSAvZGV2
L251bGwNCj4gKysrIGIvaW5jbHVkZS9saW51eC9rcnNpLmgNCj4gQEAgLTAsMCArMSwxOCBAQA0K
PiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4gKw0KPiArI2lmbmRl
ZiBfS1JTSV9IDQo+ICsjZGVmaW5lIF9LUlNJX0gNCj4gKw0KPiArI2luY2x1ZGUgPGxpbnV4L2Jw
Zi5oPg0KPiArDQo+ICsjaWZkZWYgQ09ORklHX1NFQ1VSSVRZX0tSU0kNCj4gK2ludCBrcnNpX3By
b2dfYXR0YWNoKGNvbnN0IHVuaW9uIGJwZl9hdHRyICphdHRyLCBzdHJ1Y3QgYnBmX3Byb2cgKnBy
b2cpOw0KPiArI2Vsc2UNCj4gK3N0YXRpYyBpbmxpbmUgaW50IGtyc2lfcHJvZ19hdHRhY2goY29u
c3QgdW5pb24gYnBmX2F0dHIgKmF0dHIsDQo+ICsJCQkJICAgc3RydWN0IGJwZl9wcm9nICpwcm9n
KQ0KPiArew0KPiArCXJldHVybiAtRUlOVkFMOw0KPiArfQ0KPiArI2VuZGlmIC8qIENPTkZJR19T
RUNVUklUWV9LUlNJICovDQo+ICsNCj4gKyNlbmRpZiAvKiBfS1JTSV9IICovDQo+IGRpZmYgLS1n
aXQgYS9rZXJuZWwvYnBmL3N5c2NhbGwuYyBiL2tlcm5lbC9icGYvc3lzY2FsbC5jDQo+IGluZGV4
IGYzOGE1MzlmN2U2Ny4uYWIwNjNlZDg0MjU4IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvYnBmL3N5
c2NhbGwuYw0KPiArKysgYi9rZXJuZWwvYnBmL3N5c2NhbGwuYw0KPiBAQCAtNCw2ICs0LDcgQEAN
Cj4gICAjaW5jbHVkZSA8bGludXgvYnBmLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L2JwZl90cmFj
ZS5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9icGZfbGlyYy5oPg0KPiArI2luY2x1ZGUgPGxpbnV4
L2tyc2kuaD4NCj4gICAjaW5jbHVkZSA8bGludXgvYnRmLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4
L3N5c2NhbGxzLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gQEAgLTE5NTAsNyAr
MTk1MSw3IEBAIHN0YXRpYyBpbnQgYnBmX3Byb2dfYXR0YWNoKGNvbnN0IHVuaW9uIGJwZl9hdHRy
ICphdHRyKQ0KPiAgIAkJcmV0ID0gbGlyY19wcm9nX2F0dGFjaChhdHRyLCBwcm9nKTsNCj4gICAJ
CWJyZWFrOw0KPiAgIAljYXNlIEJQRl9QUk9HX1RZUEVfS1JTSToNCj4gLQkJcmV0ID0gLUVJTlZB
TDsNCj4gKwkJcmV0ID0ga3JzaV9wcm9nX2F0dGFjaChhdHRyLCBwcm9nKTsNCj4gICAJCWJyZWFr
Ow0KPiAgIAljYXNlIEJQRl9QUk9HX1RZUEVfRkxPV19ESVNTRUNUT1I6DQo+ICAgCQlyZXQgPSBz
a2JfZmxvd19kaXNzZWN0b3JfYnBmX3Byb2dfYXR0YWNoKGF0dHIsIHByb2cpOw0KPiBkaWZmIC0t
Z2l0IGEvc2VjdXJpdHkva3JzaS9pbmNsdWRlL2tyc2lfaW5pdC5oIGIvc2VjdXJpdHkva3JzaS9p
bmNsdWRlL2tyc2lfaW5pdC5oDQo+IGluZGV4IDY4NzU1MTgyYTAzMS4uNGUxN2VjYWNkNGVkIDEw
MDY0NA0KPiAtLS0gYS9zZWN1cml0eS9rcnNpL2luY2x1ZGUva3JzaV9pbml0LmgNCj4gKysrIGIv
c2VjdXJpdHkva3JzaS9pbmNsdWRlL2tyc2lfaW5pdC5oDQo+IEBAIC01LDEyICs1LDI5IEBADQo+
ICAgDQo+ICAgI2luY2x1ZGUgImtyc2lfZnMuaCINCj4gICANCj4gKyNpbmNsdWRlIDxsaW51eC9i
aW5mbXRzLmg+DQo+ICsNCj4gICBlbnVtIGtyc2lfaG9va190eXBlIHsNCj4gICAJUFJPQ0VTU19F
WEVDVVRJT04sDQo+ICAgCV9fTUFYX0tSU0lfSE9PS19UWVBFLCAvKiBkZWxpbWl0ZXIgKi8NCj4g
ICB9Ow0KPiAgIA0KPiAgIGV4dGVybiBpbnQga3JzaV9mc19pbml0aWFsaXplZDsNCj4gKw0KPiAr
c3RydWN0IGtyc2lfYnBybV9jdHggew0KPiArCXN0cnVjdCBsaW51eF9iaW5wcm0gKmJwcm07DQo+
ICt9Ow0KPiArDQo+ICsvKg0KPiArICoga3JzaV9jdHggaXMgdGhlIGNvbnRleHQgdGhhdCBpcyBw
YXNzZWQgdG8gYWxsIEtSU0kgZUJQRg0KPiArICogcHJvZ3JhbXMuDQo+ICsgKi8NCj4gK3N0cnVj
dCBrcnNpX2N0eCB7DQo+ICsJdW5pb24gew0KPiArCQlzdHJ1Y3Qga3JzaV9icHJtX2N0eCBicHJt
X2N0eDsNCj4gKwl9Ow0KPiArfTsNCj4gKw0KPiAgIC8qDQo+ICAgICogVGhlIExTTSBjcmVhdGVz
IG9uZSBmaWxlIHBlciBob29rLg0KPiAgICAqDQo+IEBAIC0zMywxMCArNTAsNDQgQEAgc3RydWN0
IGtyc2lfaG9vayB7DQo+ICAgCSAqIFRoZSBkZW50cnkgb2YgdGhlIGZpbGUgY3JlYXRlZCBpbiBz
ZWN1cml0eWZzLg0KPiAgIAkgKi8NCj4gICAJc3RydWN0IGRlbnRyeSAqaF9kZW50cnk7DQo+ICsJ
LyoNCj4gKwkgKiBUaGUgbXV0ZXggbXVzdCBiZSBoZWxkIHdoZW4gdXBkYXRpbmcgdGhlIHByb2dz
IGF0dGFjaGVkIHRvIHRoZSBob29rLg0KPiArCSAqLw0KPiArCXN0cnVjdCBtdXRleCBtdXRleDsN
Cj4gKwkvKg0KPiArCSAqIFRoZSBlQlBGIHByb2dyYW1zIHRoYXQgYXJlIGF0dGFjaGVkIHRvIHRo
aXMgaG9vay4NCj4gKwkgKi8NCj4gKwlzdHJ1Y3QgYnBmX3Byb2dfYXJyYXkgX19yY3UJKnByb2dz
Ow0KPiAgIH07DQo+ICAgDQo+ICAgZXh0ZXJuIHN0cnVjdCBrcnNpX2hvb2sga3JzaV9ob29rc19s
aXN0W107DQo+ICAgDQo+ICtzdGF0aWMgaW5saW5lIGludCBrcnNpX3J1bl9wcm9ncyhlbnVtIGty
c2lfaG9va190eXBlIHQsIHN0cnVjdCBrcnNpX2N0eCAqY3R4KQ0KPiArew0KPiArCXN0cnVjdCBi
cGZfcHJvZ19hcnJheV9pdGVtICppdGVtOw0KPiArCXN0cnVjdCBicGZfcHJvZyAqcHJvZzsNCj4g
KwlzdHJ1Y3Qga3JzaV9ob29rICpoID0gJmtyc2lfaG9va3NfbGlzdFt0XTsNCj4gKwlpbnQgcmV0
LCByZXR2YWwgPSAwOw0KDQpSZXZlcnNlIGNocmlzdG1hcyB0cmVlIHN0eWxlPw0KDQo+ICsNCj4g
KwlwcmVlbXB0X2Rpc2FibGUoKTsNCg0KRG8gd2UgbmVlZCBwcmVlbXB0X2Rpc2FibGUoKSBoZXJl
Pw0KDQo+ICsJcmN1X3JlYWRfbG9jaygpOw0KPiArDQo+ICsJaXRlbSA9IHJjdV9kZXJlZmVyZW5j
ZShoLT5wcm9ncyktPml0ZW1zOw0KPiArCXdoaWxlICgocHJvZyA9IFJFQURfT05DRShpdGVtLT5w
cm9nKSkpIHsNCj4gKwkJcmV0ID0gQlBGX1BST0dfUlVOKHByb2csIGN0eCk7DQo+ICsJCWlmIChy
ZXQgPCAwKSB7DQo+ICsJCQlyZXR2YWwgPSByZXQ7DQo+ICsJCQlnb3RvIG91dDsNCj4gKwkJfQ0K
PiArCQlpdGVtKys7DQo+ICsJfQ0KPiArDQo+ICtvdXQ6DQo+ICsJcmN1X3JlYWRfdW5sb2NrKCk7
DQo+ICsJcHJlZW1wdF9lbmFibGUoKTsNCj4gKwlyZXR1cm4gSVNfRU5BQkxFRChDT05GSUdfU0VD
VVJJVFlfS1JTSV9FTkZPUkNFKSA/IHJldHZhbCA6IDA7DQo+ICt9DQo+ICsNCj4gICAjZGVmaW5l
IGtyc2lfZm9yX2VhY2hfaG9vayhob29rKSBcDQo+ICAgCWZvciAoKGhvb2spID0gJmtyc2lfaG9v
a3NfbGlzdFswXTsgXA0KPiAgIAkgICAgIChob29rKSA8ICZrcnNpX2hvb2tzX2xpc3RbX19NQVhf
S1JTSV9IT09LX1RZUEVdOyBcDQo+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9rcnNpL2tyc2kuYyBi
L3NlY3VyaXR5L2tyc2kva3JzaS5jDQo+IGluZGV4IDc3ZDdlMmY5MTE3Mi4uZDNhNGEzNjFjMTky
IDEwMDY0NA0KPiAtLS0gYS9zZWN1cml0eS9rcnNpL2tyc2kuYw0KPiArKysgYi9zZWN1cml0eS9r
cnNpL2tyc2kuYw0KPiBAQCAtMSw2ICsxLDkgQEANCj4gICAvLyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMA0KPiAgIA0KPiAgICNpbmNsdWRlIDxsaW51eC9sc21faG9va3MuaD4NCj4g
KyNpbmNsdWRlIDxsaW51eC9maWx0ZXIuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9icGYuaD4NCj4g
KyNpbmNsdWRlIDxsaW51eC9iaW5mbXRzLmg+DQo+ICAgDQo+ICAgI2luY2x1ZGUgImtyc2lfaW5p
dC5oIg0KPiAgIA0KPiBAQCAtMTYsNyArMTksMTUgQEAgc3RydWN0IGtyc2lfaG9vayBrcnNpX2hv
b2tzX2xpc3RbXSA9IHsNCj4gICANCj4gICBzdGF0aWMgaW50IGtyc2lfcHJvY2Vzc19leGVjdXRp
b24oc3RydWN0IGxpbnV4X2JpbnBybSAqYnBybSkNCj4gICB7DQo+IC0JcmV0dXJuIDA7DQo+ICsJ
aW50IHJldDsNCj4gKwlzdHJ1Y3Qga3JzaV9jdHggY3R4Ow0KPiArDQo+ICsJY3R4LmJwcm1fY3R4
ID0gKHN0cnVjdCBrcnNpX2Jwcm1fY3R4KSB7DQo+ICsJCS5icHJtID0gYnBybSwNCj4gKwl9Ow0K
PiArDQo+ICsJcmV0ID0ga3JzaV9ydW5fcHJvZ3MoUFJPQ0VTU19FWEVDVVRJT04sICZjdHgpOw0K
PiArCXJldHVybiByZXQ7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBzdHJ1Y3Qgc2VjdXJpdHlf
aG9va19saXN0IGtyc2lfaG9va3NbXSBfX2xzbV9yb19hZnRlcl9pbml0ID0gew0KPiBkaWZmIC0t
Z2l0IGEvc2VjdXJpdHkva3JzaS9rcnNpX2ZzLmMgYi9zZWN1cml0eS9rcnNpL2tyc2lfZnMuYw0K
PiBpbmRleCA2MDRmODI2Y2VlNWMuLjNiYTE4YjUyY2U4NSAxMDA2NDQNCj4gLS0tIGEvc2VjdXJp
dHkva3JzaS9rcnNpX2ZzLmMNCj4gKysrIGIvc2VjdXJpdHkva3JzaS9rcnNpX2ZzLmMNCj4gQEAg
LTUsNiArNSw4IEBADQo+ICAgI2luY2x1ZGUgPGxpbnV4L2ZpbGUuaD4NCj4gICAjaW5jbHVkZSA8
bGludXgvZnMuaD4NCj4gICAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCj4gKyNpbmNsdWRlIDxs
aW51eC9maWx0ZXIuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9icGYuaD4NCj4gICAjaW5jbHVkZSA8
bGludXgvc2VjdXJpdHkuaD4NCj4gICANCj4gICAjaW5jbHVkZSAia3JzaV9mcy5oIg0KPiBAQCAt
MjcsMTIgKzI5LDI5IEBAIGJvb2wgaXNfa3JzaV9ob29rX2ZpbGUoc3RydWN0IGZpbGUgKmYpDQo+
ICAgDQo+ICAgc3RhdGljIHZvaWQgX19pbml0IGtyc2lfZnJlZV9ob29rKHN0cnVjdCBrcnNpX2hv
b2sgKmgpDQo+ICAgew0KPiArCXN0cnVjdCBicGZfcHJvZ19hcnJheV9pdGVtICppdGVtOw0KPiAr
CS8qDQo+ICsJICogVGhpcyBmdW5jdGlvbiBpcyBfX2luaXQgc28gd2UgYXJlIGd1YXJyYW50ZWVk
IHRoYXQgdGhlcmUgd2lsbCBiZQ0KPiArCSAqIG5vIGNvbmN1cnJlbnQgYWNjZXNzLg0KPiArCSAq
Lw0KPiArCXN0cnVjdCBicGZfcHJvZ19hcnJheSAqcHJvZ3MgPSByY3VfZGVyZWZlcmVuY2VfcmF3
KGgtPnByb2dzKTsNCj4gKw0KPiArCWlmIChwcm9ncykgew0KDQpicGZfcHJvZ19hcnJheSBpdHNl
bGYgc2hvdWxkIG5ldmVyIGJlIG51bGw/DQoNCj4gKwkJaXRlbSA9IHByb2dzLT5pdGVtczsNCj4g
KwkJd2hpbGUgKGl0ZW0tPnByb2cpIHsNCj4gKwkJCWJwZl9wcm9nX3B1dChpdGVtLT5wcm9nKTsN
Cj4gKwkJCWl0ZW0rKzsNCj4gKwkJfQ0KPiArCQlicGZfcHJvZ19hcnJheV9mcmVlKHByb2dzKTsN
Cj4gKwl9DQo+ICsNCj4gICAJc2VjdXJpdHlmc19yZW1vdmUoaC0+aF9kZW50cnkpOw0KPiAgIAlo
LT5oX2RlbnRyeSA9IE5VTEw7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBpbnQgX19pbml0IGty
c2lfaW5pdF9ob29rKHN0cnVjdCBrcnNpX2hvb2sgKmgsIHN0cnVjdCBkZW50cnkgKnBhcmVudCkN
Cj4gICB7DQo+ICsJc3RydWN0IGJwZl9wcm9nX2FycmF5IF9fcmN1ICAgICAqcHJvZ3M7DQo+ICAg
CXN0cnVjdCBkZW50cnkgKmhfZGVudHJ5Ow0KPiAgIAlpbnQgcmV0Ow0KPiAgIA0KPiBAQCAtNDEs
NiArNjAsMTUgQEAgc3RhdGljIGludCBfX2luaXQga3JzaV9pbml0X2hvb2soc3RydWN0IGtyc2lf
aG9vayAqaCwgc3RydWN0IGRlbnRyeSAqcGFyZW50KQ0KPiAgIA0KPiAgIAlpZiAoSVNfRVJSKGhf
ZGVudHJ5KSkNCj4gICAJCXJldHVybiBQVFJfRVJSKGhfZGVudHJ5KTsNCj4gKw0KPiArCW11dGV4
X2luaXQoJmgtPm11dGV4KTsNCj4gKwlwcm9ncyA9IGJwZl9wcm9nX2FycmF5X2FsbG9jKDAsIEdG
UF9LRVJORUwpOw0KPiArCWlmICghcHJvZ3MpIHsNCj4gKwkJcmV0ID0gLUVOT01FTTsNCj4gKwkJ
Z290byBlcnJvcjsNCj4gKwl9DQo+ICsNCj4gKwlSQ1VfSU5JVF9QT0lOVEVSKGgtPnByb2dzLCBw
cm9ncyk7DQo+ICAgCWhfZGVudHJ5LT5kX2ZzZGF0YSA9IGg7DQo+ICAgCWgtPmhfZGVudHJ5ID0g
aF9kZW50cnk7DQo+ICAgCXJldHVybiAwOw0KPiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkva3JzaS9v
cHMuYyBiL3NlY3VyaXR5L2tyc2kvb3BzLmMNCj4gaW5kZXggZjJkZTNiZDk2MjFlLi5jZjRkMDYx
ODlhYTEgMTAwNjQ0DQo+IC0tLSBhL3NlY3VyaXR5L2tyc2kvb3BzLmMNCj4gKysrIGIvc2VjdXJp
dHkva3JzaS9vcHMuYw0KPiBAQCAtMSwxMCArMSwxMTIgQEANCj4gICAvLyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMA0KPiAgIA0KPiArI2luY2x1ZGUgPGxpbnV4L2Vyci5oPg0KPiAr
I2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L2ZpbHRlci5oPg0K
PiAgICNpbmNsdWRlIDxsaW51eC9icGYuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9zZWN1cml0eS5o
Pg0KPiArI2luY2x1ZGUgPGxpbnV4L2tyc2kuaD4NCj4gKw0KPiArI2luY2x1ZGUgImtyc2lfaW5p
dC5oIg0KPiArI2luY2x1ZGUgImtyc2lfZnMuaCINCj4gKw0KPiArZXh0ZXJuIHN0cnVjdCBrcnNp
X2hvb2sga3JzaV9ob29rc19saXN0W107DQo+ICsNCj4gK3N0YXRpYyBzdHJ1Y3Qga3JzaV9ob29r
ICpnZXRfaG9va19mcm9tX2ZkKGludCBmZCkNCj4gK3sNCj4gKwlzdHJ1Y3QgZmQgZiA9IGZkZ2V0
KGZkKTsNCj4gKwlzdHJ1Y3Qga3JzaV9ob29rICpoOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlp
ZiAoIWYuZmlsZSkgew0KPiArCQlyZXQgPSAtRUJBREY7DQo+ICsJCWdvdG8gZXJyb3I7DQo+ICsJ
fQ0KPiArDQo+ICsJaWYgKCFpc19rcnNpX2hvb2tfZmlsZShmLmZpbGUpKSB7DQo+ICsJCXJldCA9
IC1FSU5WQUw7DQo+ICsJCWdvdG8gZXJyb3I7DQo+ICsJfQ0KPiArDQo+ICsJLyoNCj4gKwkgKiBU
aGUgc2VjdXJpdHlmcyBkZW50cnkgbmV2ZXIgZGlzYXBwZWFycywgc28gd2UgZG9uJ3QgbmVlZCB0
byB0YWtlIGENCj4gKwkgKiByZWZlcmVuY2UgdG8gaXQuDQo+ICsJICovDQo+ICsJaCA9IGZpbGVf
ZGVudHJ5KGYuZmlsZSktPmRfZnNkYXRhOw0KPiArCWlmIChXQVJOX09OKCFoKSkgew0KPiArCQly
ZXQgPSAtRUlOVkFMOw0KPiArCQlnb3RvIGVycm9yOw0KPiArCX0NCj4gKwlmZHB1dChmKTsNCj4g
KwlyZXR1cm4gaDsNCj4gKw0KPiArZXJyb3I6DQo+ICsJZmRwdXQoZik7DQo+ICsJcmV0dXJuIEVS
Ul9QVFIocmV0KTsNCj4gK30NCj4gKw0KPiAraW50IGtyc2lfcHJvZ19hdHRhY2goY29uc3QgdW5p
b24gYnBmX2F0dHIgKmF0dHIsIHN0cnVjdCBicGZfcHJvZyAqcHJvZykNCj4gK3sNCj4gKwlzdHJ1
Y3QgYnBmX3Byb2dfYXJyYXkgKm9sZF9hcnJheTsNCj4gKwlzdHJ1Y3QgYnBmX3Byb2dfYXJyYXkg
Km5ld19hcnJheTsNCj4gKwlzdHJ1Y3Qga3JzaV9ob29rICpoOw0KPiArCWludCByZXQgPSAwOw0K
PiArDQo+ICsJaCA9IGdldF9ob29rX2Zyb21fZmQoYXR0ci0+dGFyZ2V0X2ZkKTsNCj4gKwlpZiAo
SVNfRVJSKGgpKQ0KPiArCQlyZXR1cm4gUFRSX0VSUihoKTsNCj4gKw0KPiArCW11dGV4X2xvY2so
JmgtPm11dGV4KTsNCj4gKwlvbGRfYXJyYXkgPSByY3VfZGVyZWZlcmVuY2VfcHJvdGVjdGVkKGgt
PnByb2dzLA0KPiArCQkJCQkgICAgICBsb2NrZGVwX2lzX2hlbGQoJmgtPm11dGV4KSk7DQo+ICsN
Cj4gKwlyZXQgPSBicGZfcHJvZ19hcnJheV9jb3B5KG9sZF9hcnJheSwgTlVMTCwgcHJvZywgJm5l
d19hcnJheSk7DQo+ICsJaWYgKHJldCA8IDApIHsNCj4gKwkJcmV0ID0gLUVOT01FTTsNCj4gKwkJ
Z290byB1bmxvY2s7DQo+ICsJfQ0KPiArDQo+ICsJcmN1X2Fzc2lnbl9wb2ludGVyKGgtPnByb2dz
LCBuZXdfYXJyYXkpOw0KPiArCWJwZl9wcm9nX2FycmF5X2ZyZWUob2xkX2FycmF5KTsNCj4gKw0K
PiArdW5sb2NrOg0KPiArCW11dGV4X3VubG9jaygmaC0+bXV0ZXgpOw0KPiArCXJldHVybiByZXQ7
DQo+ICt9DQo+ICAgDQo+ICAgY29uc3Qgc3RydWN0IGJwZl9wcm9nX29wcyBrcnNpX3Byb2dfb3Bz
ID0gew0KPiAgIH07DQo+ICAgDQo+ICtzdGF0aWMgYm9vbCBrcnNpX3Byb2dfaXNfdmFsaWRfYWNj
ZXNzKGludCBvZmYsIGludCBzaXplLA0KPiArCQkJCSAgICAgIGVudW0gYnBmX2FjY2Vzc190eXBl
IHR5cGUsDQo+ICsJCQkJICAgICAgY29uc3Qgc3RydWN0IGJwZl9wcm9nICpwcm9nLA0KPiArCQkJ
CSAgICAgIHN0cnVjdCBicGZfaW5zbl9hY2Nlc3NfYXV4ICppbmZvKQ0KPiArew0KPiArCS8qDQo+
ICsJICogS1JTSSBpcyBjb25zZXJ2YXRpdmUgYWJvdXQgYW55IGRpcmVjdCBhY2Nlc3MgaW4gZUJQ
RiB0bw0KPiArCSAqIHByZXZlbnQgdGhlIHVzZXJzIGZyb20gZGVwZW5kaW5nIG9uIHRoZSBpbnRl
cm5hbHMgb2YgdGhlIGtlcm5lbCBhbmQNCj4gKwkgKiBhaW1zIGF0IHByb3ZpZGluZyBhIHJpY2gg
ZWNvLXN5c3RlbSBvZiBzYWZlIGVCUEYgaGVscGVycyBhcyBhbiBBUEkNCj4gKwkgKiBmb3IgYWNj
ZXNzaW5nIHJlbGV2YW50IGluZm9ybWF0aW9uIGZyb20gdGhlIGNvbnRleHQuDQo+ICsJICovDQo+
ICsJcmV0dXJuIGZhbHNlOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGJwZl9m
dW5jX3Byb3RvICprcnNpX3Byb2dfZnVuY19wcm90byhlbnVtIGJwZl9mdW5jX2lkDQo+ICsJCQkJ
CQkJIGZ1bmNfaWQsDQo+ICsJCQkJCQkJIGNvbnN0IHN0cnVjdCBicGZfcHJvZw0KPiArCQkJCQkJ
CSAqcHJvZykNCj4gK3sNCj4gKwlzd2l0Y2ggKGZ1bmNfaWQpIHsNCj4gKwljYXNlIEJQRl9GVU5D
X21hcF9sb29rdXBfZWxlbToNCj4gKwkJcmV0dXJuICZicGZfbWFwX2xvb2t1cF9lbGVtX3Byb3Rv
Ow0KPiArCWNhc2UgQlBGX0ZVTkNfZ2V0X2N1cnJlbnRfcGlkX3RnaWQ6DQo+ICsJCXJldHVybiAm
YnBmX2dldF9jdXJyZW50X3BpZF90Z2lkX3Byb3RvOw0KPiArCWRlZmF1bHQ6DQo+ICsJCXJldHVy
biBOVUxMOw0KPiArCX0NCj4gK30NCj4gKw0KPiAgIGNvbnN0IHN0cnVjdCBicGZfdmVyaWZpZXJf
b3BzIGtyc2lfdmVyaWZpZXJfb3BzID0gew0KPiArCS5nZXRfZnVuY19wcm90byA9IGtyc2lfcHJv
Z19mdW5jX3Byb3RvLA0KPiArCS5pc192YWxpZF9hY2Nlc3MgPSBrcnNpX3Byb2dfaXNfdmFsaWRf
YWNjZXNzLA0KPiAgIH07DQo+IA0K
