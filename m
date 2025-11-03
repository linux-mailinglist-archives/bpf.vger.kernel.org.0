Return-Path: <bpf+bounces-73380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DE2C2DE30
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 20:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5F81899998
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 19:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E8531C56A;
	Mon,  3 Nov 2025 19:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="COYIPd4T"
X-Original-To: bpf@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020123.outbound.protection.outlook.com [52.101.191.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5D23717F;
	Mon,  3 Nov 2025 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197729; cv=fail; b=t1UepUYwfpwv/WQD4gWEyzw5QP0Gw5DP2yvnbiRPZ9knGGOtB9c1HXAX7E04Cn5lqFf1DxZhBHssm5aeDFjswCu5s8XGUKRrpsLKdlW66uwqtXz7ndjcewVP8jSreWy8nGIfnDXKHSOtT+rky5ikjIeLUksanb88Qddd4yk2PkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197729; c=relaxed/simple;
	bh=Blk3CNDl2XyCEHj1Lh0z+lxjubuZ7XPtNIqezHagVbA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FQUJMRL0yq786ugE6rAmGGEg8xbdfTw3Nzfh9Wh8n0rimemvPW5qbT3OFIDJLzqgS2LdUlRPtUkO+/qum48yD5oMjPaViEmz+xoIPovQa64x+idbMvUs2UoKqOQXfouJuNb9YSQc9RND9cIXTM219IeMqUHmFSYAKIA2R991McM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=COYIPd4T; arc=fail smtp.client-ip=52.101.191.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+rZUSeupePdiMdBSLWJ+c4CY+C42jkLdx8fhEP5tqUE8E0pNpugMaRCP16gEXLbJ3XJFHMjhN8zuqgKoDgAc6gcmjgcAV7VQjIpGtzctKI1wxsqdFY7nCtV/kr5eWikDYYcAX0J3OS4RvouvA4z/yEWErnShD/zDhOgnBBWgBT9rsM/86SOP3CVcpARvCBJd/WljXmLhkaFuoUNg7V3abTma9oBsU+uWB1Ux+x9kTmvCUBxUqvnaPvU4ya7Y4DuDfqQLsBbxbqmz17+T/w4BBKFSHvWB+Jx49c44GgyddLkgGEyAZ4LF64D90o0uzTYx9XU7/zwmro6oJ6nGMl+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McGzgYPbvxfk/bo4MKmIBtbjg62X1T6yXQVSbCa15mY=;
 b=RS3DN3cknISaoC49vqdX4uHYzSJdRL+99bno+Zwl+/pX1MLn5Dmzi19pZNjeWGXc+HETk3LAgICGnZAT5EVwaXdfRg6QKio4NxhhRNzvraXygj+/aU7f+yY8OHEn7BlIEhchjxoOqLFg+Vhl71ikH5+cx7XpPafROhqzVDYhzfAm8f6etYq6DT9SnMBo3dErNuiq3L0gUbYbWE/YAoC28dbiBO4glo9ZXI2RBCknVhFhgsiH87TPAFw5Nedy5vWl27zqXycpIdIAXQxKdhwxT+YhPZKMtAiBDyN0N3JlhNklHV/HH1eWda3aMNr18Gxagp/F/0KPNgGPS09vt/jK9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McGzgYPbvxfk/bo4MKmIBtbjg62X1T6yXQVSbCa15mY=;
 b=COYIPd4TyZKXRDOcM25ronZNcBU8imzTmFgPpxfHwUkePz/2dNFssZ0PxzwxU4eqBzyVPFPlKRSQNyQ6Ef26bvo42DA1yhnl23q10rU9Za/WGbvTdvQAnlBum6cpmem8fCr2Egkp0cjYXDGweUmBpLK7udmBY+DZIgCw3qhY4sJEeOnSvh+Ul63hH0GDgRQ48XzyrJcfTRKH5ozh7KGjNxZh5q4PXDftxvaIdRSoDjNZr5RXIK9terYE6yIwxxAkpB9qRgIE32pFWpQg10SyLUtgZtmTiVfzU9kkXHaNzZjZoZp2hjyQcVz7EjfXiDIZD0EHl3zJyzn3aGZc6qg0nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB11161.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 19:22:01 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 19:22:01 +0000
Message-ID: <98fa1a01-400b-4496-997c-1f84f33dd1ad@efficios.com>
Date: Mon, 3 Nov 2025 14:22:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/19] srcu: Optimize SRCU-fast-updown for arm64
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 rostedt@goodmis.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
References: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
 <20251102214436.3905633-17-paulmck@kernel.org>
 <b2fb5a99-8dc2-440b-bf52-1dbcf3d7d9a7@efficios.com>
 <f89a3a56-e48a-4975-b67b-9387fe2e48c6@paulmck-laptop>
 <7cdecba1-2b30-4296-9862-3dd7bcc013d8@efficios.com>
 <8a33bf08-8ca4-4fc1-9481-fff2247e5518@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <8a33bf08-8ca4-4fc1-9481-fff2247e5518@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::8) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB11161:EE_
