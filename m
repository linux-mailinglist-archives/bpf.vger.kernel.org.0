Return-Path: <bpf+bounces-30155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276AF8CB468
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 21:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979111F2322A
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 19:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C89148FEC;
	Tue, 21 May 2024 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SM9bWrtx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31512208DA
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 19:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716320887; cv=none; b=tQaERciUUrPedqRU7ndzlC50NUADscgwi5I0IpCQ1bfrZyPudnqomX6x1ef0IDMittbRjkAgW9fPMK+2/f1RDo/6ezum8cXdk/kDilVEJs/cJiRxOuhqv/1z09xjsRQjJ5V6te1RPfFccwhI6a6Uj0bE5fuc27y5Rb289guyKZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716320887; c=relaxed/simple;
	bh=n/OknCsCl/sy0dRsezLKrcZZfy445/+GVv6TVvue9zk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cPHqRCXiR2oP5JWrrrNZea6d5DX3YJNHx0x0ERkYatJM0eK35LnIEtxLq90XFfopeIj6OBQsnq8sCLWQzSncodUzcN5kqhADyz4rezPXbVc8fnwsTOW/mV5CbnmezeDmW4JLsvXWTRSwOv2qHZMAcT5g/fWaNVlQKdKrpYn8KnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SM9bWrtx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2b8a13416d0so561114a91.3
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 12:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716320885; x=1716925685; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dUTTV+Ry3EWKqyAWaM+NScTJ5tlhoLKKYXQQ/uRVF3I=;
        b=SM9bWrtxUQkg6HpPb9xFDhQIcDoNWtWRQ9IN2Slxr1vk4RsBMR2wM06HlUoaKFEZy5
         r3JwmzAxj5sRF/tF1HN4xSUfQ5voemBJCY/+gdXdryl7C4OPwnRpDT6vMdpF/yAAakgt
         3D90CwccT18Fp14L3sPdJu0K7wsvJU6YChr9s3HRXU3R+olG03AVDjdD3JD99sbHKbBF
         57OJuNvM20aNQ0BnLDqeR1c+XXxoEZc1FIiSRIXZ8QOzr8UDq5JCFr15ummSRPvt5dUG
         JrGirUG98p0pbUnFF1BxVNjfXPjlPnMQRxkpYTRlaOviJtQIhf/mj43YKtEs0vVLdSIz
         +QKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716320885; x=1716925685;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dUTTV+Ry3EWKqyAWaM+NScTJ5tlhoLKKYXQQ/uRVF3I=;
        b=NQhujCtEn/6RToM7+9be1EBXdxtBRZpaMbFKj7Se/Y93E9/W7g7zIOdJ0l76l0aC4q
         X0YhmMjalHyrM/nlJcfsni6YxYT86k/umf49UNiPQT+8jLoqoR28klbHG3Px0aLdnGHK
         wobuIIaVldsQLZorOCcdazy1cHKR4OIJpXe4/QqH5ZeMTZcSzAbBOewaDXbMKCGHoRaL
         gZwoijEF4adfu/iTHSRs4bX44IAyzFgghaR/OGJDvyADIcG3eQlubJlAYjP/UjtA9ExJ
         TdOceU244YRy1iy/GxbQL1N57BZE5rxx+pQjmdTHDJlq5LIb/1eDTVgUbpILvXKchHdy
         IbzQ==
X-Gm-Message-State: AOJu0YwobdOLsAaz1O3nAGH9P8cGRjFI8idcEpYQCWmr6kLADLskAzsk
	5DQOrjsRU9beGuCjcezxAKSMoHoDugtjVDZgm5+1OwBQNqSFbvEY/kQHEHAI
X-Google-Smtp-Source: AGHT+IEAxY+/FXZZAsDkLDQLrkSS9H1x6BheH/i4bAGKRt5JVkuXE5+1B+jTKbFM3DHlEEeSj7AtLA==
X-Received: by 2002:a17:90b:11d2:b0:2a2:70f6:8f67 with SMTP id 98e67ed59e1d1-2bd9f59ebcfmr97899a91.30.1716320885291;
        Tue, 21 May 2024 12:48:05 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62863a238sm24433732a91.7.2024.05.21.12.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:48:04 -0700 (PDT)
Message-ID: <f8b7741fff952d2be84f0a5cb5f8f9622c0bf09c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verifier: make kfuncs args
 nullalble
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>,  Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org
Date: Tue, 21 May 2024 12:48:04 -0700
In-Reply-To: <20240510122823.1530682-2-vadfed@meta.com>
References: <20240510122823.1530682-1-vadfed@meta.com>
	 <20240510122823.1530682-2-vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 05:28 -0700, Vadim Fedorenko wrote:
> Some arguments to kfuncs might be NULL in some cases. But currently it's
> not possible to pass NULL to any BTF structures because the check for
> the suffix is located after all type checks. Move it to earlier place
> to allow nullable args.
>=20
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9e3aba08984e..ed67aed3c284 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11179,6 +11179,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *e=
nv,
>  	if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env=
->prog), argno))
>  		return KF_ARG_PTR_TO_CTX;
> =20
> +	if (is_kfunc_arg_nullable(meta->btf, &args[argno]) && register_is_null(=
reg))
> +		return KF_ARG_PTR_TO_NULL;
> +

Nit: maybe move this above the KF_ARG_PTR_TO_CTX check as well?

