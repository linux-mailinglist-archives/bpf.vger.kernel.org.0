Return-Path: <bpf+bounces-19548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A5382DDB5
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 17:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3CD1F2299A
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD6D17BC7;
	Mon, 15 Jan 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="NezlKSA8"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ECC17BBB
	for <bpf@vger.kernel.org>; Mon, 15 Jan 2024 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355085.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40F9cr5a020579;
	Mon, 15 Jan 2024 16:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	DKIM202306; bh=LCouB3E2hOWR6Jf6PFl7KRvv4g+/ZyK2PpkuIcDNyyA=; b=N
	ezlKSA89jhBIHkSqAkKi3+7OpmW8sSOrMgTcVzRwuUHx3XWMdOKJxtQU9+OJUAaF
	F2tyCAV0+6l5i0ygIQ/XgeDBKJnKOiFbZM+lKeNb5QAA8qUhZRE2GHQsQiRU439E
	nU+IZf3z3bJmW0xmYfh6VQyx8r6JZOBaW0ETvxxhVvleKOmg4o417z3fiB/KDNB6
	TZEpsGfQRaHgGsuIJuNCHp+tKlfLgdPJegFRi2tJ6xc2hoHQvzMygJRFeYcNrpRa
	xd0n35Qbo0xEk94isAcaQpb1SLDDTHNUynQl6TA8U0MikW0B2hIIsxCCfxCvFu65
	3FYFSN7g6V6Yd/Tlsrejw==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3vmsp6hg6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 16:09:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFGCavMKwXU0k6h8vi4qEy2YB2Zzv7N3pIJo4gtElwdANhkuUXtqhg0AGLfOGSxOzkIKQQ4SBMDZGdK3xbfr4onWe9AczSxuPNAmDzoF9W3AACeLETSeWS4IVdhJJBfknvhAOphZN4r66aittkRuNF0H4CAxpupeUF+ge3ChTkX9Yiryz9qWs0tMOTiMEuf5iY0yrMspsOj37KDBSGOiGmPuue0bKesRP3f7BCc4klM823iElcCxE2TBHCm9AONVvlLmmMGyA9UF6ezcI0JS62r2jd48CHDdPfpNCeh24zLsZ+Ge2LRuQ9Qh2K9sIv4dgZDgKlZ72oGCv1MhKrzxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCouB3E2hOWR6Jf6PFl7KRvv4g+/ZyK2PpkuIcDNyyA=;
 b=et+aaw/JyJuUwsuRGCd2OPLg963GklGaPl29QpO1/TUhKUBeePnTnkFkcmI3/OIMbl96XF5phsGCk/Tr0ZT/7aRuzJXLiK0SJhgUTsuX3DqRmmIywYZ23Jz1ySED2c3zt6jfdVHGLbC9dwYKCzZJi8Cv46PLC6VNX9JEcoj8RqrkeF1Nt/8ImsJknCPituaC4hTSZT2aTBKQT22+j6t47Z1lIH2qfRZ1WvSPNULPsvWb7/cvfyPCScOSIPUhnu/M/45JRi2qbolduTOwaSckvnjqA9BF3jIvrypYZmVCV7XMXKYuBKfNc3z5O7zHbEcOecJFI2HydgZfofmXkWzhuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by TYZPR03MB7396.apcprd03.prod.outlook.com (2603:1096:400:426::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Mon, 15 Jan
 2024 16:09:14 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::a23f:1f5b:d0db:ffe7]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::a23f:1f5b:d0db:ffe7%7]) with mapi id 15.20.7181.022; Mon, 15 Jan 2024
 16:09:13 +0000
From: Maxwell Bland <mbland@motorola.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: "Jin, Di" <di_jin@brown.edu>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "v.atlidakis@gmail.com" <v.atlidakis@gmail.com>,
        "vpk@cs.brown.edu"
	<vpk@cs.brown.edu>,
        Andrew Wheeler <awheeler@motorola.com>,
        =?utf-8?B?U2FtbXkgQlMyIFF1ZSB8IOmYmeaWjOeUnw==?= <quebs2@motorola.com>
