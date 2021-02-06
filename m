Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A594E311BCE
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 08:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhBFG6u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 01:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhBFG6t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 01:58:49 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4872C06178B
        for <bpf@vger.kernel.org>; Fri,  5 Feb 2021 22:57:50 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id z21so6152410pgj.4
        for <bpf@vger.kernel.org>; Fri, 05 Feb 2021 22:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GeFgiIS108QFV9hV84yFcTcbb108FtwpfWtcwBxJMgc=;
        b=pE6XA2NM58814t2c502ngGwqTrJ93jSyQ2V9A1B+lKrTSP+0b3jFsMNiBKws3/3U/g
         ZKO26uqMjJYfmEZZGo3wf4UPB+oECVoboO8KuPuq5Rwp4HPWfgFPR/7H04Nv+XC8jI9G
         3hf+IhjNmfeJistlj+UDdW7upL+IGOt1r42Y1aF+UZOpNd0a1lWY0TNkWTO3evRRSYE3
         ElbrN5J2KTL58W9RH5Vg4V/TlzhcMs2I2ejEFX2YR+9HOmVlBiLoz8WFizGOc85POLoS
         eUjJLH5bIqq6ljadQ0rczTVi9azbvER6zezREs52TzjLehTqKGepj7RKGf8MYhBPpPNK
         YufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GeFgiIS108QFV9hV84yFcTcbb108FtwpfWtcwBxJMgc=;
        b=DFG1xcCSONgEngg/mXxCpMo0FsJrvTkSZAO5S6VN7SXS4IML8jagIwQ7qGtbYEwsW3
         Mmmc9Jsm0mXlx/MlJ4BQqRft2dNXO9J+1stIjhJJ/CdoG3hrHjhgbnm4Plz/DCISYV+Y
         UagLuVmFyYoSBhLTjRM8pKmUjWmcymRdMo/5zbsc9VW8iI94gY/NYrRet3u5gW9FY8y0
         CvmuGehTCCOSZRa54foJQTrcQ4Y49fmeJMjNFJ/WxDvl26A46FQIo+U3tV0v7gZCuibM
         JTat7vxkWl4gdqOF8IgjcuUhMkGAF6Hia6Gn5HktwjxT4RGjC4Dr0HLQp0FAdsyh+LgR
         Xszg==
X-Gm-Message-State: AOAM530hpgJPUZDYiMrh0+0dOiBI31n1w9kwhTHw1OhjRXHfGL5EGkgU
        NVYVS9ZcnWJwI5SGpVCsv+4=
X-Google-Smtp-Source: ABdhPJyEdORKwjq9L4y0YgrMXnMAciP0J2qpY56leEXMLyoRRmHrXMnqhQifdqfWlscOyMGsLs4CHw==
X-Received: by 2002:a63:eb05:: with SMTP id t5mr7879674pgh.389.1612594670472;
        Fri, 05 Feb 2021 22:57:50 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id r9sm12065093pfq.8.2021.02.05.22.57.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2021 22:57:49 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 5/5] bpf: Count the number of times recursion was prevented
