Return-Path: <bpf+bounces-56591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA503A9ADE2
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 14:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23AC1B636FA
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 12:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DEE27B500;
	Thu, 24 Apr 2025 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pnfe/48D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4972701AA;
	Thu, 24 Apr 2025 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498961; cv=none; b=aoDl/i5iVDJZYpvvTJgKSHw7vyLMn4pBX/G3NgBM9gv4WiGVPqLTEwMFvXWPgyrXrTKaq0Gs1zD0a5rEQKIex4jjdYdivSnlvAuD6vjgeF1NXusoww9Q3UZa3MofMa7iTRRoDArhnNC8c7kkjF60o4r1DLGFcfj8Funx18uxKlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498961; c=relaxed/simple;
	bh=iUgEmDrrdGRxcE2iCV8QXutWLhxWWV5HKvMxz9BWVgE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNZa2B/QjOStSQyqzbjXjQMbbJcnZOG5hQGsg2j1O/W2uUqtfb/v9Yi+DyKanpYpTmBzMl9LAccLP1lRrjT2jBHGEzC2V3nRIRI3ttPyDauLDP3SBwCjIqwh8oLeLW2sXTDOuTgyQsaCnxIWSjV6fpkUWDKIDOvH0vWp6jXbUxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pnfe/48D; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ace333d5f7bso177404466b.3;
        Thu, 24 Apr 2025 05:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745498958; x=1746103758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x3PREqi5mpIHw6+adDwUcuhHfKjMy7sAKK4QZRG6khE=;
        b=Pnfe/48DgR6oa9cyR88OlpmkiaMSSqLDgQMlOKcY6kaNRxOO7cWjjGq5iK0iTCs0Qt
         hWdExC6nIEeMAur9A+53TeLpZc56GlNzqpo/GUQrlA/dfVywhBuMe+WSSeOSHg9IeFby
         pVFtqfx3LZQq3KW+VGGmgzl/rXqW2Ziv77JJMtiPK/xtqFzXFa4DpXn+9q98sWg+F/up
         Ay9uqksJz7q9Oh/58v+R9AyrDOi0bPLe8Je3kTInmkQKuZ7yONCth3g2C/rAe7JZL1LS
         HsymbEPIHaIDhkr52LBt0djqi4huqmMmSdvXOE2kzcYRZlmCiM7VNGrGz0YgzptaHxIJ
         fp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745498958; x=1746103758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3PREqi5mpIHw6+adDwUcuhHfKjMy7sAKK4QZRG6khE=;
        b=fljQZ6VtG2ucnPgMPvDSURSDKpDWnK1dcO32cUVhKvn6wBGAfA38/9IcIEbZE1gEX2
         V6TKbE1e0rO8Z67AU8am1Icn45Q1uGXLrYONzNKzYJQPtjtR4XjLT+w3jImgal2CPRBx
         PFHNwmw5JJ3oefOrqxxzjCjPPMGmKsDrm0xQ0RcxmF8M8DyPZunDQivbAVlBMSkJlFrU
         7iSK+UvSI96tPKE+qZGT3kgF8Zo1V4RC/ouczdiQqt6eMK3o09rbxDol0p69rET0/tM0
         QW5NSZggT2gIeaqB93xFnlkWfei9PbvoYQ+tm9EB0s/bOXtTlNnFYn36+BmfLG3Q/BBe
         lGlw==
X-Forwarded-Encrypted: i=1; AJvYcCViWBW3/E586+KEpG19f7nsVE1KlODrlPUoPaEhKUh6m23imh1nDMTcf/S1PkPSgwyGrikobv54DGXqly79@vger.kernel.org, AJvYcCWdSNa8sR1TbXxuJZ0H37PCnkyXaChs9+tFDoMBzsMLiDnF5czqsqtQErtEdaLKAn4srjilYux6Y4iDgATULXbWPbAl@vger.kernel.org, AJvYcCXdN481mlu095XXDWhPiw63h9nczW8Sq/0G5PHfFMk9AOhWHfHPsUdgKcyWZgeKBSpf/xw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6rNab0MFIzcC7YXYqh01iuV/qk4l6HGwDkuZDVhUD/wSt/D6I
	7CEyjDCLcWNE1RXir88fwLtkdF4mKUPI4KK0HCMf77u7Ich4UA1R
X-Gm-Gg: ASbGnct7KhURawsjgVSixwegOeiXQi7iTQ18v9/I6B1QyDRDNeLnASf/xKRGyzD3U+g
	ey0ab8EolXZm9KEkPPOXxa6hP/LFvia3IB7b3ZoQ6qUv3lxMWLVyAaC0ev0XuyxHgl68A4jRUx6
	6UpzZfiNbhEuQPkoIJ+EKqTdl6zWmrzPGfNwwn6+L9WqnJp42ZIZATECa90w2umlpx+9oKF4tln
	IwxSbfiYw4Kt2SL20/fvXo9WMjOOIkBuh4HIPIxQ3AHeco3TXgo0tiRYp5mEsuMpvae1oAcnXyV
	1kjJA28BGWHZAarE2RqYkChs24b7OYL7AZfH0g==
