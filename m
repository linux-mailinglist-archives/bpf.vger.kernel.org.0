Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD86CE8BA7
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 16:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389238AbfJ2PRI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Oct 2019 11:17:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24120 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728879AbfJ2PRH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Oct 2019 11:17:07 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TF8fhj030625;
        Tue, 29 Oct 2019 08:16:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=kCJrt1qzASJTHLS1EgVQ995Pgk2tWfVS8Z+wocNTP8k=;
 b=leA59BOUEM0RhmjMvquz1UUFsGNKrCP2aNXZ+GNgY1YYlCu5xJns9R9oFBWp4zokmElP
 j7Tx7SZmTEk6x4+cJ9NXzRnGmgj9fpt6UUALmNP591Hww5G1DIQdMzIR7uM8zHNTZpeI
 PjkwmYlXZYAiJ+YTXHIedIFzYMSfK+elOus= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vxj1vsnm8-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 08:16:48 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 29 Oct 2019 08:16:18 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 29 Oct 2019 08:16:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPnRrBuv5duim5Espp+ARX5/yw9bNk9+yHDz6CenqNaKtoT7nmdhx4sz5vnG8ZzNr5IK8wRs0GiIrYp/a4ZZv9A76WUmMfa+BikULAjp4bxpSgz5S1IASpZ0tWTKP/t69/+2OglR+9rvnsM51ponW5PQx9HSrMcyeTx5+/Uqp3BmJPwAWd+LPcwC1HPimDIg5aVIzy5649urzXYX+ufjI/J6pIW34Sz1JuGzVkmwhTfWPz8WIbcQePeQUdYlnJyk3vN4c0NvA6wub1NOCUaJ0f64ub16O3+46RXCpwWcVx7mbRtNBcq7zmruFI/0OY4obfxt43eo9pm2BQ099Br5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCJrt1qzASJTHLS1EgVQ995Pgk2tWfVS8Z+wocNTP8k=;
 b=QA3QRuC1QmGk2g9s0fWsvsrnebb5cxAhYqmizZVGD709uNMm9LiQ+dSGu0dIWrf4htdFM22FEypW48/qrjTzxAvLrtJEhMbEZfK0Shlu7ZDoxuIDnlZGlyvB64ENAh1vZ/4gLVmbStl43rGoycoF2Oz9Oi2eEehW4ZgTEomqvf7c6WJuSa3gBlbYAU5fERWUwjkk+jUlP/IFjcQXuvAwemjbWx+BEewcrYx3dXozGwADZhXp5Rk+8T+vsMm7QVDpCVjUuen07deEhcjyQFWLJ4zML+AlmuPwB040mrZ+rf8T2n8w9RAAonA9mEeUPlkCLEi6rBZPBOhLq7b2lzJPIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCJrt1qzASJTHLS1EgVQ995Pgk2tWfVS8Z+wocNTP8k=;
 b=J9qJ+ZzyBWxLI9l25ysgLUUjoXN3RLlm3iMrsaGJCwx1LUEJDD/6T0G5wgX690Yrwk1y0nGOOCRjz3xV7sOS839m2e0qFKDp8ESUCK8pk6Y0DGUDh/pp20sVn0aV8xiKW7yjELfl8BVdStedN87GH+BlEi7/s2bBZnxBmNuf3DQ=
Received: from MWHPR15MB1375.namprd15.prod.outlook.com (10.173.233.21) by
 MWHPR15MB1247.namprd15.prod.outlook.com (10.175.2.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Tue, 29 Oct 2019 15:16:17 +0000
Received: from MWHPR15MB1375.namprd15.prod.outlook.com
 ([fe80::e917:269c:162c:2142]) by MWHPR15MB1375.namprd15.prod.outlook.com
 ([fe80::e917:269c:162c:2142%12]) with mapi id 15.20.2387.025; Tue, 29 Oct
 2019 15:16:17 +0000
From:   Andrey Ignatov <rdna@fb.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf] bpf: allow narrow loads of bpf_sysctl fields with
 offset > 0
Thread-Topic: [PATCH bpf] bpf: allow narrow loads of bpf_sysctl fields with
 offset > 0
Thread-Index: AQHVjYtVYSZ15vhmGUeukQkXXEg0BqdxCeYAgACizgCAAA/RgA==
Date:   Tue, 29 Oct 2019 15:16:16 +0000
Message-ID: <20191029151615.GA83844@rdna-mbp>
References: <20191028122902.9763-1-iii@linux.ibm.com>
 <CAEf4BzajQL463pCogVAnX1H5Tg-+kj9p_-mAJs=n1r6OfZ2mXg@mail.gmail.com>
 <9B04A778-42CE-4451-A276-5A41D6290055@linux.ibm.com>
