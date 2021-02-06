Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B843311EFC
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 18:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBFREa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 12:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBFRE3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 12:04:29 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ED2C061756
        for <bpf@vger.kernel.org>; Sat,  6 Feb 2021 09:03:48 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id o7so6847187pgl.1
        for <bpf@vger.kernel.org>; Sat, 06 Feb 2021 09:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ff2zsTna5n4xNk9qjKCjYgZuYcKCEND5UpUV8fKCYfw=;
        b=qRJPNqUMPhiifFasiMrpjEHjpkuIQiHkQtiGijxfv8Tn+KlsZld26crhXuxiqMO/q+
         +16WzzhtDGFg176OX3PSzdP4yyxT9q+AS1N235iQnT0W9jiPZqtU08MUhKqBxKSGyHs/
         fqbyrLaF/5vTHjQXRFVK/yv7owmsoBQT0mU5++LJ2XFhQxigWAYz5khxkl+tBfwPSq9T
         5vOo+hZFCOU89aPN8F5cXSdELyz6NVe4qsNRX5v7de8Q2IBGhQWDaqHmO+lSIHHsVKHK
         GXTL4Q5WcyGgZYGQFsVk5/l62DVCbVOWZ75pM5ybjGkCqS+8OD3Kiy6MEOUycA7gU72T
         soFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ff2zsTna5n4xNk9qjKCjYgZuYcKCEND5UpUV8fKCYfw=;
        b=XddvkUfDeolizOoocKQJ0gau9ZiQyajfiideUU9hVOa+ROPfrtZG3JeOlbqflEcOGo
         k1moOHEtgDwjLUOXE7r16eglB6kXmJDN0Mt0Rd7J291skHG8wvnEzzTv9hULyuf3mcJh
         YJHpqRA9CxuWu+eufAWmnlH0yEkk4d6xCdqPvJhB5UspwSByseUBvU6yTD4a+uDlApfd
         uHpAluYu0EX2ECqssuHLXkUONNKxNGexPn8RTCTYSZjGbUOT5oDoJU1iyLQtbkZbA0fR
         jqZ87NX/l97Na4n1hvEa+X5pabLO2Jf/NicohskSMIifenIxo74FrC9i6sK6t0maM9Wb
         +dnw==
X-Gm-Message-State: AOAM531v5WwLwSZAb1vDRrndSI94/jw27+DoOv5dP1eqEA836aGF3nQp
        BBxM53AQNozn4ILWy/SvjqImylIkmn0=
X-Google-Smtp-Source: ABdhPJyd1YcYKF5vlE0mCpLInszgslIrYLe5l3sz4gIRgA9IxOmkTbLmtXAuv12TxTOPfG4uUjHUag==
X-Received: by 2002:a62:1c84:0:b029:1c4:f959:7b29 with SMTP id c126-20020a621c840000b02901c4f9597b29mr10094059pfc.34.1612631028280;
        Sat, 06 Feb 2021 09:03:48 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id j14sm11149964pjl.35.2021.02.06.09.03.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Feb 2021 09:03:47 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 1/7] bpf: Optimize program stats
Date:   Sat,  6 Feb 2021 09:03:38 -0800
Message-Id: <20210206170344.78399-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Move bpf_prog_stats from prog->aux into prog to avoid one extra load
in critical path of program execution.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h     |  8 --------
 include/linux/filter.h  | 10 +++++++++-
 kernel/bpf/core.c       |  8 ++++----
 kernel/bpf/syscall.c    |  2 +-
 kernel/bpf/trampoline.c |  2 +-
 kernel/bpf/verifier.c   |  2 +-
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 321966fc35db..026fa8873c5d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -14,7 +14,6 @@
 #include <linux/numa.h>
 #include <linux/mm_types.h>
 #include <linux/wait.h>
-#include <linux/u64_stats_sync.h>
 #include <linux/refcount.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
