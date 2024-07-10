Return-Path: <bpf+bounces-34427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E2D92D86C
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B95280DFC
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E53519755E;
	Wed, 10 Jul 2024 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Lo+A9YNL"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011079.outbound.protection.outlook.com [52.103.32.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F6119754D;
	Wed, 10 Jul 2024 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636932; cv=fail; b=T8QhO70qcPh5KHSPxsZMJCxVTACCGJ1qvsprgciSZk3+7skpIT1jeuQE7FuACZ55eLoF3TdD5hxHAm++ouAz5HKl1nckMFr4v3qTvCBEVGJO0lrARjw1efaLHYgjsbOFPrVZnNO6MvYk/2pMcOcN5W5VlN2qIxv+LshRi44NQzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636932; c=relaxed/simple;
	bh=SWCAw0vxxBbwypSNpxzrPoVaZe25u4XvQL4Z9MsWc4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DZ2FdC+axwNejNkb+HT0kXf7CsGsSCdRzjn1oRePh1B1A3ObFSll52x1ixA1MplH8EI4Pzlocaajh+bulvzAcln6491VdBZ/LRS4snd8ZddRkDKAC2DWYEb6dliL937YYzaovGjAbm5gZ3srlMoCrwF58CQxkGzlHeAsbZ7p1NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Lo+A9YNL; arc=fail smtp.client-ip=52.103.32.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ie7gFM3l8WmO2FkTSHx8w1QrXJa5GaoEkImPQE78kmKRc2AUF9hwbNTLOoXS1Dysj8W03QQhGam9m5fKOaTu8iT73F2/hJeepUKlqQ0HYYBlhDbiOSkqY+LFkLxJnaFcy9PtPF7Cq6zL1q6uhMZoMVQU/nGtSpz/CC1HjOdnOX0jKqYmHlXaeQSPKTghRQHpZ95CaUSLKc2tvedn/ZA2RQZUQJIoGRo57DpQskTLT6i4JkdHUX25ITq2L49BL/4y+Kj3mqpatVZ1eIiRB/rsoqJPecVBMzzYshPN6JbJuTiItn4fdChR0bKTTTWBnPEcNbufWptLbYrBVvGQs+8WNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUTTySXX7ENbwFzAPBR/n6DwWWoqRqJO0M+cOB8m4iU=;
 b=AvT0zxWn+BfU5UDiR59/KPkwXlteAOChnzkk6O4BVKWhS+HKPWs5Np95E9eAiBdxED4PIgABlgzZQvdAfZportcSbsS7lTToeQCUdblaWWLNegnST1exF/0q1CGuSYRhrds03Rr6C8ozAaJ/HnlxAUuLdUOPO6Y7kChlL8C7GeghS0eEwc2pIIhipfmUtKP8vS+TdyZuYDYXj+IHfEsRBgmUJeaQHNIWLH1QkhjiCFwwaDWz03iSolZU79y/cNHZ4QyTgYIbKH+IQG6u9K1n2NiiD/T1pKfOna9dy2kR+vUY/omRBz+976IDpDTwB9ZHAJ4/GfJSwIC1JwgayZ3AXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUTTySXX7ENbwFzAPBR/n6DwWWoqRqJO0M+cOB8m4iU=;
 b=Lo+A9YNLAHJu96vXRMhatWoSEuja1nkiOxGd9o9fD0V4X6uHYksNMrJ7L+FA8XopgS9ZqD+vk6fWj7gcxJPJVZQEwM3O5G4s2vvQZS8sjZdAkioexKCPgeIsTRN/JfpvljaWMwOEjA0k53/3t16WV7S0AOogRCi9KJcg2JSYVac6mPbWEs2JSEzFcZ9T+k/Ar0XIRPxr2vrLmdmjFVRbLqDpjb7ePvt+tvKxY66dVSAAPZiONLR/XLGjGY/14Bue6o/uA7Yqv8MQpK+JAvlNj4LcsOgYnxSHNDtdpLwH/PIRYH1G/ztxk4IQy9PQqaPz2h2C73eprD8kC7qHXUOLXA==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB9935.eurprd03.prod.outlook.com (2603:10a6:20b:628::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 18:42:07 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 18:42:07 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	andrii@kernel.org,
	avagin@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 01/16] bpf: Introduce BPF_PROG_TYPE_CRIB
Date: Wed, 10 Jul 2024 19:40:45 +0100
Message-ID:
 <AM6PR03MB5848B590781FA283EB58AF3C99A42@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710184100.297261-1-juntong.deng@outlook.com>
