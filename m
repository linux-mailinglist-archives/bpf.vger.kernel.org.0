Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A470DE7D60
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 01:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfJ2AAP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Oct 2019 20:00:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42264 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725951AbfJ2AAO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 28 Oct 2019 20:00:14 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9SNxuiZ025160;
        Mon, 28 Oct 2019 16:59:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=xzKMtZYBt5QTurAYnX+aEW3TWwsQcCpXd+CauCaoQ7I=;
 b=rXYemhuSIfWLgAL6rBgK+tKPb6csnMHEfs2aGZ6RFovvNEwICt221R3AcVIG56SZ4vrs
 zvdAWV3pz61VvC9l/E4dgl2Zpcaid4NNFBE0/0+qKWVTzzfsipRuC7ZOh42OW0VjZQuk
 qFo73PxCJBAk/1rcpjRc52bSW/GxfB35IMQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vw5teg840-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Oct 2019 16:59:57 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Oct 2019 16:59:55 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 28 Oct 2019 16:59:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiTkD5k9u5Y2oosxAZLBhaGZ+QyrJbcYwV7bmTTPp3niLYNZt/BdefMmmBn7q7ywrWRAXTu1Ez7oN5Py7Hxjp4NenkM9q7o+xxhvVb2w1q06yt4vgiIAGs1+YegedaNDcJgiWhhO8HdCp33+eirW3VCdDmxQnStvcG2HgaqOTR1u7/U7/sw/xlbEIGJnysEwVL26zp09sX+cHyyGFc2hosKJ0x5KncOldNKGAHn1Q7Ghd3siEuJO9UYgfcBR+sawYc05Ymn37Y7MiWzfgM8Vb5Zz68WgYkapqtpueDPTW98OdgYQujqcKSUl85G+leBakoXU17yPsHMYhwp4W8J/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzKMtZYBt5QTurAYnX+aEW3TWwsQcCpXd+CauCaoQ7I=;
 b=dYlHdn1jWUd5ntag6GHT+uQA0CPA+nhh1tjaOOqZn7PhYbmKrb2JTtR4/brlh5lk1TRvxrirZiEUxC1rrgKWCTtkUdfFP5Ex+8xNxqt6mn1hBU3NF8ucQMk7fzx65woIcxPl4IEKheM5rOGZfBZnLeg9BG5wo0YNIrhsUJtz2DUn3sqsr+0uku+WjeQRUf6nlHpB1SzUOBFt0SFm8Ahfz6tZN8FnlJuJhbv2cd4MNgg+vyWL6ANjvsgMBl2zUmII5JL+jicmoZBKYhKGbDdS7rv93MJRTlB2uwohSj/2ovud6NzFdTgcZpfqspI+sIS2ii6IBQEXsrUpG/6fKCUXnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzKMtZYBt5QTurAYnX+aEW3TWwsQcCpXd+CauCaoQ7I=;
 b=BsrwqAAuR/IK94Rw6HZKySnZ618o2nGQDleY4XnwVx5bapTg04m5JIGKzAW2usbJdk0j5r9j3xpBu8sRMA0jZeYDX2YHCzR/jruivRYLmKv8sDx20TevO0yUQkooExBti8nolgLgN04TzpSZnW2Y3QFvCz/g3wD/xARi3G+Rxa0=
Received: from CY4PR15MB1366.namprd15.prod.outlook.com (10.172.157.148) by
 CY4PR15MB1382.namprd15.prod.outlook.com (10.172.157.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Mon, 28 Oct 2019 23:59:54 +0000
Received: from CY4PR15MB1366.namprd15.prod.outlook.com
 ([fe80::b911:f278:a42a:8936]) by CY4PR15MB1366.namprd15.prod.outlook.com
 ([fe80::b911:f278:a42a:8936%10]) with mapi id 15.20.2387.023; Mon, 28 Oct
 2019 23:59:54 +0000
From:   Andrey Ignatov <rdna@fb.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf] bpf: allow narrow loads of bpf_sysctl fields with
 offset > 0
Thread-Topic: [PATCH bpf] bpf: allow narrow loads of bpf_sysctl fields with
 offset > 0
Thread-Index: AQHVjYtVYSZ15vhmGUeukQkXXEg0BqdwvHuA
Date:   Mon, 28 Oct 2019 23:59:53 +0000
Message-ID: <20191028235951.GA22475@rdna-mbp.dhcp.thefacebook.com>
References: <20191028122902.9763-1-iii@linux.ibm.com>
In-Reply-To: <20191028122902.9763-1-iii@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0063.namprd21.prod.outlook.com
 (2603:10b6:300:db::25) To CY4PR15MB1366.namprd15.prod.outlook.com
 (2603:10b6:903:f7::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:909]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5800551-c764-4cd4-a753-08d75c02ed37
