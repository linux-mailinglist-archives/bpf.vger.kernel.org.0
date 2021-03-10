Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC45333BC6
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 12:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhCJLtZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 06:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhCJLs4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 06:48:56 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD3EC061760
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 03:48:56 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id v14so15242964ilj.11
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 03:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OUZP8m10BICXg+bVPGfgJD/AJgcaU4lrh7k/xffSUxE=;
        b=mbtgLm0pM+7qiwMv60dRKDKZJqODnkpoqbEPoXqEqIaq5AD66TqKZs3XHEKiTdSPBd
         E6J3u/bTHxuSW6PPuPCqsU3aDrPURWPqHsrbCWzVBicwhtV/KwmL3qrhpGDRfhjaaiDp
         yiEtfTMyHG8ISa0s1zbE7YNeG/nMKcc0hSOlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUZP8m10BICXg+bVPGfgJD/AJgcaU4lrh7k/xffSUxE=;
        b=iyQJCxzyeS81M6EoULIXm/xKpTgRZdwpjmQM/ht9TL0r1hmjf/dh2e9CT3833wKg94
         xQmC3MSAanTQ5t/YLAf0Z2NRQ1iSB8D6dkenT8XA9Yp6HwAYaPXuG9t9v4OwW1SE2LM7
         9f88Ax6mAea+MALSM5NUk6BP8ayNVC1g47BjopFBe65sybyqqMHQ0fy8KYRdXPiZJVU5
         WslNiImvvK2CPIUTFbR1Yx3rxgoxOJg4WouBrk8AbSHb9h92JvLVBTvozHhtwLwTf5d0
         St4X7dyrF6hOWhGAOkJE0ttWvVOKERewUADEGuAnkOu2lavN04MPyLsML2dl3aji2zfZ
         jx8g==
X-Gm-Message-State: AOAM531Zaxmue4fK85/v0XLNC6Epe8IDvQdpaJJlJqQVKVnWRbZeXX4p
        CdrKpW75GClpQ6S1ivGjZnzqWqjC0Wq7Cz7gTNLEXg==
X-Google-Smtp-Source: ABdhPJzKDZ2w84WPy4/Sc+NOCtoscv5Ymh7J7VojvKq29V559mzpfigpeAYOQvyHM6D72hvNfq6B4YY6wtu3RfIQZ+U=
X-Received: by 2002:a05:6e02:12b4:: with SMTP id f20mr2231220ilr.220.1615376935917;
 Wed, 10 Mar 2021 03:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20210310015455.1095207-1-revest@chromium.org> <f5cfb3d0-fab4-ee07-70de-ad5589db1244@fb.com>
 <eb0a8485-9624-1727-6913-e4520c9d8c04@fb.com>
In-Reply-To: <eb0a8485-9624-1727-6913-e4520c9d8c04@fb.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 10 Mar 2021 12:48:45 +0100
Message-ID: <CABRcYmK8m21sb8dHbr1wLT_oTCBpvr2Zg-8KHwKuJ2Ak0iTZ_A@mail.gmail.com>
Subject: Re: [BUG] One-liner array initialization with two pointers in BPF
 results in NULLs
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 10, 2021 at 6:16 AM Yonghong Song <yhs@fb.com> wrote:
> On 3/9/21 7:43 PM, Yonghong Song wrote:
> > On 3/9/21 5:54 PM, Florent Revest wrote:
> >> I noticed that initializing an array of pointers using this syntax:
> >> __u64 array[] = { (__u64)&var1, (__u64)&var2 };
> >> (which is a fairly common operation with macros such as BPF_SEQ_PRINTF)
> >> always results in array[0] and array[1] being NULL.
> >>
> >> Interestingly, if the array is only initialized with one pointer, ex:
> >> __u64 array[] = { (__u64)&var1 };
> >> Then array[0] will not be NULL.
> >>
> >> Or if the array is initialized field by field, ex:
> >> __u64 array[2];
> >> array[0] = (__u64)&var1;
> >> array[1] = (__u64)&var2;
> >> Then array[0] and array[1] will not be NULL either.
> >>
> >> I'm assuming that this should have something to do with relocations
> >> and might be a bug in clang or in libbpf but because I don't know much
> >> about these, I thought that reporting could be a good first step. :)
> >
> > Thanks for reporting. What you guess is correct, this is due to
> > relocations :-(
> >
> > The compiler notoriously tend to put complex initial values into
> > rodata section. For example, for
> >     __u64 array[] = { (__u64)&var1, (__u64)&var2 };
> > the compiler will put
> >     { (__u64)&var1, (__u64)&var2 }
> > into rodata section.
> >
> > But &var1 and &var2 themselves need relocation since they are
> > address of static variables which will sit inside .data section.
> >
> > So in the elf file, you will see the following relocations:
> >
> > RELOCATION RECORDS FOR [.rodata]:
> > OFFSET           TYPE                     VALUE
> > 0000000000000018 R_BPF_64_64              .data
> > 0000000000000020 R_BPF_64_64              .data

Right :) Thank you for the explanations Yonghong!

> > Currently, libbpf does not handle relocation inside .rodata
> > section, so they content remains 0.

Just for my own edification, why is .rodata relocation not yet handled
in libbpf ? Is it because of a read-only mapping that makes it more
difficult ?

> > That is why you see the issue with pointer as NULL.
> >
> > With array size of 1, compiler does not bother to put it into
> > rodata section.
> >
> > I *guess* that it works in the macro due to some kind of heuristics,
> > e.g., nested blocks, etc, and llvm did not promote the array init value
> > to rodata. I will double check whether llvm can complete prevent
> > such transformation.
> >
> > Maybe in the future libbpf is able to handle relocations for
> > rodata section too. But for the time being, please just consider to use
> > either macro, or the explicit array assignment.
>
> Digging into the compiler, the compiler tries to make *const* initial
> value into rodata section if the initial value size > 64, so in
> this case, macro does not work either. I think this is how you
> discovered the issue.

Indeed, I was using a macro similar to BPF_SEQ_PRINTF and this is how
I found the bug.

> The llvm does not provide target hooks to
> influence this transformation.

Oh, that is unfortunate :) Thanks for looking into it! I feel that the
real fix would be in libbpf anyway and the rest is just workarounds.

> So, there are two workarounds,
> (1).    __u64 param_working[2];
>          param_working[0] = (__u64)str1;
>          param_working[1] = (__u64)str2;
> (2). BPF_SEQ_PRINTF(seq, "%s ", str1);
>       BPF_SEQ_PRINTF(seq, "%s", str2);

(2) is a bit impractical for my actual usecase. I am implementing a
bpf_snprintf helper (patch series Coming Soon TM) and I wanted to keep
the selftest short with a few BPF_SNPRINTF() calls that exercise most
format specifiers.

> In practice, if you have at least one non-const format argument,
> you should be fine. But if all format arguments are constant, then
> none of them should be strings.

Just for context, this does not only happen for strings but also for
all sorts of pointers, for example, when I try to do address lookup of
global __ksym variables, which is important for my selftest.

> Maybe we could change marco
>     unsigned long long ___param[] = { args };
> to declare an array explicitly and then have a loop to
> assign each array element?

I think this would be a good workaround for now, indeed. :) I'll look
into it today and send it as part of my bpf_snprintf series.

Thanks!
