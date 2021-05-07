Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC73937679D
	for <lists+bpf@lfdr.de>; Fri,  7 May 2021 17:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbhEGPHS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 11:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbhEGPHH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 May 2021 11:07:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65467C0613ED
        for <bpf@vger.kernel.org>; Fri,  7 May 2021 08:06:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id j26so6930543edf.9
        for <bpf@vger.kernel.org>; Fri, 07 May 2021 08:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IgK1hHKyIod+O+8vQ51EQR24MK/zjZq9hRixW9kyZ5w=;
        b=k1OGnvaWid31eLD2CbXbr1kp6CWhDCWgeR408AMikThstfqYDJxvhgRW6+75lMp2Qe
         tINU7XA0SE0ou5tJCHaPZaer8t91zkM+MScVELhoyGam6Sp4L3S4r/J2xu4UHWA1S03i
         I6VE8fF6nuggwQcXerKMoY/SrY6KqDdy6C/stuKMgUoeo5xcrlGS1NEzs77flm39mWGW
         GJkNyZ2cTRZbgWaQxIhw+O9Vzfm7QNQy/R3cvWFbxqrRUMR1du859heVsZH3sOTnhfpl
         3iKp74kFIkpinAuKzxOPxYp20WCJ1BfrQsrxPOv8gHIT8q32qH4oQwfYqI0j1AAl72q2
         1kUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IgK1hHKyIod+O+8vQ51EQR24MK/zjZq9hRixW9kyZ5w=;
        b=B31l1umNSpNX/2HF0GK3HOHm6CPff2hfDItM280y3rGy6jdGoOpBhy2D6Za83gp2yR
         bqM/Vl6TntGEXL6kY7z6PNKt82LM/CElphU9lbGJQKriD4mByC5PemSLzPgdsfX1AVga
         Rw9Zz+gvlivhmJH3exrMTVy0nlXjcAJJdBUwuL/UGKEn/afCzTHU+wbR/Y95y3SqNi6m
         Zj1D81X8wB6xcrCU8eH6eZOiNqRy9dro0+6vwKXRVhkBnbjmAtnpuLT59o3dy98wbvAO
         VjS2lTQenfuvGYSAUvvh7YjrZhTNFkWYQSGmxLkVbnFU8/HkECOJhRNohg6Ezojqa3MF
         JxBQ==
X-Gm-Message-State: AOAM533TnMQ5+K5DP1C6+enGR89z+rYS7rlbBwRgNuoi5nGBsZE/93HP
        watwCxcRYenm7E8R304Yh+yNI3hVyimXDun5KeT1HnOQvfk=
X-Google-Smtp-Source: ABdhPJw+YbNxPhmrim56BHmLUxlRtcocYYCjzE50ZEm5UBHZiqMUacq2a8yo0EG/vWk/B6SupNuzoqrHa2KdF8QO/oE=
X-Received: by 2002:aa7:d915:: with SMTP id a21mr12326438edr.357.1620399964932;
 Fri, 07 May 2021 08:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210421122348.547922-1-jackmanb@google.com> <94c4f7b0-c64e-e580-7d9b-a0a65e2fe33d@fb.com>
 <3933ce3c-6161-2309-88bb-72707997ed76@fb.com> <CA+i-1C0tV0m+HY1WwivrYE-iouF9b8NGVSXhL_ZmRz6JL36TzA@mail.gmail.com>
 <0da3a605-198f-cd1b-f6f2-7ca95082fd94@fb.com>
