Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5285635FDA2
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 00:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhDNWQd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 18:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhDNWQd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 18:16:33 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5DEC061574;
        Wed, 14 Apr 2021 15:16:11 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id o10so23861328ybb.10;
        Wed, 14 Apr 2021 15:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7hm/hYBN74dkMimz7YGlCgiS2CU1XMz0exGEgDhOfU=;
        b=CsnPgB/7PlYNZZdvMiEuh3vNGYmCMqFHW32rXGZCOO/xsM8xv0E3JcRjSCmSjPTOkU
         zOy+thUKgInCpwcCmNtElPl3KXNxv0SNzOiQhLe5LQry5othokMhBO+BxnQVehSf3HIM
         4lAXTziwdnWAil3zOBaRLHIssWMQV3gyIxSSjV6KWGQJ+iQ0INlXEp6Et2uosNcUEvuI
         gCy35dOjw9kvkRv/bDYOR1xrjVBpfUBi4kXsuyncm7KWP1So0uBB5H7iXsexGJ5t9RHx
         Ap3tyCUb6Gd07eu9f3FzXM2gYubz+DOQLTmbFRAH2bM4ZmOIUKUUf2W4KsxUhSlHTPlS
         3jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7hm/hYBN74dkMimz7YGlCgiS2CU1XMz0exGEgDhOfU=;
        b=FJ8CZaBV/aZhPvTn9IWNGvVwmBqv9rVY87KU+9ubolU422f+7toZjPViXq9M65xUOL
         k7c3ytZzez/umaV68Y1sRbCNXDfeEDofTTTEBjGRR5kECYwJCch5bNuKczTovbW1yWDQ
         QoGdCVsD5FBb1ThlbS0W2Pkv0WlpmvimEkmyMKowhlbboZmm2i/hnkXCdX45q/PNCkyN
         UzfrTIOzToRk1WECghx/mv38AdXbe70nBUt+Iyb9V9bwmskbJgeCmrgmf8b7+B4JAF8e
         qTZIpobX7P/0+RUlOtcuITmxLTUU4FdTDRQDxz2t+7vN2dbvXzbpGOcB/+liRhpyr4Jz
         R3UQ==
X-Gm-Message-State: AOAM5326WK/8uboJUrTZrQFGAHQUyJCGwaPd7k/88LWRH9c+DF5oWIL0
        1+2Mme8UYlEn09xo5ByHls2IOo+2+Jar3UwaCgY=
X-Google-Smtp-Source: ABdhPJzAhYg7csO1MHGHEgK4AiNPsPpUXZ7uZUc+aE7ZR8UHWDEcNChsPh8MEHKc9D2yViH49DdJEZStdsWapKhi1sg=
X-Received: by 2002:a25:850c:: with SMTP id w12mr232751ybk.347.1618438570895;
 Wed, 14 Apr 2021 15:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-7-revest@chromium.org>
 <CAEf4BzZ6cLio0ZZEkc5iYp9yWg3Fc1ZORBTr85TdoqF-sRU3DQ@mail.gmail.com> <CABRcYm+v7xC8WsxYu6BoiEX1vhQSVSX5U-LyUnevGt1tFud5tA@mail.gmail.com>
In-Reply-To: <CABRcYm+v7xC8WsxYu6BoiEX1vhQSVSX5U-LyUnevGt1tFud5tA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 14 Apr 2021 15:16:00 -0700
Message-ID: <CAEf4Bzb-Xh_JOWsZwC+fNiC20K_9fzrpfiAMHTYM=6k--+SZaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/6] selftests/bpf: Add a series of tests for bpf_snprintf
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 2:21 AM Florent Revest <revest@chromium.org> wrote:
>
> On Wed, Apr 14, 2021 at 1:21 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
> > >
> > > This exercises most of the format specifiers.
> > >
> > > Signed-off-by: Florent Revest <revest@chromium.org>
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> >
> > As I mentioned on another patch, we probably need negative tests even
> > more than positive ones.
>
> Agreed.
>
> > I think an easy and nice way to do this is to have a separate BPF
> > skeleton where fmt string and arguments are provided through read-only
> > global variables, so that user-space can re-use the same BPF skeleton
> > to simulate multiple cases. BPF program itself would just call
> > bpf_snprintf() and store the returned result.
>
> Ah, great idea! I was thinking of having one skeleton for each but it
> would be a bit much indeed.
>
> Because the format string needs to be in a read only map though, I
> hope it can be modified from userspace before loading. I'll try it out
> and see :) if it doesn't work I'll just use more skeletons

You need read-only variables (const volatile my_type). Their contents
are statically verified by BPF verifier, yet user-space can pre-setup
it at runtime.

>
> > Whether we need to validate the verifier log is up to debate (though
> > it's not that hard to do by overriding libbpf_print_fn() callback),
> > I'd be ok at least knowing that some bad format strings are rejected
> > and don't crash the kernel.
>
> Alright :)
>
> >
> > >  .../selftests/bpf/prog_tests/snprintf.c       | 81 +++++++++++++++++++
> > >  .../selftests/bpf/progs/test_snprintf.c       | 74 +++++++++++++++++
> > >  2 files changed, 155 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c
> > >
> >
> > [...]
