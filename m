Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55BB30EC92
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 07:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhBDGk5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 01:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhBDGk4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 01:40:56 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CB6C061573;
        Wed,  3 Feb 2021 22:40:16 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id f67so294401ioa.1;
        Wed, 03 Feb 2021 22:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=3VNI9tGYEVxD6gbVlYfkwUu1nyjdz0zo7SwnsJNpC9w=;
        b=pCguadYVXzDK1uWiUP9tIlcU2WZOwpa188xzMbb3F7zAyERtUnUodgRrAvGyVmUgub
         tC1/HdSks8+pQkBUZrTjr/Em4QoPR5T9ixz+mWcJQ4RRTEeSBzg1NNi10lv5DyhfK8VY
         diO1Tnv9fJV3fC4w2GPFcya/c2hwv47/Kh7OHABM6SoEC7jACzKA4LXJ9f33VG+5HyNd
         76SBHXVEp3Ls8Otxe8h15o98AYWq5bXstXSDYlpj1uWtfkBy05wu6I5MoGhXH+BWVNYE
         VrR3vLpj/try2KUrXWWFUYeYB7potCJh0wShERigIcp+uwRx/9/rSfTHOR5SM/Q1S9qy
         uv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=3VNI9tGYEVxD6gbVlYfkwUu1nyjdz0zo7SwnsJNpC9w=;
        b=OBfXxg7vGkUdGWIgovuavo8PoxXRbZ2mn9+hbuAbxfAroWYRNeRrGrK4ao+JnG3oxD
         F75f39fGK8niNxC+oh+xhS9PjWRY212cM+73jjsfkJ36GmbpwhX6ssKeRlo3D/XJvNNw
         EGUm5sIaRYrev+yfUrGD2cvWqmn2WULxWFCvc/bYV7WTfq5JnVAycxjkcDGSHvbP/kcm
         +Q4SwRgU6rGJjrxDauakwStUJvaOCxdW0LUKCqMnBdxXDiD/sgMD72Awuj2x4B0DOtkM
         g/qNlqgEJBKrTlCRTTqNN4U+4/phg+ZCPJQDlpESHvCBuS/VThM9HcUhY3g8dyrsV89g
         VTrQ==
X-Gm-Message-State: AOAM532uT6zAJgzFxUwr+Qu+1qx+e7+wNxmr3UF4bij7Ti/Mtr3nnKPf
        jVlhuarXqW1Z9soKJxemYVSm19Bf6ahsvJrTLmU=
X-Google-Smtp-Source: ABdhPJwd6H00NVHQjCUVmCcWlbp2FAc/99e7JOicrwhlEMJFCcaUbLAsCxNhcvfXa0tSlMNG80u3w+MgNiqAk3r1NKo=
X-Received: by 2002:a05:6602:2b01:: with SMTP id p1mr5616057iov.156.1612420815856;
 Wed, 03 Feb 2021 22:40:15 -0800 (PST)
MIME-Version: 1.0
References: <20210112184004.1302879-1-jolsa@kernel.org> <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
 <20210121133825.GB12699@kernel.org> <CA+icZUVsdcTEJjwpB7=05W5-+roKf66qTwP+M6QJKTnuP6TOVQ@mail.gmail.com>
 <CAEf4BzaVAp=W47KmMsfpj_wuJR-Gvmav=tdKdoHKAC3AW-976w@mail.gmail.com>
 <CA+icZUW6g9=sMD3hj5g+ZXOwE_DxfxO3SX2Tb-bFTiWnQLb_EA@mail.gmail.com>
 <CAEf4BzZ-uU3vkMA1RPt1f2HbgaHoenTxeVadyxuLuFGwN9ntyw@mail.gmail.com>
 <20210128200046.GA794568@kernel.org> <CAEf4BzbXhn2qAwNyDx6Oqaj7+RdBtjnPPLe27=B0-aB9yY+Xmw@mail.gmail.com>
 <CA+icZUUTddV18rhZjaVif0a6BgpWtpj4mP1pyQ9cfh_e2xxvMQ@mail.gmail.com>
 <95233b493fd29b613f5bf3f92419528ce3298c14.camel@klomp.org>
 <CA+icZUU+XEMnrwgOSRhAaO1bn2p62P6g1KVKGyJfRqxt_jr0Ew@mail.gmail.com> <CAEf4Bzay-MS9mKc7N9Kc-eQBv1U5DomOY4VoBW=BQZaqs3f0kg@mail.gmail.com>