Subject: RE: [External] Fwd: BPF-NX+CFI is a good upstreaming candidate
Thread-Topic: [External] Fwd: BPF-NX+CFI is a good upstreaming candidate
Thread-Index: 
 AQHaPpWonDW/eHWeP0q2GVAamFCjbrDIvSYAgAAkCQCAAZfpAIAA9E+QgAoQIwCABZhHcA==
Date: Mon, 15 Jan 2024 16:09:13 +0000
Message-ID: 
 <SEZPR03MB67860CB5DCD1D8F035B67D15B46C2@SEZPR03MB6786.apcprd03.prod.outlook.com>
References: 
 <TYZPR03MB679243A8E626CC796CB7BDBDB461A@TYZPR03MB6792.apcprd03.prod.outlook.com>
 <CAKOkDnNAQSrWxsJBrcLV7ReaQkX_BHX+EAn69e0cpe9b=FAsUg@mail.gmail.com>
 <CAKOkDnPnNE=MNP-1_8=T9vw6Ox80OAJmKonzpDO4abW8Dz9JwA@mail.gmail.com>
 <SEZPR03MB67865F9167DABCA16AA6811BB4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
 <CAADnVQJCxFt2R=fbqx1T_03UioAsBO4UXYGh58kJaYHDpMHyxw@mail.gmail.com>
 <CAKOkDnPZ5SKYOQhE646Se5oYCi7Rc3ubUTnrE+-aXiViTsA1jQ@mail.gmail.com>
 <SEZPR03MB6786BF42E7105E8B55C5788DB4662@SEZPR03MB6786.apcprd03.prod.outlook.com>
 <CAADnVQJXtxV7VcfMCcmwVkjo8ZDeZhj+bF0YOjxwP8aVV_dZCQ@mail.gmail.com>
In-Reply-To: 
 <CAADnVQJXtxV7VcfMCcmwVkjo8ZDeZhj+bF0YOjxwP8aVV_dZCQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|TYZPR03MB7396:EE_
