Return-Path: <bpf+bounces-21415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B584CE28
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 16:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E1E1C21059
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D833D7FBB6;
	Wed,  7 Feb 2024 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzBe/Fgg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F67E775
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320178; cv=none; b=tkCZxZWeP99lvWjLJVwh9XRgF4CLQZCsVJc4DDaR97CNdvJC8W/p7aik+QqDC4/eteMM78/hLljstULPMYsqv5EXSEsgLxulAFlJrX9HKMByUkGXX8fHeaPJt2t66s1uC9DewYjoLoVSyMd9nuiuhZKznPBV2IZvRYM0yRAE0ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320178; c=relaxed/simple;
	bh=9L3UWxcyv/PHg1BOTF2MFJN+fCvInA4kQSJ81QomlUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRd2bzxqcCresdKKZeEBf+fpQ2daNA0ySI0LNsO2eVB+nIxDp+WV9Qgl96Tci/0HNXpbj+bOp2pV4+LPuR7UD60RVH64uh53xFRdJcnZE1V/K3j3oeUUyw3gvjt+CjwIkyeOv1lxaV8MrmfAlWMS0SEb+gNikW2LMufuiG0r0ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzBe/Fgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF6CC433C7;
	Wed,  7 Feb 2024 15:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707320177;
	bh=9L3UWxcyv/PHg1BOTF2MFJN+fCvInA4kQSJ81QomlUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AzBe/FggY3R46xv+gTDQtTGq7J4gZdS6L9/5fpv1hgPADAQQ14Qn0yaFKcsaZsq36
	 hWVe4EqRBXVMJ/8/+68qK0alYx452TRjSt4VfGYT0LCRWeVur5orn9Esj70hOcH7N5
	 YyeAUvQkXGyYTlsmDvGIcnAroPDVgX6L0TvHywmTp9xbi5j5Wp7IAtCnL4LtigVkbP
	 U2AmHp0HPUAZizHWcq/eNh+7vYn22n/0qIzOma1t8LQjjJX5IZUs0X97Ae5o5XsNkn
	 bNyPME4QpWm8/CfgZQYwt2Q/rDunvw893DKPQBSptSp7xfoH4vIraAUBj3QGGl5dWH
	 qHEU5YzWWtQdA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Viktor Malik <vmalik@redhat.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH RFC bpf-next 2/4] bpf: Add return prog to kprobe multi
Date: Wed,  7 Feb 2024 16:35:48 +0100
Message-ID: <20240207153550.856536-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207153550.856536-1-jolsa@kernel.org>
References: <20240207153550.856536-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to attach both entry and return bpf program on single
kprobe multi link.

Having entry together with return probe for given function is common
use case for tetragon, bpftrace and most likely for others.

At the moment if we want both entry and return probe to execute bpf
program we need to create two (entry and return probe) links. The link
for return probe creates extra entry probe to setup the return probe.
The extra entry probe execution could be omitted if we had a way to
use just single link for both entry and exit probe.

In addition it's possible to control the execution of the return probe
with the return value of the entry bpf program. If the entry program
returns 0 the return probe is installed and executed, otherwise it's
skip.

Suggested-by: Viktor Malik <vmalik@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       |  4 ++-
 kernel/trace/bpf_trace.c       | 50 ++++++++++++++++++++++++++--------
 tools/include/uapi/linux/bpf.h |  4 ++-
 3 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d96708380e52..9ccd6e6850aa 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1243,7 +1243,8 @@ enum bpf_perf_event_type {
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
  */
 enum {
-	BPF_F_KPROBE_MULTI_RETURN = (1U << 0)
+	BPF_F_KPROBE_MULTI_RETURN      = (1U << 0),
+	BPF_F_KPROBE_MULTI_RETURN_PROG = (1U << 1),
 };
 
 /* link_create.uprobe_multi.flags used in LINK_CREATE command for
@@ -1690,6 +1691,7 @@ union bpf_attr {
 				__aligned_u64	syms;
 				__aligned_u64	addrs;
 				__aligned_u64	cookies;
+				__u32           return_prog_fd;
 			} kprobe_multi;
 			struct {
 				/* this is overlaid with the target_btf_id above. */
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 241ddf5e3895..37e58a132ef0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2587,6 +2587,7 @@ struct bpf_kprobe_multi_link {
 	u32 mods_cnt;
 	struct module **mods;
 	u32 flags;
+	struct bpf_prog *return_prog;
 };
 
 struct bpf_kprobe_multi_run_ctx {
@@ -2663,6 +2664,8 @@ static void bpf_kprobe_multi_link_release(struct bpf_link *link)
 	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
 	unregister_fprobe(&kmulti_link->fp);
 	kprobe_multi_put_modules(kmulti_link->mods, kmulti_link->mods_cnt);
+	if (kmulti_link->return_prog)
+		bpf_prog_put(kmulti_link->return_prog);
 }
 
 static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
@@ -2792,7 +2795,8 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 
 static int
 kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
-			   unsigned long entry_ip, struct pt_regs *regs)
+			   struct bpf_prog *prog, unsigned long entry_ip,
+			   struct pt_regs *regs)
 {
 	struct bpf_kprobe_multi_run_ctx run_ctx = {
 		.link = link,
@@ -2802,7 +2806,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 	int err;
 
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
-		bpf_prog_inc_misses_counter(link->link.prog);
+		bpf_prog_inc_misses_counter(prog);
 		err = 0;
 		goto out;
 	}
@@ -2810,7 +2814,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 	migrate_disable();
 	rcu_read_lock();
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
-	err = bpf_prog_run(link->link.prog, regs);
+	err = bpf_prog_run(prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
 	rcu_read_unlock();
 	migrate_enable();
@@ -2828,8 +2832,8 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
 	struct bpf_kprobe_multi_link *link;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
-	return 0;
+	return kprobe_multi_link_prog_run(link, link->link.prog,
+					  get_entry_ip(fentry_ip), regs);
 }
 
 static void
@@ -2838,9 +2842,11 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
 			       void *data)
 {
 	struct bpf_kprobe_multi_link *link;
+	struct bpf_prog *prog;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
+	prog = link->return_prog ?: link->link.prog;
+	kprobe_multi_link_prog_run(link, prog, get_entry_ip(fentry_ip), regs);
 }
 
 static int symbols_cmp_r(const void *a, const void *b, const void *priv)
