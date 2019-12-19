Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA760125BD1
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 08:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfLSHEv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 02:04:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3430 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbfLSHEv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Dec 2019 02:04:51 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJ74cbA001353;
        Wed, 18 Dec 2019 23:04:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Cn8H2kluI53ItkhBH9D8dNC4Hk4N7tnS5IfdOZEJOk0=;
 b=DCiEdnatlmhex+250i+9UbY8QVvvqOHcir26avqY13AIobnXr894Cb4VbHqrYz5tRV0c
 ZqDhFgBEgNlWsVZRfD/VsnTf/EqMIKQGcA5Uc2wcCJD0N77jhZxqI6RsKhfifz2zTYBM
 E287eAhzhI2orxKcHnsJaya4dYUMCAnxrX8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wy97upxsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 18 Dec 2019 23:04:37 -0800
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 23:03:59 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Dec 2019 23:03:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2l6qG/7vdPze8chfcLm/Plo6Cmy8JrcKBPvHmPmA3xeoYnhVL0zrC+Aos22l1p2qkxJjekj1yJWoTK6DXSXik+8sAIn+6INwXakwghCk/5c1tNkGUjayw//KedR5aUEKkaBH9iOfUNdiSeK13KoFPAC2LKHpoGoQgI6D7c1GlRbMYiEaxAZjUbMQ8hKA0uqoQ69sny4BDYRf07C+OWjuUW5R4lbbPzXcggXrZJUlNlFwOciqgGiST+QU0NhY+iKDOZudbvKVWWyAB+Ut2mGmWsIzQSVSRvVckNfOZXYNgiiuCde8xJ/nF51UOQi3heke8+0pjuMEmyC99hTYU79Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cn8H2kluI53ItkhBH9D8dNC4Hk4N7tnS5IfdOZEJOk0=;
 b=TyIaPDYmxDnEdX/B/i8a/llLsi4PVn56SZuDZbwmfl2iu4PfqzG9KokX1WKlo/HwV++oWDdRiTvcG9CX18z8LeZyHSp1iRj07sjpiaqudk17FLXwky/dMoa/6nQNI5GRUzVDS46HtUp2F2oUWHedElHPXxBR2KaHilmOR28uwbX/uLz9GuFQJdpnoQwetlED8jjD443+K2+T/o73FUzDoA9ta5Hzcsl/Dr55dgWhtIMJ1zWXpzTmi45wug582QRW69wOEhZ78fFM8ySoe4clDdAYI0HRW3U9CuijZACfqxDBYzumrwVda5wg03VQMYM3rj8/RFx4xOPprctsC4psVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cn8H2kluI53ItkhBH9D8dNC4Hk4N7tnS5IfdOZEJOk0=;
 b=VjkXnErnbeZn4a+d9UV29k5vvOwsRi4ftVzBt74zlvqtHqC1pKhQcsG2APMtWmLPMUubSBJwoSawRwC3C0rqA5+1ydZf+5lRwks71Jc1D6Fed61vYQfkOqkfkogxBXOOPjkIrzHDqOmrNEkSeck12y9K9vyKFRKA5RN0ik1b8L8=
Received: from MWHPR15MB1294.namprd15.prod.outlook.com (10.175.3.150) by
 MWHPR15MB1183.namprd15.prod.outlook.com (10.175.2.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Thu, 19 Dec 2019 07:03:58 +0000
Received: from MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::5160:b3c0:bed1:e26c]) by MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::5160:b3c0:bed1:e26c%10]) with mapi id 15.20.2559.012; Thu, 19 Dec
 2019 07:03:57 +0000
Received: from localhost (2620:10d:c090:180::99d4) by MWHPR22CA0006.namprd22.prod.outlook.com (2603:10b6:300:ef::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.15 via Frontend Transport; Thu, 19 Dec 2019 07:03:57 +0000
From:   Andrey Ignatov <rdna@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 4/6] libbpf: Introduce bpf_prog_attach_xattr
Thread-Topic: [PATCH v3 bpf-next 4/6] libbpf: Introduce bpf_prog_attach_xattr
Thread-Index: AQHVthK+lyWDSHAf30a/jmidaijeNKfA9CGAgAAUrAA=
Date:   Thu, 19 Dec 2019 07:03:57 +0000
Message-ID: <20191219070354.GA16266@rdna-mbp.dhcp.thefacebook.com>
References: <cover.1576720240.git.rdna@fb.com>
 <a47ee7676254d3e94d3ff61afe20477eb8ace561.1576720240.git.rdna@fb.com>
 <CAEf4BzZEmnmQm=JEVyq4G=DfAvZY3M9NK+gwkGgQmgTrhizNvw@mail.gmail.com>