x-ms-office365-filtering-correlation-id: 66635e67-27de-4ea2-e109-08dc15e4512b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Bb0E9Sbn7lLB9Fds8t+0YOqILI2wSVY8oIh12+bP/J8BTudemGV5+hcEPOPrDUzyrcMnblNfqcr/stkz65qaW9Rg6q4g5OGpIsvZVZ42xgxFnDDmPLgXl/x06AzQAeJCcR88k1NJ816V9boxuafnRX0k/OCN1svr5mTKcD372bnX8o24vC2mEg6cJPzMATyeSgj3p0B1NxxUXHVc/Etb9BsirGv3IorJ2qjB1lLQhGYmWarMcVfFP9QTqM47EiGgeZVxASHzvMHQV7AzTL6+zVbtHYCr3z0GpirvYBXRcIHN4maq92ht+877b2239emjGPlljLYy7Mt3gTafjINRDZcw1yVAViF0TOAA19whqzo7RZdNP2Yz6TACRtMrwjsf3pWYes3wjv4Utf1on/BN3rIsi5oVxVrIxQKIvt3D3yBm7pnelCosSIh48vPEdVnejpK0dOLFfB+vr/aJybwnmXAzWEdLTiaTAaC6Te98//VlDn0+s+kW8xFU7gTQdocjvFKUh/pfGDc2vmWncB3Fn+xkbdNKd1lrIpTjwoP43mm0hAq6dWlJuNPZoBar1Puu7mRYPFSC75rt406innc+J9n2b7oP6PyQHuzm2c6CnlIgwdgipvHu5w6VUw+/8fOfuElKUO86C1K73ox00/CYhDnpCT7RunXdKYt9hgreRac=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230173577357003)(230273577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2906002)(9686003)(55016003)(82960400001)(38100700002)(8676002)(33656002)(4326008)(76116006)(71200400001)(478600001)(66556008)(5660300002)(7696005)(107886003)(53546011)(6506007)(54906003)(64756008)(41300700001)(66476007)(6916009)(66946007)(8936002)(26005)(316002)(66446008)(83380400001)(122000001)(66899024)(38070700009)(86362001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?anVEdFlKTWU3dmhzVjd6RDFVblRBU290blBBdWJ2Q1RyeVFqMHJhYUsxZ3JJ?=
 =?utf-8?B?dzJUSC92all0UlNXSkFzUGVxcDVjUUdkK29kRW5LbzJIZWQ0dnN0RnZINzk5?=
 =?utf-8?B?bGluR0RnbUJpdDhwNkl3dGY4VlI5U0UzNng4ZUFSRWV2V1RvTFJBek93cGRz?=
 =?utf-8?B?cUtxUkJGTzdjWm5qaVRLSmJhdklhWkpOTlpwQ1gyY3ZyMkJZSU1SV0JydEl3?=
 =?utf-8?B?ejVhZUYyNUw2YkM2SGRFZGpNR1Y3L21DZE1NbTFrTW9qU21XZmg0c29QUHlG?=
 =?utf-8?B?YTA4UnRxazc3T3RIbmVuRG4yN2pnZ0duWUxQaUZEOEQwOTg5YWZLUUxHL3Fn?=
 =?utf-8?B?S0c5YkdTQlNKTm4ySUxUWU9EMDBXUGpQT2tLY2NQMlJnbnpPd3krWVBKSWQ4?=
 =?utf-8?B?bjFackN6NDN5eWg0RXZFSU10NnhGYmpudFpERGZxUG8xREVreWNJTVNhN25M?=
 =?utf-8?B?TU50UFk1TjNkeWZJVEk2WjZEbWw4dW5RM0R6WUpQWE9tczBGczlNa2d5YkF1?=
 =?utf-8?B?Qko2MWU4TlVzVm9TWWxHSWNMNXk2blVIb1htaFpDdE9IVkYvNTRpU0FXMzRj?=
 =?utf-8?B?UEQ0eVovR2g5MEtYQVR6MTFUSWZmaW9pVWVPY3ZBQThYT3pGN1c5eEV6eitC?=
 =?utf-8?B?Mi9HT2VySmFCR04vYmgrMCszZVNjR090UzRScWVNYlhsdXpGTW1IMGdDSkhn?=
 =?utf-8?B?dHhBR2VHMWpaQkgvcmZYb1RMd2hQcC9DdFBIc1g4dk1EdWl5MGpjSlMzSk9i?=
 =?utf-8?B?S3FTK0lyV0xBTVRFcFJwa090WkZxWWVEQmtOcHBocEo4Qk9saVdYNG9VUUZO?=
 =?utf-8?B?ekd4VStCb3U2MnppZGEwQ2dpUXQzN20rd29mWDFXa3NTendhbU1vaDBpaWlO?=
 =?utf-8?B?ek5BaTIwdlJPYkhsbS95d1N1OGZYWFllYUkxMUxyZjNCWFpmMFBCMThIbVky?=
 =?utf-8?B?MzJxWXEwaEQvamFCUVZrN1V0ejU4bFQ3dDFKNGNseG1GSG85Yk9QUExzdmtn?=
 =?utf-8?B?OTlsMy9sdWg2NHNhR2kxeG5WQXRYRXZYaElJdWlrMGZ6ZTQ2YllVRmxRamM4?=
 =?utf-8?B?aEs3aGxoQmtpZFNkcXFnM2pNcHhlcy9YMUVXcXZteWs1eXZ5cElvUThmanc5?=
 =?utf-8?B?aHdIYk1mWGZPa0N1djhBd2xjZXJWY1ZWVkp0Z2xQeGV5dWxtcGVNYjJteVBj?=
 =?utf-8?B?UjY1VnRlbWlOMG5CNmRSUVlmbHRzTTMwOXoyc1FCN3MwWldIbVlITHVVM01U?=
 =?utf-8?B?dWN3dW9IWkNBclNHdmNScVR2REd0MjhaTWxRandkcDZjRVhzeHlBcHo2ZkRy?=
 =?utf-8?B?Zk10T2NqbysrZGxiZklFVGUvVTZyemZycEdzV1ZFdnNoWno5SDBQYVkySGRY?=
 =?utf-8?B?Um5CMExvVzZBUzg1UlRETmNVTHZkWWQ4VTIrV29DYWh5dXZaYTNqd2lHd0FI?=
 =?utf-8?B?REZJaUtEd3U4NjF5MkEvK1FKcXpXT1NBN2tsb3VKMzF6TnpodHo2MDI5elpW?=
 =?utf-8?B?cmdYVjgvMEFBQVhMRUx1ZngxWFhHK1hrMnM2QTZnZWkzZHpodjUvNnBoUWtm?=
 =?utf-8?B?dC96ZjF1Ty9mVXY2OEVTaFhFMnFGNXNKdm1vdWEwdk1TeS9RZnFCL0dlZGhJ?=
 =?utf-8?B?SDJhOHI0cDdiVkhmZTFRYnY1TlFLYnl5YUxMb1NWSlhvWUZrM2p4WVBYNmZW?=
 =?utf-8?B?emlvSk5hbktTZFVnWjFFcG9YUVhMRkVNQVkzQU1zU3dwRGV6dE9lNndNeVh3?=
 =?utf-8?B?KzFLMWh4bFpsTWZpZmtSVDhHcmY3STZWY1N3RkhZay9HUE83R2lmTktuZEo4?=
 =?utf-8?B?bVd1Nm83UkdDR1hCdXdaMmpOTkNPOUVDN1FBck9yOXVlZjB4TDVJRjJxcnFZ?=
 =?utf-8?B?RjlMUjlsSXh0UXA4TFF0UlQ3QVUydkdKcHJoMUR5MWM5Sng1ZndBVHU1T0pH?=
 =?utf-8?B?TW9aUUgzeTNJaEZOMjJHMk1YMXhzTU9kMzUwZThjK2N4Y0RwZUVUczdpSjU4?=
 =?utf-8?B?K0tzdjhoOEIwdFgrREJNc1prMXlyL2JubmJkZFhEdVpsYUVHVFdiOVFMTWxF?=
 =?utf-8?B?ZTJyVWZXYzJ6VVFEWjhQc2F0UENnY3FZRTg2TjFMS3RMb3ZJTjdYajI0L3Bk?=
 =?utf-8?Q?ZEVk/TQ9HuQ1HquCFKfz/ddVo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66635e67-27de-4ea2-e109-08dc15e4512b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 16:09:13.7913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+/ODcvx3bwC6AZXqy2M3RMK0eSh342e9PkqfPnUC2B1OuU6zaFVL5KayUugGWgkxzuq6utp7ERxOeFbWN90tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7396