@@ -2960,6 +2966,7 @@ static int addrs_check_error_injection_list(unsigned long *addrs, u32 cnt)
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	struct bpf_kprobe_multi_link *link = NULL;
+	struct bpf_prog *return_prog = NULL;
 	struct bpf_link_primer link_primer;
 	void __user *ucookies;
 	unsigned long *addrs;
@@ -2977,7 +2984,8 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		return -EINVAL;
 
 	flags = attr->link_create.kprobe_multi.flags;
-	if (flags & ~BPF_F_KPROBE_MULTI_RETURN)
+	if (flags & ~(BPF_F_KPROBE_MULTI_RETURN |
+		      BPF_F_KPROBE_MULTI_RETURN_PROG))
 		return -EINVAL;
 
 	uaddrs = u64_to_user_ptr(attr->link_create.kprobe_multi.addrs);
@@ -2991,10 +2999,20 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (cnt > MAX_KPROBE_MULTI_CNT)
 		return -E2BIG;
 
+	if (flags & BPF_F_KPROBE_MULTI_RETURN_PROG) {
+		if (flags & BPF_F_KPROBE_MULTI_RETURN)
+			return -EINVAL;
+		return_prog = bpf_prog_get(attr->link_create.kprobe_multi.return_prog_fd);
+		if (IS_ERR(return_prog))
+			return PTR_ERR(return_prog);
+	}
+
 	size = cnt * sizeof(*addrs);
 	addrs = kvmalloc_array(cnt, sizeof(*addrs), GFP_KERNEL);
-	if (!addrs)
-		return -ENOMEM;
+	if (!addrs) {
+		err = -ENOMEM;
+		goto error;
+	}
 
 	ucookies = u64_to_user_ptr(attr->link_create.kprobe_multi.cookies);
 	if (ucookies) {
@@ -3054,15 +3072,21 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (err)
 		goto error;
 
-	if (flags & BPF_F_KPROBE_MULTI_RETURN)
-		link->fp.exit_handler = kprobe_multi_link_exit_handler;
-	else
+	if (flags & BPF_F_KPROBE_MULTI_RETURN_PROG) {
 		link->fp.entry_handler = kprobe_multi_link_handler;
+		link->fp.exit_handler = kprobe_multi_link_exit_handler;
+	} else {
+		if (flags & BPF_F_KPROBE_MULTI_RETURN)
+			link->fp.exit_handler = kprobe_multi_link_exit_handler;
+		else
+			link->fp.entry_handler = kprobe_multi_link_handler;
+	}
 
 	link->addrs = addrs;
 	link->cookies = cookies;
 	link->cnt = cnt;
 	link->flags = flags;
+	link->return_prog = return_prog;
 
 	if (cookies) {
 		/*
@@ -3094,6 +3118,8 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	return bpf_link_settle(&link_primer);
 
 error:
+	if (return_prog)
+		bpf_prog_put(return_prog);
 	kfree(link);
 	kvfree(addrs);
 	kvfree(cookies);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d96708380e52..9ccd6e6850aa 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1243,7 +1243,8 @@ enum bpf_perf_event_type {
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
  */
 enum {
-	BPF_F_KPROBE_MULTI_RETURN = (1U << 0)
+	BPF_F_KPROBE_MULTI_RETURN      = (1U << 0),
+	BPF_F_KPROBE_MULTI_RETURN_PROG = (1U << 1),
 };
 
 /* link_create.uprobe_multi.flags used in LINK_CREATE command for
@@ -1690,6 +1691,7 @@ union bpf_attr {
 				__aligned_u64	syms;
 				__aligned_u64	addrs;
 				__aligned_u64	cookies;
+				__u32           return_prog_fd;
 			} kprobe_multi;
 			struct {
 				/* this is overlaid with the target_btf_id above. */
-- 
2.43.0


