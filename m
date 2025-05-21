Return-Path: <bpf+bounces-58695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F39FABFFB9
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 00:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6DB3A73BB
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 22:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BB4239E87;
	Wed, 21 May 2025 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXMgYE0k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6C31754B
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867145; cv=none; b=mX0QuU4pAaAkSIyVxsxXylI02K/UX1vCkW1Ybw/StJAazpRmOL30wudx6nEU2CXdQ+O9QGpsM6B5Vb8b3IjE9Bw76XyxsLo1OrYnbh3+QeVO7HRIDbTdmfoz0jTFiEIV5w1moGT8N5Qv7cYkPXGfXRJReEcJB5WoYpomh8ZPkY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867145; c=relaxed/simple;
	bh=tlnWFqSVLo3vvOmPhP1yx4wWVo74QhZ0HcAnefY5aX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGYb6ocGcIvs4IICg7NtbQAGmtIPQBE4p7F9wf25MFv0BzhKBuTN0BuZX/ogSnpKDXW6ybw1UJSzUUMXR+1yio8tCwLde3nOXqKnzytY8B8gJRbsepkRvxudaYyWDVVxdlGeH22mYTuztFYvGVjBdGLcL0hn1dy8OsReDj6+xO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXMgYE0k; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b1fd59851baso4548361a12.0
        for <bpf@vger.kernel.org>; Wed, 21 May 2025 15:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747867143; x=1748471943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nCZRqV0YxWTH9ZA2RwziFgquCFnOMSGmeQJ5qr6qrc=;
        b=UXMgYE0ktt8XuxkOa9P1y4TG2JUD6wwZQ4pfbWD4pKu/e7Jh3PSfSASJPSB6oh8hWb
         J0YzUuhwYKkJUXyqGdWjRy5ZnpDP8uDaHMiXSR/8yYiNio6GNWqT83VVF2Gonxzc4GA6
         cHZq5uIaTE/LUBhrTwJa1xOAfj35MTSbM1fTQ8/NpiZ9GoGjjZlcqoqEeJMFOXDhjco9
         5spCY4rMD7SH60Fa6VvbYq/mqIs96JcRXT5+Tn+8y1+fAtykX0ywpQnQCRhb2+WUq3UC
         2y9Z7fkS65pOg+kUgSQBzF4B7t9p4ao0jnCk8CksMrLnaN3JUVhCThI3/2K4MxNhqf8Q
         z4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747867143; x=1748471943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nCZRqV0YxWTH9ZA2RwziFgquCFnOMSGmeQJ5qr6qrc=;
        b=UYH99qosNQXPomfvyYp5H6o0IsZwet19ZqXvBnehmYLZWmU6nA/N2OtkqIZc2mnpjL
         sdAigwpBYEqhdvSeCdgH4rYRxYVBdAQYk+9SEJjn8RYcPbk3lpKMStK6j4y9ItrPyX5h
         hDDvf1rCAa9fNtoVLiWx4jl0P68h540/F2270Mi9L3cmiyDQQbBiYL+GNQ0m3y1X9EyR
         xpu7XuwBcnNl3Uht1+0FOMGwsHcfeblcQ+8niVMv9ehx3cUsoV3Ad5FP1tNTd1sGBo2L
         fLg7gGThtsUL9YB4JJJBvGuYKkQU8tqDUP8qjZgCQolY8h2cdNYj1CJVxNI4FF4CthqT
         NGBg==
X-Forwarded-Encrypted: i=1; AJvYcCXjvpiM+/vi91EzhtxZklYca1OUrhLiprbVDl4cFGjm1MjBoKJDiIHRqyZAxdy+S9IIEzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeUCaOaI0YJJCPV3dHJM9wGN1REeoVLInVa7BknLRxR+AIrJw9
	+ZiFsxKux3WI1rYDdsPURUOYbyQ4Wh/7tbyOzKevXTnUqiDclD5Ll4LEk0WiJ9NjOepeYho2qqv
	DA8JNJhrRM1HeqtbhJWHVw1XhbxKtwI8=
