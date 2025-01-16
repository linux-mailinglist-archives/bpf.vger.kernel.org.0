Return-Path: <bpf+bounces-49084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EB2A14262
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2686188BD45
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 19:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EE5230981;
	Thu, 16 Jan 2025 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OiwBMnWQ"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2084.outbound.protection.outlook.com [40.92.91.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ACA1F37B0;
	Thu, 16 Jan 2025 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056263; cv=fail; b=Eyt5AI45OfKNmQhHadIreUbPsFBhrWq/XO5xqleQ/sneLYdnpjucaYbwD/Hdj5sMKud8i8CmWUVRTEWQx1f9sNfrnbHL5nXOWC3tJekJgOrMidTqxItuPs3TX6XKMxUWfF1nZ9EL8vMrelF8urdIs3yKp+bVmE2W06F1usBFBE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056263; c=relaxed/simple;
	bh=eYXhkdcWTBC8bGc/nS6VB9408KeOZXhYA1DkKp8nMA8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VX1mpoksktqw3Hfm5bdI+0UW4wOzyIQ1HIAqhmwZ7VRF8L4xv7N50dMhu/9OsQeJ76QpH9GCBuxm3SnTSFFItnRaIGVeDNW7p6xU8x3uKVQpY6fR/5eOLVZ7F90i6bCqq5tHf0MGaxypdhILylxvo/GbnVJix9Ocxq4teXQor6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OiwBMnWQ; arc=fail smtp.client-ip=40.92.91.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3ez/FMhrahUg+aOvEZTFP9WXjGhjr0vQIof7RHo8TFfuo8AtjUwaFMaGw+p3vPR7tgTnUVvPAm6ZkwhqCOlIEYNgYIiceQXJIqxaN+BeY/sXpoNb66wpXi/kLOqRvVr5hCN5OTTIdoiyM63GoBIlx0wJVVcOXMhlG4yvL6h/YrzQUdlCVZybdBxuyN3HL+VBBy6BS/3xfBHHJ02oPeDDKb2N2Zhwefd/VkB5lEUhwFTtBZAfTxRNC7/bWlt2sGTMypCyi0etzQ2V78wbnd46rdaGibcVp53PLNZv6Fz71epLZcS0rBKb554SRvFF1Tgh/J9t381MOL0teP3paa5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1TU/is8c2yAtRsV8THK5ylEAkPlkfy/MyloHi9kgTE=;
 b=MtZvyzs7gfMAbIPwYCRq2YXSsC7CGFkgnbjLEB1QLuhXYrF3QNK4UfNn4EnM/8KBwm6CMmSvEeuKB8R2SVolcCyTajdpGqyg5VDxE8G1sBiosuPCtJHFUSAdWylFSEO7e65efd8NTISMm79SYFZ73iQckyWovBfgZifS1TSrjCDfyS051tyZDLqywxlA2ehtj0Z93yE3sl8lsb95GB+ziAb9ZVDCqLvrC/+w1YqYF6IqHzgZqR0ogotO+OjGf4PKO7G9KT74NNxQxM9QLEgpZsuNMrR3RlKOhVML5biESMfud+7Wz3ARTZxr9nGph86+KrF5z1ocsFP6jvd8IPSotA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1TU/is8c2yAtRsV8THK5ylEAkPlkfy/MyloHi9kgTE=;
 b=OiwBMnWQzxXaDjbymAh15POhK3bo6YcvrD/Ler9u1uPwloicJLCtpIbN3TKq9FomVleubnOYWHqTDwpmylAPMzCi5TEEbnoJHLUw4/1G3Qbg3XXE9nTA1slyj3cqc/mPaInEKOavn+f1M++5WTrhFd48db0C0U/q9fIIGCIRDc/odJaAq8Q/cmd75fMDyGnHZjbc/Quynm8Mwinr6TNA+DmXAY3c8Y6zHlZvJCdbvX/WU3BuZLLOtVyBFghv+wMfpJyEmYxcRWoV4/EikCWoyWvf5i8ia46NyO9+huJsSW/AffTJPVZjxBM+s0ljWJkJlVDKcQY20Xcavs5ufaa+TA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AM9PR03MB6706.eurprd03.prod.outlook.com (2603:10a6:20b:283::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.19; Thu, 16 Jan
 2025 19:37:39 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 19:37:38 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	tj@kernel.org,
	void@manifault.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 0/7] bpf: BPF internal fine-grained permission management (BPF internal capabilities)
