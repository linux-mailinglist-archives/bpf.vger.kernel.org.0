Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD50286ADB
	for <lists+bpf@lfdr.de>; Thu,  8 Oct 2020 00:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgJGW0j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Oct 2020 18:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbgJGW0j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Oct 2020 18:26:39 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9131EC061755
        for <bpf@vger.kernel.org>; Wed,  7 Oct 2020 15:26:39 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id x20so3010799ybs.8
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2020 15:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TJgBo1dtgogRyPiQsisxOf2PtjlHYcANXHFEdwGJYwE=;
        b=b3ZHCucT2ER7EipCpOuS00H0YO9Lk9r2PbfcDd5w8UuslQNVKZu5k9oguBCzr9h+N8
         ZJhEWXBy8m1PvW5fGStXXtPhBrp2uRSKyXh8HZHXVX9Zwvc6hsjSj/3DFpz0plq7xFPj
         w2cihspBeJYHPsZ2QjHf8kxwLGT7nhhRe5JMXc/VMLjfLQy+b90HCs0Gge7l2MHzuzZq
         4miRt7CguDeQmRXTvlqHe4aCxXsiyNMPm9u0n043jT00pq7C8WKy6B4UQzd6MaYhQ9Yl
         bKjkj61InGkGiSwiAiIrKyTwFvWA6A6VBpdKqU6ltBftP0fUGigMqSrNLbD458T2mjsf
         /TKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TJgBo1dtgogRyPiQsisxOf2PtjlHYcANXHFEdwGJYwE=;
        b=coQedbvjPgGe/uGk0FjQkiRpVSxYhOtSKDYBaGpig+Uxn+FMGIl75xVKe6vBKB+Xip
         GojLNN7eV7CWbffkZvgpvVV90hKs8Dm1yNKx6dV6Jn795JJ7yMp15QbvjgOi7g3pTQiN
         SU4KBucSHyo7cYc0m/zfiZub6i6W9ZfSG5vIZIA/gW3IbFVFvMJ2PodGR2WtaOJusbuG
         2tQ0UiBNSynENyu6/CVBaeh8JcZwfG6u5roc3WwWvgPInwu2ADwJg7s6KNaUKj0Mbyql
         ydc0piYtiW7PJKkiLHjc1xUmF0PDJ4g8xJsAAHa0HEFUQvhSg29xIfypjIzHjFv87yhH
         CMPg==
X-Gm-Message-State: AOAM5321aQst9+bQSy/x3SerdWbIXsmOArFFAs0rQN63Ir94M6F45kge
        PR97v4evanyKUxIbGI+ylPHPL6n/ulrwxcQFJRA=
X-Google-Smtp-Source: ABdhPJxDcyV6F+QDzjwsuKm+Z+tR/lYAoEUvVbgqo/KZd8UPAcocAWidNdkKrQKaqwWuHrpvFNRTQpxUT/idRC9477Y=
X-Received: by 2002:a25:730a:: with SMTP id o10mr7355772ybc.403.1602109598690;
 Wed, 07 Oct 2020 15:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+hQ2+gb_y7TViv13K_JpJTP=yHFqORmY+=6PrO4eAjgrBSitw@mail.gmail.com>
 <CAEf4BzbjUbYDrMc13-bYBBxicDmuokjLHyRaOVA-1JHD6vVbYg@mail.gmail.com>
 <CAMOZA0JFYEYmLqAQu=km624nZfY8epPEpmqqsdUigzp+jFsymQ@mail.gmail.com>
 <CAEf4BzYRiF00B+4=u8r-z+RN3bVWeV_h==4f_JJJZ133PhGAog@mail.gmail.com> <CAMOZA0J1u-DdNk4EDFxeemxNhS8teKYLmEEMPQUcfddaJFGwaw@mail.gmail.com>
In-Reply-To: <CAMOZA0J1u-DdNk4EDFxeemxNhS8teKYLmEEMPQUcfddaJFGwaw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Oct 2020 15:26:27 -0700
Message-ID: <CAEf4BzYnC+nBgeZ1uGb+upSwQiHpFK+hOM=fJ7WdUiZ4b1KdcA@mail.gmail.com>
Subject: Re: libbpf/bpftool inconsistent handling og .data and .bss ?
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     Luigi Rizzo <rizzo@iet.unipi.it>, bpf <bpf@vger.kernel.org>,
        Petar Penkov <ppenkov@google.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 7, 2020 at 2:29 PM Luigi Rizzo <lrizzo@google.com> wrote:
