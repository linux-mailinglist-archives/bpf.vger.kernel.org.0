Return-Path: <bpf+bounces-51600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C78A366C1
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 21:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A719172645
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560981C862E;
	Fri, 14 Feb 2025 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HkVzmvPj"
X-Original-To: bpf@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013081.outbound.protection.outlook.com [52.103.51.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A43196C7C;
	Fri, 14 Feb 2025 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739564038; cv=fail; b=HvGfVHwZpUCFaGAdxn4dBdbbJO2rj5AmenLH8Owa8TAdxF7E0bGYhbRG5GOtuvkH6lhMWiSYWnko6ZqWwX9SUwuSMvLTE1AYiv4dLxFe5GAP4HkVPeWojlgyoV+TNlx8uw91FJjrM8zDYwTg3f5TeMk0qIW1D+KMeFqV+tX8E30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739564038; c=relaxed/simple;
	bh=PJqZj3uJ8McepCsp6BGUALsz9eI0Y4X1wZ7IUOxXfyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BsM4ztWGOCF3RZcmGbuniWkndb1ULbCsRM4id4F4HczTjZ8PBKQeXFtMQcP5Q74n7fidTjxx4usQP3Ql1RFyzdw8lSyjm9lYbX1DfGiwTJERf28VwggPBvq93F4un+5vxP//FHjY/UfEaKTMxBMvVTHOViUlK2LivweD6EWXMTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HkVzmvPj; arc=fail smtp.client-ip=52.103.51.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fa+g6qOh/AuPFiN9lV10/sLlnESWw1oWT7/k+zpUdGzQJf0Lw/NJ1dhn452rINq0CxExF6Qg6Kz8KHIfrM2SnNslHeDEyCw3VTqsxvuw3dv4Cp8ddWwuOBt9uuvpzwrAW6gOfqeX0YzrHr9OgXtoiAkVx5r+QVCAxRM8z4+vLOP5WwxbdeOyE48HQX3q23LhikHu4wOdZqXHHDaUfMtdHBrctg/jj58VcxUtF96Cq/sym9Tk96M5jU6aqYMP6C0oE69Pe8w0hrNyWrU+KENIrEXvUayFn1S5sHFUPFpBOChUAOP2Q0FYtoRFdLdr9NA/6wJsRpjQICFzeYrmflMfVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqbAAz2+FaeT49O0hChGkh4KBdPwAIoEBdYkjWe689E=;
 b=xSs/yAX7MtWveSfAVSYdH31RCG05HHL3nOAohLwPVRb9zzoCiPOpb81Z3kICakCslN7fieiEbtkmgITNZrNMZ+1ay+hfeyuC7pBJb+lQ8SbhiSl5p3Rxqb4KLWNOFdPF0Zz6681Qb3yvFEo9OGzeol7Y2dJh8cmROdNGYS4AffwvuJDGavU4umaD84thQfOnrzGFwQOg/Vcm+XmUbaphB8WcJIuI+M/jUb7S5w888waqO0CzuLRvq5d46eAh05eLZiXNvzCScUL2PAV2aZkCyJUG9ljGenFsU9qfB780GB3dSaKuYhjouRgveEe6sX0x7hEcgn+jxAX9S7/N7co4cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqbAAz2+FaeT49O0hChGkh4KBdPwAIoEBdYkjWe689E=;
 b=HkVzmvPjcEg/b5ftUf5MUhQ2k+9vOR1+vCfbOSf+hHlSRLBrIflO0tGWCbf1U9nymDfaVKrRsBDc5vKJf4Q0CfLMyCjclx4AG1KXZFLFj52gHFAoyNGb4mayYdjafxKKN5PUwqrLcVDsWT4Z0biCRiiA6VwBzYulbBgKQIbfFcK+5K2jTSGVde9lSjAzy3Vi3tK4Ey3Ywjp3vBUyBuUHORPj98eQPxiWz7F/WynUaSV3ubaAi8GMEEFVRPcXCF8UvRE2hP+3srViE7B8lI5bBNTxk7+VxEwtc5Uq8uq0nzwsW6B5gE/l/EBiMp8h2ndhUEHq4kPklEpY+3fw3bIrSw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS2PR03MB9931.eurprd03.prod.outlook.com (2603:10a6:20b:643::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 20:13:51 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 20:13:51 +0000
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
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next v2 4/5] sched_ext: Removed mask-based runtime restrictions on calling kfuncs in different contexts
Date: Fri, 14 Feb 2025 20:09:28 +0000
Message-ID:
 <AM6PR03MB50800E12061E436DDDB3B20699FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080855B90C3FE9B6C4243B099FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080855B90C3FE9B6C4243B099FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0277.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::12) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250214200929.190827-4-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS2PR03MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: 0749b2ec-18de-44fe-ddb9-08dd4d3418e2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|461199028|15080799006|12121999004|8060799006|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/xtmAr9cSKb5+yIZOmg19xW1eKYj60hJnLiog2K1h1D/DPwa3exFZDGy7RFm?=
 =?us-ascii?Q?Kjr8T3mXTy8Ch0pY1f1km85dGJ78mgwDeoTgPziSDPld37+1lzBwjgjjsdgq?=
 =?us-ascii?Q?YjXugsqOLsnB96SfJvybmBgzZMXdwqhsHoa3MSinMuqdE06O1/+4E7kBZAMm?=
 =?us-ascii?Q?9xwuDT0r+wpsBx6u5A7OTuud0HGjn/isDeUZiwGyiu+8vRhvcb18cE7oOTOk?=
 =?us-ascii?Q?I7KVLolFegzqkiNyHGXo8rZ7kGeMNMTsIBtN4tXipIjWhckV77UDgh2Z7usM?=
 =?us-ascii?Q?94IQmR6tsCopd6kBepSyN7vvZeUWiBhuy/Bx8fJRU1/PsbtNse2U6jvgQrqq?=
 =?us-ascii?Q?RRaUcphWd8f24EhC/8jfD9be8DRuMmBS3ix/iPCU2ZRksoU7WMZKhyEXGVYp?=
 =?us-ascii?Q?K+aOB/fJAzIGL87ReAEPm1EcWkk2A3ElnFAjR6v5Q9ZroXsCji8xgISSL6Ty?=
 =?us-ascii?Q?mrA/E3FWgoE665TrlS4vB8QKKXlRnnZ9D57q7i4h8DcVhVqMSkoaX/Ux5LU3?=
 =?us-ascii?Q?KPhZ0RGsDyiWzfWPxsMCyjYFcRIfyJNsbFCwK7g/Fj3B096GGI2B81UTVfnM?=
 =?us-ascii?Q?KfhMphBc3FvjirPmMptAfeCKZ8geBS/ducymdMKGyji1kLurLJEXP7EG689X?=
 =?us-ascii?Q?k9+bZrIMRH3zTo0JN+00HbJgpMGKV/hFEW5HBorHD3NSHx/QOeOdqjR7Vq9p?=
 =?us-ascii?Q?EA9hOjW9/a5HQdJL13ma/LaXbtIax7HSebXcuVnLgFBQU7cHi9yE+a2k9oLf?=
 =?us-ascii?Q?cK5WNk65B/bxhj4f40QW5xfjpJyHxAXjTGPBpq/JC3xlDw51881z7VBiXVQM?=
 =?us-ascii?Q?2vcHkCpIQBLgcg1+jfR7CeaPEyKtnDs06Dxy9ribj7N/NCL4LqRLQZR3ctb5?=
 =?us-ascii?Q?xoGo71X3GhNIhOY/ddAtXyAlhSl+bwIygeF5hFD1mLitxbi/KmdkPMiua0YB?=
 =?us-ascii?Q?m0zs4/aTaLH3TT7/bmZejX15J31tEBkdn3jylSXG1sAg5LGBZshpB5MXJrVf?=
 =?us-ascii?Q?x3o9HFnztZtYn1ZMlv732D04CVJ1cPVqoMJhgRIAcbdroRLQeW9YFY6CXGgn?=
 =?us-ascii?Q?fqBScdLo6PN5HSIIT/rI8064ERN1fV+XS0z1etoSE5JgexHsC/I=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pt49fnIXpn1AeCAFRNsj+JDXADNuXN9uFwiMBWUubuplKKj8LKMkKrCbZoa+?=
 =?us-ascii?Q?wOVFYpx79iGYALCRlpIuCXhqclBnTp6B2CV+hIhVUBxA1xelCvAHBKt5IPpf?=
 =?us-ascii?Q?1q+ofZt7OaE8DS7XFqDAmyOknJCqWqOsD8vVK38dLQZr+5DL6FF0ohRr5SK4?=
 =?us-ascii?Q?CFgZRnUYZSsD6yGev/PKn+TSOoHvTa3+EiqLUNAwtecdxKXnUv2Gd2XjJC27?=
 =?us-ascii?Q?+W3pgTgpxoWZaJk4F7MsCC2BhUqs7blTJyys9+8z05tHR46Q+9kPDEA7rEDl?=
 =?us-ascii?Q?rLGles6lYtoIp0zQH+SO9P0Niq9X8kJuxckDa+2R6XY8+PVDen5KM7KzkhLO?=
 =?us-ascii?Q?DDlWh5E1/EISsAD0xfMiKSaCShwHvgRX/dqYtExeBIJT+TvvuR3LrnEe2K34?=
 =?us-ascii?Q?Gs9Sqfm81O+GE6kobneXPNpYnjeI2z0mCidZUXMIVIQBdf5WVBAcvukAMHMx?=
 =?us-ascii?Q?6zs+iV1i/B52XyDWXxWPS9cGjkezQny4jyxpiAPYldiUcNOcOpwL0U6vAHtF?=
 =?us-ascii?Q?DewC1HFPkmRgL6L+fRdLC0lYpfHeHa3PA6unCW1lmOc7ISI//Q7x7TgnvFw3?=
 =?us-ascii?Q?BSyi1XzJhTJ+xx5ETcyQN8dxdU2ZRquWs9aIGKqPFrB7IDKfCpdkXyR4GOZu?=
 =?us-ascii?Q?bVw8BrJFcs5CwWDwQJlxEQET8PWgOxw62dluAQda2s7WWO/K8flXtBkatYHp?=
 =?us-ascii?Q?5l2Wu18s69n6jRzTinJGgtWv6E7E+PWWPZhMZ1UpisgUMwlCZJ8B1mKvRwHk?=
 =?us-ascii?Q?VdYtgsCblrw43+HpkP+TeXjARrS232P7T/6tBYyB8xX69Pwgc4WVGprvpRkv?=
 =?us-ascii?Q?miFJGPWeIpwatH2OIYuxNRR5HVEdSLIlhH0g4Hpm3wEv8rJ6vFD0PkG4Y/zh?=
 =?us-ascii?Q?J2idAF1HwGdjZuKB431QH2RNXltIOUjecjtt8g2QomaWTiiS2mnZ6nsU7XhF?=
 =?us-ascii?Q?5KJm/87RzDJ3yDjEevQwAcP2A4h8Psq/WeYjazzReYaKeKIiFLrEMUTRp9Rx?=
 =?us-ascii?Q?LbGSebUEWKb6bUiRGUIj0trDSa3rZwLlQi+9uYR0cEvdXEK3Hf0Eqg0Hbjar?=
 =?us-ascii?Q?5eton5w6S5nGdZYunZ+h7nrJyBdLUFqn9Li4F/4eLIIpnlZoSFVzywhxK5dT?=
 =?us-ascii?Q?O3g8uEmyyRUZr0xnm4wdbYI6JU1nZotR4Ibb3fH12ZAzWbiHBM1pJDq6gQYL?=
 =?us-ascii?Q?+nemp1H2vgfqKHetqde5655ZY8z7EuxFROvLye7RlsXfoDVEHWqcDrJakN9B?=
 =?us-ascii?Q?zLAHB+ZjfQf/6zcNz2mV?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0749b2ec-18de-44fe-ddb9-08dd4d3418e2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 20:13:51.1430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9931

