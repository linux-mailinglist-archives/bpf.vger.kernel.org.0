Return-Path: <bpf+bounces-39867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419CD978A85
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 23:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6665E1C2135E
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 21:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFFF154435;
	Fri, 13 Sep 2024 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSAYFy9E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB15BA50
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 21:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726262632; cv=none; b=tloIexbVy75haIJosr9XbHEmFVz095sDDgfnPoGln08oiJ8RfuUMmgePMsPhLS918EUMoJz9X280K4Q8EcJdsnL6YEXUS/2mQvUd3KggrrRdjTvZHVen2kF8uPMf0cX1wHn17xZ1927ss7sXoAaWdxLYQ+sUyVm6bzMxPqRnQdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726262632; c=relaxed/simple;
	bh=dDUYPHEHXMsRYbiIFPCOgUy7V8RCFDhl7CuuCq1mHAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhUmudVxk1xI9vub51SHM+wGrD2s0i5huFkZUqu4AeLgY1GQ3CIVOfo1rsHilw2Z3RejHL4QCdAciG+weGY8WmkxOmywqJubj8UP9Kqea5ZLcBmfKmAxnRs4Bk1pLhxAWBbp1dQ7qHzn6+4oD7/P+zfdD5ys8n0TkSqyzdBxEN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSAYFy9E; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7d4fbe62bf5so873223a12.0
        for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 14:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726262630; x=1726867430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aT5adoUswyp6Oe7Nyk+LrQiCC6lu4vqnYI9zQ2NqOxk=;
        b=NSAYFy9Ec3vh+f6sHObu9qn7+9MSviGstdDQG8qy49WWLm6VtwgAxjuh8sQHW+CZfX
         Kz2/OnRqnEP1m2r3D3wWgWd/gnNQLyyp6GB9iK5NTxBM+mMy2sAD6uU+jH+7qViPFab3
         FSwqOn90MkT6Flxyk4KfWLND+XaZiglDolaWq3/4R9cbqz1vcFmd+5Y4zhGdJ2Fukg46
         vb1rWk7IYSua941Z5t0GaKExslNFfGEiiYUtwb4eAN1HNmW4Vu42n4rafN0EIfz/k4Qk
         ZnzF7ge5o0f1GVxtsnsiFB5PNiegHAlLaCbUmJyEXBICOHVAUrdm6DHYvlDIm/eYbBKd
         TuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726262630; x=1726867430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aT5adoUswyp6Oe7Nyk+LrQiCC6lu4vqnYI9zQ2NqOxk=;
        b=kUrnnJ03U3t3ZyRC8XsKOKKj8ZSxsk887KGbBmpjagEhP9UmznKpWTDBbjGzUw0rpE
         fuoPQ9l/IvGWeZDaZmPgTPIDlRKMi73LhVCr/E2Nq1iG+p7Vcigj2ZECnWx1mBZloFp/
         uPiypCh0DXlddU1R/TeU7WDe6S9DPv0MPVkAzb+KcNFA6zbNQIW06/l5n2+PT3LaiCun
         yUHYb9Pl9TFElRN+rei+Ayx9nNiMdoZBcfAz93aEZqG22J7RyrG55b+tA+/YHcjvQKjr
         OgjB9FsSXFl6zouG5d0y0x6y0YQ0WVqmgp4mdLhMie0j0c+fgGUCzhZzEwmr6Z4LaIw0
         2dXA==
X-Forwarded-Encrypted: i=1; AJvYcCVDmHPELfrepYytqraeHK4ku2bBarRcawTlEs4F5TcV6FABQAfi+w/M71rcLqR2t1ORiK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgdj7ddW9mUtx+UJTqh4d//sPOIubw258ss/EP2afnmT3j6Mnv
	7pvif7h0oGZOplvFHUYtzxi5NV9uqfeHHpDtCnMNI+34Yn4lqi8YRR09QlBweBmA+m9TwQcIJHl
	/GRNmYqyvUacanc1wAsznOF4ytSw=
