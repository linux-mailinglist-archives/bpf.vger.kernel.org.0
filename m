Return-Path: <bpf+bounces-52692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B04ACA46B25
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 20:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8B6188C6A6
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 19:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F59E24EF75;
	Wed, 26 Feb 2025 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="i0IQYf9l"
X-Original-To: bpf@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013077.outbound.protection.outlook.com [52.103.46.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4068419DF52;
	Wed, 26 Feb 2025 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598429; cv=fail; b=V1EcffZOw3ZUsH68iwJTsv5FzkOt7GYyU2q/wWvnomsGGeANOSAC8UL0qf3j/7wdgnXD/S6/+rAo7PvYAu3L8xzcuW7eWRVzzQLnQ0KUg1xWtnsSHGHxD/PKFRmk2dZrCI9n2jSk9rMp28i4UAxTw+e0MT0Hm0l3bOgBvsJxKp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598429; c=relaxed/simple;
	bh=H2opES8LeX49Q/71BNpOZG8VI4PGaBymS99N49/xAvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fSI15woptt/MTOnt8VqoRzKySGt6vVoiU+NmZeByhAd46CDWmulAuPuz3g+/Mdg0Y6VqPqCusEE6mC+eFIQcmG2jD/2lpu7VBhUBYfnCLujJrSQx3Dmg4wCYWemhR9t/o8InJx2lDpIAXGDQKUIV5gTeEzYOz3qLwdsr38MAyME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=i0IQYf9l; arc=fail smtp.client-ip=52.103.46.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oc6Cf9nAZF/jwOtQOpNnepdK3gu3CI5G/msLM3qZE+Vo3y1qMl8MzTuLYs01Vq3d5KutpoX+5rLf6poF0RjyCHhKD03zciufvYPWcu4i43JBIQqVq1TqDBjcXxQbdUlH6jIzCNTQfcpNR81wt/78jGXE79iadx9KJjRX/6v5k17UKWlUeca7c1Vs52dayq7iGB4Wa9lig4dinz3n4U9FfMIHNhRO9yVdo6jaes+SgC6DCNC9KG949j3pL7l2VsIkD0dR4rxRVzu5Bst54dLWshiyHpcp8GObvqUi2+0V1IaAZoTU69R01VOW9I/Dp1+qa/BfS3KOAp1q2SEIVJW4DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCFKNGzgYsEUOAJLCXtQGybtfSgMjpgBNQU7ZYkmGGQ=;
 b=keB6sGzkAoZX++jsdEliwsGth21NMhm91/ThE0Waju6c2KDFwjPvrAGsQfUWuq5zXsKJspkblCdHOwR+nmN7G1kLBVOcwl4GuOn3+X20E5QIGZma0iAbwGKFS3L3GvpfCNP6o6LDhuccz+zwQl/Hk8q7rBkmtDs8Cv8su4TTjNqBfKdmFw2dBYhI7SaOZE15hdZsYi0LeUDZtntmb9CCoV1jVWB94Axkt6m5OLuQEwBEUtr0YCuPY0hJJwJjAZyo8ec61v+TExNCPpzZoD6W9LcWI3kT1R3pn0opC+Cwgy6uFtmR86G4I+rUrAub63MeqexJflpHut6J74XyiA46yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCFKNGzgYsEUOAJLCXtQGybtfSgMjpgBNQU7ZYkmGGQ=;
 b=i0IQYf9ln9Jvy0dH2BSkirVNmrI56aUX3EUvQh2IYp57ZvElHkueSlQZpbhR5wXjxlv6594UnfVyMu/DZ3ktRTh4OmpbCgR5gXZ0KZtlWp70n+jg6jBw3GbC4LQt0fmoaLX/HZ2S2vm/0D/5o19Wrww9WgTTHrlazsHkM58tS+pMNsPROOwj3puRSsyVnlI3eldmhfIKKPSjSzFHmwN/y+zG3GFZ37GWcfgH+Jca0cvS+M7TGkRUkjc3fuQWpSdDk/+ObGLlyzlirHHPaH/vcwphvXKexSASPZ/jO7Demgd6uyfEUFS4PskaHMtg9bCfPaVohZ8X7+r5JkhTLc9UAA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DBBPR03MB7451.eurprd03.prod.outlook.com (2603:10a6:10:20e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 19:33:43 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 19:33:43 +0000
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
Subject: [PATCH sched_ext/for-6.15 v3 4/5] sched_ext: Removed mask-based runtime restrictions on calling kfuncs in different contexts
Date: Wed, 26 Feb 2025 19:28:19 +0000
Message-ID:
 <AM6PR03MB5080BDE038C8E8E89996F30E99C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0349.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::12) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250226192820.156545-4-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DBBPR03MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 843fd18e-ac44-4648-6835-08dd569c7abc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|12121999004|15080799006|19110799003|8060799006|5072599009|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lb7YIWPh16K+NB0iwZCrTathRx5VRbnLXzbNoKd4fXSWE0xx5qqHRNivfLWB?=
 =?us-ascii?Q?v3vJXx2z5Bg19/whOZYHL8/IuF/7zCZEokwCJuDAjBIAw1HQw1T6Mr64JfVj?=
 =?us-ascii?Q?cXQnUcRI16iFdmPKu+RLr58mQ/worJzl+3a5zeWc3bp3UZC6TveNag/ut7f6?=
 =?us-ascii?Q?pSceGxw76xgnVPqOqQUZXQ0qUx3WROdNHgTc7ipjgusvUy30SA2ADHyhizmS?=
 =?us-ascii?Q?zs6SY/ay7u0dTjZCS3Q/Vh28MkTn3iQhqiICX6rSWsyGiNhYT9Ws7SEFxD+E?=
 =?us-ascii?Q?yinZmNqeKfnEyj7autfI4JYypMTs0Cu+x5bCOccc37JPEfAt/z3IrtDSf/9M?=
 =?us-ascii?Q?7haQC5du2fSzD1sm1uXn2MR+GYo2j4ysB5ohhbtvpLHxn+8FaSTOyCmCMpiI?=
 =?us-ascii?Q?eyriGfmF6XFpY5QiiwtCrgGlK5oGpgr1oNBwf/PJ2tj9fEyonoCZL+npCF33?=
 =?us-ascii?Q?fjkyp5LS0QvEnC2K/xkpbpn9PNrOV/Q0TtJZFx6OaW2F6sJP5cMUZZC8JDpr?=
 =?us-ascii?Q?Sc6ke7T0e6OnsERcDpqgmC96n2uyi74h2Ci+W4ZMOy8SV8IF1fcCZwtnSX1l?=
 =?us-ascii?Q?euseDkZFcun54hNM88lFa+h9IxBqB2nUXObLe+F+kU1AtMUdndlufBZH0Gdi?=
 =?us-ascii?Q?A52OSQxmmZ9hHrd6lJXQWo9n/BOmapnUZzBYMb1nHrITPp9Jp7yWhY/grt8x?=
 =?us-ascii?Q?uFShlQ03yjTSkbnhhEV94k2F+7B8UMIGc5+4PkyYBdQxvqWddk3pPe/9vqq9?=
 =?us-ascii?Q?/+q5sDHwy3IbYKQa2lPexUsBppa8igt50FgBaRSYSmKA+WoNxgJ0gu5Sl4CG?=
 =?us-ascii?Q?8xdsD8+ANuAsHxfre3c5tnhuEyuhdI9e4p3Yot+FJ1Aptzb+Pos6KGHQzutJ?=
 =?us-ascii?Q?Mmw4iQmJPt8f6ZKoQUPLDBpw/fILT4SFxeLa6QmukykVZSCiXP4feJAU7uq5?=
 =?us-ascii?Q?7DMBF4ex0EJ/Yyv1Sv1EZkqPcPS9fgMzp0MfUTJDIjabee961W8E2bIpl++O?=
 =?us-ascii?Q?L5Pe2wMco4QsZhnbqIi9uOkOJWtIS8MGeHD1hJ3v9+CKUE2Gvy19wzG8GAdJ?=
 =?us-ascii?Q?8ImTntm9FYrkVcTynuPMNQanWltie91lNsfZjrPt0WVPOSpOkmg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0mUTxmjRz8Z5+CDMSz1cxuwHUe+OZxA1U5jF0yfBLICWZV6s0E3ymaYPrgVX?=
 =?us-ascii?Q?5E+TTthhdqMhwaDNGmO64i9JmZhmloS7CaDRUzjTF8Ldm1hVrocN62LqEEzo?=
 =?us-ascii?Q?GWRVfqWDoXlMqLhrwxZMVIyi+Dp1KT4mcdRgKbb/hIvRpOARKqLHfiO+hdDn?=
 =?us-ascii?Q?sIzye/0nE0XBuJmSZE2p0I4rZu4kiYYxPIeTx5d0TrslXQryt0OpDvql7lcm?=
 =?us-ascii?Q?/FW43bttO7DhBgYvLqCqjPgLZhDbpW2BaGPTu2i3Nwuygx2/gcHMptTjHVYH?=
 =?us-ascii?Q?hJYttud0BoEoJOKFYEMMcNLD8GyivIz0QDq+SD13Uqrph3tVQkQHSzRnr46C?=
 =?us-ascii?Q?Jn0O+6E5vHDzixrMFSDtrgXFAe/U0eCCFl5GGWLXV7ShKNJM1uZmrou/ebxL?=
 =?us-ascii?Q?dLPiSASfSUBYqL2eioD/VCBTd1u68a1V7VhWWLzpa36lQrzltZTnvnVMBSGW?=
 =?us-ascii?Q?l+/YVELbOkxRDbvRvAj+wPzMoBL+lxGCFf21hAmpAK1sSqK/g1oiEQ6cjUnH?=
 =?us-ascii?Q?ZfCM1TJhB+Nyh9zu0gd5u6QasZACQMh/80uPYuqFzTMhmurzaBHrmuDLm1Ze?=
 =?us-ascii?Q?SRxLrEYCrQRXfxqgl+KEEDjRFfIKGyDx+ago//tu7nqiGlF4pumYa2Mulaii?=
 =?us-ascii?Q?oDz2s7vuFWK9kUW57b+HGP8gKuLbqnoFD1XuTZQam6e5c7dnI3IOLlo0lN5h?=
 =?us-ascii?Q?iJO2H9s/A49W5N+5YmYrJfIY1j0M+hApOHfH6WD7ggY2yhTyUqvC2vdfEzVl?=
 =?us-ascii?Q?T6QCrA9oNKxMyL5O6cfVKb4jzjmyuXgBzg7wBcPvNdmVESME7ao5qtOeI8g2?=
 =?us-ascii?Q?O15FvJ8Z9XXrqNeoZt8GMFvUIFJ161s0rwULOv9pj0mtOVMIdvmJK/SP69k3?=
 =?us-ascii?Q?ndQL6AeD8gm/z7Yzo81eeiXhIuDDHi4r9lEq05srif/KnwD6VHCfEEQT4lvs?=
 =?us-ascii?Q?Yo000n4MUD3Zr3FvveoFO/Lw5bPcGaBmnKIvJ6ufhHx/M8KmybYJ82Q8byXi?=
 =?us-ascii?Q?0rXd2i9Ed17zn57/X9CH+2oM1znGRT6Z/fi4iI/sl5meclLe/vshRFfX81Vt?=
 =?us-ascii?Q?FsnteAReGSLfdLRdGX1UGqMXniKst0et4FvL8ficLqQfJh1MzV/03g+Cdk4y?=
 =?us-ascii?Q?+aebeZtbSzYcFvBPlBL+AC2eIM9j7oxP0sgWtu+CECDpbaXsfDsck05jlCIi?=
 =?us-ascii?Q?ve1IOwSXRxPgFf/H8SuVxzovYqmFJsY+SCIbr7y0AgbSUcH2Z3f0cMe/tQBW?=
 =?us-ascii?Q?yc7KE8OeSpl3YyqtaJks?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843fd18e-ac44-4648-6835-08dd569c7abc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 19:33:43.3161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7451

Currently, kfunc filters already support filtering based on struct_ops
context information.

The BPF verifier can check context-sensitive kfuncs before the SCX
program is run, avoiding runtime overhead.

Therefore we no longer need mask-based runtime restrictions.

This patch removes the mask-based runtime restrictions.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/sched/ext.h |  24 ----
 kernel/sched/ext.c        | 227 ++++++++------------------------------
 kernel/sched/ext_idle.c   |   5 +-
 3 files changed, 50 insertions(+), 206 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index f7545430a548..9980d6b55c84 100644
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
 
@@ -147,7 +124,6 @@ struct sched_ext_entity {
 	s32			sticky_cpu;
 	s32			holding_cpu;
 	s32			selected_cpu;
-	u32			kf_mask;	/* see scx_kf_mask above */
 	struct task_struct	*kf_tasks[2];	/* see SCX_CALL_OP_TASK() */
 	atomic_long_t		ops_state;
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c337f6206ae5..7dc5f11be66b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1115,19 +1115,6 @@ static long jiffies_delta_msecs(unsigned long at, unsigned long now)
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
@@ -1143,51 +1130,12 @@ static struct scx_dispatch_q *find_user_dsq(u64 dsq_id)
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
-
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
+#define SCX_CALL_OP(op, args...)	scx_ops.op(args)
 
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
 
@@ -1202,74 +1150,36 @@ do {										\
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
@@ -1279,11 +1189,6 @@ static __always_inline bool scx_kf_allowed_on_arg_tasks(u32 mask,
 	return true;
 }
 
-static bool scx_kf_allowed_if_unlocked(void)
-{
-	return !current->scx.kf_mask;
-}
-
 /**
  * nldsq_next_task - Iterate to the next task in a non-local DSQ
  * @dsq: user dsq being iterated
@@ -2219,7 +2124,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	WARN_ON_ONCE(*ddsp_taskp);
 	*ddsp_taskp = p;
 
-	SCX_CALL_OP_TASK(SCX_KF_ENQUEUE, enqueue, p, enq_flags);
+	SCX_CALL_OP_TASK(enqueue, p, enq_flags);
 
 	*ddsp_taskp = NULL;
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
@@ -2316,7 +2221,7 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	add_nr_running(rq, 1);
 
 	if (SCX_HAS_OP(runnable) && !task_on_rq_migrating(p))
-		SCX_CALL_OP_TASK(SCX_KF_REST, runnable, p, enq_flags);
+		SCX_CALL_OP_TASK(runnable, p, enq_flags);
 
 	if (enq_flags & SCX_ENQ_WAKEUP)
 		touch_core_sched(rq, p);
@@ -2351,7 +2256,7 @@ static void ops_dequeue(struct task_struct *p, u64 deq_flags)
 		BUG();
 	case SCX_OPSS_QUEUED:
 		if (SCX_HAS_OP(dequeue))
-			SCX_CALL_OP_TASK(SCX_KF_REST, dequeue, p, deq_flags);
+			SCX_CALL_OP_TASK(dequeue, p, deq_flags);
 
 		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
 					    SCX_OPSS_NONE))
@@ -2400,11 +2305,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
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
@@ -2424,7 +2329,7 @@ static void yield_task_scx(struct rq *rq)
 	struct task_struct *p = rq->curr;
 
 	if (SCX_HAS_OP(yield))
-		SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, yield, p, NULL);
+		SCX_CALL_OP_2TASKS_RET(yield, p, NULL);
 	else
 		p->scx.slice = 0;
 }
@@ -2434,7 +2339,7 @@ static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
 	struct task_struct *from = rq->curr;
 
 	if (SCX_HAS_OP(yield))
-		return SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, yield, from, to);
+		return SCX_CALL_OP_2TASKS_RET(yield, from, to);
 	else
 		return false;
 }
@@ -2992,7 +2897,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 * emitted in switch_class().
 		 */
 		if (SCX_HAS_OP(cpu_acquire))
-			SCX_CALL_OP(SCX_KF_REST, cpu_acquire, cpu_of(rq), NULL);
+			SCX_CALL_OP(cpu_acquire, cpu_of(rq), NULL);
 		rq->scx.cpu_released = false;
 	}
 
@@ -3037,8 +2942,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	do {
 		dspc->nr_tasks = 0;
 
-		SCX_CALL_OP(SCX_KF_DISPATCH, dispatch, cpu_of(rq),
-			    prev_on_scx ? prev : NULL);
+		SCX_CALL_OP(dispatch, cpu_of(rq), prev_on_scx ? prev : NULL);
 
 		flush_dispatch_buf(rq);
 
@@ -3159,7 +3063,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
 	if (SCX_HAS_OP(running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(SCX_KF_REST, running, p);
+		SCX_CALL_OP_TASK(running, p);
 
 	clr_task_runnable(p, true);
 
@@ -3240,8 +3144,7 @@ static void switch_class(struct rq *rq, struct task_struct *next)
 				.task = next,
 			};
 
-			SCX_CALL_OP(SCX_KF_CPU_RELEASE,
-				    cpu_release, cpu_of(rq), &args);
+			SCX_CALL_OP(cpu_release, cpu_of(rq), &args);
 		}
 		rq->scx.cpu_released = true;
 	}
@@ -3254,7 +3157,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
 	if (SCX_HAS_OP(stopping) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(SCX_KF_REST, stopping, p, true);
+		SCX_CALL_OP_TASK(stopping, p, true);
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
@@ -3428,8 +3331,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		WARN_ON_ONCE(*ddsp_taskp);
 		*ddsp_taskp = p;
 
-		cpu = SCX_CALL_OP_TASK_RET(SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU,
-					   select_cpu, p, prev_cpu, wake_flags);
+		cpu = SCX_CALL_OP_TASK_RET(select_cpu, p, prev_cpu, wake_flags);
 		p->scx.selected_cpu = cpu;
 		*ddsp_taskp = NULL;
 		if (ops_cpu_valid(cpu, "from ops.select_cpu()"))
@@ -3473,8 +3375,7 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 	 * designation pointless. Cast it away when calling the operation.
 	 */
 	if (SCX_HAS_OP(set_cpumask))
-		SCX_CALL_OP_TASK(SCX_KF_REST, set_cpumask, p,
-				 (struct cpumask *)p->cpus_ptr);
+		SCX_CALL_OP_TASK(set_cpumask, p, (struct cpumask *)p->cpus_ptr);
 }
 
 static void handle_hotplug(struct rq *rq, bool online)
@@ -3487,9 +3388,9 @@ static void handle_hotplug(struct rq *rq, bool online)
 		scx_idle_update_selcpu_topology(&scx_ops);
 
 	if (online && SCX_HAS_OP(cpu_online))
-		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
+		SCX_CALL_OP(cpu_online, cpu);
 	else if (!online && SCX_HAS_OP(cpu_offline))
-		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_offline, cpu);
+		SCX_CALL_OP(cpu_offline, cpu);
 	else
 		scx_ops_exit(SCX_ECODE_ACT_RESTART | SCX_ECODE_RSN_HOTPLUG,
 			     "cpu %d going %s, exiting scheduler", cpu,
@@ -3593,7 +3494,7 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 		curr->scx.slice = 0;
 		touch_core_sched(rq, curr);
 	} else if (SCX_HAS_OP(tick)) {
-		SCX_CALL_OP(SCX_KF_REST, tick, curr);
+		SCX_CALL_OP(tick, curr);
 	}
 
 	if (!curr->scx.slice)
@@ -3670,7 +3571,7 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
 			.fork = fork,
 		};
 