>
> On Wed, Oct 7, 2020 at 10:40 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Oct 7, 2020 at 1:31 PM Luigi Rizzo <lrizzo@google.com> wrote:
> > >
> > > TL;DR; there seems to be a compiler bug with clang-10 and -O2
> > > when struct are in .data -- details below.
> > >
> > > On Wed, Oct 7, 2020 at 8:35 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Oct 7, 2020 at 9:03 AM Luigi Rizzo <rizzo@iet.unipi.it> wrote:
> > > > >
> > > > > I am experiencing some weirdness in global variables handling
> > > > > in bpftool and libbpf, as described below.
> > > ...
> > > > > 2. .bss overrides from userspace are not seen in bpf at runtime
> > > > >
> > > > >     In foo_bpf.c I have "int x = 0;"
> > > > >     In the userspace program, before foo_bpf__load(), I do
> > > > >        obj->bss->x = 1
> > > > >     but after attach, the bpf code does not see the change, ie
> > > > >         "if (x == 0) { .. } else { .. }"
> > > > >     always takes the first branch.
> > > > >
> > > > >     If I initialize "int x = 2" and then do
> > > > >        obj->data->x = 1
> > > > >     the update is seen correctly ie
> > > > >           "if (x == 2) { .. } else { .. }"
> > > > >      takes one or the other depending on whether userspace overrides
> > > > >      the value before foo_bpf__load()
> > > >
> > > > This is quite surprising, given we have explicit selftests validating
> > > > that all this works. And it seems to work. Please check
> > > > prog_tests/skeleton.c and progs/test_skeleton.c. Can you try running
> > > > it and confirm that it works in your setup?
> > >
> > > Ah, this was non intuitive but obvious in hindsight:
> > >
> > > .bss is zeroed by the kernel after load(), and since my program
> > > changed the value before foo_bpf__load() , the memory was overwritten
> > > with 0s. I could confirm this by printing the value after load.
> > >
> > > If I update obj->data-><something> after __load(),
> > > or even after __attach() given that userspace mmaps .bss and .data,
> > > everything works as expected both for scalars and structs.
> >
> > Check prog_tests/skeleton.c again, it sets .data, .bss, and .rodata
> > before the load. And checks that those values are preserved after
> > load. So .bss, if you initialize it manually, shouldn't zero-out what
> > you set.
>
> Don't know what to say: it is cleared on my laptop 5.7.17
>
> I printed the values around assignments and calls
> (also verified that obj->bss does not change):
> Below, x is "uint32_t x = 0" in .bss
> struct one { uint32_t a } s = { .a = 2} " in .data
> Program output:
>
> before load, obj->bss is 0x7fb0698b6000
> initially x is 0 s.a is 2
> // x = 1; s.a = 3
> before load x is 1 s.a is 3
> after load, obj->bss is 0x7fb0698b6000
> after load x is 0 s.a is 3 // note x is cleared, s is left alone
> // x = 2; s.a = 4;
> after assign x is 2 s.a is 4 variables by 10 every 5ms
> // attach, when the program runs (every 5ms) does
> // if (s.a == 2 || s.a > 10) { x += 10; s.a += 10}
> after attach x is 12 s.a is 12
> at runtime count_off is 2382 x is 12
> at runtime count_off is 2382 x is 12
> ...
>
> Could it be some security setting ?
>
> >
> > >
> > > > >
> > > > > 3. .data overrides do not seem to work for non-scalar types
> > > > >     In foo_bpf.c I have
> > > > >           struct one { int a; }; // type also visible to userspace
> > > > >           struct one x { .a = 2 }; // avoid bugs #1 and #2
> > > > >     If in userspace I do
> > > > >           obj->data->x.a = 1
> > > > >     the update is not seen in the kernel, ie
> > > > >             "if (x.a == 2) { .. } else { .. }"
> > > > >      always takes the first branch
> > > > >
> > > >
> > > > Similarly, the same skeleton selftest tests this situation. So please
> > > > check selftests first and report if selftests for some reason don't
> > > > work in your case.
> > >
> > > Actually test_skeleton.c does _not_ test for struct in .data,
> > > only in .rodata and .bss
> >
> > It doesn't matter which section it's in, I meant it's testing struct
> > field accesses from at least one of global data sections.
>
> Right but as the llvm-objdump shows, the compiler is treating
> .bss and .data differently, at least for struct reads.
>
> >
> > >
> > > There seems to be a compiler error, at least with clang-10 and -O2
> > >
> > > Note how the struct case the compiler uses '2' as immediate value
> > > when reading, whereas in the scalar case it correctly dereferences
> > > the pointer to the variable
> >
> > It would be useful to include your original source code, especially
> > the variable declaration parts. I suspect that you declared your
> > struct variable as a static variable? In that case Clang will assume
> > nothing can change the value and can inline values like 2. So either
> > make sure you have a global variable declaration or use `static
> > volatile`. See how `const volatile` is used throughout all selftests
> > when working with the .rodata section.
>
> Perhaps the easiest is to see it on godbolt:
>
> https://godbolt.org/z/Mnx38v
>

Thanks for the example. I can also reproduce this locally. It does
seem like a Clang/LLVM bug at this point. The generated code makes
absolutely no sense to me:

r1 = 100
if r1 > 3 goto +5
r1 = 3
r1 += 111

Something fishy is going on there. I bet Yonghong will quickly figure
out what's going on.

BTW, I tried `static volatile` for the variable, marking volatile
field a, marking variable as __attribute__((weak)). Nothing really
helps, generated code is still weird and inlines constants.

> and how clang gets terribly confused when compiling read access
> to the struct_in_data field
>
> cheers
> luigi