References: <20240710184100.297261-1-juntong.deng@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ZW/My4h02Zdb1QbAqkGZIUbHmc3EP8tY]
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240710184100.297261-2-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: c715ea73-2521-45f8-81f8-08dca10fffdf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	CjExa8k0E93/2I25U0gz9kQkeEXUcciw9oEiRRFmiU+HBmrsMr0KHFYBqPMQnr6WBjc+CmcubLMqJ8Hg0rk9O+cjLvrfWNiCvmDYXMCDQl0hiany0iaL94uXM4xRCenRxh2KaBo3mxMKMEv/5jx/Ni6mM2St1H2oWcKWXGwj437RhnI+cz7LqYTppuEjfVHYNT6RVcIfmjEaJRjftXEiBcSELZjBDlvLHuaI22OJR6oWgAQtNtxw1LgCvBeVSCjme3sHVz/Ge1o7GjOPLRmaIl3ee0Oh7ySa/OYQNylPYNBBXjFR3kinORLAHlhAkhwqMilp0CJs4TvtoqwlRXCsab3wFkizRUicui/zOPtvfbMhcS5c5dtNy3U5439cXtJRJLISDU2U+Q1SCTe8UxgszlJhiNRtSJ7otPUPKUTAR1aXvqyZTRIBBA9pvdk73sgX+Z9guSgg9nijBLLfrMskm36alOmHZ65vr7L2cRkMt3SB0gJhE0Qe+YyNR9eiS9E05c6qSYi0LKyCtmGWSRsONp2RUOPc9omaa1ZCfWnTO8+VILU+a7dsHBSJmKIiTTYTJzledpXj4mMduMNthqG/Ufm+zh8TQkq7MKyWiIlhaMJEGCKA2bx4NZCwq4UgyNhsqCQM7tV/JpkXTQOqODA/Nw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7rxffpPUcVKmsXo3xM0CBvYoEUFvYDm6/pk9l6/hiGZ9HO+FbMQLljhQxwB9?=
 =?us-ascii?Q?76NTQr7xT+mlxk77fcR8rg93nxPZCHzpYvJQzziIjUWmS4wuu6jJXpqiic8/?=
 =?us-ascii?Q?zx14/welmu1qVol2FpIUydPYH0Pit+AQYVrNgOdqm49ThFOx/SozzTfBYRQt?=
 =?us-ascii?Q?zqVyt+TtlbyBcEkeRqHRWo5Sb3+1jW/EPBQXlJH7ebEH2y1sXqHBFpPNutKe?=
 =?us-ascii?Q?0hS0aSyvMATOYRqsa+piYT2cifWXiwLeV6Jxg5/JA/gaWGK2nt66xwCxws/C?=
 =?us-ascii?Q?AO5rqOGBFw+zJOxP1x/ik27m2l7TRi6BciP4lmFABi5sPc/rLSfFVg68AySP?=
 =?us-ascii?Q?tMUngNLlr+urBmH8tVSOUtr4zWuoUakABjSpooV1e+a993QvI1PewEts+09C?=
 =?us-ascii?Q?mtRzqOw5ZHCIYGl5PDKXQVXY8DGxbn/ZiUypJI0taLmg3wKPwttdcgh40j8Z?=
 =?us-ascii?Q?4Bu78+S+s4RgDam5HJzntVEV157Vd+LrFvHkH2TiCewjd+NaOjiFqnA02TAA?=
 =?us-ascii?Q?rlQh2uCUBhbI2eT98TC8ObLWOgFdGg167GAXQ4b+ssl88VY4U2Fw4K3fLU5o?=
 =?us-ascii?Q?afvv5iVjgjvkNq3DeuO/TFj725I/zQUpLQrbpH1gOC1JQW2Vw02HLdW/gcTu?=
 =?us-ascii?Q?9/MLenggzNkGG74H8Vb/N4Y8jgodPE8OhFKBDgtojK/5SlYX+4ts/hW+17uG?=
 =?us-ascii?Q?qPAZKbUg/4U419Fo6PsDwGbK8q15zGSNVXDleMD0d2MGHEfdHpnzSmr4Wbmy?=
 =?us-ascii?Q?thHGmHfudmrbkPG3uim5lT3WorfRnNDg1um88TonKqj0FUjDr20Wru2PuFN8?=
 =?us-ascii?Q?z73O4X4sAfpvc7CND7ZEHqFj5Na5sVaanwTutefn3HB2AU9q5EER1Ybl6xRg?=
 =?us-ascii?Q?QQBGEAN/bUBx5xuN6qXSaHF27FmmxNoo677kYCFw1Sh1sK7P2woY60ufioIC?=
 =?us-ascii?Q?YrL2dtY+DdwRb7/mhHyiO0CiDCA/etGLxxKcK3tkQDwEf4HrdQPwvnTDChKr?=
 =?us-ascii?Q?tcbzVy8FsFbA6fc28YYAV1bhHVQ0wsBWab3N8rKw9YxlNwOcHvl+IxNpT9+A?=
 =?us-ascii?Q?ncBgitdi0UwqJklTAEp57/vYLwXsVPkYxC8wU3e8o4hhvYc2e1ebPJeD/V8U?=
 =?us-ascii?Q?g+AsZHa5mAZXahv3THanyN3D6j6brpVaFbIdkLb4f20HDwqR/RWO7+vRMXF8?=
 =?us-ascii?Q?w8RY2go0dIsJ1G3JAYNs+Lapbww46PlqFFLowytVMOIJ16+8Q5QgIT0sxiU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c715ea73-2521-45f8-81f8-08dca10fffdf
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:42:07.1591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9935

