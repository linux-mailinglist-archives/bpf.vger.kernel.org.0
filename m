Return-Path: <bpf+bounces-52926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5A6A4A63F
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 875947A46D6
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 22:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FA61DED5E;
	Fri, 28 Feb 2025 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW0piCGD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF07123F372;
	Fri, 28 Feb 2025 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783330; cv=none; b=Zp9daG/1zqJaOpP38CodaF9YvDVSZczAH5mlWcDknTHGWuWEdd4iicB5OHlcNGeHEw5+PxmVUuUu8AvEsbQujIWQNT5pSzB+XjBxpaHTuuHF24s10z9j2rHSqA68MR7JmQ2k0YJZvUKPVnyulUwJN4+HWnsJzherZYZ1TTflV/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783330; c=relaxed/simple;
	bh=N8g8272bWuEa7yqt92SE1Z0Y2MiDeHz46bITah8vC9c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loKpvWMx6h7KmKblZcZ4SbRCvR0igQ7aDuQOhtj/7d6f4g12U3kndBMCusrJHMIyjTfI1mev+v4qkkicJb4LtvDoZ9gGxzUwBtyGxyhnU2ux+PPGugxqpQ57xJMY4NtO2siXtlBLHvmw0vHQ7D7vwxqEIU1PBKVl3wiR9Q4geuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IW0piCGD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so1638579f8f.0;
        Fri, 28 Feb 2025 14:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740783327; x=1741388127; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=45vqsVCs1qRXf6UNJ6iHFChVVOr1CMsx6P6pJ969JqI=;
        b=IW0piCGDgB0Bv/HD8zN+kaHqdXTh8sMYf+VDIuR05LVH7FyFAH8YshknGWc6NEgr7E
         WD013CHSG8yFzv6jqyQpWxlRsAZtFwb2s77a3T3clYPWj2g41rfgeIdCq4MQ3HwS2tpQ
         YOSk5p8D1Ny85UqPOFllz0nB8fGl1SCXdjF9dMDemysk1boC2DDKcf0UC/sFIeLfav3R
         vAt2opu0kgQIB/l2KQzNdCxtY5O4OW2Ggk+BL/xxQz31sDchZzxui7Osh2ROkK87T4dp
         7/LfWb3Rqm2DI/kBLV8HU6KRHD2hbPoUUYluaol2r+wAQruXo92bDKdeuAjlM15qpwPL
         pOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740783327; x=1741388127;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45vqsVCs1qRXf6UNJ6iHFChVVOr1CMsx6P6pJ969JqI=;
        b=wag4mgjspkX/7MR6J5pUVHz8GcrBtDVlD1C2Kzgb0xV685jucvCiTOS+83wWeQ49MV
         GIUXRB2eFg+4QfFn3Q/bNkA2hbcysg0dmcOY4m1piB+FY39wksNnFZRQjgTz5sIZY1/L
         BKYh2C6N1fdyK5uYJffGBz8qTWEBbcy7WKuIyyKEITBGKWPIvZHx0sP4Xru3pI5St7g6
         I9puxKwqsaRaRHrUOnplqNVNegpj/DRgVwn0Tqc11Gv45qj1QF1WAgeIgOYLwwj4scOg
         GdyrrmofD5qInPwkPSJ2szeg5cPMJCgJnYqZBBkai5y4p1tcxr2edJcuP3WLa4E9GOk7
         R1cA==
X-Forwarded-Encrypted: i=1; AJvYcCUaX0EYKELqzBpvCfBttN9Rp/umDujZiIANgzi+DGjObv0j2r0jo7j5sQhBDUQi6ZPvPSo=@vger.kernel.org, AJvYcCXA15B1bqtZ9OUQTWEo7oIzah0lz7JAu6XAd86KrnUNUGwVZxHzLUohKCeRDm+phF5l1sN3edCVm5R13oIFOOEZzA6U@vger.kernel.org, AJvYcCXIlBHYWIgCKqvcxS4jVt3tL/U3QXrzh0dT2NXWBlEQL8gRJ0tNarshw1idgaQrw2hH9m+jX/Z2eiGx3JY7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4A4x2T/Gg5+o0zCLGQnkkbs4+RUIfK9s7yDsUtH8BNs4q+cHk
	olRxSRs5W3Zl0rugxBqqA6JH0B3iFAeBxS9DDAbLYFU/Ua8aA/Wb
