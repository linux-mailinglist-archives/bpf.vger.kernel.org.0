Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF78C102EDB
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 23:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfKSWKA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Nov 2019 17:10:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3284 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725923AbfKSWJ7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 19 Nov 2019 17:09:59 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xAJM7pAM017895;
        Tue, 19 Nov 2019 14:09:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=wj1CioHT5uFw/srkSEwFz7QZAt7J1DfEd9RuXVR+7KE=;
 b=md6utt3pS+YaRsXWsX7EL+owf1CnK0mqSsZFiRXpfIDd7kTlQ5COXmBsl7N+Ml3XAVqc
 HKxUt46osp3xVFHbKPrYPbpi4kPAkOn10jn5fLXcD9ITDt3Q44KGjDE+yfImB/3GLWPi
 fFJh/oTNTsj30Zu3uveZEILt/0yeQNQFrQA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2wchf72ecw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 19 Nov 2019 14:09:46 -0800
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 Nov 2019 14:09:45 -0800
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 Nov 2019 14:09:45 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 19 Nov 2019 14:09:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7LaKaek85mLB50XefG3H9r73D81lSFtCLcYg58aUeaz0Q3oiAy0jLr8L9C2HT1gDKP1n6xFeKhfK6gdxODv2mQ4VcF6u6WU5cb9SHObJhNETvi3K3Th+iZfkZD2hxX8IliNsJJlpTp3PSzw9110wY1C/KND89PoDZRHFYd3FYCqGhsD3kE96bcxPFW5m6DCSG6+DIDfs+lHMn+jcj7+BS6mXhhcfGt/8xVjaGwIN1viO2NkuVeKn0QGIWAH68Ra+lu0eu4+Xd90ahJoUwH5DKNS4GdxhvXD62eHD7UR54+h091M2VMeGE8CtnAR6rcuFzmfC8svAgO2BBVrZHG9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wj1CioHT5uFw/srkSEwFz7QZAt7J1DfEd9RuXVR+7KE=;
 b=W4enic5X3yqhzOe14hqfxGRTJRys+kADZqGTD7oqYmoWEKXK6HuGFdtA94Dx0eALV8jz7kWwtUL2ZzHGDpSJDoM2AbgIUljxPunjTunFQbt9F22RaPY8g1V6hU6MGcgSW/yYYQ8X3ZcTlmhYbSVSCYqA7qtSCN0rBf3ZmxTrCqDFwJt04REa5xp+4/YpIJFTNdQlyfdh40ktXrpLguI9ozGVhkuC7NKo85hWBWhS4dXtY2AlAjNQ0spjN0byjRGDMm1wHdx49uzuJLrm9uWlKcVzCjIC623WPdaRV/SO5byxpMqf3NV+27Ab6XKsF5XBzGRkpc1ySAumDmm0HEDkzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wj1CioHT5uFw/srkSEwFz7QZAt7J1DfEd9RuXVR+7KE=;
 b=MjbGq+aFB1buYjXAjAh59pRrt0t5zHjDTeCs5qd5u9JSpAilIJ/xnNcIsP7Q7XFJzeTFnrto89SS6FgRwpcKZw5MI09+3q+Jf7SA+jGOFmGvx5iiuE3aYHX4uuCXUZE9nb1Icgf/VNslqKYHjuOgJG7pY1LCx1EChenLN4EX7VU=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYAPR15MB3429.namprd15.prod.outlook.com (20.179.58.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 19 Nov 2019 22:09:44 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::a9f8:a9c0:854c:d680]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::a9f8:a9c0:854c:d680%4]) with mapi id 15.20.2474.015; Tue, 19 Nov 2019
 22:09:44 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: allow s32/u32 return types in
 verifier for bpf helpers
Thread-Topic: [PATCH bpf-next v2 2/3] bpf: allow s32/u32 return types in
 verifier for bpf helpers
Thread-Index: AQHVnxOR7mAOdKrcXUWqlis6kEFbSaeTC2gAgAAChYA=
Date:   Tue, 19 Nov 2019 22:09:43 +0000
Message-ID: <b595c11d-384b-414b-f90b-328714c3a2cd@fb.com>
References: <20191119195711.3691681-1-yhs@fb.com>
 <20191119195712.3692027-1-yhs@fb.com>
 <20191119220038.6q2y7lwum5liie4e@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20191119220038.6q2y7lwum5liie4e@ast-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:300:117::33) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:f173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61fbf00f-a826-4ab1-193f-08d76d3d2e7c
