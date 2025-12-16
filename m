Return-Path: <bpf+bounces-76772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA76ECC53F7
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 22:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85A813063842
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 21:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243DE336EDE;
	Tue, 16 Dec 2025 21:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfHyxwgi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF6D337B8E
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765921527; cv=none; b=hQmksT78gsb4MgrqAylXiI+UBwRue4kMfx7IuIyqmQjWuuIWw8HrODecOiGSf4BmPflrnU8+GPY4VeFGvH/KaKGDO1P7xWWWjqVX4ahzqpkfvrp1YVtxLd3oamBlgu7ajB5xduE82+j4eUN4X2KekVc2iQRuQ569ZJEOzw4rVHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765921527; c=relaxed/simple;
	bh=VSn5YG7d9ytZps+YVHnKVfK0Ui+200nONyoEN3WADwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSHPC6to7aP6dlOq8rkhvIdYw0lRBw+dUvVmpG6UdDKsQqFDR9l0i3XkjP6VXWgqHt/zz78lrTM14mK4Q7C2nrO1IQMY4WmzyWREJQr7xeJ8Cyhk4Yb26hB+HxEBmwJgP4OuCAFK/Y9bU85nvCSdjksycc/EzY9eLEkmMTDYjYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfHyxwgi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A8BC2BCAF
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 21:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765921526;
	bh=VSn5YG7d9ytZps+YVHnKVfK0Ui+200nONyoEN3WADwU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nfHyxwgiKknhn0v9sPPA8ywWiAL7smWCZT1Roa1BXiS+XiqJBZWhauo1XE+UmcKdf
	 xBJGT56ZDVxlchI4cw7rVPbttbEBXN7Ohb1QLRpj/jiyE+Jv4kd02XRVimTewRYaO5
	 IUID0nZ9n2yNEP8Vog0WNd3YmSpjfUIkZHSXUct/MIBmhUoT0PN7jrcypLJu9j78sI
	 4gn80F2+Tox5a9PF+7SLoZQ4Bl29ZsFRCokbOP0rTWNi9VtWv0HcJWDD8+bwcA90h2
	 awKva0vetZizrGVivKxzUYE0u48UDswIhRymuxjJZJy0aFdLZQtNtMavbT5HBzslD6
	 UtpfouIbeXFTA==
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88a367a1db0so40698866d6.3
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 13:45:26 -0800 (PST)
X-Gm-Message-State: AOJu0YyVltBjz5yRQFCiSjOSdcDf4fLSZFIovPWDiZBBmXqteuJaR/L7
	Kz29af4zKanzKFxkfI2IlDWMAwf+WqIdoxzkzZXNhAqgwxV4M2EDL7tNmq43/+CdFkFxgXnglxC
	5zXz3wGWhpQA1fG1tieQr3Mxbnsyavis=
X-Google-Smtp-Source: AGHT+IGpiLALaVjL7tyGWaMRlls90DvvPiovsVSUg+k0/mjln3cJpBCT97sQ7Mze/906fNU3JYXecT8Kzf0E8JMjlG4=
X-Received: by 2002:a05:6214:5788:b0:880:4ec0:4183 with SMTP id
 6a1803df08f44-8887e13f010mr224073886d6.46.1765921525920; Tue, 16 Dec 2025
 13:45:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208030117.18892-1-git@danielhodges.dev> <20251208030117.18892-3-git@danielhodges.dev>
In-Reply-To: <20251208030117.18892-3-git@danielhodges.dev>
From: Song Liu <song@kernel.org>
Date: Wed, 17 Dec 2025 06:45:14 +0900
X-Gmail-Original-Message-ID: <CAPhsuW7c7cPatiRzwvZ=d_43m5XwPqfmphvNyyUu52G6rgbsQA@mail.gmail.com>
X-Gm-Features: AQt7F2q1-y313JcILakG9UK_RrCFUQ6dp-8PBV5qPpicFyajKWsZYKW-0lgEBCU
Message-ID: <CAPhsuW7c7cPatiRzwvZ=d_43m5XwPqfmphvNyyUu52G6rgbsQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] crypto: Add BPF hash algorithm type
 registration module
