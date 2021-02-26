Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615F2326747
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 20:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhBZTNO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 14:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhBZTNN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 14:13:13 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCB6C061574
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 11:12:33 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id m188so9915593yba.13
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 11:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Wb4PPqp0eatFADyHGq8rTnbGIK5vS9XU6Hz4zvNW8g=;
        b=vSS62N39tbQIy4g5dEdyqpLE6wUJU8ihTya1DKxbsgew4YGbv8QRTRgCkin0GpXgPK
         Io0Q5xwK6KZnOeJWis9j066Lmx6JCi5jY9a1cKcMZJ6EsZeDAsgCBSITLvWIm64P7pae
         9J7cZleFgeaDUjg5lJsTWL/GK43PQrlMULzaj3M1EN8GU1+Tiqb0Ay0DfBviFgK1+BRe
         vDwNxiJ0syw354/H0DdLBTec2sIrIWMoMSQR+6sAOvvRJGgH4MiHXEBF/wSpb5pCvanh
         i0z3CTgPEVfLtaTe/gUJFQXUSGrwihdf4oczzFL8jATXt95+xrUOkC6RTHaJlAO8AXzo
         chog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Wb4PPqp0eatFADyHGq8rTnbGIK5vS9XU6Hz4zvNW8g=;
        b=Gzb/7hewBWWZXTod+gXKF8nnooHxciEAzENqyjMZ0WWD1GW6Udqk6ErLNIjd0iNgip
         Q/oNTNPIy/B6B6QGF6CKGaXxFVDxv8hM4wFj1YTLUc+lryJAsKbZab4AEUT7Mzc+iRF0
         by7L8QJKb13ahYf4yOgC2PEGdqOITrNmyMt81/1yBgLU+E4G5vHDLhoYNKBdOs5JC6Dp
         qgMwA17E9CFSliY7ePB4OGsAAF/OuaZItVysvRRVU0JkH/B7IL6giUmLxkHCZc+It5LW
         W7E5sv3BRVPZOjPyqxiajGgDZzxsrYdhtXjjWeKsH0EsfMjrikoAvxpEuhAuU8vuDEir
         RXiw==
X-Gm-Message-State: AOAM530Ras8yx03oqCQinvD2DW3fSrHSUxeQU6+kWAKtuq6j7yBmVMGO
        Q7/oEdBGq7sjbLWlJefwQnhivkY/PRn2lrZAD7o=
X-Google-Smtp-Source: ABdhPJxvPZOaZUNyQTaDVD73FZvygv6KyO1WhTgeiEVCxvwP74IFJmQir8E6w53JqA+J0eQ0tOx+1i0O6l0Pyzu8Wy8=
X-Received: by 2002:a25:1e89:: with SMTP id e131mr6627245ybe.459.1614366752780;
 Fri, 26 Feb 2021 11:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20210226051305.3428235-1-yhs@fb.com> <20210226051305.3428292-1-yhs@fb.com>
In-Reply-To: <20210226051305.3428292-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Feb 2021 11:12:21 -0800
Message-ID: <CAEf4BzbhJDfAqxV11W5eWFVWw+WthGo42GtQk9mkz2-K+-JsUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 01/12] bpf: factor out visit_func_call_insn()
 in check_cfg()
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 25, 2021 at 9:17 PM Yonghong Song <yhs@fb.com> wrote:
>
> During verifier check_cfg(), all instructions are
> visited to ensure verifier can handle program control flows.
> This patch factored out function visit_func_call_insn()
> so it can be reused in later patch to visit callback function
> calls. There is no functionality change for this patch.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/verifier.c | 35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1dda9d81f12c..9cb182e91162 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8592,6 +8592,27 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
>         return DONE_EXPLORING;
>  }
>
> +static int visit_func_call_insn(int t, int insn_cnt,
> +                               struct bpf_insn *insns,
> +                               struct bpf_verifier_env *env,
> +                               bool visit_callee)
> +{
> +       int ret;
> +
> +       ret = push_insn(t, t + 1, FALLTHROUGH, env, false);
> +       if (ret)
> +               return ret;
> +
> +       if (t + 1 < insn_cnt)
> +               init_explored_state(env, t + 1);
> +       if (visit_callee) {
> +               init_explored_state(env, t);
> +               ret = push_insn(t, t + insns[t].imm + 1, BRANCH,
> +                               env, false);
> +       }
> +       return ret;
> +}
> +
>  /* Visits the instruction at index t and returns one of the following:
>   *  < 0 - an error occurred
>   *  DONE_EXPLORING - the instruction was fully explored
> @@ -8612,18 +8633,8 @@ static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)
>                 return DONE_EXPLORING;
>
>         case BPF_CALL:
> -               ret = push_insn(t, t + 1, FALLTHROUGH, env, false);
> -               if (ret)
> -                       return ret;
> -
> -               if (t + 1 < insn_cnt)
> -                       init_explored_state(env, t + 1);
> -               if (insns[t].src_reg == BPF_PSEUDO_CALL) {
> -                       init_explored_state(env, t);
> -                       ret = push_insn(t, t + insns[t].imm + 1, BRANCH,
> -                                       env, false);
> -               }
> -               return ret;
> +               return visit_func_call_insn(t, insn_cnt, insns, env,
> +                                           insns[t].src_reg == BPF_PSEUDO_CALL);
>
>         case BPF_JA:
>                 if (BPF_SRC(insns[t].code) != BPF_K)
> --
> 2.24.1
>