X-Gm-Gg: ASbGncsVr1YKqdH0oRQjEZMMt01aLTQ3Or2eAP4kcXq3vTgqbHNi4/k1699omjxX4rn
	QrBH1vZYdeoq1uiCy+sq2EB+6FudSQhtdKvmhcnbUjSTfFX8Ro9kcu5QZKOs4wSirnNSdV+hE48
	BBiFNTcYZS4IbCQ6UK9RScmSqA2NSyiBRtLoo1d+XNzjtbaypG2juLu3+LDA==
X-Google-Smtp-Source: AGHT+IGMnqCeZ5bAPzneziPebcu+LgP0J4dCVIIwvnxp+RUi/p9G5QvR6yAXJ13KRtM7G5Vhy5vj6JbU6rcFFhY65CU=
X-Received: by 2002:a17:90b:264e:b0:305:2d27:7cb0 with SMTP id
 98e67ed59e1d1-30e831b842amr31538330a91.21.1747867143534; Wed, 21 May 2025
 15:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521170409.2772304-1-yonghong.song@linux.dev>
 <45e399c6-74ad-4e58-bfda-06b392d1d28d@gmail.com> <2c0fa9ee-f9dd-4cde-b4fb-6f28ebefc619@linux.dev>
In-Reply-To: <2c0fa9ee-f9dd-4cde-b4fb-6f28ebefc619@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 May 2025 15:38:50 -0700
X-Gm-Features: AX0GCFsuT1UHYIZE100UboYNvBe1cyfgwt6wx5p-TAmvaCmUtSbtF9VI4AQK9No
Message-ID: <CAEf4Bzbx6xHc2LMCWpY_yQExgjauo0UaDmF4rDuFjefNvOhqRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Do not include stack ptr register in
 precision backtracking bookkeeping
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 1:35=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 5/21/25 11:55 AM, Eduard Zingerman wrote:
> > [...]
> >
> >> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier=
.h
> >> index 78c97e12ea4e..e73a910e4ece 100644
> >> --- a/include/linux/bpf_verifier.h
> >> +++ b/include/linux/bpf_verifier.h
> >> @@ -357,6 +357,10 @@ enum {
> >>       INSN_F_SPI_SHIFT =3D 3, /* shifted 3 bits to the left */
> >>         INSN_F_STACK_ACCESS =3D BIT(9), /* we need 10 bits total */
> >> +
> >> +    INSN_F_DST_REG_STACK =3D BIT(10), /* dst_reg is PTR_TO_STACK */
> >> +    INSN_F_SRC_REG_STACK =3D BIT(11), /* src_reg is PTR_TO_STACK */
> >
> > INSN_F_STACK_ACCESS can be inferred from INSN_F_DST_REG_STACK
> > and INSN_F_SRC_REG_STACK if insn_stack_access_flags() is adjusted
> > to track these flags instead. So, can be one less flag/bit.
>
> You are correct, we could have BIT(9) for both INSN_F_STACK_ACCESS and IN=
SN_F_DST_REG_STACK,
> and BIT(10) for INSN_F_SRC_REG_STACK. But it makes code a little bit
> complicated. I am okay with this if Andrii also thinks it is
> worthwhile to do this.

I originally wanted to replace INSN_F_STACK_ACCESS with either
INSN_F_DST_REG_STACK or INSN_F_SRC_REG_STACK depending on STX/LDX. But
then I realized that INSN_F_STACK_ACCESS implies the use of that spi
mask, while xxx_REG_STACK doesn't. So it might be a bit simpler if we
keep them distinct, and for LDX/STX we'll set either just
INSN_F_STACK_ACCESS or INSN_F_STACK_ACCESS|INSN_F_xxx_REG_STACK
(whichever makes most sense).

We have enough bits, so I'd probably use two new bits and keep the
existing STACK_ACCESS one as is. Unless Eduard thinks that this setup
is actually more confusing?

>
> >
> >> +    /* total 12 bits are used now. */
> >>   };
> >>     static_assert(INSN_F_FRAMENO_MASK + 1 >=3D MAX_CALL_FRAMES);
> >
> > [...]
> >
> >> @@ -4402,6 +4418,8 @@ static int backtrack_insn(struct
> >> bpf_verifier_env *env, int idx, int subseq_idx,
> >>                */
> >>               return 0;
> >>           } else if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> >> +            bool dreg_precise, sreg_precise;
> >> +
> >>               if (!bt_is_reg_set(bt, dreg) && !bt_is_reg_set(bt, sreg)=
)
> >>                   return 0;
> >>               /* dreg <cond> sreg
> >> @@ -4410,8 +4428,16 @@ static int backtrack_insn(struct
> >> bpf_verifier_env *env, int idx, int subseq_idx,
> >>                * before it would be equally necessary to
> >>                * propagate it to dreg.
> >>                */
> >> -            bt_set_reg(bt, dreg);
> >> -            bt_set_reg(bt, sreg);
> >> +            if (!hist)
> >> +                return 0;
> >> +            dreg_precise =3D !insn_dreg_stack_ptr(hist->flags);
> >> +            sreg_precise =3D !insn_sreg_stack_ptr(hist->flags);
> >> +            if (!dreg_precise && !sreg_precise)
> >> +                return 0;
> >> +            if (dreg_precise)
> >> +                bt_set_reg(bt, dreg);
> >> +            if (sreg_precise)
> >> +                bt_set_reg(bt, sreg);
> >
> > This check can be done in a generic way at backtrack_insn() callsite:
> > check which register is pointer to stack and remove it from set
> > registers.
>
> Looks like other cases in backtrack_insn() has been handled properly,
> so it may still be worthwhile to put the code here.
>
> >
> >>           } else if (BPF_SRC(insn->code) =3D=3D BPF_K) {
> >>                /* dreg <cond> K
> >>                 * Only dreg still needs precision before
> >> @@ -16397,6 +16423,29 @@ static void sync_linked_regs(struct
> >> bpf_verifier_state *vstate, struct bpf_reg_s
> >>       }
> >>   }
> >>   +static int push_cond_jmp_history(struct bpf_verifier_env *env,
> >> struct bpf_verifier_state *state,
> >> +                 struct bpf_reg_state *dst_reg, struct bpf_reg_state
> >> *src_reg,
> >> +                 u64 linked_regs)
> >> +{
> >> +    bool dreg_stack_ptr, sreg_stack_ptr;
> >> +    int insn_flags;
> >> +
> >> +    if (!src_reg) {
> >> +        if (linked_regs)
> >> +            return push_insn_history(env, state, 0, linked_regs);
> >> +        return 0;
> >> +    }
> >
> > Nit: this 'if' is not needed, src_reg is always set (it might point to
> > a fake register,
> >      but in that case it is a scalar without id).
> >
> Here, there is a bug here. Thanks for pointing this out. I need to check
> BPF_SRC(insn->code) !=3D BPF_X instead of "!src_reg". Basically passing o=
ne
> more parameter (e.g., faked_sreg) to decide whether src_reg is faked or n=
ot.
>
> >
> >> +
> >> +    dreg_stack_ptr =3D dst_reg->type =3D=3D PTR_TO_STACK;
> >> +    sreg_stack_ptr =3D src_reg->type =3D=3D PTR_TO_STACK;
> >> +
> >> +    if (!dreg_stack_ptr && !sreg_stack_ptr && !linked_regs)
> >> +        return 0;
> >> +
> >> +    insn_flags =3D insn_reg_access_flags(dreg_stack_ptr, sreg_stack_p=
tr);
> >> +    return push_insn_history(env, state, insn_flags, linked_regs);
> >> +}
> >> +
> >
> > [...]
> >
>
>