-		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, init_task, p, &args);
+		ret = SCX_CALL_OP_RET(init_task, p, &args);
 		if (unlikely(ret)) {
 			ret = ops_sanitize_err("init_task", ret);
 			return ret;
@@ -3727,11 +3628,11 @@ static void scx_ops_enable_task(struct task_struct *p)
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
@@ -3740,7 +3641,7 @@ static void scx_ops_disable_task(struct task_struct *p)
 	WARN_ON_ONCE(scx_get_task_state(p) != SCX_TASK_ENABLED);
 
 	if (SCX_HAS_OP(disable))
-		SCX_CALL_OP(SCX_KF_REST, disable, p);
+		SCX_CALL_OP(disable, p);
 	scx_set_task_state(p, SCX_TASK_READY);
 }
 
@@ -3769,7 +3670,7 @@ static void scx_ops_exit_task(struct task_struct *p)
 	}
 
 	if (SCX_HAS_OP(exit_task))
-		SCX_CALL_OP(SCX_KF_REST, exit_task, p, &args);
+		SCX_CALL_OP(exit_task, p, &args);
 	scx_set_task_state(p, SCX_TASK_NONE);
 }
 
@@ -3878,7 +3779,7 @@ static void reweight_task_scx(struct rq *rq, struct task_struct *p,
 
 	p->scx.weight = sched_weight_to_cgroup(scale_load_down(lw->weight));
 	if (SCX_HAS_OP(set_weight))
-		SCX_CALL_OP_TASK(SCX_KF_REST, set_weight, p, p->scx.weight);
+		SCX_CALL_OP_TASK(set_weight, p, p->scx.weight);
 }
 
 static void prio_changed_scx(struct rq *rq, struct task_struct *p, int oldprio)
