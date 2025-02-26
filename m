Return-Path: <bpf+bounces-52691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA44A46B21
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 20:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7191888F69
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 19:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0B3248885;
	Wed, 26 Feb 2025 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NyORY6nu"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazolkn19012048.outbound.protection.outlook.com [52.103.33.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66746241688;
	Wed, 26 Feb 2025 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598390; cv=fail; b=MrxS2X2vatyH9RqMZNH8T1/+lT+5LysGo7yq7xN/NzjbHSn+5HAV4aeYlUovMqm7SG+qlUs7uTwidQJjGgnW/J6pLSTDZASClrg2QKLwyuZf7eG8WgMvDzmjRBQgi7heHd/fGwCoH94CUDKtyw7p3tresSHsM4VPPVT7pNZIVW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598390; c=relaxed/simple;
	bh=XsrfMJpgmsn9RyPedTdq59gDV2Uzbf1W0Ie3Y94JG5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fuKLt/DwqF2PMHz1BA/teDv0nKvPFupSVhk0gtYQG/LHvwVlEsODtQk5S6yyORtKeDdzKKKlfEMEbPjsUDM6FYEpeh00OziI/En/USvCBVUYkhnViKrRsUhPTX+ZqYwxAsKlD/RVVsIxmikFcuJJfnjfNnQu9HLN9JMtdyWsPiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NyORY6nu; arc=fail smtp.client-ip=52.103.33.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQ43e/NZcvdENSAAHZUaOGSrTqksbrMCy++Q34SKWi8ewyVhmYcsGAT/vFDBcY5B/6XzYxXeO1MBzOggZoDFPH+MCuZj0YlR4RfF3sk4U2P2sNst42vT5BtzDQLml8ZdozdrchcLiuAk52tPY1mZ5dlkX7UBSswVEllj5TOjdILUgGodKx/DBPsIl7rqO5eGEHBpUjdGIG+esx6Uj/2l2MgCmItu4pMGDPOaev2lNRvo/VMZVzkE3JLRneICXvqfj2GkarOdoV10mMQjELSWHy2PDU0kBf/HMaKBnd4bmFBpKUVPGOl3MenGi4yZKkXjMn/KBI17hwYlPQMwruWZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5p+IAFZYSFBWo6hwL7YB4taBY+9DozD4tTI00KyKf4=;
 b=ygkq4mwRgxK2f6tcWnGcxsXI1bftIeboUgqkonLuViQC1KNJ70A49/DZXkKZxAdWFRH8M0yhG3lLIfaZ0qtsSZc7P03SbBiCXVs5jDcfkgKx+OrPkJ2gjzOJM6yYqB4MaRXkNaOBm40nNjBdjfa8nsIdHB/fWF0xS2VcuAXMsyw/OAazlB/yCUMCNr0XECJrOvDVtRjjAMJS2cawMBz7o7Buf6lCWs9vruvRBwdRxRhllq2/fjSYdntMfzZwVF9l4F0MEhDrvFOS7/d7YYjbYCKzqlhfsMlsXEOx3fOK9Rfn9e7ZJts/D06nWELw3ygPE89wBgShuUQkHzcS8llP3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5p+IAFZYSFBWo6hwL7YB4taBY+9DozD4tTI00KyKf4=;
 b=NyORY6nu8/4aLHQTxlMN0QCSmT1IGcVnUgrmYseEStsBhfDWa0tjlkgOrx0xxGQNTKFiCfR6Tr1NmhLNp63+pBIwD1iIDt0NOHhOIBUkJEtkvO0/4kYcloqQ6ulMg/tJ4sucMEvzYNpL8V2lbivYYhVVGY6lFes6N0RCG5jn2Ilsl6tNzc5SB3PWO5vShMzfdXP3vKZQh2OIXqr6UlqtBCbqHk/vOze7/WRECDGuzfdlv3z/3jm6EdM6Lr3YxsdHE3bhm9sRmj5AQVORWeTLQN8XWWB0ZKmNczHVlR+e/VfDD+H9DMISyFhUGOB1Mz2misZcb5nGLiDA5VLyUdy/+w==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DBBPR03MB7451.eurprd03.prod.outlook.com (2603:10a6:10:20e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 19:33:05 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 19:33:05 +0000
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
Subject: [PATCH sched_ext/for-6.15 v3 3/5] sched_ext: Add scx_kfunc_ids_ops_context_sensitive for unified filtering of context-sensitive SCX kfuncs
Date: Wed, 26 Feb 2025 19:28:18 +0000
Message-ID:
 <AM6PR03MB5080648369E8A4508220133E99C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0349.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::12) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250226192820.156545-3-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DBBPR03MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd22db5-7285-4b0b-185b-08dd569c63f2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|19110799003|8060799006|5072599009|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TGP5BJ3xsk9wBve4CY24WAzl7XjnWM4E9qkK2pcG6gUe11mhE4UphcEXfhsp?=
 =?us-ascii?Q?/JX2GlvcuVGzkFmu8jX32MM3od/coPnNCSDX525i8xEgOy7JgiR5OoyFp+Ea?=
 =?us-ascii?Q?SIWDPMgUkpRMfipPYqTrfoQbaJ41Q8tENFGaGSuC3CHVyALp4zA0+wGKn+RV?=
 =?us-ascii?Q?znqaw1MdGj9dMbTyVrtBskS60GmdAgM6r24pGvFwJ63LINgdvUdPpKIoebar?=
 =?us-ascii?Q?svvqxgFx49mgmbhB+ML1ccdNjhhgXdy4aCAzpoL1rxC/vemFXsiMAzFEtP1e?=
 =?us-ascii?Q?7AJeZnsr5lwmBapAeTphQhIMbgzAGtZHkdutu3KRkXdt5alToQ1SEcxtwAz+?=
 =?us-ascii?Q?VxFCVuL7CYou++9/ukHMfOsjqkDKmM4tXga+oBYGtREN+5wQsrK9sLabcqLu?=
 =?us-ascii?Q?nBSOadfSuwQ9rk3ZYTFcIbNJbgOjTVPxZZQQrXAacuS9uKcK6e4Hrt20KUNu?=
 =?us-ascii?Q?PQvstu+gcm1Tvf5XXYrDtVFCYnBI2oAxBzw3GRnN4SrmF9j+isDXwZPR6Yxq?=
 =?us-ascii?Q?V7Z/+5oEFo6F171kw148J6rAuLPw9NBobemx6ezU1yF4eW7vlcwrvU6CjC0v?=
 =?us-ascii?Q?tBiH3G3Po18862vw1itjPpyGlv7fpypUhxP+UXr6a63qLy2bqrVnqtMwO1rp?=
 =?us-ascii?Q?MMAGw7KW7//4SmitI3l9TVpxzfJQyosGYNpn8/D+0RitgGrAnkS1fJmzt7Wf?=
 =?us-ascii?Q?+00/mrJyyWK67OSgwdDzWjgI4y8N0vNXMOgFa5A0uoilOV/ZOIpi/vutIBW6?=
 =?us-ascii?Q?L/bq7sFRE20kAcuNZ7KrjU++AgZn2R+vsgIRZ+hey0CuSsWN0RSFAfzxhg8j?=
 =?us-ascii?Q?vq6haPB5WGpiVJ3kdNffIvK0iwmFIoxyqvyCBdyftP3oRgF/dMR1Vltee2R6?=
 =?us-ascii?Q?Hi4ruQEFbuckgBycfbcZIveZNcMC6AznbwI4lEu0oIR+p4rjqU6oJyESc6i4?=
 =?us-ascii?Q?Y4I52QxuSNX2++BoBDYFYZ5tpRcYCEl5mox8kC8yz/6FTkTpwxcm5TAs6fCj?=
 =?us-ascii?Q?kb7ALZ7wUC5V8T4O6ZfVBr5PMtij2JFk4sW9m924GsnYAWchFHSbXrWZCK9P?=
 =?us-ascii?Q?0FFDWI0Zctcg6DUrEuN/xEkFTBgBjg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tc7ov+bEKeDPYlwHJxJFPYRd/nkYGbmqHegqv4k3zbUvYRJlkYtT9CvAyWcJ?=
 =?us-ascii?Q?CyIqPMCYoDX3zFQFlzbogM1hCbD6BUuGx9mBiRBczd38JPllvQub2w5yqNAB?=
 =?us-ascii?Q?0k+7VfBCTuSyVfc90XXtBpIM/NAMs90melZMeSl1zxkHITnPJG+fnwQj/Kwo?=
 =?us-ascii?Q?eof6tnIgwy5Z1fQe8nAMViQ+rWdzhp26wmByYla1hn91hoZWHHRHVXNfxRvc?=
 =?us-ascii?Q?6eeLwEhkACt7Nb4+7iDOnjhogsLy74D93KQItCnk1eR+EUOIZL7SMYzR9y/K?=
 =?us-ascii?Q?qdUU2vP1DVR23bJeDryyZJfWYsxsvk3kIzJkGKxaYU+Jy2RoGoiObsUa+bxZ?=
 =?us-ascii?Q?bWtQbtSPrsKblyftXa024u6NPqMrs48ansNKfgoByXJlIw6clSwmx0uAdplI?=
 =?us-ascii?Q?OB5+RR/hKhGgQ/5C0nB5fE0dI9bzuISF5KXbbt6PoWP9O+Bt7qt7vP58A1hg?=
 =?us-ascii?Q?WTGYhQgZS2CqDWcAvzL8oHmu+zazfmVsWZBs0UXKOgGSb7boLtEzZBpiWuk6?=
 =?us-ascii?Q?wZOI0hbR7boM4IH5nNXS9pUFD1z3GfMVhu3C0L70HeMUVt3OZe1qU6xGoen8?=
 =?us-ascii?Q?oPAy2Z9rnc33b00meDPmulUd3a2Pe4w1Z5GIBnIVvq/38iwOrU0aQTrUmtZK?=
 =?us-ascii?Q?rIZUiaD+mTyoz3oDiEU27mArJQAblRRz2hrhA+2jqlGgF8pSTAMbebQ+z1gh?=
 =?us-ascii?Q?ic/2jw/6An29rRYgszoS6vDCCtvhGMqTzb4qbvQjuCb51MhtALdMKwF8hr7Z?=
 =?us-ascii?Q?/fTJ7LwPVNAZtDJK6bxhW4jb48zDH7irXhkK89m3gUiZUrEEqiP7iZhLO/su?=
 =?us-ascii?Q?eMI8XVP7GTIn0zWVOdwtmhLk6ynmbWQmwfG3U6Zoy+nMsWDu8VpIytC/MgOv?=
 =?us-ascii?Q?ozfs10aGr4W+fhslKQR6wbKSM2qWBKblxugtu5z7fHCUNxnPwg+YXqhdtMRD?=
 =?us-ascii?Q?f37xbnq76t1GNCN9PK6PuMxar9Gv2GQ9Tu9dScpC4RJ4CePhZCn8Lq+DDAMG?=
 =?us-ascii?Q?EGsD2+JhSSnigQaaPFasdJ8AuK7iJdAppf9jMeHdoaJBAZUk93WrvTMq8HcX?=
 =?us-ascii?Q?J6OWmJp+67dTzB9Ocf0KlxiWlk/zc3gqYcDxT5ntdxYohSQiJFO+CjgWgNuz?=
 =?us-ascii?Q?N2TolqfSEXwBE1LC4uEawP7LuQQ1u8tjL1Qjzqbaar9BhEfbyJHEeYY7QMFd?=
 =?us-ascii?Q?Z/Q3RnyUXgGA7PDxhN4Xu5htOMbrD/NO17OabVc9P+/Ftb6Ipx+2by/hmKAl?=
 =?us-ascii?Q?n+qcMDokhA0OyInE3oFb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd22db5-7285-4b0b-185b-08dd569c63f2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 19:33:05.0678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7451