@@ -507,12 +506,6 @@ enum bpf_cgroup_storage_type {
  */
 #define MAX_BPF_FUNC_ARGS 12
 
-struct bpf_prog_stats {
-	u64 cnt;
-	u64 nsecs;
-	struct u64_stats_sync syncp;
-} __aligned(2 * sizeof(u64));
-
 struct btf_func_model {
 	u8 ret_size;
 	u8 nr_args;
@@ -845,7 +838,6 @@ struct bpf_prog_aux {
 	u32 linfo_idx;
 	u32 num_exentries;
 	struct exception_table_entry *extable;
-	struct bpf_prog_stats __percpu *stats;
 	union {
 		struct work_struct work;
 		struct rcu_head	rcu;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 5b3137d7b690..c6592590a0b7 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -22,6 +22,7 @@
 #include <linux/vmalloc.h>
 #include <linux/sockptr.h>
 #include <crypto/sha1.h>
+#include <linux/u64_stats_sync.h>
 
 #include <net/sch_generic.h>
 
@@ -539,6 +540,12 @@ struct bpf_binary_header {
 	u8 image[] __aligned(BPF_IMAGE_ALIGNMENT);
 };
 
+struct bpf_prog_stats {
+	u64 cnt;
+	u64 nsecs;
+	struct u64_stats_sync syncp;
+} __aligned(2 * sizeof(u64));
+
 struct bpf_prog {
 	u16			pages;		/* Number of allocated pages */
 	u16			jited:1,	/* Is our filter JIT'ed? */
@@ -559,6 +566,7 @@ struct bpf_prog {
 	u8			tag[BPF_TAG_SIZE];
 	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
 	struct sock_fprog_kern	*orig_prog;	/* Original BPF program */
+	struct bpf_prog_stats __percpu *stats;
 	unsigned int		(*bpf_func)(const void *ctx,
 					    const struct bpf_insn *insn);
 	/* Instructions for interpreter */
@@ -581,7 +589,7 @@ DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 		struct bpf_prog_stats *__stats;				\
 		u64 __start = sched_clock();				\
 		__ret = dfunc(ctx, (prog)->insnsi, (prog)->bpf_func);	\
-		__stats = this_cpu_ptr(prog->aux->stats);		\
+		__stats = this_cpu_ptr(prog->stats);			\
 		u64_stats_update_begin(&__stats->syncp);		\
 		__stats->cnt++;						\
 		__stats->nsecs += sched_clock() - __start;		\
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5bbd4884ff7a..fa3da4cda476 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -114,8 +114,8 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
 	if (!prog)
 		return NULL;
 
-	prog->aux->stats = alloc_percpu_gfp(struct bpf_prog_stats, gfp_flags);
-	if (!prog->aux->stats) {
+	prog->stats = alloc_percpu_gfp(struct bpf_prog_stats, gfp_flags);
+	if (!prog->stats) {
 		kfree(prog->aux);
 		vfree(prog);
 		return NULL;
@@ -124,7 +124,7 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
 	for_each_possible_cpu(cpu) {
 		struct bpf_prog_stats *pstats;
 
-		pstats = per_cpu_ptr(prog->aux->stats, cpu);
+		pstats = per_cpu_ptr(prog->stats, cpu);
 		u64_stats_init(&pstats->syncp);
 	}
 	return prog;
@@ -249,7 +249,7 @@ void __bpf_prog_free(struct bpf_prog *fp)
 	if (fp->aux) {
 		mutex_destroy(&fp->aux->used_maps_mutex);
 		mutex_destroy(&fp->aux->dst_mutex);
-		free_percpu(fp->aux->stats);
+		free_percpu(fp->stats);
 		kfree(fp->aux->poke_tab);
 		kfree(fp->aux);
 	}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e5999d86c76e..f7df56a704de 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1739,7 +1739,7 @@ static void bpf_prog_get_stats(const struct bpf_prog *prog,
 		unsigned int start;
 		u64 tnsecs, tcnt;
 
-		st = per_cpu_ptr(prog->aux->stats, cpu);
+		st = per_cpu_ptr(prog->stats, cpu);
 		do {
 			start = u64_stats_fetch_begin_irq(&st->syncp);
 			tnsecs = st->nsecs;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 35c5887d82ff..5be3beeedd74 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -412,7 +412,7 @@ void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
 	     * Hence check that 'start' is not zero.
 	     */
 	    start) {
-		stats = this_cpu_ptr(prog->aux->stats);
+		stats = this_cpu_ptr(prog->stats);
 		u64_stats_update_begin(&stats->syncp);
 		stats->cnt++;
 		stats->nsecs += sched_clock() - start;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 15694246f854..4189edb41b73 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10889,7 +10889,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		/* BPF_PROG_RUN doesn't call subprogs directly,
 		 * hence main prog stats include the runtime of subprogs.
 		 * subprogs don't have IDs and not reachable via prog_get_next_id
-		 * func[i]->aux->stats will never be accessed and stays NULL
+		 * func[i]->stats will never be accessed and stays NULL
 		 */
 		func[i] = bpf_prog_alloc_no_stats(bpf_prog_size(len), GFP_USER);
 		if (!func[i])
-- 
2.24.1

