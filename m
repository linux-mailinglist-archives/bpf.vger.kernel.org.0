Return-Path: <bpf+bounces-12917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45BF7D20F3
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 06:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF0F4B20E35
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 04:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E83ED0;
	Sun, 22 Oct 2023 04:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es9OYflt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA02EEC8
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 04:17:07 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9495D9
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 21:17:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9c603e2354fso455396166b.1
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 21:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697948224; x=1698553024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rq86K2NYIZ3O2/qg+hHGo0GCeB9QbnfmZgS3czTHOqc=;
        b=Es9OYflt0+lrco9e+AeEvQ+t5+3uciggoDoFMOoKEWlzNlrjX/i0aqNy9yHkxUwn95
         hsJ9FBU4v/MdB/gr60P7nkcYel8ElzdHpw8RbJN9mGNj6Nq7MQQ4wUTehFzgoWuQSms2
         LytrWIgGmDN4sxNHH9ny29dzXw9MPh6LX3p1Q9KpuYjxHTUzODlebEqxbVZlM/YKYPOk
         BielMdhIAVPs5jadL3lqjfwUhcrruXmLNHNf7KDCNVJwtR65Bb8ioJ5934LO7B01VwoJ
         wtoscdzg/M4SUiEjdfSLjWLx+goRLiwGY8vD+r35AI9MF/VPLHeDeRm6029n96StD/qt
         BbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697948224; x=1698553024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rq86K2NYIZ3O2/qg+hHGo0GCeB9QbnfmZgS3czTHOqc=;
        b=tARWJle8V9hGCWGiGSrammKDkKEaFcRsRWvmeppDobakereHHT7cBplSIwEUg8uBTo
         3Hn/50IhN01m+3FeGTAFN62C45dFCZFfOjGR1PIL28meTAjrk8NXOucaKTCb/nxHd3Gm
         lH6rQMpxlWbfEMGTZ/2+BPFwW4tAkjlIFG0Gtrx6rChArznr5A5l9QJ5bpbDNywTyfVt
         cZkShBL1LjPetIyqPc/ZWfmKO3l6jH0GmPTb4Lb/VJ9u/JOaE7I+KFY1b1vrfTg6Pob9
         DwH224Q+/aJEbNrB4FssXst1q2o0FWR5H8TSp1tDBMdHI2lTjdiUhlX2fX8IEpGRikeB
         U4rg==
X-Gm-Message-State: AOJu0YyebQ4QIHT3vjKbqAyPMDKSij8GkPOdki3Kd7SBlwqaVyj6FyeK
	ehv4a1Rr2u7mHBWFGayQ+Ze9g8TCAccBs9GFI98=
X-Google-Smtp-Source: AGHT+IEJK9vffMTXUA7QqLAzrQ+cf5LmudK8tFFhpOdnU8PY0lWrarHewdJpUVWC+UyGjxqng8eOlYvhVLafVc9NwQA=
X-Received: by 2002:a17:907:3ea8:b0:9c3:ba22:4d65 with SMTP id
 hs40-20020a1709073ea800b009c3ba224d65mr5498612ejc.4.1697948223930; Sat, 21
 Oct 2023 21:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231022010812.9201-1-eddyz87@gmail.com> <20231022010812.9201-4-eddyz87@gmail.com>
In-Reply-To: <20231022010812.9201-4-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 21 Oct 2023 21:16:52 -0700
Message-ID: <CAEf4BzbLq7rN-nsgx86wqGPg_kUEwOc=Mvh8OL6=icPk3tf1Aw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/7] bpf: exact states comparison for iterator
 convergence checks
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com, 
	john.fastabend@gmail.com, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 21, 2023 at 6:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Convergence for open coded iterators is computed in is_state_visited()
