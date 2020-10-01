Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00ABB28004F
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 15:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbgJANkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 09:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbgJANkY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 09:40:24 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2837EC0613D0
        for <bpf@vger.kernel.org>; Thu,  1 Oct 2020 06:40:24 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k25so2103542ioh.7
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2020 06:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oft0gqA/am0xTUwB2RiD9GICUaUgJQ3uoeEmXORLoiE=;
        b=I5CMkFyW76qQXA6Ctb8ebJr8bd000kWfm7SlhlXKB98BWRPEd4dDOKeea9mRQ7isIb
         VL3g8UT9QdYsVeHCXQq8vAiVNzPWjOcUMJN/Aa90Nan45+Te/zX7lrlsEhgv9cW0oMob
         Fe+aQfM6vxFgwd7uNrgaSKlxXCKtSb0m1oGoEDv7CHDWqkZw7h/TR9uGtFykH+a22lE7
         bYQeZkRDjwxOn1+dMVCYWZQ1xrUTQLyEh/35nA9OiYRrxyj78E9UAYTCPUQN9KWgk1ps
         Azf4TDyOpYpGJQcf7hTq3o3j7YZnKLAkddVlcP6NWq7sybXEp11dPrmdGtaNbtdjWTzO
         nlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oft0gqA/am0xTUwB2RiD9GICUaUgJQ3uoeEmXORLoiE=;
        b=GNrCO7ApYFKVfkvG0uIiH2QPgOFbX08Gfj6jxWXJSueTH0NRINklg8Og26crW07qFU
         E1dv2+mu90HdsneMA25XSYqm5qZU81ETY/+8Qf/in0FIZtAiBeK31VE1urxG2BNNGXro
         6Mn70Cl+RdC7t/yYvJ9NhOUdpbqAjaDTkt7xNAWFrLm5kosWoyD3Fv5Jm89WzNw2qCn7
         JkdbLFKIkMWt6I+QBMuFknHozSlHSN7Bti0KG5ODdXnHyJ70Ms7x7EX5dByH1mOFv80U
         zATm6m9oQKbWOrFOKXo6E6/nOt3TEeOWqeAuGyKxOOV186EM2vWv30BDjRRH/BCl4Xd1
         rcKg==
X-Gm-Message-State: AOAM5316PPETAOTOaXjlHvNIeHCHGcs/+m+WHXBQtuBYIRl6VAohptp5
        nWFlwtSjWOxZJMQM6f9KWSphYbxQU2Rh8T7Ja7VmSA==
X-Google-Smtp-Source: ABdhPJz//2zTNeOieK5oK4fgzqFzqq/h45Q/eAnCpoxWEqYVPVZ8Q3lbD37ohPt+Ze1VqA2CbooUgVawUycx+BduRnY=
X-Received: by 2002:a6b:ee10:: with SMTP id i16mr5337680ioh.112.1601559623285;
 Thu, 01 Oct 2020 06:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XBgLU=8PFkP8S32e4gpst0=R4MFv8rZA5KaO+cEPYSnTRYYw@mail.gmail.com>
 <CAEf4BzZvXvb7CsnJZkoNUzb0-o=w-i9-CHecq0O+QcCKpeuUKQ@mail.gmail.com>
 <CA+XBgLWNavRQJy7uRG35RXprHjQ1uaURyB8tj7tE=Mv=EWKO+g@mail.gmail.com>
 <CAEf4Bzb4JrfmENs197d30xU2fnWwu9_1rq-=n9szaWmmxaSckg@mail.gmail.com>
 <CA+XBgLWa7nWnQNTUdqgBK2E34PH8mUc_wUWR=_iM2Yjr=gxrVw@mail.gmail.com> <CAEf4BzY1N_yZscKTT81fnexwPgD7XbD0UCyEsa1CUp_giyJwfA@mail.gmail.com>
