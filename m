Return-Path: <bpf+bounces-34135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 438EE92AA6E
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1667283026
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 20:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FA113FD84;
	Mon,  8 Jul 2024 20:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ev8QwKua"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF2C2E851
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720469934; cv=none; b=g+VNYN5aBfFjLJuyNuNMg8hA34OfF5jWpWQpZwHvCFdO0RtDXkYNawoNZxrDU/cbx2lypUV1ZCQBjZ8FwBvv+sJAlpTN/lwILzctQCRmDUzsTmHk1iA8K+Tmh6w+iuhbNYwgr7LNHJohH6WvuQADvmKdBjbF6fH90AQ5RiIK/3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720469934; c=relaxed/simple;
	bh=ncWCNezqVW9PcaC7+rOR0JLsjfAHYsTgO+IZYmt8m/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVR9Y8RpbMV66Vhqi+BN+sNCNKbtbsTOkhGuNU7Lz67PmIN4aVknnS/Q1v2UonOAIhzVbkRIIxQqXbcx8H8LjzI0FC45+9s+nRXhQ3SZfMMy8pzSoY5LydN3qxb0jSwYhJVmQSH/o7DPKnr5OrTtQaXbFkvJ6xx0PeC3Jt/VGkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ev8QwKua; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3678f36f154so2339564f8f.2
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 13:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720469931; x=1721074731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLUXWe9W4ozo88ywBD8li/hjRhL2Z8QNpy7sxHV/AqE=;
        b=Ev8QwKuaYMOfC2eGCuQfIbe79zDlWTmmyUvO/NMxQRQdaHLrCfbOerx4OljA8k61GP
         ZlsJjMOpKlqiZPm8EuIMLI+uMrm+HpDf3ogiC2pZHoTm2tBJJ+QX1weym8GKQORva5Wq
         eVcw8oF6ZF8Sur/d9T+n9EQ5aIjC/Izrkh+BTKlke+Tk5pPjd4JvokaAW4IGKYo5Dr/E
         QzG+uumwJo7nZA49nmDmFBCV6fdEhRQS8dx9wp2uFcyu4B054vT9wzycMqKGbB+J38a+
         fBkRgJI9nfvEtTO1PMol2thmJ8DzFe8W2RGHZxrPhLL3aCkPYESPdaa5KXa4Leh4ywUH
         KT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720469931; x=1721074731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLUXWe9W4ozo88ywBD8li/hjRhL2Z8QNpy7sxHV/AqE=;
        b=G0lNfxbAe+tnrWZsrWmWkOToHamve4cOZ9Enx9sISY6/zUzZQYsdd9+FavvDk7WQHe
         mvt1qLjJSpGA4ysC0rHERsXMNwUrE7PCJguTieGDmuQ+U3F31pGqHxB5lQ3Ns09ivzjo
         rww8hvGLvuhz6ki0vUlu/1hn+FedDMoPEHOwMk/aSlECkZfTpf0t0HI5ptMfxLmCW3m5
         YV6r2ReQF4cEqF1gJrXGjLwOl10q9KMA4uGYTjS+4FCtDTQDgfb4PrfOAPQvGyif9nXi
         2p8HN7X1+Sv0dfBoyt5h2oIi6RylDVRGugehrfhmQq64qQZ/o2Cci9Qubq12v1Gz92wg
         dc2w==
X-Gm-Message-State: AOJu0Yx68QTkxwU0MCXetJ8QQgbW6Fcb0Os69LdmnSryEXIrv/iHBOh2
	+F7/Wi5EyHlm1RN90cqyRoTZfeRozqQlWNY65O/pw9PCxDbBkCPgfmiOFo3zbUDbpEorkq/zHZn
	I5xAOjl3tIixhYUjVRS2uKtjCx6E=
X-Google-Smtp-Source: AGHT+IF+j2S5Pozt6Pec76/3icfKI+mIGPi5lVs9asLBmcqFH08to0FMSUjhxzkDYNbr3wiP28O1a5OGOKNkYjK6XXI=
X-Received: by 2002:adf:e7ca:0:b0:367:9522:5e6d with SMTP id
 ffacd0b85a97d-367cead15ddmr413364f8f.52.1720469930444; Mon, 08 Jul 2024
 13:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708154634.283426-1-yonghong.song@linux.dev>
 <CAADnVQL4YenuuaAjpW0T7mHv=LEk4xZHS2W=OF6QJsUPL700ZQ@mail.gmail.com> <234f2c8e-b4f5-4cda-86b9-651b5b9bc915@linux.dev>
