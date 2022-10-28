Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C874611C76
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 23:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJ1VgN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 17:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJ1VgK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 17:36:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0541CFC6A
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 14:36:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id a13so9733404edj.0
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 14:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H6/XYOV7Ku38jt2/qM9e7cMh6gi4qcZRapX4yoew69g=;
        b=QFfwbcHC/6mOjBnZTucW+NTcjq7qEclPtok3d4mUWPTdPz5tzp30zCYycryMMUSot+
         dbsrnLfmZv/+c6OtlxJ4GTwpEh7b0wNPQHzYFZ+iKMLOAd7Sw5Ay906+Mjf5Hk7TZtYQ
         pS4lyf8uXksvHvJzqMdSe7xzjAI/S/z5jJypIdk/NaV9HTOCpgbvZFQNbob1y6tInuT8
         BxGxb80Th+NMVdlhPaRzV3DtmdZ9Npobj9dge2z6wGB7nmNPCrvdlZ3cd5yMA+GBluml
         vQTiw0w4r06woy/rDZv+wolbSnVslVWUAeph3EFENqAS0Izh+F7ldCXoBxjcRc8A7VPL
         bR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6/XYOV7Ku38jt2/qM9e7cMh6gi4qcZRapX4yoew69g=;
        b=4Zt7pmVq125cQXOr1PjZv+z1tAxjchU0ynh5Xm3H42iE+FSIA6AGAGdM+ie4B4ODQQ
         o921ZR3usYBzMDDx28w1/R86QGbV5E/gi73fUMyxvwmeylG9NyIUu8HoA1QQK31prJt1
         LCpVQU7Yd8rpt1BbTnJFyJEYSdggaSmbLU2S1i2r9EX2y1ZPEH4pvGm6PxbPg7Lais4w
         KKDg72SwJtQExa3wQ+6H6k5teMSg7mROiRITM8lb0VDz2vyxNG9DIz++UsYlE5AyWwER
         QMgeTUEOMvZfg0rBVWOMqeVXrb7GwlkGfvqLycQ3eFKTmxMqUv3sjgNr6bqiCYMIXtJo
         Bo5A==
X-Gm-Message-State: ACrzQf3g2gTDuR00qwo8xDdCkCr1ckg9w4FQits0BvJZE6sVlMs4dntX
        Sq88/SK9ZwVUBnehDjqMNpLemdlHWeD6RCNITUY=
X-Google-Smtp-Source: AMsMyM54o/Tn5pmWbUQyob2kQvzVIoUA1DPR+yudXzF+ZnKV7soyvkNXPgOzR1lcz2NQvG2oLrnqOucN4ydhSzk0PEI=
X-Received: by 2002:aa7:de9a:0:b0:44d:8191:44c5 with SMTP id
 j26-20020aa7de9a000000b0044d819144c5mr1389320edv.232.1666992963589; Fri, 28
 Oct 2022 14:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221025222802.2295103-1-eddyz87@gmail.com> <CAEf4BzbScntAd4Yh5AWw+7bZhooYYaomwLYiuM0+iBtx_7LKoQ@mail.gmail.com>
 <f62834eb-fd3f-ba55-2cec-c256c328926e@meta.com> <CAEf4BzYT4pwmw64DaCTxR3_QjO5RRVadqVLO0h-hNa-+xOyLZw@mail.gmail.com>
 <af1facf9-7bc8-8a3d-0db4-7b3f333589a2@meta.com>