@@ -3894,8 +3795,7 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 	 * different scheduler class. Keep the BPF scheduler up-to-date.
 	 */
 	if (SCX_HAS_OP(set_cpumask))
-		SCX_CALL_OP_TASK(SCX_KF_REST, set_cpumask, p,
-				 (struct cpumask *)p->cpus_ptr);
+		SCX_CALL_OP_TASK(set_cpumask, p, (struct cpumask *)p->cpus_ptr);
 }
 
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
@@ -3987,8 +3887,7 @@ int scx_tg_online(struct task_group *tg)
 			struct scx_cgroup_init_args args =
 				{ .weight = tg->scx_weight };
 
-			ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_init,
-					      tg->css.cgroup, &args);
+			ret = SCX_CALL_OP_RET(cgroup_init, tg->css.cgroup, &args);
 			if (ret)
 				ret = ops_sanitize_err("cgroup_init", ret);
 		}
@@ -4009,7 +3908,7 @@ void scx_tg_offline(struct task_group *tg)
 	percpu_down_read(&scx_cgroup_rwsem);
 
 	if (SCX_HAS_OP(cgroup_exit) && (tg->scx_flags & SCX_TG_INITED))
-		SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_exit, tg->css.cgroup);
+		SCX_CALL_OP(cgroup_exit, tg->css.cgroup);
 	tg->scx_flags &= ~(SCX_TG_ONLINE | SCX_TG_INITED);
 
 	percpu_up_read(&scx_cgroup_rwsem);
