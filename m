Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF76467E01
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 20:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382780AbhLCTWK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 14:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382775AbhLCTWJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 14:22:09 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7302FC061353
        for <bpf@vger.kernel.org>; Fri,  3 Dec 2021 11:18:45 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z6so2775919plk.6
        for <bpf@vger.kernel.org>; Fri, 03 Dec 2021 11:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+QDyD99nrD3ADXUvg78wF3TX6kXVvpODTR9S+z0VHA=;
        b=GbJ9ycUQ042b+K6Sus+Xrd8sf0gxtthYett8ieZd/zgLOSNz9WfOZVm+GMw0tFqSwc
         ufoLS65KBLhFjYWNdhacxKbxVLeZ1EEhO5R/JX4cQWbfdW21a1sLSsWxjUbyR6e8eemg
         sz2DUeT/ordnxSNcFp6CrzPKutVjemyjNdvGbb+WX+bMzMHm5eMuIMj3be5/jN0B9a3V
         rlnJJbOfbJSmIePxGjKMGFLZ4njGf4bDQh7VIvqFrmbk+zXkYMpU9xjMeI6y0iKCOHhy
         l5bcw+50W7pbYzo/z1Lt1GasnhocGx4HDZvZ3PVcO7jAvwbTJkQ4ZHjLDkowefdWLwOT
         gIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+QDyD99nrD3ADXUvg78wF3TX6kXVvpODTR9S+z0VHA=;
        b=2pebvMR1Xz1DnbXxD+6A+BncyLzeM7kKqb0a+qXVecgRFOThv6r0XfBxViAvXzMxUi
         bkywFXLFm17NT6k3TI7hhnjjMg/o3hii6ljowO8h6Jn6X4mHh+Vuzxn91kwj6CqtfOMv
         eABs7028YeVent8eF8dy3LmjOqcGhi+7kv+1Tmb/xt52XoEItiKLuGUK+rF5p8kSeH4w
         gz8A00HH+QkOO/wgdCcrFnMdc01d1l2hPy9O0ITG0IsouFof/HvNldFBx6U/SP6YJt0i
         BgMbswMr/HUKfuZP8wu5we7mEsByHnmBw4ekvwqHnSvzCk6ADRAiAIM2E8mKYPMJ75jt
         rVCQ==
X-Gm-Message-State: AOAM531o+3a7j23Je4YLWOcO5jm7ftG2OREJWEKoMlujs7/1UW1omgKO
        572wUQeB03TUSmDiIYtUxKNXDjJb6DOmvXs9A1wBJ36HWhs=
X-Google-Smtp-Source: ABdhPJxIG3rONTjOTCRRHPZ9KqYKRgh1OWSI6M8V1VQMlnIeb/DMloLcdkO/Spl0uBzzImgmS12VMACyoTyySMlUo28=
X-Received: by 2002:a17:902:b588:b0:143:b732:834 with SMTP id
 a8-20020a170902b58800b00143b7320834mr25182795pls.22.1638559124808; Fri, 03
 Dec 2021 11:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20211201181040.23337-1-alexei.starovoitov@gmail.com> <CAFnufp2sP_N57qxQPoEHoMqN-NQ3HwiqKvWOecbEvFwrgK8QRw@mail.gmail.com>
In-Reply-To: <CAFnufp2sP_N57qxQPoEHoMqN-NQ3HwiqKvWOecbEvFwrgK8QRw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 3 Dec 2021 11:18:33 -0800
Message-ID: <CAADnVQJDax2j0-7uyqdqFEnpB57om_z+Cqmi1O2QyLpHqkVKwA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 00/17] bpf: CO-RE support in the kernel
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 2, 2021 at 10:45 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> On Wed, Dec 1, 2021 at 7:11 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > v4->v5:
> > . Reduce number of memory allocations in candidate cache logic
> > . Fix couple UAF issues
> > . Add Andrii's patch to cleanup struct bpf_core_cand
> > . More thorough tests
> > . Planned followups:
> >   - support -v in lskel
> >   - move struct bpf_core_spec out of bpf_core_apply_relo_insn to
> >     reduce stack usage
> >   - implement bpf_core_types_are_compat
> >
> > v3->v4:
> > . complete refactor of find candidates logic.
> >   Now it has small permanent cache.
> > . Fix a bug in gen_loader related to attach_kind.
> > . Fix BTF log size limit.
> > . More tests.
> >
> > v2->v3:
> > . addressed Andrii's feedback in every patch.
> >   New field in union bpf_attr changed from "core_relo" to "core_relos".
> > . added one more test and checkpatch.pl-ed the set.
> >
> > v1->v2:
> > . Refactor uapi to pass 'struct bpf_core_relo' from LLVM into libbpf and further
> > into the kernel instead of bpf_core_apply_relo() bpf helper. Because of this
> > change the CO-RE algorithm has an ability to log error and debug events through
> > the standard bpf verifer log mechanism which was not possible with helper
> > approach.
> > . #define RELO_CORE macro was removed and replaced with btf_member_bit_offset() patch.
> >
> > This set introduces CO-RE support in the kernel.
> > There are several reasons to add such support:
> > 1. It's a step toward signed BPF programs.
> > 2. It allows golang like languages that struggle to adopt libbpf
> >    to take advantage of CO-RE powers.
> > 3. Currently the field accessed by 'ldx [R1 + 10]' insn is recognized
> >    by the verifier purely based on +10 offset. If R1 points to a union
> >    the verifier picks one of the fields at this offset.
> >    With CO-RE the kernel can disambiguate the field access.
> >
>
> Hi,
>
> I ran my usual co-re test which was failing in the v1. Relocations
> looks correct now:

Matteo,

Thanks for testing.
May I ask you to take a stab at implementing non-recursive
bpf_core_types_are_compat ?
The libbpf version cannot be used as-is in the kernel.
Or maybe we can limit its recursion to a few steps?
In practice the limit of 2 is probably more than enough.
