Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A45450EA
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2019 02:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfFNAwm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jun 2019 20:52:42 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36148 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbfFNAwm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Jun 2019 20:52:42 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5E0gGB0018772;
        Thu, 13 Jun 2019 17:51:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=caSLQYXZjX2ALDbHJAZESkAd/TEcslEZgg8PznqA7RU=;
 b=AUXAgHt15ShXgzzFUZjPMi0n9XQTR4fyQfK9u+jHghGKal5yyrSA18UaYTzZE6vKjnwe
 6cOcQ1P2VpEYKynBJ/KL0tqPBk9IvXZgWVJ7vCbJNRF6XobgRieb4Kzw6dumDBRRA8I2
 I8qhI8HMfYrFCOpB92Zl7Qj+eHima0H0oOY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2t3qmj23dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 13 Jun 2019 17:51:41 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 13 Jun 2019 17:51:39 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 13 Jun 2019 17:51:38 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 13 Jun 2019 17:51:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caSLQYXZjX2ALDbHJAZESkAd/TEcslEZgg8PznqA7RU=;
 b=HVeJvBc6WT53vwpldIY+Y1INlqdV+KtLbtO7E1gYRQNCpJHK9rPOa3q1/qDAow+vc6DcHDjH/LxbR+X0I5/TnFO7o6yGljLh1xbjSnq/bCOY62zvp2nBNctc6MEfIKwW2nq3clqm2021mevkqKLLhf5WKn/wcER/P8TSU5vac84=
Received: from CY4PR15MB1254.namprd15.prod.outlook.com (10.172.180.136) by
 CY4PR15MB1301.namprd15.prod.outlook.com (10.172.182.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 14 Jun 2019 00:51:24 +0000
Received: from CY4PR15MB1254.namprd15.prod.outlook.com
 ([fe80::5913:4af7:f57c:1d22]) by CY4PR15MB1254.namprd15.prod.outlook.com
 ([fe80::5913:4af7:f57c:1d22%7]) with mapi id 15.20.1987.010; Fri, 14 Jun 2019
 00:51:24 +0000
From:   Matt Mullins <mmullins@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     Song Liu <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "ast@kernel.org" <ast@kernel.org>, Andrew Hall <hall@fb.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Martin Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf v2] bpf: fix nested bpf tracepoints with per-cpu data
Thread-Topic: [PATCH bpf v2] bpf: fix nested bpf tracepoints with per-cpu data
Thread-Index: AQHVIKAbh1qBtP69rE6qUMBEymUwlKaXdkuAgAK8dwCAACKQgA==
Date:   Fri, 14 Jun 2019 00:51:24 +0000
Message-ID: <9c77657414993332987ca79d4081c4d71cc48d66.camel@fb.com>
References: <20190611215304.28831-1-mmullins@fb.com>
         <CAEf4BzZ_Gypm32mSnrpGWw_U9q8LfTn7hag-p-LvYKVNkFdZGw@mail.gmail.com>
         <4aa26670-75b8-118d-68ca-56719af44204@iogearbox.net>
