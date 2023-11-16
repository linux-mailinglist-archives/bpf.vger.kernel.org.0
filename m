Return-Path: <bpf+bounces-15174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7037EE258
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 15:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581081C20BED
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 14:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A636315AF;
	Thu, 16 Nov 2023 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhgXfcfq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9559FB7
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 06:08:19 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9e623356d5dso122905166b.3
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 06:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700143698; x=1700748498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCDgqu7sWoAS0V1mochu50Ig11gLKauVGkXZUuzwspg=;
        b=JhgXfcfqYy4BoMqnrSLn9GA18gm7LZ5LIyhcdfZvXDnjfZvJLxuzenqd2s9j8G7/cM
         rHhydgvCOeKJ92h8v0fZbnrW3O94IYrP/hHLO0wf570RyoUhXuXv6raeJceQ383/N1Id
         rYMH3deLO/z46YK+jUILkPg3cRWCx7qKraq9A2PmaDNPsM1Me4m2fkVzrHdivjC/vOA5
         MSBOpq2NY/iJEU5ZwaI4SHy6I8HroNJGydhQ4QSSN7sJbs8geAfbopHpMXagIgtkaF1H
         KJfYlCiv3JReq4Esw136okKAqnX25cB+1BGWC0anpHO15427O08oYItM2zyt4btyfV1y
         5htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700143698; x=1700748498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCDgqu7sWoAS0V1mochu50Ig11gLKauVGkXZUuzwspg=;
        b=nvOjuHdB4GrsIk3oXrIlUSMyIQNmydp5FMRnH0BxDcgxHKPqrrSsuFqKq653Zp4/6D
         9ski7Dstsyi48ubqJW7RrKlwT3r7M6WP7V2CLj4jtvy1qo6Xba51YVbeAlBQJA7lRDIL
         LaPWqNbu2QuSSVTGot4/E4Du5pdKNdXjN9qvP0KXgitXN7rv+dk5x6ziBY/dwjRIfPrP
         pSvhQmWPorQ0KcEIpQKYjeTobC2qgTpLGY0h9tU9rK1uU+FKrsNog419sAO8rVkU68TR
         vRIEqfNxTLdderzBlCDvUeKXi8Oa5IBn+607LPPo8nNFYZtZZIKhKHtJOtF9wXKKx6pb
         kshg==
X-Gm-Message-State: AOJu0YzyXxVWsm2lMon9b7gl/JBQcnsd6dfFxwdnSyk8nOHDYIXIr9SY
	hes10zRET+YpDtLmmlBVsIF/Jt4FPRzgOtUezCU=
X-Google-Smtp-Source: AGHT+IEwFOxFC6BIsdqLGO3itNfAWXuxBGvdSx4wxH26z6ALqosMkWxuY9vbgpKiu6AFIOCnK30f1zdn79wUWInDiI8=
X-Received: by 2002:a17:906:c312:b0:9be:fc60:32d9 with SMTP id
 s18-20020a170906c31200b009befc6032d9mr11137752ejz.47.1700143697663; Thu, 16
 Nov 2023 06:08:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-11-eddyz87@gmail.com>
In-Reply-To: <20231116021803.9982-11-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Nov 2023 09:08:06 -0500
Message-ID: <CAEf4BzY8-97hcj2eKjo-uPoOJAnxy-jmbhRxxzQxO1naUiMHdg@mail.gmail.com>
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
> +               if (cur_func(env)->callback_depth < regs[BPF_REG_1].umax_=
value)

I haven't had time to look at the patch set properly yet and I'm not
sure if I'll have time today. But one thing that I randomly realized
is that if you are taking umax_value into account then this BPF_REG_1
has to be precise, so please make sure to mark_chain_precision() on it
first.

> +                       err =3D push_callback_call(env, insn, insn_idx, m=
eta.subprogno,
> +                                                set_loop_callback_state)=
;
> +               else
> +                       cur_func(env)->callback_depth =3D 0;
>                 break;
>         case BPF_FUNC_dynptr_from_mem:
>                 if (regs[BPF_REG_1].type !=3D PTR_TO_MAP_VALUE) {
> --
> 2.42.0
>

