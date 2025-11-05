Return-Path: <bpf+bounces-73542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C90C2C33794
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 01:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2807A18C25D1
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 00:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCFB23536B;
	Wed,  5 Nov 2025 00:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6eZUR2+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2DA224AF3
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 00:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762302565; cv=none; b=PFq9zLDntT2cDRtq/ncOUwq4Uc9iO2ZSXnhpcRd75kscRJwF6hcCJk1kZpD53jh8t+e6YPpROOU3tCtc7pT6jwkZQWJyykmmSQ+FdVvQIe+whd6nD55xCJYIMcPJJtXUgtDhgyu6ajKlzhRP1ULtE0HeBTXHZzbhzx1tGpzAeYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762302565; c=relaxed/simple;
	bh=f5aIiFy5mSzEtHXYFs8wRFblnfTWk3IdBkJ2/t5G3Qg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K0gWE+n7ouEDB+yB3GPQw8zewSSiuLeHnGG181v/jjUYgSBm8u7/iWWiFamdhMoJLyD8bbmUGTaSk9oHakCxh4mqxUgsK1ijRe85yOj2BVc2KjxblixzNGO6swRu3D8KvIvYJZuHxJBr3NU+IWuSDxsPvheKu1k8pPpVlC7WdEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6eZUR2+; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso3439516a91.2
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 16:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762302563; x=1762907363; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hMhLnyIfG7UbkKgdpPmZtvjp99PUyucsrPbWxECJVAc=;
        b=U6eZUR2+7fKGnXSvEaLO60nR6gkubM58I9bV0UuE8Mk/zuwNRxlG4YpnTtnFLRpRW/
         gEprhj+xy1nIwcOjIdbaU3K1d2fXiPQt0hFQ+2D43Cu0bcMYv2q9vnqwPceTVEHUBGGR
         BzdwQVQtD6botKTfySSj9a3wWquk1uZhfwkxO9I0ozlmARd+LJcAL72+BDNgZMRjygjm
         18aJWB1t8+W1WTiFOIgxRI5JOheSOQra9FNMuM43l3KdluaEup1O5ae+z+0byQn0Hz1Q
         BnMBf+w1w1COTHJpyf09r1SKQp5exyFI9IQdhuRbfR6rW5VTu5EvYyKUCn/hUTvuYs+I
         3z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762302563; x=1762907363;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMhLnyIfG7UbkKgdpPmZtvjp99PUyucsrPbWxECJVAc=;
        b=Wx90tlcGAmJui4LnodVpe3RpCAZRzE0Rjog4BOI3TuX5J7rZzYBRGo5PO6cb/lw20t
         HTa37aYiASdDUhO/BxMMNeeqFyHdHi+qEio1LP1idWC1f7xJ5qqBLOvDKT2f/Mf7QS8Z
         5H+TUJ8FyjReqA/ZqDv6OzYs2O/RE9kZJGks+hNpsjpS3SWaGkczNV+F7Fagvsxhf6ZH
         FtscgWtu0bxmHfqOcdI2WSICSx1rBJM1QV4nj3B/PN3MJtxLckJqqRj8Hr25GYT7mUuK
         LV2JWurDaXW9O5cc9LgWysRe8QExIUK0mpVZ8/XUJmwdWek6EYgjBCwaH7XeyPpx8rWB
         Mt4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQ9BsoykKov0pD9pu7a4GmpfXXejD9hIlQIBpBAm/HoubBrLaDuintZvyMSSxc/u9Y/4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIlXxndsj9Uk1RaQGb963FCn6LCTaIpCQtGI0X3QUpsbbu/Gf/
	sHJ42VbeRDo0/eJA8HNU63AKt883CDRPxfdSAqBJ2myqEKXSb6nCllVH8Gerp13P
