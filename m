Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE29467E2D
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 20:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245075AbhLCT1h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 14:27:37 -0500
Received: from linux.microsoft.com ([13.77.154.182]:39712 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244366AbhLCT1f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 14:27:35 -0500
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by linux.microsoft.com (Postfix) with ESMTPSA id 638D020E6945
        for <bpf@vger.kernel.org>; Fri,  3 Dec 2021 11:24:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 638D020E6945
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1638559451;
        bh=kBSC6R6s06iTQxxVsVB4SP/zSl6Wua1CMH/5WLdRTI8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DtTHRnGU87daPTbqr86fUQIKxiUW2n0s5R/huYIecOnHWPaf9yXMdvcISL2/U9tOC
         berXOnKhxI5quwzdmgIKLRqpLgEHBez4kAdvu+m0PdXXovTowPJCKzZ1QVEYdkxplN
         hMxWpF9dzuWI7bhcm1eSa1Boq/7Iro/H8EVXSlFk=
Received: by mail-pf1-f175.google.com with SMTP id 8so3797314pfo.4
        for <bpf@vger.kernel.org>; Fri, 03 Dec 2021 11:24:11 -0800 (PST)
X-Gm-Message-State: AOAM531SfTfCkHMvimBs+eO8wbwGiKFMNcMXRTvN+Vs9S1rBgUCDhdDm
        arfTR4CuUHKnlW9JWuwXV0NrV1XL2tJKhIAPTXg=
X-Google-Smtp-Source: ABdhPJygQ/lGkciWUZAc4ykPj1D0/keZJcD/dEW+Na+16wERhinaRAPDc1PKMyYMwhvbepmMqUUhwWzvB4TAQy/ziiA=
X-Received: by 2002:a63:2c50:: with SMTP id s77mr5843042pgs.387.1638559450838;
 Fri, 03 Dec 2021 11:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
 <CAFnufp2sP_N57qxQPoEHoMqN-NQ3HwiqKvWOecbEvFwrgK8QRw@mail.gmail.com> <CAADnVQJDax2j0-7uyqdqFEnpB57om_z+Cqmi1O2QyLpHqkVKwA@mail.gmail.com>
In-Reply-To: <CAADnVQJDax2j0-7uyqdqFEnpB57om_z+Cqmi1O2QyLpHqkVKwA@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Fri, 3 Dec 2021 20:23:35 +0100
X-Gmail-Original-Message-ID: <CAFnufp1mStPb2z=CLmudh9bpPoXWC7L6KpbHFh=nbs_UEre5cA@mail.gmail.com>
Message-ID: <CAFnufp1mStPb2z=CLmudh9bpPoXWC7L6KpbHFh=nbs_UEre5cA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 00/17] bpf: CO-RE support in the kernel
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 3, 2021 at 8:18 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Dec 2, 2021 at 10:45 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> >
> > On Wed, Dec 1, 2021 at 7:11 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > v4->v5:
> > > . Reduce number of memory allocations in candidate cache logic
> > > . Fix couple UAF issues
> > > . Add Andrii's patch to cleanup struct bpf_core_cand
> > > . More thorough tests
> > > . Planned followups:
> > >   - support -v in lskel
> > >   - move struct bpf_core_spec out of bpf_core_apply_relo_insn to
> > >     reduce stack usage
> > >   - implement bpf_core_types_are_compat
> > >
> > > v3->v4:
> > > . complete refactor of find candidates logic.
> > >   Now it has small permanent cache.
> > > . Fix a bug in gen_loader related to attach_kind.
> > > . Fix BTF log size limit.
> > > . More tests.
> > >
> > > v2->v3:
> > > . addressed Andrii's feedback in every patch.
> > >   New field in union bpf_attr changed from "core_relo" to "core_relos".
> > > . added one more test and checkpatch.pl-ed the set.
> > >
> > > v1->v2:
> > > . Refactor uapi to pass 'struct bpf_core_relo' from LLVM into libbpf and further
> > > into the kernel instead of bpf_core_apply_relo() bpf helper. Because of this
> > > change the CO-RE algorithm has an ability to log error and debug events through
> > > the standard bpf verifer log mechanism which was not possible with helper
> > > approach.
> > > . #define RELO_CORE macro was removed and replaced with btf_member_bit_offset() patch.
> > >
> > > This set introduces CO-RE support in the kernel.
> > > There are several reasons to add such support:
> > > 1. It's a step toward signed BPF programs.
> > > 2. It allows golang like languages that struggle to adopt libbpf
> > >    to take advantage of CO-RE powers.
> > > 3. Currently the field accessed by 'ldx [R1 + 10]' insn is recognized
> > >    by the verifier purely based on +10 offset. If R1 points to a union
> > >    the verifier picks one of the fields at this offset.
> > >    With CO-RE the kernel can disambiguate the field access.
> > >
> >
> > Hi,
> >
> > I ran my usual co-re test which was failing in the v1. Relocations
> > looks correct now:
>
> Matteo,
>
> Thanks for testing.
> May I ask you to take a stab at implementing non-recursive
> bpf_core_types_are_compat ?
> The libbpf version cannot be used as-is in the kernel.
> Or maybe we can limit its recursion to a few steps?
> In practice the limit of 2 is probably more than enough.

Sure, I will have a look.
In the worst case I'll limit recursion.

Regards,
-- 
per aspera ad upstream
