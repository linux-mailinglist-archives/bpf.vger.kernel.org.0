Return-Path: <bpf+bounces-35578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED5B93B957
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 00:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3797283FDD
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 22:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C0A13D8A8;
	Wed, 24 Jul 2024 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWQU5eQK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCC313A40F
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721861776; cv=none; b=BLCZn4tbFP/aNFry355pMQj28aaoORc77fqxbU948xA7/A6Tz5ttvfAnKzxjJszOtZcD0occYjywDcmT/uXW6LAhNjtk79eh1b0cjrcNWzLms8ZlmQ6l1WO8SddNtUuasZFN3qvNmCr7YuqubpuE3mTGnNoYqCN0SPsqoXKgmn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721861776; c=relaxed/simple;
	bh=AhtclKYqc87to2e3cjQ7SgUnh4xHZAnTDlXPv0/ETpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRE4lfeoxYUXXjhGMW8JYogggLMD7Hjn+6fmtOhZwzgawSNizWx0oq4UWtxwm175Fogd5+5eb94v1gIk0CYcEMmOPx+M/j1E9aNKUCIfcoSaYnnkvVNSZQZbz6pqhSlkDGw7vGTJClfdRdtVWguXqhJGeqC13I8UwYMwqXN39t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWQU5eQK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d25b5b6b0so241257b3a.2
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 15:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721861774; x=1722466574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdLnQlYExMVGdL86psdlJXVC9eTfPNNJsCsSEjGc7RI=;
        b=BWQU5eQKtWOJI4trfRj+p429+7J7iSB9mtUdt5vfYRh3p/0gFqH7kMmd9NdLUbeS8y
         zK81R9XWqwCl9WOUSSFH59HFs/QEor44W8IEw/3pZxlVi7nhdho3/xKsUbbrDTIWLad5
         bDAGBtpjKyH86S0yBis/Je7wYdhmagjMt7q9FFi6XPU+nuZW5It0YSpFQICXk841J/sb
         xw2VuFj1K8PrKPMQOT16+6TcyT2R0JWkNMr0/W+LERnwsB3icc7Mopp9B3GGFcVQdwGR
         KHTieeVbknoxVn0KO6vYpnxpq1uOzY/dgVjtatE/1kVbjIqwg/Y/I6ORz9+IF6/jXWpu
         tBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721861774; x=1722466574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdLnQlYExMVGdL86psdlJXVC9eTfPNNJsCsSEjGc7RI=;
        b=o/C3GriOzcCX+iy8sXhp1dDEVFTLan+0CHC619+dEpYzry0rwtCM3gm1eBLggUPT9z
         JEbqOaGDEQDtC5oJcSaZ3pbRwH4/5b0aR1Vy6/SxA4VMfaJTdccqux1sWDm1Owq7C/r9
         ofECO+2e/TynYkcihFkFuxSxOPNlLRe6UgAHe2vSxBE5414tpnqU28h1PiMInJ7sBZZg
         YhWqHSW1MOknnaUlP2yQJE89R/+I8rC7nJntRGJQQ+etZy/7ZsJ5lu1ppQ5RgU2sNADv
         qAMZClDvaokT1o/iTcyb2fi3th3a6ipC+2vSYr8fH6x3Eg4fGSpjgMxR8d6VX/NURzNW
         59gg==
X-Gm-Message-State: AOJu0Yyq8o++eKjxEG0S6DSB8OPJccPBPwa7yRHpYr3dKO2imcb6KeQu
	dxFNnuYuDtZXMfq5A6tXu4FPOjkfjlpfkIG5Q1WyK3bkqdc6JkPR/SjyndlG6UcxdNSEo8yo8/o
	jcrb3WbbRGpSyAJdOXL15m3TiG0M=
X-Google-Smtp-Source: AGHT+IHH0PDLCdGliiXrX8Vyo8+6acU0LjmzT+KL0wvcQAbd3jcR8Mt9GjZYsnH+Lkj+ElELHOjhaDLf55LCiKIrNT8=
X-Received: by 2002:a05:6a20:4314:b0:1be:caf6:66e5 with SMTP id
 adf61e73a8af0-1c4727a6275mr1641248637.6.1721861774410; Wed, 24 Jul 2024
 15:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718052821.3753486-1-yonghong.song@linux.dev>
 <CAEf4BzYazgarMJNVqt33grWxYEcNWy_L=OCXwg9tw5wHYc+2iw@mail.gmail.com> <17304347-8431-46f3-affe-9da7b9546821@linux.dev>
