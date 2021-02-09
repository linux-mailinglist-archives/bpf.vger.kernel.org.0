Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941A631582C
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 22:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhBIU4S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 15:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbhBIUq6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 15:46:58 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D86C06121F
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 11:49:00 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id x136so6000726pfc.2
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 11:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9CtEo0PQ7nFntVkjl+Lb8BnJier51eSyW865jIVLumc=;
        b=tcXm6dxrsqQSzQHy3Ydaa2U50hIR9GTYadFNDs4wN9qgBjp2xcFNsXwvWQiLicnNyz
         3fulSiQTnzalekxNw3Bo6riFl2et0qznVXk6oGBgEPGBk+zwqK6wkzy3r91ALZJW5j0Q
         JW6b+GK0I1W0fpSftK7kVB3GPp1ZhKmdY8ckc+HUH7HVydi5lvB/mFUUXd6hybCH0KNb
         DCRXI7S5/R6FDGENJjngBzbK+eN9HHa1kNPQ7Dvkp7JTilIRYqtBHdD1taivkxcX77Fy
         r0vQ4Ic4xreIdFQ6SRjSen2VgSQCRYBLXULxWF+pEpXPdc5U3QeuE0JGJ0bsnzO8ZwQM
         1hXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9CtEo0PQ7nFntVkjl+Lb8BnJier51eSyW865jIVLumc=;
        b=srI9mZYKQX+rAo92Lcuw2MyCqojgbJF6rO6OIkhoAsW0rgkFtIo550b3x0pkYCHL06
         FMKE0yWGo05VEdP4JVMOKHwkh66dPUD4lw7UN7fX7QAwZPW0N3DGtd55hQ/IJx9sZRWv
         12FDrkxXJ7pevdQP/n9oKb5Vda5z0BhpV3P9G4GUY94Zz1Ai3JuJXTYv8dnfXFL2O8Zq
         9Q3pYWfadEEg1iboKCKkNG7PwZPKksww8Xh6Sw7snh8RvylFpau21aBj8w222VSdbsdI
         /JtBFc++N6ZuUKBedEOVLsTLxV0ywLSsZ0w/PSpc9Jqxjjxm12wZkgIy/e4itJOaj6NQ
         zcFg==
X-Gm-Message-State: AOAM531u685xBmoHCGEQmFR2t3T+XRiAYZ8/DLLWu5+cv0krsGWd8wc9
        vJGc7CUSJT5eMeJuRfO1QLC2rmNnZws=
X-Google-Smtp-Source: ABdhPJyuGlHaf7DgmTuGKjTXjoaGrR7QsUFzAEtpEf4kbVi51t1vRmt0+fkwFrIs6igQ0W05f6NbyA==
X-Received: by 2002:a63:844:: with SMTP id 65mr23191097pgi.371.1612900140175;
        Tue, 09 Feb 2021 11:49:00 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id j22sm139123pff.57.2021.02.09.11.48.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 11:48:59 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 1/8] bpf: Optimize program stats
Date:   Tue,  9 Feb 2021 11:48:49 -0800
Message-Id: <20210209194856.24269-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
References: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Move bpf_prog_stats from prog->aux into prog to avoid one extra load
in critical path of program execution.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h     |  8 --------
 include/linux/filter.h  | 14 +++++++++++---
 kernel/bpf/core.c       |  8 ++++----
 kernel/bpf/syscall.c    |  2 +-
 kernel/bpf/trampoline.c |  2 +-
 kernel/bpf/verifier.c   |  2 +-
 6 files changed, 18 insertions(+), 18 deletions(-)

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
index 5b3137d7b690..cecb03c9d251 100644
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
@@ -557,10 +564,11 @@ struct bpf_prog {
 	u32			len;		/* Number of filter blocks */
 	u32			jited_len;	/* Size of jited insns in bytes */
 	u8			tag[BPF_TAG_SIZE];
-	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
-	struct sock_fprog_kern	*orig_prog;	/* Original BPF program */
+	struct bpf_prog_stats __percpu *stats;
 	unsigned int		(*bpf_func)(const void *ctx,
 					    const struct bpf_insn *insn);
+	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
+	struct sock_fprog_kern	*orig_prog;	/* Original BPF program */
 	/* Instructions for interpreter */
 	struct sock_filter	insns[0];
 	struct bpf_insn		insnsi[];
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
index 5bbd4884ff7a..2cf71fd39c22 100644
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
@@ -249,10 +249,10 @@ void __bpf_prog_free(struct bpf_prog *fp)
 	if (fp->aux) {
 		mutex_destroy(&fp->aux->used_maps_mutex);
 		mutex_destroy(&fp->aux->dst_mutex);
-		free_percpu(fp->aux->stats);
 		kfree(fp->aux->poke_tab);
 		kfree(fp->aux);
 	}
+	free_percpu(fp->stats);
 	vfree(fp);
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

