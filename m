Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B2C2EEB2D
	for <lists+bpf@lfdr.de>; Fri,  8 Jan 2021 03:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbhAHCJf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jan 2021 21:09:35 -0500
Received: from mail-eopbgr1320082.outbound.protection.outlook.com ([40.107.132.82]:7229
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbhAHCJe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jan 2021 21:09:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ln6ejZ580otBLJZArlB/YkE4tMhk3z48UnEQHbkHwiakP8PWP/+zy6EWNzlRw9azTTFy6XUIyEny0pfTqznpPXr3NFMnpTEgh4Q+wjrOPQYtcYK94gTRkEmciWyAUux017AHVBU+WXT9JC1elk3KCQeo6ySkKEg/GLRfL6Q2vWHZMVtNPqnltS4wC7pOxNUl5X56pMdb73/PqK9kLksPlo38poNWSbzkQCsetzSXtIvDVVqLjGJkULoPni86pwqbI7svpnHo9kY7R4QDt6Dc/oq0nUBIdVaD4i33GmeBxSDbJ9JR9iBWSbW68Qo6r+8r5fZ+wHA/ovQhvOxrlk5F4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0iJgr2FmvEC2+OBdUqxmKDXCLlDE5BeBVLPO/Cii9M=;
 b=ICDiuwp+TC031vzIXjJFK5jvoICu0GTrV1S314Larfmeev6tFIexVUaaj/k78CHRcANopz4yLtbhvc5k+D0w593ty3Gr83Mz40px1szTbRVCUoObofgV7rSgo4PpscgVDDlL2sOwCsH453qljGRLY1t0R/i7rcWlAV4HGcG044rAC//ksLF/ki/BfXPY3EGBNkFQ5jHwE25clS9gboJA+awA9IwMUBD4OX4zOBD/KFeXCnkEZ9H/KNVuWTzvp7kYzTPq4HjsWtxjj2eNTN2nIaKJxvqBx6VenGKulMax9mTLrzwa0biYWQQyZlEIO/M8WAoyy4vBGS25WDBZjdzsdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0iJgr2FmvEC2+OBdUqxmKDXCLlDE5BeBVLPO/Cii9M=;
 b=hSP1sJeARc9e9z9dk9gj8yvgdtNSVLEdpy372wHvf3hZiSF2R1qwOIlNGNy2iHnSVfVUzGjL74fCTh7M+wRAGBVt6d5cBd8VwdMmHnKp7Y6RdttLLq8cNXdA+pgZnu8nuok1M/JYRb0lVDkOyy1sFmpvfd6JvMO98D9YqSBdIqA=
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com (2603:1096:203:d3::12)
 by HK2PR02MB3873.apcprd02.prod.outlook.com (2603:1096:202:19::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 02:08:00 +0000
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::e87c:a07c:77fc:630c]) by HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::e87c:a07c:77fc:630c%7]) with mapi id 15.20.3742.006; Fri, 8 Jan 2021
 02:08:00 +0000
From:   =?utf-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>
To:     "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] tools/bpf: Remove unnecessary parameter in
 bpf_object__probe_loading
Thread-Topic: [PATCH] tools/bpf: Remove unnecessary parameter in
 bpf_object__probe_loading