In-Reply-To: <CAEf4Bzay-MS9mKc7N9Kc-eQBv1U5DomOY4VoBW=BQZaqs3f0kg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 4 Feb 2021 07:40:04 +0100
Message-ID: <CA+icZUWz1JYC4h4TewsqVpuC6oMpSFFZsWo6ycd57LOdYPWD6w@mail.gmail.com>
Subject: Re: [RFT] pahole 1.20 RC was Re: [PATCH] btf_encoder: Add extra
 checks for symbol names
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Mark Wielaard <mark@klomp.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Tom Stellard <tstellar@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 4, 2021 at 12:22 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Feb 3, 2021 at 1:48 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Wed, Feb 3, 2021 at 11:23 AM Mark Wielaard <mark@klomp.org> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, 2021-02-03 at 10:03 +0100, Sedat Dilek wrote:
> > > > > It all looks to be working fine on my side. There is a compilation
> > > > > error in our libbpf CI when building the latest pahole from sources
> > > > > due to DW_FORM_implicit_const being undefined. I'm updating our VMs to
> > > > > use Ubuntu Focal 20.04, up from Bionic 18.04, and that should
> > > > > hopefully solve the issue due to newer versions of libdw. If you worry
> > > > > about breaking others, though, we might want to add #ifndef guards and
> > > > > re-define DW_FORM_implicit_const as 0x21 explicitly in pahole source
> > > > > code.
> > >
> > > I think that might be a good idea for older setups. But that also means
> > > that the underlying elfutils libdw doesn't support DWARF5, so pahole
> > > itself also wouldn't work (the define would only fix the compile time
> > > issue, not the runtime issue of not being able to parse
> > > DW_FORM_implicit_const). That might not be a problem because such
> > > systems also wouldn't have GCC11 defaulting to DWARF5.
> > >
> > > > > But otherwise, all good from what I can see in my environment.
> > > > > Looking
> > > > > forward to 1.20 release! I'll let you know if, after updating to
> > > > > Ubuntu Focal, any new pahole issues crop up.
> > > > >
> > > >
> > > > Last weekend I did some testing with
> > > > <pahole.git#DW_AT_data_bit_offset> and DWARF-v5 support for the
> > > > Linux-kernel.
> > > >
> > > > The good: I was able to compile :-).
> > > > The bad: My build-log grew up to 1.2GiB and I could not boot in QEMU.
> > > > The ugly: I killed the archive which had all relevant material.
> > >
> > > I think the build-log grew so much because of warnings about unknown
> > > tags. At least when using GCC11 you'll get a couple of standardized
> > > DWARF5 tags instead of the GNU extensions to DWARF4. That should be
> > > solved by:
> > >
> > >    commit d783117162c0212d4f75f6cea185f493d2f244e1
> > >    Author: Mark Wielaard <mark@klomp.org>
> > >    Date:   Sun Jan 31 01:27:31 2021 +0100
> > >
> > >        dwarf_loader: Handle DWARF5 DW_TAG_call_site like DW_TAG_GNU_call_site
> > >
> >
> > I had some conversation with Mark directly as I dropped by accident the CC list.
> >
> > With latest pahole from Git and CONFIG_DEBUG_INFO_BTF=y I was not able
> > to build with DWARF-v4 and DWARF-v5.
>
> There is hardly anything actionable without all the extra info I've
> asked you before. What's the issue? What's the kernel config? Tool
> versions?
>
> >
> > Hope it is OK for you Mark when I quote you:
> >
> > > Here I use LLVM/Clang v12.0.0-rc1 with Clang's Integrated Assembler
> > > (make LLVM_IAS=1).
> >
> > Note I haven't personally tested llvm with DWARF5. I know some other
> > tools cannot (yet) handle the DWARF5 produced by llvm (for example
> > valgrind, rpm debugedit and dwz don't handle all the forms llvm emits
> > when it produces DWARF5, which aren't emitted by GCC unless requesting
> > split-dwarf). In theory dwarves/pahole should be able to handle it
> > because elfutils libdw (at least versions > 0.172) does handle it. But
> > I don't know if anybody ever tested that. But I believe llvm will by
> > default emit DWARF4, not 5.
> >
> > More quotes from Mark:
> >
> > I would try to avoid using clang producing DWARF5. It clearly has some
> > incompatibilities with dwarves/pahole. It should work if you don't set
> > DEBUG_INFO_DWARF5. Try GCC 11 (which defaults to -gdwarf-5) or an
> > earlier version (probably at least GCC 8 or higher) using -gdwarf-5
> > explicitly.
> >
> > What makes me nerves are reports from Red Hat's CKI reporting:
> >
> > 'failed to validate module [something] BTF: -22 '
> >
> > This is was from ClangBuiltLinux mailing-list.
>
> And no link to the issue, of course. If you are hoping for someone to
> try to help and fix issues, please provide extra info. If this is what
> I think it is, that was the problem with kernel rejecting empty BTF
> and it was fixed already in v5.11-fbk6. But who knows, I can only
> guess.
>

"Do one thing and do it well."
( Unix philosophy )

https://en.wikipedia.org/wiki/Unix_philosophy#Do_One_Thing_and_Do_It_Well

Yesterday, I did two things in parallel.
( I had some other stuff to dig into which is fixed for me. )

As for fun I will do a new test with <pahole.git#tmp.1.20>.

I will attach kernel-config and BTF/pahole warnings.

For the ClangBuiltLinux mailing-list link:
I have asked on the list to have the links so that people from
outlands can read them.

"Just for fun" (IMHO that is the title of Linus Torvalds' biographie :-)?)

- Sedat -

> >
> > Looks like CONFIG_DEBUG_INFO_BTF=y makes troubles with LLVM/Clang.
> > Can we have a fix for Linux v5.11-rc6+ to avoid a selection of it when
> > CC_IS_CLANG=y?
>
> Let's first understand problems and try to fix them, please.
>
> >
> > - Sedat -
> >
> >
> > - Sedat -
