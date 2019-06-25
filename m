Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED81553BE
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2019 17:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbfFYPvt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jun 2019 11:51:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57876 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbfFYPvs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Jun 2019 11:51:48 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PFikoB029025;
        Tue, 25 Jun 2019 08:51:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ShlWxDXnNwxhdhV0gExeE5jp1UANRMAARZK/oP/4WyE=;
 b=TpxLW1C+1AdW1WJpLYldD6Hv7p/DNTiQbRW7VtA2MRj+9KJ+7zqzWJns5TIhzFH1XzwO
 Q+vYxr21heQXEomla8F882kenk1QVjb+Rbgprs3OMpDStPYwlqp2jMM8Xt7P4PhYJyzE
 xdA5fPG0lVdDvY9S4sexoWhDEgmsYmI42HI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2tbn4hrch4-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 Jun 2019 08:51:25 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 25 Jun 2019 08:50:59 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 25 Jun 2019 08:50:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShlWxDXnNwxhdhV0gExeE5jp1UANRMAARZK/oP/4WyE=;
 b=XcIDNptQiyeEJXNPAi88ieeUtHwg7KEWaBTX2S24LMbuc6blY8Z5R3+VqPjpjUTjRZCsYqdV5wMj/C8047f8w7W2nlxswzXJtVg24z9oLdar9oLHSWO5aPwXbrE5E9Y9n+a36bsshpPKxu1W3GF7lZ0TgmOBLLgqSVCXoa14OOk=
