Return-Path: <bpf+bounces-77049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A72CCDC78
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 23:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0568A301FC0D
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 22:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548C12F12BB;
	Thu, 18 Dec 2025 22:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jq0XViQ7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2882EC561
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766096514; cv=none; b=DyI/fHCzT3lv/W/+Krbb1MwOh9yGfi+KrEaPyyAYRxwyO9IC55AdbNhXERgAPX+9xp/XSvbc394rfoCciYVJUxfva7JBOyt4AIip5NQRNYs/hjY7DaqyLiH2Go02rM1hfpiACl+2+qvX4yBBxUP0cwQI7/+QiiaHIQNccSQ3bq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766096514; c=relaxed/simple;
	bh=/Ezioviutypmg+WMqOfqJaTRCXcEhsJJkVA/oyK3hMU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=trPioDsntMW8PIFFGEtCBXYYNk1bU/mLP3HKW6w0AKVIQ6kIykkDUvOViEcZxWszQRjDSiz6fAzwgLaLBqQPPNYU3+tKsXi9cSozzURjO1xyOQ6UiY8FW3qU/RRN7M6g6nkXzATg07uAbwWD8spswmYDkvTAubBhH4cNOHqPC4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jq0XViQ7; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c0c24d0f4ceso632106a12.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 14:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766096507; x=1766701307; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Efc046qbNC3P9us3ogii6ibq5RZYvqCH9sCzxOMoveI=;
        b=jq0XViQ7bhBJfZtImuOEDQ33uGc8khxDNv31OEEHPuBK0jPTVCRPktt/Ms93WLnwZD
         FduUdigEhafPmJZmzsXkHpTYXiAb0WntbCSTjXENuo2eVaQrzDEcv1hP0kDAs7P2sv1l
         KTmj7quWT/YobBzC29c8IzPFST3O+hYA7SbdP3kYLDH4QeAkSW6mDSCUTKWz40JN4hTf
         E9twQj2LL3lKk73Qj1M5Foi4yyvTPs79/21+O/KQkRIbtaW3k98pGjqMRugDyiKCDVDZ
         Ydz9l4TC9UEFrKpKqaCzce8lIa1Cm0K5+NdXeyUZyj7U496spcIw9XWn2XVF84ccbDhD
         0ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766096507; x=1766701307;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Efc046qbNC3P9us3ogii6ibq5RZYvqCH9sCzxOMoveI=;
        b=gZKiHbx6xmiJPSuaEtuIWn+Htco5pkgbkV0oe+dOZMy6TNjbdHkBhi2esVj1wh4IZw
         AImE9Cov6+Vn8PQzd3IYx2uerWrfyAXdBf7A6mBMfhVdtM/UCxFyNbMMLE58Ima4xfYN
         It0DmJA9ohTLXRNquCBoUSHjsLfLL2FNyPbrqApK0iRNYLYYr6u6plSLQ82Ux4YLLcTW
         ku8yLAlknNfFd2tcASsxGZP4M2MsBoqMweEqhJlF6B8KOrNkxP/zOZRjHED3jhEVmlQE
         6QoTeW0kvFqJUeDQ1yv2rNE9KpXtaj6z6/3vaXjerHymUnj3mdIvISyUAHLu27vZYf2f
         QYFw==
X-Forwarded-Encrypted: i=1; AJvYcCVebufJr2hu8O7Kb9+4VShoA319U3+bubOdt/mczg6fVGOPaaTkK9S8Ez3hjN8yQ99tN6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCA4M0OrPMpwNqD+b/WvdAQGczLJcCHrWqwkbSiatHo3fotCyN
	xOWs+Uih4QEnpGatk/OJotd81HVwgQMEkbKuRqAmpZmS43vB1UcCd2sF
