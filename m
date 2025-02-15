Return-Path: <bpf+bounces-51639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47C1A36B8B
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 04:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3693B0CB2
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 03:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531BA1519B3;
	Sat, 15 Feb 2025 03:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wewqj8AL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA2415198B;
	Sat, 15 Feb 2025 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739588667; cv=none; b=JCRSPQq9i3EEALAgDP4tN/9LCXcJ/B/yC+adGrXSqH0eWLnUAOKN9xzOff/cPJSQYB9VO9RfRRAyxPS2P1qqsb2lJIcL8Nj9HKy+cGWf223qRH0sFl2QCOU/OsyCRvVVBaxhd1R/XNWtc9QLnjGD+PowjVxbYP3yvSXs2YRf3L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739588667; c=relaxed/simple;
	bh=I9x2MwW2MXiXY0ZFzL5MIBifqfA14vdI95tsEZByDB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJviFgjwFunBuoiWvISaihgsx7cnO6YmxPHFvLnOUzwCq0U1WfpwbIxV7farD9na35mvn7dG1bq1DeC+iRem4s37MCBeK6rJWNNBH9sdK/0ph6BHX7bhH8LUzjY2FRC7Jaz8PrQ6K7+B0WPWAhycNxeTk1L8rps2+HKKesHfJj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wewqj8AL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43967004304so9981365e9.2;
        Fri, 14 Feb 2025 19:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739588664; x=1740193464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1ke7H8+M8yCjXV+9PJPO/6rsexf+VnewbpjFFNJVx4=;
        b=Wewqj8AL+l1Ll0CxhhIWwpIrzncEj0Ak39Hz/t710lGokiIuOGlfMNByVIZXodzXRp
         kjOJEluD9I8F15FpEVr/p+vu6EyAehr71QyYdKplXNYduFoGX0k4OHnhlUdZkXS2CZBs
         whCcOBmfGonX2DANlhKRZK4GAz1C/lgRZkgI1E+5QxwYUBSDbd1e3gNILiuSBM1JUGKi
         XGp6LOQIFzfEu+NtXMohinFHa0dAJV0frYGnLW4WUAG3CyTWFqnTEpYgudbV4PD9zJYt
         yuVSlEwGoed73HA/hgQNO6SJEgabQiLrxy4+Hs+K4Q2SsoIQz2AWds5ufJTH/3gTyPCJ
         Nybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739588664; x=1740193464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1ke7H8+M8yCjXV+9PJPO/6rsexf+VnewbpjFFNJVx4=;
        b=Kda66n2yaBNt8amuX1tQWGMwsS5M8s20FgaFRTLsm+ghVVJx4JOcPuNsv4zTFcgF7b
         03rDhADJRn5AxY9LBl3YZznNeI5Wr3s+YuX0u4/UBzv8oz+laR4+clRaua99p5N8F+Pq
         BdKJV8T++X5eIuZZzeVZM8Q/f9LI3BZZz11p3F0x5G+J/C+zbPKtUSyQwICe6JANLC0q
         gvNKGBE7djPNQtxJf7vnMMA44xWsfOeQw9gkTQXj0Hktwp5Tqi2+eyZgXacuQYVB6Ngr
         DoNEd8rwZOJSNx2vkviUow9sE7gz9DJxodHZ7OSzYK3JUUwz0RTwdSEW3WnCGiejeDyD
         8ggg==
X-Forwarded-Encrypted: i=1; AJvYcCUmzCX61+sa35LL8raoBvbJcWhshYcHO+zZJQmOavm2ntEMl9OdpZlg0opZNuED78iwqK3zV1JYXS1oCoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUojlJ3tyA2xnhTbyLOlCw8FZ0zFZXT3H2gjcV9yJ8bN9bMRky
	8q2DRbiWZ+HONjQDu8lH1iK2WAqhj2tYm6NmXyj6Qu7ctpJHlfMeZs1te7SjN7Auv/slBULXbF0
	lp+uKlCgOgCpra7EaiiCcvskJ//GMRJit
