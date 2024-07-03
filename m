Return-Path: <bpf+bounces-33751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701B1925809
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 12:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E7A1B27D11
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 10:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDEE172777;
	Wed,  3 Jul 2024 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxIYkZcG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03458143758;
	Wed,  3 Jul 2024 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001473; cv=none; b=KTVqYdoCKAAeQteHO0qzCneqYKdc9KkVg/o+PM0S59iWEZKQyGpDP5smLYCCZgVEVIsdnCT1aotCTcCuxBm+17St5pn6UEwHOpO8WfLIsY0jntW2LGYPWTgOjCjCvYyhFKZAjUmp6R4LxXAXoiONQ48OiBh18oTwUziTMaKA2TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001473; c=relaxed/simple;
	bh=OtlEX+N2t22ZO0stHC9uK5V+uqtQ/aaFzUaCS8qHyPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcPo7Ox3UUB8f44u94aMEROifIOqfG1ICZbE8e2boWjMVK/gax0hbvnQwDmcUHB2Rk/hQ+yCE8sTqTxNU7gDuAKjA/YG4o5/5MrXGGi1373PokQanw2YLtX1+gcHTEzV1MBtmk8LhA8dBvVub8yvbpn+D9p0/j1KAEWg8gGrsyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxIYkZcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1432AC32781;
	Wed,  3 Jul 2024 10:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720001472;
	bh=OtlEX+N2t22ZO0stHC9uK5V+uqtQ/aaFzUaCS8qHyPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxIYkZcGUcc9gfnGdG5yW4Jmigr8H/S6zs9NwCzHe8JfCciF5l0zxi4aJnysN8pjV
	 a1maAmcFMJfTPznNccowSoqXMj2c1K4RTfSiGZtEUIVwZkujCDJ0pfQifJ0GxtrHYC
	 Aq/BezJWWthV/f5iWNH3gG7g9m6nnGXoYIcFdXt0UAyeU3MICY4PtcCfTwDi4Jrx+D
	 SQTW/jJ2G8htqoJmcLUVReCAXX0m9jXm5cnVt5++w39xs3KpGqrqpdXZZ7koj97umo
	 L9ZrBi5lf7rkayW/qDnR7EqGm81egFKwfOpy4zmZV+Wrqtw2JwlPIg6yMBywlH/9L+
	 AclTEGVZ5McDg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guo Ren <guoren@kernel.org>
Subject: [PATCH v12 11/19] bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
Date: Wed,  3 Jul 2024 19:11:07 +0900
Message-Id: <172000146719.63468.13245486388278577139.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172000134410.63468.13742222887213469474.stgit@devnote2>
References: <172000134410.63468.13742222887213469474.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Enable kprobe_multi feature if CONFIG_FPROBE is enabled. The pt_regs is
converted from ftrace_regs by ftrace_partial_regs(), thus some registers
may always returns 0. But it should be enough for function entry (access
arguments) and exit (access return value).

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Florent Revest <revest@chromium.org>
---
 Changes in v9:
  - Avoid wasting memory for bpf_kprobe_multi_pt_regs when
    CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST=y
---
 kernel/trace/bpf_trace.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f72b421abe9b..77fd63027286 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2602,7 +2602,7 @@ struct bpf_session_run_ctx {
 	void *data;
 };
 
-#if defined(CONFIG_FPROBE) && defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
+#ifdef CONFIG_FPROBE
 struct bpf_kprobe_multi_link {
 	struct bpf_link link;
 	struct fprobe fp;
@@ -2625,6 +2625,13 @@ struct user_syms {
 	char *buf;
 };
 
+#ifndef CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST
+static DEFINE_PER_CPU(struct pt_regs, bpf_kprobe_multi_pt_regs);
+#define bpf_kprobe_multi_pt_regs_ptr()	this_cpu_ptr(&bpf_kprobe_multi_pt_regs)
+#else
+#define bpf_kprobe_multi_pt_regs_ptr()	(NULL)
+#endif
+
 static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32 cnt)
 {
 	unsigned long __user usymbol;
@@ -2819,7 +2826,7 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 
 static int
 kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
-			   unsigned long entry_ip, struct pt_regs *regs,
+			   unsigned long entry_ip, struct ftrace_regs *fregs,
 			   bool is_return, void *data)
 {
 	struct bpf_kprobe_multi_run_ctx run_ctx = {
@@ -2831,6 +2838,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 		.entry_ip = entry_ip,
 	};
 	struct bpf_run_ctx *old_run_ctx;
+	struct pt_regs *regs;
 	int err;
 
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
@@ -2841,6 +2849,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 
 	migrate_disable();
 	rcu_read_lock();
+	regs = ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_ptr());
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
@@ -2857,15 +2866,11 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
 			  unsigned long ret_ip, struct ftrace_regs *fregs,
 			  void *data)
 {
-	struct pt_regs *regs = ftrace_get_regs(fregs);
 	struct bpf_kprobe_multi_link *link;
 	int err;
 
-	if (!regs)
-		return 0;
-
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, false, data);
+	err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), fregs, false, data);
 	return is_kprobe_session(link->link.prog) ? err : 0;
 }
 
@@ -2875,13 +2880,9 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
 			       void *data)
 {
 	struct bpf_kprobe_multi_link *link;
-	struct pt_regs *regs = ftrace_get_regs(fregs);
-
-	if (!regs)
-		return;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, true, data);
+	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), fregs, true, data);
 }
 
 static int symbols_cmp_r(const void *a, const void *b, const void *priv)
@@ -3142,7 +3143,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	kvfree(cookies);
 	return err;
 }
-#else /* !CONFIG_FPROBE || !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+#else /* !CONFIG_FPROBE */
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	return -EOPNOTSUPP;