x-ms-traffictypediagnostic: BYAPR15MB3429:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB3429BC85E17E13306248B5C6D34C0@BYAPR15MB3429.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(396003)(39860400002)(189003)(199004)(6916009)(8936002)(36756003)(81156014)(8676002)(81166006)(446003)(478600001)(11346002)(25786009)(99286004)(305945005)(7736002)(46003)(14454004)(316002)(486006)(476003)(2616005)(186003)(54906003)(102836004)(53546011)(6512007)(6506007)(256004)(6246003)(6486002)(86362001)(386003)(229853002)(2906002)(76176011)(64756008)(66556008)(66476007)(31696002)(52116002)(66446008)(6116002)(31686004)(71190400001)(4326008)(71200400001)(6436002)(66946007)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3429;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jtVoUwX/x+nzJ87TsMsvHOboFT2jyn5ROJrMhdTlR55ga3pSe+MVroS8wcQtFzCzjA2hPlus8+ZvsXAYPEP1Ttjgef0XD6e5wqyOkAeDXsxA+nKTGbEAtmXeolDHPTKPf6zZmLRiy3AtSC+FREuS4GXHYH7+ufx8FXYMSZ25gGM64iKj9pncbozAB98sPnylN4gsG3RhYrOD5arhAe3biQYmiCGUpugFkxN5P2QuD11TJVk7V9yuhvy0A0Xziq2kIJ928hx9NTLglMgZmNvAWQcU9ZuE2U9yfy4Ju6xUYoTF8l8V/1hsSwbMrKqVRgh754SD4wFVsqHGsEAfRhucY5r1i3QVXkuWKsgXcL+TgruKfuTmiiqt8z0l5rbb/noYnsNWU1mO2hW5YP3zgj7Z0DdjfEtihNCEBCWMTsIyrPQOs+ub3mh+yppQvIdp0plt
Content-Type: text/plain; charset="utf-8"
Content-ID: <17FCB1689A5CBD45851258EC110B66D8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fbf00f-a826-4ab1-193f-08d76d3d2e7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 22:09:43.9590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Ho7Z02c+YDBy5YcCIFekRj71iK9IJR5uM96l9FlXMPs/hvi3bY3whAjDs/yazxm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3429
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_08:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911190178
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDExLzE5LzE5IDI6MDAgUE0sIEFsZXhlaSBTdGFyb3ZvaXRvdiB3cm90ZToNCj4gT24g
VHVlLCBOb3YgMTksIDIwMTkgYXQgMTE6NTc6MTJBTSAtMDgwMCwgWW9uZ2hvbmcgU29uZyB3cm90
ZToNCj4+ICAgI2RlZmluZSBUTlVNKF92LCBfbSkJKHN0cnVjdCB0bnVtKXsudmFsdWUgPSBfdiwg
Lm1hc2sgPSBfbX0NCj4+IC0vKiBBIGNvbXBsZXRlbHkgdW5rbm93biB2YWx1ZSAqLw0KPj4gKy8q
IGNvbXBsZXRlbHkgdW5rbm93biAzMi1iaXQgYW5kIDY0LWJpdCB2YWx1ZXMgKi8NCj4+ICtjb25z
dCBzdHJ1Y3QgdG51bSB0bnVtX3Vua25vd24zMiA9IHsgLnZhbHVlID0gMCwgLm1hc2sgPSAweGZm
ZmZmZmZmVUxMIH07DQo+PiAgIGNvbnN0IHN0cnVjdCB0bnVtIHRudW1fdW5rbm93biA9IHsgLnZh
bHVlID0gMCwgLm1hc2sgPSAtMSB9Ow0KPj4gICANCj4+ICAgc3RydWN0IHRudW0gdG51bV9jb25z
dCh1NjQgdmFsdWUpDQo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi92ZXJpZmllci5jIGIva2Vy
bmVsL2JwZi92ZXJpZmllci5jDQo+PiBpbmRleCBhMzQ0YjA4YWVmNzcuLjk0NTgyNzM1MTc1OCAx
MDA2NDQNCj4+IC0tLSBhL2tlcm5lbC9icGYvdmVyaWZpZXIuYw0KPj4gKysrIGIva2VybmVsL2Jw
Zi92ZXJpZmllci5jDQo+PiBAQCAtMTAyNCw2ICsxMDI0LDE1IEBAIHN0YXRpYyB2b2lkIF9fbWFy
a19yZWdfdW5ib3VuZGVkKHN0cnVjdCBicGZfcmVnX3N0YXRlICpyZWcpDQo+PiAgIAlyZWctPnVt
YXhfdmFsdWUgPSBVNjRfTUFYOw0KPj4gICB9DQo+PiAgIA0KPj4gKy8qIFJlc2V0IHRoZSBtaW4v
bWF4IGJvdW5kcyBvZiBhIHN1YiByZWdpc3RlciAqLw0KPj4gK3N0YXRpYyB2b2lkIF9fbWFya19z
dWJyZWdfdW5ib3VuZGVkKHN0cnVjdCBicGZfcmVnX3N0YXRlICpzdWJyZWcpDQo+PiArew0KPj4g
KwlzdWJyZWctPnNtaW5fdmFsdWUgPSBTMzJfTUlOOw0KPj4gKwlzdWJyZWctPnNtYXhfdmFsdWUg
PSBTMzJfTUFYOw0KPj4gKwlzdWJyZWctPnVtaW5fdmFsdWUgPSAwOw0KPj4gKwlzdWJyZWctPnVt
YXhfdmFsdWUgPSBVMzJfTUFYOw0KPj4gK30NCj4gDQo+IHdoZW4gaW50MzIgaXMgcmV0dXJuZWQg
dGhlIGFib3ZlIGZlZWxzIGNvcnJlY3QsIGJ1dCBJIHRoaW5rIGl0IGNvbmZsaWN0cyB3aXRoDQo+
IGRlZmluaXRpb24gb2YgdG51bV91bmtub3duMzIsIHNpbmNlIGl0IHNheXMgdGhhdCB1cHBlciAz
Mi1iaXQgc2hvdWxkIGJlIHplcm8uDQo+IFRoZSB0eXBpY2FsIHZlcmlmaWVyIGFjdGlvbiBhZnRl
ciBwcm9jZXNzaW5nIGFsdTMyIGluc246DQo+ICAgICAgICAgIGlmIChCUEZfQ0xBU1MoaW5zbi0+
Y29kZSkgIT0gQlBGX0FMVTY0KSB7DQo+ICAgICAgICAgICAgICAgICAgLyogMzItYml0IEFMVSBv
cHMgYXJlICgzMiwzMiktPjMyICovDQo+ICAgICAgICAgICAgICAgICAgY29lcmNlX3JlZ190b19z
aXplKGRzdF9yZWcsIDQpOw0KPiAgICAgICAgICB9DQo+IA0KPiAgICAgICAgICBfX3JlZ19kZWR1
Y2VfYm91bmRzKGRzdF9yZWcpOw0KPiAgICAgICAgICBfX3JlZ19ib3VuZF9vZmZzZXQoZHN0X3Jl
Zyk7DQo+IA0KPiBBbmQgdGhhdCBpcyBjb3JyZWN0IGJlaGF2aW9yIGZvciBhbHUzMiwgYnV0IGhl
cmUgdGhlIGhlbHBlciBpcyByZXR1cm5pbmcNCj4gJ2ludCcsIHNvIGlmIHRoZSB2ZXJpZmllciBz
YXlzIHN1YnJlZy0+c21pbl92YWx1ZSA9IFMzMl9NSU47DQo+IGl0IG1lYW5zIHRoYXQgdXBwZXIg
Yml0cyB3aWxsIGJlIG5vbi16ZXJvLg0KPiBUaGUgaGVscGVyIGNhbiByZXR1cm4gKHU2NCktMSB3
aXRoIGFsbCA2NC1iaXRzIGJlaW5nIHNldCB0byAxLg0KPiBJZiBuZXh0IGluc24gYWZ0ZXIgdzAg
PSBjYWxsIGhlbHBlcjsgaXMgdzAgKz0gaW1tOw0KPiB0aGUgdmVyaWZpZXIgd2lsbCBkbyBhYm92
ZSBjb2VyY2UrZGVkdWNlIGxvZ2ljIGFuZCBjbGVhciB1cHBlciBiaXRzLg0KPiBUaGF0J3MgY29y
cmVjdCwgYnV0IHdpdGhvdXQgZXh0cmEgYWx1MzIgb3BlcmF0aW9uIG9uIHcwIHRoZSBzdGF0ZQ0K
PiBvZiByMCBpcyB0ZWNobmljYWxseSBjb3JyZWN0LCBidXQgZG9lc24ndCBtYXRjaCByMC0+dmFy
X3JlZw0KPiB3aGljaCBpcyB0bnVtX3Vua25vd24zMi4NCj4gSSB3b25kZXIgd2hldGhlciBpdCBz
aG91bGQgYmUgdG51bV91bmtub3duIGluc3RlYWQgd2l0aCBhYm92ZQ0KPiBfX21hcmtfc3VicmVn
X3VuYm91bmRlZCgpID8NCg0KdG51bV91bmtub3duIHNob3VsZCB3b3JrIHNpbmNlIHN1YnJlZyB7
c21pbixzbWF4LHVtaW4sdW1heH1fdmFsdWUNCmFsbCBpbiAzMi1iaXQgcmFuZ2UuIFRoZSBtYXNr
ICgtMSkgc2hvdWxkIHdvcmsgYXMgdXBwZXIgMzItYml0IHVuc2lnbmVkIA0KdmFsdWUgaXMgYWx3
YXlzIDAuDQoNCldpbGwgbWFrZSB0aGUgY2hhbmdlIGFuZCBzZW5kIGFub3RoZXIgcmV2aXNpb24u
DQoNCj4gDQo+PiArDQo+PiAgIC8qIE1hcmsgYSByZWdpc3RlciBhcyBoYXZpbmcgYSBjb21wbGV0
ZWx5IHVua25vd24gKHNjYWxhcikgdmFsdWUuICovDQo+PiAgIHN0YXRpYyB2b2lkIF9fbWFya19y
ZWdfdW5rbm93bihzdHJ1Y3QgYnBmX3JlZ19zdGF0ZSAqcmVnKQ0KPj4gICB7DQo+PiBAQCAtMTAz
OCw2ICsxMDQ3LDIwIEBAIHN0YXRpYyB2b2lkIF9fbWFya19yZWdfdW5rbm93bihzdHJ1Y3QgYnBm
X3JlZ19zdGF0ZSAqcmVnKQ0KPj4gICAJX19tYXJrX3JlZ191bmJvdW5kZWQocmVnKTsNCj4+ICAg
fQ0KPj4gICANCj4+ICsvKiBNYXJrIGEgc3ViIHJlZ2lzdGVyIGFzIGhhdmluZyBhIGNvbXBsZXRl
bHkgdW5rbm93biAoc2NhbGFyKSB2YWx1ZS4gKi8NCj4+ICtzdGF0aWMgdm9pZCBfX21hcmtfc3Vi
cmVnX3Vua25vd24oc3RydWN0IGJwZl9yZWdfc3RhdGUgKnN1YnJlZykNCj4+ICt7DQo+PiArCS8q
DQo+PiArCSAqIENsZWFyIHR5cGUsIGlkLCBvZmYsIGFuZCB1bmlvbihtYXBfcHRyLCByYW5nZSkg
YW5kDQo+PiArCSAqIHBhZGRpbmcgYmV0d2VlbiAndHlwZScgYW5kIHVuaW9uDQo+PiArCSAqLw0K
Pj4gKwltZW1zZXQoc3VicmVnLCAwLCBvZmZzZXRvZihzdHJ1Y3QgYnBmX3JlZ19zdGF0ZSwgdmFy
X29mZikpOw0KPj4gKwlzdWJyZWctPnR5cGUgPSBTQ0FMQVJfVkFMVUU7DQo+PiArCXN1YnJlZy0+
dmFyX29mZiA9IHRudW1fdW5rbm93bjMyOw0KPj4gKwlzdWJyZWctPmZyYW1lbm8gPSAwOw0KPj4g
KwlfX21hcmtfc3VicmVnX3VuYm91bmRlZChzdWJyZWcpOw0KPj4gK30NCj4gDQo=
