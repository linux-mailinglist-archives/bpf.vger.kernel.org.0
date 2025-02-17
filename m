Return-Path: <bpf+bounces-51756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA1EA38A7F
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 18:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240AB3A2C16
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3363229B05;
	Mon, 17 Feb 2025 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="o93C38iJ"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2040.outbound.protection.outlook.com [40.92.90.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD4E22576E;
	Mon, 17 Feb 2025 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739812928; cv=fail; b=unvO41kzPansXtIGSlPCKeZCrVCjZNRD6HhFLHYNbI4JIh7v4dVyU5W+gGDbcnskxv/lQrrq7W5o9m7kPde1xj6zxHAXeQgboCE0x589i7tRUnbMJG1/UxcP6D6rXYOIaxC05NH/r3vR0gpitncu1cLMwXVJdot9UsyQXxM957I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739812928; c=relaxed/simple;
	bh=9fwcOvH45Esyd43CM7eBR5fVqiOThn+dFDH0Gmdqzik=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=j3lBFOBcbpLhB6ye+lQD/K12Uf60T3/2lZjFvBsTZzZsgrNNMqht9zrix/zuX0hhqpR2tMHgxcdRoQuHh9Ty4uWjsVTSbehs1hRqPB0VDYF7yQbFsJz05WATQJpNwVgc9WBACslMPc5r39Ccb81BycAKr18qqMg0L6o/RQt0A5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=o93C38iJ; arc=fail smtp.client-ip=40.92.90.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGHcirgiy7Qlk2Xa+OLD+uLeezSiH237SV3Edz/36easusvsmBvQiYifNKmi2QrxJ6eVVWjvdRATmRRV+Lda1eCi81/9i0QnZLGA30FUO2Uv5HuuD1a0K5PjQbZGvgzMFosLRfDnsg2OSyoHemchUZFp0lpqGxsRteVXuZm1WuTnIiQAWNgANI0ZGJPaahyPkBI1vncw698zUnInuCdrkdkkCZgw0YHKCb6lw9jQbBxL80wwrlapvjZXMak0uVRdW6tpBuAdXZyAyibOXTf3b5B9U8Avo3HyxhLFq1hxGVq3IQoNi0SuKL4VyNL7VTrixMAWC/XXr79adEZEmBbEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F4XCVh7W8fsy7evhvpwxfWRjH1NsFAVbBP//Ww+PEA=;
 b=rOUUWIS1qFCqIlALvYKCVGDI8yjnuYH+0p23FY/zb+w9tEd5RwJClcLIeu4yOD/0ZP0VDU4OvdRgoxRpFXEXotVS1U0NF6rk5+CaGxyy4lV2Y8qFlAJS4hlkWxKQ1jSyAZ0kmcbDN7QrNyLGgM9q2RfuhcGEu8w0Tr5jkSJymuZjrLj3fzHF/R+Gij+zVTUTGCyK16CNiJKku1plxRhGmNUqZtHA5LZOsu6eUEuXDxgcBDFf9zKnBGSu/XyR6UsmcTB9w7ue2m+9wiD8ATZiDg12cgGQs6AgSSxsuKY+XuKMewhJL3b9DIsABa+mIlt1qHWAOEIorXsQFRp8RtTgWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F4XCVh7W8fsy7evhvpwxfWRjH1NsFAVbBP//Ww+PEA=;
 b=o93C38iJu7Jfm3kfKVJ+/Hj71bFzHma0rB1NV24MCuMAVJ3vgZgrQrfW4NLReg+qiTfWMWT0Z+doFIBToRFU88rto6puU1V7J5UYf5QTMKstb52qylvBdgQElHDAchGxqH/SuCC85b2VJQrjZcFnVolfRQHeZLE/YWECAU+tvelLlTOAh955hm4bRIVB/tggeyoOw+NAGORa8IAwXBpvnaNyzZ1gqGOKCz7/26QqvERTtJgyNywWAHVdjzziYoRwn8VfmQ1ItpNR/IKOAUvt/mzAb+cI61Gx7kMMGWSzd5Y9EA7TwkR6Xq3VNc6qY12o2zaeYWFuEwzbJnDMUUtSCw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DBAPR03MB6613.eurprd03.prod.outlook.com (2603:10a6:10:19b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 17:22:03 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8445.016; Mon, 17 Feb 2025
 17:22:03 +0000
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
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 0/3] bpf: BPF runtime hooks: BPF debug mode (tracing all kfuncs and helpers calls)
Date: Mon, 17 Feb 2025 17:17:49 +0000
Message-ID:
 <AM6PR03MB50804A5BF211E94A5DF8F66699FB2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0209.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::16) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250217171749.55733-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DBAPR03MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 730d93e0-13ce-4ffc-eafe-08dd4f7797f4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|5072599009|19110799003|15080799006|8060799006|461199028|440099028|4302099013|3412199025|10035399004|56899033|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vTnO4QzQk9+nFPezo8jZJjPnIBGXu2+g91jnLvW4TV6bZE0Nggli/3CfRAJu?=
 =?us-ascii?Q?yFbjlOD8wgO++ycndOTua4O2zuFjsyStCcCMhJBzrAJRnE+A+lIrPTiAZXEW?=
 =?us-ascii?Q?bmrXaRmseEO0R9mO2LwwyCJ98BuzoenpPMZs+SERBwirpW/BHUpj7LBq1Lth?=
 =?us-ascii?Q?dgtXgp414fOIgjBBz60+6Ecrb8mXwow4lT6JgPxPHP7fqEia4QnJ80eaWBlD?=
 =?us-ascii?Q?NC4b9cD/jr30rWEBjKurF2ezQbAt6nNOkprlMZ6am7wI6cP1j+90buM3BrhJ?=
 =?us-ascii?Q?B0RIs9zrDvMdyB5lyFR8Y0nBCobNonoJBWoKEKfG+Y7Wk8FdRRHoBHKElLvH?=
 =?us-ascii?Q?TL/8XjHL070TjkGuwpVZTfy037bQsh0HoPOXObL2H4FLXJGJMPQk/3kLbqoR?=
 =?us-ascii?Q?nUX+tVSqD+k2rd1MHac/8f3rgc0tmY2EpJUFgWy7WmqZinccDWFQN40ms/Ua?=
 =?us-ascii?Q?jlEQ4ggD8/SZ/1bQG9zSUCGkF1tlPTK2X0QXYqLu4xHXKWYEtTBirPqUi6A2?=
 =?us-ascii?Q?tqa3PpvaO1+0CQAcDQdqWaCX8/h7W3K/hV76VIyFEGv7aqKsydto/0yCAVsF?=
 =?us-ascii?Q?MKGTwpC9GG1zK9Lo1ng8K2SF2ybygHlTdugW3/EB/yzR1RVEUx/KtdPBQItF?=
 =?us-ascii?Q?/NOTMlTiPyv/Qp7LzSkxOyrbvLLCz1dT53PVdFB/eHGBl1Qe6zGQS0tdOWuI?=
 =?us-ascii?Q?X/2oI4du/LL6xthpHLzw30eezDbC4qK1FS0SnqD2gybJua/hp2ENbE1F0ZF7?=
 =?us-ascii?Q?gX2mSu/hSF++Rkj+z+U9Bf1RaZR4JNBoy9I7NH9EJjlQ7nN/3G6xU2MMvKOf?=
 =?us-ascii?Q?QLWi8xFeCVk4lWqeerpPkEgW8WrtRcdKgt/EfDmvkAy+xyDMiKiUenhDCvxG?=
 =?us-ascii?Q?RYJa8n3SAEeKG3VvUKBk14iLc+pY6ORezFhPrwLlKrqjOA1FbmXq9NIi0AZZ?=
 =?us-ascii?Q?qsXAefc9K/bj2w82my/9byfK4akj+uAYpEmx7zMrVcqigIoUEVdAlAAl1C8b?=
 =?us-ascii?Q?yo8TfH+ltjRrFwY230VC/dthRfLmxSnjTddjk6K9UTKYID96F8LoxZztMeP+?=
 =?us-ascii?Q?GZHgyYVnGnHU3vUwYymGhzkXYt1qMnpE4djzX1oS0pX7Q0tS2/8GBPYRRtRW?=
 =?us-ascii?Q?srkv9Hi3fwbjpPPkTNWRaxF4Ty5Xw6UZQ5+uN/SQibrmKVfiZubH0Ks7FThp?=
 =?us-ascii?Q?a4u9kbkDMDa4Zljv?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z5d/Sjn9tiTSEAI30O1GPWx5wkxMrElT+tWq2SrjjrGKMrji7nfTKi8WTVmV?=
 =?us-ascii?Q?6OiYEqQvRAkQ4bkaKxcWa26HVURk+yf4J699gq2Oo57YBFuH8X/EQjgnEoyX?=
 =?us-ascii?Q?gM7e3wAr/NkEjmtJDCe2CjR5qbJ/oxxoogNHx0lWG+3rTETD8IT1e/ra1A7i?=
 =?us-ascii?Q?DjAhkpDUe9CfbwA+L4hERBkQdxIDyo8XfWXHTJSsJrZlksEQpd1Z8bsqd7Mo?=
 =?us-ascii?Q?Wh77pMZQg0OuQAJQVpCYtfFgtUtimC5DKaauVxFJcrg8aZ+P4KF5d78wJl40?=
 =?us-ascii?Q?eOyzzaXqoB58rrzrI3G4oEO5D4YmdDcI4+ZfgzSG9wZgdbP1bB7wu2jIPoZZ?=
 =?us-ascii?Q?n+rVYg2d5l58zhe847d5yXNcgtxScIXk/Ysm8TmJac1ySUe+6OZtdN7ANjvX?=
 =?us-ascii?Q?f0i/VFF+RCb4hc+twNIUJ2b5ddJ6+sbDX6DdYH/yky0VFmZtzeMKnzoXKr11?=
 =?us-ascii?Q?R/tYYe0EgkbVNlW/QQ5tQSri44OlucS2aWU8FQQ2ZG08EB6MB3zK82WARiZx?=
 =?us-ascii?Q?MfN1aNY4WhX09/t0kBGnr654/CHDgj1syifCY6v6IJeEhjkM8rouUoZFJNXM?=
 =?us-ascii?Q?8Dg1NnoydeYo0JyFKlQEDrEixeXM9k/nA4LAoHN+tA5upb9/xvFW+u8gVeHl?=
 =?us-ascii?Q?boRQf4qzP8O3dH/ctX+Gk+OA6ITDXzrzqprbZowy9BQ3GLw2GSnM7OqHQxjm?=
 =?us-ascii?Q?vPZ2kXf6gdythDASAFkwhDy7qtBsMuRsylPEaKRMhKPPU38O4QwSwiFPIWvW?=
 =?us-ascii?Q?v2Kb8PH00yMK0HBXIGYnRw8vJO9mzpB0gdlJmu6KegUPjvZ535wj7HlOI91Q?=
 =?us-ascii?Q?3h9kwBO+nU17ugnR+0mPhMLS9I3RY5Xr9rdB0AIAmUqFeUVY1hP5cIZ0NVZ8?=
 =?us-ascii?Q?EoJAl+TH8iOmzvwe6DgV5O0s97AJkT3oExRXF5uZEu5fiIxCryvSc2vqVXP9?=
 =?us-ascii?Q?TaExBGgYmmHa5/Yb8OsOSgKPPJhY9urTINHfoaKCiNFavGsaS8dxwDaNzBlU?=
 =?us-ascii?Q?yAKXO+lFpAcqBw3f8iSIUlmetYSkLu6JN5TA87yq8lWIqG5Rng++bQUnlnFF?=
 =?us-ascii?Q?0dfUr4+9JE+pD26V/Z2aOxyUeBTxp3l9cLSbdyFhW0+S2i2H1B5Vb1bVt7Jc?=
 =?us-ascii?Q?cVxWs1G3TZagPx4DaMcdxGscxHalmpPGJBEL8p7llfdM2Du4TcRNdbz+KryX?=
 =?us-ascii?Q?WgZeeKzxMjK4y0020tsKVh9LJVmfw44iGGMErkKyNs0/v2cmdPaWczMH0Rkx?=
 =?us-ascii?Q?HK4FogErFGNthv6sy+K/?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730d93e0-13ce-4ffc-eafe-08dd4f7797f4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 17:22:02.9621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6613