Date: Thu, 16 Jan 2025 19:35:18 +0000
Message-ID:
 <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0301.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::19) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250116193518.14389-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AM9PR03MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a39109-beed-43c6-e04c-08dd36653c22
X-MS-Exchange-SLBlob-MailProps:
	V85gaVfRD4++ew0dOHhl6Xscvu48sr33tjG69mKD1qACWpYxVlSomz4RJVziM//vsICmk2m7ZoHFAq6lxGOSuL6c+5N4E+tL1qSfpaLRStIWTjCa2G2LO3dK/kTHpHB7i1Avg0IeRMIq5elRFrdcasjGB5b4sJmuON3bTz1Dna6e5vsxPkKXdO6vHBiuCgauyW59Ds9jb3nV/LP+RHF6K0UJ8j6jS5W/Cf9s9UwHJr+UqLzpebpRtCj9sjAQWNzwjnC4o+4fYd7/ox8b6y0L20jlTrqfxEX33XMkUuZXoen7bdF7AbDaiUoZ1G3NAuMyp6AhqnJtJilN0+heKydTpaE5ggplN1Fv7cHH1vXCTJBh/z2Pp5VATHeqUhyRmDfw9MtzL/IJTlb/V/t5vDK9/rWSxYmij2TdD89CLT2m49bHncSaO37MBjHpTfmocYdyOgZ8ryPYg07wM7lYzk390kycpEwP+bInYFHbLYNYBRThJ626XPNQbUss+karmCsI19S2x8PW4qZJmHJryVFCn6CmB6xxlQUa7NHwo1TvEebe2Ofi83SVdD/rU4aRCr87Tlrux2qfeKY6ziYAkvIVphLxxTIyifC2NhnVWrkB3V5OuVg6g3NEiXc6mRrugahco4E3U1g6t6Ai9Swfg4eYi1YGgoCwJN+4cAMxO9C7TGpBQDAKYhvTG26TfBK37B/rNzqwT5+Zb2nkasywgLe1/gj3OtIXbDKuAz0+BNglpkLCT5vTcDgun2ZjBWnfvgDoqjL1SwmUcJUEiT9VHGmbhQeA7t2RwkUskdhU0T5DIFrRhJbrCxiT3IYe1cYNi0TX0O3OjxK3PMk0DVwVfZG4XA==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599009|461199028|5062599005|19110799003|15080799006|10035399004|3412199025|440099028|4302099013|18061999003|56899033|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WDk7W+bJX/n/BaSPdD5i+7Xy8mTzul9YJIkoplxFfdIiadukauLJRgWu2QB/?=
 =?us-ascii?Q?FiDtHIu+buWTD+EgGMqtI20dAjSNAxWrj+BnUH+i9U50agA3w7ZsF8wd2sRM?=
 =?us-ascii?Q?sx8dFsoRRAdwzpwZ3pUi2aJenpZaWsJDxwZT3DZGTnBe9kV8nwnjE76IODxo?=
 =?us-ascii?Q?Jz96IPky99595R1SLFO2U/Wa+NxhGRyaXJPvy2kIT18tQabMU8HauifE+jYK?=
 =?us-ascii?Q?UEtVleekmw3QqDupswwpTugy/LWbo2iilE3yVxWvYgHgGK5qTV4+nXFjQfgF?=
 =?us-ascii?Q?PqLxTR+AQ9H44DIJMiqZZAJtLKZIfsAhSzBph9jZRLI73ku22EIaBmFPOpM/?=
 =?us-ascii?Q?egLMOrRgGquA44fNAv9c5W+HfIN3AswFTJAeVD34fSWx2FwF7AalExGXaH0K?=
 =?us-ascii?Q?4VxBamDb0xsFrRIATY9JVRPp2Ya0Loe9gqX7pb1uaiR5zz91HAsKN424zlXB?=
 =?us-ascii?Q?emhF6u1MYTRHP721CEX+yk8rhkahxIat0ruF9xDg9CS4OYskZ81dhZsHjZm0?=
 =?us-ascii?Q?ZHQEi3YqjBNnY4peTfI2g65h3tTUY5rA7o+GG5Md5dKwmTxiv95/A/IvbpI9?=
 =?us-ascii?Q?2QM72vFXFeTxgf9cZ7U6QtDXZi+gltH/YdNoPBR8SVul58etS7LeueZyMaf+?=
 =?us-ascii?Q?Ly9dX3I+or+CTQ/oVK3NQO5wVuv9zjO5GEO/lpKcVjmBtovw7D6VMBBoNOOY?=
 =?us-ascii?Q?v6gysFCdemxOuD9/JOjw/q4FbCWbb9ncGu0h0B+stTSp9sOToEiiZU8RY4Pq?=
 =?us-ascii?Q?UtFgOmJjwXYj1GVpI3GJyAmtFOTPkfjVL0OIQpLKAUzBfv7Vl0XYZrQ70fxi?=
 =?us-ascii?Q?0Cw/K/cugRmtZsrhEGKHTM3CA42Me+pmmXBA8L2buoTRdxwqwfstbe7Epf3h?=
 =?us-ascii?Q?wtc75ro6Ts0CacFD4GG8e4umk6eb5HNeKP8crLiugpZXSCx8Q8r5ztmEYp85?=
 =?us-ascii?Q?U3CPVogLWavIrrccQ0mSTELVrkHwTQTeSU5+awyq0I7UttqHT/2P33anqOAx?=
 =?us-ascii?Q?zQobBBXV+gIAFafT9A5HLhiFg6Rxm2CbaVHfQo2uu2diLafu3waHWmaMXw9P?=
 =?us-ascii?Q?S3TTJAGg4Qh3HRjIOO48uXaMNWms+IEz9+V24UuDW6eEUnlJA4QcMct0hAMH?=
 =?us-ascii?Q?lvEWq/fDO2ug3G8ECuDg4yxMD8YfiH97GP9/X/E2haBLYRlWFVGJ+3uB/Ai0?=
 =?us-ascii?Q?V+WvFDX+Peo8E7/0Ish+3626YQHuuFlJ9ULb5A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EMIdh8VL0e0f9LYSXZR24Vss/d2m6Vwh4abnZQ3lLk9nILygyY4Dimc9LKt3?=
 =?us-ascii?Q?n7lyJkHi2S4MXRS2QU9DgRMfhxunjRwYuCmvJPP09rNC5LLHQruhBmzwDJju?=
 =?us-ascii?Q?dA0rxhs9Otg9QBNPED6MHOxUZ3kNUsgqo14Y1hzG5V/ty3FuB14UhpGPuPEG?=
 =?us-ascii?Q?TQw9gYMPInt6PfD26RMPs4Lc7gVqAWKkGvXotiYZ+AgWs35EIJBB2Z8eQN2E?=
 =?us-ascii?Q?cjVBj1+OtIoDjNePs01MlDUVraf9y6arctH132hZ5OgT8GmgxmqPBYOV3VLI?=
 =?us-ascii?Q?VyPM+1tgdAzORldgNc3WI3xc6HvEWlkpbwKDVWxTh5pHLLmqxySW1vPiQYz2?=
 =?us-ascii?Q?ArfcqpTeexS5y+597YP8Vu9z9t2Az5J4xGS1Zqyums8Pdbb5ORm9X78tLM75?=
 =?us-ascii?Q?o0YcUQ38L3XxtkQjYTzW6MKA8i8FUjL4mdAqQBLE9gIdjB4Zb35xsccaU7PE?=
 =?us-ascii?Q?aGTkySZHH7H+WEBbPcsptvrotmQw4jeudY5ExkS32vdrRKB3Gl+AzURsxt/V?=
 =?us-ascii?Q?y5DIWEpBl6cs0NSWFNYdLiT5RVZyarMClblYx6W94eYdiobTk9O40NjuRGSH?=
 =?us-ascii?Q?8BjLtFXWSs8LI5T4OUn7+Rrca8O478kvswdis7NX2ifpfsUpCHCBwpP35+r0?=
 =?us-ascii?Q?mXLOG2QsHP+8tfS9rEyidUgRVWTPsvMeMHHkCZjADehNrTSoCjReBt2cfo5W?=
 =?us-ascii?Q?4Vts8ehozerai/W4ZSMAFu2n6tKdhbBderWygVTh0tqIgBJ4Yy84BBx2/Z+e?=
 =?us-ascii?Q?93IuRjgJq3ZMB+nWFgmCRoz26/iGyoGMDQSDCzA9x2nCjWc8S/FArQKJNBLT?=
 =?us-ascii?Q?5EwTTQGGxXj/GOspz/4e3xae/K8DFICpi17mVHqvkLWpMZ8x0aJ4uuxnwRBH?=
 =?us-ascii?Q?u1WVnGY2DYcx3h06it2TwmQ5Im2qfMHUv77vNq1YyHCUOzXQeBrkl3PX6u+Q?=
 =?us-ascii?Q?pe2vBZn9guuSYHi2IUbHmMu+MJMlI5hzI7mcplDhagNwi7yGbYB/Ng/V2/M1?=
 =?us-ascii?Q?hz4Yb0m7k3svKx5Kbk84ir1LMjX81CjDfE+vSwx1pjkabvQaysixIWTJhEoS?=
 =?us-ascii?Q?3Z99Dkpve1mYVeido13ji7B7WIUYJYxls+vU3d/cg2wr0TyU+rt57+hlwB9P?=
 =?us-ascii?Q?UYOhE0x1/+Xc9yyEqPPFQGh7YX+zeF5wqBus4XIKbzTY2Nz99k9wszzqzjjX?=
 =?us-ascii?Q?ZWrtVHex7ijJA07dn8UyVxomgKy6PPHnV9Cf7ubgjrNrMUwJh8yZIhp5rUkg?=
 =?us-ascii?Q?Ps0s6aKU+/+abEFvwTi2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a39109-beed-43c6-e04c-08dd36653c22
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 19:37:38.8046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6706

