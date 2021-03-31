Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51ACF34F750
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 05:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhCaDRF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 23:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbhCaDQ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Mar 2021 23:16:56 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5D4C061574;
        Tue, 30 Mar 2021 20:16:55 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q10so1978657pgj.2;
        Tue, 30 Mar 2021 20:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wCq5vB6nRa7iBw/LoHkKmtXlXNSByG8GYyz4XsDrmt0=;
        b=ddjguVU93v8nkcjmb9Syz7DHhAJRZN+t12cemOS+OjCcjTnEe+mOUds24iKqlt12gM
         djTadXDCIhLkcTAA1NyElH8JlDgwv05ozx50QwkwtIAry2iEsNOXTisAaVr2EbqxFAOq
         MfpuZciI0MKtHOo/c2mPEE4WvzYjeeA910+4xOTcXUF3lmx3nIvskV48S3K+vZGoLXs4
         MIv2N5NiD9Cx2FVc1k+hXrFFlhSScK1aRR5utG6OdkavTPhmNytg9RKZt5nx3V80iyRD
         CBlU8p7kIKuJehCxDazGNL3cwO2/wA6ZOrcu9H+upJnXYsf11M+RO0yAM6x9U7qy0wv2
         1mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wCq5vB6nRa7iBw/LoHkKmtXlXNSByG8GYyz4XsDrmt0=;
        b=QIrOrflTd0jP+mI+6MGQyszXwxgBB6tCkTLSpxYXkLWoC+pNyQ8Cc7Xw8uvD/NBU9C
         WpsiWFG9gVE9LjjqKSBy7zhEv/WYvZcabSYBChwONBm/PBgEUYcr+Q1h/zgHg5PJq5RX
         dM6pe4crbKMwyK+ZAaAUVUpL7dV/64m1NyxNBBqrF5gkq/1ejflXAOGX7Vn/oOgXaMZJ
         ykRwtuqflTUXQG+BxJPJW9OtANSewISrHFVJpVGczd5jv+A8GfltxJjB3Af3ommBRnhM
         hlc0RLp+bzvwAdtiRcjlmcnArI9H/uCq/U4oJQ2GQv5jUmeMF/lkwlYtsZBY1X8Vf9Mb
         Wzrg==
X-Gm-Message-State: AOAM532NEJ7Fi3qXK8AFtCXUNyLfs3mOfy7lkpopx13w7pEP54zT5FR+
        I2PEHTVGq5A2pWAcg/95bxnFu0NhckjoC97CYaU=
X-Google-Smtp-Source: ABdhPJwuTDigJJaVZS2cekodYzHLEQHAChQQZ7c1+JWW9SeIrUoTHY0nUiF+pvYfStA92KPf92D1D57N/rC/t02zJr8=
X-Received: by 2002:a63:d7:: with SMTP id 206mr1191324pga.30.1617160615386;
 Tue, 30 Mar 2021 20:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210328064121.2062927-1-yhs@fb.com> <20210329225235.1845295-1-ndesaulniers@google.com>
 <0b8d17be-e015-83c3-88d8-7c218cd01536@fb.com> <20210331002507.xv4sxe27dqirmxih@google.com>
 <79f231f2-2d14-0900-332e-cba42f770d9e@fb.com> <CAFP8O3JjU26pNKhFE2AniP-k=8-G09G2ZXc6BXndK9hugX-0ag@mail.gmail.com>
 <CAENS6EuKv9iWLy24Gp=7dyA0RHNo9sjORASAph4UWLXvDWB+oQ@mail.gmail.com> <d34a3d62-bae8-3a30-26b6-4e5e8efcd0af@fb.com>
