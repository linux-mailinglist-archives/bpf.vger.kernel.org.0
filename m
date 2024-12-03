Return-Path: <bpf+bounces-45971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71E49E0F7D
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 01:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B686B225BB
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 00:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BF8645;
	Tue,  3 Dec 2024 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdBQtIic"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE139A2D
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 00:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733184334; cv=none; b=OnqPfOP4INtjqwAoYhgBR5y5FHig095d1gLzofqZswD3kxGnVTlgGS5LANhqcXsrwU0F2kghZzzD9sr6QOJkeFS8OrLleZFKhR+AuCviYP2u/WhK600O2fKyXNCkHmWhbvg5ro4aPOyQd683unLM/b9OQtcvMPwsZ81W2Aq/CQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733184334; c=relaxed/simple;
	bh=q8rz2DT+/mzwQcleZkEWXdXy4ZM11nUMdi2b84XcUTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPhxbjiGT7WUqfYts3ufnL2VROoenO9lVfIa4kMwgt6FeS7zGn9KSbGx5toOGP+TCxLnJt/6bOf2trZQLE0gYmSIq1zZU9NOnUIEoQt+2KKASuakznmO2oHT6WsXTEArBdA84lj/OxfFtw904G7X7ZD4q5h1sb8KASiz8BqFno0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdBQtIic; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ffe28c12bdso44608511fa.1
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 16:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733184331; x=1733789131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1X76QhN84DXWC/2RA9PsnRQx/D+7vx2BmQUyUXadieI=;
        b=fdBQtIicwNVt/NgNdz11b3uvbd1C9GUG6h5lSLzmZUfzGz4o6uSvQ6SoeSkn9PVTvU
         uGBBn/PGOSZHxhnUWAGcIJxfnLs20IDPdgvBSm9dWL9jChOjYs5rdX4kq3LWGjvYK88t
         GFxJpOEV0zgdbg/4Wa0XFsUINNmM7eVSgPwmVEnCRi5S/E8TdR0RMg0nIVgRsCp9hDAl
         nGsmZ/bS8JrnkQNqsqB7zKALBOo2kxsAN9pD14+cRuA2ZZiegCxhigz/9xYWXE2eX+iX
         eEgkEI9zPLfSU0e1ZR1kGDllSwnZGbVkfRZbw4dgIdLuxp5wPgpj6Ou+a1QoIkfwWZi6
         pGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733184331; x=1733789131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1X76QhN84DXWC/2RA9PsnRQx/D+7vx2BmQUyUXadieI=;
        b=fYthsq0noTC2oub9pX3GXT11OmjYu5NyB98PnwCHwVxdkEqpOd9X99NK5iSs2FV3gg
         g0GjoOrUUgdDerl1Ff882M4V2l30bzO5yaVNxjSJuQ9caLTeBXBLIGgkUfXgYuBwyJfL
         WRXIizs4260ruapuwR9n9bX9FfIAmvTd/28VPX9MMlhvGlpGuqbWmZzGRAVirUOIpKUZ
         DeBrEWmcV/WDb7BhKtfyYHicI5cext2BZYK/ol3jJogUx5fckGLijCXEvXDcNqT1zChg
         pM8qDtw7mvNx0SWj0J9dEDtBLha5oRXZObmp2CNrK6TYRFczDipAQLZMa9+HlElwnaOv
         woBg==
X-Gm-Message-State: AOJu0YzituoytYAVrjQDfb5UpjhRaPogjoVZ/CnwhD+qF5MYwSkrruKC
	CF5WBZWDlj4QR6RwdOg9mqVdX0X7RxDMsy61F1ZBKqQk6sMT4XHx+dsIj8UNcmq5XHd+Jyk2NhD
	nFHunnVZU2fAY7GVBqTJwZXbjeBw=
X-Gm-Gg: ASbGncuQIdbnC6aMf8otepGyeoRF0Ax0obSYTAzTkKnNdgoYqFtOElbckyfHkb6DCzS
	VFN4SufigpJd6nq8pMM4y6wuT06vOHt0vCMHEyTs40BiGAU0=
X-Google-Smtp-Source: AGHT+IESh1CsbZC+yJ3JbHst990WRLPAzQorD+6xhUkpHLWIrF3QLx60Truv2dac/S3vjeMy0oEQw/EYL4rOhUbwJas=
X-Received: by 2002:a2e:bc83:0:b0:2fb:955e:5c17 with SMTP id
 38308e7fff4ca-30009cc52cfmr3428011fa.40.1733184330758; Mon, 02 Dec 2024
 16:05:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129001632.3828611-1-memxor@gmail.com> <20241129001632.3828611-5-memxor@gmail.com>
In-Reply-To: <20241129001632.3828611-5-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Dec 2024 16:05:19 -0800
Message-ID: <CAADnVQKyb78oeRaYZjvHVj3th6RQHg4zTVKk=rHqyCGRAPx_Mw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/7] bpf: Introduce support for bpf_local_irq_{save,restore}
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> >         enum ref_state_type {
> -               REF_TYPE_PTR =3D 0,
> -               REF_TYPE_LOCK,
> +               REF_TYPE_PTR    =3D 1,
> +               REF_TYPE_IRQ    =3D 2,
> +
> +               REF_TYPE_LOCK   =3D 3,
>         } type;

why extra empty line?

why renumber ?

