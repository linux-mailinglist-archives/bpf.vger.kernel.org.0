Return-Path: <bpf+bounces-31986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DABBF905EFC
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 01:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595ED1F21EDD
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 23:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6F112C819;
	Wed, 12 Jun 2024 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBGx5+Ol"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F5E12C544
	for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718234028; cv=none; b=ZSFrn0QOZeeqdvD+ghJCHqKQ3MmxokSzOF/JCL+nP0K+cP66oxM4tKMzNAyxtiDxzqmeT+Zjeex3OiX3eAcakizMz8BiLonR4WXahZgiBKhe2V0QPQRQEK5bCVGgJpSc7pbeecF+KcIsiEtIhltf23YeaP7uvKjxft3FQrbX9/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718234028; c=relaxed/simple;
	bh=tay+E+9d82gTXaaZmWW3P+fnE8jsFwfdJUwN9oj8Ddo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RF5LBHHI6ALgxKpYONaoTX20pxd68SABwNfz97m3zzoxtzR9QnKeGbRKssu6WAgonUV/FVggfFzwaTcOGWj+pjEXnsMbSRqVU15uJFg8avs2MlhM6hWBZFIm4R4eJcMLVr1OOLlRjd/yfwCqQ2qrz76VDIb/0bYA8vnnFDXe8+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBGx5+Ol; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42281d8cd2dso3168895e9.3
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 16:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718234025; x=1718838825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVlqVJqnEUSmI5HHCZstmKqKcvAAhF97ztDNwWmrW3E=;
        b=UBGx5+OlXXaHIEEPihNMufuNzMNCCuO21eZW3AgOkmiwnTV+iKhRzz9DgZZtUvSQP1
         ddoqrhNb5jsnOOS3Wcj2RhwmRDQI8+GFEMEEcGHK8wFnRrVEIdTdqhgKZukR01UOVyqY
         NqTExgGgbsrtoeyPt2SzwIeO43SwTL7SY8xuXB1hksKz4vkpGRV25y58+nVwo2y1w5T1
         lj4gi+ZQTkqNhfLw8IWCnw44A2IT/OAARQO66CdR5noFFs8Y3qOoQC1YECFl9iDM07AR
         Y30dC5LUu+RJnFIidcZIoNIA3rg8ZHfhafGQFy7ddJ02l1+pVVZWNjbjeEm6TYPPWhjR
         M3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718234025; x=1718838825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVlqVJqnEUSmI5HHCZstmKqKcvAAhF97ztDNwWmrW3E=;
        b=fbTVOTzJ0y0mdTSEq/uwgVkXg2wjAJSLhgOyk8F5oDdRaKNjR6wAKtNxe8wjFCREoU
         vIiBBVDiQ9R7TNUYdDpUrZRSZ1W+sUJ/ajAS8nKRyPbqFMJbDTCXmXJOUgMYQl6xv220
         68xdRLzj/SU5iF8N9mp4iJoRz2G2DGnQegwNlT6mlBsMswCJiF0RWrrYAqkWy+oiyI+8
         +A1r0xemPRqZPRea9uev8UMYVtq9NrJ5Fk0DA7NZFAECUyttMlwXwmIZQ8/B3W7cFqfG
         tUiMdPQ+LUs09uERMumiLhZcACp/YjO0o0e6itngt6k4KeqsdFnZTqKZl+cAqKGllBo0
         6ZXg==
X-Gm-Message-State: AOJu0YwVq9hgyTHZpPkEw2CP6FouzTXNwCnJeP5S5VWoW5wFtqtzYrLp
	NVHYHId4pBZJ0gEHbp1BS3w8SkyUWVXbKJ15mVUgiz1oiiY+9jZ6Lm/lE0NIp6El2hOaUQ0mEjM
	RK/AzTdsqRAE0zaCQD1mys7inh9rwtQ==
X-Google-Smtp-Source: AGHT+IFrxxaoFYG7qYKlYMiKeeMN3CTwtOrstSL0jOP3tuZke0PZ+gjjmLL8mLAdQMUwIDDitjs0yVyVqvYuDU9iPSk=
X-Received: by 2002:adf:fe0a:0:b0:35f:fa0:cf82 with SMTP id
 ffacd0b85a97d-35fe891b400mr2160979f8f.68.1718234024888; Wed, 12 Jun 2024
 16:13:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612221405.3378-1-daniel@iogearbox.net>
