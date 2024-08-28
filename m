Return-Path: <bpf+bounces-38314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3171996316A
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 22:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2EAD285078
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 20:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3893E1ABED0;
	Wed, 28 Aug 2024 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Dev8n9ev"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19012035.outbound.protection.outlook.com [52.103.32.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB20139578;
	Wed, 28 Aug 2024 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724875541; cv=fail; b=OuJfaZI+wA97EuaNnBSRjeqeL578pr51nwclv3p+PdyBE0IdB8EY9oF9Juw6aNrFw7uyPBMZ29F93Eo0XVJGdvOTanp/B/SqEvznI4Q2iZ5jDKYeFXOYePHkVl0IqUJJzvhg+7sNem7h8UQCzPMPb0BIk/Tth4B9vSeQhc8OiwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724875541; c=relaxed/simple;
	bh=cl8h2qFeEsahKI5RbUycxw6lHcALP1yEK3qtRs8dK1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UUP6rrWjhOgcNvyN2bHI2T2uogq0f7/4MD8GeiVlwrYtZD/yuLS9tubJRwA4sutkQyX87zlUwTHBr+EFjurNQ4zJyr2wi20nmw7EHw0k0KLDILi+rEfYoS+tiaYw3pQ2eneobeZhlaoTi/QusaLWyc6nAo883Nz5yTlcP4CqtLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Dev8n9ev; arc=fail smtp.client-ip=52.103.32.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXCKVbdkVz7xu20ZNenlafADOSny1d/CSy6JoEihYhyZpfyXi1mrf/rIQ6H8Ix8ejGlSrdrspAWky0Ga+toFbuDadkV85m3jRQf8EOPHIqabSjKYprXfv133FeMLyhEHG7sV2lfqSaffoedYm0LibfnXcG279CiANWFZSaX9nQwhoQ7LEgbGUggvVOFqzuEutVLdKUkoTQDeS9Cq3ntvpaoMGrSHbVf7vMOR0k7dP/DUjFNB5KkP9uU7/ZcqklFSKnWUhQu950KfbSjGSb6nnnhpZ66Syydf9zd488gA38BeiG3p6D/V6l4adCiEyIff5WWS/tueWgvZ4GXKfmnjJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNv18U8sXFxXQncNIU+D7wD9HSF4hdVq8zTLwb0pBsM=;
 b=iOwD0u9OhcPnH353eUa2bgpqTx98LVcbCB8SifOzBpDHI4A8J2K/o+X9/CWJ5zOaTeRu/F2mlv/lqiY4mpyd9iVDF8TH7GPBT0R/p2OzjT96mMO0idAxbIY44bD2bR+iCSzOS2XeixuHceKneUgNJSynQ1Ch0cKrtSpgpflgD2s3K2e66QiLmZ0O8nBiTVVQVKspi80bW4lD+Cxo1PbWYk+fxlovnUIZIMHE/niIjnAK9XaLNlbIseBczAepxDhzL7c0OK/IQY/IHayZl2v31zl1M89YZCIjqjS53fpOoblOPJ7fCpdCx9aonv/DPZFfy15qi7QCMoq6O82IdfwsnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNv18U8sXFxXQncNIU+D7wD9HSF4hdVq8zTLwb0pBsM=;
 b=Dev8n9evagNNeA3KdWzUL64ipgbPRnO2Ob0yv0whxX9rgW+I6Qsb3EMYUxPmSvuNEsUl7Zl0fUSRZe9TDP8oc+Po21K0NghCOUghkwJeSFK71MlPY5hkrTH6NPHIMg1FBzA0SSODNz/X73GZ8xSqOLJOvq/He+yIpFugymL3PCik2LE9SyUxo5H6ufCNbaF+Z7DnzyfEJiWHMV+5XKxq3GriE5y0VuFdxjko+GQvQA0jFRJkeS7BzxoFfwtYOQsl0qQ8GVFtAXFK/3NVP2cT+pMw+epuLfQwldY8phuI8f/r1D95X4TJhAajQw7B17JFoRFWtFpgPZGb4mfdSQkv8A==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by VI0PR03MB10807.eurprd03.prod.outlook.com (2603:10a6:800:26a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 20:05:36 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 20:05:36 +0000
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
Subject: [PATCH bpf-next v2 1/2] bpf: Add KF_OBTAIN for obtaining objects without reference count
Date: Wed, 28 Aug 2024 21:04:33 +0100
Message-ID:
 <AM6PR03MB5848874457E6E3E21635B18999952@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [DInjrd2oaxsFe/DxbwlCnYwWOJ3Pm4Ny]
X-ClientProxiedBy: LO2P265CA0069.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::33) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240828200433.52591-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|VI0PR03MB10807:EE_
X-MS-Office365-Filtering-Correlation-Id: 09fd2fa4-fe99-4f3c-52ff-08dcc79cc801
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|8060799006|461199028|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	BbOQnZawp2DaZlPuHHaiMdOLNc2rUzlkIC0R0LTtq2kV4zP7DtBibotmpAwQgKBd2wTd5crFv4i7o38P0dhaINE+ULhHkIGxU9G44/rbwxLiovTuVABHlRFunLzWiRB8fnG5srtHr2tCJq/jpboPiBF2oyB5jHlCRvmK2cbNzd71wpC7mRLHq5MG6TlYYewEof9GGoGT2V/jcIEFOdSO9pJ4WzfvA49Bz/aI7NjzmmSDbflxVqNjGZ7rVq4PXWtPBwchhrX1fsriG/D5qCERyKZ9aziz/rVf/CE0uVJY/Q2j75s+vfljeSsGpcX96LnIPtaTrWH97JIcYLBprrguRWhd9Z8jr1veVhPxHqZ+CsqjDesI0ykTpiXniJrutgfFCATxFRX1Toi6WukROPtbZDXBjNzb833BUASbr89V9NCNbiMFUFS9i3mOKSWZSLqBKHz+JLJTK/1yzf0+mBaB+4gxlWMOJhmrmwmbUVV2kVd38Ii3ElqV70DVlS+UE/MTjU3/L4+tXd0tETwS3RERNK282PhYSE883hOYaV0Y8yYULVoV2l7pqDldoQDYTaeyW8OiWQ7EERxxfTO2FYJCGLCMi3u5ysPmbHYzIK8XOWmbS9NUDdFDdHHgZ97pLD1Zi77jKoAhwkAyG2w/yO8TWJkvYujG5rh5gk8AbJIEC9Gn7a0iRNA81T3f22pwrlAaath3J0/t6tc4TggFaRj0Eg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hab/v7gVnSbjuv1voGiNHNgEX4hLaC62Eextxf9B4zSwcTs/YSM+08YyRFke?=
 =?us-ascii?Q?a2Mmm8xKjgllpS/ruNM1tdbAX6iQe0YyMBl8W9fv8C79o5M3yANu4s9v6l6y?=
 =?us-ascii?Q?X2srIUqML4aGPYlt+b6g6879BGwPna8wouR8nZRxHx2wtN05s2gCYLmygijM?=
 =?us-ascii?Q?EzmxSt9/pXA4QDbZQQ1uZHmM1cfLftgWH75OcN3c9NvIvbnNwH6215xWH2wv?=
 =?us-ascii?Q?vPLnSaiHMwPwaO3HCUFuxE9neE+YjxU9JQMWtWC7aq3CF5l+JxmdkhhlQbZm?=
 =?us-ascii?Q?y0FyymyVy4Lc4Ei3vOu2wBaPrc5Cn07kUfl472TEesnR9rstlqAcvqLMpgAq?=
 =?us-ascii?Q?Fmi7EdZp35pwQxT+f9HTNsKW1RGPsR+JtArB2J05PucQ0Evi0i/V17V6rUPv?=
 =?us-ascii?Q?9z0o67s4WxmPoVHaWaf6GZVipUlofiZAwCq6i1Dj29X2s236a/6/Gopk+iFw?=
 =?us-ascii?Q?kP6Cs2Af/ohWwxIDiLcywmqp+mTgafpNAPpDymRhKx8pMr3jYosld/Am7mni?=
 =?us-ascii?Q?UuwAvT/ovXKObhE4js6XISJ1gcwIk222MwFmemgvWe3ETb8MbJpnuq+zMCzf?=
 =?us-ascii?Q?jl1ryAjrEvcFGfZqmnU3o7IdJDdp/IM/Y4Tc2EjGhewHCdZZD0VbzApwzZmx?=
 =?us-ascii?Q?e8UIGN7nhjTsX6z/V3U2M2WYfbMQ18LGKKudmlg+gYTKcIJFbyZ/AwKIZ1ch?=
 =?us-ascii?Q?0tuTCKRv4gnE8lHN5wqyXfIPXybvPeJAQ4wEwBiuSAphCajyhd4+X/5F5dKg?=
 =?us-ascii?Q?P7ienkxkj48ku7L8HE20fmYt+nhlyxAvwvz7xAEE4xXc1/wHbcGiWiXG+JCv?=
 =?us-ascii?Q?2gOAGVQLzUandwBbpNepW/wbNp/u10fakNxdqdgm2C0RywDHB+X93TNfJMZB?=
 =?us-ascii?Q?zYpqF0DbxGNYmp3EqsEtT2JTZozjAc36kssjhje2yjpdQWyNH4w2HAJ0jOfP?=
 =?us-ascii?Q?Dc5lDwSNpGAhqTCQUA0X6hYdcuwyeaLLlkKOtPSLuajU0ex9iBIy5pi7UGFl?=
 =?us-ascii?Q?GJc/iLrL/x3i8ITfPF6h7MQNGW/NsRhwHng2u2MOsEDnhi3NnSpSWkVCHOz7?=
 =?us-ascii?Q?WSIG+Z+ASQbqV3YYpB6+eKOE9r3s/Q82KbugLaQkaUJf52hFdouMzZ2NIWZ3?=
 =?us-ascii?Q?9wHm8Z/mzG39+rhhRvSqiZs/bRClPM6FHObHhOj5/+s+30w4whpUjanffbWl?=
 =?us-ascii?Q?zMgXi9OGQTUcev9rLUnSHKzcYoLOaBQCklxmxZpI7FM+Kez81AiH+rrCK+ig?=
 =?us-ascii?Q?ns5rr53UsUvpBZt3yamL?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fd2fa4-fe99-4f3c-52ff-08dcc79cc801
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 20:05:36.6126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10807