Last week, I proposed non-intrusive BPF runtime hooks for implementing
automatic resource release in watchdog [0].

I realized this weekend that the idea of non-intrusive BPF runtime 
hooks can have more application scenarios, and that it is a
general infrastructure.

For example, we can implement BPF version of strace based on BPF runtime
hooks to help us diagnose and debug bpf programs.

We can add BPF debug mode. When a bpf program is in debug mode, all
calls to kfuncs and helpers will be traced and output to the trace
ring buffer.

We can also record timestamps for each call to analyze the performance
of a bpf program, making it easier for us to optimize the performance
of a bpf program.

This patch series is a proof-of-concept implementation of BPF version of
strace based on BPF runtime hooks.

Note that this patch series is developed based on BPF runtime hooks and
therefore cannot be applied separately.

In this patch series I used trace_printk directly in the BPF debug mode
hook for proof-of-concept purposes.

In actual implementation, the BPF debug mode hook should only be
responsible for recording information, and parsing and outputting
information should be done in another thread to avoid affecting
the performance of the bpf program.

We may also need to add a new FTRACE_ENTRY to customize the format of
the event output.

We always use bpf program to trace/analyze/diagnose kernel/applications,
and now we can also trace/analyze/diagnose bpf programs via
BPF debug mode.

This will be helpful for us to debug/optimize complex bpf programs.