X-Gm-Gg: ASbGncsGdzU8tYtXG2+dztyreJ3KcExTuW7KfCyhL8mYPsAFduBx88PHYc2RrGFklCB
	IPmOZgiaUOadzxcgfkTv91JauudGvgzJ3Npiswmm9E9ARKEfWuL2SiNGUOFXoehj7WjWjKLnNa2
	tmjJwH/pl1TgmAo7v1IJrlBR8tz+1hdeGCEgCyt3ZRkKrtkZrZRl/9oZmaE17bK0LQaQj76bLwt
	hkQ/95eq1O0XzMwqk/3BrnK9FA4q48bhDQp92invWPbp6big1ReHdBY0WT17S2n8FOyU3D14sOY
	Md4w9t3CNbvW3Oas+VMMg34gu080mcdnk4qZ+nYW5iJimMg4qC8=
X-Google-Smtp-Source: AGHT+IFGg7pzEbjhJs1wS6cbIwFccqK9bJ5GUIPR+C8H5R6dMQIX9v5RXm7QCZc8OMaGCMLhZj24HQ==
X-Received: by 2002:a05:6000:1883:b0:38d:c55e:ebcf with SMTP id ffacd0b85a97d-390eca3871fmr4398376f8f.52.1740783326541;
        Fri, 28 Feb 2025 14:55:26 -0800 (PST)
