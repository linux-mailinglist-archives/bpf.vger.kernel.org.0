Return-Path: <bpf+bounces-18814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F14D8224AD
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 23:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195FA1F23724
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 22:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A3B171C8;
	Tue,  2 Jan 2024 22:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2u3iKjQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C691798E
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33694bf8835so8356913f8f.3
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 14:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704234164; x=1704838964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDwbLpzkiZwzLN6LlwqoPCHG8NWbwDYx8UA8VxHDvWE=;
        b=g2u3iKjQtXFsqpm5lXCAjU4oMwb7BhDProzFyOvwH7StxnH/H8K0VhUuSy5X8Fum4H
         iKXAvEuIW6W4zTP8Oxg+AYawstGWa7KiD7AWYFhL71NOJhLOauaq+K08jW8C3Ul3tp09
         Qb6AGUh/SyrM68W5TqNpN0GYcUsP8MKb3ZBjch6UoNracNBX8TGmjfHvP/pQYEL9C5ZO
         HqnfA7T/0F5tNkc9hlhiTwkCQ9WgT4M1gjuYeio27sgTC139OIl7Yp6oXmcx4PsU0EG/
         x4RZVUni77+rbVIy/jGo+42VlBj5D/1JLmtCxgbixIelLq6yyiAkSoFBdS39hthe8R8R
         dcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704234164; x=1704838964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDwbLpzkiZwzLN6LlwqoPCHG8NWbwDYx8UA8VxHDvWE=;
        b=DrQh4h0o8GdhaMRkpIZ4LDC47xindCEvxlhbB3scAPHOhM0AnazQxTzofITC97i1QA
         ZavQd5DkdiD+1n1NwvF/zUfESPY4iriAa8/XGTuy28W8Ikeo42OZuy10MEssZQPSR+t+
         XCvoauqN2p3wsGzZI+PmwWe+0raJ2tnhOx+d3X1i+0cvZ/YHItW5x5RWMyiKxsu9G8w8
         xFm+6woJKOYBQ5IHAo03ZfcHqaV9Tr2UExR3yfpcEYtP+I4Jie2gU/EINKyYGkEzIgZ7
         VCYXz1iQbAavhf/5MPT33rjDimKC8Yx9tQTHopnGRcEuq/2l5fTI5/i2b6ZQivgsFxxD
         IgnQ==
X-Gm-Message-State: AOJu0YwW293SfdKiAi9vOXSsCgUXqzLOLbywNOTFy5ZgiFTrGj5RHN7r
	mwF0WBQp5F4msMa+sc7wF+tnNUmw9opeEa/5hbo=
X-Google-Smtp-Source: AGHT+IF6O5iXD925W2UO5L5pXoxHYFHpRbT8UAattzm+OlZA4Y3RYMsbRNcEm9Z9mnsvuBn2d6LHwgmfmUf1XF1fYuE=
X-Received: by 2002:adf:a1c4:0:b0:336:c876:a3ff with SMTP id
 v4-20020adfa1c4000000b00336c876a3ffmr6764939wrv.71.1704234164170; Tue, 02 Jan
 2024 14:22:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102190726.2017424-1-yonghong.song@linux.dev> <CAEf4BzaWets3fHUGtctwCNWecR9ASRCO2kFagNy8jJZmPBWYDA@mail.gmail.com>
In-Reply-To: <CAEf4BzaWets3fHUGtctwCNWecR9ASRCO2kFagNy8jJZmPBWYDA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jan 2024 14:22:32 -0800
Message-ID: <CAEf4BzZccDxr-okp1J96iZ86BpJuPePdGySff87BeQZfQfWLCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Track aligned st store as imprecise spilled registers
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 1:42=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jan 2, 2024 at 11:07=E2=80=AFAM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
> >
> > With patch set [1], precision backtracing supports register spill/fill
> > to/from the stack. The patch [2] allows initial imprecise register spil=
l
> > with content 0. This is a common case for cpuv3 and lower for
> > initializing the stack variables with pattern
> >   r1 =3D 0
> >   *(u64 *)(r10 - 8) =3D r1
> > and the [2] has demonstrated good verification improvement.
> >
> > For cpuv4, the initialization could be
> >   *(u64 *)(r10 - 8) =3D 0
> > The current verifier marks the r10-8 contents with STACK_ZERO.
> > Similar to [2], let us permit the above insn to behave like
> > imprecise register spill which can reduce number of verified states.
> >
> > I checked cpuv3 and cpuv4 with and without this patch.
> > There is no change for cpuv3 since '*(u64 *)(r10 - 8) =3D 0'
> > is only generated with cpuv4.
> >
> > For cpuv4:
> > $ ../veristat -C old.cpuv4.csv new.cpuv4.csv -e file,prog,insns,states =
-s '|insns_diff|'
> > File                                                   Program         =
                                      Insns (A)  Insns (B)  Insns    (DIFF)=
  States (A)  States (B)  States (DIFF)
> > -----------------------------------------------------  ----------------=
------------------------------------  ---------  ---------  ---------------=
  ----------  ----------  -------------
