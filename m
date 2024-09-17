Return-Path: <bpf+bounces-40027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C41497AD18
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 10:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F16F1C21156
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 08:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A571591EA;
	Tue, 17 Sep 2024 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HV4undIu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D514BFBF;
	Tue, 17 Sep 2024 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563083; cv=none; b=W+WydSc0aF/aPoVB1tPQUqByUa7//NtVg2XBPohonIq8MwKUbeNlHt/tg0t7DQ0M9a0m9kMhwCo7q9X8oK7PcvjrQB55S8pMoFuYGfhK7Qeoisc1/mVZZsRxkmHl9kQmkTFgoqUovRcHG7VS6Sfkzlc0EWs+5SDWqyzY+hP3DDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563083; c=relaxed/simple;
	bh=E5ksyVpxSxCr84wbzqQecnCcRAmkbzdRXeqaxZgzDAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjHKFudTedRDUOXuc7PRczjODkr+l7FyRk8IQUZWl3huRI7MAlMus1ADlDEztBwiHwgC+R8ekRDy1v9OQYdPDajMx6qMNS6Ukjna022Cv75FBTOapaYcUx9Q2EClVTZUXNorH6nWFGxKSW/zDNKCnRJr+LrV5cJ5Z7IisifyudU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HV4undIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74D8C4CEC5;
	Tue, 17 Sep 2024 08:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563082;
	bh=E5ksyVpxSxCr84wbzqQecnCcRAmkbzdRXeqaxZgzDAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HV4undIuFFhagswIduRHdKj+/C0WeX/RVy8WqGPRx0pIJH6ZlwwYOAmC2FOq9YAfF
	 paiFkPLgG4D5OCt7n8yXI/ZFdHXbJalZLoXm0UnVGzXAgm8anExBBPPL3c/whrw8UG
	 bkCFQfYJa+F7eCO19NMdW03vJIXjTJotB4CpF0lszHEoJkU6dVI+8wqWrexcIurWs4
	 rs/ZbmY1u2OmRQyQle5vBtd8i7YKJNSH72OTRoJbj9RLs5387uoon1DF5YzhickQMQ
	 4tBUYzP+WAeEK2wO72JnY/wf0lOrlDWbH6dA17gkrNORBjYw4UTDj2rOJU9Jsm9HU1
	 NMIH5c7P85oxg==
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
Subject: [PATCHv4 04/14] bpf: Add support for uprobe multi session context
Date: Tue, 17 Sep 2024 10:50:14 +0200
Message-ID: <20240917085024.765883-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917085024.765883-1-jolsa@kernel.org>
References: <20240917085024.765883-1-jolsa@kernel.org>
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
index 63ea457af16a..b6f377f1ce5f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3186,7 +3186,7 @@ struct bpf_uprobe_multi_link {
 };
 
 struct bpf_uprobe_multi_run_ctx {
-	struct bpf_run_ctx run_ctx;
+	struct bpf_session_run_ctx session_ctx;
 	unsigned long entry_ip;
 	struct bpf_uprobe *uprobe;
 };
@@ -3299,10 +3299,15 @@ static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
 
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
@@ -3321,7 +3326,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 
 	migrate_disable();
 
-	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
 
@@ -3351,7 +3356,7 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
 	int ret;
 
 	uprobe = container_of(con, struct bpf_uprobe, consumer);
-	ret = uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
+	ret = uprobe_prog_run(uprobe, instruction_pointer(regs), regs, false, data);
 	if (uprobe->session)
 		return ret ? UPROBE_HANDLER_IGNORE : UPROBE_HANDLER_IWANTMYCOOKIE;
 	return ret;
@@ -3370,14 +3375,15 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
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
 
@@ -3385,7 +3391,8 @@ static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
 {
 	struct bpf_uprobe_multi_run_ctx *run_ctx;
 
-	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx, run_ctx);
+	run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx,
+			       session_ctx.run_ctx);
 	return run_ctx->uprobe->cookie;
 }
 
@@ -3579,7 +3586,7 @@ static int bpf_kprobe_multi_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	if (!btf_id_set8_contains(&kprobe_multi_kfunc_set_ids, kfunc_id))
 		return 0;
 
-	if (!is_kprobe_session(prog))
+	if (!is_kprobe_session(prog) && !is_uprobe_session(prog))
 		return -EACCES;
 
 	return 0;
-- 
2.46.0


