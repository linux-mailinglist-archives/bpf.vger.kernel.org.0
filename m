Return-Path: <bpf+bounces-29165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5FA8C0C95
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 10:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B371F2200D
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 08:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558FF14A098;
	Thu,  9 May 2024 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa3uBfDd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4001612E1C4;
	Thu,  9 May 2024 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715243449; cv=none; b=TQce8jfLzBSog0dex6JIq1SeYGUZMQT0eSIUIi6fF+LN1S+loXgc2BatQ+fYtrZtz1rRaBVmYHpnv309Ooli1j/goLuiE76nOWAOvARyQ4G4FZOko1Mfrx3mfVZ/Ux55HoFFvE7lS5Y6lCWF9F+UbDp0o/vqfUSnD698KSSHGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715243449; c=relaxed/simple;
	bh=Csbm16spngNqq/F2Dk/fnh8ntFFhKMPLnQkT6Wr+iY0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8Ky9Ysz/mHpJCsK5UVBzBWZSHMML68GSvogcRtjyTwiUl4/vQDpvUeZQPRXAQZsVwW0vKVffxKXEtRPAavswfVLZggslVRL1jWYLdK6JwLQs0TnuiKJQ5ObBbPRslaWLbyhyLX/cKeIr0IyHANijcBIpOkOUgMjSZwItqrH5zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa3uBfDd; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so647434e87.1;
        Thu, 09 May 2024 01:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715243446; x=1715848246; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X4/7bu7ewnVjt5wRsildefb8Ndmj1/3cq+0GpIKp4Mw=;
        b=Fa3uBfDdfh+tfI2GFpmawOSV0BnCBAXMVY3bbjlxjgNIycR1H8o8WO7xaztyLlS6Gj
         gjhPFl8m6AOujoyyK/4rn18m97mU8Epbf3+gyyzn5aFA+bxFHNYe4fMcnPXfTjJwZ5Op
         XV4FfdMEkP7t+IbwkaYSPNVwTdxymCUzySEGwRveF1GlToqe/0VDYf9YXKnXQXssxXSI
         yKtT1Zz/jU6/bhYMbCeHcmFJu/xIO7hZb4gXOM2AGgnizpY4dxfnYVfVBq++OKN7LDma
         11HeH/JENVCMa52SZ4Il/ejMF7icKMjm8+OKhBwz2JfwoUQD2Y6el9nQEVv5dMDiWXEo
         oeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715243446; x=1715848246;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4/7bu7ewnVjt5wRsildefb8Ndmj1/3cq+0GpIKp4Mw=;
        b=WnX0dNcLRJaVUhtK+3f/qKz0lNhvKD3PkvaiuN3+ZavmYg86xGQKFWjF/fxuvQfqAc
         JvPnZedh4g46a4t3bDiAyOiou6Q5dViiUmQmeJ+1oKBzrdTO4zeRpAeiJv6zawrzZIR7
         AYUkMGEfIegHL38Tq2G8DIg5/0J0Q3eFdZvL2i/He7pWu3JC/DCSKt6aBeYXlL04PjBg
         0wquzq7mSrgbkUtpXm4X4WJmrYcFmQK18ca+cRRm1kacePRtWIMl3OVwHEVlF8OwpkTn
         CDf0+4+wyt3bZ0CWxTSxSK4PrwsfcWAr8ua3iXQuMk9VbEULrW+XzqzMicOzhgdmquGU
         lLvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm8s1FY0YcKA+gFuqg4JnGX9+UFaE9QgFlCZPse0FDpvekxQ1vkJPd0nBHiNNS6BrN1UVul87d9aW5TiqpuKd/bPo0+quXifaM4zFMEGR3KbceD4reUkpNQ4vgr6M3GhOtBXVPjAH2FM/RK/fo2RskgB1en+JCJ7RC2IeoMCS+7GgTe5vefKsvoBLS5EjksDUZxXQgFO2eOV7792AGb72UFaTNaA87IPycjiqoiFwnOskJAJ22WcQudqkB
X-Gm-Message-State: AOJu0Yyvof+yzJmFwnUcLsNz/ptaqKbDL/JkQ/HAJ6gK/qFoc1SZuUfY
	sMcdfFvq6U+RpFiwDXl8W8Bz76Cz9KH3pgo1kbo1+BxKA94sX50q
X-Google-Smtp-Source: AGHT+IHsuTbKddeGklF4hAktuyIW+ua8ooMij/wsuat5VKs0CCYQwMQMvNWwhwEnlAQ02kiqZNRaoQ==
X-Received: by 2002:ac2:4197:0:b0:51d:9f3f:14ad with SMTP id 2adb3069b0e04-5217cc50d48mr3257055e87.47.1715243445809;
        Thu, 09 May 2024 01:30:45 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87b26675sm51944065e9.2.2024.05.09.01.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 01:30:45 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 9 May 2024 10:30:42 +0200
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yhs@fb.com" <yhs@fb.com>,
	"songliubraving@fb.com" <songliubraving@fb.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>
Subject: Re: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Message-ID: <ZjyJsl_u_FmYHrki@krava>
References: <20240507105321.71524-1-jolsa@kernel.org>
 <20240507105321.71524-7-jolsa@kernel.org>
 <a08a955c74682e9dc6eb6d49b91c6968c9b62f75.camel@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a08a955c74682e9dc6eb6d49b91c6968c9b62f75.camel@intel.com>

On Tue, May 07, 2024 at 05:35:54PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2024-05-07 at 12:53 +0200, Jiri Olsa wrote:
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 81e6ee95784d..ae6c3458a675 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -406,6 +406,11 @@ SYSCALL_DEFINE0(uretprobe)
> >          * trampoline's ret instruction
> >          */
> >         r11_cx_ax[2] = regs->ip;
> > +
> > +       /* make the shadow stack follow that */
> > +       if (shstk_push_frame(regs->ip))
> > +               goto sigill;
> > +
> >         regs->ip = ip;
> >  
> 
> Per the earlier discussion, this cannot be reached unless uretprobes are in use,
> which cannot happen without something with privileges taking an action. But are
> uretprobes ever used for monitoring applications where security is important? Or
> is it strictly a debug-time thing?

sorry, I don't have that level of detail, but we do have customers
that use uprobes in general or want to use it and complain about
the speed

there are several tools in bcc [1] that use uretprobes in scripts,
like:
  memleak, sslsniff, trace, bashreadline, gethostlatency, argdist,
  funclatency

jirka


[1] https://github.com/iovisor/bcc

