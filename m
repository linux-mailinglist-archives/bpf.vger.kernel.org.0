Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D37098F53C
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2019 21:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbfHOT7b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Aug 2019 15:59:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25354 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727814AbfHOT7a (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Aug 2019 15:59:30 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x7FJufpA030049;
        Thu, 15 Aug 2019 12:59:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=N9SEXJfrEPN/cpEktDKvmGP52+GAc8WXVYNkqr2+np8=;
 b=bp0wb84dXizLhnzDK6L5uRWqR/8zgUAppyrHvThsLbeho4V4/CZzgEGFPpLFsD2aKZdk
 /uTyMnUeCIYqTU8aHjXKHCq9QnezfIMnyr3g3RVVbWgPismXOQkv+1KlED1/j1yiMlPg
 eHmAv3fk85dkmxAkRfGH2xQs4ew/LJIVj7s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2udc3a8g82-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 15 Aug 2019 12:59:00 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 15 Aug 2019 12:58:59 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 15 Aug 2019 12:58:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSCgZRPoC+f7FTKzKelsRvJAJ4sMvSRlwC0y/sPm+SnvO9n+vlzugKUOFP27i4WbgyksU3O3C5cpdzNyKFfYza1ZvyaSPaarc9+0hhWopsGMUPSW5rnb42m3heZ7XErMsqyUJGfi5cLI6xPqU1Hio79iWVPp3jScXWvNnCe3GQ0ddr464iITVN7CAkwXhzNvhe4Hm+/nH+K7MpjK2fd/gsQknwW3FUL1f5q0z9tu958QtQmdYK2tJ9bH+u0s0GhwtIvGZ3o9x1/vx1S8ClTFR0QBUbVndTud3J9l+0SYki6m0PpHeiMNdBwEllksC9H2dgdYiTpERojcHxnhUsQ36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9SEXJfrEPN/cpEktDKvmGP52+GAc8WXVYNkqr2+np8=;
 b=Nx3XgeGjA2mz1ARfRHG1GYbVzUFeMHtzSjboO7D4HhpEOahSTYh59+f9GOfOACnd41FoeBJHpfL4LQ8Li4L3KEyXhT4LO+GOe9kkH3qQRJyy9CXnVdlYAYSBvPIzkFpwgVa87qQFpAQ4AIv6XADePVoWq6lSS09tftc/xQZFGKiiiL68zX/hei4xLOX2rYN+6bMImRxwatOdooUvBLwhTClvoKugpMTfPrWyO6UrvJxPUhru0pj3qfJ4JNpB+vG3d5KUU5ItsXKQXnibvhrswC22uiwdHU2O/fRwOUXng379mpX6YrWLaC2qUwyqHUx4fddz9bw8kHBS24gaU82QGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9SEXJfrEPN/cpEktDKvmGP52+GAc8WXVYNkqr2+np8=;
 b=ADfq+6rSNVllTjT5cJn25CO/ihojTH5eTwbeOUBJVXmxlpV1+dc2OGaPEjVCPGzYkOFd4ywDz6wV6lIEZyH5TO6qBuc4i4X/s2Q5NivG48WWYRDGs5RGo19BsAN6DNYmec9pTm+IJjTUSx4xXCUrsL9aL3EqRbXB2SfFmXj1mww=
Received: from CY4PR15MB1366.namprd15.prod.outlook.com (10.172.157.148) by
 CY4PR15MB1511.namprd15.prod.outlook.com (10.172.161.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Thu, 15 Aug 2019 19:58:58 +0000
Received: from CY4PR15MB1366.namprd15.prod.outlook.com
 ([fe80::6c5f:cfef:6a46:d2f1]) by CY4PR15MB1366.namprd15.prod.outlook.com
 ([fe80::6c5f:cfef:6a46:d2f1%9]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 19:58:58 +0000
From:   Andrey Ignatov <rdna@fb.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf] bpf: fix accessing bpf_sysctl.file_pos on s390
Thread-Topic: [PATCH bpf] bpf: fix accessing bpf_sysctl.file_pos on s390
Thread-Index: AQHVU6Pg3te8c0S7PE+oXZhbnTVdFA==
Date:   Thu, 15 Aug 2019 19:58:58 +0000
Message-ID: <20190815195856.GA45122@rdna-mbp>
References: <20190815112044.38420-1-iii@linux.ibm.com>
In-Reply-To: <20190815112044.38420-1-iii@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR07CA0052.namprd07.prod.outlook.com (2603:10b6:100::20)
 To CY4PR15MB1366.namprd15.prod.outlook.com (2603:10b6:903:f7::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:2a82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfe65e33-4d71-49a0-12d9-08d721bb0293
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR15MB1511;
x-ms-traffictypediagnostic: CY4PR15MB1511:
x-microsoft-antispam-prvs: <CY4PR15MB15117AB6120781144021D859A8AC0@CY4PR15MB1511.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(136003)(396003)(346002)(366004)(39860400002)(199004)(189003)(66476007)(66556008)(9686003)(6436002)(486006)(66446008)(66946007)(53936002)(6116002)(6512007)(476003)(8936002)(76176011)(102836004)(386003)(316002)(6506007)(186003)(81156014)(81166006)(64756008)(478600001)(25786009)(33656002)(99286004)(14444005)(256004)(5024004)(71200400001)(305945005)(46003)(33716001)(6246003)(1076003)(14454004)(6916009)(71190400001)(2906002)(446003)(52116002)(11346002)(54906003)(5660300002)(86362001)(7736002)(229853002)(6486002)(8676002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1511;H:CY4PR15MB1366.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WKXVwYTAU1DbyF7ebfVa3MkRlGm7B3IfpAy/o5h40lfGRF3erv6PynUAtcZo5WfeHvkgsLX90250zzAKMY/UrDhPlTJBNUF0kukUXqMXbvI1wACd91j0TZRGNL2DbH41CCgRpf1W0pRkvxpWBh8lPa5gvBOgzPrbSDenFeJjKQk507RqvYEMsWfrnxkFg8yo54pLiM2ip9Dm4R8H2bO7iKIMWZXHI/ReviGMEDK6PJV0frESgGipa1ljQepIcpEuzNLZcJC4pWTgNw0IOICobBiSwiwQw7kHuPPVXXhYSl6Do1Dqm7XI0ZT07Xu+uHWVSIoLQp5SkwEjAmWhXG5PF5+RToXkf0rTPusAWSTBntOrfkW+HjP/IBgtMfyndMoMEArIIwz4iSk4SdTsTTiSMVuAuDLU4aV+trtSlsFKqHE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <34A2BA763447E240948D4F2DA97A9338@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe65e33-4d71-49a0-12d9-08d721bb0293
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 19:58:58.5546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ves9uy6Hw/n4G2b75kmZVC4Bmx8l/0P6psBaCwHzWA4ZIZO86YC9bWRBugJ0NRu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1511
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908150188
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SWx5YSBMZW9zaGtldmljaCA8aWlpQGxpbnV4LmlibS5jb20+IFtUaHUsIDIwMTktMDgtMTUgMTE6
MjAgLTA3MDBdOg0KPiAiY3R4OmZpbGVfcG9zIHN5c2N0bDpyZWFkIHdyaXRlIG9rIiBmYWlscyBv
biBzMzkwIHdpdGggIlJlYWQgdmFsdWUgICE9DQo+IG51eCIuIFRoaXMgaXMgYmVjYXVzZSB2ZXJp
ZmllciByZXdyaXRlcyBhIGNvbXBsZXRlIDMyLWJpdA0KPiBicGZfc3lzY3RsLmZpbGVfcG9zIHVw
ZGF0ZSB0byBhIHBhcnRpYWwgdXBkYXRlIG9mIHRoZSBmaXJzdCAzMiBiaXRzIG9mDQo+IDY0LWJp
dCAqYnBmX3N5c2N0bF9rZXJuLnBwb3MsIHdoaWNoIGlzIG5vdCBjb3JyZWN0IG9uIGJpZy1lbmRp
YW4NCj4gc3lzdGVtcy4NCj4gDQo+IEZpeCBieSB1c2luZyBhbiBvZmZzZXQgb24gYmlnLWVuZGlh
biBzeXN0ZW1zLg0KPiANCj4gRGl0dG8gZm9yIGJwZl9zeXNjdGwuZmlsZV9wb3MgcmVhZHMuIEN1
cnJlbnRseSB0aGUgdGVzdCBkb2VzIG5vdCBkZXRlY3QNCj4gYSBwcm9ibGVtIHRoZXJlLCBzaW5j
ZSBpdCBleHBlY3RzIHRvIHNlZSAwLCB3aGljaCBpdCBnZXRzIHdpdGggaGlnaA0KPiBwcm9iYWJp
bGl0eSBpbiBlcnJvciBjYXNlcywgc28gY2hhbmdlIGl0IHRvIHNlZWsgdG8gb2Zmc2V0IDMgYW5k
IGV4cGVjdA0KPiAzIGluIGJwZl9zeXNjdGwuZmlsZV9wb3MuDQo+IA0KPiBGaXhlczogZTE1NTBi
ZmUwZGU0ICgiYnBmOiBBZGQgZmlsZV9wb3MgZmllbGQgdG8gYnBmX3N5c2N0bCBjdHgiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBJbHlhIExlb3Noa2V2aWNoIDxpaWlAbGludXguaWJtLmNvbT4NCg0KUmln
aHQsIEkgbWlzc2VkIHRoaXMuIFRoYW5rcyBmb3IgZml4aW5nIQ0KDQpBY2tlZC1ieTogQW5kcmV5
IElnbmF0b3YgPHJkbmFAZmIuY29tPg0KDQo+IC0tLQ0KPiAgaW5jbHVkZS9saW51eC9maWx0ZXIu
aCAgICAgICAgICAgICAgICAgICAgfCAxMCArKysrKysrKysrDQo+ICBrZXJuZWwvYnBmL2Nncm91
cC5jICAgICAgICAgICAgICAgICAgICAgICB8ICA5ICsrKysrKystLQ0KPiAgdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYnBmL3Rlc3Rfc3lzY3RsLmMgfCAgOSArKysrKysrKy0NCj4gIDMgZmlsZXMg
Y2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L2ZpbHRlci5oIGIvaW5jbHVkZS9saW51eC9maWx0ZXIuaA0KPiBp
bmRleCA5MmM2ZTMxZmIwMDguLjk0ZTgxYzU2ZDgxYyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9s
aW51eC9maWx0ZXIuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2ZpbHRlci5oDQo+IEBAIC03NjAs
NiArNzYwLDE2IEBAIGJwZl9jdHhfbmFycm93X2xvYWRfc2hpZnQodTMyIG9mZiwgdTMyIHNpemUs
IHUzMiBzaXplX2RlZmF1bHQpDQo+ICAjZW5kaWYNCj4gIH0NCj4gIA0KPiArc3RhdGljIGlubGlu
ZSBzMTYNCj4gK2JwZl9jdHhfbmFycm93X2FjY2Vzc19vZmZzZXQoc2l6ZV90IHZhcmlhYmxlX3Np
emUsIHNpemVfdCBhY2Nlc3Nfc2l6ZSkNCj4gK3sNCj4gKyNpZmRlZiBfX0xJVFRMRV9FTkRJQU4N
Cj4gKwlyZXR1cm4gMDsNCj4gKyNlbHNlDQo+ICsJcmV0dXJuIHZhcmlhYmxlX3NpemUgLSBhY2Nl
c3Nfc2l6ZTsNCj4gKyNlbmRpZg0KPiArfQ0KPiArDQo+ICAjZGVmaW5lIGJwZl9jdHhfd2lkZV9h
Y2Nlc3Nfb2sob2ZmLCBzaXplLCB0eXBlLCBmaWVsZCkJCQlcDQo+ICAJKHNpemUgPT0gc2l6ZW9m
KF9fdTY0KSAmJgkJCQkJXA0KPiAgCW9mZiA+PSBvZmZzZXRvZih0eXBlLCBmaWVsZCkgJiYJCQkJ
CVwNCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvY2dyb3VwLmMgYi9rZXJuZWwvYnBmL2Nncm91
cC5jDQo+IGluZGV4IDBhMDBlYWNhNmZhZS4uYjgzNWZiYjEzZWE4IDEwMDY0NA0KPiAtLS0gYS9r
ZXJuZWwvYnBmL2Nncm91cC5jDQo+ICsrKyBiL2tlcm5lbC9icGYvY2dyb3VwLmMNCj4gQEAgLTEz
NTYsNyArMTM1Niw5IEBAIHN0YXRpYyB1MzIgc3lzY3RsX2NvbnZlcnRfY3R4X2FjY2VzcyhlbnVt
IGJwZl9hY2Nlc3NfdHlwZSB0eXBlLA0KPiAgCQkJCXRyZWcsIHNpLT5kc3RfcmVnLA0KPiAgCQkJ
CW9mZnNldG9mKHN0cnVjdCBicGZfc3lzY3RsX2tlcm4sIHBwb3MpKTsNCj4gIAkJCSppbnNuKysg
PSBCUEZfU1RYX01FTSgNCj4gLQkJCQlCUEZfU0laRU9GKHUzMiksIHRyZWcsIHNpLT5zcmNfcmVn
LCAwKTsNCj4gKwkJCQlCUEZfU0laRU9GKHUzMiksIHRyZWcsIHNpLT5zcmNfcmVnLA0KPiArCQkJ
CWJwZl9jdHhfbmFycm93X2FjY2Vzc19vZmZzZXQoDQo+ICsJCQkJCXNpemVvZihsb2ZmX3QpLCBz
aXplb2YodTMyKSkpOw0KPiAgCQkJKmluc24rKyA9IEJQRl9MRFhfTUVNKA0KPiAgCQkJCUJQRl9E
VywgdHJlZywgc2ktPmRzdF9yZWcsDQo+ICAJCQkJb2Zmc2V0b2Yoc3RydWN0IGJwZl9zeXNjdGxf
a2VybiwgdG1wX3JlZykpOw0KPiBAQCAtMTM2Niw3ICsxMzY4LDEwIEBAIHN0YXRpYyB1MzIgc3lz
Y3RsX2NvbnZlcnRfY3R4X2FjY2VzcyhlbnVtIGJwZl9hY2Nlc3NfdHlwZSB0eXBlLA0KPiAgCQkJ
CXNpLT5kc3RfcmVnLCBzaS0+c3JjX3JlZywNCj4gIAkJCQlvZmZzZXRvZihzdHJ1Y3QgYnBmX3N5
c2N0bF9rZXJuLCBwcG9zKSk7DQo+ICAJCQkqaW5zbisrID0gQlBGX0xEWF9NRU0oDQo+IC0JCQkJ
QlBGX1NJWkUoc2ktPmNvZGUpLCBzaS0+ZHN0X3JlZywgc2ktPmRzdF9yZWcsIDApOw0KPiArCQkJ
CUJQRl9TSVpFKHNpLT5jb2RlKSwgc2ktPmRzdF9yZWcsIHNpLT5kc3RfcmVnLA0KPiArCQkJCWJw
Zl9jdHhfbmFycm93X2FjY2Vzc19vZmZzZXQoDQo+ICsJCQkJCXNpemVvZihsb2ZmX3QpLA0KPiAr
CQkJCQlicGZfc2l6ZV90b19ieXRlcyhCUEZfU0laRShzaS0+Y29kZSkpKSk7DQo+ICAJCX0NCj4g
IAkJKnRhcmdldF9zaXplID0gc2l6ZW9mKHUzMik7DQo+ICAJCWJyZWFrOw0KPiBkaWZmIC0tZ2l0
IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3Rfc3lzY3RsLmMgYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9zeXNjdGwuYw0KPiBpbmRleCBhM2JlYmQ3YzY4ZGQuLmFi
YzI2MjQ4YTdmMSAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rl
c3Rfc3lzY3RsLmMNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3Rfc3lz
Y3RsLmMNCj4gQEAgLTMxLDYgKzMxLDcgQEAgc3RydWN0IHN5c2N0bF90ZXN0IHsNCj4gIAllbnVt
IGJwZl9hdHRhY2hfdHlwZSBhdHRhY2hfdHlwZTsNCj4gIAljb25zdCBjaGFyICpzeXNjdGw7DQo+
ICAJaW50IG9wZW5fZmxhZ3M7DQo+ICsJaW50IHNlZWs7DQo+ICAJY29uc3QgY2hhciAqbmV3dmFs
Ow0KPiAgCWNvbnN0IGNoYXIgKm9sZHZhbDsNCj4gIAllbnVtIHsNCj4gQEAgLTEzOSw3ICsxNDAs
NyBAQCBzdGF0aWMgc3RydWN0IHN5c2N0bF90ZXN0IHRlc3RzW10gPSB7DQo+ICAJCQkvKiBJZiAo
ZmlsZV9wb3MgPT0gWCkgKi8NCj4gIAkJCUJQRl9MRFhfTUVNKEJQRl9XLCBCUEZfUkVHXzcsIEJQ
Rl9SRUdfMSwNCj4gIAkJCQkgICAgb2Zmc2V0b2Yoc3RydWN0IGJwZl9zeXNjdGwsIGZpbGVfcG9z
KSksDQo+IC0JCQlCUEZfSk1QX0lNTShCUEZfSk5FLCBCUEZfUkVHXzcsIDAsIDIpLA0KPiArCQkJ
QlBGX0pNUF9JTU0oQlBGX0pORSwgQlBGX1JFR183LCAzLCAyKSwNCj4gIA0KPiAgCQkJLyogcmV0
dXJuIEFMTE9XOyAqLw0KPiAgCQkJQlBGX01PVjY0X0lNTShCUEZfUkVHXzAsIDEpLA0KPiBAQCAt
MTUyLDYgKzE1Myw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc3lzY3RsX3Rlc3QgdGVzdHNbXSA9IHsNCj4g
IAkJLmF0dGFjaF90eXBlID0gQlBGX0NHUk9VUF9TWVNDVEwsDQo+ICAJCS5zeXNjdGwgPSAia2Vy
bmVsL29zdHlwZSIsDQo+ICAJCS5vcGVuX2ZsYWdzID0gT19SRE9OTFksDQo+ICsJCS5zZWVrID0g
MywNCj4gIAkJLnJlc3VsdCA9IFNVQ0NFU1MsDQo+ICAJfSwNCj4gIAl7DQo+IEBAIC0xNDQyLDYg
KzE0NDQsMTEgQEAgc3RhdGljIGludCBhY2Nlc3Nfc3lzY3RsKGNvbnN0IGNoYXIgKnN5c2N0bF9w
YXRoLA0KPiAgCWlmIChmZCA8IDApDQo+ICAJCXJldHVybiBmZDsNCj4gIA0KPiArCWlmICh0ZXN0
LT5zZWVrICYmIGxzZWVrKGZkLCB0ZXN0LT5zZWVrLCBTRUVLX1NFVCkgPT0gLTEpIHsNCj4gKwkJ
bG9nX2VycigibHNlZWsoJWQpIGZhaWxlZCIsIHRlc3QtPnNlZWspOw0KPiArCQlnb3RvIGVycjsN
Cj4gKwl9DQo+ICsNCj4gIAlpZiAodGVzdC0+b3Blbl9mbGFncyA9PSBPX1JET05MWSkgew0KPiAg
CQljaGFyIGJ1ZlsxMjhdOw0KPiAgDQoNCi0tIA0KQW5kcmV5IElnbmF0b3YNCg==
