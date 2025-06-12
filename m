Return-Path: <bpf+bounces-60446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5CCAD6817
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 08:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08BA97AB5CF
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 06:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6361F419A;
	Thu, 12 Jun 2025 06:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhRBe/IY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00541F1313;
	Thu, 12 Jun 2025 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749710231; cv=none; b=PCet7wL+Eh8M1HDxrN6WUmIRkP6BFEGcFFTrRnK61n2baf1KRuyG6rsoFhG/iaC919/xHXbkRGVQtV5RHnRx7XcykYueRP+Q11VQyNjcFMeQ7+SHD4RESgjPVGH2FBKG+61731eu+564WUleZ1W5D8ve1/XW3XrQvEjLI34neik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749710231; c=relaxed/simple;
	bh=/VpVpbtC3baNIr5wzysF+4FBa8mkC7xG5zs4TCPuWqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbAja7JIpUJTI5zzoLOpk8CIIvLLZViEyYopSrwWTwnXZhbear2g4EhkVf9Z3Ti4Hlp+Q7BHpcJfkHJnZPtq3h84E3pscfkSfjhGD1Hh1BY6SIcu4MJ9qlAeGdS6J8aIGaXsUUp1rbBoXqioa4NUPC0yZUVkt44yczyE1Az4ukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhRBe/IY; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e79de9da3fso160309137.1;
        Wed, 11 Jun 2025 23:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749710229; x=1750315029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSM5fa2hq4AxPJITWpG89v/KX6gCjVB1D4fyAWuaB0g=;
        b=fhRBe/IY5g3XhUNpYFFZO7kkeuw7cLJOf6l/JgtkPOtvj7lIkzz66o9RAlMWOcqwg0
         KU8JUHRaQMewkcQyt6rdWEYYVyoPYL2WnK/8BfntS/Vd18VWgPlEJ4pNIQbKhsXmGeoc
         b0g4IXJYfHx8nKJ96iMxVAZpx7bZFy3bpwNSp31pdS8LwhSyEZ0C030WE7YKQ0yngMga
         be3zT1a20UZu2SGvaaxRkihBEnnbqCLiOOKdPDCrWG5zEOyc6Ogw5wBJtT6s4MxD9NG7
         bahnmuh/rCHx/w55/c27mPPww+OQU4KpsGfcVLZg9hLllkR4zMjZpVpjwDlx93mH27lF
         mS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749710229; x=1750315029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSM5fa2hq4AxPJITWpG89v/KX6gCjVB1D4fyAWuaB0g=;
        b=GBBSYYfBmbYBQ/A4sKxdbxz1Zy3JBvVrPnTjC7qppAhtb8eE7CLLC7lHQB1fwBZnf/
         z9fhDL0/h8fgrhEgPxFn4ReeX6W0FmNqD1eZBETDLI/TAgTZu19q0ctj1z3lx9SI84Rn
         Kxb9BD7UuEoq/u4oLlxZ8k8zZ+bmq4rzQY/g/dLbVJYNDmRHSqhRd9iNGwibXT9pG8Bl
         /CV5myc/MTFXj3d4CNTtWipR/jxwnNGIRWdXH8o4BGpb+ByEs3Mz5sI9lGx8O0cpPSbh
         YoLmNZEC8ViPyIHyBCbFBvemKgtttYEMLGYTIcdMyi4YpQwFZ6NTbQ0RZlGTJTY6zT3E
         1BIg==
X-Forwarded-Encrypted: i=1; AJvYcCV7CJ6o1Sb44S/oglOYOEKur0LpEgnD41J8X3VFyOk1qIo90rU9BcdICUF0atrnOV4q4+k=@vger.kernel.org, AJvYcCW636GwuycW0glIjcp9Urlm7OPW1fvMzZRVwj1IhSX3cVAMxGUO41qIKeSka9+lTu6MMGzBohg8HRqAslPF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ttrUBkFOCQ5KNgeqNAF0JxfD/IcbWtQ7NsYkHn7oXP39WSO2
	LOxHV+4531gtDcnjEequnejI3G5Afo/juc9ObRyCFS6TwjBNcPdKwmBr1L2QjxDQ9qjovN9DdYZ
	UQn4nHVx8GHmZprkekJoZgJt/DeqG7QM=
