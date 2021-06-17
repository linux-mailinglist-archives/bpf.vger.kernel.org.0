Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321583ABE62
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 23:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFQVzS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 17:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhFQVzS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 17:55:18 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31907C061574;
        Thu, 17 Jun 2021 14:53:09 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id j62so5898303qke.10;
        Thu, 17 Jun 2021 14:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5HJ5/0qFNsQT3wn5IzbLqFyLfklIaRV+pxgd44JY6so=;
        b=iqyz46WC8gNSdLt5+6dIIwe+k82TYSzFDitSNnTEh3SS0+qYsVXXW3cy9sL6a6b6Hx
         /GOTXMOFk5+1vpoZp/NUGPDnLCLPK1Vn6gDBp16e6vsIAKD+aiBzkD9JUFEvhvZAUkVS
         jjyyRPor7X6qltoHp5FIB/tJ5Dv3MxdxKNe3f9rRrEMKet2QdA8pVKXsR16VQO/arOCT
         J1B2mHhVOYIqpv/x7O4SPzQU67SfNOXNzAqGUGzCV4kD32tOEcaGurPKhHonBsivISTX
         ScJEyugtchNnK9Wun5/usdPcd3ulj+aXJxxHOq1TbaVfoUbdvV+Lqwyf8gEhq5flVkLw
         cm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5HJ5/0qFNsQT3wn5IzbLqFyLfklIaRV+pxgd44JY6so=;
        b=Y19JDKeBWjlH2F3iETI2yAntvw8a+zoiNj5fYpoK07b8plMZmy5n4Ycm1m5sW8GOXs
         9KirC9Voo2oLr+i/QCM1GSAQm6OvRfeHzv6D+fGN9NGikv3I04A5Orn+ns1ktbOn20kN
         ggPyzAYlniZ90HE6K0Nc00rBjJfbWHpBaIiwrud6blyTIw/LT2D4BoIfnV68b6VqFbW4
         hhebwSXmuRgo7RbJOY2+AkfzbaDQOF5iBMSa0OgTgdXlSrgLP0dFY9nDE8MLi879j5RS
         rMZROmA1AMydPdjcJbCX4voRuELpxZj3COcz+oeQq4bjl/QMjOxSJQfyopsZWju+4TD/
         CHNg==
X-Gm-Message-State: AOAM530HiedJS5IYWs1LHbHxGN1hZjfH9t3jd4jp7fSrzcp80p9DvuPo
        M98ZSTtCQ9KHWKP87039bAcXH3djVktdWLT86Y8=
X-Google-Smtp-Source: ABdhPJwUz28+SPTW0Ozti7nMpWNZxshO9+NLYRxI2GshdBBE3qyMRrqAr9xFDuTEmU9cXw26S6mx0hyluoUQvzYSWS0=
X-Received: by 2002:a25:ba06:: with SMTP id t6mr8488871ybg.459.1623966788273;
 Thu, 17 Jun 2021 14:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZnZN2mt4+5F-00ggO9YHWrL3Jru_u3Qt2JJ+SMkHwg+w@mail.gmail.com>
 <YMoRBvTdD0qzjYf4@kernel.org> <YMopYxHgmoNVd3Yl@kernel.org>
 <YMph3VeKA1Met65X@kernel.org> <CAEf4BzZmBbkU1WWLEsZG1yVMdt7CDcuHhRF8uoLqeamhef3bVQ@mail.gmail.com>
 <YMtgz+hcE/7iO7Ux@kernel.org> <CAEf4BzbK4jN7c8aa05xGyLm_FJKgywW8Ju8dA11VAJ9Nx8drVQ@mail.gmail.com>
 <YMuzAfK6vwbeN3XX@kernel.org>
In-Reply-To: <YMuzAfK6vwbeN3XX@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Jun 2021 14:52:57 -0700
Message-ID: <CAEf4BzZWq21zP+1C4=qqWGQ3WUXK-pvt+rWpcsh_971qAw4Wzw@mail.gmail.com>
Subject: Re: latest pahole breaks libbpf CI and let's talk about staging
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org, siudin@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 17, 2021 at 1:39 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Jun 17, 2021 at 01:00:11PM -0700, Andrii Nakryiko escreveu:
> > On Thu, Jun 17, 2021 at 7:48 AM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Wed, Jun 16, 2021 at 03:36:54PM -0700, Andrii Nakryiko escreveu:
> > > > On Wed, Jun 16, 2021 at 1:41 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > > > And if I use pahole's BTF loader I find the info about that function:
> > > > >
> > > > > [acme@seventh linux]$ strace -e openat -o /tmp/bla pfunct -F btf tcp_cong_avoid_ai  ; grep vmlinux /tmp/bla
> > > > > void tcp_cong_avoid_ai(struct tcp_sock * tp, u32 w, u32 acked);
> > > > > openat(AT_FDCWD, "/sys/kernel/btf/vmlinux", O_RDONLY) = 3
> > > > >
> > > > > So this should be unrelated to the breakage you noticed in the CI.
> > > > >
> > > > > I'm trying to to reproduce the CI breakage by building the kernel and
> > > > > running selftests after a reboot.
> > > > >
> > > > > I suspect I'm missing something, can you see what it is?
> > > >
> > > > Oh, I didn't realize initially what it is. This is not kernel-related,
> > > > you are right. You just need newer Clang. Can you please use nightly
> > > > version or build from sources? Basically, your Clang is too old and it
> > > > doesn't generate BTF information for extern functions in BPF code.
> > >
> > > Oh well, I thought that that clang was new enough, the system being
> > > Fedora rawhide:
> > >
> > > [acme@seventh ~]$ clang -v |& head -1
> > > clang version 12.0.0 (https://github.com/llvm/llvm-project 87369c626114ae17f4c637635c119e6de0856a9a)
> > >
> > > I'm now building the single-repo main...
> > >
> > > Would you consider a patch for libbpf that would turn this:
> > >
> > > > > > libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section: -2
> > > > > > Error: failed to open BPF object file: No such file or directory
> > > > > > make: *** [Makefile:460: /mnt/linux/tools/testing/selftests/bpf/bpf_cubic.skel.h] Error 255
> > > > > > make: *** Deleting file '/mnt/linux/tools/testing/selftests/bpf/bpf_cubic.skel.h'
> > > > > > make: Leaving directory '/mnt/linux/tools/testing/selftests/bpf'
> > >
> > > Into:
> > >
> > > libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section: -2
> > > HINT: Please update your clang/llvm toolchain to at least cset abcdef123456
> > > HINT: That is where clang started generating BTF information for extern functions in BPF code.
> > >
> > > ?
> > >
> > > :-)
> >
> > I'd rather not :)
>
> Not even a "please update clang?"
>

It could be old clang, it could also be because BPF program wasn't
built with BTF (i.e., you didn't specify -g during clang invocation),
it could probably be due to some other problems as well.

I don't want libbpf to turn into a library that's constantly trying to
guess possible problems. It will become a complete mess to maintain.
And when it will still be wrong sometimes, causing more harm than
being helpful. Especially for relatively uncommon problems like this.

Those people who are trying to use features like BPF unstable helpers
(calling whitelisted kernel functions), should know that they need
Clang of some version and build with BTF. We have that also mentioned
in selftest/bpf/README.rst. I'd rather not duplicate all that in
libbpf code as well.

> "-2" and "Error 255" doesn't seem that helpful :-\

But "failed to find BTF for extern 'tcp_cong_avoid_ai'" is pretty
helpful. -2 is for more involved debugging, if necessary.

>
> - Arnaldo