Overview
--------

This is a proof-of-concept patch series that aims to rethink the current
permission management of bpf programs.

This patch series is used to demonstrate the idea of BPF (internal)
capabilities (fine-grained permissions model) to solve the problems
caused by the coarse-grained permissions model based on program type
in the current BPF.

In this patch series, I consider what BPF kfuncs a bpf program can use,
what BPF helpers it can use, what BPF maps it can use, etc. as
permissions of the bpf program.

Note that the "capabilities" mentioned in this patch series have nothing
to do with Linux capabilities, nor with userspace.

The BPF capabilities in this patch series are capabilities that are ONLY
used internally in the bpf subsystem.

The ideas in this patch series come from previous discussions [0].

[0]: https://lore.kernel.org/bpf/AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com/T/#t

Motivation
----------

Currently, the permission management of bpf programs is a coarse-grained
model based on program types. The program type determines the
permissions of the bpf program. 

This is fine when BPF has fewer usage scenarios, but it becomes
inappropriate when BPF has more usage scenarios.

The following are the current problems:

1. Cannot change the permissions of bpf program in different contexts

Since permissions management in BPF is based on program type, once a
bpf program selects a program type, its permissions cannot be changed.

Currently sched-ext (SCX) is implemented based on the
BPF_PROG_TYPE_STRUCT_OPS program type, but SCX needs to enforce
different restrictions in different contexts. For example, some kfuncs
can only be used in the DISPATCH context, and some kfuncs can only be
used in the CPU_RELEASE context.

