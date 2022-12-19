Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058E66507DD
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 07:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiLSGrJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 01:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiLSGqu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 01:46:50 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D74EDEF7
        for <bpf@vger.kernel.org>; Sun, 18 Dec 2022 22:44:52 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id m4so8109710pls.4
        for <bpf@vger.kernel.org>; Sun, 18 Dec 2022 22:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=74r6/OFw2o+y3LmvB17ImA1vks0iJdTpJFuHNLqCbh4=;
        b=J/aLItQgYDm0UhSe9+LoR6MHpHGo6TtrCt6eYccdndcpzqRnZFwz1lihHgGKskmIBf
         QG7UHh03l2j1/sOg32u+5xZkhL1Qvhm/gYx3SlvEwXah84fH627CsPM2Vvc8y+aZZgPW
         8Po1jdUwkhHBmcGd8qvtkL8ZzW6WhaeLQZWakF3lfTqxQ/M6pjaJ0EwcyUd8IhyKMwMS
         AU93dLZiPa7QHbKNWa3UdclQn6szOtTdC/FPDBx44W/YWbQs/nxinl957SY01vq3rk1J
         pSCwFtDL6mixi9gXwgLBLkg7j4qzsTcxwXrqR43NpiCYj5fpzovRvhI4bZCxLo26wEUQ
         qBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74r6/OFw2o+y3LmvB17ImA1vks0iJdTpJFuHNLqCbh4=;
        b=GvLbGjTe9s0dZJnzu8s4Y7ugm7VNMp2cGDp8e3nL8VTffD6ml6XpoPMmTW7Er4nW+f
         m3fHYLND9uB7iIquMtXJBXaGGf08OFPcl0ybTSVr48oXesy3xPYL8FHlFEjRGqdWqbaI
         639dmpmrKlAOn5VPvp5FG+Z9/zoZ72xgfKocyEdqw9WXPjpva7X24OQMpGIkAdPpXxoa
         oyQ2ylktnkrO96EAgqh5u6tI7Jq/PtUC1R1Aj0WQP/JOTt+a1+FC0yEDNNgmvrfoBVTC
         gcs2QLXMgB9PA4N72vRlJZqx9V59kwc1omCzfnwxsSd8+/oviPT6CtUAF8iQgNRx588o
         RrVQ==
X-Gm-Message-State: ANoB5plvQMo0+uYE9cPkS5Kx6I9HQfiJgDwFfVhrZjqHlXbabZoKvkMD
        Ig1B/EZP3yiZ9aXKvEWXFornYSDooieveaoV
X-Google-Smtp-Source: AA0mqf4vmHvzGdbj+T92o6e+xzCwpd/4CzoqhvKi9Odt+HLlBW2VabmR2XTkB4pCkDQvBA4gEbFOIQ==
X-Received: by 2002:a17:903:22c5:b0:189:f708:9b67 with SMTP id y5-20020a17090322c500b00189f7089b67mr57978250plg.46.1671432291402;
        Sun, 18 Dec 2022 22:44:51 -0800 (PST)
Received: from localhost.localdomain ([1.202.165.115])
        by smtp.gmail.com with ESMTPSA id jf14-20020a170903268e00b00189a50d2a3esm6146641plb.241.2022.12.18.22.44.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Dec 2022 22:44:50 -0800 (PST)
From:   xiangxia.m.yue@gmail.com
To:     bpf@vger.kernel.org
Cc:     Tonghao Zhang <xiangxia.m.yue@gmail.com>,
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
Subject: [bpf-next v3 1/2] bpf: add runtime stats, max cost
Date:   Mon, 19 Dec 2022 14:44:27 +0800
Message-Id: <20221219064428.71784-1-xiangxia.m.yue@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

Now user can enable sysctl kernel.bpf_stats_enabled to fetch
run_time_ns and run_cnt. It's easy to calculate the average value.

In some case, the max cost for bpf prog invoked, are more useful:
is there a burst sysload or high cpu usage:

* If prog invoked frequently(run_cnt may be too large), run_time_ns/run_cnt
  is not ideal to indicate a bpf prog cpu burst. And syscall frequently
  may consume a lot of CPU cycles.
* This also help us to debug bpf prog, the cost is what we want?
  if not, there may be an issue in bpf prog.

This patch introduce a update stats helper.

$ bpftool --json --pretty p s
   ...
   "run_max_cost_ns": 313367

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
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
 include/linux/filter.h   | 29 ++++++++++++++++++++++-------
 include/uapi/linux/bpf.h |  1 +
 kernel/bpf/syscall.c     | 10 +++++++++-
 kernel/bpf/trampoline.c  | 10 +---------
 4 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index bf701976056e..886b65fcd4ac 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -556,6 +556,7 @@ struct bpf_prog_stats {
 	u64_stats_t cnt;
 	u64_stats_t nsecs;
 	u64_stats_t misses;
+	u64_stats_t max_cost;
 	struct u64_stats_sync syncp;
 } __aligned(2 * sizeof(u64));
 
