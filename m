Return-Path: <bpf+bounces-64296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FDEB11180
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 21:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889811CE592E
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 19:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432B62ECE81;
	Thu, 24 Jul 2025 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad71gxep"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF5223702
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753384559; cv=none; b=dO0UDAXj9bg+BKi0ryB3sPnJI3nBecFPCNLNb/K0oWyc0Yjuzry7/I0707a1JsK0NujYYEgMdnFsBKN6nYrI+MptPA4CT5oE+AlnuSm5znnWRXXwgI+pJaFexOpS9+rZxRsMvdh0USgFVi89lGXKZpnoIS52yVrMadPs9mmuw8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753384559; c=relaxed/simple;
	bh=42TXJUzk1duES+xNIsDQE+2H78JD2ayRZ/cwGouGMAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jKgVoL/QaRXMx2o9FAtYEHegYHsjBikWjv7PPyhLACp+Pe2/Tn3MvlK+jN0SDHOGSLqWEmmYBhxgyWcDalSiJaRY/Ig/XjwL9bWHj+UF3244Xt8TKWUWOqwlH1k6lDS4UM08SvX4YT7KrEu/PjSCfrk2onLuP19acgTR8QIVapE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ad71gxep; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b3bdab4bf19so1234120a12.2
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 12:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753384557; x=1753989357; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rPRO+ut8IFBOpsvnywlOQeUL0w655qHQaJH0BBDoPyQ=;
        b=Ad71gxep/9wmJi1GfNw85YCpHtm962pe/Cu7igoHkcefhRf0Zz9dQuG/s+sOu+SFOx
         avcvS2K6raKCuUiDrXT7X2trtxm3atPQ6IRR10j1DyIdVHf5UUjUoUMLNrqNJevJ5bCp
         4YHNhzYQqU80wf2asy7z30hCzkpswWZRy7nFwygThWs9r/1wqQj+LJ8PMwF1Ef+uzsev
         gPqGZMj0vfTbp+KZE79xNw2+JaKG+Uyjs21xV7yGagLYEM0s8zOIx+zeFeokzzCDElMV
         56GR1O+w269LzhJ3nOorB2mWP4kvBqaMgrnUzVNvzjVQycfYXzT5pN7QX61QDYGkG/Bm
         8t1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753384557; x=1753989357;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rPRO+ut8IFBOpsvnywlOQeUL0w655qHQaJH0BBDoPyQ=;
        b=m8JGOe1dSm+lv5F8sHLsszll/+u/18Pmg2ex9f7rsIGRnvtvMzpjOq4hbO/xTLIntx
         aX9LOY8cPdL9DCX8GHN4eEnUvkEc4RZWXKiSIlFpgltFuUWhEhtgnp30Z0YGjDD1t1kw
         NUhj8LeIYFkiveUM7iV0ugJ2nX4ZYAC7Azxikj2wr1YbNGymSvrrFonwNCvUi82Mwr8I
         492QhXMH7Sf8WgbMHvN/b751OlMD1BdgF1z/d0Nwm69gN9X6iYq6ZDXmydmz+ONVYANz
         ta5uUsw/1SdCI6vM6kcS82DNaT/ESoRQztH3Os8xYx+Yly8uaLdEIkKY1knKA1NxoAjT
         1wpA==
X-Forwarded-Encrypted: i=1; AJvYcCU+8Y7my525l749w8IlEeZUg8aaqaGqfPLcP6ndZjHNNQ02qsOYgvfvzvkEV2WD6aIwXoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwhTK57ywOqVW2zA9/I6GsIuvTuUolQiHktj+xTQwJOR9L3OS+
	Vnz1tb2Ym9ypXsYmRZ4iMGnqvW7kehyFmv82ZL4WfilyxNpZdqQNHw3z
X-Gm-Gg: ASbGncv4riZg5sgu5v2UGN6MiHcrEj6s1SwhuX4ep64PZ9cz3YF4sI5nAz18QVKxyL2
	FeuCyN/UfJqbkjfKcQc7fwc+owyBwHGIXS2ixipmCVdkieltgfbd78RIyryWSDkkNeEt2mkQe8g
	+zO4gtd6llGEhwzA28WDyrGClq779AuCb/0hlw87mHAau0kmax50jW48JUljQ+P5PPlV0VAWh6f
	GmfEgCb0ZbhDDSzmkUdfydY3d17IMluE+dYge7dL52RS2fGDiLpnj35H5N7vH5pAP/zkSifji/d
	MxNUn9hP6D14Vg42SfuypiDaKfO3Sw934WpMIBLxlgvVE9SWL23a/x1PLRKSCJ6h2sslWu7ls52
	HKI1DJ25ER5n2aN2iWw==
X-Google-Smtp-Source: AGHT+IGQ8ftz3UaP4EJwDxaBD21gtBzKB4+IdyaaLHxD0UbYaqjH6CJeR70M62j0W4gDKlmp1Xp66Q==
X-Received: by 2002:a17:90b:2247:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-31e507e4bfemr11039468a91.21.1753384556848;
        Thu, 24 Jul 2025 12:15:56 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f6c115e2csm1878743a12.53.2025.07.24.12.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:15:56 -0700 (PDT)