In-Reply-To: <CAEf4BzZEmnmQm=JEVyq4G=DfAvZY3M9NK+gwkGgQmgTrhizNvw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0006.namprd22.prod.outlook.com
 (2603:10b6:300:ef::16) To MWHPR15MB1294.namprd15.prod.outlook.com
 (2603:10b6:320:25::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::99d4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e32d7f2-efc0-4b10-30fa-08d784519de5
x-ms-traffictypediagnostic: MWHPR15MB1183:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB11838891FE93D9759C8881F5A8520@MWHPR15MB1183.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(6916009)(86362001)(4326008)(4001150100001)(6496006)(5660300002)(2906002)(53546011)(54906003)(52116002)(16526019)(186003)(66476007)(66946007)(33656002)(316002)(66446008)(64756008)(66556008)(9686003)(6486002)(81156014)(8676002)(8936002)(1076003)(71200400001)(81166006)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1183;H:MWHPR15MB1294.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eOzDYkTu6yHIyTiRhFPw3S65maax6HwQARqvREj6pM4V7tNkcXYdP0zDGVLY4TIKPJaWhHUHGaH6DAu+3YRFewWNq23cYRX8MaU5qeScpbwEUaFnuiPM2b6Z5vttRGL8ZcSh5rd7l6P+y72ksHwplOIlUxrJ/0pbXwWNNgFJo4AXb8BvSGW7uJn7/+cRe4kxg6lqApyC9SduYnwy1VlgnZkQTEz7sM1mbN9U1vk2j5h8RmSQz5/fDaoSoBeIU6E6/YgMK4bWCh3OKSwGGDtH9s7V+OLZJu+6tXScpRL/gFX2QOkgEL/1gAZAsxZABVwyodZ2Ng1RQ9r4t0pdwFEfmJl4yYy9JKRW2GHmk5nLZboRYT+F3XdoYNiKPncDTg75tYSWvjcf+lgxwxL64IvhYYu686+KcSACbCT8icjWMpZU5whvv+VQ4V/ZHGcNub/A
Content-Type: text/plain; charset="utf-8"
Content-ID: <40973DD12C12884FA337980E990E2E8C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e32d7f2-efc0-4b10-30fa-08d784519de5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 07:03:57.7053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6mn3q/VW3RtpwFkvPoFEPNlfnGFLWxQH2IdGW31pvCIAr26tOOUoLKOqpwWpexPr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1183
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_08:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=899 lowpriorityscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912190059
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

QW5kcmlpIE5ha3J5aWtvIDxhbmRyaWkubmFrcnlpa29AZ21haWwuY29tPiBbV2VkLCAyMDE5LTEy
LTE4IDIxOjUwIC0wODAwXToNCj4gT24gV2VkLCBEZWMgMTgsIDIwMTkgYXQgNjo1NiBQTSBBbmRy
ZXkgSWduYXRvdiA8cmRuYUBmYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSW50cm9kdWNlIGEgbmV3
IGJwZl9wcm9nX2F0dGFjaF94YXR0ciBmdW5jdGlvbiB0aGF0LCBpbiBhZGRpdGlvbiB0bw0KPiA+
IHByb2dyYW0gZmQsIHRhcmdldCBmZCBhbmQgYXR0YWNoIHR5cGUsIGFjY2VwdHMgYW4gZXh0ZW5k
YWJsZSBzdHJ1Y3QNCj4gPiBicGZfcHJvZ19hdHRhY2hfb3B0cy4NCj4gPg0KPiA+IGJwZl9wcm9n
X2F0dGFjaF9vcHRzIHJlbGllcyBvbiBERUNMQVJFX0xJQkJQRl9PUFRTIG1hY3JvIHRvIG1haW50
YWluDQo+ID4gYmFja3dhcmQgYW5kIGZvcndhcmQgY29tcGF0aWJpbGl0eSBhbmQgaGFzIHRoZSBm
b2xsb3dpbmcgIm9wdGlvbmFsIg0KPiA+IGF0dGFjaCBhdHRyaWJ1dGVzOg0KPiA+DQo+ID4gKiBl
eGlzdGluZyBhdHRhY2hfZmxhZ3MsIHNpbmNlIGl0J3Mgbm90IHJlcXVpcmVkIHdoZW4gYXR0YWNo
aW5nIGluIE5PTkUNCj4gPiAgIG1vZGUuIEV2ZW4gdGhvdWdoIGl0J3MgcXVpdGUgb2Z0ZW4gdXNl
ZCBpbiBNVUxUSSBhbmQgT1ZFUlJJREUgbW9kZSBpdA0KPiA+ICAgc2VlbXMgdG8gYmUgYSBnb29k
IGlkZWEgdG8gcmVkdWNlIG51bWJlciBvZiBhcmd1bWVudHMgdG8NCj4gPiAgIGJwZl9wcm9nX2F0
dGFjaF94YXR0cjsNCj4gPg0KPiA+ICogbmV3bHkgaW50cm9kdWNlZCBhdHRyaWJ1dGUgb2YgQlBG
X1BST0dfQVRUQUNIIGNvbW1hbmQ6IHJlcGxhY2VfcHJvZ19mZA0KPiA+ICAgdGhhdCBpcyBmZCBv
ZiBwcmV2aW91c2x5IGF0dGFjaGVkIGNncm91cC1icGYgcHJvZ3JhbSB0byByZXBsYWNlIGlmDQo+
ID4gICBCUEZfRl9SRVBMQUNFIGZsYWcgaXMgdXNlZC4NCj4gPg0KPiA+IFRoZSBuZXcgZnVuY3Rp
b24gaXMgbmFtZWQgdG8gYmUgY29uc2lzdGVudCB3aXRoIG90aGVyIHhhdHRyLWZ1bmN0aW9ucw0K
PiA+IChicGZfcHJvZ190ZXN0X3J1bl94YXR0ciwgYnBmX2NyZWF0ZV9tYXBfeGF0dHIsIGJwZl9s
b2FkX3Byb2dyYW1feGF0dHIpLg0KPiA+DQo+ID4gVGhlIHN0cnVjdCBicGZfcHJvZ19hdHRhY2hf
b3B0cyBpcyBzdXBwb3NlZCB0byBiZSB1c2VkIHdpdGgNCj4gPiBERUNMQVJFX0xJQkJQRl9PUFRT
IG1hY3JvLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IElnbmF0b3YgPHJkbmFAZmIu
Y29tPg0KPiA+IC0tLQ0KPiA+ICB0b29scy9saWIvYnBmL2JwZi5jICAgICAgfCAxNiArKysrKysr
KysrKysrKystDQo+ID4gIHRvb2xzL2xpYi9icGYvYnBmLmggICAgICB8IDExICsrKysrKysrKysr
DQo+ID4gIHRvb2xzL2xpYi9icGYvbGliYnBmLm1hcCB8ICAxICsNCj4gPiAgMyBmaWxlcyBjaGFu
Z2VkLCAyNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvdG9vbHMvbGliL2JwZi9icGYuYyBiL3Rvb2xzL2xpYi9icGYvYnBmLmMNCj4gPiBpbmRleCA5
ODU5NmUxNTM5MGYuLmViYjRmOGQ3MWJkYiAxMDA2NDQNCj4gPiAtLS0gYS90b29scy9saWIvYnBm
L2JwZi5jDQo+ID4gKysrIGIvdG9vbHMvbGliL2JwZi9icGYuYw0KPiA+IEBAIC00NjYsNiArNDY2
LDE3IEBAIGludCBicGZfb2JqX2dldChjb25zdCBjaGFyICpwYXRobmFtZSkNCj4gPg0KPiA+ICBp
bnQgYnBmX3Byb2dfYXR0YWNoKGludCBwcm9nX2ZkLCBpbnQgdGFyZ2V0X2ZkLCBlbnVtIGJwZl9h
dHRhY2hfdHlwZSB0eXBlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGZs
YWdzKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBERUNMQVJFX0xJQkJQRl9PUFRTKGJwZl9wcm9nX2F0
dGFjaF9vcHRzLCBvcHRzLA0KPiA+ICsgICAgICAgICAgICAgICAuZmxhZ3MgPSBmbGFncywNCj4g
PiArICAgICAgICk7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIGJwZl9wcm9nX2F0dGFjaF94
YXR0cihwcm9nX2ZkLCB0YXJnZXRfZmQsIHR5cGUsICZvcHRzKTsNCj4gPiArfQ0KPiA+ICsNCj4g
PiAraW50IGJwZl9wcm9nX2F0dGFjaF94YXR0cihpbnQgcHJvZ19mZCwgaW50IHRhcmdldF9mZCwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgIGVudW0gYnBmX2F0dGFjaF90eXBlIHR5cGUs
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgYnBmX3Byb2dfYXR0
YWNoX29wdHMgKm9wdHMpDQo+ID4gIHsNCj4gPiAgICAgICAgIHVuaW9uIGJwZl9hdHRyIGF0dHI7
DQo+ID4NCj4gDQo+IFlvdSBuZWVkIHRvIHZhbGlkYXRlIG9wdHMgd2l0aCBPUFRTX1ZBTElEIG1h
Y3JvIChzZWUNCj4gYnRmX2R1bXBfX2VtaXRfdHlwZV9kZWNsKCkgZm9yIHNpbXBsZSBleGFtcGxl
KS4NCj4gDQo+ID4gQEAgLTQ3Myw3ICs0ODQsMTAgQEAgaW50IGJwZl9wcm9nX2F0dGFjaChpbnQg
cHJvZ19mZCwgaW50IHRhcmdldF9mZCwgZW51bSBicGZfYXR0YWNoX3R5cGUgdHlwZSwNCj4gPiAg
ICAgICAgIGF0dHIudGFyZ2V0X2ZkICAgICA9IHRhcmdldF9mZDsNCj4gPiAgICAgICAgIGF0dHIu
YXR0YWNoX2JwZl9mZCA9IHByb2dfZmQ7DQo+ID4gICAgICAgICBhdHRyLmF0dGFjaF90eXBlICAg
PSB0eXBlOw0KPiA+IC0gICAgICAgYXR0ci5hdHRhY2hfZmxhZ3MgID0gZmxhZ3M7DQo+ID4gKyAg
ICAgICBpZiAob3B0cykgew0KPiA+ICsgICAgICAgICAgICAgICBhdHRyLmF0dGFjaF9mbGFncyA9
IG9wdHMtPmZsYWdzOw0KPiA+ICsgICAgICAgICAgICAgICBhdHRyLnJlcGxhY2VfYnBmX2ZkID0g
b3B0cy0+cmVwbGFjZV9wcm9nX2ZkOw0KPiA+ICsgICAgICAgfQ0KPiANCj4gUGxlYXNlIHVzZSBP
UFRTX0dFVCgpIG1hY3JvIHRvIGZldGNoIHZhbHVlcyBmcm9tIG9wdHMgc3RydWN0IGFuZA0KPiBw
cm92aWRlIGRlZmF1bHQgdmFsdWUgaWYgdGhleSBhcmUgbm90IHNwZWNpZmllZC4NCg0KT0ssIHdp
bGwgZG8gYm90aCBPUFRTX1ZBTElEIGFuZCBPUFRTX0dFVCBpbiB2NC4NCg0KPiANCj4gDQo+ID4N
Cj4gPiAgICAgICAgIHJldHVybiBzeXNfYnBmKEJQRl9QUk9HX0FUVEFDSCwgJmF0dHIsIHNpemVv
ZihhdHRyKSk7DQo+ID4gIH0NCj4gDQo+IFsuLi5dDQoNCi0tIA0KQW5kcmV5IElnbmF0b3YNCg==
