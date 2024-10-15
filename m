Return-Path: <bpf+bounces-41988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 491FE99E28A
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 11:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AED24B21283
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 09:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE9B1E5018;
	Tue, 15 Oct 2024 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgMwAVdZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD01CDA0A
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983520; cv=none; b=jc7TZ+lMB3+LETsBd4cVa4Szc/2ITuaZrgeJYmTefHQodg5jf47wTS8SIsWNkPX1uDW2Z5D8S0FaUYR71mD/RuUVn6sivZKZhBsbig4R0lAeCQQ/1+Nnyn5FW0PfbFdDjh6tAibTSexbun76GSGomosQKZsGLG+EL7snDME56MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983520; c=relaxed/simple;
	bh=EZ76JiF8nHrXB5Od2azxqfLxETX83Z2xeo/fMdQY5Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tb3p3p3wsOJ0HZq+1wLyh664oGq02cX2W64TeKULhd6dobz3F0NScSsgYkYe13LLh30PA2zK002hlV3QlnR7ZOb1kbgHTtTujBM8gJpRoG8IGYlAud4n7w6ld0a6pamvDr8/zmnmdQFDqky+dKzRLjumMsdA+ueke7y6LqPsrh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgMwAVdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8BCC4CEC6;
	Tue, 15 Oct 2024 09:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728983518;
	bh=EZ76JiF8nHrXB5Od2azxqfLxETX83Z2xeo/fMdQY5Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BgMwAVdZgfYC5ulZExkdztGqi56izG4+SMqLx++XLnL6EchhEh5Xc+H6uUKKMRno7
	 ObS10uu4SLL5AS++qjeu6U6P37TMKcaM8FFH6+I+WyC0pbLaFy46/4GnKphtXMMZF1
	 HNYSCbQwbPjQ1a2tLemFl8QHh1XZKkZWyYvz4ZeSoGyaSBv3ZEZJZ3fXthQQb4U8un
	 dNAAtDJWUNXh2CzTDbWWsXf4QDS1ymhrEDLA4GvNyoW4+pIZy21n9cH/J0qURzUcFN
	 wW2MUxK4656cJzXrx3nviFx7ZMnUda0edwajb+pDAZyuZlcxsAts28MxmkKwbfC2zL
	 5CU3ylJVdlWDw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv7 bpf-next 06/15] bpf: Add support for uprobe multi session context
Date: Tue, 15 Oct 2024 11:10:41 +0200
Message-ID: <20241015091050.3731669-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015091050.3731669-1-jolsa@kernel.org>
References: <20241015091050.3731669-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Placing bpf_session_run_ctx layer in between bpf_run_ctx and
bpf_uprobe_multi_run_ctx, so the session data can be retrieved
from uprobe_multi link.

Plus granting session kfuncs access to uprobe session programs.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 5f10994376d0..01868039d7bc 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3098,7 +3098,7 @@ struct bpf_uprobe_multi_link {
 };
 
 struct bpf_uprobe_multi_run_ctx {
-	struct bpf_run_ctx run_ctx;
+	struct bpf_session_run_ctx session_ctx;
 	unsigned long entry_ip;
 	struct bpf_uprobe *uprobe;
 };
@@ -3211,16 +3211,22 @@ static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
 
 static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 			   unsigned long entry_ip,
-			   struct pt_regs *regs)
+			   struct pt_regs *regs,
+			   bool is_return, void *data)
 {
 	struct bpf_uprobe_multi_link *link = uprobe->link;
 	struct bpf_uprobe_multi_run_ctx run_ctx = {
+		.session_ctx = {
+			.is_return = is_return,
+			.data = data,
+		},
 		.entry_ip = entry_ip,
 		.uprobe = uprobe,
 	};
 	struct bpf_prog *prog = link->link.prog;
 	bool sleepable = prog->sleepable;
 	struct bpf_run_ctx *old_run_ctx;
+	int err;
 
 	if (link->task && !same_thread_group(current, link->task))
 		return 0;
@@ -3232,8 +3238,8 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 
 	migrate_disable();
 
-	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
-	bpf_prog_run(link->link.prog, regs);
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
+	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
 
 	migrate_enable();
@@ -3242,7 +3248,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 		rcu_read_unlock_trace();
 	else
 		rcu_read_unlock();
-	return 0;
+	return err;
 }
 
 static bool
@@ -3262,7 +3268,7 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
 	int ret;
 
 	uprobe = container_of(con, struct bpf_uprobe, consumer);
-	ret = uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
+	ret = uprobe_prog_run(uprobe, instruction_pointer(regs), regs, false, data);
 	if (uprobe->session)
 		return ret ? UPROBE_HANDLER_IGNORE : 0;
 	return 0;
@@ -3275,7 +3281,7 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
 	struct bpf_uprobe *uprobe;
 
 	uprobe = container_of(con, struct bpf_uprobe, consumer);
-	uprobe_prog_run(uprobe, func, regs);
+	uprobe_prog_run(uprobe, func, regs, true, data);
 	return 0;
 }
 
@@ -3283,7 +3289,8 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 {
 	struct bpf_uprobe_multi_run_ctx *run_ctx;
 
-	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx, run_ctx);
+	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx,
+			       session_ctx.run_ctx);
 	return run_ctx->entry_ip;
 }
 
@@ -3291,7 +3298,8 @@ static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
 {
 	struct bpf_uprobe_multi_run_ctx *run_ctx;
 
-	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx, run_ctx);
+	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx,
+			       session_ctx.run_ctx);
 	return run_ctx->uprobe->cookie;
 }
 
@@ -3485,7 +3493,7 @@ static int bpf_kprobe_multi_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	if (!btf_id_set8_contains(&kprobe_multi_kfunc_set_ids, kfunc_id))
 		return 0;
 
-	if (!is_kprobe_session(prog))
+	if (!is_kprobe_session(prog) && !is_uprobe_session(prog))
 		return -EACCES;
 
 	return 0;
-- 
2.46.2


