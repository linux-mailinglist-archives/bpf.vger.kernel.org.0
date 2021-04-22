Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B3E368099
	for <lists+bpf@lfdr.de>; Thu, 22 Apr 2021 14:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbhDVMhp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Apr 2021 08:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbhDVMhn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Apr 2021 08:37:43 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D7FC06138D
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 05:37:07 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id c15so37710586ilj.1
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 05:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A665ErDKUdmsQDlfh0SCMscZakL4a8DB0rDSnVVLJ5g=;
        b=cbO5PaTxCYtLcvQnj3TKsFgXHTI0X/UzwDrcZiH6jvdvJiF4FedjajAB44bF46M8pJ
         6eE+oYtoHZkmwd5EhBEY/eJpHH6TIlz1FsIp4motwyZf24wj4xp3SJzhrypsr5IVtVaa
         XvkYCzm3IR/LOXTj1UTalPBhojQDkssRcW7ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A665ErDKUdmsQDlfh0SCMscZakL4a8DB0rDSnVVLJ5g=;
        b=UGBX8rydSKnZUiWMv8NUTFiEh9Wg8h52HdtCwPX7j69bzob40FFEZVvnN2xIqFoM7B
         9UH+eETLcyC3333y0kbi1kp30ep4xP10E//WDSJO7hxGyGxvhgTsk2BEI1UPamNvyXPM
         o2FCViKfzu5RewHq5F79Dt7iMQPdvq/aZV/pzyyVF3m2IBI/OhRpRrepFTKs7Rq5XM0T
         VGscGek7F2O6TLvF7RHubAdquuxiQmFMHUCpo16/tmtIEEot1+ihIhANMwr1/cKR0fOt
         xNt5+ojSW4K5G31j2/12VbHtqIt94pejUA3Eq2QmZH6dNAccAojKtBTeYpRyVySWzW8S
         QBRg==
X-Gm-Message-State: AOAM530986UcpOp/9xs74DpJ5dqle6YeNC89IuQf4BGNwfxR0ZT7cjA8
        ULCOe977YmKCKi0aKE/55XPCkgnyRcWioXPiMXPZyA==
X-Google-Smtp-Source: ABdhPJyiG/f5qhwUvdtkH0ZkVZ7NdNUmooZC7RMWMCIvCpKoFeMRhcZRV8C37SD3oGPQWOgsiKQoEqMcu1DNtJJ1Mc8=
X-Received: by 2002:a05:6e02:219d:: with SMTP id j29mr2669565ila.204.1619095027316;
 Thu, 22 Apr 2021 05:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210421190736.1538217-1-linux@rasmusvillemoes.dk>
 <CAEf4Bza6-Unvr7QmcbvVtNDPc4BNzf8zMaU4XardNqB_GnGDHw@mail.gmail.com>
 <236995f6-30ee-8047-624c-08d0a1552dc1@rasmusvillemoes.dk> <CABRcYmJFfdCU_QxX+gYRWc+7BSbmTWX84o_WT=oBg_CPr8qS=g@mail.gmail.com>
 <7e9d3337-eb7b-a2c8-a5ef-037d6a9765d7@rasmusvillemoes.dk>
In-Reply-To: <7e9d3337-eb7b-a2c8-a5ef-037d6a9765d7@rasmusvillemoes.dk>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 22 Apr 2021 14:36:56 +0200
Message-ID: <CABRcYmLU0f9eSvsjBogKmc_FK8qykfR1pNx9VCW8Scjj4-VQQg@mail.gmail.com>
Subject: Re: [PATCH] bpf: remove pointless code from bpf_do_trace_printk()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 22, 2021 at 12:09 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 22/04/2021 11.23, Florent Revest wrote:
> > On Thu, Apr 22, 2021 at 9:13 AM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> >>
> >> On 22/04/2021 05.32, Andrii Nakryiko wrote:
> >>> On Wed, Apr 21, 2021 at 6:19 PM Rasmus Villemoes
> >>> <linux@rasmusvillemoes.dk> wrote:
> >>>>
> >>>> The comment is wrong. snprintf(buf, 16, "") and snprintf(buf, 16,
> >>>> "%s", "") etc. will certainly put '\0' in buf[0]. The only case where
> >>>> snprintf() does not guarantee a nul-terminated string is when it is
> >>>> given a buffer size of 0 (which of course prevents it from writing
> >>>> anything at all to the buffer).
> >>>>
> >>>> Remove it before it gets cargo-culted elsewhere.
> >>>>
> >>>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >>>> ---
> >>>>  kernel/trace/bpf_trace.c | 3 ---
> >>>>  1 file changed, 3 deletions(-)
> >>>>
> >>>
> >>> The change looks good to me, but please rebase it on top of the
> >>> bpf-next tree. This is not a bug, so it doesn't have to go into the
> >>> bpf tree. As it is right now, it doesn't apply cleanly onto bpf-next.
> >
> > FWIW the idea of the patch also looks good to me :)
> >
> >> Thanks for the pointer. Looking in next-20210420, it seems to me that
> >>
> >> commit d9c9e4db186ab4d81f84e6f22b225d333b9424e3
> >> Author: Florent Revest <revest@chromium.org>
> >> Date:   Mon Apr 19 17:52:38 2021 +0200
> >>
> >>     bpf: Factorize bpf_trace_printk and bpf_seq_printf
> >>
> >> is buggy. In particular, these two snippets:
> >>
> >> +#define BPF_CAST_FMT_ARG(arg_nb, args, mod)                            \
> >> +       (mod[arg_nb] == BPF_PRINTF_LONG_LONG ||                         \
> >> +        (mod[arg_nb] == BPF_PRINTF_LONG && __BITS_PER_LONG == 64)      \
> >> +         ? (u64)args[arg_nb]                                           \
> >> +         : (u32)args[arg_nb])
> >>
> >>
> >> +       ret = snprintf(buf, sizeof(buf), fmt, BPF_CAST_FMT_ARG(0, args,
> >> mod),
> >> +               BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2,
> >> args, mod));
> >>
> >> Regardless of the casts done in that macro, the type of the resulting
> >> expression is that resulting from C promotion rules. And (foo ? (u64)bla
> >> : (u32)blib) has type u64, which is thus the type the compiler uses when
> >> building the vararg list being passed into snprintf(). C simply doesn't
> >> allow you to change types at run-time in this way.
> >>
> >> It probably works fine on x86-64, which passes the first six or so
> >> argument in registers, va_start() puts those registers into the va_list
> >> opaque structure, and when it comes time to do a va_arg(int), just the
> >> lower 32 bits are used. It is broken on i386 and other architectures
> >> where arguments are passed on the stack (and for x86-64 as well had
> >> there been a few more arguments) and va_arg(ap, int) is essentially ({
> >> int res = *(int *)ap; ap += 4; res; }) [or maybe it's -= 4 because stack
> >> direction etc., that's not really relevant here].
> >>
> >> Rasmus
> >
> > Thank you Rasmus :)
>
>
> I think you were lucky (or unlucky, depending on how you look at it)
> with your test case
>
> +       num_ret  = BPF_SNPRINTF(num_out, sizeof(num_out),
> +                               "%d %u %x %li %llu %lX",
> +                               -8, 9, 150, -424242, 1337, 0xDABBAD00);
>
> because it just so happens that the eventual snprintf() call uses three
> arguments for itself, so the first three 32-bit arguments end up being
> passed via registers, while the 64 bit arguments are passed via the
> stack. Can I get you to test what would happen if you interchanged
> these, i.e. changed the test case to do
>
> +       num_ret  = BPF_SNPRINTF(num_out, sizeof(num_out),
> +                               "%li %llu %lX %d %u %x",
> +                               -424242, 1337, 0xDABBAD00, -8, 9, 150);
>
> (or just add a few more expects-a-32-bit argument format specifiers and
> corresponding arguments). My guess is that up until formatting -8 it
> goes well, but when vsnprintf() is to grab the argument corresponding to
> %u, it will get the 0xffffffff from the upper half of (u64)-8.

