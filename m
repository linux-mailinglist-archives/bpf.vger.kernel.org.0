Return-Path: <bpf+bounces-71615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBFCBF82D6
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 20:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE17118C0A7D
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 18:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1469134FF71;
	Tue, 21 Oct 2025 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw7kh3Hm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043891A2392
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761073147; cv=none; b=ZDouavIFbcv7FU+n+tHAfxcVPKE0EY3sONVMBLJJNGWYOk0iUnWmBC4MjoTYt4C8PMM1eCZHiu52Vn6j71ZSTuL7BCw7yIX0S3uD2ZKFv8QfL6nfXDzxUsA/5SQuEGR+iM0PHT6Egilpnyt/MS/dvlNvnU+J0dpFcI8QYBpg3uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761073147; c=relaxed/simple;
	bh=SvaklC7Xo8EDNsJtw3DLvLfCVDUwxQTDXVLProv/b+k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iAv/lNwtsTzmjNGLTAtYmKwef5LWtT4UR4Ik4shqD1msgRTSPwqGDH0L2XKwcZxp10xY1yIV1yOjYdheob5cziFe9bGMZVx8stZqNoujnVG4EqWlDCL9925LRx/Yac3XVt9Z9HPpRQw30LmH3Wcqq+I7uY4eGJIvmatxZXyroTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw7kh3Hm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27ee41e0798so94700645ad.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 11:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761073144; x=1761677944; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DpvzDhvoU2M65ZmoJi4ZoCYkJD7PD7GjWLLYJ1Tpgfk=;
        b=Rw7kh3Hmh9HnBlSoC7wk+Q76OdF1WorUM2+2jqF4Ocks5fMzt1dRJX1N1qw6UdRGuM
         Kv/UcoswVjaKR+6QEvnuTvhZ8p/UCfireGhNpq9cRsieJC0+VUU70+TT+irrGaL7oAK0
         UDxHDyuti0ZKJjsUhxR3ncei6zl/iduMH3+zAN2J2CG53FTgiCxk2DHfWRKPBY6pi2Jt
         YY/WOvi6mXpj9J7pxFdxxJGoKCFAqDq0iZXkodE13wRBLe0IQkQ2x/dqD5AKF3Tz4s+t
         DX3tZmVykReHY8Axxb0gJZ0p/5TaFdPd+lejBxUwc8mdpOC6mdY3NMUT4UWnAbx34BGJ
         mgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761073144; x=1761677944;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DpvzDhvoU2M65ZmoJi4ZoCYkJD7PD7GjWLLYJ1Tpgfk=;
        b=KWzxZEw1ThgVi5VQ0pWWKK90Vqh2URbzEDxF0EZGr4rz+cT/yHcuIY6s4VXXjYvu95
         Cxk05EGs6oFpbSNtd9MNJvSRnvgRwcuJPXtZIHScbIGrwCIrNGbBckWz7VAD6mFvH6SZ
         CAd9aGmKAa094zG4Q1VmHQkjstDtaK7icuJMZeCD5Xvk8+PWngoXP5rDp6pbkZm9y+b+
         ft+p/pEuJpfE5/rsAz6qRERjQQMUuIcRiR258l906jJOd6mYFzizT5jDXnPjxhm/3PDu
         Z7kfq/0ZrcX3NVBXjhfRB3s9tmeUKUz2hUE1If3kor1Sp5cVRA9wHSzNofepLQD5YZ91
         ChGA==
X-Forwarded-Encrypted: i=1; AJvYcCURNR/6w2yx0JmZlxSgh9SlLBUdi24o3WCjBt36BVFqsAXuUzDcRnwnPYGwZi0eyvHrhoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0dvx2QA4m3asD88m7C4AHjCxtOeH1ziKJsqfDhkp2wTkeFYfn
	Dib/lvTqTeGR+2Ue3d0KbdF46wwsQ2Yf/kthpiGIp1OWqQC8GJU+shjoGFrcp6AA
X-Gm-Gg: ASbGncsEc38txvcCv0N71cHtfAZ7kyxQvsBOMQRs/V3Crdix5k/FfctE0U+CYjMwjXr
	OE9HhZCC/S5XT5CSRxBUaT1q/Nbbwok7L4GJ4+VZ0qlfriF3x9vYnDlaWSJg77Oy/3h0dAJlKNc
	VqD2Vp/grCrvMlAQqphLBmGn1Booi3eNkRuEDPtagAOGJURiGV43eK6ng6hao25J5rav8bjervI
	dlmIKkNmIeNCHxe2UzyYJwoEnJC8tOlOWp1spcGbMFh16EvAUE7rqoprRzYKZahRX9OWBbp1lrQ
	djJAO0PM6wCMk5jKmXM7YYCXr4d0RouJU2FxmWodL9iZMS14nJPxtpIU1ZhK6b6RHukiMl2yrbk
	OJ14eg3x6ZspECcBtZLXojGmgkjLmOaj/mBe6JN7ZCpclf3WrR3TLqJJTHPGHIbD4vqqE6/jRRq
	6sVWNNdktsBPc1g4BCNmnlX0gQDzjrAW/ndHw=
