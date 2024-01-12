Return-Path: <bpf+bounces-19486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A04182C61F
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 21:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA928B2163A
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 20:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C360E1640B;
	Fri, 12 Jan 2024 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0PgfY6e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898DB15ADB
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e9e5c97e1so8566714e87.0
        for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 12:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705089941; x=1705694741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hn7nxppEEkoTy/uLVP6ZP5qmjHZxRtvNPwABhvpAzXY=;
        b=B0PgfY6eELfKM7p8oPaqxS2DmC7msgn0i3pwmm9a03kfn/0oliiXqETmyVGAzQJzDK
         Fd1kLSjONYx0EeXXbAHarcSMVKXeXALfln/HHg4XrTRfxS3s1zV5J2vj6yY0GZbsBy94
         BOiaT2Ikw2Lu4mxSCUVzrsNCVbOhc4G2TlO+TaIjNCf4/whItC9w3B97Njjg9bqyaeYD
         Dfi4kzjXJk7aw1AqByxD/YRZ7sZScN+0XOD8TAD6SsjV7NLcZeXq9h6KYrzePhWPdnLi
         tsuwoG/2b535YBZ1cRd2C4cTQdVZKBW1tiQDuvmXeOmRI+VDCYSzok+exTgr9DbjZOMJ
         ZunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705089941; x=1705694741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hn7nxppEEkoTy/uLVP6ZP5qmjHZxRtvNPwABhvpAzXY=;
        b=nzyNOltezXzmH/MeS1tFoL1wr+uMQUzUAztSJAXtYkuTzmVoSDUeXxLu3Hi2ggAzex
         CmGFJZ8aSVImXGybAMlAb2N6iO/qTEyfA29oAirwwTdpWUGVGmagnRbY6kqvFb1vOAzr
         uXdSsOwwbfC7YleVU3UEVzt1HWCuYTTm9Gu9lKMOkWuYXpkzgtNCKbk52ehqHidgnLXj
         A4yRygv5Js08Jk4ivbFoKyEQXA6Tt+Poapouk0vpnsmhU0VasHyDb4of8O91o4ZwpdHf
         6QrSw4nYGHYS5yZ8b8MEXIuLstWLVu1ZPdYafVa7i3Ude4SIn2ErXP1lTclEKWClooJ1
         kF0Q==
X-Gm-Message-State: AOJu0Yz/+5kcAQg2THVwufuRrDIXsssKxiGs9kanWDvD7RD1/KBZdH/+
	luXu3A8x6gQGeqNOHxpFv3WxrsvQGuswNM+YCpo=
X-Google-Smtp-Source: AGHT+IE10F5cN1OvH2YS0PZX2MwZgC8oL4de4KEK9mGdKaIX9FT7DlmmoFl9pZBLmRtGoo/ZrmJqS8ULt0MphhdH5HA=
X-Received: by 2002:a19:4f48:0:b0:50e:d4b2:6f63 with SMTP id
 a8-20020a194f48000000b0050ed4b26f63mr721441lfk.124.1705089941235; Fri, 12 Jan
 2024 12:05:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110051348.2737007-1-yonghong.song@linux.dev>
In-Reply-To: <20240110051348.2737007-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 12 Jan 2024 12:05:28 -0800
Message-ID: <CAEf4BzY=bug0r-T+eALgAFeacBDSOLTKMkE=r+Sx2fjw4LK--A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Track aligned st store as imprecise
 spilled registers
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 9:14=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
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
>  kernel/bpf/verifier.c                           | 17 +++++++++++++++--
>  .../selftests/bpf/progs/verifier_spill_fill.c   | 16 ++++++++--------
>  2 files changed, 23 insertions(+), 10 deletions(-)
>
> Changelogs:
>   v3 -> v4:
>     - add missed SPILL slot check in check_stack_write_var_off().
>     - remove incorrect comments in the new test.
>   v2 -> v3:
>     - add precision checking to the spilled zero value register in
>       check_stack_write_var_off().
>     - check spill slot-by-slot instead of in a bunch within a spi.
>   v1 -> v2:
>     - Preserve with-const-zero spill if writing is also zero
>       in check_stack_write_var_off().
>     - Add a test with not-8-byte-aligned BPF_ST store.
>

