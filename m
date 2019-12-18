Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9073124E7F
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2019 17:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfLRQ6h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Dec 2019 11:58:37 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34842 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727561AbfLRQ6g (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Dec 2019 11:58:36 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIGqPt1020295;
        Wed, 18 Dec 2019 08:58:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=81cMLMWP5gZNtkDeU4Gwk064KH5AOnkfsItCyBOispc=;
 b=T33bc7sHq0lmtg6Ye9TQ+Xeoaq68XkeBd7+LbR4+waIpYpmAYjs0ATO8deEN9sY8F6ns
 yU61+ziCV5NoimFIo1X/EYCngKGil8GJNWltp/22xExfewZmzsq9YOzJ5XBVNg4KQLgZ
 0AbZxoA6G97xI4ZifEfFGCr6Uhs425y+wv4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wyqv4g2rw-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 18 Dec 2019 08:58:21 -0800
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 08:57:59 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Dec 2019 08:57:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+K1d4km7ESAv620vObmIePOYoCdl+KuTDobbmlvBT4qGGuajBzl+raa2vb9P+g9AE2cTXk687tDUoDJuJquvITDHPVNn1tGdOHx90LNtnRHHgCyyJU2G/932W2g5JgJ032YoSHEN/XuBbeF9hGzw08sxCviYQir7ZaXRJK4B3qEmTAJE4DLskidASYaJYefZhyJWyIfMH13IweOHE4C/5jvFBlk4w+8iFIDpJzE01qhyc50pfTM2401BNwKIKxGl19fBGC1T2dZ8dJUVr9p2WlX6KOnsHysneAJOk1tJtLMj15EAJQIviALYQdLqcZtmjje8rnq/IshhfVzUFMHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81cMLMWP5gZNtkDeU4Gwk064KH5AOnkfsItCyBOispc=;
 b=J6fPXjvxaVSo+vGiIgNiclZ0/FLliP4qpbVIyV/xHpX1f8ZXMk0XEIdYRz09emPBsIzPajGv6qFgmsYe9rqjo/FVuBrUEnzMzsmdvd+BokxPBpqeBAxOzOoAGNVtoRBzCNhET1bv7Hnfs1KSEsz/70Ecia46NCPbOoFvF9WR+l04Gdpag3cfGBwHbhHLVmGnXek1oBEIVb+o1lf6bbR4L7kwLAqy8BY6WlGEEKjBDwtPI64unxoUNROGN5u88CnrrO5IxtNMZ38nMLrNSW//TBetFnZmHN5qPSMJdllWqTOVh5UoCVEUIjJ3fJeefKvLg/Z5++SQeiL4Z1FfK4EzFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81cMLMWP5gZNtkDeU4Gwk064KH5AOnkfsItCyBOispc=;
 b=gpGb9prg+97Rsh9UROdK3HN4D7M/YR1RRboY/C79P/PQHUnVT+5kA1NEay+S4Ve1LQHBF9ZZf8IQ1O723rDeRTbEtyoYZQd0J8m0bey66rNUBVp/2Vin4sKSqA5mlXGk7W9dY5oOiVppOyXwRGUzDHixYRBP/vZ6fiPFvNvIc30=
Received: from MWHPR15MB1294.namprd15.prod.outlook.com (10.175.3.150) by
 MWHPR15MB1424.namprd15.prod.outlook.com (10.173.234.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Wed, 18 Dec 2019 16:57:58 +0000
Received: from MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::5160:b3c0:bed1:e26c]) by MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::5160:b3c0:bed1:e26c%10]) with mapi id 15.20.2559.012; Wed, 18 Dec
 2019 16:57:57 +0000
Received: from localhost (2620:10d:c090:180::7ec8) by MWHPR1701CA0008.namprd17.prod.outlook.com (2603:10b6:301:14::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend Transport; Wed, 18 Dec 2019 16:57:57 +0000
From:   Andrey Ignatov <rdna@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>
CC:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        "Martin Lau" <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 6/6] selftests/bpf: Cover BPF_F_REPLACE in
 test_cgroup_attach
Thread-Topic: [PATCH v2 bpf-next 6/6] selftests/bpf: Cover BPF_F_REPLACE in
 test_cgroup_attach
Thread-Index: AQHVsURuuxkAl3N4Lkm2i24iTPRS86e3o64AgAiCXoA=
Date:   Wed, 18 Dec 2019 16:57:57 +0000
Message-ID: <20191218165755.GA94162@rdna-mbp.dhcp.thefacebook.com>
References: <cover.1576193131.git.rdna@fb.com>
 <bc55a274ea572d237bd091819f38502fa837abb5.1576193131.git.rdna@fb.com>
 <CAEf4Bza7KU1r3iRuXiwL7AiOnEbNmxx_hsEUZL8up2OVtJX3XA@mail.gmail.com>