X-Gm-Gg: ASbGncvIP8gH1G7k+2ZX3xAjm4Hhl4r89jrT58LFMw1hFEkYeDuD3z5XxGZAKRBiA4n
	JYDphXZRZvc+vQMP8HMNY6oVBReO7Q7w0PEKgo5Xtp2VhcPDnFfsD7Y8i849yKFa0O62cz2n/Gd
	XGsQXW8DjsMp95xNVTw3vSyH6FqoeXNgx6dSZZfdbanCY8BxB8tg8en3g7hzvlyqCRsAAD+1PQR
	HW92VjhNjb4aIzIgZz35+NQgR16u6ArHT3DBYoxxUC2GUy3J3q3Mhb/7yBJ/oEIRZzJ+VTQ1Dnz
	y16jP7emh3lfVZEojxZeoeIYFmUbufrnGT0dOHtgJUbLBbZLjSse2EjFuYUe7Esw+cohEVmp2RX
	7cmCfATgKrTpHeDydeyNl2Mo4j3tVv44lyvO7/YvQEcZhBsNw86206hKJNEU971SZRBPjZhFaWi
	GmAy7wPjtbkhI8YbnG3llYEB3gjrJDx1/zzw==
X-Google-Smtp-Source: AGHT+IEur4L3kpgPLQKd1EkackNoAVMpsy7agVybkv3A/vREqnQw12q4zI6TWGxQu61ecJlnrazP+A==
X-Received: by 2002:a17:90b:6cf:b0:340:2a38:d45f with SMTP id 98e67ed59e1d1-341a6c5f60fmr1508831a91.16.1762302563233;
        Tue, 04 Nov 2025 16:29:23 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a9e845a4sm526091a91.21.2025.11.04.16.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 16:29:22 -0800 (PST)
Message-ID: <123fde84e56aaa2dcccc16a2eac00d0e28a0823e.camel@gmail.com>
Subject: Re: [RFC PATCH v4 4/7] libbpf: Implement lazy sorting validation
 for binary search optimization
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song
 Liu	 <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Date: Tue, 04 Nov 2025 16:29:21 -0800
In-Reply-To: <20251104134033.344807-5-dolinux.peng@gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
	 <20251104134033.344807-5-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 21:40 +0800, Donglin Peng wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>=20