In-Reply-To: <17304347-8431-46f3-affe-9da7b9546821@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Jul 2024 15:56:02 -0700
Message-ID: <CAEf4BzZ7oz+gEq4s9JoXgDs4aHGjYnSp6LiASauNeyUtBG3+Ug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Get better reg range with ldsx and
 32bit compare
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 11:16=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
> On 7/19/24 3:46 PM, Andrii Nakryiko wrote:
> > On Wed, Jul 17, 2024 at 10:28=E2=80=AFPM Yonghong Song <yonghong.song@l=
inux.dev> wrote:
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
> >> Actually insn #15 R1 smin range can be better. Before insn #15, we hav=
e
> >>    R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7fffffff)
> >> With the above range, we know for R1, upper 32bit can only be 0xffffff=
ff or 0.
> >> Otherwise, the value range for R1 could be beyond [smin=3D0xffffffff80=
000000,smax=3D0x7fffffff].
> >>
> >> After insn #15, for the true patch, we know smin32=3D0 and smax32=3D32=
. With the upper 32bit 0xffffffff,
> >> then the corresponding value is [0xffffffff00000000, 0xffffffff0000002=
0]. The range is
> >> obviously beyond the original range [smin=3D0xffffffff80000000,smax=3D=
0x7fffffff] and the
> >> range is not possible. So the upper 32bit must be 0, which implies smi=
n =3D smin32 and
> >> smax =3D smax32.
> >>
> >> This patch fixed the issue by adding additional register deduction aft=
er 32-bit compare
> > __reg_deduce_mixed_bounds() is called from reg_bounds_sync() pretty
> > much after every arithmetic operation or any comparison. Is the above
> > logic true universally or only after signed comparison? If the latter,
> > then we can't just do it unconditionally inside
> > __reg_deduce_mixed_bounds().
>
> It is not just for signed extension. Some other arithmetic operation may
> produce such a range as well.

Agreed. It took me a bit to grok this more intuitively, but I think I
got there. :)

>
> >
> >> insn. If the signed 32-bit register range is non-negative then 64-bit =
smin is
> >> in range of [S32_MIN, S32_MAX], then the actual 64-bit smin/smax shoul=
d be the same
> >> as 32-bit smin32/smax32.
> >>
> >> With this patch, iters/iter_arr_with_actual_elem_count succeeded with =
better register range:
> >>
> >> from 15 to 20: R0=3Drdonly_mem(id=3D7,ref_obj_id=3D2,sz=3D4) R1_w=3Dsc=
alar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D31,var_off=3D(0x0; 0=
x1f)) R6=3Dscalar(id=3D1,smin=3Dumin=3Dsmin32=3Dumin32=3D1,smax=3Dumax=3Dsm=
ax32=3Dumax32=3D32,var_off=3D(0x0; 0x3f)) R7=3Dscalar(id=3D9,smin=3D0,smax=
=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff)) R8=3Dscalar(id=3D9,smin=
=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff)) R10=3Dfp0 fp-8=
=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D3) refs=3D2
> >>
> >> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   kernel/bpf/verifier.c | 36 ++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 36 insertions(+)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 8da132a1ef28..46532437c4bb 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -2182,6 +2182,42 @@ static void __reg_deduce_mixed_bounds(struct bp=
f_reg_state *reg)
> >>                  reg->smin_value =3D max_t(s64, reg->smin_value, new_s=
min);
> >>                  reg->smax_value =3D min_t(s64, reg->smax_value, new_s=
max);
> >>          }
> >> +
> >> +       /* Here we would like to handle a special case after sign exte=
nding load,
> >> +        * when upper bits for a 64-bit range are all 1s or all 0s.
> >> +        *
> >> +        * Upper bits are all 1s when register is in a range:
> >> +        *   [0xffff_ffff_0000_0000, 0xffff_ffff_ffff_ffff]
> >> +        * Upper bits are all 0s when register is in a range:
> >> +        *   [0x0000_0000_0000_0000, 0x0000_0000_ffff_ffff]
> >> +        * Together this forms are continuous range:
> >> +        *   [0xffff_ffff_0000_0000, 0x0000_0000_ffff_ffff]
> >> +        *
> >> +        * Now, suppose that register range is in fact tighter:
> >> +        *   [0xffff_ffff_8000_0000, 0x0000_0000_ffff_ffff] (R)
> >> +        * Also suppose that it's 32-bit range is positive,
> >> +        * meaning that lower 32-bits of the full 64-bit register
> >> +        * are in the range:
> >> +        *   [0x0000_0000, 0x7fff_ffff] (W)
> >> +        *
> >> +        * If this happens, then any value in a range:
> >> +        *   [0xffff_ffff_0000_0000, 0xffff_ffff_7fff_ffff]
> >> +        * is smaller than a lowest bound of the range (R):
> >> +        *   0xffff_ffff_8000_0000
> >> +        * which means that upper bits of the full 64-bit register
> >> +        * can't be all 1s, when lower bits are in range (W).
> >> +        *
> >> +        * Note that:
> >> +        *  - 0xffff_ffff_8000_0000 =3D=3D (s64)S32_MIN
> >> +        *  - 0x0000_0000_ffff_ffff =3D=3D (s64)S32_MAX
> > ?? S32_MAX =3D 0x7fffffff, so should the right part be U32_MAX or the
> > left part should be 0x0000_0000_7fff_ffff ?
> Will make a change in the next revision.
> >
> >> +        * These relations are used in the conditions below.
> >> +        */
> >> +       if (reg->s32_min_value >=3D 0 && reg->smin_value >=3D S32_MIN =
&& reg->smax_value <=3D S32_MAX) {
> >> +               reg->smin_value =3D reg->umin_value =3D reg->s32_min_v=
alue;
> >> +               reg->smax_value =3D reg->umax_value =3D reg->s32_max_v=
alue;
> > let's please not mix signed and unsigned 32 -> 64 bit conversions,
> > they are confusing and tricky enough in each domain individually,
> > there is no point in mixing them
> Okay, will do.
> >
> >> +               reg->var_off =3D tnum_intersect(reg->var_off,
> >> +                                             tnum_range(reg->smin_val=
ue, reg->smax_value));
> >> +       }
> >>   }
> >>
> >>   static void __reg_deduce_bounds(struct bpf_reg_state *reg)
> >> --
> >> 2.43.0
> >>

