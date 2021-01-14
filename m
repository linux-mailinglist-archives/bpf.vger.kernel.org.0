Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4852F6BE2
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 21:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbhANUNo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 15:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbhANUNo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 15:13:44 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2620C061575
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 12:13:03 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id u17so13825689iow.1
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 12:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=erIA/lSh4mbluHxm/ANIO8rRbgUM63xnChvxcoG6rx0=;
        b=X208WmP2OYiY/uZRl2VbmbBaGJolET1+r7frr8XJmHOEPfAYBFSEYHH9YHakyXZZ0H
         Vpvb/m+CZTio+qLE2luJ55e2mXuRCcQGcFNJPHS++5H41LeWKXp0WEeQdUipF7PVo6k7
         YGurqkot9wVEQzp0Jp5Wugpm6ZNdPMv+hNKsllnV8H6ByySjeSKfAX6Dk56e/U1vCGbu
         C+Y8NS9QzaPnqvEghgl5gUu/iBt6zXjryCu2GQ4JD6NZvUrFZeYzxzSwy1CA/49ID/PX
         3VYSKxZrqUj2Yo1QYn7Oe0TmSF+eksbW6xqQ5NlcWuIOToePh1VpzlcjnxvTOWumGUtq
         Zkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=erIA/lSh4mbluHxm/ANIO8rRbgUM63xnChvxcoG6rx0=;
        b=ajA6NL7IfqrFbhg3A7HdswYEIxu41UbHHj+Y+eE1AVjDc5695/7B3ArsrOXIPMBSRx
         ihxxQp9oCnl/eiAbgP79iOcWMhYuTSsSbdWnefG9E08H1vfTTjApDa/rwAUdVjjzg8F6
         Mx7lHGY+ahygG+HAwwPYkN7/MIc1/F+mQRCDepWYA6v024Y71pclh9muwE447Y7Hh+bt
         /FeBMCUGgIe4FvC107yelsBR0DrHR+8lEynwK+sRivKMx9cxKhS8vh1fqlbIC3RCIAfL
         5Zt7SBNffZO3aJmkb8rHHxCFEB3G4y+5Uk1u3ZkjE13HlCoguCQZea2mCJuxl3SUUyGz
         RJyQ==
X-Gm-Message-State: AOAM533WMdCwtSuVDtxAsL259jlr9YobiB1rOlQaaJUtgggbDkMHtczb
        Ubq+O9GEikEvoB8P150XkpdqtHQZGI2RrpnwZtI=
X-Google-Smtp-Source: ABdhPJxcpqhBvUCALwcsXnMrd54uB8EaZQpVnCNFIuOAZoyN2C+4sWaln/u+h2IPuzRaFUI89pCrs0+LoCob5+bbAGY=
X-Received: by 2002:a92:c692:: with SMTP id o18mr8296573ilg.215.1610655182714;
 Thu, 14 Jan 2021 12:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20201204011129.2493105-1-ndesaulniers@google.com>
 <20201204011129.2493105-3-ndesaulniers@google.com> <CA+icZUVa5rNpXxS7pRsmj-Ys4YpwCxiPKfjc0Cqtg=1GDYR8-w@mail.gmail.com>
 <CA+icZUW6h4EkOYtEtYy=kUGnyA4RxKKMuX-20p96r9RsFV4LdQ@mail.gmail.com>
 <CABtf2+RdH0dh3NyARWSOzig8euHK33h+0jL1zsey9V1HjjzB9w@mail.gmail.com>
 <CA+icZUUtAVBvpU8M0PONnNSiOATgeL9Ym24nYUcRPoWhsQj8Ug@mail.gmail.com>
 <CAKwvOd=+g88AEDO9JRrV-gwggsqx5p-Ckiqon3=XLcx8L-XaKg@mail.gmail.com>
 <CAKwvOdnSx+8snm+q=eNMT4A-VFFnwPYxM=uunRkXdzX-AG4s0A@mail.gmail.com>
 <5707cd3c-03f2-a806-c087-075d4f207bee@fb.com> <CAKwvOdnZW03GaEbSC0Hpg1wb-mniAbT2gBeCwB66+RYAdSr=7Q@mail.gmail.com>
In-Reply-To: <CAKwvOdnZW03GaEbSC0Hpg1wb-mniAbT2gBeCwB66+RYAdSr=7Q@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 14 Jan 2021 21:12:51 +0100
Message-ID: <CA+icZUWUJzG1XcFosgDHmyCaWdCwk8hT8xedQMW66k9Y39YbMA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Kbuild: DWARF v5 support
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Yonghong Song <yhs@fb.com>, Jiri Olsa <jolsa@kernel.org>,
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

On Thu, Jan 14, 2021 at 8:20 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Jan 14, 2021 at 11:13 AM Yonghong Song <yhs@fb.com> wrote:
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
>
> Latest is v4: https://lore.kernel.org/lkml/20210113003235.716547-1-ndesaulniers@google.com/
>
> > I think you can add CONFIG_DEBUG_INFO_DWARF5 to kernel with dependency
> > of !CONFIG_DEBUG_INFO_BTF. At the same time, people can debug pahole
> > issues. Once it is resolved, !CONFIG_DEBUG_INFO_BTF dependency can be
> > removed with proper pahole version change in kernel.
>
> SGTM, will send a v5 tomorrow in case there's more feedback.
>

Please CC me on v5.

Feel free to add my Reported-by.

- Sedat -

> >
> > >
> > > FWIW, my distro packages pahole v1.17; rebuilt with ToT v1.19 from
> > > source and also observe the issue.
> > >
> --
> Thanks,
> ~Nick Desaulniers
