Return-Path: <bpf+bounces-15698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FE97F5077
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 20:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5362A1C20B35
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 19:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3A25E0AC;
	Wed, 22 Nov 2023 19:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7rSDPw9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5949C1
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 11:22:09 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-548d67d30bbso196179a12.1
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 11:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700680928; x=1701285728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IPiWsauDMQpJYss3bx6J0HitQmJivs6FudbHQw5k8PA=;
        b=b7rSDPw9yWuoiISlDBil6uoIyLHnIdW7j997xAKrXkpw99R7xT8vb39Rz8+F4+C0OF
         3juhW3XQqkKyYI96lJiz7ie5wShNpjG7ld56gioFYqiqen5ha/7/nCWQOMfesPHalLKN
         GuIKeQCR3qsruWGeuDqV7R3BSkgCQFGrw2989VARbQby0EvgfBXQKcgQ3flC4yCgb1rW
         Yxga3an8f/ulcc+deAzTqCfR6LBxKOIVykkXS01PwJ59en5aAjB6vDcBAKgscS8JvPlV
         YWBzw3THjHOIupvwcn1CZxXWpCxFUXAtaLjVYrplpip2iY+k+ZmhnZOj0lOwsr9wr7sb
         Pmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700680928; x=1701285728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPiWsauDMQpJYss3bx6J0HitQmJivs6FudbHQw5k8PA=;
        b=dKNKJ4IU8pttUCBxBxe/yu/6iYjAl2NFCYgE0FJxSb6cha92Tszc7/hvO4m6zt7G7X
         g3Ji7ZBTVO+YG2JP18ckceUMHQFtsWBHSZPnykK6G2DaQ0NnhIaSCzL7dDlC3ZghHZf1
         Atp7oBJcf7IjddlfU//cGtJV1FysPRlL58A/xomsy/umeQkSVYtGnP/Z8L5OG0ayDizW
         mi6YfYN9ZEW1MyE2ue/io3Uihwcx7WcmWRLAkd2cDuzDKMSRKrDeQ5U1u5K0fYdtsbyC
         8GahtOQVJQcqqB5LjN4FyXMH3zqpTRHjZw9ZYX6bNdp7Di5UQW2kZ4e7YkDxIvKM+WE4
         djOg==
X-Gm-Message-State: AOJu0Yy78COXbdUK30xVuxeS6KCBx0ZWl3iHms+U2gCQcKd1Odw745oK
	nwiCjFU4Y+kZMMmYLNYdLmC4rdptVdU+kQ==
X-Google-Smtp-Source: AGHT+IENdi+TmH+2zXHx5jEg9Gn+ACiY/3pHBhLC2ullpdwGWfbWawdT5YiBDSoEookjR72NZ/lh7g==
X-Received: by 2002:a17:906:4119:b0:a03:a857:c6e0 with SMTP id j25-20020a170906411900b00a03a857c6e0mr1873407ejk.77.1700680927705;
        Wed, 22 Nov 2023 11:22:07 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id oz2-20020a170906cd0200b009f92d851cc7sm108597ejb.113.2023.11.22.11.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 11:22:07 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	dan.carpenter@linaro.org,
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH bpf-next v2] bpf: Relax tracing prog recursive attach rules
Date: Wed, 22 Nov 2023 20:18:09 +0100
Message-ID: <20231122191816.5572-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, it's not allowed to attach an fentry/fexit prog to another
one of the same type. At the same time it's not uncommon to see a
tracing program with lots of logic in use, and the attachment limitation
prevents usage of fentry/fexit for performance analysis (e.g. with
"bpftool prog profile" command) in this case. An example could be
falcosecurity libs project that uses tp_btf tracing programs.

Following the corresponding discussion [1], the reason for that is to
avoid tracing progs call cycles without introducing more complex
solutions. Relax "no same type" requirement to "no progs that are
already an attach target themselves" for the tracing type. In this way
only a standalone tracing program (without any other progs attached to
it) could be attached to another one, and no cycle could be formed. To
implement, add a new field into bpf_prog_aux to track the fact of
attachment in the target prog.

As a side effect of this change alone, one could create an unbounded
chain of tracing progs attached to each other. Similar issues between
fentry/fexit and extend progs are addressed via forbidding certain
combinations that could lead to similar chains. Introduce an
attach_depth field to limit the attachment chain, and display it in
bpftool.

[1]: https://lore.kernel.org/bpf/20191108064039.2041889-16-ast@kernel.org/

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
Previous discussion: https://lore.kernel.org/bpf/20231114084118.11095-1-9erthalion6@gmail.com/

