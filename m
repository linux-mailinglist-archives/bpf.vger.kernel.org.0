Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99429286A10
	for <lists+bpf@lfdr.de>; Wed,  7 Oct 2020 23:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgJGV36 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Oct 2020 17:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgJGV35 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Oct 2020 17:29:57 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F983C061755
        for <bpf@vger.kernel.org>; Wed,  7 Oct 2020 14:29:56 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h24so5028988ejg.9
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2020 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=beUoMmomUBp8vX+FY2eAW2H2BANNLTrd9ilIfJu5X6E=;
        b=uZd+znOs5Jn1coHDN0BMX8D33sgKQtgs7XL/S1Lt0mZE4dLuraM9F89zaEHLONvAUi
         KPx5bSiPx02UbsBKTzuf5h4szwRHKXpt0XBs0iI/Vgtg6/GOOAlAxZu310eGSTElS2sW
         cHm2bsgRl/CHvgRR3XcFHEbquqo8TYpDm7Gp2HHg6KOPAT7Ujn7al2ui2jmzejR7ls/C
         qedOyhdlvUpzzkW/G3R8XO0KfE2lo8C0Zlu6Xf/3L8D+GschOwSMdE4stQMrHGNYkmRm
         efgCxt4oXT1QeoSA89FPnHZu3cPLf760lcpjM6Vqn46a8ZJ1A35yAflQZp9bpK2Nt5uB
         kduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=beUoMmomUBp8vX+FY2eAW2H2BANNLTrd9ilIfJu5X6E=;
        b=eirp9/sRDtZNRrIRn04HM6g3Ti4Q1XeSDQ2u4fTTzTqlml7lIbnBoE1vbLoKybKIV9
         dfXqIiSnUkZW3XQN0Hk85OnKPeDGf3qUImlnHIL5fWexw06gPhnlC7M8Hv5J8D8Woh1f
         8q9EkalydiJyyfdv1yEBJJtQsSPY8UMef/W44chPKxspKJfFANC/1fRQihfGC1cFkWKp
         09Mu7BJMOt+ylHheMq71QyQxdrwm0n1OTnovAJyW+Tao+HV236Ygc3bEJ1C8ZRancdEs
         f/Gxuk+f6pztjZixyFIPxm9ztDloqlaW956BbU/2ULW0h0cf/MeN+cMFCaRWonWj/0N1
         +Z/g==
X-Gm-Message-State: AOAM5311ho5CW/a0pohvHFuOLeowy59Ub9LaQ4jHbs51h2U1meZyjDSz
        /zcl+VWcNQLbjSJ1jsyEgimsMiFD37wXcjEwm0oDWIAHAKDfjA==
X-Google-Smtp-Source: ABdhPJzps4CHYF5Udov6OImLtHjhYKlXMVRTYJYEHZSUMe/j3cU0xppuCoTdEaa4TZf8MOZEc6ud4Aua5I31FfIuzbs=
X-Received: by 2002:a17:906:7210:: with SMTP id m16mr5531484ejk.490.1602106194476;
 Wed, 07 Oct 2020 14:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <CA+hQ2+gb_y7TViv13K_JpJTP=yHFqORmY+=6PrO4eAjgrBSitw@mail.gmail.com>
 <CAEf4BzbjUbYDrMc13-bYBBxicDmuokjLHyRaOVA-1JHD6vVbYg@mail.gmail.com>
 <CAMOZA0JFYEYmLqAQu=km624nZfY8epPEpmqqsdUigzp+jFsymQ@mail.gmail.com> <CAEf4BzYRiF00B+4=u8r-z+RN3bVWeV_h==4f_JJJZ133PhGAog@mail.gmail.com>
In-Reply-To: <CAEf4BzYRiF00B+4=u8r-z+RN3bVWeV_h==4f_JJJZ133PhGAog@mail.gmail.com>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Wed, 7 Oct 2020 23:29:43 +0200
Message-ID: <CAMOZA0J1u-DdNk4EDFxeemxNhS8teKYLmEEMPQUcfddaJFGwaw@mail.gmail.com>
Subject: Re: libbpf/bpftool inconsistent handling og .data and .bss ?
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Luigi Rizzo <rizzo@iet.unipi.it>, bpf <bpf@vger.kernel.org>,
        Petar Penkov <ppenkov@google.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 7, 2020 at 10:40 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Oct 7, 2020 at 1:31 PM Luigi Rizzo <lrizzo@google.com> wrote:
