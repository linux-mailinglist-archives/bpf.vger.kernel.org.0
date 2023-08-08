Return-Path: <bpf+bounces-7221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B05773995
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 12:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAC0281752
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 10:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80239EAD1;
	Tue,  8 Aug 2023 10:20:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202BEDDBF
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 10:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12030C433C7;
	Tue,  8 Aug 2023 10:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691490057;
	bh=3D8UlFaQhT9sb59ACbUa5dShagqWM3haJ/9jO2RNvK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jzT3dAbhEjiZBW7Dluo41cuVp4S/mvEjxsBDpyQB6jAJfcz9vFfLHpcTjMUf4pHRB
	 BpFpxbUHqdgB1in+UDTXMXptX5Ok7LAHuHO8NqMSdnRk9Z4F9dVdJse1XjA0G382Rp
	 OkuK7nw8evOoQ/606MpZuZgsqPhFetNfNeEQmbp/rCr+SMqb+W7U7mP73cqNDUI8L2
	 ceTpHRgVJCUajztU5xIPvHiIp9e3ZHXxsD3PJEOAHorzAcHTW/X0oXG0KIUsmVMglt
	 3NBxz+LMy8nEZgkdxu33HXBFFmHQ9C3Yo3bhfdRy5WyB9ALb0h+dh+AFAfmz7hrE8y
	 EnKi2PRm3w6ZA==
Date: Tue, 8 Aug 2023 19:20:51 +0900
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
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v2 6/6] bpf: Enable kprobe_multi feature if
 CONFIG_FPROBE is enabled
Message-Id: <20230808192051.ef24cfae1532f9e7779bae43@kernel.org>
In-Reply-To: <ZNFrS4YGcW8dyxnF@krava>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
	<169139097360.324433.2521527070503682979.stgit@devnote2>
	<ZNFrS4YGcW8dyxnF@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Aug 2023 00:08:11 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Mon, Aug 07, 2023 at 03:49:33PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Enable kprobe_multi feature if CONFIG_FPROBE is enabled. The pt_regs is
> > converted from ftrace_regs by ftrace_partial_regs(), thus some registers
> > may always returns 0. But it should be enough for function entry (access
> > arguments) and exit (access return value).
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c |   22 +++++++++-------------
> >  1 file changed, 9 insertions(+), 13 deletions(-)
> > 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 99c5f95360f9..0725272a3de2 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2460,7 +2460,7 @@ static int __init bpf_event_init(void)
> >  fs_initcall(bpf_event_init);
> >  #endif /* CONFIG_MODULES */
> >  
> > -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > +#ifdef CONFIG_FPROBE
> >  struct bpf_kprobe_multi_link {
> >  	struct bpf_link link;
> >  	struct fprobe fp;
> > @@ -2482,6 +2482,8 @@ struct user_syms {
> >  	char *buf;
> >  };
> >  
> > +static DEFINE_PER_CPU(struct pt_regs, bpf_kprobe_multi_pt_regs);
> > +
> >  static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32 cnt)
> >  {
> >  	unsigned long __user usymbol;
> > @@ -2623,13 +2625,14 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
> >  
> >  static int
> >  kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
> > -			   unsigned long entry_ip, struct pt_regs *regs)
> > +			   unsigned long entry_ip, struct ftrace_regs *fregs)
> >  {
> >  	struct bpf_kprobe_multi_run_ctx run_ctx = {
> >  		.link = link,
> >  		.entry_ip = entry_ip,
> >  	};
> >  	struct bpf_run_ctx *old_run_ctx;
> > +	struct pt_regs *regs;
> >  	int err;
> >  
> >  	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
> > @@ -2639,6 +2642,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
> >  
> >  	migrate_disable();
> >  	rcu_read_lock();
> > +	regs = ftrace_partial_regs(fregs, this_cpu_ptr(&bpf_kprobe_multi_pt_regs));
> 
> you did check for !regs when returned from ftrace_get_regs, why don't we need
> to check it in here? both ftrace_partial_regs and ftrace_get_regs call
> arch_ftrace_get_regs on x86

Good catch! I think ftrace_partial_regs must not return NULL (unless getting
invalid parameter, e.g. fregs == NULL).

> 
> also also I can't find the place ensuring fregs->regs.cs != 0 for FL_SAVE_REGS
> flag as stated in arch_ftrace_get_regs, any hint?

Oops, I misread that part. Maybe ftrace_partial_regs must forcibly return
ftrace_regs::regs if HAVE_PT_REGS_COMPAT_FTRACE_REGS=y because it does not
care the regs is partial or not.

Thank you!

> 
> thanks,
> jirka
> 
> 
> >  	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> >  	err = bpf_prog_run(link->link.prog, regs);
> >  	bpf_reset_run_ctx(old_run_ctx);
> > @@ -2656,13 +2660,9 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
> >  			  void *data)
> >  {
> >  	struct bpf_kprobe_multi_link *link;
> > -	struct pt_regs *regs = ftrace_get_regs(fregs);
> > -
> > -	if (!regs)
> > -		return 0;
> >  
> >  	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
> > -	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> > +	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), fregs);
> >  	return 0;
> >  }
> >  
> > @@ -2672,13 +2672,9 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
> >  			       void *data)
> >  {
> >  	struct bpf_kprobe_multi_link *link;
> > -	struct pt_regs *regs = ftrace_get_regs(fregs);
> > -
> > -	if (!regs)
> > -		return;
> >  
> >  	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
> > -	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> > +	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), fregs);
> >  }
> >  
> >  static int symbols_cmp_r(const void *a, const void *b, const void *priv)
> > @@ -2918,7 +2914,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >  	kvfree(cookies);
> >  	return err;
> >  }
> > -#else /* !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> > +#else /* !CONFIG_FPROBE */
> >  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> >  {
> >  	return -EOPNOTSUPP;
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

