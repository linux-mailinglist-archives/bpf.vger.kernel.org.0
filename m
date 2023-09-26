Return-Path: <bpf+bounces-10827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBCA7AE2E3
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 02:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E22252814C4
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 00:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5C3627;
	Tue, 26 Sep 2023 00:20:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9491B366;
	Tue, 26 Sep 2023 00:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCEBC433C8;
	Tue, 26 Sep 2023 00:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695687655;
	bh=8ZXFwCIg1oGcxQ32a/Xjtx4euP4ylyONmkXQpSM8V/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QPHBRHPuzL3zDK7hSy7P5KSkTOWXqVMwUlon1sr2TNZDnwdsZxCBsBMaTX7IxVEkU
	 RQNd7BpGdKiSCXhQyWW5dJzSmjHDiqpNC7qEoBG87sX8aTwsRgN5t56Un91Rp7JkJd
	 F8RSpw+j5Wnkpy+oCu2+jn7B9lsqKAP7e++/al9fTtzVRfOzzj6LzT34ASAqaAFdQt
	 q1pGB2jK52y+KPiNKeDGV5xdcfnnq2yYsDVZ/fwQjlyQ5sWriUh7/6D5+Eq9X/yqVu
	 r5vyBq9w9+OZGFRtDep/lpX+xs1UZK6k0TIQJL4aTzSgIkhBtSAeNY+KAH7Cr7sNvk
	 qgMzYOb0FURPQ==
Date: Tue, 26 Sep 2023 09:20:48 +0900
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
Subject: Re: [PATCH v5 04/12] fprobe: Use ftrace_regs in fprobe entry
 handler
Message-Id: <20230926092048.5c08fb61cb99f77573f89d7b@kernel.org>
In-Reply-To: <ZRIGSTTTYADzP7QU@krava>
References: <169556254640.146934.5654329452696494756.stgit@devnote2>
	<169556259571.146934.4558592076420704031.stgit@devnote2>
	<ZRFj97DJtbXc4naO@krava>
	<20230925211515.41d26a160c546c7bce08ac64@kernel.org>
	<ZRIGSTTTYADzP7QU@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Sep 2023 00:14:33 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Mon, Sep 25, 2023 at 09:15:15PM +0900, Masami Hiramatsu wrote:
> > Hi Jiri,
> > 
> > On Mon, 25 Sep 2023 12:41:59 +0200
> > Jiri Olsa <olsajiri@gmail.com> wrote:
> > 
> > > On Sun, Sep 24, 2023 at 10:36:36PM +0900, Masami Hiramatsu (Google) wrote:
> > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > 
> > > > This allows fprobes to be available with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > > > instead of CONFIG_DYNAMIC_FTRACE_WITH_REGS, then we can enable fprobe
> > > > on arm64.
> > > > 
> > > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > Acked-by: Florent Revest <revest@chromium.org>
> > > 
> > > I was getting bpf selftests failures with this patchset and when
> > > bisecting I'm getting crash when running on top of this change
> > 
> > Thanks for bisecting!
> > 
> > > 
> > > looks like it's missing some of the regs NULL checks added later?
> > 
> > yeah, if the RIP (arch_rethook_prepare+0x0/0x30) is correct, 
> > 
> > void arch_rethook_prepare(struct rethook_node *rh, struct ftrace_regs *fregs, bool mcount)
> > 
> > RSI (the 2nd argument) is NULL. This means fregs == NULL and caused the crash.
> > I think ftrace_get_regs(fregs) for the entry handler may return NULL.
> > 
> > Ah, 
> > 
> > @@ -182,7 +182,7 @@ static void fprobe_init(struct fprobe *fp)
> >  		fp->ops.func = fprobe_kprobe_handler;
> >  	else
> >  		fp->ops.func = fprobe_handler;
> > -	fp->ops.flags |= FTRACE_OPS_FL_SAVE_REGS;
> > +	fp->ops.flags |= FTRACE_OPS_FL_SAVE_ARGS;
> >  }
> >  
> >  static int fprobe_init_rethook(struct fprobe *fp, int num)
> > 
> > This may cause the issue, it should keep REGS at this point (this must be done in
> > [9/12]). But after applying [9/12], it shouldn't be a problem... 
> > 
> > Let me check it again.
> 
> that helped with the crash, I'll continue bisecting to find out
> where it breaks the tests

Can you share the configuration and the test?
I would like to reproduce it because I couldn't make it reproduced.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