LGTM, thanks

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index adbf330d364b..bd7d74a06f19 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4493,7 +4493,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
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
> @@ -4640,7 +4640,20 @@ static int check_stack_write_var_off(struct bpf_ve=
rifier_env *env,
>                         return -EINVAL;
>                 }
>
> -               /* Erase all spilled pointers. */
> +               /* If writing_zero and the spi slot contains a spill of v=
alue 0,
> +                * maintain the spill type.
> +                */
> +               if (writing_zero && *stype =3D=3D STACK_SPILL &&
> +                   is_spilled_scalar_reg(&state->stack[spi])) {
> +                       struct bpf_reg_state *spill_reg =3D &state->stack=
[spi].spilled_ptr;
> +
> +                       if (tnum_is_const(spill_reg->var_off) && spill_re=
g->var_off.value =3D=3D 0) {
> +                               zero_used =3D true;
> +                               continue;
> +                       }
> +               }
> +
> +               /* Erase all other spilled pointers. */
>                 state->stack[spi].spilled_ptr.type =3D NOT_INIT;
>
>                 /* Update the slot type. */
> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
> index 39fe3372e0e0..d4b3188afe07 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> @@ -495,14 +495,14 @@ char single_byte_buf[1] SEC(".data.single_byte_buf"=
);
>  SEC("raw_tp")
>  __log_level(2)
>  __success
> -/* make sure fp-8 is all STACK_ZERO */
> -__msg("2: (7a) *(u64 *)(r10 -8) =3D 0          ; R10=3Dfp0 fp-8_w=3D0000=
0000")
> +/* fp-8 is spilled IMPRECISE value zero (represented by a zero value fak=
e reg) */
> +__msg("2: (7a) *(u64 *)(r10 -8) =3D 0          ; R10=3Dfp0 fp-8_w=3D0")
>  /* but fp-16 is spilled IMPRECISE zero const reg */
>  __msg("4: (7b) *(u64 *)(r10 -16) =3D r0        ; R0_w=3D0 R10=3Dfp0 fp-1=
6_w=3D0")
> -/* validate that assigning R2 from STACK_ZERO doesn't mark register
> +/* validate that assigning R2 from STACK_SPILL with zero value  doesn't =
mark register
>   * precise immediately; if necessary, it will be marked precise later
>   */
> -__msg("6: (71) r2 =3D *(u8 *)(r10 -1)          ; R2_w=3D0 R10=3Dfp0 fp-8=
_w=3D00000000")
> +__msg("6: (71) r2 =3D *(u8 *)(r10 -1)          ; R2_w=3D0 R10=3Dfp0 fp-8=
_w=3D0")
>  /* similarly, when R2 is assigned from spilled register, it is initially
>   * imprecise, but will be marked precise later once it is used in precis=
e context
>   */
> @@ -520,14 +520,14 @@ __msg("mark_precise: frame0: regs=3Dr0 stack=3D bef=
ore 3: (b7) r0 =3D 0")
>  __naked void partial_stack_load_preserves_zeros(void)
>  {
>         asm volatile (
> -               /* fp-8 is all STACK_ZERO */
> +               /* fp-8 is value zero (represented by a zero value fake r=
eg) */
>                 ".8byte %[fp8_st_zero];" /* LLVM-18+: *(u64 *)(r10 -8) =
=3D 0; */
>
>                 /* fp-16 is const zero register */
>                 "r0 =3D 0;"
>                 "*(u64 *)(r10 -16) =3D r0;"
>
> -               /* load single U8 from non-aligned STACK_ZERO slot */
> +               /* load single U8 from non-aligned spilled value zero slo=
t */
>                 "r1 =3D %[single_byte_buf];"
>                 "r2 =3D *(u8 *)(r10 -1);"
>                 "r1 +=3D r2;"
> @@ -539,7 +539,7 @@ __naked void partial_stack_load_preserves_zeros(void)
>                 "r1 +=3D r2;"
>                 "*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
>
> -               /* load single U16 from non-aligned STACK_ZERO slot */
> +               /* load single U16 from non-aligned spilled value zero sl=
ot */
>                 "r1 =3D %[single_byte_buf];"
>                 "r2 =3D *(u16 *)(r10 -2);"
>                 "r1 +=3D r2;"
> @@ -551,7 +551,7 @@ __naked void partial_stack_load_preserves_zeros(void)
>                 "r1 +=3D r2;"
>                 "*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
>
> -               /* load single U32 from non-aligned STACK_ZERO slot */
> +               /* load single U32 from non-aligned spilled value zero sl=
ot */
>                 "r1 =3D %[single_byte_buf];"
>                 "r2 =3D *(u32 *)(r10 -4);"
>                 "r1 +=3D r2;"
> --
> 2.34.1
>