This patch adds a new BPF program type CRIB (Checkpoint/Restore In eBPF)
for checkpointing/restoring processes through eBPF.

CRIB BPF programs are not attached to any hooks, run through
BPF_PROG_RUN, and are called by userspace programs as eBPF APIs
for dumping/restoring process information.

CRIB BPF programs dump/restore process information through CRIB
kfunc APIs.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/bpf_crib.h         |  16 +++++
 include/linux/bpf_types.h        |   4 ++
 include/uapi/linux/bpf.h         |   1 +
 kernel/bpf/Kconfig               |   2 +
 kernel/bpf/Makefile              |   2 +
 kernel/bpf/btf.c                 |   4 ++
 kernel/bpf/crib/Kconfig          |  14 ++++
 kernel/bpf/crib/Makefile         |   3 +
 kernel/bpf/crib/bpf_checkpoint.c |  13 ++++
 kernel/bpf/crib/bpf_crib.c       | 109 +++++++++++++++++++++++++++++++
 kernel/bpf/crib/bpf_restore.c    |  13 ++++
 kernel/bpf/helpers.c             |   1 +
 kernel/bpf/syscall.c             |   1 +
 tools/include/uapi/linux/bpf.h   |   1 +
 tools/lib/bpf/libbpf.c           |   2 +
 tools/lib/bpf/libbpf_probes.c    |   1 +
 16 files changed, 187 insertions(+)
 create mode 100644 include/linux/bpf_crib.h
 create mode 100644 kernel/bpf/crib/Kconfig
 create mode 100644 kernel/bpf/crib/Makefile
 create mode 100644 kernel/bpf/crib/bpf_checkpoint.c
 create mode 100644 kernel/bpf/crib/bpf_crib.c
 create mode 100644 kernel/bpf/crib/bpf_restore.c

diff --git a/include/linux/bpf_crib.h b/include/linux/bpf_crib.h
new file mode 100644
index 000000000000..f667b740fcc2
--- /dev/null
+++ b/include/linux/bpf_crib.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Checkpoint/Restore In eBPF (CRIB)
+ *
+ * Author:
+ *	Juntong Deng <juntong.deng@outlook.com>
+ */
+#ifndef _BPF_CRIB_H
+#define _BPF_CRIB_H
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/filter.h>
+
+#endif /* _BPF_CRIB_H */
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 9f2a6b83b49e..a6feddfd17e2 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -83,6 +83,10 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_SYSCALL, bpf_syscall,
 BPF_PROG_TYPE(BPF_PROG_TYPE_NETFILTER, netfilter,
 	      struct bpf_nf_ctx, struct bpf_nf_ctx)
 #endif
+#ifdef CONFIG_BPF_CRIB
+BPF_PROG_TYPE(BPF_PROG_TYPE_CRIB, bpf_crib,
+	      void *, void *)
+#endif /* CONFIG_BPF_CRIB */
 
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_ARRAY, percpu_array_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 35bcf52dbc65..cb67a9cad8c6 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1055,6 +1055,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	BPF_PROG_TYPE_CRIB,
 	__MAX_BPF_PROG_TYPE
 };
 
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 17067dcb4386..a129677a03e3 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -101,4 +101,6 @@ config BPF_LSM
 
 	  If you are unsure how to answer this question, answer N.
 
+source "kernel/bpf/crib/Kconfig"
+
 endmenu # "BPF subsystem"
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 0291eef9ce92..8c350d159d3c 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -58,3 +58,5 @@ vpath %.c $(srctree)/kernel/bpf:$(srctree)/tools/lib/bpf
 
 $(obj)/%.o: %.c FORCE
 	$(call if_changed_rule,cc_o_c)