@@ -4042,8 +3941,7 @@ int scx_cgroup_can_attach(struct cgroup_taskset *tset)
 			continue;
 
 		if (SCX_HAS_OP(cgroup_prep_move)) {
-			ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_prep_move,
-					      p, from, css->cgroup);
+			ret = SCX_CALL_OP_RET(cgroup_prep_move, p, from, css->cgroup);
 			if (ret)
 				goto err;
 		}
@@ -4056,8 +3954,7 @@ int scx_cgroup_can_attach(struct cgroup_taskset *tset)
 err:
 	cgroup_taskset_for_each(p, css, tset) {
 		if (SCX_HAS_OP(cgroup_cancel_move) && p->scx.cgrp_moving_from)
-			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_cancel_move, p,
-				    p->scx.cgrp_moving_from, css->cgroup);
+			SCX_CALL_OP(cgroup_cancel_move, p, p->scx.cgrp_moving_from, css->cgroup);
 		p->scx.cgrp_moving_from = NULL;
 	}
 
@@ -4075,8 +3972,7 @@ void scx_cgroup_move_task(struct task_struct *p)
 	 * cgrp_moving_from set.
 	 */
 	if (SCX_HAS_OP(cgroup_move) && !WARN_ON_ONCE(!p->scx.cgrp_moving_from))
