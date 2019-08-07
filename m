Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0077384405
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 07:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfHGFwD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 01:52:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39178 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbfHGFwD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Aug 2019 01:52:03 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x775nO0S031626;
        Tue, 6 Aug 2019 22:51:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5vFOtRdp1wOwUty7RF65lPBZSDdXU36rlIgh8B3fgmU=;
 b=cX6VOPnTU0bRaRsoNY9RjQzYk/tdVCED9Xu8sFLzWTXVsl68dGjvylpx6KWOSSC66Dde
 9QBmvVpo9Nx4ILohZ6dblCPkErV3m8qfwd5Uj/EA7mbSgGAekZYyleI0OWmAo9RMY/Rk
 zxqLbruNZuUMS5vHA697mwNeXMMTTOexGXg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u7degaaag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 06 Aug 2019 22:51:58 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 6 Aug 2019 22:51:51 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 6 Aug 2019 22:51:50 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 6 Aug 2019 22:51:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVgcg3n6hd5xl5o8mCusTtWSelMFwhDFjFYG/UyjGBHdjIJeIyNNHU03jRLBuOyIp+Vid+QiAWZvQhgDNwKGYnjfJY0GzE68chuKFoWZlW+4q36nOmDiTJIYHHrmqXbTc3mb6v8kydYR+aOyMzOvbShNvQNwOwHPXc8u5yVmRGELQKLJR7+Bn2fW2Q5MBW6f8oEL6vkue+lYegE1Jg8/HFUQVCw2MFoLActl4ZWL+tgIkcBfYrNKPEH6TyFfgpy9ornOJwOwc/yFyr3cDmFHwO4pFAmM4IydJg8yY+2ob5GAuz28KNZmMg3aaMIRaTd/EPshYkQNB2FK7HdiQqP7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vFOtRdp1wOwUty7RF65lPBZSDdXU36rlIgh8B3fgmU=;
 b=HrDWF4HbxgRRh7wK88exsOF30W3fU4irfPFPFKZYwsmoDjMtzCN2CaSPKIuj4wdWcSEVzb1qp7xEasFMGaI2VKn9nU89zcLLdeWxSXVr35OP4LR16RNjqXHlFiZg9HTdfRaGahqGtW/DqX9/T6MOQGgrdMKErDQVFTizRcJ8wcdEva3q7qJ5XTs1EwpwbR2TezXpxjMKXQ8w5PoiIMXz5n+23iLiODTUIQ1wdx/4i9dW+vpqx7VA5je6kYqCp44lZOghadLoMsnaI5JKRpghELWwSqzLPe1shJ9dDN3+HGhGlJssuzoK8ftsCCdHNjYSAElShOgvjULnzfnjfgcmiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vFOtRdp1wOwUty7RF65lPBZSDdXU36rlIgh8B3fgmU=;
 b=VUo8xwh0Df/zTwEdtUCBe/0rl97QmybqrnERIvGezBpjVPnTdLphj+bkzw1PAYyBBcBV9aOaCIkwWVFTxCttSyhN3+pHM6phVNxFBigwrhiuLUFhWKIukpPw1iolB06OYQrL6TMazsCrSfCHbyNNVFtgNrU21zsyJw47AM/37WM=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2439.namprd15.prod.outlook.com (52.135.198.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Wed, 7 Aug 2019 05:51:49 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::e499:ecba:ec04:abac]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::e499:ecba:ec04:abac%5]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 05:51:49 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Daniel Xu <dxu@dxuuu.xyz>, Song Liu <songliubraving@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 1/3] tracing/kprobe: Add PERF_EVENT_IOC_QUERY_KPROBE ioctl
Thread-Topic: [PATCH 1/3] tracing/kprobe: Add PERF_EVENT_IOC_QUERY_KPROBE
 ioctl
