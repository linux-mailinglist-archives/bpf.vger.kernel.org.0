Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DEF6899D2
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 14:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjBCNdv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 08:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjBCNdu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 08:33:50 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACEA1EFF3
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 05:32:57 -0800 (PST)
X-QQ-mid: bizesmtp75t1675431155tjo08yhf
Received: from localhost.localdomain ( [1.202.165.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 03 Feb 2023 21:32:31 +0800 (CST)
X-QQ-SSF: 0100000000000090B000000A0000000
X-QQ-FEAT: ZdHcY4j9T+JcqsNB2vzwk6maPH5wAUQFi6zGdXPGqG7bee2HGhzfmWgkcPIVq
        CETxzRqQX9365W2Onna9+urzBbYvC42B6PxDZYKTBa6wTAk9+EM89I1t5YrVM3TxVZ+Yj4G
        EkYZwMIOHO6gM0O0IMCHiG2N+1qPfqEK2sc6aPNUVH7Vu4uuYGI18cGhVejObm0gBdWuVs7
        LH3HsFPEXkzhQvmBJWLKGEMCvZx0bKLYXld5oDHSGcTPnhb/SzDPx+SHCkwc4kcqcE/lgna
        I3mH/Fbh981RRG4hB4qnImKWoaxBv33VKU/unD/FLWdd6yDJHkwvHfcOJn8Bz2GZywH1zHD
        BiM1BJ8hi9NJcIu+hceBMuCaHUrB1XR/RTXyKsJ
X-QQ-GoodBg: 0
From:   tong@infragraf.org
To:     bpf@vger.kernel.org
Cc:     Tonghao Zhang <tong@infragraf.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [bpf-next v1] bpf: introduce stats update helper
Date:   Fri,  3 Feb 2023 21:32:20 +0800
Message-Id: <20230203133220.48919-1-tong@infragraf.org>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:infragraf.org:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Tonghao Zhang <tong@infragraf.org>

This patch introduce a stats update helper to simplify codes.

Signed-off-by: Tonghao Zhang <tong@infragraf.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Hou Tao <houtao1@huawei.com>
---
 include/linux/filter.h  | 22 +++++++++++++++-------
 kernel/bpf/trampoline.c | 10 +---------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 1727898f1641..582dfe1188e8 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -579,6 +579,20 @@ typedef unsigned int (*bpf_dispatcher_fn)(const void *ctx,
 					  unsigned int (*bpf_func)(const void *,
 								   const struct bpf_insn *));
 
+static inline void bpf_prog_update_stats(const struct bpf_prog *prog, u64 start)
+{
+	struct bpf_prog_stats *stats;
+	unsigned long flags;
+
+	stats = this_cpu_ptr(prog->stats);
+	flags = u64_stats_update_begin_irqsave(&stats->syncp);
+
+	u64_stats_inc(&stats->cnt);
+	u64_stats_add(&stats->nsecs, sched_clock() - start);
+
+	u64_stats_update_end_irqrestore(&stats->syncp, flags);
+}
+
 static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 					  const void *ctx,
 					  bpf_dispatcher_fn dfunc)
@@ -587,16 +601,10 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 
 	cant_migrate();
 	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
-		struct bpf_prog_stats *stats;
 		u64 start = sched_clock();
-		unsigned long flags;
 
 		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
-		stats = this_cpu_ptr(prog->stats);
-		flags = u64_stats_update_begin_irqsave(&stats->syncp);
-		u64_stats_inc(&stats->cnt);
-		u64_stats_add(&stats->nsecs, sched_clock() - start);
-		u64_stats_update_end_irqrestore(&stats->syncp, flags);
+		bpf_prog_update_stats(prog, start);
 	} else {
 		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
 	}
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index d0ed7d6f5eec..07bc7c9a18d5 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -885,8 +885,6 @@ static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tram
 static void notrace update_prog_stats(struct bpf_prog *prog,
 				      u64 start)
 {
-	struct bpf_prog_stats *stats;
-
 	if (static_branch_unlikely(&bpf_stats_enabled_key) &&
 	    /* static_key could be enabled in __bpf_prog_enter*
 	     * and disabled in __bpf_prog_exit*.
@@ -894,13 +892,7 @@ static void notrace update_prog_stats(struct bpf_prog *prog,
 	     * Hence check that 'start' is valid.
 	     */
 	    start > NO_START_TIME) {
-		unsigned long flags;
-
-		stats = this_cpu_ptr(prog->stats);
-		flags = u64_stats_update_begin_irqsave(&stats->syncp);
-		u64_stats_inc(&stats->cnt);
-		u64_stats_add(&stats->nsecs, sched_clock() - start);
-		u64_stats_update_end_irqrestore(&stats->syncp, flags);
+		bpf_prog_update_stats(prog, start);
 	}
 }
 
-- 
2.27.0

