Return-Path: <bpf+bounces-17579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF4180F751
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 20:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97825B20ED9
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 19:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5D252766;
	Tue, 12 Dec 2023 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTN3YAAI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388F1B7
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 11:58:11 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a22f59c6ae6so12075566b.1
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 11:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702411089; x=1703015889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPaf80IzNCY1oiOCB4RCv7XrlTl4C8/MbjMQHeJgayI=;
        b=JTN3YAAIdMpU4M4kFFM5D6puauKxztPU0Hk99OOpWFQ/MdhIzFfLxCgXiFPBu8K7m6
         f1MFGMpG8xo45vyQ/j3hxSUN7VmyjSE/jHNdKbW3mUVYJTBVMsRs09NpkQiBjQlZ50l5
         Jn+sj2e14jywjITKw0jG7tkHeiMzrHfKo3U9IIL6lwIPcGt1JWmMFwSnjMWxIKev9IjF
         dgejqEWqonRvLozS4LwIZJ03L7RKWxUfAbDDYNHvHXzX8k6Heh5sJkP7k9/RwEqlW/1l
         Iq3FfocExQFpfQ/k85phtnVYivfrR0Vavh+rYvxdGwR3uF7rBiYy9hm9/1i21rVTWrYg
         YM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702411089; x=1703015889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPaf80IzNCY1oiOCB4RCv7XrlTl4C8/MbjMQHeJgayI=;
        b=PoMC/UbPftw4wBwb3unRR06lmutfBLoqa+lPdTs8BJxviBih7/vb9IDWIVrjmaqqXb
         dq/7G/wHvvI9dE+6w5szuZDvZCeVvciMU3FOLRUmeI28n0XClS00D7BLseow3msXHpim
         SxgYjd5qISImtmYsVN7yO4Mw8SBjO/zNbLSCr9+XFNLXYGidWEYw0Essg7NLwmBvfwiw
         CPCfXdvbIcnpnUVPfXkKvSbrk928eFQcw1lPN9bY0n43ZM5cfLUFo7CNBORA5w6wwgrK
         hJgp2b+lAuKimMwFNS0jqmS1LaRkt0EJzeA0tzSiLc/gZ0302LdKpTpIfO9gJGeKFUg8
         H1Kg==
X-Gm-Message-State: AOJu0YxP9QfCZZhY5CMbVqvbg5lpmjZ8QVnhlrCH4l5o7xt1UMb63CUw
	e5F9eNuEuhah7HIw0+2Wt/Rt1LbRG6wU0w==
X-Google-Smtp-Source: AGHT+IH43IBLt6ByBvjRHk0k0fDjIdrxQBlfrsxQukgfVrbyFpjHGH5SZi3+kNPPC2Yj9WvyfAbcUQ==
X-Received: by 2002:a17:907:9483:b0:a1e:5ea5:c5d3 with SMTP id dm3-20020a170907948300b00a1e5ea5c5d3mr2335486ejc.131.1702411089414;
        Tue, 12 Dec 2023 11:58:09 -0800 (PST)
Received: from localhost.localdomain ([2a00:20:608d:69b3:fa16:54ff:fe6e:2940])
        by smtp.gmail.com with ESMTPSA id tm6-20020a170907c38600b00a1db955c809sm6677386ejc.73.2023.12.12.11.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 11:58:09 -0800 (PST)
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
Subject: [PATCH bpf-next v8 1/4] bpf: Relax tracing prog recursive attach rules
Date: Tue, 12 Dec 2023 20:54:06 +0100
Message-ID: <20231212195413.23942-2-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212195413.23942-1-9erthalion6@gmail.com>
References: <20231212195413.23942-1-9erthalion6@gmail.com>
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
add a new field into bpf_prog_aux to track nested attachment for tracing
programs.

[1]: https://lore.kernel.org/bpf/20191108064039.2041889-16-ast@kernel.org/

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
Previous discussion: https://lore.kernel.org/bpf/20231208185557.8477-1-9erthalion6@gmail.com/

Changes in v8:
    - Move bookkeping in bpf_tracing_link_release under the tgt_prog
      condition.
    - Fix some indentation issues.

Changes in v7:
    - Replace attach_depth with a boolean flag to indicate a program is
      already tracing an fentry/fexit.

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

 include/linux/bpf.h   |  1 +
 kernel/bpf/syscall.c  | 10 +++++++++-
 kernel/bpf/verifier.c | 39 +++++++++++++++++++++++++--------------
 3 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eb447b0a9423..e7393674ab94 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1414,6 +1414,7 @@ struct bpf_prog_aux {
 	bool dev_bound; /* Program is bound to the netdev. */
 	bool offload_requested; /* Program is bound and offloaded to the netdev. */
 	bool attach_btf_trace; /* true if attaching to BTF-enabled raw tp */
+	bool attach_tracing_prog; /* true if tracing another tracing program */
 	bool func_proto_unreliable;
 	bool sleepable;
 	bool tail_call_reachable;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5e43ddd1b83f..af51e97c2c28 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3040,8 +3040,10 @@ static void bpf_tracing_link_release(struct bpf_link *link)
 	bpf_trampoline_put(tr_link->trampoline);
 
 	/* tgt_prog is NULL if target is a kernel function */
-	if (tr_link->tgt_prog)
+	if (tr_link->tgt_prog) {
 		bpf_prog_put(tr_link->tgt_prog);
+		link->prog->aux->attach_tracing_prog = false;
+	}
 }
 
 static void bpf_tracing_link_dealloc(struct bpf_link *link)
@@ -3243,6 +3245,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		goto out_unlock;
 	}
 
+	/* Bookkeeping for managing the prog attachment chain */
+	if (tgt_prog &&
+		prog->type == BPF_PROG_TYPE_TRACING &&
+		tgt_prog->type == BPF_PROG_TYPE_TRACING)
+			prog->aux->attach_tracing_prog = true;
+
 	link->tgt_prog = tgt_prog;
 	link->trampoline = tr;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8e7b6072e3f4..f8c15ce8fd05 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20077,6 +20077,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    struct bpf_attach_target_info *tgt_info)
 {
 	bool prog_extension = prog->type == BPF_PROG_TYPE_EXT;
+	bool prog_tracing = prog->type == BPF_PROG_TYPE_TRACING;
 	const char prefix[] = "btf_trace_";
 	int ret = 0, subprog = -1, i;
 	const struct btf_type *t;
@@ -20147,10 +20148,21 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Can attach to only JITed progs\n");
 			return -EINVAL;
 		}
-		if (tgt_prog->type == prog->type) {
-			/* Cannot fentry/fexit another fentry/fexit program.
-			 * Cannot attach program extension to another extension.
-			 * It's ok to attach fentry/fexit to extension program.
+		if (prog_tracing) {
+			if (aux->attach_tracing_prog) {
+				/*
+				 * Target program is an fentry/fexit which is already attached
+				 * to another tracing program. More levels of nesting
+				 * attachment are not allowed.
+				 */
+				bpf_log(log, "Cannot nest tracing program attach more than once\n");
+				return -EINVAL;
+			}
+		} else if (tgt_prog->type == prog->type) {
+			/*
+			 * To avoid potential call chain cycles, prevent attaching of a
+			 * program extension to another extension. It's ok to attach
+			 * fentry/fexit to extension program.
 			 */
 			bpf_log(log, "Cannot recursively attach\n");
 			return -EINVAL;
@@ -20163,16 +20175,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
-- 
2.41.0


