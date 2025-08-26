Return-Path: <bpf+bounces-66530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D9AB356F1
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 10:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E928B171793
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 08:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294E22FAC03;
	Tue, 26 Aug 2025 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTbyDQUt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC24D1DED64;
	Tue, 26 Aug 2025 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197188; cv=none; b=IyrTmlD6/ZjVDc6g+br5ESSoXmQ2+EBh9yziCeRQth5T9Gon3Ak9RIhZWEF28nSyte9VnGZg6XMjiLvXK3UDA5xBecUX8yw+tbxjt5bipBoXGP/LQpLjn5zwj3HE7Z1QI6i2QD1Nywuc71dnS8Xdnxsrx/OfjwpGtN5i78Jwto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197188; c=relaxed/simple;
	bh=OA8xWJ/KnE4nlmU8LRAyhQqzQwAaRS5yTJxNqw1prBw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gV3NxS0PpeRHva8ar8DoSlW6MrJozJRH3ssDiCj1xkWrath8JH5TXLYkoLcZtaxSaJt3f2aTmyTHOcZ3vDiH3JQjVAPSF/UrV5CPIk2THgx18GLNvgxVlMwskIogzNV08csN9zcpOXU0yoRHvTPYHuIVZPZcDi6BN3DS+zxNbEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTbyDQUt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c6df24f128so2277269f8f.3;
        Tue, 26 Aug 2025 01:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756197185; x=1756801985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fl4XqMbw5eWLG21H5yX4CcJWnuTddZJ9fz6Oh8RT7c4=;
        b=jTbyDQUtdMKV89JSdp6IteZWNfJB1clC/aeKtqku5hZv/SPZxD3P29LYcXQdQ+z5Yl
         j5vjKOSITpmIGZl3xaVFrTapGQpgyuf61nWwvro/raus0fmHiwaq4qUCS2w60uMOeORR
         Q/2k4Jr7rMZKrZPKGNxSeVRv6wthH1hqPbPX57pBroo26ObNSE3h8D+fovb7m0Q0tpSG
         sp/IRL29xoTRjWeevsNTmZrktvgOF5lf3fnjFtApc5l8FFWu7z1HszaUK70RHyBCJfod
         ubwtYvCKC0USOkV0thn6LFALWFkQFFSipixgRFeufggXZ72lSE5Vo00kINWu/ZyHsUp3
         7bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756197185; x=1756801985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fl4XqMbw5eWLG21H5yX4CcJWnuTddZJ9fz6Oh8RT7c4=;
        b=Hq79HBNTpL9ReZ46EcZmf1VgA9sN7MkTw5B2BmVmCLjHPV9lHcuFT8eVxsI/NDx54W
         TAF03A0BejKfSggu5+nrPy6IiBLEhdgonHKB8P5x9DUjmbmwIuJF6uRAysCGH8+sJDKS
         e5QjomyYhxoj/IARXGMOZfRf57VXIqWCUgTyk/ankhsWWhwP+BzO8B2ly69HfbYV8Gj1
         g+R+4pTiVmWhg2WRFADNElfElshWY7xi23y00+FAUR+W2pousRrZIJC99B/LwybRqBjv
         t9Vnp6yHq+2VA3sPcu2ozhts0jcVuPnfUZqiuQWogH70o6HWJRaguCsLS6pWxxj00aKS
         UYvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6PWqKJ9Ld0ZPDG5U9oy+9P4+EHhEjPauPuPHg+lDLs4l4E0UU9QrRyHAxRZG8OxAwRxk=@vger.kernel.org, AJvYcCVpWi1oGTfQSu5kQ5XnUD9kNcYIClM9oKBfqCx2OpJ4soav7g4rJbenOyde008aoYLX73xM3ljQzr2A5Sdc@vger.kernel.org, AJvYcCXsqk/1BOTfs4536zvhbPaAOS678nfU8cyj/CXEtzchdzXop5ScKsNoqz0BxcHUsaGW5bzbFUrx0IlgpvA75IAagBaa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8wYxxbV66qzSHz132TLuQIg6b2GOUJweSToPFDd/e+s2Y7lwR
	WC/7s5ogqvKO59PZBT/SIkc0XSRkPkp8ZQcjkTaH57N2o1ytQZy0bv/ijv39+0Oi
X-Gm-Gg: ASbGncsmTW4EZtLg5VQzSwjnM9E75hCxydx1vNglt91q5Y6QSvWFYEGRE6zECu5oUyM
	4fT+3Bg8ZgI4Cql7rZP7DI6h+vf4rHFNg4C5J4O77LIry/XJcUQP+MhX06r7XSlibsoSSsuxne1
	zCN++qFeA79aHio2rURS7sq/TiNAnVF6WMP34cH1dWAiN57FC5Zgyfld6RSxQWb50W+AF5yDeOj
	EEKpD845vRnXMJo6MROSWtxafe/Xkdl/iPd9E4rjgh1dXr19glwVvVgyP0yeuZlUJJICWxjPU23
	17koAVMTxq0R3Tz3dKkzH5DPwQedUrAX0YwZMag+y2XvZ+LCyWkhlNWuix4Su5sait1zCTc=
