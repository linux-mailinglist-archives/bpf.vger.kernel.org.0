Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0DD28066F
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 20:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbgJASVX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 14:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbgJASVS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 14:21:18 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57672C0613D0
        for <bpf@vger.kernel.org>; Thu,  1 Oct 2020 11:21:18 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id x8so4700302ybe.12
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2020 11:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HfF5ODh4VOzsSiRoUMFn5r1WdtUcvxzNEHZ1e6TS4Hw=;
        b=NMoxN036043nfjJIszJWGq77X5o8hjaq4Qzd2vy00TEwVILDKs/BQ3GW+6gqO0gy7f
         zLRgopFAZWOhrOrvP8gU+dLn6g4bzWQCpHUWtDqBU9arj1wVAiVfzrnIg2O9Whyqzc2Y
         kIN19vmA9LAU98Ij4JbL26E0T/EzJXrK0pJvhIE5IdjYrUCtkQFrxZVkTdq0Wh5oVYGN
         F/EYAc4Qq3Y4L/h6O48em8zwEQeCsVQxW3vJiy/zKX0bD+X38DppMxCtdL+nLj65jVNk
         cX1ZUraBgpJlAqRhBLBDtt/fWS+ECjY9JpMeFQ2nZB0bKfnZuJ5fk1q3X/tqhsUr+A+6
         hcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfF5ODh4VOzsSiRoUMFn5r1WdtUcvxzNEHZ1e6TS4Hw=;
        b=qjiphHfT66pjVPloe0kPPCrbrqSyVFI8xAf8e7/BbKb3s0taQ2RWfdHA+q9ykS7Eab
         DRfYYThUyPgS7eiiLybkrSRnOtObu1laIPGmAQtw2oHsSumX222ufoRc5MKO5Qu6Qrz0
         aai5RvGU/5gjYW7hXYiIZsv1BKBoUK2MtbuNl/LCmKvI3AXNr5Zfg0+i8vF6MnZcdgwI
         jywk+eOpt1n8AkWmEqkmyMla29Bs4z76/lJbrW0TSGIuD4S5oZ9qbsLItXnNAiwR+cx5
         +dEQiZuq+947d0jqFxtVxUxPpGou9oNw/3OhLkiuBVHzWdoSppTS4I4ZZgh+U9sXAQur
         OLjg==
X-Gm-Message-State: AOAM532olhMTMEeyL2f9kfA4X4xwAXkubXtu0CYwtPLagocww6A8UzWz
        Gchf5KIx423KB6F/61VjKP/sj+0lFGVKzxh4KPeC7tScnCg=
X-Google-Smtp-Source: ABdhPJwdSzATXRpbmm2Dp6xLw9IgXQthXO2G/L0TUYrrV7BIwhXsdiDmmrYTeGxluu6perCBML4/nK5wpRtpPsJiing=
X-Received: by 2002:a25:2596:: with SMTP id l144mr12009508ybl.510.1601576477473;
 Thu, 01 Oct 2020 11:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XBgLU=8PFkP8S32e4gpst0=R4MFv8rZA5KaO+cEPYSnTRYYw@mail.gmail.com>
 <CAEf4BzZvXvb7CsnJZkoNUzb0-o=w-i9-CHecq0O+QcCKpeuUKQ@mail.gmail.com>
 <CA+XBgLWNavRQJy7uRG35RXprHjQ1uaURyB8tj7tE=Mv=EWKO+g@mail.gmail.com>
 <CAEf4Bzb4JrfmENs197d30xU2fnWwu9_1rq-=n9szaWmmxaSckg@mail.gmail.com>
 <CA+XBgLWa7nWnQNTUdqgBK2E34PH8mUc_wUWR=_iM2Yjr=gxrVw@mail.gmail.com>
 <CAEf4BzY1N_yZscKTT81fnexwPgD7XbD0UCyEsa1CUp_giyJwfA@mail.gmail.com> <CA+XBgLWid4c3TZgcAREnJ_M9Wuw9wHs6H2T6RYjPwwExRZPC+Q@mail.gmail.com>
