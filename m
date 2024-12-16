Return-Path: <bpf+bounces-47028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3D59F2B72
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 09:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC9D165506
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 08:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E618A20127B;
	Mon, 16 Dec 2024 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nS5AFYvj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C82171BB;
	Mon, 16 Dec 2024 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336218; cv=none; b=SJpXiqc/XYzSUP3VFV0KzT+ZxHAz1HpbUcRLKi6/T58R9ir+QCPs29khYxqQ+8Yc41FPInAeU50axDgSWpS+dCN22Zpy7lbwiGbESo4XwNwF/69oxinXs7wX/BIpeLgKoHxkHQ9EIzRigciBsMzlV6ll6M6WukAbIwF7xk8ZE3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336218; c=relaxed/simple;
	bh=PLTdXl25d8Yzujmnw9Ek54OVgC5xdWmAsMdbaVRNhYs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lR45CxWYg0kjlqO8WIV5pRzEWVEzROld8g+A1qmKWyaokCwccCh6FcQk5iuSvTidmoI/hTX4UL2+xq5t1ZrvTEY+zWY1vQIu+ORaC4Pi0fU9cquYbisZgoN9Hr9yrFfXgzOKayMAMpEua9mLzczDLsxnKYrkCZJXP1P0Ez5UHJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nS5AFYvj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa6c0d1833eso657650766b.1;
        Mon, 16 Dec 2024 00:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734336215; x=1734941015; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ET2EmSDFrzknOpgiLUh9ZRnpRLjgw6q5dLLxX6PLaUs=;
        b=nS5AFYvjfV3d7bEltNh3ld9bJ4czzRGwguGNag/sPgke5+3D+fLNA5vwPEmyIvFc7j
         DNpMgIB9HMGzjJUGPvqCPbv/SkTkfkVJEFm0+i0iuF/hHbp1eFganqMTCz47Y5theLLo
         eKqEgQHTr8BSlyp4Cb7M2VJmlfU7mV2BYQfjP6O3+nghXLLHFbRIkENhZmYR1KW+AJaD
         ooa4Ym/ViV0crA5s6XLFaAdB6jzLstRIWhFbnp4G4B7T8Da76Gc0ZuMU21IcZx94N9rF
         wkfUyBtwdlZSoH0rrhYu6Fr1RG8oUitXVJToyBaK+B76t0fSRglEWFchP0rn6KIQtLJq
         Krkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734336215; x=1734941015;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ET2EmSDFrzknOpgiLUh9ZRnpRLjgw6q5dLLxX6PLaUs=;
        b=QB6sgsv6gLpbhyJlegB+34+ZpWmO1zRcElEf5gCtHcgZTYgMkHsZxhkLVoYkqREGTz
         3gSZMsaReD7q9srQhIkTQwke58Un7wX533GKXI6gm5Llx5YDOTtwXe6/Qfa7A9hibX39
         fupcXbBBctVhetv0HaF2sJyb4sNwwqgJelCejdMESXFdGy73yUDW1lcUDTjSNMg2omlL
         v9p6Rtjc2jVUmmB9440jDXG+sGxSJoGAyIW3o1FbLPBSuCfRhicIe05MPauqqOY5Yl3R
         p/UfEOU7gkYesczbrcU012BYv/xtYwx2iL+IClBNcZ+0pLcIEozML3PKYlmPwsMhi4V4
         yu7g==
X-Forwarded-Encrypted: i=1; AJvYcCVh1jrKOawEn77ZuCdurWfoVu2OOsNCWTdtglF3e3ggt7XtEg18xBXhdpnfVCJfGSwOyxonqF2dH8jxvStA@vger.kernel.org, AJvYcCXA9LOKYolXrybPd4nsEpyQrz7mHg40d6ESMuV9j/931hvKKRgT/u8Z8ZHRuoafuBFGdUXy12eDcSd+3R7RxFMHheDZ@vger.kernel.org, AJvYcCXQaS+kK6ATfMWFeO62/XbF7A+K8Z3WM3VA9ZZsa0hYZmDepi5pu59aijF5aPhNCLaWdAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCQ9e+TVLzKrf/bea6zVhe0rzSrsW91jGKHquLX64S7MP3zbbf
	XGUzTK+jky0Ea4Y1gU0KFrUTZ7Gfb5UM2+/Abkzkw6kZamVYw2qz
X-Gm-Gg: ASbGncvD5Zgn82EJFD9npVDoNvf1D26BISSi0PDGpPhLk8FFrAzMDeWOqxdtWwtGPZu
	aCT0Sx9sQE/GghqPaJKaq1zgOhYIviaRtjcgtPvjgCeMMZmrba4i5yQLm47rO48irQwG8GVH0q1
	2y9hb/g3jVGCntApEuVr2PH9KtW0CSPJvMftYt751fFkKEB+6PGaTX/XS8jlcLn1GdQBRIQG8mW
	gG0RCO9T0BQi1Dsip/8JvdpTneK9LZ+D39dUJKH4RFRWRD5KcuOWRq+m0PH/X42DJVbqzJ3hThB
	Q0v4k16Ss+d4MrnZBq931bz8mlgYIQ==
