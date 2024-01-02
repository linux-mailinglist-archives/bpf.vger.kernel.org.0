Return-Path: <bpf+bounces-18811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B28822353
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 22:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87B1AB21FD4
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 21:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC42168AF;
	Tue,  2 Jan 2024 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOBVc3yl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43DD168A8
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a22f59c6ae6so1146801766b.1
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 13:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704231788; x=1704836588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IY+vgUmxJ6YZ+SLMShwvOtj1SD8B7Ha+dCYU/bKc6A=;
        b=JOBVc3ylB/ramNzGPuzHSyxPWB2rpuGjcBZll3FSWs4BtiZAH6xuBoDujtvPxFcso1
         LOJ2J0ZdxKmMOyDfnQHDxHwbPu4KXejn+v6/bEiN03+jkWEhVIjJmS1WFyNIWyxnDrZf
         8zdwe/eOSSo6fJ70g4VIHipaRTJz9BDstpjtepiLc4njaGySTZUIwwjttvcdSUkqRTkr
         Rm2FGTPGxnv17ml7+BBZocxmIOXvneEVN5AEE+ZTQhmYQoBowCM0gZ6TaHBZ6wfveRAT
         5DLMIMT88E1glV+LyxJU9cynKEpuRwCwhhMv47jrdAjn1Z9Rgs+W/7BHZN57azxK2Bt1
         FwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704231788; x=1704836588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IY+vgUmxJ6YZ+SLMShwvOtj1SD8B7Ha+dCYU/bKc6A=;
        b=A4rAfeHDIXbD/LZgLl/dV/EmwuBwDLnVwO+uTLUJo9ZEpdykya3dA9sU2qtmQQmP0n
         UVtLnhVFBE8HGi9XTY75bs+gHvWveS3O4OKF1cCyQ21se5RCIELCb3VbJVreqOYjmxnM
         DEjEe7PLMDDh1ByoZ6cOBlZOed0ynPZkMvAXaic2CtynvEgOujC0xu+25ONHHNprqvpi
         EmLSN7qCsXk72/hQpw6P3kuLao2Zp6mKKscsd0UUH2a1mTa+H+gBn0OXJ/tW+I/mhsg4
         dbLLU7WVHbXDHCQcvU2WdTqyQ/Nye9Nro1xoJ3LrYdnJsLu26/QlxocCAkefgavCW5BA
         ++aA==
X-Gm-Message-State: AOJu0YzVuXdBSKGNeIC4YU18smIRbhJi+DaBA48ty3YN5kK3WFJGCArT
	aRdYm3lLkIxrwWTPruwTHacB+mmfdw87t+owBMw=
X-Google-Smtp-Source: AGHT+IFDe0d1AYKJEEbSbIcI8VWGL9uScVsC9WzCPYMhm0ndgyH+6XJIMp52GNe5MF4QKRFCY86DUkR2F8m9y9cUoZM=
X-Received: by 2002:a17:906:7492:b0:a28:620d:2bbe with SMTP id
 e18-20020a170906749200b00a28620d2bbemr201243ejl.265.1704231787796; Tue, 02
 Jan 2024 13:43:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102190726.2017424-1-yonghong.song@linux.dev>
In-Reply-To: <20240102190726.2017424-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jan 2024 13:42:55 -0800
Message-ID: <CAEf4BzaWets3fHUGtctwCNWecR9ASRCO2kFagNy8jJZmPBWYDA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Track aligned st store as imprecise spilled registers
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 11:07=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
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
>
> I checked cpuv3 and cpuv4 with and without this patch.
> There is no change for cpuv3 since '*(u64 *)(r10 - 8) =3D 0'
> is only generated with cpuv4.
>
> For cpuv4:
> $ ../veristat -C old.cpuv4.csv new.cpuv4.csv -e file,prog,insns,states -s=
 '|insns_diff|'
> File                                                   Program           =
                                    Insns (A)  Insns (B)  Insns    (DIFF)  =
States (A)  States (B)  States (DIFF)
> -----------------------------------------------------  ------------------=
----------------------------------  ---------  ---------  ---------------  =
----------  ----------  -------------
> pyperf600_bpf_loop.bpf.linked3.o                       on_event          =
                                         6066       4889  -1177 (-19.40%)  =
       403         321  -82 (-20.35%)
> xdp_synproxy_kern.bpf.linked3.o                        syncookie_tc      =
                                        12412      11719    -693 (-5.58%)  =
       345         330   -15 (-4.35%)
> xdp_synproxy_kern.bpf.linked3.o                        syncookie_xdp     =
                                        12478      11794    -684 (-5.48%)  =
       346         331   -15 (-4.34%)
> test_cls_redirect.bpf.linked3.o                        cls_redirect      =
                                        35483      35387     -96 (-0.27%)  =
      2179        2177    -2 (-0.09%)
> local_storage_bench.bpf.linked3.o                      get_local         =
                                          228        168    -60 (-26.32%)  =
        17          14   -3 (-17.65%)
> test_l4lb_noinline.bpf.linked3.o                       balancer_ingress  =
                                         4494       4522     +28 (+0.62%)  =
       217         219    +2 (+0.92%)
> test_l4lb_noinline_dynptr.bpf.linked3.o                balancer_ingress  =
                                         1432       1455     +23 (+1.61%)  =
        92          94    +2 (+2.17%)
> verifier_iterating_callbacks.bpf.linked3.o             widening          =
                                           52         41    -11 (-21.15%)  =
         4           3   -1 (-25.00%)
> test_xdp_noinline.bpf.linked3.o                        balancer_ingress_v=
6                                        3462       3458      -4 (-0.12%)  =
       216         216    +0 (+0.00%)
> ...
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
>  kernel/bpf/verifier.c                                   | 2 +-
>  tools/testing/selftests/bpf/progs/verifier_spill_fill.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a376eb609c41..17ad0228270e 100644
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

the change makes sense, there is nothing special about insn->imm =3D=3D 0
case, so LGTM

>                 struct bpf_reg_state fake_reg =3D {};
>
>                 __mark_reg_known(&fake_reg, insn->imm);
> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
> index 39fe3372e0e0..05de3de56e79 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> @@ -496,13 +496,13 @@ SEC("raw_tp")
>  __log_level(2)
>  __success
>  /* make sure fp-8 is all STACK_ZERO */

but we should update STACK_ZERO comments in this test

and also, STACK_ZERO situation is still possible, right? E.g., when we
spill register at -4 offset, not -8. So I'd either extend or add
another test to make sure we still validate that STACK_ZERO slots
return precise zero. Can you add something like this?


> -__msg("2: (7a) *(u64 *)(r10 -8) =3D 0          ; R10=3Dfp0 fp-8_w=3D0000=
0000")
> +__msg("2: (7a) *(u64 *)(r10 -8) =3D 0          ; R10=3Dfp0 fp-8_w=3D0")
>  /* but fp-16 is spilled IMPRECISE zero const reg */
>  __msg("4: (7b) *(u64 *)(r10 -16) =3D r0        ; R0_w=3D0 R10=3Dfp0 fp-1=
6_w=3D0")
>  /* validate that assigning R2 from STACK_ZERO doesn't mark register
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
> --
> 2.34.1
>

