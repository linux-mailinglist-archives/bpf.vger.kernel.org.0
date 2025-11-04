Return-Path: <bpf+bounces-73424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33053C304D2
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 10:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5024B3B2DBD
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 09:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBE72C3247;
	Tue,  4 Nov 2025 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4IhtWMC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032F72116F4
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248446; cv=none; b=cZQBTz1+aIOh0eQ0WprvVD1LCJGJ3mpvktBI2WQnzYQmbcaoN20zPfH41CDZWOkMjCiiw6AZw3Bj4X4tIhpgJwFLFCDPJEikEeiPB2MNje9inJAw3B+3jeC32G5/6lCI9/4Soloemy0OisxsceAjBymmpC8cN+wkln5+ppZSMkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248446; c=relaxed/simple;
	bh=VIL05nHFT4N6JAG/H2iMRz7OrtDZbp13GR+Lkr9m0m4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kee3WqaYOfu+aABlv9FGBOZZ+pLVG2RKZYP4SJgGWzhw1JnGycdPInF0EZ8Nbq78EPeSYEl8YqgU+lsn0OHYw0Z9w4naOU0susAsCrsvGAsj9YyNgGTg66fLwUzz7pk8lg8Q0RKY1HJy7XA4bmo3st8schTS/Wv7qQ4osmomwQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4IhtWMC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429c7869704so3315462f8f.2
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 01:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762248443; x=1762853243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oAiC86qBA7A39iWQR2bMUkqXVWA4G10ZvXba/KKkMyI=;
        b=K4IhtWMCtKLxMSMUCxBB4qWgLuSWTpzCT12alYZRcv4KDgzm7rz/ezkL79TgPc9cdN
         X4S/9WQThRupWvuEN5VYqQXHXyxoHHsIL1+nPrXv8g8PRmkJhC8ylBG5mPWthm6And69
         q/YHnxLQVkrvTkW9n2AuTGoamQqxtp/yvkHje++WYSzQ4YnWg9pvZJvdj69kWA5GcGYE
         oSOCIyJ4h9R9gABKW7tCkU3fu8V4G6KQpoxNKkf78akoCNLmOexow4EHR9Nn3jwc500X
         cDBFf/TffiDhObbufEB9KNMDhiuJURctJeXoRITDpwlwhDx8CsADckLs0T8t8UY8f0a/
         +sig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762248443; x=1762853243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAiC86qBA7A39iWQR2bMUkqXVWA4G10ZvXba/KKkMyI=;
        b=gDJt45vFRMO4Q/L2Jr9BxrSJQ35XM/3NLv2pvktx1MW4grFUPUtQvMyCDFlG8Dk72u
         XVKdOahvSEmjHEUf3H9RWMgZV05Ici1we5a0tdu9AiMwjnCfwGlCV46/S+WsyIo5lzOL
         f7nl2df+WJcKfqEmM1zPtO1EOhMZh5CZADpRQZv6sJHGMWttmWJzG8fs9f/d3jalY+/Z
         jLAHpFvuqCl9eFTseV2LkaW8JNngz31KPVKEaLQddnIoSitzexNBTpcE3vZfaazLr46l
         0xn42j7brG9ZMgHm0izOcRN84CDjdtlpIGGih2HHzzuL6O2b4ksW+f2QVRn/dQ/n1suy
         yowg==
X-Forwarded-Encrypted: i=1; AJvYcCU/W8xJWH+guE4OlA/JsY4QTlDOFVmwE6xmWjYD8ZrwD7B+yCd2APFhiGOPcdGeZTDa794=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUHMdYekp2BNbNIYSx5xRUaRS5vmGTa0Amll+GUdvE1QJnA1S/
	EPJcUXiSBH0i4HGG4/2TNbWeM4f5lOEnNQjFLV/8nAEjGm8BSj8Q+ttA