+
+obj-$(CONFIG_BPF_CRIB) += crib/
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4ff11779699e..306349ee3d6a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -219,6 +219,7 @@ enum btf_kfunc_hook {
 	BTF_KFUNC_HOOK_LWT,
 	BTF_KFUNC_HOOK_NETFILTER,
 	BTF_KFUNC_HOOK_KPROBE,
+	BTF_KFUNC_HOOK_CRIB,
 	BTF_KFUNC_HOOK_MAX,
 };
 
@@ -6037,6 +6038,7 @@ static int btf_validate_prog_ctx_type(struct bpf_verifier_log *log, const struct
 	case BPF_PROG_TYPE_TRACEPOINT:
 	case BPF_PROG_TYPE_SYSCALL:
 	case BPF_PROG_TYPE_EXT:
+	case BPF_PROG_TYPE_CRIB:
 		return 0; /* anything goes */
 	default:
 		break;
@@ -8326,6 +8328,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 		return BTF_KFUNC_HOOK_NETFILTER;
 	case BPF_PROG_TYPE_KPROBE:
 		return BTF_KFUNC_HOOK_KPROBE;
+	case BPF_PROG_TYPE_CRIB:
+		return BTF_KFUNC_HOOK_CRIB;
 	default:
 		return BTF_KFUNC_HOOK_MAX;
 	}
diff --git a/kernel/bpf/crib/Kconfig b/kernel/bpf/crib/Kconfig
new file mode 100644
index 000000000000..346304f65db6
--- /dev/null
+++ b/kernel/bpf/crib/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config BPF_CRIB
+	bool "Checkpoint/Restore In eBPF (CRIB)"
+	depends on BPF_SYSCALL
+	depends on BPF_JIT
+	depends on DEBUG_INFO_BTF
+	help
+	  Enable CRIB (Checkpoint/Restore In eBPF), which allows
+	  checkpointing/restoring of processes through BPF programs.
+
+	  Compared to procfs and system call interfaces, CRIB achieves
+	  higher performance and supports dumping/restoring more
+	  comprehensive process status information.
diff --git a/kernel/bpf/crib/Makefile b/kernel/bpf/crib/Makefile
new file mode 100644
index 000000000000..abd43c76140b
--- /dev/null
+++ b/kernel/bpf/crib/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_BPF_CRIB) += bpf_crib.o bpf_checkpoint.o bpf_restore.o
diff --git a/kernel/bpf/crib/bpf_checkpoint.c b/kernel/bpf/crib/bpf_checkpoint.c
new file mode 100644
index 000000000000..efaca6bcdfe4
--- /dev/null
+++ b/kernel/bpf/crib/bpf_checkpoint.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Checkpoint/Restore In eBPF (CRIB): Checkpoint
+ *
+ * Author:
+ *	Juntong Deng <juntong.deng@outlook.com>
+ */
+
+#include <linux/bpf_crib.h>
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc_end_defs();
diff --git a/kernel/bpf/crib/bpf_crib.c b/kernel/bpf/crib/bpf_crib.c
new file mode 100644
index 000000000000..9ef2d61955bf
--- /dev/null
+++ b/kernel/bpf/crib/bpf_crib.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Checkpoint/Restore In eBPF (CRIB): Common
+ *
+ * Author:
+ *	Juntong Deng <juntong.deng@outlook.com>
+ */
+
+#include <linux/bpf_crib.h>
+#include <linux/init.h>
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_crib_kfuncs)
+
+BTF_KFUNCS_END(bpf_crib_kfuncs)
+
+static int bpf_prog_run_crib(struct bpf_prog *prog,
+			      const union bpf_attr *kattr,
+			      union bpf_attr __user *uattr)
+{
+	void __user *ctx_in = u64_to_user_ptr(kattr->test.ctx_in);
+	__u32 ctx_size_in = kattr->test.ctx_size_in;
+	void *ctx = NULL;
+	u32 retval;
+	int err = 0;
+
+	/* doesn't support data_in/out, ctx_out, duration, or repeat or flags */
+	if (kattr->test.data_in || kattr->test.data_out ||
+	    kattr->test.ctx_out || kattr->test.duration ||
+	    kattr->test.repeat || kattr->test.flags ||
+	    kattr->test.batch_size)
+		return -EINVAL;
+
+	if (ctx_size_in < prog->aux->max_ctx_offset ||
+	    ctx_size_in > U16_MAX)
+		return -EINVAL;
+
+	if (ctx_size_in) {
+		ctx = memdup_user(ctx_in, ctx_size_in);
+		if (IS_ERR(ctx))
+			return PTR_ERR(ctx);
+	}
+
+	rcu_read_lock_trace();
+	retval = bpf_prog_run_pin_on_cpu(prog, ctx);
+	rcu_read_unlock_trace();
+
+	if (copy_to_user(&uattr->test.retval, &retval, sizeof(u32))) {
+		err = -EFAULT;
+		goto out;
+	}
+out:
+	if (ctx_size_in)
+		kfree(ctx);
+
+	return err;
+}
+
+static const struct bpf_func_proto *
+bpf_crib_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	default:
+		return bpf_base_func_proto(func_id, prog);
+	}
+}
+
+static bool bpf_crib_is_valid_access(int off, int size,
+					 enum bpf_access_type type,
+					 const struct bpf_prog *prog,
+					 struct bpf_insn_access_aux *info)
+{
+	/*
+	 * Changing the context is not allowed, and all dumped data
+	 * is returned to userspace via ringbuf.
+	 */
+	if (type != BPF_READ)
+		return false;
+	if (off < 0 || off >= U16_MAX)
+		return false;
+	if (off % size != 0)
+		return false;
+
+	return true;
+}
+
+const struct bpf_prog_ops bpf_crib_prog_ops = {
+	.test_run = bpf_prog_run_crib,
+};
+
+const struct bpf_verifier_ops bpf_crib_verifier_ops = {
+	.get_func_proto		= bpf_crib_func_proto,
+	.is_valid_access	= bpf_crib_is_valid_access,
+};
+
+static const struct btf_kfunc_id_set bpf_crib_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_crib_kfuncs,
+};
+
+static int __init bpf_crib_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_CRIB, &bpf_crib_kfunc_set);
+}
+
+late_initcall(bpf_crib_init);
diff --git a/kernel/bpf/crib/bpf_restore.c b/kernel/bpf/crib/bpf_restore.c
new file mode 100644
index 000000000000..6bbb4b01e34b
--- /dev/null
+++ b/kernel/bpf/crib/bpf_restore.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Checkpoint/Restore In eBPF (CRIB): Restore
+ *
+ * Author:
+ *	Juntong Deng <juntong.deng@outlook.com>
+ */
+
+#include <linux/bpf_crib.h>
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc_end_defs();
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5241ba671c5a..bcd3ce9da00c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2986,6 +2986,7 @@ static int __init kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CRIB, &generic_kfunc_set);
 	ret = ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
 						  ARRAY_SIZE(generic_dtors),
 						  THIS_MODULE);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0719192a3482..faf99e53d706 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2633,6 +2633,7 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 		return -EINVAL;
 	case BPF_PROG_TYPE_SYSCALL:
 	case BPF_PROG_TYPE_EXT:
