Return-Path: <bpf+bounces-22244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08F285A0EF
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 11:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD9DB21CB2
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075D328E26;
	Mon, 19 Feb 2024 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="CYIoQPhw"
X-Original-To: bpf@vger.kernel.org
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2091.outbound.protection.outlook.com [40.107.12.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBCB2869B;
	Mon, 19 Feb 2024 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708338355; cv=fail; b=eBIC0BxkTb7eN7ExsQpZIHHxk8DYxy4AvhEMy9UrCy3z20FMoEtW8ab4sfaUHnwE8O/Kb0ciSJcnDm7B5lFkoExOtclEZaODfWcUILZ1+ZYUDdNkwC6+5mabnlwxTG+IOcrsLfT63bvqGhqD1tvEbIp1ihOIsTn9Yl36ClrcaEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708338355; c=relaxed/simple;
	bh=n+ZBGqqRvKAgqsb9jmFDEodqKAKt9B3lcLYmEKWP4tM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dpH86NQkbrCHzr84IZM7vpAjYe62DbCgMZQ/i39RrpLul4D+iDuChBs5l2mFLOq+d+0FT9ccHdk++wXWMXWNXNgu1ECDajntU+BKgvmhyaQJUBnxSpXRJ1aJsWiLOFMIWeLRUNZ3fFQZFQ/bntefXMysSQP2dI3XIcSNcZIiKGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=CYIoQPhw; arc=fail smtp.client-ip=40.107.12.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfcMvppjS3ZTrcy/tZl/j8Xl1LVxpNckU11JpBEzUZPTyKkLaFr0t/CORCr13jkPoG9+9NmCsqAzD7FKaluJWSkcoy6k7k5wG9PzZkwjifBVwHHk3DPKkW7jhoUdX7FnKW23oo1Zu6eCO8qvUijpVoCqdSvm1BRAjx2EZkZGYhgBtm4u59YV8w+NBQVkWc9Q8xygJYwkc3cSKGhG2qMpWLudHZSIDWg1db50m2EtPHHqxMQXe2+dSURAhjhUWpM4Yw+J4ATzfuupgNp5ud7x4DdP5o2BcqOvCftZujegygwu9lsO1aHYAjcU4EcGbWaHeZL97qb2HpUvf30DbvDuog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+ZBGqqRvKAgqsb9jmFDEodqKAKt9B3lcLYmEKWP4tM=;
 b=N655VJxAkVM8cMUq1OVcpAEIeRvNX6Ooy3F4E0ULzq/bKyuR0iCsjk3VKBOu06RrWv5zmmJANezXLxNn1YpboLnRT4Brr4qehwa8z36iGK9mSDDIajtf1rVvpuAvbk54bsrd3RStfuHg44LTzfvH2jvEik2OhqoQlncZGNuPI6OxOQoXzYrkSBGiIcnzbtpdsdm+Dee+XhW45OT8zhG4DNfP8k5fhBbGt7Pa1wgayocxNtBOSztcFINQV48cibA4Y8fP8xunDz726ZbNmznToy8cjWVbxvPWIZFks5FtvXasVY7VMeZ+opHpuTWk4DELS+C/eTUS/Z63bnlEnUU5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+ZBGqqRvKAgqsb9jmFDEodqKAKt9B3lcLYmEKWP4tM=;
 b=CYIoQPhwiW7T38L2qgpmppotpEhH+lD3LkT6JcskDt4B/4oOQObYtZkcHpD2H8IKEmFEu8q2JctNdsoc0mQCAmxrWSq71IcIu5zv57bZiPQk86Tu1eATKbLPSIZOsvirLfY2SL6WnkyrLWA+AozahgS3zwhW4pbmdu321DYhfp0+GZQ9kvAozxzXDjsh2LGZ0tatk9VgSZIbMMmIMheTVk/X8HD2kuW7KXqbB2FuLpru/Y2JjOZ36t8xjo4IVizqYxARbVTQZTqNtbqtgbnKJ/Vk413jzfaJyHXapQAON5UE5uHDTYJpHfsSVsP9PDKCFK2FUgylH96xoknuIJc9sw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2545.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:32::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 10:25:50 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::64a9:9a73:652c:1589]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::64a9:9a73:652c:1589%7]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 10:25:49 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Simon Horman <horms@kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Check return from set_memory_rox() and
 friends
