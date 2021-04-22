Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B41F3681F7
	for <lists+bpf@lfdr.de>; Thu, 22 Apr 2021 15:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbhDVN4J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Apr 2021 09:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhDVN4J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Apr 2021 09:56:09 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25D4C06138B
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 06:55:34 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b9so15822615iod.13
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 06:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=stwSr3IA5sn78Uz4bhEUBctzdSAEhhRuapERpH3b3WA=;
        b=keiowMGE3Mt1a+OsE9i6JvGrQXxYq0Z/fYxoVkGxNSeNQ4Dp3qV8/n/lf7Bb5w1GvQ
         iSi/eJCXAVhBzvnOLBaCwaSyTlcZeWB4YMKf9zfOT/zEeeUN3PzL2Xk1QkwdPqp5koxl
         dEp7aI8vkXMlCmT4gya82+VcIjzPWG4GLQgYXPXUcbk0FDx2rEFpfhWWR6n5SMLiRdSh
         b+IO+vcDloWHxeIVEosUJR3V5kqu1YuASCBipYhAz7LcaPgg73o7dnhOJ0rjihZ4LJSA
         q+WJC5cH8RB1Q2l0CZffqkkDJzFnrCRlYK3c0WtUxjDJoLE9MV8vx0U61nMRoEE7yjaz
         cXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stwSr3IA5sn78Uz4bhEUBctzdSAEhhRuapERpH3b3WA=;
        b=fVe5okwf0GEi79cZ5zW3FctmoiiUqWIkY79q97zjAcf6KY/q17M7H7peckebseT0bP
         Z2hJQKEyNx/ECJdmu1vE25rPIT1EBP+c+0IJdJSMORlBWXm9HBoc38avZTEpiMzPztvK
         bWlLillpIVFaB1p+u6hf9Nj5su59onLIvUzd2aewhG4otlkjj3V0nJisXSJiEvN0ZT15
         YT7StR12EDi9aa5tieQK1r7r+IpQTnFM2rHd+438W5EYAso5c42FlTUupAuLWFPmqp5k
         Wdk0CO/Di0fYWey268H8J0g5Ot0mryru3tuRoaXvXiBIozrqMx8BJ4ijdaVmaSGCS3L3
         B3Jw==
X-Gm-Message-State: AOAM532PhBB7sDofuCFoNr+eVQZuB8NAFwv58zPZpRTOYDXkWMJdIV6f
        DcT/YdZT38d7BOv1EClBHyE+3NDFKVPzDNxdEffZVA==
X-Google-Smtp-Source: ABdhPJx3uLv09AOc6LYEGfaDhkBWTZmyZUnSfpNo7Thp+HjfD7+3OPL+rszRbunFwHHrpyFS3Lv9Qr1DB2H0mGdAdtg=
X-Received: by 2002:a02:3f08:: with SMTP id d8mr3232523jaa.141.1619099733903;
 Thu, 22 Apr 2021 06:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210421122348.547922-1-jackmanb@google.com> <94c4f7b0-c64e-e580-7d9b-a0a65e2fe33d@fb.com>
 <3933ce3c-6161-2309-88bb-72707997ed76@fb.com>
In-Reply-To: <3933ce3c-6161-2309-88bb-72707997ed76@fb.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Thu, 22 Apr 2021 15:55:22 +0200
Message-ID: <CA+i-1C0tV0m+HY1WwivrYE-iouF9b8NGVSXhL_ZmRz6JL36TzA@mail.gmail.com>
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

On Wed, 21 Apr 2021 at 18:59, Yonghong Song <yhs@fb.com> wrote:
> On 4/21/21 8:06 AM, Yonghong Song wrote:
> > On 4/21/21 5:23 AM, Brendan Jackman wrote:
> > Thanks, Brendan. Looks at least the verifier failure is triggered
> > by recent clang changes. I will take a look whether we could
> > improve verifier for such a case and whether we could improve
> > clang to avoid generate such codes the verifier doesn't like.
> > Will get back to you once I had concrete analysis.
> >
> >>
> >> This seems like it must be a common pitfall, any idea what we can do
> >> to fix it
> >> and avoid it in future? Am I misunderstanding the issue?
>
> First, for the example code you provided, I checked with llvm11, llvm12
> and latest trunk llvm (llvm13-dev) and they all generated similar codes,
> which may trigger verifier failure. Somehow you original code could be
> different may only show up with a recent llvm, I guess.
>
> Checking llvm IR, the divergence between "w2 = w8" and "if r8 < 0x1000"
> appears in insn scheduling phase related handling PHIs. Need to further
> check whether it is possible to prevent the compiler from generating
> such codes.
>
> The latest kernel already had the ability to track register equivalence.
> However, the tracking is conservative for 32bit mov like "w2 = w8" as
> you described in the above. if we have code like "r2 = r8; if r8 <
> 0x1000 ...", we will be all good.
>
> The following hack fixed the issue,
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 58730872f7e5..54f418fd6a4a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7728,12 +7728,20 @@ static int check_alu_op(struct bpf_verifier_env
> *env, struct bpf_insn *insn)
>                                                  insn->src_reg);
>                                          return -EACCES;
>                                  } else if (src_reg->type == SCALAR_VALUE) {
> +                                       /* If src_reg is in 32bit range,
> there is
> +                                        * no need to reset the ID.
> +                                        */
> +                                       bool is_32bit_src =
> src_reg->umax_value <= 0x7fffffff;
> +
> +                                       if (is_32bit_src && !src_reg->id)
> +                                               src_reg->id = ++env->id_gen;
>                                          *dst_reg = *src_reg;
>                                          /* Make sure ID is cleared
> otherwise
>                                           * dst_reg min/max could be
> incorrectly
>                                           * propagated into src_reg by
> find_equal_scalars()
>                                           */
> -                                       dst_reg->id = 0;
> +                                       if (!is_32bit_src)
> +                                               dst_reg->id = 0;
>                                          dst_reg->live |= REG_LIVE_WRITTEN;
>                                          dst_reg->subreg_def =
> env->insn_idx + 1;
>                                  } else {
>
> Basically, for a 32bit mov insn like "w2 = w8", if we can ensure
> that "w8" is 32bit and has no possibility that upper 32bit is set
> for r8, we can declare them equivalent. This fixed your issue.
>
> Will try to submit a formal patch later.

Ah.. I did not realise this equivalence tracking with reg.id was there
for scalar values! I also didn't take any notice of the use of 32-bit
operations in the assembly, thanks for pointing that out.

Yes it sounds like this is certainly worth fixing in the kernel - even
if Clang stops generating the code today it will probably start doing
so again in the future. I can also help with the verifier work if
needed.
