Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2461059A6
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2019 19:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfKUSgo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Nov 2019 13:36:44 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27792 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726939AbfKUSgo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Nov 2019 13:36:44 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALIYf5R003377;
        Thu, 21 Nov 2019 10:36:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YX/uoI9tVQ24ukfluX3gKjf25KUlNBf/4xRhxnfXSWI=;
 b=njg9dd3Fk8xpXXGRB+GBOR7dVoxIybtRH6oe19TSCp0o/Ws9gh69/DDGpWWhzJ82aA6Y
 2BZ+1heU4MP8qr2eIWaNLTGIF72tI7oFIoKiaLZ1jIUncNaQHQ8MarDrwy7x6BFkBfcs
 zfpLc80lflcO9djqGWf4qnT/IKCOB2vhA88= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wdjuvfm0j-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Nov 2019 10:36:25 -0800
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 21 Nov 2019 10:36:25 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 21 Nov 2019 10:36:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhOVZIiBI8exSfLJS7raGnCMqN0TvbLUFhZgk3euTQssmmRrXI5dLVqhco9EavuZSSgC9ZTfMWaM7OGBHsgGCXCzXGyeBFplmfatpdyAEiJzy9YqhXpXYfB52MmrzcINwtYFh2HNR7LXm6BCvusB48HSGSwQPm9gRXA+akVUrfrD79LaU1Xs3K09sCaYrA+IwMW44863yMvmUguR5Iaf/+DBrSUdBdb6bSmmpXEVJDE1Yed0tFGQzs5IgZ/FVRNUE64WyICbG8dOtk8uMxrAnd43SS2jhQJnh6J5riYmU+s4LdHZWzR9jCMyNXwcxAbXwL3/Xh/UFUfn7Y1GRwXHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YX/uoI9tVQ24ukfluX3gKjf25KUlNBf/4xRhxnfXSWI=;
 b=US4owjjckShiwxRfJ9n+Dqb0S7IpiaWFZKhwKWJBOFfhB4eqRZ5LEdzZqHRl6b2a+YPNRxcx7F8ieCs6DwCNOodncQq2qnM24Zbb8L1Y6BdzCMTEIM/iTqTZS4xSIa8rE+Cih3JNcUyL8Il6fNHQ39wYS7iThQjXXJw3JaG+W7FLMs3tVPwEoLodPXqQj4bapt/G5fwfDShRUHxG0iVzrSgAdXbyzw30yLXjTJm9xLfpOy5GdjmLZ4NEkbb1JV1HCXGsmdRtbrQQusOBELDybIFXVe4wuuhrG2jb+k5R0p+RdSn+tEJ0bnDxPODwqLTEuQviJWYAx/cSWXk8YcEf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YX/uoI9tVQ24ukfluX3gKjf25KUlNBf/4xRhxnfXSWI=;
 b=i6vwDcPqWOAL60SrB6RUzCpGCdfgYIFXaRn4w+HjOTFY/0L2M8R8j5ViP51xz7yv1LEAFxxyTfAY40lwg35+E0eV/3E8SVfweB4r5SFmQbUcf7LoLGM5v1nMtdkSJ/UV8PZ1bIbOioFmiTjVrIPY7A5ab8ZjQ8p/jWrFnnPreyo=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYAPR15MB3494.namprd15.prod.outlook.com (20.179.59.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Thu, 21 Nov 2019 18:36:24 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::a9f8:a9c0:854c:d680]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::a9f8:a9c0:854c:d680%4]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 18:36:24 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Brian Vazquez <brianvv@google.com>,
        Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
CC:     Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 8/9] selftests/bpf: add batch ops testing for
 hmap and hmap_percpu
Thread-Topic: [PATCH v2 bpf-next 8/9] selftests/bpf: add batch ops testing for
 hmap and hmap_percpu
Thread-Index: AQHVnw/resvEjTgPbUGBOlXGvvOeZKeV9wIA
Date:   Thu, 21 Nov 2019 18:36:23 +0000
Message-ID: <9f80a432-9825-9a39-cc90-d1358e0fc40f@fb.com>
References: <20191119193036.92831-1-brianvv@google.com>
 <20191119193036.92831-9-brianvv@google.com>
In-Reply-To: <20191119193036.92831-9-brianvv@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0082.namprd04.prod.outlook.com
 (2603:10b6:102:1::50) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:b385]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4bc8226-f46f-4486-ae07-08d76eb1b60a
