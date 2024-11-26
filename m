Return-Path: <bpf+bounces-45610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9F19D8FFC
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 02:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7322A288A40
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 01:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D571C2ED;
	Tue, 26 Nov 2024 01:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rjy/Ar9T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75611372
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732584697; cv=none; b=VVqZptq4kXmIV7yez8gIJG4TGQ3cuKlfhTK/kc7d/LkS7m6O34U/S0HKvGIRy9T/SKzEN6XNUzbLuEeCvBFufg1e6S6l5056I96qxB9yTm1wDaOyVj0Oueu2gcUOZwf9POMHlMpENHamZ6mq64pMip41aMnRyxlPJyrOyWfhp8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732584697; c=relaxed/simple;
	bh=SiO1XMU61c6M1IoaqYf/La/msoY20zd7V3OVPHqb0kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sECCEe9b2wMdbMd8SWgtSUhaFE0N9Qf8MOu/AWLgsL33cZM38Wx6CuROXezV8TLCqZ+V28qhwj2PQ0zisYfKwPeGsuPR7e7zogiDrzJkwt8e6MO2upMsqQ5m2rwH8lIizQInGWM41YB/gABZEgJMrp7FKcM95R86reZUesxFMQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rjy/Ar9T; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so7866755e9.3
        for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 17:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732584694; x=1733189494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8lPwoyKVTjhvHUlBNU/idkTbz7Lu11WiN2aHhYXcac=;
        b=Rjy/Ar9TZ8JEjCN3pWT2WUFXvFGMpKLQ7JpBYYUniIFKiaGB9CbQuaxcSj6tFfPWOi
         /VU058L9YxdxbJktrQc/fdyQIi5oIeNZxkPIPgCQAbNWJ6LkN4orBWH4KQR0Jf+1XTYR
         47fQDUxfeDEYgVLgeN3rSgyZT7sJWYBcTau4fKz0u3JjEtRlwbKrUBq1ubHjU3DwuRf8
         mBcSaDeK0vtQZETYAbg5X5ic9oNm7KBvCrZNVh/8OJBf44ZeM/GQ0NvcBVGcPQAqHRE0
         yU9SpLFcrVEgiHNQeZUVGvIMsTnipzfpozPad/HQ4yBqHBzBdDPUDfy87ArNecYDFsh3
         QL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732584694; x=1733189494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8lPwoyKVTjhvHUlBNU/idkTbz7Lu11WiN2aHhYXcac=;
        b=BPh8NZedhuYJ6eHx/Im1L+MAaGDrhpJvv6b3HhohL6mMzz3SgaYKna7xwC4RuOajfN
         +1YkVxw81HASXMEuaAYznnXpN6ZJmikKE2cNfFq34UB14jIeKxraEiwzfWGwdsFquY/S
         QHqAA+ZScLPcPS/ZcFxMLAZzidHaaBlYtUBwHa4pZsPhTqZMkknK1dfld0CMMsvfjb1j
         v9xsMcX5P44NDCW/nf6S3OlqzC1QfSRWYnh03vO8F0eFM7zYkT15W3wVucaE8DJBncoq
         YHcv0Lq0Ptu0U8saul3ydyMvMF/Y2k2OUWFKUF72i3apUfiPeQ3a9BUMGvRpxn9VbpBD
         zcpA==
X-Gm-Message-State: AOJu0YyadQ2yrwqWkpZGTdaFESW4hyYk0r3Qc4PXHPsd9iIC4JBGBBJo
	oo3UJuR/++u4K3qVwgqSEVVgvPpRYVIQnRvSsYgTkq0IA2YEETkw9ZI1cpcdk89akAoamWmAn4K
	mZM7m5E4MOQFJmgmYHf4/JtuS4wKtfbpV
X-Gm-Gg: ASbGncv5PX26r4iKOGlSAB3UQxFOyUk94wP1AKv3W21d61YbV3S2wEFkf/SqYCgdlG3
	1uHIz+6PGSmja+iAw98ilvG0yYBrs7txYArbIp65f1D6p8g4=
X-Google-Smtp-Source: AGHT+IEq5wJbcce/AjuVm2h9CJGkmMhKE5Q7NFJeN6qWeNQDylKkrUCROQOb9Q8t2OtPl1QZZ4RgrYsMLUEslyO0Gyk=
X-Received: by 2002:a05:600c:364d:b0:434:9f0d:3823 with SMTP id
 5b1f17b1804b1-4349f0d3964mr56214355e9.9.1732584693399; Mon, 25 Nov 2024
 17:31:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119101552.505650-1-aspsk@isovalent.com> <20241119101552.505650-2-aspsk@isovalent.com>
In-Reply-To: <20241119101552.505650-2-aspsk@isovalent.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Nov 2024 17:31:22 -0800
Message-ID: <CAADnVQ+MdboMD8SGyx2xSbJ3+YL2HgwKAZvj+S49G3x0gqKLXw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/6] bpf: add a __btf_get_by_fd helper
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 2:17=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> Add a new helper to get a pointer to a struct btf from a file
> descriptor which doesn't increase a refcount.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  include/linux/btf.h | 13 +++++++++++++
>  kernel/bpf/btf.c    | 13 ++++---------
>  2 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 4214e76c9168..050051a578a8 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -4,6 +4,7 @@
>  #ifndef _LINUX_BTF_H
>  #define _LINUX_BTF_H 1
>
> +#include <linux/file.h>
>  #include <linux/types.h>
>  #include <linux/bpfptr.h>
>  #include <linux/bsearch.h>
> @@ -143,6 +144,18 @@ void btf_get(struct btf *btf);
>  void btf_put(struct btf *btf);
>  const struct btf_header *btf_header(const struct btf *btf);
>  int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_sz)=
;
> +
> +static inline struct btf *__btf_get_by_fd(struct fd f)
> +{
> +       if (fd_empty(f))
> +               return ERR_PTR(-EBADF);
> +
> +       if (unlikely(fd_file(f)->f_op !=3D &btf_fops))
> +               return ERR_PTR(-EINVAL);
> +
> +       return fd_file(f)->private_data;
> +}

Maybe let's call it __btf_get() and place it next to __bpf_map_get() ?
So names and function bodies are directly comparable?