However, the current BPF permission management based on program type
cannot natively implement these restrictions. The current approach used
by SCX is dynamic detection, by adding masks to check at runtime if
disallowed kfuncs are being called, which results in runtime overhead.

Ideally, we could check for these incorrect uses of kfuncs via the
verifier without any runtime overhead.

2. Permission rules cannot be inherited and extended between program types

When one program type has a large number of the same base permissions as
another program type, the current permission model based on program
types cannot achieve "inheritance".

All kfuncs need to be registered to each program type separately and
populated into struct btf_id_set8 of each program type via
btf_populate_kfunc_set.

The current feature similar to "inheritance" is "alias".
BPF_PROG_TYPE_TRACING, BPF_PROG_TYPE_TRACEPOINT,
BPF_PROG_TYPE_PERF_EVENT, BPF_PROG_TYPE_LSM are actually "aliases"
of BTF_KFUNC_HOOK_TRACING.

So what should we do if there are differences in permissions between
"aliased" program types? We need to implement a filter callback function
to filter out some commonly registered kfuncs under different specific
program types.

This is obviously not an elegant solution.


The essence of all the above problems comes from the fact that the
current coarse-grained bpf permission model based on program type is
no longer appropriate and we need to rethink it.

What we need to face is:

1. ONE bpf program type can be used in MANY different contexts
(scenarios), and these contexts may have different restrictions.

