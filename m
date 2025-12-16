Return-Path: <bpf+bounces-76775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA81CC548D
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 23:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2EAB730019F7
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 22:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62133271F2;
	Tue, 16 Dec 2025 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmlJIihd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8D233A6FE
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765922429; cv=none; b=NMit5IMVHAMvVf9JBzXS/egoSrGkACUsnEELxQmtKEIvhnq8d5Use43fuqW8U4oQMzW75BotqsqAW3D6ARNcZMi+GLDWCM84nxBuV15MOR4EH7hBw3Wp5QXZkz6Fk6sNis/9KtxF+OPpOV6XCG8fr9YZ6LRggDvhGCS4hd8rwEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765922429; c=relaxed/simple;
	bh=LpXKGuOmQTlkXn4y6+rjvDSHyvJ7l1XuRSzmw2yQ0Yg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TXD1Ov25ZJlllOo0+jmBAHyBrFIhWqoScLiEt86YOO48KnfpfnGL94/mCaoiOAoaG/lMl9HcaIXhEZlAU1BBRkyinfNOulw3zI2zoNQyBo1Ht0msMmdbxaDdZX8Oddn1Ccb7JysRR4EemQb82mjN/dhI+xRqPvmfQDbY0HSWaao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmlJIihd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29f102b013fso62310585ad.2
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 14:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765922425; x=1766527225; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mFG3q3UcDNpgnUkWkSVTKwxTGVaZ3/mHhibJlT58Gnw=;
        b=FmlJIihdzPTuTIB8sON6E7Ml6gh21kpmwfRqPDEb031/qRYOHI24ocWxZcv+cdPcEN
         2HodGJ991txllPthVjdncahKZVSYOT7GvBy/g+n2Vh5nPbwnncJMAavyGynK3+n80K/D
         eEyVHsxGI8fsRmaGCq0XW1HcF5cKoMjDTGeKO39AKUAsR2wQod5j8/dt22qHDGAl8l34
         /xJjBCfDR9ESMpNKi6dz14d8noobWJvW88QxszRJFNBOgDYtAJFR2WhVqCpkbHAE8QED
         k+V5eG42bgwB36It3rGc2Sa3faotWXZNswxP9gyBjfEYVr+M1KH3oW2x1Tg6q7YwSH1E
         Z6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765922425; x=1766527225;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFG3q3UcDNpgnUkWkSVTKwxTGVaZ3/mHhibJlT58Gnw=;
        b=Uk675tS/lRjC1xJlgNshC3SVJ2ss+W0nPA8VZDfHkPiISnGjX64aR9BjgZ8d+ut0v/
         vUc3hMkkAmFBpvC+GodnQZ91j7rmAQvdPFIfb5jWcBvlRSMMMzA4e9ZsqNcerG7hxKz4
         qLvZc8JWk88x+0Mpojv0HbWz14lsLu8pp9+0RcimbkDVMmLfdU0F/Er26ZO0lEjjN7is
         Qznljd/KC2Yx7HDE9LNnQusF/J9cBcx2iRPqu+MG+COH89/O5TsQtvMOHayksL9vHOYm
         3k/IOjjBU4fBNey5gJ+4f5MCpXuJ6Yqtdd+dAUVGefS4zEZAOztPwbMM9vGOXaLHoazO
         fzTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpE+/v3kWTd4Bj2+uyAeYaHK9eQq4r4AZV4lA9rrFPK7p3GruIgJCeXD6ZvDEwhG8lru4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/5dGLHDhySUBLMBL2y5aPnfsoVJDBdfY/Ln4HY74nqQK/WfFd
	lDwAoGhTnS10SipU8slpI1/Fn6TEMSUVf/2A0Yf/xsJ3vA9+8iHjfEroTUASblDR
X-Gm-Gg: AY/fxX4qKO0ARVge64iBBAcEgTUOaSeHhQSW8OwdyWIXV1ogKtJqHnAkxMDvwOEEOaZ
	+AQJubZYudpwIcr4uv6yK8PLe+ec+u+/WnbluoO3fYIpg0xz3NfviWd1kB5knTUZCKNnlPb0H3x
	fmG1sLzd+UF0X8itmWbpB+A855DXy4AJHAXTtq3bwqAcuVekT/Wg458xHOP/2MIa0fuuSnavJR5
	F9HU5ZKF0jw2ZnkEi3uxtFFD1N/esveM4bIX1eYGu3KE6KqejCoZcDx/gybJRIQPOexPo9jAzIS
	yijkFksdtwRQFDFcQ9lsmPxg0Yb0qEkXan6X8QegZK7XfDO38Q8BySbyIRN/ZoMTurcceO4Gxrc
	VO4rHhoVYyEUnHGhR0WqOkHk1p/CygmJE5uo+WqJndp2MBF0vz3JM16I/R8wDRbyC4f1x/jUB41
	QUpw4xBmhW
