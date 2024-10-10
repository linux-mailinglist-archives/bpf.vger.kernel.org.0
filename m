Return-Path: <bpf+bounces-41625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C59A299936F
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754EB282E1D
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2B61DFDB0;
	Thu, 10 Oct 2024 20:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cF2ErTXG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E97F1CFEC9;
	Thu, 10 Oct 2024 20:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591077; cv=none; b=FWqzfHIvHOuB3Wt01F8h6YwpgEze6wZQiJwYa+pRcNl2dqNlE3cABgHZbTXo4eomQFPnBDREOBpc1rBt6/13ZjPR/6yyPHVC3KiFbF7RFwQrCHaTkd0rMEK1YGObUHH3GfawJxwCzOx+VkacT+evvaMFxuY1MoSAvnUhejbUkUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591077; c=relaxed/simple;
	bh=EZ76JiF8nHrXB5Od2azxqfLxETX83Z2xeo/fMdQY5Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6idl4gxxxsUhk2STB9aoNgOs6QBeRCbguS+yMjeQDDAr5kD4x29tuFcoOfS3TsWNIEs9/p7emL4n9ns1bKbudAvCstyU4cJ4xO6mnLLD8n8r4OA/Cpds9oeay5jdffh18zQ8Qhx1kSqNmxc6AZ3vfSMPpF3sdFbtoeK2pP7nTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cF2ErTXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2246CC4CEC5;
	Thu, 10 Oct 2024 20:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728591077;
	bh=EZ76JiF8nHrXB5Od2azxqfLxETX83Z2xeo/fMdQY5Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cF2ErTXGVbFDjXDANDHwP0gBUVrnmRBbDVo6HY/7zOha/O3Y6bIkkOgPpH9in9LFp
	 r4mh65sxyficJylPHDwQIOyKJpOtN9mZkczejeouF/FM2ip1oTTE6T+4JaE1F/Zsy5
	 Nn3uHtG4X2kqt2+YmF4SkUVMtG4BFCt/RAEXUNiLkSu07pJ4rpNdOI/g565di9Y4aO
	 npKjrqbC2PthmQBqUGnFTTyc+nN00HNajDuqb9Z5HhDGIjPsHiZ4LsHI031E5LC2ji
	 OH1z9HPQhw8f6+R0PxsIu5e82GKsvO3AFQwnjmREjrZu3XOV0MtAuR08V7hnpggt8g
	 UoYvOLOMMkbIQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv6 bpf-next 06/16] bpf: Add support for uprobe multi session context
Date: Thu, 10 Oct 2024 22:09:47 +0200
Message-ID: <20241010200957.2750179-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010200957.2750179-1-jolsa@kernel.org>
References: <20241010200957.2750179-1-jolsa@kernel.org>
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