This patch adds scx_kfunc_ids_ops_context_sensitive for unified
filtering of context-sensitive SCX kfuncs.

Currently we need to rely on kfunc id sets to group context-sensitive
SCX kfuncs.

If we add filters to each group kfunc id set separately, it will be
cumbersome. A better approach would be to use different kfunc id sets
for grouping purposes and filtering purposes.

scx_kfunc_ids_ops_context_sensitive is a kfunc id set for filtering
purposes, which contains all context-sensitive SCX kfuncs and implements
filtering rules for different contexts in the filter (by searching the
kfunc id sets used for grouping purposes).

Now we only need to register scx_kfunc_ids_ops_context_sensitive, no
longer need to register multiple context-sensitive kfunc id sets.

In addition, this patch adds the SCX_MOFF_IDX macro to facilitate the
calculation of idx based on moff.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/sched/ext.c      | 110 ++++++++++++++++++++++++++++++----------
 kernel/sched/ext_idle.c |   8 +--
 2 files changed, 83 insertions(+), 35 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 15fac968629e..c337f6206ae5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -10,6 +10,7 @@
 #include "ext_idle.h"
 
 #define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
+#define SCX_MOFF_IDX(moff)	(moff / sizeof(void (*)(void)))
 
 enum scx_consts {
 	SCX_DSP_DFL_MAX_BATCH		= 32,
@@ -6300,11 +6301,6 @@ BTF_ID_FLAGS(func, scx_bpf_dispatch, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
 
-static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
-	.owner			= THIS_MODULE,
-	.set			= &scx_kfunc_ids_enqueue_dispatch,
-};
-
 static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 			 struct task_struct *p, u64 dsq_id, u64 enq_flags)
 {
@@ -6620,11 +6616,6 @@ BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_dispatch)
 
