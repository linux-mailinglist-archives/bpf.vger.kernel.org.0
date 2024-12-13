Return-Path: <bpf+bounces-46857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561469F0FA5
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 15:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F7328362A
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5001E25F8;
	Fri, 13 Dec 2024 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXG2s3oB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D0F1E2307;
	Fri, 13 Dec 2024 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101509; cv=none; b=gmWUaIdZi1QdEl4X9SohWrb6d1xsanHxBbfjV2bft+9GG44+i3myPoAwENukRoNayWxrnMdIWYODc0QRNiuUpfmm18ZXAI4CbgkvxKEBdxfsIIG8d32lL4xmmJrVa7mab+o/7aopBsGhnnODxX5fArP+U9agBB2Z5z2gXqhuxSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101509; c=relaxed/simple;
	bh=AcwLDCrhmT093MAx5669WpSb6W4SciI0PAntUxGIfSM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpRgVZrkb6QXogt2liQ2DP6udvISCdiREPBkxENJ7riRZrDDH3kN3p9Gvoehi62Gja1Zj3j1hwMxOnyobyVco/ZvyCe4Os1U3YgWQUeBTP2blys4wgGkcWYO6LzSvp0J52INZh6VMf/rUgHabx1wiPy5oSC35KK0rYrVq3i5IXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXG2s3oB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso18648665e9.2;
        Fri, 13 Dec 2024 06:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734101506; x=1734706306; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wO11UitlPTLO/UgtijQoipzUiwAqw6F40i63P4efTn0=;
        b=ZXG2s3oBs6Y98iCahspXVLs5CN6lCBB5wTzbzuBMf22wYwJJTzWDun605MQHpJizkD
         t0ULqqeVGR7MGuZeR5vU1pXdwXXAE/VCsAzmHGTfkYEhOM4QpJ6lsF1pP5DdoA3jaU0d
         5etjhEDcb7u47oyBF6U5nNW8x8OY6WRoJpPgjlE0HOMMNSdip7tD7r9Tz1DxbiibWht4
         BtG+VyVnkz4C+1ifI4+WU0SjbinBrYcpYFRGP4ZZq/Hkeq2CaBXUVUKvW4xOEh6lfB/O
         8YRW5c8vp9iN/nL5zQJ3l6RCNWvz8fr1uaeGs7Vc8BbvfIM/eV0A36ke/hV/Z2HSGmkF
         qjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101506; x=1734706306;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wO11UitlPTLO/UgtijQoipzUiwAqw6F40i63P4efTn0=;
        b=fSkbOeHiKWSu2fnQV9aikEAF9ddFG9viOg9lXUfId2OzPQ8bu5VIyZAggkUhxi3MW7
         TMKllbTCimsdl58cwYeT6ghIHfp6/iJRC/B8eEPpaFte66zMwbIdZkWI79MiFIic+5Qq
         WSIhE0gQcFnBcGK9VURCjM8oZtmXa34sU1am0E3Xe4wrtVCtiQyhlVKrgUiEU/R+m3Fk
         Sq25ewFtj8qQE3K3NaqnAbdsOLDJKpli5+/bM/BYG1i5Cq+VjUIWQiJygd3UIvCmUa0U
         x3LhbEvDjCthWwATHZ6ymZGopBgUZOAyvCtO7VavWl5OOjd1ZlMaxzWAQd7iFfh1rVbo
         EVPw==
X-Forwarded-Encrypted: i=1; AJvYcCV/Tjy9tRuuURqWIon0UWpSrgYSuKdio+ToSxt9Whb7vYJSY+cYnVzLbsOQk75yrVS79FO3z+D1DJtvVivtEfk+syA+@vger.kernel.org, AJvYcCV6mzy+GpQa4OVpaGlDDqS99/rbCMtA1jCXBSX6duhQRtxvdVfAVC+QIgZRkri/NIXx09zZh6i1i/MWatB6@vger.kernel.org, AJvYcCXFJ84837Js/XMmU8K75mCgIYcrL8KvXrI6FR2QTtp9c21WJvH9KWSdxFusgPLs2LwU/+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYjvmFI1tLv8rz3cJ2KaHpkK3lSnGByjA2GNXgNcFRgaz0s40l
	+Y0lQqBSWZPKhRHaYqu+0SX7iulB4K+UYLQL5nC1zyo6505L0c+L
X-Gm-Gg: ASbGnct2AYqjIYttUzENIOcS0l/T3gSByg8z4Vj/BdwKrqw6PnUIABqFDkHcOp36+5+
	cG6A/SqUBKuLRJi7FLgLgni3RxHbJwBcXLNz1D44oFD3MN+GBinL+l4NpL99X+tTaVuvLwfJN1B
	VeQ98m/3xMv6cPT0kc4PFc1l1NsIyxC9NDF4KDKA3bdYYcJ/vvgFcbrlRuGFlI3PRDFIYFY7KyM
	mwRosTW36jKqkV70BE+QuYd37JkKWV42YW65LRbphfjqG1awMbZovDRfeXEt2gq+/ULAwGq45s9
	z5/IJ91+jz8NmVY7VtcypbBht3C7GA==