@@ -578,6 +579,26 @@ typedef unsigned int (*bpf_dispatcher_fn)(const void *ctx,
 					  unsigned int (*bpf_func)(const void *,
 								   const struct bpf_insn *));
 
+static inline void bpf_prog_update_stats(const struct bpf_prog *prog, u64 start)
+{
+	struct bpf_prog_stats *stats;
+	unsigned long flags;
+	u64 run_time, max_cost;
+
+	stats = this_cpu_ptr(prog->stats);
+	flags = u64_stats_update_begin_irqsave(&stats->syncp);
+
+	run_time =  sched_clock() - start;
+	u64_stats_inc(&stats->cnt);
+	u64_stats_add(&stats->nsecs, run_time);
+
+	max_cost = u64_stats_read(&stats->max_cost);
+	if (max_cost < run_time)
+		u64_stats_set(&stats->max_cost, run_time);
+
+	u64_stats_update_end_irqrestore(&stats->syncp, flags);
+}
+
 static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 					  const void *ctx,
 					  bpf_dispatcher_fn dfunc)
@@ -586,16 +607,10 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 
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
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 464ca3f01fe7..da4d1f2d7bc2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6259,6 +6259,7 @@ struct bpf_prog_info {
 	__u32 verified_insns;
 	__u32 attach_btf_obj_id;
 	__u32 attach_btf_id;
+	__u64 run_max_cost_ns;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 64131f88c553..06439b09863d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2105,6 +2105,7 @@ struct bpf_prog_kstats {
 	u64 nsecs;
 	u64 cnt;
 	u64 misses;
+	u64 max_cost;
 };
 
 void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog)
@@ -2122,12 +2123,13 @@ static void bpf_prog_get_stats(const struct bpf_prog *prog,
 			       struct bpf_prog_kstats *stats)
 {
 	u64 nsecs = 0, cnt = 0, misses = 0;
+	u64 max_cost = 0;
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
 		const struct bpf_prog_stats *st;
 		unsigned int start;
-		u64 tnsecs, tcnt, tmisses;
+		u64 tnsecs, tcnt, tmisses, tmax_cost;
 
 		st = per_cpu_ptr(prog->stats, cpu);
 		do {
@@ -2135,14 +2137,17 @@ static void bpf_prog_get_stats(const struct bpf_prog *prog,
 			tnsecs = u64_stats_read(&st->nsecs);
 			tcnt = u64_stats_read(&st->cnt);
 			tmisses = u64_stats_read(&st->misses);
+			tmax_cost = u64_stats_read(&st->max_cost);
 		} while (u64_stats_fetch_retry(&st->syncp, start));
 		nsecs += tnsecs;
 		cnt += tcnt;
 		misses += tmisses;
+		max_cost = max(max_cost, tmax_cost);
 	}
 	stats->nsecs = nsecs;
 	stats->cnt = cnt;
 	stats->misses = misses;
+	stats->max_cost = max_cost;
 }
 
 #ifdef CONFIG_PROC_FS
@@ -2162,6 +2167,7 @@ static void bpf_prog_show_fdinfo(struct seq_file *m, struct file *filp)
 		   "prog_id:\t%u\n"
 		   "run_time_ns:\t%llu\n"
 		   "run_cnt:\t%llu\n"
+		   "run_max_cost_ns:\t%llu\n"
 		   "recursion_misses:\t%llu\n"
 		   "verified_insns:\t%u\n",
 		   prog->type,
@@ -2171,6 +2177,7 @@ static void bpf_prog_show_fdinfo(struct seq_file *m, struct file *filp)
 		   prog->aux->id,
 		   stats.nsecs,
 		   stats.cnt,
+		   stats.max_cost,
 		   stats.misses,
 		   prog->aux->verified_insns);
 }
@@ -3962,6 +3969,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	info.run_time_ns = stats.nsecs;
 	info.run_cnt = stats.cnt;
 	info.recursion_misses = stats.misses;
+	info.run_max_cost_ns = stats.max_cost;
 
 	info.verified_insns = prog->aux->verified_insns;
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index d6395215b849..4ddad462562e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -882,8 +882,6 @@ static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tram
 static void notrace update_prog_stats(struct bpf_prog *prog,
 				      u64 start)
 {
-	struct bpf_prog_stats *stats;
-
 	if (static_branch_unlikely(&bpf_stats_enabled_key) &&
 	    /* static_key could be enabled in __bpf_prog_enter*
 	     * and disabled in __bpf_prog_exit*.
@@ -891,13 +889,7 @@ static void notrace update_prog_stats(struct bpf_prog *prog,
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

