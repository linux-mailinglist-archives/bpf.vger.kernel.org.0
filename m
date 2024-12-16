Return-Path: <bpf+bounces-47062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388289F3A26
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 20:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29A1167D91
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 19:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E333020C486;
	Mon, 16 Dec 2024 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh3deJEb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA31207DF3
	for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734378466; cv=none; b=X4IP4eK2+gXD8FGZsa/CW59UOJfLrk3Suif2NyLI4i7GQu6qHdfoUmQ6zgLiPpetA4ehvBYRXerS+Bz3+3TuijuuDXj5w4f9ekiGfKrBnYUjRpQ7FyOoR0iuv3qP0o8QCdQhweUnYDqYpJwM8DI8DTlcoePkCe0f7Zhw7lZTgH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734378466; c=relaxed/simple;
	bh=5rOe1eU67u3297QJ12A5skth8vI7v+7707udB6y1hEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJkyJBOKAUUGIsHITH2y/298RNqUSRJoPXXDYBP6jbfce8nMl234V+KBuchrRFKPgVpzTDdPvcCYSTLVr8es+PPeqEdzMVimS/vP3v26WZ6WLooCUnsBdhuFO3L947h0dRuEgQg9HktaWG/AcOodbf9Klpav5MNBhIoqo36PSkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh3deJEb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso3936062f8f.0
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 11:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734378461; x=1734983261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpQJf1bRaX7ssCZqk4oLkrpOUE/SXjfse/Z9uQNI6JA=;
        b=Vh3deJEbUuhtuFzpYDvPl2BaNMVwe5Gzyi51wBp2eH4jKrICpgWtp9dOImRmtVopL2
         6WCF4P8VUFI85nECZ4iFgjk0hdRg1wXVkaqGY21HBDhrZjepzU+Jt20MLUduYmxygkRc
         a3g/nPsL3mw+2Q2mxSq9TrO8pX3x8SBqthpsxHZ5gNMxJcMKrT984coOn4VB7btz5y1m
         y/P661Vzq3pvrGSSxb4nAOT5De767MBY7sUc5YYL4bVRTnjfRVaUuUSbJ2OSrt+g0/C+
         aKRdfnUjrTUkRQoDeNf7ZBTAL2+hBNJ/jV8nP2QlxOE9bN653+jputbjxhA6y7TtJKDM
         V5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734378461; x=1734983261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpQJf1bRaX7ssCZqk4oLkrpOUE/SXjfse/Z9uQNI6JA=;
        b=CDE1DRKnUohqP4WI2whBqWlKH8d148/D7S94VtuhFEEALzurgTMeME9o0KwlXauCjU
         1NkkPaFeWv6FStyNHBTB2xgw0J0NQjV0fVyIKrT6vqOxoQv7LBoynQ/LrJH3ojiImkjY
         yT6AVQkcAm96zcbaCM8fpKaGiLxB7QYA01Th2UTfTYBB9uQnVk+OZLAuNwF2oXQSm+9F
         ngWrUIVXkcI9eu5YmF9jhP4HcLT9KSD6gJT/WuXYaE+ZyBY4nHKrd8qYYzxxp46mgGmk
         iIQmR2hVEi1KJRSuD0kq0NulB/AIq2Qbphnqaij34hdAEd090lt/QEnVCDv2SS4JyjU7
         0W7g==
X-Forwarded-Encrypted: i=1; AJvYcCXZ6mS3Q77pWZxYc1o9zM0vOexcqqXTchvAD5wtSlTrJJhUdOUzyDnsMyQQyX4O1qWMVDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx01Luc3u0YDCpPIbtA75Fz67/Vf/rW98GXL13kPh626APeTMnv
	0niewYfR4ILIY1Zde1xQblVryzEyaZ14uI8y0PsltOpKWGEX3ry4UItw6nP7UM7gsoVkvbo8fs4
	7NxnU0i0smvkH+EPYVXog2DuQ8m4=
X-Gm-Gg: ASbGncuIzasNj2ipYsgb/YDq0QxylouBUG0TopJYAZ9b5wBN/bzOwba0VqggPy9jp98
	lvajTvByxNlIcFMqfXJNPmfHYqbEYUBYoKiLzXMcC
X-Google-Smtp-Source: AGHT+IEGbNwjv7NwK0AP2o2wN5edt/dGYHdMgqkz1X3mrO1yU1l0AFHhZZDkj8hOAGJgtoKDJCXSNLv+QNy1P+1Rslg=
X-Received: by 2002:a5d:5985:0:b0:385:df73:2f42 with SMTP id
 ffacd0b85a97d-38880ae14c3mr10438352f8f.32.1734378461097; Mon, 16 Dec 2024
 11:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213212717.1830565-1-afabre@cloudflare.com>
 <20241213212717.1830565-3-afabre@cloudflare.com> <76401f4502366c2d9221758f9034aa7bb2d831a3.camel@gmail.com>
 <D6DB4NCLQZC9.I7DUNKR9RORW@bobby> <CAADnVQ++HfXeobY2XoJfDWXZGrF4_kR5kOK7asFRpBN=qmXU8Q@mail.gmail.com>
 <ed827bde40ab18be536add38c4237d949a752b2d.camel@gmail.com>
In-Reply-To: <ed827bde40ab18be536add38c4237d949a752b2d.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 16 Dec 2024 11:47:30 -0800
Message-ID: <CAADnVQJwJVtD6rs0123mEa+Fok34mYL_nAZX09isKQHeLiY1-Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test r0 bounds after BPF to BPF
 call with abnormal return
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Arthur Fabre <afabre@cloudflare.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 10:50=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2024-12-16 at 10:05 -0800, Alexei Starovoitov wrote:
>
> [...]
>
> > > Thanks for the review! Good point, I'll try to write them in C.
> > >
> > > It might not be possible to do them both entirely: clang also doesn't
> > > know that bpf_tail_call() can return, so it assumes the callee() will
> > > return a constant r0. It sometimes optimizes branches / loads out
> > > because of this.
> >
> > I wonder whether we should tell llvm that it's similar to longjmp()
> > with __attribute__((noreturn)) or some other attribute.
>
> GCC documents it as follows [1]:
>
>   > The noreturn keyword tells the compiler to assume that fatal
>   > cannot reaturn. It can then optimize without regard to what would
>   > happen if fatal ever did return. This makes slightly better code.
>   > More importantly, it helps avoid spurious warnings of
>   > uninitialized variables.
>
> But the bpf_tail_call could return if MAX_TAIL_CALL_CNT limit is exceeded=
,
> or programs map index is out of bounds.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc-14.2.0/gcc/Common-Function-Attribu=
tes.html#index-noreturn-function-attribute

Yeah. noreturn is too heavy.
attr(returns_twice) is another option, but it will probably
pessimize the code too much as well.