X-Gm-Gg: AY/fxX6Wa81H/fJfeBwXu82uVWVCB9YTzMtzj5LxYJK9U3W1Gsrb7shgOJtNXP5XsuK
	zqE+Lol9p6U15janimFefLV1ICLk4sqTZwoK+N+NSRrIVhdD043CObPOMLUh35Hg0+ZM5XjjXuK
	DINFk/SklFKV5tbt8Z+e7cRWR73iCVxv+UT49BSg1KQgbGQUpCd3yEzBqHNin7pZ+vKQSR3SxtK
	E2NlK9r2aF/9rNXYFZOeWhlOjmykujmJXsU2ye/wOMAJ6b5fE6AogotE4igS+6MUzMLaSLa724K
	WQe4LlAzyaFK5JROu69BnA4W+p0LTsBXn0fV7gVFtA065pspjTg9HcmeSxRTiCaB4GLMjvQ3pNC
	/g3LcdLBCrXyWPHY9JAiazQ8Brjwn4X1b5fzzQ8WMsHnIhBQt9mlla5R9GKWE3o9RJCpzFQBs3X
	dvcvsJpHZlinUl2QnabsS7zwib37b3f4jeNcQU
X-Google-Smtp-Source: AGHT+IED7jsYoy8m0Jv0UOu6nQ2sIFS9HNLAix0LSpEDO8WIkd6BRijTogWfa/p+EZdjPvtmA0ssoQ==
X-Received: by 2002:a05:7300:e50f:b0:2ae:5e6e:bcbe with SMTP id 5a478bee46e88-2b05ea1b956mr903487eec.0.1766096506511;
        Thu, 18 Dec 2025 14:21:46 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4779:aa2b:e8ff:52c4? ([2620:10d:c090:500::5:3eff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ffd5f86sm1182521eec.5.2025.12.18.14.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 14:21:46 -0800 (PST)
Message-ID: <eede20e39fa1eb459e6e5174b5a8a5e3ba7db312.camel@gmail.com>
Subject: Re: [PATCH bpf-next v10 08/13] bpf: Skip anonymous types in type
 lookup for performance
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Thu, 18 Dec 2025 14:21:44 -0800
In-Reply-To: <20251218113051.455293-9-dolinux.peng@gmail.com>
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
	 <20251218113051.455293-9-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-18 at 19:30 +0800, Donglin Peng wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>=20
> Currently, vmlinux and kernel module BTFs are unconditionally
> sorted during the build phase, with named types placed at the
> end. Thus, anonymous types should be skipped when starting the
> search. In my vmlinux BTF, the number of anonymous types is
> 61,747, which means the loop count can be reduced by 61,747.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  include/linux/btf.h   |  1 +
>  kernel/bpf/btf.c      | 24 ++++++++++++++++++++----
>  kernel/bpf/verifier.c |  7 +------
>  3 files changed, 22 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index f06976ffb63f..2d28f2b22ae5 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -220,6 +220,7 @@ bool btf_is_module(const struct btf *btf);
>  bool btf_is_vmlinux(const struct btf *btf);
>  struct module *btf_try_get_module(const struct btf *btf);
>  u32 btf_nr_types(const struct btf *btf);
> +u32 btf_sorted_start_id(const struct btf *btf);
>  struct btf *btf_base_btf(const struct btf *btf);
>  bool btf_type_is_i32(const struct btf_type *t);
>  bool btf_type_is_i64(const struct btf_type *t);
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a9e2345558c0..3aeb4f00cbfe 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -550,6 +550,11 @@ u32 btf_nr_types(const struct btf *btf)
>  	return total;
>  }
> =20
> +u32 btf_sorted_start_id(const struct btf *btf)

Nit: the name is a bit confusing, given that it not always returns the
     start id for sorted part. btf_maybe_first_named_id?
     Can't figure out a good name :(

> +{
> +	return btf->sorted_start_id ?: (btf->start_id ?: 1);
> +}
> +
>  /*
>   * Assuming that types are sorted by name in ascending order.
>   */

[...]

