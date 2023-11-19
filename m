Return-Path: <bpf+bounces-15333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 315ED7F093E
	for <lists+bpf@lfdr.de>; Sun, 19 Nov 2023 22:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C641CB20A6C
	for <lists+bpf@lfdr.de>; Sun, 19 Nov 2023 21:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0581519BD6;
	Sun, 19 Nov 2023 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5xLKXQ9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC8E107;
	Sun, 19 Nov 2023 13:58:15 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32f7c80ab33so2479447f8f.0;
        Sun, 19 Nov 2023 13:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700431093; x=1701035893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DHInlKAixtjHWpCSSb9nsEcmRnYPF01P98gw/ou6aY=;
        b=X5xLKXQ9sYzakXg8w1uPp7vdZ5El/h0D46ilttHnXh+8BTxaR7w4d8UU8FkVglEAhc
         0Us/wGua7lDzVY5ahaa0gfFIcAkLAQ4XAOq+Gq2RAHhWdAO9wl6Jgyb7wvwAk/cL+HFY
         8FeTDioAu8PxECEqgDbLiD+uz0MjFvAZeJhAGI7S/CBE/iLbEOZnoJIug+6fd3Zpd0/D
         vr+x3rU0uADGzlfThOmjhj50xoTeeOzpytbfbTdKN7rbyaL2BGWpkrRp/0a6JBrGtkM9
         LGKneVx9SXMb2jT0X632aoYa4lrw1D/DvrpVE1oBAkGaalTY4YrJ7lNAkmoVxUrlQLqF
         kJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700431093; x=1701035893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DHInlKAixtjHWpCSSb9nsEcmRnYPF01P98gw/ou6aY=;
        b=lCE8ZSCg1JFUfyQxZD2ULa91apVzG+Gga/VyyDsgfje7tv45MFFgBlb8KpjqYuhmjh
         ctqmgashQmfjtQA+WXIUHfbJDfkGQS3266RQGtbC2qpCaAlmiL/nQoWujgNgehOOx3Ue
         FkAO+dnOsRKBt0UHnMsexPWMa5HUA1X9OYDcoDIrk1jVVRaoFfd2lAaVgQ3782IG1klc
         yXzsOgfQa10KFMa8/KmaPnyXM67+OD3OycalKKdQ6uLkyKx3zElGw0yFJHB7qiIXy1Aj
         Hm671XOwwqfSqXiGyt71G0Ii5gIC7GC31b5Iee2ijgLoOfsFlHsNu6cdqDk7fK/VnyZC
         WZXw==
X-Gm-Message-State: AOJu0Yz8d1EYQ/XFT1cSvMoCHnc1XJPVpLGyHC4J9cZ8rB90+xV6KUji
	HjHLN5iv5MDOkG+iY0lZ8FpkK+aW8Z8FyiYqG4lcU+6R
X-Google-Smtp-Source: AGHT+IGZM04mtNc46owlWHC1iRvF8ZmEk8CGAt5Ztp/xNz3uveCctVYkqYfV5uytJlgCfvg1hQigvUgo9oAIx9RePpY=
X-Received: by 2002:adf:fd86:0:b0:32d:857c:d51d with SMTP id
 d6-20020adffd86000000b0032d857cd51dmr3326047wrr.60.1700431093124; Sun, 19 Nov
 2023 13:58:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118225451.2132137-1-vadfed@meta.com> <20231118225451.2132137-2-vadfed@meta.com>
In-Reply-To: <20231118225451.2132137-2-vadfed@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 19 Nov 2023 13:58:01 -0800
Message-ID: <CAADnVQ+tLbMppLNT7HOV5=k+8075qjjyO5wWEDvLRoPi5WALJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] selftests: bpf: crypto skcipher algo selftests
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski <kuba@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Network Development <netdev@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2023 at 2:55=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com> w=
rote:
>
> +
> +SEC("fentry.s/bpf_fentry_test1")
> +int BPF_PROG(skb_crypto_setup)
> +{
> +       struct bpf_crypto_lskcipher_ctx *cctx;
> +       struct bpf_dynptr key =3D {};
> +       int err =3D 0;
> +
> +       status =3D 0;
> +
> +       bpf_dynptr_from_mem(crypto_key, sizeof(crypto_key), 0, &key);
> +       cctx =3D bpf_crypto_lskcipher_ctx_create(crypto_algo, &key, &err)=
;

Direct string will work here, right?
What's the reason to use global var?