I will need to come up with a repro and let you know yes :)

> > It seems that we went offtrack in
> > https://lore.kernel.org/bpf/CAEf4BzZVEGM4esi-Rz67_xX_RTDrgxViy0gHfpeauECR5bmRNA@mail.gmail.com/
> > and we do need something like "88a5c690b6 bpf: fix bpf_trace_printk on
> > 32 bit archs". Thinking about it again, it's clearer now why the
> > __BPF_TP_EMIT macro emits 2^3=8 different __trace_printk() indeed.
>
> Isn't it 3^3 = 27, or has that been reduced in -next compared to Linus'
> master? Doesn't matter much, just curious.
>
> > In the case of bpf_trace_printk with a maximum of 3 args, it's
> > relatively cheap; but for bpf_seq_printf and bpf_snprintf which accept
> > up to 12 arguments, that would be 2^12=4096 calls.
>
> Yeah, that doesn't scale at all.
>
>  Until now
> > bpf_seq_printf has just ignored this problem and just considered
> > everything as u64, I wonder if that'd be the best approach for these
> > two helpers anyway.
> >
>
> [wild handwaving ahead]
>
> One possibility, if one is willing to get hands dirty and dig into ABI
> details on various arches, is to create a
>
>   struct fake_va_list {
>     union {
>       va_list      ap; /* opaque, compiler-provided */
>       arch_va_list _ap; /* arch-provided, must match layout of ap */
>     };
>     void *stack;
>   };
>
> Then do
>
>   struct fake_va_list fva;
>   u64 buf[24]; /* or whatever you want to support, can be different in
> different functions */
>
>   fake_va_init(&fva, buf);
>   /* various C code, parsing format string etc. */
>   if (arg[i] is really 32 bits)
>     fake_va_push(&fva, (u32)arg[i]);
>   else
>     fake_va_push(&fva, (u64)arg[i]);
>   /* etc. */
>   ...
>   vsnprintf(out, size, fmt, fva.va);
>
> On arches like x86-64, where va_list is really a typedef for a
> one-element array of
>
> struct __va_list_tag {
>         unsigned int               gp_offset;
>         unsigned int               fp_offset;
>         void *                     overflow_arg_area;
>         void *                     reg_save_area;
> };
>
>
> fake_va_init() would make the va_list look like the reg_save_area is
> already used (i.e., set gp_offset to 48), and initialize both
> ->_ap.overflow_arg_area and ->stack to point at the given buffer.
> fake_va_push() would use and update stack appropriately. For 32 bit x86,
> va_list is really just a pointer, so fake_va_init would essentially just
> do "fva->_ap = fva->stack = buf", and fake_va_push() would again just
> need to manipulate ->stack.
>
> It's not pretty, but I don't think it necessarily requires too much
> arch-specific work (fake_va_push() could be common, perhaps just with a
> arch define to say whether 64 bit arguments need ->stack to first be
> up-aligned to an 8 byte boundary).
>
> Rasmus

Creative! :D I think these arch-specific structures would be a hard
sell though ahah.

I was having a stroll through lib/vsprintf.c and noticed bstr_printf:

 * This function like C99 vsnprintf, but the difference is that vsnprintf gets
 * arguments from stack, and bstr_printf gets arguments from @bin_buf which is
 * a binary buffer that generated by vbin_printf.

Maybe it would be easier to just build our argument buffer similarly
to what vbin_printf does.
