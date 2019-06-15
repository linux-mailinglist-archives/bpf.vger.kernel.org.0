Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 562A0471C0
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2019 21:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfFOTBG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Jun 2019 15:01:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43638 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbfFOTBG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 15 Jun 2019 15:01:06 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5FIvG3b029728;
        Sat, 15 Jun 2019 12:00:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=9VNf4wtqG3NujezacPxHpto04gvzzNUzgArFMCU+Ebg=;
 b=B0vEtjdPByS7TOvPw99UPM6RUX4mKQt1WuwjO8iccsoa1qg5IrJRLPfrvZJH5zQlaXDx
 i4J+k133iw/X7YexaPPk8TCXDcTKx8qyietg2ub9ZKuUXlS2ZGJLJDZbBKkxiH7cBGKA
 HAUX0hxhR01jmGFAJJ7zb5bkKdA4hzWKcF8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0b-00082601.pphosted.com with ESMTP id 2t4vg1s4jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 15 Jun 2019 12:00:36 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 15 Jun 2019 12:00:35 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 15 Jun 2019 12:00:35 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 15 Jun 2019 12:00:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VNf4wtqG3NujezacPxHpto04gvzzNUzgArFMCU+Ebg=;
 b=drmmdVkBH2hFhP5NXzSvXbeOWEULaRIBCUClw7Do2RYpvVevEttxCNkqFq0XTFNSpiNQz1qjUavF8Uf4+MvCHy/Uz41iXlFJtMiji6NftmQ9SUeU/IlYsbGDGrNGk4hQ1dqhERNpH4Y5dmwhAfLe4f6EcxG1F45/RwnUWkeRQxk=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB3015.namprd15.prod.outlook.com (20.178.238.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Sat, 15 Jun 2019 19:00:33 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::60a3:8bdd:1ea2:3702]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::60a3:8bdd:1ea2:3702%7]) with mapi id 15.20.1987.014; Sat, 15 Jun 2019
 19:00:33 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 9/9] bpf: precise scalar_value tracking
Thread-Topic: [PATCH v2 bpf-next 9/9] bpf: precise scalar_value tracking
Thread-Index: AQHVIoKfFavSgvQGakqlExPbT7iHSqabr+2AgAFkQQA=
Date:   Sat, 15 Jun 2019 19:00:33 +0000
Message-ID: <80ab1e2e-be4f-818b-d678-52defb8acf33@fb.com>
References: <20190614072557.196239-1-ast@kernel.org>
 <20190614072557.196239-10-ast@kernel.org>
 <CAEf4Bza-tWx4=sQzkXVFrKDKYrhmrHNfFtRDS3CfDMmPhbGJVg@mail.gmail.com>
