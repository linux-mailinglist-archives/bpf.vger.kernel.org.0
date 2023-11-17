Return-Path: <bpf+bounces-15244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7617EF688
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 17:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF86E1C20AC1
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 16:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328953EA6A;
	Fri, 17 Nov 2023 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEjAD8MD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9E0A4
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:47:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-543923af573so3317234a12.0
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700239624; x=1700844424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Thx8LLnaaRodv164Y7EegfEHoh5Her4BVqcftkBpp8=;
        b=BEjAD8MDf/qWXk8O81iHIvxiDrY2JlLk58uYl6qjr5VeE2edjO0qHhbrNXw9Mrbykh
         lzjBYAiCZiMF+ypwbrRvEDeOlxLKRZIcfyFX87q8IxCV/CINuCodXSPt3Nv1dmkPF4k6
         SNe9eu4tmYJTDduxNQ7ZbR3jNPZctDI7bjjLduFoWbh8sjp2vlPW+nrI85CH4uBuDVPA
         cdSbYwMANCy61pzH5kkP075fWv/mGAyooeDedWZkFZDLysfG/PXl323LY+QnLZD/Sar7
         Yjw9y2Gp23CMdl73bjnn20gL9LmeNUUqJwLbW6C6Gxd8Qv4q32jGFw8lbRhb8b1Piedn
         ZPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239624; x=1700844424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Thx8LLnaaRodv164Y7EegfEHoh5Her4BVqcftkBpp8=;
        b=kBEZAIejtWevIyhsbayIVHwYvwrok9iOSNv7k8yAZK1qFxf3AE95aUHjAepgHnfnMZ
         skv3I3/6VFD1qflb/rirgb+jEKuraMsAC5XhYyEkJGDvCnLrRMvqgZNGbrq5/ZsB/0Es
         FixkFCpzyF6Qn0KZB8nVXKWd23foq/lB2P/E5XtkgV6xrog8IqeRtDbVIwKB9IGq59BM
         +THewvZP+FJplT/86+wnCAzwhIlT5qkjQQM9YetUA/UrmiuSIeHxJO1zs2oUg5h5zmqs
         SiOKFwOokrfN3sypI/kenxE7ajM4n0XBD4AxvVT3fC9Dq39ksSqeA904oxtcdoybS01E
         Sg5g==
X-Gm-Message-State: AOJu0YzOZDxrDlBkHIGbXvF6HhbPLQ2tkTE6C7EqtW5UQGlVO1b7qEJu
	o25YNTu7GfAxFQFo5ZVvMFcb7xvYE54SK9aEQis=
X-Google-Smtp-Source: AGHT+IFI9eqvo8p5ST18Yrs0rBCm0mDMvD+SYvwjSxR9a1hKudOB7EeyDxuxqie5VmqOjI8Hs2ZiNTnaTk+msSEtyog=
X-Received: by 2002:a50:ab12:0:b0:540:2ece:79 with SMTP id s18-20020a50ab12000000b005402ece0079mr16135627edc.10.1700239624568;
 Fri, 17 Nov 2023 08:47:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-7-eddyz87@gmail.com>
In-Reply-To: <20231116021803.9982-7-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 11:46:53 -0500
Message-ID: <CAEf4BzZCdYvjj_xoBsdTwoT33Q2gBJLfGRTPcsv3bDusf9cgJA@mail.gmail.com>
Subject: Re: [PATCH bpf 06/12] bpf: verify callbacks as if they are called
 unknown number of times
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 9:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Prior to this patch callbacks were handled as regular function calls,
> execution of callback body was modeled exactly once.
> This patch updates callbacks handling logic as follows:
> - introduces a function push_callback_call() that schedules callback
>   body verification in env->head stack;
> - updates prepare_func_exit() to reschedule callback body verification
>   upon BPF_EXIT;
> - as calls to bpf_*_iter_next(), calls to callback invoking functions
>   are marked as checkpoints;
> - is_state_visited() is updated to stop callback based iteration when
>   some identical parent state is found.
>
> Paths with callback function invoked zero times are now verified first,
> which leads to necessity to modify some selftests:
> - the following negative tests required adding release/unlock/drop
>   calls to avoid previously masked unrelated error reports:
>   - cb_refs.c:underflow_prog
>   - exceptions_fail.c:reject_rbtree_add_throw
>   - exceptions_fail.c:reject_with_cp_reference
> - the following precision tracking selftests needed change in expected
>   log trace:
>   - verifier_subprog_precision.c:callback_result_precise
>     (note: r0 precision is no longer propagated inside callback and
>            I think this is a correct behavior)
>   - verifier_subprog_precision.c:parent_callee_saved_reg_precise_with_cal=
lback
>   - verifier_subprog_precision.c:parent_stack_slot_precise_with_callback
>
> Reported-by: Andrew Werner <awerner32@gmail.com>
> Closes: https://lore.kernel.org/bpf/CA+vRuzPChFNXmouzGG+wsy=3D6eMcfr1mFG0=
F3g7rbg-sedGKW3w@mail.gmail.com/
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf_verifier.h                  |   5 +
>  kernel/bpf/verifier.c                         | 257 +++++++++++-------
>  .../selftests/bpf/prog_tests/cb_refs.c        |   4 +-
>  tools/testing/selftests/bpf/progs/cb_refs.c   |   1 +
>  .../selftests/bpf/progs/exceptions_fail.c     |   2 +
>  .../bpf/progs/verifier_subprog_precision.c    |  22 +-
>  6 files changed, 183 insertions(+), 108 deletions(-)
>

