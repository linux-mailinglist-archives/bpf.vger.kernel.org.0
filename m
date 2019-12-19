Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3C0125C08
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 08:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfLSHgM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 02:36:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31116 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbfLSHgL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Dec 2019 02:36:11 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJ7ZAeR013771;
        Wed, 18 Dec 2019 23:35:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=LXq7Uy4Ja3o0QLcUWIkGjJWYLQrQh471TvYcgaS+oi0=;
 b=MUhuxHmatVaLi7s/hnGgBwtL2savpeRtAourwUTiFSLoOe+UxJGa656QF99l/LTx6f7A
 Lc2hPYNvSuSDhpt178H+tRZnakEgk4y4vVkbPlvRgPwh6u+d6AqU5/nFZw6ZjupKezDp
 g1pyk/bxRlL0Rc7Gh9TRdDS7CK8IDcqDZf0= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wypvwkuxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 23:35:52 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 18 Dec 2019 23:35:51 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Dec 2019 23:35:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFWXIwjjtnPu6f9kgyDoyPrZ7+9LQHTUGbPKmtL9Ty/0GlrAob3ZGk6OEbFQGX5ARCkWZORyY+S/Xw/hj4EmacoMKMkmi7wXvelPpopAteD112Pm7z7Dc3XvHK5YPGdKywlBbhESVK124fzEf02CsvSpWXn9pmv3mn9p3DxqV0E/wESD8+OHCD4l1EeYUNyCQMZ/kipGCpD5BGHHGKW6Mu5s6TOD/BSTDzL0N/DU1352ZFrInAbOBJbbxCpkBsYFBAFstqh/ccQVDbmV1vnT0Z14ABcNf2tu6NVkGbkI0t+nicYIsfVBnEbsMJDcesVHl9fy4mklH847LAZjjjRhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXq7Uy4Ja3o0QLcUWIkGjJWYLQrQh471TvYcgaS+oi0=;
 b=igI1k+XCRInPpHAWPtr+KWl/QMxYnJUg9Tgw7n4toPya9lzgNH1MOd1ZX3z1E97QuhIuOwFPAJLbYsuV9J4NtLc1WcXLFAG9RvAH+peky9Yq3R/ZZpM9ChRDYdQC/UjvaSHd2vJxSbeW7/YIYCGfrZMbg079seVdkb7Ld2ZT5PefPLrRzJPyKakUeMsTi+IOEA7MVL+2pbXqjkkHf3pwg9q8/slDWQVAZeo2FkMKeCWBjrg2r0tpEtRj9B5b2+9KZP439gpTsL1pKwtcBimEzW7yAlwbaOTtZL/9rScUSq2CoIx/dTWYLzwKtkcnSz72bIwdPKL9ZOcHL/URp4GGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXq7Uy4Ja3o0QLcUWIkGjJWYLQrQh471TvYcgaS+oi0=;
 b=ReKqkkNAIZm1jisU79aNycSvpBbnHuRDWlvRGN6LtZmlZ+xNaeLJi6Y8IOZHc7DK/016C6kkA0zDlSB0AKpHctEAOYJbXPAXwmoIbr8fh8pq79l3nNKjpwPwXnzeG5Ui9riS7s7aKVrMj7cryZ6aPvWLFG4kia9ZJ98r5fj/CU4=
Received: from MWHPR15MB1294.namprd15.prod.outlook.com (10.175.3.150) by
 MWHPR15MB1789.namprd15.prod.outlook.com (10.174.96.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Thu, 19 Dec 2019 07:35:36 +0000
Received: from MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::5160:b3c0:bed1:e26c]) by MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::5160:b3c0:bed1:e26c%10]) with mapi id 15.20.2559.012; Thu, 19 Dec
 2019 07:35:36 +0000
Received: from localhost (2620:10d:c090:180::99d4) by MWHPR20CA0013.namprd20.prod.outlook.com (2603:10b6:300:13d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend Transport; Thu, 19 Dec 2019 07:35:35 +0000
From:   Andrey Ignatov <rdna@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 6/6] selftests/bpf: Test BPF_F_REPLACE in
 cgroup_attach_multi
