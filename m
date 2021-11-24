Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C370545B65C
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 09:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhKXISI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 03:18:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229733AbhKXISI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 03:18:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34FEC61055
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 08:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637741699;
        bh=dko9EeLRbwlSDjDLJNhUXUtMjKbVVTOsFc2Z8Xm8EYM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oOShSW/snMf2l47amNurzb1YazgWBF0jFLhgJ9/LrMhwdOjBXln3LxBxabY5CAPz9
         SRPlX12JfovoIk+FcWI/pmVA+LyUDo8Kq9eHTCT22QWRSJt913Ax1aZbfZBLDu0uUF
         UeS35Cwm7GL9nG/5zST7///6DVXeY/hSI8kfAZeicsMupG8G4WVZxg0U6BpF/93511
         0jvpUiGDhEshMd3x/J2OWc79UfCCZmRT9IzW8Zxug4OrLyRn1dprApwBebLmns1ckJ
         kOu9cvIr+9yQ8vRShCXoqWFy1/zJt57+8G0VK5JIyL6zI/1xlcSItfAgJWdxOHAVc+
         VvI67ZohYk7Fw==
Received: by mail-yb1-f170.google.com with SMTP id v7so5093756ybq.0
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 00:14:59 -0800 (PST)
X-Gm-Message-State: AOAM532yihYAudWIQLh/bhDLKb9DLlaxn5+brI3l28Frfi5QWpqH9lE/
        7PJ1P8UnF2QQMEpuqf0vwcDhGf4ewRh6QuvtVus=
X-Google-Smtp-Source: ABdhPJwkh+xkx/h2SQ1t5DS0cTDPoNSK7vXv6fwwvYjVa8G70GBlI/v3I9rjRGzuZJrw9su8IxEHobLfI7hp1UWhGUs=
X-Received: by 2002:a25:344d:: with SMTP id b74mr14908992yba.317.1637741698268;
 Wed, 24 Nov 2021 00:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20211120165528.197359-1-kuba@kernel.org> <CAPhsuW4g1PhdczQh=iqDR_CzB=6FoM4QPF9DmknEP0hZ_Ac3TA@mail.gmail.com>
 <d4c52f8f-7efb-3d2a-8f2e-c983cd0c8cce@arm.com>
In-Reply-To: <d4c52f8f-7efb-3d2a-8f2e-c983cd0c8cce@arm.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 23 Nov 2021 22:14:46 -1000
X-Gmail-Original-Message-ID: <CAPhsuW6CMBymKpOMdL-bianESBLfbKa5JwmFypKL3dx4k0rmSQ@mail.gmail.com>
Message-ID: <CAPhsuW6CMBymKpOMdL-bianESBLfbKa5JwmFypKL3dx4k0rmSQ@mail.gmail.com>
Subject: Re: [PATCH bpf] cacheinfo: move get_cpu_cacheinfo_id() back out
To:     James Morse <james.morse@arm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, fenghua.yu@intel.com,
        reinette.chatre@intel.com, bpf <bpf@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        dave.hansen@linux.intel.com, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 23, 2021 at 8:49 AM James Morse <james.morse@arm.com> wrote:
>
> Hello,
>
> On 23/11/2021 17:45, Song Liu wrote:
> > On Sat, Nov 20, 2021 at 6:55 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >>
> >> This commit more or less reverts commit 709c4362725a ("cacheinfo:
> >> Move resctrl's get_cache_id() to the cacheinfo header file").
> >>
> >> There are no users of the static inline helper outside of resctrl/core.c
> >> and cpu.h is a pretty heavy include, it pulls in device.h etc. This
> >> trips up architectures like riscv which want to access cacheinfo
> >> in low level headers like elf.h.
> >>
> >> Link: https://lore.kernel.org/all/20211120035253.72074-1-kuba@kernel.org/
> >> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >> ---
>
> >> x86 resctrl folks, does this look okay?
> >>
> >> I'd like to do some bpf header cleanups in -next which this is blocking.
> >> How would you like to handle that? This change looks entirely harmless,
> >> can I get an ack and take this via bpf/netdev to Linus ASAP so it
> >> propagates to all trees?
> >
> > Does this patch target the bpf tree, or the bpf-next tree? If we want to unblock
> > bpf header cleanup in -next, we can simply include it in a set for bpf-next.
>
>
> Some background: this is part of the mpam tree that wires up resctrl for arm64. This patch
> floated to the top and got merged with some cleanup as it was independent of the wider
> resctrl changes.
>
> If the cpu.h include is the problem, I can't see what that is needed for. It almost
> certainly came in with a lockdep annotation that got replaced by a comment instead.

Thanks for the information.

I can ack the patch for the patch itself.

Acked-by: Song Liu <songliubraving@fb.com>

But I am not sure whether we should ship it via bpf tree. It seems to
me that the
only reason we ship it via bpf tree is to get it to upstream ASAP?

Alexei/Daniel/Andrii, what do you think about this?

Thanks,
Song
