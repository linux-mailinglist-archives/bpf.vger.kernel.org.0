Return-Path: <bpf+bounces-50176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F9DA23760
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 23:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA30F1672B2
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 22:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE771BC9F4;
	Thu, 30 Jan 2025 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkKBaZUx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177141B4156
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738277337; cv=none; b=agacxVpA47+0yQh+sIYk3E3osHf1f6TmHv9hZ7Ywy6dFo9UxGK3kJLgvbsOvMy2i/Skwkbxz07ZjUnq22AENgmINDJ1IFpHTKGn8Ei/LOxq7Pxfwnj/5D7BDV6dPk8DCrvY7ymVadNlGKv468l4hbNhs7Wo34hD574dth3RJJNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738277337; c=relaxed/simple;
	bh=iveAOxx7F7q5CjEqukAcJIkEKzzMfWgyHu9hnhbf7JI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bsRpsuSxdnooGhit1Yfc7+pE/Rw0kC+KIvFp5MFrHNqEun5/n+pQgqwPX6XHOZ1OUPsqk3YncRNH1N4GPnvPTTJ4tThRYvmlXteIOJt2bAIz8teTawzHOdLRa/P1psefRxef3YUU3Ta31o8KaCXQILODYk/eG1V+wVwjECuZfeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkKBaZUx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso1841035a91.3
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 14:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738277334; x=1738882134; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LZ6xl2HIYNRJ4FHQ+tVQ7Y8ejHjKn5fNAcerWncwMG0=;
        b=XkKBaZUxmseO9q04aJdoWtc4g90bxxHM0GrR03TOXr56/+iWhDICZqyuTR2nM2PYxM
         9R6piuIY3Kavi1F96GpRezngvayQx3VXZpGT1mliM6M6wTIX9qLCrSDP2CmpQ4ctE9wK
         aG4NiAvAxfPz4a1yiQVnQ+NAHlQqyDWmUZErvLntecyvxFWokBVMrqd8BUiyDHYIf2d3
         eisB6SHc1TDD/9FCpOCmfifUrKZdiheG8JfA0pnrNJh/qlz2QUHxtoz5ySGdOuIbS7HP
         MHObEaRP/aqvscF6FC+6Av8NGZHRXuunCz/b+8S39myfyghiQ2KR0sxcZa1rP9N8n6Ci
         jaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738277334; x=1738882134;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZ6xl2HIYNRJ4FHQ+tVQ7Y8ejHjKn5fNAcerWncwMG0=;
        b=HCqFmeJr0TEnQE+nLo8Y8tqhEVZkzmnXobyzXnANYrsL5/oK/0g/86/AtRpS7cmXKt
         DeEnorEkWyqCnXEu+cQkUblm5qoaa0aFnq59f3k2eOk6dC9yuFigkGZX6nJi7fQ2Egv9
         i93MoL30nP15VCByS2eKZCz80ZEP1Xcr47HfC1Lh1JjIxmNa5EGkf8dvfFQT4hoT7a0W
         GWCeLjFzFFmxYjKTOveLjwFUI3QbVDDnvqAIcVchDgcbOYaqaDFv5CbIFVQncf/5p+OV
         1mLwztBU5depD4CR5/seFvls4BLUSF4hCwH9SLNYNDu2Djo25TEghT0hHPzRVh51gZXc
         CVgw==
X-Forwarded-Encrypted: i=1; AJvYcCUqynD40Dn1Vpu5VSbwCOQYGztoQZhDo7wNX27ezOipAC/a34fFdoOE009j8CwFY6oq4N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQEqYsgz3CqsEY9arLDQUqQfFE47wh6SHE9L/4M/V3PhaJEYZ5
	uKuTG02H2XqRsmRGpohTGjNKTbQNrly+J7/xfMD16gO0VFJtnjri