In-Reply-To: <234f2c8e-b4f5-4cda-86b9-651b5b9bc915@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Jul 2024 13:18:38 -0700
Message-ID: <CAADnVQJTgxhpKJDLVb9FY+Zuu7NNuTzEq9Cy4zFJ2=DDHSCFng@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Workaround iters/iter_arr_with_actual_elem_count
 failure when -mcpu=cpuv4
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 11:34=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 7/8/24 9:27 AM, Alexei Starovoitov wrote:
> > On Mon, Jul 8, 2024 at 8:46=E2=80=AFAM Yonghong Song <yonghong.song@lin=
ux.dev> wrote:
> >> With latest llvm19, the selftest iters/iter_arr_with_actual_elem_count
> >> failed with -mcpu=3Dv4.
> >>
> >> The following are the details:
> >>    0: R1=3Dctx() R10=3Dfp0
> >>    ; int iter_arr_with_actual_elem_count(const void *ctx) @ iters.c:14=
20
> >>    0: (b4) w7 =3D 0                        ; R7_w=3D0
> >>    ; int i, n =3D loop_data.n, sum =3D 0; @ iters.c:1422
> >>    1: (18) r1 =3D 0xffffc90000191478       ; R1_w=3Dmap_value(map=3Dit=
ers.bss,ks=3D4,vs=3D1280,off=3D1144)
> >>    3: (61) r6 =3D *(u32 *)(r1 +128)        ; R1_w=3Dmap_value(map=3Dit=
ers.bss,ks=3D4,vs=3D1280,off=3D1144) R6_w=3Dscalar(smin=3D0,smax=3Dumax=3D0=
xffffffff,var_off=3D(0x0; 0xffffffff))
> >>    ; if (n > ARRAY_SIZE(loop_data.data)) @ iters.c:1424
> >>    4: (26) if w6 > 0x20 goto pc+27       ; R6_w=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D32,var_off=3D(0x0; 0x3f))
> >>    5: (bf) r8 =3D r10                      ; R8_w=3Dfp0 R10=3Dfp0
> >>    6: (07) r8 +=3D -8                      ; R8_w=3Dfp-8
> >>    ; bpf_for(i, 0, n) { @ iters.c:1427
> >>    7: (bf) r1 =3D r8                       ; R1_w=3Dfp-8 R8_w=3Dfp-8
> >>    8: (b4) w2 =3D 0                        ; R2_w=3D0
> >>    9: (bc) w3 =3D w6                       ; R3_w=3Dscalar(id=3D1,smin=
=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D32,var_off=3D(0x0; 0x3f)) R6_=
w=3Dscalar(id=3D1,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D32,var_=
off=3D(0x0; 0x3f))
> >>    10: (85) call bpf_iter_num_new#45179          ; R0=3Dscalar() fp-8=
=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D0) refs=3D2
> >>    11: (bf) r1 =3D r8                      ; R1=3Dfp-8 R8=3Dfp-8 refs=
=3D2
> >>    12: (85) call bpf_iter_num_next#45181 13: R0=3Drdonly_mem(id=3D3,re=
f_obj_id=3D2,sz=3D4) R6=3Dscalar(id=3D1,smin=3Dsmin32=3D0,smax=3Dumax=3Dsma=
x32=3Dumax32=3D32,var_off=3D(0x0; 0x3f)) R7=3D0 R8=3Dfp-8 R10=3Dfp0 fp-8=3D=
iter_num(ref_id=3D2,state=3Dactive,depth=3D1) refs=3D2
> >>    ; bpf_for(i, 0, n) { @ iters.c:1427
> >>    13: (15) if r0 =3D=3D 0x0 goto pc+2       ; R0=3Drdonly_mem(id=3D3,=
ref_obj_id=3D2,sz=3D4) refs=3D2
> >>    14: (81) r1 =3D *(s32 *)(r0 +0)         ; R0=3Drdonly_mem(id=3D3,re=
f_obj_id=3D2,sz=3D4) R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7ffff=
fff) refs=3D2
> >>    15: (ae) if w1 < w6 goto pc+4 20: R0=3Drdonly_mem(id=3D3,ref_obj_id=
=3D2,sz=3D4) R1=3Dscalar(smin=3D0xffffffff80000000,smax=3Dsmax32=3Dumax32=
=3D31,umax=3D0xffffffff0000001f,smin32=3D0,var_off=3D(0x0; 0xffffffff000000=
1f)) R6=3Dscalar(id=3D1,smin=3Dumin=3Dsmin32=3Dumin32=3D1,smax=3Dumax=3Dsma=
x32=3Dumax32=3D32,var_off=3D(0x0; 0x3f)) R7=3D0 R8=3Dfp-8 R10=3Dfp0 fp-8=3D=
iter_num(ref_id=3D2,state=3Dactive,depth=3D1) refs=3D2
> >>    ; sum +=3D loop_data.data[i]; @ iters.c:1429
> >>    20: (67) r1 <<=3D 2                     ; R1_w=3Dscalar(smax=3D0x7f=
fffffc0000007c,umax=3D0xfffffffc0000007c,smin32=3D0,smax32=3Dumax32=3D124,v=
ar_off=3D(0x0; 0xfffffffc0000007c)) refs=3D2
> >>    21: (18) r2 =3D 0xffffc90000191478      ; R2_w=3Dmap_value(map=3Dit=
ers.bss,ks=3D4,vs=3D1280,off=3D1144) refs=3D2
> >>    23: (0f) r2 +=3D r1
> >>    math between map_value pointer and register with unbounded min valu=
e is not allowed
> >>
> >> The source code:
> >>    int iter_arr_with_actual_elem_count(const void *ctx)
> >>    {
> >>          int i, n =3D loop_data.n, sum =3D 0;
> >>
> >>          if (n > ARRAY_SIZE(loop_data.data))
> >>                  return 0;
> >>
> >>          bpf_for(i, 0, n) {
> >>                  /* no rechecking of i against ARRAY_SIZE(loop_data.n)=
 */
> >>                  sum +=3D loop_data.data[i];
> >>          }
> >>
> >>          return sum;
> >>    }
> >>
> >> The insn #14 is a sign-extenstion load which is related to 'int i'.
> >> The insn #15 did a subreg comparision. Note that smin=3D0xffffffff8000=
0000 and this caused later
> >> insn #23 failed verification due to unbounded min value.
> >>
> >> Actually insn #15 smin range can be better. Since after comparison, we=
 know smin32=3D0 and smax32=3D32.
