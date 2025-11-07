Return-Path: <bpf+bounces-73989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5837BC41E1E
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 23:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE0443521C8
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 22:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E263195EA;
	Fri,  7 Nov 2025 22:50:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020122.outbound.protection.outlook.com [52.101.195.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5E6315790;
	Fri,  7 Nov 2025 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555816; cv=fail; b=CdYKRPq4+dGkWIANRVd5YSUnvj5GPJ1muIkSO2aLrkvOTWpVvQ+dlW9Qjl2RdDEUa7l54RB/+N75Bxl3wMkKb1LrJ1HrsJ0rAhuEFuLgFSOEUVwrWAsFH23ZqzuziVaAVIQNcKxLoFkaiWJXQN5dhkP1pHYZJXfkWUGalNVIdDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555816; c=relaxed/simple;
	bh=bBatQFAtjUxgAXfHwerAGS3BgBixfNOATHfeioijZ+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mC6iIwlvduoWjy/0EpjfjkortK7q95feDYDvSw8l4+j2Lb9hM63GViDSkfOoOCk6tqtSjhQaCLLhaYmQkzLHWxrIlTXAMTVVohBr1G84a6DBrwFccP0iNqan4Lz5yUZyj79xR2CRKTuvL9Bz1slnyViMn61RnW+5cndKy3+s2ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ew7h0bzWskB/3ycEbnk9p4+4zACaD2pQZJV0xJ+dX34Hrens1VWfrRfiJEMgIZG3SjWa6EPjPoikMtL7y9jesugKaxib9oUEAALos0entOfjLiLzUC1vnq2yJTtYaGurRl6N7irKMpLtwXFnZfnsYmHBxpgtVyhLsG/jfe2AWLmLvwLEjVpGYb5I3p5X6v7JWf0Hp7vp0aj1GSqISJLwVynNjsDAUDnHcKXbcOG2f22YbmHhjOhdJ/2Xx57zVJYOo+Oec2iA1JUGknvrMqv0l7CrQ8tZB8Uyk2OIaEhhf3RmQ1DMeWkTrGo+BukwXzpSPfE0jPNZykkOb4drc8I6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaLBujlh7CB7cnghSBMrCfJS4MDQT5dIXtIQe+0eP+k=;
 b=W0LLwGFuHKVNlCd0YYQmrGls/sGFO56J9T5DQDFVkw82zHYgP+tJf5zhaUsRWrxF9elmfeGPbA7Xo4qICHMuoyHtavyT+KSeUte9MY5IOh1JypnIKaK5/kTI6ZnQ/CZuypKQ9OKb54otV3iYz3ifxxL9hyg07zx0o9K23+ZxoSQas2z2ysGVRgRozmRDqwqcA79f9DAxbZrkcEuj+UXyQodEQ3jjMeoWO2lx3mghyXSJnFJygk0s1Hjwh2nxDU3MSbkkADGvutD7T62XOIMCkd7ML+VFfDFgPHXts/hhVhB0Ir0jGTVn4tO9T/QmWpR6mnq50efpZUsoUKmPzXSeMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:be::10)
 by LO0P123MB6688.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 22:50:12 +0000
Received: from LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
 ([fe80::8242:da40:efa0:8375]) by LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
 ([fe80::8242:da40:efa0:8375%4]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 22:50:12 +0000
Date: Fri, 7 Nov 2025 17:50:08 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <kees@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] kallsyms: Clean up @namebuf initialization in
 kallsyms_lookup_buildid()
Message-ID: <m7fqnnouanoiplm5vyt6su62txcm3zqqv2flgovlqggjecjauo@b3zkvy4yeamx>
References: <20251105142319.1139183-1-pmladek@suse.com>
 <20251105142319.1139183-6-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105142319.1139183-6-pmladek@suse.com>
