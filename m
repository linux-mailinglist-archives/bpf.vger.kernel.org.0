Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C956435361
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 21:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhJTTE7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 15:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhJTTE6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 15:04:58 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07771C06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 12:02:44 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id q189so14156749ybq.1
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 12:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dIio4hKQ5FBEKhnjEpl9U58egw3eTQ+jQrEvoQau7gA=;
        b=WUM8m1bGQ2JFFwbk3mmujR7k1cXUd3a8Hd2B9SmGMWZlS3J5tEtb6RclCjNrERzeN/
         XrEg516EnZ4XmaErY3HGPQ6mBZfzcJTNsdq52Ky+QhgEUzT6gVg+wK8HYYik7YAMFDzD
         55n5FibuKey+bjB5DeawlGsIqRGosuAN0DQx6pV2c3j2tThVEADBtrMGnwNM4i81wj/r
         xKUB3rkIxUKUmABbAka8JfcCng13ZscWoLIYIJMCOb5uEZKQEfvHn6vcEH6YMJuwoe0X
         9Am5FttfcASaNQeCDx02YR2y9A1TuVzQVWUMvqY64cjJ+cpMO0g8kB+fthy5GtzBDbdv
         qgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dIio4hKQ5FBEKhnjEpl9U58egw3eTQ+jQrEvoQau7gA=;
        b=gPRjwt2sS8MHB0RTNLdWzXvwQ/ArdADxem/yxpphaqicDZcrSEYuKToQUJ2gDzuQp9
         0h6QuPcbgWL1DUFEB2/bpryBJmKficoj3nhtc/9xcrss30ZNjXWZIDy0xdkaLC5VBvZD
         FJHYdfsM0mDvCTjjwFEJtpzCS8Cxw/JqlO5OWXpchH19TvfcpNH5EoynCst7QgmW6gbZ
         Zuvq8aE/rlqr3PZMEeTAIlOf0ULZL3V4JvFBXztC0Ft/4Fnb/OToFD8fOpB+gN5OQSHZ
         kHy99SmHWN+59Oq1xsn27TeVJJY0WsqqNTOdu3wFbAR2jqqcPtrjucL7XyKThCqBkBgY
         +b5A==
X-Gm-Message-State: AOAM532dRzvH08mQKUT3a5MZhmEdgaFlu1RKk0P0AV1AUoSvODniOHFm
        ukKTt4ZtekMSqCqchAryGiPMYYGQKHV/kXTAjEk=
X-Google-Smtp-Source: ABdhPJwriZpHvlyuRdcpIQmpP/wpjK9naRva49ZTmmSHAEY4H5zGtGDh8s/lu/a9+1/NxFED6xMJabPJohWEHqGGSlc=
X-Received: by 2002:a25:e7d7:: with SMTP id e206mr797523ybh.267.1634756563114;
 Wed, 20 Oct 2021 12:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211008000309.43274-9-andrii@kernel.org>
 <dfde174b-fff5-118b-b6c8-a2d4047ab2c1@iogearbox.net> <CAEf4BzYx7Ff6HYqE5mB9Nw84TkpyPrDOz5NSeERD1jpRH6OyWQ@mail.gmail.com>
 <2d2260b6-53ae-bcf4-ab41-4b4744a09bd6@iogearbox.net>
In-Reply-To: <2d2260b6-53ae-bcf4-ab41-4b4744a09bd6@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 12:02:32 -0700
Message-ID: <CAEf4BzZAtPwpoyeurfHT=3V+8-sWnO+QRy4=iTYugN-fGqgc6g@mail.gmail.com>
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

On Tue, Oct 12, 2021 at 7:54 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 10/12/21 5:47 AM, Andrii Nakryiko wrote:
> > On Mon, Oct 11, 2021 at 3:57 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >> On 10/8/21 2:03 AM, andrii.nakryiko@gmail.com wrote:
> >>> From: Andrii Nakryiko <andrii@kernel.org>
> >>>
> >>> Enhance existing selftests to demonstrate the use of custom
> >>> .data/.rodata sections.
> >>>
> >>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >>
> >> Just a thought, but wouldn't the actual demo / use case be better to show that we can
> >> now have a __read_mostly attribute which implies SEC(".data.read_mostly") section?
> >>
> >> Would be nice to add a ...
> >>
> >>     #define __read_mostly    SEC(".data.read_mostly")
> >>
> >> ... into tools/lib/bpf/bpf_helpers.h along with the series for use out of BPF programs
> >> as I think this should be a rather common use case. Thoughts?
> >
> > But what's so special about the ".data.read_mostly" ELF section for
> > BPF programs? It's just another data section with no extra semantics.
> > So unclear why we need to have a dedicated #define for that?..
>
> I mean semantics are implicit that only vars would be located there which are
> by far more read than written to. Placing into separate .data.read_mostly would
> help to reduce cache misses due to false sharing e.g. if they are otherwise placed
> near vars which are written more often (silly example would be some counter in
> the prog).

We've discussed this offline. We concluded that it's a bit premature
to add #define __read_mostly into bpf_helpers.h, but I'll use
__read_mostly as part of a selftests to demonstrate this concept.

>
> >>> ---
> >>>    .../selftests/bpf/prog_tests/skeleton.c       | 25 +++++++++++++++++++
> >>>    .../selftests/bpf/progs/test_skeleton.c       | 10 ++++++++
> >>>    2 files changed, 35 insertions(+)
> >> [...]
> >>> diff --git a/tools/testing/selftests/bpf/progs/test_skeleton.c b/tools/testing/selftests/bpf/progs/test_skeleton.c
> >>> index 441fa1c552c8..47a7e76866c4 100644
> >>> --- a/tools/testing/selftests/bpf/progs/test_skeleton.c
> >>> +++ b/tools/testing/selftests/bpf/progs/test_skeleton.c
> >>> @@ -40,9 +40,16 @@ int kern_ver = 0;
> >>>
> >>>    struct s out5 = {};
> >>>
> >>> +const volatile int in_dynarr_sz SEC(".rodata.dyn");
> >>> +const volatile int in_dynarr[4] SEC(".rodata.dyn") = { -1, -2, -3, -4 };
> >>> +
> >>> +int out_dynarr[4] SEC(".data.dyn") = { 1, 2, 3, 4 };
> >>> +
> >>>    SEC("raw_tp/sys_enter")
> >>>    int handler(const void *ctx)
> >>>    {
> >>> +     int i;
> >>> +
> >>>        out1 = in1;
> >>>        out2 = in2;
> >>>        out3 = in3;
> >>> @@ -53,6 +60,9 @@ int handler(const void *ctx)
> >>>        bpf_syscall = CONFIG_BPF_SYSCALL;
> >>>        kern_ver = LINUX_KERNEL_VERSION;
> >>>
> >>> +     for (i = 0; i < in_dynarr_sz; i++)
> >>> +             out_dynarr[i] = in_dynarr[i];
> >>> +
> >>>        return 0;
> >>>    }
> >>>
> >>>
> >>