> >
> > TL;DR; there seems to be a compiler bug with clang-10 and -O2
> > when struct are in .data -- details below.
> >
> > On Wed, Oct 7, 2020 at 8:35 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Oct 7, 2020 at 9:03 AM Luigi Rizzo <rizzo@iet.unipi.it> wrote:
> > > >
> > > > I am experiencing some weirdness in global variables handling
> > > > in bpftool and libbpf, as described below.
> > ...
> > > > 2. .bss overrides from userspace are not seen in bpf at runtime
> > > >
> > > >     In foo_bpf.c I have "int x = 0;"
> > > >     In the userspace program, before foo_bpf__load(), I do
> > > >        obj->bss->x = 1
> > > >     but after attach, the bpf code does not see the change, ie
> > > >         "if (x == 0) { .. } else { .. }"
> > > >     always takes the first branch.
> > > >
> > > >     If I initialize "int x = 2" and then do
> > > >        obj->data->x = 1
> > > >     the update is seen correctly ie
> > > >           "if (x == 2) { .. } else { .. }"
> > > >      takes one or the other depending on whether userspace overrides
> > > >      the value before foo_bpf__load()
> > >
> > > This is quite surprising, given we have explicit selftests validating
> > > that all this works. And it seems to work. Please check
> > > prog_tests/skeleton.c and progs/test_skeleton.c. Can you try running
> > > it and confirm that it works in your setup?
> >
> > Ah, this was non intuitive but obvious in hindsight:
> >
> > .bss is zeroed by the kernel after load(), and since my program
> > changed the value before foo_bpf__load() , the memory was overwritten
> > with 0s. I could confirm this by printing the value after load.
> >
> > If I update obj->data-><something> after __load(),
> > or even after __attach() given that userspace mmaps .bss and .data,
> > everything works as expected both for scalars and structs.
>
> Check prog_tests/skeleton.c again, it sets .data, .bss, and .rodata
> before the load. And checks that those values are preserved after
> load. So .bss, if you initialize it manually, shouldn't zero-out what
> you set.

Don't know what to say: it is cleared on my laptop 5.7.17

I printed the values around assignments and calls
(also verified that obj->bss does not change):
Below, x is "uint32_t x = 0" in .bss
struct one { uint32_t a } s = { .a = 2} " in .data
Program output:

before load, obj->bss is 0x7fb0698b6000
initially x is 0 s.a is 2
// x = 1; s.a = 3
before load x is 1 s.a is 3
after load, obj->bss is 0x7fb0698b6000
after load x is 0 s.a is 3 // note x is cleared, s is left alone
// x = 2; s.a = 4;
after assign x is 2 s.a is 4 variables by 10 every 5ms
// attach, when the program runs (every 5ms) does
// if (s.a == 2 || s.a > 10) { x += 10; s.a += 10}
after attach x is 12 s.a is 12
at runtime count_off is 2382 x is 12
at runtime count_off is 2382 x is 12
...

Could it be some security setting ?

>
> >
> > > >
> > > > 3. .data overrides do not seem to work for non-scalar types
> > > >     In foo_bpf.c I have
> > > >           struct one { int a; }; // type also visible to userspace
> > > >           struct one x { .a = 2 }; // avoid bugs #1 and #2
> > > >     If in userspace I do
> > > >           obj->data->x.a = 1
> > > >     the update is not seen in the kernel, ie
> > > >             "if (x.a == 2) { .. } else { .. }"
> > > >      always takes the first branch
> > > >
> > >
> > > Similarly, the same skeleton selftest tests this situation. So please
> > > check selftests first and report if selftests for some reason don't
> > > work in your case.
> >
> > Actually test_skeleton.c does _not_ test for struct in .data,
> > only in .rodata and .bss
>
> It doesn't matter which section it's in, I meant it's testing struct
> field accesses from at least one of global data sections.

Right but as the llvm-objdump shows, the compiler is treating
.bss and .data differently, at least for struct reads.

>
> >
> > There seems to be a compiler error, at least with clang-10 and -O2
> >
> > Note how the struct case the compiler uses '2' as immediate value
> > when reading, whereas in the scalar case it correctly dereferences
> > the pointer to the variable
>
> It would be useful to include your original source code, especially
> the variable declaration parts. I suspect that you declared your
> struct variable as a static variable? In that case Clang will assume
> nothing can change the value and can inline values like 2. So either
> make sure you have a global variable declaration or use `static
> volatile`. See how `const volatile` is used throughout all selftests
> when working with the .rodata section.

Perhaps the easiest is to see it on godbolt:

https://godbolt.org/z/Mnx38v

and how clang gets terribly confused when compiling read access
to the struct_in_data field

cheers
luigi