Thread-Index: AdblYbQpQKmKVR0hTa2lc5nK9Yvjhg==
Date:   Fri, 8 Jan 2021 02:08:00 +0000
Message-ID: <HKAPR02MB42916F8599BF7B58AD73C27AE0AE0@HKAPR02MB4291.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oppo.com;
x-originating-ip: [58.255.79.102]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b53abdac-c101-4555-3c6e-08d8b37a396e
x-ms-traffictypediagnostic: HK2PR02MB3873:
x-microsoft-antispam-prvs: <HK2PR02MB3873D20BE075FC44476DF3B9E0AE0@HK2PR02MB3873.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ygcFEZcaN8fwqaHnVBSVnPvIUXLhVAvcpv4VyQpgutwYHg6qy3f7YqW+Ps66cx3Qa4U8uE8CYWJ12ee9rt8fL2drulAgi+LWWBBNh0n6GO4yulEI5OiTNf2gg0i+0RVJ/hIQTn4fVu7WJMkXHNkED7rq3Iax73rTzJ9su/TS9tpS2kjLLA6CCfmYTWt2ylOWFpu8xyaSNeELOBDb7hy0eCFMMZvLNEgGA9JnMwQxDDZqTVsaGW9ePp59LYazK6YL57CSUbazK3L4rnOvXrAVKwbZPMgYl0wQtTU8d2GZDt8GB4+DgRaOg1oiN6sIaOkl64CGrhHyJUaa/6qZN7VkGIlrVfXt5G1CVb62Ts2GnOB4CufBlY7MJe50ihi6uMNcoYGScmdpnWdkd1Pskha/JSQj2w+mgohwMlshEH+CzYMDEtl4XgNVticmuBKPOmz3BSuHHV8z0sR/6mWtHpawO5wLGdLJDGP0kOt3lzx/Sr0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR02MB4291.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(64756008)(66556008)(66446008)(8676002)(66946007)(83380400001)(4744005)(8936002)(9686003)(186003)(66476007)(52536014)(478600001)(6506007)(33656002)(26005)(110136005)(7696005)(71200400001)(86362001)(5660300002)(55016002)(2906002)(4326008)(316002)(85182001)(54906003)(76116006)(11606006)(101420200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?V3B5dnFwcjREREpmcjdjcUdxY3psWVZhN3NLZllrY0h1R2YrdGpQR3NLaHFh?=
 =?utf-8?B?aTJCdzN5RjhQZHZhaFBjanpVL1NSczR3U1lyUVBRbFpTdGMwK3RZVTh3VGZL?=
 =?utf-8?B?WGZ4YVVlanZTWE82cW5hZmpTd1J1bjhPWm1yTUZsMHpHemFSdG8wN1ZKRFhs?=
 =?utf-8?B?UzFHekRFSEQ5V2lENllid3VUbUFNZEJublVpVG5kZXE3eDhHNkUvQ1VOTzRH?=
 =?utf-8?B?aFFjMllDc1JIOEVMTjdwVmNaRTJDelBzdlNQZzRPQkloVVhLTytOTllqbGlr?=
 =?utf-8?B?eDIxL09ONTByT0hpWHZmTDVsU09WL3hpN3h1Z3hGdkpwSnRoMTl4UHRyQlRJ?=
 =?utf-8?B?cXlnTmRqWVFJSWJJRWg3YUtLRDBVSWUwR0RxRUU3QVVGVFdFOGNmMUx5RDM2?=
 =?utf-8?B?OXg1ZVpjem5SSm5iRnBXR2F3MG9ReEhIQkpOVjdmbEE1dUt4YjA0aTlSN29n?=
 =?utf-8?B?WUNoc2YvY1ovdlBsek96MFJxMjA5RkRibVhwb2ZabUxRZWFOZ3FuNHpBTmt4?=
 =?utf-8?B?WURGR0V0cFB0VTVlTFNxNDhZYzZRQWR3YzA1RjZTc3NHMFBobnRwWXhISFJD?=
 =?utf-8?B?Vk1KQy9ER0dXY0NxV0hWeElHUWxrdnVwRW0wSmtzSmVVd3I2ajA4YnZrNEIr?=
 =?utf-8?B?dE84Y1lLQXg2c3FTU3QzYldlWHhtSWJDK0VtZ3A5ZmpCMG1BZ0lqcVB4d0dk?=
 =?utf-8?B?eFk0cHV6bDJ2NE9oQU9GSGU3VGlkaWh5QVQrZVZVeXp2V2wvMW1LaDVJTTZK?=
 =?utf-8?B?NGQrSUhLQVllcS9SNmNpQ01NWjZ5NWdGS1c4WU5mdDFNa0dxb253aXdWWk1r?=
 =?utf-8?B?akludWFvSDJ0bEw0Q3gvNVNWRWxCbDhyemlkeG11N1h6bWxISGZab1I5S3Js?=
 =?utf-8?B?WGpwUzFWNlU1a3psNHJQY0tHMW1IWEs4dWpZSjMxYkJnTHpMVkdQMjd4K0k2?=
 =?utf-8?B?MjQxOEl5V2p1YVAza0tqVjgySWN0QlNxRUpkYWlsWHNCOGljYW1LK2d4bHpV?=
 =?utf-8?B?QnF6Y1VTWXIyTDFIczV3MTNoZGlzYUpKazhlczVJZ3NSc3h3M08ybS8vb1c0?=
 =?utf-8?B?ZkFHLzdLdFhPMUhmZTBucU11aWdqMkxDNWtDdEpockd4YkRKUUVUd0MzNUZR?=
 =?utf-8?B?SUsrZC9iYUxZUy9pQXlsb0hrZVZaWitRWi9nOWV3a28veDBWT1B3c1VvbG9L?=
 =?utf-8?B?eEZOVm5QNXVUbG50ZTRTRmptT29NZjF1VThDTml0T0Q1eW16OE9sV2tDazl5?=
 =?utf-8?B?Qm1PMlhxWWM0WVlWenJyNituZzlQSXR4bStOUEFXazhoM3djWmZMVk5jNVNi?=
 =?utf-8?Q?HqbqrPU//A80c=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HKAPR02MB4291.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53abdac-c101-4555-3c6e-08d8b37a396e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 02:08:00.2558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rTGu1R4hFl6r4zMRjxeNLIIIK458/UTd6FtJcBHu5txZ+oGCpH/OTmzguAyHqKWU0Sj0Skd77IQmTmDKkN7y+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR02MB3873
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

c3RydWN0IGJwZl9vYmplY3QgKm9iaiBpcyBub3QgdXNlZCBpbiBicGZfb2JqZWN0X19wcm9iZV9s
b2FkaW5nLCBzbyB3ZQ0KY2FuIHJlbW92ZSBpdC4NCg0KU2lnbmVkLW9mZi1ieTogUGVuZyBIYW8g
PHJpY2hhcmQucGVuZ0BvcHBvLmNvbT4NCi0tLQ0KIHRvb2xzL2xpYi9icGYvbGliYnBmLmMgfCA0
ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvdG9vbHMvbGliL2JwZi9saWJicGYuYyBiL3Rvb2xzL2xpYi9icGYvbGli
YnBmLmMNCmluZGV4IDMxMzAzNDExNzA3MC4uMTdkOTA3NzlmMDlhIDEwMDY0NA0KLS0tIGEvdG9v
bHMvbGliL2JwZi9saWJicGYuYw0KKysrIGIvdG9vbHMvbGliL2JwZi9saWJicGYuYw0KQEAgLTM2
ODUsNyArMzY4NSw3IEBAIGludCBicGZfbWFwX19yZXNpemUoc3RydWN0IGJwZl9tYXAgKm1hcCwg
X191MzIgbWF4X2VudHJpZXMpDQogfQ0KDQogc3RhdGljIGludA0KLWJwZl9vYmplY3RfX3Byb2Jl
X2xvYWRpbmcoc3RydWN0IGJwZl9vYmplY3QgKm9iaikNCiticGZfb2JqZWN0X19wcm9iZV9sb2Fk
aW5nKHZvaWQpDQogew0KICAgICAgICBzdHJ1Y3QgYnBmX2xvYWRfcHJvZ3JhbV9hdHRyIGF0dHI7
DQogICAgICAgIGNoYXIgKmNwLCBlcnJtc2dbU1RSRVJSX0JVRlNJWkVdOw0KQEAgLTcyNTgsNyAr
NzI1OCw3IEBAIGludCBicGZfb2JqZWN0X19sb2FkX3hhdHRyKHN0cnVjdCBicGZfb2JqZWN0X2xv
YWRfYXR0ciAqYXR0cikNCiAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCiAgICAgICAg
fQ0KDQotICAgICAgIGVyciA9IGJwZl9vYmplY3RfX3Byb2JlX2xvYWRpbmcob2JqKTsNCisgICAg
ICAgZXJyID0gYnBmX29iamVjdF9fcHJvYmVfbG9hZGluZygpOw0KICAgICAgICBlcnIgPSBlcnIg
PyA6IGJwZl9vYmplY3RfX2xvYWRfdm1saW51eF9idGYob2JqKTsNCiAgICAgICAgZXJyID0gZXJy
ID8gOiBicGZfb2JqZWN0X19yZXNvbHZlX2V4dGVybnMob2JqLCBvYmotPmtjb25maWcpOw0KICAg
ICAgICBlcnIgPSBlcnIgPyA6IGJwZl9vYmplY3RfX3Nhbml0aXplX2FuZF9sb2FkX2J0ZihvYmop
Ow0KLS0NCjIuMTguNA0K