Thread-Topic: [PATCH bpf-next] bpf: Check return from set_memory_rox() and
 friends
Thread-Index: AQHaYYt0k5q3btwWO0uxnF4OiPUcRLERdyKAgAAByoA=
Date: Mon, 19 Feb 2024 10:25:49 +0000
Message-ID: <2229a6a3-d37b-4865-a479-44df02dfa1d7@csgroup.eu>
References:
 <63322c8e8454de9b240583de58cd730bc97bb789.1708165016.git.christophe.leroy@csgroup.eu>
 <20240219101925.GW40273@kernel.org>
In-Reply-To: <20240219101925.GW40273@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2545:EE_
x-ms-office365-filtering-correlation-id: ba943d50-4599-4e42-0de8-08dc313524bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kpcv04uA6mT+OYGcJBFkTK9uAC3FI3D8++QJ+KD8ob+q9M1dBH7KWAt8FDVvyh1Rt3azJ6FXIdqfHf0AYK/pKlhocpiJYXYACed2olnOZvpoMg9Ncf1GmoFs5n+aFTwRbK30IjnD4f49ikzo9vjNeGNo8Wmh1ZTegdhd2r2v2Tm9HxgMPC8JyyrxZzTG0VntJAs7jk6ZCWn+3B0FyancIHt1L1tI5AoA8iXkcfRAEWaVeRflzmc40SSBY1oqqyaiJW/dY9ugpo4Jjd8Rh4AKVMW3M6a27NuVDGqMFGG2s7bOhHWpRnNWeGddUVFaiQ/UgsY/+AArbDiKd4G1JRLrxclkFX5SEzNb58RbXk2DTywFnuywt5l5RFL7GTPa7WHzss2UaZ8GjA1SQH+J4IJIPtv8VXmXbWUEoqaQnLQUp42HUZIPAjHiRbRFqWm68Vw1jZjv8aY03TSpdgvOXhOPwF0SGPXB5qoVkA+njBEIBAAbjb6CBvJdgJGoo2Iafp5i+kvNdE7YSjshFryK3J3/AUVOJ60iG3rC1Zrv46jUWAQMo/ALd2YkMZpnCyDQvDwrws5Cn8BGnVoteKq9nxc5YbBnedrhww4ceESwlxjUopgLHTDrvu0NvpIrYU8kYh6u
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39850400004)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(122000001)(38100700002)(26005)(31686004)(31696002)(86362001)(83380400001)(66574015)(44832011)(5660300002)(2906002)(478600001)(6486002)(7416002)(6506007)(6512007)(8676002)(4326008)(6916009)(8936002)(66556008)(76116006)(66946007)(64756008)(66446008)(66476007)(38070700009)(2616005)(36756003)(41300700001)(316002)(54906003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGpDdGhkVm9keWdXdDRWb1FiOHljdG1tRm1UYmNMWUhmSExFN3pzdER3OGJJ?=
 =?utf-8?B?RVQxQmQrZzhrL09pLzRCVnNIemlMRlJEcmNVQ3VGNmFJamxuRWcvWXpmVmw4?=
 =?utf-8?B?alNvQ2M5MmNFeFQrdk9YQnRSaWN4WDQwb3lja0granJLRGhxOHRVemExMGxF?=
 =?utf-8?B?Q2J5VHJhTmJaQzVWWCt1VTFaekw1Uzg3czROOTVNdTEvRWZCUXBVTG52VUR1?=
 =?utf-8?B?Q284Yk9EZmxzcjRzRVM2dkRiM2lNSjRhL1ZlYnRhQVdDTXh0QytVYkllMllV?=
 =?utf-8?B?RC92VkdIdHM4WlBNZmlNUHBUSFVJSUdTaXJqQTVFSnFUU3JUOWVOWFE0aDlw?=
 =?utf-8?B?WU92NEdrcHBxQ1Q0TTdFWk9pcnVhbG5yVlF3WGxySWtEK2d4ZWJCVEI1Y0Zj?=
 =?utf-8?B?YUdMOWJmUlhmUGsxNDNkWU9qUktiNHJIeTdYNE1NYTBUZTB5aGNZcFpjM2E0?=
 =?utf-8?B?QkVrTmg4L2lZMWVYYmNJVkNrb2Q0R0tPQzhuNzdvQkpycyttdWhnZWNUSzRQ?=
 =?utf-8?B?MS84Tk01TjgvQ005RkNzdFlYdGFjRmtZMmFPYnAyYUZpRHd2Z1hBU3FEZ0t3?=
 =?utf-8?B?UkRjTUlIYzNicitmcFBOcXE1TGpiQVhHWEx3TEtyaWRaZDYzRG1JWkpjZ0lB?=
 =?utf-8?B?MnB2SUxtcXhKUFdlTkJJUDN4OUdWUEx2UVZjWFlpZU9VWGNpcmRVSWx0LzUv?=
 =?utf-8?B?YlFUbDY2enkvOHdkUEw1ZGQ1WWY0RUpKZ0hZMC9lTDd4L0FVUzFsV2ZWTjBX?=
 =?utf-8?B?am83UXk2dTQ0U0hjbm9VRU05N2VUbkx3amdkMmIxRDZicVgyWHU4Sy8zQ3Vh?=
 =?utf-8?B?bk9aR3QyT1V5WG9yNUxqanZzWUozUnpuYmpCVXNmNnFXeGs2WXlIcDJMcnl4?=
 =?utf-8?B?dTJhbUQwZ3RLR2svR0F2eVR2aTVleEYzS0xFR0JIMjRRMUdnZXpUODlsa1Vw?=
 =?utf-8?B?MHcreVpxODFrUWZtbldadWRyWGoxL1QwSU81R2FxUFNUajNIRlNMdys3cWto?=
 =?utf-8?B?QWJZT0RzMjNwc2VHbTM1K1dWUDRiMnRQQlJkbGVMeEJCWjNVekVwdG84UXlZ?=
 =?utf-8?B?UXEzaFV5QU9zeU5uR0R2cTQzMHB0Zk9IcFREeXliYmZzT0VPeUJjclRab1Aw?=
 =?utf-8?B?NVozbHVBRStodWNtRFZkRGk3aDNSUW15aytTaXhRUkU5YUh3K29xY1ZTalAw?=
 =?utf-8?B?SzBUS0lpaE5GRzZNVWtBN01nTVZoTnZqRkFXb0tOYmdjR2F1Ykl0bVBLZUw1?=
 =?utf-8?B?NnRZQ3R2VTlFR1NRSE81eWMzOU1zWFVOY2hYbGFwYkd5R3d0eTJYS0djTEFq?=
 =?utf-8?B?ZFBwaE9MVzgyZm9qNm93RkFvU1VRUnVuYWpSVnJiRy9uU211a1BxTmY1UWtk?=
 =?utf-8?B?ZE9Rdk5mQVZOQlo2aDgxb0RYbzA5c0U2Z2xGZDRMeGtHTjEyTFh4eVZ4a0kw?=
 =?utf-8?B?WDBhaTlINHJKMmM4WUN6SFhOZ2VPMXZxVElIL1kzamFJZEdVVnJtK2RVOTVV?=
 =?utf-8?B?VXc0ZEt4cXVjTUNha21RTFVwUW52UzRiMTZYK052L2Vxb3Exam5NOERubHJR?=
 =?utf-8?B?alNvM2ZKbndNYzVIZjFLL0hBZ0ZGVGxCT0xUQXI1QUhOMzJpWHEyb0g2ZS9D?=
 =?utf-8?B?a0dmY3VBdUR6MHBkRDgxZkQ1VS9LYkJkS1I0dHlkbEYrVi9DSVJhUG1LdkVx?=
 =?utf-8?B?bVdGdHZxbUNERkR0MTJpOVJvZHM5WmR0UkxUUUpWOUF1NEpsYmY2VGJJcm4v?=
 =?utf-8?B?dHJ1U3A1Tk81SGpIeEF6M0ozbnV5VzJmT2djZzlrdjBqdGVrNUMyQ0pUR1E4?=
 =?utf-8?B?OWJiY0pxQ1RZMk5ScXZwTzNrMjQzSUdoNHFMTFpwMWZza3BHUnVqUEpySU1Q?=
 =?utf-8?B?RlRhYTdEcEpjYjNoZkNpd25xMnhFMndsNVBJa1k3TlZDQUtqSk51WjFvUGM2?=
 =?utf-8?B?NTVQMzNYWElTSWRSbksydUlHcGNPN0lPZldUWW5OVWlPeEg4aHVsdHhpZ1Ev?=
 =?utf-8?B?cFpNNVp2cno0T3p6WVpYQnNiRzZwTXpZR2p4RVVqRncvMGd2MHJlM3UxTXNy?=
 =?utf-8?B?ekkwSElsdmNzNHpLczdud3lURGFJRk5NbkxNTm8rRGxyZ2t3V2cvNzc4WGJo?=
 =?utf-8?Q?v1Q+YhZVU7qgyxlz23b5cNm6d?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCA7258C29854644BF27B673C5083FCD@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ba943d50-4599-4e42-0de8-08dc313524bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 10:25:49.8995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJAapoX6CgGJz1llVkpUEUxut4sbiplUFTKyDKofcTNHXd+sLHNZHHjroq7qk7j1If0WbTNNDGUIjQBsrOcW+DeUKFtRlNOXhY/7bDG/z2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2545

DQoNCkxlIDE5LzAyLzIwMjQgw6AgMTE6MTksIFNpbW9uIEhvcm1hbiBhIMOpY3JpdMKgOg0KPiBP
biBTYXQsIEZlYiAxNywgMjAyNCBhdCAxMToyNDowN0FNICswMTAwLCBDaHJpc3RvcGhlIExlcm95
IHdyb3RlOg0KPj4gYXJjaF9wcm90ZWN0X2JwZl90cmFtcG9saW5lKCkgYW5kIGFsbG9jX25ld19w
YWNrKCkgY2FsbA0KPj4gc2V0X21lbW9yeV9yb3goKSB3aGljaCBjYW4gZmFpbCwgbGVhZGluZyB0
byB1bnByb3RlY3RlZCBtZW1vcnkuDQo+Pg0KPj4gVGFrZSBpbnRvIGFjY291bnQgcmV0dXJuIGZy
b20gc2V0X21lbW9yeV9YWCgpIGZ1bmN0aW9ucyBhbmQgYWRkDQo+PiBfX211c3RfY2hlY2sgZmxh
ZyB0byBhcmNoX3Byb3RlY3RfYnBmX3RyYW1wb2xpbmUoKS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+DQo+IA0KPiAu
Li4NCj4gDQo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi9jb3JlLmMgYi9rZXJuZWwvYnBmL2Nv
cmUuYw0KPj4gaW5kZXggZWE2ODQzYmUyNjE2Li4yM2NlMTdkYTNiZjcgMTAwNjQ0DQo+PiAtLS0g
YS9rZXJuZWwvYnBmL2NvcmUuYw0KPj4gKysrIGIva2VybmVsL2JwZi9jb3JlLmMNCj4+IEBAIC04
OTgsMjMgKzg5OCwzMCBAQCBzdGF0aWMgTElTVF9IRUFEKHBhY2tfbGlzdCk7DQo+PiAgIHN0YXRp
YyBzdHJ1Y3QgYnBmX3Byb2dfcGFjayAqYWxsb2NfbmV3X3BhY2soYnBmX2ppdF9maWxsX2hvbGVf
dCBicGZfZmlsbF9pbGxfaW5zbnMpDQo+PiAgIHsNCj4+ICAgCXN0cnVjdCBicGZfcHJvZ19wYWNr
ICpwYWNrOw0KPj4gKwlpbnQgZXJyOw0KPj4gICANCj4+ICAgCXBhY2sgPSBremFsbG9jKHN0cnVj
dF9zaXplKHBhY2ssIGJpdG1hcCwgQklUU19UT19MT05HUyhCUEZfUFJPR19DSFVOS19DT1VOVCkp
LA0KPj4gICAJCSAgICAgICBHRlBfS0VSTkVMKTsNCj4+ICAgCWlmICghcGFjaykNCj4+ICAgCQly
ZXR1cm4gTlVMTDsNCj4+ICAgCXBhY2stPnB0ciA9IGJwZl9qaXRfYWxsb2NfZXhlYyhCUEZfUFJP
R19QQUNLX1NJWkUpOw0KPj4gLQlpZiAoIXBhY2stPnB0cikgew0KPj4gLQkJa2ZyZWUocGFjayk7
DQo+PiAtCQlyZXR1cm4gTlVMTDsNCj4+IC0JfQ0KPj4gKwlpZiAoIXBhY2stPnB0cikNCj4+ICsJ
CWdvdG8gb3V0Ow0KPj4gICAJYnBmX2ZpbGxfaWxsX2luc25zKHBhY2stPnB0ciwgQlBGX1BST0df
UEFDS19TSVpFKTsNCj4+ICAgCWJpdG1hcF96ZXJvKHBhY2stPmJpdG1hcCwgQlBGX1BST0dfUEFD
S19TSVpFIC8gQlBGX1BST0dfQ0hVTktfU0laRSk7DQo+PiAgIAlsaXN0X2FkZF90YWlsKCZwYWNr
LT5saXN0LCAmcGFja19saXN0KTsNCj4gDQo+IEhpIENocmlzdG9waGUsDQo+IA0KPiBIZXJlIHBh
Y2sgaXMgYWRkZWQgdG8gcGFja19saXN0Lg0KPiANCj4+ICAgDQo+PiAgIAlzZXRfdm1fZmx1c2hf
cmVzZXRfcGVybXMocGFjay0+cHRyKTsNCj4+IC0Jc2V0X21lbW9yeV9yb3goKHVuc2lnbmVkIGxv
bmcpcGFjay0+cHRyLCBCUEZfUFJPR19QQUNLX1NJWkUgLyBQQUdFX1NJWkUpOw0KPj4gKwllcnIg
PSBzZXRfbWVtb3J5X3JveCgodW5zaWduZWQgbG9uZylwYWNrLT5wdHIsIEJQRl9QUk9HX1BBQ0tf
U0laRSAvIFBBR0VfU0laRSk7DQo+PiArCWlmIChlcnIpDQo+PiArCQlnb3RvIG91dF9mcmVlOw0K
PiANCj4gQnV0IHRoaXMgdW53aW5kIHBhdGggZG9lc24ndCBhcHBlYXIgdG8gcmVtb3ZlIHBhY2sg
Zm9ybSBwYWNrX2xpc3QuDQoNCkFoLCB0aGFua3MsDQoNCkluZGVlZCBJIHdvbmRlcmVkIGFib3V0
IGl0IGFuZCBpZ25vcmVkIGl0IGFzIEkgbWlzLXJlYWQgcGFja19saXN0IGFzIA0KcGFjay0+bGlz
dCwgdGhpbmtpbmcgaXQgd291bGQgaW1wbGljaXRlbHkgZmx5IGF3YXkgd2hlbiBkcm9waW5nIHBh
Y2suDQoNCkknbGwgc2VuZCBhIHYyIGluIGEgZmV3IGRheXMgb25jZSBtb3JlIHBlb3BsZSBoYXZl
IHJldmlld2VkIGl0Lg0KDQpDaHJpc3RvcGhlDQo=

