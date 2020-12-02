Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2553D2CB294
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 03:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgLBCBO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 21:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgLBCBO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 21:01:14 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB92AC0613CF;
        Tue,  1 Dec 2020 18:00:33 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id 10so180735ybx.9;
        Tue, 01 Dec 2020 18:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OzlqzYwMGreBv2oDESxm1K09u8pamlF0uEL/bsIrwOk=;
        b=caLv9SaEiAadNVS2Q+cCFkO4hDcxjkTWnu1S0Cpc894zLEfMiwblhEtw9Rzj+ofK6b
         bySqn/7CNaHEod2sVhliiqmcHVWSQVj8malNmXjo73De1cl1eDfaZ3NfYiBZCRYeKnWm
         vWiMxmFhGgqVlCJrV+wCt/I0NVpC/Me72dtQTIdR98FNL4IHpIX7oYw6/XYCIfaIOPng
         1qU+/tE/aLA0I878rjyJvR68ZOTuOq5bM3fRgwsquh4IO4C1fTliEzabDO5gpcMKv1G9
         EN6wYEIZx8uDBTtRkk33QLY2aOyhmMPcwtcw4nXJoCUTjAYbiQ/CYx8ZGlTcEAIPph5Q
         ZiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OzlqzYwMGreBv2oDESxm1K09u8pamlF0uEL/bsIrwOk=;
        b=dntdnQRhFEJ1DG2gok2pbmm9tT8++eBpxbZHZYE+aFvbZeZs9L4SwootaXIR+DOpWb
         y6owzaky+qiAeYU0fO3O/mEL7hMjOPp6mbW6FKGPXdy/3q7HSG8ejiLWqzR61kxz3qpQ
         hJ7LbY7d/Wj9tDwxJkvtLly+5DlhyRaEINxmlekkrxbLHieediozkwSsE7et+Lt0CagW
         qRCBXX7HcAexrh/sWvKmOHsLBLmQBHULGGBcqb77MQyjgJcBXQNNuNTpMnJhsrrYu3gM
         6g+XJmtZEgLzqNnKOE6nEzbmbiGGF7oR9ag9/+jhX4Y+9IicyTCzWYNq3hmzzKAmiWnu
         Jxlw==
X-Gm-Message-State: AOAM533tCywtJwf28DQ8NOg9PAUYdff36c7LJo0q4Sl+fML6a/uYfjCg
        ef+XpYTBlZ9fDwCtm7sTTZMrmUdI1uM0h10MouA=
X-Google-Smtp-Source: ABdhPJyCJ8bfLh0JjtXoJGiMA3/oes2qWrwVrOG2uicnNXdmDmYN1CvCkfqWOCUD5j14o2xo9AIKaK9S17WXK5VJb5E=
X-Received: by 2002:a25:df8e:: with SMTP id w136mr364608ybg.230.1606874432918;
 Tue, 01 Dec 2020 18:00:32 -0800 (PST)
MIME-Version: 1.0
References: <20201127175738.1085417-1-jackmanb@google.com> <829353e6-d90a-a91a-418b-3c2556061cda@fb.com>
 <20201129014000.3z6eua5pcz3jxmtk@ast-mbp> <b3903adc-59c6-816f-6512-2225c28f47f5@fb.com>
 <4fa9f8cf-aaf8-a63c-e0ca-7d4c83b01578@fb.com>