+	case BPF_PROG_TYPE_CRIB:
 		if (expected_attach_type)
 			return -EINVAL;
 		fallthrough;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 35bcf52dbc65..cb67a9cad8c6 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1055,6 +1055,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	BPF_PROG_TYPE_CRIB,
 	__MAX_BPF_PROG_TYPE
 };
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 30f121754d83..4e1451901b7d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -224,6 +224,7 @@ static const char * const prog_type_name[] = {
 	[BPF_PROG_TYPE_SK_LOOKUP]		= "sk_lookup",
 	[BPF_PROG_TYPE_SYSCALL]			= "syscall",
 	[BPF_PROG_TYPE_NETFILTER]		= "netfilter",
+	[BPF_PROG_TYPE_CRIB]			= "crib",
 };
 
 static int __base_pr(enum libbpf_print_level level, const char *format,
@@ -9449,6 +9450,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("struct_ops.s+",	STRUCT_OPS, 0, SEC_SLEEPABLE),
 	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE),
 	SEC_DEF("netfilter",		NETFILTER, BPF_NETFILTER, SEC_NONE),
+	SEC_DEF("crib",			CRIB, 0, SEC_NONE),
 };
 
 int libbpf_register_prog_handler(const char *sec,
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9dfbe7750f56..2e087280c5f0 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -180,6 +180,7 @@ static int probe_prog_load(enum bpf_prog_type prog_type,
 	case BPF_PROG_TYPE_SK_REUSEPORT:
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_CRIB:
 		break;
 	case BPF_PROG_TYPE_NETFILTER:
 		opts.expected_attach_type = BPF_NETFILTER;
-- 
2.39.2


