Return-Path: <bpf+bounces-18628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB4881CFFE
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 23:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3481828456D
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 22:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621192EAFA;
	Fri, 22 Dec 2023 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GU31fap1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F192E853
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3368ac0f74dso1616407f8f.0
        for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 14:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703285981; x=1703890781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8wr2BCoklxstpCG0AXqdSvusx+ZNdEv+a9VL5nW9Zc=;
        b=GU31fap1q9d962EnlUFGswFhWC/fCquvdXuHeHyISgK+ASB0LlQ3t64PyGJFEzsmSb
         p4TUYeTg3v3G8UKlnqRt5d6ftM/+FYp2veMJ/y7oMWTB2MW5ta895LpArhj8IG7pmkN1
         uCMSPgcCXs8SYTfUZoJnyTQTAO12ejP3ItjsKwQw5Gdfcx1OoKhqVtYYrYpI3dTRVrrV
         jqbwHkvE+sAtM+4xutBh61QrHOqjRXXX85cWCixt/8F1y4Ci88SiJSwe7Q9vNLyIu7JJ
         8gHxuvPSVg1toyYUHiI0bTPonIKTGpAn8bU70V2tS/dLcBqCrf2K0d2KqRewRafVqSA0
         VKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703285981; x=1703890781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8wr2BCoklxstpCG0AXqdSvusx+ZNdEv+a9VL5nW9Zc=;
        b=W3o4qX20VaulsXqGN8zEIdd+Q6NWQwkieEBLcp+6+TPILf62DGJWAyE48S1jwY7cUw
         ovMIME5nSK1+m2AGgvg65K/nbKBd9w5cwA0eawUpdxkls8s4Dupj2j/7YpUi0uGxyJPQ
         57oHtK7DHkNolU5pAUt9OG2y4ekdSQqnz0u8ypLz7Bg4qVQZ4cGcaMNBNakvDhHvV+B6
         peydZk6LoNVYuw8AhZWDcZzvs4tEVof0OJYtyoJnHEZCdwnhPgWp2RGf8Adwsp14Y7JR
         OVMKMmEW5R+uRcDEuR9gVa0g/2se9YXEiKC3UN7yWQ17HgnwPFc3/F1QFRI9ZBvJEqhJ
         h+9Q==
X-Gm-Message-State: AOJu0Yx2IjCJCsyYlAm2vo2mYqj31GprFsiE7ug+YFBGi09fCu0cL+Qy
	rDoe2LIWjxu/Ej36R1ry5QwotyKtl4rOKghcKeE=
X-Google-Smtp-Source: AGHT+IHNl50a2AXElcaWCYofN+n7KXygExNFlz10Ux2s6zzmAt3fhipFyS9wSfXjLKzx4iLQepcOdxIGc7SmMxr4feo=
X-Received: by 2002:a05:6000:1f16:b0:336:9952:f25f with SMTP id
 bv22-20020a0560001f1600b003369952f25fmr800332wrb.133.1703285980473; Fri, 22
 Dec 2023 14:59:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
 <20231221033854.38397-3-alexei.starovoitov@gmail.com> <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
In-Reply-To: <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 22 Dec 2023 14:59:28 -0800
Message-ID: <CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: Introduce "volatile compare" macro
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 8:28=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> When I was writing the _eq/lt/... variants I noticed that unless I use
> LHS to be a full 8-byte register the compiler can still play
> shenanigans even with inline assembly, like choosing a different input
> register for LHS than the one already allocated for a variable before
> the assembly is emitted, doing left/right shifts to mask upper bits
> before the inline assembly logic, and thus since the scalar id
> association is broken on that, the cmp does not propagate to what are
> logical copies.

I saw that llvm can add a redundant r1 =3D w2 and use r1 as LHS in some cas=
es,
but I haven't seen extra shifts.
When it's assignment like this then the register link is there and
the verifier correctly propagates the range knowledge.
Could you share an example where you saw shifts?

I also don't understand the point of:
_Static_assert(__builtin_constant_p((RHS)), "2nd argument must be a
constant expression")
in your macro.
bpf_assert(bpf_cmp(foo, =3D=3D, bar));
seems useful too. Restricting RHS to a constant looks odd.

> So maybe in addition to using bpf_cmp, we should instead do a
> bpf_assert_op as a replacement that enforces this rule of LHS being 8
> byte (basically just perform __bpf_assert_check) before dispatching to
> the bpf_cmp.

I don't see the need to restrict LHS to 8 byte.

I considered making bpf_cmp macro smarter and use "w" registers
when sizeof(lhs)<=3D4, but I suspect it won't help the verifier much
since 32-bit compares update lower 32-bit only and range of
upper 32-bit may stay unknown (depending on what was in the code before 'if=
').
So I kept "r" only.

I still need to investigate why barrier_var is better in profiler.c.