In-Reply-To: <4aa26670-75b8-118d-68ca-56719af44204@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-originating-ip: [2620:10d:c090:200::2:db3f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b26050d9-00b1-47b8-2660-08d6f0626cdd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR15MB1301;
x-ms-traffictypediagnostic: CY4PR15MB1301:
x-microsoft-antispam-prvs: <CY4PR15MB1301A568093A42DD1F3FA1AFB0EE0@CY4PR15MB1301.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(396003)(346002)(376002)(189003)(199004)(91956017)(99286004)(66946007)(64756008)(305945005)(4326008)(316002)(2906002)(66556008)(73956011)(71200400001)(86362001)(71190400001)(66476007)(76116006)(7736002)(66446008)(2501003)(53936002)(54906003)(118296001)(6436002)(110136005)(102836004)(478600001)(14454004)(11346002)(186003)(476003)(53546011)(6506007)(5660300002)(81156014)(446003)(8936002)(46003)(6512007)(36756003)(68736007)(30864003)(6486002)(6246003)(6116002)(486006)(76176011)(229853002)(50226002)(14444005)(256004)(2616005)(25786009)(81166006)(8676002)(99106002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1301;H:CY4PR15MB1254.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j5+So7+/zmoOmoPeABFulFZwIhkAc1P5D+5DyuW9zJQIi4RvknkfhDPvIv+yC8SqXFDfBNwN8m0+dxPKjPnkl/DpGilWbwDxHDH2/wuOkwQL/IvMLiCMPZMKFLC8S4Hi4xKPZahKFV/0VXepGEvSVqxPdqQGKsCLuldtmN1Z2ZBQuLfqvYfmzjST1Q+s9xvMSbZAuqhzEFxFlNkMfWsXrWv0+TzamasNfDjWhC4S5lEU24EQswke0soQyDxe2DgDvvW0PIPFbLJjTpCTrd2JvE9rjoLBRe3nP8aPkbHI28KYtn1dsgPDdqgtwfoJvrymGiWuk2XuvnYjuh6CwjM7plL5CEBi8zM/UCLuBKcV5PwGslWf/JI0PaGCZjhO9E7Y/lYmWxoc1tFHQGlEnnuaHeA71TWlAVyWXWOkLtE9Dx0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0803BE2A77538A4CB6C2C8EFC0DFF6FD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b26050d9-00b1-47b8-2660-08d6f0626cdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 00:51:24.1896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mmullins@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1301
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140005
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gRnJpLCAyMDE5LTA2LTE0IGF0IDAwOjQ3ICswMjAwLCBEYW5pZWwgQm9ya21hbm4gd3JvdGU6
DQo+IE9uIDA2LzEyLzIwMTkgMDc6MDAgQU0sIEFuZHJpaSBOYWtyeWlrbyB3cm90ZToNCj4gPiBP
biBUdWUsIEp1biAxMSwgMjAxOSBhdCA4OjQ4IFBNIE1hdHQgTXVsbGlucyA8bW11bGxpbnNAZmIu
Y29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gQlBGX1BST0dfVFlQRV9SQVdfVFJBQ0VQT0lOVHMg
Y2FuIGJlIGV4ZWN1dGVkIG5lc3RlZCBvbiB0aGUgc2FtZSBDUFUsIGFzDQo+ID4gPiB0aGV5IGRv
IG5vdCBpbmNyZW1lbnQgYnBmX3Byb2dfYWN0aXZlIHdoaWxlIGV4ZWN1dGluZy4NCj4gPiA+IA0K
PiA+ID4gVGhpcyBlbmFibGVzIHRocmVlIGxldmVscyBvZiBuZXN0aW5nLCB0byBzdXBwb3J0DQo+
ID4gPiAgIC0gYSBrcHJvYmUgb3IgcmF3IHRwIG9yIHBlcmYgZXZlbnQsDQo+ID4gPiAgIC0gYW5v
dGhlciBvbmUgb2YgdGhlIGFib3ZlIHRoYXQgaXJxIGNvbnRleHQgaGFwcGVucyB0byBjYWxsLCBh
bmQNCj4gPiA+ICAgLSBhbm90aGVyIG9uZSBpbiBubWkgY29udGV4dA0KPiA+ID4gKGF0IG1vc3Qg
b25lIG9mIHdoaWNoIG1heSBiZSBhIGtwcm9iZSBvciBwZXJmIGV2ZW50KS4NCj4gPiA+IA0KPiA+
ID4gRml4ZXM6IDIwYjlkN2FjNDg1MiAoImJwZjogYXZvaWQgZXhjZXNzaXZlIHN0YWNrIHVzYWdl
IGZvciBwZXJmX3NhbXBsZV9kYXRhIikNCj4gDQo+IEdlbmVyYWxseSwgbG9va3MgZ29vZCB0byBt
ZS4gVHdvIHRoaW5ncyBiZWxvdzoNCj4gDQo+IE5pdCwgZm9yIHN0YWJsZSwgc2hvdWxkbid0IGZp
eGVzIHRhZyBiZSBjNGY2Njk5ZGZjYjggKCJicGY6IGludHJvZHVjZSBCUEZfUkFXX1RSQUNFUE9J
TlQiKQ0KPiBpbnN0ZWFkIG9mIHRoZSBvbmUgeW91IGN1cnJlbnRseSBoYXZlPw0KDQpBaCwgeWVh
aCwgdGhhdCdzIHByb2JhYmx5IG1vcmUgcmVhc29uYWJsZTsgSSBoYXZlbid0IG1hbmFnZWQgdG8g
Y29tZSB1cA0Kd2l0aCBhIHNjZW5hcmlvIHdoZXJlIG9uZSBjb3VsZCBoaXQgdGhpcyB3aXRob3V0
IHJhdyB0cmFjZXBvaW50cy4gIEknbGwNCmZpeCB1cCB0aGUgbml0cyB0aGF0J3ZlIGFjY3VtdWxh
dGVkIHNpbmNlIHYyLg0KDQo+IE9uZSBtb3JlIHF1ZXN0aW9uIC8gY2xhcmlmaWNhdGlvbjogd2Ug
aGF2ZSBfX2JwZl90cmFjZV9ydW4oKSB2cyB0cmFjZV9jYWxsX2JwZigpLg0KPiANCj4gT25seSBy
YXcgdHJhY2Vwb2ludHMgY2FuIGJlIG5lc3RlZCBzaW5jZSB0aGUgcmVzdCBoYXMgdGhlIGJwZl9w
cm9nX2FjdGl2ZSBwZXItQ1BVDQo+IGNvdW50ZXIgdmlhIHRyYWNlX2NhbGxfYnBmKCkgYW5kIHdv
dWxkIGJhaWwgb3V0IG90aGVyd2lzZSwgaWl1Yy4gQW5kIHJhdyBvbmVzIHVzZQ0KPiB0aGUgX19i
cGZfdHJhY2VfcnVuKCkgYWRkZWQgaW4gYzRmNjY5OWRmY2I4ICgiYnBmOiBpbnRyb2R1Y2UgQlBG
X1JBV19UUkFDRVBPSU5UIikuDQo+IA0KPiAxKSBJIHRyaWVkIHRvIHJlY2FsbCBhbmQgZmluZCBh
IHJhdGlvbmFsZSBmb3IgbWVudGlvbmVkIHRyYWNlX2NhbGxfYnBmKCkgc3BsaXQgaW4NCj4gdGhl
IGM0ZjY2OTlkZmNiOCBsb2csIGJ1dCBjb3VsZG4ndCBmaW5kIGFueS4gSXMgdGhlIHJhaXNvbiBk
J8OqdHJlIHB1cmVseSBiZWNhdXNlIG9mDQo+IHBlcmZvcm1hbmNlIG92ZXJoZWFkIChhbmQgZGVz
aXJlIHRvIG5vdCBtaXNzIGV2ZW50cyBhcyBhIHJlc3VsdCBvZiBuZXN0aW5nKT8gKFRoaXMNCj4g
YWxzbyBtZWFucyB3ZSdyZSBub3QgcHJvdGVjdGVkIGJ5IGJwZl9wcm9nX2FjdGl2ZSBpbiBhbGwg
dGhlIG1hcCBvcHMsIG9mIGNvdXJzZS4pDQo+IDIpIFdvdWxkbid0IHRoaXMgYWxzbyBtZWFuIHRo
YXQgd2Ugb25seSBuZWVkIHRvIGZpeCB0aGUgcmF3IHRwIHByb2dyYW1zIHZpYQ0KPiBnZXRfYnBm
X3Jhd190cF9yZWdzKCkgLyBwdXRfYnBmX3Jhd190cF9yZWdzKCkgYW5kIHdvbid0IG5lZWQgdGhp
cyBkdXBsaWNhdGlvbiBmb3INCj4gdGhlIHJlc3Qgd2hpY2ggcmVsaWVzIHVwb24gdHJhY2VfY2Fs
bF9icGYoKT8gSSdtIHByb2JhYmx5IG1pc3Npbmcgc29tZXRoaW5nLCBidXQNCj4gZ2l2ZW4gdGhl
eSBoYXZlIHNlcGFyYXRlIHB0X3JlZ3MgdGhlcmUsIGhvdyBjb3VsZCB0aGV5IGJlIGFmZmVjdGVk
IHRoZW4/DQoNCkZvciB0aGUgcHRfcmVncywgeW91J3JlIGNvcnJlY3Q6IEkgb25seSB1c2VkIGdl
dC9wdXRfcmF3X3RwX3JlZ3MgZm9yDQp0aGUgX3Jhd190cCB2YXJpYW50cy4gIEhvd2V2ZXIsIGNv
bnNpZGVyIHRoZSBmb2xsb3dpbmcgbmVzdGluZzoNCg0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdHJhY2VfbmVzdF9sZXZlbCByYXdfdHBfbmVzdF9sZXZlbA0KICAoa3Byb2Jl
KSBicGZfcGVyZl9ldmVudF9vdXRwdXQgICAgICAgICAgICAxICAgICAgICAgICAgICAgMA0KICAo
cmF3X3RwKSBicGZfcGVyZl9ldmVudF9vdXRwdXRfcmF3X3RwICAgICAyICAgICAgICAgICAgICAg
MQ0KICAocmF3X3RwKSBicGZfZ2V0X3N0YWNraWRfcmF3X3RwICAgICAgICAgICAyICAgICAgICAg
ICAgICAgMg0KDQpJIG5lZWQgdG8gaW5jcmVtZW50IGEgbmVzdCBsZXZlbCAoYW5kIGlkZWFsbHkg
aW5jcmVtZW50IGl0IG9ubHkgb25jZSkNCmJldHdlZW4gdGhlIGtwcm9iZSBhbmQgdGhlIGZpcnN0
IHJhd190cCwgYmVjYXVzZSB0aGV5IHdvdWxkIG90aGVyd2lzZQ0Kc2hhcmUgdGhlIHN0cnVjdCBw
ZXJmX3NhbXBsZV9kYXRhLiAgQnV0IEkgYWxzbyBuZWVkIHRvIGluY3JlbWVudCBhIG5lc3QNCmxl
dmVsIGJldHdlZW4gdGhlIHR3byByYXdfdHBzLCBzaW5jZSB0aGV5IHNoYXJlIHRoZSBwdF9yZWdz
IC0tIEkgY2FuJ3QNCnVzZSB0cmFjZV9uZXN0X2xldmVsIGZvciBldmVyeXRoaW5nIGJlY2F1c2Ug
aXQncyBub3QgdXNlZCBieQ0KZ2V0X3N0YWNraWQsIGFuZCBJIGNhbid0IHVzZSByYXdfdHBfbmVz
dF9sZXZlbCBmb3IgZXZlcnl0aGluZyBiZWNhdXNlDQppdCdzIG5vdCBpbmNyZW1lbnRlZCBieSBr
cHJvYmVzLg0KDQpJZiByYXcgdHJhY2Vwb2ludHMgd2VyZSB0byBidW1wIGJwZl9wcm9nX2FjdGl2
ZSwgdGhlbiBJIGNvdWxkIGdldCBhd2F5DQp3aXRoIGp1c3QgdXNpbmcgdGhhdCBjb3VudCBpbiB0
aGVzZSBjYWxsc2l0ZXMgLS0gSSdtIHJlbHVjdGFudCB0byBkbw0KdGhhdCwgdGhvdWdoLCBzaW5j
ZSBpdCB3b3VsZCBwcmV2ZW50IGtwcm9iZXMgZnJvbSBldmVyIHJ1bm5pbmcgaW5zaWRlIGENCnJh
d190cC4gIEknZCBsaWtlIHRvIHJldGFpbiB0aGUgYWJpbGl0eSB0byAoZS5nLikNCiAgdHJhY2Uu
cHkgLUsgaHRhYl9tYXBfdXBkYXRlX2VsZW0NCmFuZCBnZXQgc29tZSBzdGFjayB0cmFjZXMgZnJv
bSBhdCBsZWFzdCB3aXRoaW4gcmF3IHRyYWNlcG9pbnRzLg0KDQpUaGF0IHNhaWQsIGFzIEkgd3Jv
dGUgdXAgdGhpcyBleGFtcGxlLCBicGZfdHJhY2VfbmVzdF9sZXZlbCBzZWVtcyB0byBiZQ0Kd2ls
ZGx5IG1pc25hbWVkOyBJIHNob3VsZCBuYW1lIHRob3NlIGFmdGVyIHRoZSBzdHJ1Y3R1cmUgdGhl
eSdyZQ0KcHJvdGVjdGluZy4uLg0KDQo+IFRoYW5rcywNCj4gRGFuaWVsDQo+IA0KPiA+ID4gU2ln
bmVkLW9mZi1ieTogTWF0dCBNdWxsaW5zIDxtbXVsbGluc0BmYi5jb20+DQo+ID4gPiAtLS0NCj4g
PiANCj4gPiBMR1RNLCBtaW5vciBuaXQgYmVsb3cuDQo+ID4gDQo+ID4gQWNrZWQtYnk6IEFuZHJp
aSBOYWtyeWlrbyA8YW5kcmlpbkBmYi5jb20+DQo+ID4gDQo+ID4gPiB2MS0+djI6DQo+ID4gPiAg
ICogcmV2ZXJzZS1DaHJpc3RtYXMtdHJlZS1pemUgdGhlIGRlY2xhcmF0aW9ucyBpbiBicGZfcGVy
Zl9ldmVudF9vdXRwdXQNCj4gPiA+ICAgKiBpbnN0YW50aWF0ZSBlcnIgbW9yZSByZWFkYWJseQ0K
PiA+ID4gDQo+ID4gPiBJJ3ZlIGRvbmUgYWRkaXRpb25hbCB0ZXN0aW5nIHdpdGggdGhlIG9yaWdp
bmFsIHdvcmtsb2FkIHRoYXQgaGl0IHRoZQ0KPiA+ID4gaXJxK3Jhdy10cCByZWVudHJhbmN5IHBy
b2JsZW0sIGFuZCBhcyBmYXIgYXMgSSBjYW4gdGVsbCwgaXQncyBzdGlsbA0KPiA+ID4gc29sdmVk
IHdpdGggdGhpcyBzb2x1dGlvbiAoYXMgb3Bwb3NlZCB0byBteSBlYXJsaWVyIHBlci1tYXAtZWxl
bWVudA0KPiA+ID4gdmVyc2lvbikuDQo+ID4gPiANCj4gPiA+ICBrZXJuZWwvdHJhY2UvYnBmX3Ry
YWNlLmMgfCAxMDAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+ID4g
PiAgMSBmaWxlIGNoYW5nZWQsIDg0IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiA+
ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL3RyYWNlL2JwZl90cmFjZS5jIGIva2VybmVs
L3RyYWNlL2JwZl90cmFjZS5jDQo+ID4gPiBpbmRleCBmOTJkNmFkNWUwODAuLjFjOWE0NzQ1ZTU5
NiAxMDA2NDQNCj4gPiA+IC0tLSBhL2tlcm5lbC90cmFjZS9icGZfdHJhY2UuYw0KPiA+ID4gKysr
IGIva2VybmVsL3RyYWNlL2JwZl90cmFjZS5jDQo+ID4gPiBAQCAtNDEwLDggKzQxMCw2IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgYnBmX2Z1bmNfcHJvdG8gYnBmX3BlcmZfZXZlbnRfcmVhZF92YWx1
ZV9wcm90byA9IHsNCj4gPiA+ICAgICAgICAgLmFyZzRfdHlwZSAgICAgID0gQVJHX0NPTlNUX1NJ
WkUsDQo+ID4gPiAgfTsNCj4gPiA+IA0KPiA+ID4gLXN0YXRpYyBERUZJTkVfUEVSX0NQVShzdHJ1
Y3QgcGVyZl9zYW1wbGVfZGF0YSwgYnBmX3RyYWNlX3NkKTsNCj4gPiA+IC0NCj4gPiA+ICBzdGF0
aWMgX19hbHdheXNfaW5saW5lIHU2NA0KPiA+ID4gIF9fYnBmX3BlcmZfZXZlbnRfb3V0cHV0KHN0
cnVjdCBwdF9yZWdzICpyZWdzLCBzdHJ1Y3QgYnBmX21hcCAqbWFwLA0KPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgdTY0IGZsYWdzLCBzdHJ1Y3QgcGVyZl9zYW1wbGVfZGF0YSAqc2QpDQo+
ID4gPiBAQCAtNDQyLDI0ICs0NDAsNTAgQEAgX19icGZfcGVyZl9ldmVudF9vdXRwdXQoc3RydWN0
IHB0X3JlZ3MgKnJlZ3MsIHN0cnVjdCBicGZfbWFwICptYXAsDQo+ID4gPiAgICAgICAgIHJldHVy
biBwZXJmX2V2ZW50X291dHB1dChldmVudCwgc2QsIHJlZ3MpOw0KPiA+ID4gIH0NCj4gPiA+IA0K
PiA+ID4gKy8qDQo+ID4gPiArICogU3VwcG9ydCBleGVjdXRpbmcgdHJhY2Vwb2ludHMgaW4gbm9y
bWFsLCBpcnEsIGFuZCBubWkgY29udGV4dCB0aGF0IGVhY2ggY2FsbA0KPiA+ID4gKyAqIGJwZl9w
ZXJmX2V2ZW50X291dHB1dA0KPiA+ID4gKyAqLw0KPiA+ID4gK3N0cnVjdCBicGZfdHJhY2Vfc2Ft
cGxlX2RhdGEgew0KPiA+ID4gKyAgICAgICBzdHJ1Y3QgcGVyZl9zYW1wbGVfZGF0YSBzZHNbM107
DQo+ID4gPiArfTsNCj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgREVGSU5FX1BFUl9DUFUoc3RydWN0
IGJwZl90cmFjZV9zYW1wbGVfZGF0YSwgYnBmX3RyYWNlX3Nkcyk7DQo+ID4gPiArc3RhdGljIERF
RklORV9QRVJfQ1BVKGludCwgYnBmX3RyYWNlX25lc3RfbGV2ZWwpOw0KPiA+ID4gIEJQRl9DQUxM
XzUoYnBmX3BlcmZfZXZlbnRfb3V0cHV0LCBzdHJ1Y3QgcHRfcmVncyAqLCByZWdzLCBzdHJ1Y3Qg
YnBmX21hcCAqLCBtYXAsDQo+ID4gPiAgICAgICAgICAgIHU2NCwgZmxhZ3MsIHZvaWQgKiwgZGF0
YSwgdTY0LCBzaXplKQ0KPiA+ID4gIHsNCj4gPiA+IC0gICAgICAgc3RydWN0IHBlcmZfc2FtcGxl
X2RhdGEgKnNkID0gdGhpc19jcHVfcHRyKCZicGZfdHJhY2Vfc2QpOw0KPiA+ID4gKyAgICAgICBz
dHJ1Y3QgYnBmX3RyYWNlX3NhbXBsZV9kYXRhICpzZHMgPSB0aGlzX2NwdV9wdHIoJmJwZl90cmFj
ZV9zZHMpOw0KPiA+ID4gKyAgICAgICBpbnQgbmVzdF9sZXZlbCA9IHRoaXNfY3B1X2luY19yZXR1
cm4oYnBmX3RyYWNlX25lc3RfbGV2ZWwpOw0KPiA+ID4gICAgICAgICBzdHJ1Y3QgcGVyZl9yYXdf
cmVjb3JkIHJhdyA9IHsNCj4gPiA+ICAgICAgICAgICAgICAgICAuZnJhZyA9IHsNCj4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgIC5zaXplID0gc2l6ZSwNCj4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIC5kYXRhID0gZGF0YSwNCj4gPiA+ICAgICAgICAgICAgICAgICB9LA0KPiA+ID4g
ICAgICAgICB9Ow0KPiA+ID4gKyAgICAgICBzdHJ1Y3QgcGVyZl9zYW1wbGVfZGF0YSAqc2Q7DQo+
ID4gPiArICAgICAgIGludCBlcnI7DQo+ID4gPiANCj4gPiA+IC0gICAgICAgaWYgKHVubGlrZWx5
KGZsYWdzICYgfihCUEZfRl9JTkRFWF9NQVNLKSkpDQo+ID4gPiAtICAgICAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7DQo+ID4gPiArICAgICAgIGlmIChXQVJOX09OX09OQ0UobmVzdF9sZXZlbCA+
IEFSUkFZX1NJWkUoc2RzLT5zZHMpKSkgew0KPiA+ID4gKyAgICAgICAgICAgICAgIGVyciA9IC1F
QlVTWTsNCj4gPiA+ICsgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gPiA+ICsgICAgICAgfQ0K
PiA+ID4gKw0KPiA+ID4gKyAgICAgICBzZCA9ICZzZHMtPnNkc1tuZXN0X2xldmVsIC0gMV07DQo+
ID4gPiArDQo+ID4gPiArICAgICAgIGlmICh1bmxpa2VseShmbGFncyAmIH4oQlBGX0ZfSU5ERVhf
TUFTSykpKSB7DQo+ID4gPiArICAgICAgICAgICAgICAgZXJyID0gLUVJTlZBTDsNCj4gPiA+ICsg
ICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gPiA+ICsgICAgICAgfQ0KPiA+IA0KPiA+IEZlZWwg
ZnJlZSB0byBpZ25vcmUsIGJ1dCBqdXN0IHN0eWxpc3RpY2FsbHksIGdpdmVuIHRoaXMgY2hlY2sg
ZG9lc24ndA0KPiA+IGRlcGVuZCBvbiBzZCwgSSdkIG1vdmUgaXQgZWl0aGVyIHRvIHRoZSB2ZXJ5
IHRvcCBvciByaWdodCBhZnRlcg0KPiA+IGBuZXN0X2xldmVsID4gQVJSQVlfU0laRShzZHMtPnNk
cylgIGNoZWNrLCBzbyB0aGF0IGFsbCB0aGUgZXJyb3INCj4gPiBjaGVja2luZyBpcyBncm91cGVk
IHdpdGhvdXQgaW50ZXJzcGVyc2VkIGFzc2lnbm1lbnQuDQo+IA0KPiBNYWtlcyBzZW5zZS4NCj4g
DQo+ID4gPiAgICAgICAgIHBlcmZfc2FtcGxlX2RhdGFfaW5pdChzZCwgMCwgMCk7DQo+ID4gPiAg
ICAgICAgIHNkLT5yYXcgPSAmcmF3Ow0KPiA+ID4gDQo+ID4gPiAtICAgICAgIHJldHVybiBfX2Jw
Zl9wZXJmX2V2ZW50X291dHB1dChyZWdzLCBtYXAsIGZsYWdzLCBzZCk7DQo+ID4gPiArICAgICAg
IGVyciA9IF9fYnBmX3BlcmZfZXZlbnRfb3V0cHV0KHJlZ3MsIG1hcCwgZmxhZ3MsIHNkKTsNCj4g
PiA+ICsNCj4gPiA+ICtvdXQ6DQo+ID4gPiArICAgICAgIHRoaXNfY3B1X2RlYyhicGZfdHJhY2Vf
bmVzdF9sZXZlbCk7DQo+ID4gPiArICAgICAgIHJldHVybiBlcnI7DQo+ID4gPiAgfQ0KPiA+ID4g
DQo+ID4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBicGZfZnVuY19wcm90byBicGZfcGVyZl9ldmVu
dF9vdXRwdXRfcHJvdG8gPSB7DQo+ID4gPiBAQCAtODIyLDE2ICs4NDYsNDggQEAgcGVfcHJvZ19m
dW5jX3Byb3RvKGVudW0gYnBmX2Z1bmNfaWQgZnVuY19pZCwgY29uc3Qgc3RydWN0IGJwZl9wcm9n
ICpwcm9nKQ0KPiA+ID4gIC8qDQo+ID4gPiAgICogYnBmX3Jhd190cF9yZWdzIGFyZSBzZXBhcmF0
ZSBmcm9tIGJwZl9wdF9yZWdzIHVzZWQgZnJvbSBza2IveGRwDQo+ID4gPiAgICogdG8gYXZvaWQg
cG90ZW50aWFsIHJlY3Vyc2l2ZSByZXVzZSBpc3N1ZSB3aGVuL2lmIHRyYWNlcG9pbnRzIGFyZSBh
ZGRlZA0KPiA+ID4gLSAqIGluc2lkZSBicGZfKl9ldmVudF9vdXRwdXQsIGJwZl9nZXRfc3RhY2tp
ZCBhbmQvb3IgYnBmX2dldF9zdGFjaw0KPiA+ID4gKyAqIGluc2lkZSBicGZfKl9ldmVudF9vdXRw
dXQsIGJwZl9nZXRfc3RhY2tpZCBhbmQvb3IgYnBmX2dldF9zdGFjay4NCj4gPiA+ICsgKg0KPiA+
ID4gKyAqIFNpbmNlIHJhdyB0cmFjZXBvaW50cyBydW4gZGVzcGl0ZSBicGZfcHJvZ19hY3RpdmUs
IHN1cHBvcnQgY29uY3VycmVudCB1c2FnZQ0KPiA+ID4gKyAqIGluIG5vcm1hbCwgaXJxLCBhbmQg
bm1pIGNvbnRleHQuDQo+ID4gPiAgICovDQo+ID4gPiAtc3RhdGljIERFRklORV9QRVJfQ1BVKHN0
cnVjdCBwdF9yZWdzLCBicGZfcmF3X3RwX3JlZ3MpOw0KPiA+ID4gK3N0cnVjdCBicGZfcmF3X3Rw
X3JlZ3Mgew0KPiA+ID4gKyAgICAgICBzdHJ1Y3QgcHRfcmVncyByZWdzWzNdOw0KPiA+ID4gK307
DQo+ID4gPiArc3RhdGljIERFRklORV9QRVJfQ1BVKHN0cnVjdCBicGZfcmF3X3RwX3JlZ3MsIGJw
Zl9yYXdfdHBfcmVncyk7DQo+ID4gPiArc3RhdGljIERFRklORV9QRVJfQ1BVKGludCwgYnBmX3Jh
d190cF9uZXN0X2xldmVsKTsNCj4gPiA+ICtzdGF0aWMgc3RydWN0IHB0X3JlZ3MgKmdldF9icGZf
cmF3X3RwX3JlZ3Modm9pZCkNCj4gPiA+ICt7DQo+ID4gPiArICAgICAgIHN0cnVjdCBicGZfcmF3
X3RwX3JlZ3MgKnRwX3JlZ3MgPSB0aGlzX2NwdV9wdHIoJmJwZl9yYXdfdHBfcmVncyk7DQo+ID4g
PiArICAgICAgIGludCBuZXN0X2xldmVsID0gdGhpc19jcHVfaW5jX3JldHVybihicGZfcmF3X3Rw
X25lc3RfbGV2ZWwpOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICBpZiAoV0FSTl9PTl9PTkNFKG5l
c3RfbGV2ZWwgPiBBUlJBWV9TSVpFKHRwX3JlZ3MtPnJlZ3MpKSkgew0KPiA+ID4gKyAgICAgICAg
ICAgICAgIHRoaXNfY3B1X2RlYyhicGZfcmF3X3RwX25lc3RfbGV2ZWwpOw0KPiA+ID4gKyAgICAg
ICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FQlVTWSk7DQo+ID4gPiArICAgICAgIH0NCj4gPiA+
ICsNCj4gPiA+ICsgICAgICAgcmV0dXJuICZ0cF9yZWdzLT5yZWdzW25lc3RfbGV2ZWwgLSAxXTsN
Cj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIHZvaWQgcHV0X2JwZl9yYXdfdHBfcmVn
cyh2b2lkKQ0KPiA+ID4gK3sNCj4gPiA+ICsgICAgICAgdGhpc19jcHVfZGVjKGJwZl9yYXdfdHBf
bmVzdF9sZXZlbCk7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gIEJQRl9DQUxMXzUoYnBmX3Bl
cmZfZXZlbnRfb3V0cHV0X3Jhd190cCwgc3RydWN0IGJwZl9yYXdfdHJhY2Vwb2ludF9hcmdzICos
IGFyZ3MsDQo+ID4gPiAgICAgICAgICAgIHN0cnVjdCBicGZfbWFwICosIG1hcCwgdTY0LCBmbGFn
cywgdm9pZCAqLCBkYXRhLCB1NjQsIHNpemUpDQo+ID4gPiAgew0KPiA+ID4gLSAgICAgICBzdHJ1
Y3QgcHRfcmVncyAqcmVncyA9IHRoaXNfY3B1X3B0cigmYnBmX3Jhd190cF9yZWdzKTsNCj4gPiA+
ICsgICAgICAgc3RydWN0IHB0X3JlZ3MgKnJlZ3MgPSBnZXRfYnBmX3Jhd190cF9yZWdzKCk7DQo+
ID4gPiArICAgICAgIGludCByZXQ7DQo+ID4gPiArDQo+ID4gPiArICAgICAgIGlmIChJU19FUlIo
cmVncykpDQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIocmVncyk7DQo+ID4g
PiANCj4gPiA+ICAgICAgICAgcGVyZl9mZXRjaF9jYWxsZXJfcmVncyhyZWdzKTsNCj4gPiA+IC0g
ICAgICAgcmV0dXJuIF9fX19icGZfcGVyZl9ldmVudF9vdXRwdXQocmVncywgbWFwLCBmbGFncywg
ZGF0YSwgc2l6ZSk7DQo+ID4gPiArICAgICAgIHJldCA9IF9fX19icGZfcGVyZl9ldmVudF9vdXRw
dXQocmVncywgbWFwLCBmbGFncywgZGF0YSwgc2l6ZSk7DQo+ID4gPiArDQo+ID4gPiArICAgICAg
IHB1dF9icGZfcmF3X3RwX3JlZ3MoKTsNCj4gPiA+ICsgICAgICAgcmV0dXJuIHJldDsNCj4gPiA+
ICB9DQo+ID4gPiANCj4gPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGJwZl9mdW5jX3Byb3RvIGJw
Zl9wZXJmX2V2ZW50X291dHB1dF9wcm90b19yYXdfdHAgPSB7DQo+ID4gPiBAQCAtODQ4LDEyICs5
MDQsMTggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBicGZfZnVuY19wcm90byBicGZfcGVyZl9ldmVu
dF9vdXRwdXRfcHJvdG9fcmF3X3RwID0gew0KPiA+ID4gIEJQRl9DQUxMXzMoYnBmX2dldF9zdGFj
a2lkX3Jhd190cCwgc3RydWN0IGJwZl9yYXdfdHJhY2Vwb2ludF9hcmdzICosIGFyZ3MsDQo+ID4g
PiAgICAgICAgICAgIHN0cnVjdCBicGZfbWFwICosIG1hcCwgdTY0LCBmbGFncykNCj4gPiA+ICB7
DQo+ID4gPiAtICAgICAgIHN0cnVjdCBwdF9yZWdzICpyZWdzID0gdGhpc19jcHVfcHRyKCZicGZf
cmF3X3RwX3JlZ3MpOw0KPiA+ID4gKyAgICAgICBzdHJ1Y3QgcHRfcmVncyAqcmVncyA9IGdldF9i
cGZfcmF3X3RwX3JlZ3MoKTsNCj4gPiA+ICsgICAgICAgaW50IHJldDsNCj4gPiA+ICsNCj4gPiA+
ICsgICAgICAgaWYgKElTX0VSUihyZWdzKSkNCj4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4g
UFRSX0VSUihyZWdzKTsNCj4gPiA+IA0KPiA+ID4gICAgICAgICBwZXJmX2ZldGNoX2NhbGxlcl9y
ZWdzKHJlZ3MpOw0KPiA+ID4gICAgICAgICAvKiBzaW1pbGFyIHRvIGJwZl9wZXJmX2V2ZW50X291
dHB1dF90cCwgYnV0IHB0X3JlZ3MgZmV0Y2hlZCBkaWZmZXJlbnRseSAqLw0KPiA+ID4gLSAgICAg
ICByZXR1cm4gYnBmX2dldF9zdGFja2lkKCh1bnNpZ25lZCBsb25nKSByZWdzLCAodW5zaWduZWQg
bG9uZykgbWFwLA0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZsYWdzLCAw
LCAwKTsNCj4gPiA+ICsgICAgICAgcmV0ID0gYnBmX2dldF9zdGFja2lkKCh1bnNpZ25lZCBsb25n
KSByZWdzLCAodW5zaWduZWQgbG9uZykgbWFwLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZmxhZ3MsIDAsIDApOw0KPiA+ID4gKyAgICAgICBwdXRfYnBmX3Jhd190cF9yZWdz
KCk7DQo+ID4gPiArICAgICAgIHJldHVybiByZXQ7DQo+ID4gPiAgfQ0KPiA+ID4gDQo+ID4gPiAg
c3RhdGljIGNvbnN0IHN0cnVjdCBicGZfZnVuY19wcm90byBicGZfZ2V0X3N0YWNraWRfcHJvdG9f
cmF3X3RwID0gew0KPiA+ID4gQEAgLTg2OCwxMSArOTMwLDE3IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgYnBmX2Z1bmNfcHJvdG8gYnBmX2dldF9zdGFja2lkX3Byb3RvX3Jhd190cCA9IHsNCj4gPiA+
ICBCUEZfQ0FMTF80KGJwZl9nZXRfc3RhY2tfcmF3X3RwLCBzdHJ1Y3QgYnBmX3Jhd190cmFjZXBv
aW50X2FyZ3MgKiwgYXJncywNCj4gPiA+ICAgICAgICAgICAgdm9pZCAqLCBidWYsIHUzMiwgc2l6
ZSwgdTY0LCBmbGFncykNCj4gPiA+ICB7DQo+ID4gPiAtICAgICAgIHN0cnVjdCBwdF9yZWdzICpy
ZWdzID0gdGhpc19jcHVfcHRyKCZicGZfcmF3X3RwX3JlZ3MpOw0KPiA+ID4gKyAgICAgICBzdHJ1
Y3QgcHRfcmVncyAqcmVncyA9IGdldF9icGZfcmF3X3RwX3JlZ3MoKTsNCj4gPiA+ICsgICAgICAg
aW50IHJldDsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgaWYgKElTX0VSUihyZWdzKSkNCj4gPiA+
ICsgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihyZWdzKTsNCj4gPiA+IA0KPiA+ID4gICAg
ICAgICBwZXJmX2ZldGNoX2NhbGxlcl9yZWdzKHJlZ3MpOw0KPiA+ID4gLSAgICAgICByZXR1cm4g
YnBmX2dldF9zdGFjaygodW5zaWduZWQgbG9uZykgcmVncywgKHVuc2lnbmVkIGxvbmcpIGJ1ZiwN
Cj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgKHVuc2lnbmVkIGxvbmcpIHNpemUs
IGZsYWdzLCAwKTsNCj4gPiA+ICsgICAgICAgcmV0ID0gYnBmX2dldF9zdGFjaygodW5zaWduZWQg
bG9uZykgcmVncywgKHVuc2lnbmVkIGxvbmcpIGJ1ZiwNCj4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAodW5zaWduZWQgbG9uZykgc2l6ZSwgZmxhZ3MsIDApOw0KPiA+ID4gKyAgICAg
ICBwdXRfYnBmX3Jhd190cF9yZWdzKCk7DQo+ID4gPiArICAgICAgIHJldHVybiByZXQ7DQo+ID4g
PiAgfQ0KPiA+ID4gDQo+ID4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBicGZfZnVuY19wcm90byBi
cGZfZ2V0X3N0YWNrX3Byb3RvX3Jhd190cCA9IHsNCj4gPiA+IC0tDQo+ID4gPiAyLjE3LjENCj4g
PiA+IA0KPiANCj4gDQo=
