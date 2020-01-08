Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA308134922
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2020 18:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgAHRUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jan 2020 12:20:20 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58308 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729748AbgAHRUU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Jan 2020 12:20:20 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 008HJwOF028831;
        Wed, 8 Jan 2020 09:20:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=lCf1YYzv+9lpsR/aEdrxcwJmeg3/j4Br/4XkMRvQwbU=;
 b=dSrR9braazL3cbq9otqcn0n8HWd6YPzlboj43+zK3ezM/EQP/uQwxzbjmNvXs7c4Z3VQ
 7yhQxPcgQVpi+3mULFZrgolpdpR1qMPkfnefXuclfcNlOcJ2H8xTU3CZ0k2/NuLlLfHi
 zeP8Kffr1Ayoq0WffkNVn2mDlnu1pkiEa8U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xd5auux44-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Jan 2020 09:20:05 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 8 Jan 2020 09:19:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwcFvz1J5pvMGzApino3UkHp41pgsVu8yB/8UrB0EHYMJIogPL5FQoxV5k9UUDlUFymB2nWgVQpj2m1+k/mG7d+hfDrfzsGtydzHjKNt6qH/2tm7YjBaJfQ05y0dorWuw11QE7gGJtf59F8BhAAd9vaKSg847p4XH/anM3F+L8jGohDkPS1E83zqZt7DN3eJETIwwsBRxHbcBH8rKjStdkESJHODLvd1C9DyOsXFSvpiEj04YHy1pcJ6mbyCDC2UrcuI0xUPpwpes6R3tP6NoJJO0HVvK//YNCvhQ4A8nkPo92zwP6ZNSRFtd/wm4AoDvyTzokOQ7Yp4t2Q+5uF1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCf1YYzv+9lpsR/aEdrxcwJmeg3/j4Br/4XkMRvQwbU=;
 b=A6lJFQ/8GKyAUQ1qxS14oJRt43Wbsim2OP4NB7q3xPkywN39ZICCtkaWtKC6308KyslGYU2TeafXfXP7LYw1pKQLaHOpb/kmJjxBv/7v8BcAUlrxahI+aSi6yxmOluuq+U6eR2RoWRFnpVbSqmvAJesRUQipB0Al0Ee4hqUw63UeA4LjzjBQJeWQRCF71S+ed3cuy08E1nadrvHR2SkkOoDdnmvkPXWJu/htNZVmc6DPqGMxEmCmuGbwZA6rh/qdEnNdiCS1ZGA8tlmkCe8Kbw9cr716qp2sMi3HkRzp4X9BgloHLUnOZg0Ok+Ls9fL6Xd/HQzoUMAq4V77zIs2bZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCf1YYzv+9lpsR/aEdrxcwJmeg3/j4Br/4XkMRvQwbU=;
 b=H4dvgBE6LBBTG0tfpSEqHBpAwVm/hYAb00CDH7lWYbiNmZg2sOcBf8y1Ab0XVY/xRcHuZlmNvov3jSoKqSayEa6kGUiYJpe1gKmakYYKg4BZXIq3uZNbbta/18dulGiS/lvr8YnwZBzZBaIztiOslqlBfTLC0qQFSITHTHp+B28=
Received: from MWHPR15MB1294.namprd15.prod.outlook.com (10.175.3.150) by
 MWHPR15MB1565.namprd15.prod.outlook.com (10.173.235.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8; Wed, 8 Jan 2020 17:19:51 +0000
Received: from MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::b47a:a4d2:b9dd:eb1e]) by MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::b47a:a4d2:b9dd:eb1e%5]) with mapi id 15.20.2623.008; Wed, 8 Jan 2020
 17:19:51 +0000
Received: from localhost (2620:10d:c090:200::1:6af7) by MWHPR14CA0050.namprd14.prod.outlook.com (2603:10b6:300:81::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8 via Frontend Transport; Wed, 8 Jan 2020 17:19:50 +0000
From:   Andrey Ignatov <rdna@fb.com>
To:     Song Liu <songliubraving@fb.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] bpf: Document BPF_F_QUERY_EFFECTIVE flag
Thread-Topic: [PATCH bpf-next] bpf: Document BPF_F_QUERY_EFFECTIVE flag
Thread-Index: AQHVxcSfBt9TxEIVwUi7KBnTUidr7afg9qiAgAANeIA=
Date:   Wed, 8 Jan 2020 17:19:51 +0000
Message-ID: <20200108171949.GA96819@rdna-mbp.dhcp.thefacebook.com>
References: <20200108014006.938363-1-rdna@fb.com>
 <67C42A60-A9C3-4B3D-9F27-C38827EDA73B@fb.com>