X-Google-Smtp-Source: AGHT+IEqolvyXmoJv9zuVLvctan1U7z5XFIwLUwH3MzFK9iJr7WiPjI5btIHC50iw45YOnZUCA04zA==
X-Received: by 2002:a17:907:96a9:b0:acb:107e:95af with SMTP id a640c23a62f3a-ace573badbdmr227478666b.39.1745498957806;
        Thu, 24 Apr 2025 05:49:17 -0700 (PDT)
Received: from krava ([173.38.220.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace5989b1b6sm104746866b.74.2025.04.24.05.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:49:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 24 Apr 2025 14:49:14 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <aAozSky7pIIGIB4s@krava>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-11-jolsa@kernel.org>
 <CAEf4BzbJJuKY+eTaDvwhgmp9jBqYXoLWinBY8vK0oYh0irC07Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbJJuKY+eTaDvwhgmp9jBqYXoLWinBY8vK0oYh0irC07Q@mail.gmail.com>

On Tue, Apr 22, 2025 at 05:04:03PM -0700, Andrii Nakryiko wrote:

SNIP

> >  arch/x86/include/asm/uprobes.h |   7 +
> >  arch/x86/kernel/uprobes.c      | 281 ++++++++++++++++++++++++++++++++-
> >  include/linux/uprobes.h        |   6 +-
> >  kernel/events/uprobes.c        |  15 +-
> >  4 files changed, 301 insertions(+), 8 deletions(-)
> >
> 
> just minor nits, LGTM
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> > +int set_swbp(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> > +            unsigned long vaddr)
> > +{
> > +       if (should_optimize(auprobe)) {
> > +               bool optimized = false;
> > +               int err;
> > +
> > +               /*
> > +                * We could race with another thread that already optimized the probe,
> > +                * so let's not overwrite it with int3 again in this case.
> > +                */
> > +               err = is_optimized(vma->vm_mm, vaddr, &optimized);
> > +               if (err || optimized)
> > +                       return err;
> 
> IMO, this is a bit too clever, I'd go with plain
> 
> if (err)
>     return err;
> if (optimized)
>     return 0; /* we are done */
> 

ok

> (and mirror set_orig_insn() structure, consistently)

set_orig_insn does that already, right?

> 
> 
> > +       }
> > +       return uprobe_write_opcode(vma, vaddr, UPROBE_SWBP_INSN, true);
> > +}
> > +
> > +int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> > +                 unsigned long vaddr)
> > +{
> > +       if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags)) {
> > +               struct mm_struct *mm = vma->vm_mm;
> > +               bool optimized = false;
> > +               int err;
> > +
> > +               err = is_optimized(mm, vaddr, &optimized);
> > +               if (err)
> > +                       return err;
> > +               if (optimized)
> > +                       WARN_ON_ONCE(swbp_unoptimize(auprobe, vma, vaddr));
> > +       }
> > +       return uprobe_write_opcode(vma, vaddr, *(uprobe_opcode_t *)&auprobe->insn, false);
> > +}
> > +
> > +static int __arch_uprobe_optimize(struct mm_struct *mm, unsigned long vaddr)
> > +{
> > +       struct uprobe_trampoline *tramp;
> > +       struct vm_area_struct *vma;
> > +       int err = 0;
> > +
> > +       vma = find_vma(mm, vaddr);
> > +       if (!vma)
> > +               return -1;
> 
> this is EPERM, will be confusing to debug... why not -EINVAL?
> 
> > +       tramp = uprobe_trampoline_get(vaddr);
> > +       if (!tramp)
> > +               return -1;
> 
> ditto

so the error value is not exposed to user space in this case,
we try to optimize in the first hit with:

	handle_swbp()
	{
		arch_uprobe_optimize()
		{

			if (__arch_uprobe_optimize(mm, vaddr))
				set_bit(ARCH_UPROBE_FLAG_OPTIMIZE_FAIL, &auprobe->flags);

		}
	}

and set ARCH_UPROBE_FLAG_OPTIMIZE_FAIL flags bit in case of error,
plus there's WARN for swbp_optimize which should pass in case we
get that far

thanks,
jirka

> 
> > +       err = swbp_optimize(vma, vaddr, tramp->vaddr);
> > +       if (WARN_ON_ONCE(err))
> > +               uprobe_trampoline_put(tramp);
> > +       return err;
> > +}
> > +
> 
> [...]

