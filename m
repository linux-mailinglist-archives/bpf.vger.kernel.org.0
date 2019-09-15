Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B86B31D4
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2019 21:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfIOTqL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 15 Sep 2019 15:46:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18990 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725270AbfIOTqK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 15 Sep 2019 15:46:10 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8FJhfKE004692;
        Sun, 15 Sep 2019 12:45:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=1w4oTUYa2ruB8eUSvKvJ4M9wheNyksD4C1cv5QCGF9g=;
 b=nvkUmC1k3xID5o9gSIl9LK0O9k2bWrCR4TS8OQ3+5PHVMlxZM4GDow10Svlw2T+7DdlB
 WLA3zrOR9xmegQhElGr+zI0/fSgzqIIHBdLcUQ3UigLZkpudBNTh+/waHvfin3Fx8XL7
 6W7JdyiPLSOqYIdpWxA01fxQZ5annSQEmp8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2v1fwshm7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 15 Sep 2019 12:45:23 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Sun, 15 Sep 2019 12:45:22 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Sun, 15 Sep 2019 12:45:22 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Sun, 15 Sep 2019 12:45:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M83A/qsgOmCU2IJFmjCbKCQf/BnOG07yds7DyIwffnfQnzMy6LhhUBoos7mX0/Ao6MI91o6UJ7eKApJexppqNq/4vDriCCySU3Oppc121vjPmyMMIVK4PNtO5N38qfEFldZgsqDvujKQk/9Ur9AMm1AeYSHlMW4I24GobbxyIUr9/XYc1NbAnbEh9df3ioB1F7js7Hi/bxHOI9zDhEhqo9i+nEwMDyxW/nlkPQSr8X2MbEg5yJHpArqzFxdRpacL905H4733C28hdN5gJWiLEyBJCGHnYaI2j/1bUfA8gdK6/Cn0JIF70zbg93DC/LLL63e07WqHcdqzd6F5bwExxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w4oTUYa2ruB8eUSvKvJ4M9wheNyksD4C1cv5QCGF9g=;
 b=dvgvOogww/kfLuTAG4TYX9efKT9K6zsO05Som0MyafCmzC1C+UHc6MxeHW38VuS6ZxzpS5yHbZRJnw+/EyMuQzsbJM2IzuP/izIEKTbPvpmIk/d9m/RvMoSImBHQEsBezR00SKVnqb9bM6l+UNuq77veyTSgdYXN/yHBe3uzF/gBDvJkSSmxl+R0MMEP3CxKCnwU9KxuFfKpWWEC7aKbrjNAq7HI5BjGTRSaMKAEGQSPMPy3RYlTd/J3Fbzxtot01tORZZ6AxPhd5+l3G9daSsiuK3ZinfBJ4FHwLrBCSr8ffz7ygieZhwZi5m5Eal/xGtouzmwKuXlYx0/WlPlHVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w4oTUYa2ruB8eUSvKvJ4M9wheNyksD4C1cv5QCGF9g=;
 b=lEcl+A2s1zrcduveTyIRrMh44Fydu3jhiI8jIIHs8I47hoTjB93siVb8xpWe4amY3hAgm04mA14wOp/pYQh8qCJJM3f30CZTZuLSIIdBC2Sy+RtffueR6JpPLSFlNnq8YSALBmJAe/DEufC9X+xG6tyXdfsPC0/iwl7cgS5b+Bs=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYAPR15MB2390.namprd15.prod.outlook.com (52.135.199.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.26; Sun, 15 Sep 2019 19:45:20 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::95ab:61a0:29f4:e07e]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::95ab:61a0:29f4:e07e%6]) with mapi id 15.20.2263.021; Sun, 15 Sep 2019
 19:45:20 +0000
From:   Yonghong Song <yhs@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        "Brendan Gregg" <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        "Matthew Garrett" <mjg59@google.com>,
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
        Quentin Monnet <quentin.monnet@netronome.com>,
        "Andrey Ignatov" <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [RFC v1 14/14] krsi: Pin arg pages only when needed
