Return-Path: <bpf+bounces-69629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B41CB9C4FD
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 23:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538171BC1BA2
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 21:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851A428980A;
	Wed, 24 Sep 2025 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZzuUpBL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BCF2877E2;
	Wed, 24 Sep 2025 21:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758751008; cv=none; b=ATkwIawzuCGhGNDaKacVOrBeJGbvC4lowWiI+vPzjDRXLb4DyKWNKv+xhx2TL41FzGP7HOtwFZCWnxtcyXV9+uRjZrgZdHPgXla9WW9dxF3SRUa2xqD/QuX/ZFNeF0ArmqzrT3QXC2Q6zQitI4LNLTzQWWJ4H+7sHiLErLi4ZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758751008; c=relaxed/simple;
	bh=+lWw7yoU715GpZMy0siMIcqf5i9GkAjvt07AQ62ZNig=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cibRAfPlkTB88K2WWCiuDfSkPBQPtP0geR8QpdFQK1nIyPBd5ZIJ2vdUBd5+9ucmO7+g7MazECRiPG29XpoY0A+Ehuik/OADpmCzhd+SBi/u1opoavGy4J/uWGVcRDvJBHB/v3E0i3qjNfvqZ6n4ZQHmaFqVpwMMHPEqeDYG2G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZzuUpBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D83C4CEE7;
	Wed, 24 Sep 2025 21:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758751007;
	bh=+lWw7yoU715GpZMy0siMIcqf5i9GkAjvt07AQ62ZNig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CZzuUpBLcY7MtuZwTTknk8CaLyA+krm5iNkc87b9279VB+gJKgIZIeFk1ydJvuTZC
	 GLRpe1jhZKqw8AjtN7XsXDCQOCWE88iaUcwmoJc5qZKKifyxS9FNagWLujAF5AOQbF
	 Thxdvq/qWlp/C4VlIqUyo7cYaqeylbzzo2ed4Fdm5nfCfvtymUd9pyhMt1taxITChm
	 uN9/HZng25v3CHLu9GKmqoctFQ1EED1Qlmvac3qkfgcIoUJK8kEnDbymubrX6RE3Ca
	 GpEGZB1X1qBZQMsaIisrtQhptQzd1uTGFZEUEQfKdJy4kusN7SjPqtY3edAdzSKWzI
	 hxUpxFD/+eaBw==
Date: Thu, 25 Sep 2025 06:56:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Feng Yang <yangfeng59949@163.com>, mhiramat@kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, song@kernel.org,
 yonghong.song@linux.dev
Subject: Re: [BUG] Failed to obtain stack trace via bpf_get_stackid on ARM64
 architecture
Message-Id: <20250925065641.5e066b03db123e96791d5671@kernel.org>
In-Reply-To: <aNQRWlNIno3ThMkv@krava>
References: <20250924003215.365db154e1fc79163d9d80fe@kernel.org>
	<20250924062536.471231-1-yangfeng59949@163.com>
	<aNQRWlNIno3ThMkv@krava>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 17:42:18 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Wed, Sep 24, 2025 at 02:25:36PM +0800, Feng Yang wrote:
> 
> SNIP
> 
> > > Hmm, can you also dump the regs and insert pr_info() to find
> > > which function fails?
> > > 
> > > Thanks,
> > > 
> > 
> > After testing, it was found that the stack could not be obtained because user_mode(regs) returned 1. 
> > Referring to the arch_ftrace_fill_perf_regs function in your email 
> > (https://lore.kernel.org/all/173518997908.391279.15910334347345106424.stgit@devnote2/), 
> > I made the following modification: by setting the value of pstate, the stack can now be obtained successfully.
> > 
> > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > index 058a99aa44bd..f2814175e958 100644
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -159,11 +159,13 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> >  {
> >         struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
> >  
> >         memcpy(regs->regs, afregs->regs, sizeof(afregs->regs));
> >         regs->sp = afregs->sp;
> >         regs->pc = afregs->pc;
> >         regs->regs[29] = afregs->fp;
> >         regs->regs[30] = afregs->lr;
> > +       regs->pstate = PSR_MODE_EL1h;
> >         return regs;
> >  }
> > However, I'm not sure if there will be any other impacts...
> 
> nice, the test works for me with this change.. could you please send
> formal patch? I can polish and send out the test [1]

Yeah, and Cc to arm64 maintainers, also Closes: to this thread.

Thanks,

> 
> thanks,
> jirka
> 
> 
> [1] https://github.com/kernel-patches/bpf/pull/9845/commits/11b31cd465a83b8719cb06331c8e81794cca40fa


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