X-Gm-Gg: ASbGncsct2V8SMlBeHE+34M8qSnL2BofBOBJF6R5cQt375TrJqzHHtCsL9S5OOT33jy
	Fgq6LqDzHtsWdqHF0eNqr6hnf4wThZ5Q80ImN/7KMbp6FICCvUTSAbSLN6tR8q3NCsjRv81+D
X-Google-Smtp-Source: AGHT+IGDmDaemoeZfMeIUnkaZyc8p3ts9pgGPm4BMDfRwRIGcfPCqXQEOelUoI+XwIc4D/xg+4rdj4ZLSWD9udHVlGo=
X-Received: by 2002:a05:6000:184e:b0:38f:227e:6ff2 with SMTP id
 ffacd0b85a97d-38f33f1c711mr1918249f8f.14.1739588664456; Fri, 14 Feb 2025
 19:04:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738888641.git.yepeilin@google.com> <d03d8c3305e311c6cb29924119b5eecae8370bbc.1738888641.git.yepeilin@google.com>
 <CAADnVQ+L0h8qXfYkC3+ORyQkXFJ2MgO8FDHr_Ha0QMAtS_ujag@mail.gmail.com>
 <Z6gRHDLfA7cjnlSn@google.com> <CAADnVQLkHA9LGv99k2TZOJEGUU=dw=q6nVurJ=aoh0v6cFS6zQ@mail.gmail.com>
 <Z6qC303CzfUMN8nV@google.com> <Z60dO2sV6VIVNE6t@google.com>
 <CAADnVQ+OyoBPOJk6dcUFozTt0RD-o-hHdR4Dgy+dK2r0uHyC7Q@mail.gmail.com>
 <Z63aX0Tv_zdw8LOQ@google.com> <Z6_9LgfOMeR18HGe@google.com>
In-Reply-To: <Z6_9LgfOMeR18HGe@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Feb 2025 19:04:13 -0800
X-Gm-Features: AWEUYZmlNFZtUB1WliSaQIbmQErfRpNsKDqUO-NqyAwWdkRImN9BdvQxTrZQ4H4
Message-ID: <CAADnVQKZ=pjXjyzB8tJj5Gen4odcj5H5JhXyRtVgphTEDCisTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/9] bpf: Introduce load-acquire and
 store-release instructions
To: Peilin Ye <yepeilin@google.com>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, bpf@ietf.org, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Vernet <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 6:34=E2=80=AFPM Peilin Ye <yepeilin@google.com> wro=
te:
>
> > On Wed, Feb 12, 2025 at 09:55:43PM -0800, Alexei Starovoitov wrote:
> > > How about:
> > > #define BPF_LOAD_ACQ 2
> > > #define BPF_STORE_REL 3
> > >
> > > and only use them with BPF_MOV like
> > >
> > > imm =3D BPF_MOV | BPF_LOAD_ACQ - is actual load acquire
> > > imm =3D BPF_MOV | BPF_STORE_REL - release
>
> Based on everything discussed, should we proceed with the above
> suggestion?  Specifically:
>
>   #define BPF_LD_ST     BPF_MOV /* 0xb0 */

The aliasing still bothers me.
I hated doing it when going from cBPF to eBPF,
but we only had 8-bit to work with.
Here we have 32-bit.
Aliases make disassemblers trickier, since value no longer
translates to string as-is. It depends on the context.
There is probably no use for BPF_MOV operation in atomic
context, but by reusing BPF_ADD, BPF_XOR, etc in atomic
we signed up ourselves for all of alu ops.
That's why BPF_XCHG and BPF_CMPXCHG are outside
of alu op range.

So my preference is to do:
#define BPF_LOAD_ACQ 0x100
#define BPF_STORE_REL 0x110
#define BPF_CMPWAIT_RELAXED   0x120

and keep growing it.
We burn the first nibble, but so be it.

