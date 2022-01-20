Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D09D49570F
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 00:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348190AbiATXi7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 18:38:59 -0500
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:49920 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244889AbiATXi7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 18:38:59 -0500
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20KNNO0T019723;
        Thu, 20 Jan 2022 23:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=jNH7Ckyhw08KyYY4YBJKhKZWzEKkgGRJQVpca6PIcN4=;
 b=PX6z9fAm9lnXBYK1YRJLYerEXorbzqM8/jh+37Q2Xe+JdFtQ7Jj78rujumvvheTEQTB3
 i7SoZOJhJ8VC/Now3V4V8yzF7xIpm6eYM+ImLFD5JyhIHO+Z2DfwL4FCbo/+Fj0zSuuu
 wf+VClp63g7pJ4K5joF5KnnUouwJcLRGxCP9hwklm7vuIWCQU7poA1R5OzNVq89JaxaZ
 17/UXrJTLQxvsIZEdYmvo9Qm1E2Ux4CiCGNLsdKoVo3TjM4bynWH0ClyTNEWtam4aHGq
 xBwNPDtXQaKDeSzyMUBjFPL1jZGJ+SRm8dATH32pSLj2+5mFzwYb4akby84Yb/UhxzlD 9g== 
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2171.outbound.protection.outlook.com [104.47.23.171])
        by mx08-001d1705.pphosted.com with ESMTP id 3dqhc880gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 23:38:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OI9BZYYtq506ianHiOVCbM00cKL/+rusZDW1WiE4FxX/GqkmC3uggcF0RD3Icd65elo3jWQhpBpk3sorW6N6PzRQDaWc8d96ygyb0ogeAO+hboct9ttsqzzVpmYGdNK+TPLe7IhpHvL2TQAPZJKDWH4HL3xdHrtVdMZSRQl4e+JnkQwNE2BXp9YyTiaT7XBKNP19KILQkyuPj+9t0IV2P92jVAi+pjlgEeHAodUvr4PqLKypS8I6QPwg+ChuoG5+6JymJzsUMl4cQfUVbVnvrUO2fp577BQ6NEGPkH3+u+ihjHmCN9D2fMd6YH5gu7Oiui561Plt67LryfyKRFr19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNH7Ckyhw08KyYY4YBJKhKZWzEKkgGRJQVpca6PIcN4=;
 b=iK8qCT89D8IHMoE7mbYUTqRCOhQL+BpDDbCoxqEWIXnjfscpPCGxSQwZTTL3CiVa4DXYIMKvOcjdCslJG3MZ9dI1SQHDpQ+q/aETRrtVMqMaVK825Rq43toe5iz16et8hqfnNNWIpUYfXp7yN83Ncb2jGkuQpUKitn8t9H2jXMifX0VLHewg/My2ryto8xZdHr8RruBbE2XbZFj4W6umLcHehRAccNU+bg8T7whlSqUfdl9FdWl2fuExuywUNPwUUvYH+4GiXobEiWEYLBMuyLmfqb3YtKQso11zi6lDQsEyZf94+xaxkxzdpYNZkHsas3Q6XTWgF7va2+vyLMfCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from TYCPR01MB5936.jpnprd01.prod.outlook.com (2603:1096:400:42::10)
 by TYCPR01MB8820.jpnprd01.prod.outlook.com (2603:1096:400:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 23:38:23 +0000
Received: from TYCPR01MB5936.jpnprd01.prod.outlook.com
 ([fe80::4d73:10a:5d6:4b8d]) by TYCPR01MB5936.jpnprd01.prod.outlook.com
 ([fe80::4d73:10a:5d6:4b8d%7]) with mapi id 15.20.4909.011; Thu, 20 Jan 2022
 23:38:23 +0000
From:   <Kenta.Tada@sony.com>
To:     <andrii.nakryiko@gmail.com>
CC:     <andrii@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <songliubraving@fb.com>,
        <yhs@fb.com>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>
Subject: RE: [PATCH v4 2/3] libbpf: Fix the incorrect register read for
 syscalls on x86_64
Thread-Topic: [PATCH v4 2/3] libbpf: Fix the incorrect register read for
 syscalls on x86_64
Thread-Index: AQHYDTZZ2C28qVTfhEWPJ0gTzKPfeqxqq8iAgAHYINCAAATdgIAACHzQgAAA/qA=
Date:   Thu, 20 Jan 2022 23:38:23 +0000
Message-ID: <TYCPR01MB59363F1E8F4703D72C3BAA2BF55A9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
References: <20220119131209.36092-1-Kenta.Tada@sony.com>
 <20220119131209.36092-3-Kenta.Tada@sony.com>
 <CAEf4Bza9A+iC49bZRiSPWNuy+=qG3sc=_XvKem4Fj2zZF8merg@mail.gmail.com>
 <TYCPR01MB5936508A473D90FCA8C779E9F55A9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
 <CAEf4Bzb5ShGTVwf-62rYzA0EKqSd=HkMuWeaO=Og4xyN8k6=AA@mail.gmail.com>
 <TYCPR01MB59365EBB32022F54882AD196F55A9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB59365EBB32022F54882AD196F55A9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bcc686c-df28-444d-fa18-08d9dc6df2d4
x-ms-traffictypediagnostic: TYCPR01MB8820:EE_
x-microsoft-antispam-prvs: <TYCPR01MB88209BC7F7A761F1535FD1F6F55A9@TYCPR01MB8820.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EJ7okJ8R0jmrMnFNT0qmjbN4VWDP/d6QUVxfAlMDrF1Ess5rSve4cO4MamiwZ8+rY1rGi4vgorBslwbukGJPw6MOD2swKeQ+kMR8MXWOCp0PfqAfR191Imk5lZPQjojPVwRsLvqQXbyz6wFGMlEVoN9bk7qFg7995xTShfJKcEx4aItYXOu0Pu41jSKQ/hRhngh+awA09POVYO3sJziKRZZk3QX/7PGS50uv9FmfQMz1Hs6LsUikMbyesuR3iW2mHlvgMGyBzxBsttOyNjI3EJEPoJ1/Y2VFIo4Cospb+3D5JXjQpgGrqE+diETGrAr9xUNb478J1FrCVehPqiLo9ewAo0PUWWsosL0Ylt2EHFxC7kWZhDyIdkeFxWJKrdH+WP5Uusq0CWyy2rViLzVYSRMqfR+TM1XG2VHvtaHG6hQrSXwZ98jUigqK7bWekPctlwOAWTbtfvMago2wm0+eSHOSz5w3QEB1lBVvc01YbRwuu5Z97pV8HLUAGwi4qTn0WVERh9wBQyZ/LH9O6Pp/bruoWLON6DMwdl3HqE8rsOt0nBj/3GwuGi+iBv5/azOhAH/zqqvnrRMaMdrusNMfwJVM4lr5Dgv8p0Hi8qzOGi66aY94iEMHjEn2oo4yU74kBY7W+VUVu4hH0xHBi5rwweASKHwpPJd14o/b1F600Orbyg+u5daoLWWesf9CyHl2bY2feWIhXlb0GYADWehjXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5936.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(122000001)(66446008)(82960400001)(52536014)(76116006)(55016003)(4744005)(66556008)(66476007)(316002)(54906003)(5660300002)(6916009)(64756008)(7416002)(33656002)(7696005)(38070700005)(8676002)(71200400001)(2940100002)(4326008)(8936002)(9686003)(6506007)(186003)(508600001)(38100700002)(86362001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWM5OGllcmZNYVY5SEYxYVBzSlhiL2pCQ2tnbVMzeUROZEdzT2JPMEw4TWU0?=
 =?utf-8?B?ZXZ3SGFlR3EyTjZSWU1mMXAzbzRNV2tRbHBlZ2syall5aEY0MTl6dW1qTzFj?=
 =?utf-8?B?WXdiNWZIVXdpblIrdTQwU0dKWUxReHRPQXE3eDN2bEdtNDd0cWtXWk1jZklS?=
 =?utf-8?B?aGZYdDA2NDdtMjRtWUwva1JLa2ZEa2JQT1N1MGIwTjBiNTloWkV3L1prNC9T?=
 =?utf-8?B?dzFCYTgzQit5MkwwSVZISkR5Y0VJK2tkODdhcVp2aFNlODRUenViWFBqRnhv?=
 =?utf-8?B?QjYxSXBjaVNFeFhqM25PVk1ybTZjU0xqOThJRGhYbmZXQWVnN1I5aWluRW5v?=
 =?utf-8?B?KzVNWnlPZUVjaGs2VDNqZ1ZaeVlBVEw3VUgzcWxVSTkyU08wVE5rV0E4bjdI?=
 =?utf-8?B?cHpySFprcVVNcDF3a25EVmJqdmM3emJNL1hrbGdlWnFUWHVmRzAybEZ6NExT?=
 =?utf-8?B?bWxmbDFVN2VkUUsvQUV4Zm1ZbkQ3L25GaDJmc3pTSFdMMU5rYytoRFVsc21l?=
 =?utf-8?B?RE9mVkFHWno3dlV6M2xsb1h0c2hPZmc0anh5dnZhNjYyaUpLSDZ5ZnVVVU9E?=
 =?utf-8?B?ZktuUGV5UTJMR1NjaTlOUkwzZE9ta00xY3VvbVYvc3dxckZacWFJWVphSE9U?=
 =?utf-8?B?elRseVpYZ2NSSXRnemNrRWVPNUt6M3hJRkdhSkVDNnA0eG8yaGh2Z2hjeUwx?=
 =?utf-8?B?UEJsTnZVYk9pYTFUUzlEd3ZMUjdlV3NiY1NEZnlHb29Mc05xT3BBS0NRWHFT?=
 =?utf-8?B?TkdidzBBWmhwWDIyU1FsZjlGZ01kY2tWWEtQZWJYdkpuTVdsb1ZXWEpJb3ly?=
 =?utf-8?B?R2ZVajlWTXVxV1oyRGR6TWJvRWY1YUFpUVBJaW1xNk1vbFFIRHBJNUVTNUt5?=
 =?utf-8?B?aEE1Umt6K3VpZG9US2pLMXhaS1hHNzN4UUFOTkZKaXMybllVdGJ6Vk4xTmtW?=
 =?utf-8?B?a2pPOVVUU2VOYlNFczJVWjJlYlUzZHRKRXdROXU1S1JTMkhlTEdsZ1AzWkFX?=
 =?utf-8?B?WVFWT0ExaHJ6Slp1ZjlhTmN4bmtjWHBuODMwZnFCREVaZUgyc1RuVzFuNm9E?=
 =?utf-8?B?OHd4d0NQSDN5dkcrOXRzeGlvbldPdFg3Ujk4d2FVajJrMkUySWRzd3J1RytM?=
 =?utf-8?B?U2tkbHBpdXNDTHhCUVpWQ3VQWGxiVGY5T2ZsUE9pZnJQek1uZFZ2KzgydU01?=
 =?utf-8?B?NzVEUm1aZUFsa0ZzQUpoelhkVXJiaFpVUk1yYVI0bENOSDdkS1kzUS9nS1Bh?=
 =?utf-8?B?TUlvYzdCbWFNSjZZNUlCLzZxMHBjM0dHRnh0ZFkrTEZBTmtzblRLQ01HMUtE?=
 =?utf-8?B?VU5EQjZYVncwdWtuSGhnYUw3TWg4S09DQXlUWFpqYmNmYnlvOXZWaHhrZG1n?=
 =?utf-8?B?aGRzNUlHSDY3bk92b25NVm5NckhuMld5Tm9hK29rbVFrR0hpMEVzeEJxeUdo?=
 =?utf-8?B?VkFxOHN0WkJrb2QrMzNiNER4NkJXSTQ2MDdaNjV3VitQdGFob0Erbm1XR2wx?=
 =?utf-8?B?b0RsRDV0KzBHcHFGM1JmdDN3QTF5Y0tuNmtlRkxtcTdaSkx6STFXcVNYMVpv?=
 =?utf-8?B?S2pEZlE4M1FraWMvZ2pTZVJrU0hhQmZEdmNlYnZTOWQyZFBHUWowTTNGOG1p?=
 =?utf-8?B?R1lncW03c3VqSzIxMmMyWDlDdElNZXI3M0NQTis3RllPVVRBZ3lkYnc2QlZT?=
 =?utf-8?B?QXE2ZndxTDZOYWNIbE1MZmtDb01rYzNlT2I1ekxIZVZ6YXlNNmNlOTErMEw1?=
 =?utf-8?B?UlpPZWdZTmZqMmdwd0xWUUNuZXZROXhwM3BuWit2UFZDT3pKcWdvc3NsaTQ1?=
 =?utf-8?B?aU9qYzVYRTNsdjcrbjdJVkVqUVdaYXhRVEFZVWxoRy9FZWdHN3J4bmUrUExu?=
 =?utf-8?B?NG5qdzlKOXFUc0NadHdIdGswaHVldWFsVlgzdTNNQXo2WlZOdEpIZUNxMjRJ?=
 =?utf-8?B?azl1UlZ4TnFzV3A5QWtZS000dGhOWWJrZzRDTTZKTU4zSWJJaDBoOFM2VEV0?=
 =?utf-8?B?VHlzM3JGcGlWUU9yNk1wdHArc3dFNXBwaHMrQ2NaQlFjbEt0WEs2WVdkNTZY?=
 =?utf-8?B?RUZlbXhlY1cxb21qcm9OZHB6bDIzKzJuN2NlZkNCYTJXMld0bHRUNmFuRE5J?=
 =?utf-8?B?SG0vVVBReTUwb0F5M3RRLzRrWHVoamhvRTZIVXRObnlxaGcvUU5adHQ3SVFp?=
 =?utf-8?B?N2p3ckNtQkpaUExiY1d4eGVzQ2tEWmtJZjl0MCtkNStlYXhkSlNlSmRia0Rw?=
 =?utf-8?B?OWRzK3gzZHZrMTZMdVNsVnpyRTF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5936.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcc686c-df28-444d-fa18-08d9dc6df2d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 23:38:23.2600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3C9Rv37LrATDf5+3LDFrI5M5Qhc6D71MwsS58v+w7X6i34JOusO7oi/ANleksvhV5DWb+ijlaKNTKOfSRKlow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8820
X-Proofpoint-GUID: ouNNKaPEf5gweyumJlRsQYbhlSON-Q8n
X-Proofpoint-ORIG-GUID: ouNNKaPEf5gweyumJlRsQYbhlSON-Q8n
X-Sony-Outbound-GUID: ouNNKaPEf5gweyumJlRsQYbhlSON-Q8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_10,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=778
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201200119
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pj4+DQo+Pj4gPmRpZCB5b3UgY2hlY2sgUFRfUkVHU19QQVJNNF9DT1JFKCkgZGVmaW5pdGlvbj8g
VGhpcyBzaG91bGQgYmUNCj4+Pg0KPj4+IEluIG15IGxvY2FsIHRlc3QsIHRoaXMgd3JvbmcgY29k
ZSBjYW4gcGFzcyB0aGUgY29ycmVjdCBhcmc0IGJlY2F1c2UgdGhlIHRlc3QganVzdCBjaGVja3Mg
dGhlIHZhbHVlLg0KPj4NCj4+VGhlIGJpZ2dlc3QgcHJvYmxlbSBpcyB0aGUgbGFjayBvZiBicGZf
cHJvYmVfcmVhZF9rZXJuZWwoKS4gWW91ciBkZWZpbml0aW9uIGRvZXMgZGlyZWN0IG1lbW9yeSBy
ZWFkIHdoaWNoIHdvbid0IHdvcmsgaWYgcHRfcmVncyBpcyBub3QgYW4gaW5wdXQgY29udGV4dCB0
byB0aGUgQlBGIHByb2dyYW0uIFdoaWNoIGlzIGV4YWN0bHkgdGhlIGNhc2UgZm9yIHN5c2NhbGxz
Lg0KPg0KPlllcy4NCj5JJ2xsIHVzZSBCUEZfQ09SRV9SRUFEKCkgZm9yIFBUX1JFR1NfUEFSTTRf
Q09SRSgpIG5vdCB0byByZWFkIGRpcmVjdCBtZW1vcnkuDQoNClNvcnJ5LCBOb3QgUFRfUkVHU19Q
QVJNNF9DT1JFKCkgYnV0IFBUX1JFR1NfUEFSTTRfQ09SRV9TWVNDQUxMKCkuDQpBbmQgSSBjb2Zp
cm1lZCB0aGUgZGVmaW5pdGlvbiBvZiBQVF9SRUdTX1BBUk00X0NPUkUoKSBhbmQgQlBGX0NPUkVf
UkVBRCgpLg0KSSdsbCB1c2UgQlBGX0NPUkVfUkVBRCgpIGZvciBQVF9SRUdTX1BBUk00X0NPUkVf
U1lTQ0FMTCgpLg0K
