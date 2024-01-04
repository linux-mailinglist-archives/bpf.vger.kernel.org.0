Return-Path: <bpf+bounces-19079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78AC824BA0
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 00:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694F2284B75
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 23:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48A32D022;
	Thu,  4 Jan 2024 23:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OruWNbWF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755342D040
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ccb4adbffbso12679831fa.0
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 15:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704409452; x=1705014252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xG7lsq34UrUr9ddN9PZhCzdDbNOCukOjgxD/Q275gJ8=;
        b=OruWNbWFfEFb8znKkdahSTnLdmUhnsovKfvOC9PB6DGh7lKfbXWjttLA+FNdvhTgcV
         F5/GMU+aaBPz/KKWtRRzg3XeJRPL4GKl/b9+WM6s/A9S1fjf8c4t//ixLuz6b3JfDhGQ
         g/zM/8adtVbYOTrToPAmzcSrUZt18YAV66O/4c/GS1jnfV7pFp902rmGIA0Ix394kBSZ
         Jn38OpZL9M9Mm5J+8dfb6WIkzUgXIbyNeqgDxSkGrq5ejPB+76K1EW3Wlyyb16iDmXSW
         vA/5dJzzbi/4qryP4S5k5fdhNtt/wm+CzdsqDAwsDMCgHY/JMG1CW47IqNYFr2+96r7d
         8MWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704409452; x=1705014252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xG7lsq34UrUr9ddN9PZhCzdDbNOCukOjgxD/Q275gJ8=;
        b=I9dKEFtNvQDPr4iQU/4EkxW5EAU3yeRlvWlKWaNGA2B1nsMzAtS+xyav/09XOvJy9P
         mQsMIDHPmf0TZdPWGePQXnrVtRiyzb9Vh31pkmxXMiSGdVuSrVldvs0MW8YKvdTLdwVu
         +u9+Ix6Hj2/SjSkiYVCv6GOzu6KfOLwzIUShjHcSICXZGLIeY4XkM2JGDOn+oxl+NwFp
         2jyY6uMvGCxorfFHxgxYUtMQRevwrjdZSXTQjXpvr/WeqyGreAR1puclgIsY8uSauPJi
         XJ6M3cwOwsCUX9RnsvkOLY1nnfL/Dms6Kp7DQtR/KZH6WbhJnq5mDfPQwp917Lmt9BlJ
         il+g==
X-Gm-Message-State: AOJu0YzIXhbBZjW13UqPWq2LMwcWUpyKs/+QlazBNqDsmIZ5zpl5gGex
	nC3iHbMbNUaIVKeOWxnoBjwiR4Et8B5oc2PD+so=
X-Google-Smtp-Source: AGHT+IHH1nUn7Ym5cony8PKVZkZtTz0m4R1520Ou3qCIsYuzLg6FxPEshoFbGjzHerj0lmp7ZIfv9xFLXQklFUZKHG8=
X-Received: by 2002:a2e:7215:0:b0:2cc:3793:5575 with SMTP id
 n21-20020a2e7215000000b002cc37935575mr720395ljc.93.1704409452091; Thu, 04 Jan
 2024 15:04:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
In-Reply-To: <20240103232617.3770727-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Jan 2024 15:03:59 -0800
Message-ID: <CAEf4BzYOuQw-+Gtfk5LgeXJzaWBetrPUaetRL8PgTdoYQe5CgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Track aligned st store as imprecise
 spilled registers
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 3:26=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> With patch set [1], precision backtracing supports register spill/fill
> to/from the stack. The patch [2] allows initial imprecise register spill
> with content 0. This is a common case for cpuv3 and lower for
> initializing the stack variables with pattern
>   r1 =3D 0
>   *(u64 *)(r10 - 8) =3D r1
> and the [2] has demonstrated good verification improvement.
>
> For cpuv4, the initialization could be
>   *(u64 *)(r10 - 8) =3D 0
> The current verifier marks the r10-8 contents with STACK_ZERO.
> Similar to [2], let us permit the above insn to behave like
> imprecise register spill which can reduce number of verified states.
> The change is in function check_stack_write_fixed_off().
>
> Before this patch, spilled zero will be marked as STACK_ZERO
> which can provide precise values. In check_stack_write_var_off(),
> STACK_ZERO will be maintained if writing a const zero
> so later it can provide precise values if needed.
>
> The above handling of '*(u64 *)(r10 - 8) =3D 0' as a spill
> will have issues in check_stack_write_var_off() as the spill
> will be converted to STACK_MISC and the precise value 0
> is lost. To fix this issue, if the spill slots with const
> zero and the BPF_ST write also with const zero, the spill slots
> are preserved, which can later provide precise values
> if needed. Without the change in check_stack_write_var_off(),
> the test_verifier subtest 'BPF_ST_MEM stack imm zero, variable offset'
> will fail.
>
> I checked cpuv3 and cpuv4 with and without this patch with veristat.
> There is no state change for cpuv3 since '*(u64 *)(r10 - 8) =3D 0'
> is only generated with cpuv4.
>
> For cpuv4:
> $ ../veristat -C old.cpuv4.csv new.cpuv4.csv -e file,prog,insns,states -f=
 'insns_diff!=3D0'