X-Proofpoint-ORIG-GUID: UeJHczB2u4CNynyjODY_XJRZnNzgO-M3
X-Proofpoint-GUID: UeJHczB2u4CNynyjODY_XJRZnNzgO-M3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401150118

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3Yg
PGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5
IDExLCAyMDI0IDg6MTcgUE0NCj4gVG86IE1heHdlbGwgQmxhbmQgPG1ibGFuZEBtb3Rvcm9sYS5j
b20+DQo+IENjOiBKaW4sIERpIDxkaV9qaW5AYnJvd24uZWR1PjsgYnBmQHZnZXIua2VybmVsLm9y
Zzsgdi5hdGxpZGFraXNAZ21haWwuY29tOw0KPiB2cGtAY3MuYnJvd24uZWR1OyBBbmRyZXcgV2hl
ZWxlciA8YXdoZWVsZXJAbW90b3JvbGEuY29tPjsgU2FtbXkNCj4gQlMyIFF1ZSB8IOmYmeaWjOeU
nyA8cXVlYnMyQG1vdG9yb2xhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtFeHRlcm5hbF0gRndkOiBC
UEYtTlgrQ0ZJIGlzIGEgZ29vZCB1cHN0cmVhbWluZyBjYW5kaWRhdGUNCj4gDQo+IE9uIEZyaSwg
SmFuIDUsIDIwMjQgYXQgODo1OOKAr0FNIE1heHdlbGwgQmxhbmQgPG1ibGFuZEBtb3Rvcm9sYS5j
b20+DQo+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPiBXaXRoIHRoZSBpbmNsdXNpb24gb2YgUGV0ZXIn
cyBDRkkgcGF0Y2hlcyBhbmQgdGhlIGFkYXB0aW9uIG9mIHRoZXNlIHRvIEFSTSwNCj4gdGhlcmUn
cyBhbHJlYWR5IHN0cm9uZyBwcm9ncmVzcyB0b3dhcmRzIHNlY3VyaXR5IGZvciBCUEYncyBKSVQu
IElmIHRoZSBtaXhpbmcNCj4gZXhlY3V0YWJsZSBjb2RlIHdpdGggZGF0YSBpc3N1ZSBnZXRzIGZp
eGVkIHRvbywgdGhlbiBpdCB3aWxsIHNvb24gYmVjb21lDQo+IHBvc3NpYmxlIHRvIHRyZWF0IEJQ
RiBKSVQgcHJvZ3JhbXMgbGlrZSBhbnkgb3RoZXIgcGFydCBvZiB0aGUgLnRleHQgc2VjdGlvbiwN
Cj4gd2hpY2ggc2VlbXMgbGlrZSBhIGh1Z2Ugd2luLCBzaW5jZSBCUEYgdGhlbiBnZXRzIGFsbCBv
ciBtYW55IG9mIHRoZSBmcnVpdHMgb2YNCj4gc3RhbmRhcmQgLnRleHQgc2VjdGlvbiBzZWN1cml0
eS4NCj4gDQo+IA0KPiBGWUkga0NGSSArIEJQRiBmaXhlcyBmb3IgeDg2IGhhdmUgbGFuZGVkIGlu
IExpbnVzJ3MgdHJlZSB0b2RheS4NCj4gU29tZWJvZHkgbmVlZHMgdG8gZG8gdGhlIHdvcmsgZm9y
IGFybTY0IEpJVC4NCj4gU2luY2UgYnBmIGNvcmUgcGllY2VzIGFyZSByZWFkeSBpdCB3aWxsIGJl
IGEgYml0IGVhc2llci4NCg0KVGhhbmtzISBJIGFtIHRoYXQgc29tZWJvZHkgKG1heWJlKS0tLUkg
YW0gd29ya2luZyB0b3dhcmQgdGhpcyBwYXRjaC4NCg0KQWxzbyBob3BlZnVsbHkgc29tZW9uZSBi
ZWF0cyBtZSB0byBpdDogSSBmb3J3YXJkZWQgdGhpcyB0byBrZXJuZWwgc2VjdXJpdHkNCnRlYW1z
IGF0IE1USy9RQ09NIChTYW1wYXRoIFBvbm5hdGhwdXJhIDxzYW1wYXRocEBxdGkucXVhbGNvbW0u
Y29tPiBhbmQgQ2hpbndlbg0KQ2hhbmcgPGNoaW53ZW4uY2hhbmdAbWVkaWF0ZWsuY29tPikgc28g
dGhleSBhcmUgYWxzbyBhd2FyZS4NCg==

