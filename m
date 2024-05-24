Return-Path: <bpf+bounces-30450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 816178CDF15
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 03:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278E21F22720
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 01:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E6EB662;
	Fri, 24 May 2024 01:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXhv6Pqn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B7A5CAC;
	Fri, 24 May 2024 01:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716512964; cv=none; b=AmcqlJ3icAeKpSjLvXJ2i1AKhvp966PcxbuLKxa54Ku5TDlZfDxLf1gbRy0ZFCuaymlu0rvmhNBC80hHbm6cINgFsKM002bMaQA6BxXvwk4eRhAW3dXDPwVaOhj+zU7Ahq+pfagD1i7LI4VT7sXgc82w9ScyOkyEi/FXsSriBN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716512964; c=relaxed/simple;
	bh=N5i8ODqIWK6xce8rPBypOBonIZKEmwJfgSq3wA+sDiM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nphwmOB4Raz3jdXhLYXDQcfA8GEpQ5So6bUtq3eIWZpQGQrcv10P0LMb7IJdw2iUhbbDtRq0AByo2CwG3tb3BS9VusiGX2EmKwWKE/WiA/4OSlJjC4asWcYnK1irtdKvuu8pmwnOPJl6M3Zo73fdvc0mqbg6MnDdKD6dmjo7Urk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXhv6Pqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14EDC3277B;
	Fri, 24 May 2024 01:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716512963;
	bh=N5i8ODqIWK6xce8rPBypOBonIZKEmwJfgSq3wA+sDiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nXhv6PqnFOr8LrGFjDqcJYW7eIwONusPVONYtH+Uxt0hcT+HI9cmsYnY1HkEZQqWN
	 bqixDnXsLQRr0fJomyfPw5AepmT+Ls6sAnTU/qaYJ2ee9/6KN1fG5J+tEZB2E3EMgp
	 THHdNP8nhRtqwPTHiNFhyeocUj+frWH/Dm3fw9Qziacqot2VXv8OBb3WfH3GtpHqST
	 E7erDiXA3vnJhxnyH+mXsGkHqjp+UD+Oenn1HonCfuxfP49TV0RBY5lzQGIniZFRyE
	 pr/niEFe+bRLtLnCSOtmPEL0DSU+EfnGxv/X5JfiDquxMFHjpIb4mo9+SDA3FyCx9a
	 JwBOIxB+ogI+Q==
Date: Fri, 24 May 2024 10:09:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v10 01/36] tracing: Add a comment about ftrace_regs
 definition
Message-Id: <20240524100917.6983301f9df6da716591f136@kernel.org>
In-Reply-To: <20240523191031.7574d944@gandalf.local.home>
References: <171509088006.162236.7227326999861366050.stgit@devnote2>
	<171509089214.162236.6201493898649663823.stgit@devnote2>
	<20240523191031.7574d944@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 19:10:31 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  7 May 2024 23:08:12 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > To clarify what will be expected on ftrace_regs, add a comment to the
> > architecture independent definition of the ftrace_regs.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  Changes in v8:
> >   - Update that the saved registers depends on the context.
> >  Changes in v3:
> >   - Add instruction pointer
> >  Changes in v2:
> >   - newly added.
> > ---
> >  include/linux/ftrace.h |   26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 54d53f345d14..b81f1afa82a1 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -118,6 +118,32 @@ extern int ftrace_enabled;
> >  
> >  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> >  
> > +/**
> > + * ftrace_regs - ftrace partial/optimal register set
> > + *
> > + * ftrace_regs represents a group of registers which is used at the
> > + * function entry and exit. There are three types of registers.
> > + *
> > + * - Registers for passing the parameters to callee, including the stack
> > + *   pointer. (e.g. rcx, rdx, rdi, rsi, r8, r9 and rsp on x86_64)
> > + * - Registers for passing the return values to caller.
> > + *   (e.g. rax and rdx on x86_64)
> > + * - Registers for hooking the function call and return including the
> > + *   frame pointer (the frame pointer is architecture/config dependent)
> > + *   (e.g. rip, rbp and rsp for x86_64)
> > + *
> > + * Also, architecture dependent fields can be used for internal process.
> > + * (e.g. orig_ax on x86_64)
> > + *
> > + * On the function entry, those registers will be restored except for
> > + * the stack pointer, so that user can change the function parameters
> > + * and instruction pointer (e.g. live patching.)
> > + * On the function exit, only registers which is used for return values
> > + * are restored.
> 
> I wonder if we should also add a note about some architectures in some
> circumstances may store all pt_regs in ftrace_regs. For example, if an
> architecture supports FTRACE_WITH_REGS, it may pass the pt_regs within the
> ftrace_regs. If that is the case, then ftrace_get_regs() called on it will
> return a pointer to a valid pt_regs, or NULL if it is not supported or the
> ftrace_regs does not have a all the registers.

Agreed. That case also should be noted. Thanks for pointing!


> 
> -- Steve
> 
> 
> > + *
> > + * NOTE: user *must not* access regs directly, only do it via APIs, because
> > + * the member can be changed according to the architecture.
> > + */
> >  struct ftrace_regs {
> >  	struct pt_regs		regs;
> >  };
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

