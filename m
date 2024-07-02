Return-Path: <bpf+bounces-33654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C71924512
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 19:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0552CB237F1
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 17:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF711C68AD;
	Tue,  2 Jul 2024 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOSqoEri"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707EB1C005C;
	Tue,  2 Jul 2024 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940659; cv=none; b=C25ZjwYj01gILL4F9chQYb9Wg5euG+LHa/3yFfs8ec5BrAzA45Oer2PLzO60scoHWlE6w4dLAyTQbzRSFEzaEiUofLo9deLEtl+rMVGcYQgABJTyV7OApdSLNUKdMuvRp5HaJzvvSovolbmgIsUxEkX4R7gN4yCt6dhzt6qs6TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940659; c=relaxed/simple;
	bh=4868Ep+IoY10npVHcVKyoLSgEn/iBhldDS/CKlKIWeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfeVGKLQshxovuIJX+d1MHf81ybsyrwFeeplF/MKvM6QlL8ZrT07KeWvwtFcQBqyoCQcP7Tv8thVqNNSW2U5/ub0JH58PCOc7T90NB2feUQ8c8Eybd8YZ4pNZ+fXxPobvv/1tHrtzEUz7JRai8TporTEW6DgGKUFkN1M2RfgCeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOSqoEri; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c1a4192d55so2695685a91.2;
        Tue, 02 Jul 2024 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719940658; x=1720545458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab7Ql4t/fDVRM0N/Hkib1qt1vDXIApr8krme2e4EA7M=;
        b=XOSqoErisk6s7XXkTiD4NVZHF7EgqsC7/JnYc/tOY2qZ6YJIAnWZxn2vVqiu67U1uJ
         ei7/dx3rgTlPzCyAE79COtff3YLBSNo1oatA6nOPnovSdIYCc+wK0dKBGMl7v2YFQ2lt
         a6IBUAsaCQ6nRV+uzdEGhtBiIbtCgD1ChXOmFwCxsKO33krZ7tvUd0/yses+d4gTm/+k
         uDA8YzoNc5j1xAz3B8VXRDqrkQazukpNHkKqPmkC4WkYEvzbhSvnzhE9QmHOUsH0SWOK
         TogibV8Ai1+D+CTM1eSBHUvaVDeD8goQf2JLu3qh8Wz6l8JMtl66XDOKLmxPWwhF4kt7
         +/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719940658; x=1720545458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab7Ql4t/fDVRM0N/Hkib1qt1vDXIApr8krme2e4EA7M=;
        b=iawMCHuQiwYSEyhRCkqccjHxoFa0wkOw24AtHzIWABiP1HUFpXIOeRuxspdSWb6WWb
         LT7MOHcgeEB5k0HF5fhEmPlTchffeWSB6lqMt3oFl0BM71LzC1KF6+TcK2q8fnQNVOxe
         ZtO7X8MoUf5gixvFiML4mTkwPKnV8/Oq833O+GIBTnxqkgfIm1jBmF+7TtQwA7o94W5L
         s1JuL6yQPxTOQG+pNhD+RYZyA+2weUm+tHskIdWyNDUxUDLzWyJR7zCwb9el0Xddqcni
         W2Io6GF3t5T0v1qYhGHPZMLz5DONv6kVISnLcij4TzfvQxF/iPDEMIUDW+MVQglz9u3v
         GJ9A==
X-Forwarded-Encrypted: i=1; AJvYcCUQq4INjdVK14Su4X/mw7W5kuEXf21Sdyhw7D4Z2kSt74LryiJn2VvSnhHQG2Cz/AfRQFb5QvHw3fpo0HjYIwKerIOxTO3t2vsRak1vJ2kQCY3ATK8+cBHFTNqFp8IFyMGIQhMzIplHheDb2b9xDUMCpZURtECQVfIdSkKd7OpwzZssN1L9yz+QCRFRzn3i89AiQyCC6FEsJfnBMipSPnocHGajCi6owg==
X-Gm-Message-State: AOJu0YxOouXGtHv0A5D/1qEe+qNVr+zY1qHArikpwz3NDsxE0HfgchhE
	4GS08BmdNRCfcjcp9VVKm1A83lDV0G0prAReFVPJgaRm3AoHFy3KR8Nb1hsarQXrYqCP37AQmfB
	tv5uXdLyDLXsAZKUA18h2Nb1RdVh17f0/
X-Google-Smtp-Source: AGHT+IFAHjRiuSEDaf8Hq1+3dk9LMpcf/uGUbkKYmarxsoMEFNojGFS2jiWIoJDgxN+hGNT47VCp7kxlwzAj9WVYrh0=
X-Received: by 2002:a17:90b:fd1:b0:2c3:11fa:41f with SMTP id
 98e67ed59e1d1-2c93d76fbbemr5239692a91.45.1719940657536; Tue, 02 Jul 2024
 10:17:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701231027.61930-1-andrii@kernel.org> <20240702095036.GE11386@noisy.programming.kicks-ass.net>