Changes in v2:
    - Verify tgt_prog is not null
    - Replace boolean followed with number of followers, to handle
      multiple progs attaching/detaching

 include/linux/bpf.h            |  2 ++
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           | 12 +++++++++++-
 kernel/bpf/verifier.c          | 19 ++++++++++++++++---
 tools/bpf/bpftool/prog.c       |  2 ++
 tools/include/uapi/linux/bpf.h |  1 +
 6 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4001d11be151..1b890f65ac39 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1394,6 +1394,8 @@ struct bpf_prog_aux {
 	u32 real_func_cnt; /* includes hidden progs, only used for JIT and freeing progs */
 	u32 func_idx; /* 0 for non-func prog, the index in func array for func prog */
 	u32 attach_btf_id; /* in-kernel BTF type id to attach to */
+	u32 attach_depth; /* position of the prog in the attachment chain */
+	u32 follower_cnt; /* number of programs attached to it */
 	u32 ctx_arg_info_size;
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7cf8bcf9f6a2..aa6614547ef6 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6465,6 +6465,7 @@ struct bpf_prog_info {
 	__u32 verified_insns;
 	__u32 attach_btf_obj_id;
 	__u32 attach_btf_id;
+	__u32 attach_depth;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0ed286b8a0f0..1809595958ef 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3038,9 +3038,12 @@ static void bpf_tracing_link_release(struct bpf_link *link)
 
 	bpf_trampoline_put(tr_link->trampoline);
 
+	link->prog->aux->attach_depth--;
 	/* tgt_prog is NULL if target is a kernel function */
-	if (tr_link->tgt_prog)
+	if (tr_link->tgt_prog) {
+		tr_link->tgt_prog->aux->follower_cnt--;
 		bpf_prog_put(tr_link->tgt_prog);
+	}
 }
 
 static void bpf_tracing_link_dealloc(struct bpf_link *link)
@@ -3235,6 +3238,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	if (err)
 		goto out_unlock;
 
+	if (tgt_prog) {
+		/* Bookkeeping for managing the prog attachment chain. */
+		tgt_prog->aux->follower_cnt++;
+		prog->aux->attach_depth = tgt_prog->aux->attach_depth + 1;
+	}
+
 	err = bpf_trampoline_link_prog(&link->link, tr);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
@@ -4509,6 +4518,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	if (prog->aux->btf)
 		info.btf_id = btf_obj_id(prog->aux->btf);
 	info.attach_btf_id = prog->aux->attach_btf_id;
+	info.attach_depth = prog->aux->attach_depth;
 	if (attach_btf)
 		info.attach_btf_obj_id = btf_obj_id(attach_btf);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9ae6eae13471..de058a83d769 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20329,6 +20329,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	if (tgt_prog) {
 		struct bpf_prog_aux *aux = tgt_prog->aux;
 
+		if (aux->attach_depth >= 32) {
+			bpf_log(log, "Target program attach depth is %d. Too large\n",
+					aux->attach_depth);
+			return -EINVAL;
+		}
+
 		if (bpf_prog_is_dev_bound(prog->aux) &&
 		    !bpf_prog_dev_bound_match(prog, tgt_prog)) {
 			bpf_log(log, "Target program bound device mismatch");
@@ -20367,9 +20373,16 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Can attach to only JITed progs\n");
 			return -EINVAL;
 		}
-		if (tgt_prog->type == prog->type) {
-			/* Cannot fentry/fexit another fentry/fexit program.
-			 * Cannot attach program extension to another extension.
+		if (tgt_prog->type == prog->type &&
+			(prog_extension || prog->aux->follower_cnt > 0)) {
+			/*
+			 * To avoid potential call chain cycles, prevent attaching programs
+			 * of the same type. The only exception is standalone fentry/fexit
+			 * programs that themselves are not attachment targets.
+			 * That means:
+			 *  - Cannot attach followed fentry/fexit to another
+			 *    fentry/fexit program.
+			 *  - Cannot attach program extension to another extension.
 			 * It's ok to attach fentry/fexit to extension program.
 			 */
 			bpf_log(log, "Cannot recursively attach\n");
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 7ec4f5671e7a..24565e8bb825 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -554,6 +554,8 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
 		printf("  memlock %sB", memlock);
 	free(memlock);
 
+	printf("  attach depth %d", info->attach_depth);
+
 	if (info->nr_map_ids)
 		show_prog_maps(fd, info->nr_map_ids);
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7cf8bcf9f6a2..aa6614547ef6 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6465,6 +6465,7 @@ struct bpf_prog_info {
 	__u32 verified_insns;
 	__u32 attach_btf_obj_id;
 	__u32 attach_btf_id;
+	__u32 attach_depth;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {

base-commit: 100888fb6d8a185866b1520031ee7e3182b173de
-- 
2.41.0