Overall makes sense, but I left few questions below to try to
understand everything better. Thanks!

[...]

> +static bool is_callback_iter_next(struct bpf_verifier_env *env, int insn=
_idx);
> +
>  /* For given verifier state backtrack_insn() is called from the last ins=
n to
>   * the first insn. Its purpose is to compute a bitmask of registers and
>   * stack slots that needs precision in the parent verifier state.
> @@ -4030,10 +4044,7 @@ static int backtrack_insn(struct bpf_verifier_env =
*env, int idx, int subseq_idx,
>                                         return -EFAULT;
>                                 return 0;
>                         }
> -               } else if ((bpf_helper_call(insn) &&
> -                           is_callback_calling_function(insn->imm) &&
> -                           !is_async_callback_calling_function(insn->imm=
)) ||
> -                          (bpf_pseudo_kfunc_call(insn) && is_callback_ca=
lling_kfunc(insn->imm))) {
> +               } else if (is_sync_callback_calling_insn(insn) && idx !=
=3D subseq_idx - 1) {

can you leave a comment why we need idx !=3D subseq_idx - 1 check?

>                         /* callback-calling helper or kfunc call, which m=
eans
>                          * we are exiting from subprog, but unlike the su=
bprog
>                          * call handling above, we shouldn't propagate

[...]

> @@ -12176,6 +12216,21 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                 return -EACCES;
>         }
>
> +       /* Check the arguments */
> +       err =3D check_kfunc_args(env, &meta, insn_idx);
> +       if (err < 0)
> +               return err;
> +
> +       if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add_impl=
]) {

can't we use is_sync_callback_calling_kfunc() here?

> +               err =3D push_callback_call(env, insn, insn_idx, meta.subp=
rogno,
> +                                        set_rbtree_add_callback_state);
> +               if (err) {
> +                       verbose(env, "kfunc %s#%d failed callback verific=
ation\n",
> +                               func_name, meta.func_id);
> +                       return err;
> +               }
> +       }
> +

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/tes=
ting/selftests/bpf/prog_tests/cb_refs.c
> index 3bff680de16c..b5aa168889c1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> @@ -21,12 +21,14 @@ void test_cb_refs(void)
>  {
>         LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_buf =3D log_b=
uf,
>                                                 .kernel_log_size =3D size=
of(log_buf),
> -                                               .kernel_log_level =3D 1);
> +                                               .kernel_log_level =3D 1 |=
 2 | 4);

nit: 1 is redundant if 2 is specified, so just `2 | 4` ?

>         struct bpf_program *prog;
>         struct cb_refs *skel;
>         int i;
>
>         for (i =3D 0; i < ARRAY_SIZE(cb_refs_tests); i++) {
> +               if (!test__start_subtest(cb_refs_tests[i].prog_name))
> +                       continue;
>                 LIBBPF_OPTS(bpf_test_run_opts, run_opts,
>                         .data_in =3D &pkt_v4,
>                         .data_size_in =3D sizeof(pkt_v4),

[...]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision=
.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> index db6b3143338b..ead358679fe2 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> @@ -120,14 +120,12 @@ __naked int global_subprog_result_precise(void)
>  SEC("?raw_tp")
>  __success __log_level(2)
>  __msg("14: (0f) r1 +=3D r6")
> -__msg("mark_precise: frame0: last_idx 14 first_idx 10")
> +__msg("mark_precise: frame0: last_idx 14 first_idx 9")
>  __msg("mark_precise: frame0: regs=3Dr6 stack=3D before 13: (bf) r1 =3D r=
7")
>  __msg("mark_precise: frame0: regs=3Dr6 stack=3D before 12: (27) r6 *=3D =
4")
>  __msg("mark_precise: frame0: regs=3Dr6 stack=3D before 11: (25) if r6 > =
0x3 goto pc+4")
>  __msg("mark_precise: frame0: regs=3Dr6 stack=3D before 10: (bf) r6 =3D r=
0")
> -__msg("mark_precise: frame0: parent state regs=3Dr0 stack=3D:")
> -__msg("mark_precise: frame0: last_idx 18 first_idx 0")
> -__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 18: (95) exit")
> +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 9: (85) call bpf_=
loop")

you are right that r0 returned from bpf_loop is not r0 returned from
bpf_loop's callback, but we still have to go through callback
instructions, right? so you removed few __msg() from subprog
instruction history because it was too long a history or what? I'd
actually keep those but update that in subprog we don't need r0 to be
precise, that will make this test even clearer

>  __naked int callback_result_precise(void)
>  {
>         asm volatile (

[...]

