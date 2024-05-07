Return-Path: <bpf+bounces-28898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418E68BE9A9
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07DD281A9F
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFF016C6B0;
	Tue,  7 May 2024 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfXIvXXT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5696161331
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100509; cv=none; b=B057ZLAiNChCgqIlZ4ElNqZDsbQZ4xTooH2gaRsZCnRjkpbVbxKEUg4Kc7wYZHF1KC+9P08nsC5RpwMKJTvg5L/NeP9NDEV8as2hqMfOf7V9b/02c+bgQs1wPTOe2I667Dty022o3wg1TIs3kx3TogdOGZC9QDStOdyRCJOm80k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100509; c=relaxed/simple;
	bh=AyfLgwArcIROzxC/2C3UsbtZN0Jwkmmc8u1mT/ISh7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyjboONapm78s477pbRjmCEJTFAtFoTCroBvU2IUXSupvzjfp/NCht2tbUGLbEx40/CBjm5rTlhuc6gmH96SHo/LCwC0jlaHXdd7gXUoBJzrYyqDkj3Gklz/rT+NiNtakxprVBzUVa1UkGznDAMPXeJ6PHK15Rr4rIL5BdU4fHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfXIvXXT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2b4a7671abaso2263529a91.0
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715100507; x=1715705307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iBpwAq45Ygo1jdY3x73Zg1y2tSiP5KlHqNYPnT/bv8=;
        b=TfXIvXXTdkj12vZ26qRp6i5x45NclBPZ8P0VMDoy61vE1jDNgoYXMoqNuAQEns18ZF
         /kpOP/7WSn4cye0pKBHgEDgtVRP+TjMjX8iyGansJ1DO7rBQ/Oy8h6Hv9EBRS0TFRDCi
         QNRA6izst0haMJGBYyBNeJztYZyCm3WIGRncdPQoiCMBwQ3icYAk5PDEi49iMqWhzN9i
         oY0gPGjjfMoPsHByC0g24tj1fscyfCu/gML4jn3asGKLDop5gh6pvl/8kJO+SLdn+ps6
         MmNo/e3BGahV2Odip8zpa/rmdo5WpjlAzX+GMaAyqbIQOd+CrmG5fSH/UTUGEM8Bstzy
         39GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715100507; x=1715705307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iBpwAq45Ygo1jdY3x73Zg1y2tSiP5KlHqNYPnT/bv8=;
        b=uHNbVTtCmCR1txV1GeMZezOBWNzltS2ViqP1BHx1ykYTQJsLjjqXbUe4dWJ3/xCZrK
         Lqip/EaggekDnUr9cZ3aT7ffkX/vaAXTLmsMNu1sGmt5W9GaqidYLgXkKf4aE1K/HLAu
         J8G7cUzpbZG5ppeiiwGOTNk598ZnkvnT67dgXy5XtmK0Y5lRjxIkNvU5I8wuoPeCTjth
         I8Cc+lzJcdbe/G8IZnOFCD5FmVuPN7lMeH4rB0oxu1YdT/zVD/Ogb+JVjXEjqHR7FM1w
         e3KH4UKCdi2WU2FszXOdidHGKt7vilDNBzs8M1ZAsjkPH8AQrgQGTwfxxA9JRhQYkaqI
         U5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXLud7UrFwFNh8LFsyTpCzBZ2kNgA8s3jIfEt2HuDaZ7Hi0GzUJV7ZhsJ4AdpPlskD3CjcvAT3JurRToQOvH6JtP8yr
X-Gm-Message-State: AOJu0YweuFnYB6gVrolrqpXD9lwW8dSHJdzeGW98Yt9gVCJPLQ0VcqES
	9Gj/9eBfE5GK/XmjUMxKBXoPZlfeco669bDgoxfVp1JKYfKkJdbtOCSDr+XIR6I/8/JYaon2IDb
	WV4TpVAiF7KALcQxaRClLwKt7wok=
X-Google-Smtp-Source: AGHT+IHSzqcu54TzNpQS4qT/Njv7FuEP0Y6d9h3/1uAs4voNRI0kGeqmU1fMmnLYXOCE1532corNhq8VzxviV7PRnSE=
X-Received: by 2002:a17:90b:212:b0:2b3:28be:df00 with SMTP id
 98e67ed59e1d1-2b61649c518mr134942a91.4.1715100507029; Tue, 07 May 2024
 09:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507135514.490467-1-alan.maguire@oracle.com>
In-Reply-To: <20240507135514.490467-1-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 09:48:14 -0700
Message-ID: <CAEf4BzbWANm+Bf63hcFAB3Tn51tOeBLhyabV3NNz8tjaMnThjg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] kbuild,bpf: switch to using --btf_features
 for pahole v1.26 and later
To: Alan Maguire <alan.maguire@oracle.com>, Masahiro Yamada <masahiroy@kernel.org>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 6:55=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> The btf_features list can be used for pahole v1.26 and later -
> it is useful because if a feature is not yet implemented it will
> not exit with a failure message.  This will allow us to add feature
> requests to the pahole options without having to check pahole versions
> in future; if the version of pahole supports the feature it will be
> added.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  scripts/Makefile.btf | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index 82377e470aed..2d6e5ed9081e 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -3,6 +3,8 @@
>  pahole-ver :=3D $(CONFIG_PAHOLE_VERSION)
>  pahole-flags-y :=3D
>
> +ifeq ($(call test-le, $(pahole-ver), 125),y)
> +
>  # pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
>  ifeq ($(call test-le, $(pahole-ver), 121),y)
>  pahole-flags-$(call test-ge, $(pahole-ver), 118)       +=3D --skip_encod=
ing_btf_vars
> @@ -12,8 +14,17 @@ pahole-flags-$(call test-ge, $(pahole-ver), 121)     +=
=3D --btf_gen_floats
>
>  pahole-flags-$(call test-ge, $(pahole-ver), 122)       +=3D -j
>
> -pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=3D --lang_exclu=
de=3Drust
> +ifeq ($(pahole-ver), 125)

it's a bit of a scope creep, but isn't it strange that we don't have
test-eq and have to work-around that with more verbose constructs?
Let's do a good service to the community and add test-eq (and maybe
test-ne while at it, don't know, up to Masahiro)?

Overall the change looks OK to me, so if people are opposed to adding
test-eq, I'm fine with it as well:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> +pahole-flags-y +=3D --skip_encoding_btf_inconsistent_proto --btf_gen_opt=
imized
> +endif
> +
> +else
>
> -pahole-flags-$(call test-ge, $(pahole-ver), 125)       +=3D --skip_encod=
ing_btf_inconsistent_proto --btf_gen_optimized
> +# Switch to using --btf_features for v1.26 and later.
> +pahole-flags-$(call test-ge, $(pahole-ver), 126)  =3D -j --btf_features=
=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consisten=
t_func
> +
> +endif
> +
> +pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=3D --lang_exclu=
de=3Drust
>
>  export PAHOLE_FLAGS :=3D $(pahole-flags-y)
> --
> 2.39.3
>

