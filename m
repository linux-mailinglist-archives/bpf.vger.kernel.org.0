Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729DC2F6D8A
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 22:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbhANVxh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 16:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbhANVxf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 16:53:35 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1599C061575
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 13:52:54 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id q1so14275223ion.8
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 13:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=25UGyailuGkSlV0rEAoFPYluemtWcBTnklauhq8H0ck=;
        b=N1graEbZFfiWEd2Yl780jQH/sTD70P8lgY8ZwyRUE7r/dEpF3EOp0SmgelThj0Qe76
         EIhGa1MBqaTYBUMDx34ODBuiGOqkXvp/jUxX6Lh6mDvUDTczocbFrrBzMCg6NstCnKmT
         ps3AxZB0wIAA3dm3ZPWna7VJNl7urvLGZ0xNY3HXFt6pPlD+6mz2qPiopThTQFIqZDGr
         /pXHTx0FPj1KUfXrRLfQt4WS+GeGkQvwhza5qizKLZDj9Fsl714DmtfnY4O/pvKROrPV
         GtUmCR9lYZN9yX9l855A3UK478UwlkZVKJmXBGx5TEoQhpbQBXEquIuNSyHb5BW2iVAp
         yWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=25UGyailuGkSlV0rEAoFPYluemtWcBTnklauhq8H0ck=;
        b=SY6rL0J2TOevhNklKfAEPCZwixr5ONBEr3yG0lkgR3pd6yzt/niGTeF1wfuy0kzN4p
         OklopIU4EmUTHAskp5PP2twqlObiVDRyqDb/2awvf15rtwf7zD0zZJ6EthCvFneJUmPI
         A2iLBhsepsyDsfGnPLcgf0+RZQYaijbKGigR1fHeRtXe+yC7k+QtuDf+bL6CHXktuc+n
         3lgp35cz1POd6rkkR+3Mma1UqN5oAZPOtsuWCcBIhL2zJjhd6HKHkvUSxMv+juAE44jc
         1AQLuxTIyntELR6ABqSV+0t/+w96ABQahdGLjsAKTG0yyU1f2QIcq3cY8avwe1nrrTls
         oYsw==
X-Gm-Message-State: AOAM531ReXdyq2b6K2JiyYhevGFHiq9SdFlcvOdEzweYRNNcGwJ8sZKL
        Km551CHRRjaO1piC8/vVfU+HprKlvYZUmvUWEPc=
X-Google-Smtp-Source: ABdhPJyAT2jWT+u7Yqqd//3BLiGQiACkWSaJUa7ivIwhLe+anx/kPh10FBNju+yc5+LJ8nfj79c9wPgDQHgHtNZB6mg=
X-Received: by 2002:a92:d990:: with SMTP id r16mr8530650iln.10.1610661173930;
 Thu, 14 Jan 2021 13:52:53 -0800 (PST)
MIME-Version: 1.0
References: <20201204011129.2493105-1-ndesaulniers@google.com>
 <20201204011129.2493105-3-ndesaulniers@google.com> <CA+icZUVa5rNpXxS7pRsmj-Ys4YpwCxiPKfjc0Cqtg=1GDYR8-w@mail.gmail.com>
 <CA+icZUW6h4EkOYtEtYy=kUGnyA4RxKKMuX-20p96r9RsFV4LdQ@mail.gmail.com>
 <CABtf2+RdH0dh3NyARWSOzig8euHK33h+0jL1zsey9V1HjjzB9w@mail.gmail.com>
 <CA+icZUUtAVBvpU8M0PONnNSiOATgeL9Ym24nYUcRPoWhsQj8Ug@mail.gmail.com>
 <CAKwvOd=+g88AEDO9JRrV-gwggsqx5p-Ckiqon3=XLcx8L-XaKg@mail.gmail.com>
 <CAKwvOdnSx+8snm+q=eNMT4A-VFFnwPYxM=uunRkXdzX-AG4s0A@mail.gmail.com>
 <5707cd3c-03f2-a806-c087-075d4f207bee@fb.com> <CA+icZUXuzJ4SL=AwTaVq_-tCPnSSrF+w_P8gEKYnT56Ln0Zoew@mail.gmail.com>
In-Reply-To: <CA+icZUXuzJ4SL=AwTaVq_-tCPnSSrF+w_P8gEKYnT56Ln0Zoew@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 14 Jan 2021 22:52:41 +0100
Message-ID: <CA+icZUXQ5bNX0eX7jEhgTMawdctZ4vkmYoRKDgxEMV5ZKp8YaQ@mail.gmail.com>
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

On Thu, Jan 14, 2021 at 9:11 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Thu, Jan 14, 2021 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 1/14/21 11:01 AM, Nick Desaulniers wrote:
> > > On Thu, Jan 14, 2021 at 10:53 AM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > >>
> > >> On Wed, Jan 13, 2021 at 10:18 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >>>
> > >>> On Wed, Jan 13, 2021 at 11:25 PM Caroline Tice <cmtice@google.com> wrote:
> > >>>>
> > >>>> On Tue, Jan 12, 2021 at 3:17 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >>>>>
> > >>>>> Unfortunately, I see with CONFIG_DEBUG_INFO_DWARF5=y and
> > >>>>> CONFIG_DEBUG_INFO_BTF=y:
> > >>>>>
> > >>>>> die__process_inline_expansion: DW_TAG_INVALID (0x48) @ <0x3f0dd5a> not handled!
> > >>>>> die__process_function: DW_TAG_INVALID (0x48) @ <0x3f0dd69> not handled!
> > >>
> > >> I can confirm that I see a stream of these warnings when building with
> > >> this patch series applied, and those two configs enabled.
> > >>
> > >> rebuilding with `make ... V=1`, it looks like the call to:
> > >>
> > >> + pahole -J .tmp_vmlinux.btf
> > >>
> > >> is triggering these.
> > >>
> > >> Shall I send a v4 that adds a Kconfig dependency on !DEBUG_INFO_BTF?
> > >> Does pahole have a bug tracker?
> >
> > pahole could have issues for dwarf5 since as far as I know, people just
> > use dwarf2/dwarf4 with config functions in the kernel.
> >
> > Where is the link of the patch to add CONFIG_DEBUG_INFO_DWARF5 to linux?
> > I think you can add CONFIG_DEBUG_INFO_DWARF5 to kernel with dependency
> > of !CONFIG_DEBUG_INFO_BTF. At the same time, people can debug pahole
> > issues. Once it is resolved, !CONFIG_DEBUG_INFO_BTF dependency can be
> > removed with proper pahole version change in kernel.
> >
>
> Yeah, sounds like a good idea.
>

Today, I have observed and reported (see [1]) bpf/btf/pahole issues
with Clang v12 (from apt.llvm.org) and DWARF-4 ("four").
Cannot speak for other compilers and its version.

- Sedat -

[1] https://lore.kernel.org/bpf/CA+icZUWb3OyaSQAso8LhsRifZnpxAfDtuRwgB786qEJ3GQ+kRw@mail.gmail.com/T/#m6d05cc6c634e9cee89060b2522abc78c3705ea4c


>
> > >
> > > FWIW, my distro packages pahole v1.17; rebuilt with ToT v1.19 from
> > > source and also observe the issue.
> > >