In-Reply-To: <20240702095036.GE11386@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 10:17:24 -0700
Message-ID: <CAEf4BzZxXDsB+_Oyu=gDP9_7c5vc4Z6QFfW5TnY3GTA86X6hSQ@mail.gmail.com>
Subject: Re: [PATCH] perf,x86: avoid missing caller address in stack traces
 captured in uprobe
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, x86@kernel.org, mingo@redhat.com, 
	tglx@linutronix.de, bpf@vger.kernel.org, rihams@fb.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 2:50=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
>
> +Josj +LKML
>

ack, will add for next revision


> On Mon, Jul 01, 2024 at 04:10:27PM -0700, Andrii Nakryiko wrote:
> > When tracing user functions with uprobe functionality, it's common to
> > install the probe (e.g., a BPF program) at the first instruction of the
> > function. This is often going to be `push %rbp` instruction in function
> > preamble, which means that within that function frame pointer hasn't
> > been established yet. This leads to consistently missing an actual
> > caller of the traced function, because perf_callchain_user() only
> > records current IP (capturing traced function) and then following frame
> > pointer chain (which would be caller's frame, containing the address of
> > caller's caller).
> >
> > So when we have target_1 -> target_2 -> target_3 call chain and we are
> > tracing an entry to target_3, captured stack trace will report
> > target_1 -> target_3 call chain, which is wrong and confusing.
> >
> > This patch proposes a x86-64-specific heuristic to detect `push %rbp`
> > instruction being traced. Given entire kernel implementation of user
> > space stack trace capturing works under assumption that user space code
> > was compiled with frame pointer register (%rbp) preservation, it seems
> > pretty reasonable to use this instruction as a strong indicator that
> > this is the entry to the function. In that case, return address is stil=
l
> > pointed to by %rsp, so we fetch it and add to stack trace before
> > proceeding to unwind the rest using frame pointer-based logic.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  arch/x86/events/core.c  | 20 ++++++++++++++++++++
> >  include/linux/uprobes.h |  2 ++
> >  kernel/events/uprobes.c |  2 ++
> >  3 files changed, 24 insertions(+)
> >
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 5b0dd07b1ef1..82d5570b58ff 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -2884,6 +2884,26 @@ perf_callchain_user(struct perf_callchain_entry_=
ctx *entry, struct pt_regs *regs
> >               return;
> >
> >       pagefault_disable();
> > +
> > +#ifdef CONFIG_UPROBES
> > +     /*
> > +      * If we are called from uprobe handler, and we are indeed at the=
 very
> > +      * entry to user function (which is normally a `push %rbp` instru=
ction,
> > +      * under assumption of application being compiled with frame poin=
ters),
> > +      * we should read return address from *regs->sp before proceeding
> > +      * to follow frame pointers, otherwise we'll skip immediate calle=
r
> > +      * as %rbp is not yet setup.
> > +      */
> > +     if (current->utask) {
> > +             struct arch_uprobe *auprobe =3D current->utask->auprobe;
> > +             u64 ret_addr;
> > +
> > +             if (auprobe && auprobe->insn[0] =3D=3D 0x55 /* push %rbp =
*/ &&
> > +                 !__get_user(ret_addr, (const u64 __user *)regs->sp))
>
> This u64 is wrong, perf_callchain_user() is always native size.
>
> Additionally, I suppose you should also add a hunk to
> perf_callchain_user32(), which is the compat case.
>

Ah, I misunderstood the purpose of perf_callchain_user32(), and so
assumed u64 is correct here. I get it now, perf_callchain_user32() is
compat 32-in-64 case, but the general case can be either 32 or 64 bit.
Will fix it, thanks!

> > +                     perf_callchain_store(entry, ret_addr);
> > +     }
> > +#endif
> > +
> >       while (entry->nr < entry->max_stack) {
> >               if (!valid_user_frame(fp, sizeof(frame)))
> >                       break;
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index b503fafb7fb3..a270a5892ab4 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -76,6 +76,8 @@ struct uprobe_task {
> >       struct uprobe                   *active_uprobe;
> >       unsigned long                   xol_vaddr;
> >
> > +     struct arch_uprobe              *auprobe;
> > +
> >       struct return_instance          *return_instances;
> >       unsigned int                    depth;
> >  };
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 99be2adedbc0..6e22e4d80f1e 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -2082,6 +2082,7 @@ static void handler_chain(struct uprobe *uprobe, =
struct pt_regs *regs)
> >       bool need_prep =3D false; /* prepare return uprobe, when needed *=
/
> >
> >       down_read(&uprobe->register_rwsem);
> > +     current->utask->auprobe =3D &uprobe->arch;
> >       for (uc =3D uprobe->consumers; uc; uc =3D uc->next) {
> >               int rc =3D 0;
> >
> > @@ -2096,6 +2097,7 @@ static void handler_chain(struct uprobe *uprobe, =
struct pt_regs *regs)
> >
> >               remove &=3D rc;
> >       }
> > +     current->utask->auprobe =3D NULL;
> >
> >       if (need_prep && !remove)
> >               prepare_uretprobe(uprobe, regs); /* put bp at return */
> > --
> > 2.43.0
> >