> File                                        Program              Insns (A=
)  Insns (B)  Insns    (DIFF)  States (A)  States (B)  States (DIFF)
> ------------------------------------------  -------------------  --------=
-  ---------  ---------------  ----------  ----------  -------------
> local_storage_bench.bpf.linked3.o           get_local                  22=
8        168    -60 (-26.32%)          17          14   -3 (-17.65%)
> pyperf600_bpf_loop.bpf.linked3.o            on_event                  606=
6       4889  -1177 (-19.40%)         403         321  -82 (-20.35%)
> test_cls_redirect.bpf.linked3.o             cls_redirect             3548=
3      35387     -96 (-0.27%)        2179        2177    -2 (-0.09%)
> test_l4lb_noinline.bpf.linked3.o            balancer_ingress          449=
4       4522     +28 (+0.62%)         217         219    +2 (+0.92%)
> test_l4lb_noinline_dynptr.bpf.linked3.o     balancer_ingress          143=
2       1455     +23 (+1.61%)          92          94    +2 (+2.17%)
> test_xdp_noinline.bpf.linked3.o             balancer_ingress_v6       346=
2       3458      -4 (-0.12%)         216         216    +0 (+0.00%)
> verifier_iterating_callbacks.bpf.linked3.o  widening                    5=
2         41    -11 (-21.15%)           4           3   -1 (-25.00%)
> xdp_synproxy_kern.bpf.linked3.o             syncookie_tc             1241=
2      11719    -693 (-5.58%)         345         330   -15 (-4.35%)
> xdp_synproxy_kern.bpf.linked3.o             syncookie_xdp            1247=
8      11794    -684 (-5.48%)         346         331   -15 (-4.34%)
>
> test_l4lb_noinline and test_l4lb_noinline_dynptr has minor regression, bu=
t
> pyperf600_bpf_loop and local_storage_bench gets pretty good improvement.
>
>   [1] https://lore.kernel.org/all/20231205184248.1502704-1-andrii@kernel.=
org/
>   [2] https://lore.kernel.org/all/20231205184248.1502704-9-andrii@kernel.=
org/
>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/verifier.c                         | 21 +++++++++++++++++--
>  .../selftests/bpf/progs/verifier_spill_fill.c | 16 +++++++-------
>  2 files changed, 27 insertions(+), 10 deletions(-)
>
> Changelogs:
>   v1 -> v2:
>     - Preserve with-const-zero spill if writing is also zero
>       in check_stack_write_var_off().
>     - Add a test with not-8-byte-aligned BPF_ST store.
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d4e31f61de0e..cfe7a68d90a5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4491,7 +4491,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
>                 if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
>                         state->stack[spi].spilled_ptr.id =3D 0;
>         } else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &=
&
> -                  insn->imm !=3D 0 && env->bpf_capable) {
> +                  env->bpf_capable) {
>                 struct bpf_reg_state fake_reg =3D {};
>
>                 __mark_reg_known(&fake_reg, insn->imm);
> @@ -4613,11 +4613,28 @@ static int check_stack_write_var_off(struct bpf_v=
erifier_env *env,
>
>         /* Variable offset writes destroy any spilled pointers in range. =
*/
>         for (i =3D min_off; i < max_off; i++) {
> +               struct bpf_reg_state *spill_reg;
>                 u8 new_type, *stype;
> -               int slot, spi;
> +               int slot, spi, j;
>
>                 slot =3D -i - 1;
>                 spi =3D slot / BPF_REG_SIZE;
> +
> +               /* If writing_zero and the the spi slot contains a spill =
of value 0,
> +                * maintain the spill type.
> +                */
> +               if (writing_zero && !(i % BPF_REG_SIZE) && is_spilled_sca=
lar_reg(&state->stack[spi])) {
> +                       spill_reg =3D &state->stack[spi].spilled_ptr;
> +                       if (tnum_is_const(spill_reg->var_off) && spill_re=
g->var_off.value =3D=3D 0) {

here we assume that *spilled* register is zero and will stay zero,
even if it's imprecise. This is wrong, because imprecise SCALAR 0 is
actually an unknown scalar when doing state pruning. So we need to
either force the spilled register to be precise, or overwrite it with
STACK_MISC.


> +                               for (j =3D BPF_REG_SIZE; j > 0; j--) {
> +                                       if (state->stack[spi].slot_type[j=
 - 1] !=3D STACK_SPILL)
> +                                               break;
> +                               }
> +                               i +=3D BPF_REG_SIZE - j - 1;
> +                               continue;
> +                       }
> +               }
> +
>                 stype =3D &state->stack[spi].slot_type[slot % BPF_REG_SIZ=
E];
>                 mark_stack_slot_scratched(env, spi);
>

[...]