> >> With insn #14 being a sign-extension load. We will know top 32bits sho=
uld be 0 as well.
> >> Current verifier is not able to handle this, and this patch is a worka=
round to fix
> >> test failure by changing variable 'i' type from 'int' to 'unsigned' wh=
ich will give
> >> proper range during comparison.
> >>
> >>    ; bpf_for(i, 0, n) { @ iters.c:1428
> >>    13: (15) if r0 =3D=3D 0x0 goto pc+2       ; R0=3Drdonly_mem(id=3D3,=
ref_obj_id=3D2,sz=3D4) refs=3D2
> >>    14: (61) r1 =3D *(u32 *)(r0 +0)         ; R0=3Drdonly_mem(id=3D3,re=
f_obj_id=3D2,sz=3D4) R1_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,var_of=
f=3D(0x0; 0xffffffff)) refs=3D2
> >>    ...
> >>    from 15 to 20: R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2,sz=3D4) R1=3Ds=
calar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D31,var_off=3D(0x0; =
0x1f)) R6=3Dscalar(id=3D1,smin=3Dumin=3Dsmin32=3Dumin32=3D1,smax=3Dumax=3Ds=
max32=3Dumax32=3D32,var_off=3D(0x0; 0x3f)) R7=3D0 R8=3Dfp-8 R10=3Dfp0 fp-8=
=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D1) refs=3D2
> >>    20: R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2,sz=3D4) R1=3Dscalar(smin=
=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D31,var_off=3D(0x0; 0x1f)) R6=
=3Dscalar(id=3D1,smin=3Dumin=3Dsmin32=3Dumin32=3D1,smax=3Dumax=3Dsmax32=3Du=
max32=3D32,var_off=3D(0x0; 0x3f)) R7=3D0 R8=3Dfp-8 R10=3Dfp0 fp-8=3Diter_nu=
m(ref_id=3D2,state=3Dactive,depth=3D1) refs=3D2
> >>    ; sum +=3D loop_data.data[i]; @ iters.c:1430
> >>    20: (67) r1 <<=3D 2                     ; R1_w=3Dscalar(smin=3Dsmin=
32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D124,var_off=3D(0x0; 0x7c)) refs=3D2
> >>    21: (18) r2 =3D 0xffffc90000185478      ; R2_w=3Dmap_value(map=3Dit=
ers.bss,ks=3D4,vs=3D1280,off=3D1144) refs=3D2
> >>    23: (0f) r2 +=3D r1
> >>    mark_precise: frame0: last_idx 23 first_idx 20 subseq_idx -1
> >>    ...
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   tools/testing/selftests/bpf/progs/iters.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing=
/selftests/bpf/progs/iters.c
> >> index 16bdc3e25591..d1801d151a12 100644
> >> --- a/tools/testing/selftests/bpf/progs/iters.c
> >> +++ b/tools/testing/selftests/bpf/progs/iters.c
> >> @@ -1419,7 +1419,8 @@ SEC("raw_tp")
> >>   __success
> >>   int iter_arr_with_actual_elem_count(const void *ctx)
> >>   {
> >> -       int i, n =3D loop_data.n, sum =3D 0;
> >> +       unsigned i;
> >> +       int n =3D loop_data.n, sum =3D 0;
> >>
> >>          if (n > ARRAY_SIZE(loop_data.data))
> >>                  return 0;
> > I think we only have one realistic test that
> > checks 'range vs range' verifier logic.
> > Since "int i; bpf_for(i"
> > is a very common pattern in all other bpf_for tests it feels
> > wrong to workaround like this.
>
> Agree. We should fix this in verifier to be user friendly.
>
> >
> > What exactly needs to be improved in 'range vs range' logic to
> > handle this case?
>
> We can add a bit in struct bpf_reg_state like below
>         struct bpf_reg_state {
>                 ...
>                 enum bpf_reg_liveness live;
>                 bool precise;
>         }
> to
>         struct bpf_reg_state {
>                 ...
>                 enum bpf_reg_liveness live;
>                 unsigned precise:1;
>                 unsigned 32bit_sign_ext:1;  /* for *(s32 *)(...) */
>         }
> When the insn 15 is processed with 'true' branch
>    14: (81) r1 =3D *(s32 *)(r0 +0)         ; R0=3Drdonly_mem(id=3D3,ref_o=
bj_id=3D2,sz=3D4) R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7fffffff=
) refs=3D2
>    15: (ae) if w1 < w6 goto pc+4
>
> the 32bit_sign_ext will indicate the register r1 is from 32bit sign exten=
sion, so once w1 range is refined, the upper 32bit can be recalculated.
>
> Can we avoid 32bit_sign_exit in the above? Let us say we have
>    r1 =3D ...;  R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7fffffff=
), R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D32,var_o=
ff=3D(0x0; 0x3f))
>    if w1 < w6 goto pc+4
> where r1 achieves is trange through other means than 32bit sign extension=
 e.g.
