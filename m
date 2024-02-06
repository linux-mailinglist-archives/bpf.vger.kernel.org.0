Return-Path: <bpf+bounces-21343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7293F84B93F
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1981F2140F
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 15:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4A013B7AF;
	Tue,  6 Feb 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMcuttnA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB2D131E56;
	Tue,  6 Feb 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232400; cv=none; b=qJIAy5e78FzRIGT0ow1Wtj2jpnWx7jv0wG91ymi+4mZB1/3G3rzmtbt7TNV3ehT7jVXQWODGIQK+cVYMcbRtpmmwhEQMURD2S1KQEBwxupe8chbLzvL64u/HN9UAFSw48jRMdOqvpCp+hQbbm6aJdtsDcKgCsRBij1P0JJynyS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232400; c=relaxed/simple;
	bh=zgVjHsibf80Ba7/uhgykpeSact93x0IdExGXz3s/bRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lumOfqvs0b97SDYGqeTN+9M/17u5vVZf4CmhqHaOaMUfcLXgvGYB5ZK6l9cyltC/RmVFVXzEplzJkARq0mK5LrvlkinF7wDhXro4z1ptVkjGRwptzkQLPPHh3IQChNu4Z3khJbp/C7ibONhJK8yZ6O3ujwJ3nKaCZD7hij3KSUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMcuttnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FB5C433C7;
	Tue,  6 Feb 2024 15:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707232400;
	bh=zgVjHsibf80Ba7/uhgykpeSact93x0IdExGXz3s/bRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMcuttnAwPajr0EAax7Mf2KawlZ7VzkM6WET9CCxRo5RK+nwSxnojiIv8vWCePp+1
	 QnpcUAjdz5MlOUILH98Q18C4BvpScsR54n3qRk7an+r/nfXQJpjpZyveZ5fcA0NTkk
	 FVAFEDhUNuHRxMHMBfVo44Z5neKS2weXZ1ZhtA6R4IagBgH6JthoWypbas2lUwyG0z
	 dWKvyaHY/aazwVhZ6fWbGmUI5c6caQZgrgPDIXaAHSEaXptjt32pohSTAE/bwqUiua
	 wdwu1yM2l3LYlIw/Nhulrz3ZsURO0XBnJCzvOP+UkV3bachBN20BVYKmaHclt9oCEf
	 o0N5fUoH7vgng==
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
Subject: [PATCH v7 31/36] bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
Date: Wed,  7 Feb 2024 00:13:13 +0900
Message-Id: <170723239387.502590.7145597542791935266.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170723204881.502590.11906735097521170661.stgit@devnote2>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
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
 Changes from previous series: NOTHING, Update against the new series.
---
 kernel/trace/bpf_trace.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 115c4166ac00..5ad3c32b1c40 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2577,7 +2577,7 @@ static int __init bpf_event_init(void)
 fs_initcall(bpf_event_init);
 #endif /* CONFIG_MODULES */
 
-#if defined(CONFIG_FPROBE) && defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
+#ifdef CONFIG_FPROBE
 struct bpf_kprobe_multi_link {
 	struct bpf_link link;
 	struct fprobe fp;
@@ -2600,6 +2600,8 @@ struct user_syms {
 	char *buf;
 };
 
+static DEFINE_PER_CPU(struct pt_regs, bpf_kprobe_multi_pt_regs);
+
 static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32 cnt)
 {
 	unsigned long __user usymbol;
@@ -2777,13 +2779,14 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 
 static int
 kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
-			   unsigned long entry_ip, struct pt_regs *regs)
+			   unsigned long entry_ip, struct ftrace_regs *fregs)
 {
 	struct bpf_kprobe_multi_run_ctx run_ctx = {
 		.link = link,
 		.entry_ip = entry_ip,
 	};
 	struct bpf_run_ctx *old_run_ctx;
+	struct pt_regs *regs;
 	int err;
 
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
@@ -2794,6 +2797,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 
 	migrate_disable();
 	rcu_read_lock();
+	regs = ftrace_partial_regs(fregs, this_cpu_ptr(&bpf_kprobe_multi_pt_regs));
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
@@ -2811,13 +2815,9 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
 			  void *data)
 {
 	struct bpf_kprobe_multi_link *link;
-	struct pt_regs *regs = ftrace_get_regs(fregs);
-
-	if (!regs)
-		return 0;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
+	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), fregs);
 	return 0;
 }
 
@@ -2827,13 +2827,9 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
 			       void *data)
 {
 	struct bpf_kprobe_multi_link *link;
-	struct pt_regs *regs = ftrace_get_regs(fregs);
-
-	if (!regs)
-		return;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
+	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), fregs);
 }
 
 static int symbols_cmp_r(const void *a, const void *b, const void *priv)
@@ -3092,7 +3088,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	kvfree(cookies);
 	return err;
 }
-#else /* !CONFIG_FPROBE || !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+#else /* !CONFIG_FPROBE */
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	return -EOPNOTSUPP;


