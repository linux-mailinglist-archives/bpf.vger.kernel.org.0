Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7E8311F01
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 18:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhBFRFK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 12:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhBFRFI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 12:05:08 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B37C06178B
        for <bpf@vger.kernel.org>; Sat,  6 Feb 2021 09:03:54 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n10so6808799pgl.10
        for <bpf@vger.kernel.org>; Sat, 06 Feb 2021 09:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mSEl96TyA6FmlILIBwStFeCiUiAQJTqNLulkv1cwKeE=;
        b=nueCpySJlPLarBg+pjEclrXIflXkHZ+cMg7bwXBjI4I5s1PQRVvgYotPbxg7YuZooF
         9VaGU9ybYj/7gGa2biwE3pcTiSoCgMhSo+v+Ds5t3GLGFhqHJHJ/pTu3Pg9eBVgABrTQ
         Se5Ui+NztyoNHNwvMsa99HRDC8BEnlqQ41qA/oVMomw/sCxVNutbyhyVmwki4NrP4kPK
         ucUjsgzxwktqIdGCnR2e9lc46TpX16l5gh1+xCfHiHSEn4Pr0s9sqF+YZxjG+Xbo3+M3
         XlGJ36LwodosHZCT6+rFt/zExW82NBb59VNzyuPF+Pgq91ljkLhsr8WtAbZqz05M/4NL
         pTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mSEl96TyA6FmlILIBwStFeCiUiAQJTqNLulkv1cwKeE=;
        b=Ft9qrEZHJ5eUiyfpgoEuwgM0Q9gun7/bX8n9Y78RwQRBr4bReryh/y9EOHBUaTzpFX
         EIRBmjohp9ekZD0wQRCsIqgYw/cEYdjDZBwN4/V+ZNZZNEqXWZ7G2ZcBwcZ4ASiEUjus
         Esoauvxko/XQLfvYIWVnewTHv6R1EIUpzKP3yXyJC7h5+w+/mRcCiF8yF+nzTBP23bsj
         ja5Tk5+2rLUZydeN5ZWCHGs7QbQty7npBFjMsq5V9MFyfA8/eBJ2a9VrM1VaXWEbeKfj
         d/fdNLnpiLQm46jWGKc5sG+2yAYGplFKYxJUzxrPFgsjVN5OQp8CIBYdzu7+AfSzfZaJ
         kdXg==
X-Gm-Message-State: AOAM533oTruiBkVKV/FN4pV2O3GzBBNm2wyH3k9Y/379G4wZW+BqZXX8
        n2dD7vwus8oM5xczx4sHDV4=
X-Google-Smtp-Source: ABdhPJw/j116P52TxVNDHyAppTykyKanCS3Bo9Xkt4u8TC2s7TKMzMTqhYVWJigdVxgyuDImg0bdMw==
X-Received: by 2002:a63:1f1e:: with SMTP id f30mr10374543pgf.141.1612631033767;
        Sat, 06 Feb 2021 09:03:53 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id j14sm11149964pjl.35.2021.02.06.09.03.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Feb 2021 09:03:53 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 5/7] bpf: Count the number of times recursion was prevented
Date:   Sat,  6 Feb 2021 09:03:42 -0800
Message-Id: <20210206170344.78399-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
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
index d6c740eac056..4c9850b35744 100644
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