-		SCX_CALL_OP_TASK(SCX_KF_UNLOCKED, cgroup_move, p,
-			p->scx.cgrp_moving_from, tg_cgrp(task_group(p)));
+		SCX_CALL_OP_TASK(cgroup_move, p, p->scx.cgrp_moving_from, tg_cgrp(task_group(p)));
 	p->scx.cgrp_moving_from = NULL;
 }
 
@@ -4095,8 +3991,7 @@ void scx_cgroup_cancel_attach(struct cgroup_taskset *tset)
 
 	cgroup_taskset_for_each(p, css, tset) {
 		if (SCX_HAS_OP(cgroup_cancel_move) && p->scx.cgrp_moving_from)
-			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_cancel_move, p,
-				    p->scx.cgrp_moving_from, css->cgroup);
+			SCX_CALL_OP(cgroup_cancel_move, p, p->scx.cgrp_moving_from, css->cgroup);
 		p->scx.cgrp_moving_from = NULL;
 	}
 out_unlock:
@@ -4109,8 +4004,7 @@ void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 
 	if (scx_cgroup_enabled && tg->scx_weight != weight) {
 		if (SCX_HAS_OP(cgroup_set_weight))
-			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_set_weight,
-				    tg_cgrp(tg), weight);
+			SCX_CALL_OP(cgroup_set_weight, tg_cgrp(tg), weight);
 		tg->scx_weight = weight;
 	}
 