X-Google-Smtp-Source: AGHT+IGsZhlVDzZigDdVekdNu1ba8f6ux1+/XWSPzpuHy3xGUg5eQV2LJdxR4PDWUoeJck9yGLtIWg==
X-Received: by 2002:a17:902:dac2:b0:2a0:98a2:3ccf with SMTP id d9443c01a7336-2a098a23ebdmr120494715ad.40.1765922424708;
        Tue, 16 Dec 2025 14:00:24 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a10e079277sm63267795ad.30.2025.12.16.14.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 14:00:24 -0800 (PST)
Message-ID: <3777b2f096877a9965a0fa6905fbabb06826d13f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v9 01/10] libbpf: Add BTF permutation support
 for type reordering
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Tue, 16 Dec 2025 14:00:21 -0800
In-Reply-To: <20251208062353.1702672-2-dolinux.peng@gmail.com>
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
	 <20251208062353.1702672-2-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-08 at 14:23 +0800, Donglin Peng wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>=20
> Introduce btf__permute() API to allow in-place rearrangement of BTF types=
.
> This function reorganizes BTF type order according to a provided array of
> type IDs, updating all type references to maintain consistency.
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

[...]

> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index cc01494d6210..ba67e5457e3a 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -281,6 +281,42 @@ LIBBPF_API int btf__dedup(struct btf *btf, const str=
uct btf_dedup_opts *opts);
>   */
>  LIBBPF_API int btf__relocate(struct btf *btf, const struct btf *base_btf=
);
> =20
> +struct btf_permute_opts {
> +	size_t sz;
> +	/* optional .BTF.ext info along the main BTF info */
> +	struct btf_ext *btf_ext;
> +	size_t :0;
> +};
> +#define btf_permute_opts__last_field btf_ext
> +
> +/**
> + * @brief **btf__permute()** performs in-place BTF type rearrangement
> + * @param btf BTF object to permute
> + * @param id_map Array mapping original type IDs to new IDs
> + * @param id_map_cnt Number of elements in @id_map
> + * @param opts Optional parameters for BTF extension updates
> + * @return 0 on success, negative error code on failure
> + *
> + * **btf__permute()** rearranges BTF types according to the specified ID=
 mapping.
> + * The @id_map array defines the new type ID for each original type ID.
> + *
> + * For **base BTF**:
> + * - @id_map must include all types from ID 1 to `btf__type_cnt(btf)-1`
> + * - @id_map_cnt should be `btf__type_cnt(btf) - 1`
> + * - Mapping uses `id_map[original_id - 1] =3D new_id`
> + *
> + * For **split BTF**:
> + * - @id_map should cover only split types
> + * - @id_map_cnt should be `btf__type_cnt(btf) - btf__type_cnt(btf__base=
_btf(btf))`
> + * - Mapping uses `id_map[original_id - btf__type_cnt(btf__base_btf(btf)=
)] =3D new_id`

Nit: internally the rule does not have special cases:

       id_map[original_id - start_id] =3D new_id

     So, maybe there is no need split these cases in the docstring?
     Otherwise it is not immediately clear that both cases are handled
     uniformly.

> + *
> + * On error, returns negative error code and sets errno:
> + *   - `-EINVAL`: Invalid parameters or ID mapping (duplicates, out-of-r=
ange)
> + *   - `-ENOMEM`: Memory allocation failure
> + */
> +LIBBPF_API int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map=
_cnt,
> +			    const struct btf_permute_opts *opts);
> +
>  struct btf_dump;
> =20
>  struct btf_dump_opts {
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 8ed8749907d4..b778e5a5d0a8 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -451,4 +451,5 @@ LIBBPF_1.7.0 {
>  	global:
>  		bpf_map__set_exclusive_program;
>  		bpf_map__exclusive_program;
> +		btf__permute;
>  } LIBBPF_1.6.0;

