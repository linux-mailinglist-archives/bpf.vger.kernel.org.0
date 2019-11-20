Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B00B104702
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2019 00:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfKTXfg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Nov 2019 18:35:36 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39600 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725878AbfKTXfg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Nov 2019 18:35:36 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAKNX5OZ007948;
        Wed, 20 Nov 2019 15:35:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=qKPeoW4ef/5LSL7S9Yd7Y1X9cV4AkL/GU9PaKgyrnv4=;
 b=GkGdJpHc7qI2B0L1A9Kc2TOZbTSvM3HAu0L0/Rl5V2XQoV06h4pweQI/Oq5WYoL2u4d5
 Bzz/0vWIdBaPQcR/GD4PnoanWLTu+/FmcQ3SYrmV70KwW+61BMHaACuGsJmQDy3Cw20P
 BptTxgTYtmf1J1DV/SQ/qw1WruhUkXfdWPA= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wc6abbx8s-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Nov 2019 15:35:15 -0800
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 20 Nov 2019 15:35:06 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 20 Nov 2019 15:35:06 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 20 Nov 2019 15:35:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoyqPx2n/Z4TjefNOoU4YZnWAHTjThfmgHDAMZLmzpl1eR4NMBIF/NrFO3B4XQ3nevYAUvBZjFofxBZxhk+1JS54srT9lw8v7r7jbQq8lyumSQgKkBmXXOE8XwaNUt10/YXx+78Xzz9Hjiiku/i2n8JcjOVjQB7pS9EYN2F2sBkskBNy9vTidv5Y7EbQHVQutcfadry/Cc0guKTE/d1S98Ft9Iw51wtkNCkZwzVNcHZt85HHqALVrRW+cKyTZ1G1wuS+tcfHROGSE1qsoK4AAu3HgNUqvuMWNlTYK+3N1YQ3Rg2GC/XSx0OU+iO3yGaS51EHVj80yC3xH2tbHggENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKPeoW4ef/5LSL7S9Yd7Y1X9cV4AkL/GU9PaKgyrnv4=;
 b=WLd+EGzCBs4a1NiHTi4PPBwG0zt0kKBE9xSDdTrZgXxdm9mIWi5EOv6AfsyrmjYhtXRUnYObTKNvGcl3lexeBwEus1gBEUjdpx5dq2gM7ex0gYly8UGS2HvQ67Ij2W4UK2f6b2BDuRZUkhUTko8SvX8wfRSAinaJ3pwM1pAFp/d/w7WX1WgHzM+jVe9Kv8ZbIuYtxpR9NtUhE1IwdJ33NDKvYH8Jdd3EtUBaUmSMw9NBxSEIWLAMU3ZDn2gm5DQwrsvpiUGGQalekOZP1KwgopQUm4eR7/K/Zrq6HPAHhfNcCxy6cyhPsRv2hqds0nYwT3qfzQwyipn2BnSJjRnjrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKPeoW4ef/5LSL7S9Yd7Y1X9cV4AkL/GU9PaKgyrnv4=;
 b=bVpIbdaYyd0exef3mYQpHw1uwqQkjZaVEFtNVVXHddOzCS5q3S+3lw5Jjs5DMO2ShrLIpWEuaqmFxW6TNxoqo73wlGYlh94AAvq5tVXi5VIK4MN72kp5TbdOZ9M3erPl0c6bZDJ+KrcdGjtagVuL5KU/T1gBFgqZD4xrSoFaQ/I=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYAPR15MB2838.namprd15.prod.outlook.com (20.178.206.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 23:35:05 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::a9f8:a9c0:854c:d680]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::a9f8:a9c0:854c:d680%4]) with mapi id 15.20.2474.018; Wed, 20 Nov 2019
 23:35:05 +0000
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
Thread-Index: AQHVnxOR7mAOdKrcXUWqlis6kEFbSaeTC2gAgAAChYCAAaouAA==
Date:   Wed, 20 Nov 2019 23:35:05 +0000
Message-ID: <0e7d5b81-5554-dba0-0a72-83323506340b@fb.com>
References: <20191119195711.3691681-1-yhs@fb.com>
 <20191119195712.3692027-1-yhs@fb.com>
 <20191119220038.6q2y7lwum5liie4e@ast-mbp.dhcp.thefacebook.com>
 <b595c11d-384b-414b-f90b-328714c3a2cd@fb.com>
In-Reply-To: <b595c11d-384b-414b-f90b-328714c3a2cd@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0016.namprd10.prod.outlook.com (2603:10b6:301::26)
 To BYAPR15MB3384.namprd15.prod.outlook.com (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::f768]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d16c1f6a-7de2-40ce-d119-08d76e124575