X-Google-Smtp-Source: AGHT+IGSxsUDqs68DJ6NkTjNEpB1AkCqjW8Wl4QWO76JPF+xmI4Z7WHX1hn4VzZNwjI3ylmXq0TpXv6HiXTsUEqPgRE=
X-Received: by 2002:a17:90b:3790:b0:2d8:9253:dffc with SMTP id
 98e67ed59e1d1-2dbb9e1d335mr5273948a91.19.1726262630109; Fri, 13 Sep 2024
 14:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
 <0170cd7d95df0583770c385c1e11bd27dfacf618b71b6e723f0952efc0ce9040@mail.kernel.org>
 <CAEf4BzZgAkSkMd6Vk3m1D-0AVqXp06PaBPr+2L7Dd3WRgJ8JvA@mail.gmail.com>
 <20240913085402.9e5b2c506a8973b099679d04@kernel.org> <CAEf4BzZEoNHgcLDPTPQ=yyQTZtEZoVrGbBbeTf3vqe_wcpS6EA@mail.gmail.com>
 <20240913175935.bb0892ab1e6052efc12c6423@kernel.org> <20240913214515.894c868a1ef4968550553b86@kernel.org>
 <20240913224957.5bfa380429020f3cbe9eeb63@kernel.org>
In-Reply-To: <20240913224957.5bfa380429020f3cbe9eeb63@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Sep 2024 14:23:38 -0700
Message-ID: <CAEf4BzaCixhyFHH1Ut56sCLh2n-twtP6_0YPUcvv9dP+GXF-DA@mail.gmail.com>
Subject: Re: [PATCH v14 00/19] tracing: fprobe: function_graph: Multi-function
 graph and fprobe on fgraph
To: Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc: kernel-ci@meta.com, bot+bpf-ci@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 6:50=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Fri, 13 Sep 2024 21:45:15 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > On Fri, 13 Sep 2024 17:59:35 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> >
> > > >
> > > > Taking failing output from the test:
> > > >
> > > > > > > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpe=
cted kretprobe_test3_result: actual 0 !=3D expected 1
> > > >
> > > > kretprobe_test3_result is a sort of identifier for a test condition=
,
> > > > you can find a corresponding line in user space .c file grepping fo=
r
> > > > that:
> > > >
> > > > ASSERT_EQ(skel->bss->kretprobe_testmod_test3_result, 1,
> > > > "kretprobe_test3_result");
> > > >
> > > > Most probably the problem is in:
> > > >
> > > > __u64 addr =3D bpf_get_func_ip(ctx);
> > >
> > > Yeah, and as I replyed to another thread, the problem is
> > > that the ftrace entry_ip is not symbol ip.
> > >
> > > We have ftrace_call_adjust() arch function for reverse
> > > direction (symbol ip to ftrace entry ip) but what we need
> > > here is the reverse translate function (ftrace entry to symbol)
> > >
> > > The easiest way is to use kallsyms to find it, but this is
> > > a bit costful (but it just increase bsearch in several levels).
> > > Other possible options are
> > >
> > >  - Change bpf_kprobe_multi_addrs_cmp() to accept a range
> > >    of address. [sym_addr, sym_addr + offset) returns true,
> > >    bpf_kprobe_multi_cookie() can find the entry address.
> > >    The offset depends on arch, but 16 is enough.
> >
> > Oops. no, this bpf_kprobe_multi_cookie() is used only for storing
> > test data. Not a general problem solving. (I saw kprobe_multi_check())
> >
> > So solving problem is much costly, we need to put more arch-
> > dependent in bpf_trace, and make sure it does reverse translation
> > of ftrace_call_adjust(). (this means if you expand arch support,
> > you need to add such implementation)
>
> OK, can you try this one?
>

I'm running out of time today, so I won't have time to try this, sorry.

But see my last reply, I think adjusting link->addrs once before
attachment is the way to go. It gives us fast and simple lookups at
runtime.

In my last reply I assumed that we won't need to keep a copy of
original addrs (because we can dynamically adjust for
bpf_kprobe_multi_link_fill_link_info()), but I now realize that we do
need that for bpf_get_func_ip() anyways.

