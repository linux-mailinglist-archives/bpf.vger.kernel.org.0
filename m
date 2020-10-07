Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853E1286920
	for <lists+bpf@lfdr.de>; Wed,  7 Oct 2020 22:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgJGUbe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Oct 2020 16:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbgJGUbe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Oct 2020 16:31:34 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12725C061755
        for <bpf@vger.kernel.org>; Wed,  7 Oct 2020 13:31:34 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id p13so3570103edi.7
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2020 13:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pa6A/Wb2jIahrX4zuacGIFWAHhbuMOoeMYYAfLXtYPU=;
        b=s9oM8LjXeuKqRydoiVeAUptSLVc193s8B9onXm5Tii8S/b2cXABDasJT+KiPxTqa3Y
         VcKFUCruhmdbCUtdjDJiNLAFFOEdFKtm16Hmo9I65HIM0yrs08OSXfCs0s8lzd40EqGl
         AVsQ/7EJLQvhRbryNuSQYyX5ZpFZ0o+1GQxvSESbQRA//sGQTERGq/+fsxn4C9TkCoUH
         CEQGkR3vHTA5Ufo+RiPSzBuwTl4CtLqywTE0ARfX73AeMvtrnnvl3TeUA0vNw3LrTAYA
         ENHZkkzWQbl3v+6tT9niWnE55yAdLcW0JrEtsU/YFbd/JWtNOdd2Tlk8N+O3oj/VVlh/
         tUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pa6A/Wb2jIahrX4zuacGIFWAHhbuMOoeMYYAfLXtYPU=;
        b=LuSdpos2tHsm40Wfl77Q23BPTCvSAMwYZbjDe9ogI9aQHMC2HFmkbxBt8NpTWrsCAa
         rSODay4v4eknfwDsipc+RhNVq8mUBdLy3j2g1mV09hGPoTxG+woEhrAple3qYEY6KZU4
         dcDouDLt/p3JsGT1GtAv00liKSghZK0Mz7FfAzYxvDZ8Td4JvAhFMn81HCzab0OCUTwg
         krmV7L7tiyB2L6RFKkg7rTutnAv8cg0MrpOvvrtEcr2DkcfRlIk9AXJEl1NpNkMxqR6f
         NRjGctOOKnuHIO6QqrmZCWc17azgQhEUFUVZDK8sDv3/p+gSZBKLQ1M5eWMS7E6hKAK7
         2kPQ==
X-Gm-Message-State: AOAM530DOjG3KQbY0VI2OkgJj5T3oZ3uFlThYqObviEjqJNrDnpDPyOE
        5H+rKbcjXBGkLhuH6dNc4o/hPoItD93yBZtMyZiRMw==
X-Google-Smtp-Source: ABdhPJy6zAMTu4NvcoEpMpbTsxtFL82UCOPRxi+hubwUawIvhbVzccUEDSfcZcPwmem/6Uj9sHVT0p1j0xnntTjN6fs=
X-Received: by 2002:aa7:cfcb:: with SMTP id r11mr5381056edy.211.1602102692323;
 Wed, 07 Oct 2020 13:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <CA+hQ2+gb_y7TViv13K_JpJTP=yHFqORmY+=6PrO4eAjgrBSitw@mail.gmail.com>
 <CAEf4BzbjUbYDrMc13-bYBBxicDmuokjLHyRaOVA-1JHD6vVbYg@mail.gmail.com>
In-Reply-To: <CAEf4BzbjUbYDrMc13-bYBBxicDmuokjLHyRaOVA-1JHD6vVbYg@mail.gmail.com>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Wed, 7 Oct 2020 22:31:21 +0200
Message-ID: <CAMOZA0JFYEYmLqAQu=km624nZfY8epPEpmqqsdUigzp+jFsymQ@mail.gmail.com>
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

TL;DR; there seems to be a compiler bug with clang-10 and -O2
when struct are in .data -- details below.

On Wed, Oct 7, 2020 at 8:35 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Oct 7, 2020 at 9:03 AM Luigi Rizzo <rizzo@iet.unipi.it> wrote:
> >
> > I am experiencing some weirdness in global variables handling
> > in bpftool and libbpf, as described below.
...
> > 2. .bss overrides from userspace are not seen in bpf at runtime
> >
> >     In foo_bpf.c I have "int x = 0;"
> >     In the userspace program, before foo_bpf__load(), I do
> >        obj->bss->x = 1
> >     but after attach, the bpf code does not see the change, ie
> >         "if (x == 0) { .. } else { .. }"
> >     always takes the first branch.
> >
> >     If I initialize "int x = 2" and then do
> >        obj->data->x = 1
> >     the update is seen correctly ie
> >           "if (x == 2) { .. } else { .. }"
> >      takes one or the other depending on whether userspace overrides
> >      the value before foo_bpf__load()
>
> This is quite surprising, given we have explicit selftests validating
> that all this works. And it seems to work. Please check
> prog_tests/skeleton.c and progs/test_skeleton.c. Can you try running
> it and confirm that it works in your setup?