In-Reply-To: <CAEf4BzY1N_yZscKTT81fnexwPgD7XbD0UCyEsa1CUp_giyJwfA@mail.gmail.com>
From:   Luka Oreskovic <luka.oreskovic@sartura.hr>
Date:   Thu, 1 Oct 2020 15:40:12 +0200
Message-ID: <CA+XBgLWid4c3TZgcAREnJ_M9Wuw9wHs6H2T6RYjPwwExRZPC+Q@mail.gmail.com>
Subject: Re: Problems with pointer offsets on ARM32
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 1, 2020 at 1:09 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 15, 2020 at 12:26 AM Luka Oreskovic
> <luka.oreskovic@sartura.hr> wrote:
> >
> > On Mon, Sep 14, 2020 at 7:49 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Sep 14, 2020 at 12:55 AM Luka Oreskovic
> > > <luka.oreskovic@sartura.hr> wrote:
> > > >
> > > > On Fri, Sep 11, 2020 at 8:14 PM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Fri, Sep 11, 2020 at 9:45 AM Luka Oreskovic
> > > > > <luka.oreskovic@sartura.hr> wrote:
> > > > > >
> > > > > > Greetings everyone,
> > > > > >
> > > > > > I have been testing various BPF programs on the ARM32 architecture and
> > > > > > have encountered a strange error.
> > > > > >
> > > > > > When trying to run a simple program that prints out the arguments of
> > > > > > the open syscall,
> > > > > > I found some strange behaviour with the pointer offsets when accessing
> > > > > > the arguments:
> > > > > > The output of llvm-objdump differed from the verifier error dump log.
> > > > > > Notice the differences in lines 0 and 1. Why is the bytecode being
> > > > > > altered at runtime?
> > > > > >
> > > > > > I attached the program, the llvm-objdump result and the verifier dump below.
> > > > > >
> > > > > > Best wishes,
> > > > > > Luka Oreskovic
> > > > > >
> > > > > > BPF program
> > > > > > --------------------------------------------
> > > > > > #include "vmlinux.h"
> > > > > > #include <bpf/bpf_helpers.h>
> > > > > >
> > > > > > SEC("tracepoint/syscalls/sys_enter_open")
> > > > > > int tracepoint__syscalls__sys_enter_open(struct trace_event_raw_sys_enter* ctx)
> > > > > > {
> > > > > >         const char *arg1 = (const char *)ctx->args[0];
> > > > > >         int arg2 = (int)ctx->args[1];
>
> Luka, can you apply the changes below to bpf_core_read.h header and
> read these args using BPF_CORE_READ() macro:
>
> const char *arg1 = (const char *)BPF_CORE_READ(ctx, args[0]);
> int arg2 = BPF_CORE_READ(ctx, args[1]);
>
> I'm curious if that will work (unfortunately I don't have a complete
> enough setup to test this).
>
> The patch is as follows (with broken tab<->space conversion, so please
> make changes by hand):
>
> diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
> index bbcefb3ff5a5..fee6328d36c0 100644
> --- a/tools/lib/bpf/bpf_core_read.h
> +++ b/tools/lib/bpf/bpf_core_read.h
> @@ -261,14 +261,16 @@ enum bpf_enum_value_kind {
>  #define ___type(...) typeof(___arrow(__VA_ARGS__))
>
>  #define ___read(read_fn, dst, src_type, src, accessor)                     \
> -       read_fn((void *)(dst), sizeof(*(dst)), &((src_type)(src))->accessor)
> +       read_fn((void *)(dst),                                              \
> +               bpf_core_field_size(((src_type)(src))->accessor),           \
> +               &((src_type)(src))->accessor)
>
>  /* "recursively" read a sequence of inner pointers using local __t var */
>  #define ___rd_first(src, a) ___read(bpf_core_read, &__t, ___type(src), src, a);
>  #define ___rd_last(...)
>              \
>         ___read(bpf_core_read, &__t,                                        \
>                 ___type(___nolast(__VA_ARGS__)), __t, ___last(__VA_ARGS__));
> -#define ___rd_p1(...) const void *__t; ___rd_first(__VA_ARGS__)
> +#define ___rd_p1(...) const void *__t = (void *)0; ___rd_first(__VA_ARGS__)
>  #define ___rd_p2(...) ___rd_p1(___nolast(__VA_ARGS__)) ___rd_last(__VA_ARGS__)
>  #define ___rd_p3(...) ___rd_p2(___nolast(__VA_ARGS__)) ___rd_last(__VA_ARGS__)
>  #define ___rd_p4(...) ___rd_p3(___nolast(__VA_ARGS__)) ___rd_last(__VA_ARGS__)
>
>
>
> BTW, this approach should work for reading pointers as well, it would
> be nice if you can test that as well. E.g., something like the
> following:
>
> struct task_struct *t = (void *)bpf_get_current_task();
> int ppid = BPF_CORE_READ(t, group_leader, tgid);
>
> If you try it without the patch above, it should either read garbage
> or zero, but not a valid parent PID (please verify that as well).
>
> I really appreciate your help with testing, thanks!
>
>
> > > > > >
> > > > > >         bpf_printk("Open arg 1: %s\n", arg1);
> > > > > >         bpf_printk("Open arg 2: %d\n", arg2);
> > > > > >
> > > > > >         return 0;
> > > > > > }
> > > > > >
> > > > > > char LICENSE[] SEC("license") = "GPL";
> > > > > >
> > > > > >
>
> [...]
>
> >
> > Best wishes,
> > Luka Oreskovic

Greetings,

I have tested your patch using the BPF_CORE_READ() macro and
everything works great!

As for the pointer read, it prints valid PIDs both with the patch and
without it.

Thank you very much for your help.
