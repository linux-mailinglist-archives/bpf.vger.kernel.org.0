Return-Path: <bpf+bounces-18892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A07823552
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663ED281672
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867461CA9F;
	Wed,  3 Jan 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GekiKvy7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4D21CA93
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso304301e87.1
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 11:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704308779; x=1704913579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijme0rml4onbOQp0HK8tIIjWWbSpCStFM4JHVkgfj7k=;
        b=GekiKvy75qQy0BoyB6ep0uRSeRgocOh7o7EmubvTSHmJT6OPjpfk+zgUqeW028lYt7
         7RXmTKEUIPvHMsxx2EqMYLnRBYGBwTIQKbYB9O3cBsrVhA2S41hEUNQI3SdToF5F5D/0
         0Sc+pclvQQdZNb/cNwaG1nA4+R/ZgxvpVtJsw2CLkrzt2KbEsnUMI7FOwMpu030ccRiK
         5oggaq4WXwOPsq7tFMCnoAgKz7ARGeIxJLq5me9D6BEYFbDH/oyqaOZM7pcyDZ7PJoAH
         6r+KzaYvBtrWgmlw0uC9mT7SvBw0Jk7oFKU7e5rHGlwTIgRa86bitrgB6mwXBNGYg9vg
         l8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704308779; x=1704913579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijme0rml4onbOQp0HK8tIIjWWbSpCStFM4JHVkgfj7k=;
        b=LJ+u+ZdHU7QAz07fkkWOz7cCQw0BTxwNucIb+bexbcqDiCopzrB/cm7cq8x6DDGpId
         5g6k3vKIdg77vfR7Lmya2MDSUyfcdJBEz9DjqCJq97JbuJe8AatYPSQrFcQQuUxnLvqU
         IbeHusQIL5iMu8EX2bQiB25br/mNw/VcB8lb0yxJSPs5a32YmHR4JBEFtRWTCUnqUIB3
         evLrIc3/pkZiHnOC4zoSKsb5bgIlMRu80GXVyhtGgeZ3AbRGgdRYHBP4XZQ81AiP7IUK
         jXV0YZws9U2ZmHNkqSEeNngDOX9w3VVWaroQjxw83pcjA6Lhg1OjTm7uFW3+BPqTQQfv
         6bOg==
X-Gm-Message-State: AOJu0Ywg5CCPRWIRqy/MTJE3liTRvrlWjQ7VsKe64OzchA2AG03genGh
	ALLtTUIfc07OIbU3NKe5YJFnp43Vvz9X1w==
X-Google-Smtp-Source: AGHT+IFB8oWMbdQYuwQvUMYm2d9tfmNKgdhzH3vKG9x73uxscTTetqUgmtXbZ0tQYEKo2wk+WV6jqA==
X-Received: by 2002:a05:6512:3119:b0:50e:4fcb:dc28 with SMTP id n25-20020a056512311900b0050e4fcbdc28mr3905929lfb.35.1704308779134;
        Wed, 03 Jan 2024 11:06:19 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id wj20-20020a170907051400b00a28a8a7de10sm605772ejb.159.2024.01.03.11.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 11:06:18 -0800 (PST)
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
Subject: [PATCH bpf-next v12 1/4] bpf: Relax tracing prog recursive attach rules
Date: Wed,  3 Jan 2024 20:05:44 +0100
Message-ID: <20240103190559.14750-2-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240103190559.14750-1-9erthalion6@gmail.com>
References: <20240103190559.14750-1-9erthalion6@gmail.com>
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

Acked-by: Jiri Olsa <olsajiri@gmail.com>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
Previous discussion: https://lore.kernel.org/bpf/20231222151153.31291-1-9erthalion6@gmail.com/

Changes in v10:
    - Set attach_tracing_prog flag at load time.

Changes in v9:
    - Formatting

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
 kernel/bpf/syscall.c  | 23 ++++++++++++++++++++++-
 kernel/bpf/verifier.c | 39 +++++++++++++++++++++++++--------------
 3 files changed, 48 insertions(+), 15 deletions(-)

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
index 5e43ddd1b83f..c40cad8886e9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2702,6 +2702,22 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 			goto free_prog_sec;
 	}
 
+	/*
+	 * Bookkeeping for managing the program attachment chain.
+	 *
+	 * It might be tempting to set attach_tracing_prog flag at the attachment
+	 * time, but this will not prevent from loading bunch of tracing prog
+	 * first, then attach them one to another.
+	 *
+	 * The flag attach_tracing_prog is set for the whole program lifecycle, and
+	 * doesn't have to be cleared in bpf_tracing_link_release, since tracing
+	 * programs cannot change attachment target.
+	 */
+	if (type == BPF_PROG_TYPE_TRACING && dst_prog &&
+	    dst_prog->type == BPF_PROG_TYPE_TRACING) {
+		prog->aux->attach_tracing_prog = true;
+	}
+
 	/* find program type: socket_filter vs tracing_filter */
 	err = find_prog_type(type, prog);
 	if (err < 0)
@@ -3135,7 +3151,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	}
 
 	if (tgt_prog_fd) {
-		/* For now we only allow new targets for BPF_PROG_TYPE_EXT */
+		/*
+		 * For now we only allow new targets for BPF_PROG_TYPE_EXT. If this
+		 * part would be changed to implement the same for
+		 * BPF_PROG_TYPE_TRACING, do not forget to update the way how
+		 * attach_tracing_prog flag is set.
+		 */
 		if (prog->type != BPF_PROG_TYPE_EXT) {
 			err = -EINVAL;
 			goto out_put_prog;
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