In-Reply-To: <CAEf4Bza-tWx4=sQzkXVFrKDKYrhmrHNfFtRDS3CfDMmPhbGJVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR07CA0069.namprd07.prod.outlook.com (2603:10b6:100::37)
 To BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:ed9e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: faa6323b-5e20-4bf2-60d8-08d6f1c3be11
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB3015;
x-ms-traffictypediagnostic: BYAPR15MB3015:
x-microsoft-antispam-prvs: <BYAPR15MB30155858CD52203EE2E560EFD7E90@BYAPR15MB3015.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0069246B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(136003)(396003)(39850400004)(189003)(199004)(31686004)(53546011)(305945005)(64756008)(46003)(8676002)(81156014)(6116002)(8936002)(53936002)(102836004)(6512007)(386003)(7736002)(81166006)(68736007)(76176011)(99286004)(36756003)(14454004)(6506007)(25786009)(446003)(11346002)(229853002)(6486002)(478600001)(2616005)(4326008)(52116002)(486006)(6246003)(14444005)(6436002)(73956011)(186003)(66556008)(54906003)(256004)(31696002)(66946007)(86362001)(2906002)(5660300002)(30864003)(316002)(71190400001)(110136005)(66476007)(71200400001)(66446008)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3015;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cVSyFDQkZVLf5nEgoxisyjXyqMgzZJveRE+3xiCpF5k0VPN703PHC9gzqFVB4z1VoUO/7gJUBbh3QhXEtLZ9POBHiVMApApgHj9DTr803wtrCaxlvtoxRPubisQ3X8yKzQufbTIYeuqwpyF6fuiqpJWu2uiLN6nD4gsrnNyf6u/1G2YfmgyqAHNdMi6LAItfrrx/BugFsHOMw6IkgvZLZYrp3XFlA2CT13qDLSlm3Vv2/nV7T1MafvXTmtWWlLSMvjxdHO6MoP2YdG7ibw56vlMFmsqG1snpx6NfPE6BpCZmvdEXJY8fP9ev/7vyos8dr+Kd1k5GjtXOhOXQppQiyuIoYPN8OLaYM5j7ei3wPENLRb1t6eFuQpK5/NJnHkZPdXeEB2wYDIOYHtEJj4VecdjYmQM/tiTJDPy3rQ2KF4k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B479EEC4FD8BC4BB1454AD05AEC65BD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: faa6323b-5e20-4bf2-60d8-08d6f1c3be11
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2019 19:00:33.3318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ast@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3015
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-15_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906150179
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gNi8xNC8xOSAyOjQ1IFBNLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6DQo+IE9uIEZyaSwgSnVu
IDE0LCAyMDE5IGF0IDEyOjI2IEFNIEFsZXhlaSBTdGFyb3ZvaXRvdiA8YXN0QGtlcm5lbC5vcmc+
IHdyb3RlOg0KPj4NCj4+IEludHJvZHVjZSBwcmVjaXNpb24gdHJhY2tpbmcgbG9naWMgdGhhdA0K
Pj4gaGVscHMgY2lsaXVtIHByb2dyYW1zIHRoZSBtb3N0Og0KPj4gICAgICAgICAgICAgICAgICAg
IG9sZCBjbGFuZyAgb2xkIGNsYW5nICAgIG5ldyBjbGFuZyAgbmV3IGNsYW5nDQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB3aXRoIGFsbCBwYXRjaGVzICAgICAgICAgd2l0aCBhbGwgcGF0
Y2hlcw0KPj4gYnBmX2xiLURMQl9MMy5vICAgICAgMTgzOCAgICAgMjcyOCAgICAgICAgIDE5MjMg
ICAgICAyMjE2DQo+PiBicGZfbGItRExCX0w0Lm8gICAgICAzMjE4ICAgICAzNTYyICAgICAgICAg
MzA3NyAgICAgIDMzOTANCj4+IGJwZl9sYi1EVU5LTk9XTi5vICAgIDEwNjQgICAgIDU0NCAgICAg
ICAgICAxMDYyICAgICAgNTQzDQo+PiBicGZfbHhjLUREUk9QX0FMTC5vICAyNjkzNSAgICAxNTk4
OSAgICAgICAgMTY2NzI5ICAgIDE1MzcyDQo+PiBicGZfbHhjLURVTktOT1dOLm8gICAzNDQzOSAg
ICAyNjA0MyAgICAgICAgMTc0NjA3ICAgIDIyMTU2DQo+PiBicGZfbmV0ZGV2Lm8gICAgICAgICA5
NzIxICAgICA4MDYyICAgICAgICAgODQwNyAgICAgIDczMTINCj4+IGJwZl9vdmVybGF5Lm8gICAg
ICAgIDYxODQgICAgIDYxMzggICAgICAgICA1NDIwICAgICAgNTU1NQ0KPj4gYnBmX2x4Y19qaXQu
byAgICAgICAgMzkzODkgICAgMzk0NTIgICAgICAgIDM5Mzg5ICAgICAzOTQ1Mg0KPj4NCj4+IENv
bnNpZGVyIGNvZGU6DQo+PiA2NTQ6ICg4NSkgY2FsbCBicGZfZ2V0X2hhc2hfcmVjYWxjIzM0DQo+
PiA2NTU6IChiZikgcjcgPSByMA0KPj4gNjU2OiAoMTUpIGlmIHI4ID09IDB4MCBnb3RvIHBjKzI5
DQo+PiA2NTc6IChiZikgcjIgPSByMTANCj4+IDY1ODogKDA3KSByMiArPSAtNDgNCj4+IDY1OTog
KDE4KSByMSA9IDB4ZmZmZjg4ODFlNDFlMWIwMA0KPj4gNjYxOiAoODUpIGNhbGwgYnBmX21hcF9s
b29rdXBfZWxlbSMxDQo+PiA2NjI6ICgxNSkgaWYgcjAgPT0gMHgwIGdvdG8gcGMrMjMNCj4+IDY2
MzogKDY5KSByMSA9ICoodTE2ICopKHIwICswKQ0KPj4gNjY0OiAoMTUpIGlmIHIxID09IDB4MCBn
b3RvIHBjKzIxDQo+PiA2NjU6IChiZikgcjggPSByNw0KPj4gNjY2OiAoNTcpIHI4ICY9IDY1NTM1
DQo+PiA2Njc6IChiZikgcjIgPSByOA0KPj4gNjY4OiAoM2YpIHIyIC89IHIxDQo+PiA2Njk6ICgy
ZikgcjIgKj0gcjENCj4+IDY3MDogKGJmKSByMSA9IHI4DQo+PiA2NzE6ICgxZikgcjEgLT0gcjIN
Cj4+IDY3MjogKDU3KSByMSAmPSAyNTUNCj4+IDY3MzogKDI1KSBpZiByMSA+IDB4MWUgZ290byBw
YysxMg0KPj4gICBSMD1tYXBfdmFsdWUoaWQ9MCxvZmY9MCxrcz0yMCx2cz02NCxpbW09MCkgUjFf
dz1pbnYoaWQ9MCx1bWF4X3ZhbHVlPTMwLHZhcl9vZmY9KDB4MDsgMHgxZikpDQo+PiA2NzQ6ICg2
NykgcjEgPDw9IDENCj4+IDY3NTogKDBmKSByMCArPSByMQ0KPj4NCj4+IEF0IHRoaXMgcG9pbnQg
dGhlIHZlcmlmaWVyIHdpbGwgbm90aWNlIHRoYXQgc2NhbGFyIFIxIGlzIHVzZWQgaW4gbWFwIHBv
aW50ZXIgYWRqdXN0bWVudC4NCj4+IFIxIGhhcyB0byBiZSBwcmVjaXNlIGZvciBsYXRlciBvcGVy
YXRpb25zIG9uIFIwIHRvIGJlIHZhbGlkYXRlZCBwcm9wZXJseS4NCj4+DQo+PiBUaGUgdmVyaWZp
ZXIgd2lsbCBiYWNrdHJhY2sgdGhlIGFib3ZlIGNvZGUgaW4gdGhlIGZvbGxvd2luZyB3YXk6DQo+
PiBsYXN0X2lkeCA2NzUgZmlyc3RfaWR4IDY2NA0KPj4gcmVncz0yIHN0YWNrPTAgYmVmb3JlIDY3
NTogKDBmKSByMCArPSByMSAgICAgICAgIC8vIHN0YXJ0ZWQgYmFja3RyYWNraW5nIFIxIHJlZ3M9
MiBpcyBhIGJpdG1hc2sNCj4+IHJlZ3M9MiBzdGFjaz0wIGJlZm9yZSA2NzQ6ICg2NykgcjEgPDw9
IDENCj4+IHJlZ3M9MiBzdGFjaz0wIGJlZm9yZSA2NzM6ICgyNSkgaWYgcjEgPiAweDFlIGdvdG8g
cGMrMTINCj4+IHJlZ3M9MiBzdGFjaz0wIGJlZm9yZSA2NzI6ICg1NykgcjEgJj0gMjU1DQo+PiBy
ZWdzPTIgc3RhY2s9MCBiZWZvcmUgNjcxOiAoMWYpIHIxIC09IHIyICAgICAgICAgLy8gbm93IGJv
dGggUjEgYW5kIFIyIGhhcyB0byBiZSBwcmVjaXNlIC0+IHJlZ3M9NiBtYXNrDQo+PiByZWdzPTYg
c3RhY2s9MCBiZWZvcmUgNjcwOiAoYmYpIHIxID0gcjggICAgICAgICAgLy8gYWZ0ZXIgdGhpcyBp
bnNuIFI4IGFuZCBSMiBoYXMgdG8gYmUgcHJlY2lzZQ0KPj4gcmVncz0xMDQgc3RhY2s9MCBiZWZv
cmUgNjY5OiAoMmYpIHIyICo9IHIxICAgICAgIC8vIGFmdGVyIHRoaXMgb25lIFI4LCBSMiwgYW5k
IFIxDQo+PiByZWdzPTEwNiBzdGFjaz0wIGJlZm9yZSA2Njg6ICgzZikgcjIgLz0gcjENCj4+IHJl
Z3M9MTA2IHN0YWNrPTAgYmVmb3JlIDY2NzogKGJmKSByMiA9IHI4DQo+PiByZWdzPTEwMiBzdGFj
az0wIGJlZm9yZSA2NjY6ICg1NykgcjggJj0gNjU1MzUNCj4+IHJlZ3M9MTAyIHN0YWNrPTAgYmVm
b3JlIDY2NTogKGJmKSByOCA9IHI3DQo+PiByZWdzPTgyIHN0YWNrPTAgYmVmb3JlIDY2NDogKDE1
KSBpZiByMSA9PSAweDAgZ290byBwYysyMQ0KPj4gICAvLyB0aGlzIGlzIHRoZSBlbmQgb2YgdmVy
aWZpZXIgc3RhdGUuIFRoZSBmb2xsb3dpbmcgcmVncyB3aWxsIGJlIG1hcmtlZCBwcmVjaXNlZDoN
Cj4+ICAgUjFfcnc9aW52UChpZD0wLHVtYXhfdmFsdWU9NjU1MzUsdmFyX29mZj0oMHgwOyAweGZm
ZmYpKSBSN19ydz1pbnZQKGlkPTApDQo+PiBwYXJlbnQgZGlkbid0IGhhdmUgcmVncz04MiBzdGFj
az0wIG1hcmtzICAgICAgICAgLy8gc28gYmFja3RyYWNraW5nIGNvbnRpbnVlcyBpbnRvIHBhcmVu
dCBzdGF0ZQ0KPj4gbGFzdF9pZHggNjYzIGZpcnN0X2lkeCA2NTUNCj4+IHJlZ3M9ODIgc3RhY2s9
MCBiZWZvcmUgNjYzOiAoNjkpIHIxID0gKih1MTYgKikocjAgKzApICAgLy8gUjEgd2FzIGFzc2ln
bmVkIG5vIG5lZWQgdG8gdHJhY2sgaXQgZnVydGhlcg0KPj4gcmVncz04MCBzdGFjaz0wIGJlZm9y
ZSA2NjI6ICgxNSkgaWYgcjAgPT0gMHgwIGdvdG8gcGMrMjMgICAgLy8ga2VlcCB0cmFja2luZyBS
Nw0KPj4gcmVncz04MCBzdGFjaz0wIGJlZm9yZSA2NjE6ICg4NSkgY2FsbCBicGZfbWFwX2xvb2t1
cF9lbGVtIzEgIC8vIGtlZXAgdHJhY2tpbmcgUjcNCj4+IHJlZ3M9ODAgc3RhY2s9MCBiZWZvcmUg
NjU5OiAoMTgpIHIxID0gMHhmZmZmODg4MWU0MWUxYjAwDQo+PiByZWdzPTgwIHN0YWNrPTAgYmVm
b3JlIDY1ODogKDA3KSByMiArPSAtNDgNCj4+IHJlZ3M9ODAgc3RhY2s9MCBiZWZvcmUgNjU3OiAo
YmYpIHIyID0gcjEwDQo+PiByZWdzPTgwIHN0YWNrPTAgYmVmb3JlIDY1NjogKDE1KSBpZiByOCA9
PSAweDAgZ290byBwYysyOQ0KPj4gcmVncz04MCBzdGFjaz0wIGJlZm9yZSA2NTU6IChiZikgcjcg
PSByMCAgICAgICAgICAgICAgICAvLyBoZXJlIHRoZSBhc3NpZ25tZW50IGludG8gUjcNCj4+ICAg
Ly8gbWFyayBSMCB0byBiZSBwcmVjaXNlOg0KPj4gICBSMF9ydz1pbnZQKGlkPTApDQo+PiBwYXJl
bnQgZGlkbid0IGhhdmUgcmVncz0xIHN0YWNrPTAgbWFya3MgICAgICAgICAgICAgICAgIC8vIHJl
Z3M9MSAtPiB0cmFja2luZyBSMA0KPj4gbGFzdF9pZHggNjU0IGZpcnN0X2lkeCA2NDQNCj4+IHJl
Z3M9MSBzdGFjaz0wIGJlZm9yZSA2NTQ6ICg4NSkgY2FsbCBicGZfZ2V0X2hhc2hfcmVjYWxjIzM0
IC8vIGFuZCBpbiB0aGUgcGFyZW50IGZyYW1lIGl0IHdhcyBhIHJldHVybiB2YWx1ZQ0KPj4gICAg
Ly8gbm90aGluZyBmdXJ0aGVyIHRvIGJhY2t0cmFjaw0KPj4NCj4+IFR3byBzY2FsYXIgcmVnaXN0
ZXJzIG5vdCBtYXJrZWQgcHJlY2lzZSBhcmUgZXF1aXZhbGVudCBmcm9tIHN0YXRlIHBydW5pbmcg
cG9pbnQgb2Ygdmlldy4NCj4+IE1vcmUgZGV0YWlscyBpbiB0aGUgcGF0Y2ggY29tbWVudHMuDQo+
Pg0KPj4gSXQgZG9lc24ndCBzdXBwb3J0IGJwZjJicGYgY2FsbHMgeWV0IGFuZCBlbmFibGVkIGZv
ciByb290IG9ubHkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQWxleGVpIFN0YXJvdm9pdG92IDxh
c3RAa2VybmVsLm9yZz4NCj4+IC0tLQ0KPiANCj4gPHNuaXA+DQo+IA0KPj4gQEAgLTk1OCw2ICs5
ODMsMTcgQEAgc3RhdGljIHZvaWQgX19yZWdfYm91bmRfb2Zmc2V0KHN0cnVjdCBicGZfcmVnX3N0
YXRlICpyZWcpDQo+PiAgICAgICAgICByZWctPnZhcl9vZmYgPSB0bnVtX2ludGVyc2VjdChyZWct
PnZhcl9vZmYsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0bnVt
X3JhbmdlKHJlZy0+dW1pbl92YWx1ZSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmVnLT51bWF4X3ZhbHVlKSk7DQo+PiArICAgICAgIC8qIGlm
IHJlZ2lzdGVyIGJlY2FtZSBrbm93biBjb25zdGFudCBhZnRlciBhIHNlcXVlbmNlIG9mIGNvbXBh
cmlzb25zDQo+PiArICAgICAgICAqIG9yIGFyaXRobWV0aWMgb3BlcmF0aW9ucyBtYXJrIGl0IHBy
ZWNpc2Ugbm93LCBzaW5jZSBiYWNrdHJhY2tpbmcNCj4+ICsgICAgICAgICogY2Fubm90IGZvbGxv
dyBzdWNoIGxvZ2ljLg0KPj4gKyAgICAgICAgKiBFeGFtcGxlOg0KPj4gKyAgICAgICAgKiByMCA9
IGdldF9yYW5kb20oKTsNCj4+ICsgICAgICAgICogaWYgKHIwIDwgMSkgZ290byAuLg0KPj4gKyAg
ICAgICAgKiBpZiAocjAgPiAxKSBnb3RvIC4uDQo+PiArICAgICAgICAqIHIwIGlzIGNvbnN0IGhl
cmUNCj4+ICsgICAgICAgICovDQo+PiArICAgICAgIGlmICh0bnVtX2lzX2NvbnN0KHJlZy0+dmFy
X29mZikpDQo+PiArICAgICAgICAgICAgICAgcmVnLT5wcmVjaXNlID0gdHJ1ZTsNCj4gDQo+IEkn
bSBub3Qgc3VyZSB5b3UgaGF2ZSB0byBkbyB0aGlzOiByMCB2YWx1ZSBtaWdodCBuZXZlciBiZSB1
c2VkIGluIGENCj4gInByZWNpc2UiIGNvbnRleHQuIEJ1dCB3b3JzZSwgaWYgaXQgaXMgcmVxdWly
ZWQgdG8gYmUgcHJlY2lzZSwNCj4gYmFja3RyYWNraW5nIGxvZ2ljIHdpbGwgc3RvcCBoZXJlLCB3
aGlsZSBpdCBoYXMgdG8gY29udGludWUgdG8gdGhlDQo+IHByZXZpb3VzIGNvbmRpdGlvbmFsIGp1
bXBzIGFuZCBrZWVwIG1hcmtpbmcgcjAgYXMgcHJlY2lzZS4NCg0KRXhjZWxsZW50IGNhdGNoLg0K
VGhhdCB3YXMgYSBsZWZ0IG92ZXIgd2hlbiBiYWNrdHJhY2tpbmcgd2FzIG9ubHkgdHJhY2tpbmcg
Y29uc3RhbnRzLg0KQnV0IGl0IHdhc24ndCB0aGF0IGVmZmVjdGl2ZSB0byByZWR1Y2UgaW5zbl9w
cm9jZXNzZWQuDQpSZW1vdmVkIGl0Lg0KDQo+IA0KPj4gICB9DQo+Pg0KPj4gICAvKiBSZXNldCB0
aGUgbWluL21heCBib3VuZHMgb2YgYSByZWdpc3RlciAqLw0KPj4gQEAgLTk2Nyw2ICsxMDAzLDkg
QEAgc3RhdGljIHZvaWQgX19tYXJrX3JlZ191bmJvdW5kZWQoc3RydWN0IGJwZl9yZWdfc3RhdGUg
KnJlZykNCj4+ICAgICAgICAgIHJlZy0+c21heF92YWx1ZSA9IFM2NF9NQVg7DQo+PiAgICAgICAg
ICByZWctPnVtaW5fdmFsdWUgPSAwOw0KPj4gICAgICAgICAgcmVnLT51bWF4X3ZhbHVlID0gVTY0
X01BWDsNCj4+ICsNCj4+ICsgICAgICAgLyogY29uc3RhbnQgYmFja3RyYWNraW5nIGlzIGVuYWJs
ZWQgZm9yIHJvb3Qgb25seSBmb3Igbm93ICovDQo+PiArICAgICAgIHJlZy0+cHJlY2lzZSA9IGNh
cGFibGUoQ0FQX1NZU19BRE1JTikgPyBmYWxzZSA6IHRydWU7DQo+PiAgIH0NCj4+DQo+PiAgIC8q
IE1hcmsgYSByZWdpc3RlciBhcyBoYXZpbmcgYSBjb21wbGV0ZWx5IHVua25vd24gKHNjYWxhcikg
dmFsdWUuICovDQo+PiBAQCAtMTQ1Nyw2ICsxNDk2LDkgQEAgc3RhdGljIGludCBjaGVja19zdGFj
a193cml0ZShzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2VudiAqZW52LA0KPj4NCj4+ICAgICAgICAgIGlm
IChyZWcgJiYgc2l6ZSA9PSBCUEZfUkVHX1NJWkUgJiYgcmVnaXN0ZXJfaXNfY29uc3QocmVnKSAm
Jg0KPj4gICAgICAgICAgICAgICFyZWdpc3Rlcl9pc19udWxsKHJlZykgJiYgZW52LT5hbGxvd19w
dHJfbGVha3MpIHsNCj4+ICsgICAgICAgICAgICAgICBpZiAoZW52LT5wcm9nLT5pbnNuc2lbaW5z
bl9pZHhdLmRzdF9yZWcgIT0gQlBGX1JFR19GUCkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAg
IC8qIGJhY2t0cmFja2luZyBsb2dpYyBjYW4gb25seSByZWNvZ25pemUgZXhwbGljaXQgW2ZwLVhd
ICovDQo+PiArICAgICAgICAgICAgICAgICAgICAgICByZWctPnByZWNpc2UgPSB0cnVlOw0KPiAN
Cj4gVGhpcyBoYXMgc2ltaWxhciBwcm9ibGVtIGFzIGFib3ZlLiBFdmVyeSB0aW1lIHlvdSBwcm9h
Y3RpdmVseSBtYXJrDQo+IHNvbWUgcmVnaXN0ZXIvc3RhY2sgc2xvdCBhcyBwcmVjaXNlLCB5b3Ug
aGF2ZSB0byBkbyBiYWNrdHJhY2sgbG9naWMgdG8NCj4gbWFyayByZWxldmFudCByZWdpc3RlciBw
cmVjaXNlLg0KDQpBbm90aGVyIGdyZWF0IHBvaW50IQ0KSW5kZWVkLiBTd2l0Y2hlZCB0byBtYXJr
X2NoYWluX3ByZWNpc2lvbigpIGF0IHRoaXMgcG9pbnQgYW5kDQphZGRlZCBhIGNvbW1lbnQuDQoN
Cj4gDQo+PiAgICAgICAgICAgICAgICAgIHNhdmVfcmVnaXN0ZXJfc3RhdGUoc3RhdGUsIHNwaSwg
cmVnKTsNCj4+ICAgICAgICAgIH0gZWxzZSBpZiAocmVnICYmIGlzX3NwaWxsYWJsZV9yZWd0eXBl
KHJlZy0+dHlwZSkpIHsNCj4+ICAgICAgICAgICAgICAgICAgLyogcmVnaXN0ZXIgY29udGFpbmlu
ZyBwb2ludGVyIGlzIGJlaW5nIHNwaWxsZWQgaW50byBzdGFjayAqLw0KPj4gQEAgLTE2MTAsNiAr
MTY1MiwxMCBAQCBzdGF0aWMgaW50IGNoZWNrX3N0YWNrX3JlYWQoc3RydWN0IGJwZl92ZXJpZmll
cl9lbnYgKmVudiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIHNvIHRo
ZSB3aG9sZSByZWdpc3RlciA9PSBjb25zdF96ZXJvDQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKi8NCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fbWFy
a19yZWdfY29uc3RfemVybygmc3RhdGUtPnJlZ3NbdmFsdWVfcmVnbm9dKTsNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLyogYmFja3RyYWNraW5nIGRvZXNuJ3Qgc3VwcG9ydCBT
VEFDS19aRVJPIHlldCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogc28g
Y29uc2VydmF0aXZlbHkgbWFyayBpdCBwcmVjaXNlDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAqLw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0ZS0+
cmVnc1t2YWx1ZV9yZWdub10ucHJlY2lzZSA9IHRydWU7DQo+IA0KPiBUaGlzIGlzIHByb2JhYmx5
IG9rIHdpdGhvdXQgYmFja3RyYWNraW5nLCBiZWNhdXNlIG9mIFNUQUNLX1pFUk8gYmVpbmcNCj4g
aW1wbGljaXRseSBwcmVjaXNlLiBCdXQgZmxhZ2dpbmcganVzdCBpbiBjYXNlLg0KDQpBZnRlciBm
dXJ0aGVyIGFuYWx5c2lzLiBJdCdzIG9rIHRvIGRvIHByZWNpc2U9dHJ1ZSBoZXJlLA0KYnV0IGNv
cnJlc3BvbmRpbmcgc3BpbGwgYWxzbyBuZWVkcyB0byBoYXZlOg0KaWYgKHJlZyAmJiByZWdpc3Rl
cl9pc19udWxsKHJlZykpDQogICAgICAgLyogYmFja3RyYWNraW5nIGRvZXNuJ3Qgd29yayBmb3Ig
U1RBQ0tfWkVSTyB5ZXQuICovDQogICAgICAgZXJyID0gbWFya19jaGFpbl9wcmVjaXNpb24ocmVn
KTsNCg0KQWxzbyBhZGRlZCBhIGNvbW1lbnQuDQoNCj4gDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgfSBlbHNlIHsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qIGhh
dmUgcmVhZCBtaXNjIGRhdGEgZnJvbSB0aGUgc3RhY2sgKi8NCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIG1hcmtfcmVnX3Vua25vd24oZW52LCBzdGF0ZS0+cmVncywgdmFsdWVf
cmVnbm8pOw0KPj4gQEAgLTI3MzUsNiArMjc4MSwzNjkgQEAgc3RhdGljIGludCBpbnRfcHRyX3R5
cGVfdG9fc2l6ZShlbnVtIGJwZl9hcmdfdHlwZSB0eXBlKQ0KPj4gICAgICAgICAgcmV0dXJuIC1F
SU5WQUw7DQo+PiAgIH0NCj4+DQo+PiArLyogZm9yIGFueSBicmFuY2gsIGNhbGwsIGV4aXQgcmVj
b3JkIHRoZSBoaXN0b3J5IG9mIGptcHMgaW4gdGhlIGdpdmVuIHN0YXRlICovDQo+PiArc3RhdGlj
IGludCBwdXNoX2ptcF9oaXN0b3J5KHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICplbnYsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGJwZl92ZXJpZmllcl9zdGF0ZSAqY3Vy
KQ0KPj4gK3sNCj4+ICsgICAgICAgc3RydWN0IGJwZl9pZHhfcGFpciAqcDsNCj4+ICsgICAgICAg
dTMyIGNudCA9IGN1ci0+am1wX2hpc3RvcnlfY250Ow0KPiANCj4gUmV2ZXJzZSBDaHJpc3RtYXMg
dHJlZS4NCg0KbG9sLiAncGF0Y2ggZGVsYXknIG1lY2hhbmlzbSBpcyBub3cgdXNlZCBhZ2FpbnN0
IG1lIDopDQpmaXhlZC4NCg0KPj4gKw0KPj4gKyAgICAgICBjbnQrKzsNCj4+ICsgICAgICAgcCA9
IGtyZWFsbG9jKGN1ci0+am1wX2hpc3RvcnksIGNudCAqIHNpemVvZigqcCksIEdGUF9VU0VSKTsN
Cj4+ICsgICAgICAgaWYgKCFwKQ0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0K
Pj4gKyAgICAgICBwW2NudCAtIDFdLmlkeCA9IGVudi0+aW5zbl9pZHg7DQo+PiArICAgICAgIHBb
Y250IC0gMV0ucHJldl9pZHggPSBlbnYtPnByZXZfaW5zbl9pZHg7DQo+PiArICAgICAgIGN1ci0+
am1wX2hpc3RvcnkgPSBwOw0KPj4gKyAgICAgICBjdXItPmptcF9oaXN0b3J5X2NudCA9IGNudDsN
Cj4+ICsgICAgICAgcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gKy8qIEJhY2t0cmFjayBvbmUg
aW5zbiBhdCBhIHRpbWUuIElmIGlkeCBpcyBub3QgYXQgdGhlIHRvcCBvZiByZWNvcmRlZA0KPj4g
KyAqIGhpc3RvcnkgdGhlbiBwcmV2aW91cyBpbnN0cnVjdGlvbiBjYW1lIGZyb20gc3RyYWlnaHQg
bGluZSBleGVjdXRpb24uDQo+PiArICovDQo+PiArc3RhdGljIGludCBwb3BfYW5kX2dldF9wcmV2
X2lkeChzdHJ1Y3QgYnBmX3ZlcmlmaWVyX3N0YXRlICpzdCwgaW50IGkpDQo+IA0KPiBUaGlzIG9w
ZXJhdGlvbiBkZXN0cm95cyBqbXBfaGlzdG9yeSwgd2hpY2ggaXMgYSBwcm9ibGVtIGlmIHRoZXJl
IGlzDQo+IGFub3RoZXIgYnJhbmNoIHlldC10by1iZS1wcm9jZXNzZWQsIHdoaWNoIG1pZ2h0IG5l
ZWQgam1wIGhpc3RvcnkgYWdhaW4NCj4gdG8gbWFyayBzb21lIG90aGVyIHJlZ2lzdGVyIGFzIHBy
ZWNpc2UuDQoNCkFic29sdXRlbHkuIEZpeGVkLg0KDQo+PiArew0KPj4gKyAgICAgICB1MzIgY250
ID0gc3QtPmptcF9oaXN0b3J5X2NudDsNCj4+ICsNCj4+ICsgICAgICAgaWYgKGNudCAmJiBzdC0+
am1wX2hpc3RvcnlbY250IC0gMV0uaWR4ID09IGkpIHsNCj4+ICsgICAgICAgICAgICAgICBpID0g
c3QtPmptcF9oaXN0b3J5W2NudCAtIDFdLnByZXZfaWR4Ow0KPj4gKyAgICAgICAgICAgICAgIHN0
LT5qbXBfaGlzdG9yeV9jbnQtLTsNCj4+ICsgICAgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgICAg
ICAgICBpLS07DQo+PiArICAgICAgIH0NCj4+ICsgICAgICAgcmV0dXJuIGk7DQo+PiArfQ0KPj4g
Kw0KPiANCj4gPHNuaXA+DQo+IA0KPj4gKyAgICAgICB9IGVsc2UgaWYgKGNsYXNzID09IEJQRl9K
TVAgfHwgY2xhc3MgPT0gQlBGX0pNUDMyKSB7DQo+PiArICAgICAgICAgICAgICAgaWYgKG9wY29k
ZSA9PSBCUEZfQ0FMTCkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGluc24tPnNy
Y19yZWcgPT0gQlBGX1BTRVVET19DQUxMKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVOT1RTVVBQOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgZWxzZQ0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiByZWd1bGFyIGhlbHBlciBjYWxs
IHNldHMgUjAgKi8NCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKnJlZ19tYXNr
ICY9IH4xOw0KPiANCj4gUmVndWxhciBoZWxwZXIgYWxzbyBjbG9iYmVycyBSMS1SNSwgd2hpY2gg
ZnJvbSB0aGUgc3RhbmRwb2ludCBvZg0KPiB2ZXJpZmllciBzaG91bGQgYmUgdHJlYXRlZCBhcyBS
WzEtNV0gPSA8VU5LTk9XTj4sIHNvOg0KPiANCj4gKnJlZ19tYXNrICY9IH4weDNmDQoNCkl0IHdh
c24ndCBjbGVhcmluZyBiZWNhdXNlIGJhY2t0cmFja2luZyBzdGFydHMgZnJvbSBpbnNuIHRoYXQN
CnRyaWdnZXJlZCBiYWNrdHJhY2tpbmcuDQpBbmQgaW4gY2FzZSBvZiBjYWxsIHRvIGhlbHBlciBp
dCB3b3VsZCBjbGVhciB0aGUgcmVnIGltbWVkaWF0ZWx5IDopDQpTbyBJIGhhZCAtMSBoYWNrLCBi
dXQgdGhhdCB3YXNuJ3QgY29ycmVjdCBlaXRoZXIgZHVlIHRvIGptcF9oaXN0b3J5Lg0KU28gbm93
IEkndmUgYWRkZWQgYSBsb2dpYyB0byBza2lwIGZpcnN0IGluc24gdGhhdCB0cmlnZ2VyZWQgYmFj
a3RyYWNraW5nDQphbmQgYWRkZWQgYSB3YXJuaW5nDQppZiAoKnJlZ19tYXNrICYgMHgzZikNCi8q
IGlmIGJhY2t0cmFjaW5nIHdhcyBsb29raW5nIGZvciByZWdpc3RlcnMgUjEtUjUNCiAgKiB0aGV5
IHNob3VsZCBoYXZlIGJlZW4gZm91bmQgYWxyZWFkeS4NCiAgKi8NCndoaWNoIGlzIGEgZ29vZCBj
aGVjayBmb3Igc2FuaXR5IG9mIGJhY2t0cmFja2luZy4NCkkgd2FzIGhhcHB5IHRvIHNlZSB0aGF0
IGl0IGRpZG4ndCBmaXJlIGluIGFueSBvZiB0aGUgdGVzdHMgOikNCg0KPiANCj4+ICsgICAgICAg
ICAgICAgICB9IGVsc2UgaWYgKG9wY29kZSA9PSBCUEZfRVhJVCkgew0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIC1FTk9UU1VQUDsNCj4+ICsgICAgICAgICAgICAgICB9DQo+PiAr
ICAgICAgIH0gZWxzZSBpZiAoY2xhc3MgPT0gQlBGX0xEKSB7DQo+PiArICAgICAgICAgICAgICAg
aWYgKCEoKnJlZ19tYXNrICYgZHJlZykpDQo+PiArICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gMDsNCj4gDQo+IDxzbmlwPg0KPiANCj4+ICsgKg0KPj4gKyAqIE5vdGUgdGhlIHZlcmlmaWVy
IGNhbm5vdCBzaW1wbHkgd2FsayByZWdpc3RlciBwYXJlbnRhZ2UgY2hhaW4sDQo+PiArICogc2lu
Y2UgbWFueSBkaWZmZXJlbnQgcmVnaXN0ZXJzIGFuZCBzdGFjayBzbG90cyBjb3VsZCBoYXZlIGJl
ZW4NCj4+ICsgKiB1c2VkIHRvIGNvbXB1dGUgc2luZ2xlIHByZWNpc2Ugc2NhbGFyLg0KPj4gKyAq
DQo+PiArICogSXQncyBub3Qgc2FmZSB0byBzdGFydCB3aXRoIHByZWNpc2U9dHJ1ZSBhbmQgYmFj
a3RyYWNrDQo+PiArICogd2hlbiBwYXNzaW5nIHNjYWxhciByZWdpc3RlciBpbnRvIGEgaGVscGVy
IHRoYXQgdGFrZXMgQVJHX0FOWVRISU5HLg0KPiANCj4gSXQgdG9vayBtZSBtYW55IHJlYWRzIHRv
IHVuZGVyc3RhbmQgd2hhdCB0aGlzIG1lYW5zIChJIHRoaW5rKS4gSGVyZQ0KPiB5b3UgYXJlIHNh
eWluZyB0aGF0IGFwcHJvYWNoIG9mIHN0YXJ0aW5nIHdpdGggcHJlY2lzZT10cnVlIGZvcg0KPiBy
ZWdpc3RlciBhbmQgdGhlbiBiYWNrdHJhY2tpbmcgdG8gbWFyayBpdCBhcyBub3QgcHJlY2lzZSB3
aGVuIHdlDQo+IGRldGVjdCB0aGF0IHdlIGRvbid0IGNhcmUgYWJvdXQgc3BlY2lmaWMgdmFsdWUg
KGUuZy4sIHdoZW4gaGVscGVyDQo+IHRha2VzIHJlZ2lzdGVyIGFzIEFSR19BTllUSElORyBwYXJh
bWV0ZXIpIGlzIG5vdCBzYWZlLiBJcyB0aGF0IGNvcnJlY3QNCj4gaW50ZXJwcmV0YXRpb24/IElm
IHllcywgc2xpZ2h0bHkgbGVzcyBicmllZiBjb21tZW50IG1pZ2h0IGJlDQo+IGFwcHJvcHJpYXRl
IDspDQoNCmdvb2QgcG9pbnQuIHJld29yZGVkLg0KDQo+IA0KPj4gKyAqDQo+PiArICogSXQncyBv
ayB0byB3YWxrIHNpbmdsZSBwYXJlbnRhZ2UgY2hhaW4gb2YgdGhlIHZlcmlmaWVyIHN0YXRlcy4N
Cj4+ICsgKiBJdCdzIHBvc3NpYmxlIHRoYXQgdGhpcyBiYWNrdHJhY2tpbmcgd2lsbCBnbyBhbGwg
dGhlIHdheSB0aWxsIDFzdCBpbnNuLg0KPj4gKyAqIEFsbCBvdGhlciBicmFuY2hlcyB3aWxsIGJl
IGV4cGxvcmVkIGZvciBuZWVkaW5nIHByZWNpc2lvbiBsYXRlci4NCj4+ICsgKg0KPj4gKyAqIFRo
ZSBiYWNrdHJhY2tpbmcgbmVlZHMgdG8gZGVhbCB3aXRoIGNhc2VzIGxpa2U6DQo+PiArICogICBS
OD1tYXBfdmFsdWUoaWQ9MCxvZmY9MCxrcz00LHZzPTE5NTIsaW1tPTApIFI5X3c9bWFwX3ZhbHVl
KGlkPTAsb2ZmPTQwLGtzPTQsdnM9MTk1MixpbW09MCkNCj4+ICsgKiByOSAtPSByOA0KPj4gKyAq
IHI1ID0gcjkNCj4+ICsgKiBpZiByNSA+IDB4NzlmIGdvdG8gcGMrNw0KPj4gKyAqICAgIFI1X3c9
aW52KGlkPTAsdW1heF92YWx1ZT0xOTUxLHZhcl9vZmY9KDB4MDsgMHg3ZmYpKQ0KPj4gKyAqIHI1
ICs9IDENCj4+ICsgKiAuLi4NCj4+ICsgKiBjYWxsIGJwZl9wZXJmX2V2ZW50X291dHB1dCMyNQ0K
Pj4gKyAqICAgd2hlcmUgLmFyZzVfdHlwZSA9IEFSR19DT05TVF9TSVpFX09SX1pFUk8NCj4+ICsg
Kg0KPj4gKyAqIGFuZCB0aGlzIGNhc2U6DQo+PiArICogcjYgPSAxDQo+PiArICogY2FsbCBmb28g
Ly8gdXNlcyBjYWxsZWUncyByNiBpbnNpZGUgdG8gY29tcHV0ZSByMA0KPj4gKyAqIHIwICs9IHI2
DQo+PiArICogaWYgcjAgPT0gMCBnb3RvDQo+PiArICoNCj4+ICsgKiB0byB0cmFjayBhYm92ZSBy
ZWdfbWFzay9zdGFja19tYXNrIG5lZWRzIHRvIGJlIGluZGVwZW5kZW50IGZvciBlYWNoIGZyYW1l
Lg0KPj4gKyAqDQo+PiArICogQWxzbG8gaWYgcGFyZW50J3MgY3VyZnJhbWUgPiBmcmFtZSB3aGVy
ZSBiYWNrdHJhY2tpbmcgc3RhcnRlZCwNCj4gDQo+IHR5cG86IEFsc2xvIC0+IEFsc28NCg0KZml4
ZWQNCg0KPiA8c25pcD4NCj4gDQo+PiArDQo+PiArc3RhdGljIGludCBtYXJrX2NoYWluX3ByZWNp
c2lvbihzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2VudiAqZW52LCBpbnQgcmVnbm8pDQo+PiArew0KPj4g
KyAgICAgICBzdHJ1Y3QgYnBmX3ZlcmlmaWVyX3N0YXRlICpzdCA9IGVudi0+Y3VyX3N0YXRlLCAq
cGFyZW50ID0gc3QtPnBhcmVudDsNCj4+ICsgICAgICAgaW50IGxhc3RfaWR4ID0gZW52LT5pbnNu
X2lkeDsNCj4+ICsgICAgICAgaW50IGZpcnN0X2lkeCA9IHN0LT5maXJzdF9pbnNuX2lkeDsNCj4+
ICsgICAgICAgc3RydWN0IGJwZl9mdW5jX3N0YXRlICpmdW5jOw0KPj4gKyAgICAgICBzdHJ1Y3Qg
YnBmX3JlZ19zdGF0ZSAqcmVnOw0KPj4gKyAgICAgICB1MzIgcmVnX21hc2sgPSAxdSA8PCByZWdu
bzsNCj4+ICsgICAgICAgdTY0IHN0YWNrX21hc2sgPSAwOw0KPj4gKyAgICAgICBpbnQgaSwgZXJy
Ow0KPiANCj4gcmV2ZXJzZSBDaHJpc3RtYXMgdHJlZSA6KQ0KDQpub3QgdGhpcyBvbmUuDQppdCdz
IGJldHRlciB0byBncm91cCB2YXJpYWJsZXMgbG9naWNhbGx5Lg0KbGFzdCtmaXJzdCwgZnVuYyty
ZWcsIHJlZytzdGFjay4NCg0KPiANCj4+ICsNCj4+ICsgICAgICAgZnVuYyA9IHN0LT5mcmFtZVtz
dC0+Y3VyZnJhbWVdOw0KPj4gKyAgICAgICByZWcgPSAmZnVuYy0+cmVnc1tyZWdub107DQo+PiAr
ICAgICAgIGlmIChyZWctPnR5cGUgIT0gU0NBTEFSX1ZBTFVFKSB7DQo+IA0KPiA8c25pcD4NCj4g
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICB9DQo+PiArICAgICAgICAgICAgICAgfQ0KPj4g
KyAgICAgICAgICAgICAgIHN0ID0gcGFyZW50Ow0KPiANCj4gbm90IHN1cmUgd2h5IHlvdSBuZWVk
IHBhcmVudCB2YXJpYWJsZSwganVzdCBzdCA9IHN0LT5wYXJlbnQNCg0KZml4ZWQNCg0KPj4gKyAg
ICAgICAgICAgICAgIGlmICghc3QpDQo+PiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsN
Cj4+ICsNCj4gDQo+IDxzbmlwPg0KPiANCj4+DQo+PiBAQCAtNDEyMCw2ICs0NTMxLDkgQEAgc3Rh
dGljIGludCBhZGp1c3Rfc2NhbGFyX21pbl9tYXhfdmFscyhzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2Vu
diAqZW52LA0KPj4gICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+ICAgICAgICAgIH0NCj4+
DQo+PiArICAgICAgIGlmIChzcmNfcmVnLnByZWNpc2UpDQo+PiArICAgICAgICAgICAgICAgZHN0
X3JlZy0+cHJlY2lzZSA9IHRydWU7DQo+IA0KPiBUaGlzIGRvZXNuJ3Qgc2VlbSBuZWNlc3Nhcnkg
YW5kIGNvcnJlY3QuIElmIGRzdF9yZWcgaXMgbmV2ZXIgdXNlZCBpbiBhDQo+IHByZWNpc2UgY29u
dGV4dCwgdGhlbiBpdCBkb2Vzbid0IGhhdmUgdG8gYmUgcHJlY2lzZS4NCg0KY29ycmVjdC4gdGhp
cyB0eXBlIG9mIHByb3BhZ2F0aW9uIGlzIG5vdCBzYWZlLiByZW1vdmVkIGl0Lg0KDQpUaGFua3Mg
YSB0b24gZm9yIGRldGFpbGVkIGNvZGUgcmV2aWV3LiB2MyBpcyBjb21pbmcuDQo=
