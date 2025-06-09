Return-Path: <bpf+bounces-60070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A028EAD247B
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 18:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D6907A2433
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9312C21ADCC;
	Mon,  9 Jun 2025 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkIYWu+E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5A91D9A5F;
	Mon,  9 Jun 2025 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488208; cv=none; b=Y/0anV92vUBbutze7cMYueTqFsqnF6aFKDrfg3/6GXCC+9ZBFiEcu4nqM+x8zX1eg5+izB4J/Kwxp186Ir1/vW49wFHYtoKnWWeixM4hdOUjcpP1kUqOJ0sLW1UtveIwPkNOpmw4cGkSzToVEM/UXJ8MifrFxQhCkF5nAuzqlZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488208; c=relaxed/simple;
	bh=3LtbqBbkiGyBjHqwHJdySON8o+kwZIS1rnVLMn2Kko4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tps4w4Ulbd0atMBTTCcAgVhXOPquQHSmlBKueoYzXdqGdWP45hONT4X0KpzEZ+9Tf4nEHD/kV6YVnwDQiV2jLzWI2vl11UVIo7Cn8JifB3yZmTKpgYnk8yaNjYmWHuNEpfdd7Lc7+P7l4J1zsMKvNJDf1uCInakmTPD0i2++YRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkIYWu+E; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d7b50815so39198465e9.2;
        Mon, 09 Jun 2025 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749488205; x=1750093005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEKBn359O9mr33CG8MceiNQqpL/noItwoksjNv7iYis=;
        b=TkIYWu+E7DadLdifNC3UM+KB8jSnAJdMMD42+hpMmFpnBLyRYbJqt4nN8TitR9/HyA
         H9PYZZQoqq9rUk5Ew/lbPde8FjI8sRsW10ektruzFw7ODvrIEiJGcD8JJIpNowLttDKl
         +fVdP3FvhSGTduolxLhKe9IfoX3eRyko9wNtau2+b/XOtBkLKLux0LROPq9wfvL6DMAc
         LcH8zvwXslC12EKuFOi5g6cz8Q38VU8sf/UnYS8si5P0g1in4EC/jCBA7/vZ3K04CfCC
         57mgjNAX0hO9C9gTA6Ua7HwdKEn2/GKQJ/RPP4SD94xK+7NKmGgjWG+twG/Sm+oYG045
         avzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749488205; x=1750093005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEKBn359O9mr33CG8MceiNQqpL/noItwoksjNv7iYis=;
        b=a/Uw9EG4s/ErxQaOVM7XK0Ygug0kZgXJu+xpDHaowPIVOdYkExFEmOyYMmM6SW0yRD
         MY/yClUWRz7uxA9v9MKBDFosaN5J2C8G6xbNJh58U/8LRSg4vwWjxmw2VMzQQbVocCxg
         wCNU2LukZQ9M/SA/1s3gdmynVX/XKnyR1+mVZb5yQR+RRPC2AxB5h6NUWGjgyRHXpbmB
         XHBcOvQMydVGjDq6TC+xLtP0IIE5wrctW2cWppEOBgggyb7Pjuyz6OTQVD+FmKeVWAVN
         kbr2voiFtyDkOW4yA3zlKL+q2wmtL5HdGaSO7NeLd/tPiZ3e5ikVgtoGyDlmtEAeD9JG
         hxcg==
X-Forwarded-Encrypted: i=1; AJvYcCXQIwuxjUAQ8/yKHquwVaLumD9ndZdIv96FdQq7upz9lR8gASuJoBQQnLTNL+C9WR8V2y6JrP0xVCBXqpPbCHhZOi8qCi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YziUkvf5fIc2/Z4KtFdKU6WkZpt66HoIWqtTmOxPUEP4babjM+N
	kY5fmO6h98DRy5XuG2nXlL5p53Ey1bWIkEm1ucJFUTCHO2B/XFoz/VjOrkJGakIV++RCkx/Kaux
	6T+MVR9wqt5AtQ0NFtNWrdoW/48cnos4=
X-Gm-Gg: ASbGncueTCwS+sYyeT7hKwUzLN62ZsjqZj/DcvBSX5fVpuIRMj//Zc2WiZdb7yPu6NC
	EtYkIMo5wM7xYnkFJO4160AsJe+4n3c2TTAHnbDiXCHXQw/74M4hXdKqBmvBMlOQmwsL8Kpdxme
	ott9L4Uvdarfn6PrPrQtLEhCWs2jJ52Ar6MKraCgjtIEj6SvB1SsDw8LBmuU0H2g==
X-Google-Smtp-Source: AGHT+IE5tR2B9YXXzFTeLm3U8oQQ7rc1H7LS56rqUvYeJrYiaepW2wsqQoRzFYFvshVVyTamFVC25LhZyxq/w1aj/WE=
X-Received: by 2002:a05:6000:40c7:b0:3a5:2653:734d with SMTP id
 ffacd0b85a97d-3a531cb8333mr11466966f8f.28.1749488204602; Mon, 09 Jun 2025
 09:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-2-kpsingh@kernel.org>
In-Reply-To: <20250606232914.317094-2-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Jun 2025 09:56:33 -0700
X-Gm-Features: AX0GCFtChgw-MK2fTqpAFYE-5cEEbvD3Vlnxk5O9ru09xt-jCLYTsZV1NWl8ieY
Message-ID: <CAADnVQKnG6PORcQMJNw2zWd4u5xFMugm=KSG4P4bLPBmuJ==jw@mail.gmail.com>
Subject: Re: [PATCH 01/12] bpf: Implement an internal helper for SHA256 hashing
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
>
> This patch introduces bpf_sha256, an internal helper function
> that wraps the standard kernel crypto API to compute SHA256 digests of
> the program insns and map content
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/bpf.h |  1 +
>  kernel/bpf/core.c   | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5b25d278409b..d5ae43b36e68 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2086,6 +2086,7 @@ static inline bool map_type_contains_progs(struct b=
pf_map *map)
>  }
>
>  bool bpf_prog_map_compatible(struct bpf_map *map, const struct bpf_prog =
*fp);
> +int bpf_sha256(u8 *data, size_t data_size, u8 *output_digest);
>  int bpf_prog_calc_tag(struct bpf_prog *fp);
>
>  const struct bpf_func_proto *bpf_get_trace_printk_proto(void);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index a3e571688421..607d5322ef94 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -17,6 +17,7 @@
>   * Kris Katterjohn - Added many additional checks in bpf_check_classic()
>   */
>
> +#include <crypto/hash.h>
>  #include <uapi/linux/btf.h>
>  #include <linux/filter.h>
>  #include <linux/skbuff.h>
> @@ -287,6 +288,44 @@ void __bpf_prog_free(struct bpf_prog *fp)
>         vfree(fp);
>  }
>
> +int bpf_sha256(u8 *data, size_t data_size, u8 *output_digest)
> +{
> +       struct crypto_shash *tfm;
> +       struct shash_desc *shash_desc;
> +       size_t desc_size;
> +       int ret =3D 0;
> +
> +       tfm =3D crypto_alloc_shash("sha256", 0, 0);

In kernel/bpf/Kconfig we use:
config BPF
        bool
        select CRYPTO_LIB_SHA1

I think it's fine to add "select CRYPTO_LIB_SHA256" in this patch,
and remove CRYPTO_LIB_SHA1 line in patch 2,
since the only user will be gone.

