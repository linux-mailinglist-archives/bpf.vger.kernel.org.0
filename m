Return-Path: <bpf+bounces-40519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3B2989771
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 22:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8201EB21D65
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 20:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0684317BB11;
	Sun, 29 Sep 2024 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koSi4l1k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AE813B58C;
	Sun, 29 Sep 2024 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727643494; cv=none; b=Fr/IgpO9S504TL4/cLsstw/zG+LHDPGsSLTmqMIDVsP05yFB4o5ewWjGF1p797ZNFXCACDHZJ4FGWTOfiZTRqpCgJZIYiWXzQekrQryPVXjEjn7LKzyOZcMXsLmpeXGnFeGt+u0LWikvIr+wIEQRPYWlffY8sGV4txCRXFixpXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727643494; c=relaxed/simple;
	bh=X2c9rNtwRNPonQHvHspo6tt2WiHF3JstxCqP0Vs89JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ehoiyh+T4awimgpgGwni16qCZXUlvQE7aBSuE3VVAEMh+a+e6CjHxqjjd+l85eARMibyrt4+zF9zUFF6DsOyJgQ0CnEVnXTVP+AEwX7/H4l/5uoCQ4UODFC2B5rsSiyrOG62b9+stRpIfpZ6Sb+UT5Kb8M4oCLKus96LxRJKIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koSi4l1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D06C4CEC5;
	Sun, 29 Sep 2024 20:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727643494;
	bh=X2c9rNtwRNPonQHvHspo6tt2WiHF3JstxCqP0Vs89JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=koSi4l1kDhnDWh64tDaQZwoRcRoAyTSjSM5xNGW3n0DClO40kgdeZ7n+WzyF+rYC/
	 oZ1LNbDmT3ZBFxdqWwVDcTbB3zXPfqQlGVKGv/x7gJvXQK7ddGkndm8IBER6xPZjIB
	 q2ABLZ4s8ErnDZ7l4OZWu6v91PfvcOAK20/EHBcYFuNGgcuymV4H95E3fPS7Nn4Xcu
	 Vd3O7UnXJx1iKsfClXw2VXpX7Q7J94xDOGGS0Ci7G2MPmPM9tTVEjSFEX5nzb0dtXl
	 O5RxTdTVa08MKjU0jEjBU1c373d3pPTuVy5Yw9VAbQjff4LMnuJEzYQZcUq424HSui
	 MXdZ0Y/jSmKMQ==
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
Subject: [PATCHv5 bpf-next 04/13] bpf: Add support for uprobe multi session context
Date: Sun, 29 Sep 2024 22:57:08 +0200
Message-ID: <20240929205717.3813648-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240929205717.3813648-1-jolsa@kernel.org>
References: <20240929205717.3813648-1-jolsa@kernel.org>
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
 kernel/trace/bpf_trace.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 98e940ec184d..41f83d504bf6 100644
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
@@ -3211,10 +3211,15 @@ static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
 
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
@@ -3233,7 +3238,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 
 	migrate_disable();
 
-	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
 
@@ -3263,7 +3268,7 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
 	int ret;
 
 	uprobe = container_of(con, struct bpf_uprobe, consumer);
-	ret = uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
+	ret = uprobe_prog_run(uprobe, instruction_pointer(regs), regs, false, data);
 	if (uprobe->session)
 		return ret ? UPROBE_HANDLER_IGNORE : 0;
 	return ret;
@@ -3282,14 +3287,15 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
 	 */
 	if (uprobe->session && !data)
 		return 0;
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
 
@@ -3297,7 +3303,8 @@ static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
 {
 	struct bpf_uprobe_multi_run_ctx *run_ctx;
 
-	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx, run_ctx);
+	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx,
+			       session_ctx.run_ctx);
 	return run_ctx->uprobe->cookie;
 }
 
@@ -3491,7 +3498,7 @@ static int bpf_kprobe_multi_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	if (!btf_id_set8_contains(&kprobe_multi_kfunc_set_ids, kfunc_id))
 		return 0;
 
-	if (!is_kprobe_session(prog))
+	if (!is_kprobe_session(prog) && !is_uprobe_session(prog))
 		return -EACCES;
 
 	return 0;
-- 
2.46.1