X-Google-Smtp-Source: AGHT+IFM1Sv7pueAX0mJuGk+YeBWnEIy4IDBNdXGy6e5V0s5fSWeD6Ur7nkUrpj/+CR7hnMdY1emiA==
X-Received: by 2002:a17:902:d508:b0:28a:2e51:9272 with SMTP id d9443c01a7336-290cbc3f200mr259202015ad.48.1761073144106;
        Tue, 21 Oct 2025 11:59:04 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:84fc:875:6946:cc56? ([2620:10d:c090:500::7:6bbb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292472197e9sm116891535ad.116.2025.10.21.11.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:59:03 -0700 (PDT)
Message-ID: <174642a334760af39a5e7bacdd8b977b392a82c7.camel@gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to
 enable binary search
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song
 Liu	 <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Date: Tue, 21 Oct 2025 11:59:02 -0700
In-Reply-To: <20251020093941.548058-3-dolinux.peng@gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
	 <20251020093941.548058-3-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
> This patch implements sorting of BTF types by their kind and name,
> enabling the use of binary search for type lookups.
>=20
> To share logic between kernel and libbpf, a new btf_sort.c file is
> introduced containing common sorting functionality.
>=20
> The sorting is performed during btf__dedup() when the new
> sort_by_kind_name option in btf_dedup_opts is enabled.

Do we really need this option?  Dedup is free to rearrange btf types
anyway, so why not sort always?  Is execution time a concern?

> For vmlinux and kernel module BTF, btf_check_sorted() verifies
> whether the types are sorted and binary search can be used.

[...]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index c414cf37e1bd..11b05f4eb07d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -259,6 +259,7 @@ struct btf {
>  	void *nohdr_data;
>  	struct btf_header hdr;
>  	u32 nr_types; /* includes VOID for base BTF */
> +	u32 nr_sorted_types;
>  	u32 types_size;
>  	u32 data_size;
>  	refcount_t refcnt;
> @@ -544,33 +545,29 @@ u32 btf_nr_types(const struct btf *btf)
>  	return total;
>  }
> =20
> -u32 btf_type_cnt(const struct btf *btf)
> +u32 btf_start_id(const struct btf *btf)
>  {
> -	return btf->start_id + btf->nr_types;
> +	return btf->start_id;
>  }
> =20
> -s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 ki=
nd)
> +u32 btf_nr_sorted_types(const struct btf *btf)
>  {
> -	const struct btf_type *t;
> -	const char *tname;
> -	u32 i, total;
> -
> -	do {
> -		total =3D btf_type_cnt(btf);
> -		for (i =3D btf->start_id; i < total; i++) {
> -			t =3D btf_type_by_id(btf, i);
> -			if (BTF_INFO_KIND(t->info) !=3D kind)
> -				continue;
> +	return btf->nr_sorted_types;
> +}
> =20
> -			tname =3D btf_name_by_offset(btf, t->name_off);
> -			if (!strcmp(tname, name))
> -				return i;
> -		}
> +void btf_set_nr_sorted_types(struct btf *btf, u32 nr)
> +{
> +	btf->nr_sorted_types =3D nr;
> +}
> =20
> -		btf =3D btf->base_btf;
> -	} while (btf);
> +u32 btf_type_cnt(const struct btf *btf)
> +{
> +	return btf->start_id + btf->nr_types;
> +}
> =20
> -	return -ENOENT;
> +s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 ki=
nd)
> +{
> +	return find_btf_by_name_kind(btf, 1, name, kind);
                                         ^^^
		nit: this will make it impossible to find "void" w/o a special case
		     in the find_btf_by_name_kind(), why not start from 0?
>  }
> =20
>  s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)

[...]

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 18907f0fcf9f..87e47f0b78ba 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[...]