X-Gm-Gg: ASbGncsLrL0KmOD9KRIm0AXz4N5AF03PDp4v/ybtF/ffp+Ao5amDP0RGr+4vXSfCXtn
	TL1zEI9Lg3/XxgqPBDQOSa/m0WlN9pVIgiLWBN2wQlxMdUmXNQ+z6ZMNJMkJJ59GpeDMv3swyec
	ptvft18BKFV3lmVx/wl03pNuGhT7Pzr4jY7+MD+XE4uX0lboEBWhJLAZ1AubyuJdlVRcnzqynFF
	xUH5SqEWVsQJ4c5zVu/rcEmU06WtMUHk7zhPyaldqmbGeVEqoWm5RYSQ9oeg007eMb1idl939MJ
	XUmG37iUUH3cdLfAbtjhgS0eHzyVqTNVNx1bnOc9c92b3JzQLXOjPtNlPhnR9iBOkpRYH8G7ik8
	tX77wtIhhonv7MTN08oK910vm57xbV3LCnojBf7KDHeULTtI3Sw==
X-Google-Smtp-Source: AGHT+IG1Iz02Do8vk/OkUauhbzeE1XTOlKai6jAIc/dx9gUu7tjggesIQloqaLtajEfFQGe39i3EMQ==
X-Received: by 2002:a05:6000:400d:b0:3f7:b7ac:f3d2 with SMTP id ffacd0b85a97d-429bd6be4e8mr13062531f8f.43.1762248443219;
        Tue, 04 Nov 2025 01:27:23 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18f41bsm3393650f8f.9.2025.11.04.01.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 01:27:22 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 4 Nov 2025 10:27:20 +0100
To: bot+bpf-ci@kernel.org
Cc: mhiramat@kernel.org, rostedt@goodmis.org, jpoimboe@kernel.org,
	peterz@infradead.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, yhs@fb.com,
	songliubraving@fb.com, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 2/4] x86/fgraph,bpf: Fix stack ORC unwind from
 kprobe_multi return probe
Message-ID: <aQnG-D8O8Jco9_4X@krava>
References: <20251103220924.36371-3-jolsa@kernel.org>
 <bb44afd60873d171a8482032e466d2827018486ecd13b4047df74632d2df4950@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb44afd60873d171a8482032e466d2827018486ecd13b4047df74632d2df4950@mail.kernel.org>

On Mon, Nov 03, 2025 at 11:47:37PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> > index 93156ac4f..b08c95872 100644
> > --- a/arch/x86/include/asm/ftrace.h
> > +++ b/arch/x86/include/asm/ftrace.h
> > @@ -56,6 +56,11 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
> >  	return &arch_ftrace_regs(fregs)->regs;
> >  }
> >
> > +#define arch_ftrace_partial_regs(regs) do {	\
> > +	regs->flags &= ~X86_EFLAGS_FIXED;	\
> > +	regs->cs = __KERNEL_CS;			\
> > +} while (0)
> > +
> 
> Can arch_ftrace_partial_regs read uninitialized regs->flags?
> 
> In return_to_handler, the ftrace_regs structure is allocated on the
> stack but only a few fields are initialized (RAX, RDX, RBP, RSP).
> The EFLAGS/flags field is never written before
> arch_ftrace_partial_regs reads it:
> 
> arch/x86/kernel/ftrace_64.S return_to_handler:
>     subq $(FRAME_SIZE), %rsp    # Allocate ftrace_regs on stack
>     movq %rax, RAX(%rsp)
>     movq %rdx, RDX(%rsp)
>     movq %rbp, RBP(%rsp)
>     movq %rsp, RSP(%rsp)
>     # No initialization of EFLAGS field
> 
> Then ftrace_partial_regs()->arch_ftrace_partial_regs() executes:
>     regs->flags &= ~X86_EFLAGS_FIXED;
> 
> This reads the uninitialized flags field. Stack allocations contain
> garbage, so regs->flags will have whatever data was previously on
> the stack. The &= operation produces undefined results when operating
> on uninitialized memory.
> 
> For comparison, ftrace_regs_caller explicitly initializes EFLAGS:
>     movq MCOUNT_REG_SIZE(%rsp), %rcx
>     movq %rcx, EFLAGS(%rsp)
> 
> Should return_to_handler initialize regs->flags to 0 (or another
> appropriate value) before arch_ftrace_partial_regs modifies it?

yes, that was in the initial version [1] but Stephen did not like that,
so I moved the flags init to later where it needs to take into account
other callers (that have meaningful flags) and just zeros the X86_EFLAGS_FIXED,
so we go through !perf_hw_regs leg in perf_callchain_kernel

jirka


[1] https://lore.kernel.org/bpf/aObSyt3qOnS_BMcy@krava/

