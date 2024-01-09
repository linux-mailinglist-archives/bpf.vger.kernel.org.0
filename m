Return-Path: <bpf+bounces-19286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0A0829005
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 23:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022561F2509C
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 22:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2831F3DB8A;
	Tue,  9 Jan 2024 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXHA+K9K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0574112E41
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-555f581aed9so4081583a12.3
        for <bpf@vger.kernel.org>; Tue, 09 Jan 2024 14:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704839920; x=1705444720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=To9llvZs8uqaFMu8/1D5jzPMoU7/vjq4zQl8S61WgAE=;
        b=mXHA+K9Kekx/BJ6xwEQSj/O3X6+IVZeE6gRgaKsRWSRphkVgxmv2UcvZZ15mDpkKq0
         I0pN5FJQlkp3F0UnIcEIfkvCIiumRU8FODPuvxNbEluznpuJyB/FQ8sE+jwst7i8OmyN
         jiLGZO4X0uXmkpnAYRht7Qm9cPb/tRI6usZWFd3vAwV+rHgwOwvVAt/U1bBBMd5UaOXj
         xNQv25xhhsgpGGEyIIfDzHaoGpi7g1hzBDHGxM0WKkVIGsdLwrfrI7BZ1aq+k4MVvbcf
         sGm2FZNOMksRA+mXq1/0XT/ShCrh3a9PDSeYPmCtDgvIFgMk5dAQsalNfnW4X0w9ODiy
         p2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704839920; x=1705444720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=To9llvZs8uqaFMu8/1D5jzPMoU7/vjq4zQl8S61WgAE=;
        b=amCOu6XSFx4oAMu/ZR0DSPvv+Uc5V3QX+THfjHHydmfVXFN+qRan/3ztLNW8DDk2H3
         RZkHhhAAwLtoVf5AX56F1x/bISlBphhiAfAVmI/Zd6u2Su2zu9UrHh6W8yZJYobPtZ+U
         pxz7lUzdhjzJEc+Igfb3I3A5Ij8a4JzN34yEAHXf0zNt9k8hHh3W8pLZIUTjLgRpXs2O
         x4uhMrAAEFN8bssQ/KsJMwAKKXwvCWdYG3yHDUDKbP1uhpNbPu+KlKsEFizL7q5z46oK
         Ch/Fyu+KmvHKzRyn1DcJo1N6dhygVvPDkHzYPNPibhi1BL0wkEAJmZnLKEe+TBjYRq1E
         Q8Og==
X-Gm-Message-State: AOJu0YzBzbWpsVTPmubipVPHt3QAmr7yk8W1Fmw/ZsmJRhEfsELK5w7/
	pd6FAdLccGADRz5rENaH5rz411WBS9VgLrGZMik=
X-Google-Smtp-Source: AGHT+IGRC5Qa8+Qi6+D3WkrDTd8QITnMf1fGNWWtteM+YKwR+RWZje6Z+9QMCBPPD0zanfoBKm+6BeFSOGI0MnQtuvI=
X-Received: by 2002:a50:d499:0:b0:558:17a1:22d2 with SMTP id
 s25-20020a50d499000000b0055817a122d2mr52438edi.68.1704839919957; Tue, 09 Jan
 2024 14:38:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109040524.2313448-1-yonghong.song@linux.dev>
In-Reply-To: <20240109040524.2313448-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jan 2024 14:38:27 -0800
Message-ID: <CAEf4BzZgKWA6h4cEyxrFri4r+u976cNcm4vzFgKvJ0j=+uT+Jw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Track aligned st store as imprecise
 spilled registers
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 8:05=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
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
>  kernel/bpf/verifier.c                            | 16 ++++++++++++++--
>  .../selftests/bpf/progs/verifier_spill_fill.c    | 16 ++++++++--------
>  2 files changed, 22 insertions(+), 10 deletions(-)
>
> Changelogs:
>   v2 -> v3:
>     - add precision checking to the spilled zero value register in
>       check_stack_write_var_off().
>     - check spill slot-by-slot instead of in a bunch within a spi.
>   v1 -> v2:
>     - Preserve with-const-zero spill if writing is also zero
>       in check_stack_write_var_off().
>     - Add a test with not-8-byte-aligned BPF_ST store.
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index adbf330d364b..54da1045e078 100644
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
> @@ -4615,6 +4615,7 @@ static int check_stack_write_var_off(struct bpf_ver=
ifier_env *env,
>
>         /* Variable offset writes destroy any spilled pointers in range. =
*/
>         for (i =3D min_off; i < max_off; i++) {
> +               struct bpf_reg_state *spill_reg;
>                 u8 new_type, *stype;
>                 int slot, spi;
>
> @@ -4640,7 +4641,18 @@ static int check_stack_write_var_off(struct bpf_ve=
rifier_env *env,
>                         return -EINVAL;
>                 }
>
> -               /* Erase all spilled pointers. */
> +               /* If writing_zero and the the spi slot contains a spill =
of value 0,
> +                * maintain the spill type.
> +                */
> +               if (writing_zero && is_spilled_scalar_reg(&state->stack[s=
pi])) {

nit: I'd probably move `struct bpf_reg_state *spill_reg;` here to keep it l=
ocal

other than the missing `*stype =3D=3D STACK_SPILL` check that Eduard
already called out, looks good to me!

> +                       spill_reg =3D &state->stack[spi].spilled_ptr;
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

[...]