> by examining states with branches count > 1 and using states_equal().
> states_equal() computes sub-state relation using read and precision marks=
.
> Read and precision marks are propagated from children states,
> thus are not guaranteed to be complete inside a loop when branches
> count > 1. This could be demonstrated using the following unsafe program:
>
>      1. r7 =3D -16
>      2. r6 =3D bpf_get_prandom_u32()
>      3. while (bpf_iter_num_next(&fp[-8])) {
>      4.   if (r6 !=3D 42) {
>      5.     r7 =3D -32
>      6.     r6 =3D bpf_get_prandom_u32()
>      7.     continue
>      8.   }
>      9.   r0 =3D r10
>     10.   r0 +=3D r7
>     11.   r8 =3D *(u64 *)(r0 + 0)
>     12.   r6 =3D bpf_get_prandom_u32()
>     13. }
>
> Here verifier would first visit path 1-3, create a checkpoint at 3
> with r7=3D-16, continue to 4-7,3 with r7=3D-32.
>
> Because instructions at 9-12 had not been visitied yet existing
> checkpoint at 3 does not have read or precision mark for r7.
> Thus states_equal() would return true and verifier would discard
> current state, thus unsafe memory access at 11 would not be caught.
>
> This commit fixes this loophole by introducing exact state comparisons
> for iterator convergence logic:
> - registers are compared using regs_exact() regardless of read or
>   precision marks;
> - stack slots have to have identical type.
>
> Unfortunately, this is too strict even for simple programs like below:
>
>     i =3D 0;
>     while(iter_next(&it))
>       i++;
>
> At each iteration step i++ would produce a new distinct state and
> eventually instruction processing limit would be reached.
>
> To avoid such behavior speculatively forget (widen) range for
> imprecise scalar registers, if those registers were not precise at the
> end of the previous iteration and do not match exactly.
>
> This a conservative heuristic that allows to verify wide range of
> programs, however it precludes verification of programs that conjure
> an imprecise value on the first loop iteration and use it as precise
> on the second.
>
> Test case iter_task_vma_for_each() presents one of such cases:
>
>         unsigned int seen =3D 0;
>         ...
>         bpf_for_each(task_vma, vma, task, 0) {
>                 if (seen >=3D 1000)
>                         break;
>                 ...
>                 seen++;
>         }
>
> Here clang generates the following code:
>
> <LBB0_4>:
>       24:       r8 =3D r6                          ; stash current value =
of
>                 ... body ...                       'seen'
>       29:       r1 =3D r10
>       30:       r1 +=3D -0x8
>       31:       call bpf_iter_task_vma_next
>       32:       r6 +=3D 0x1                        ; seen++;
>       33:       if r0 =3D=3D 0x0 goto +0x2 <LBB0_6>  ; exit on next() =3D=
=3D NULL
>       34:       r7 +=3D 0x10
>       35:       if r8 < 0x3e7 goto -0xc <LBB0_4> ; loop on seen < 1000
>
> <LBB0_6>:
>       ... exit ...
>
> Note that counter in r6 is copied to r8 and then incremented,
> conditional jump is done using r8. Because of this precision mark for
> r6 lags one state behind of precision mark on r8 and widening logic
> kicks in.
>
> Adding barrier_var(seen) after conditional is sufficient to force
> clang use the same register for both counting and conditional jump.
>
> This issue was discussed in the thread [1] which was started by
> Andrew Werner <awerner32@gmail.com> demonstrating a similar bug
> in callback functions handling. The callbacks would be addressed
> in a followup patch.
>
> [1] https://lore.kernel.org/bpf/97a90da09404c65c8e810cf83c94ac703705dc0e.=
camel@gmail.com/
>
> Co-developed-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Co-developed-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf_verifier.h                  |   1 +
>  kernel/bpf/verifier.c                         | 212 +++++++++++++++---
>  .../selftests/bpf/progs/iters_task_vma.c      |   1 +
>  3 files changed, 184 insertions(+), 30 deletions(-)
>

[...]

> +static int widen_imprecise_scalars(struct bpf_verifier_env *env,
> +                                  struct bpf_verifier_state *old,
> +                                  struct bpf_verifier_state *cur)
> +{
> +       struct bpf_func_state *fold, *fcur;
> +       int i, fr;
> +
> +       reset_idmap_scratch(env);
> +       for (fr =3D old->curframe; fr >=3D 0; fr--) {
> +               fold =3D old->frame[fr];
> +               fcur =3D cur->frame[fr];
> +
> +               for (i =3D 0; i < MAX_BPF_REG; i++)
> +                       maybe_widen_reg(env,
> +                                       &fold->regs[i],
> +                                       &fcur->regs[i],
> +                                       &env->idmap_scratch);
> +
> +               for (i =3D 0; i < fold->allocated_stack / BPF_REG_SIZE; i=
++) {
> +                       if (is_spilled_scalar_reg(&fold->stack[i]))

should this be !is_spilled_scalar_reg()?

but also your should make sure that fcur->stack[i] is also a spilled
reg (it could be iter or dynptr, or just hard-coded ZERO or MISC stack
slot, so accessing fcur->stack[i].spilled_ptr below might be invalid)

> +                               continue;

> +
> +                       maybe_widen_reg(env,
> +                                       &fold->stack[i].spilled_ptr,
> +                                       &fcur->stack[i].spilled_ptr,
> +                                       &env->idmap_scratch);
> +               }
> +       }
> +       return 0;
> +}
> +

[...]

