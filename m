Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D937315830
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 22:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhBIU5e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 15:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhBIUtj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 15:49:39 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE2FC061A2D
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 11:49:06 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o21so11746937pgn.12
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 11:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IKtlYY7iR2yjt3dZ8Xi+Wen7V2BC8t7LgAPTs1+bl/g=;
        b=CjTkfUZMkSO7fS7idyoNsQ9S5aBwcQVFTQ5o0ShAaBLfE+jBrq5//5yUd4kjTXlXSl
         +YYF8KDjzJyEbJqMwR7WPGrtfmak3ZZljGoW6yz9qWbmKql0nxIdV2pQ/hHpEyv/R1tE
         d9oCd9w1V0GBUGQ1fd0GQpl+ekN7Ch1452v/iT1tJB65u182wob3Da9SAxep9DHgUevd
         LsuFUBBRZkxY/qPvmouA9OQjwZ4Qg1tO/9+m2nuv3tKlwYj/cmV24llWRNqBEY58XqP0
         AOlSCwJpumIHnr7UXd2eWXGUJIH/WSvo0rMC6wPlHihe97QmbPrm9n2GGOsfzskRrE5N
         NUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IKtlYY7iR2yjt3dZ8Xi+Wen7V2BC8t7LgAPTs1+bl/g=;
        b=XO2aTmvOYjme5SdVi13e+NECokX6koKdy7tXHWhqOZ7+XVcjnEIDSBiCsyECOVJ5xL
         TabGHi6gc1PCJxVAdcpZvwqvsbUra1CEkkl6YSzLjIAE2Lw1ohYt8wdQwHxgJCl8S/Ly
         Hd6e9IPjIxyUJkXzOXIDD/N1F+qZBe2d9v7bFEq6/6gkiWUFZr35kG+cjrqsF+CO5OTL
         S6lAfnojWumgVE7u1RT2bNkr0+gOgVXAlvi9zUYnTEi7NHmWUbzNM1+5S8AxLS6Q2BiX
         pmeAKUcq12h1WQ2G2pVonM8zAvG9kNf/+tIfnDProitBs7lJc3lJSi+O8Wes8Dvj3kFB
         qiSw==
X-Gm-Message-State: AOAM532RxRf50onyed7+tsu8w/7Ssm0ajrU0cbgCy6m5YkBIHDk/+uH/
        zehMPG9Z5FyCplb7xdEfnjs=
X-Google-Smtp-Source: ABdhPJz4qSeUw1pDYk6xcD6omZnIOKnpbIAUa198cbuGsnRayQtdUr9UI4a22RLFPqn8H76JvhMokw==
X-Received: by 2002:a62:187:0:b029:1da:e323:a96b with SMTP id 129-20020a6201870000b02901dae323a96bmr16159676pfb.28.1612900146029;
        Tue, 09 Feb 2021 11:49:06 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id j22sm139123pff.57.2021.02.09.11.49.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 11:49:05 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 5/8] bpf: Count the number of times recursion was prevented
Date:   Tue,  9 Feb 2021 11:48:53 -0800
Message-Id: <20210209194856.24269-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
References: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add per-program counter for number of times recursion prevention mechanism
was triggered and expose it via show_fdinfo and bpf_prog_info.
Teach bpftool to print it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/filter.h         |  1 +
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           | 14 ++++++++++----
 kernel/bpf/trampoline.c        | 18 ++++++++++++++++--
 tools/bpf/bpftool/prog.c       |  4 ++++
 tools/include/uapi/linux/bpf.h |  1 +
 6 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 6a06f3c69f4e..3b00fc906ccd 100644
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
index f7df56a704de..c859bc46d06c 100644
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
+		misses += tmisses;
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
index 89ef6320d19b..7bc3b3209224 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -394,6 +394,16 @@ static u64 notrace bpf_prog_start_time(void)
 	return start;
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
@@ -412,8 +422,10 @@ u64 notrace __bpf_prog_enter(struct bpf_prog *prog)
 {
 	rcu_read_lock();
 	migrate_disable();
-	if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1))
+	if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1)) {
+		inc_misses_counter(prog);
 		return 0;
+	}
 	return bpf_prog_start_time();
 }
 
@@ -451,8 +463,10 @@ u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog)
 	rcu_read_lock_trace();
 	migrate_disable();
 	might_fault();
-	if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1))
+	if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1)) {
+		inc_misses_counter(prog);
 		return 0;
+	}
 	return bpf_prog_start_time();
 }
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 1fe3ba255bad..f2b915b20546 100644
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
@@ -446,6 +448,8 @@ static void print_prog_header_plain(struct bpf_prog_info *info)
 	if (info->run_time_ns)
 		printf(" run_time_ns %lld run_cnt %lld",
 		       info->run_time_ns, info->run_cnt);
+	if (info->recursion_misses)
+		printf(" recursion_misses %lld", info->recursion_misses);
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