In-Reply-To: <9B04A778-42CE-4451-A276-5A41D6290055@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:300:c0::12) To MWHPR15MB1375.namprd15.prod.outlook.com
 (2603:10b6:300:ba::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::b373]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14b8d94c-6d35-476e-37fb-08d75c82f1ab
x-ms-traffictypediagnostic: MWHPR15MB1247:
x-microsoft-antispam-prvs: <MWHPR15MB1247A1938C8D78832B12F28DA8610@MWHPR15MB1247.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(4001150100001)(446003)(14444005)(186003)(256004)(6116002)(476003)(86362001)(76176011)(52116002)(6512007)(8676002)(6486002)(9686003)(4326008)(6436002)(14454004)(229853002)(7736002)(305945005)(486006)(46003)(81166006)(8936002)(102836004)(81156014)(6246003)(66476007)(66946007)(25786009)(110136005)(316002)(66556008)(2906002)(11346002)(66446008)(64756008)(54906003)(1076003)(71190400001)(6506007)(5660300002)(71200400001)(33716001)(53546011)(386003)(478600001)(99286004)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1247;H:MWHPR15MB1375.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AM7OBqNReRwv2URpXV4pECgeOGEwgWHuhg0FYe2q7xFNo1WCkEoVSdh4deRO5enSmg8QFWvb7KlaUHSnrKAmZ2k1VHvZKaQyho1yWUFAnOMzlxD4RZMZURGQr4wztbXdfn9AULOSw+Ig9P8GZWj7lbXffcGDT0xgf5UGRHbZN3jeDTSqxoeK7CP6xvvduVUkyN4qpXD5tnb4747N72PmvTQDCwvRNvNJ1IXskeBZAIZ7mvS2KOVZJaUg9KtkU2+ZMpzSrPrDo4TgTnTAlX6/MvpDe7KE4FBrzHGyKwuHZEdACtqeEki/1js5tcni+nbBEAo6FwrSrHYlFNHKN5fWfvTSe/96zwTdz8DEqDcBb/k50NI+pTOPwhPLXDmXvmL9yaBgP7bGZYobrRkNWn7Ri2K2blvmD9QrpJf9IMXfPdiggwcKSAKIa+PSbDXz7IWb
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FED19ED237E8D54B98F7A2C997D6941C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b8d94c-6d35-476e-37fb-08d75c82f1ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 15:16:17.0736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uuqUqUfGMkrIrc/p2bWMnrO4pgxMHxQNrHqDbU6KNaAQbQIwi3Vxg5Ylnjom0KbR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1247
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_05:2019-10-28,2019-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910290142
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SWx5YSBMZW9zaGtldmljaCA8aWlpQGxpbnV4LmlibS5jb20+IFtUdWUsIDIwMTktMTAtMjkgMDc6
MjAgLTA3MDBdOg0KPiA+IEFtIDI5LjEwLjIwMTkgdW0gMDU6MzYgc2NocmllYiBBbmRyaWkgTmFr
cnlpa28gPGFuZHJpaS5uYWtyeWlrb0BnbWFpbC5jb20+Og0KPiA+IA0KPiA+IE9uIE1vbiwgT2N0
IDI4LCAyMDE5IGF0IDE6MDkgUE0gSWx5YSBMZW9zaGtldmljaCA8aWlpQGxpbnV4LmlibS5jb20+
IHdyb3RlOg0KPiA+PiANCj4gPj4gLS0tIGEva2VybmVsL2JwZi9jZ3JvdXAuYw0KPiA+PiArKysg
Yi9rZXJuZWwvYnBmL2Nncm91cC5jDQo+ID4+IEBAIC0xMzExLDEyICsxMzExLDEyIEBAIHN0YXRp
YyBib29sIHN5c2N0bF9pc192YWxpZF9hY2Nlc3MoaW50IG9mZiwgaW50IHNpemUsIGVudW0gYnBm
X2FjY2Vzc190eXBlIHR5cGUsDQo+ID4+ICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4g
Pj4gDQo+ID4+ICAgICAgICBzd2l0Y2ggKG9mZikgew0KPiA+PiAtICAgICAgIGNhc2Ugb2Zmc2V0
b2Yoc3RydWN0IGJwZl9zeXNjdGwsIHdyaXRlKToNCj4gPj4gKyAgICAgICBjYXNlIGJwZl9jdHhf
cmFuZ2Uoc3RydWN0IGJwZl9zeXNjdGwsIHdyaXRlKToNCj4gPiANCj4gPiB0aGlzIHdpbGwgYWN0
dWFsbHkgYWxsb3cgcmVhZHMgcGFzIHQgd3JpdGUgZmllbGQgKGUuZy4sIG9mZnNldCA9IDIsIHNp
emUgPSA0KS4NCj4gDQo+IFdvdWxkbid0DQo+IA0KPiAJaWYgKG9mZiA8IDAgfHwgb2ZmICsgc2l6
ZSA+IHNpemVvZihzdHJ1Y3QgYnBmX3N5c2N0bCkgfHwgb2ZmICUgc2l6ZSkNCj4gCQlyZXR1cm4g
ZmFsc2U7DQo+IA0KPiBwcmV2ZW50IGFsbCBPT0IgcmVhZC13cml0ZSBhdHRlbXB0cz8gRXNwZWNp
YWxseSB0aGUgb2ZmICUgc2l6ZSBwYXJ0IC0gSQ0KPiB0aGluayBpdCBoYXMgdGhlIGVmZmVjdCBv
ZiBwcmV2ZW50aW5nIE9PQiBhY2Nlc3NlcyBmb3IgZmllbGRzLiBJbg0KPiBwYXJ0aWN1bGFyLCBp
dCB3b3VsZCBmaWx0ZXIgb2Zmc2V0ID0gMiwgc2l6ZSA9IDQgY2FzZS4NCg0KWWVzLCBpdCB3b3Vs
ZC4gVGhpcyBjb2RlIG1ha2VzIHN1cmUgdGhhdCBuYXJyb3cgYWNjZXNzZXMgYXJlIGFsaWduZWQg
c28NCnRoYXQgb2Zmc2V0ID0gMiB3b3VsZCBhbGxvdyBvbmx5IHNpemUgPSAyIG9yIHNpemUgPSAx
Lg0KDQo+IEkgaGF2ZSBhbHNvIGNoZWNrZWQgdGhlIG90aGVyIHVzYWdlcyBvZiBicGZfY3R4X3Jh
bmdlLCBmb3IgZXhhbXBsZSwNCj4gYnBmX3NrYl9pc192YWxpZF9hY2Nlc3MsIGFuZCB0aGV5IGRv
bid0IHNlZW0gdG8gYmUgZG9pbmcgYW55dGhpbmcNCj4gc3BlY2lhbC4NCg0KWWVzLCBzeXNjdGwg
aG9vayBmb2xsb3dzIGxvZ2ljIHNpbWlsYXIgdG8gdGhhdCBvZiBvdGhlciBwcm9ncmFtIHR5cGVz
Lg0KDQo+ID4+ICAgICAgICAgICAgICAgIGlmICh0eXBlICE9IEJQRl9SRUFEKQ0KPiA+PiAgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPj4gICAgICAgICAgICAgICAgYnBm
X2N0eF9yZWNvcmRfZmllbGRfc2l6ZShpbmZvLCBzaXplX2RlZmF1bHQpOw0KPiA+PiAgICAgICAg
ICAgICAgICByZXR1cm4gYnBmX2N0eF9uYXJyb3dfYWNjZXNzX29rKG9mZiwgc2l6ZSwgc2l6ZV9k
ZWZhdWx0KTsNCj4gPj4gLSAgICAgICBjYXNlIG9mZnNldG9mKHN0cnVjdCBicGZfc3lzY3RsLCBm
aWxlX3Bvcyk6DQo+ID4+ICsgICAgICAgY2FzZSBicGZfY3R4X3JhbmdlKHN0cnVjdCBicGZfc3lz
Y3RsLCBmaWxlX3BvcykNCj4gPiANCj4gPiB0aGlzIHdpbGwgYWxsb3cgcmVhZCBwYXN0IGNvbnRl
eHQgc3RydWN0IGFsdG9nZXRoZXIuIFdoZW4gd2UgYWxsb3cNCj4gPiByYW5nZXMsIHdlIHdpbGwg
aGF2ZSB0byBhZGp1c3QgYWxsb3dlZCByZWFkIHNpemUuDQo+IA0KPiBTYW1lIGhlcmUuDQoNCi0t
IA0KQW5kcmV5IElnbmF0b3YNCg==
