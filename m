Return-Path: <bpf+bounces-10721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5747AC9BB
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 15:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EB08328169F
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 13:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83B7CA66;
	Sun, 24 Sep 2023 13:37:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D5CA53;
	Sun, 24 Sep 2023 13:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5909EC433C8;
	Sun, 24 Sep 2023 13:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695562676;
	bh=FEfGDz6clxZ9PLKtBAXOYmli6LSrFixQDspF7u/Z4KA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUhxY4N8h3ShSDm2qYxveksvNl9zrO2XDzm2UaaVojXVnQrGNh+H6DYGuxn/NNlqj
	 btDQMa8Lp6z5LAEwgsx1ooN6yll4I1549gag/udsMHgDxg8jVgLUELsvsRiwwaD8SZ
	 d39JuIuxXZKH2zhdTwqlI7KRzuTedHAYT/fr9E5NsPCCHlDWTK01If8Dy6tW3UvD9b
	 ecguWWebaF78uUGf3swAMjGj3Tm/7gKa4qZqCs6hPskHFYoJdF1UC/YekLBEUPUpr5
	 AadOSeUAGI673e+JmebPT3pq1IXStV6K/Jl8n4n38MvkEddiFZQKSX6geivcghXsbJ
	 ntOcH7s15m+Gw==
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
Subject: [PATCH v5 10/12] bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
Date: Sun, 24 Sep 2023 22:37:49 +0900
Message-Id: <169556266942.146934.6508273802845934438.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169556254640.146934.5654329452696494756.stgit@devnote2>
References: <169556254640.146934.5654329452696494756.stgit@devnote2>
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
 kernel/trace/bpf_trace.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 8bb003ce7bb2..808acd56e432 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2501,7 +2501,7 @@ static int __init bpf_event_init(void)
 fs_initcall(bpf_event_init);
 #endif /* CONFIG_MODULES */
 
-#if defined(CONFIG_FPROBE) && defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
+#ifdef CONFIG_FPROBE
 struct bpf_kprobe_multi_link {
 	struct bpf_link link;
 	struct fprobe fp;
@@ -2524,6 +2524,8 @@ struct user_syms {
 	char *buf;
 };
 
+static DEFINE_PER_CPU(struct pt_regs, bpf_kprobe_multi_pt_regs);
+
 static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32 cnt)
 {
 	unsigned long __user usymbol;
@@ -2700,13 +2702,14 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 
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
@@ -2716,6 +2719,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 
 	migrate_disable();
 	rcu_read_lock();
+	regs = ftrace_partial_regs(fregs, this_cpu_ptr(&bpf_kprobe_multi_pt_regs));
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
@@ -2733,13 +2737,9 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
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
 
@@ -2749,13 +2749,9 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
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
@@ -2996,7 +2992,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	kvfree(cookies);
 	return err;
 }
-#else /* !CONFIG_FPROBE || !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+#else /* !CONFIG_FPROBE */
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	return -EOPNOTSUPP;