> This patch adds lazy validation of BTF type ordering to determine if type=
s
> are sorted by name. The check is performed on first access and cached,
> enabling efficient binary search for sorted BTF while maintaining linear
> search fallback for unsorted cases.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
>  tools/lib/bpf/btf.c | 76 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 74 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 5af14304409c..0ee00cec5c05 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -26,6 +26,10 @@
> =20
>  #define BTF_MAX_NR_TYPES 0x7fffffffU
>  #define BTF_MAX_STR_OFFSET 0x7fffffffU
> +/* sort verification occurs lazily upon first btf_find_type_by_name_kind=
()
> + * call
> + */
> +#define BTF_NEED_SORT_CHECK ((__u32)-1)
> =20
>  static struct btf_type btf_void;
> =20
> @@ -96,6 +100,10 @@ struct btf {
>  	 *   - doesn't include special [0] void type;
>  	 *   - for split BTF counts number of sorted and named types added on
>  	 *     top of base BTF.
> +	 *   - BTF_NEED_SORT_CHECK value indicates sort validation will be perf=
ormed
> +	 *     on first call to btf_find_type_by_name_kind.
> +	 *   - zero value indicates applied sorting check with unsorted BTF or =
no
> +	 *     named types.

And this can be another flag.

>  	 */
>  	__u32 nr_sorted_types;
>  	/* if not NULL, points to the base BTF on top of which the current
> @@ -903,8 +911,67 @@ int btf__resolve_type(const struct btf *btf, __u32 t=
ype_id)
>  	return type_id;
>  }
> =20
> -/*
> - * Find BTF types with matching names within the [left, right] index ran=
ge.
> +static int btf_compare_type_names(const void *a, const void *b, void *pr=
iv)
> +{
> +	struct btf *btf =3D (struct btf *)priv;
> +	struct btf_type *ta =3D btf_type_by_id(btf, *(__u32 *)a);
> +	struct btf_type *tb =3D btf_type_by_id(btf, *(__u32 *)b);
> +	const char *na, *nb;
> +	bool anon_a, anon_b;
> +
> +	na =3D btf__str_by_offset(btf, ta->name_off);
> +	nb =3D btf__str_by_offset(btf, tb->name_off);
> +	anon_a =3D str_is_empty(na);
> +	anon_b =3D str_is_empty(nb);
> +
> +	if (anon_a && !anon_b)
> +		return 1;
> +	if (!anon_a && anon_b)
> +		return -1;
> +	if (anon_a && anon_b)
> +		return 0;
> +
> +	return strcmp(na, nb);
> +}
> +
> +/* Verifies BTF type ordering by name and counts named types.
> + *
> + * Checks that types are sorted in ascending order with named types
> + * before anonymous ones. If verified, sets nr_sorted_types to the
> + * number of named types.
> + */
> +static void btf_check_sorted(struct btf *btf, int start_id)
> +{
> +	const struct btf_type *t;
> +	int i, n, nr_sorted_types;
> +
> +	if (likely(btf->nr_sorted_types !=3D BTF_NEED_SORT_CHECK))
> +		return;
> +	btf->nr_sorted_types =3D 0;
> +
> +	if (btf->nr_types < 2)
> +		return;
> +
> +	nr_sorted_types =3D 0;
> +	n =3D btf__type_cnt(btf);
> +	for (n--, i =3D start_id; i < n; i++) {
             ^^^
     why not -1 one line before?

> +		int k =3D i + 1;
> +
> +		if (btf_compare_type_names(&i, &k, btf) > 0)
> +			return;
> +		t =3D btf_type_by_id(btf, k);
> +		if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
> +			nr_sorted_types++;
> +	}
> +
> +	t =3D btf_type_by_id(btf, start_id);
> +	if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
> +		nr_sorted_types++;
> +	if (nr_sorted_types)
> +		btf->nr_sorted_types =3D nr_sorted_types;

I think that maintaining nr_sorted_types only for named types is an
unnecessary complication. Binary search will skip those anyway,
probably in one iteration.

> +}
> +
> +/* Find BTF types with matching names within the [left, right] index ran=
ge.
>   * On success, updates *left and *right to the boundaries of the matchin=
g range
>   * and returns the leftmost matching index.
>   */
> @@ -978,6 +1045,8 @@ static __s32 btf_find_type_by_name_kind(const struct=
 btf *btf, int start_id,
>  	}
> =20
>  	if (err =3D=3D -ENOENT) {
> +		btf_check_sorted((struct btf *)btf, btf->start_id);
> +
>  		if (btf->nr_sorted_types) {
>  			/* binary search */
>  			__s32 l, r;
> @@ -1102,6 +1171,7 @@ static struct btf *btf_new_empty(struct btf *base_b=
tf)
>  	btf->fd =3D -1;
>  	btf->ptr_sz =3D sizeof(void *);
>  	btf->swapped_endian =3D false;
> +	btf->nr_sorted_types =3D BTF_NEED_SORT_CHECK;
> =20
>  	if (base_btf) {
>  		btf->base_btf =3D base_btf;
> @@ -1153,6 +1223,7 @@ static struct btf *btf_new(const void *data, __u32 =
size, struct btf *base_btf, b
>  	btf->start_id =3D 1;
>  	btf->start_str_off =3D 0;
>  	btf->fd =3D -1;
> +	btf->nr_sorted_types =3D BTF_NEED_SORT_CHECK;
> =20
>  	if (base_btf) {
>  		btf->base_btf =3D base_btf;
> @@ -1811,6 +1882,7 @@ static void btf_invalidate_raw_data(struct btf *btf=
)
>  		free(btf->raw_data_swapped);
>  		btf->raw_data_swapped =3D NULL;
>  	}
> +	btf->nr_sorted_types =3D BTF_NEED_SORT_CHECK;
>  }
> =20
>  /* Ensure BTF is ready to be modified (by splitting into a three memory

