Return-Path: <bpf+bounces-15248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2017EF68C
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 17:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C711C20AF2
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7243EA93;
	Fri, 17 Nov 2023 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlmwCUrg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04A7196
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:47:19 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54864b675b2so144459a12.2
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700239638; x=1700844438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nNCOKuqecOUBXxQSHFAwSuVTd2k0l0OufmrNmQ96uw=;
        b=PlmwCUrgUl7JrWaL05oRCf8edGO+Li8Wv/3NVmbbiQX7QYD7c0O4WhSl3cMSFiDtmk
         8umhmSa+UdZh8mpir+HFlTXBlHiwUzP79Pmf1R1rxtpbXJSFrhMxerpBxURQfUxGUoRW
         UclPbo4uFpEmHNI7TxtmqEaiyN2f52q3QFURrBcNMsfpHkcjnlKLODwuKFL2hOmri2r3
         mcQiFUneKxNnIPsa+eS/2gP6nYXZx3qzdzMAY7m2IOtREt6d8vcMhXVFYMC/bnKkfEiR
         iSWxblFWM5/WFu6Ib6/2nlvcFbHh190lUsOSIpdd12iG0K3ZusxK5T6L0V6OSQCkyxTa
         iuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239638; x=1700844438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nNCOKuqecOUBXxQSHFAwSuVTd2k0l0OufmrNmQ96uw=;
        b=hOJA2UK0FPKBE1Wx9bxHiN4Ez6hYO4wt18XEK68tghvCKMDLmI9Xuugoe2hVz1kScw
         vQSnQlHZh3bEQOVgW8IHW+mRZvoafku6Y+NGIOwE/OEZaINghlkygwD/4fvx/Mh35rP6
         EKNq4ZlnlXbkTfQuIX5Cuc+FYcKbUOwpi2aRtKg2TRn9ofv+koPTIDy93iJ9J+SeUQrr
         quJhdBUysEfk0rlmy7WUpuHN2C0n8lRvz1aMomyQvq3OTlzOet+eIHbuyH6qg4BbOFpq
         XDEiuMZU40if9XTEO8FwuGPTBBDsG1QpeEesYdWr6/kji3562AeYHUUEMn5+z0z9D4ec
         PiMQ==
X-Gm-Message-State: AOJu0Yxb+A9nl7WI2334c2NElyFAeluJdsblRWSga8X1yAclAv6KtHRX
	vY2h9I/IRYwA/Wlt6twW6NSvLEr5nRGn+vCUq38=
X-Google-Smtp-Source: AGHT+IFC9/x2YCQTvkP4SmDsfl/mzgphLQQDq1FOzcEyrEmL0PEKKSFlj4ZF7+wVvStB6W7mOZ/GyB/YCz+kYxpBhF0=
X-Received: by 2002:aa7:d4c3:0:b0:540:31dc:ff8b with SMTP id
 t3-20020aa7d4c3000000b0054031dcff8bmr15336709edr.13.1700239638395; Fri, 17
 Nov 2023 08:47:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-11-eddyz87@gmail.com>
In-Reply-To: <20231116021803.9982-11-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 11:47:07 -0500
Message-ID: <CAEf4BzbP9rh1Qb1eyANQn4yrR78q1+VL5R=GGyJihpaZJui0tA@mail.gmail.com>
Subject: Re: [PATCH bpf 10/12] bpf: keep track of max number of bpf_loop
 callback iterations
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 9:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> In some cases verifier can't infer convergence of the bpf_loop()
> iteration. E.g. for the following program:
>
>     static int cb(__u32 idx, struct num_context* ctx)
>     {
>         ctx->i++;
>         return 0;
>     }
>
>     SEC("?raw_tp")
>     int prog(void *_)
>     {
>         struct num_context ctx =3D { .i =3D 0 };
>         __u8 choice_arr[2] =3D { 0, 1 };
>
>         bpf_loop(2, cb, &ctx, 0);
>         return choice_arr[ctx.i];
>     }
>
> Each 'cb' simulation would eventually return to 'prog' and reach
> 'return choice_arr[ctx.i]' statement. At which point ctx.i would be
> marked precise, thus forcing verifier to track multitude of separate
> states with {.i=3D0}, {.i=3D1}, ... at bpf_loop() callback entry.
>
> This commit allows "brute force" handling for such cases by limiting
> number of callback body simulations using 'umax' value of the first
> bpf_loop() parameter.
>
> For this, extend bpf_func_state with 'callback_depth' field.
> Increment this field when callback visiting state is pushed to states
> traversal stack. For frame #N it's 'callback_depth' field counts how
> many times callback with frame depth N+1 had been executed.
> Use bpf_func_state specifically to allow independent tracking of
> callback depths when multiple nested bpf_loop() calls are present.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  9 +++++++++
>  kernel/bpf/verifier.c        | 12 ++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 0ffb479c72d8..302f9c310de7 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -301,6 +301,15 @@ struct bpf_func_state {
>         struct tnum callback_ret_range;
>         bool in_async_callback_fn;
>         bool in_exception_callback_fn;
> +       /* For callback calling functions that limit number of possible
> +        * callback executions (e.g. bpf_loop) keeps track of current
> +        * simulated iteration number. When non-zero either:
> +        * - current frame has a child frame, in such case it's callsite =
points
> +        *   to callback calling function;
> +        * - current frame is a topmost frame, in such case callback has =
just
> +        *   returned and env->insn_idx points to callback calling functi=
on.
> +        */
> +       u32 callback_depth;
>
>         /* The following fields should be last. See copy_func_state() */
>         int acquired_refs;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5b8c0ebcb4f6..474af277ea54 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9680,6 +9680,8 @@ static int push_callback_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *ins
>                 return err;
>
>         callback_state->callback_iter_depth++;
> +       callback_state->frame[callback_state->curframe - 1]->callback_dep=
th++;
> +       caller->callback_depth =3D 0;
>         return 0;
>  }
>
> @@ -10479,8 +10481,14 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>                 break;
>         case BPF_FUNC_loop:
>                 update_loop_inline_state(env, meta.subprogno);
> -               err =3D push_callback_call(env, insn, insn_idx, meta.subp=
rogno,
> -                                        set_loop_callback_state);
> +               if (env->log.level & BPF_LOG_LEVEL2)
> +                       verbose(env, "frame%d callback_depth=3D%u\n",
> +                               env->cur_state->curframe, cur_func(env)->=
callback_depth);

btw, is this a debugging leftover or intentional? If the latter, why
is it done only for bpf_loop()? Maybe push_callback_call() be a better
place for it?

> +               if (cur_func(env)->callback_depth < regs[BPF_REG_1].umax_=
value)
> +                       err =3D push_callback_call(env, insn, insn_idx, m=
eta.subprogno,
> +                                                set_loop_callback_state)=
;
> +               else
> +                       cur_func(env)->callback_depth =3D 0;

I guess it's actually a bit more interesting to know that we stopped
iterating because umax is reached. But I'm actually not sure whether
we should be adding these logs at all, though I don't have a strong
preference.



>                 break;
>         case BPF_FUNC_dynptr_from_mem:
>                 if (regs[BPF_REG_1].type !=3D PTR_TO_MAP_VALUE) {
> --
> 2.42.0
>