Message-ID: <905853bfc266a6969953b4de8433ef9ca7e7a34c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Test cross-sign 64bits
 range refinement
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Thu, 24 Jul 2025 12:15:53 -0700
In-Reply-To: <8f1297bcbfaeebff55215d57f488570152ebb05f.1753364265.git.paul.chaignon@gmail.com>
References: <cover.1753364265.git.paul.chaignon@gmail.com>
	 <8f1297bcbfaeebff55215d57f488570152ebb05f.1753364265.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-24 at 15:43 +0200, Paul Chaignon wrote:
> This patch adds coverage for the new cross-sign 64bits range refinement
> logic. The three tests cover the cases when the u64 and s64 ranges
> overlap (1) in the negative portion of s64, (2) in the positive portion
> of s64, and (3) in both portions.
>=20
> The first test is a simplified version of a BPF program generated by
> syzkaller that caused an invariant violation [1]. It looks like
> syzkaller could not extract the reproducer itself (and therefore didn't
> report it to the mailing list), but I was able to extract it from the
> console logs of a crash.
>=20
> The principle is similar to the invariant violation described in
> 6279846b9b25 ("bpf: Forget ranges when refining tnum after JSET"): the
> verifier walks a dead branch, uses the condition to refine ranges, and
> ends up with inconsistent ranges. In this case, the dead branch is when
> we fallthrough on both jumps. The new refinement logic improves the
> bounds such that the second jump is properly detected as always-taken
> and the verifier doesn't end up walking a dead branch.
>=20
> The second and third tests are inspired by the first, but rely on
> condition jumps to prepare the bounds instead of ALU instructions. An
> R10 write is used to trigger a verifier error when the bounds can't be
> refined.
>=20
> Link: https://syzkaller.appspot.com/bug?extid=3Dc711ce17dd78e5d4fdcf [1]
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Hi Paul,

Thank you for adding the tests, I think the patch looks good.

>  .../selftests/bpf/progs/verifier_bounds.c     | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index 63b533ca4933..dd4e3e9f41d3 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -1550,4 +1550,122 @@ l0_%=3D:	r0 =3D 0;				\
>  	: __clobber_all);
>  }
> =20
> +/* This test covers the bounds deduction on 64bits when the s64 and u64 =
ranges
> + * overlap on the negative side. At instruction 7, the ranges look as fo=
llows:
> + *
> + * 0          umin=3D0xfffffcf1                 umax=3D0xff..ff6e  U64_M=
AX
> + * |                [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]        |
> + * |----------------------------|------------------------------|
> + * |xxxxxxxxxx]                                   [xxxxxxxxxxxx|
> + * 0    smax=3D0xeffffeee                       smin=3D-655        -1
> + *
> + * We should therefore deduce the following new bounds:
> + *
> + * 0                             u64=3D[0xff..ffd71;0xff..ff6e]  U64_MAX
> + * |                                              [xxx]        |
> + * |----------------------------|------------------------------|
> + * |                                              [xxx]        |
> + * 0                                        s64=3D[-655;-146]    -1
> + *
> + * Without the deduction cross sign boundary, we end up with an invarian=
t
> + * violation error.
> + */
> +SEC("socket")
> +__description("bounds deduction cross sign boundary, negative overlap")
> +__success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
> +__msg("7: (1f) r0 -=3D r6 {{.*}} R0=3Dscalar(smin=3D-655,smax=3Dsmax32=
=3D-146,umin=3D0xfffffffffffffd71,umax=3D0xffffffffffffff6e,smin32=3D-783,u=
min32=3D0xfffffcf1,umax32=3D0xffffff6e,var_off=3D(0xfffffffffffffc00; 0x3ff=
))")

Interesting, note the difference: smin=3D-655, smin32=3D-783.
There is a code to infer s32 range from s46 range in this situation in
__reg32_deduce_bounds(), but it looks like a third __reg_deduce_bounds
call is needed to trigger it. E.g. the following patch removes the
difference for me:

  diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
  index f0a41f1596b6..87050d17baf9 100644
  --- a/kernel/bpf/verifier.c
  +++ b/kernel/bpf/verifier.c
  @@ -2686,6 +2686,7 @@ static void reg_bounds_sync(struct bpf_reg_state *r=
eg)
          /* We might have learned something about the sign bit. */
          __reg_deduce_bounds(reg);
          __reg_deduce_bounds(reg);
  +       __reg_deduce_bounds(reg);
          /* We might have learned some bits from the bounds. */
          __reg_bound_offset(reg);
          /* Intersecting with the old var_off might have improved our boun=
ds

> +__retval(0)
> +__naked void bounds_deduct_negative_overlap(void)
> +{
> +	asm volatile("			\
> +	call %[bpf_get_prandom_u32];	\
> +	w3 =3D w0;			\
> +	w6 =3D (s8)w0;			\
> +	r0 =3D (s8)r0;			\
> +	if w6 >=3D 0xf0000000 goto l0_%=3D;	\
> +	r0 +=3D r6;			\
> +	r6 +=3D 400;			\
> +	r0 -=3D r6;			\
> +	if r3 < r0 goto l0_%=3D;		\
> +l0_%=3D:	r0 =3D 0;				\
> +	exit;				\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

[...]

