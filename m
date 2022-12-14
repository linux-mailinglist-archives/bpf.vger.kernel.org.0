Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC26264CC1E
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 15:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbiLNO0L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 09:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238269AbiLNO0K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 09:26:10 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D362036B
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 06:26:06 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so7189652pjj.4
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 06:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YDDulVS0weavGd0rJEW7T5un8kCL2junQDBKezBqRVE=;
        b=FDE30ZAdVp6FSg6fMiTsOeK6bYlZykSbfO641Dr4JABsoYNTv6x+KbD1JVPQFpLMAX
         taKYhdPrdDjYE6WUD4NxrxXbyqvLcOuZJngceHkkP4ytzJWOzCpFCTqVwSUZStkjwe6c
         LwzaNBZEtEnlLwh64ckFunmex+kScY/YT9lRtv5EwXZLr1m7dy2n+9Y2kjwXurqqoqH1
         0MaToHpQRSZtVPYKacHe8xnfzpOBJmoGnvmsa1un/ywxUxcz2hrt8w8MSOd1Ad9mDmSx
         HcuqMvdOCGaL+fhnNxPe8CU+/xN2fP10HZrdpe32dp6CAN3Q2RZVamhGJM90yWS/fxe9
         t2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDDulVS0weavGd0rJEW7T5un8kCL2junQDBKezBqRVE=;
        b=heO7tUbRysw/sBr8yWGzxsHkQzPpLYmcQiKO4b3eBt1EBs8MRqbaT1FUZXiZ1OQhXW
         aF9ewWX160/MH2ZoCXJo1WwShphnV4fIE9lZD0YUvPcBsckhfURAvgtx8et3xM4HtV6t
         9Enru63dRYpaslrOAhbNxz4zVFcPRHe+IQsyeuNkRVO33+QttxGDJcoeH4IS/acibahj
         XpuTFjnfkapuKb7uICf0jZHP0t9PsIbXl67lV729VzEgUjYk9Q80+cV69QJ1PycCKAtm
         h8vZfto0t7L+qKfcvNYUa2B8c7kEM364+q/cK7AoleZNywEm0YvsF38+PvLvjecJU2ae
         kZTg==
X-Gm-Message-State: ANoB5pn0DCargKhVuSHImXyMpNhjGq3L/q5Kuzht9/fF7vAlH8iEuks4
        zBbmH3Myn8U6rujU2FSj7MGDDMnastAHvw==
X-Google-Smtp-Source: AA0mqf4dbsDnXY7e8dlMNPQ3kPNu4dMoyv1vC4+SKa81gY516XfG+4LtINJi3m4YmQAlt6QxZuAVbQ==
X-Received: by 2002:a17:903:240c:b0:188:9806:2e2b with SMTP id e12-20020a170903240c00b0018898062e2bmr25455088plo.35.1671027965277;
        Wed, 14 Dec 2022 06:26:05 -0800 (PST)
Received: from localhost.localdomain ([111.201.145.40])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090341c400b00187033cac81sm1942915ple.145.2022.12.14.06.26.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Dec 2022 06:26:04 -0800 (PST)
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
Subject: [bpf-next 1/2] bpf: add runtime stats, max cost
Date:   Wed, 14 Dec 2022 22:25:38 +0800
Message-Id: <20221214142539.73650-1-xiangxia.m.yue@gmail.com>
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
 include/linux/filter.h   | 29 ++++++++++++++++++++++-------
 include/uapi/linux/bpf.h |  1 +
 kernel/bpf/syscall.c     | 10 +++++++++-
 kernel/bpf/trampoline.c  |  8 +-------
 4 files changed, 33 insertions(+), 15 deletions(-)

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
index d6395215b849..0251b02a7645 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -891,13 +891,7 @@ static void notrace update_prog_stats(struct bpf_prog *prog,
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

