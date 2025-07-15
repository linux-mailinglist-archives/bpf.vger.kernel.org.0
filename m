Return-Path: <bpf+bounces-63317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20CBB059C0
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 14:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A08D07B6103
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 12:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7247D2DE6F3;
	Tue, 15 Jul 2025 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/FBene5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B21D253B71;
	Tue, 15 Jul 2025 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581801; cv=none; b=uBHRT4nJwqW4SgehX+t/eDQGR+Iry8EBnIXE25HgiwXEaJpDMVJEE9rT8atzzojJ3mobwIOLM1HceBUHc6B+NSr46Nwa9YWmHryUDSZzc+7wYgMMl3TaoENuQJ+1iHn2wOstPLSX1z0rzZ4MPdT4AEia9ZZdQckU1GVTEYG/ios=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581801; c=relaxed/simple;
	bh=0oOq8pDPAqnbtAaHz1hfb30bLPq6HrFqDTmaJHiwkxg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZZ5dCOIkCKSU+tj/TDTaXklneeb1jea+8srysC0puM1H6RwL931YTHNsLHPi4Iw8vqDPS1wJrZjTKEXmQP9Xm8ApS2qHrJBU8RiRcxxOYYWcpvtq5Hv4DXuNfct5G+BI5NqwrC3iRXxF30JWuqnr1MOloiywH+49rdjlTQmH+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/FBene5; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso1310543166b.0;
        Tue, 15 Jul 2025 05:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752581797; x=1753186597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QxwIW/ofNO76/yWrxJNDNniTVZbbwyY1BwNSpwd5GEM=;
        b=A/FBene5Yu8Qm6/ZeDkHbPUp+8T/ZxZDZEXN+jLs8FUjrVVkShy0t92G2ud7X680K9
         iedvB82nt9nFYaF3Gsl/DRCWNGgpvgA1f7bU7cVMlEbFpc8b+Xc36/j7KxXIj7ySW+CL
         Xl+ue+T5p7ddyUgqAtQQbviJ7VmCs4+YQp7s5B/LcJDWINhWEYczgojU2y5mIA6P5mBR
         SAH8cfbzZaAMoPIWzY+eq/OCHoGgnW72qXu809WqzIt8yj4kNvSadXbuCKvx5/E91+vp
         wh308fiUI/TAAHh7qAsEHQDjXg4Js/tgDtDuH+HOTkYiyHUwUNvhZAejG7NdkcWfZwZh
         i+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752581797; x=1753186597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxwIW/ofNO76/yWrxJNDNniTVZbbwyY1BwNSpwd5GEM=;
        b=febr/pgNtmVPttx9KYgSznmuD1EZYyaeLccnee+EH1iMnZR6vGPu5xYWxM1Lc2A4vN
         VtkW9/LMgpDJtNDfXuPhInsyVc99ygCC1KrlAnHF4z4H2ZqFSnwACPEd/yWHGFpnOygP
         mZn+OlWxekWvok4OYO2pyLUkbQowgFGDyEOo68s7A7CGXvLVvNfmKQ+B8SoXMRXSP16q
         IgksXA+WXRIAbv06jqfE8HqiLb1aWv2QqkL1dOnRQ9XlVel565p77CBy6cCaaDejo/4/
         9WfNVSNP84u5kE8hJlbYd4NO05qkbajQyv+HXrOne9DkVxjjQAA/VePDKz+8FSaR/4Nd
         jJLA==
X-Forwarded-Encrypted: i=1; AJvYcCVBzwnizYSyS+bZA3gffcmIGl1fBtwOnHwHp0ggADFteCBRBNvBEh/RSR+GOw1cf6nrkdxqimb5qlsDKQ/O@vger.kernel.org, AJvYcCVEw29nx8SXqtI1uxIsQ3McoVDvh62fcRFdlxkNHcS32k5lqe793GcAYETq8IJqcSd4eq0=@vger.kernel.org, AJvYcCXmb4PE40SvUS6r/Ew2tHvY9zd+593O7nZFJwGUds5NiclGu9SXSYBTFqeXcND/o5naUgsezIW2dEHILbIcvVKk1VmI@vger.kernel.org
X-Gm-Message-State: AOJu0YxxSmO5UIf0D7mFwS+vUZFRlOMFc+7TJvT30+3e2D6yymGTH0f5
	g9HBhYVMRKZjsM9i5ezwX6GcFse8QLv2ovC3+SjULMoqGLbXy+ACkRYg
X-Gm-Gg: ASbGncvZwFqjQMD1SkdLp0+IzkcxH8CojdklsZzkeVTrw0sV5DeXkndbQPz9+cJns9c
	bKTAIwA74RWB430L1rIuOGFzu4bowzEdFuAicNIY79MZlL+a5/tVcjeQHQubuucS36vZTgxaB2f
	d082c4hDh5JRMfN0s7CJUYMnWiJd8XfSNAkZJ4+NdxVm18i5EMmNLJtqPyX9anMW8rHnQfC+3Ny
	Sm82atjaER92zuXMBlDk1qP4M4TDmt47xxqBuyWaP/St4TM5K4JmQMQoRnQExApT3lJnBbW6xlp
	dqHg18Ii5Wat3mkuoQl9tR38t1x/v37qKLvAQs+GFRnHeLzxRARm0kdLwaZ1KsoZF8MBj4czKwg
	H9eVgs6d5