Currently, kfunc filters already support filtering based on struct_ops
context information.

The BPF verifier can check context-sensitive kfuncs before the SCX
program is run, avoiding runtime overhead.

Therefore we no longer need mask-based runtime restrictions.

This patch removes the mask-based runtime restrictions.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/sched/ext.h |  24 ----
 kernel/sched/ext.c        | 232 ++++++++------------------------------
 2 files changed, 50 insertions(+), 206 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 1d70a9867fb1..867c24b88ace 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -96,29 +96,6 @@ enum scx_ent_dsq_flags {
 	SCX_TASK_DSQ_ON_PRIQ	= 1 << 0, /* task is queued on the priority queue of a dsq */
 };
 
-/*
- * Mask bits for scx_entity.kf_mask. Not all kfuncs can be called from
- * everywhere and the following bits track which kfunc sets are currently
- * allowed for %current. This simple per-task tracking works because SCX ops
- * nest in a limited way. BPF will likely implement a way to allow and disallow
- * kfuncs depending on the calling context which will replace this manual
- * mechanism. See scx_kf_allow().
- */
-enum scx_kf_mask {
-	SCX_KF_UNLOCKED		= 0,	  /* sleepable and not rq locked */
-	/* ENQUEUE and DISPATCH may be nested inside CPU_RELEASE */
-	SCX_KF_CPU_RELEASE	= 1 << 0, /* ops.cpu_release() */
-	/* ops.dequeue (in REST) may be nested inside DISPATCH */
-	SCX_KF_DISPATCH		= 1 << 1, /* ops.dispatch() */
-	SCX_KF_ENQUEUE		= 1 << 2, /* ops.enqueue() and ops.select_cpu() */
-	SCX_KF_SELECT_CPU	= 1 << 3, /* ops.select_cpu() */
-	SCX_KF_REST		= 1 << 4, /* other rq-locked operations */
-
-	__SCX_KF_RQ_LOCKED	= SCX_KF_CPU_RELEASE | SCX_KF_DISPATCH |
-				  SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
-	__SCX_KF_TERMINAL	= SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
-};
-
 enum scx_dsq_lnode_flags {
 	SCX_DSQ_LNODE_ITER_CURSOR = 1 << 0,
 
@@ -146,7 +123,6 @@ struct sched_ext_entity {
 	u32			weight;
 	s32			sticky_cpu;
 	s32			holding_cpu;
-	u32			kf_mask;	/* see scx_kf_mask above */
 	struct task_struct	*kf_tasks[2];	/* see SCX_CALL_OP_TASK() */
 	atomic_long_t		ops_state;
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d5eb82eada9c..d9b4b5e64674 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1092,19 +1092,6 @@ static long jiffies_delta_msecs(unsigned long at, unsigned long now)
 		return -(long)jiffies_to_msecs(now - at);
 }
 
-/* if the highest set bit is N, return a mask with bits [N+1, 31] set */
-static u32 higher_bits(u32 flags)
-{
-	return ~((1 << fls(flags)) - 1);
-}
-
-/* return the mask with only the highest bit set */
-static u32 highest_bit(u32 flags)
-{
-	int bit = fls(flags);
-	return ((u64)1 << bit) >> 1;
-}
-
 static bool u32_before(u32 a, u32 b)
 {
 	return (s32)(a - b) < 0;
@@ -1120,51 +1107,12 @@ static struct scx_dispatch_q *find_user_dsq(u64 dsq_id)
 	return rhashtable_lookup_fast(&dsq_hash, &dsq_id, dsq_hash_params);
 }
 
-/*
- * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
- * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
- * the allowed kfuncs and those kfuncs should use scx_kf_allowed() to check
- * whether it's running from an allowed context.
- *
- * @mask is constant, always inline to cull the mask calculations.
- */
-static __always_inline void scx_kf_allow(u32 mask)
-{
-	/* nesting is allowed only in increasing scx_kf_mask order */
-	WARN_ONCE((mask | higher_bits(mask)) & current->scx.kf_mask,
-		  "invalid nesting current->scx.kf_mask=0x%x mask=0x%x\n",
-		  current->scx.kf_mask, mask);
-	current->scx.kf_mask |= mask;
-	barrier();
-}
+#define SCX_CALL_OP(op, args...)	scx_ops.op(args)
 
-static void scx_kf_disallow(u32 mask)
-{
-	barrier();
-	current->scx.kf_mask &= ~mask;
-}
-
-#define SCX_CALL_OP(mask, op, args...)						\
-do {										\
-	if (mask) {								\
-		scx_kf_allow(mask);						\
-		scx_ops.op(args);						\
-		scx_kf_disallow(mask);						\
-	} else {								\
-		scx_ops.op(args);						\
-	}									\
-} while (0)
-
-#define SCX_CALL_OP_RET(mask, op, args...)					\
+#define SCX_CALL_OP_RET(op, args...)						\
 ({										\
 	__typeof__(scx_ops.op(args)) __ret;					\
-	if (mask) {								\
-		scx_kf_allow(mask);						\
-		__ret = scx_ops.op(args);					\
-		scx_kf_disallow(mask);						\
-	} else {								\
-		__ret = scx_ops.op(args);					\
-	}									\
+	__ret = scx_ops.op(args);						\
 	__ret;									\
 })
 
@@ -1179,74 +1127,36 @@ do {										\
  * scx_kf_allowed_on_arg_tasks() to test whether the invocation is allowed on
  * the specific task.
  */
-#define SCX_CALL_OP_TASK(mask, op, task, args...)				\
+#define SCX_CALL_OP_TASK(op, task, args...)					\
 do {										\
-	BUILD_BUG_ON((mask) & ~__SCX_KF_TERMINAL);				\
 	current->scx.kf_tasks[0] = task;					\
-	SCX_CALL_OP(mask, op, task, ##args);					\
+	SCX_CALL_OP(op, task, ##args);						\
 	current->scx.kf_tasks[0] = NULL;					\
 } while (0)
 
-#define SCX_CALL_OP_TASK_RET(mask, op, task, args...)				\
+#define SCX_CALL_OP_TASK_RET(op, task, args...)					\
 ({										\
 	__typeof__(scx_ops.op(task, ##args)) __ret;				\
-	BUILD_BUG_ON((mask) & ~__SCX_KF_TERMINAL);				\
 	current->scx.kf_tasks[0] = task;					\
-	__ret = SCX_CALL_OP_RET(mask, op, task, ##args);			\
+	__ret = SCX_CALL_OP_RET(op, task, ##args);				\
 	current->scx.kf_tasks[0] = NULL;					\
 	__ret;									\
 })
 
-#define SCX_CALL_OP_2TASKS_RET(mask, op, task0, task1, args...)			\
+#define SCX_CALL_OP_2TASKS_RET(op, task0, task1, args...)			\
 ({										\
 	__typeof__(scx_ops.op(task0, task1, ##args)) __ret;			\
-	BUILD_BUG_ON((mask) & ~__SCX_KF_TERMINAL);				\
 	current->scx.kf_tasks[0] = task0;					\
 	current->scx.kf_tasks[1] = task1;					\
-	__ret = SCX_CALL_OP_RET(mask, op, task0, task1, ##args);		\
+	__ret = SCX_CALL_OP_RET(op, task0, task1, ##args);			\
 	current->scx.kf_tasks[0] = NULL;					\
 	current->scx.kf_tasks[1] = NULL;					\
 	__ret;									\
 })
 
-/* @mask is constant, always inline to cull unnecessary branches */
-static __always_inline bool scx_kf_allowed(u32 mask)
-{
-	if (unlikely(!(current->scx.kf_mask & mask))) {
-		scx_ops_error("kfunc with mask 0x%x called from an operation only allowing 0x%x",
-			      mask, current->scx.kf_mask);
-		return false;
-	}
-
-	/*
-	 * Enforce nesting boundaries. e.g. A kfunc which can be called from
-	 * DISPATCH must not be called if we're running DEQUEUE which is nested
-	 * inside ops.dispatch(). We don't need to check boundaries for any
-	 * blocking kfuncs as the verifier ensures they're only called from
-	 * sleepable progs.
-	 */
-	if (unlikely(highest_bit(mask) == SCX_KF_CPU_RELEASE &&
-		     (current->scx.kf_mask & higher_bits(SCX_KF_CPU_RELEASE)))) {
-		scx_ops_error("cpu_release kfunc called from a nested operation");
-		return false;
-	}
-
-	if (unlikely(highest_bit(mask) == SCX_KF_DISPATCH &&
-		     (current->scx.kf_mask & higher_bits(SCX_KF_DISPATCH)))) {
-		scx_ops_error("dispatch kfunc called from a nested operation");
-		return false;
-	}
-
-	return true;
-}
-
 /* see SCX_CALL_OP_TASK() */
-static __always_inline bool scx_kf_allowed_on_arg_tasks(u32 mask,
-							struct task_struct *p)
+static __always_inline bool scx_kf_allowed_on_arg_tasks(struct task_struct *p)
 {
-	if (!scx_kf_allowed(mask))
-		return false;
-
 	if (unlikely((p != current->scx.kf_tasks[0] &&
 		      p != current->scx.kf_tasks[1]))) {
 		scx_ops_error("called on a task not being operated on");
@@ -1256,11 +1166,6 @@ static __always_inline bool scx_kf_allowed_on_arg_tasks(u32 mask,
 	return true;
 }
 
-static bool scx_kf_allowed_if_unlocked(void)
-{
-	return !current->scx.kf_mask;
-}
-
 /**
  * nldsq_next_task - Iterate to the next task in a non-local DSQ
  * @dsq: user dsq being interated
@@ -2076,7 +1981,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	WARN_ON_ONCE(*ddsp_taskp);
 	*ddsp_taskp = p;
 
-	SCX_CALL_OP_TASK(SCX_KF_ENQUEUE, enqueue, p, enq_flags);
+	SCX_CALL_OP_TASK(enqueue, p, enq_flags);
 
 	*ddsp_taskp = NULL;
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
@@ -2171,7 +2076,7 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	add_nr_running(rq, 1);
 
 	if (SCX_HAS_OP(runnable) && !task_on_rq_migrating(p))
-		SCX_CALL_OP_TASK(SCX_KF_REST, runnable, p, enq_flags);
+		SCX_CALL_OP_TASK(runnable, p, enq_flags);
 
 	if (enq_flags & SCX_ENQ_WAKEUP)
 		touch_core_sched(rq, p);
@@ -2202,7 +2107,7 @@ static void ops_dequeue(struct task_struct *p, u64 deq_flags)
 		BUG();
 	case SCX_OPSS_QUEUED:
 		if (SCX_HAS_OP(dequeue))
-			SCX_CALL_OP_TASK(SCX_KF_REST, dequeue, p, deq_flags);
+			SCX_CALL_OP_TASK(dequeue, p, deq_flags);
 
 		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
 					    SCX_OPSS_NONE))
@@ -2251,11 +2156,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	 */
 	if (SCX_HAS_OP(stopping) && task_current(rq, p)) {
 		update_curr_scx(rq);
-		SCX_CALL_OP_TASK(SCX_KF_REST, stopping, p, false);
+		SCX_CALL_OP_TASK(stopping, p, false);
 	}
 
 	if (SCX_HAS_OP(quiescent) && !task_on_rq_migrating(p))
-		SCX_CALL_OP_TASK(SCX_KF_REST, quiescent, p, deq_flags);
+		SCX_CALL_OP_TASK(quiescent, p, deq_flags);
 
 	if (deq_flags & SCX_DEQ_SLEEP)
 		p->scx.flags |= SCX_TASK_DEQD_FOR_SLEEP;
@@ -2275,7 +2180,7 @@ static void yield_task_scx(struct rq *rq)
 	struct task_struct *p = rq->curr;
 
 	if (SCX_HAS_OP(yield))
-		SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, yield, p, NULL);
+		SCX_CALL_OP_2TASKS_RET(yield, p, NULL);
 	else
 		p->scx.slice = 0;
 }
@@ -2285,7 +2190,7 @@ static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
 	struct task_struct *from = rq->curr;
 
 	if (SCX_HAS_OP(yield))
-		return SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, yield, from, to);
+		return SCX_CALL_OP_2TASKS_RET(yield, from, to);
 	else
 		return false;
 }
@@ -2812,7 +2717,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 * emitted in switch_class().
 		 */
 		if (SCX_HAS_OP(cpu_acquire))
-			SCX_CALL_OP(SCX_KF_REST, cpu_acquire, cpu_of(rq), NULL);
+			SCX_CALL_OP(cpu_acquire, cpu_of(rq), NULL);
 		rq->scx.cpu_released = false;
 	}
 
@@ -2857,8 +2762,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	do {
 		dspc->nr_tasks = 0;
 
-		SCX_CALL_OP(SCX_KF_DISPATCH, dispatch, cpu_of(rq),
-			    prev_on_scx ? prev : NULL);
+		SCX_CALL_OP(dispatch, cpu_of(rq), prev_on_scx ? prev : NULL);
 
 		flush_dispatch_buf(rq);
 
@@ -2978,7 +2882,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
 	if (SCX_HAS_OP(running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(SCX_KF_REST, running, p);
+		SCX_CALL_OP_TASK(running, p);
 
 	clr_task_runnable(p, true);
 
@@ -3059,8 +2963,7 @@ static void switch_class(struct rq *rq, struct task_struct *next)
 				.task = next,
 			};
 
-			SCX_CALL_OP(SCX_KF_CPU_RELEASE,
-				    cpu_release, cpu_of(rq), &args);
+			SCX_CALL_OP(cpu_release, cpu_of(rq), &args);
 		}
 		rq->scx.cpu_released = true;
 	}
@@ -3073,7 +2976,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
 	if (SCX_HAS_OP(stopping) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(SCX_KF_REST, stopping, p, true);
+		SCX_CALL_OP_TASK(stopping, p, true);
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
@@ -3651,8 +3554,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		WARN_ON_ONCE(*ddsp_taskp);
 		*ddsp_taskp = p;
 
-		cpu = SCX_CALL_OP_TASK_RET(SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU,
-					   select_cpu, p, prev_cpu, wake_flags);
+		cpu = SCX_CALL_OP_TASK_RET(select_cpu, p, prev_cpu, wake_flags);
 		*ddsp_taskp = NULL;
 		if (ops_cpu_valid(cpu, "from ops.select_cpu()"))
 			return cpu;
@@ -3690,8 +3592,7 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 	 * designation pointless. Cast it away when calling the operation.
 	 */
 	if (SCX_HAS_OP(set_cpumask))
-		SCX_CALL_OP_TASK(SCX_KF_REST, set_cpumask, p,
-				 (struct cpumask *)p->cpus_ptr);
+		SCX_CALL_OP_TASK(set_cpumask, p, (struct cpumask *)p->cpus_ptr);
 }
 
 static void reset_idle_masks(void)
@@ -3757,7 +3658,7 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 	 * managed by put_prev_task_idle()/set_next_task_idle().
 	 */
 	if (SCX_HAS_OP(update_idle) && do_notify && !scx_rq_bypassing(rq))
-		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
+		SCX_CALL_OP(update_idle, cpu_of(rq), idle);
 
 	/*
 	 * Update the idle masks:
@@ -3788,9 +3689,9 @@ static void handle_hotplug(struct rq *rq, bool online)
 		update_selcpu_topology();
 
 	if (online && SCX_HAS_OP(cpu_online))
-		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
+		SCX_CALL_OP(cpu_online, cpu);
 	else if (!online && SCX_HAS_OP(cpu_offline))
-		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_offline, cpu);
+		SCX_CALL_OP(cpu_offline, cpu);
 	else
 		scx_ops_exit(SCX_ECODE_ACT_RESTART | SCX_ECODE_RSN_HOTPLUG,
 			     "cpu %d going %s, exiting scheduler", cpu,
@@ -3900,7 +3801,7 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 		curr->scx.slice = 0;
 		touch_core_sched(rq, curr);
 	} else if (SCX_HAS_OP(tick)) {
-		SCX_CALL_OP(SCX_KF_REST, tick, curr);
+		SCX_CALL_OP(tick, curr);
 	}
 
 	if (!curr->scx.slice)
@@ -3977,7 +3878,7 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
 			.fork = fork,
 		};
 
-		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, init_task, p, &args);
+		ret = SCX_CALL_OP_RET(init_task, p, &args);
 		if (unlikely(ret)) {
 			ret = ops_sanitize_err("init_task", ret);
 			return ret;
@@ -4034,11 +3935,11 @@ static void scx_ops_enable_task(struct task_struct *p)
 	p->scx.weight = sched_weight_to_cgroup(weight);
 
 	if (SCX_HAS_OP(enable))
-		SCX_CALL_OP_TASK(SCX_KF_REST, enable, p);
+		SCX_CALL_OP_TASK(enable, p);
 	scx_set_task_state(p, SCX_TASK_ENABLED);
 
 	if (SCX_HAS_OP(set_weight))
-		SCX_CALL_OP_TASK(SCX_KF_REST, set_weight, p, p->scx.weight);
+		SCX_CALL_OP_TASK(set_weight, p, p->scx.weight);
 }
 
 static void scx_ops_disable_task(struct task_struct *p)
@@ -4047,7 +3948,7 @@ static void scx_ops_disable_task(struct task_struct *p)
 	WARN_ON_ONCE(scx_get_task_state(p) != SCX_TASK_ENABLED);
 
 	if (SCX_HAS_OP(disable))
-		SCX_CALL_OP(SCX_KF_REST, disable, p);
+		SCX_CALL_OP(disable, p);
 	scx_set_task_state(p, SCX_TASK_READY);
 }
 
@@ -4076,7 +3977,7 @@ static void scx_ops_exit_task(struct task_struct *p)
 	}
 
 	if (SCX_HAS_OP(exit_task))
-		SCX_CALL_OP(SCX_KF_REST, exit_task, p, &args);
+		SCX_CALL_OP(exit_task, p, &args);
 	scx_set_task_state(p, SCX_TASK_NONE);
 }
 
@@ -4185,7 +4086,7 @@ static void reweight_task_scx(struct rq *rq, struct task_struct *p,
 
 	p->scx.weight = sched_weight_to_cgroup(scale_load_down(lw->weight));
 	if (SCX_HAS_OP(set_weight))
-		SCX_CALL_OP_TASK(SCX_KF_REST, set_weight, p, p->scx.weight);
+		SCX_CALL_OP_TASK(set_weight, p, p->scx.weight);
 }
 
 static void prio_changed_scx(struct rq *rq, struct task_struct *p, int oldprio)
@@ -4201,8 +4102,7 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 	 * different scheduler class. Keep the BPF scheduler up-to-date.
 	 */
 	if (SCX_HAS_OP(set_cpumask))
-		SCX_CALL_OP_TASK(SCX_KF_REST, set_cpumask, p,
-				 (struct cpumask *)p->cpus_ptr);
+		SCX_CALL_OP_TASK(set_cpumask, p, (struct cpumask *)p->cpus_ptr);
 }
 
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
@@ -4294,8 +4194,7 @@ int scx_tg_online(struct task_group *tg)
 			struct scx_cgroup_init_args args =
 				{ .weight = tg->scx_weight };
 
-			ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_init,
-					      tg->css.cgroup, &args);
+			ret = SCX_CALL_OP_RET(cgroup_init, tg->css.cgroup, &args);
 			if (ret)
 				ret = ops_sanitize_err("cgroup_init", ret);
 		}
@@ -4316,7 +4215,7 @@ void scx_tg_offline(struct task_group *tg)
 	percpu_down_read(&scx_cgroup_rwsem);
 
 	if (SCX_HAS_OP(cgroup_exit) && (tg->scx_flags & SCX_TG_INITED))
-		SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_exit, tg->css.cgroup);
+		SCX_CALL_OP(cgroup_exit, tg->css.cgroup);
 	tg->scx_flags &= ~(SCX_TG_ONLINE | SCX_TG_INITED);
 
 	percpu_up_read(&scx_cgroup_rwsem);
@@ -4349,8 +4248,7 @@ int scx_cgroup_can_attach(struct cgroup_taskset *tset)
 			continue;
 
 		if (SCX_HAS_OP(cgroup_prep_move)) {
-			ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_prep_move,
-					      p, from, css->cgroup);
+			ret = SCX_CALL_OP_RET(cgroup_prep_move, p, from, css->cgroup);
 			if (ret)
 				goto err;
 		}
@@ -4363,8 +4261,7 @@ int scx_cgroup_can_attach(struct cgroup_taskset *tset)
 err:
 	cgroup_taskset_for_each(p, css, tset) {
 		if (SCX_HAS_OP(cgroup_cancel_move) && p->scx.cgrp_moving_from)
-			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_cancel_move, p,
-				    p->scx.cgrp_moving_from, css->cgroup);
+			SCX_CALL_OP(cgroup_cancel_move, p, p->scx.cgrp_moving_from, css->cgroup);
 		p->scx.cgrp_moving_from = NULL;
 	}
 
@@ -4395,8 +4292,7 @@ void scx_move_task(struct task_struct *p)
 	 * cgrp_moving_from set.
 	 */
 	if (SCX_HAS_OP(cgroup_move) && !WARN_ON_ONCE(!p->scx.cgrp_moving_from))
-		SCX_CALL_OP_TASK(SCX_KF_UNLOCKED, cgroup_move, p,
-			p->scx.cgrp_moving_from, tg_cgrp(task_group(p)));
+		SCX_CALL_OP_TASK(cgroup_move, p, p->scx.cgrp_moving_from, tg_cgrp(task_group(p)));
 	p->scx.cgrp_moving_from = NULL;
 }
 
@@ -4415,8 +4311,7 @@ void scx_cgroup_cancel_attach(struct cgroup_taskset *tset)
 
 	cgroup_taskset_for_each(p, css, tset) {
 		if (SCX_HAS_OP(cgroup_cancel_move) && p->scx.cgrp_moving_from)
-			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_cancel_move, p,
-				    p->scx.cgrp_moving_from, css->cgroup);
+			SCX_CALL_OP(cgroup_cancel_move, p, p->scx.cgrp_moving_from, css->cgroup);
 		p->scx.cgrp_moving_from = NULL;
 	}
 out_unlock:
@@ -4429,8 +4324,7 @@ void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 
 	if (scx_cgroup_enabled && tg->scx_weight != weight) {
 		if (SCX_HAS_OP(cgroup_set_weight))
-			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_set_weight,
-				    tg_cgrp(tg), weight);
+			SCX_CALL_OP(cgroup_set_weight, tg_cgrp(tg), weight);
 		tg->scx_weight = weight;
 	}
 