> > pyperf600_bpf_loop.bpf.linked3.o                       on_event        =
                                           6066       4889  -1177 (-19.40%)=
         403         321  -82 (-20.35%)
> > xdp_synproxy_kern.bpf.linked3.o                        syncookie_tc    =
                                          12412      11719    -693 (-5.58%)=
         345         330   -15 (-4.35%)
> > xdp_synproxy_kern.bpf.linked3.o                        syncookie_xdp   =
                                          12478      11794    -684 (-5.48%)=
         346         331   -15 (-4.34%)
> > test_cls_redirect.bpf.linked3.o                        cls_redirect    =
                                          35483      35387     -96 (-0.27%)=
        2179        2177    -2 (-0.09%)
> > local_storage_bench.bpf.linked3.o                      get_local       =
                                            228        168    -60 (-26.32%)=
          17          14   -3 (-17.65%)
> > test_l4lb_noinline.bpf.linked3.o                       balancer_ingress=
                                           4494       4522     +28 (+0.62%)=
         217         219    +2 (+0.92%)
> > test_l4lb_noinline_dynptr.bpf.linked3.o                balancer_ingress=
                                           1432       1455     +23 (+1.61%)=
          92          94    +2 (+2.17%)
> > verifier_iterating_callbacks.bpf.linked3.o             widening        =
                                             52         41    -11 (-21.15%)=
           4           3   -1 (-25.00%)
> > test_xdp_noinline.bpf.linked3.o                        balancer_ingress=
_v6                                        3462       3458      -4 (-0.12%)=
         216         216    +0 (+0.00%)
> > ...
> >
> > test_l4lb_noinline and test_l4lb_noinline_dynptr has minor regression, =
but
> > pyperf600_bpf_loop and local_storage_bench gets pretty good improvement=
.
> >
> >   [1] https://lore.kernel.org/all/20231205184248.1502704-1-andrii@kerne=
l.org/
> >   [2] https://lore.kernel.org/all/20231205184248.1502704-9-andrii@kerne=
l.org/
> >
> > Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Cc: Martin KaFai Lau <kafai@fb.com>
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
> >  kernel/bpf/verifier.c                                   | 2 +-
> >  tools/testing/selftests/bpf/progs/verifier_spill_fill.c | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index a376eb609c41..17ad0228270e 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4491,7 +4491,7 @@ static int check_stack_write_fixed_off(struct bpf=
_verifier_env *env,
> >                 if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
> >                         state->stack[spi].spilled_ptr.id =3D 0;
> >         } else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn)=
 &&
> > -                  insn->imm !=3D 0 && env->bpf_capable) {
> > +                  env->bpf_capable) {
>
> the change makes sense, there is nothing special about insn->imm =3D=3D 0
> case, so LGTM
>
> >                 struct bpf_reg_state fake_reg =3D {};
> >
> >                 __mark_reg_known(&fake_reg, insn->imm);
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/=
tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > index 39fe3372e0e0..05de3de56e79 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > @@ -496,13 +496,13 @@ SEC("raw_tp")
> >  __log_level(2)
> >  __success
> >  /* make sure fp-8 is all STACK_ZERO */
>
> but we should update STACK_ZERO comments in this test
>
> and also, STACK_ZERO situation is still possible, right? E.g., when we
> spill register at -4 offset, not -8. So I'd either extend or add
> another test to make sure we still validate that STACK_ZERO slots
> return precise zero. Can you add something like this?
>
>
> > -__msg("2: (7a) *(u64 *)(r10 -8) =3D 0          ; R10=3Dfp0 fp-8_w=3D00=
000000")
> > +__msg("2: (7a) *(u64 *)(r10 -8) =3D 0          ; R10=3Dfp0 fp-8_w=3D0"=
)
> >  /* but fp-16 is spilled IMPRECISE zero const reg */
> >  __msg("4: (7b) *(u64 *)(r10 -16) =3D r0        ; R0_w=3D0 R10=3Dfp0 fp=
-16_w=3D0")
> >  /* validate that assigning R2 from STACK_ZERO doesn't mark register
> >   * precise immediately; if necessary, it will be marked precise later
> >   */
> > -__msg("6: (71) r2 =3D *(u8 *)(r10 -1)          ; R2_w=3D0 R10=3Dfp0 fp=
-8_w=3D00000000")
> > +__msg("6: (71) r2 =3D *(u8 *)(r10 -1)          ; R2_w=3D0 R10=3Dfp0 fp=
-8_w=3D0")
> >  /* similarly, when R2 is assigned from spilled register, it is initial=
ly
> >   * imprecise, but will be marked precise later once it is used in prec=
ise context
> >   */

And seems like test_verifier test is failing now ([0]):

  #114/p BPF_ST_MEM stack imm zero, variable offset FAIL
  Failed to load prog 'Invalid argument'!
  At program exit the register R0 has smin=3D0 smax=3D255 should have been =
in [0, 1]
  verification time 19 usec
  stack depth 32
  processed 11 insns (limit 1000000) max_states_per_insn 0
total_states 0 peak_states 0 mark_read 0


  [0] https://github.com/kernel-patches/bpf/actions/runs/7389645653/job/201=
03046755

> > --
> > 2.34.1
> >