-static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
-	.owner			= THIS_MODULE,
-	.set			= &scx_kfunc_ids_dispatch,
-};
-
 __bpf_kfunc_start_defs();
 
 /**
@@ -6687,11 +6678,6 @@ BTF_KFUNCS_START(scx_kfunc_ids_cpu_release)
 BTF_ID_FLAGS(func, scx_bpf_reenqueue_local)
 BTF_KFUNCS_END(scx_kfunc_ids_cpu_release)
 
-static const struct btf_kfunc_id_set scx_kfunc_set_cpu_release = {
-	.owner			= THIS_MODULE,
-	.set			= &scx_kfunc_ids_cpu_release,
-};
-
 __bpf_kfunc_start_defs();
 
 /**
@@ -6724,11 +6710,6 @@ BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
 
-static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
-	.owner			= THIS_MODULE,
-	.set			= &scx_kfunc_ids_unlocked,
-};
-
 __bpf_kfunc_start_defs();
 
 /**
@@ -7370,6 +7351,85 @@ __bpf_kfunc void scx_bpf_events(struct scx_event_stats *events,
 
 __bpf_kfunc_end_defs();
 
+BTF_KFUNCS_START(scx_kfunc_ids_ops_context_sensitive)
+/* scx_kfunc_ids_select_cpu */
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
+/* scx_kfunc_ids_enqueue_dispatch */
+BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dispatch, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime, KF_RCU)
+/* scx_kfunc_ids_dispatch */
+BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local)
+BTF_ID_FLAGS(func, scx_bpf_consume)
+/* scx_kfunc_ids_cpu_release */
+BTF_ID_FLAGS(func, scx_bpf_reenqueue_local)
+/* scx_kfunc_ids_unlocked */
+BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_SLEEPABLE)
+/* Intersection of scx_kfunc_ids_dispatch and scx_kfunc_ids_unlocked */
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_slice)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_vtime)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
+BTF_KFUNCS_END(scx_kfunc_ids_ops_context_sensitive)
+
+extern struct btf_id_set8 scx_kfunc_ids_select_cpu;
+
+static int scx_kfunc_ids_ops_context_sensitive_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	u32 moff, flags;
+
+	if (!btf_id_set8_contains(&scx_kfunc_ids_ops_context_sensitive, kfunc_id))
+		return 0;
+
+	if (prog->type == BPF_PROG_TYPE_SYSCALL &&
+	    btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
+		return 0;
+
+	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
+	    prog->aux->st_ops != &bpf_sched_ext_ops)
+		return 0;
+
+	/* prog->type == BPF_PROG_TYPE_STRUCT_OPS && prog->aux->st_ops == &bpf_sched_ext_ops*/
+
+	moff = prog->aux->attach_st_ops_member_off;
+	flags = scx_ops_context_flags[SCX_MOFF_IDX(moff)];
+
+	if ((flags & SCX_OPS_KF_UNLOCKED) &&
+	    btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
+		return 0;
+
+	if ((flags & SCX_OPS_KF_CPU_RELEASE) &&
+	    btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id))
+		return 0;
+
+	if ((flags & SCX_OPS_KF_DISPATCH) &&
+	    btf_id_set8_contains(&scx_kfunc_ids_dispatch, kfunc_id))
+		return 0;
+
+	if ((flags & SCX_OPS_KF_ENQUEUE) &&
+	    btf_id_set8_contains(&scx_kfunc_ids_enqueue_dispatch, kfunc_id))
+		return 0;
+
+	if ((flags & SCX_OPS_KF_SELECT_CPU) &&
+	    btf_id_set8_contains(&scx_kfunc_ids_select_cpu, kfunc_id))
+		return 0;
+
+	return -EACCES;
+}
+
+static const struct btf_kfunc_id_set scx_kfunc_set_ops_context_sensitive = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_ops_context_sensitive,
+	.filter			= scx_kfunc_ids_ops_context_sensitive_filter,
+};
+
 BTF_KFUNCS_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
@@ -7425,15 +7485,9 @@ static int __init scx_init(void)
 	 * check using scx_kf_allowed().
 	 */
 	if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					     &scx_kfunc_set_enqueue_dispatch)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					     &scx_kfunc_set_dispatch)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					     &scx_kfunc_set_cpu_release)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					     &scx_kfunc_set_unlocked)) ||
+					     &scx_kfunc_set_ops_context_sensitive)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
-					     &scx_kfunc_set_unlocked)) ||
+					     &scx_kfunc_set_ops_context_sensitive)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_any)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index dc40e0baf77c..efb6077810d8 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -1125,17 +1125,11 @@ BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
 BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
 
-static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
-	.owner			= THIS_MODULE,
-	.set			= &scx_kfunc_ids_select_cpu,
-};
-
 int scx_idle_init(void)
 {
 	int ret;
 
-	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_select_cpu) ||
-	      register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_idle) ||
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_idle) ||
 	      register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &scx_kfunc_set_idle) ||
 	      register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &scx_kfunc_set_idle);
 
-- 
2.39.5