In-Reply-To: <67C42A60-A9C3-4B3D-9F27-C38827EDA73B@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0050.namprd14.prod.outlook.com
 (2603:10b6:300:81::12) To MWHPR15MB1294.namprd15.prod.outlook.com
 (2603:10b6:320:25::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:6af7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a12efc0-bb18-4df7-a060-08d7945ef828
x-ms-traffictypediagnostic: MWHPR15MB1565:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB15659B3FF4547B71BB62E043A83E0@MWHPR15MB1565.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(396003)(376002)(346002)(199004)(189003)(6486002)(6496006)(71200400001)(1076003)(52116002)(8676002)(81156014)(16526019)(186003)(8936002)(81166006)(6636002)(316002)(5660300002)(54906003)(86362001)(2906002)(478600001)(6862004)(9686003)(66446008)(66556008)(64756008)(66946007)(33656002)(66476007)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1565;H:MWHPR15MB1294.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B6zo+KH5l8pO3v4229QtM3oRKKDfOGa9PQ9QGscea6jaKmSBsvbU0xfRcL7BcueRMWE2rJZno6NyNTVToDBOmk5Qq65Iae4qZdIexO8xC3TzJIxL5m1E19UTdhJ/hz7sw71p748LO5REBOzLkolL74KykDe54VM/+evPHg3mSTdU5k/ihiXz9iKuBkUYVEGUWUJCtqW/SOruO4dxbbcFmHEOd5TymqO/jpmi/DEPw+40V+KMSYmMhAyikChDAa0PhqrKjOU8d6zJb8nNVBwz+kYiMoeweqX7vVrg6WWfa/GGgYsLCOsKX/i915kfvVHfYkq6eiO+LLzZcsdFU+M01bLYifo+86vPzrPcUYSO7ts5XjqYnYrrqF8dUTRe4i5adjWyHv4YdISQwp71RmHesQb0f6DtEKjsKNY/EIxs1e2ZjE2cOZ+4mUJ3b/dgr4iS
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C19419A7814F44AA88FB31D4E220670@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a12efc0-bb18-4df7-a060-08d7945ef828
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 17:19:51.0481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kO7QewkwpxIJzIlNgtl7IFW8wL6zVxdTz4ygqPzD75qyGf+e9XdS8qv7OzTi7TMZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1565
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_04:2020-01-08,2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=730
 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001080140
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

U29uZyBMaXUgPHNvbmdsaXVicmF2aW5nQGZiLmNvbT4gW1dlZCwgMjAyMC0wMS0wOCAwODozMSAt
MDgwMF06DQpbLi4uXQ0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgg
Yi9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgNCj4gPiBpbmRleCA3ZGY0MzZkYTU0MmQuLmRjNGI4
YTJkMmE4NiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgNCj4gPiAr
KysgYi9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgNCj4gPiBAQCAtMzU3LDcgKzM1NywxMiBAQCBl
bnVtIGJwZl9hdHRhY2hfdHlwZSB7DQo+ID4gLyogRW5hYmxlIG1lbW9yeS1tYXBwaW5nIEJQRiBt
YXAgKi8NCj4gPiAjZGVmaW5lIEJQRl9GX01NQVBBQkxFCQkoMVUgPDwgMTApDQo+ID4gDQo+ID4g
LS8qIGZsYWdzIGZvciBCUEZfUFJPR19RVUVSWSAqLw0KPiA+ICsvKiBGbGFncyBmb3IgQlBGX1BS
T0dfUVVFUlkuICovDQo+ID4gKw0KPiA+ICsvKiBRdWVyeSBlZmZlY3RpdmUgKGRpcmVjdGx5IGF0
dGFjaGVkICsgaW5oZXJpdGVkIGZyb20gYW5jZXN0b3IgY2dyb3VwcykNCj4gPiArICogcHJvZ3Jh
bXMgdGhhdCB3aWxsIGJlIGV4ZWN1dGVkIGZvciBldmVudHMgd2l0aGluIGEgY2dyb3VwLg0KPiA+
ICsgKiBhdHRhY2hfZmxhZ3Mgd2l0aCB0aGlzIGZsYWcgYXJlIHJldHVybmVkIG9ubHkgZm9yIGRp
cmVjdGx5IGF0dGFjaGVkIHByb2dyYW1zLg0KPiANCj4gVGhpcyBsaW5lIGlzIG1vcmUgdGhhbiA3
NSBieXRlIGxvbmcsIEkgZ3Vlc3MgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgd291bGQNCj4gY29t
cGxhaW4gYWJvdXQgaXQ/DQoNCkkgcnVuIGNoZWNrcGF0Y2gucGwgYmVmb3JlIHNlbmRpbmcgaXQg
YnV0IGl0IGRpZG4ndCBjb21wbGFpbjoNCg0KICAlIHNjcmlwdHMvY2hlY2twYXRjaC5wbCBwLzAw
MDEtYnBmLURvY3VtZW50LUJQRl9GX1FVRVJZX0VGRkVDVElWRS1mbGFnLnBhdGNoDQogIHRvdGFs
OiAwIGVycm9ycywgMCB3YXJuaW5ncywgMjYgbGluZXMgY2hlY2tlZA0KICANCiAgcC8wMDAxLWJw
Zi1Eb2N1bWVudC1CUEZfRl9RVUVSWV9FRkZFQ1RJVkUtZmxhZy5wYXRjaCBoYXMgbm8gb2J2aW91
cyBzdHlsZSBwcm9ibGVtcyBhbmQgaXMgcmVhZHkgZm9yIHN1Ym1pc3Npb24uDQoNCkkgaGF2ZW4n
dCBkZWJ1Z2dlZCB3aHksIGJ1dCB0aGlzIGhlYWRlciBoYXMgcGxlbnR5IG9mIGxpbmVzIGxpa2Ug
dGhpczoNCg0KICAlIGF3ayAnbGVuZ3RoKCQwKSA+PSA3NScgaW5jbHVkZS91YXBpL2xpbnV4L2Jw
Zi5oIHwgd2MgLWwNCiAgNzQNCg0KDQotLSANCkFuZHJleSBJZ25hdG92DQo=