In-Reply-To: <d34a3d62-bae8-3a30-26b6-4e5e8efcd0af@fb.com>
From:   David Blaikie <dblaikie@gmail.com>
Date:   Tue, 30 Mar 2021 20:16:44 -0700
Message-ID: <CAENS6EuGOHcBURjR2ee2tPz3VdEu3EssCM3rFcyQqAM5MjeyQg@mail.gmail.com>
Subject: Re: [PATCH kbuild] kbuild: add -grecord-gcc-switches to clang build
To:     Yonghong Song <yhs@fb.com>
Cc:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel-team@fb.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 30, 2021 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 3/30/21 7:51 PM, David Blaikie wrote:
> > On Tue, Mar 30, 2021 at 7:39 PM F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray@g=
oogle.com> wrote:
> >>
> >> On Tue, Mar 30, 2021 at 6:48 PM Yonghong Song <yhs@fb.com> wrote:
> >>>
> >>>
> >>>
> >>> On 3/30/21 5:25 PM, Fangrui Song wrote:
> >>>> On 2021-03-30, 'Yonghong Song' via Clang Built Linux wrote:
> >>>>>
> >>>>>
> >>>>> On 3/29/21 3:52 PM, Nick Desaulniers wrote:
> >>>>>> (replying to
> >>>>>> https://lore.kernel.org/bpf/20210328064121.2062927-1-yhs@fb.com/)
> >>>>>>
> >>>>>> Thanks for the patch!
> >>>>>>
> >>>>>>> +# gcc emits compilation flags in dwarf DW_AT_producer by default
> >>>>>>> +# while clang needs explicit flag. Add this flag explicitly.
> >>>>>>> +ifdef CONFIG_CC_IS_CLANG
> >>>>>>> +DEBUG_CFLAGS    +=3D -grecord-gcc-switches
> >>>>>>> +endif
> >>>>>>> +
> >>>>
> >>>> Yes, gcc defaults to -grecord-gcc-switches. Clang doesn't.
> >>>
> >>> Could you know why? dwarf size concern?
> >>>
> >>>>
> >>>>>> This adds ~5MB/1% to vmlinux of an x86_64 defconfig built with cla=
ng.
> >>>>>> Do we
> >>>>>> want to add additional guards for CONFIG_DEBUG_INFO_BTF, so that w=
e
> >>>>>> don't have
> >>>>>> to pay that cost if that config is not set?
> >>>>>
> >>>>> Since this patch is mostly motivated to detect whether the kernel i=
s
> >>>>> built with clang lto or not. Let me add the flag only if lto is
> >>>>> enabled. My measurement shows 0.5% increase to thinlto-vmlinux.
> >>>>> The smaller percentage is due to larger .debug_info section
> >>>>> (almost double) for thinlto vs. no lto.
> >>>>>
> >>>>> ifdef CONFIG_LTO_CLANG
> >>>>> DEBUG_CFLAGS   +=3D -grecord-gcc-switches
> >>>>> endif
> >>>>>
> >>>>> This will make pahole with any clang built kernels, lto or non-lto.
> >>>>
> >>>> I share the same concern about sizes. Can't pahole know it is clang =
LTO
> >>>> via other means? If pahole just needs to know the one-bit informatio=
n
> >>>> (clang LTO vs not), having every compile option seems unnecessary...=
.
> >>>
> >>> This is v2 of the patch
> >>>     https://lore.kernel.org/bpf/20210331001623.2778934-1-yhs@fb.com/
> >>> The flag will be guarded with CONFIG_LTO_CLANG.
> >>>
> >>> As mentioned in commit message of v2, the alternative is
> >>> to go through every cu to find out whether DW_FORM_ref_addr is used
> >>> or not. In other words, check every possible cross-cu references
> >>> to find whether cross-cu reference actually happens or not. This
> >>> is quite heavy for pahole...
> >>>
> >>> What we really want to know is whether cross-cu reference happens
> >>> or not? If there is an easy way to get it, that will be great.
> >>
> >> +David Blaikie
> >
> > Yep, that shouldn't be too hard to test for more directly - scanning
> > .debug_abbrev for DW_FORM_ref_addr should be what you need. Would that
> > be workable rather than relying on detecting clang/lto from command
> > line parameters? (GCC can produce these cross-CU references too, when
> > using lto - so this approach would help make the solution generalize
> > over GCC's behavior too)
>
> Thanks, David. This should be better. I tried with a non-lto vmlinux.
> Did "llvm-dwarfdump --debug-abbrev vmlinux > log" and then
> "grep "DW_CHILDREN_no" log | wc -l" and get 231676 records.

What conclusions are you drawing from this number/data? (I'm not
following how DW_CHILDREN_no relates to the topic - perhaps I'm
missing something)

> I will try this approach. If the time is a very small fraction of
> actual dwarf cu processing time, we should be fine. This definitely
> better than visit all die's in cu trying to detect cross-cu reference.

*fingers crossed*