Not all structures in the kernel contain reference count, such as
struct socket (its reference count is actually in struct file),
so it makes no sense to use a combination of KF_ACQUIRE and KF_RELEASE
to trick the verifier to make the pointer to struct socket valid.

In this example, we cannot just use BTF_TYPE_SAFE_TRUSTED method,
because not all files are sockets. It is not enough to make private_data
in struct file to be trusted. We need a kfunc like bpf_socket_from_file.

This patch adds KF_OBTAIN flag for the cases where a valid pointer can
be obtained but there is no need to manipulate the reference count
(e.g. the structure itself has no reference count, the actual reference
count is in another structure).

For KF_OBTAIN kfuncs, the passed argument must be valid pointers.
KF_OBTAIN kfuncs guarantees that if the pointer passed in is valid,
then the pointer returned by KF_OBTAIN kfuncs is also valid.

For example, bpf_socket_from_file is a KF_OBTAIN kfunc, and if the
struct file pointer passed in is valid, then the struct socket pointer
returned is also valid.

KF_OBTAIN kfuncs use ref_obj_id to ensure that the returned pointer has
the correct ownership and lifetime. For example, if we pass pointer A to
KF_OBTAIN kfunc and get returned pointer B, then once pointer A is
released, pointer B will become invalid.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
v1 -> v2: Add more example information to commit message, no code changed.

 include/linux/btf.h   |  1 +
 kernel/bpf/verifier.c | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index b8a583194c4a..d3f695123af9 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -75,6 +75,7 @@
 #define KF_ITER_NEXT    (1 << 9) /* kfunc implements BPF iter next method */
 #define KF_ITER_DESTROY (1 << 10) /* kfunc implements BPF iter destructor */
 #define KF_RCU_PROTECTED (1 << 11) /* kfunc should be protected by rcu cs when they are invoked */
+#define KF_OBTAIN        (1 << 12) /* kfunc is an obtain function */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5437dca56159..67a67c2b4a55 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10985,9 +10985,15 @@ static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_RELEASE;
 }
 
+static bool is_kfunc_obtain(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_OBTAIN;
+}
+
 static bool is_kfunc_trusted_args(struct bpf_kfunc_call_arg_meta *meta)
 {
-	return (meta->kfunc_flags & KF_TRUSTED_ARGS) || is_kfunc_release(meta);
+	return (meta->kfunc_flags & KF_TRUSTED_ARGS) || is_kfunc_release(meta) ||
+		is_kfunc_obtain(meta);
 }
 
 static bool is_kfunc_sleepable(struct bpf_kfunc_call_arg_meta *meta)
@@ -12845,6 +12851,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			/* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
 			regs[BPF_REG_0].id = ++env->id_gen;
 		}
+
+		if (is_kfunc_obtain(&meta)) {
+			regs[BPF_REG_0].type |= PTR_TRUSTED;
+			regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
+		}
+
 		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
 		if (is_kfunc_acquire(&meta)) {
 			int id = acquire_reference_state(env, insn_idx);
-- 
2.39.2