Received: from BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) by
 BYAPR15MB2501.namprd15.prod.outlook.com (52.135.196.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 15:50:55 +0000
Received: from BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::60a3:8bdd:1ea2:3702]) by BYAPR15MB2501.namprd15.prod.outlook.com
 ([fe80::60a3:8bdd:1ea2:3702%7]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 15:50:55 +0000
From:   Alexei Starovoitov <ast@fb.com>
To:     Roman Gushchin <guro@fb.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Tejun Heo <tj@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: fix cgroup bpf release synchronization
Thread-Topic: [PATCH bpf-next] bpf: fix cgroup bpf release synchronization
Thread-Index: AQHVKjTnfXTg4w17SUSy4+EivgF2L6apsEGAgAB+kgCAAlhLAA==
Date:   Tue, 25 Jun 2019 15:50:55 +0000
Message-ID: <6eedf3b7-d2db-7348-5969-d57376483961@fb.com>
References: <20190624023051.4168487-1-guro@fb.com>
 <91017042-1b59-6110-dfdd-13cfbbec1ae1@fb.com>
 <20190624040211.GA10696@castle.dhcp.thefacebook.com>
In-Reply-To: <20190624040211.GA10696@castle.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:300:6c::22) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:ec57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1376b80-3690-48d2-e284-08d6f984e839
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2501;
x-ms-traffictypediagnostic: BYAPR15MB2501:
x-microsoft-antispam-prvs: <BYAPR15MB250162A5C937B468BD56C47BD7E30@BYAPR15MB2501.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(396003)(39860400002)(199004)(189003)(6636002)(46003)(6486002)(54906003)(229853002)(316002)(53936002)(6512007)(66556008)(478600001)(66476007)(6436002)(37006003)(66946007)(64756008)(73956011)(66446008)(99286004)(14444005)(5024004)(4326008)(6116002)(102836004)(76176011)(53546011)(52116002)(186003)(71190400001)(71200400001)(68736007)(6506007)(25786009)(11346002)(2616005)(31696002)(486006)(86362001)(305945005)(386003)(6862004)(256004)(8676002)(8936002)(81166006)(81156014)(476003)(14454004)(6246003)(36756003)(2906002)(5660300002)(31686004)(446003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2501;H:BYAPR15MB2501.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WYKQDWnYDvTTEdIYyc91YbYDHr/wGxxNbCwFq0xqqgYMbMsDH2RO96VWKKvqWLRDSfidb71UnsRGQvg4/tylN5DZr/vzaJKbn05HibsL93aaob7nuDZU0bZrKNSCUgwz8xo9ZSKbpXPY23zAvbeELkiw6LShXBRTKsLpwTXIccFvV6Ua80c/gFDBc9wiZfFTRIeWPaoqmCP7Z8wwAlIzeaUOGEeflccv3jMBBUaX7JPmeHZTYyd1640uKMfjk5WwC0WtgxKuszSsJ/glqEQrpM8zVCL4MT0VetcLaoHDscIHoDV9ohCOj1JgQ/W3CeGXDudxVi7vbfDksl5Y/GWpainmFZ9Bsevror2btmfUlVdQRWv5VkqEuvCfnIXxQB0/mpCroQE+kTq0qUXp6TfE2FtDxChfKQmrSsM6EytX/ec=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F25D1DDA3305544AC10EAD23F0859E5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b1376b80-3690-48d2-e284-08d6f984e839
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 15:50:55.4206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ast@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2501
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=823 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250119
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gNi8yMy8xOSA5OjAyIFBNLCBSb21hbiBHdXNoY2hpbiB3cm90ZToNCj4gT24gU3VuLCBKdW4g
MjMsIDIwMTkgYXQgMDg6Mjk6MjFQTSAtMDcwMCwgQWxleGVpIFN0YXJvdm9pdG92IHdyb3RlOg0K
Pj4gT24gNi8yMy8xOSA3OjMwIFBNLCBSb21hbiBHdXNoY2hpbiB3cm90ZToNCj4+PiBTaW5jZSBj
b21taXQgNGJmYzBiYjJjNjBlICgiYnBmOiBkZWNvdXBsZSB0aGUgbGlmZXRpbWUgb2YgY2dyb3Vw
X2JwZg0KPj4+IGZyb20gY2dyb3VwIGl0c2VsZiIpLCBjZ3JvdXBfYnBmIHJlbGVhc2Ugb2NjdXJz
IGFzeW5jaHJvbm91c2x5DQo+Pj4gKGZyb20gYSB3b3JrZXIgY29udGV4dCksIGFuZCBiZWZvcmUg
dGhlIHJlbGVhc2Ugb2YgdGhlIGNncm91cCBpdHNlbGYuDQo+Pj4NCj4+PiBUaGlzIGludHJvZHVj
ZWQgYSBwcmV2aW91c2x5IG5vbi1leGlzdGluZyByYWNlIGJldHdlZW4gdGhlIHJlbGVhc2UNCj4+
PiBhbmQgdXBkYXRlIHBhdGhzLiBFLmcuIGlmIGEgbGVhZidzIGNncm91cF9icGYgaXMgcmVsZWFz
ZWQgYW5kIGEgbmV3DQo+Pj4gYnBmIHByb2dyYW0gaXMgYXR0YWNoZWQgdG8gdGhlIG9uZSBvZiBh
bmNlc3RvciBjZ3JvdXBzIGF0IHRoZSBzYW1lDQo+Pj4gdGltZS4gVGhlIHJhY2UgbWF5IHJlc3Vs
dCBpbiBkb3VibGUtZnJlZSBhbmQgb3RoZXIgbWVtb3J5IGNvcnJ1cHRpb25zLg0KPj4+DQo+Pj4g
VG8gZml4IHRoZSBwcm9ibGVtLCBsZXQncyBwcm90ZWN0IHRoZSBib2R5IG9mIGNncm91cF9icGZf
cmVsZWFzZSgpDQo+Pj4gd2l0aCBjZ3JvdXBfbXV0ZXgsIGFzIGl0IHdhcyBlZmZlY3RpdmVseSBw
cmV2aW91c2x5LCB3aGVuIGFsbCB0aGlzDQo+Pj4gY29kZSB3YXMgY2FsbGVkIGZyb20gdGhlIGNn
cm91cCByZWxlYXNlIHBhdGggd2l0aCBjZ3JvdXAgbXV0ZXggaGVsZC4NCj4+Pg0KPj4+IEFsc28g
bWFrZSBzdXJlLCB0aGF0IHdlIGRvbid0IGxlYXZlIGFscmVhZHkgZnJlZWQgcG9pbnRlcnMgdG8g
dGhlDQo+Pj4gZWZmZWN0aXZlIHByb2cgYXJyYXlzLiBPdGhlcndpc2UsIHRoZXkgY2FuIGJlIHJl
bGVhc2VkIGFnYWluIGJ5DQo+Pj4gdGhlIHVwZGF0ZSBwYXRoLiBJdCB3YXNuJ3QgbmVjZXNzYXJ5
IGJlZm9yZSwgYmVjYXVzZSBwcmV2aW91c2x5DQo+Pj4gdGhlIHVwZGF0ZSBwYXRoIGNvdWxkbid0
IHNlZSBzdWNoIGEgY2dyb3VwLCBhcyBjZ3JvdXBfYnBmIGFuZCBjZ3JvdXANCj4+PiBpdHNlbGYg
d2VyZSByZWxlYXNlZCB0b2dldGhlci4NCj4+DQo+PiBJIHRob3VnaHQgZHlpbmcgY2dyb3VwIHdv
bid0IGhhdmUgYW55IGNoaWxkcmVuIGNncm91cHMgPw0KPiANCj4gSXQncyBub3QgY29tcGxldGVs
eSB0cnVlLCBhIGR5aW5nIGNncm91cCBjYW4ndCBoYXZlIGxpdmluZyBjaGlsZHJlbi4NCj4gDQo+
PiBJdCBzaG91bGQgaGF2ZSBiZWVuIGVtcHR5IHdpdGggbm8gdGFza3MgaW5zaWRlIGl0Pw0KPiAN
Cj4gUmlnaHQuDQo+IA0KPj4gT25seSBzb21lIHJlc291cmNlcyBhcmUgc3RpbGwgaGVsZD8NCj4g
DQo+IFJpZ2h0Lg0KPiANCj4+IG11dGV4IGFuZCB6ZXJvIGluaXQgYXJlIGhpZ2hseSBzdXNwaWNp
b3VzLg0KPj4gSXQgZmVlbHMgdGhhdCBjZ3JvdXBfYnBmX3JlbGVhc2UgaXMgY2FsbGVkIHRvbyBl
YXJseS4NCj4gDQo+IEFuIGFsdGVybmF0aXZlIHNvbHV0aW9uIGlzIHRvIGJ1bXAgdGhlIHJlZmNv
dW50ZXIgb24NCj4gZXZlcnkgdXBkYXRlIHBhdGgsIGFuZCBleHBsaWNpdGx5IHNraXAgZGUtYnBm
J2VkIGNncm91cHMuDQo+IA0KPj4NCj4+IFRoaW5raW5nIGZyb20gYW5vdGhlciBhbmdsZS4uLiBp
ZiBjaGlsZCBjZ3JvdXBzIGNhbiBzdGlsbCBhdHRhY2ggdGhlbg0KPj4gdGhpcyBicGZfcmVsZWFz
ZSBpcyBicm9rZW4uDQo+IA0KPiBIbSwgd2hhdCBkbyB5b3UgbWVhbiB1bmRlciBhdHRhY2g/IEl0
J3Mgbm90IHBvc3NpYmxlIHRvIGF0dGFjaA0KPiBhIG5ldyBwcm9nLCBidXQgaWYgYSBwcm9nIGlz
IGF0dGFjaGVkIHRvIGEgcGFyZW50IGNncm91cCwNCj4gYSBwb2ludGVyIGNhbiBzcGlsbCB0aHJv
dWdoICJlZmZlY3RpdmUiIGFycmF5Lg0KPiANCj4gQnV0IEkgYWdyZWUsIGl0J3MgYnJva2VuLiBV
cGRhdGUgcGF0aCBzaG91bGQgaWdub3JlIHN1Y2gNCj4gY2dyb3VwcyAoY2dyb3Vwcywgd2hpY2gg
Y2dyb3VwX2JwZiB3YXMgcmVsZWFzZWQpLiBJJ2xsIHRha2UgYSBsb29rLg0KPiANCj4+IFRoZSBj
b2RlIHNob3VsZCBiZQ0KPj4gY2FsbGluZyBfX2Nncm91cF9icGZfZGV0YWNoKCkgb25lIGJ5IG9u
ZSB0byBtYWtlIHN1cmUNCj4+IHVwZGF0ZV9lZmZlY3RpdmVfcHJvZ3MoKSBpcyBjYWxsZWQsIHNp
bmNlIGRlc2NlbmRhbnQgYXJlIHN0aWxsDQo+PiBzb3J0LW9mIGFsaXZlIGFuZCBjYW4gYXR0YWNo
Pw0KPiANCj4gTm90IHN1cmUgSSBnZXQgeW91LiBEeWluZyBjZ3JvdXAgaXMgYSBsZWFmIGNncm91
cC4NCj4gDQo+Pg0KPj4gTXkgbW9uZXkgaXMgb24gJ3RvbyBlYXJseScuDQo+PiBNYXkgYmUgY2dy
b3VwIGlzIG5vdCBkeWluZyA/DQo+PiBKdXN0IGNncm91cF9za19mcmVlKCkgaXMgY2FsbGVkIG9u
IHRoZSBsYXN0IHNvY2tldCBhbmQNCj4+IHRoaXMgYXV0by1kZXRhY2ggbG9naWMgZ290IHRyaWdn
ZXJlZCBpbmNvcnJlY3RseT8NCj4gDQo+IFNvLCBvbmNlIGFnYWluLCB3aGF0J3MgbXkgcGljdHVy
ZToNCj4gDQo+IEENCj4gQS9CDQo+IEEvQi9DDQo+IA0KPiBjcHUxOiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjcHUyOg0KPiBybWRpciBDICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBhdHRhY2ggbmV3IHByb2cgdG8gQQ0KPiBDIGdvdCBkeWluZyAgICAgICAgICAgICAgICAgICAg
ICAgICB1cGRhdGUgQSwgdXBkYXRlIEIsIHVwZGF0ZSBDLi4uDQo+IEMncyBjZ3JvdXBfYnBmIGlz
IHJlbGVhc2VkICAgICAgICAgIEMncyBlZmZlY3RpdmUgcHJvZ3MgaXMgcmVwbGFjZWQgd2l0aCBu
ZXcgb25lDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvbGQgaXMgZG91
YmxlIGZyZWVkDQo+IA0KPiBJdCBsb29rcyBsaWtlIGl0IGNhbiBiZSByZXByb2R1Y2VkIHdpdGhv
dXQgYW55IHNvY2tldHMuDQoNCkkgc2VlLg0KRG9lcyBpdCBtZWFuIHRoYXQgY3NzX2Zvcl9lYWNo
X2Rlc2NlbmRhbnQgd2Fsa3MgZHlpbmcgY2dyb3VwcyA/DQpJIGd1ZXNzIHRoZSBmaXggdGhlbiBp
cyB0byBhdm9pZCB3YWxraW5nIHRoZW0gaW4gdXBkYXRlX2VmZmVjdGl2ZV9wcm9ncyA/DQoNCg==