X-ClientProxiedBy: BN0PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:408:142::13) To LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:be::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO3P123MB3531:EE_|LO0P123MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: b284d39d-48ba-45fa-31c0-08de1e500273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RytqZ0cxdUxKM2xLS2VGY2RidTUyNkRnOFlIK3RLL3RuRWJCbmk2SWpZb3F6?=
 =?utf-8?B?UVJWcGFFR2hiRnQva3JIakJpTWRRTXZWbVFZZUUxemRDRHJUWkI4RTRFaWVM?=
 =?utf-8?B?ZVZaK2ZUallDNk12R1V3QTdETjlJYkdMYmVTbVVKZjNhR1I1WkExaVA0bHdF?=
 =?utf-8?B?bGg4NW8wV08zTnBXTzg3S0lRUm5RekR1SzM5SjF1bEdBSzdoMmxDdW42NkVU?=
 =?utf-8?B?VCt5a0M0UU5JR1NLME1JSmp1WjRiNjRCRlpYN3dXSkNyNHd4QlVDbHRRSitL?=
 =?utf-8?B?NnR3TTlJNHZWT054b2RqRGMvdnpVQ0d5VUZJU1Q1MFdOTmJwQmN0NkV2WXNu?=
 =?utf-8?B?WGxHSDc2M3FuTzcwSTRJejdUZjdPMS9Lb2o0RnlKSU1zYTl2MjJ6RmYwS0x4?=
 =?utf-8?B?ZnR0ckxsYUZNVXVHMUlXMXlNODcvSHFpUEZiRHFXc1RJS2JoQkRncDZwS3hN?=
 =?utf-8?B?VlNPdkU4OGN2a3FUOGhBZ0FwakRmem5yYkZqTTFLbUlvdFFYTC9MV2wrZ3Rq?=
 =?utf-8?B?c3VjUXYvMlJXK3pmdHA4SWJYTWl0UXFRZXhvRi9QYkpuU09ORS9zdXJLMDVD?=
 =?utf-8?B?S2drWk03K2pDMDY0SEFZTDJmQnBFT3BnaWNqSFQ3ZDNrc2xYU2NWRENhNFBX?=
 =?utf-8?B?SFlnY25EZ3d1WGZDOHFsTkpOZFpCZ0VIRTRRd2hYUFlWRzdnYUVaazBLTVh5?=
 =?utf-8?B?MHVyZTBmOTIwTlJXS2Q1WWhETGNtNEoxWllNaGZET1dQdzljcmp4KzFtMXRw?=
 =?utf-8?B?UkhoM3ZUdzNQd05iUzcydHRVSVNQbXpIWk8rbTRxN24vbU9qdXpKVEZQZ0Ru?=
 =?utf-8?B?Q0FpcXl1UVA1TlNWaWI2TmpPUzR2RlVncmhaZXpJSEhIS0g1MjZLTjJKOUg4?=
 =?utf-8?B?SEIwMGJlWDRUbi9wRXV1TFhoU2p0eWZEZmxHaUxONTZ5YkM2ZDF4R3pob09s?=
 =?utf-8?B?NWloSTM0WWpYY0RzaW5QV2NzWXJ5ditNQ0RoVDJwUTdOOXZHYi9lMVRaK2xu?=
 =?utf-8?B?WHpVL1Y3Q3R5SFgvYVJLZVdKZDllNmVWa0xrSmtKc2hCR1JhM3FXTzlwY2VX?=
 =?utf-8?B?SllXdzgzLzVSZGFueXRYMUZIMm1DdVBhNVgrR0o3T2ZuaWRrODRDbExRY3RT?=
 =?utf-8?B?YkpuVkk0c3dFdnozZFdndXJUZkFZSmZwOW5IbUxSeXpZdDlLZUpVQUlTb096?=
 =?utf-8?B?RitxcVRUdElEdTVqV0ZtVzNIcjM2bGNIYXNNYVBOZUZVc0tPbGE1M1F0YnUw?=
 =?utf-8?B?eE03YlFVSzN0VDEzbXErb0tpNzc3ZFE1WkRWMlk0WitvSlNIb044YjVqbzNC?=
 =?utf-8?B?b2paWFYxazNVR0F4VzZEVnlkLzV3NTV3TXRmZXdRSVdNbVpEa1cySkJyUUdH?=
 =?utf-8?B?bHY1YTl4Y2FuUFZJZTlUU05CVjNkNlNzTHpiRm53d2ZoZlNxUG1Qc01uTmxN?=
 =?utf-8?B?WXRmZlpzSVpqa0huVUh2cDk3R0IzOWx4b1Vqb25xNG1zWlBxbzFacjl5WldW?=
 =?utf-8?B?Q2dMQUNKVzErWGJsWHdEeFJIa01GN1ZzNmVNZ01saTh3QkJlV250ejBiaVBh?=
 =?utf-8?B?QmV3N3cxODYyQnZlbmxlYzhwL1dDdGphZWxTTzdweVhaVE1IMkN1eHFJdnJy?=
 =?utf-8?B?ZmNOZytZM2s2WWswR3k3WHVaU01xTW5CdWkwVVlIYkJPTlJweE9wZkJINC9y?=
 =?utf-8?B?ekhTZTVleVdTcHVaTjFjLzBmcmVuTHF2Rzl3S05kaDNsNDVJNGEzbEh2aDBv?=
 =?utf-8?B?cDRKMGhJWEx6dHJWZ1JHNDBWTFlCRTlqbG16M2R6RU5QTHc1NUp4eFcxR2Zu?=
 =?utf-8?B?YTVYcWVuWDBpUmlmUGVxMDdGb0gyTTN6Qkg1dVkrVm50MWs3cW9JcXRlbWRM?=
 =?utf-8?B?KzF3MjJjUFIvUi9oVWFzNXNYeTJ1dnNkWFYxK3cyTk13ZVJGR2oxbW5xTFFZ?=
 =?utf-8?Q?gWc/jXxaS9DArHoWTuN0S/PevKU8Bke8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnZMWCtlbmYwMHE5YUdDNkFwWkJvUXJDTlJlVWFzMnlvQXY2QkxNbUFjZjJQ?=
 =?utf-8?B?VlV4ZnpSamZLaU54RGlsRDRzaUg4a1Q0T0diaCs4K2kwYXloWXI3SWEyRS9n?=
 =?utf-8?B?MDVQWHl3YzVXdEhmaGthVmpzbzFZcWhGZENzbnVlczZsbWIyT3ZlelZkYWZ4?=
 =?utf-8?B?QmtEeDFqRFRNTUlUcHpnakRpcm1WV082ZkdQSUJyK1V2QmZaaXpYQzBpWFF6?=
 =?utf-8?B?aXh3MjRtbHZUQmc5bWpaaWd3clBEalcwN015VzZIa3owRmM3VWd5K05VUG1j?=
 =?utf-8?B?S2hOMkhxYmYyTXppMkRFYTNmNC9PWDZUeVg2RnB4YXh2R3dXeVZ0amo0TllS?=
 =?utf-8?B?bFZJdmNhMEI2dnNzU1h0K2pka1JYZi9SZDRrMmdXSWxPby90bHVMbGthVEt4?=
 =?utf-8?B?ZzhFakNkTDRaZnVLc2NKY2FpbGYvbGhzaXdYdk9qcmVjMU01YUx4eHhjekJq?=
 =?utf-8?B?M2hBY0ZZSUdlUG12SzVBQVRVRzBmRHp6ZmVoZEVuMHQwOVEzL29QUFpHQ2pB?=
 =?utf-8?B?R0pSTTdxV0Z6TWdjaVJpSW5icXFDc3M2QUtwbWlwUkVIbHdRTGNOcXR4Yzhj?=
 =?utf-8?B?a28rRzVnOFJDQ2lUdE5HOHFqdzNFSTBJMHhKdncvTG1VNDJsZFdRczRLbHVX?=
 =?utf-8?B?aGNKOTF6UXBzV0w3MllJekFwK2d3MUZZOU4vQ2JkYmRJb0pzVktzNXNhaHlX?=
 =?utf-8?B?d21FeFo4cHIxUjE5MkltWVNtZFBidVh3bzFvUklWMFM4WGVEdDEvaXhpbldC?=
 =?utf-8?B?M0loYXZuK3JmenlkY3ZoSlAyYThrdHE4NkRvVWRZVGo3ZHZ5dWpCd0VIYUpp?=
 =?utf-8?B?L042SDlXalhnc2l3L2RlSjM0NGpaMm1XSFF1citUTHZINFBuTTczRmt5c1ZI?=
 =?utf-8?B?c2trb2k1Y2dpV3cyYnFYZEgxVEswQ1E1T0ZnbGlFSkdiQnNNZzYxUU1IVVVO?=
 =?utf-8?B?L0ZCeU95blJCeVBHaWw1b3NObDhOSjFKN21WUEt6a3I1alFZdEpwSkwyN2R0?=
 =?utf-8?B?anZmbEtYQk9rVXR6VFA1NEdnVVEwRSs2WnpoRVE5eEpyVWpTSFBiaGpWYURy?=
 =?utf-8?B?cDdaV0xoa3A4NTYvTU1zOHZZdVNDdGppMDRWVExLY2NjL2VYS0MvdXpzeWRo?=
 =?utf-8?B?cGpUckhUMGxrNk4zL0RoSitlVW96eVpiNDJVTGZsRnlGbjIzWndlRldoalF1?=
 =?utf-8?B?V0JSeTZuV0pzOWFjSjY1aDFBazZPb0VMcGtBSmEweWNyQ1B1Vm82SDFZa1c4?=
 =?utf-8?B?d0hqaUZRejhrcEYzek01TDJBVGkyRllvYksvOUJoTkxRVk1lRFhpY1VqYWZN?=
 =?utf-8?B?YlRUWmpBdmNkdjBOVi9MUkRsdVJ5OUJCbng3NktsYkEwSEtVM01EMnI3M01Y?=
 =?utf-8?B?L3JyL1Z4L1R6SlhwcFFQOEpYSVZ3UVBkZ2FjM092ZlJtYjNJUlFFOHBqZHB0?=
 =?utf-8?B?U29OY3BCSElJMm1UN3U5c0s5RS9BRDhFVXJHcUFYM3dqcHZDbmtKRmIyTk9L?=
 =?utf-8?B?c0RFL0lyT2VpRW0zRHlJTEk1YXQwS0Q2SnYvdjFIQTdPQnVoTHpCSlNuNW52?=
 =?utf-8?B?cm5OQ1lXaGhtditsbU82dnk3RTk1bnl5S3RwZWpZMGhYZHFpUnVOcGk4Q0Er?=
 =?utf-8?B?R1VuRDZ1cW94aTcxTytPS3NhUWVOWWYzYmJuVlVZZlVaRzgwVWp4Z3BqaERz?=
 =?utf-8?B?VVc4cTc4cXhaWXVhYzVvbWZ2OGZaeHhDTE1NUkh2Z3JJOWRuRlZGRlFldjZ3?=
 =?utf-8?B?STg2YlRPQ1l0dGc3RWJKT1VYTFpUYW91ZHF2NVJTUCtkOHdFZk5BYTRSOFYz?=
 =?utf-8?B?WlRlYWNZbStYR0RJMDI0OUU2TlFVdVJPejBmQzI5aE1SWHdWOWp1QWhRMUIr?=
 =?utf-8?B?TzU0c2FkSGRibTJJdFQ3ZVdKZ1BIKzZLWWJrcWNLcHdQT1BRY0lCaUp2Y3pS?=
 =?utf-8?B?cS9zV3VJNk1TN1pLWm1JWHJ2aEt0Rmh6RVhsNnptb2JGZHpIcDdIMTk0Qk9l?=
 =?utf-8?B?cXphWFNnbk4rVmkwZXpDK2U2QmNOVjFMNi8wNzBQUDU2SWxRdjVyWnpxcndo?=
 =?utf-8?B?amdFbDRxUkZHVDRpWWx0TGZpVU9sT1dRdk1aTTd5MGJLU0RIcGZkYzRJRE9a?=
 =?utf-8?Q?1euE2qf1Op0EshchS9lt3x6Ol?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b284d39d-48ba-45fa-31c0-08de1e500273