In-Reply-To: <20240612221405.3378-1-daniel@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Jun 2024 16:13:33 -0700
Message-ID: <CAADnVQJgFWciD8tgtzq=Pv56Dz+pre3eJtOi_xWca1ZZAQQnmA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix reg_set_min_max corruption of fake_reg
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf <bpf@vger.kernel.org>, jjlopezjaimez@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 3:40=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Juan reported that after doing some changes to buzzer [0] and implementin=
g
> a new fuzzing strategy guided by coverage, they noticed the following in
> one of the probes:
>
>   [...]
>   13: (79) r6 =3D *(u64 *)(r0 +0)         ; R0=3Dmap_value(ks=3D4,vs=3D8)=
 R6_w=3Dscalar()
>   14: (b7) r0 =3D 0                       ; R0_w=3D0
>   15: (b4) w0 =3D -1                      ; R0_w=3D0xffffffff
>   16: (74) w0 >>=3D 1                     ; R0_w=3D0x7fffffff
>   17: (5c) w6 &=3D w0                     ; R0_w=3D0x7fffffff R6_w=3Dscal=
ar(smin=3Dsmin32=3D0,smax=3Dumax=3Dumax32=3D0x7fffffff,var_off=3D(0x0; 0x7f=
ffffff))
>   18: (44) w6 |=3D 2                      ; R6_w=3Dscalar(smin=3Dumin=3Ds=
min32=3Dumin32=3D2,smax=3Dumax=3Dumax32=3D0x7fffffff,var_off=3D(0x2; 0x7fff=
fffd))
>   19: (56) if w6 !=3D 0x7ffffffd goto pc+1
>   REG INVARIANTS VIOLATION (true_reg2): range bounds violation u64=3D[0x7=
fffffff, 0x7ffffffd] s64=3D[0x7fffffff, 0x7ffffffd] u32=3D[0x7fffffff, 0x7f=
fffffd] s32=3D[0x7fffffff, 0x7ffffffd] var_off=3D(0x7fffffff, 0x0)
>   REG INVARIANTS VIOLATION (false_reg1): range bounds violation u64=3D[0x=
7fffffff, 0x7ffffffd] s64=3D[0x7fffffff, 0x7ffffffd] u32=3D[0x7fffffff, 0x7=
ffffffd] s32=3D[0x7fffffff, 0x7ffffffd] var_off=3D(0x7fffffff, 0x0)
>   REG INVARIANTS VIOLATION (false_reg2): const tnum out of sync with rang=
e bounds u64=3D[0x0, 0xffffffffffffffff] s64=3D[0x8000000000000000, 0x7ffff=
fffffffffff] u32=3D[0x0, 0xffffffff] s32=3D[0x80000000, 0x7fffffff] var_off=
=3D(0x7fffffff, 0x0)
>   19: R6_w=3D0x7fffffff
>   20: (95) exit
>
>   from 19 to 21: R0=3D0x7fffffff R6=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin3=
2=3D2,smax=3Dumax=3Dsmax32=3Dumax32=3D0x7ffffffe,var_off=3D(0x2; 0x7ffffffd=
)) R7=3Dmap_ptr(ks=3D4,vs=3D8) R9=3Dctx() R10=3Dfp0 fp-24=3Dmap_ptr(ks=3D4,=
vs=3D8) fp-40=3Dmmmmmmmm
>   21: R0=3D0x7fffffff R6=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D2,smax=
=3Dumax=3Dsmax32=3Dumax32=3D0x7ffffffe,var_off=3D(0x2; 0x7ffffffd)) R7=3Dma=
p_ptr(ks=3D4,vs=3D8) R9=3Dctx() R10=3Dfp0 fp-24=3Dmap_ptr(ks=3D4,vs=3D8) fp=
-40=3Dmmmmmmmm
>   21: (14) w6 -=3D 2147483632             ; R6_w=3Dscalar(smin=3Dumin=3Du=
min32=3D2,smax=3Dumax=3D0xffffffff,smin32=3D0x80000012,smax32=3D14,var_off=
=3D(0x2; 0xfffffffd))
>   22: (76) if w6 s>=3D 0xe goto pc+1      ; R6_w=3Dscalar(smin=3Dumin=3Du=
min32=3D2,smax=3Dumax=3D0xffffffff,smin32=3D0x80000012,smax32=3D13,var_off=
=3D(0x2; 0xfffffffd))
>   23: (95) exit
>
>   from 22 to 24: R0=3D0x7fffffff R6_w=3D14 R7=3Dmap_ptr(ks=3D4,vs=3D8) R9=
=3Dctx() R10=3Dfp0 fp-24=3Dmap_ptr(ks=3D4,vs=3D8) fp-40=3Dmmmmmmmm
>   24: R0=3D0x7fffffff R6_w=3D14 R7=3Dmap_ptr(ks=3D4,vs=3D8) R9=3Dctx() R1=
0=3Dfp0 fp-24=3Dmap_ptr(ks=3D4,vs=3D8) fp-40=3Dmmmmmmmm
>   24: (14) w6 -=3D 14                     ; R6_w=3D0
>   [...]
>
> What can be seen here is a register invariant violation on line 19. After
> the binary-or in line 18, the verifier knows that bit 2 is set but knows
> nothing about the rest of the content which was loaded from a map value,
> meaning, range is [2,0x7fffffff] with var_off=3D(0x2; 0x7ffffffd). When i=
n
> line 19 the verifier analyzes the branch, it splits the register states
> in reg_set_min_max() into the registers of the true branch (true_reg1,
> true_reg2) and the registers of the false branch (false_reg1, false_reg2)=
.
>
> Since the test is w6 !=3D 0x7ffffffd, the src_reg is a known constant.
> Internally, the verifier creates a "fake" register initialized as scalar
> to the value of 0x7ffffffd, and then passes it onto reg_set_min_max(). No=
w,
> for line 19, it is mathematically impossible to take the false branch of
> this program, yet the verifier analyzes it. It is impossible because the
> second bit of r6 will be set due to the prior or operation and the
> constant in the condition has that bit unset (hex(fd) =3D=3D binary(1111 =
1101).
>
> When the verifier first analyzes the false / fall-through branch, it will
> compute an intersection between the var_off of r6 and of the constant. Th=
is
> is because the verifier creates a "fake" register initialized to the valu=
e
> of the constant. The intersection result later refines both registers in
> regs_refine_cond_op():
>
>   [...]
>   t =3D tnum_intersect(tnum_subreg(reg1->var_off), tnum_subreg(reg2->var_=
off));
>   reg1->var_off =3D tnum_with_subreg(reg1->var_off, t);
>   reg2->var_off =3D tnum_with_subreg(reg2->var_off, t);
>   [...]
>
> Since the verifier is analyzing the false branch of the conditional jump,
> reg1 is equal to false_reg1 and reg2 is equal to false_reg2, i.e. the reg=
2
> is the "fake" register that was meant to hold a constant value. The resul=
ting
> var_off of the intersection says that both registers now hold a known val=
ue
> of var_off=3D(0x7fffffff, 0x0) or in other words: this operation manages =
to
> make the verifier think that the "constant" value that was passed in the
> jump operation now holds a different value.
>
> Normally this would not be an issue since it should not influence the tru=
e
> branch, however, false_reg2 and true_reg2 are pointers to the same "fake"
> register. Meaning, the false branch can influence the results of the true
> branch. In line 24, the verifier assumes R6_w=3D0, but the actual runtime
> value in this case is 1. The fix is simply not passing in the same "fake"
> register location as inputs to reg_set_min_max(), but instead making a
> copy. With this, the verifier successfully rejects invalid accesses from
> the test program.
>
>   [0] https://github.com/google/buzzer
>
> Fixes: 67420501e868 ("bpf: generalize reg_set_min_max() to handle non-con=
st register comparisons")
> Reported-by: Juan Jos=C3=A9 L=C3=B3pez Jaimez <jjlopezjaimez@google.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  kernel/bpf/verifier.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 36ef8e96787e..366b312203d2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15112,8 +15112,8 @@ static int check_cond_jmp_op(struct bpf_verifier_=
env *env,
>         struct bpf_verifier_state *other_branch;
>         struct bpf_reg_state *regs =3D this_branch->frame[this_branch->cu=
rframe]->regs;
>         struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg =3D N=
ULL;
> +       struct bpf_reg_state fake_reg1 =3D {}, fake_reg2 =3D {};

That's too much stack increase.
Even a single reg on the stack is a bit high.
Just reinitialize fake_reg in BPF_K case.

pw-bot: cr