2. There will be more bpf program types, and there will be a lot of
common permissions between different program types.

When faced with complex permission management, we need a fine-grained
permission management model. It is difficult for us to achieve fine-
grained permission division based on a coarse-grained permission model.

The current SCX mask and filter callback functions are band-aids for
this coarse-grained permission model.

BPF Capabilities
----------------

BPF capabilities is a capability-based permission model used internally
in the BPF subsystem. In BPF capabilities, all kfuncs will be registered
into different capabilities according to fine-grained permission
division, rather than directly registered into the program type.

BPF capabilities aims to achieve is:

1. Fine-grained permission division

All kfuncs can be divided into different sets according to their
functions and registered to different capabilities, such as
BPF_CAP_FS, BPF_CAP_LSM, BPF_CAP_SCX_DISPATCH. 

In this way, we can enable or disable some features in
different contexts.

2. Dynamically enable and disable capabilities

The bpf verifier maintains a list of capabilities that are
currently enabled for the bpf program. This list can be modified in
different contexts. 

When a bpf program accesses a feature corresponding to an enabled
capability, it will be allowed, but if it accesses a feature
corresponding to a disabled capability, it will be denied.

3. Capabilities hierarchy

Capabilities can be organized in a hierarchy. For example, we can
define TRACING_CAP_BASE, which includes all common capabilities in
tracing scenarios and can be used in BPF_PROG_TYPE_TRACING,
BPF_PROG_TYPE_TRACEPOINT, BPF_PROG_TYPE_PERF_EVENT,
and BPF_PROG_TYPE_LSM.

We do not need to list all required capabilities separately for
each program type.

4. Low-coupling capabilities system:

Different subsystems can define their own capabilities and change the
capabilities of a bpf program (enable or disable) in the verifier in
different contexts in a appropriate way.

All of this does not require modifications to the BPF core and needs
to be decoupled from the BPF core.

Proof of Concept Alert
----------------------

Note that this is a proof-of-concept in the early stages and all code
in this patch series is not well-designed.

This is a minimal proof-of-concept used only to demonstrate the idea,
and the code is full of bugs and bits and pieces here and there,
please don't mind.

Current Implementation
----------------------

The implementation in this patch series is a possible way to implement
BPF capabilities. We can discuss other better implementations of
BPF capabilities.

1. Fine-grained permission division

I added a new field "capability" in BTF_ID to record the capability of
each kfuncs. This field will be set when registering the kfuncs sets. 

All kfuncs will be put into the same struct btf_id_set8, and will no
longer be divided into different sets according to program type.

All permission managements are based on capabilities, not program types.

2. Dynamically enable and disable capabilities

I added a bitmap "bpf_capabilities" to struct bpf_verifier_env to record
the capabilities currently enabled for the bpf program.

This bitmap can be changed in different contexts. In check_kfunc_call,
the bitmap is used to determine whether the kfunc call is legal.

3. Capabilities hierarchy

I used macros to define sets of base capabilities, such as
STRUCT_OPS_BASE_CAPS.