@@ -4620,7 +4514,7 @@ static void scx_cgroup_exit(void)
 			continue;
 		rcu_read_unlock();
 
-		SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_exit, css->cgroup);
+		SCX_CALL_OP(cgroup_exit, css->cgroup);
 
 		rcu_read_lock();
 		css_put(css);
@@ -4663,8 +4557,7 @@ static int scx_cgroup_init(void)
 			continue;
 		rcu_read_unlock();
 
-		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_init,
-				      css->cgroup, &args);
+		ret = SCX_CALL_OP_RET(cgroup_init, css->cgroup, &args);
 		if (ret) {
 			css_put(css);
 			scx_ops_error("ops.cgroup_init() failed (%d)", ret);
@@ -5127,7 +5020,7 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	}
 
 	if (scx_ops.exit)
-		SCX_CALL_OP(SCX_KF_UNLOCKED, exit, ei);
+		SCX_CALL_OP(exit, ei);
 
 	cancel_delayed_work_sync(&scx_watchdog_work);
 
@@ -5333,7 +5226,7 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
 
 	if (SCX_HAS_OP(dump_task)) {
 		ops_dump_init(s, "    ");
-		SCX_CALL_OP(SCX_KF_REST, dump_task, dctx, p);
+		SCX_CALL_OP(dump_task, dctx, p);
 		ops_dump_exit();
 	}
 