X-Google-Smtp-Source: AGHT+IGz/CRc7Xqe31QqU7ApSbcW2GW1z/m5Z7IpTOERFFnrIkD15JOV6f8gYWo21gZifw5ihZEqHA==
X-Received: by 2002:a05:600c:5397:b0:434:a1d3:a306 with SMTP id 5b1f17b1804b1-4362aa157damr21176755e9.5.1734101505946;
        Fri, 13 Dec 2024 06:51:45 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559ec08sm51754935e9.22.2024.12.13.06.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:51:45 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 13 Dec 2024 15:51:44 +0100
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 06/13] uprobes/x86: Add uprobe syscall to speed
 up uprobe
Message-ID: <Z1xKAKnX3su21JZu@krava>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-7-jolsa@kernel.org>
 <66e85401-b2ec-442d-bebe-c4ff3151e7e2@t-8ch.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66e85401-b2ec-442d-bebe-c4ff3151e7e2@t-8ch.de>

On Fri, Dec 13, 2024 at 02:48:00PM +0100, Thomas Weißschuh wrote:

SNIP

> > +static int tramp_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
> > +{
> > +	return -EPERM;
> > +}
> > +
> > +static struct vm_special_mapping tramp_mapping = {
> > +	.name   = "[uprobes-trampoline]",
> > +	.mremap = tramp_mremap,
> > +};
> > +
> > +SYSCALL_DEFINE0(uprobe)
> > +{
> > +	struct pt_regs *regs = task_pt_regs(current);
> > +	struct vm_area_struct *vma;
> > +	unsigned long bp_vaddr;
> > +	int err;
> > +
> > +	err = copy_from_user(&bp_vaddr, (void __user *)regs->sp + 3*8, sizeof(bp_vaddr));
> 
> A #define for the magic values would be nice.

the 3*8 is to skip 3 values pushed on stack and get the return ip value,
I'd prefer to keep 3*8 but it's definitely missing explaining comment
above, wdyt?

> 
> > +	if (err) {
> > +		force_sig(SIGILL);
> > +		return -1;
> > +	}
> > +
> > +	/* Allow execution only from uprobe trampolines. */
> > +	vma = vma_lookup(current->mm, regs->ip);
> > +	if (!vma || vma->vm_private_data != (void *) &tramp_mapping) {
> 
> vma_is_special_mapping()

did not know about this function, thanks

> 
> > +		force_sig(SIGILL);
> > +		return -1;
> > +	}
> > +
> > +	handle_syscall_uprobe(regs, bp_vaddr - 5);
> > +	return 0;
> > +}
> > +
> > +asm (
> > +	".pushsection .rodata\n"
> > +	".global uprobe_trampoline_entry\n"
> > +	"uprobe_trampoline_entry:\n"
> > +	"endbr64\n"
> > +	"push %rcx\n"
> > +	"push %r11\n"
> > +	"push %rax\n"
> > +	"movq $" __stringify(__NR_uprobe) ", %rax\n"
> > +	"syscall\n"
> > +	"pop %rax\n"
> > +	"pop %r11\n"
> > +	"pop %rcx\n"
> > +	"ret\n"
> > +	".global uprobe_trampoline_end\n"
> > +	"uprobe_trampoline_end:\n"
> > +	".popsection\n"
> > +);
> > +
> > +extern __visible u8 uprobe_trampoline_entry[];
> > +extern __visible u8 uprobe_trampoline_end[];
> > +
> > +const struct vm_special_mapping *arch_uprobe_trampoline_mapping(void)
> > +{
> > +	struct pt_regs *regs = task_pt_regs(current);
> > +
> > +	return user_64bit_mode(regs) ? &tramp_mapping : NULL;
> > +}
> > +
> > +static int __init arch_uprobes_init(void)
> > +{
> > +	unsigned long size = uprobe_trampoline_end - uprobe_trampoline_entry;
> > +	static struct page *pages[2];
> > +	struct page *page;
> > +
> > +	page = alloc_page(GFP_HIGHUSER);
> 
> That page could be in static memory, removing the need for the explicit
> allocation. It could also be __ro_after_init.
> Then tramp_mapping itself can be const.

hum, how would that look like? I think that to get proper page object
you have to call alloc_page or some other page alloc family function..
what do I miss?

> 
> Also this seems to waste the page on 32bit kernels.

it's inside CONFIG_X86_64 ifdef

> 
> > +	if (!page)
> > +		return -ENOMEM;
> > +	pages[0] = page;
> > +	tramp_mapping.pages = (struct page **) &pages;
> 
> tramp_mapping.pages = pages; ?

I think the compiler will cry about *pages[2] vs **pages types mismatch,
but I'll double check that

thanks,
jirka

> 
> > +	arch_uprobe_copy_ixol(page, 0, uprobe_trampoline_entry, size);
> > +	return 0;
> > +}
> > +
> > +late_initcall(arch_uprobes_init);
> > +
> >  /*
> >   * If arch_uprobe->insn doesn't use rip-relative addressing, return
> >   * immediately.  Otherwise, rewrite the instruction so that it accesses
> 
> [..]