x-ms-traffictypediagnostic: BYAPR15MB3494:
x-microsoft-antispam-prvs: <BYAPR15MB3494397ABDE76869B81BAA23D34E0@BYAPR15MB3494.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:115;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(186003)(25786009)(66946007)(8676002)(6246003)(99286004)(4326008)(86362001)(6486002)(53546011)(6506007)(8936002)(54906003)(64756008)(386003)(14444005)(6116002)(110136005)(36756003)(66556008)(7416002)(71190400001)(446003)(11346002)(71200400001)(66446008)(2616005)(256004)(66476007)(316002)(81166006)(81156014)(2906002)(229853002)(6436002)(14454004)(7736002)(305945005)(102836004)(52116002)(478600001)(5660300002)(6512007)(31696002)(31686004)(76176011)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3494;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cHo6EJA9L1QgrdsdXcUTnv5hcNt5lyYtkK/XS9B271xWw9fuwDtWNo3wHwB1mvx3AsA2pQuC0VXY9wjIEVo/YtmvMDIjPwXj4xkYr7pF2WaDpo1fFXZrRKcIUuBQ4cQRQ3T8aW8n5/fJqahn6ZOre7aS03wJ9IwEHLCterRs+RteGwzSuv5RicNu2oJ5mrEbzWK0D7/3Lvkbhj129H+fKGM3ZZrqv2BPphO7ioYn+WHmXJvtmAVxoH4bVBD1eWCL01NrJKxImfFMxEsvP1L7/ruBNuMS3vkY0c/4MPj6EcGzXbBF6Jx0L8aorQCFzyH++0WSuqMfxN/xC74PWvlwVy2eQAGIsjp64EFZx9AjqmtYIHWNKm+x5OqemKgOvcg/iu8yl/dHAHWTdjDP2vcvB+hOLTg0ELVGJRdfVtQ18CGUNXGbqVp7P1o9kNgCGHfj
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5426A2EB4C6C2047BC1EE8664946A62F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bc8226-f46f-4486-ae07-08d76eb1b60a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 18:36:23.9953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xfjlqEpPS3dv4dqcSOGJkgan/gFZ0Fz1p82qujzARrk0aAz7VRn6ulz8uTgmRcKs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3494
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_05:2019-11-21,2019-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911210156
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDExLzE5LzE5IDExOjMwIEFNLCBCcmlhbiBWYXpxdWV6IHdyb3RlOg0KPiBGcm9tOiBZ
b25naG9uZyBTb25nIDx5aHNAZmIuY29tPg0KPiANCj4gVGVzdGVkIGJwZl9tYXBfbG9va3VwX2Fu
ZF9kZWxldGVfYmF0Y2goKSBhbmQgYnBmX21hcF91cGRhdGVfYmF0Y2goKQ0KPiBmdW5jdGlvbmFs
aXR5Lg0KPiAgICAkIC4vdGVzdF9tYXBzDQo+ICAgICAgLi4uDQo+ICAgICAgICB0ZXN0X2htYXBf
bG9va3VwX2FuZF9kZWxldGVfYmF0Y2g6UEFTUw0KPiAgICAgICAgdGVzdF9wY3B1X2htYXBfbG9v
a3VwX2FuZF9kZWxldGVfYmF0Y2g6UEFTUw0KPiAgICAgIC4uLg0KDQpNYXliZSB5b3UgY2FuIGFk
ZCBhbm90aGVyIHRlc3RzIGZvciBsb29rdXBfYmF0Y2goKSBhbmQgZGVsZXRlX2JhdGNoKCkNCnNv
IGFsbCBuZXcgQVBJcyBnZXQgdGVzdGVkPw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZb25naG9u
ZyBTb25nIDx5aHNAZmIuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBCcmlhbiBWYXpxdWV6IDxicmlh
bnZ2QGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgIC4uLi9tYXBfbG9va3VwX2FuZF9kZWxldGVfYmF0
Y2hfaHRhYi5jICAgICAgICB8IDI1NyArKysrKysrKysrKysrKysrKysNCj4gICAxIGZpbGUgY2hh
bmdlZCwgMjU3IGluc2VydGlvbnMoKykNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvYnBmL21hcF90ZXN0cy9tYXBfbG9va3VwX2FuZF9kZWxldGVfYmF0Y2hf
aHRhYi5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL21h
cF90ZXN0cy9tYXBfbG9va3VwX2FuZF9kZWxldGVfYmF0Y2hfaHRhYi5jIGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYnBmL21hcF90ZXN0cy9tYXBfbG9va3VwX2FuZF9kZWxldGVfYmF0Y2hfaHRh
Yi5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMDAuLjkzZTAy
NGNiODVjNjANCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9icGYvbWFwX3Rlc3RzL21hcF9sb29rdXBfYW5kX2RlbGV0ZV9iYXRjaF9odGFiLmMNCj4gQEAg
LTAsMCArMSwyNTcgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+
ICsvKiBDb3B5cmlnaHQgKGMpIDIwMTkgRmFjZWJvb2sgICovDQo+ICsjaW5jbHVkZSA8c3RkaW8u
aD4NCj4gKyNpbmNsdWRlIDxlcnJuby5oPg0KPiArI2luY2x1ZGUgPHN0cmluZy5oPg0KPiArDQo+
ICsjaW5jbHVkZSA8YnBmL2JwZi5oPg0KPiArI2luY2x1ZGUgPGJwZi9saWJicGYuaD4NCj4gKw0K
PiArI2luY2x1ZGUgPGJwZl91dGlsLmg+DQo+ICsjaW5jbHVkZSA8dGVzdF9tYXBzLmg+DQo+ICsN
Cj4gK3N0YXRpYyB2b2lkIG1hcF9iYXRjaF91cGRhdGUoaW50IG1hcF9mZCwgX191MzIgbWF4X2Vu
dHJpZXMsIGludCAqa2V5cywNCj4gKwkJCSAgICAgdm9pZCAqdmFsdWVzLCBib29sIGlzX3BjcHUp
DQo+ICt7DQo+ICsJdHlwZWRlZiBCUEZfREVDTEFSRV9QRVJDUFUoaW50LCB2YWx1ZSk7DQo+ICsJ
aW50IGksIGosIGVycjsNCj4gKwl2YWx1ZSAqdjsNCj4gKw0KPiArCWlmIChpc19wY3B1KQ0KPiAr
CQl2ID0gKHZhbHVlICopdmFsdWVzOw0KPiArDQo+ICsJZm9yIChpID0gMDsgaSA8IG1heF9lbnRy
aWVzOyBpKyspIHsNCj4gKwkJa2V5c1tpXSA9IGkgKyAxOw0KPiArCQlpZiAoaXNfcGNwdSkNCj4g
KwkJCWZvciAoaiA9IDA7IGogPCBicGZfbnVtX3Bvc3NpYmxlX2NwdXMoKTsgaisrKQ0KPiArCQkJ
CWJwZl9wZXJjcHUodltpXSwgaikgPSBpICsgMiArIGo7DQo+ICsJCWVsc2UNCj4gKwkJCSgoaW50
ICopdmFsdWVzKVtpXSA9IGkgKyAyOw0KPiArCX0NCj4gKw0KPiArCWVyciA9IGJwZl9tYXBfdXBk
YXRlX2JhdGNoKG1hcF9mZCwga2V5cywgdmFsdWVzLCAmbWF4X2VudHJpZXMsIDAsIDApOw0KPiAr
CUNIRUNLKGVyciwgImJwZl9tYXBfdXBkYXRlX2JhdGNoKCkiLCAiZXJyb3I6JXNcbiIsIHN0cmVy
cm9yKGVycm5vKSk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIG1hcF9iYXRjaF92ZXJpZnko
aW50ICp2aXNpdGVkLCBfX3UzMiBtYXhfZW50cmllcywNCj4gKwkJCSAgICAgaW50ICprZXlzLCB2
b2lkICp2YWx1ZXMsIGJvb2wgaXNfcGNwdSkNCj4gK3sNCj4gKwl0eXBlZGVmIEJQRl9ERUNMQVJF
X1BFUkNQVShpbnQsIHZhbHVlKTsNCj4gKwl2YWx1ZSAqdjsNCj4gKwlpbnQgaSwgajsNCj4gKw0K
PiArCWlmIChpc19wY3B1KQ0KPiArCQl2ID0gKHZhbHVlICopdmFsdWVzOw0KPiArDQo+ICsJbWVt
c2V0KHZpc2l0ZWQsIDAsIG1heF9lbnRyaWVzICogc2l6ZW9mKCp2aXNpdGVkKSk7DQo+ICsJZm9y
IChpID0gMDsgaSA8IG1heF9lbnRyaWVzOyBpKyspIHsNCj4gKw0KPiArCQlpZiAoaXNfcGNwdSkg
ew0KPiArCQkJZm9yIChqID0gMDsgaiA8IGJwZl9udW1fcG9zc2libGVfY3B1cygpOyBqKyspIHsN
Cj4gKwkJCQlDSEVDSyhrZXlzW2ldICsgMSArIGogIT0gYnBmX3BlcmNwdSh2W2ldLCBqKSwNCj4g
KwkJCQkgICAgICAia2V5L3ZhbHVlIGNoZWNraW5nIiwNCj4gKwkJCQkgICAgICAiZXJyb3I6IGkg
JWQgaiAlZCBrZXkgJWQgdmFsdWUgJWRcbiIsDQo+ICsJCQkJICAgICAgaSwgaiwga2V5c1tpXSwg
YnBmX3BlcmNwdSh2W2ldLCAgaikpOw0KPiArCQkJfQ0KPiArCQl9IGVsc2Ugew0KPiArCQkJQ0hF
Q0soa2V5c1tpXSArIDEgIT0gKChpbnQgKil2YWx1ZXMpW2ldLA0KPiArCQkJICAgICAgImtleS92
YWx1ZSBjaGVja2luZyIsDQo+ICsJCQkgICAgICAiZXJyb3I6IGkgJWQga2V5ICVkIHZhbHVlICVk
XG4iLCBpLCBrZXlzW2ldLA0KPiArCQkJICAgICAgKChpbnQgKil2YWx1ZXMpW2ldKTsNCj4gKwkJ
fQ0KPiArDQo+ICsJCXZpc2l0ZWRbaV0gPSAxOw0KPiArDQo+ICsJfQ0KPiArCWZvciAoaSA9IDA7
IGkgPCBtYXhfZW50cmllczsgaSsrKSB7DQo+ICsJCUNIRUNLKHZpc2l0ZWRbaV0gIT0gMSwgInZp
c2l0ZWQgY2hlY2tpbmciLA0KPiArCQkgICAgICAiZXJyb3I6IGtleXMgYXJyYXkgYXQgaW5kZXgg
JWQgbWlzc2luZ1xuIiwgaSk7DQo+ICsJfQ0KPiArfQ0KPiArDQo+ICt2b2lkIF9fdGVzdF9tYXBf
bG9va3VwX2FuZF9kZWxldGVfYmF0Y2goYm9vbCBpc19wY3B1KQ0KPiArew0KPiArCWludCBtYXBf
dHlwZSA9IGlzX3BjcHUgPyBCUEZfTUFQX1RZUEVfUEVSQ1BVX0hBU0ggOiBCUEZfTUFQX1RZUEVf
SEFTSDsNCj4gKwlzdHJ1Y3QgYnBmX2NyZWF0ZV9tYXBfYXR0ciB4YXR0ciA9IHsNCj4gKwkJLm5h
bWUgPSAiaGFzaF9tYXAiLA0KPiArCQkubWFwX3R5cGUgPSBtYXBfdHlwZSwNCj4gKwkJLmtleV9z
aXplID0gc2l6ZW9mKGludCksDQo+ICsJCS52YWx1ZV9zaXplID0gc2l6ZW9mKGludCksDQo+ICsJ
fTsNCj4gKwl0eXBlZGVmIEJQRl9ERUNMQVJFX1BFUkNQVShpbnQsIHZhbHVlKTsNCj4gKwlpbnQg
bWFwX2ZkLCAqa2V5cywgKnZpc2l0ZWQsIGtleTsNCj4gKwlfX3UzMiBiYXRjaCA9IDAsIGNvdW50
LCB0b3RhbCwgdG90YWxfc3VjY2VzczsNCj4gKwljb25zdCBfX3UzMiBtYXhfZW50cmllcyA9IDEw
Ow0KPiArCWludCBlcnIsIGksIHN0ZXAsIHZhbHVlX3NpemU7DQo+ICsJdmFsdWUgcGNwdV92YWx1
ZXNbMTBdOw0KPiArCWJvb2wgbm9zcGFjZV9lcnI7DQo+ICsJdm9pZCAqdmFsdWVzOw0KPiArDQo+
ICsJeGF0dHIubWF4X2VudHJpZXMgPSBtYXhfZW50cmllczsNCj4gKwltYXBfZmQgPSBicGZfY3Jl
YXRlX21hcF94YXR0cigmeGF0dHIpOw0KPiArCUNIRUNLKG1hcF9mZCA9PSAtMSwNCj4gKwkgICAg
ICAiYnBmX2NyZWF0ZV9tYXBfeGF0dHIoKSIsICJlcnJvcjolc1xuIiwgc3RyZXJyb3IoZXJybm8p
KTsNCj4gKw0KPiArCXZhbHVlX3NpemUgPSBpc19wY3B1ID8gc2l6ZW9mKHZhbHVlKSA6IHNpemVv
ZihpbnQpOw0KPiArCWtleXMgPSBtYWxsb2MobWF4X2VudHJpZXMgKiBzaXplb2YoaW50KSk7DQo+
ICsJaWYgKGlzX3BjcHUpDQo+ICsJCXZhbHVlcyA9IHBjcHVfdmFsdWVzOw0KPiArCWVsc2UNCj4g
KwkJdmFsdWVzID0gbWFsbG9jKG1heF9lbnRyaWVzICogc2l6ZW9mKGludCkpOw0KPiArCXZpc2l0
ZWQgPSBtYWxsb2MobWF4X2VudHJpZXMgKiBzaXplb2YoaW50KSk7DQo+ICsJQ0hFQ0soIWtleXMg
fHwgIXZhbHVlcyB8fCAhdmlzaXRlZCwgIm1hbGxvYygpIiwNCj4gKwkgICAgICAiZXJyb3I6JXNc
biIsIHN0cmVycm9yKGVycm5vKSk7DQo+ICsNCj4gKwkvKiB0ZXN0IDE6IGxvb2t1cC9kZWxldGUg
YW4gZW1wdHkgaGFzaCB0YWJsZSwgLUVOT0VOVCAqLw0KPiArCWNvdW50ID0gbWF4X2VudHJpZXM7
DQo+ICsJZXJyID0gYnBmX21hcF9sb29rdXBfYW5kX2RlbGV0ZV9iYXRjaChtYXBfZmQsIE5VTEws
ICZiYXRjaCwga2V5cywNCj4gKwkJCQkJICAgICAgdmFsdWVzLCAmY291bnQsIDAsIDApOw0KPiAr
CUNIRUNLKChlcnIgJiYgZXJybm8gIT0gRU5PRU5UKSwgImVtcHR5IG1hcCIsDQo+ICsJICAgICAg
ImVycm9yOiAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsNCj4gKw0KPiArCS8qIHBvcHVsYXRlIGVs
ZW1lbnRzIHRvIHRoZSBtYXAgKi8NCj4gKwltYXBfYmF0Y2hfdXBkYXRlKG1hcF9mZCwgbWF4X2Vu
dHJpZXMsIGtleXMsIHZhbHVlcywgaXNfcGNwdSk7DQo+ICsNCj4gKwkvKiB0ZXN0IDI6IGxvb2t1
cC9kZWxldGUgd2l0aCBjb3VudCA9IDAsIHN1Y2Nlc3MgKi8NCj4gKwliYXRjaCA9IDA7DQo+ICsJ
Y291bnQgPSAwOw0KPiArCWVyciA9IGJwZl9tYXBfbG9va3VwX2FuZF9kZWxldGVfYmF0Y2gobWFw
X2ZkLCBOVUxMLCAmYmF0Y2gsIGtleXMsDQo+ICsJCQkJCSAgICAgIHZhbHVlcywgJmNvdW50LCAw
LCAwKTsNCj4gKwlDSEVDSyhlcnIsICJjb3VudCA9IDAiLCAiZXJyb3I6ICVzXG4iLCBzdHJlcnJv
cihlcnJubykpOw0KPiArDQo+ICsJLyogdGVzdCAzOiBsb29rdXAvZGVsZXRlIHdpdGggY291bnQg
PSBtYXhfZW50cmllcywgc3VjY2VzcyAqLw0KPiArCW1lbXNldChrZXlzLCAwLCBtYXhfZW50cmll
cyAqIHNpemVvZigqa2V5cykpOw0KPiArCW1lbXNldCh2YWx1ZXMsIDAsIG1heF9lbnRyaWVzICog
dmFsdWVfc2l6ZSk7DQo+ICsJY291bnQgPSBtYXhfZW50cmllczsNCj4gKwliYXRjaCA9IDA7DQo+
ICsJZXJyID0gYnBmX21hcF9sb29rdXBfYW5kX2RlbGV0ZV9iYXRjaChtYXBfZmQsIE5VTEwsICZi
YXRjaCwga2V5cywNCj4gKwkJCQkJICAgICAgdmFsdWVzLCAmY291bnQsIDAsIDApOw0KPiArCUNI
RUNLKChlcnIgJiYgZXJybm8gIT0gRU5PRU5UKSwgImNvdW50ID0gbWF4X2VudHJpZXMiLA0KPiAr
CSAgICAgICAiZXJyb3I6ICVzXG4iLCBzdHJlcnJvcihlcnJubykpOw0KPiArCUNIRUNLKGNvdW50
ICE9IG1heF9lbnRyaWVzLCAiY291bnQgPSBtYXhfZW50cmllcyIsDQo+ICsJICAgICAgImNvdW50
ID0gJXUsIG1heF9lbnRyaWVzID0gJXVcbiIsIGNvdW50LCBtYXhfZW50cmllcyk7DQo+ICsJbWFw
X2JhdGNoX3ZlcmlmeSh2aXNpdGVkLCBtYXhfZW50cmllcywga2V5cywgdmFsdWVzLCBpc19wY3B1
KTsNCj4gKw0KPiArCS8qIGJwZl9tYXBfZ2V0X25leHRfa2V5KCkgc2hvdWxkIHJldHVybiAtRU5P
RU5UIGZvciBhbiBlbXB0eSBtYXAuICovDQo+ICsJZXJyID0gYnBmX21hcF9nZXRfbmV4dF9rZXko
bWFwX2ZkLCBOVUxMLCAma2V5KTsNCj4gKwlDSEVDSyghZXJyLCAiYnBmX21hcF9nZXRfbmV4dF9r
ZXkoKSIsICJlcnJvcjogJXNcbiIsIHN0cmVycm9yKGVycm5vKSk7DQo+ICsNCj4gKwkvKiB0ZXN0
IDQ6IGxvb2t1cC9kZWxldGUgaW4gYSBsb29wIHdpdGggdmFyaW91cyBzdGVwcy4gKi8NCj4gKwl0
b3RhbF9zdWNjZXNzID0gMDsNCj4gKwlmb3IgKHN0ZXAgPSAxOyBzdGVwIDwgbWF4X2VudHJpZXM7
IHN0ZXArKykgew0KPiArCQltYXBfYmF0Y2hfdXBkYXRlKG1hcF9mZCwgbWF4X2VudHJpZXMsIGtl
eXMsIHZhbHVlcywgaXNfcGNwdSk7DQo+ICsJCW1lbXNldChrZXlzLCAwLCBtYXhfZW50cmllcyAq
IHNpemVvZigqa2V5cykpOw0KPiArCQltZW1zZXQodmFsdWVzLCAwLCBtYXhfZW50cmllcyAqIHZh
bHVlX3NpemUpOw0KPiArCQliYXRjaCA9IDA7DQo+ICsJCXRvdGFsID0gMDsNCj4gKwkJaSA9IDA7
DQo+ICsJCS8qIGl0ZXJhdGl2ZWx5IGxvb2t1cC9kZWxldGUgZWxlbWVudHMgd2l0aCAnc3RlcCcN
Cj4gKwkJICogZWxlbWVudHMgZWFjaA0KPiArCQkgKi8NCj4gKwkJY291bnQgPSBzdGVwOw0KPiAr
CQlub3NwYWNlX2VyciA9IGZhbHNlOw0KPiArCQl3aGlsZSAodHJ1ZSkgew0KPiArCQkJZXJyID0g
YnBmX21hcF9sb29rdXBfYmF0Y2gobWFwX2ZkLA0KPiArCQkJCQkJICAgdG90YWwgPyAmYmF0Y2gg
OiBOVUxMLA0KPiArCQkJCQkJICAgJmJhdGNoLCBrZXlzICsgdG90YWwsDQo+ICsJCQkJCQkgICB2
YWx1ZXMgKw0KPiArCQkJCQkJICAgdG90YWwgKiB2YWx1ZV9zaXplLA0KPiArCQkJCQkJICAgJmNv
dW50LCAwLCAwKTsNCj4gKwkJCS8qIEl0IGlzIHBvc3NpYmxlIHRoYXQgd2UgYXJlIGZhaWxpbmcg
ZHVlIHRvIGJ1ZmZlciBzaXplDQo+ICsJCQkgKiBub3QgYmlnIGVub3VnaC4gSW4gc3VjaCBjYXNl
cywgbGV0IHVzIGp1c3QgZXhpdCBhbmQNCj4gKwkJCSAqIGdvIHdpdGggbGFyZ2Ugc3RlcHMuIE5v
dCB0aGF0IGEgYnVmZmVyIHNpemUgd2l0aA0KPiArCQkJICogbWF4X2VudHJpZXMgc2hvdWxkIGFs
d2F5cyB3b3JrLg0KPiArCQkJICovDQo+ICsJCQlpZiAoZXJyICYmIGVycm5vID09IEVOT1NQQykg
ew0KPiArCQkJCW5vc3BhY2VfZXJyID0gdHJ1ZTsNCj4gKwkJCQlicmVhazsNCj4gKwkJCX0NCj4g
Kw0KPiArDQo+ICsJCQlDSEVDSygoZXJyICYmIGVycm5vICE9IEVOT0VOVCksICJsb29rdXAgd2l0
aCBzdGVwcyIsDQo+ICsJCQkgICAgICAiZXJyb3I6ICVzXG4iLCBzdHJlcnJvcihlcnJubykpOw0K
PiArDQo+ICsJCQl0b3RhbCArPSBjb3VudDsNCj4gKwkJCWlmIChlcnIpDQo+ICsJCQkJYnJlYWs7
DQo+ICsNCj4gKwkJCWkrKzsNCj4gKwkJfQ0KPiArCQlpZiAobm9zcGFjZV9lcnIgPT0gdHJ1ZSkN
Cj4gKwkJCWNvbnRpbnVlOw0KPiArDQo+ICsJCUNIRUNLKHRvdGFsICE9IG1heF9lbnRyaWVzLCAi
bG9va3VwIHdpdGggc3RlcHMiLA0KPiArCQkgICAgICAidG90YWwgPSAldSwgbWF4X2VudHJpZXMg
PSAldVxuIiwgdG90YWwsIG1heF9lbnRyaWVzKTsNCj4gKwkJbWFwX2JhdGNoX3ZlcmlmeSh2aXNp
dGVkLCBtYXhfZW50cmllcywga2V5cywgdmFsdWVzLCBpc19wY3B1KTsNCj4gKw0KPiArCQltZW1z
ZXQoa2V5cywgMCwgbWF4X2VudHJpZXMgKiBzaXplb2YoKmtleXMpKTsNCj4gKwkJbWVtc2V0KHZh
bHVlcywgMCwgbWF4X2VudHJpZXMgKiB2YWx1ZV9zaXplKTsNCj4gKwkJYmF0Y2ggPSAwOw0KPiAr
CQl0b3RhbCA9IDA7DQo+ICsJCWkgPSAwOw0KPiArCQkvKiBpdGVyYXRpdmVseSBsb29rdXAvZGVs
ZXRlIGVsZW1lbnRzIHdpdGggJ3N0ZXAnDQo+ICsJCSAqIGVsZW1lbnRzIGVhY2gNCj4gKwkJICov
DQo+ICsJCWNvdW50ID0gc3RlcDsNCj4gKwkJbm9zcGFjZV9lcnIgPSBmYWxzZTsNCj4gKwkJd2hp
bGUgKHRydWUpIHsNCj4gKwkJCWVyciA9IGJwZl9tYXBfbG9va3VwX2FuZF9kZWxldGVfYmF0Y2go
bWFwX2ZkLA0KPiArCQkJCQkJCXRvdGFsID8gJmJhdGNoIDogTlVMTCwNCj4gKwkJCQkJCQkmYmF0
Y2gsIGtleXMgKyB0b3RhbCwNCj4gKwkJCQkJCQl2YWx1ZXMgKw0KPiArCQkJCQkJCXRvdGFsICog
dmFsdWVfc2l6ZSwNCj4gKwkJCQkJCQkmY291bnQsIDAsIDApOw0KPiArCQkJLyogSXQgaXMgcG9z
c2libGUgdGhhdCB3ZSBhcmUgZmFpbGluZyBkdWUgdG8gYnVmZmVyIHNpemUNCj4gKwkJCSAqIG5v
dCBiaWcgZW5vdWdoLiBJbiBzdWNoIGNhc2VzLCBsZXQgdXMganVzdCBleGl0IGFuZA0KPiArCQkJ
ICogZ28gd2l0aCBsYXJnZSBzdGVwcy4gTm90IHRoYXQgYSBidWZmZXIgc2l6ZSB3aXRoDQo+ICsJ
CQkgKiBtYXhfZW50cmllcyBzaG91bGQgYWx3YXlzIHdvcmsuDQo+ICsJCQkgKi8NCj4gKwkJCWlm
IChlcnIgJiYgZXJybm8gPT0gRU5PU1BDKSB7DQo+ICsJCQkJbm9zcGFjZV9lcnIgPSB0cnVlOw0K
PiArCQkJCWJyZWFrOw0KPiArCQkJfQ0KPiArDQo+ICsJCQlDSEVDSygoZXJyICYmIGVycm5vICE9
IEVOT0VOVCksICJsb29rdXAgd2l0aCBzdGVwcyIsDQo+ICsJCQkgICAgICAiZXJyb3I6ICVzXG4i
LCBzdHJlcnJvcihlcnJubykpOw0KPiArDQo+ICsJCQl0b3RhbCArPSBjb3VudDsNCj4gKwkJCWlm
IChlcnIpDQo+ICsJCQkJYnJlYWs7DQo+ICsJCQlpKys7DQo+ICsJCX0NCj4gKw0KPiArCQlpZiAo
bm9zcGFjZV9lcnIgPT0gdHJ1ZSkNCj4gKwkJCWNvbnRpbnVlOw0KPiArDQo+ICsJCUNIRUNLKHRv
dGFsICE9IG1heF9lbnRyaWVzLCAibG9va3VwL2RlbGV0ZSB3aXRoIHN0ZXBzIiwNCj4gKwkJICAg
ICAgInRvdGFsID0gJXUsIG1heF9lbnRyaWVzID0gJXVcbiIsIHRvdGFsLCBtYXhfZW50cmllcyk7
DQo+ICsNCj4gKwkJbWFwX2JhdGNoX3ZlcmlmeSh2aXNpdGVkLCBtYXhfZW50cmllcywga2V5cywg
dmFsdWVzLCBpc19wY3B1KTsNCj4gKwkJZXJyID0gYnBmX21hcF9nZXRfbmV4dF9rZXkobWFwX2Zk
LCBOVUxMLCAma2V5KTsNCj4gKwkJQ0hFQ0soIWVyciwgImJwZl9tYXBfZ2V0X25leHRfa2V5KCki
LCAiZXJyb3I6ICVzXG4iLA0KPiArCQkgICAgICBzdHJlcnJvcihlcnJubykpOw0KPiArDQo+ICsJ
CXRvdGFsX3N1Y2Nlc3MrKzsNCj4gKwl9DQo+ICsNCj4gKwlDSEVDSyh0b3RhbF9zdWNjZXNzID09
IDAsICJjaGVjayB0b3RhbF9zdWNjZXNzIiwNCj4gKwkgICAgICAidW5leHBlY3RlZCBmYWlsdXJl
XG4iKTsNCj4gK30NCj4gKw0KPiArdm9pZCB0ZXN0X2htYXBfbG9va3VwX2FuZF9kZWxldGVfYmF0
Y2godm9pZCkNCj4gK3sNCj4gKwlfX3Rlc3RfbWFwX2xvb2t1cF9hbmRfZGVsZXRlX2JhdGNoKGZh
bHNlKTsNCj4gKwlwcmludGYoIiVzOlBBU1NcbiIsIF9fZnVuY19fKTsNCj4gK30NCj4gKw0KPiAr
dm9pZCB0ZXN0X3BjcHVfaG1hcF9sb29rdXBfYW5kX2RlbGV0ZV9iYXRjaCh2b2lkKQ0KPiArew0K
PiArCV9fdGVzdF9tYXBfbG9va3VwX2FuZF9kZWxldGVfYmF0Y2godHJ1ZSk7DQo+ICsJcHJpbnRm
KCIlczpQQVNTXG4iLCBfX2Z1bmNfXyk7DQo+ICt9DQo+ICsNCj4gK3ZvaWQgdGVzdF9tYXBfbG9v
a3VwX2FuZF9kZWxldGVfYmF0Y2hfaHRhYih2b2lkKQ0KPiArew0KPiArCXRlc3RfaG1hcF9sb29r
dXBfYW5kX2RlbGV0ZV9iYXRjaCgpOw0KPiArCXRlc3RfcGNwdV9obWFwX2xvb2t1cF9hbmRfZGVs
ZXRlX2JhdGNoKCk7DQo+ICt9DQo+IA0K
