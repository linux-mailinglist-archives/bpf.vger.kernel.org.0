Return-Path: <bpf+bounces-15475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593B17F22CC
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 02:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D522CB21878
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 01:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35B91861;
	Tue, 21 Nov 2023 01:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUAvib0g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34258A2
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 17:04:31 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c6b30aca06so61890711fa.3
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 17:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700528669; x=1701133469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6IKxQAcbr62zTiK30wWFl/78kGTTFjVKFOCIzTX/m4=;
        b=JUAvib0ge5kccHHOsukQ3AC/4qY5A2TJAnnCJVzrEBCm60JiLdx3G4u5+Dj9p3/RSU
         0ZIufnkCL85EBndELxZBdVefQnsCtlIyoxQTHH3WHGVoOWgAa6Up015Z0/M9u3BqEJeJ
         7U5yVcyKObzS+ycUK1zo4LZ64rxXvbOENBunSsnkZcuhCC22mAN7VvjBUUWbwXNThAXQ
         7UTxSTQyGZyu5yq+2vYC6n+qbqSqjsQ2qgZNd/8rmIPAP00N60eAv5JeufNjCuAo5+zN
         HXKghHsELsIal/2byLJmlb1HRp205gOCnf/Y//GSeH83RjG/SoJn0zLV8nOGH7ZET/or
         hqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700528669; x=1701133469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6IKxQAcbr62zTiK30wWFl/78kGTTFjVKFOCIzTX/m4=;
        b=ikX31HCZ+a6KeF2s3Tum8pTaQBVnSvEHk1CVh8wvbgHZb+/R17dK2QoxXhTK1SGLDS
         RIETHi6ahOPLxAptb6ugDFFc6D9vi0VUe3APuK44D7D4QfF9DNPR9uxbKL0FFcg7bQkd
         /wdsX1AnQ+RiAut7ipQJm4/nnFrAw8RnUyUH4R4/4zwY94umY0bQScVNBDKmEG6Sg4I7
         /TJ3FrjZjsS7//yJOSp2PrAfQOzGqlwchEiOYEXzEvTafzqJENqzpRFH52wsg072EsS6
         BHIrjUTGnbq7FJn9VXgq6B2esgit8LFaV5G2U1VtM3Ri4nLJ2nE1q6c7YVnKLP1iDj5s
         X9TQ==
X-Gm-Message-State: AOJu0YzrASWFj7wpPPkpuGgdIAKYG7FHwOw7BK4onrrMcHXdMto8C/Ft
	5sYLyG7V5Wcei22I5Uh2TP1f4BLQptcAxk2t1xE=
X-Google-Smtp-Source: AGHT+IFJndBPvdmCCjw2+E/3OATdfHLIG1kjG8zM+bXnM3vmMMwLRtOTxPiXKbhafufGOm+TXYX1UBiukcgeWD6T+8w=
X-Received: by 2002:a2e:2245:0:b0:2c8:713c:b506 with SMTP id
 i66-20020a2e2245000000b002c8713cb506mr6260240lji.43.1700528669099; Mon, 20
 Nov 2023 17:04:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120225945.11741-1-eddyz87@gmail.com> <20231120225945.11741-11-eddyz87@gmail.com>
In-Reply-To: <20231120225945.11741-11-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 20 Nov 2023 17:04:18 -0800
Message-ID: <CAEf4BzZc8eCQ=2qCqWD9+LHobrSA3cxQ-yHpVFm4zRQ0Phn1bg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 10/11] bpf: keep track of max number of bpf_loop
 callback iterations
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 3:00=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
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
>  include/linux/bpf_verifier.h                  | 11 ++++++
>  kernel/bpf/verifier.c                         | 17 +++++++--
>  .../bpf/progs/verifier_subprog_precision.c    | 35 +++++++++++++------
>  3 files changed, 51 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 6e21d74a64e7..9ed6672534c7 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -301,6 +301,17 @@ struct bpf_func_state {
>         struct tnum callback_ret_range;
>         bool in_async_callback_fn;
>         bool in_exception_callback_fn;
> +       /* For callback calling functions that limit number of possible
> +        * callback executions (e.g. bpf_loop) keeps track of current
> +        * simulated iteration number.
> +        * Value in frame N refers to number of times callback with frame
> +        * N+1 was simulated, e.g. for the following call:
> +        *
> +        *   bpf_loop(..., fn, ...); | suppose current frame is N
> +        *                           | fn would be simulated in frame N+1
> +        *                           | number of simulations is tracked i=
n frame N
> +        */
> +       u32 callback_depth;
>
>         /* The following fields should be last. See copy_func_state() */
>         int acquired_refs;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 004de7c32bae..37d8c22c292a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9505,6 +9505,8 @@ static int push_callback_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *ins
>                 return err;
>
>         callback_state->cumulative_callback_depth++;
> +       callback_state->frame[callback_state->curframe - 1]->callback_dep=
th++;
> +       caller->callback_depth =3D 0;
>         return 0;
>  }
>
> @@ -10309,8 +10311,19 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>                 break;
>         case BPF_FUNC_loop:
>                 update_loop_inline_state(env, meta.subprogno);
> -               err =3D push_callback_call(env, insn, insn_idx, meta.subp=
rogno,
> -                                        set_loop_callback_state);
> +               /* Verifier relies on R1 value to determine if bpf_loop()=
 iteration
> +                * is finished, thus mark it precise.
> +                */
> +               mark_chain_precision(env, BPF_REG_1);