Still, I'd rather have an extra link->adj_addrs with a copy and do a
quick and simple lookup at runtime. So I suggest going with that. At
the very worst case it's a few kilobytes of memory for thousands of
attached functions, no big deal, IMO.

It's vastly better than maintaining arch-specific reverse of
ftrace_call_adjust(), isn't it?

Jiri, any opinion here?

>
> From 81bc599911507215aa9faa1077a601880cbd654a Mon Sep 17 00:00:00 2001
> From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> Date: Fri, 13 Sep 2024 21:43:46 +0900
> Subject: [PATCH] bpf: Add get_entry_ip() for arm64
>
> Add get_entry_ip() implementation for arm64. This is based on
> the information in ftrace_call_adjust() for arm64.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 64 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index deb629f4a510..b0cf6e5b8965 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1066,6 +1066,70 @@ static unsigned long get_entry_ip(unsigned long fe=
ntry_ip)
>                 fentry_ip -=3D ENDBR_INSN_SIZE;
>         return fentry_ip;
>  }
> +#elif defined (CONFIG_ARM64)
> +#include <asm/insn.h>
> +
> +static unsigned long get_entry_ip(unsigned long fentry_ip)
> +{
> +       u32 insn;
> +
> +       /*
> +        * When using patchable-function-entry without pre-function NOPS,=
 ftrace
> +        * entry is the address of the first NOP after the function entry=
 point.
> +        *
> +        * The compiler has either generated:
> +        *
> +        * func+00:     func:   NOP             // To be patched to MOV X=
9, LR
> +        * func+04:             NOP             // To be patched to BL <c=
aller>
> +        *
> +        * Or:
> +        *
> +        * func-04:             BTI     C
> +        * func+00:     func:   NOP             // To be patched to MOV X=
9, LR
> +        * func+04:             NOP             // To be patched to BL <c=
aller>
> +        *
> +        * The fentry_ip is the address of `BL <caller>` which is at `fun=
c + 4`
> +        * bytes in either case.
> +        */
> +       if (!IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
> +               return fentry_ip - AARCH64_INSN_SIZE;
> +
> +       /*
> +        * When using patchable-function-entry with pre-function NOPs, BT=
I is
> +        * a bit different.
> +        *
> +        * func+00:     func:   NOP             // To be patched to MOV X=
9, LR
> +        * func+04:             NOP             // To be patched to BL <c=
aller>
> +        *
> +        * Or:
> +        *
> +        * func+00:     func:   BTI     C
> +        * func+04:             NOP             // To be patched to MOV X=
9, LR
> +        * func+08:             NOP             // To be patched to BL <c=
aller>
> +        *
> +        * The fentry_ip is the address of `BL <caller>` which is at eith=
er
> +        * `func + 4` or `func + 8` depends on whether there is a BTI.
> +        */
> +
> +       /* If there is no BTI, the func address should be one instruction=
 before. */
> +       if (!IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
> +               return fentry_ip - AARCH64_INSN_SIZE;
> +
> +       /* We want to be extra safe in case entry ip is on the page edge,
> +        * but otherwise we need to avoid get_kernel_nofault()'s overhead=
.
> +        */
> +       if ((fentry_ip & ~PAGE_MASK) < AARCH64_INSN_SIZE * 2) {
> +               if (get_kernel_nofault(insn, (u32 *)(fentry_ip - AARCH64_=
INSN_SIZE * 2)))
> +                       return fentry_ip - AARCH64_INSN_SIZE;
> +       } else {
> +               insn =3D *(u32 *)(fentry_ip - AARCH64_INSN_SIZE * 2);
> +       }
> +
> +       if (aarch64_insn_is_bti(le32_to_cpu((__le32)insn)))
> +               return fentry_ip - AARCH64_INSN_SIZE * 2;
> +
> +       return fentry_ip - AARCH64_INSN_SIZE;
> +}
>  #else
>  #define get_entry_ip(fentry_ip) fentry_ip
>  #endif
> --
> 2.34.1
>
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

