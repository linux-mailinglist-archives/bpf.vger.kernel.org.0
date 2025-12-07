Return-Path: <bpf+bounces-76231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E81CABA67
	for <lists+bpf@lfdr.de>; Sun, 07 Dec 2025 23:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F7F73010286
	for <lists+bpf@lfdr.de>; Sun,  7 Dec 2025 22:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A092E54A1;
	Sun,  7 Dec 2025 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCE66x0+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E0625F995
	for <bpf@vger.kernel.org>; Sun,  7 Dec 2025 22:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765146225; cv=none; b=hXSO/WoJ+cP7KmNfPTwhm6alSXoGP0OtUwnRG7S82SIMChutR0xbfJoxrPTkvfMoKEulEctXIz4rxT3k5nHlwqVs9px7OSDNzniywvZbpOdWDe6flqxnzqyyuqOhTWkG4i2r+lcc/vqtsEFu9P60kqK3fDwDx9firZnrP3FkzyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765146225; c=relaxed/simple;
	bh=o/UYKSK/gkbLh8FWxRxvVU3OkU/Q+/03bFyedFJp1NA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCyva0+fzgchBOHMfOgDIVMNg1yph2J4QUH9H8qlsm2endFKpTggyQL7xq/qotp2CaiUxF2YUSj+uySLF8nktOqcNSLgpdr8s9iwdZcgSqSsEgt4uptfjS//tyREp9PIG2rGAB0WLoPOh8jn5BIu12fUPEplTM3q8bppeg8ZbBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCE66x0+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso32685435e9.3
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 14:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765146222; x=1765751022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+w862P9gwDeWHrowG1HizWcJbg4rpsvYLnk23PcrduI=;
        b=XCE66x0+QMeUsDpmtND2oSsLY+7Y6KU0mm++Nk+/hSjhd6bho1cLaHQULBnsNpx2kQ
         cU+Rd4nt5NavdpcTs7k2G5ihzk45DzkGFChYuPPTywwFrFWHdHWdINI+4fqM6Nac/5BV
         NOx3wVKqPdnTPrYFGGuwtRCSD4FvG9kpt/C4o9vyW2m+zfxvl1PSSfZC/xa/8o/sl+MJ
         zCPI4gl6PCJ2E0XV2ScZ+uFccl0+rn0aCfca976+4Upw0zSF0BZ2+c1UjJlF3VCLFJVA
         wDIIf+eCKD2HxW7jAQ5idegVJLB+6et1wIURJo552U0JMzX0LJn0frkHaxLRsw4JXZqN
         3BQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765146222; x=1765751022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+w862P9gwDeWHrowG1HizWcJbg4rpsvYLnk23PcrduI=;
        b=fjxf7uNZXwERgnfXmsRJIE3Hp18xL0RcheBEN4SwJttRpwYlesDuoVheXlhsuXCDzU
         W45LAZzXrj2TQmTUITHGYR50Sv3NNsA8QA937YM5WuHYul2w75WbnsQoP4qPqmx2879L
         TK+Lv6vwXiIQ8aANb6wdSLazDatNxXdcRmZZJhw6fCOeQAkdEhBe8tQTeuPfLFMwjDj+
         N+xNGLz8by30oeRRH4bSNAc318ahRj69/OvC+hJnWjQWI7Msb6JVyUuNYDizQboSLez+
         9MKr5PWNfeVyMpKLo13dPRNR2yVHqdLSw5H0osZzxF72Ql7Ai16fLt5l/cKCKF1R8F3b
         FAmA==
X-Gm-Message-State: AOJu0Ywe5UyW05rBXLdVsAKjUlAPnasVoM1lFKuwL9+cZo6r6hSaA3tC
	n3N6ot7Ai6fn6JmucCLCbWvO+9gadPpLvMws3HjBF6Pl/WUB730bLvm6