X-Gm-Gg: ASbGncvw0dzdUMpJHbjJ8y3WW8SyyKX1WHNID8VVV2catIzvp7mwIzrbjaa6TMrg17Z
	RKJqN7xg5rjKp+wP98zQAIABi02W9vERvwNpnDjeQQRp/rIQzw3/wBpJ3LIvq/V/PfL92u/2oXH
	I42s+/0SVjSJm8vVfAlDlUI/LVyYODbgd131/5Sfr3nNGLub4ss01adQhoAkHzTx8S0R5F08p/f
	td2B6YuuTskd3x8N21lQUXjbIngKNAPGtJj29ATR4++ZDYUhQWAIlB+QHTJE+M9cEkkA94SNWgd
	09GQaxq4U65F
X-Google-Smtp-Source: AGHT+IFtG4NbvcEozNTQOCDE/aobKjgKK9QIrwiA9UsVpB2ttJJu3m9YHE1rA6s4Oy7JUVA382mkew==
X-Received: by 2002:a17:90b:2dca:b0:2ee:b666:d14a with SMTP id 98e67ed59e1d1-2f83ac00cf5mr14593491a91.17.1738277334259;
        Thu, 30 Jan 2025 14:48:54 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ea7cbsm18940065ad.151.2025.01.30.14.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 14:48:53 -0800 (PST)
Message-ID: <1622c76ba2b780105de3c25502357a527b18b4d8.camel@gmail.com>
Subject: Re: [PATCH v0 3/3] selftests/bpf: Extend tests with more coverage
 for sign extension
From: Eduard Zingerman <eddyz87@gmail.com>
To: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Mykola Lysenko	 <mykolal@fb.com>, Yonghong Song
 <yonghong.song@linux.dev>, Shung-Hsi Yu	 <shung-hsi.yu@suse.com>
Date: Thu, 30 Jan 2025 14:48:48 -0800
In-Reply-To: <20250130112342.69843-4-dimitar.kanaliev@siteground.com>
References: <20250130112342.69843-1-dimitar.kanaliev@siteground.com>
	 <20250130112342.69843-4-dimitar.kanaliev@siteground.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-30 at 13:23 +0200, Dimitar Kanaliev wrote:
> This commit adds a few more tests related to tnum_scast that explicitly
> check cases with known / unknown sign bit, as well as values that cross
> zero (going from negative to positive).
>=20
> Signed-off-by: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
> ---
>  .../selftests/bpf/progs/verifier_movsx.c      | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/t=
esting/selftests/bpf/progs/verifier_movsx.c
> index 994bbc346d25..20abeec09dee 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
> @@ -327,6 +327,79 @@ label_%=3D: 	                                       =
 \
>  	: __clobber_all);
>  }
> =20
> +SEC("socket")
> +__description("MOV64SX, S8, unknown value")
> +__success __success_unpriv __retval(1)

Note: __retval() annotation is needed when one wants to execute the
      test using libbpf's bpf_prog_test_run_opts().
      The changes for register range tracking should not affect
      runtime behaviour (unless there is a bug in and some dead code
      elimination is done incorrectly).
      I suggest to add __log_level(2) annotation and check verifier
      log output using __msg() annotations to check what range is
      inferred for specific registers.
      As-is these new tests are passing on master as well,
      so the feature is effectively untested.

> +__naked void mov64sx_s8_unknown(void)
> +{
> +	asm volatile ("                                      \
> +	call %[bpf_get_prandom_u32];                         \
> +	r1 =3D r0;                                             \
> +	r1 &=3D 0xFF;      			             \
> +	r1 =3D (s8)r1;  					     \
> +	if r1 s>=3D -128 goto l0_%=3D;                           \
> +	r0 =3D 0;                                              \
> +	exit;                                                \
> +l0_%=3D:                                                       \
> +	if r1 s<=3D 127 goto l1_%=3D;                            \
> +	r0 =3D 0;                                              \
> +	exit;                                                \
> +l1_%=3D:                                                       \
> +	r0 =3D 1;                                              \
> +	exit;                                                \
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

[...]