The default enabled capabilities for each program type are defined via
array, which can contain base capabilities macros.

4. Low-coupling capabilities system:

I added the bpf_capabilities_adjust callback function to
struct bpf_verifier_ops and the context information context_info
to struct bpf_verifier_env (in the case of SCX, this context
information may be "moff").

Passing context_info to the bpf_capabilities_adjust callback function
allows the implementer to determine the current context and make changes
to the enabled capabilities list of the bpf program in the verifier.

Test Results
------------

For testing I added scx_simple_cap_test. I added
scx_bpf_dsq_move_to_local to enqueue, which is not allowed.
If we run this program, the verifier will report errors.

./build/bin/scx_simple_cap_test 
libbpf: prog 'simple_enqueue': BPF program load failed: -EACCES
libbpf: prog 'simple_enqueue': -- BEGIN PROG LOAD LOG --
...
17: (85) call scx_bpf_dsq_move_to_local#135437
The bpf program does not have the capability to call scx_bpf_dsq_move_to_local
...
libbpf: failed to load BPF skeleton 'scx_simple_cap_test': -EACCES
[SCX_BUG] scx_simple_cap_test.c:88 (Permission denied)
Failed to load skel

But if we run scx_simple, the program can run normally.

./build/bin/scx_simple
[  152.792015] sched_ext: BPF scheduler "simple" enabled
local=7 global=0
local=30 global=3
local=33 global=11

More
----

BPF capabilities is a general function that is flexible and extensible. 

In my opinion, bpf capabilities can be used not only to manage kfuncs,
but can be used to manage permissions for all features of BPF, including
BPF helpers, BPF maps, etc.

We can associate these features with a capability, so that the bpf
verifier can manage them according to different contexts.

Maybe we can also make BPF capabilities configurable through /sys/bpf
or associate some BPF capabilities with Linux capabilities, so that
system administrators can choose to only open part of BPF features
to certain users.

Related Suggestions
-------------------

In the current implementation, I need to add capability information to
each kfuncs, this is implemented by modifying the BTF_ID structure.

But I cannot modify BTF_ID directly, because BTF_ID is used for data
structures in addition to kfuncs, and data structures do not need
capability information.

My suggestion is to use BTF_ID_FLAGS for all kfuncs and only use BTF_ID
for data structures.

This way we can distinguish kfuncs from data structures.

At The End
----------

This is a proof-of-concept patch series that rethinks the current BPF
permissions management.

All ideas and implementations are not complete yet, but BPF capabilities
may be a better solution than the current program type-based
permission management.

Welcome to discuss and give feedback!

Many thanks.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>

Juntong Deng (7):
  bpf: Add capability field to BTF_ID_FLAGS
  bpf: Add enum bpf_capability
  bpf: Add capabilities version of kfuncs registration
  bpf: Make the verifier support BPF capabilities
  bpf: Add default BPF capabilities initialization for program types
  sched_ext: Make SCX use BPF capabilities
  sched_ext: Add proof-of-concept test case

 include/linux/bpf.h                       |   2 +
 include/linux/bpf_verifier.h              |   6 +
 include/linux/btf.h                       |   8 +-
 include/linux/btf_ids.h                   |   6 +-
 include/uapi/linux/bpf.h                  |  15 ++
 kernel/bpf/btf.c                          | 165 +++++++++++++++++++++-
 kernel/bpf/verifier.c                     |  66 ++++++++-
 kernel/sched/ext.c                        |  74 ++++++++--
 tools/bpf/resolve_btfids/main.c           |   2 +-
 tools/include/linux/btf_ids.h             |   1 +
 tools/sched_ext/Makefile                  |   2 +-
 tools/sched_ext/scx_simple_cap_test.bpf.c | 159 +++++++++++++++++++++
 tools/sched_ext/scx_simple_cap_test.c     | 107 ++++++++++++++
 13 files changed, 590 insertions(+), 23 deletions(-)
 create mode 100644 tools/sched_ext/scx_simple_cap_test.bpf.c
 create mode 100644 tools/sched_ext/scx_simple_cap_test.c

-- 
2.39.5


