Return-Path: <bpf+bounces-16185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A507FE08F
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 20:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2641C20C71
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 19:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E701D5DF29;
	Wed, 29 Nov 2023 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNl1Ne4w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832C9194
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 11:56:48 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a178d491014so17847466b.3
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 11:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701287807; x=1701892607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysuLQO1BmL4wxpSUMTs+73BlOCnGBF97cBHe6W0jx/s=;
        b=XNl1Ne4w/vyVCFTmsX6/DahiwMwzHq0xFqtWfNLXxER/jUxfbX0ykwRlyqn4wYIWwI
         vmq/Zp4c4LAiawmI9TLh7Xecgq61/yCafC+fpYoOKwiIXOTnMNO3WQvu0DbocMMOur8a
         bJBQOhosWKXgf3a7gJyg5+EsHcMzO/bIkMo3ezFo1wBUjR2fbuUaDbvOQqBRA255BORw
         B4nRhlzMDXF6raE+Ol9jsi4E8mjtK2Zw9NR94/mTbHrnG90QEWh3wYJik+s8aKNw50C4
         nFpfWx25qcNcvbXOd8KAPX5luMNbLF+t7EoqwjRaA+55+oOJIlCo18fwEPcY7HDLoPG9
         0KlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701287807; x=1701892607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysuLQO1BmL4wxpSUMTs+73BlOCnGBF97cBHe6W0jx/s=;
        b=enH413dOYTaNrQiWxYnInG5EXXM+0699njijPyuT9Z1Aago/FXcWXJ/R1x4oxG9LUD
         qIZTGP0lj7W05oB2jmotgWdqxJIUbneXG99DwlhgNb3bG5FeMxjZIgDPZVpz4ZU8xdcL
         h8bMiZMAwuYbbYB0TRuF3fMWDgv0uY6WuVMh3lCDBjPVGyqME4IY9U7p8GbjXaTk4cS2
         be8ZR64Dm7kcKtryi+zLpO0QyZMu1UCQMeGU8S/7E6V793mx0WZ5Ts4KU1sJK/XCCPNB
         fhQvjyp0mVwjVm58R5PY0+M5JtWo8C40TUy3Us4BNZzkUfDUuXtrf+jCe5+9glJcWRgj
         MFXw==
X-Gm-Message-State: AOJu0YwObmbz+b3NoLvNi5VpCulm5gs8UHk4zzdVLlPQCou5ewzzT+p2
	EOIFU9geUmN+KIrlssaQVG9C5lGcTiz8LA==
X-Google-Smtp-Source: AGHT+IHv2eE8hqRClbdfEpV+vRmEQfkW4GlxYeJldkG874MqnUV42lotOYbl7KJeQEOIhi9OCvK7HA==
X-Received: by 2002:a17:906:3f8a:b0:9d3:ccd1:7604 with SMTP id b10-20020a1709063f8a00b009d3ccd17604mr12313350ejj.44.1701287806953;
        Wed, 29 Nov 2023 11:56:46 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id p4-20020a170906b20400b009ddaf5ebb6fsm8287742ejz.177.2023.11.29.11.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 11:56:46 -0800 (PST)
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
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v4 1/3] bpf: Relax tracing prog recursive attach rules
Date: Wed, 29 Nov 2023 20:52:36 +0100
Message-ID: <20231129195240.19091-2-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231129195240.19091-1-9erthalion6@gmail.com>
References: <20231129195240.19091-1-9erthalion6@gmail.com>
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
implement, add a new field into bpf_prog_aux to track the number of
attachments to the target prog.

As a side effect of this change alone, one could create an unbounded
chain of tracing progs attached to each other. Similar issues between
fentry/fexit and extend progs are addressed via forbidding certain
combinations that could lead to similar chains. Introduce an
attach_depth field to limit the attachment chain, and display it in
bpftool.

Note, that currently, due to various limitations, it's actually not
possible to form such an attachment cycle the original implementation
was prohibiting. It seems that the idea was to make this part robust
even in the view of potential future changes.

[1]: https://lore.kernel.org/bpf/20191108064039.2041889-16-ast@kernel.org/

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 include/linux/bpf.h            |  2 ++
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           | 12 +++++++++++-
 kernel/bpf/verifier.c          | 19 ++++++++++++++++---
 tools/bpf/bpftool/prog.c       |  3 +++
 tools/include/uapi/linux/bpf.h |  1 +
 6 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eb447b0a9423..d7ace97d8e4b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1400,6 +1400,8 @@ struct bpf_prog_aux {
 	u32 real_func_cnt; /* includes hidden progs, only used for JIT and freeing progs */
 	u32 func_idx; /* 0 for non-func prog, the index in func array for func prog */
 	u32 attach_btf_id; /* in-kernel BTF type id to attach to */
+	u32 attach_depth; /* position of the prog in the attachment chain */
+	u32 follower_cnt; /* number of programs attached to it */
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
index 5e43ddd1b83f..a595d7a62dbc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3039,9 +3039,12 @@ static void bpf_tracing_link_release(struct bpf_link *link)
 
 	bpf_trampoline_put(tr_link->trampoline);
 
+	link->prog->aux->attach_depth = 0;
 	/* tgt_prog is NULL if target is a kernel function */
-	if (tr_link->tgt_prog)
+	if (tr_link->tgt_prog) {
+		tr_link->tgt_prog->aux->follower_cnt--;
 		bpf_prog_put(tr_link->tgt_prog);
+	}
 }
 
 static void bpf_tracing_link_dealloc(struct bpf_link *link)
@@ -3243,6 +3246,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		goto out_unlock;
 	}
 
+	if (tgt_prog) {
+		/* Bookkeeping for managing the prog attachment chain. */
+		tgt_prog->aux->follower_cnt++;
+		prog->aux->attach_depth = tgt_prog->aux->attach_depth + 1;
+	}
+
 	link->tgt_prog = tgt_prog;
 	link->trampoline = tr;
 
@@ -4510,6 +4519,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	if (prog->aux->btf)
 		info.btf_id = btf_obj_id(prog->aux->btf);
 	info.attach_btf_id = prog->aux->attach_btf_id;
+	info.attach_depth = prog->aux->attach_depth;
 	if (attach_btf)
 		info.attach_btf_obj_id = btf_obj_id(attach_btf);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8e7b6072e3f4..31ffcffb7198 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20109,6 +20109,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
@@ -20147,9 +20153,16 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
index feb8e305804f..83f999f5505d 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -558,6 +558,9 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd, bool orphaned)
 	if (orphaned)
 		printf("  orphaned");
 
+	if (info->attach_depth)
+		printf("  attach depth %d", info->attach_depth);
+
 	if (info->nr_map_ids)
 		show_prog_maps(fd, info->nr_map_ids);
 
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