x-ms-traffictypediagnostic: CY4PR15MB1382:
x-microsoft-antispam-prvs: <CY4PR15MB1382FD29978F166C9D60A59AA8660@CY4PR15MB1382.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(136003)(396003)(346002)(199004)(189003)(6486002)(229853002)(4326008)(486006)(46003)(476003)(71200400001)(71190400001)(11346002)(14454004)(8936002)(6116002)(446003)(2906002)(52116002)(386003)(6506007)(99286004)(76176011)(102836004)(186003)(6246003)(54906003)(9686003)(1076003)(6512007)(6436002)(5660300002)(316002)(305945005)(7736002)(33656002)(64756008)(6916009)(66556008)(66476007)(66446008)(8676002)(66946007)(4001150100001)(81166006)(81156014)(256004)(86362001)(25786009)(14444005)(478600001)(5024004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1382;H:CY4PR15MB1366.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PbCGEtNAyOK4BsJpUtmm7s0vBlDw/ed4OqonDMskXcMVMbLWtjfC4HKf4hkcV9haN6PUTZG3pbTovHSxGydLbmg+si8gUyKIHxGzCsHAuMpIqkHUnpqfsKWyXCGh+qP/psuGgNXgBAHAdyYsPeJ20VRWMa5k6TDSX0rc1eudEtQZysask33nXdUfthh8pqYqbXMvOgYZ+kZIUh7S7mfYnGcJkNn0/baK363GaPrB72hB3pEI4IozmqeyIA94F6S8qZ9iLmKd9gHHLRFdxGNvMAsXOfIep+wEcRpySERAJFts9qFKMd1GslgxeKSqJI+5z3EJJ7S22ElxIVtGekacfvh56PB8RZ0nn8pztvXSjIXReCDAwAQsBHNfvOV6XFLNnYRdqSWprLYSOhs+ONmNJr0uT45nqp1L8h3YiG39Lf4L+EDuh+ztvVgWBIIpjnbw
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E16859D569815A4AB8064A1301F4E0D2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c5800551-c764-4cd4-a753-08d75c02ed37
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 23:59:53.8340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W7oQMSFTBD4Q7sZgg81+jGgHTmT1jgZL/Eoeas5K1r4WX5WxvYp1Y78l7nlWskaJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1382
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-28_07:2019-10-28,2019-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910280227
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SWx5YSBMZW9zaGtldmljaCA8aWlpQGxpbnV4LmlibS5jb20+IFtNb24sIDIwMTktMTAtMjggMDU6
MjkgLTA3MDBdOg0KPiAiY3R4OmZpbGVfcG9zIHN5c2N0bDpyZWFkIHJlYWQgb2sgbmFycm93IiB3
b3JrcyBvbiBzMzkwIGJ5IGFjY2lkZW50OiBpdA0KPiByZWFkcyB0aGUgd3JvbmcgYnl0ZSwgd2hp
Y2ggaGFwcGVucyB0byBoYXZlIHRoZSBleHBlY3RlZCB2YWx1ZSBvZiAwLg0KPiBJbXByb3ZlIHRo
ZSB0ZXN0IGJ5IHNlZWtpbmcgdG8gdGhlIDR0aCBieXRlIGFuZCBleHBlY3RpbmcgNCBpbnN0ZWFk
IG9mDQo+IDAuDQo+IA0KPiBUaGlzIG1ha2VzIHRoZSBsYXRlbnQgcHJvYmxlbSBhcHBhcmVudDog
dGhlIHRlc3QgYXR0ZW1wdHMgdG8gcmVhZCB0aGUNCj4gZmlyc3QgYnl0ZSBvZiBicGZfc3lzY3Rs
LmZpbGVfcG9zLCBhc3N1bWluZyB0aGlzIGlzIHRoZSBsZWFzdC1zaWduaWZpY2FudA0KPiBieXRl
LCB3aGljaCBpcyBub3QgdGhlIGNhc2Ugb24gYmlnLWVuZGlhbiBtYWNoaW5lczogYSBub24temVy
byBvZmZzZXQgaXMNCj4gbmVlZGVkLg0KPiANCj4gVGhlIHBvaW50IG9mIHRoZSB0ZXN0IGlzIHRv
IHZlcmlmeSBuYXJyb3cgbG9hZHMsIHNvIHdlIGNhbm5vdCBjaGVhdCBvdXINCj4gd2F5IG91dCBi
eSBzaW1wbHkgdXNpbmcgQlBGX1cuIFRoZSBleGlzdGVuY2Ugb2YgdGhlIHRlc3QgbWVhbnMgdGhh
dCBzdWNoDQo+IGxvYWRzIGhhdmUgdG8gYmUgc3VwcG9ydGVkLCBtb3N0IGxpa2VseSBiZWNhdXNl
IGxsdm0gY2FuIGdlbmVyYXRlIHRoZW0uDQoNClJpZ2h0LCBsbHZtIHNvbWV0aW1lcyBnZW5lcmF0
ZXMgbmFycm93IGxvYWQgZXZlbiBpZiBDIHByb3JhbSB1c2VzIHUzMiBhbmQgdGhpcw0KaXMgdGhl
IHJlYXNvbiB0byBzdXBwb3J0IHRoZW0uDQoNCj4gRml4IHRoZSB0ZXN0IGJ5IGFkZGluZyBhIGJp
Zy1lbmRpYW4gdmFyaWFudCwgd2hpY2ggdXNlcyBhbiBvZmZzZXQgdG8NCj4gYWNjZXNzIHRoZSBs
ZWFzdC1zaWduaWZpY2FudCBieXRlIG9mIGJwZl9zeXNjdGwuZmlsZV9wb3MuDQo+IA0KPiBUaGlz
IHJldmVhbHMgdGhlIGZpbmFsIHByb2JsZW06IHZlcmlmaWVyIHJlamVjdHMgYWNjZXNzZXMgdG8g
YnBmX3N5c2N0bA0KPiBmaWVsZHMgd2l0aCBvZmZzZXQgPiAwLiBTdWNoIGFjY2Vzc2VzIGFyZSBh
bHJlYWR5IGFsbG93ZWQgZm9yIGEgd2lkZQ0KPiByYW5nZSBvZiBzdHJ1Y3RzOiBfX3NrX2J1ZmYs
IGJwZl9zb2NrX2FkZHIgYW5kIHNrX21zZ19tZCB0byBuYW1lIGEgZmV3Lg0KPiBFeHRlbmQgdGhp
cyBzdXBwb3J0IHRvIGJwZl9zeXNjdGwgYnkgdXNpbmcgYnBmX2N0eF9yYW5nZSBpbnN0ZWFkIG9m
DQo+IG9mZnNldG9mIHdoZW4gbWF0Y2hpbmcgZmllbGQgb2Zmc2V0cy4NCj4gDQo+IEZpeGVzOiA3
YjE0NmNlYmUzMGMgKCJicGY6IFN5c2N0bCBob29rIikNCj4gRml4ZXM6IGUxNTUwYmZlMGRlNCAo
ImJwZjogQWRkIGZpbGVfcG9zIGZpZWxkIHRvIGJwZl9zeXNjdGwgY3R4IikNCj4gRml4ZXM6IDlh
MTAyN2U1MjUzNSAoInNlbGZ0ZXN0cy9icGY6IFRlc3QgZmlsZV9wb3MgZmllbGQgaW4gYnBmX3N5
c2N0bCBjdHgiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBJbHlhIExlb3Noa2V2aWNoIDxpaWlAbGludXgu
aWJtLmNvbT4NCj4gLS0tDQo+ICBrZXJuZWwvYnBmL2Nncm91cC5jICAgICAgICAgICAgICAgICAg
ICAgICB8IDQgKystLQ0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3Rfc3lzY3Rs
LmMgfCA4ICsrKysrKystDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL2Nncm91cC5jIGIva2Vy
bmVsL2JwZi9jZ3JvdXAuYw0KPiBpbmRleCBkZGQ4YWRkY2RiNWMuLmEzZWFmMDhlN2RkMyAxMDA2
NDQNCj4gLS0tIGEva2VybmVsL2JwZi9jZ3JvdXAuYw0KPiArKysgYi9rZXJuZWwvYnBmL2Nncm91
cC5jDQo+IEBAIC0xMzExLDEyICsxMzExLDEyIEBAIHN0YXRpYyBib29sIHN5c2N0bF9pc192YWxp
ZF9hY2Nlc3MoaW50IG9mZiwgaW50IHNpemUsIGVudW0gYnBmX2FjY2Vzc190eXBlIHR5cGUsDQo+
ICAJCXJldHVybiBmYWxzZTsNCj4gIA0KPiAgCXN3aXRjaCAob2ZmKSB7DQo+IC0JY2FzZSBvZmZz
ZXRvZihzdHJ1Y3QgYnBmX3N5c2N0bCwgd3JpdGUpOg0KPiArCWNhc2UgYnBmX2N0eF9yYW5nZShz
dHJ1Y3QgYnBmX3N5c2N0bCwgd3JpdGUpOg0KPiAgCQlpZiAodHlwZSAhPSBCUEZfUkVBRCkNCj4g
IAkJCXJldHVybiBmYWxzZTsNCj4gIAkJYnBmX2N0eF9yZWNvcmRfZmllbGRfc2l6ZShpbmZvLCBz
aXplX2RlZmF1bHQpOw0KPiAgCQlyZXR1cm4gYnBmX2N0eF9uYXJyb3dfYWNjZXNzX29rKG9mZiwg
c2l6ZSwgc2l6ZV9kZWZhdWx0KTsNCg0KTEdUTSwgYnV0IGNvdWxkIHlvdSBwbGVhc2UgYWRkIGEg
dGVzdCBjYXNlIGZvciBuYXJyb3cgbG9hZCBmcm9tIGB3cml0ZWA/IEZyb20NCndoYXQgSSBzZWUg
YWxsIGV4aXN0aW5nIHRlc3QgY2FzZXMgdXNlIEJQRl9XLg0KDQo+IC0JY2FzZSBvZmZzZXRvZihz
dHJ1Y3QgYnBmX3N5c2N0bCwgZmlsZV9wb3MpOg0KPiArCWNhc2UgYnBmX2N0eF9yYW5nZShzdHJ1
Y3QgYnBmX3N5c2N0bCwgZmlsZV9wb3MpOg0KPiAgCQlpZiAodHlwZSA9PSBCUEZfUkVBRCkgew0K
PiAgCQkJYnBmX2N0eF9yZWNvcmRfZmllbGRfc2l6ZShpbmZvLCBzaXplX2RlZmF1bHQpOw0KPiAg
CQkJcmV0dXJuIGJwZl9jdHhfbmFycm93X2FjY2Vzc19vayhvZmYsIHNpemUsIHNpemVfZGVmYXVs
dCk7DQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9zeXNj
dGwuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi90ZXN0X3N5c2N0bC5jDQo+IGluZGV4
IGEzMjBlMzg0NGIxNy4uN2M2ZTViMTczZjMzIDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9icGYvdGVzdF9zeXNjdGwuYw0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9icGYvdGVzdF9zeXNjdGwuYw0KPiBAQCAtMTYxLDkgKzE2MSwxNCBAQCBzdGF0aWMgc3Ry
dWN0IHN5c2N0bF90ZXN0IHRlc3RzW10gPSB7DQo+ICAJCS5kZXNjciA9ICJjdHg6ZmlsZV9wb3Mg
c3lzY3RsOnJlYWQgcmVhZCBvayBuYXJyb3ciLA0KPiAgCQkuaW5zbnMgPSB7DQo+ICAJCQkvKiBJ
ZiAoZmlsZV9wb3MgPT0gWCkgKi8NCj4gKyNpZiBfX0JZVEVfT1JERVIgPT0gX19MSVRUTEVfRU5E
SUFODQo+ICAJCQlCUEZfTERYX01FTShCUEZfQiwgQlBGX1JFR183LCBCUEZfUkVHXzEsDQo+ICAJ
CQkJICAgIG9mZnNldG9mKHN0cnVjdCBicGZfc3lzY3RsLCBmaWxlX3BvcykpLA0KPiAtCQkJQlBG
X0pNUF9JTU0oQlBGX0pORSwgQlBGX1JFR183LCAwLCAyKSwNCj4gKyNlbHNlDQo+ICsJCQlCUEZf
TERYX01FTShCUEZfQiwgQlBGX1JFR183LCBCUEZfUkVHXzEsDQo+ICsJCQkJICAgIG9mZnNldG9m
KHN0cnVjdCBicGZfc3lzY3RsLCBmaWxlX3BvcykgKyAzKSwNCj4gKyNlbmRpZg0KPiArCQkJQlBG
X0pNUF9JTU0oQlBGX0pORSwgQlBGX1JFR183LCA0LCAyKSwNCj4gIA0KPiAgCQkJLyogcmV0dXJu
IEFMTE9XOyAqLw0KPiAgCQkJQlBGX01PVjY0X0lNTShCUEZfUkVHXzAsIDEpLA0KPiBAQCAtMTc2
LDYgKzE4MSw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc3lzY3RsX3Rlc3QgdGVzdHNbXSA9IHsNCj4gIAkJ
LmF0dGFjaF90eXBlID0gQlBGX0NHUk9VUF9TWVNDVEwsDQo+ICAJCS5zeXNjdGwgPSAia2VybmVs
L29zdHlwZSIsDQo+ICAJCS5vcGVuX2ZsYWdzID0gT19SRE9OTFksDQo+ICsJCS5zZWVrID0gNCwN
Cj4gIAkJLnJlc3VsdCA9IFNVQ0NFU1MsDQo+ICAJfSwNCj4gIAl7DQo+IC0tIA0KPiAyLjIzLjAN
Cj4gDQoNCi0tIA0KQW5kcmV5IElnbmF0b3YNCg==