@@ -5379,7 +5272,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 
 	if (SCX_HAS_OP(dump)) {
 		ops_dump_init(&s, "");
-		SCX_CALL_OP(SCX_KF_UNLOCKED, dump, &dctx);
+		SCX_CALL_OP(dump, &dctx);
 		ops_dump_exit();
 	}
 
@@ -5436,7 +5329,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 		used = seq_buf_used(&ns);
 		if (SCX_HAS_OP(dump_cpu)) {
 			ops_dump_init(&ns, "  ");
-			SCX_CALL_OP(SCX_KF_REST, dump_cpu, &dctx, cpu, idle);
+			SCX_CALL_OP(dump_cpu, &dctx, cpu, idle);
 			ops_dump_exit();
 		}
 
@@ -5656,7 +5549,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	cpus_read_lock();
 
 	if (scx_ops.init) {
-		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, init);
+		ret = SCX_CALL_OP_RET(init);
 		if (ret) {
 			ret = ops_sanitize_err("init", ret);
 			cpus_read_unlock();
@@ -6432,9 +6325,6 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	if (!check_builtin_idle_enabled())
 		goto prev_cpu;
 
-	if (!scx_kf_allowed(SCX_KF_SELECT_CPU))
-		goto prev_cpu;
-
 #ifdef CONFIG_SMP
 	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, is_idle);
 #endif
