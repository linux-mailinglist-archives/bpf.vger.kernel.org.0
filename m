Return-Path: <bpf+bounces-37057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F03C950A25
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613AC1C22AD2
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ADA1A2C0A;
	Tue, 13 Aug 2024 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKfvfuCY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE201A2573;
	Tue, 13 Aug 2024 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566551; cv=none; b=AZd/vat//BsYi3FjUklLyvsqedWSbHbANYzlOSY2lBeJbUi7pRwD6VuHyqeRpvMTUQWLPsu9uzhWpy72sSFsm1Yzojz7q8HQXbLp3pP4CcIw3EyBBbiNGGLUWxR1SWevmF4NzxgdKBKPrFZno/Z2Vo1EPUKuI2PTjEhRgqllu1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566551; c=relaxed/simple;
	bh=wTHMksnShasaMu0YkQx+byCye7Bb9rVvVk7DsdGChvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGgj/m/HsfshW5j5iFI4V4AHDX7fAQJ0uKHRjgVbNfO0LtYh8JaN4bHToXaAmuooXxkqm9f8GgPh1HIAiUSaLe+XXxVtv5CxLeuJM4TvrWRfkDBB/SBtu+1gXyO8B7qeEscbhYphvdzPR/mz3IbGlWd0Ep2bCV3ZkfTlEuLLuII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKfvfuCY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428fb103724so160225e9.1;
        Tue, 13 Aug 2024 09:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723566548; x=1724171348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHZnlrhN2AES2SquLcRLOECxi9CzRlchk7IVnfUTEhs=;
        b=GKfvfuCY4JJ1mcQIhA97CdpG+wWNWkIDz6loxlZxpPIpzMWGCak33/7iiqXozjSYEL
         p/39GslQWsbw61CuyHrDhhgVhw9PL+7tPxHj+KHuziNnPn9FHjgph3ZtmyT5lyVAEbtc
         291gkB9X69/nD5YksFFyh9XpmLBxXc9px0UgNzA/nnn660jh8/XGGpwO12UCxYPd25rd
         yxVlwOlyA2jD79IwVL6KoNQsXhPTWYgYZXQXR/L/OM3Q8OC/47U+coRPtx2YqvQUtS6B
         1liCWSuPFLAXgrXHPusqa20P1xDCDVToph5NZR/bwK963D8Xob+ODlwXFsqNZhLCfU6k
         xgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723566548; x=1724171348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHZnlrhN2AES2SquLcRLOECxi9CzRlchk7IVnfUTEhs=;
        b=OgAk/20j6+fO//Ap31LnnmDxfkhcxu2547H427wA1Izm4OcktSqbDirEpLh5Xw+oOp
         TUUVATSD5il8DkXS+SKZApMp7M2Wf2lNCz+qtrQMcr1wMGnGunsUe4QtBAnIGTociRv1
         zdU/6GXeInh3Qi77FJVcsmBySAnfRShd6JDRPaJdYmpM7uSzwYVYBHRkxBCM/aLRsSF1
         pd0+j0ETrodc3jqLJEloR+PxXUivz6GOUTdz/2qKzSI+9/2rAXaSSKUIl+Lb+V+xhqCy
         R6aZpX7VviUVm2nCKD2BDgPHWTBupS1h/Lpm5Nu7W4BH13io6mBS7WdxSy/IMW76Sf1Z
         nzog==
X-Forwarded-Encrypted: i=1; AJvYcCVgivwUTXKIeYZmTn6eyV5GExVhkWeNalM0iDn20DUoLRP/RA8TAr5NbZGTjB9We1xAYnklpsqf2vUutmflENGolLQldFO0zX8xCv0F3ybfrjyyjN/jbQLQ9wzHSOFoUrj6GjcLjpsZS9gnfPkv2goFPi2idY7YmETnP+H9VqtXqLjM
X-Gm-Message-State: AOJu0YyfvS785RvpKxpWBzdn7b9kMSqEJEYDg4XhXrF1u3vl2yRLJvpD
	ODv8FVh3ib2iDQkDIYyL+9Pyu9wcorXnUv2nl3kUas52rDl98R9GazivoVADMk7UXZMsp8Y8Co7
	/5ObXMBeeR9pDnPCawCg7VI8/2R0=
X-Google-Smtp-Source: AGHT+IEH6RWi44HaYQZCtjAKZvTHcH6VPvbJHSFdtTUFD5tvlEOWaGUQvp5fgB7LeQzj0zd7GSq7omX92zNzaIeDwsc=
X-Received: by 2002:a05:600c:470f:b0:426:5e32:4857 with SMTP id
 5b1f17b1804b1-429dcfe4b40mr2984495e9.0.1723566548086; Tue, 13 Aug 2024
 09:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813151752.95161-2-thorsten.blum@toblux.com>
In-Reply-To: <20240813151752.95161-2-thorsten.blum@toblux.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Aug 2024 09:28:56 -0700
Message-ID: <CAADnVQKEgG5bXvLMLYupAZO6xahWHU7mc06KFfseNoYUvoJbRQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Annotate struct bpf_cand_cache with __counted_by()
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 8:19=E2=80=AFAM Thorsten Blum <thorsten.blum@toblux=
.com> wrote:
>
> Add the __counted_by compiler attribute to the flexible array member
> cands to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
>
> Increment cnt before adding a new struct to the cands array.

why? What happens otherwise?

>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  kernel/bpf/btf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 520f49f422fe..42bc70a56fcd 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7240,7 +7240,7 @@ struct bpf_cand_cache {
>         struct {
>                 const struct btf *btf;
>                 u32 id;
> -       } cands[];
> +       } cands[] __counted_by(cnt);
>  };
>
>  static DEFINE_MUTEX(cand_cache_mutex);
> @@ -8784,9 +8784,9 @@ bpf_core_add_cands(struct bpf_cand_cache *cands, co=
nst struct btf *targ_btf,
>                 memcpy(new_cands, cands, sizeof_cands(cands->cnt));
>                 bpf_free_cands(cands);
>                 cands =3D new_cands;
> -               cands->cands[cands->cnt].btf =3D targ_btf;
> -               cands->cands[cands->cnt].id =3D i;
>                 cands->cnt++;
> +               cands->cands[cands->cnt - 1].btf =3D targ_btf;
> +               cands->cands[cands->cnt - 1].id =3D i;
>         }
>         return cands;
>  }
> --
> 2.46.0
>