@@ -4300,7 +4194,7 @@ static void scx_cgroup_exit(void)
 			continue;
 		rcu_read_unlock();
 
-		SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_exit, css->cgroup);
+		SCX_CALL_OP(cgroup_exit, css->cgroup);
 
 		rcu_read_lock();
 		css_put(css);
@@ -4343,8 +4237,7 @@ static int scx_cgroup_init(void)
 			continue;
 		rcu_read_unlock();
 
-		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_init,
-				      css->cgroup, &args);
+		ret = SCX_CALL_OP_RET(cgroup_init, css->cgroup, &args);
 		if (ret) {
 			css_put(css);
 			scx_ops_error("ops.cgroup_init() failed (%d)", ret);
@@ -4840,7 +4733,7 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	}
 
 	if (scx_ops.exit)
-		SCX_CALL_OP(SCX_KF_UNLOCKED, exit, ei);
+		SCX_CALL_OP(exit, ei);
 
 	cancel_delayed_work_sync(&scx_watchdog_work);
 
@@ -5047,7 +4940,7 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
 
 	if (SCX_HAS_OP(dump_task)) {
 		ops_dump_init(s, "    ");
-		SCX_CALL_OP(SCX_KF_REST, dump_task, dctx, p);
+		SCX_CALL_OP(dump_task, dctx, p);
 		ops_dump_exit();
 	}
 