huh? What about error handling?

> +               if (cur_func(env)->callback_depth < regs[BPF_REG_1].umax_=
value) {
> +                       err =3D push_callback_call(env, insn, insn_idx, m=
eta.subprogno,
> +                                                set_loop_callback_state)=
;
> +               } else {
> +                       cur_func(env)->callback_depth =3D 0;
> +                       if (env->log.level & BPF_LOG_LEVEL2)
> +                               verbose(env, "frame%d bpf_loop iteration =
limit reached\n",
> +                                       env->cur_state->curframe);
> +               }
>                 break;
>         case BPF_FUNC_dynptr_from_mem:
>                 if (regs[BPF_REG_1].type !=3D PTR_TO_MAP_VALUE) {
> diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision=
.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> index da803cffb5ef..f61d623b1ce8 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> @@ -119,7 +119,23 @@ __naked int global_subprog_result_precise(void)
>
>  SEC("?raw_tp")
>  __success __log_level(2)
> -/* First simulated path does not include callback body */
> +/* First simulated path does not include callback body,
> + * r1 and r4 are always precise for bpf_loop() calls.
> + */
> +__msg("9: (85) call bpf_loop#181")
> +__msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
> +__msg("mark_precise: frame0: parent state regs=3Dr4 stack=3D:")
> +__msg("mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx 9")
> +__msg("mark_precise: frame0: regs=3Dr4 stack=3D before 8: (b7) r4 =3D 0"=
)
> +__msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
> +__msg("mark_precise: frame0: parent state regs=3Dr1 stack=3D:")
> +__msg("mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx 9")
> +__msg("mark_precise: frame0: regs=3Dr1 stack=3D before 8: (b7) r4 =3D 0"=
)
> +__msg("mark_precise: frame0: regs=3Dr1 stack=3D before 7: (b7) r3 =3D 0"=
)
> +__msg("mark_precise: frame0: regs=3Dr1 stack=3D before 6: (bf) r2 =3D r8=
")
> +__msg("mark_precise: frame0: regs=3Dr1 stack=3D before 5: (bf) r1 =3D r6=
")
> +__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 4: (b7) r6 =3D 3"=
)
> +/* r6 precision propagation */
>  __msg("14: (0f) r1 +=3D r6")
>  __msg("mark_precise: frame0: last_idx 14 first_idx 9")
>  __msg("mark_precise: frame0: regs=3Dr6 stack=3D before 13: (bf) r1 =3D r=
7")
> @@ -134,10 +150,9 @@ __msg("17: (b7) r0 =3D 0")
>  __msg("18: (95) exit")
>  __msg("returning from callee:")
>  __msg("to caller at 9:")
> -/* r4 (flags) is always precise for bpf_loop() */
> -__msg("frame 0: propagating r4")
> +__msg("frame 0: propagating r1,r4")
>  __msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
> -__msg("mark_precise: frame0: regs=3Dr4 stack=3D before 18: (95) exit")
> +__msg("mark_precise: frame0: regs=3Dr1,r4 stack=3D before 18: (95) exit"=
)
>  __msg("from 18 to 9: safe")
>  __naked int callback_result_precise(void)
>  {
> @@ -264,12 +279,12 @@ __msg("15: (b7) r0 =3D 0")
>  __msg("16: (95) exit")
>  __msg("returning from callee:")
>  __msg("to caller at 9:")
> -/* r4 (flags) is always precise for bpf_loop(),
> +/* r1, r4 are always precise for bpf_loop(),
>   * r6 was marked before backtracking to callback body.
>   */
> -__msg("frame 0: propagating r4,r6")
> +__msg("frame 0: propagating r1,r4,r6")
>  __msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
> -__msg("mark_precise: frame0: regs=3Dr4,r6 stack=3D before 16: (95) exit"=
)
> +__msg("mark_precise: frame0: regs=3Dr1,r4,r6 stack=3D before 16: (95) ex=
it")
>  __msg("mark_precise: frame1: regs=3D stack=3D before 15: (b7) r0 =3D 0")
>  __msg("mark_precise: frame1: regs=3D stack=3D before 9: (85) call bpf_lo=
op")
>  __msg("mark_precise: frame0: parent state regs=3D stack=3D:")
> @@ -422,12 +437,12 @@ __msg("17: (b7) r0 =3D 0")
>  __msg("18: (95) exit")
>  __msg("returning from callee:")
>  __msg("to caller at 10:")
> -/* r4 (flags) is always precise for bpf_loop(),
> +/* r1, r4 are always precise for bpf_loop(),
>   * fp-8 was marked before backtracking to callback body.
>   */
> -__msg("frame 0: propagating r4,fp-8")
> +__msg("frame 0: propagating r1,r4,fp-8")
>  __msg("mark_precise: frame0: last_idx 10 first_idx 10 subseq_idx -1")
> -__msg("mark_precise: frame0: regs=3Dr4 stack=3D-8 before 18: (95) exit")
> +__msg("mark_precise: frame0: regs=3Dr1,r4 stack=3D-8 before 18: (95) exi=
t")
>  __msg("mark_precise: frame1: regs=3D stack=3D before 17: (b7) r0 =3D 0")
>  __msg("mark_precise: frame1: regs=3D stack=3D before 10: (85) call bpf_l=
oop#181")
>  __msg("mark_precise: frame0: parent state regs=3D stack=3D:")
> --
> 2.42.1
>