To: Daniel Hodges <git@danielhodges.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, vadim.fedorenko@linux.dev, yatsenko@meta.com, 
	martin.lau@linux.dev, eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	yonghong.song@linux.dev, herbert@gondor.apana.org.au, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025 at 7:01=E2=80=AFPM Daniel Hodges <git@danielhodges.dev>=
 wrote:
>
> Add bpf_crypto_shash module that registers a hash type with the BPF
> crypto infrastructure, enabling BPF programs to access kernel hash
> algorithms through a unified interface.
>
> Update the bpf_crypto_type interface with hash-specific callbacks:
>    - alloc_tfm: Allocates crypto_shash context with proper descriptor siz=
e
>    - free_tfm: Releases hash transform and context memory
>    - has_algo: Checks algorithm availability via crypto_has_shash()
>    - hash: Performs single-shot hashing via crypto_shash_digest()
>    - digestsize: Returns the output size for the hash algorithm
>    - get_flags: Exposes transform flags to BPF programs
>
> Update bpf_shash_ctx to contain crypto_shash transform and shash_desc
> descriptor to accommodate algorithm-specific descriptor requirements.
>
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> ---
>  crypto/Makefile           |  3 ++
>  crypto/bpf_crypto_shash.c | 95 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 98 insertions(+)
>  create mode 100644 crypto/bpf_crypto_shash.c
>
> diff --git a/crypto/Makefile b/crypto/Makefile
> index 16a35649dd91..853dff375906 100644
> --- a/crypto/Makefile
> +++ b/crypto/Makefile
> @@ -30,6 +30,9 @@ obj-$(CONFIG_CRYPTO_ECHAINIV) +=3D echainiv.o
>  crypto_hash-y +=3D ahash.o
>  crypto_hash-y +=3D shash.o
>  obj-$(CONFIG_CRYPTO_HASH2) +=3D crypto_hash.o
> +ifeq ($(CONFIG_BPF_SYSCALL),y)
> +obj-$(CONFIG_CRYPTO_HASH2) +=3D bpf_crypto_shash.o
> +endif
>
>  obj-$(CONFIG_CRYPTO_AKCIPHER2) +=3D akcipher.o
>  obj-$(CONFIG_CRYPTO_SIG2) +=3D sig.o
> diff --git a/crypto/bpf_crypto_shash.c b/crypto/bpf_crypto_shash.c
> new file mode 100644
> index 000000000000..95c178ec0ce8
> --- /dev/null
> +++ b/crypto/bpf_crypto_shash.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <linux/bpf_crypto.h>
> +#include <crypto/hash.h>
> +
> +struct bpf_shash_ctx {
> +       struct crypto_shash *tfm;
> +       struct shash_desc desc;
> +};
> +
> +static void *bpf_crypto_shash_alloc_tfm(const char *algo)
> +{
> +       struct bpf_shash_ctx *ctx;
> +       struct crypto_shash *tfm;
> +
> +       tfm =3D crypto_alloc_shash(algo, 0, 0);
> +       if (IS_ERR(tfm))
> +               return tfm;
> +
> +       ctx =3D kzalloc(sizeof(*ctx) + crypto_shash_descsize(tfm), GFP_KE=
RNEL);
> +       if (!ctx) {
> +               crypto_free_shash(tfm);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       ctx->tfm =3D tfm;
> +       ctx->desc.tfm =3D tfm;
> +
> +       return ctx;
> +}

What if we let bpf_crypto_shash_alloc_tfm() return a "struct shash_desc"?
shash_desc->tfm is already struct crypto_shash. This way, we don't need
bpf_shash_ctx any more. Would this work?

Thanks,
Song