Thread-Topic: [RFC v1 14/14] krsi: Pin arg pages only when needed
Thread-Index: AQHVZ87hbuOgQ0AyT0uRpdYgTl4mM6cr6s4AgAASlwCAAS8qAA==
Date:   Sun, 15 Sep 2019 19:45:19 +0000
Message-ID: <cde5ca45-7bff-7eb9-2a70-98603cc420d0@fb.com>
References: <20190910115527.5235-1-kpsingh@chromium.org>
 <20190910115527.5235-15-kpsingh@chromium.org>
 <d9b7b968-c3a7-48a4-2eb0-85d5ac9dd196@fb.com>
 <20190915014008.GA19558@chromium.org>
In-Reply-To: <20190915014008.GA19558@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0019.namprd10.prod.outlook.com (2603:10b6:301::29)
 To BYAPR15MB3384.namprd15.prod.outlook.com (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::fa7d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97618ee1-c29a-4820-933a-08d73a153d47
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB2390;
x-ms-traffictypediagnostic: BYAPR15MB2390:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB23909A3A5FA6A2A60C767584D38D0@BYAPR15MB2390.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01613DFDC8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(396003)(366004)(136003)(189003)(199004)(6512007)(7416002)(6916009)(2906002)(6116002)(6246003)(31686004)(53936002)(8676002)(81156014)(71190400001)(71200400001)(229853002)(316002)(81166006)(8936002)(54906003)(6506007)(386003)(52116002)(53546011)(102836004)(76176011)(476003)(2616005)(46003)(11346002)(446003)(4326008)(256004)(5024004)(186003)(14444005)(86362001)(486006)(31696002)(6486002)(25786009)(7736002)(14454004)(478600001)(305945005)(5660300002)(66476007)(66946007)(36756003)(66556008)(64756008)(66446008)(6436002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2390;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xCIrsrvuK2/3VBNBluWeYNy5LljADxFV+7kZfsN6EYFiNQhGbYQ44jx2uwnjbWPVbLRUB8Y1n76fQvPKDwJiUpoa+6r+r2KnEDtcGaGrT5gq1qyCaSQvxW3j2ndh8ZQwaXam8ADjdN7PiW2/ZTmqmadToOMtLLfSyBlmBaZF7fsYBTmMt9gNnjdmY3IyuqfgsACauHbK5+KFGAKJL2uL9b5vNy1e/7nQwihlO5Q0d3IFmZv+p3qs11lQswRPpCp8f2JTQfZsXC8a4wPTAHYBgXIg3E1FGLXBgB3OXGti6Aet5HwYdunWUMyq2gqJ6kVNz1F1H3/T41kxJtWqu7kF/rufAA6vZwObF3yzwf3yPxONS+bMoe9ozsqwoDFdjI6YK65HNwSv+BXzrvuPM04P7n0Uqjckhajns1UcCuerE5k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C62C87A37EA732429EBF699D456B1542@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 97618ee1-c29a-4820-933a-08d73a153d47
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2019 19:45:19.7487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qv9wtOarq+jxPGmGVzyonURIADY2twpB4u/pXAIlCyKLY+YyXphm5OX43icA9B4y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2390
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-15_10:2019-09-11,2019-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909150215
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDkvMTUvMTkgMjo0MCBBTSwgS1AgU2luZ2ggd3JvdGU6DQo+IE9uIDE1LVNlcCAwMDoz
MywgWW9uZ2hvbmcgU29uZyB3cm90ZToNCj4+DQo+Pg0KPj4gT24gOS8xMC8xOSAxMjo1NSBQTSwg
S1AgU2luZ2ggd3JvdGU6DQo+Pj4gRnJvbTogS1AgU2luZ2ggPGtwc2luZ2hAZ29vZ2xlLmNvbT4N
Cj4+Pg0KPj4+IEFkZHMgYSBjYWxsYmFjayB3aGljaCBpcyBjYWxsZWQgd2hlbiBhIG5ldyBwcm9n
cmFtIGlzIGF0dGFjaGVkDQo+Pj4gdG8gYSBob29rLiBUaGUgY2FsbGJhY2sgcmVnaXN0ZXJlZCBi
eSB0aGUgcHJvY2Vzc19leGVjdGlvbiBob29rDQo+Pj4gY2hlY2tzIGlmIGEgcHJvZ3JhbSB0aGF0
IGhhcyBjYWxscyB0byBhIGhlbHBlciB0aGF0IHJlcXVpcmVzIHBhZ2VzIHRvDQo+Pj4gYmUgcGlu
bmVkIChlZy4ga3JzaV9nZXRfZW52X3ZhcikuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBLUCBT
aW5naCA8a3BzaW5naEBnb29nbGUuY29tPg0KPj4+IC0tLQ0KPj4+ICAgIGluY2x1ZGUvbGludXgv
a3JzaS5oICAgICAgICAgICAgICB8ICAxICsNCj4+PiAgICBzZWN1cml0eS9rcnNpL2luY2x1ZGUv
aG9va3MuaCAgICAgfCAgNSArKy0NCj4+PiAgICBzZWN1cml0eS9rcnNpL2luY2x1ZGUva3JzaV9p
bml0LmggfCAgNyArKysrDQo+Pj4gICAgc2VjdXJpdHkva3JzaS9rcnNpLmMgICAgICAgICAgICAg
IHwgNjIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPj4+ICAgIHNlY3VyaXR5L2ty
c2kvb3BzLmMgICAgICAgICAgICAgICB8IDEwICsrKystDQo+Pj4gICAgNSBmaWxlcyBjaGFuZ2Vk
LCA3NyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgva3JzaS5oIGIvaW5jbHVkZS9saW51eC9rcnNpLmgNCj4+PiBpbmRleCBj
N2QxNzkwZDBjMWYuLmU0NDNkMDMwOTc2NCAxMDA2NDQNCj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4
L2tyc2kuaA0KPj4+ICsrKyBiL2luY2x1ZGUvbGludXgva3JzaS5oDQo+Pj4gQEAgLTcsNiArNyw3
IEBADQo+Pj4gICAgDQo+Pj4gICAgI2lmZGVmIENPTkZJR19TRUNVUklUWV9LUlNJDQo+Pj4gICAg
aW50IGtyc2lfcHJvZ19hdHRhY2goY29uc3QgdW5pb24gYnBmX2F0dHIgKmF0dHIsIHN0cnVjdCBi
cGZfcHJvZyAqcHJvZyk7DQo+Pj4gK2V4dGVybiBjb25zdCBzdHJ1Y3QgYnBmX2Z1bmNfcHJvdG8g
a3JzaV9nZXRfZW52X3Zhcl9wcm90bzsNCj4+PiAgICAjZWxzZQ0KPj4+ICAgIHN0YXRpYyBpbmxp
bmUgaW50IGtyc2lfcHJvZ19hdHRhY2goY29uc3QgdW5pb24gYnBmX2F0dHIgKmF0dHIsDQo+Pj4g
ICAgCQkJCSAgIHN0cnVjdCBicGZfcHJvZyAqcHJvZykNCj4+PiBkaWZmIC0tZ2l0IGEvc2VjdXJp
dHkva3JzaS9pbmNsdWRlL2hvb2tzLmggYi9zZWN1cml0eS9rcnNpL2luY2x1ZGUvaG9va3MuaA0K
Pj4+IGluZGV4IGUwNzBjNDUyYjVkZS4uMzgyOTMxMjVmZjk5IDEwMDY0NA0KPj4+IC0tLSBhL3Nl
Y3VyaXR5L2tyc2kvaW5jbHVkZS9ob29rcy5oDQo+Pj4gKysrIGIvc2VjdXJpdHkva3JzaS9pbmNs
dWRlL2hvb2tzLmgNCj4+PiBAQCAtOCw3ICs4LDcgQEANCj4+PiAgICAgKg0KPj4+ICAgICAqIEZv
cm1hdDoNCj4+PiAgICAgKg0KPj4+IC0gKiAgIEtSU0lfSE9PS19JTklUKFRZUEUsIE5BTUUsIExT
TV9IT09LLCBLUlNJX0hPT0tfRk4pDQo+Pj4gKyAqICAgS1JTSV9IT09LX0lOSVQoVFlQRSwgTkFN
RSwgTFNNX0hPT0ssIEtSU0lfSE9PS19GTiwgQ0FMTEJBQ0spDQo+Pj4gICAgICoNCj4+PiAgICAg
KiBLUlNJIGFkZHMgb25lIGxheWVyIG9mIGluZGlyZWN0aW9uIGJldHdlZW4gdGhlIG5hbWUgb2Yg
dGhlIGhvb2sgYW5kIHRoZSBuYW1lDQo+Pj4gICAgICogaXQgZXhwb3NlcyB0byB0aGUgdXNlcnNw
YWNlIGluIFNlY3VyaXR5IEZTIHRvIHByZXZlbnQgdGhlIHVzZXJzcGFjZSBmcm9tDQo+Pj4gQEAg
LTE4LDQgKzE4LDUgQEANCj4+PiAgICBLUlNJX0hPT0tfSU5JVChQUk9DRVNTX0VYRUNVVElPTiwN
Cj4+PiAgICAJICAgICAgIHByb2Nlc3NfZXhlY3V0aW9uLA0KPj4+ICAgIAkgICAgICAgYnBybV9j
aGVja19zZWN1cml0eSwNCj4+PiAtCSAgICAgICBrcnNpX3Byb2Nlc3NfZXhlY3V0aW9uKQ0KPj4+
ICsJICAgICAgIGtyc2lfcHJvY2Vzc19leGVjdXRpb24sDQo+Pj4gKwkgICAgICAga3JzaV9wcm9j
ZXNzX2V4ZWN1dGlvbl9jYikNCj4+PiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkva3JzaS9pbmNsdWRl
L2tyc2lfaW5pdC5oIGIvc2VjdXJpdHkva3JzaS9pbmNsdWRlL2tyc2lfaW5pdC5oDQo+Pj4gaW5k
ZXggNjE1Mjg0N2MzYjA4Li45OTgwMWQ1YjI3M2EgMTAwNjQ0DQo+Pj4gLS0tIGEvc2VjdXJpdHkv
a3JzaS9pbmNsdWRlL2tyc2lfaW5pdC5oDQo+Pj4gKysrIGIvc2VjdXJpdHkva3JzaS9pbmNsdWRl
L2tyc2lfaW5pdC5oDQo+Pj4gQEAgLTMxLDYgKzMxLDggQEAgc3RydWN0IGtyc2lfY3R4IHsNCj4+
PiAgICAJfTsNCj4+PiAgICB9Ow0KPj4+ICAgIA0KPj4+ICt0eXBlZGVmIGludCAoKmtyc2lfcHJv
Z19hdHRhY2hfdCkgKHN0cnVjdCBicGZfcHJvZ19hcnJheSAqKTsNCj4+PiArDQo+Pj4gICAgLyoN
Cj4+PiAgICAgKiBUaGUgTFNNIGNyZWF0ZXMgb25lIGZpbGUgcGVyIGhvb2suDQo+Pj4gICAgICoN
Cj4+PiBAQCAtNjEsNiArNjMsMTEgQEAgc3RydWN0IGtyc2lfaG9vayB7DQo+Pj4gICAgCSAqIFRo
ZSBlQlBGIHByb2dyYW1zIHRoYXQgYXJlIGF0dGFjaGVkIHRvIHRoaXMgaG9vay4NCj4+PiAgICAJ
ICovDQo+Pj4gICAgCXN0cnVjdCBicGZfcHJvZ19hcnJheSBfX3JjdQkqcHJvZ3M7DQo+Pj4gKwkv
Kg0KPj4+ICsJICogVGhlIGF0dGFjaCBjYWxsYmFjayBpcyBjYWxsZWQgYmVmb3JlIGEgbmV3IHBy
b2dyYW0gaXMgYXR0YWNoZWQNCj4+PiArCSAqIHRvIHRoZSBob29rIGFuZCBpcyBwYXNzZWQgdGhl
IHVwZGF0ZWQgYnBmX3Byb2dfYXJyYXkgYXMgYW4gYXJndW1lbnQuDQo+Pj4gKwkgKi8NCj4+PiAr
CWtyc2lfcHJvZ19hdHRhY2hfdCBhdHRhY2hfY2FsbGJhY2s7DQo+Pj4gICAgfTsNCj4+PiAgICAN
Cj4+PiAgICBleHRlcm4gc3RydWN0IGtyc2lfaG9vayBrcnNpX2hvb2tzX2xpc3RbXTsNCj4+PiBk
aWZmIC0tZ2l0IGEvc2VjdXJpdHkva3JzaS9rcnNpLmMgYi9zZWN1cml0eS9rcnNpL2tyc2kuYw0K
Pj4+IGluZGV4IDAwYTcxNTBjMWIyMi4uYTQ0NDNkN2FhMTUwIDEwMDY0NA0KPj4+IC0tLSBhL3Nl
Y3VyaXR5L2tyc2kva3JzaS5jDQo+Pj4gKysrIGIvc2VjdXJpdHkva3JzaS9rcnNpLmMNCj4+PiBA
QCAtNSwxNSArNSw2NSBAQA0KPj4+ICAgICNpbmNsdWRlIDxsaW51eC9icGYuaD4NCj4+PiAgICAj
aW5jbHVkZSA8bGludXgvYmluZm10cy5oPg0KPj4+ICAgICNpbmNsdWRlIDxsaW51eC9oaWdobWVt
Lmg+DQo+Pj4gKyNpbmNsdWRlIDxsaW51eC9rcnNpLmg+DQo+Pj4gICAgI2luY2x1ZGUgPGxpbnV4
L21tLmg+DQo+Pj4gICAgDQo+Pj4gICAgI2luY2x1ZGUgImtyc2lfaW5pdC5oIg0KPj4+ICAgIA0K
Pj4+ICsvKg0KPj4+ICsgKiBuZWVkX2FyZ19wYWdlcyBpcyBvbmx5IHVwZGF0ZWQgaW4gYnBybV9j
aGVja19zZWN1cml0eV9jYg0KPj4+ICsgKiB3aGVuIGEgbXV0ZXggb24ga3JzaV9ob29rIGZvciBi
cHJtX2NoZWNrX3NlY3VyaXR5IGlzIGFscmVhZHkNCj4+PiArICogaGVsZC4gbmVlZF9hcmdfcGFn
ZXMgYXZvaWRzIHBpbm5pbmcgcGFnZXMgd2hlbiBubyBwcm9ncmFtDQo+Pj4gKyAqIHRoYXQgbmVl
ZHMgdGhlbSBpcyBhdHRhY2hlZCB0byB0aGUgaG9vay4NCj4+PiArICovDQo+Pj4gK3N0YXRpYyBi
b29sIG5lZWRfYXJnX3BhZ2VzOw0KPj4+ICsNCj4+PiArLyoNCj4+PiArICogQ2hlY2tzIGlmIHRo
ZSBpbnN0cnVjdGlvbiBpcyBhIEJQRl9DQUxMIHRvIGFuIGVCUEYgaGVscGVyIGxvY2F0ZWQNCj4+
PiArICogYXQgdGhlIGdpdmVuIGFkZHJlc3MuDQo+Pj4gKyAqLw0KPj4+ICtzdGF0aWMgaW5saW5l
IGJvb2wgYnBmX2lzX2NhbGxfdG9fZnVuYyhzdHJ1Y3QgYnBmX2luc24gKmluc24sDQo+Pj4gKwkJ
CQkgICAgICAgdm9pZCAqZnVuY19hZGRyKQ0KPj4+ICt7DQo+Pj4gKwl1OCBvcGNvZGUgPSBCUEZf
T1AoaW5zbi0+Y29kZSk7DQo+Pj4gKw0KPj4+ICsJaWYgKG9wY29kZSAhPSBCUEZfQ0FMTCkNCj4+
PiArCQlyZXR1cm4gZmFsc2U7DQo+Pj4gKw0KPj4+ICsJaWYgKGluc24tPnNyY19yZWcgPT0gQlBG
X1BTRVVET19DQUxMKQ0KPj4+ICsJCXJldHVybiBmYWxzZTsNCj4+PiArDQo+Pj4gKwkvKg0KPj4+
ICsJICogVGhlIEJQRiB2ZXJpZmllciB1cGRhdGVzIHRoZSB2YWx1ZSBvZiBpbnNuLT5pbW0gZnJv
bSB0aGUNCj4+PiArCSAqIGVudW0gYnBmX2Z1bmNfaWQgdG8gdGhlIG9mZnNldCBvZiB0aGUgYWRk
cmVzcyBvZiBoZWxwZXINCj4+PiArCSAqIGZyb20gdGhlIF9fYnBmX2NhbGxfYmFzZS4NCj4+PiAr
CSAqLw0KPj4+ICsJcmV0dXJuIF9fYnBmX2NhbGxfYmFzZSArIGluc24tPmltbSA9PSBmdW5jX2Fk
ZHI7DQo+Pg0KPj4gSW4gaG93IG1hbnkgY2FzZXMsIGtyc2kgcHJvZ3JhbSBkb2VzIG5vdCBoYXZl
IGtyc2lfZ2V0X2Vudl92YXIoKSBoZWxwZXI/DQo+IA0KPiBJdCBkZXBlbmRzLCBpZiB0aGUgdXNl
ciBkb2VzIG5vdCBjaG9vc2UgdG8gdXNlIGxvZyBlbnZpcm9ubWVudA0KPiB2YXJpYWJsZXMgb3Ig
dXNlIHRoZSB0aGUgdmFsdWUgYXMgYSBwYXJ0IG9mIHRoZWlyIE1BQyBwb2xpY3ksIHRoZQ0KPiBw
aW5uaW5nIG9mIHRoZSBwYWdlcyBpcyBub3QgbmVlZGVkLg0KDQpUaGFua3MuIEkganVzdCB3YW50
IHRvIGtub3cgd2hldGhlciB3ZSB3YW50IHRvIG9wdGltaXplIHN1Y2ggY2FzZXMuDQpJIGFtIG5v
dCBhIHNlY3VyaXR5IGV4cGVydCwgc28gSSBhbSBva2F5IHdpdGggd2hhdGV2ZXIgZGVjaXNpb24g
eW91DQptYWRlLg0KDQo+IA0KPiBBbHNvLCB0aGUgcGlubmluZyBpcyBuZWVkZWQgc2luY2UgZUJQ
RiBoZWxwZXJzIGNhbm5vdCBydW4gYSBub24tYXRvbWljDQo+IGNvbnRleHQuIEl0IHdvdWxkIG5v
dCBiZSBuZWVkZWQgaWYgInNsZWVwYWJsZSBlQlBGIiBiZWNvbWVzIGEgdGhpbmcuDQoNCkluZGVl
ZC4gJ3NsZWVwYWJsZSBCUEYnIG1pZ2h0IGJlIGFsc28gYSBnb29kIHRoaW5nIGZvciByZWFsdGlt
ZSBsaW51eC4NClNvbWUgd29ya3MgbmVlZCB0byBhZGRyZXNzIGJwZiBhcmVhIHNwaW4gbG9jaywg
cGVyIGNwdSB2YXJpYWJsZXMsIGV0Yy4NCmJlZm9yZSB0aGF0IGNhbiBoYXBwZW4uDQoNCj4gDQo+
IC0gS1ANCj4gDQo+Pg0KPj4+ICt9DQo+Pj4gKw0KPj4+ICtzdGF0aWMgaW50IGtyc2lfcHJvY2Vz
c19leGVjdXRpb25fY2Ioc3RydWN0IGJwZl9wcm9nX2FycmF5ICphcnJheSkNCj4+PiArew0KPj4+
ICsJc3RydWN0IGJwZl9wcm9nX2FycmF5X2l0ZW0gKml0ZW0gPSBhcnJheS0+aXRlbXM7DQo+Pj4g
KwlzdHJ1Y3QgYnBmX3Byb2cgKnA7DQo+Pj4gKwljb25zdCBzdHJ1Y3QgYnBmX2Z1bmNfcHJvdG8g
KnByb3RvID0gJmtyc2lfZ2V0X2Vudl92YXJfcHJvdG87DQo+Pj4gKwlpbnQgaTsNCj4+PiArDQo+
Pj4gKwl3aGlsZSAoKHAgPSBSRUFEX09OQ0UoaXRlbS0+cHJvZykpKSB7DQo+Pj4gKwkJZm9yIChp
ID0gMDsgaSA8IHAtPmxlbjsgaSsrKSB7DQo+Pj4gKwkJCWlmIChicGZfaXNfY2FsbF90b19mdW5j
KCZwLT5pbnNuc2lbaV0sIHByb3RvLT5mdW5jKSkNCj4+PiArCQkJCW5lZWRfYXJnX3BhZ2VzID0g
dHJ1ZTsNCj4+PiArCQl9DQo+Pj4gKwkJaXRlbSsrOw0KPj4+ICsJfQ0KPj4+ICsJcmV0dXJuIDA7
DQo+Pj4gK30NCj4+PiArDQo+Pj4gICAgc3RydWN0IGtyc2lfaG9vayBrcnNpX2hvb2tzX2xpc3Rb
XSA9IHsNCj4+PiAtCSNkZWZpbmUgS1JTSV9IT09LX0lOSVQoVFlQRSwgTkFNRSwgSCwgSSkgXA0K
Pj4+ICsJI2RlZmluZSBLUlNJX0hPT0tfSU5JVChUWVBFLCBOQU1FLCBILCBJLCBDQikgXA0KPj4+
ICAgIAkJW1RZUEVdID0geyBcDQo+Pj4gICAgCQkJLmhfdHlwZSA9IFRZUEUsIFwNCj4+PiAgICAJ
CQkubmFtZSA9ICNOQU1FLCBcDQo+Pj4gKwkJCS5hdHRhY2hfY2FsbGJhY2sgPSBDQiwgXA0KPj4+
ICAgIAkJfSwNCj4+PiAgICAJI2luY2x1ZGUgImhvb2tzLmgiDQo+Pj4gICAgCSN1bmRlZiBLUlNJ
X0hPT0tfSU5JVA0KPj4+IEBAIC03NSw5ICsxMjUsMTEgQEAgc3RhdGljIGludCBrcnNpX3Byb2Nl
c3NfZXhlY3V0aW9uKHN0cnVjdCBsaW51eF9iaW5wcm0gKmJwcm0pDQo+Pj4gICAgCQkuYnBybSA9
IGJwcm0sDQo+Pj4gICAgCX07DQo+Pj4gICAgDQo+Pj4gLQlyZXQgPSBwaW5fYXJnX3BhZ2VzKCZj
dHguYnBybV9jdHgpOw0KPj4+IC0JaWYgKHJldCA8IDApDQo+Pj4gLQkJZ290byBvdXRfYXJnX3Bh
Z2VzOw0KPj4+ICsJaWYgKFJFQURfT05DRShuZWVkX2FyZ19wYWdlcykpIHsNCj4+PiArCQlyZXQg
PSBwaW5fYXJnX3BhZ2VzKCZjdHguYnBybV9jdHgpOw0KPj4+ICsJCWlmIChyZXQgPCAwKQ0KPj4+
ICsJCQlnb3RvIG91dF9hcmdfcGFnZXM7DQo+Pj4gKwl9DQo+Pj4gICAgDQo+Pj4gICAgCXJldCA9
IGtyc2lfcnVuX3Byb2dzKFBST0NFU1NfRVhFQ1VUSU9OLCAmY3R4KTsNCj4+PiAgICAJa2ZyZWUo
Y3R4LmJwcm1fY3R4LmFyZ19wYWdlcyk7DQo+Pj4gQEAgLTg3LDcgKzEzOSw3IEBAIHN0YXRpYyBp
bnQga3JzaV9wcm9jZXNzX2V4ZWN1dGlvbihzdHJ1Y3QgbGludXhfYmlucHJtICpicHJtKQ0KPj4+
ICAgIH0NCj4+PiAgICANCj4+PiAgICBzdGF0aWMgc3RydWN0IHNlY3VyaXR5X2hvb2tfbGlzdCBr
cnNpX2hvb2tzW10gX19sc21fcm9fYWZ0ZXJfaW5pdCA9IHsNCj4+PiAtCSNkZWZpbmUgS1JTSV9I
T09LX0lOSVQoVCwgTiwgSE9PSywgSU1QTCkgTFNNX0hPT0tfSU5JVChIT09LLCBJTVBMKSwNCj4+
PiArCSNkZWZpbmUgS1JTSV9IT09LX0lOSVQoVCwgTiwgSE9PSywgSU1QTCwgQ0IpIExTTV9IT09L
X0lOSVQoSE9PSywgSU1QTCksDQo+Pj4gICAgCSNpbmNsdWRlICJob29rcy5oIg0KPj4+ICAgIAkj
dW5kZWYgS1JTSV9IT09LX0lOSVQNCj4+PiAgICB9Ow0KPj4+IGRpZmYgLS1naXQgYS9zZWN1cml0
eS9rcnNpL29wcy5jIGIvc2VjdXJpdHkva3JzaS9vcHMuYw0KPj4+IGluZGV4IDFkYjk0ZGZhYWMx
NS4uMmRlNjgyMzcxZWZmIDEwMDY0NA0KPj4+IC0tLSBhL3NlY3VyaXR5L2tyc2kvb3BzLmMNCj4+
PiArKysgYi9zZWN1cml0eS9rcnNpL29wcy5jDQo+Pj4gQEAgLTEzOSw2ICsxMzksMTQgQEAgaW50
IGtyc2lfcHJvZ19hdHRhY2goY29uc3QgdW5pb24gYnBmX2F0dHIgKmF0dHIsIHN0cnVjdCBicGZf
cHJvZyAqcHJvZykNCj4+PiAgICAJCWdvdG8gdW5sb2NrOw0KPj4+ICAgIAl9DQo+Pj4gICAgDQo+
Pj4gKwlpZiAoaC0+YXR0YWNoX2NhbGxiYWNrKSB7DQo+Pj4gKwkJcmV0ID0gaC0+YXR0YWNoX2Nh
bGxiYWNrKG5ld19hcnJheSk7DQo+Pj4gKwkJaWYgKHJldCA8IDApIHsNCj4+PiArCQkJYnBmX3By
b2dfYXJyYXlfZnJlZShuZXdfYXJyYXkpOw0KPj4+ICsJCQlnb3RvIHVubG9jazsNCj4+PiArCQl9
DQo+Pj4gKwl9DQo+Pj4gKw0KPj4+ICAgIAlyY3VfYXNzaWduX3BvaW50ZXIoaC0+cHJvZ3MsIG5l
d19hcnJheSk7DQo+Pj4gICAgCWJwZl9wcm9nX2FycmF5X2ZyZWUob2xkX2FycmF5KTsNCj4+PiAg
ICANCj4+PiBAQCAtMjc4LDcgKzI4Niw3IEBAIEJQRl9DQUxMXzUoa3JzaV9nZXRfZW52X3Zhciwg
c3RydWN0IGtyc2lfY3R4ICosIGN0eCwgY2hhciAqLCBuYW1lLCB1MzIsIG5fc2l6ZSwNCj4+PiAg
ICAJcmV0dXJuIGdldF9lbnZfdmFyKGN0eCwgbmFtZSwgZGVzdCwgbl9zaXplLCBzaXplKTsNCj4+
PiAgICB9DQo+Pj4gICAgDQo+Pj4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgYnBmX2Z1bmNfcHJvdG8g
a3JzaV9nZXRfZW52X3Zhcl9wcm90byA9IHsNCj4+PiArY29uc3Qgc3RydWN0IGJwZl9mdW5jX3By
b3RvIGtyc2lfZ2V0X2Vudl92YXJfcHJvdG8gPSB7DQo+Pj4gICAgCS5mdW5jID0ga3JzaV9nZXRf
ZW52X3ZhciwNCj4+PiAgICAJLmdwbF9vbmx5ID0gdHJ1ZSwNCj4+PiAgICAJLnJldF90eXBlID0g
UkVUX0lOVEVHRVIsDQo+Pj4NCg==