X-Google-Smtp-Source: AGHT+IF7bp0ZljhGCA0JYAxDKj0EMLhMDy2gFBBdb6vD753/Fp2MT3HA6q/ApSnSFkj6SZ0bUInEMg==
X-Received: by 2002:a17:906:31cc:b0:aa6:423c:8502 with SMTP id a640c23a62f3a-aab77ef7ec8mr939147266b.60.1734336214743;
        Mon, 16 Dec 2024 00:03:34 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab960681a4sm299699266b.54.2024.12.16.00.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:03:34 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Dec 2024 09:03:32 +0100
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 06/13] uprobes/x86: Add uprobe syscall to speed
 up uprobe
Message-ID: <Z1_e1OPwP-qUPb1_@krava>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-7-jolsa@kernel.org>
 <66e85401-b2ec-442d-bebe-c4ff3151e7e2@t-8ch.de>
 <Z1xKAKnX3su21JZu@krava>
 <bd095061-f43b-4b99-bb94-40cdeac76f4c@t-8ch.de>
 <Z1ysj_PXy51WeAT2@krava>
 <ec6f4159-8428-4156-9413-d5aa6b39e5eb@t-8ch.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec6f4159-8428-4156-9413-d5aa6b39e5eb@t-8ch.de>

On Sat, Dec 14, 2024 at 02:21:43PM +0100, Thomas Weißschuh wrote:
> On 2024-12-13 22:52:15+0100, Jiri Olsa wrote:
> > On Fri, Dec 13, 2024 at 04:12:46PM +0100, Thomas Weißschuh wrote:
> > 
> > SNIP
> > 
> > > > > > +static int __init arch_uprobes_init(void)
> > > > > > +{
> > > > > > +	unsigned long size = uprobe_trampoline_end - uprobe_trampoline_entry;
> > > > > > +	static struct page *pages[2];
> > > > > > +	struct page *page;
> > > > > > +
> > > > > > +	page = alloc_page(GFP_HIGHUSER);
> > > > > 
> > > > > That page could be in static memory, removing the need for the explicit
> > > > > allocation. It could also be __ro_after_init.
> > > > > Then tramp_mapping itself can be const.
> > > > 
> > > > hum, how would that look like? I think that to get proper page object
> > > > you have to call alloc_page or some other page alloc family function..
> > > > what do I miss?
> > > 
> > > static u8 trampoline_page[PAGE_SIZE] __ro_after_init __aligned(PAGE_SIZE);
> > > static struct page *tramp_mapping_pages[2] __ro_after_init;
> > > 
> > > static const struct vm_special_mapping tramp_mapping = {
> > > 	.name   = "[uprobes-trampoline]",
> > > 	.pages  = tramp_mapping_pages,
> > > 	.mremap = tramp_mremap,
> > > };
> > > 
> > > static int __init arch_uprobes_init(void)
> > > {
> > > 	...
> > > 	trampoline_pages[0] = virt_to_page(trampoline_page);
> > > 	...
> > > }
> > > 
> > > Untested, but it's similar to the stuff the vDSO implementations are
> > > doing which I am working with at the moment.
> > 
> > nice idea, better than allocating the page, will do that
> 
> Or even better yet, just allocate the whole page already in the inline
> asm and avoid the copying, too:
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index b2420eeee23a..c5e6ca7f998a 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -462,7 +462,7 @@ SYSCALL_DEFINE0(uprobe)
> 
>  asm (
>         ".pushsection .rodata\n"
> -       ".global uprobe_trampoline_entry\n"
> +       ".balign " __stringify(PAGE_SIZE) "\n"
>         "uprobe_trampoline_entry:\n"
>         "endbr64\n"
>         "push %rcx\n"
> @@ -474,13 +474,11 @@ asm (
>         "pop %r11\n"
>         "pop %rcx\n"
>         "ret\n"
> -       ".global uprobe_trampoline_end\n"
> -       "uprobe_trampoline_end:\n"
> +       ".balign " __stringify(PAGE_SIZE) "\n"
>         ".popsection\n"
>  );
> 
> -extern __visible u8 uprobe_trampoline_entry[];
> -extern __visible u8 uprobe_trampoline_end[];
> +extern u8 uprobe_trampoline_entry[];
> 
> 
> If you want to keep the copying for some reason, the asm code should be
> in the section ".init.rodata" as its not used afterwards.

perfect, no need for copy, I'll do what you propose above

> 
> (A bit bikesheddy, I admit)

thanks for the review,

jirka