X-Gm-Gg: ASbGncviQcdQT+X6QpzJzDxuBZmBeOxewXYPvQhDfgiVRMwPofYH+NdvzWZbVisRIC3
	w+oPVYnP9E/4Dr8/iA47/ZyixmD1gcmNIz3XKMgrFjI8OD8CNizoDmcGGbxpZVkiskQzpLBt59L
	eilextIuI19tVVZH/VM6b5uIRGZDT6OvZjAoSfRWG5GXV9QM4/FK+P8J7EmwUoUy/uqtI3uiDl3
	Qnlhg==
X-Google-Smtp-Source: AGHT+IEbFgP1S6Gk9/6iAqTU4+jgjbVNHHgyFY+8WLCVxocnGQ5CY+KraXI49ZsjlW99mMD8LVQFot8xOM2G7DKn7II=
X-Received: by 2002:a05:6102:5809:b0:4e5:9380:9c25 with SMTP id
 ada2fe7eead31-4e7ce7f66f7mr1574972137.3.1749710228499; Wed, 11 Jun 2025
 23:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610221356.2663491-1-harishankar.vishwanathan@gmail.com> <a39e1ed2db4121b690796c347f1259da09e23e13.camel@gmail.com>
In-Reply-To: <a39e1ed2db4121b690796c347f1259da09e23e13.camel@gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Thu, 12 Jun 2025 02:36:56 -0400
X-Gm-Features: AX0GCFs9Z304OB7d5wa1MX6csEMZ52OJaNSn4qdReUou0pSVZF0pvwUwszJsHcI
Message-ID: <CAM=Ch06Jr11bSO1DHO+NSLmxj1kuRW8GmzUfBqKPnhNGs6i=nw@mail.gmail.com>
Subject: Re: [PATCH] bpf, verifier: Improve precision for BPF_ADD and BPF_SUB
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, Matan Shachnai <m.shachnai@rutgers.edu>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 2:11=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2025-06-10 at 18:13 -0400, Harishankar Vishwanathan wrote:
> > This patch improves the precison of the scalar(32)_min_max_add and
> > scalar(32)_min_max_sub functions, which update the u(32)min/u(32)_max
> > ranges for the BPF_ADD and BPF_SUB instructions. We discovered this mor=
e
> > precise operator using a technique we are developing for automatically
> > synthesizing functions for updating tnums and ranges.
> >
> > According to the BPF ISA [1], "Underflow and overflow are allowed durin=
g
> > arithmetic operations, meaning the 64-bit or 32-bit value will wrap".
> > Our patch leverages the wrap-around semantics of unsigned overflow and
> > underflow to improve precision.
> >
> > Below is an example of our patch for scalar_min_max_add; the idea is
> > analogous for all four functions.
> >
> > There are three cases to consider when adding two u64 ranges [dst_umin,
> > dst_umax] and [src_umin, src_umax]. Consider a value x in the range
> > [dst_umin, dst_umax] and another value y in the range [src_umin,
> > src_umax].
> >
> > (a) No overflow: No addition x + y overflows. This occurs when even the
> > largest possible sum, i.e., dst_umax + src_umax <=3D U64_MAX.
> >
> > (b) Partial overflow: Some additions x + y overflow. This occurs when
> > the largest possible sum overflows (dst_umax + src_umax > U64_MAX), but
> > the smallest possible sum does not overflow (dst_umin + src_umin <=3D
> > U64_MAX).
> >
> > (c) Full overflow: All additions x + y overflow. This occurs when both
> > the smallest possible sum and the largest possible sum overflow, i.e.,
> > both (dst_umin + src_umin) and (dst_umax + src_umax) are > U64_MAX.
> >
> > The current implementation conservatively sets the output bounds to
> > unbounded, i.e, [umin=3D0, umax=3DU64_MAX], whenever there is *any*
> > possibility of overflow, i.e, in cases (b) and (c). Otherwise it
> > computes tight bounds as [dst_umin + src_umin, dst_umax + src_umax]:
> >
> > if (check_add_overflow(*dst_umin, src_reg->umin_value, dst_umin) ||
> >     check_add_overflow(*dst_umax, src_reg->umax_value, dst_umax)) {
> >       *dst_umin =3D 0;
> >       *dst_umax =3D U64_MAX;
> > }
> >
> > Our synthesis-based technique discovered a more precise operator.
> > Particularly, in case (c), all possible additions x + y overflow and
> > wrap around according to eBPF semantics, and the computation of the
> > output range as [dst_umin + src_umin, dst_umax + src_umax] continues to
> > work. Only in case (b), do we need to set the output bounds to
> > unbounded, i.e., [0, U64_MAX].
> >
> > Case (b) can be checked by seeing if the minimum possible sum does *not=
*
> > overflow and the maximum possible sum *does* overflow, and when that
> > happens, we set the output to unbounded:
> >
> > min_overflow =3D check_add_overflow(*dst_umin, src_reg->umin_value, dst=
_umin);
> > max_overflow =3D check_add_overflow(*dst_umax, src_reg->umax_value, dst=
_umax);
> >
> > if (!min_overflow && max_overflow) {
> >       *dst_umin =3D 0;
> >       *dst_umax =3D U64_MAX;
> > }
> >
> > Below is an example eBPF program and the corresponding log from the
> > verifier. Before instruction 6, register r3 has bounds
> > [0x8000000000000000, U64_MAX].
> >
> > The current implementation sets r3's bounds to [0, U64_MAX] after
> > instruction r3 +=3D r3, due to conservative overflow handling.
> >
> > 0: R1=3Dctx() R10=3Dfp0
> > 0: (18) r3 =3D 0x8000000000000000       ; R3_w=3D0x8000000000000000
> > 2: (18) r4 =3D 0x0                      ; R4_w=3D0
> > 4: (87) r4 =3D -r4                      ; R4_w=3Dscalar()
> > 5: (4f) r3 |=3D r4                      ; R3_w=3Dscalar(smax=3D-1,umin=
=3D0x8000000000000000,var_off=3D(0x8000000000000000; 0x7fffffffffffffff)) R=
4_w=3Dscalar()
> > 6: (0f) r3 +=3D r3                      ; R3_w=3Dscalar()
> > 7: (b7) r0 =3D 1                        ; R0_w=3D1
> > 8: (95) exit
> >
> > With our patch, r3's bounds after instruction 6 are set to a more preci=
se
> > [0, 0xfffffffffffffffe].
> >
> > ...
> > 6: (0f) r3 +=3D r3                      ; R3_w=3Dscalar(umax=3D0xffffff=
fffffffffe)
> > 7: (b7) r0 =3D 1                        ; R0_w=3D1
> > 8: (95) exit
> >
> > The logic for scalar32_min_max_add is analogous. For the
> > scalar(32)_min_max_sub functions, the reasoning is similar but applied
> > to detecting underflow instead of overflow.
> >
> > We verified the correctness of the new implementations using Agni [3,4]=
.
> >
> > We since also discovered that a similar technique has been used to
> > calculate output ranges for unsigned interval addition and subtraction
> > in Hacker's Delight [2].
> >
> > [1] https://docs.kernel.org/bpf/standardization/instruction-set.html
> > [2] Hacker's Delight Ch.4-2, Propagating Bounds through Add=E2=80=99s a=
nd Subtract=E2=80=99s
> > [3] https://github.com/bpfverif/agni
> > [4] https://people.cs.rutgers.edu/~sn349/papers/sas24-preprint.pdf
> >
> > Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
> > Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
> > Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> > Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> > Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> > Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> > Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail=
.com>
> > ---
>
> Is this patch dictated by mere possibility of improvement or you
> observed some C programs that can benefit from the change?
>
> Could you please add selftests covering each overflow / underflow
> combination?
> Please use same framework as tools/testing/selftests/bpf/progs/verifier_a=
nd.c.

We didn't specifically look for C programs that show improvements. We
discovered this operator using our abstract operator synthesis
framework, and that was the motivation for the patch.

In theory, programs that make use of overflow or underflow behavior,
particularly where all outcomes overflow, should benefit from this
patch.

As illustrated in the commit message, we do have examples of eBPF
programs that benefit from the precision improvement. We can
definitely add selftests covering each case. I'll send a follow up v2
patch set.

Thanks for the feedback!

> [...]

