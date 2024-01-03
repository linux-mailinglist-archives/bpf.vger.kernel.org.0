Return-Path: <bpf+bounces-18911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C87BE8236BD
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 21:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79870287384
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC5E1D522;
	Wed,  3 Jan 2024 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="ndy+QCm6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643F11DA20
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355091.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403C8S2L026707;
	Wed, 3 Jan 2024 18:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=DKIM202306; bh=NoV7S5
	BoAj3ZuegrlM8yIsdAjbljryhdK95Z1QO1W7g=; b=ndy+QCm6nis+PtfiTsss8M
	Fe3yU1KcEdTgk1NO1ocrzNmrg2vWIrsrcD+oqn7on9bnv7gP7OxltX2ROHDn8cmA
	BI4oHVTqpAPWohknLzUskVdy31IEWkKwAtAMz+USx7VAAvKqVwLp2xYAPdfWiXKu
	MZdFT7G6MBMb2UtjU4fI4VuYpe+OGKXY+aEmUeTR21BJD+DqJCA0LuFpkKxjzvpD
	MQ8RCoZkmBBQcV6htTk9RYsITDbffcIF2KW1AKODz8naWLHoiidKW813OMg5lkHA
	pLfNRzAADPkCa2/isJuy6kkZMk5T7pB+IUMfsMIwK03G3yainpTmXUT6B7YmRjWA
	==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3vd7aw0nc0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 18:56:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpxkPfxUb8EmwnfJwLP7z1j4imnJyQgGmoE29Q8+Ibk1ZnxjKCy+pIgN9seNjzKBG9Ewwt/r6eXBai/r3U1VK+z1eFIeOTHiETBgqlJpJMfqWGXSjrZotKkQTq8dhDZAqZe64bBDlzNZqzvAlgmhACT6yXqszyA3QFF6TfwDtJ8j2O4MlemPb1l9ON2DBwlboah89Bj4EsXcL3b4RlN/lnVdVEOgjYzwZxvfJE9S+icBbHQI+14Fx31eRCWA0bMvDqs6+com6ruBRK+PNQy6RTtnLhuGXoP9G+VAstDkOGi4+mOie3SIatdbv8UdsvtNZ9m46WZo5OIt7ORGzPzVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoV7S5BoAj3ZuegrlM8yIsdAjbljryhdK95Z1QO1W7g=;
 b=dcpsce9u8yw/HawIDPDwbdJ/B4249CKOJ17zWoebg7Bpyx9grC91OMzq4nCnwHmTQznAzjPZmf3AAKmnd1TbidKF/qV48OzqTaWS8Wn/qxm6m014xDBbbIbmO8EldEFpvv8PTB4WuIaDaLCWFkSFQI/6l6VMwfWqFauNsGP5P3itKAL2N8pah3d360Z2Bnjl0eOi8FuqBNmIycEpDR+2gy3xxGNv14YpMEHicy+xZnrjaVdt4kj6CMBH9E+x645Ecy1XfJX4NK4NwYcbvx/x1vSSKN5adwL+V8t/JVZyeQSxjKvdFQjdNRKEn5UYDPhbxGdOoP6ZL5Fb1k9QkGu7Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by KL1PR0302MB5412.apcprd03.prod.outlook.com (2603:1096:820:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 18:56:03 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 18:56:03 +0000
From: Maxwell Bland <mbland@motorola.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: Andrew Wheeler <awheeler@motorola.com>,
        =?utf-8?B?U2FtbXkgQlMyIFF1ZSB8IOmYmeaWjOeUnw==?= <quebs2@motorola.com>,
        "di_jin@brown.edu" <di_jin@brown.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        "vpk@cs.brown.edu" <vpk@cs.brown.edu>,
        "v.atlidakis@gmail.com"
	<v.atlidakis@gmail.com>
Subject: [PATCH 2/2] Adding BPF CFI
Thread-Topic: [PATCH 2/2] Adding BPF CFI
Thread-Index: Ado+dgeat11I/pBISMy5MB62Pqngww==
Date: Wed, 3 Jan 2024 18:56:03 +0000
Message-ID: 
 <SEZPR03MB67866BC3232BC67023B7E24CB4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|KL1PR0302MB5412:EE_
x-ms-office365-filtering-correlation-id: 41533f5e-8e81-4757-83c2-08dc0c8da293
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 EbD1ByLrJLG293NKeP2LGggJBChpUiNdplrRhwPSjYC6i8/V8yuHfV06NPl3OJ+xU6D/m80yht8boyeSKBHC1wbQ0ujpEXFwaHQ+ckZ6S5eKm++sERnLShUa7iC+tu0SRJtfv3n/nU9ZWjJ69SpNI2u0mkJT2zhdTc0B9VJgDCFqLoL9lIs5TxxVBgDL1yyE4Xbg/1MJqhe2rHcIaLjyFu4MYxaYu+dQ4jcvuzjYu47BySKB75bFWtwzCxEkbuACyTzJvTpYzRik/v/MDM0svA1mB9424ZG5/gQ11STSNw7luzuN0V2xxx3v48A/mtcESINf/2Rd+Kh+L9+U5C1213R3EfzmwXCU7Kk/t54oc+ToA5qBJ3i5TOSwIKy0ThO+AugOi2h8YH1+7bd6Tp2YLML+rkU8xnanuHf90EbuC9kIdqkzScBCLL+XgTkR1X5b/sImpDlDXdV8XUh5emAnBQimSyBoq0aY7aGF55dJKPEW+IaIg+ZnHRllbyowLnMHFjrbnmcNfWuMWornGVJGFMTNEedKXWo2DyJqGGvPi82DLNWKDRR1dkIaZsQXzjqv5QK9aiW7ckY7JPFSDk93F/Xf9/i7uIEv3rTwnrZDqLFaMO20qktZ1IGzBfoJJ6lMuVbhU81xM9/Nn0lNQvOcQ1CgiR4ZBNy4oC9UFNFbJcA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(33656002)(83380400001)(55016003)(7696005)(2906002)(64756008)(66476007)(76116006)(66556008)(66446008)(316002)(54906003)(66946007)(38070700009)(38100700002)(478600001)(6506007)(71200400001)(26005)(9686003)(6916009)(86362001)(82960400001)(122000001)(5660300002)(8936002)(8676002)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MzlDY1VqVUUwK3VKRmtMOTFpdkhWcFJDbWhMdnFqcnBIbUNYSTJRbmNaZFNo?=
 =?utf-8?B?WmRva0RLZU1hNWZLU2lKOEVLSHMvSDgrTzVOaklSWUZQMUtKR2NaS1Jtd0pl?=
 =?utf-8?B?QjVRZTM3WFNadmtOWk5GUkczVC9iMFBCQWthTlpxYlZEaTRKMzU3Vm1sM254?=
 =?utf-8?B?UTBNdlFXSjJsQmdUZWViVjA1VFZWS0xFdkhtOHQxRlVXYnZrVGtQc0ZWcHBO?=
 =?utf-8?B?TnRQc1cvMk00MGV1RHprdjZNNml2bXo0c3A1ZjBzZVZhU1M5S3o3LzFwcFNR?=
 =?utf-8?B?UGsyZ0sxcUNtOUNaYVJFNU5TSGdHMS9zRG10eVdwYzFzaG53WnhqTDBRSVhw?=
 =?utf-8?B?NkRyeUJzc3orYWdJZ1pWY3MzdHY2bVV1b2pxV1htUWJPQ3F4S1RvcFVLbitN?=
 =?utf-8?B?Y3c2UGFBSVA1ZWVYTTRqQWpuNmoyM0pXbEdwWGFzNFM3MDBlbktYbENhWlUz?=
 =?utf-8?B?UDhhN2Fua0JJVEhCdHlFcUJhTGhoeUhTNG5kSHJWelNNam5SVVhPajQ2Rjhs?=
 =?utf-8?B?dkVSb1RaWFk3SFlPL2pDdDM2UWxMcU5Scmx3VnZwQ2h4UkJZcmRoNXZNSUV1?=
 =?utf-8?B?ZENSR05hcXp1THg2YUlLbkJreHdWTDZ0bEZHTzJyN0pxYmp6d0V1bGw5bXZl?=
 =?utf-8?B?L205M3FKUUJETFIxL2Q5eitJQldkTjRVSkN3TFhLZ0w0ZUlzYldjSk9DU0FR?=
 =?utf-8?B?WkFjdTQyaWhUV1hWVzlIblltS2xnRTRSR1U3QXVFUEp2c3A1d3liVlo1c21W?=
 =?utf-8?B?MEpHSzY0OWdUZTN2aHBtcit1ckVBVElMbDJiQW5idFAwUEpnK3p3M2ZiMjFX?=
 =?utf-8?B?TzZCYUh1RUFQT3ViZlFVSkl0eXloUFpONG1hRjVzNVUyQ2hjZDhhQnRhbGph?=
 =?utf-8?B?aWx5ZGRNb0l0L0hpdUJTa1F6OVFmUkI4OURnajVnYnB1OXBzR2xJdWxpa1di?=
 =?utf-8?B?VCtQUHFDcUpPRTRPbWdDNUtPRDFQelRVM0djR0xPeHJGZE40VEsvSUpScGsx?=
 =?utf-8?B?MHd2bkV4ZW5yeUFKbU5wQ0YxTVpmQWlwdWlrajdldmFydUVnLzd5K3d5TkdY?=
 =?utf-8?B?N2Noc243NXNVR2tjVVJKcS82d2dMaDdRV2NIeGhLYkNxa05nSXRZSzNLODRz?=
 =?utf-8?B?c0NZNlRBdmhCNFBYZ0ppb1U3NHNNeWt1THB4WkJUYmlHWkY3QXB5T3haWW9H?=
 =?utf-8?B?b2ZrcmhCRThuOFNET3pIdlhzV0dpdjRRTmVXK0Evei9tZmVRTlJpdS9SelZW?=
 =?utf-8?B?S2JBYktILzBCUDM1bmhYd2oraWdXOTRZeGtGOWthb1JjUGV0WGtRaUY0b2tY?=
 =?utf-8?B?VFZpdTVUWSsxMmFWZ1dKTnJ3K09VWWFXRlB2MHV3YkZLd2l3RXhZNHQ5cXgx?=
 =?utf-8?B?MEpad3l1T1VrcUU1czEvODM0OGZKMGpDZHNNc0E0ZlVDb2pYdnFocW8wN1J2?=
 =?utf-8?B?Q0dKc1hWVFlNc2xIVDRHZFI1M3pwVDZVQnFHdXpvdCt3aFEzMWsyeCt1NXRl?=
 =?utf-8?B?L0tuUm1aaXJKamFQTDlRME1RMEp2Mk9PeFFFUXROdllmeVJkYU85d1c0UWJL?=
 =?utf-8?B?TGFWZ3Znc2pUd0hNUlZDZUFKcFJxakJLS0RCbmNiNTZ4Sk5Zd2FvNFk5MFMx?=
 =?utf-8?B?Q3k2d3dYUElYcWU1NmRSRERPejVnOWVLVmNrdHN0eWdPdFk5NUIvWGtuaDJL?=
 =?utf-8?B?YVY3U2NyWjVtNmVyN2p3TnZyUVZBVGRIZnUrNWwyeVBFclg5aU8vVE9kNlFK?=
 =?utf-8?B?aXBySlVKWTRXbVZ0clNPODFOZDNIeGkvQmREN0g2ZkVPek92QytHZHNmMFN0?=
 =?utf-8?B?YTQ3TkhqaGd4NEZZS3pPcG9HakIraDByOGRGTXVzMU9kS0lUOFNGVUFBQkNG?=
 =?utf-8?B?R0xPZjB2UVZVbnJpTnZONGoxS2VLOWJ4VGxVakdyYUw4Wkt4ZVVWbWNJNkxT?=
 =?utf-8?B?SXV4dkx1RFl4U2UveFBqRDhsN1lzWGpzUy9JdFUvVnlNWG1qNEVVSXBvTHpu?=
 =?utf-8?B?STJ4Rzh6d25EZlEyWlNLa3FRTm9wSVBQMG5oUERxV3FrUWJKMzhKZEd0OHQv?=
 =?utf-8?B?NFRUWHdVZjJsNGRnZFUwN3ZIdjJVT0h4VzJSSnAwTWI2QnJTdlhCay9heVVk?=
 =?utf-8?Q?EelE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: motorola.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6786.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41533f5e-8e81-4757-83c2-08dc0c8da293
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 18:56:03.7196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l9awrSHyn7yxVOUIPMjip0cOU7dbUCGhdfemICCdOwUQIixlEkK9jbPC0PO9VqB2/d5AgxMflWC5T9VAwDyR8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5412
X-Proofpoint-ORIG-GUID: 7ZMRFfZmydWo-EuZ_SPLrqleReczmpUK
X-Proofpoint-GUID: 7ZMRFfZmydWo-EuZ_SPLrqleReczmpUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401030153

RnJvbTogVGVudXQgPHRlbnV0QE5pb2JpdW0+DQpTdWJqZWN0OiBbUEFUQ0ggMi8yXSBBZGRpbmcg
QlBGIENGSQ0KDQpDaGVjayBvZmZzZXQgb2YgQlBGIGluc3RydWN0aW9ucyBpbiB0aGUgaW50ZXJw
cmV0ZXIgdG8gbWFrZSBzdXJlIHRoZSBCUEYgcHJvZ3JhbSBpcw0KZXhlY3V0ZWQgZnJvbSB0aGUg
Y29ycmVjdCBzdGFydGluZyBwb2ludA0KDQpTaWduZWQtb2ZmLWJ5OiBNYXh3ZWxsIEJsYW5kIDxt
YmxhbmRAbW90b3JvbGEuY29tPg0KLS0tDQprZXJuZWwvYnBmL0tjb25maWcgfCAxMCArKysrKysr
DQoga2VybmVsL2JwZi9jb3JlLmMgIHwgNzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA4OSBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL0tjb25maWcgYi9rZXJuZWwvYnBmL0tjb25m
aWcNCmluZGV4IDcxNjBkY2FhYTU4YS4uOWM2NGRiMGRkZDYzIDEwMDY0NA0KLS0tIGEva2VybmVs
L2JwZi9LY29uZmlnDQorKysgYi9rZXJuZWwvYnBmL0tjb25maWcNCkBAIC05NCw2ICs5NCw3IEBA
IGNvbmZpZyBCUEZfSEFSREVOSU5HDQogCWhlbHANCiAJICBFbmhhbmNlIGJwZiBpbnRlcnByZXRl
cidzIHNlY3VyaXR5DQogDQoraWYgQlBGX0hBUkRFTklORw0KIGNvbmZpZyBCUEZfTlgNCiBib29s
ICJFbmFibGUgYnBmIE5YIg0KIAlkZXBlbmRzIG9uIEJQRl9IQVJERU5JTkcgJiYgIURZTkFNSUNf
TUVNT1JZX0xBWU9VVA0KQEAgLTEwMiw2ICsxMDMsMTUgQEAgYm9vbCAiRW5hYmxlIGJwZiBOWCIN
CiAJICBBbGxvY2F0ZSBlQlBGIHByb2dyYW1zIGluIHNlcGVyYXRlIGFyZWEgYW5kIG1ha2Ugc3Vy
ZSB0aGUNCiAJICBpbnRlcnByZXRlZCBwcm9ncmFtcyBhcmUgaW4gdGhlIHJlZ2lvbi4NCiANCitj
b25maWcgQlBGX0NGSQ0KKwlib29sICJFbmFibGUgYnBmIENGSSINCisJZGVwZW5kcyBvbiBCUEZf
TlgNCisJZGVmYXVsdCBuDQorCWhlbHANCisJICBFbmFibGUgYWxpZ25tZW50IGNoZWNrcyBmb3Ig
ZUJQRiBwcm9ncmFtIHN0YXJ0aW5nIHBvaW50cw0KKw0KK2VuZGlmDQorDQogc291cmNlICJrZXJu
ZWwvYnBmL3ByZWxvYWQvS2NvbmZpZyINCiANCiBjb25maWcgQlBGX0xTTQ0KZGlmZiAtLWdpdCBh
L2tlcm5lbC9icGYvY29yZS5jIGIva2VybmVsL2JwZi9jb3JlLmMNCmluZGV4IDU2ZDllOGQ0YTZk
ZS4uZGVlMGQyNzEzYzNiIDEwMDY0NA0KLS0tIGEva2VybmVsL2JwZi9jb3JlLmMNCisrKyBiL2tl
cm5lbC9icGYvY29yZS5jDQpAQCAtMTE2LDYgKzExNiw3NSBAQCBzdGF0aWMgdm9pZCBicGZfaW5z
bl9jaGVja19yYW5nZShjb25zdCBzdHJ1Y3QgYnBmX2luc24gKmluc24pDQogfQ0KICNlbmRpZiAv
KiBDT05GSUdfQlBGX05YICovDQogDQorI2lmZGVmIENPTkZJR19CUEZfQ0ZJDQorI2RlZmluZSBC
UEZfT04gIDENCisjZGVmaW5lIEJQRl9PRkYgMA0KKw0KK3N0cnVjdCBicGZfbW9kZV9mbGFnIHsN
CisJdTggYnl0ZV9hcnJheVtQQUdFX1NJWkVdOw0KK307DQorREVGSU5FX1BFUl9DUFVfUEFHRV9B
TElHTkVEKHN0cnVjdCBicGZfbW9kZV9mbGFnLCBicGZfZXhlY19tb2RlKTsNCisNCitzdGF0aWMg
dm9pZCBfX2luaXQgbG9ja19icGZfZXhlY19tb2RlKHZvaWQpDQorew0KKwlzdHJ1Y3QgYnBmX21v
ZGVfZmxhZyAqZmxhZ19wYWdlOw0KKwlpbnQgY3B1Ow0KKwlmb3JfZWFjaF9wb3NzaWJsZV9jcHUo
Y3B1KSB7DQorCQlmbGFnX3BhZ2UgPSBwZXJfY3B1X3B0cigmYnBmX2V4ZWNfbW9kZSwgY3B1KTsN
CisJCXNldF9tZW1vcnlfcm8oKHVuc2lnbmVkIGxvbmcpZmxhZ19wYWdlLCAxKTsNCisJfTsNCit9
DQorc3Vic3lzX2luaXRjYWxsKGxvY2tfYnBmX2V4ZWNfbW9kZSk7DQorDQorc3RhdGljIHZvaWQg
d3JpdGVfY3IwX25vY2hlY2sodW5zaWduZWQgbG9uZyB2YWwpDQorew0KKwlhc20gdm9sYXRpbGUo
Im1vdiAlMCwlJWNyMCI6ICIrciIgKHZhbCkgOiA6ICJtZW1vcnkiKTsNCit9DQorDQorLyoNCisg
KiBOb3RpY2UgdGhhdCBnZXRfY3B1X3ZhciBhbHNvIGRpc2FibGVzIHByZWVtcHRpb24gc28gbm8N
CisgKiBleHRyYSBjYXJlIG5lZWRlZCBmb3IgdGhhdC4NCisgKi8NCitzdGF0aWMgdm9pZCBlbnRl
cl9icGZfZXhlY19tb2RlKHVuc2lnbmVkIGxvbmcgKmZsYWdzcCkNCit7DQorCXN0cnVjdCBicGZf
bW9kZV9mbGFnICpmbGFnX3BhZ2U7DQorCWZsYWdfcGFnZSA9ICZnZXRfY3B1X3ZhcihicGZfZXhl
Y19tb2RlKTsNCisJbG9jYWxfaXJxX3NhdmUoKmZsYWdzcCk7DQorCXdyaXRlX2NyMF9ub2NoZWNr
KHJlYWRfY3IwKCkgJiB+WDg2X0NSMF9XUCk7DQorCWZsYWdfcGFnZS0+Ynl0ZV9hcnJheVswXSA9
IEJQRl9PTjsNCisJd3JpdGVfY3IwX25vY2hlY2socmVhZF9jcjAoKSB8IFg4Nl9DUjBfV1ApOw0K
K30NCisNCitzdGF0aWMgdm9pZCBsZWF2ZV9icGZfZXhlY19tb2RlKHVuc2lnbmVkIGxvbmcgKmZs
YWdzcCkNCit7DQorCXN0cnVjdCBicGZfbW9kZV9mbGFnICpmbGFnX3BhZ2U7DQorCWZsYWdfcGFn
ZSA9IHRoaXNfY3B1X3B0cigmYnBmX2V4ZWNfbW9kZSk7DQorCXdyaXRlX2NyMF9ub2NoZWNrKHJl
YWRfY3IwKCkgJiB+WDg2X0NSMF9XUCk7DQorCWZsYWdfcGFnZS0+Ynl0ZV9hcnJheVswXSA9IEJQ
Rl9PRkY7DQorCXdyaXRlX2NyMF9ub2NoZWNrKHJlYWRfY3IwKCkgfCBYODZfQ1IwX1dQKTsNCisJ
bG9jYWxfaXJxX3Jlc3RvcmUoKmZsYWdzcCk7DQorCXB1dF9jcHVfdmFyKGJwZl9leGVjX21vZGUp
Ow0KK30NCisNCitzdGF0aWMgdm9pZCBjaGVja19icGZfZXhlY19tb2RlKHZvaWQpDQorew0KKwlz
dHJ1Y3QgYnBmX21vZGVfZmxhZyAqZmxhZ19wYWdlOw0KKwlmbGFnX3BhZ2UgPSB0aGlzX2NwdV9w
dHIoJmJwZl9leGVjX21vZGUpOw0KKwlCVUdfT04oZmxhZ19wYWdlLT5ieXRlX2FycmF5WzBdICE9
IEJQRl9PTik7DQorfQ0KKw0KK3N0YXRpYyB2b2lkIGJwZl9jaGVja19jZmkoY29uc3Qgc3RydWN0
IGJwZl9pbnNuICppbnNuKQ0KK3sNCisJY29uc3Qgc3RydWN0IGJwZl9wcm9nICpmcDsNCisJZnAg
PSBjb250YWluZXJfb2YoaW5zbiwgc3RydWN0IGJwZl9wcm9nLCBpbnNuc2lbMF0pOw0KKwlpZiAo
IUlTX0FMSUdORUQoKHVuc2lnbmVkIGxvbmcpZnAsIEJQRl9NRU1PUllfQUxJR04pKQ0KKwkJQlVH
KCk7DQorfQ0KKw0KKyNlbHNlIC8qIENPTkZJR19CUEZfQ0ZJICovDQorc3RhdGljIHZvaWQgY2hl
Y2tfYnBmX2V4ZWNfbW9kZSh2b2lkKSB7fQ0KKyNlbmRpZiAvKiBDT05GSUdfQlBGX0NGSSAqLw0K
Kw0KIHN0cnVjdCBicGZfcHJvZyAqYnBmX3Byb2dfYWxsb2Nfbm9fc3RhdHModW5zaWduZWQgaW50
IHNpemUsIGdmcF90IGdmcF9leHRyYV9mbGFncykNCiB7DQogCWdmcF90IGdmcF9mbGFncyA9IGJw
Zl9tZW1jZ19mbGFncyhHRlBfS0VSTkVMIHwgX19HRlBfWkVSTyB8IGdmcF9leHRyYV9mbGFncyk7
DQpAQCAtMTcxOSwxMSArMTc4OCwxOCBAQCBzdGF0aWMgdTY0IF9fX2JwZl9wcm9nX3J1bih1NjQg
KnJlZ3MsIGNvbnN0IHN0cnVjdCBicGZfaW5zbiAqaW5zbikNCiAjdW5kZWYgQlBGX0lOU05fMl9M
QkwNCiAJdTMyIHRhaWxfY2FsbF9jbnQgPSAwOw0KIA0KKyNpZmRlZiBDT05GSUdfQlBGX0NGSQ0K
Kwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KKwllbnRlcl9icGZfZXhlY19tb2RlKCZmbGFncyk7DQor
CWJwZl9jaGVja19jZmkoaW5zbik7DQorI2VuZGlmDQorDQogI2RlZmluZSBDT05UCSAoeyBpbnNu
Kys7IGdvdG8gc2VsZWN0X2luc247IH0pDQogI2RlZmluZSBDT05UX0pNUCAoeyBpbnNuKys7IGdv
dG8gc2VsZWN0X2luc247IH0pDQogDQogc2VsZWN0X2luc246DQogCWJwZl9pbnNuX2NoZWNrX3Jh
bmdlKGluc24pOw0KKwljaGVja19icGZfZXhlY19tb2RlKCk7DQogCWdvdG8gKmp1bXB0YWJsZVtp
bnNuLT5jb2RlXTsNCiANCiAJLyogRXhwbGljaXRseSBtYXNrIHRoZSByZWdpc3Rlci1iYXNlZCBz
aGlmdCBhbW91bnRzIHdpdGggNjMgb3IgMzENCkBAIC0yMDM0LDYgKzIxMTAsOSBAQCBzdGF0aWMg
dTY0IF9fX2JwZl9wcm9nX3J1bih1NjQgKnJlZ3MsIGNvbnN0IHN0cnVjdCBicGZfaW5zbiAqaW5z
bikNCiAJCWluc24gKz0gaW5zbi0+aW1tOw0KIAkJQ09OVDsNCiAJSk1QX0VYSVQ6DQorI2lmZGVm
IENPTkZJR19CUEZfQ0ZJDQorCQlsZWF2ZV9icGZfZXhlY19tb2RlKCZmbGFncyk7DQorI2VuZGlm
DQogCQlyZXR1cm4gQlBGX1IwOw0KIAkvKiBKTVAgKi8NCiAjZGVmaW5lIENPTkRfSk1QKFNJR04s
IE9QQ09ERSwgQ01QX09QKQkJCQlcDQo=

