Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B13429C10
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 05:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhJLDtl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 23:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhJLDtl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Oct 2021 23:49:41 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C705C061570
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 20:47:40 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id s4so43598329ybs.8
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 20:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jl3OQjbVDuQ13dHe0DBsuKRfDDe0LCo4TQCe5ZZ48oY=;
        b=Lxww5HYzv5UIKDsnGIbX5VOHxLHGw3V+t5R6pvLVABdNfcT1qpJJiI6i/NCjwV8T/F
         uw3XfFMydsPQszdEm1brVT6MxBrJU3DxQWKZyzISK8CuJ7UQrKYdxZiL6Y6imytOLHK2
         FeUXagWd7+45U27zZ8m4czlKXijf2/wOrCqs7Wl+SBAFz7uoxAfhM1zP/6/rJkya24lM
         ERB2CM6dOTUlConPNY5Kn1rTnDVSQQ1hKxDye95ro29D20zdpAKw1xvE5u5QEr1CQesP
         0n8k9thkhJNOSrum5BmLpRsfav454TDgkfy6+VlmTdKr1nDpNouWVCFqqME9Hf2O4JF/
         epTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jl3OQjbVDuQ13dHe0DBsuKRfDDe0LCo4TQCe5ZZ48oY=;
        b=MZseZknrilYSml43T8k4ns+jqVXNiVXEmjvJwyTyC0XMKARAc7BkzOsysQr8ZkRBwR
         ttoH+Mlh3W2Qatg9EinvkyzIfDCYRsFdOI9KnnB2vjte8vEwFZceT3yxRJtqqkU6nhVN
         J1B2lWhA1oyd9b2fXwJKbfGFzpXnaRgEtY3vKijgprg+dCTiD+jzO1vYuVfk62V437yb
         SKJyFXGOlOChFGE7ZFOo584TlVqgpXEHgxUNc211+P6qBiGLFXc/bSX897F32LajgprX
         Um0+DgKgqYreTWYEGEiQpf5OMVYLPsswHUP72Bz+/7/Oq5d18kB4hO/QPIJ4qMY1MMB+
         LLkQ==
X-Gm-Message-State: AOAM531ZHPT6b19QzaPp7wgNwrNT1cB7MwsoHrnScOL0fvdSxq1n+eg+
        Obdd6S8gayCka2VAJ17qJIcxy/s4kPI84FhS/Jo=
X-Google-Smtp-Source: ABdhPJzQRiAbulpWK28C3jOWNJWhGS9chA/LZOKUL1+iYYDs/ebPlI4HZ4oj0Y9pSmwl+xHlF6r/jakPBmCNXiDdVhQ=
X-Received: by 2002:a25:d3c8:: with SMTP id e191mr25693944ybf.455.1634010459768;
 Mon, 11 Oct 2021 20:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211008000309.43274-9-andrii@kernel.org>
 <dfde174b-fff5-118b-b6c8-a2d4047ab2c1@iogearbox.net>
In-Reply-To: <dfde174b-fff5-118b-b6c8-a2d4047ab2c1@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Oct 2021 05:47:28 +0200
Message-ID: <CAEf4BzYx7Ff6HYqE5mB9Nw84TkpyPrDOz5NSeERD1jpRH6OyWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 08/10] selftests/bpf: demonstrate use of custom
 .rodata/.data sections
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 11, 2021 at 3:57 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 10/8/21 2:03 AM, andrii.nakryiko@gmail.com wrote:
> > From: Andrii Nakryiko <andrii@kernel.org>
> >
> > Enhance existing selftests to demonstrate the use of custom
> > .data/.rodata sections.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Just a thought, but wouldn't the actual demo / use case be better to show that we can
> now have a __read_mostly attribute which implies SEC(".data.read_mostly") section?
>
> Would be nice to add a ...
>
>    #define __read_mostly    SEC(".data.read_mostly")
>
> ... into tools/lib/bpf/bpf_helpers.h along with the series for use out of BPF programs
> as I think this should be a rather common use case. Thoughts?

But what's so special about the ".data.read_mostly" ELF section for
BPF programs? It's just another data section with no extra semantics.
So unclear why we need to have a dedicated #define for that?..

>
> > ---
> >   .../selftests/bpf/prog_tests/skeleton.c       | 25 +++++++++++++++++++
> >   .../selftests/bpf/progs/test_skeleton.c       | 10 ++++++++
> >   2 files changed, 35 insertions(+)
> [...]
> > diff --git a/tools/testing/selftests/bpf/progs/test_skeleton.c b/tools/testing/selftests/bpf/progs/test_skeleton.c
> > index 441fa1c552c8..47a7e76866c4 100644
> > --- a/tools/testing/selftests/bpf/progs/test_skeleton.c
> > +++ b/tools/testing/selftests/bpf/progs/test_skeleton.c
> > @@ -40,9 +40,16 @@ int kern_ver = 0;
> >
> >   struct s out5 = {};
> >
> > +const volatile int in_dynarr_sz SEC(".rodata.dyn");
> > +const volatile int in_dynarr[4] SEC(".rodata.dyn") = { -1, -2, -3, -4 };
> > +
> > +int out_dynarr[4] SEC(".data.dyn") = { 1, 2, 3, 4 };
> > +
> >   SEC("raw_tp/sys_enter")
> >   int handler(const void *ctx)
> >   {
> > +     int i;
> > +
> >       out1 = in1;
> >       out2 = in2;
> >       out3 = in3;
> > @@ -53,6 +60,9 @@ int handler(const void *ctx)
> >       bpf_syscall = CONFIG_BPF_SYSCALL;
> >       kern_ver = LINUX_KERNEL_VERSION;
> >
> > +     for (i = 0; i < in_dynarr_sz; i++)
> > +             out_dynarr[i] = in_dynarr[i];
> > +
> >       return 0;
> >   }
> >
> >
>
