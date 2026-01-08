Return-Path: <bpf+bounces-78229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 595D9D035CF
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 15:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C470030019E6
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 14:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E603EF0D5;
	Thu,  8 Jan 2026 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3ESvgyB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204343D3CF5
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882766; cv=none; b=VOriqfj4g9K4439iLhwWa1pzpXdV13W4Nap2X+0ySx4SVd+JY/cyc9PtRvuKhI739S931u0++dv9LthLdK1aqn0aTZg+B3gjM9H01Rupt5ABbPsLfWi61xoC8h0CMErarmHkrUztJ2uwEqjG5rn6nxFQGiY8aCWt0Q/s6C1znzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882766; c=relaxed/simple;
	bh=dHjIgFqdeoPzZ5z+03xbnogVyQwTr9wuLKUwgnPwV5g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4RtWaheYG87A6j5xGbU5XaMZ0tcmGekj9HF0/yxzFa9o/eCnQmiVOMA5TJytFnYUFvjEvAehjy4bv4sEq0KfDr2SrLj2+yZTHMN08OfKyjgV+Y2/GzcjfVwj3Wf+JfcrJvAZyPAJcYnaxDAvOE80/mtCYVUyIEvH+5/RV1qcs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3ESvgyB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so30585795e9.1
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 06:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767882763; x=1768487563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dKsZk5STRUk0X4Pv4cc5SZyi6XswPBivoY5uNi8SKAU=;
        b=e3ESvgyBt9gQC42atr/ki2jdc8asvgjXgWS7NTslxdIZMC+NBmxPxSwI3k0RKU5SO9
         /UyneP+AJEY7kAZPrr8Cin3d6ob9M20cbqWCCf1NvimjKDyUV/KuPVJ+89IxyKLVFjED
         ejkMuPr1PprNWktCdPuA35EKU7tRdtm2G+oXEko3C+ynagQTCJ7kkBkt0yPQHNxhl55l
         t5zikgTxhmK1Ey+/km+FWTHUMPKAB6G3emEa/YSlV1Mc8c1+h4DJ0w/w1Mqj7Jr/OoRJ
         gZOciTuVfrCV2gZkV6RK3bYcVRvYsxfoGwLTDqy6YGD288vtNUi6uH7pRR/DyEWBZSp8
         B0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767882763; x=1768487563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKsZk5STRUk0X4Pv4cc5SZyi6XswPBivoY5uNi8SKAU=;
        b=pAlJ8uAeng6mmYwopcmvJRr73b1bQXs7v2EPOlxhuMRUz7rgXVhZXkWLBulha0VvGx
         KpC9SaTFiZlg/kvJJxvXwES9E4cDQFoGeRorKRjHuo+WOzJCXwBLL5vm6zlE7XX8VnS9
         l10wD7BkuS1N7etIVjFWbSIBiVswBGjS8vtnqJQgBQg2I3uoW+pEhzn/oTc8aYSeNfGZ
         Im33ggru0BfwVKxEx7BFKPaF0DFwru9qVcyhA+NwUkZdacisrZjcTWiF4HwsQLFp+y4W
         Jlg0GHIEQL5PnbYlIEUPdH3uQovwErCtNKIlM9z6yqIXSeB1qmCvw8VcnWfYdBFgnpUd
         Dwbg==
X-Forwarded-Encrypted: i=1; AJvYcCUTMITtXFy4KxKbw8yTPKAiWz8o/y/IhdqRAtaO2saDFq4hSU/ephihx5R0Ue3HK7M1CbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0T3g6Y2n/f1WnQwV1+SLAQoOhfBVxGSG+dQ7qUIUzIc9TCVSP
	Sv/TIiMrSN7zjJGbCxbhO1FbCIcIZRcQmTYmvK0Hrk5D0Yi6BxthABbP
X-Gm-Gg: AY/fxX6lA8vbi/pDXJVTGUT1OWvXSKAb4jvDFPM5AI4ntWtgFNKBMjT78vLjvjZL4f7
	VN3ywKXj5pucv38Qadw+43eMyU+dUx16XtCuyg/vsTPt8x2A1fiV5UcdfpiRS4GWT4JNDXpNIPz
	dy9nASot/6MHISfe9y7wMYyoU4+i2wZ/bz1SRlVian22XoPqLHWM7EIjAyuGjh2SlPfAx1oJBsk
	GECFWW+2CXM7WbBa+MDnO5kBdrwmha/kCPxS/PlAtEjE/BZ9KQUatLKRRC3RCYnGcMCTRK4ytHz
	tHqH6hK29ExB6h1EwwJoZ5a+Ftg/9edtFLp3Hhvj86nPDD1j8m8gWR1UMPFwnB38b5ghDTNVnLL
	0M99QgnA9oAn9BYmF8RKzbCN+rri9phpNnkxTyKLruIWDNpnCKLmKKStrrhKT87EpA9X96gzDBB
	w=
X-Google-Smtp-Source: AGHT+IGnDsY3fisUw/PeO5pgI1mNCLBNotubRxiPg3jCybSey6S3sceqOXla0zwMBu7+42vl1Y5nvA==
X-Received: by 2002:a05:600c:4ed1:b0:47d:18b0:bb9a with SMTP id 5b1f17b1804b1-47d84b54031mr77169965e9.33.1767882763275;
        Thu, 08 Jan 2026 06:32:43 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm159970735e9.7.2026.01.08.06.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:32:42 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 8 Jan 2026 15:32:40 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Will Deacon <will@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH bpf-next 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <aV_ACGtNHRfheAme@krava>
References: <20260107093256.54616-1-jolsa@kernel.org>
 <20260107110352.3fd7ddda@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107110352.3fd7ddda@gandalf.local.home>

On Wed, Jan 07, 2026 at 11:03:52AM -0500, Steven Rostedt wrote:
> On Wed,  7 Jan 2026 10:32:55 +0100
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > index 1621c84f44b3..177c7bbf3b84 100644
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -157,6 +157,30 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> >  	return regs;
> >  }
> >  
> 
> See my reply in the other email thread:
> 
>   https://lore.kernel.org/all/20260107105316.2b70a308@gandalf.local.home/

ah ok, thanks

jirka

> 
> -- Steve
> 
> 
> > +/*
> > + * ftrace_partial_regs_update - update the original ftrace_regs from regs
> > + * @fregs: The ftrace_regs to update from @regs
> > + * @regs: The partial regs from ftrace_partial_regs() that was updated
> > + *
> > + * Some architectures have the partial regs living in the ftrace_regs
> > + * structure, whereas other architectures need to make a different copy
> > + * of the @regs. If a partial @regs is retrieved by ftrace_partial_regs() and
> > + * if the code using @regs updates a field (like the instruction pointer or
> > + * stack pointer) it may need to propagate that change to the original @fregs
> > + * it retrieved the partial @regs from. Use this function to guarantee that
> > + * update happens.
> > + */
> > +static __always_inline void
> > +ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs)
> > +{
> > +	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
> > +
> > +	if (afregs->pc != regs->pc) {
> > +		afregs->pc = regs->pc;
> > +		afregs->regs[0] = regs->regs[0];
> > +	}
> > +}

