Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96099286945
	for <lists+bpf@lfdr.de>; Wed,  7 Oct 2020 22:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgJGUkn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Oct 2020 16:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgJGUkn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Oct 2020 16:40:43 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724EAC061755
        for <bpf@vger.kernel.org>; Wed,  7 Oct 2020 13:40:43 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id b138so513277yba.5
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2020 13:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ve7Xx2y+gVGLkumZ6yEeNgzcZhV0ouq5NDZHEoTU/FM=;
        b=NdPf4zLUDtiAJowilYjiLzxBORxlGGbD2QrLTJ1p7dQRRFFUQtvoz1a9n3pWiMInIK
         crTQiXQKsZMRLfLnxlL9+1J4GHDJa0Sg1PkDr5edFfqmqlqv0l7eCwSLEWNjeXAKoEuZ
         N0p2t6Q2w5DqVvuuebO3JjQ0P2Z4COBJn8+6Nbr/mlRTHNPP5dBc9a167JpGgYvSrk63
         O7KB72i+XNI/5NBqgozbtzrXhHw6fBLqp/iVKRa6ZDJOS9uDfO+EpW2Z6K471cmwJAlk
         v+xIQ7bwb7q4BcUnYmVpvm0MuvT+NpTSFI7YN3XmmGiom3pPuIT6Ox44X1oIfYq6oGc4
         qiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ve7Xx2y+gVGLkumZ6yEeNgzcZhV0ouq5NDZHEoTU/FM=;
        b=aH39EM/cnYHQxg0npvX6OT9JPuxCYlnTvfARZA8W7lKCR1w+2GtMahwY9AvgY5Uslg
         mkpn2nFlK5zzBF6xamqZTs9PV4L3bcL7timyUPeoks6d1W5HNGI3sqwQi84GJj2qEp0Z
         SM8T02DaLUaRODWlgQWtHOYI6/Ev9wMtbR644BmcTrTt/NZjwSQSxoqzl1dnaFBnYrEc
         ouTajTvsGr5hfIG45BFTfUhrsDniD8unzG2uJdZk/HYIXYpP1FJDukv2B+GcuTjpmDuE
         sw74T17MZR4ILqrOgXZBehCax69an2lMcAEAJR44Af8o1qKvtHDTgnCL///X9QX6yQVD
         wsEQ==
X-Gm-Message-State: AOAM533a13gBwErAO0aYXW+7ggBmZp+nE9wwAJ8lGoMx1cjBjfgXMWDx
        oNxrQG/Rv9NeFApzjVJF6p/hkYmrIyvzDFCHC8w=
X-Google-Smtp-Source: ABdhPJx5YGP55fphZInticJlE5e8OacvZX3ev32QH9lOeUN2SLgf0vRE5SHzBOT77Rl6rxXTehXCiZJKL8S89eoAkNE=
X-Received: by 2002:a25:730a:: with SMTP id o10mr6873963ybc.403.1602103242473;
 Wed, 07 Oct 2020 13:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <CA+hQ2+gb_y7TViv13K_JpJTP=yHFqORmY+=6PrO4eAjgrBSitw@mail.gmail.com>
 <CAEf4BzbjUbYDrMc13-bYBBxicDmuokjLHyRaOVA-1JHD6vVbYg@mail.gmail.com> <CAMOZA0JFYEYmLqAQu=km624nZfY8epPEpmqqsdUigzp+jFsymQ@mail.gmail.com>
In-Reply-To: <CAMOZA0JFYEYmLqAQu=km624nZfY8epPEpmqqsdUigzp+jFsymQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Oct 2020 13:40:31 -0700
Message-ID: <CAEf4BzYRiF00B+4=u8r-z+RN3bVWeV_h==4f_JJJZ133PhGAog@mail.gmail.com>
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

On Wed, Oct 7, 2020 at 1:31 PM Luigi Rizzo <lrizzo@google.com> wrote:
>
> TL;DR; there seems to be a compiler bug with clang-10 and -O2
> when struct are in .data -- details below.
>
> On Wed, Oct 7, 2020 at 8:35 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Oct 7, 2020 at 9:03 AM Luigi Rizzo <rizzo@iet.unipi.it> wrote:
> > >
> > > I am experiencing some weirdness in global variables handling
> > > in bpftool and libbpf, as described below.
> ...
> > > 2. .bss overrides from userspace are not seen in bpf at runtime
> > >
> > >     In foo_bpf.c I have "int x = 0;"
> > >     In the userspace program, before foo_bpf__load(), I do
> > >        obj->bss->x = 1
> > >     but after attach, the bpf code does not see the change, ie
> > >         "if (x == 0) { .. } else { .. }"
> > >     always takes the first branch.
> > >
> > >     If I initialize "int x = 2" and then do
> > >        obj->data->x = 1
> > >     the update is seen correctly ie
> > >           "if (x == 2) { .. } else { .. }"
> > >      takes one or the other depending on whether userspace overrides
> > >      the value before foo_bpf__load()
> >
> > This is quite surprising, given we have explicit selftests validating
> > that all this works. And it seems to work. Please check
> > prog_tests/skeleton.c and progs/test_skeleton.c. Can you try running
> > it and confirm that it works in your setup?
>
> Ah, this was non intuitive but obvious in hindsight:
>
> .bss is zeroed by the kernel after load(), and since my program
> changed the value before foo_bpf__load() , the memory was overwritten
> with 0s. I could confirm this by printing the value after load.
>
> If I update obj->data-><something> after __load(),
> or even after __attach() given that userspace mmaps .bss and .data,
> everything works as expected both for scalars and structs.

Check prog_tests/skeleton.c again, it sets .data, .bss, and .rodata
before the load. And checks that those values are preserved after
load. So .bss, if you initialize it manually, shouldn't zero-out what
you set.

>
> > >
> > > 3. .data overrides do not seem to work for non-scalar types
> > >     In foo_bpf.c I have
> > >           struct one { int a; }; // type also visible to userspace
> > >           struct one x { .a = 2 }; // avoid bugs #1 and #2
> > >     If in userspace I do
> > >           obj->data->x.a = 1
> > >     the update is not seen in the kernel, ie
> > >             "if (x.a == 2) { .. } else { .. }"
> > >      always takes the first branch
> > >
> >
> > Similarly, the same skeleton selftest tests this situation. So please
> > check selftests first and report if selftests for some reason don't
> > work in your case.
>
> Actually test_skeleton.c does _not_ test for struct in .data,
> only in .rodata and .bss

It doesn't matter which section it's in, I meant it's testing struct
field accesses from at least one of global data sections.

>
> There seems to be a compiler error, at least with clang-10 and -O2
>
> Note how the struct case the compiler uses '2' as immediate value
> when reading, whereas in the scalar case it correctly dereferences
> the pointer to the variable

It would be useful to include your original source code, especially
the variable declaration parts. I suspect that you declared your
struct variable as a static variable? In that case Clang will assume
nothing can change the value and can inline values like 2. So either
make sure you have a global variable declaration or use `static
volatile`. See how `const volatile` is used throughout all selftests
when working with the .rodata section.

[...]
