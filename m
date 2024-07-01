Return-Path: <bpf+bounces-33515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CBB91E58D
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 18:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492541C214E4
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 16:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C49C16DC20;
	Mon,  1 Jul 2024 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot1sWCaM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDD216D9D4;
	Mon,  1 Jul 2024 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852145; cv=none; b=Pwxfu244sdRT4iy2vcvK+4hF4HYv0yeA4PCkKVGzgzbhq+05LoMayhOyi+z1IdmvvKLAoinZDta6E3oPc1FW3dmgJBUlIHVvIanlDk1XASunqZ2xzvOAl/ar3V+uhDb8FI/yS8XaT0flqePjZFegsFL04cT6Cxou2VJAKyw2QyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852145; c=relaxed/simple;
	bh=O8uwJGrSkGhVs2iDn7X37DF1L6JmCLleefXOJnbJU/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UK9zAgPMzKJUEOB48MmF2Kmr1pE2C3I/AF+xW5Kx6eVXgu/hrVnvCY6ddeAxR2r1jelzAogalfYuu2Ng/f0hgLWHyLB9qB9vhYGUX/IRz4O/s0ok7JX39iK2udmC9yVeLSCSdz0Bdiy0jEJa9eVazZrY10e4q2llkantk4inrxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ot1sWCaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A58C116B1;
	Mon,  1 Jul 2024 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719852145;
	bh=O8uwJGrSkGhVs2iDn7X37DF1L6JmCLleefXOJnbJU/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ot1sWCaMQLIahGmBEJuSGeD+ZDMmc3AMTu4qOl5nosL3bKkuWr3iSITmn05cfD+3E
	 zaZJTDRnl5GCxb/0aouUZ6w4X8kO3wbY4Iv/VvxbzcCRK/G1J/KbEIL9exAVcDz07X
	 e/p7Ftv+GDUlI+eBT9ZVwYMEQ/TkK8X13pE4dWaUHVXqs7rZZgAmb+W5aQBCSiljdp
	 v09IocmLkM7eonvUf8/zjPtW7YbTKxl7p9sn6GVpWWFFo5cgR5qSuoRDtmvmkfMAyQ
	 9FyZqCk92MfG8cqJE/mkKxtMzcH11gm/wtxzuqNNGiIBeDSjs8iQO4TuHRPHEomzRF
	 JpNVHUcx9SqHg==
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 bpf-next 3/9] bpf: Add support for uprobe multi session context
Date: Mon,  1 Jul 2024 18:41:09 +0200
Message-ID: <20240701164115.723677-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701164115.723677-1-jolsa@kernel.org>
References: <20240701164115.723677-1-jolsa@kernel.org>
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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1b19c1cdb5e1..d431b880ca11 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3184,7 +3184,7 @@ struct bpf_uprobe_multi_link {
 };
 
 struct bpf_uprobe_multi_run_ctx {
-	struct bpf_run_ctx run_ctx;
+	struct bpf_session_run_ctx session_ctx;
 	unsigned long entry_ip;
 	struct bpf_uprobe *uprobe;
 };
@@ -3297,10 +3297,15 @@ static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
 
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
@@ -3319,7 +3324,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 
 	migrate_disable();
 
-	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
 
@@ -3349,7 +3354,7 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
 	struct bpf_uprobe *uprobe;
 
 	uprobe = container_of(con, struct bpf_uprobe, consumer);
-	return uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
+	return uprobe_prog_run(uprobe, instruction_pointer(regs), regs, false, data);
 }
 
 static int
@@ -3359,14 +3364,15 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
 	struct bpf_uprobe *uprobe;
 
 	uprobe = container_of(con, struct bpf_uprobe, consumer);
-	return uprobe_prog_run(uprobe, func, regs);
+	return uprobe_prog_run(uprobe, func, regs, true, data);
 }
 
 static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 {
 	struct bpf_uprobe_multi_run_ctx *run_ctx;
 
-	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx, run_ctx);
+	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx,
+			       session_ctx.run_ctx);
 	return run_ctx->entry_ip;
 }
 
@@ -3374,7 +3380,8 @@ static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
 {
 	struct bpf_uprobe_multi_run_ctx *run_ctx;
 
-	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx, run_ctx);
+	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx,
+			       session_ctx.run_ctx);
 	return run_ctx->uprobe->cookie;
 }
 
@@ -3565,7 +3572,7 @@ static int bpf_kprobe_multi_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	if (!btf_id_set8_contains(&kprobe_multi_kfunc_set_ids, kfunc_id))
 		return 0;
 
-	if (!is_kprobe_session(prog))
+	if (!is_kprobe_session(prog) && !is_uprobe_session(prog))
 		return -EACCES;
 
 	return 0;
-- 
2.45.2