X-MS-Office365-Filtering-Correlation-Id: 617cc052-2307-4ba9-2613-08de1b0e43b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFV1Zm5OMVdSNEZ6bEdjdFNjdEV6K2xxRkhVZFU1RU1TV3F3ZWhXMVlmY2FU?=
 =?utf-8?B?cXBBMEx1R21aYjdqR2RXSEN3TUpVNXFWV1V2RzZ5Wit4NkJ2Zm9qeEE0Vk01?=
 =?utf-8?B?aGJtQUVZZkZMTUJrdzJka3l2dkFQY3FNSU5nTUtxNDV1QXFHMVJKRWx4Q3hy?=
 =?utf-8?B?N3hZaXdtaFpMbTZlRWx5cUZMSXRHangwSzcxeGN0WUsrMHVXVkR1S09LY1dv?=
 =?utf-8?B?T3o1ZEN3NThLMUlCMmgrdGFka1BhaHp1T2VxRTB4TVBRZXdKRXFDV0dqKzVH?=
 =?utf-8?B?NkRxWHNOcFNXcDJSRHRHSWpDczlrMlpicG45Y3dOQndOYW9xeHp0KzdLL0RT?=
 =?utf-8?B?dXJuNm9ZY0FDVnBXY0VPV1dlSWM2WHI5dTlHV2s3MU5NRWtOdk00VHhCcldX?=
 =?utf-8?B?SHQ0TjE2WDcwT3dIb1czQkQwdnFacVVtSWR1V2NrekgvaFpCWEVjZzNaeHNu?=
 =?utf-8?B?NzlpanF4cjhUNGwvUHlpUmZWYnYzQ2w2ZHVTZE5aQzlwZDFYendFYXErN09B?=
 =?utf-8?B?WVdpbUNNWVEwR3RYczJTa2RPWGluNW9hWElXbXBOSVp6MGc0SVBFVFdmRlV4?=
 =?utf-8?B?Rk4zTXVRdklvYk5rN1pNZGZ5emVLTUZaZXY4Uy83bHFCWEJDRkZ1T3JhNXZQ?=
 =?utf-8?B?ak4rVzI5NUxtb2tIQ1pJVWJaRG5rRDJHMFVpWmt1cFNUc2NLV1d2alBkTkpr?=
 =?utf-8?B?U0luS3BEdmFaaVM0Y1N5Z2I1Z1UxK05Iem4xSGNXdExqZnI1K2cxS0FOM3kr?=
 =?utf-8?B?aTRRZU43czFiM2toZndGay9obTcvWnBXUFpLdHlaQ2JKNDVuY28yclhyU0Ix?=
 =?utf-8?B?Slp0cDNYRFFSM1BhdGpNTjdlUmozK0FoQWMxTnA4cTBIdjdlNm1xekE0aG5a?=
 =?utf-8?B?SjZLaElmYWJpR2J2Sk16WWNWOWVxQk1Td2pDS1llTHd2czFiTDBkNnhhdkRq?=
 =?utf-8?B?ZEROdjVDTE5UTjh3NCtKVEJzTUhaUmtZL0luSlY1eDdRejZqMFRMNFdWNENY?=
 =?utf-8?B?bmZHL2ZtbEYyR2hVSDloV0NkMEF5bm9meEh1MStQS0pxQVFFUlRZY05uS0I1?=
 =?utf-8?B?WWRidGhwMU1BZUp6S2UwSFd0WVBFWTI2c2RYWUtudXdnWFI0TDd5ekx1d1Nl?=
 =?utf-8?B?NGNYdjl2dGd6ZkM2bU1iTm1GV1l6TTR0T0NpbUxMYk9ocmd5Q3M2ZW5OWEpM?=
 =?utf-8?B?a2RyL1pFekJQdnB3WCtqbHA1MGkzbmVnNjJVOVlaZER3UC94MnduNExzdXV3?=
 =?utf-8?B?TjFXYlU5SnFndjMwaGdzcVo0VGh5aWlnYVo2YURVbUNqRTNOdnkzM2dJV3hu?=
 =?utf-8?B?QytCZFlxS0l4Z1RUSEFWTm1RYzFQNFAzWUFqaDFYTDYrSTE2YmJORDQxMjF1?=
 =?utf-8?B?WmZOY0IrOHhuUnpaa1M0RFBKVHh0L1RiaHJXOWVoVGRRYzBYaHFwcU5NM215?=
 =?utf-8?B?Q2F2QXpJQzl0N2dvMHQ5bDk3amVMZFhkMWkwN0RTakwzYm5nVTcxbXFhK1Jv?=
 =?utf-8?B?emtSWjNvd2tOQlE0bzA0eGV0eUt1STBmeThuUGxONm5WczNiYzNpVXVpQ0tX?=
 =?utf-8?B?UUlzYWpoRUhQeFNJRG53aFJaUWdOYkVueEZ4Szh6THRYMlZjRDZ6T3VvQXJQ?=
 =?utf-8?B?WkxYMi9GL3JnN2RxZVJjRnJZL3ZJUFplOWJMeTJmSWR4STVNMXNUNHczRjB0?=
 =?utf-8?B?enJrWFlnTGJKVG1ENWh6RGRMUDVmakNYeEZBQU5kNFJ3a21LbVJvWFJydHhZ?=
 =?utf-8?B?M0N0aW0vRHdKQ0RhQzFQUktFSjUwbWxQbGZ1MDlMNFdmZlA4bUl2Ti9SMUpj?=
 =?utf-8?B?QmRrcXdNMUVoTEFyRTFRc0lsVi9sWGV5dlFuTkJlODA1bFZyWEtrMGhnS1hW?=
 =?utf-8?B?bFEwektuMEcyYWt6akNxRm5KWEJIVWRCS21DTGpTdEdGUHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzlyRFFwUEFkNnl6Z0xTRnpiRWZtTlFZOWVyRWx5OUZIVWV4TlNMcTlNZ1dQ?=
 =?utf-8?B?Si9sNzVkTWRRWXRCOGZOc0tXVEZJVVhXa29oc2tMcnlLblZxUnFzeEZMWkE5?=
 =?utf-8?B?UXh3NmdQVWtkMVJQSUdvU3VpL2JITVVxNXF6WHZWb0FEdlgrTElnQ2UxcE45?=
 =?utf-8?B?MjI0TE5GelA0bVBCcW56eWlzdnYzR3FDTlZVSm1EVDFhNU9SZWI0b0szK0lK?=
 =?utf-8?B?NXZUaVpaQVIzK3RnTFlRRDBOdTNCR1BDaUsvaWk1OHhMS2FmQ0RpSk5UV3k3?=
 =?utf-8?B?K2pkWVhoM25iQlY0Vk45SVFtbVVROHU0ZGVWRHVpV1dwRGxxeWQ5dGFSelN3?=
 =?utf-8?B?R3o1QlQvdi9tbEtjT084MXltOFFlVU02ckZmM2hiNXkvc3IzOXpBRVE1MjBD?=
 =?utf-8?B?NmltRnRPaFN4bWtKUVpPOVlsNlAwVVB6ZnJjZE1wVlhYTDJzTEdnL2xHTkh2?=
 =?utf-8?B?NnRCMjByRS9JY1ZaNG9MYXJEZXJNMjNiVHV0K3B0ZGcxY2ttbERIV2dycmNk?=
 =?utf-8?B?NjFjdG5LZE16MnFSQ3BqT091UDBDQW16TmJOT0pTRU5Db1o1NEVjalZIMG1r?=
 =?utf-8?B?OVlrK3orUTJtQ3dsOEVxMEpHSVdIcGtucExIR0dDU1ZCdWYzMktuZGFlbGIx?=
 =?utf-8?B?NkVPdld2Q3Y2MTNWSzZSQitvUHdOWmRyd0FzQjY3T0xFUFlSc3NKRElzSTVr?=
 =?utf-8?B?bitRTWxFeTNyNEJNM3VaanRJeENiMEMwZXRCd1J3Y0x1cVBDWFZwMDNEc2tL?=
 =?utf-8?B?MVNjdHBnd1BzZDlQbW9UUXNtNnB2a1ZVdWtUbTZiUWZjdUw1S2N0VmozWC9i?=
 =?utf-8?B?MHcvY2syTjhNWGRpVkhValBtbFJWUyttd2ZIU2x4N1BSWUtTRXhrclczb29p?=
 =?utf-8?B?bzJGMGZDL2g0b0syTGloa3NjeE1DaURlY0tWREprMG5aMWl3Yit0WEVBejBm?=
 =?utf-8?B?cU1tWE1VaFJud2Y5S01hNEFZaFBYVlJ4cEh0dWJBb0c3R1BqL0poUnhiSHVV?=
 =?utf-8?B?NzNscmRwditwNzZxOHkzeGg5eUh0Z3cwZE9hRndkb2kzVkVEUU9vUnJnRERm?=
 =?utf-8?B?YmNJUHJNQzVrZGxQSENnUldYM3NEQVpHQzA3RE5IRUhGc215dzh1dFdxTW9R?=
 =?utf-8?B?VzlkdXJHRTZmL3Jhc3dub1FVWXZiLzBtbElldisrVWFpZkdoZHVWUEk2L1pY?=
 =?utf-8?B?Yk45RTd0bzFaVlJ0RFpReW00Y3puSDdBcjcrcnRBdDJqelZXWmpKSVJBaFQ2?=
 =?utf-8?B?MmZJVUNvcWdWSFNnOXA2clY5VHA4SXVqSEcxMEhCR0w1bzlqNTU0TGpZNHZ6?=
 =?utf-8?B?MlBwSXdiUWdzN3RGMG9WOFduZERaQURMWnI3SHNmZ1l4aUtmOC9CY3VQelI4?=
 =?utf-8?B?SU5iRXpzeC9NL2ZiNE9Wc1dnckw3dXlKdjl4MGdhcnY3NHphU0J5dXlyVGRE?=
 =?utf-8?B?VS9UMFk5VDFUblFKd2dlM1BPVk9QZWJCeUlneE5BWVNVZXN5dXF3ZkFUSzFx?=
 =?utf-8?B?S0MzTFhLZUVqVU9oQTB1WSs4SHBYMFg5cmlNdjUzV2k5SkJBU296V2FZSWtX?=
 =?utf-8?B?Y1ZoejkreStnMDA4clBtcUpMaVdrZkRMczZ5ZXhhc0wzYndINlcvM2s2TEM3?=
 =?utf-8?B?eTNNQlZETWk3MEM0QmZLeTdjSmFMWlY2eHE4YzZFd2N3N1RqdTlEODdIMDZi?=
 =?utf-8?B?dnRUSjgwOXZxL0xMckpKSE90NU03UHJQVzdGcnFZTWtwWVRMS216VGFRS1V4?=
 =?utf-8?B?UmVCRnVJd25FbG1DOXdVSExxZWc4T0dlUHFZZDQvQ2RaZ1lySDAyYlFJWGpW?=
 =?utf-8?B?M1lLZm8xSVZoVGhrd21Zd01LSTZJL0ZOZUVTaS9GNkp1dnNKQlRpV1hqNEY0?=
 =?utf-8?B?QnBJNksvZGl3ckQvb0dJZjQraDgzcjZ4YlovRWdCSmVseUlSNjBoQ212Smx3?=
 =?utf-8?B?aFI5VmJPdXdBUVZZM1lUNnp5anRGQmEwRkg4aGlTcGdadjg1T2xKY0s3Ty9m?=
 =?utf-8?B?ZVMwd3BxTWUwRnFORGozazd4d21mK2I3OHp1TEhtWUVFVmNkaHJrUkVQbjdJ?=
 =?utf-8?B?L2lIOHhOTU5YMXByV08xUU85U2RDemhrekg4ZEdpbGp0ZkpUdTBCNGVyWXcw?=
 =?utf-8?B?VThlT0ZOOWNYL0JCSU1vbm9VL1g4MWl6Wk1xYzluMGRMU3F3OHRPTkhuS05K?=
 =?utf-8?Q?kfOcMnAXLKO8x1Q0VEuSrrA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617cc052-2307-4ba9-2613-08de1b0e43b4
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 19:22:01.4183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y68OXspuNKjc8gGZDjtFig2ts9HeSLABmyyw15cz4i7dFDrMcGgu5cmt/H37FIy4c+ajspGcFxD8pQwBJtYU9isFlHjiWTcUfeJGs48+yws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB11161

On 2025-11-03 14:17, Paul E. McKenney wrote:
[...]
>> This is effectively a use of split-counters, but the split
>> is across concurrency handling mechanisms rather than across
>> CPUs.
> 
> Ah, got it, thank you!  But we would need an additional softirq counter,
> correct?

Fundamentally it depends on how you want to split frequent vs infrequent
accesses.

If the fast-paths you care about are all in thread context, then you
only need to split between percpu ops vs atomic counters. The per-thread
accesses would use percpu ops, and all the rest use atomics. The "all
the rest" can cover everything else including softirqs, irq, and nmis.

> 
> I will keep this in my back pocket in case Catalin's and Yicong's prefetch
> trick turns out to be problematic, and again, thank you!

You're welcome! :)

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

