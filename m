Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DEE3FF7A0
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 01:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347832AbhIBXGw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 19:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347912AbhIBXGv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Sep 2021 19:06:51 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF114C061575;
        Thu,  2 Sep 2021 16:05:52 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id z18so6844927ybg.8;
        Thu, 02 Sep 2021 16:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B86ESlgqkajdOaq6Bjknz3MFl+TpH2X5kP28d+2n8So=;
        b=lYvOwRGs1vjxgzh2WiJKppW7pB8bP6jhUKVmxygCMpozFDZNEyAMVKo/i7mGirozQO
         0TJ8iyTjDKmA9W7EpImHZvj43GWarqWpTo52VpHcC4fh/nNzj4RZcGT/Svl7LteP1YfR
         B96yZ+UmqdzWapvpyoJg9Y8I0e8Xn2hlPvLTOQ5lE0WuuptYXKGU8nGNlydX7QDiIS9X
         5xx60/JJf12hww9fvy/pteltfi0A5hcYSIJVjEYTq6kbRGJv+uKZShGdSJuqKTaa/g50
         QzV9mhBiWZYQCh+R6sGkHqvPkIRx+Mx1IIKRm1lVz3TVNoCUxwzj/dGHBbFzvqO9nLDU
         1Gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B86ESlgqkajdOaq6Bjknz3MFl+TpH2X5kP28d+2n8So=;
        b=qfS8OV1gZSEE1SVDrYUO7ShDLTK7FgRibP+ygbQQC6Od4duFZRvbAzeQ3Js/qr2iuF
         s2BxsQeY8CASx0DzI/p8+tTOd2UQOrYRs7PRFtpVhBCoUckQipolPIs8IBBgpTZOBE/K
         YfIzZCRZS64QQRpKbVZCJcYM6if37kYR8wZP19dRajKGLmVHJVZCmz3Csb0SbJsA6uNf
         1bXyWJN9sg5zYJH5J/iYDCg/5rWLpcTCUcvPuKO1qeqgaZ8cZZEqYl3tzTfVjstGT+LN
         jKowy00CSIO3rDu0gEbETxXGGBGoFkjIM/aKsVRA+T93P9TAh4ly45f4RKFofALa48fm
         xwTw==
X-Gm-Message-State: AOAM530JvEn3nM/8+d8lFxrtGaB5qTKmH1asEkSds8jjP+Fjclmu4X2p
        pyTehB2oh+trJuqsVEs4SeAvt2cK9tIUfp+Itac=
X-Google-Smtp-Source: ABdhPJysHZaAXCn7ljb1ZgUTt5qFYEkM2Ce4iInBur0+W1hWTONnSQgktIMzZ3lApaaxC8PXZp/Q9ygciQm2yWFKHp4=
X-Received: by 2002:a25:bb13:: with SMTP id z19mr1085813ybg.347.1630623952207;
 Thu, 02 Sep 2021 16:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-3-songliubraving@fb.com> <CAEf4BzZLSs3ejyVLPMORd_GPCYNE8Jz4M6=4wxzR576Vag-+-A@mail.gmail.com>
 <F7A1D3BF-357A-46FB-92EA-938DB99D8193@fb.com>
In-Reply-To: <F7A1D3BF-357A-46FB-92EA-938DB99D8193@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 2 Sep 2021 16:05:41 -0700
Message-ID: <CAEf4BzbpibAeK-PDiu0TEgKXXuU4MbPdfaaBB057e7DS2G35-A@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: introduce helper bpf_get_branch_snapshot
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 2, 2021 at 4:03 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Sep 2, 2021, at 3:53 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Sep 2, 2021 at 9:58 AM Song Liu <songliubraving@fb.com> wrote:
> >>
> >> Introduce bpf_get_branch_snapshot(), which allows tracing pogram to get
> >> branch trace from hardware (e.g. Intel LBR). To use the feature, the
> >> user need to create perf_event with proper branch_record filtering
> >> on each cpu, and then calls bpf_get_branch_snapshot in the bpf function.
> >> On Intel CPUs, VLBR event (raw event 0x1b00) can be use for this.
> >>
> >> Signed-off-by: Song Liu <songliubraving@fb.com>
> >> ---
> >> include/uapi/linux/bpf.h       | 22 ++++++++++++++++++++++
> >> kernel/bpf/trampoline.c        |  3 ++-
> >> kernel/trace/bpf_trace.c       | 33 +++++++++++++++++++++++++++++++++
> >> tools/include/uapi/linux/bpf.h | 22 ++++++++++++++++++++++
> >> 4 files changed, 79 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index 791f31dd0abee..c986e6fad5bc0 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -4877,6 +4877,27 @@ union bpf_attr {
> >>  *             Get the struct pt_regs associated with **task**.
> >>  *     Return
> >>  *             A pointer to struct pt_regs.
> >> + *
> >> + * long bpf_get_branch_snapshot(void *entries, u32 size, u64 flags)
> >> + *     Description
> >> + *             Get branch trace from hardware engines like Intel LBR. The
> >> + *             branch trace is taken soon after the trigger point of the
> >> + *             BPF program, so it may contain some entries after the
> >
> > This part is a leftover from previous design, so not relevant anymore?
>
> Hmm.. This is still relevant, but not very accurate. I guess we should
> provide more information, like "For more information about branches before
> the trigger point, this should be called early in the BPF program".

I read the part about "taken soon after the trigger point of BPF
program" as a reference to previous implementation. So maybe let's
clarify that because LBR is not frozen, from the time
bpf_get_branch_snapshot() is called to when we actually capture LBRs
we can waste few records due to internal kernel calls, so the user has
to be aware of that.

>
> Song
>
>
> >
> >> + *             trigger point. The user need to filter these entries
> >> + *             accordingly.
> >> + *
> >> + *             The data is stored as struct perf_branch_entry into output
> >> + *             buffer *entries*. *size* is the size of *entries* in bytes.
> >> + *             *flags* is reserved for now and must be zero.
> >> + *
> >> + *     Return
> >> + *             On success, number of bytes written to *buf*. On error, a
> >> + *             negative value.
> >> + *
> >> + *             **-EINVAL** if arguments invalid or **size** not a multiple
> >> + *             of **sizeof**\ (**struct perf_branch_entry**\ ).
> >> + *
> >> + *             **-ENOENT** if architecture does not support branch records.
> >
> > [...]
>