X-Google-Smtp-Source: AGHT+IHscCe1NjLPLyPaBZZf+9xT5Q5fRNvd9R6wL0J4MFH2pGXT0pyHG4kc8nmj0tTbwW7rRFdlHw==
X-Received: by 2002:a5d:5d0d:0:b0:3b8:ebbe:1792 with SMTP id ffacd0b85a97d-3c5dac173f7mr11223041f8f.10.1756197185062;
        Tue, 26 Aug 2025 01:33:05 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba41bsm15802694f8f.10.2025.08.26.01.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:33:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 26 Aug 2025 10:33:03 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com,
	andrii@kernel.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, alx@kernel.org, eyal.birger@gmail.com,
	kees@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	haoluo@google.com, rostedt@goodmis.org, alan.maguire@oracle.com,
	David.Laight@aculab.com, thomas@t-8ch.de, mingo@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH 2/6] uprobes/x86: Optimize is_optimize()
Message-ID: <aK1xPy33UMlT-blF@krava>
References: <20250821122822.671515652@infradead.org>
 <20250821123656.823296198@infradead.org>
 <20250826065158.1b7ad5fc@pumpkin>
 <aK1veaIWBv3dZUUP@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK1veaIWBv3dZUUP@krava>

On Tue, Aug 26, 2025 at 10:25:29AM +0200, Jiri Olsa wrote:
> On Tue, Aug 26, 2025 at 06:51:58AM +0100, David Laight wrote:
> > On Thu, 21 Aug 2025 14:28:24 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > Make is_optimized() return a tri-state and avoid return through
> > > argument. This simplifies things a little.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  arch/x86/kernel/uprobes.c |   34 +++++++++++++---------------------
> > >  1 file changed, 13 insertions(+), 21 deletions(-)
> > > 
> > > --- a/arch/x86/kernel/uprobes.c
> > > +++ b/arch/x86/kernel/uprobes.c
> > > @@ -1047,7 +1047,7 @@ static bool __is_optimized(uprobe_opcode
> > >  	return __in_uprobe_trampoline(vaddr + 5 + call->raddr);
> > >  }
> > >  
> > > -static int is_optimized(struct mm_struct *mm, unsigned long vaddr, bool *optimized)
> > > +static int is_optimized(struct mm_struct *mm, unsigned long vaddr)
> > >  {
> > >  	uprobe_opcode_t insn[5];
> > >  	int err;
> > > @@ -1055,8 +1055,7 @@ static int is_optimized(struct mm_struct
> > >  	err = copy_from_vaddr(mm, vaddr, &insn, 5);
> > >  	if (err)
> > >  		return err;
> > > -	*optimized = __is_optimized((uprobe_opcode_t *)&insn, vaddr);
> > > -	return 0;
> > > +	return __is_optimized((uprobe_opcode_t *)&insn, vaddr);
> > >  }
> > >  
> > >  static bool should_optimize(struct arch_uprobe *auprobe)
> > > @@ -1069,17 +1068,14 @@ int set_swbp(struct arch_uprobe *auprobe
> > >  	     unsigned long vaddr)
> > >  {
> > >  	if (should_optimize(auprobe)) {
> > > -		bool optimized = false;
> > > -		int err;
> > > -
> > >  		/*
> > >  		 * We could race with another thread that already optimized the probe,
> > >  		 * so let's not overwrite it with int3 again in this case.
> > >  		 */
> > > -		err = is_optimized(vma->vm_mm, vaddr, &optimized);
> > > -		if (err)
> > > -			return err;
> > > -		if (optimized)
> > > +		int ret = is_optimized(vma->vm_mm, vaddr);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +		if (ret)
> > >  			return 0;
> > 
> > Looks like you should swap over 0 and 1.
> > That would then be: if (ret <= 0) return ret;
> 
> hum, but if it's not optimized (ret == 0) we need to follow up with
> installing breakpoint through following uprobe_write_opcode call

ah u meant to swap the whole thing.. got it

> 
> also I noticed we mix int/bool return, perhaps we could do fix below
> 
> jirka
> 
> 
> ---
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 0a8c0a4a5423..853abb2a5638 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -1064,7 +1064,7 @@ static int is_optimized(struct mm_struct *mm, unsigned long vaddr)
>  	err = copy_from_vaddr(mm, vaddr, &insn, 5);
>  	if (err)
>  		return err;
> -	return __is_optimized((uprobe_opcode_t *)&insn, vaddr);
> +	return __is_optimized((uprobe_opcode_t *)&insn, vaddr) ? 1 : 0;
>  }
>  
>  static bool should_optimize(struct arch_uprobe *auprobe)