X-Google-Smtp-Source: AGHT+IGBMdyFQuiP57H2mcE0Zylo2duSUbz/norkoFdyLof8gAifWmo3TXOU/ZepRN1FhaPNaAdssQ==
X-Received: by 2002:a17:907:72d3:b0:ae6:f669:e196 with SMTP id a640c23a62f3a-ae9b5bc9c4amr313006766b.4.1752581796888;
        Tue, 15 Jul 2025 05:16:36 -0700 (PDT)
Received: from krava ([173.38.220.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90c4dsm1005237166b.19.2025.07.15.05.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 05:16:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 15 Jul 2025 14:16:33 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv5 perf/core 09/22] uprobes/x86: Add uprobe syscall to
 speed up uprobe
Message-ID: <aHZGofDkcJDCx3wY@krava>
References: <20250711082931.3398027-1-jolsa@kernel.org>
 <20250711082931.3398027-10-jolsa@kernel.org>
 <20250714173915.b9edd474742de46bcbe9c617@kernel.org>
 <20250714093903.GP905792@noisy.programming.kicks-ass.net>
 <20250714191935.577ec7df5ae8a73282cddce7@kernel.org>
 <aHV2mrao8EMOTz8S@krava>
 <20250715085451.6a871a3b40c5ff19d3568956@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715085451.6a871a3b40c5ff19d3568956@kernel.org>

On Tue, Jul 15, 2025 at 08:54:51AM +0900, Masami Hiramatsu wrote:
> On Mon, 14 Jul 2025 23:28:58 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > On Mon, Jul 14, 2025 at 07:19:35PM +0900, Masami Hiramatsu wrote:
> > > On Mon, 14 Jul 2025 11:39:03 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > > On Mon, Jul 14, 2025 at 05:39:15PM +0900, Masami Hiramatsu wrote:
> > > > 
> > > > > > +	/*
> > > > > > +	 * Some of the uprobe consumers has changed sp, we can do nothing,
> > > > > > +	 * just return via iret.
> > > > > > +	 */
> > > > > 
> > > > > Do we allow consumers to change the `sp`? It seems dangerous
> > > > > because consumer needs to know whether it is called from
> > > > > breakpoint or syscall. Note that it has to set up ax, r11
> > > > > and cx on the stack correctly only if it is called from syscall,
> > > > > that is not compatible with breakpoint mode.
> > > > > 
> > > > > > +	if (regs->sp != sp)
> > > > > > +		return regs->ax;
> > > > > 
> > > > > Shouldn't we recover regs->ip? Or in this case does consumer has
> > > > > to change ip (== return address from trampline) too?
> > > > > 
> > > > > IMHO, it should not allow to change the `sp` and `ip` directly
> > > > > in syscall mode. In case of kprobes, kprobe jump optimization
> > > > > must be disabled explicitly (e.g. setting dummy post_handler)
> > > > > if the handler changes `ip`.
> > > > > 
> > > > > Or, even if allowing to modify `sp` and `ip`, it should be helped
> > > > > by this function, e.g. stack up the dummy regs->ax/r11/cx on the
> > > > > new stack at the new `regs->sp`. This will allow modifying those
> > > > > registries transparently as same as breakpoint mode.
> > > > > In this case, I think we just need to remove above 2 lines.
> > > > 
> > > > There are two syscall return paths; the 'normal' is sysret and for that
> > > > you need to undo all things just right.
> > > > 
> > > > The other is IRET. At which point we can have whatever state we want,
> > > > including modified SP.
> > > > 
> > > > See arch/x86/entry/syscall_64.c:do_syscall_64() and
> > > > arch/x86/entry/entry_64.S:entry_SYSCALL_64
> > > > 
> > > > The IRET path should return pt_regs as is from an interrupt/exception
> > > > very much like INT3.
> > > 
> > > OK, so SYSRET case, we need to follow;
> > > 
> > > sys_uprobe -> do_syscall_64 -> entry_SYSCALL_64 -> trampoline -> retaddr
> > > 
> > > But using IRET to return, we can skip returning to trampoline,
> > > 
> > > sys_uprobe -> do_syscall_64 -> entry_SYSCALL_64 -> regs->ip
> > 
> > the handler gets the original breakpoint address, it's set in:
> > 
> >         regs->ip  = ax_r11_cx_ip[3] - 5;
> > 
> > and at the point we do:
> > 
> >         /*
> >          * Some of the uprobe consumers has changed sp, we can do nothing,
> >          * just return via iret.
> >          */
> >         if (regs->sp != sp)
> >                 return regs->ax;
> > 
> > 
> > .. regs->ip value wasn't restored for the trampoline's return address,
> > so iret will skip the trampoline
> 
> Ah, OK. So unless we restore regs->cx = regs->ip and 
> regs->r11 = regs->flags, it automatically use IRET. Got it.
> 
> > 
> > but perhaps we could do the extra check below to land on the next instruction?
> 
> Hmm, can you clarify the required condition of changing regs
> in the consumers? regs->sp change need to be handled by the
> IRET, but other changes can be handled by trampoline. Is that
> correct?

yes,
if handler changes regs->sp we return through iret
if handler changes regs->ip (the only other tricky one IIUC), we return through
the trampoline and jump to regs->ip via trampoline's 'ret' instruction

jirka

