Return-Path: <bpf+bounces-69630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DC1B9C515
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 00:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C71AF7AC62F
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 21:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F390128851C;
	Wed, 24 Sep 2025 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neZTQ2RJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E13C14658D;
	Wed, 24 Sep 2025 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758751228; cv=none; b=k/RCBDSQJSgWNdRQCoCyI0TCyi0EZxw95v4fgyOrYxDpyBNc3NpGHCnOm2F2vT2eZxqykw1oeb9YwmVqyoBRho+CFApXD+HUjFn+Kq82c4yAHTxcuSWBcFgr6q67Vk+b8K+GwxMgp/Xd4mrdfbn9UWVloG2IzQ0/uUS+xKQ8J5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758751228; c=relaxed/simple;
	bh=6nsdrp/oNxfmTedGHJyCptTjEQF4jfMWqCgFHC0AW0c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Xe6KYAUDzZW386gyYRJz3iKjo/GuuDx5zdLksWPYIxnMnMIR3PoM2Msu3tXZOSLsHH6p2vTgQJ0UjeAhbAtatDhl2BrSFwfeofxEunwEDhkEbVV13eyaC2dVstmPWTaXNxicN3BKBnyB9HzF0qeOGGnyaTNghz2MEqshgt0x0+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neZTQ2RJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89829C4CEE7;
	Wed, 24 Sep 2025 22:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758751227;
	bh=6nsdrp/oNxfmTedGHJyCptTjEQF4jfMWqCgFHC0AW0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=neZTQ2RJyR1L1WE/Cmcheu2WwBC+tY+fvrDUrwBxO+FirmJGl6NWIBcv/iefmwkVL
	 NUTcRKGN9UvvWfJFl+Y35Uw5v/P4oqVNctqRtwZ95xnxOsaZcXmxJ/3y4FbVof6Ijw
	 2+jQj2rtBJ9vB1HjwbWb7PVMvw7Y3GWOvoeEVS69pGre2UCurfcrxYFC9GWRN6MZp8
	 ncgku5SQ55aqInuk6er7NkhW7gy6GHfH/41wfhIcCiNiTOHB6TIHht4VIUu5POH8jk
	 pmMoFWdNH+PjlcO1Zz2CscR3lRA4XqEEcBP+vk51AL8UCwRBX/pzvcqMdHuIFW1Jt+
	 XrSlU509deNHQ==
Date: Thu, 25 Sep 2025 07:00:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Feng Yang <yangfeng59949@163.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 song@kernel.org, yonghong.song@linux.dev
Subject: Re: [BUG] Failed to obtain stack trace via bpf_get_stackid on ARM64
 architecture
Message-Id: <20250925070022.42ef1398e0f61c797222679c@kernel.org>
In-Reply-To: <20250924105353.840865-1-yangfeng59949@163.com>
References: <20250924170416.0874e56c2ce99a4de92e05b8@kernel.org>
	<20250924105353.840865-1-yangfeng59949@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 18:53:53 +0800
Feng Yang <yangfeng59949@163.com> wrote:

> On Wed, 24 Sep 2025 17:04:16 +0900 Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > After testing, it was found that the stack could not be obtained because user_mode(regs) returned 1. 
> > > Referring to the arch_ftrace_fill_perf_regs function in your email 
> > > (https://lore.kernel.org/all/173518997908.391279.15910334347345106424.stgit@devnote2/), 
> > > I made the following modification: by setting the value of pstate, the stack can now be obtained successfully.
> > > 
> > > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > > index 058a99aa44bd..f2814175e958 100644
> > > --- a/arch/arm64/include/asm/ftrace.h
> > > +++ b/arch/arm64/include/asm/ftrace.h
> > > @@ -159,11 +159,13 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> > >  {
> > >         struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
> > >  
> > >         memcpy(regs->regs, afregs->regs, sizeof(afregs->regs));
> > >         regs->sp = afregs->sp;
> > >         regs->pc = afregs->pc;
> > >         regs->regs[29] = afregs->fp;
> > >         regs->regs[30] = afregs->lr;
> > > +       regs->pstate = PSR_MODE_EL1h;
> > 
> > Good catch! 
> 
> Should I submit this patch, or will you carry out a more complete fix?


Yes, please send a fix. I think this is enoguh. Please add,

Fixes: b9b55c8912ce ("tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs")

Thank you,

> 
> > > By the way, during my testing, I also noticed that when executing bpf_get_stackid via kprobes or tracepoints, 
> > > the command bpftrace -e 'kprobe:bpf_get_stackid {printf("bpf_get_stackid\n");}' produces no output. 
> > 
> > I think this is because the bpf_get_stackid is a kind of recursive
> > event from kprobes. Kprobe handler can not be reentered.
> > 
> > > However, it does output something when bpf_get_stackid is invoked via uprobes. 
> > > This phenomenon also occurs on the x86 architecture, could this be a bug as well?
> > 
> > Maybe if bpf_get_stackid() is kicked from uprobes, it is not recursive
> > call from kprobes, so it works.
> > 
> > So it is expected behavior, not a bug. Sorry for confusion.
> > 
> > 
> > Thank you,
> 
> Thank you very much for your explanation.
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