X-MS-Exchange-CrossTenant-AuthSource: LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 22:50:12.4045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: te6jKzAUqQtkFoObJ5/u1eed3uJVimWVrsPa9DInHvrpy6X+eM2U74JRdRw7l4LjXSJrCj5dObAR8YF9KHtyAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6688

On Wed, Nov 05, 2025 at 03:23:17PM +0100, Petr Mladek wrote:
> The function kallsyms_lookup_buildid() initializes the given @namebuf
> by clearing the first and the last byte. It is not clear why.
> 
> The 1st byte makes sense because some callers ignore the return code
> and expect that the buffer contains a valid string, for example:
> 
>   - function_stat_show()
>     - kallsyms_lookup()
>       - kallsyms_lookup_buildid()
> 
> The initialization of the last byte does not make much sense because it
> can later be overwritten. Fortunately, it seems that all called
> functions behave correctly:
> 
>   -  kallsyms_expand_symbol() explicitly adds the trailing '\0'
>      at the end of the function.
> 
>   - All *__address_lookup() functions either use the safe strscpy()
>     or they do not touch the buffer at all.
> 
> Document the reason for clearing the first byte. And remove the useless
> initialization of the last byte.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/kallsyms.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 71868a76e9a1..ff7017337535 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -352,7 +352,12 @@ static int kallsyms_lookup_buildid(unsigned long addr,
>  {
>  	int ret;
>  
> -	namebuf[KSYM_NAME_LEN - 1] = 0;
> +	/*
> +	 * kallsyms_lookus() returns pointer to namebuf on success and
> +	 * NULL on error. But some callers ignore the return value.
> +	 * Instead they expect @namebuf filled either with valid
> +	 * or empty string.
> +	 */
>  	namebuf[0] = 0;
>  
>  	if (is_ksym_addr(addr)) {
> -- 
> 2.51.1
> 
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin

