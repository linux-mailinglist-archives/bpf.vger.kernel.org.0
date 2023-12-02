Return-Path: <bpf+bounces-16515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F40801E33
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 20:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BBA1F211A3
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 19:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F97208A1;
	Sat,  2 Dec 2023 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjaH4eQH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E14125
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 11:19:47 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so465007666b.1
        for <bpf@vger.kernel.org>; Sat, 02 Dec 2023 11:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701544785; x=1702149585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVnD9IBKgeFXP1N/4EisJqwdjkIdWjmpXDkOaU1l2H0=;
        b=BjaH4eQHgwykQaCIrUp7JJdBLEyVwWOiqbCi9YFduGND0fKrr4fvqVG4V2UKMX9dZZ
         Rp8uNNpMjVa90GJWFMMOfYQGOGsYeldHByy+nnmT6kXSIP+lNJBUZKKrO4sTkucEu1fa
         iHev37Iid4BNdH+yQ/YkCMxeJmSZpDBslGndj0Fzm6l6IkrlaCibKDaUW2ojEChVxW4O
         qlIkFGH8WwOMP399ry2a7ITZkrISIvT00Dy5RB6+dwj14NRlTyFcZhwMXn1pO/NHb0RL
         W+jzH4mKIAHAhhs10hUU/7CPN+9DOL0dPUc7YiURTQXmvHifijHyr8klepO5QAZqoQQA
         oHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701544785; x=1702149585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVnD9IBKgeFXP1N/4EisJqwdjkIdWjmpXDkOaU1l2H0=;
        b=JFsWYXKBB7jGyzVB5YF2IVlRFNSH6wthfxCCgTp80cmZ90H4nMsxt+9MXb139AH1Vc
         kPijmYqEVDbPtB5h33lBHoTdyJnfhuScSlRp+tXKklMYwq0LXVf2JmzyoSYzCmAGqM+H
         BKenRgXluRBF06tMx5eDP0EOtKOm2+4d5ybTLQsPokfiydVHzOOJcj0NtiDb31+8CtA/
         SBCDY53xOUOoVxy2CIz2bY3bgLF2z+2/D2j/ORwrfW2Xww1JINzAt7QzvcQwVlbc+0fu
         dm50XB3M7F8fRNPdOh/fp7qV8Z21QsZw9/mG7y+ZfmnFsF5+GL8UdHK9Ondn06KNPN0z
         MI2Q==
X-Gm-Message-State: AOJu0YyPHb+eBnfWFUizywUG5DWL9srpfJUuOb+JPFYg+kjsVytuNiWZ
	QOufLYJpBVY8Hlt9awJCg95aCg1scHzkIw==
X-Google-Smtp-Source: AGHT+IGdO+iRzWWumSEC+qjIegMz38ZOfYsI3AGMCOWLKkWpKeeCZCjwgahwhUnzsa0p6udFEbauyg==
X-Received: by 2002:a17:906:20d9:b0:9d4:2080:61dc with SMTP id c25-20020a17090620d900b009d4208061dcmr2083865ejc.22.1701544785350;
        Sat, 02 Dec 2023 11:19:45 -0800 (PST)
Received: from localhost.localdomain ([2a00:20:6008:6fb9:fa16:54ff:fe6e:2940])
        by smtp.gmail.com with ESMTPSA id i23-20020a170906115700b00a18ed83ce42sm3127814eja.15.2023.12.02.11.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 11:19:45 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	dan.carpenter@linaro.org,
	olsajiri@gmail.com,
	asavkov@redhat.com,
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v6 1/4] bpf: Relax tracing prog recursive attach rules
Date: Sat,  2 Dec 2023 20:15:47 +0100
Message-ID: <20231202191556.30997-2-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231202191556.30997-1-9erthalion6@gmail.com>
References: <20231202191556.30997-1-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, it's not allowed to attach an fentry/fexit prog to another
one fentry/fexit. At the same time it's not uncommon to see a tracing
program with lots of logic in use, and the attachment limitation
prevents usage of fentry/fexit for performance analysis (e.g. with
"bpftool prog profile" command) in this case. An example could be
falcosecurity libs project that uses tp_btf tracing programs.

Following the corresponding discussion [1], the reason for that is to
avoid tracing progs call cycles without introducing more complex
solutions. But currently it seems impossible to load and attach tracing
programs in a way that will form such a cycle. The limitation is coming
from the fact that attach_prog_fd is specified at the prog load (thus
making it impossible to attach to a program loaded after it in this
way), as well as tracing progs not implementing link_detach.

Replace "no same type" requirement with verification that no more than
one level of attachment nesting is allowed. In this way only one
fentry/fexit program could be attached to another fentry/fexit to cover
profiling use case, and still no cycle could be formed. To implement,
add a new field into bpf_prog_aux to track the depth of attachment.

[1]: https://lore.kernel.org/bpf/20191108064039.2041889-16-ast@kernel.org/

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
Previous discussion: https://lore.kernel.org/bpf/20231201154734.8545-1-9erthalion6@gmail.com/

Changes in v6:
    - Apply nesting level limitation only to tracing programs, otherwise
      it's possible to apply it in "fentry->extension" case and break it

Changes in v5:
    - Remove follower_cnt and drop unreachable cycle prevention condition
    - Allow only one level of attachment nesting
    - Do not display attach_depth in bpftool, as it doesn't make sense
      anymore

Changes in v3:
    - Fix incorrect decreasing of attach_depth, setting to 0 instead
    - Place bookkeeping later, to not miss a cleanup if needed
    - Display attach_depth in bpftool only if the value is not 0

Changes in v2:
    - Verify tgt_prog is not null
    - Replace boolean followed with number of followers, to handle
      multiple progs attaching/detaching

 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           | 12 ++++++++++++
 kernel/bpf/verifier.c          | 33 +++++++++++++++++++--------------
 tools/include/uapi/linux/bpf.h |  1 +
 5 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eb447b0a9423..1588e48fe31c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1400,6 +1400,7 @@ struct bpf_prog_aux {
 	u32 real_func_cnt; /* includes hidden progs, only used for JIT and freeing progs */
 	u32 func_idx; /* 0 for non-func prog, the index in func array for func prog */
 	u32 attach_btf_id; /* in-kernel BTF type id to attach to */
+	u32 attach_depth; /* for tracing prog, level of attachment nesting */
 	u32 ctx_arg_info_size;
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e88746ba7d21..9cf45ad914f1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6468,6 +6468,7 @@ struct bpf_prog_info {
 	__u32 verified_insns;
 	__u32 attach_btf_obj_id;
 	__u32 attach_btf_id;
+	__u32 attach_depth;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5e43ddd1b83f..9c56b5970d7e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3039,6 +3039,7 @@ static void bpf_tracing_link_release(struct bpf_link *link)
 
 	bpf_trampoline_put(tr_link->trampoline);
 
+	link->prog->aux->attach_depth = 0;
 	/* tgt_prog is NULL if target is a kernel function */
 	if (tr_link->tgt_prog)
 		bpf_prog_put(tr_link->tgt_prog);
@@ -3243,6 +3244,16 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		goto out_unlock;
 	}
 
+	if (tgt_prog) {
+		/* Bookkeeping for managing the prog attachment chain. If it's a
+		 * tracing program, bump the level, otherwise carry it on.
+		 */
+		if (prog->type == BPF_PROG_TYPE_TRACING)
+			prog->aux->attach_depth = tgt_prog->aux->attach_depth + 1;
+		else
+			prog->aux->attach_depth = tgt_prog->aux->attach_depth;
+	}
+
 	link->tgt_prog = tgt_prog;
 	link->trampoline = tr;
 
@@ -4510,6 +4521,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	if (prog->aux->btf)
 		info.btf_id = btf_obj_id(prog->aux->btf);
 	info.attach_btf_id = prog->aux->attach_btf_id;
+	info.attach_depth = prog->aux->attach_depth;
 	if (attach_btf)
 		info.attach_btf_obj_id = btf_obj_id(attach_btf);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8e7b6072e3f4..a3ea2087a6b2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20109,6 +20109,11 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	if (tgt_prog) {
 		struct bpf_prog_aux *aux = tgt_prog->aux;
 
+		if (aux->attach_depth >= 1) {
+			bpf_log(log, "Cannot attach with more than one level of nesting\n");
+			return -EINVAL;
+		}
+
 		if (bpf_prog_is_dev_bound(prog->aux) &&
 		    !bpf_prog_dev_bound_match(prog, tgt_prog)) {
 			bpf_log(log, "Target program bound device mismatch");
@@ -20147,10 +20152,11 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Can attach to only JITed progs\n");
 			return -EINVAL;
 		}
-		if (tgt_prog->type == prog->type) {
-			/* Cannot fentry/fexit another fentry/fexit program.
-			 * Cannot attach program extension to another extension.
-			 * It's ok to attach fentry/fexit to extension program.
+		if (tgt_prog->type == prog->type && prog_extension) {
+			/*
+			 * To avoid potential call chain cycles, prevent attaching of a
+			 * program extension to another extension. It's ok to attach
+			 * fentry/fexit to extension program.
 			 */
 			bpf_log(log, "Cannot recursively attach\n");
 			return -EINVAL;
@@ -20163,16 +20169,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			 * except fentry/fexit. The reason is the following.
 			 * The fentry/fexit programs are used for performance
 			 * analysis, stats and can be attached to any program
-			 * type except themselves. When extension program is
-			 * replacing XDP function it is necessary to allow
-			 * performance analysis of all functions. Both original
-			 * XDP program and its program extension. Hence
-			 * attaching fentry/fexit to BPF_PROG_TYPE_EXT is
-			 * allowed. If extending of fentry/fexit was allowed it
-			 * would be possible to create long call chain
-			 * fentry->extension->fentry->extension beyond
-			 * reasonable stack size. Hence extending fentry is not
-			 * allowed.
+			 * type. When extension program is replacing XDP function
+			 * it is necessary to allow performance analysis of all
+			 * functions. Both original XDP program and its program
+			 * extension. Hence attaching fentry/fexit to
+			 * BPF_PROG_TYPE_EXT is allowed. If extending of
+			 * fentry/fexit was allowed it would be possible to create
+			 * long call chain fentry->extension->fentry->extension
+			 * beyond reasonable stack size. Hence extending fentry
+			 * is not allowed.
 			 */
 			bpf_log(log, "Cannot extend fentry/fexit\n");
 			return -EINVAL;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e88746ba7d21..9cf45ad914f1 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6468,6 +6468,7 @@ struct bpf_prog_info {
 	__u32 verified_insns;
 	__u32 attach_btf_obj_id;
 	__u32 attach_btf_id;
+	__u32 attach_depth;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
-- 
2.41.0