In-Reply-To: <af1facf9-7bc8-8a3d-0db4-7b3f333589a2@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 28 Oct 2022 14:35:51 -0700
Message-ID: <CAEf4BzZE7boex4KBjMmhJ4Nib6BA71-pf5jiAg74FjEdr_2e6A@mail.gmail.com>
Subject: Re: [RFC bpf-next 00/12] Use uapi kernel headers with vmlinux.h
To:     Yonghong Song <yhs@meta.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, yhs@fb.com, arnaldo.melo@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 28, 2022 at 11:57 AM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 10/28/22 10:13 AM, Andrii Nakryiko wrote:
> > On Thu, Oct 27, 2022 at 6:33 PM Yonghong Song <yhs@meta.com> wrote:
> >>
> >>
> >>
> >> On 10/27/22 4:14 PM, Andrii Nakryiko wrote:
> >>> On Tue, Oct 25, 2022 at 3:28 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> >>>>
> >>>> Hi BPF community,
> >>>>
> >>>> AFAIK there is a long standing feature request to use kernel headers
> >>>> alongside `vmlinux.h` generated by `bpftool`. For example significant
> >>>> effort was put to add an attribute `bpf_dominating_decl` (see [1]) to
> >>>> clang, unfortunately this effort was stuck due to concerns regarding C
> >>>> language semantics.
> >>>>
> >>>
> >>> Maybe we should make another attempt to implement bpf_dominating_decl?
> >>> That seems like a more elegant solution than any other implemented or
> >>> discussed alternative. Yonghong, WDYT?
> >>
> >> I would say it would be very difficult for upstream to agree with
> >> bpf_dominating_decl. We already have lots of discussions and we
> >> likely won't be able to satisfy Aaron who wants us to emit
> >> adequate diagnostics which will involve lots of other work
> >> and he also thinks this is too far away from C standard and he
> >> wants us to implement in a llvm/clang tool which is not what
> >> we want.
> >
> > Ok, could we change the problem to detecting if some type is defined.
> > Would it be possible to have something like
> >
> > #if !__is_type_defined(struct abc)
> > struct abc {
> > };
> > #endif
> >
> > I think we talked about this and there were problems with this
> > approach, but I don't remember details and how insurmountable the
> > problem is. Having a way to check whether some type is defined would
> > be very useful even outside of -target bpf parlance, though, so maybe
> > it's the problem worth attacking?
>
> Yes, we discussed this before. This will need to add additional work
> in preprocessor. I just made a discussion topic in llvm discourse
>
> https://discourse.llvm.org/t/add-a-type-checking-macro-is-type-defined-type/66268
>
> Let us see whether we can get some upstream agreement or not.
>

Thanks for starting the conversation! I'll be following along.

> >
> >>
> >>>
> >>> BTW, I suggest splitting libbpf btf_dedup and btf_dump changes into a
> >>> separate series and sending them as non-RFC sooner. Those improvements
> >>> are independent of all the header guards stuff, let's get them landed
> >>> sooner.
> >>>
> >>>> After some discussion with Alexei and Yonghong I'd like to request
> >>>> your comments regarding a somewhat brittle and partial solution to
> >>>> this issue that relies on adding `#ifndef FOO_H ... #endif` guards in
> >>>> the generated `vmlinux.h`.
> >>>>
> >>>
> >>> [...]
> >>>
> >>>> Eduard Zingerman (12):
> >>>>     libbpf: Deduplicate unambigous standalone forward declarations
> >>>>     selftests/bpf: Tests for standalone forward BTF declarations
> >>>>       deduplication
> >>>>     libbpf: Support for BTF_DECL_TAG dump in C format
> >>>>     selftests/bpf: Tests for BTF_DECL_TAG dump in C format
> >>>>     libbpf: Header guards for selected data structures in vmlinux.h
> >>>>     selftests/bpf: Tests for header guards printing in BTF dump
> >>>>     bpftool: Enable header guards generation
> >>>>     kbuild: Script to infer header guard values for uapi headers
> >>>>     kbuild: Header guards for types from include/uapi/*.h in kernel BTF
> >>>>     selftests/bpf: Script to verify uapi headers usage with vmlinux.h
> >>>>     selftests/bpf: Known good uapi headers for test_uapi_headers.py
> >>>>     selftests/bpf: script for infer_header_guards.pl testing
> >>>>
> >>>>    scripts/infer_header_guards.pl                | 191 +++++
> >>>>    scripts/link-vmlinux.sh                       |  13 +-
> >>>>    tools/bpf/bpftool/btf.c                       |   4 +-
> >>>>    tools/lib/bpf/btf.c                           | 178 ++++-
> >>>>    tools/lib/bpf/btf.h                           |   7 +-
> >>>>    tools/lib/bpf/btf_dump.c                      | 232 +++++-
> >>>>    .../selftests/bpf/good_uapi_headers.txt       | 677 ++++++++++++++++++
> >>>>    tools/testing/selftests/bpf/prog_tests/btf.c  | 152 ++++
> >>>>    .../selftests/bpf/prog_tests/btf_dump.c       |  11 +-
> >>>>    .../bpf/progs/btf_dump_test_case_decl_tag.c   |  39 +
> >>>>    .../progs/btf_dump_test_case_header_guards.c  |  94 +++
> >>>>    .../bpf/test_uapi_header_guards_infer.sh      |  33 +
> >>>>    .../selftests/bpf/test_uapi_headers.py        | 197 +++++
> >>>>    13 files changed, 1816 insertions(+), 12 deletions(-)
> >>>>    create mode 100755 scripts/infer_header_guards.pl
> >>>>    create mode 100644 tools/testing/selftests/bpf/good_uapi_headers.txt
> >>>>    create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
> >>>>    create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_header_guards.c
> >>>>    create mode 100755 tools/testing/selftests/bpf/test_uapi_header_guards_infer.sh
> >>>>    create mode 100755 tools/testing/selftests/bpf/test_uapi_headers.py
> >>>>
> >>>> --
> >>>> 2.34.1
> >>>>
