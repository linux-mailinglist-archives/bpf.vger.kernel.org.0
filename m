Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A801E2F6AD2
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 20:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbhANTVH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 14:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbhANTVG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 14:21:06 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9652BC061757
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 11:20:26 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v1so3653461pjr.2
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 11:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vfn3VJyLZfDBREd6pk2kWhaeYFaMULYrKp3kOErgYsc=;
        b=Sa1eJWQJEjZ8hUFsyvNGIfVO5E1CXVLBFXJhV89nDarkISkD7C2yhdu4sLN3K8GXd2
         51GG5QAdF3gz0IQH54RWy5Hp3RV/bvo2QP3bcU4zsivOGCb+PAZ4614uZQl5cHOF/w0k
         IlPIYvP2acVIbGhzSaBhJAITPU642nGUYo3iBUic4nWtdPeW5lFCbWqv9vsj8rpTzHfh
         RCqYfpDoykefTDLZhgTv/GyDaRlfYQEclLp03P7S8NLjK7NNFGr9D7lRwC8+xjK1VUOD
         h/ifjh2ODV18k3/S05PTkS5okd6M1RHZNOVBuKNhjgcTnTNf2PphIR2y40IKpvW5dZml
         Ermg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vfn3VJyLZfDBREd6pk2kWhaeYFaMULYrKp3kOErgYsc=;
        b=S2c6De8QaWVRMdn5jtbkrYjltq1NNbIYoRzgA+EJ/5/tYd9Im3Otp5k/4trtyemD0l
         fnisVHsU1Zn79FCEVRmPx3dD3+S476i71xkV2nt0eOX6i8hauBaym08jwKqaiNkPUAOj
         0pOJ+AtcdX5+/+eFu49M9dBe23DBZEnoDtICsWspxB1EVxI0eYAqkGjoDxmxEFdZeBuv
         jagVAxu7CBeSE5RLut8R2E350V+VPuRNAcRXpTsua1P8j4ovn63hyE5pMFZLcGvvGr1n
         xmx/0NC70mop6vo++DJoGJRZYZ2/u663peZXoEAqA1zME1vAU6ysVbQpcl1Yt9J0BiXJ
         QOEQ==
X-Gm-Message-State: AOAM532Xl00YWyo2StzUDrnk57ADxo2eR6abyLTpgHEM2Pb5Xen2zUdV
        F32LrcMPqZRCQxa+jISFHkYDZVtVuzt757OnxYTvxQ==
X-Google-Smtp-Source: ABdhPJzvqdWpkEhDz6Sx3bcXyepg8TTUvdjhz73dopPFFkzMUjycN6oNIhlDXgxsEP6Eu/YPZGHTyZGoG2C5OfV6KuA=
X-Received: by 2002:a17:90a:9915:: with SMTP id b21mr6281896pjp.101.1610652025995;
 Thu, 14 Jan 2021 11:20:25 -0800 (PST)
MIME-Version: 1.0
References: <20201204011129.2493105-1-ndesaulniers@google.com>
 <20201204011129.2493105-3-ndesaulniers@google.com> <CA+icZUVa5rNpXxS7pRsmj-Ys4YpwCxiPKfjc0Cqtg=1GDYR8-w@mail.gmail.com>
 <CA+icZUW6h4EkOYtEtYy=kUGnyA4RxKKMuX-20p96r9RsFV4LdQ@mail.gmail.com>
 <CABtf2+RdH0dh3NyARWSOzig8euHK33h+0jL1zsey9V1HjjzB9w@mail.gmail.com>
 <CA+icZUUtAVBvpU8M0PONnNSiOATgeL9Ym24nYUcRPoWhsQj8Ug@mail.gmail.com>
 <CAKwvOd=+g88AEDO9JRrV-gwggsqx5p-Ckiqon3=XLcx8L-XaKg@mail.gmail.com>
 <CAKwvOdnSx+8snm+q=eNMT4A-VFFnwPYxM=uunRkXdzX-AG4s0A@mail.gmail.com> <5707cd3c-03f2-a806-c087-075d4f207bee@fb.com>
In-Reply-To: <5707cd3c-03f2-a806-c087-075d4f207bee@fb.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Jan 2021 11:20:15 -0800
Message-ID: <CAKwvOdnZW03GaEbSC0Hpg1wb-mniAbT2gBeCwB66+RYAdSr=7Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Kbuild: DWARF v5 support
To:     Yonghong Song <yhs@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Caroline Tice <cmtice@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Nick Clifton <nickc@redhat.com>, bpf <bpf@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 14, 2021 at 11:13 AM Yonghong Song <yhs@fb.com> wrote:
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

Latest is v4: https://lore.kernel.org/lkml/20210113003235.716547-1-ndesaulniers@google.com/

> I think you can add CONFIG_DEBUG_INFO_DWARF5 to kernel with dependency
> of !CONFIG_DEBUG_INFO_BTF. At the same time, people can debug pahole
> issues. Once it is resolved, !CONFIG_DEBUG_INFO_BTF dependency can be
> removed with proper pahole version change in kernel.

SGTM, will send a v5 tomorrow in case there's more feedback.

>
> >
> > FWIW, my distro packages pahole v1.17; rebuilt with ToT v1.19 from
> > source and also observe the issue.
> >
-- 
Thanks,
~Nick Desaulniers