(An interesting idea is that maybe one day we will also be able to
attach bpf programs to the BPF debug mode hook. We use a bpf program
to trace other bpf programs in the kernel to help us improve the
performance of other bpf programs. Of course, the bpf program attached
to the debug mode hook cannot enter debug mode.)

[0]: https://lore.kernel.org/bpf/AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com/T/#u

The following is a simple test result (removed trace_printk prefix):

[456.900891] bpf_iter_num_new(ffffa91a02103c78,1,3) = 0
[456.903768] bpf_iter_num_next(ffffa91a02103c78) = ffffa91a02103c78
[456.904849] bpf_task_from_pid(1) = ffff8bf4c1320000
[456.905904] bpf_probe_read_kernel(ffffa91a02103c74,4,ffff8bf4c1320690) = 0
[456.905971] bpf_task_release(ffff8bf4c1320000)
[456.906893] bpf_iter_num_next(ffffa91a02103c78) = ffffa91a02103c78
[456.907751] bpf_task_from_pid(2) = ffff8bf4c1320fc0
[456.908635] bpf_probe_read_kernel(ffffa91a02103c74,4,ffff8bf4c1321650) = 0
[456.908656] bpf_task_release(ffff8bf4c1320fc0)
[456.909570] bpf_iter_num_next(ffffa91a02103c78) = 0
[456.910425] bpf_iter_num_destroy(ffffa91a02103c78)
[456.911604] bpf_cpumask_create() = ffff8bf4c4042a88
[456.912600] bpf_cpumask_release(ffff8bf4c4042a88)

Any feedback is welcome.

Many thanks.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>

Juntong Deng (3):
  bpf: Add BPF debug mode
  bpf: Add bpf_runtime_kfunc_tracing_hook
  selftests/bpf: Add test case for demonstrating BPF debug mode.

 arch/x86/net/bpf_jit_comp.c                   |   2 +-
 include/linux/bpf.h                           |   3 +-
 include/linux/btf.h                           |   4 +-
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              |  72 +++++++++-
 kernel/bpf/syscall.c                          |   4 +-
 tools/include/uapi/linux/bpf.h                |   2 +
 tools/lib/bpf/libbpf.c                        |   6 +
 tools/lib/bpf/libbpf.h                        |   2 +
 tools/testing/selftests/bpf_debug/Makefile    | 136 ++++++++++++++++++
 tools/testing/selftests/bpf_debug/debug.bpf.c |  39 +++++
 tools/testing/selftests/bpf_debug/debug.c     |  24 ++++
 12 files changed, 290 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf_debug/Makefile
 create mode 100644 tools/testing/selftests/bpf_debug/debug.bpf.c
 create mode 100644 tools/testing/selftests/bpf_debug/debug.c

-- 
2.39.5


