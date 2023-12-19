Return-Path: <bpf+bounces-18346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 496F68193DD
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 23:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7208A1C24F66
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 22:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC5B3D0B3;
	Tue, 19 Dec 2023 22:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6xev0+F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EF33DB8C;
	Tue, 19 Dec 2023 22:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FADC433C7;
	Tue, 19 Dec 2023 22:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703026326;
	bh=3d5e2aUYMvcozpuqzXim5hohQZk4N3N4SmHcyRdCntc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T6xev0+FV3fDb/mYUfcl5Fmn8BtiZ468wXbAb/2c6ecNu9SAKggagRcWZY7DU4BBI
	 6PNDDEVEaW07keZLg21OseWmJGb/+sz0GN/KnB5mOpHWfyuBxrApnnNij7Maksf9Zi
	 ja5m+cfCSsWf3VoeCiHYrSovHe7wYCQgLC4NZmRB6BPCCq23mB7XFxpsQTlMGoUIWY
	 tcSuUirvRD747eZUmD/16B6qTTUS0QIO9+7Ix4XH3WIPBmrxXAXN9a9opmie35dSYc
	 U2t6A7yooWn0Ta4uCpR/TPzAqd2ML79AK6EFzxxL0KNAbi3HgU+vLtWO1TiqkhAdTO
	 RiazzkQJhSORQ==
Date: Wed, 20 Dec 2023 07:51:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>, Mark
 Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v5 24/34] fprobe: Use ftrace_regs in fprobe entry
 handler
Message-Id: <20231220075159.a999e25dbf56f0334ba79249@kernel.org>
In-Reply-To: <ZYGZZES--JmqQN_v@krava>
References: <170290509018.220107.1347127510564358608.stgit@devnote2>
	<170290538307.220107.14964448383069008953.stgit@devnote2>
	<ZYGZZES--JmqQN_v@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 14:23:48 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Mon, Dec 18, 2023 at 10:16:23PM +0900, Masami Hiramatsu (Google) wrote:
> 
> SNIP
> 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 84e8a0f6e4e0..d3f8745d8ead 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2503,7 +2503,7 @@ static int __init bpf_event_init(void)
> >  fs_initcall(bpf_event_init);
> >  #endif /* CONFIG_MODULES */
> >  
> > -#ifdef CONFIG_FPROBE
> > +#if defined(CONFIG_FPROBE) && defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
> >  struct bpf_kprobe_multi_link {
> >  	struct bpf_link link;
> >  	struct fprobe fp;
> > @@ -2733,10 +2733,14 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
> >  
> >  static int
> >  kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
> > -			  unsigned long ret_ip, struct pt_regs *regs,
> > +			  unsigned long ret_ip, struct ftrace_regs *fregs,
> >  			  void *data)
> >  {
> >  	struct bpf_kprobe_multi_link *link;
> > +	struct pt_regs *regs = ftrace_get_regs(fregs);
> > +
> > +	if (!regs)
> > +		return 0;
> >  
> >  	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
> >  	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> > @@ -3008,7 +3012,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >  	kvfree(cookies);
> >  	return err;
> >  }
> > -#else /* !CONFIG_FPROBE */
> > +#else /* !CONFIG_FPROBE || !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> >  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> >  {
> >  	return -EOPNOTSUPP;
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 6cd2a4e3afb8..f12569494d8a 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -46,7 +46,7 @@ static inline void __fprobe_handler(unsigned long ip, unsigned long parent_ip,
> >  	}
> >  
> >  	if (fp->entry_handler)
> > -		ret = fp->entry_handler(fp, ip, parent_ip, ftrace_get_regs(fregs), entry_data);
> > +		ret = fp->entry_handler(fp, ip, parent_ip, fregs, entry_data);
> >  
> >  	/* If entry_handler returns !0, nmissed is not counted. */
> >  	if (rh) {
> > @@ -182,7 +182,7 @@ static void fprobe_init(struct fprobe *fp)
> >  		fp->ops.func = fprobe_kprobe_handler;
> >  	else
> >  		fp->ops.func = fprobe_handler;
> > -	fp->ops.flags |= FTRACE_OPS_FL_SAVE_REGS;
> > +	fp->ops.flags |= FTRACE_OPS_FL_SAVE_ARGS;
> 
> so with this change you move to ftrace_caller trampoline,
> but we need ftrace_regs_caller right?

Yes, that's right.

> 
> otherwise the (!regs) check in kprobe_multi_link_handler
> will be allways true IIUC

Ah, OK. So until we move to fgraph [28/34], keep this flag SAVE_REGS
then kprobe_multi test will pass.

OK, let me keep it so.

Thank you!

> 
> jirka
> 
> >  }
> >  
> >  static int fprobe_init_rethook(struct fprobe *fp, int num)
> > diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> > index 7d2ddbcfa377..ef6b36fd05ae 100644
> > --- a/kernel/trace/trace_fprobe.c
> > +++ b/kernel/trace/trace_fprobe.c
> > @@ -320,12 +320,16 @@ NOKPROBE_SYMBOL(fexit_perf_func);
> >  #endif	/* CONFIG_PERF_EVENTS */
> >  
> >  static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
> > -			     unsigned long ret_ip, struct pt_regs *regs,
> > +			     unsigned long ret_ip, struct ftrace_regs *fregs,
> >  			     void *entry_data)
> >  {
> >  	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
> > +	struct pt_regs *regs = ftrace_get_regs(fregs);
> >  	int ret = 0;
> >  
> > +	if (!regs)
> > +		return 0;
> > +
> >  	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
> >  		fentry_trace_func(tf, entry_ip, regs);
> >  #ifdef CONFIG_PERF_EVENTS
> > diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
> > index 24de0e5ff859..ff607babba18 100644
> > --- a/lib/test_fprobe.c
> > +++ b/lib/test_fprobe.c
> > @@ -40,7 +40,7 @@ static noinline u32 fprobe_selftest_nest_target(u32 value, u32 (*nest)(u32))
> >  
> >  static notrace int fp_entry_handler(struct fprobe *fp, unsigned long ip,
> >  				    unsigned long ret_ip,
> > -				    struct pt_regs *regs, void *data)
> > +				    struct ftrace_regs *fregs, void *data)
> >  {
> >  	KUNIT_EXPECT_FALSE(current_test, preemptible());
> >  	/* This can be called on the fprobe_selftest_target and the fprobe_selftest_target2 */
> > @@ -81,7 +81,7 @@ static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
> >  
> >  static notrace int nest_entry_handler(struct fprobe *fp, unsigned long ip,
> >  				      unsigned long ret_ip,
> > -				      struct pt_regs *regs, void *data)
> > +				      struct ftrace_regs *fregs, void *data)
> >  {
> >  	KUNIT_EXPECT_FALSE(current_test, preemptible());
> >  	return 0;
> > diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
> > index 64e715e7ed11..1545a1aac616 100644
> > --- a/samples/fprobe/fprobe_example.c
> > +++ b/samples/fprobe/fprobe_example.c
> > @@ -50,7 +50,7 @@ static void show_backtrace(void)
> >  
> >  static int sample_entry_handler(struct fprobe *fp, unsigned long ip,
> >  				unsigned long ret_ip,
> > -				struct pt_regs *regs, void *data)
> > +				struct ftrace_regs *fregs, void *data)
> >  {
> >  	if (use_trace)
> >  		/*
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