>    call bpf_get_prandom_u32;
>    r1 =3D r0;
>    r1 <<=3D 32;
>    call bpf_get_prandom_u32;
>    r1 |=3D r0;  /* r1 is 64bit random number */
>    r2 =3D 0xffffffff80000000 ll;
>    if r1 s< r2 goto end;
>    if r1 s> 0x7fffFFFF goto end; /* after this r1 range (smin=3D0xfffffff=
f80000000,smax=3D0x7fffffff) */
>    if w1 < w6 goto end;
>    ...  <=3D=3D=3D w1 range [0,31]
>         <=3D=3D=3D but if we have upper bit as 0xffffffff........, then t=
he range will be
>         <=3D=3D=3D [0xffffffff0000001f, 0xffffffff00000000] and this rang=
e is not possible compared to original r1 range.

Just rephrasing for myself...
Because smin=3D0xffffffff80000000 if upper 32-bit =3D=3D 0xffffFFFF
then lower 32-bit has to be negative.
and because we're doing unsigned compare w1 < w6
and w6 is less than 80000000
we can conclude that upper bits are zero.
right?

>         <=3D=3D=3D so the only possible way for upper 32bit range is 0.
> end:
>
> Therefore, looks like we do not need 32bit_sign_exit. Just from
> R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7fffffff)
> with refined range in true path of 'if w1 < w6 goto ...',
> we can further refine w1 range properly.

yep. looks like it.
We can hard code this special logic for this specific smin/smax pair,
but the gut feel is that we can generalize it further.

