Return-Path: <bpf+bounces-69534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A2CB9981E
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 12:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DEC4C4376
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 10:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241DE2E1C56;
	Wed, 24 Sep 2025 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Uv/hNuGx"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A211A1A9F8D;
	Wed, 24 Sep 2025 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758711295; cv=none; b=sJJC/uuDRw4d/3jejYqwn3+YvRJheqGF498IqxMT6unYEn+yNFrud6sN1LemIaYxqAbPBdFiSFA3BRKMAUTftKR6/JuwH96+LBfRMgOzJ6inXLaA6Q9V7TKa96WN5h7gp+Ubrdx6RhBS/Aqc3tYhrKFFqkE9NB+1YBVc3gAalq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758711295; c=relaxed/simple;
	bh=v99OOH221w3fUxxpDIO4h3pShz2WIBmSyzeE+NQjmnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uasKixdyQQfB2hjreMtvIBJNmX0BYT7qy8FDtcD8XSdDs9RGAOLuNDndnWgSB5WJThfYUDnbf0H27F3Emqel7VRlGPKxkkogdC7vrIXkaK5b/QA+99+0rOGLOyNrxCM2fURs2JAoXbrmp0pXOPhDPuPG0QSM6Wcbc4OaOLLF7Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Uv/hNuGx; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mu
	ELRdJmgkXKCBpSkBR/bsOuPAXgetmP5S+z1LDTyc4=; b=Uv/hNuGxqiR+uBB8mU
	ZuYBVpu5H4CIi8O+//Uu7a7GeWX6nLG3y4rSSLv+SWgafGEOZR4gm5jATPXvqx9Q
	yhQD5IKL3SXgx+WffJki0zIdtIRwevjqURTPzmh1uwfUuqctnoMZycJ60iVZGQzO
	0F3dAnwOPNqIMOg/3ZLbjKPLM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3X8PCzdNoczw7Dg--.17058S2;
	Wed, 24 Sep 2025 18:53:55 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: mhiramat@kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	yangfeng59949@163.com,
	yonghong.song@linux.dev
Subject: Re: [BUG] Failed to obtain stack trace via bpf_get_stackid on ARM64 architecture
Date: Wed, 24 Sep 2025 18:53:53 +0800
Message-Id: <20250924105353.840865-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250924170416.0874e56c2ce99a4de92e05b8@kernel.org>
References: <20250924170416.0874e56c2ce99a4de92e05b8@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X8PCzdNoczw7Dg--.17058S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww15KrW3Kr45Gr45ZryfXrb_yoW8ZrWUpa
	sYk3ZxKrs8CFn2k3sFqw1DXFy5Cws5uw4DCr1rCF1akrnrZFyUWr42kFW5uryUZryDK340
	9FnFv3srJr4Yva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR4vViUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiZQfSeGjTn7-D9AABsl

On Wed, 24 Sep 2025 17:04:16 +0900 Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

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
> 
> Good catch! 

Should I submit this patch, or will you carry out a more complete fix?

> > By the way, during my testing, I also noticed that when executing bpf_get_stackid via kprobes or tracepoints, 
> > the command bpftrace -e 'kprobe:bpf_get_stackid {printf("bpf_get_stackid\n");}' produces no output. 
> 
> I think this is because the bpf_get_stackid is a kind of recursive
> event from kprobes. Kprobe handler can not be reentered.
> 
> > However, it does output something when bpf_get_stackid is invoked via uprobes. 
> > This phenomenon also occurs on the x86 architecture, could this be a bug as well?
> 
> Maybe if bpf_get_stackid() is kicked from uprobes, it is not recursive
> call from kprobes, so it works.
> 
> So it is expected behavior, not a bug. Sorry for confusion.
> 
> 
> Thank you,

Thank you very much for your explanation.