Thread-Topic: [PATCH v3 bpf-next 6/6] selftests/bpf: Test BPF_F_REPLACE in
 cgroup_attach_multi
Thread-Index: AQHVtjFv4idHXt2RN0WYBTBN9tUMF6fBEWkA
Date:   Thu, 19 Dec 2019 07:35:36 +0000
Message-ID: <20191219073534.GC16266@rdna-mbp.dhcp.thefacebook.com>
References: <cover.1576720240.git.rdna@fb.com>
 <31ac56887591418c2c098fabc14ad00de008e603.1576720240.git.rdna@fb.com>
 <CAEf4BzYWJLJgCt4QCcThg4-kbPr=L+Nv2A5Nd0YknWWkuM05tg@mail.gmail.com>
In-Reply-To: <CAEf4BzYWJLJgCt4QCcThg4-kbPr=L+Nv2A5Nd0YknWWkuM05tg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:300:13d::23) To MWHPR15MB1294.namprd15.prod.outlook.com
 (2603:10b6:320:25::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::99d4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e33466c-b52c-4d3e-2574-08d7845609d3
x-ms-traffictypediagnostic: MWHPR15MB1789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1789806239A7C8346C13242BA8520@MWHPR15MB1789.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:376;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(199004)(54906003)(316002)(1076003)(6916009)(71200400001)(4001150100001)(6496006)(8936002)(52116002)(2906002)(86362001)(6486002)(9686003)(8676002)(81156014)(33656002)(81166006)(66946007)(66556008)(64756008)(66446008)(66476007)(4326008)(186003)(16526019)(5660300002)(53546011)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1789;H:MWHPR15MB1294.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NPZnp1A4UUa6Mp/un7E/yQjnVUgN+VxS6BrzgFeo8XjBucc2SpikL+Gm5d4NOIidzmS+G50S0zhuAkw16/YFjfMpGB81NbTojGVU2zBKfSBN+PVgMC0MoCxHdoOEFRqV1XBssYzGm0UilsCqmeKIvnCa3Ciyxvix6uMDLwSrgFhnOlbRU0NXiy1fU9LM+gQkP5HzU+C3bWfveo9Ab/JYLv2yRdAUHxMTXuyHN2X+nRr0faSBPXKExDKnlwNGeclWvwPFR0NGWIpBK77ZN+wsVo5Icfx7gymKYv1Je8QRmWPGe04VpxeOLoCnAMgISNpl0BZtLkIApkZ+SDaRy+mgpF6TLugOJoLL6XCy3I+k8iaNbI2mdfgklE/rlNe9xVfua9yf+7r6lxc5WS8j9bFmRoYw1FNxkOg9SfkaKa5I0VZYkL1GgGPmhM24uiSDemBZ
Content-Type: text/plain; charset="utf-8"
Content-ID: <323277FBD96AB0468FE516FF21D180B8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e33466c-b52c-4d3e-2574-08d7845609d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 07:35:36.5200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g1enQ/eZYQnPoguPhZN1i60+FkpHPqRpF/gVnZIuWXkRPo1xjJhGm3cG0DaKuA+l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1789
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_08:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190064
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

QW5kcmlpIE5ha3J5aWtvIDxhbmRyaWkubmFrcnlpa29AZ21haWwuY29tPiBbV2VkLCAyMDE5LTEy
LTE4IDIxOjU5IC0wODAwXToNCj4gT24gV2VkLCBEZWMgMTgsIDIwMTkgYXQgNjoxNyBQTSBBbmRy
ZXkgSWduYXRvdiA8cmRuYUBmYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGVzdCByZXBsYWNpbmcg
YSBjZ3JvdXAtYnBmIHByb2dyYW0gYXR0YWNoZWQgd2l0aCBCUEZfRl9BTExPV19NVUxUSSBhbmQN
Cj4gPiBwb3NzaWJsZSBmYWlsdXJlIG1vZGVzOiBpbnZhbGlkIGNvbWJpbmF0aW9uIG9mIGZsYWdz
LCBpbnZhbGlkDQo+ID4gcmVwbGFjZV9icGZfZmQsIHJlcGxhY2luZyBhIG5vbi1hdHRhY2hkIHRv
IHNwZWNpZmllZCBjZ3JvdXAgcHJvZ3JhbS4NCj4gPg0KPiA+IEV4YW1wbGUgb2YgcHJvZ3JhbSBy
ZXBsYWNpbmc6DQo+ID4NCj4gPiAgICMgZ2RiIC1xIC0tYXJncyAuL3Rlc3RfcHJvZ3MgLS1uYW1l
PWNncm91cF9hdHRhY2hfbXVsdGkNCj4gPiAgIC4uLg0KPiA+ICAgQnJlYWtwb2ludCAxLCB0ZXN0
X2Nncm91cF9hdHRhY2hfbXVsdGkgKCkgYXQgY2dyb3VwX2F0dGFjaF9tdWx0aS5jOjIyNw0KPiA+
ICAgKGdkYikNCj4gPiAgIFsxXSsgIFN0b3BwZWQgICAgICAgICAgICAgICAgIGdkYiAtcSAtLWFy
Z3MgLi90ZXN0X3Byb2dzIC0tbmFtZT1jZ3JvdXBfYXR0YWNoX211bHRpDQo+ID4gICAjIGJwZnRv
b2wgYyBzIC9tbnQvY2dyb3VwMi9jZ3JvdXAtdGVzdC13b3JrLWRpci9jZzENCj4gPiAgIElEICAg
ICAgIEF0dGFjaFR5cGUgICAgICBBdHRhY2hGbGFncyAgICAgTmFtZQ0KPiA+ICAgMjEzMyAgICAg
ZWdyZXNzICAgICAgICAgIG11bHRpDQo+ID4gICAyMTM0ICAgICBlZ3Jlc3MgICAgICAgICAgbXVs
dGkNCj4gPiAgICMgZmcNCj4gPiAgIGdkYiAtcSAtLWFyZ3MgLi90ZXN0X3Byb2dzIC0tbmFtZT1j
Z3JvdXBfYXR0YWNoX211bHRpDQo+ID4gICAoZ2RiKSBjDQo+ID4gICBDb250aW51aW5nLg0KPiA+
DQo+ID4gICBCcmVha3BvaW50IDIsIHRlc3RfY2dyb3VwX2F0dGFjaF9tdWx0aSAoKSBhdCBjZ3Jv
dXBfYXR0YWNoX211bHRpLmM6MjMzDQo+ID4gICAoZ2RiKQ0KPiA+ICAgWzFdKyAgU3RvcHBlZCAg
ICAgICAgICAgICAgICAgZ2RiIC1xIC0tYXJncyAuL3Rlc3RfcHJvZ3MgLS1uYW1lPWNncm91cF9h
dHRhY2hfbXVsdGkNCj4gPiAgICMgYnBmdG9vbCBjIHMgL21udC9jZ3JvdXAyL2Nncm91cC10ZXN0
LXdvcmstZGlyL2NnMQ0KPiA+ICAgSUQgICAgICAgQXR0YWNoVHlwZSAgICAgIEF0dGFjaEZsYWdz
ICAgICBOYW1lDQo+ID4gICAyMTM5ICAgICBlZ3Jlc3MgICAgICAgICAgbXVsdGkNCj4gPiAgIDIx
MzQgICAgIGVncmVzcyAgICAgICAgICBtdWx0aQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5k
cmV5IElnbmF0b3YgPHJkbmFAZmIuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYnBmL3Byb2dfdGVz
dHMvY2dyb3VwX2F0dGFjaF9tdWx0aS5jICAgICAgfCA1MyArKysrKysrKysrKysrKysrKy0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3Rz
L2Nncm91cF9hdHRhY2hfbXVsdGkuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9n
X3Rlc3RzL2Nncm91cF9hdHRhY2hfbXVsdGkuYw0KPiA+IGluZGV4IDRlYWFiNzQzNTA0NC4uMmZm
MjFkYmNlMTc5IDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9w
cm9nX3Rlc3RzL2Nncm91cF9hdHRhY2hfbXVsdGkuYw0KPiA+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2Nncm91cF9hdHRhY2hfbXVsdGkuYw0KPiA+IEBAIC03
OCw3ICs3OCw4IEBAIHZvaWQgdGVzdF9jZ3JvdXBfYXR0YWNoX211bHRpKHZvaWQpDQo+ID4gIHsN
Cj4gPiAgICAgICAgIF9fdTMyIHByb2dfaWRzWzRdLCBwcm9nX2NudCA9IDAsIGF0dGFjaF9mbGFn
cywgc2F2ZWRfcHJvZ19pZDsNCj4gPiAgICAgICAgIGludCBjZzEgPSAwLCBjZzIgPSAwLCBjZzMg
PSAwLCBjZzQgPSAwLCBjZzUgPSAwLCBrZXkgPSAwOw0KPiA+IC0gICAgICAgaW50IGFsbG93X3By
b2dbNl0gPSB7LTF9Ow0KPiA+ICsgICAgICAgREVDTEFSRV9MSUJCUEZfT1BUUyhicGZfcHJvZ19h
dHRhY2hfb3B0cywgYXR0YWNoX29wdHMpOw0KPiA+ICsgICAgICAgaW50IGFsbG93X3Byb2dbN10g
PSB7LTF9Ow0KPiA+ICAgICAgICAgdW5zaWduZWQgbG9uZyBsb25nIHZhbHVlOw0KPiA+ICAgICAg
ICAgX191MzIgZHVyYXRpb24gPSAwOw0KPiA+ICAgICAgICAgaW50IGkgPSAwOw0KPiA+IEBAIC0x
ODksNiArMTkwLDUyIEBAIHZvaWQgdGVzdF9jZ3JvdXBfYXR0YWNoX211bHRpKHZvaWQpDQo+ID4g
ICAgICAgICBDSEVDS19GQUlMKGJwZl9tYXBfbG9va3VwX2VsZW0obWFwX2ZkLCAma2V5LCAmdmFs
dWUpKTsNCj4gPiAgICAgICAgIENIRUNLX0ZBSUwodmFsdWUgIT0gMSArIDIgKyA4ICsgMTYpOw0K
PiA+DQo+ID4gKyAgICAgICAvKiB0ZXN0IHJlcGxhY2UgKi8NCj4gPiArDQo+ID4gKyAgICAgICBh
dHRhY2hfb3B0cy5mbGFncyA9IEJQRl9GX0FMTE9XX09WRVJSSURFIHwgQlBGX0ZfUkVQTEFDRTsN
Cj4gPiArICAgICAgIGF0dGFjaF9vcHRzLnJlcGxhY2VfcHJvZ19mZCA9IGFsbG93X3Byb2dbMF07
DQo+ID4gKyAgICAgICBpZiAoQ0hFQ0soIWJwZl9wcm9nX2F0dGFjaF94YXR0cihhbGxvd19wcm9n
WzZdLCBjZzEsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBC
UEZfQ0dST1VQX0lORVRfRUdSRVNTLCAmYXR0YWNoX29wdHMpLA0KPiA+ICsgICAgICAgICAgICAg
ICAgICJmYWlsX3Byb2dfcmVwbGFjZV9vdmVycmlkZSIsICJ1bmV4cGVjdGVkIHN1Y2Nlc3NcbiIp
KQ0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIGVycjsNCj4gPiArICAgICAgIENIRUNLX0ZBSUwo
ZXJybm8gIT0gRUlOVkFMKTsNCj4gDQo+IENIRUNLIG1hY3JvIGFib3ZlIGNhbiBwcmludHMgYm90
aCBpbiBzdWNjZXNzIGFuZCBmYWlsdXJlIHNjZW5hcmlvcywNCj4gd2hpY2ggbWVhbnMgdGhhdCBl
cnJubyBvZiBicGZfcHJvZ19hdHRhY2hfeGF0dHIgY2FuIGJlIG92ZXJyaWRlbiBieSBhDQo+IGJ1
bmNoIG9mIG90aGVyIGZ1bmN0aW9ucy4gU28gaWYgdGhpcyBjaGVjayBpcyBjcml0aWNhbCwgeW91
J2QgaGF2ZSB0bw0KPiByZW1lbWJlciBlcnJubyBiZWZvcmUgY2FsbGluZyBDSEVDSy4gU2FtZSBm
b3IgYWxsIHRoZSBjaGVjayBiZWxvdy4NCg0KSWYgYnBmX3Byb2dfYXR0YWNoX3hhdHRyIGZpbmlz
aGVzIHN1Y2Nlc3NmdWxseSAod2hhdCBpcyB1bmV4cGVjdGVkDQpoZXJlKSwgYGdvdG8gZXJyYCB3
aWxsIGJlIHRha2VuIGFuZCBgQ0hFQ0tfRkFJTChlcnJubyAhPSBFSU5WQUwpYCB3b24ndA0KYmUg
cnVuIGF0IGFsbCBzbyAic3VjY2VzcyIgY2FzZSBpcyBub3QgYSBwcm9ibGVtLg0KDQpJZiBicGZf
cHJvZ19hdHRhY2hfeGF0dHIgZmFpbHMgKHdoYXQgaXMgZXhwZWN0ZWQpIGl0IGhhcyB0byBzZXQg
ZXJybm8NCmFuZCB0aGlzIGlzIHRoZSBlcnJubyB0aGF0IHdpbGwgYmUgY2hlY2tlZCBieSBDSEVD
S19GQUlMLCBpLmUuIGZhaWx1cmUNCmNhc2UgaXMgbm90IGEgcHJvYmxlbSBhdCBhbGwuDQoNCklm
IHlvdSBtZWFuIHByaW50ZigpIHRoYXQgaXMgY2FsbGVkIGZyb20gIlBBU1MiIGJyYW5jaCBvZiBD
SEVDSyB0aGVuIEkNCmRvbid0IGFjdHVhbGx5IHNlZSBhIHdheSB0byBkaXN0aW5ndWlzaCBlcnJu
byBmcm9tIGZhaWxlZA0KYnBmX3Byb2dfYXR0YWNoX3hhdHRyICh3aGF0IHdvdWxkIG1lYW4gIlBB
U1MiIGZvciB0aGUgQ0hFQ0spIGFuZA0KcHJpbnRmKCkgZnJvbSB0aGUgQ0hFQ0soKSB3L28gY2hh
bmdpbmcgQ0hFQ0soKSBpdHNlbGYuDQoNCkkgdGhpbmsgQ0hFQ0soKSBjYW4gYmUgaW1wcm92ZWQg
d3J0IGVycm5vIHNvIHRoYXQgaXQgc2F2ZXMgZXJybm8gYmVmb3JlDQpjYWxsaW5nIGFueXRoaW5n
IHRoYXQgY2FuIGFmZmVjdCBpdCBhbmQgcmVzdG9yZSBpdCBhZnRlcndhcmRzLiBCdXQgdGhpcw0K
aXMgbm90IHNwZWNpZmljIHRvIHRoaXMgcGF0Y2ggc28gSU1PIGl0IHNob3VsZCBiZSBkb25lIHNl
cGFyYXRlbHkgd2l0aCwNCmlkZWFsbHksIGNoZWNraW5nIHRoYXQgaXQgZG9lc24ndCBicmVhayBz
b21lIG90aGVyIHRlc3RzLg0KDQo+ID4gKw0KPiA+ICsgICAgICAgYXR0YWNoX29wdHMuZmxhZ3Mg
PSBCUEZfRl9SRVBMQUNFOw0KPiA+ICsgICAgICAgaWYgKENIRUNLKCFicGZfcHJvZ19hdHRhY2hf
eGF0dHIoYWxsb3dfcHJvZ1s2XSwgY2cxLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgQlBGX0NHUk9VUF9JTkVUX0VHUkVTUywgJmF0dGFjaF9vcHRzKSwNCj4g
PiArICAgICAgICAgICAgICAgICAiZmFpbF9wcm9nX3JlcGxhY2Vfbm9fbXVsdGkiLCAidW5leHBl
Y3RlZCBzdWNjZXNzXG4iKSkNCj4gPiArICAgICAgICAgICAgICAgZ290byBlcnI7DQo+ID4gKyAg
ICAgICBDSEVDS19GQUlMKGVycm5vICE9IEVJTlZBTCk7DQo+ID4gKw0KPiA+ICsgICAgICAgYXR0
YWNoX29wdHMuZmxhZ3MgPSBCUEZfRl9BTExPV19NVUxUSSB8IEJQRl9GX1JFUExBQ0U7DQo+ID4g
KyAgICAgICBhdHRhY2hfb3B0cy5yZXBsYWNlX3Byb2dfZmQgPSAtMTsNCj4gPiArICAgICAgIGlm
IChDSEVDSyghYnBmX3Byb2dfYXR0YWNoX3hhdHRyKGFsbG93X3Byb2dbNl0sIGNnMSwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJQRl9DR1JPVVBfSU5FVF9F
R1JFU1MsICZhdHRhY2hfb3B0cyksDQo+ID4gKyAgICAgICAgICAgICAgICAgImZhaWxfcHJvZ19y
ZXBsYWNlX2JhZF9mZCIsICJ1bmV4cGVjdGVkIHN1Y2Nlc3NcbiIpKQ0KPiA+ICsgICAgICAgICAg
ICAgICBnb3RvIGVycjsNCj4gPiArICAgICAgIENIRUNLX0ZBSUwoZXJybm8gIT0gRUJBREYpOw0K
PiA+ICsNCj4gPiArICAgICAgIC8qIHJlcGxhY2luZyBhIHByb2dyYW0gdGhhdCBpcyBub3QgYXR0
YWNoZWQgdG8gY2dyb3VwIHNob3VsZCBmYWlsICAqLw0KPiA+ICsgICAgICAgYXR0YWNoX29wdHMu
cmVwbGFjZV9wcm9nX2ZkID0gYWxsb3dfcHJvZ1szXTsNCj4gPiArICAgICAgIGlmIChDSEVDSygh
YnBmX3Byb2dfYXR0YWNoX3hhdHRyKGFsbG93X3Byb2dbNl0sIGNnMSwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJQRl9DR1JPVVBfSU5FVF9FR1JFU1MsICZh
dHRhY2hfb3B0cyksDQo+ID4gKyAgICAgICAgICAgICAgICAgImZhaWxfcHJvZ19yZXBsYWNlX25v
X2VudCIsICJ1bmV4cGVjdGVkIHN1Y2Nlc3NcbiIpKQ0KPiA+ICsgICAgICAgICAgICAgICBnb3Rv
IGVycjsNCj4gPiArICAgICAgIENIRUNLX0ZBSUwoZXJybm8gIT0gRU5PRU5UKTsNCj4gPiArDQo+
ID4gKyAgICAgICAvKiByZXBsYWNlIDFzdCBmcm9tIHRoZSB0b3AgcHJvZ3JhbSAqLw0KPiA+ICsg
ICAgICAgYXR0YWNoX29wdHMucmVwbGFjZV9wcm9nX2ZkID0gYWxsb3dfcHJvZ1swXTsNCj4gPiAr
ICAgICAgIGlmIChDSEVDSyhicGZfcHJvZ19hdHRhY2hfeGF0dHIoYWxsb3dfcHJvZ1s2XSwgY2cx
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCUEZfQ0dST1VQ
X0lORVRfRUdSRVNTLCAmYXR0YWNoX29wdHMpLA0KPiA+ICsgICAgICAgICAgICAgICAgICJwcm9n
X3JlcGxhY2UiLCAiZXJybm89JWRcbiIsIGVycm5vKSkNCj4gPiArICAgICAgICAgICAgICAgZ290
byBlcnI7DQo+ID4gKw0KPiA+ICsgICAgICAgdmFsdWUgPSAwOw0KPiA+ICsgICAgICAgQ0hFQ0tf
RkFJTChicGZfbWFwX3VwZGF0ZV9lbGVtKG1hcF9mZCwgJmtleSwgJnZhbHVlLCAwKSk7DQo+ID4g
KyAgICAgICBDSEVDS19GQUlMKHN5c3RlbShQSU5HX0NNRCkpOw0KPiA+ICsgICAgICAgQ0hFQ0tf
RkFJTChicGZfbWFwX2xvb2t1cF9lbGVtKG1hcF9mZCwgJmtleSwgJnZhbHVlKSk7DQo+ID4gKyAg
ICAgICBDSEVDS19GQUlMKHZhbHVlICE9IDY0ICsgMiArIDggKyAxNik7DQo+ID4gKw0KPiA+ICAg
ICAgICAgLyogZGV0YWNoIDNyZCBmcm9tIGJvdHRvbSBwcm9ncmFtIGFuZCBwaW5nIGFnYWluICov
DQo+ID4gICAgICAgICBpZiAoQ0hFQ0soIWJwZl9wcm9nX2RldGFjaDIoMCwgY2czLCBCUEZfQ0dS
T1VQX0lORVRfRUdSRVNTKSwNCj4gPiAgICAgICAgICAgICAgICAgICAiZmFpbF9wcm9nX2RldGFj
aF9mcm9tX2NnMyIsICJ1bmV4cGVjdGVkIHN1Y2Nlc3NcbiIpKQ0KPiA+IEBAIC0yMDIsNyArMjQ5
LDcgQEAgdm9pZCB0ZXN0X2Nncm91cF9hdHRhY2hfbXVsdGkodm9pZCkNCj4gPiAgICAgICAgIENI
RUNLX0ZBSUwoYnBmX21hcF91cGRhdGVfZWxlbShtYXBfZmQsICZrZXksICZ2YWx1ZSwgMCkpOw0K
PiA+ICAgICAgICAgQ0hFQ0tfRkFJTChzeXN0ZW0oUElOR19DTUQpKTsNCj4gPiAgICAgICAgIENI
RUNLX0ZBSUwoYnBmX21hcF9sb29rdXBfZWxlbShtYXBfZmQsICZrZXksICZ2YWx1ZSkpOw0KPiA+
IC0gICAgICAgQ0hFQ0tfRkFJTCh2YWx1ZSAhPSAxICsgMiArIDE2KTsNCj4gPiArICAgICAgIENI
RUNLX0ZBSUwodmFsdWUgIT0gNjQgKyAyICsgMTYpOw0KPiA+DQo+ID4gICAgICAgICAvKiBkZXRh
Y2ggMm5kIGZyb20gYm90dG9tIHByb2dyYW0gYW5kIHBpbmcgYWdhaW4gKi8NCj4gPiAgICAgICAg
IGlmIChDSEVDSyhicGZfcHJvZ19kZXRhY2gyKC0xLCBjZzQsIEJQRl9DR1JPVVBfSU5FVF9FR1JF
U1MpLA0KPiA+IEBAIC0yMTMsNyArMjYwLDcgQEAgdm9pZCB0ZXN0X2Nncm91cF9hdHRhY2hfbXVs
dGkodm9pZCkNCj4gPiAgICAgICAgIENIRUNLX0ZBSUwoYnBmX21hcF91cGRhdGVfZWxlbShtYXBf
ZmQsICZrZXksICZ2YWx1ZSwgMCkpOw0KPiA+ICAgICAgICAgQ0hFQ0tfRkFJTChzeXN0ZW0oUElO
R19DTUQpKTsNCj4gPiAgICAgICAgIENIRUNLX0ZBSUwoYnBmX21hcF9sb29rdXBfZWxlbShtYXBf
ZmQsICZrZXksICZ2YWx1ZSkpOw0KPiA+IC0gICAgICAgQ0hFQ0tfRkFJTCh2YWx1ZSAhPSAxICsg
MiArIDQpOw0KPiA+ICsgICAgICAgQ0hFQ0tfRkFJTCh2YWx1ZSAhPSA2NCArIDIgKyA0KTsNCj4g
Pg0KPiA+ICAgICAgICAgcHJvZ19jbnQgPSA0Ow0KPiA+ICAgICAgICAgQ0hFQ0tfRkFJTChicGZf
cHJvZ19xdWVyeShjZzUsIEJQRl9DR1JPVVBfSU5FVF9FR1JFU1MsDQo+ID4gLS0NCj4gPiAyLjE3
LjENCj4gPg0KDQotLSANCkFuZHJleSBJZ25hdG92DQo=