X-Gm-Gg: ASbGncvOmr8CvNj1jgCtBvT/CsubCAcCqogDt/vnE/R+9LfJ8i6rs5By7ATuxlwQwsj
	7k5DTAjnnJtCscVqBKqX/tpJ1+SnFnDI40Og27wZftfce4v3LgFrhCbiYAQAM7RX+Pp/ZgU7N67
	V+HBh7VpVTtz6E+dCXyd/nPy4J1lYLTW8eCZBr+owsxkHGJlpl2YwvvAiLyITLIs9JYeQo/6Dnu
	CtFaZvbWwHb+9eQ/jLFr55nvf/OWEOmfBoX7eQ/DtcurIO1cnVz/KY4oOZSVmeNi7q9tqXy3itz
	G/OrUYyMnwPtwKfXpmmrFTANngEPazWwxdMVFsMxmH/aUzv1LyF4s6F7HRsFhjzRhoVtLYjTCgW
	1iICBLzdXT8H0F0DalKgZV2eEAeNhhYLQPWbe8r5pWyCRo0iRtn4dA3hnEKUcalIWGqnquHN5v4
	w=
X-Google-Smtp-Source: AGHT+IEm2HK0eaJoyNa2SSzEora5+85e9+DGsx6tJi0vt33FJbGSHrWsG8eiRmYxrXpGu63DFLG+Fw==
X-Received: by 2002:a05:600c:820b:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-47939e043d3mr66573745e9.14.1765146222181;
        Sun, 07 Dec 2025 14:23:42 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d2226e7sm22659293f8f.27.2025.12.07.14.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 14:23:41 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 7 Dec 2025 23:23:40 +0100
To: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 0/8] uprobe/x86: Add support to optimize prologue
Message-ID: <aTX-bIYKXHOFXv21@krava>
References: <20251117124057.687384-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117124057.687384-1-jolsa@kernel.org>

On Mon, Nov 17, 2025 at 01:40:49PM +0100, Jiri Olsa wrote:
> hi,
> the subject is bit too optimistic, in nutshell the idea is to allow
> optimization on top of emulated instructions and then add support to
> emulate more instructions with high presence in function prologues.
> 
> This patchset adds support to optimize uprobe on top of instruction
> that could be emulated and also adds support to emulate particular
> versions of mov and sub instructions to cover some of the user space
> functions prologues, like:
> 
>   pushq %rbp
>   movq  %rsp,%rbp
>   subq  $0xb0,%rsp
> 
> The idea is to store instructions on underlying 5 bytes and emulate
> them during the int3 and uprobe syscall execution:
> 
>   - install 'call trampoline' through standard int3 update
>   - if int3 is hit before we finish optimizing we emulate
>     all underlying instructions
>   - when call is installed the uprobe syscall will emulate
>     all underlying instructions

David, sorry I used wrong email.. I think the update here might
be a problem, any chance you could check?

thanks,
jirka


> 
> There's an additional issue that single instruction replacement does
> not have and it's the possibility of the user space code to jump in the
> middle of those 5 bytes. I think it's unlikely to happen at the function
> prologue, but uprobe could be placed anywhere. I'm not sure how to
> mitigate this other than having some enable/disable switch or config
> option, which is unfortunate.
> 
> The patchset is based on bpf-next/master with [1] changes merged in.
> 
> thanks,
> jirka
> 
> 
> [1] https://lore.kernel.org/lkml/20251117093137.572132-1-jolsa@kernel.org/T/#m95a3208943ec24c5eee17ad6113002fdc6776cf8
> ---
> Jiri Olsa (8):
>       uprobe/x86: Introduce struct arch_uprobe_xol object
>       uprobe/x86: Use struct arch_uprobe_xol in emulate callback
>       uprobe/x86: Add support to emulate mov reg,reg instructions
>       uprobe/x86: Add support to emulate sub imm,reg instructions
>       uprobe/x86: Add support to optimize on top of emulated instructions
>       selftests/bpf: Add test for mov and sub emulation
>       selftests/bpf: Add test for uprobe prologue optimization
>       selftests/bpf: Add race test for uprobe proglog optimization
> 
>  arch/x86/include/asm/uprobes.h                          |  35 +++++++---
>  arch/x86/kernel/uprobes.c                               | 336 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
>  include/linux/uprobes.h                                 |   1 +
>  kernel/events/uprobes.c                                 |   6 ++
>  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 129 ++++++++++++++++++++++++++++++++-----
>  5 files changed, 434 insertions(+), 73 deletions(-)