Received: from krava (85-193-35-41.rib.o2.cz. [85.193.35.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6a87sm6573972f8f.32.2025.02.28.14.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 14:55:25 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 28 Feb 2025 23:55:23 +0100
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
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH RFCv2 12/18] uprobes/x86: Add support to optimize uprobes
Message-ID: <Z8I-24x1FHoBOQ6N@krava>
References: <20250224140151.667679-1-jolsa@kernel.org>
 <20250224140151.667679-13-jolsa@kernel.org>
 <CAEf4BzbE1dhqZWpLYhZFo7cuuK04t9iM+1ykHA5_PbM_xdb1PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbE1dhqZWpLYhZFo7cuuK04t9iM+1ykHA5_PbM_xdb1PQ@mail.gmail.com>

On Fri, Feb 28, 2025 at 10:55:24AM -0800, Andrii Nakryiko wrote:
> On Mon, Feb 24, 2025 at 6:04 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Putting together all the previously added pieces to support optimized
> > uprobes on top of 5-byte nop instruction.
> >
> > The current uprobe execution goes through following:
> >   - installs breakpoint instruction over original instruction
> >   - exception handler hit and calls related uprobe consumers
> >   - and either simulates original instruction or does out of line single step
> >     execution of it
> >   - returns to user space
> >
> > The optimized uprobe path
> >
> >   - checks the original instruction is 5-byte nop (plus other checks)
> >   - adds (or uses existing) user space trampoline and overwrites original
> >     instruction (5-byte nop) with call to user space trampoline
> >   - the user space trampoline executes uprobe syscall that calls related uprobe
> >     consumers
> >   - trampoline returns back to next instruction
> >
> > This approach won't speed up all uprobes as it's limited to using nop5 as
> > original instruction, but we could use nop5 as USDT probe instruction (which
> > uses single byte nop ATM) and speed up the USDT probes.
> >
> > This patch overloads related arch functions in uprobe_write_opcode and
> > set_orig_insn so they can install call instruction if needed.
> >
> > The arch_uprobe_optimize triggers the uprobe optimization and is called after
> > first uprobe hit. I originally had it called on uprobe installation but then
> > it clashed with elf loader, because the user space trampoline was added in a
> > place where loader might need to put elf segments, so I decided to do it after
> > first uprobe hit when loading is done.
> >
> > We do not unmap and release uprobe trampoline when it's no longer needed,
> > because there's no easy way to make sure none of the threads is still
> > inside the trampoline. But we do not waste memory, because there's just
> > single page for all the uprobe trampoline mappings.
> >
> > We do waste frmae on page mapping for every 4GB by keeping the uprobe
> > trampoline page mapped, but that seems ok.
> >
> > Attaching the speed up from benchs/run_bench_uprobes.sh script:
> >
> > current:
> >         usermode-count :  818.836 ± 2.842M/s
> >         syscall-count  :    8.917 ± 0.003M/s
> >         uprobe-nop     :    3.056 ± 0.013M/s
> >         uprobe-push    :    2.903 ± 0.002M/s
> >         uprobe-ret     :    1.533 ± 0.001M/s
> > -->     uprobe-nop5    :    1.492 ± 0.000M/s
> >         uretprobe-nop  :    1.783 ± 0.000M/s
> >         uretprobe-push :    1.672 ± 0.001M/s
> >         uretprobe-ret  :    1.067 ± 0.002M/s
> > -->     uretprobe-nop5 :    1.052 ± 0.000M/s
> >
> > after the change:
> >
> >         usermode-count :  818.386 ± 1.886M/s
> >         syscall-count  :    8.923 ± 0.003M/s
> >         uprobe-nop     :    3.086 ± 0.005M/s
> >         uprobe-push    :    2.751 ± 0.001M/s
> >         uprobe-ret     :    1.481 ± 0.000M/s
> > -->     uprobe-nop5    :    4.016 ± 0.002M/s
> >         uretprobe-nop  :    1.712 ± 0.008M/s
> >         uretprobe-push :    1.616 ± 0.001M/s
> >         uretprobe-ret  :    1.052 ± 0.000M/s
> > -->     uretprobe-nop5 :    2.015 ± 0.000M/s
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/include/asm/uprobes.h |   6 ++
> >  arch/x86/kernel/uprobes.c      | 191 ++++++++++++++++++++++++++++++++-
> >  include/linux/uprobes.h        |   6 +-
> >  kernel/events/uprobes.c        |  16 ++-
> >  4 files changed, 209 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
> > index 678fb546f0a7..7d4df920bb59 100644
> > --- a/arch/x86/include/asm/uprobes.h
> > +++ b/arch/x86/include/asm/uprobes.h
> > @@ -20,6 +20,10 @@ typedef u8 uprobe_opcode_t;
> >  #define UPROBE_SWBP_INSN               0xcc
> >  #define UPROBE_SWBP_INSN_SIZE             1
> >
> > +enum {
> > +       ARCH_UPROBE_FLAG_CAN_OPTIMIZE   = 0,
> > +};
> > +
> >  struct uprobe_xol_ops;
> >
> >  struct arch_uprobe {
> > @@ -45,6 +49,8 @@ struct arch_uprobe {
> >                         u8      ilen;
> >                 }                       push;
> >         };
> > +
> > +       unsigned long flags;
> >  };
> >
> >  struct arch_uprobe_task {
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index e8aebbda83bc..73ddff823904 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -18,6 +18,7 @@
> >  #include <asm/processor.h>
> >  #include <asm/insn.h>
> >  #include <asm/mmu_context.h>
> > +#include <asm/nops.h>
> >
> >  /* Post-execution fixups. */
> >
> > @@ -768,7 +769,7 @@ static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
> >         return NULL;
> >  }
> >
> > -static __maybe_unused struct uprobe_trampoline *uprobe_trampoline_get(unsigned long vaddr)
> > +static struct uprobe_trampoline *uprobe_trampoline_get(unsigned long vaddr)
> >  {
> >         struct uprobes_state *state = &current->mm->uprobes_state;
> >         struct uprobe_trampoline *tramp = NULL;
> > @@ -794,7 +795,7 @@ static void destroy_uprobe_trampoline(struct uprobe_trampoline *tramp)
> >         kfree(tramp);
> >  }
> >
> > -static __maybe_unused void uprobe_trampoline_put(struct uprobe_trampoline *tramp)
> > +static void uprobe_trampoline_put(struct uprobe_trampoline *tramp)
> >  {
> >         if (tramp == NULL)
> >                 return;
> > @@ -807,6 +808,7 @@ struct mm_uprobe {
> >         struct rb_node rb_node;
> >         unsigned long auprobe;
> >         unsigned long vaddr;
> > +       bool optimized;
> >  };
> >
> 
> I'm trying to understand if this RB-tree based mm_uprobe is strictly
> necessary. Is it? Sure we keep optimized flag, but that's more for
> defensive checks, no? Is there any other reason we need this separate
> look up data structure?

so the call instruction update is done in 2 locked steps:
 - first we write breakpoint as part of normal uprobe registration
 - then uprobe is hit, we overwrite breakpoint with call instruction

in between we could race with another thread that could either unregister the
uprobe or try to optimize the uprobe as well

I think we either need to keep the state of the uprobe per process (mm_struct),
or we would need to read the probed instruction each time when we need to make
decision based on what state are we at (nop5,breakpoint,call)

jirka