In-Reply-To: <CA+XBgLWid4c3TZgcAREnJ_M9Wuw9wHs6H2T6RYjPwwExRZPC+Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 1 Oct 2020 11:21:06 -0700
Message-ID: <CAEf4BzaXMWupwzcvS1AaPEpoQ0Lz4MJA23YeRcsBWD8717Sr+Q@mail.gmail.com>
Subject: Re: Problems with pointer offsets on ARM32
To:     Luka Oreskovic <luka.oreskovic@sartura.hr>
Cc:     bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 1, 2020 at 6:40 AM Luka Oreskovic <luka.oreskovic@sartura.hr> wrote:
>
> On Thu, Oct 1, 2020 at 1:09 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Sep 15, 2020 at 12:26 AM Luka Oreskovic
> > <luka.oreskovic@sartura.hr> wrote:
> > >
> > > On Mon, Sep 14, 2020 at 7:49 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Mon, Sep 14, 2020 at 12:55 AM Luka Oreskovic
> > > > <luka.oreskovic@sartura.hr> wrote:
> > > > >
> > > > > On Fri, Sep 11, 2020 at 8:14 PM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Sep 11, 2020 at 9:45 AM Luka Oreskovic
> > > > > > <luka.oreskovic@sartura.hr> wrote:
> > > > > > >
> > > > > > > Greetings everyone,
> > > > > > >
> > > > > > > I have been testing various BPF programs on the ARM32 architecture and
> > > > > > > have encountered a strange error.
> > > > > > >
> > > > > > > When trying to run a simple program that prints out the arguments of
> > > > > > > the open syscall,
> > > > > > > I found some strange behaviour with the pointer offsets when accessing
> > > > > > > the arguments:
> > > > > > > The output of llvm-objdump differed from the verifier error dump log.
> > > > > > > Notice the differences in lines 0 and 1. Why is the bytecode being
> > > > > > > altered at runtime?
> > > > > > >
> > > > > > > I attached the program, the llvm-objdump result and the verifier dump below.
> > > > > > >
> > > > > > > Best wishes,
> > > > > > > Luka Oreskovic
> > > > > > >
> > > > > > > BPF program
> > > > > > > --------------------------------------------
> > > > > > > #include "vmlinux.h"
> > > > > > > #include <bpf/bpf_helpers.h>
> > > > > > >
> > > > > > > SEC("tracepoint/syscalls/sys_enter_open")
> > > > > > > int tracepoint__syscalls__sys_enter_open(struct trace_event_raw_sys_enter* ctx)
> > > > > > > {
> > > > > > >         const char *arg1 = (const char *)ctx->args[0];
> > > > > > >         int arg2 = (int)ctx->args[1];
> >
> > Luka, can you apply the changes below to bpf_core_read.h header and
> > read these args using BPF_CORE_READ() macro:
> >
> > const char *arg1 = (const char *)BPF_CORE_READ(ctx, args[0]);
> > int arg2 = BPF_CORE_READ(ctx, args[1]);
> >
> > I'm curious if that will work (unfortunately I don't have a complete
> > enough setup to test this).
> >
> > The patch is as follows (with broken tab<->space conversion, so please
> > make changes by hand):
> >
> > diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
> > index bbcefb3ff5a5..fee6328d36c0 100644
> > --- a/tools/lib/bpf/bpf_core_read.h
> > +++ b/tools/lib/bpf/bpf_core_read.h
> > @@ -261,14 +261,16 @@ enum bpf_enum_value_kind {
> >  #define ___type(...) typeof(___arrow(__VA_ARGS__))
> >
> >  #define ___read(read_fn, dst, src_type, src, accessor)                     \
> > -       read_fn((void *)(dst), sizeof(*(dst)), &((src_type)(src))->accessor)
> > +       read_fn((void *)(dst),                                              \
> > +               bpf_core_field_size(((src_type)(src))->accessor),           \
> > +               &((src_type)(src))->accessor)
> >
> >  /* "recursively" read a sequence of inner pointers using local __t var */
> >  #define ___rd_first(src, a) ___read(bpf_core_read, &__t, ___type(src), src, a);
> >  #define ___rd_last(...)
> >              \
> >         ___read(bpf_core_read, &__t,                                        \
> >                 ___type(___nolast(__VA_ARGS__)), __t, ___last(__VA_ARGS__));
> > -#define ___rd_p1(...) const void *__t; ___rd_first(__VA_ARGS__)
> > +#define ___rd_p1(...) const void *__t = (void *)0; ___rd_first(__VA_ARGS__)
> >  #define ___rd_p2(...) ___rd_p1(___nolast(__VA_ARGS__)) ___rd_last(__VA_ARGS__)
> >  #define ___rd_p3(...) ___rd_p2(___nolast(__VA_ARGS__)) ___rd_last(__VA_ARGS__)
> >  #define ___rd_p4(...) ___rd_p3(___nolast(__VA_ARGS__)) ___rd_last(__VA_ARGS__)
> >
> >
> >
> > BTW, this approach should work for reading pointers as well, it would
> > be nice if you can test that as well. E.g., something like the
> > following:
> >
> > struct task_struct *t = (void *)bpf_get_current_task();
> > int ppid = BPF_CORE_READ(t, group_leader, tgid);
> >
> > If you try it without the patch above, it should either read garbage
> > or zero, but not a valid parent PID (please verify that as well).
> >
> > I really appreciate your help with testing, thanks!
> >
> >
> > > > > > >
> > > > > > >         bpf_printk("Open arg 1: %s\n", arg1);
> > > > > > >         bpf_printk("Open arg 2: %d\n", arg2);
> > > > > > >
> > > > > > >         return 0;
> > > > > > > }
> > > > > > >
> > > > > > > char LICENSE[] SEC("license") = "GPL";
> > > > > > >
> > > > > > >
> >
> > [...]
> >
> > >
> > > Best wishes,
> > > Luka Oreskovic
>
> Greetings,
>
> I have tested your patch using the BPF_CORE_READ() macro and
> everything works great!

Ok, glad it worked. It needs to be a bit more work to be applicable in
wide range of situation, but you can use it as a work around for now,
at least.

>
> As for the pointer read, it prints valid PIDs both with the patch and
> without it.

That surprised me initially, but then I realized that 32-bit kernel
will just chop off high 32 bits of BPF's 64-bit register when the
helper is getting passed a pointer, so even if those high 32-bits have
garbage (as should be the case here), it still works magically.

>
> Thank you very much for your help.
