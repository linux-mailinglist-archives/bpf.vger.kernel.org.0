Return-Path: <bpf+bounces-19061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A00824964
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 21:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB551288055
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 20:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839352C1B8;
	Thu,  4 Jan 2024 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPxgQNVg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3782C1B3
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 20:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so1136834a12.2
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 12:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704398818; x=1705003618; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Qpy8CKTwx13EKLhCgem+XwA5WicRaOxmBu3xP/hAcw=;
        b=gPxgQNVgHIFruAG/BQ8sziIVH0b3mvWV8mjh9aMBJTlIcud+vI4Sq36xUiWl1LJ/g2
         T1t4soTALMdzgEyby16vqmMpqwUvhW5Citm1CRokUY60GR3+KgTIIIEmdbtaO4UOOvla
         XVNKIq+tgCjO5aqJap4wJyBbty5tjr+hWrMYDdcF5gDBXwTKrcelRQMms2SGO5jSwXb0
         0NiyFUjDxMt0C4qz+kjbDi4mS7SPsviPRkYQyi/osRd3+gc4YMwXmlYgkLl77c2lRIsm
         ck/KQ/9TiJcAcZoel8HD/H/n0HIVNAvZT76au7FkrfmMqjdC4BIRbrTlRB9Haj07yT6A
         4eUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704398818; x=1705003618;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Qpy8CKTwx13EKLhCgem+XwA5WicRaOxmBu3xP/hAcw=;
        b=ppH1npgNkrDPKmKjBOEdJMqFNpHlNNXGnjWJwHbxX1TQgKptbv6q8tHqvcqYj65lid
         k4XKVeYVscHj/oNPojtVL+ApV1VTO4c65julwLSWtv29vbe/E9JWwGz5MuJiHykEL/VF
         5bXOzz7XhYBkF4LGK3eIKOcltdzDu59AjZ8aF1flUcKF11BY8kD6xmw5q4E4NtodoF+9
         iGbGBm9KjDD48+tcUMLLI/mmo28KzeqaQwceg2ptaK9+qFj9gpunjVrb3GTpIQAD7k+x
         UR9SdKYdoEExQqeuC+MCc0+IHsXM5QIUTLLGFofHf6csZc3CbThCDIyBXo4HbvNR85wV
         gy9w==
X-Gm-Message-State: AOJu0YyZG+N4O3m0fOFVL0z51k5N/JhkjgpVEvxXtu0rom8XtnL4DvME
	7nu6z2tSBAoaJ7oV3LyOR3vCRJByo9uVuw==
X-Google-Smtp-Source: AGHT+IEz0j6WY4Qeu/ZV1TjM60UwFjQkTr/DMrkZL3WQN6SITkbTWNLakXvqHo6vH1Xk+7LpJmhMAw==
X-Received: by 2002:a17:906:ae5b:b0:a26:f10b:758b with SMTP id lf27-20020a170906ae5b00b00a26f10b758bmr416169ejb.233.1704398817634;
        Thu, 04 Jan 2024 12:06:57 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id j19-20020a170906431300b00a28aba1f56fsm19661ejm.210.2024.01.04.12.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 12:06:56 -0800 (PST)
Message-ID: <c467ee717491884d153bb0016accb9a8a539b899.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: Introduce "volatile compare" macro
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Kumar Kartikeya
	Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>,  Martin KaFai Lau <martin.lau@kernel.org>, Daniel Xu
 <dxu@dxuuu.xyz>, John Fastabend <john.fastabend@gmail.com>, bpf
 <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Date: Thu, 04 Jan 2024 22:06:55 +0200
In-Reply-To: <CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
	 <20231221033854.38397-3-alexei.starovoitov@gmail.com>
	 <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
	 <CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
	 <CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-25 at 12:33 -0800, Alexei Starovoitov wrote:
[...]

Regarding disappearing asm blocks.

> https://godbolt.org/z/Kqszr6q3v
>=20
> Another issue is llvm removes asm() completely when output "+r"
> constraint is used. It has to be asm volatile to convince llvm
> to keep that asm block. That's bad1() case.
> asm() stays in place when input "r" constraint is used.
> That's bad2().
> asm() removal happens with x86 backend too. So maybe it's a feature?

The difference between bad1() and bad2() is small:

                             .---- output operand
                             v
bad1:    asm("%[reg] +=3D 1":[reg]"+r"(var));
bad2:    asm("%[reg] +=3D 1"::[reg]"r"(var));
                              ^
                              '--- input operand
                             =20
This leads to different IR generation at the beginning of translation:

  %1 =3D call i32 asm "$0 +=3D 1", "=3Dr,0"(i32 %0)

vs.

  call void asm sideeffect "$0 +=3D 1", "r"(i32 %0)

Whether or not to add "sideeffect" property to asm call seem to be
controlled by the following condition in CodeGenFunction::EmitAsmStmt():

  bool HasSideEffect =3D S.isVolatile() || S.getNumOutputs() =3D=3D 0;

See [1].
This is documented in [2] (assuming that clang and gcc are compatible):

>  asm statements that have no output operands and asm goto statements,
>  are implicitly volatile.

Asm block w/o sideeffect, output value of which is not used,
is removed from selection DAG at early stages of instruction generation.
If "bad1" is modified to use "var" after asm block (e.g. return it)
the asm block is not removed.

So, this looks like regular clang behavior, not specific to BPF target.

[1] https://github.com/llvm/llvm-project/blob/166bd4e1f18da221621953bd5943c=
1a8d17201fe/clang/lib/CodeGen/CGStmt.cpp#L2843
[2]

