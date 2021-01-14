Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626E32F6BE1
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 21:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbhANUMv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 15:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbhANUMv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 15:12:51 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1324FC061575
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 12:12:11 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id b19so11246741ioa.9
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 12:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=WB5wr1zDjOj2xrVVEaih6Xat+U2C1D/39T4wbnBt3Vc=;
        b=EYpYVeVJNYW00lqNBb8uNKbbxHD2i7Vijq7DOy81JFSWlNa5xjuaqn0lgHgB6HhMH9
         4BFrB6FWWDd9tir7VZupprYZxuucbgCFAu/Flj5ymipze9DLqZSNZfneXIxlhvueyqVk
         YPtzr4EnF21vIUz7/SjmBszBLEuDFezGN0Ls421aMICiEAndnaLLbdwK0FABDTbFqKBs
         tZij3hQgnh1+Q28kFxjcvsVv494fXLPzxnotkUOcpVopH1uajhhQH/lyRHHTkyD6W3v9
         gYxzj2/+WTrU16wdo8v5MmPMSYR2YEw3LOVZ6T0W8QxX/3xz8U1r8+RzTqoFmprOGUVT
         ATcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=WB5wr1zDjOj2xrVVEaih6Xat+U2C1D/39T4wbnBt3Vc=;
        b=eYocgVfmHuqV0UyjYA13ijN8rzNxfDzBDdC2TyozJUIteQBqlvjR3Lp0fj0qo57TMi
         bPHZhjhU9ITuudWriPT32m8Ocpif/1vHdNjQBso3YTA+XPXsvE2zLWaWyAuGtb6SY1LQ
         rv+3n+ZKuA5fM73XXzEbVUaHhD/slLCyKm4llQRHEAiMq/8+x5h2NBFjJGtVLDD6j1M7
         bYgiSZx2thM6kqf+PsBwxYFZO1uIBSlfOtYzuFvtT1jJYnpZXTsfGr9EGzVWd1ZiD5D4
         7R4APQMuESkd0WSUWWcFg7KtBRhx4S1VPmvJlKA736kLSjhpoygGSuI9dG6KTWkvopEu
         DVzQ==
X-Gm-Message-State: AOAM533SnGkfogVtjUPIOdDFNgRX/ZIgn37ZgTdX0oJz+lstrq5DgMGm
        +GGjGwnYKzTkVqGXMYyMGJpd4PdfSLZr3ekRbPE=
X-Google-Smtp-Source: ABdhPJzVZwhceppXvr2x5BMUOLTlbJR6kN6FiUKflXD744br8qvFgk4JjoKtxhx40Jl0BvaMUn4QNbJ//NpcZGoLfAU=
X-Received: by 2002:a05:6638:296:: with SMTP id c22mr7770161jaq.65.1610655130404;
 Thu, 14 Jan 2021 12:12:10 -0800 (PST)
MIME-Version: 1.0
References: <20201204011129.2493105-1-ndesaulniers@google.com>
 <20201204011129.2493105-3-ndesaulniers@google.com> <CA+icZUVa5rNpXxS7pRsmj-Ys4YpwCxiPKfjc0Cqtg=1GDYR8-w@mail.gmail.com>
 <CA+icZUW6h4EkOYtEtYy=kUGnyA4RxKKMuX-20p96r9RsFV4LdQ@mail.gmail.com>
 <CABtf2+RdH0dh3NyARWSOzig8euHK33h+0jL1zsey9V1HjjzB9w@mail.gmail.com>
 <CA+icZUUtAVBvpU8M0PONnNSiOATgeL9Ym24nYUcRPoWhsQj8Ug@mail.gmail.com>
 <CAKwvOd=+g88AEDO9JRrV-gwggsqx5p-Ckiqon3=XLcx8L-XaKg@mail.gmail.com>
 <CAKwvOdnSx+8snm+q=eNMT4A-VFFnwPYxM=uunRkXdzX-AG4s0A@mail.gmail.com> <5707cd3c-03f2-a806-c087-075d4f207bee@fb.com>
In-Reply-To: <5707cd3c-03f2-a806-c087-075d4f207bee@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 14 Jan 2021 21:11:59 +0100
Message-ID: <CA+icZUXuzJ4SL=AwTaVq_-tCPnSSrF+w_P8gEKYnT56Ln0Zoew@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Kbuild: DWARF v5 support
To:     Yonghong Song <yhs@fb.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Caroline Tice <cmtice@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Nick Clifton <nickc@redhat.com>, bpf <bpf@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 14, 2021 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 1/14/21 11:01 AM, Nick Desaulniers wrote:
> > On Thu, Jan 14, 2021 at 10:53 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> >>
> >> On Wed, Jan 13, 2021 at 10:18 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>>
> >>> On Wed, Jan 13, 2021 at 11:25 PM Caroline Tice <cmtice@google.com> wrote:
> >>>>
> >>>> On Tue, Jan 12, 2021 at 3:17 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>>>>
> >>>>> Unfortunately, I see with CONFIG_DEBUG_INFO_DWARF5=y and
> >>>>> CONFIG_DEBUG_INFO_BTF=y:
> >>>>>
> >>>>> die__process_inline_expansion: DW_TAG_INVALID (0x48) @ <0x3f0dd5a> not handled!
> >>>>> die__process_function: DW_TAG_INVALID (0x48) @ <0x3f0dd69> not handled!
> >>
> >> I can confirm that I see a stream of these warnings when building with
> >> this patch series applied, and those two configs enabled.
> >>
> >> rebuilding with `make ... V=1`, it looks like the call to:
> >>
> >> + pahole -J .tmp_vmlinux.btf
> >>
> >> is triggering these.
> >>
> >> Shall I send a v4 that adds a Kconfig dependency on !DEBUG_INFO_BTF?
> >> Does pahole have a bug tracker?
>
> pahole could have issues for dwarf5 since as far as I know, people just
> use dwarf2/dwarf4 with config functions in the kernel.
>
> Where is the link of the patch to add CONFIG_DEBUG_INFO_DWARF5 to linux?
> I think you can add CONFIG_DEBUG_INFO_DWARF5 to kernel with dependency
> of !CONFIG_DEBUG_INFO_BTF. At the same time, people can debug pahole
> issues. Once it is resolved, !CONFIG_DEBUG_INFO_BTF dependency can be
> removed with proper pahole version change in kernel.
>

Yeah, sounds like a good idea.

- Sedat -

> >
> > FWIW, my distro packages pahole v1.17; rebuilt with ToT v1.19 from
> > source and also observe the issue.
> >