In-Reply-To: <CAEf4Bza7KU1r3iRuXiwL7AiOnEbNmxx_hsEUZL8up2OVtJX3XA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1701CA0008.namprd17.prod.outlook.com
 (2603:10b6:301:14::18) To MWHPR15MB1294.namprd15.prod.outlook.com
 (2603:10b6:320:25::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::7ec8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3a1b952-ac3b-4feb-feec-08d783db6e93
x-ms-traffictypediagnostic: MWHPR15MB1424:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1424985A3FEC3D9A65278371A8530@MWHPR15MB1424.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39860400002)(136003)(366004)(189003)(199004)(8936002)(71200400001)(81166006)(81156014)(9686003)(5660300002)(8676002)(66446008)(64756008)(66556008)(6496006)(86362001)(16526019)(54906003)(110136005)(316002)(4001150100001)(52116002)(33656002)(53546011)(66946007)(478600001)(1076003)(4326008)(66476007)(186003)(2906002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1424;H:MWHPR15MB1294.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gRcKwhiFdsDskm55z3jq0YPX0au0z9v+lChjRldrJ1Z/BCTlSgDTEI9X/WHlo9yZX57KqDISYsD0xyqyMQgHxBHPTUH9yaf6VHXKxrS2DAiJQ4enH7SIv4semwgwNHa8PjiYZPk1d2+sRU68YLYzbUjypJl4jT2I2q5lnu9fDeqgIUdrBUpvKiEjNXeagCsJQLaCYTj8LO2AV1gpdpV64Zv7G8dTyN3k5gmYYk8hg5MpJdlipdhesKWDRAxaSZ2iCytdCqFMNEZ3MJHtvt7+afEYoG96Ckm9alT4HUcjThYYMO8f3yIQ0izrQVYnBMNZY3l/croOl5CD9iXpgCo2dwaHWquPoQ57SC7nHVdMt6//mZiWY1b68aflnYGM7csaE2JE3hhf1eMVSitSTfSilXtQoEDyx/r1Zwskg534Jv9owMFFFR/oCXqRMT1+EkiR
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FBD76767B247A4293EE34C2CA16556F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a1b952-ac3b-4feb-feec-08d783db6e93
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 16:57:57.8031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtwTl4Mv//q95i3BVFh3/sLTgpOVnJVQ4/LisjNJJ3lhUy3Jhjn+2cga3eupK8Sq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1424
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_05:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912180138
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

QW5kcmlpIE5ha3J5aWtvIDxhbmRyaWkubmFrcnlpa29AZ21haWwuY29tPiBbVGh1LCAyMDE5LTEy
LTEyIDIzOjAxIC0wODAwXToNCj4gT24gVGh1LCBEZWMgMTIsIDIwMTkgYXQgMzozNCBQTSBBbmRy
ZXkgSWduYXRvdiA8cmRuYUBmYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGVzdCByZXBsYWNlbWVu
dCBvZiBhIGNncm91cC1icGYgcHJvZ3JhbSBhdHRhY2hlZCB3aXRoIEJQRl9GX0FMTE9XX01VTFRJ
DQo+ID4gYW5kIHBvc3NpYmxlIGZhaWx1cmUgbW9kZXM6IGludmFsaWQgY29tYmluYXRpb24gb2Yg
ZmxhZ3MsIGludmFsaWQNCj4gPiByZXBsYWNlX2JwZl9mZCwgcmVwbGFjaW5nIGEgbm9uLWF0dGFj
aGQgdG8gc3BlY2lmaWVkIGNncm91cCBwcm9ncmFtLg0KPiA+DQo+ID4gRXhhbXBsZSBvZiBwcm9n
cmFtIHJlcGxhY2luZzoNCj4gPg0KPiA+ICAgIyBnZGIgLXEgLi90ZXN0X2Nncm91cF9hdHRhY2gN
Cj4gPiAgIFJlYWRpbmcgc3ltYm9scyBmcm9tIC9kYXRhL3VzZXJzL3JkbmEvYmluL3Rlc3RfY2dy
b3VwX2F0dGFjaC4uLmRvbmUuDQo+ID4gICAuLi4NCj4gPiAgIEJyZWFrcG9pbnQgMSwgdGVzdF9t
dWx0aXByb2cgKCkgYXQgdGVzdF9jZ3JvdXBfYXR0YWNoLmM6NDQzDQo+ID4gICA0NDMgICAgIHRl
c3RfY2dyb3VwX2F0dGFjaC5jOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5Lg0KPiA+ICAgKGdk
YikNCj4gPiAgIFsyXSsgIFN0b3BwZWQgICAgICAgICAgICAgICAgIGdkYiAtcSAuL3Rlc3RfY2dy
b3VwX2F0dGFjaA0KPiA+ICAgIyBicGZ0b29sIGMgcyAvbW50L2Nncm91cDIvY2dyb3VwLXRlc3Qt
d29yay1kaXIvY2cxDQo+ID4gICBJRCAgICAgICBBdHRhY2hUeXBlICAgICAgQXR0YWNoRmxhZ3Mg
ICAgIE5hbWUNCj4gPiAgIDM1ICAgICAgIGVncmVzcyAgICAgICAgICBtdWx0aQ0KPiA+ICAgMzYg
ICAgICAgZWdyZXNzICAgICAgICAgIG11bHRpDQo+ID4gICAjIGZnIGdkYiAtcSAuL3Rlc3RfY2dy
b3VwX2F0dGFjaA0KPiA+ICAgYw0KPiA+ICAgQ29udGludWluZy4NCj4gPiAgIERldGFjaGluZyBh
ZnRlciBmb3JrIGZyb20gY2hpbGQgcHJvY2VzcyAzNjEuDQo+ID4NCj4gPiAgIEJyZWFrcG9pbnQg
MiwgdGVzdF9tdWx0aXByb2cgKCkgYXQgdGVzdF9jZ3JvdXBfYXR0YWNoLmM6NDU0DQo+ID4gICA0
NTQgICAgIGluIHRlc3RfY2dyb3VwX2F0dGFjaC5jDQo+ID4gICAoZ2RiKQ0KPiA+ICAgWzJdKyAg
U3RvcHBlZCAgICAgICAgICAgICAgICAgZ2RiIC1xIC4vdGVzdF9jZ3JvdXBfYXR0YWNoDQo+ID4g
ICAjIGJwZnRvb2wgYyBzIC9tbnQvY2dyb3VwMi9jZ3JvdXAtdGVzdC13b3JrLWRpci9jZzENCj4g
PiAgIElEICAgICAgIEF0dGFjaFR5cGUgICAgICBBdHRhY2hGbGFncyAgICAgTmFtZQ0KPiA+ICAg
NDEgICAgICAgZWdyZXNzICAgICAgICAgIG11bHRpDQo+ID4gICAzNiAgICAgICBlZ3Jlc3MgICAg
ICAgICAgbXVsdGkNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBJZ25hdG92IDxyZG5h
QGZiLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL3NlbGZ0ZXN0cy9icGYvdGVzdF9jZ3JvdXBfYXR0
YWNoLmMgICAgICAgIHwgNjIgKysrKysrKysrKysrKysrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgNTcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiANCj4gSSBzZWNvbmQg
QWxleGVpJ3Mgc2VudGltZW50LiBIYXZpbmcgdGhpcyBhcyBwYXJ0IG9mIHRlc3RfcHJvZ3Mgd291
bGQNCj4gY2VydGFpbmx5IGJlIGJldHRlciBpbiB0ZXJtcyBvZiBlbnN1cmluZyB0aGlzIGRvZXNu
J3QgYWNjaWRlbnRhbGx5DQo+IGJyZWFrcy4NCg0KT0ssIEkgY29udmVydGVkIGJvdGggZXhpc3Rp
bmcgdGVzdF9jZ3JvdXBfYXR0YWNoIGFuZCBteSB0ZXN0IGZvcg0KQlBGX0ZfUkVQTEFDRSB0byB0
ZXN0X3Byb2dzIGFuZCB3aWxsIHNlbmQgdjMgd2l0aCB0aGlzIGNoYW5nZS4NCg0KDQo+IFsuLi5d
DQo+IA0KPiA+DQo+ID4gKyAgICAgICAvKiBpbnZhbGlkIGlucHV0ICovDQo+ID4gKw0KPiA+ICsg
ICAgICAgREVDTEFSRV9MSUJCUEZfT1BUUyhicGZfcHJvZ19hdHRhY2hfb3B0cywgYXR0YWNoX29w
dHMsDQo+ID4gKyAgICAgICAgICAgICAgIC50YXJnZXRfZmQgICAgICAgICAgICAgID0gY2cxLA0K
PiA+ICsgICAgICAgICAgICAgICAucHJvZ19mZCAgICAgICAgICAgICAgICA9IGFsbG93X3Byb2db
Nl0sDQo+ID4gKyAgICAgICAgICAgICAgIC5yZXBsYWNlX3Byb2dfZmQgICAgICAgID0gYWxsb3df
cHJvZ1swXSwNCj4gPiArICAgICAgICAgICAgICAgLnR5cGUgICAgICAgICAgICAgICAgICAgPSBC
UEZfQ0dST1VQX0lORVRfRUdSRVNTLA0KPiA+ICsgICAgICAgICAgICAgICAuZmxhZ3MgICAgICAg
ICAgICAgICAgICA9IEJQRl9GX0FMTE9XX01VTFRJIHwgQlBGX0ZfUkVQTEFDRSwNCj4gPiArICAg
ICAgICk7DQo+IA0KPiBUaGlzIG1pZ2h0IGNhdXNlIGNvbXBpbGVyIHdhcm5pbmdzIChkZXBlbmRp
bmcgb24gY29tcGlsZXIgc2V0dGluZ3MsIG9mDQo+IGNvdXJzZSkuIERFQ0xBUkVfTElCQlBGX09Q
VFMgZG9lcyBkZWNsYXJlIHZhcmlhYmxlLCBzbyB0aGlzIGlzIGENCj4gc2l0dWF0aW9uIG9mIG1p
eGluZyBjb2RlIGFuZCB2YXJpYWJsZSBkZWNsYXJhdGlvbnMsIHdoaWNoIHVuZGVyIEM4OQ0KPiAo
b3Igd2hhdGV2ZXIgaXQncyBuYW1lZCwgdGhlIG9sZGVyIHN0YW5kYXJkIHRoYXQga2VybmVsIGlz
IHRyeWluZyB0bw0KPiBzdGljayB0byBmb3IgdGhlIG1vc3QgcGFydCkgaXMgbm90IGFsbG93ZWQu
DQoNClllYWgsIEkga25vdyBhYm91dCBzdWNoIGEgd2FybmluZyBhbmQgZXhwZWN0ZWQgaXQgYnV0
IGRpZG4ndCBnZXQgaXQgd2l0aA0KdGhlIGN1cnJlbnQgc2V0dXAgKHdoYXQgc3VycHJpc2VkIG1l
IGJ0dykgYW5kIGRlY2lkZWQgdG8ga2VlcCBpdC4NCg0KVGhlIG1haW4gcmVhc29uIEkga2VwdCBp
dCBpcyBpdCdzIG5vdCBhY3R1YWxseSBjbGVhciBob3cgdG8gc2VwYXJhdGUNCmRlY2xhcmF0aW9u
IGFuZCBpbml0aWFsaXphdGlvbiBvZiBvcHRzIHN0cnVjdHVyZSB3aGVuDQpERUNMQVJFX0xJQkJQ
Rl9PUFRTIGlzIHVzZWQgc2luY2UgdGhlIG1hY3JvIGRvZXMgYm90aCB0aGluZ3MgYXQgb25jZS4g
SW4NCnNlbGZ0ZXN0cyBJIGNhbiBqdXN0IHN3aXRjaCB0byBkaXJlY3QgaW5pdGlhbGl6YXRpb24g
KHcvbyB0aGUgbWFjcm8pDQpzaW5jZSBsaWJicGYgYW5kIHNlbGZ0ZXN0cyBhcmUgaW4gc3luYywg
YnV0IGZvciByZWFsIHVzZS1jYXNlcyB0aGVyZQ0Kc2hvdWxkIGJlIHNtdGggZWxzZSAoZS5nLiBJ
TklUX0xJQkJQRl9PUFRTIG1hY3JvIHRoYXQgZG9lcyBvbmx5DQppbml0aWFsaXphdGlvbiBvZiBh
bHJlYWR5IGRlY2xhcmVkIHN0cnVjdCkuDQoNCg0KPiA+ICsNCj4gPiArICAgICAgIGF0dGFjaF9v
cHRzLmZsYWdzID0gQlBGX0ZfQUxMT1dfT1ZFUlJJREUgfCBCUEZfRl9SRVBMQUNFOw0KPiA+ICsg
ICAgICAgaWYgKCFicGZfcHJvZ19hdHRhY2hfeGF0dHIoJmF0dGFjaF9vcHRzKSkgew0KPiA+ICsg
ICAgICAgICAgICAgICBsb2dfZXJyKCJVbmV4cGVjdGVkIHN1Y2Nlc3Mgd2l0aCBPVkVSUklERSB8
IFJFUExBQ0UiKTsNCj4gPiArICAgICAgICAgICAgICAgZ290byBlcnI7DQo+ID4gKyAgICAgICB9
DQo+ID4gKyAgICAgICBhc3NlcnQoZXJybm8gPT0gRUlOVkFMKTsNCj4gPiArDQoNCi0tIA0KQW5k
cmV5IElnbmF0b3YNCg==