Thread-Index: AQHVTLCaA23KAPLzH0qY+4wWGfc8J6bvLwEA
Date:   Wed, 7 Aug 2019 05:51:49 +0000
Message-ID: <f4a1ca0c-3fa1-5a20-2f41-133dc2ec1445@fb.com>
References: <20190806234131.5655-1-dxu@dxuuu.xyz>
In-Reply-To: <20190806234131.5655-1-dxu@dxuuu.xyz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:300:4b::29) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1dec]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91dc7bc2-33f0-4441-5a36-08d71afb56b9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2439;
x-ms-traffictypediagnostic: BYAPR15MB2439:
x-microsoft-antispam-prvs: <BYAPR15MB243977C8D7BE4BCB47865FE5D3D40@BYAPR15MB2439.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39860400002)(346002)(136003)(199004)(189003)(81166006)(31686004)(6486002)(6436002)(11346002)(8676002)(478600001)(256004)(66946007)(7736002)(64756008)(8936002)(6512007)(71200400001)(53936002)(5024004)(305945005)(71190400001)(14444005)(14454004)(66476007)(81156014)(66556008)(476003)(66446008)(36756003)(186003)(25786009)(229853002)(110136005)(54906003)(5660300002)(316002)(486006)(2906002)(53546011)(6506007)(76176011)(99286004)(46003)(6246003)(2616005)(102836004)(6116002)(446003)(52116002)(86362001)(6636002)(386003)(4326008)(68736007)(31696002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2439;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ge01okSbfSEsPSdA2rg+51qSSFej/rUZXEqfPLxkBZfqdaTdck8ZPJp7A+BuCWxX8Dtrat95/uy1OeD5lqbonXTAfoOlgKm23de46NaUJrRwxaqVrOw9+1m7h0ud7GXMG24j0FPecPTcK1lfCduhOlAVO0qJmzi0V/nWfusxgoKhWY1Ov24h2vj+vhBJxm11KW7mCwA0k2jTmde0mTRtYv6AgOlxSR80bd3w8fVAaeKbzJLt3909n24375KyHm7tlU5+GkWOd79NeS5+d3HrPcXcQJUgdgdzyGYhCN9bjFMIkEDRofPA59lV2tF9W/kPmTVJ8O7H5MNz2Ev3IV0V5zdL7nfBdAm46P4DCV9Gzx7aprZNp2SPpLE23VqBUyIZpxZADKuPg5JLZ7IJ8oybkDMzfffZYjVY8vkxQ21FSg4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C1B9FF8DED7294A94AE4F0E59469728@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 91dc7bc2-33f0-4441-5a36-08d71afb56b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 05:51:49.1924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yhs@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2439
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070063
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDgvNi8xOSA0OjQxIFBNLCBEYW5pZWwgWHUgd3JvdGU6DQo+IEl0J3MgdXNlZnVsIHRv
IGtub3cga3Byb2JlJ3Mgbm1pc3NlZCBhbmQgbmhpdCBzdGF0cy4gRm9yIGV4YW1wbGUgd2l0aA0K
PiB0cmFjaW5nIHRvb2xzLCBpdCdzIGltcG9ydGFudCB0byBrbm93IHdoZW4gZXZlbnRzIG1heSBo
YXZlIGJlZW4gbG9zdC4NCj4gVGhlcmUgaXMgY3VycmVudGx5IG5vIHdheSB0byBnZXQgdGhhdCBp
bmZvcm1hdGlvbiBmcm9tIHRoZSBwZXJmIEFQSS4NCj4gVGhpcyBwYXRjaCBhZGRzIGEgbmV3IGlv
Y3RsIHRoYXQgbGV0cyB1c2VycyBxdWVyeSB0aGlzIGluZm9ybWF0aW9uLg0KPiAtLS0NCj4gICBp
bmNsdWRlL2xpbnV4L3RyYWNlX2V2ZW50cy5oICAgIHwgIDYgKysrKysrDQo+ICAgaW5jbHVkZS91
YXBpL2xpbnV4L3BlcmZfZXZlbnQuaCB8IDIzICsrKysrKysrKysrKysrKysrKysrKysrDQo+ICAg
a2VybmVsL2V2ZW50cy9jb3JlLmMgICAgICAgICAgICB8IDExICsrKysrKysrKysrDQo+ICAga2Vy
bmVsL3RyYWNlL3RyYWNlX2twcm9iZS5jICAgICB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gICA0IGZpbGVzIGNoYW5nZWQsIDY1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L3RyYWNlX2V2ZW50cy5oIGIvaW5jbHVkZS9saW51eC90cmFjZV9l
dmVudHMuaA0KPiBpbmRleCA1MTUwNDM2NzgzZTguLjI4ZmFmMTE1ZTBiOCAxMDA2NDQNCj4gLS0t
IGEvaW5jbHVkZS9saW51eC90cmFjZV9ldmVudHMuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3Ry
YWNlX2V2ZW50cy5oDQo+IEBAIC01ODYsNiArNTg2LDEyIEBAIGV4dGVybiBpbnQgYnBmX2dldF9r
cHJvYmVfaW5mbyhjb25zdCBzdHJ1Y3QgcGVyZl9ldmVudCAqZXZlbnQsDQo+ICAgCQkJICAgICAg
IHUzMiAqZmRfdHlwZSwgY29uc3QgY2hhciAqKnN5bWJvbCwNCj4gICAJCQkgICAgICAgdTY0ICpw
cm9iZV9vZmZzZXQsIHU2NCAqcHJvYmVfYWRkciwNCj4gICAJCQkgICAgICAgYm9vbCBwZXJmX3R5
cGVfdHJhY2Vwb2ludCk7DQo+ICtleHRlcm4gaW50IHBlcmZfZXZlbnRfcXVlcnlfa3Byb2JlKHN0
cnVjdCBwZXJmX2V2ZW50ICpldmVudCwgdm9pZCBfX3VzZXIgKmluZm8pOw0KPiArI2Vsc2UNCj4g
K2ludCBwZXJmX2V2ZW50X3F1ZXJ5X2twcm9iZShzdHJ1Y3QgcGVyZl9ldmVudCAqZXZlbnQsIHZv
aWQgX191c2VyICppbmZvKQ0KPiArew0KPiArCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gK30NCj4g
ICAjZW5kaWYNCj4gICAjaWZkZWYgQ09ORklHX1VQUk9CRV9FVkVOVFMNCj4gICBleHRlcm4gaW50
ICBwZXJmX3Vwcm9iZV9pbml0KHN0cnVjdCBwZXJmX2V2ZW50ICpldmVudCwNCj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvdWFwaS9saW51eC9wZXJmX2V2ZW50LmggYi9pbmNsdWRlL3VhcGkvbGludXgv
cGVyZl9ldmVudC5oDQo+IGluZGV4IDcxOThkZGQwYzZiMS4uNGE1ZTE4NjA2YmFmIDEwMDY0NA0K
PiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvcGVyZl9ldmVudC5oDQo+ICsrKyBiL2luY2x1ZGUv
dWFwaS9saW51eC9wZXJmX2V2ZW50LmgNCj4gQEAgLTQ0Nyw2ICs0NDcsMjggQEAgc3RydWN0IHBl
cmZfZXZlbnRfcXVlcnlfYnBmIHsNCj4gICAJX191MzIJaWRzWzBdOw0KPiAgIH07DQo+ICAgDQo+
ICsvKg0KPiArICogU3RydWN0dXJlIHVzZWQgYnkgYmVsb3cgUEVSRl9FVkVOVF9JT0NfUVVFUllf
S1BST0UgY29tbWFuZA0KDQp0eXBvIFBFUkZfRVZFTlRfSU9DX1FVRVJZX0tQUk9FID0+IFBFUkZf
RVZFTlRfSU9DX1FVRVJZX0tQUk9CRQ0KDQo+ICsgKiB0byBxdWVyeSBpbmZvcm1hdGlvbiBhYm91
dCB0aGUga3Byb2JlIGF0dGFjaGVkIHRvIHRoZSBwZXJmDQo+ICsgKiBldmVudC4NCj4gKyAqLw0K
PiArc3RydWN0IHBlcmZfZXZlbnRfcXVlcnlfa3Byb2JlIHsNCj4gKyAgICAgICAvKg0KPiArICAg
ICAgICAqIFNpemUgb2Ygc3RydWN0dXJlIGZvciBmb3J3YXJkL2JhY2t3YXJkIGNvbXBhdGliaWxp
dHkNCj4gKyAgICAgICAgKi8NCj4gKyAgICAgICBfX3UzMiAgIHNpemU7DQoNClNpbmNlIHRoaXMg
aXMgcGVyZl9ldmVudCBVQVBJIGNoYW5nZSwgY291bGQgeW91IGNjIHRvDQpQZXRlciBaaWpsc3Ry
YSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+IGFzIHdlbGw/DQoNCldlIGhhdmUgMzIgYml0IGhvbGUg
aGVyZS4gRm9yIFVBUEksIGl0IHdvdWxkIGJlIGJlc3QgdG8gcmVtb3ZlDQp0aGUgaG9sZSBvciBt
YWtlIGl0IGV4cGxpY2l0LiBTbyBpbiB0aGlzIGNhc2UsIG1heWJlIHNvbWV0aGluZyBsaWtlDQog
ICAgICAgICAgIF9fdTMyICAgOjMyOw0KDQpBbHNvLCB3aGF0IGlzIGluIHlvdXIgbWluZCBmb3Ig
cG90ZW50aWFsIGZ1dHVyZSBleHRlbnNpb24/DQoNCj4gKyAgICAgICAvKg0KPiArICAgICAgICAq
IFNldCBieSB0aGUga2VybmVsIHRvIGluZGljYXRlIG51bWJlciBvZiB0aW1lcyB0aGlzIGtwcm9i
ZQ0KPiArICAgICAgICAqIHdhcyB0ZW1wb3JhcmlseSBkaXNhYmxlZA0KPiArICAgICAgICAqLw0K
PiArICAgICAgIF9fdTY0ICAgbm1pc3NlZDsNCj4gKyAgICAgICAvKg0KPiArICAgICAgICAqIFNl
dCBieSB0aGUga2VybmVsIHRvIGluZGljYXRlIG51bWJlciBvZiB0aW1lcyB0aGlzIGtwcm9iZQ0K
PiArICAgICAgICAqIHdhcyBoaXQNCj4gKyAgICAgICAgKi8NCj4gKyAgICAgICBfX3U2NCAgIG5o
aXQ7DQo+ICt9Ow0KPiArDQo+ICAgLyoNCj4gICAgKiBJb2N0bHMgdGhhdCBjYW4gYmUgZG9uZSBv
biBhIHBlcmYgZXZlbnQgZmQ6DQo+ICAgICovDQo+IEBAIC00NjIsNiArNDg0LDcgQEAgc3RydWN0
IHBlcmZfZXZlbnRfcXVlcnlfYnBmIHsNCj4gICAjZGVmaW5lIFBFUkZfRVZFTlRfSU9DX1BBVVNF
X09VVFBVVAkJX0lPVygnJCcsIDksIF9fdTMyKQ0KPiAgICNkZWZpbmUgUEVSRl9FVkVOVF9JT0Nf
UVVFUllfQlBGCQlfSU9XUignJCcsIDEwLCBzdHJ1Y3QgcGVyZl9ldmVudF9xdWVyeV9icGYgKikN
Cj4gICAjZGVmaW5lIFBFUkZfRVZFTlRfSU9DX01PRElGWV9BVFRSSUJVVEVTCV9JT1coJyQnLCAx
MSwgc3RydWN0IHBlcmZfZXZlbnRfYXR0ciAqKQ0KPiArI2RlZmluZSBQRVJGX0VWRU5UX0lPQ19R
VUVSWV9LUFJPQkUJCV9JT1dSKCckJywgMTIsIHN0cnVjdCBwZXJmX2V2ZW50X3F1ZXJ5X2twcm9i
ZSAqKQ0KPiAgIA0KPiAgIGVudW0gcGVyZl9ldmVudF9pb2NfZmxhZ3Mgew0KPiAgIAlQRVJGX0lP
Q19GTEFHX0dST1VQCQk9IDFVIDw8IDAsDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvZXZlbnRzL2Nv
cmUuYyBiL2tlcm5lbC9ldmVudHMvY29yZS5jDQo+IGluZGV4IDAyNmExNDU0MWEzOC4uZDYxYzNh
YzVkYTRmIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvZXZlbnRzL2NvcmUuYw0KPiArKysgYi9rZXJu
ZWwvZXZlbnRzL2NvcmUuYw0KPiBAQCAtNTA2MSw2ICs1MDYxLDEwIEBAIHN0YXRpYyBpbnQgcGVy
Zl9ldmVudF9zZXRfYnBmX3Byb2coc3RydWN0IHBlcmZfZXZlbnQgKmV2ZW50LCB1MzIgcHJvZ19m
ZCk7DQo+ICAgc3RhdGljIGludCBwZXJmX2NvcHlfYXR0cihzdHJ1Y3QgcGVyZl9ldmVudF9hdHRy
IF9fdXNlciAqdWF0dHIsDQo+ICAgCQkJICBzdHJ1Y3QgcGVyZl9ldmVudF9hdHRyICphdHRyKTsN
Cj4gICANCj4gKyNpZmRlZiBDT05GSUdfS1BST0JFX0VWRU5UUw0KPiArc3RhdGljIHN0cnVjdCBw
bXUgcGVyZl9rcHJvYmU7DQo+ICsjZW5kaWYgLyogQ09ORklHX0tQUk9CRV9FVkVOVFMgKi8NCj4g
Kw0KPiAgIHN0YXRpYyBsb25nIF9wZXJmX2lvY3RsKHN0cnVjdCBwZXJmX2V2ZW50ICpldmVudCwg
dW5zaWduZWQgaW50IGNtZCwgdW5zaWduZWQgbG9uZyBhcmcpDQo+ICAgew0KPiAgIAl2b2lkICgq
ZnVuYykoc3RydWN0IHBlcmZfZXZlbnQgKik7DQo+IEBAIC01MTQzLDYgKzUxNDcsMTMgQEAgc3Rh
dGljIGxvbmcgX3BlcmZfaW9jdGwoc3RydWN0IHBlcmZfZXZlbnQgKmV2ZW50LCB1bnNpZ25lZCBp
bnQgY21kLCB1bnNpZ25lZCBsb24NCj4gICANCj4gICAJCXJldHVybiBwZXJmX2V2ZW50X21vZGlm
eV9hdHRyKGV2ZW50LCAgJm5ld19hdHRyKTsNCj4gICAJfQ0KPiArI2lmZGVmIENPTkZJR19LUFJP
QkVfRVZFTlRTDQo+ICsgICAgICAgIGNhc2UgUEVSRl9FVkVOVF9JT0NfUVVFUllfS1BST0JFOg0K
PiArCQlpZiAoZXZlbnQtPmF0dHIudHlwZSAhPSBwZXJmX2twcm9iZS50eXBlKQ0KPiArCQkJcmV0
dXJuIC1FSU5WQUw7DQoNClRoaXMgd2lsbCBvbmx5IGhhbmRsZSBGRCBiYXNlZCBrcHJvYmUuIElm
IHRoaXMgaXMgdGhlIGludGVudGlvbiwgYmVzdCB0bw0KY2xlYXJseSBzdGF0ZSBpdCBpbiB0aGUg
Y292ZXIgbGV0dGVyIGFzIHdlbGwuDQoNCkkgc3VzcGVjdCB0aGlzIHNob3VsZCBhbHNvIHdvcmsg
Zm9yIGRlYnVnZnMgdHJhY2UgZXZlbnQgYmFzZWQga3Byb2JlLA0KYnV0IEkgZGlkIG5vdCB2ZXJp
ZnkgaXQgdGhyb3VnaCBjb2Rlcy4NCg0KPiArDQo+ICsgICAgICAgICAgICAgICAgcmV0dXJuIHBl
cmZfZXZlbnRfcXVlcnlfa3Byb2JlKGV2ZW50LCAodm9pZCBfX3VzZXIgKilhcmcpOw0KPiArI2Vu
ZGlmIC8qIENPTkZJR19LUFJPQkVfRVZFTlRTICovDQo+ICAgCWRlZmF1bHQ6DQo+ICAgCQlyZXR1
cm4gLUVOT1RUWTsNCj4gICAJfQ0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3RyYWNlL3RyYWNlX2tw
cm9iZS5jIGIva2VybmVsL3RyYWNlL3RyYWNlX2twcm9iZS5jDQo+IGluZGV4IDlkNDgzYWQ5YmI2
Yy4uNTQ0OTE4MmYzMDU2IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvdHJhY2UvdHJhY2Vfa3Byb2Jl
LmMNCj4gKysrIGIva2VybmVsL3RyYWNlL3RyYWNlX2twcm9iZS5jDQo+IEBAIC0xOTYsNiArMTk2
LDMxIEBAIGJvb2wgdHJhY2Vfa3Byb2JlX2Vycm9yX2luamVjdGFibGUoc3RydWN0IHRyYWNlX2V2
ZW50X2NhbGwgKmNhbGwpDQo+ICAgCXJldHVybiB3aXRoaW5fZXJyb3JfaW5qZWN0aW9uX2xpc3Qo
dHJhY2Vfa3Byb2JlX2FkZHJlc3ModGspKTsNCj4gICB9DQo+ICAgDQo+ICtpbnQgcGVyZl9ldmVu
dF9xdWVyeV9rcHJvYmUoc3RydWN0IHBlcmZfZXZlbnQgKmV2ZW50LCB2b2lkIF9fdXNlciAqaW5m
bykNCj4gK3sNCj4gKwlzdHJ1Y3QgcGVyZl9ldmVudF9xdWVyeV9rcHJvYmUgX191c2VyICp1cXVl
cnkgPSBpbmZvOw0KPiArCXN0cnVjdCBwZXJmX2V2ZW50X3F1ZXJ5X2twcm9iZSBxdWVyeSA9IHt9
Ow0KPiArCXN0cnVjdCB0cmFjZV9ldmVudF9jYWxsICpjYWxsID0gZXZlbnQtPnRwX2V2ZW50Ow0K
PiArCXN0cnVjdCB0cmFjZV9rcHJvYmUgKnRrID0gKHN0cnVjdCB0cmFjZV9rcHJvYmUgKiljYWxs
LT5kYXRhOw0KPiArCXU2NCBubWlzc2VkLCBuaGl0Ow0KPiArDQo+ICsJaWYgKCFjYXBhYmxlKENB
UF9TWVNfQURNSU4pKQ0KPiArCQlyZXR1cm4gLUVQRVJNOw0KPiArCWlmIChjb3B5X2Zyb21fdXNl
cigmcXVlcnksIHVxdWVyeSwgc2l6ZW9mKHF1ZXJ5KSkpDQo+ICsJCXJldHVybiAtRUZBVUxUOw0K
PiArCWlmIChxdWVyeS5zaXplICE9IHNpemVvZihxdWVyeSkpDQo+ICsJCXJldHVybiAtRUlOVkFM
Ow0KPiArDQo+ICsJbmhpdCA9IHRyYWNlX2twcm9iZV9uaGl0KHRrKTsNCj4gKwlubWlzc2VkID0g
dGstPnJwLmtwLm5taXNzZWQ7DQo+ICsNCj4gKwlpZiAoY29weV90b191c2VyKCZ1cXVlcnktPm5t
aXNzZWQsICZubWlzc2VkLCBzaXplb2Yobm1pc3NlZCkpIHx8DQo+ICsJICAgIGNvcHlfdG9fdXNl
cigmdXF1ZXJ5LT5uaGl0LCAmbmhpdCwgc2l6ZW9mKG5oaXQpKSkNCj4gKwkJcmV0dXJuIC1FRkFV
TFQ7DQoNCllvdSBjYW4gdXNlIHB1dF91c2VyKCkgaW5zdGVhZCBvZiBjb3B5X3RvX3VzZXIoKSB0
byBzaW1wbGlmeSB0aGUgY29kZS4NCg0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4g
ICBzdGF0aWMgaW50IHJlZ2lzdGVyX2twcm9iZV9ldmVudChzdHJ1Y3QgdHJhY2Vfa3Byb2JlICp0
ayk7DQo+ICAgc3RhdGljIGludCB1bnJlZ2lzdGVyX2twcm9iZV9ldmVudChzdHJ1Y3QgdHJhY2Vf
a3Byb2JlICp0ayk7DQo+ICAgDQo+IA0K