In-Reply-To: <4fa9f8cf-aaf8-a63c-e0ca-7d4c83b01578@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Dec 2020 18:00:22 -0800
Message-ID: <CAEf4BzYc=c_2xCMFAE6RjMCHKWJj2euP2B21y-jfvsNzPVkhpQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/13] Atomics for eBPF
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Brendan Jackman <jackmanb@google.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 30, 2020 at 7:51 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 11/30/20 9:22 AM, Yonghong Song wrote:
> >
> >
> > On 11/28/20 5:40 PM, Alexei Starovoitov wrote:
> >> On Fri, Nov 27, 2020 at 09:53:05PM -0800, Yonghong Song wrote:
> >>>
> >>>
> >>> On 11/27/20 9:57 AM, Brendan Jackman wrote:
> >>>> Status of the patches
> >>>> =====================
> >>>>
> >>>> Thanks for the reviews! Differences from v1->v2 [1]:
> >>>>
> >>>> * Fixed mistakes in the netronome driver
> >>>>
> >>>> * Addd sub, add, or, xor operations
> >>>>
> >>>> * The above led to some refactors to keep things readable. (Maybe I
> >>>>     should have just waited until I'd implemented these before starting
> >>>>     the review...)
> >>>>
> >>>> * Replaced BPF_[CMP]SET | BPF_FETCH with just BPF_[CMP]XCHG, which
> >>>>     include the BPF_FETCH flag
> >>>>
> >>>> * Added a bit of documentation. Suggestions welcome for more places
> >>>>     to dump this info...
> >>>>
> >>>> The prog_test that's added depends on Clang/LLVM features added by
> >>>> Yonghong in
> >>>> https://reviews.llvm.org/D72184
> >>>>
> >>>> This only includes a JIT implementation for x86_64 - I don't plan to
> >>>> implement JIT support myself for other architectures.
> >>>>
> >>>> Operations
> >>>> ==========
> >>>>
> >>>> This patchset adds atomic operations to the eBPF instruction set. The
> >>>> use-case that motivated this work was a trivial and efficient way to
> >>>> generate globally-unique cookies in BPF progs, but I think it's
> >>>> obvious that these features are pretty widely applicable.  The
> >>>> instructions that are added here can be summarised with this list of
> >>>> kernel operations:
> >>>>
> >>>> * atomic[64]_[fetch_]add
> >>>> * atomic[64]_[fetch_]sub
> >>>> * atomic[64]_[fetch_]and
> >>>> * atomic[64]_[fetch_]or
> >>>
> >>> * atomic[64]_[fetch_]xor
> >>>
> >>>> * atomic[64]_xchg
> >>>> * atomic[64]_cmpxchg
> >>>
> >>> Thanks. Overall looks good to me but I did not check carefully
> >>> on jit part as I am not an expert in x64 assembly...
> >>>
> >>> This patch also introduced atomic[64]_{sub,and,or,xor}, similar to
> >>> xadd. I am not sure whether it is necessary. For one thing,
> >>> users can just use atomic[64]_fetch_{sub,and,or,xor} to ignore
> >>> return value and they will achieve the same result, right?
> >>>  From llvm side, there is no ready-to-use gcc builtin matching
> >>> atomic[64]_{sub,and,or,xor} which does not have return values.
> >>> If we go this route, we will need to invent additional bpf
> >>> specific builtins.
> >>
> >> I think bpf specific builtins are overkill.
> >> As you said the users can use atomic_fetch_xor() and ignore
> >> return value. I think llvm backend should be smart enough to use
> >> BPF_ATOMIC | BPF_XOR insn without BPF_FETCH bit in such case.
> >> But if it's too cumbersome to do at the moment we skip this
> >> optimization for now.
> >
> > We can initially all have BPF_FETCH bit as at that point we do not
> > have def-use chain. Later on we can add a
> > machine ssa IR phase and check whether the result of, say
> > atomic_fetch_or(), is used or not. If not, we can change the
> > instruction to atomic_or.
>
> Just implemented what we discussed above in llvm:
>    https://reviews.llvm.org/D72184
> main change:
>    1. atomic_fetch_sub (and later atomic_sub) is gone. llvm will
>       transparently transforms it to negation followed by
>       atomic_fetch_add or atomic_add (xadd). Kernel can remove
>       atomic_fetch_sub/atomic_sub insns.
>    2. added new instructions for atomic_{and, or, xor}.
>    3. for gcc builtin e.g., __sync_fetch_and_or(), if return
>       value is used, atomic_fetch_or will be generated. Otherwise,
>       atomic_or will be generated.

Great, this means that all existing valid uses of
__sync_fetch_and_add() will generate BPF_XADD instructions and will
work on old kernels, right?

If that's the case, do we still need cpu=v4? The new instructions are
*only* going to be generated if the user uses previously unsupported
__sync_fetch_xxx() intrinsics. So, in effect, the user consciously
opts into using new BPF instructions. cpu=v4 seems like an unnecessary
tautology then?