@@ -6452,9 +6342,6 @@ BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
 
 static bool scx_dsq_insert_preamble(struct task_struct *p, u64 enq_flags)
 {
-	if (!scx_kf_allowed(SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
-		return false;
-
 	lockdep_assert_irqs_disabled();
 
 	if (unlikely(!p)) {
@@ -6616,9 +6503,6 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	bool in_balance;
 	unsigned long flags;
 
-	if (!scx_kf_allowed_if_unlocked() && !scx_kf_allowed(SCX_KF_DISPATCH))
-		return false;
-
 	/*
 	 * Can be called from either ops.dispatch() locking this_rq() or any
 	 * context where no rq lock is held. If latter, lock @p's task_rq which
@@ -6701,9 +6585,6 @@ __bpf_kfunc_start_defs();
  */
 __bpf_kfunc u32 scx_bpf_dispatch_nr_slots(void)
 {
-	if (!scx_kf_allowed(SCX_KF_DISPATCH))
-		return 0;
-
 	return scx_dsp_max_batch - __this_cpu_read(scx_dsp_ctx->cursor);
 }
 
@@ -6717,9 +6598,6 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(void)
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 
-	if (!scx_kf_allowed(SCX_KF_DISPATCH))
-		return;
-
 	if (dspc->cursor > 0)
 		dspc->cursor--;
 	else
@@ -6745,9 +6623,6 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id)
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct scx_dispatch_q *dsq;
 
-	if (!scx_kf_allowed(SCX_KF_DISPATCH))
-		return false;
-
 	flush_dispatch_buf(dspc->rq);
 
 	dsq = find_user_dsq(dsq_id);
@@ -6938,9 +6813,6 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
 	struct rq *rq;
 	struct task_struct *p, *n;
 
-	if (!scx_kf_allowed(SCX_KF_CPU_RELEASE))
-		return 0;
-
 	rq = cpu_rq(smp_processor_id());
 	lockdep_assert_rq_held(rq);
 
@@ -7671,7 +7543,7 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p)
 	struct task_group *tg = p->sched_task_group;
 	struct cgroup *cgrp = &cgrp_dfl_root.cgrp;
 
-	if (!scx_kf_allowed_on_arg_tasks(__SCX_KF_RQ_LOCKED, p))
+	if (!scx_kf_allowed_on_arg_tasks(p))
 		goto out;
 
 	cgrp = tg_cgrp(tg);
@@ -7870,10 +7742,6 @@ static int __init scx_init(void)
 	 *
 	 * Some kfuncs are context-sensitive and can only be called from
 	 * specific SCX ops. They are grouped into BTF sets accordingly.
-	 * Unfortunately, BPF currently doesn't have a way of enforcing such
-	 * restrictions. Eventually, the verifier should be able to enforce
-	 * them. For now, register them the same and make each kfunc explicitly
-	 * check using scx_kf_allowed().
 	 */
 	if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_ops_context)) ||
-- 
2.39.5