> +/*
> + * Compact and sort BTF types.
> + *
> + * Similar to btf_dedup_compact_types, but additionally sorts the btf_ty=
pes.
> + */
> +static int btf__dedup_compact_and_sort_types(struct btf_dedup *d)
> +{

And this function will become btf__dedup_compact_types(),
if BTF will be always sorted. Thus removing some code duplication.

[...]

> diff --git a/tools/lib/bpf/btf_sort.c b/tools/lib/bpf/btf_sort.c
> new file mode 100644
> index 000000000000..2ad4a56f1c08
> --- /dev/null
> +++ b/tools/lib/bpf/btf_sort.c

[...]

> +/*
> + * Sort BTF types by kind and name in ascending order, placing named typ=
es
> + * before anonymous ones.
> + */
> +int btf_compare_type_kinds_names(const void *a, const void *b, void *pri=
v)
> +{
> +	struct btf *btf =3D (struct btf *)priv;
> +	struct btf_type *ta =3D btf_type_by_id(btf, *(__u32 *)a);
> +	struct btf_type *tb =3D btf_type_by_id(btf, *(__u32 *)b);
> +	const char *na, *nb;
> +	int ka, kb;
> +
> +	/* ta w/o name is greater than tb */
> +	if (!ta->name_off && tb->name_off)
> +		return 1;
> +	/* tb w/o name is smaller than ta */
> +	if (ta->name_off && !tb->name_off)
> +		return -1;
> +
> +	ka =3D btf_kind(ta);
> +	kb =3D btf_kind(tb);
> +	na =3D btf__str_by_offset(btf, ta->name_off);
> +	nb =3D btf__str_by_offset(btf, tb->name_off);
> +
> +	return cmp_btf_kind_name(ka, na, kb, nb);

If both types are anonymous and have the same kind, this will lead to
strcmp(NULL, NULL). On kernel side that would lead to null pointer
dereference.

> +}
> +
> +__s32 find_btf_by_name_kind(const struct btf *btf, int start_id,
> +				   const char *type_name, __u32 kind)

Nit: having functions with names btf_find_by_name_kind and
     	    	      	   	 find_btf_by_name_kind
     is very confusing.
     Usually we use names like __<func> for auxiliary functions
     like this.

> +{
> +	const struct btf_type *t;
> +	const char *tname;
> +	__u32 i, total;
> +
> +	if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
> +		return 0;
> +
> +	do {
> +		if (btf__nr_sorted_types(btf)) {
> +			/* binary search */
> +			__s32 start, end, mid, found =3D -1;
> +			int ret;
> +
> +			start =3D btf__start_id(btf);
> +			end =3D start + btf__nr_sorted_types(btf) - 1;
> +			/* found the leftmost btf_type that matches */
> +			while(start <=3D end) {
> +				mid =3D start + (end - start) / 2;
> +				t =3D btf_type_by_id(btf, mid);
> +				tname =3D btf__name_by_offset(btf, t->name_off);
> +				ret =3D cmp_btf_kind_name(BTF_INFO_KIND(t->info), tname,
> +							kind, type_name);
> +				if (ret =3D=3D 0)
> +					found =3D mid;
> +				if (ret < 0)
> +					start =3D mid + 1;
> +				else if (ret >=3D 0)
> +					end =3D mid - 1;
> +			}
> +
> +			if (found !=3D -1)
> +				return found;
> +		} else {
> +			/* linear search */
> +			total =3D btf__type_cnt(btf);
> +			for (i =3D btf__start_id(btf); i < total; i++) {
> +				t =3D btf_type_by_id(btf, i);
> +				if (btf_kind(t) !=3D kind)
> +					continue;
> +
> +				tname =3D btf__name_by_offset(btf, t->name_off);
> +				if (tname && !strcmp(tname, type_name))
> +					return i;
> +			}
> +		}
> +
> +		btf =3D btf__base_btf(btf);
> +	} while (btf && btf__start_id(btf) >=3D start_id);
> +
> +	return libbpf_err(-ENOENT);
> +}
> +
> +void btf_check_sorted(struct btf *btf, int start_id)
> +{
> +	const struct btf_type *t;
> +	int i, n, nr_sorted_types;
> +
> +	n =3D btf__type_cnt(btf);
> +	if ((n - start_id) < BTF_CHECK_SORT_THRESHOLD)
> +		return;

Are there any measurable performance benefits from having this special case=
?

> +
> +	n--;
> +	nr_sorted_types =3D 0;
> +	for (i =3D start_id; i < n; i++) {
> +		int k =3D i + 1;
> +
> +		t =3D btf_type_by_id(btf, i);
> +		if (!btf__str_by_offset(btf, t->name_off))
> +			return;

I am confused.
This effectively bans BTFs with anonymous types,
as btf__set_nr_sorted_types() wont be called if such types are found.
Anonymous types are very common, e.g. all FUNC_PROTO are anonymous.

> +
> +		t =3D btf_type_by_id(btf, k);
> +		if (!btf__str_by_offset(btf, t->name_off))
> +			return;
> +
> +		if (btf_compare_type_kinds_names(&i, &k, btf) > 0)
> +			return;
> +
> +		if (t->name_off)
> +			nr_sorted_types++;
> +	}
> +
> +	t =3D btf_type_by_id(btf, start_id);
> +	if (t->name_off)
> +		nr_sorted_types++;
> +	if (nr_sorted_types >=3D BTF_CHECK_SORT_THRESHOLD)
> +		btf__set_nr_sorted_types(btf, nr_sorted_types);
> +}
> +

[...]