Ah, this was non intuitive but obvious in hindsight:

.bss is zeroed by the kernel after load(), and since my program
changed the value before foo_bpf__load() , the memory was overwritten
with 0s. I could confirm this by printing the value after load.

If I update obj->data-><something> after __load(),
or even after __attach() given that userspace mmaps .bss and .data,
everything works as expected both for scalars and structs.

> >
> > 3. .data overrides do not seem to work for non-scalar types
> >     In foo_bpf.c I have
> >           struct one { int a; }; // type also visible to userspace
> >           struct one x { .a = 2 }; // avoid bugs #1 and #2
> >     If in userspace I do
> >           obj->data->x.a = 1
> >     the update is not seen in the kernel, ie
> >             "if (x.a == 2) { .. } else { .. }"
> >      always takes the first branch
> >
>
> Similarly, the same skeleton selftest tests this situation. So please
> check selftests first and report if selftests for some reason don't
> work in your case.

Actually test_skeleton.c does _not_ test for struct in .data,
only in .rodata and .bss

There seems to be a compiler error, at least with clang-10 and -O2

Note how the struct case the compiler uses '2' as immediate value
when reading, whereas in the scalar case it correctly dereferences
the pointer to the variable


Disassembly of section fexit/bar:

0000000000000000 foo_struct:
; int BPF_PROG(foo_struct) {
       0:       b7 01 00 00 02 00 00 00 r1 = 2
;   if (x.a == 2 || x.a > 10) { x.a += 10; }
       1:       15 01 02 00 02 00 00 00 if r1 == 2 goto +2 <LBB1_2>
       2:       b7 02 00 00 0b 00 00 00 r2 = 11
       3:       2d 12 04 00 00 00 00 00 if r2 > r1 goto +4 <LBB1_3>

0000000000000020 LBB1_2:
       4:       07 01 00 00 0a 00 00 00 r1 += 10
       5:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0 ll
       7:       63 12 00 00 00 00 00 00 *(u32 *)(r2 + 0) = r1

0000000000000040 LBB1_3:
; int BPF_PROG(foo_struct) {
       8:       b7 00 00 00 00 00 00 00 r0 = 0
       9:       95 00 00 00 00 00 00 00 exit

Disassembly of section fexit/baz:

0000000000000000 foo_scalar:
;   if (count_off == 2 || count_off > 10) { count_off += 10; }
       0:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
       2:       61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
       3:       15 02 02 00 02 00 00 00 if r2 == 2 goto +2 <LBB2_2>
       4:       b7 03 00 00 0b 00 00 00 r3 = 11
       5:       2d 23 02 00 00 00 00 00 if r3 > r2 goto +2 <LBB2_3>

0000000000000030 LBB2_2:
       6:       07 02 00 00 0a 00 00 00 r2 += 10
       7:       63 21 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r2

0000000000000040 LBB2_3:
; int BPF_PROG(foo_scalar) {
       8:       b7 00 00 00 00 00 00 00 r0 = 0
       9:       95 00 00 00 00 00 00 00 exit

------------

If I put the struct in .bss then it gets translated correctly:

Disassembly of section fexit/bar:

0000000000000000 foo_struct:
;   if (x.a == 2 || x.a > 10) { x.a += 10; }
       0:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
       2:       61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
       3:       15 02 02 00 02 00 00 00 if r2 == 2 goto +2 <LBB1_2>
       4:       b7 03 00 00 0b 00 00 00 r3 = 11
       5:       2d 23 02 00 00 00 00 00 if r3 > r2 goto +2 <LBB1_3>

0000000000000030 LBB1_2:
       6:       07 02 00 00 0a 00 00 00 r2 += 10
       7:       63 21 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r2

0000000000000040 LBB1_3:
; int BPF_PROG(foo_struct) {
       8:       b7 00 00 00 00 00 00 00 r0 = 0
       9:       95 00 00 00 00 00 00 00 exit