In-Reply-To: <0da3a605-198f-cd1b-f6f2-7ca95082fd94@fb.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Fri, 7 May 2021 17:05:53 +0200
Message-ID: <CA+i-1C0K1-b04-3w32J6CJ18CN=9brddn80zuOEpTjwS=fODFA@mail.gmail.com>
Subject: Re: Help with verifier failure
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 22 Apr 2021 at 16:35, Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 4/22/21 6:55 AM, Brendan Jackman wrote:
> > On Wed, 21 Apr 2021 at 18:59, Yonghong Song <yhs@fb.com> wrote:
> >> On 4/21/21 8:06 AM, Yonghong Song wrote:
> >>> On 4/21/21 5:23 AM, Brendan Jackman wrote:
> >>> Thanks, Brendan. Looks at least the verifier failure is triggered
> >>> by recent clang changes. I will take a look whether we could
> >>> improve verifier for such a case and whether we could improve
> >>> clang to avoid generate such codes the verifier doesn't like.
> >>> Will get back to you once I had concrete analysis.
> >>>
> >>>>
> >>>> This seems like it must be a common pitfall, any idea what we can do
> >>>> to fix it
> >>>> and avoid it in future? Am I misunderstanding the issue?
> >>
> >> First, for the example code you provided, I checked with llvm11, llvm12
> >> and latest trunk llvm (llvm13-dev) and they all generated similar codes,
> >> which may trigger verifier failure. Somehow you original code could be
> >> different may only show up with a recent llvm, I guess.
> >>
> >> Checking llvm IR, the divergence between "w2 = w8" and "if r8 < 0x1000"
> >> appears in insn scheduling phase related handling PHIs. Need to further
> >> check whether it is possible to prevent the compiler from generating
> >> such codes.
> >>
> >> The latest kernel already had the ability to track register equivalence.
> >> However, the tracking is conservative for 32bit mov like "w2 = w8" as
> >> you described in the above. if we have code like "r2 = r8; if r8 <
> >> 0x1000 ...", we will be all good.
> >>
> >> The following hack fixed the issue,
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 58730872f7e5..54f418fd6a4a 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -7728,12 +7728,20 @@ static int check_alu_op(struct bpf_verifier_env
> >> *env, struct bpf_insn *insn)
> >>                                                   insn->src_reg);
> >>                                           return -EACCES;
> >>                                   } else if (src_reg->type == SCALAR_VALUE) {
> >> +                                       /* If src_reg is in 32bit range,
> >> there is
> >> +                                        * no need to reset the ID.
> >> +                                        */
> >> +                                       bool is_32bit_src =
> >> src_reg->umax_value <= 0x7fffffff;
> >> +
> >> +                                       if (is_32bit_src && !src_reg->id)
> >> +                                               src_reg->id = ++env->id_gen;
> >>                                           *dst_reg = *src_reg;
> >>                                           /* Make sure ID is cleared
> >> otherwise
> >>                                            * dst_reg min/max could be
> >> incorrectly
> >>                                            * propagated into src_reg by
> >> find_equal_scalars()
> >>                                            */
> >> -                                       dst_reg->id = 0;
> >> +                                       if (!is_32bit_src)
> >> +                                               dst_reg->id = 0;
> >>                                           dst_reg->live |= REG_LIVE_WRITTEN;
> >>                                           dst_reg->subreg_def =
> >> env->insn_idx + 1;
> >>                                   } else {
> >>
> >> Basically, for a 32bit mov insn like "w2 = w8", if we can ensure
> >> that "w8" is 32bit and has no possibility that upper 32bit is set
> >> for r8, we can declare them equivalent. This fixed your issue.

I just got around to looking into this - spent some time reading and
realised it's simpler than I thought :) I also double checked that it
fixes the test with my current Clang too.

Beyond cleaning up and putting it into a patch, did you have anything
in particular in mind when you called this a "hack"?

Do I understand correctly that in this code we only need to check
umax_value, because it anyway gets folded into the other bounds fields
during adjust_min_max_reg_vals?

It seems like the next rung on the "ladder" of solution completeness
here would be quite a big step up, something like a more comprehensive
representation of register relationships (instead of just "these regs
have the same value" vs. "these regs have no relationship"), which I
guess would be more extreme than necessary right now.
