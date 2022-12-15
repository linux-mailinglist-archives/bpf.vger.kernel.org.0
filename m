Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6331364D5E0
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 05:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiLOEdD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 23:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLOEdB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 23:33:01 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5262A978
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 20:33:00 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so1539896pjd.0
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 20:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJGgsR5AjJSvyBINbFZpBAsobiGp2e7U6Ec1YD5pHH4=;
        b=l5klcS+Trbw02ZCKfqlX9H7JA1KLrjTCqAS8gEP8wp22sGcjjgfRGkw70dPFF2hXcj
         NummEVWmqz7lim99gerSbGTRjqupbFlku08pARLzuIPjb+rLV7YfkntXdbm1mfDdWRJ/
         ze0niHwe16sOGSGEOQDtZRF+gg+AYQVhOn5sSTC47UjobmIQRcM7VGXZqitcT/iJCipB
         bxaKsIXT7roSYkCNyCnqQ3lDAhSCmIU53qum4CMfec0+b63F8014EGUbhmkSm5V2gRoN
         B8QpB/XJv5i2+xzM+CXRU/48ZymjIupNm7B0LyrPseONDfKXcAyDF0DsjYu2oSGB9/3r
         rSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJGgsR5AjJSvyBINbFZpBAsobiGp2e7U6Ec1YD5pHH4=;
        b=XEAeUSwfJt1YpBhxNnwS7sNwIiQA3owKkXE3iz5lwdK0dGe26oLU6kt/Tq5gWgjdnU
         DNcfkrfzpONnqRrweKqq7IqTnmbaQ81m4N8qPIgW3btYBYAg3tZRoquCUdPzpnpRm4Wy
         6uQgSLo49hr8iiVcqZUho6omq5Xyc4enpHLcfk63Wb/5PChUHlWe6Fa6TBpCU+SnhTJg
         H3U18GqPDaV8Yn4t8fP6arZq+svVL+dMgEmFf8b2na7EGJRe9B7uBEren55j/jTTpzCQ
         HXpeN+0IjvCKej2fPEbMtfddJNpGrYSvL+DFun5NzEVwU3VQ/iH56tebV5BZOKazKTdo
         Zsvg==
X-Gm-Message-State: ANoB5plA0M0OdR22eXr132ccGQaNzwUgcPHL0i53aBjM/m4vfM7diMl3
        n+OLAGcn3BFmAYKSn3fjwq++bzsaZQLgKQ==
X-Google-Smtp-Source: AA0mqf5gTYCA3VacnCpylIw7zkYOE+pKzRfzYaevlv6azXI8SS2bLZ5rTaOsxtlBpOnmP65KPl6L4Q==
X-Received: by 2002:a17:90a:6c21:b0:223:1e7d:67e8 with SMTP id x30-20020a17090a6c2100b002231e7d67e8mr9328726pjj.16.1671078779887;
        Wed, 14 Dec 2022 20:32:59 -0800 (PST)
Received: from localhost.localdomain ([111.201.145.40])
        by smtp.gmail.com with ESMTPSA id mv4-20020a17090b198400b0021894e92f82sm2161298pjb.36.2022.12.14.20.32.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Dec 2022 20:32:59 -0800 (PST)
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
Subject: [bpf-next v2 1/2] bpf: add runtime stats, max cost
Date:   Thu, 15 Dec 2022 12:32:16 +0800
Message-Id: <20221215043217.81368-1-xiangxia.m.yue@gmail.com>
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
is there a burst sysload or high cpu usage. This patch introduce
a update stats helper.

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
v2: fix build warning
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

