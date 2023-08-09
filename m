Return-Path: <bpf+bounces-7405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BFF776C08
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 00:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F6C1C21410
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 22:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE761DDEE;
	Wed,  9 Aug 2023 22:13:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCCC1C9F6
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 22:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E473C433C7;
	Wed,  9 Aug 2023 22:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691619216;
	bh=0SR9DPqseRHiCXQ+j6+0+QSN4Sn6OOxeM42Im3uazes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aEUC8hu248uC08A4L5iDh0a+W+mlid8cOQvoZghQ0ePtWWP3/01VWwKlMokaVoStR
	 +yoxh3hV/rweR2hv0YPrigzI8RzRzYptpjK3gStXmzsm7ruL2sM0U5XfHLKjGZwE/p
	 pPnKJU08RLf12NVdtwlhoJtHISSFK48EM8lzMEeky31FVgscBf/BbjBOyTX3DDJa/1
	 9yluawRZ/bHdkUJj6boWBctDa3g1Vsy5Gsc4oWziBVg1b2Sl73ejFosS3ymDeil0+B
	 zNBNk3AE/+0fKDSQpKeEy3+xPOyc5EoeY5lkfeuOrf0gbEEiNgUrfkC99fJV+kpsxX
	 jY6X4ZUgLojRA==
Date: Thu, 10 Aug 2023 07:13:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Florent Revest <revest@chromium.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v2 1/6] fprobe: Use fprobe_regs in fprobe entry
 handler
Message-Id: <20230810071330.d41a728f996f76e3243f469e@kernel.org>
In-Reply-To: <CABRcYmLHfQsjwf7dk+A0Q96iANhj60M0g_xRjVyMUY9LJPybNg@mail.gmail.com>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
	<169139091575.324433.13168120610633669432.stgit@devnote2>
	<CABRcYmKRAbOuqNQm5mCwC9NWbtcz1JJDYL_h5x6dK77SJ5FRkA@mail.gmail.com>
	<20230809231011.b125bd68887a5659db59905e@kernel.org>
	<CABRcYmKEd=zmriE8VUnSTvybwA962r60+QaRJZK=KNqYixd_eg@mail.gmail.com>
	<CABRcYmLHfQsjwf7dk+A0Q96iANhj60M0g_xRjVyMUY9LJPybNg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 9 Aug 2023 18:17:47 +0200
Florent Revest <revest@chromium.org> wrote:

> On Wed, Aug 9, 2023 at 6:09 PM Florent Revest <revest@chromium.org> wrote:
> >
> > On Wed, Aug 9, 2023 at 4:10 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > Hi Florent,
> > >
> > > On Wed, 9 Aug 2023 12:28:38 +0200
> > > Florent Revest <revest@chromium.org> wrote:
> > >
> > > > On Mon, Aug 7, 2023 at 8:48 AM Masami Hiramatsu (Google)
> > > > <mhiramat@kernel.org> wrote:
> > > > >
> > > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > >
> > > > > This allows fprobes to be available with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > > > > instead of CONFIG_DYNAMIC_FTRACE_WITH_REGS, then we can enable fprobe
> > > > > on arm64.
> > > >
> > > > This patch lets fprobe code build on configs WITH_ARGS and !WITH_REGS
> > > > but fprobe wouldn't run on these builds because fprobe still registers
> > > > to ftrace with FTRACE_OPS_FL_SAVE_REGS, which would fail on
> > > > !WITH_REGS. Shouldn't we also let the fprobe_init callers decide
> > > > whether they want REGS or not ?
> > >
> > > Ah, I think you meant FPROBE_EVENTS? Yes I forgot to add the dependency
> > > on it. But fprobe itself can work because fprobe just pass the ftrace_regs
> > > to the handlers. (Note that exit callback may not work until next patch)
> >
> > No, I mean that fprobe still registers its ftrace ops with the
> > FTRACE_OPS_FL_SAVE_REGS flag:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/tree/kernel/trace/fprobe.c?h=topic/fprobe-ftrace-regs&id=2ca022b2753ae0d2a2513c95f7ed5b5b727fb2c4#n185
> >
> > Which means that __register_ftrace_function will return -EINVAL on
> > builds !WITH_REGS:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/tree/kernel/trace/ftrace.c?h=topic/fprobe-ftrace-regs&id=2ca022b2753ae0d2a2513c95f7ed5b5b727fb2c4#n338
> >
> > As documented here:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/tree/include/linux/ftrace.h?h=topic/fprobe-ftrace-regs&id=2ca022b2753ae0d2a2513c95f7ed5b5b727fb2c4#n188
> >
> > There are two parts to using sparse pt_regs. One is "static": having
> > WITH_ARGS in the config, the second one is "dynamic": a ftrace ops
> > needs to specify that it doesn't want to go through the ftrace
> > trampoline that saves a full pt_regs, by not giving
> > FTRACE_OPS_FL_SAVE_REGS. If we want fprobe to work on builds
> > !WITH_REGS then we should both remove Kconfig dependencies to
> > WITH_REGS (like you've done) but also stop passing this ftrace ops
> > flag.
> 
> Said in a different way: there are arches that support both WITH_ARGS
> and WITH_REGS (like x86 actually). They have two ftrace trampolines
> compiled in: ftrace_caller and ftrace_regs_caller, one for each
> usecase. If you register to ftrace with the FTRACE_OPS_FL_SAVE_REGS
> flag you are telling it that what you want is a pt_regs. If you are
> trying to move away from pt_regs and support ftrace_regs in the more
> general case (meaning, in the case where it can contain a sparse
> pt_regs) then you should stop passing that flag so you go through the
> lighter, faster trampoline and test your code in the circumstances
> where ftrace_regs isn't just a regular pt_regs but an actually sparse
> or light data structure.
> 
> I hope that makes my thoughts clearer? It's a hairy topic ahah

Ah, I see your point.

static void fprobe_init(struct fprobe *fp)
{
        fp->nmissed = 0;
        if (fprobe_shared_with_kprobes(fp))
                fp->ops.func = fprobe_kprobe_handler;
        else
                fp->ops.func = fprobe_handler;
        fp->ops.flags |= FTRACE_OPS_FL_SAVE_REGS; <---- This flag!
}

So it should be FTRACE_OPS_FL_ARGS. Let me fix that.

Thank you!
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