@@ -5094,7 +4987,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 
 	if (SCX_HAS_OP(dump)) {
 		ops_dump_init(&s, "");
-		SCX_CALL_OP(SCX_KF_UNLOCKED, dump, &dctx);
+		SCX_CALL_OP(dump, &dctx);
 		ops_dump_exit();
 	}
 
@@ -5151,7 +5044,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 		used = seq_buf_used(&ns);
 		if (SCX_HAS_OP(dump_cpu)) {
 			ops_dump_init(&ns, "  ");
-			SCX_CALL_OP(SCX_KF_REST, dump_cpu, &dctx, cpu, idle);
+			SCX_CALL_OP(dump_cpu, &dctx, cpu, idle);
 			ops_dump_exit();
 		}
 
@@ -5405,7 +5298,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	cpus_read_lock();
 
 	if (scx_ops.init) {
-		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, init);
+		ret = SCX_CALL_OP_RET(init);
 		if (ret) {
 			ret = ops_sanitize_err("init", ret);
 			cpus_read_unlock();
@@ -6146,9 +6039,6 @@ void __init init_sched_ext_class(void)
  */
 static bool scx_dsq_insert_preamble(struct task_struct *p, u64 enq_flags)
 {
-	if (!scx_kf_allowed(SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
-		return false;
-
 	lockdep_assert_irqs_disabled();
 
 	if (unlikely(!p)) {
@@ -6310,9 +6200,6 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	bool in_balance;
 	unsigned long flags;
 
-	if (!scx_kf_allowed_if_unlocked() && !scx_kf_allowed(SCX_KF_DISPATCH))
-		return false;
-
 	/*
 	 * Can be called from either ops.dispatch() locking this_rq() or any
 	 * context where no rq lock is held. If latter, lock @p's task_rq which
@@ -6395,9 +6282,6 @@ __bpf_kfunc_start_defs();
  */
 __bpf_kfunc u32 scx_bpf_dispatch_nr_slots(void)
 {
-	if (!scx_kf_allowed(SCX_KF_DISPATCH))
-		return 0;
-
 	return scx_dsp_max_batch - __this_cpu_read(scx_dsp_ctx->cursor);
 }
 
@@ -6411,9 +6295,6 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(void)
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 
-	if (!scx_kf_allowed(SCX_KF_DISPATCH))
-		return;
-
 	if (dspc->cursor > 0)
 		dspc->cursor--;
 	else
@@ -6439,9 +6320,6 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id)
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct scx_dispatch_q *dsq;
 
-	if (!scx_kf_allowed(SCX_KF_DISPATCH))
-		return false;
-
 	flush_dispatch_buf(dspc->rq);
 
 	dsq = find_user_dsq(dsq_id);
@@ -6632,9 +6510,6 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
 	struct rq *rq;
 	struct task_struct *p, *n;
 
-	if (!scx_kf_allowed(SCX_KF_CPU_RELEASE))
-		return 0;
-
 	rq = cpu_rq(smp_processor_id());
 	lockdep_assert_rq_held(rq);
 
@@ -7239,7 +7114,7 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p)
 	struct task_group *tg = p->sched_task_group;
 	struct cgroup *cgrp = &cgrp_dfl_root.cgrp;
 
-	if (!scx_kf_allowed_on_arg_tasks(__SCX_KF_RQ_LOCKED, p))
+	if (!scx_kf_allowed_on_arg_tasks(p))
 		goto out;
 
 	cgrp = tg_cgrp(tg);
@@ -7479,10 +7354,6 @@ static int __init scx_init(void)
 	 *
 	 * Some kfuncs are context-sensitive and can only be called from
 	 * specific SCX ops. They are grouped into BTF sets accordingly.
-	 * Unfortunately, BPF currently doesn't have a way of enforcing such
-	 * restrictions. Eventually, the verifier should be able to enforce
-	 * them. For now, register them the same and make each kfunc explicitly
-	 * check using scx_kf_allowed().
 	 */
 	if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_ops_context_sensitive)) ||
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index efb6077810d8..e241935021eb 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -658,7 +658,7 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 	 * managed by put_prev_task_idle()/set_next_task_idle().
 	 */
 	if (SCX_HAS_OP(update_idle) && do_notify && !scx_rq_bypassing(rq))
-		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
+		SCX_CALL_OP(update_idle, cpu_of(rq), idle);
 
 	/*
 	 * Update the idle masks:
@@ -803,9 +803,6 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	if (!check_builtin_idle_enabled())
 		goto prev_cpu;
 
-	if (!scx_kf_allowed(SCX_KF_SELECT_CPU))
-		goto prev_cpu;
-
 #ifdef CONFIG_SMP
 	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, is_idle);
 #endif
-- 
2.39.5