x-ms-traffictypediagnostic: BYAPR15MB2838:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB283831E456D2609B3F458918D34F0@BYAPR15MB2838.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(136003)(39860400002)(189003)(199004)(6486002)(8676002)(6436002)(81156014)(7736002)(305945005)(81166006)(478600001)(66446008)(64756008)(66946007)(2906002)(71190400001)(6512007)(66556008)(66476007)(71200400001)(5660300002)(6306002)(186003)(25786009)(31696002)(14454004)(46003)(316002)(76176011)(256004)(6116002)(229853002)(6916009)(14444005)(966005)(4326008)(52116002)(11346002)(53546011)(446003)(102836004)(2616005)(31686004)(476003)(36756003)(86362001)(8936002)(6506007)(386003)(99286004)(54906003)(6246003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2838;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bknf/pBQW4KM8xAYfbonq/BaBPulrLpm1eYjbjJxK+Sqp9WZ5XpBf5ShkRXMZFl9vg0rVvt43nqcEkc1oHGhmlXPEyau0qHP+qUf1el6SZrF4pS61awHD0iSKxfPsEV8SyM2LZtpoCgMdzEyMFM6jjilFEGydEmxZfpbGbYla2Hp93CnkIqf+JuDV/Us43J9k2Ry6L0nQhmu4PVfyHJ51k+RkHnzOmRW1gasWpMvIq2V8UeAcDCkzMzrBW1wK6cJ4QJ77f4a1UWhJDD4RiCvQdvYiggPzB90zi/Hef6UFmYBml/01DaU4GbK9BuhFSL9fWgFNCeqh4TE14esdj+KFPQrcaQ6i4M+PniPHK9QoDCHMp+7cdm9xsBXf5ZewWZJWEGX8158mz/5EkyUe66+ypIxAYWgcCTGTgMeI+rhhErOuVcyKV2DVYot5YVSF3+LAC3QFYxNGHAAGb9mTLkchC8jJFvlRBslIVG7O7gZmiE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A199EBA5E60E045AA20DECBACCDFE77@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d16c1f6a-7de2-40ce-d119-08d76e124575
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 23:35:05.2109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ahadqGuGXoe0B9gCmJ53owyh8lOpxnteCpxhIttOVVTAwCE5ffHIZaSbi3MAp9bm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2838
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_08:2019-11-20,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=834 suspectscore=0 impostorscore=0
 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911200197
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDExLzE5LzE5IDI6MDkgUE0sIFlvbmdob25nIFNvbmcgd3JvdGU6DQo+IA0KPiANCj4g
T24gMTEvMTkvMTkgMjowMCBQTSwgQWxleGVpIFN0YXJvdm9pdG92IHdyb3RlOg0KPj4gT24gVHVl
LCBOb3YgMTksIDIwMTkgYXQgMTE6NTc6MTJBTSAtMDgwMCwgWW9uZ2hvbmcgU29uZyB3cm90ZToN
Cj4+PiAgICAjZGVmaW5lIFROVU0oX3YsIF9tKQkoc3RydWN0IHRudW0pey52YWx1ZSA9IF92LCAu
bWFzayA9IF9tfQ0KPj4+IC0vKiBBIGNvbXBsZXRlbHkgdW5rbm93biB2YWx1ZSAqLw0KPj4+ICsv
KiBjb21wbGV0ZWx5IHVua25vd24gMzItYml0IGFuZCA2NC1iaXQgdmFsdWVzICovDQo+Pj4gK2Nv
bnN0IHN0cnVjdCB0bnVtIHRudW1fdW5rbm93bjMyID0geyAudmFsdWUgPSAwLCAubWFzayA9IDB4
ZmZmZmZmZmZVTEwgfTsNCj4+PiAgICBjb25zdCBzdHJ1Y3QgdG51bSB0bnVtX3Vua25vd24gPSB7
IC52YWx1ZSA9IDAsIC5tYXNrID0gLTEgfTsNCj4+PiAgICANCj4+PiAgICBzdHJ1Y3QgdG51bSB0
bnVtX2NvbnN0KHU2NCB2YWx1ZSkNCj4+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi92ZXJpZmll
ci5jIGIva2VybmVsL2JwZi92ZXJpZmllci5jDQo+Pj4gaW5kZXggYTM0NGIwOGFlZjc3Li45NDU4
MjczNTE3NTggMTAwNjQ0DQo+Pj4gLS0tIGEva2VybmVsL2JwZi92ZXJpZmllci5jDQo+Pj4gKysr
IGIva2VybmVsL2JwZi92ZXJpZmllci5jDQo+Pj4gQEAgLTEwMjQsNiArMTAyNCwxNSBAQCBzdGF0
aWMgdm9pZCBfX21hcmtfcmVnX3VuYm91bmRlZChzdHJ1Y3QgYnBmX3JlZ19zdGF0ZSAqcmVnKQ0K
Pj4+ICAgIAlyZWctPnVtYXhfdmFsdWUgPSBVNjRfTUFYOw0KPj4+ICAgIH0NCj4+PiAgICANCj4+
PiArLyogUmVzZXQgdGhlIG1pbi9tYXggYm91bmRzIG9mIGEgc3ViIHJlZ2lzdGVyICovDQo+Pj4g
K3N0YXRpYyB2b2lkIF9fbWFya19zdWJyZWdfdW5ib3VuZGVkKHN0cnVjdCBicGZfcmVnX3N0YXRl
ICpzdWJyZWcpDQo+Pj4gK3sNCj4+PiArCXN1YnJlZy0+c21pbl92YWx1ZSA9IFMzMl9NSU47DQo+
Pj4gKwlzdWJyZWctPnNtYXhfdmFsdWUgPSBTMzJfTUFYOw0KPj4+ICsJc3VicmVnLT51bWluX3Zh
bHVlID0gMDsNCj4+PiArCXN1YnJlZy0+dW1heF92YWx1ZSA9IFUzMl9NQVg7DQo+Pj4gK30NCj4+
DQo+PiB3aGVuIGludDMyIGlzIHJldHVybmVkIHRoZSBhYm92ZSBmZWVscyBjb3JyZWN0LCBidXQg
SSB0aGluayBpdCBjb25mbGljdHMgd2l0aA0KPj4gZGVmaW5pdGlvbiBvZiB0bnVtX3Vua25vd24z
Miwgc2luY2UgaXQgc2F5cyB0aGF0IHVwcGVyIDMyLWJpdCBzaG91bGQgYmUgemVyby4NCj4+IFRo
ZSB0eXBpY2FsIHZlcmlmaWVyIGFjdGlvbiBhZnRlciBwcm9jZXNzaW5nIGFsdTMyIGluc246DQo+
PiAgICAgICAgICAgaWYgKEJQRl9DTEFTUyhpbnNuLT5jb2RlKSAhPSBCUEZfQUxVNjQpIHsNCj4+
ICAgICAgICAgICAgICAgICAgIC8qIDMyLWJpdCBBTFUgb3BzIGFyZSAoMzIsMzIpLT4zMiAqLw0K
Pj4gICAgICAgICAgICAgICAgICAgY29lcmNlX3JlZ190b19zaXplKGRzdF9yZWcsIDQpOw0KPj4g
ICAgICAgICAgIH0NCj4+DQo+PiAgICAgICAgICAgX19yZWdfZGVkdWNlX2JvdW5kcyhkc3RfcmVn
KTsNCj4+ICAgICAgICAgICBfX3JlZ19ib3VuZF9vZmZzZXQoZHN0X3JlZyk7DQo+Pg0KPj4gQW5k
IHRoYXQgaXMgY29ycmVjdCBiZWhhdmlvciBmb3IgYWx1MzIsIGJ1dCBoZXJlIHRoZSBoZWxwZXIg
aXMgcmV0dXJuaW5nDQo+PiAnaW50Jywgc28gaWYgdGhlIHZlcmlmaWVyIHNheXMgc3VicmVnLT5z
bWluX3ZhbHVlID0gUzMyX01JTjsNCj4+IGl0IG1lYW5zIHRoYXQgdXBwZXIgYml0cyB3aWxsIGJl
IG5vbi16ZXJvLg0KPj4gVGhlIGhlbHBlciBjYW4gcmV0dXJuICh1NjQpLTEgd2l0aCBhbGwgNjQt
Yml0cyBiZWluZyBzZXQgdG8gMS4NCj4+IElmIG5leHQgaW5zbiBhZnRlciB3MCA9IGNhbGwgaGVs
cGVyOyBpcyB3MCArPSBpbW07DQo+PiB0aGUgdmVyaWZpZXIgd2lsbCBkbyBhYm92ZSBjb2VyY2Ur
ZGVkdWNlIGxvZ2ljIGFuZCBjbGVhciB1cHBlciBiaXRzLg0KPj4gVGhhdCdzIGNvcnJlY3QsIGJ1
dCB3aXRob3V0IGV4dHJhIGFsdTMyIG9wZXJhdGlvbiBvbiB3MCB0aGUgc3RhdGUNCj4+IG9mIHIw
IGlzIHRlY2huaWNhbGx5IGNvcnJlY3QsIGJ1dCBkb2Vzbid0IG1hdGNoIHIwLT52YXJfcmVnDQo+
PiB3aGljaCBpcyB0bnVtX3Vua25vd24zMi4NCj4+IEkgd29uZGVyIHdoZXRoZXIgaXQgc2hvdWxk
IGJlIHRudW1fdW5rbm93biBpbnN0ZWFkIHdpdGggYWJvdmUNCj4+IF9fbWFya19zdWJyZWdfdW5i
b3VuZGVkKCkgPw0KPiANCj4gdG51bV91bmtub3duIHNob3VsZCB3b3JrIHNpbmNlIHN1YnJlZyB7
c21pbixzbWF4LHVtaW4sdW1heH1fdmFsdWUNCj4gYWxsIGluIDMyLWJpdCByYW5nZS4gVGhlIG1h
c2sgKC0xKSBzaG91bGQgd29yayBhcyB1cHBlciAzMi1iaXQgdW5zaWduZWQNCj4gdmFsdWUgaXMg
YWx3YXlzIDAuDQo+IA0KPiBXaWxsIG1ha2UgdGhlIGNoYW5nZSBhbmQgc2VuZCBhbm90aGVyIHJl
dmlzaW9uLg0KDQpBbiB1cGRhdGUgZm9yIHRoaXMgYnVnLg0KSW52ZXN0aWdhdGVkIGZ1cnRoZXIg
d2l0aCBBbGV4ZWkgYW5kIGZvdW5kIGFjdHVhbGx5IHdlIGhhdmUNCmEgTExWTSBidWcgd2hlcmUg
c29tZSBMU2hpZnQgYW5kIFJzaGlmdCBpcyByZW1vdmVkIGluY29ycmVjdGx5DQphdCArYWx1MzIg
bW9kZS4gVGhlIGZvbGxvd2luZyBMTFZNIHBhdGNoDQogICAgaHR0cHM6Ly9yZXZpZXdzLmxsdm0u
b3JnL0Q3MDUxMS9uZXcvDQpoYXMgYmVlbiBtZXJnZWQgd2hpY2ggZml4ZWQgTExWTSBpc3N1ZS4N
Cg0KVGhlcmUgYXJlIHNvbWUga2VybmVsIGNoYW5nZXMgbmVlZGVkIHRvIG1ha2UgdGVzdF9wcm9n
cyBwYXNzaW5nLCB3aGljaA0KSSB3aWxsIHNlbmQgb3V0IHNob3J0bHkuDQoNClRoaXMgcGF0Y2gg
c2V0IGNhbiBiZSBhYmFuZG9uZWQuDQoNCj4gDQo+Pg0KPj4+ICsNCj4+PiAgICAvKiBNYXJrIGEg
cmVnaXN0ZXIgYXMgaGF2aW5nIGEgY29tcGxldGVseSB1bmtub3duIChzY2FsYXIpIHZhbHVlLiAq
Lw0KPj4+ICAgIHN0YXRpYyB2b2lkIF9fbWFya19yZWdfdW5rbm93bihzdHJ1Y3QgYnBmX3JlZ19z
dGF0ZSAqcmVnKQ0KPj4+ICAgIHsNCj4+PiBAQCAtMTAzOCw2ICsxMDQ3LDIwIEBAIHN0YXRpYyB2
b2lkIF9fbWFya19yZWdfdW5rbm93bihzdHJ1Y3QgYnBmX3JlZ19zdGF0ZSAqcmVnKQ0KPj4+ICAg
IAlfX21hcmtfcmVnX3VuYm91bmRlZChyZWcpOw0KPj4+ICAgIH0NCj4+PiAgICANCj4+PiArLyog
TWFyayBhIHN1YiByZWdpc3RlciBhcyBoYXZpbmcgYSBjb21wbGV0ZWx5IHVua25vd24gKHNjYWxh
cikgdmFsdWUuICovDQo+Pj4gK3N0YXRpYyB2b2lkIF9fbWFya19zdWJyZWdfdW5rbm93bihzdHJ1
Y3QgYnBmX3JlZ19zdGF0ZSAqc3VicmVnKQ0KPj4+ICt7DQo+Pj4gKwkvKg0KPj4+ICsJICogQ2xl
YXIgdHlwZSwgaWQsIG9mZiwgYW5kIHVuaW9uKG1hcF9wdHIsIHJhbmdlKSBhbmQNCj4+PiArCSAq
IHBhZGRpbmcgYmV0d2VlbiAndHlwZScgYW5kIHVuaW9uDQo+Pj4gKwkgKi8NCj4+PiArCW1lbXNl
dChzdWJyZWcsIDAsIG9mZnNldG9mKHN0cnVjdCBicGZfcmVnX3N0YXRlLCB2YXJfb2ZmKSk7DQo+
Pj4gKwlzdWJyZWctPnR5cGUgPSBTQ0FMQVJfVkFMVUU7DQo+Pj4gKwlzdWJyZWctPnZhcl9vZmYg
PSB0bnVtX3Vua25vd24zMjsNCj4+PiArCXN1YnJlZy0+ZnJhbWVubyA9IDA7DQo+Pj4gKwlfX21h
cmtfc3VicmVnX3VuYm91bmRlZChzdWJyZWcpOw0KPj4+ICt9DQo+Pg0K
