Return-Path: <bpf+bounces-13377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB097D8BDE
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 00:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6C7282010
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 22:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9846A3C083;
	Thu, 26 Oct 2023 22:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/mY5HqU"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837868BFD;
	Thu, 26 Oct 2023 22:53:35 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9851B2;
	Thu, 26 Oct 2023 15:53:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32d80ae19f8so974220f8f.2;
        Thu, 26 Oct 2023 15:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698360812; x=1698965612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgnbF3Hsu9/XQh4UgHEZNCwHcpd7d6NRmUUuObs8kj4=;
        b=C/mY5HqUW4WmCZQ8R0+4yPwb1FKc6D6aeSDqYsvqDxJwnE1aaMsXQbgmRpvHXw9FVh
         4RAzLxgg0nk3Yt19tcrYa1Urk1s0O8G6rIggVS8QZnZ9d81UF6pT/cr50PdzP74/kpcS
         6Io7WcXdqzRIx4FMXevwbqUNG6IDMW97bZJIGOAMZSNfqIKFIuU5pLecXhvFMqYaVKj4
         +RVwTnQ1jQZgkjku994HKV1tKffLfeX/EULmmzzllF1U1JTYI5Ioar5/UhZcsUeZqbU9
         G7SnFbWe0DRgUHI+rkUH/6tRGOGIz5xM+XlbF9p86fcNyBGjJvHcMwWwGbxDGjZ5Xugc
         E1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698360812; x=1698965612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgnbF3Hsu9/XQh4UgHEZNCwHcpd7d6NRmUUuObs8kj4=;
        b=i7WyWyNrY0RP507L9sOtpkYSEp2Tdo6AT+vyFT7/cLOVh8hiaQYYI3H4rKbK4Ykghj
         YeK6t8KL3yY4FxTXErT8dWmPG4ixKC8TMQPpnvOSkap1b7WWDm1GsKyp9BkhU57rsJDV
         WY8dWQOVwwf34GFEjj98P21zXFjZsCwlchG6XW3y0hMgf17xxSt4XwmL0jZTRrgrFGKs
         hsNc7ObLqF2opXVCcxHdIDfG8yCsMlFonYjp+Zm8SI/DFE2q3XlEwz34+ddUNpTt7OYX
         uf6B2DUAMp2QRr+EhsSO9dACBQA80gAUNGLGk+Y7FHcTqxLkTYaOT+37XfaXeHEmvnCA
         XpgA==
X-Gm-Message-State: AOJu0YxTPr2ieY3zXeW3DhuJirg093sky9VteUIoaQ1uLRoBjTK2V+hs
	cwEfBihryNlb8KoMOFcJ1aK2MOcKAut+OHuWXLjOO0VQ
X-Google-Smtp-Source: AGHT+IGrI1aktxHcABBYb+9E51oOzbpmkdtJKFiGUWELCegWokJcbkIEwWpERoc2w39UNvJqRkQHQs7E46A0nB8uD2o=
X-Received: by 2002:adf:f392:0:b0:32d:b8f8:2b1b with SMTP id
 m18-20020adff392000000b0032db8f82b1bmr652047wro.26.1698360811890; Thu, 26 Oct
 2023 15:53:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026015938.276743-1-vadfed@meta.com>
In-Reply-To: <20231026015938.276743-1-vadfed@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 26 Oct 2023 15:53:20 -0700
Message-ID: <CAADnVQJ6E+YFoZdtyTUHGHvMevW+wGnGsZRgve_-zY3MedjbjQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add skcipher API support to TC/XDP programs
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 6:59=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com> w=
rote:
>
> +__bpf_kfunc struct bpf_crypto_skcipher_ctx *
> +bpf_crypto_skcipher_ctx_create(const struct bpf_dynptr_kern *algo, const=
 struct bpf_dynptr_kern *key,
> +                              int *err)
> +{
> +       struct bpf_crypto_skcipher_ctx *ctx;
> +
> +       if (__bpf_dynptr_size(algo) > CRYPTO_MAX_ALG_NAME) {
> +               *err =3D -EINVAL;
> +               return NULL;
> +       }
> +
> +       if (!crypto_has_skcipher(algo->data, CRYPTO_ALG_TYPE_SKCIPHER, CR=
YPTO_ALG_TYPE_MASK)) {
> +               *err =3D -EOPNOTSUPP;
> +               return NULL;
> +       }
> +
> +       ctx =3D bpf_mem_cache_alloc(&bpf_crypto_ctx_ma);

Since this kfunc is sleepable, just kmalloc(GFP_KERNEL) here.
No need to use bpf_mem_alloc.