Date:   Fri,  5 Feb 2021 22:57:41 -0800
Message-Id: <20210206065741.59188-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210206065741.59188-1-alexei.starovoitov@gmail.com>
References: <20210206065741.59188-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add per-program counter for number of times recursion prevention mechanism
was triggered and expose it via show_fdinfo and bpf_prog_info.
Teach bpftool to print it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/filter.h         |  1 +
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           | 14 ++++++++++----
 kernel/bpf/trampoline.c        | 18 ++++++++++++++++--
 tools/bpf/bpftool/prog.c       |  5 +++++
 tools/include/uapi/linux/bpf.h |  1 +
 6 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 9927e14ce021..707f86560a43 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -543,6 +543,7 @@ struct bpf_binary_header {
 struct bpf_prog_stats {
 	u64 cnt;
 	u64 nsecs;
+	u64 misses;
 	struct u64_stats_sync syncp;
 } __aligned(2 * sizeof(u64));
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c001766adcbc..c547ad1ffe43 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4501,6 +4501,7 @@ struct bpf_prog_info {
 	__aligned_u64 prog_tags;
 	__u64 run_time_ns;
 	__u64 run_cnt;
+	__u64 recursion_misses;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f7df56a704de..a5b8af378c33 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1731,25 +1731,28 @@ static int bpf_prog_release(struct inode *inode, struct file *filp)
 static void bpf_prog_get_stats(const struct bpf_prog *prog,
 			       struct bpf_prog_stats *stats)
 {
-	u64 nsecs = 0, cnt = 0;
+	u64 nsecs = 0, cnt = 0, misses = 0;
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
 		const struct bpf_prog_stats *st;
 		unsigned int start;
-		u64 tnsecs, tcnt;
+		u64 tnsecs, tcnt, tmisses;
 
 		st = per_cpu_ptr(prog->stats, cpu);
 		do {
 			start = u64_stats_fetch_begin_irq(&st->syncp);
 			tnsecs = st->nsecs;
 			tcnt = st->cnt;
+			tmisses = st->misses;
 		} while (u64_stats_fetch_retry_irq(&st->syncp, start));
 		nsecs += tnsecs;
 		cnt += tcnt;
+		misses += misses;
 	}
 	stats->nsecs = nsecs;
 	stats->cnt = cnt;
+	stats->misses = misses;
 }
 
 #ifdef CONFIG_PROC_FS
@@ -1768,14 +1771,16 @@ static void bpf_prog_show_fdinfo(struct seq_file *m, struct file *filp)
 		   "memlock:\t%llu\n"
 		   "prog_id:\t%u\n"
 		   "run_time_ns:\t%llu\n"
-		   "run_cnt:\t%llu\n",
+		   "run_cnt:\t%llu\n"
+		   "recursion_misses:\t%llu\n",
 		   prog->type,
 		   prog->jited,
 		   prog_tag,
 		   prog->pages * 1ULL << PAGE_SHIFT,
 		   prog->aux->id,
 		   stats.nsecs,
-		   stats.cnt);
+		   stats.cnt,
+		   stats.misses);
 }
 #endif
 
@@ -3438,6 +3443,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	bpf_prog_get_stats(prog, &stats);
 	info.run_time_ns = stats.nsecs;
 	info.run_cnt = stats.cnt;
+	info.recursion_misses = stats.misses;
 
 	if (!bpf_capable()) {
 		info.jited_prog_len = 0;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 226f613ab289..83b77883bd77 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -381,6 +381,16 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	mutex_unlock(&trampoline_mutex);
 }
 
+static void notrace inc_misses_counter(struct bpf_prog *prog)
+{
+	struct bpf_prog_stats *stats;
+
+	stats = this_cpu_ptr(prog->stats);
+	u64_stats_update_begin(&stats->syncp);
+	stats->misses++;
+	u64_stats_update_end(&stats->syncp);
+}
+
 /* The logic is similar to BPF_PROG_RUN, but with an explicit
  * rcu_read_lock() and migrate_disable() which are required
  * for the trampoline. The macro is split into
@@ -396,8 +406,10 @@ u64 notrace __bpf_prog_enter(struct bpf_prog *prog)
 
 	rcu_read_lock();
 	migrate_disable();
-	if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1))
+	if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1)) {
+		inc_misses_counter(prog);
 		return 0;
+	}
 	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
 		start = sched_clock();
 		if (unlikely(!start))
@@ -442,8 +454,10 @@ u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog)
 	rcu_read_lock_trace();
 	migrate_disable();
 	might_fault();
-	if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1))
+	if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1)) {
+		inc_misses_counter(prog);
 		return 0;
+	}
 	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
 		start = sched_clock();
 		if (unlikely(!start))
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 1fe3ba255bad..2e1cd12589c5 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -368,6 +368,8 @@ static void print_prog_header_json(struct bpf_prog_info *info)
 		jsonw_uint_field(json_wtr, "run_time_ns", info->run_time_ns);
 		jsonw_uint_field(json_wtr, "run_cnt", info->run_cnt);
 	}
+	if (info->recursion_misses)
+		jsonw_uint_field(json_wtr, "recursion_misses", info->recursion_misses);
 }
 
 static void print_prog_json(struct bpf_prog_info *info, int fd)
@@ -446,6 +448,9 @@ static void print_prog_header_plain(struct bpf_prog_info *info)
 	if (info->run_time_ns)
 		printf(" run_time_ns %lld run_cnt %lld",
 		       info->run_time_ns, info->run_cnt);
+	if (info->recursion_misses)
+		printf(" recursion_misses %lld",
+		       info->recursion_misses);
 	printf("\n");
 }
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c001766adcbc..c547ad1ffe43 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4501,6 +4501,7 @@ struct bpf_prog_info {
 	__aligned_u64 prog_tags;
 	__u64 run_time_ns;
 	__u64 run_cnt;
+	__u64 recursion_misses;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
-- 
2.24.1

