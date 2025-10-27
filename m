Return-Path: <bpf+bounces-72362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD24C0FF69
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 19:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 131854F226F
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 18:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF56313531;
	Mon, 27 Oct 2025 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WU8A8Vv6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49915317711
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590429; cv=none; b=Vdj4x7PBTUYXTp/TI8ceTx4dbeZ3i8QBZGF1vrdbe1aQjiiI1z8v8uCqRw0GKHllTgf9JN26eZ6IKb6+3rEF9PgRYjkuQy8FyGTACzDnLkJ1bbDmnKMh8DRIaPS0vayQie4oRSkIu1ujmAgm5Kms8++DcVfaPzcmuUHGNvZX9Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590429; c=relaxed/simple;
	bh=w5KxVgRr3e+HKMqnL0mlpeCZQqaUsw/g9mNX4fLvGck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nhLD52v7spE3peh2DohMdqxW1z+gbb3F1i/SFU6yksfy11c/9ZLuFx4dTZ/f20XQxVvxEGC8L4chXh9erPjIFql2FGxj7rCjfKWtDpt/SI+qHGiQsUPz1UE7M+2nRsLvKOdSjMvaTDr47atWgvYIarfEg3WKkGU7BAtZpKov1tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WU8A8Vv6; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b55517e74e3so4617607a12.2
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 11:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761590426; x=1762195226; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gQlKf8vLkZj4zJyjmnZT1xVDVRltU5vGOgkpPqZX5gM=;
        b=WU8A8Vv6klRQUBe3STZJDMQa/vRLk9n3bs3qs4/GaLp5Azh1pCfnZHHCsRDdbSjKtc
         gkWLBxswdPmlpNXpOFPhR7f4/J9tRTAMOjqjk+EkU9o9VI3c8cdb5FsLiqpLD0IZexTU
         Z2IOtE7DYGC1tQTpjBKAX/TiageufLyHmL+E+ks8HgdAaaG7O+XxXa1avZWhVtWCv29k
         Dst2sjnQHirRMMW7vxE6m3uHBRwx0eNOMaQc63P3WyHx0M2kaIfOZrN7c4tac1mTMkbr
         lTJJBcW3GLbJzQYvJTv+PV5JRHHjQprVS1EgxJ0Mnf0Iq7sGcrTbStkUxKD+s2m9YFTr
         UptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761590426; x=1762195226;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQlKf8vLkZj4zJyjmnZT1xVDVRltU5vGOgkpPqZX5gM=;
        b=FQjnDAuAX2lYkyNEzx9FqDM1Y0WrdfqGr3KMmeFxzYHBQ0/Z74fdF0rMXUFHf89t/0
         CoOQJtgME7z7RvB8q3wEngJ1ukRV++VF5ZspHufhXejsylwWt5rFpwRgQFbcU0Lk2tas
         aZ9MJNIStH8sQpNrnCplRxccFwhHVW6mpoJQki2F4F2sKZSA/JaS3+XCsiG+mDRcMkSS
         JN/JbR3vqgz8XHDVwXY19IGz9EkUNyCt1Bo0t8+v1ZauiBrD5SkBEH4XOdotdMuSGxtZ
         w5a+IGdydImY+bT+eZiJVX/Ibl72xf7fRS4qLmUzu2RZio9hlZtVqlJccgaVmVY2bYRb
         s6+g==
X-Forwarded-Encrypted: i=1; AJvYcCVcbCRRB3sXE0QQS2rl3gO4jFkKg4bkNsEez2GGQXstblMfkegQlcHGQPRlsZRwzUtA+ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgXHxOB+u3qqIYLeclu8mujKUBsFdE7z9eoLs09cKKOEP+ANn/
	o2bEWNk6JdRB7aq4QI/2wB/ZIPaITNB66UXYXDD+iZb2Gf1m/dQF20F1
X-Gm-Gg: ASbGncvDU7eZwKV1xv1J++2CpzhMaYJ1NkyQ7/QLDBwYlZlQDjjJ9uzLeR/37BG0ICW
	9mpv0YBblDrvxyhvyESlTv6OlDWCYgG4Mx5908FDl3RKVWOPgqEFU9s2vF1LV+l9ZUpkuX5Ldgj
	3J4Z6gXgSNt1V91eHelTV1jJKYfn7dqE/ChbttG6XPl4ChPrmc2OgJW2W65GcAIJYYecO4AmVOY
	lPFkjuPxwwEdqj0AKeh7VRg9yFELhCgd0rsH74g3i3thiOQxfw6xfYKovYhi8dZCVhbh6pcOrzW
	4LRdVDEe/ZWVdQRstfof8n3PT6JVgO8CvuMRbdUU9DXfndkPOpY/2KSCtA/UDaa9ePfLLtUgf5d
	QDFKoISWD+LQCZMtRB8bzRZ/7dQJlapLwnYUX8Pz9AVzSklumdQcy8eukVarfSMDZmQNS0/XhFQ
	==
X-Google-Smtp-Source: AGHT+IHP4bEY/nxSKrhX7kyno5hOcbT92ZbbD4V8usAh7PoCI7LeXnix+Ike0Wg3iMoy007E8oTliQ==
X-Received: by 2002:a17:90b:288a:b0:330:6d5e:f174 with SMTP id 98e67ed59e1d1-34027bcb2f0mr875727a91.20.1761590426434;
        Mon, 27 Oct 2025 11:40:26 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3402942f298sm86823a91.5.2025.10.27.11.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:40:26 -0700 (PDT)
Message-ID: <b4258ba5ace4c422cdbcde659bb5304408aaec14.camel@gmail.com>
Subject: Re: [RFC PATCH v3 1/3] btf: implement BTF type sorting for
 accelerated lookups
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song
 Liu	 <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Date: Mon, 27 Oct 2025 11:40:23 -0700
In-Reply-To: <20251027135423.3098490-2-dolinux.peng@gmail.com>
References: <20251027135423.3098490-1-dolinux.peng@gmail.com>
	 <20251027135423.3098490-2-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-27 at 21:54 +0800, Donglin Peng wrote:
> This patch introduces a new libbpf interface btf__permute() to reorganize
> BTF types according to a provided mapping. The BTF lookup mechanism is
> enhanced with binary search capability, significantly improving lookup
> performance for large type sets.
>=20
> The pahole tool can invoke this interface with a sorted type ID array,
> enabling binary search in both user space and kernel. To share core logic
> between kernel and libbpf, common sorting functionality is implemented
> in a new btf_sort.c source file.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
> v2->v3:
> - Remove sorting logic from libbpf and provide a generic btf__permute() i=
nterface
> - Remove the search direction patch since sorted lookup provides sufficie=
nt performance
>   and changing search order could cause conflicts between BTF and base BT=
F
> - Include btf_sort.c directly in btf.c to reduce function call overhead
> ---


Could you please split this in two commits:
- one handling BTF sortedness
- another handling btf__permute()
?

>  tools/lib/bpf/btf.c            | 262 ++++++++++++++++++++++++++++++---
>  tools/lib/bpf/btf.h            |  17 +++
>  tools/lib/bpf/btf_sort.c       | 174 ++++++++++++++++++++++
>  tools/lib/bpf/btf_sort.h       |  11 ++
>  tools/lib/bpf/libbpf.map       |   6 +
>  tools/lib/bpf/libbpf_version.h |   2 +-
>  6 files changed, 447 insertions(+), 25 deletions(-)
>  create mode 100644 tools/lib/bpf/btf_sort.c
>  create mode 100644 tools/lib/bpf/btf_sort.h
>=20
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 18907f0fcf9f..d20bf81a21ce 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -23,6 +23,7 @@
>  #include "libbpf_internal.h"
>  #include "hashmap.h"
>  #include "strset.h"
> +#include "btf_sort.h"
> =20
>  #define BTF_MAX_NR_TYPES 0x7fffffffU
>  #define BTF_MAX_STR_OFFSET 0x7fffffffU
> @@ -92,6 +93,12 @@ struct btf {
>  	 *   - for split BTF counts number of types added on top of base BTF.
>  	 */
>  	__u32 nr_types;
> +	/* number of sorted and named types in this BTF instance:
> +	 *   - doesn't include special [0] void type;
> +	 *   - for split BTF counts number of sorted and named types added on
> +	 *     top of base BTF.
> +	 */
> +	__u32 nr_sorted_types;
>  	/* if not NULL, points to the base BTF on top of which the current
>  	 * split BTF is based
>  	 */
> @@ -624,6 +631,11 @@ const struct btf *btf__base_btf(const struct btf *bt=
f)
>  	return btf->base_btf;
>  }
> =20
> +__u32 btf__start_id(const struct btf *btf)
> +{
> +	return btf->start_id;
> +}
> +
>  /* internal helper returning non-const pointer to a type */
>  struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id)
>  {
> @@ -915,38 +927,16 @@ __s32 btf__find_by_name(const struct btf *btf, cons=
t char *type_name)
>  	return libbpf_err(-ENOENT);
>  }
> =20
> -static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
> -				   const char *type_name, __u32 kind)
> -{
> -	__u32 i, nr_types =3D btf__type_cnt(btf);
> -
> -	if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
> -		return 0;
> -
> -	for (i =3D start_id; i < nr_types; i++) {
> -		const struct btf_type *t =3D btf__type_by_id(btf, i);
> -		const char *name;
> -
> -		if (btf_kind(t) !=3D kind)
> -			continue;
> -		name =3D btf__name_by_offset(btf, t->name_off);
> -		if (name && !strcmp(type_name, name))
> -			return i;
> -	}
> -
> -	return libbpf_err(-ENOENT);
> -}
> -
>  __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type=
_name,
>  				 __u32 kind)
>  {
> -	return btf_find_by_name_kind(btf, btf->start_id, type_name, kind);
> +	return _btf_find_by_name_kind(btf, btf->start_id, type_name, kind);
>  }
> =20
>  __s32 btf__find_by_name_kind(const struct btf *btf, const char *type_nam=
e,
>  			     __u32 kind)
>  {
> -	return btf_find_by_name_kind(btf, 1, type_name, kind);
> +	return _btf_find_by_name_kind(btf, 1, type_name, kind);
>  }
> =20
>  static bool btf_is_modifiable(const struct btf *btf)
> @@ -1091,6 +1081,7 @@ static struct btf *btf_new(const void *data, __u32 =
size, struct btf *base_btf, b
>  	err =3D err ?: btf_sanity_check(btf);
>  	if (err)
>  		goto done;
> +	btf_check_sorted(btf, btf->start_id);
> =20
>  done:
>  	if (err) {
> @@ -1715,6 +1706,8 @@ static void btf_invalidate_raw_data(struct btf *btf=
)
>  		free(btf->raw_data_swapped);
>  		btf->raw_data_swapped =3D NULL;
>  	}
> +	if (btf->nr_sorted_types)
> +		btf->nr_sorted_types =3D 0;
>  }
> =20
>  /* Ensure BTF is ready to be modified (by splitting into a three memory
> @@ -5829,3 +5822,224 @@ int btf__relocate(struct btf *btf, const struct b=
tf *base_btf)
>  		btf->owns_base =3D false;
>  	return libbpf_err(err);
>  }
> +
> +struct btf_permute;
> +
> +static struct btf_permute *btf_permute_new(struct btf *btf, const struct=
 btf_permute_opts *opts);
> +static void btf_permute_free(struct btf_permute *p);
> +static int btf_permute_shuffle_types(struct btf_permute *p);
> +static int btf_permute_remap_types(struct btf_permute *p);
> +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx);
> +
> +/*
> + * Permute BTF types in-place using the ID mapping from btf_permute_opts=
->ids.
> + * After permutation, all type ID references are updated to reflect the =
new
> + * ordering. If a struct btf_ext (representing '.BTF.ext' section) is pr=
ovided,
> + * type ID references within the BTF extension data are also updated.
> + */
> +int btf__permute(struct btf *btf, const struct btf_permute_opts *opts)
> +{
> +	struct btf_permute *p;

Maybe allocate this on stack?
(Or just use btf_permute_opts directly and have 'map' as local variable?).

> +	int err =3D 0;
> +
> +	if (!OPTS_VALID(opts, btf_permute_opts))
> +		return libbpf_err(-EINVAL);
> +
> +	p =3D btf_permute_new(btf, opts);
> +	if (!p) {
> +		pr_debug("btf_permute_new failed: %ld\n", PTR_ERR(p));
> +		return libbpf_err(-EINVAL);
> +	}
> +
> +	if (btf_ensure_modifiable(btf)) {
> +		err =3D -ENOMEM;
> +		goto done;
> +	}
> +
> +	err =3D btf_permute_shuffle_types(p);
> +	if (err < 0) {
> +		pr_debug("btf_permute_shuffle_types failed: %s\n", errstr(err));
> +		goto done;
> +	}
> +	err =3D btf_permute_remap_types(p);
> +	if (err) {
> +		pr_debug("btf_permute_remap_types failed: %s\n", errstr(err));
> +		goto done;
> +	}
> +
> +done:
> +	btf_permute_free(p);
> +	return libbpf_err(err);
> +}
> +
> +struct btf_permute {
> +	/* .BTF section to be permuted in-place */
> +	struct btf *btf;
> +	struct btf_ext *btf_ext;
> +	/* Array of type IDs used for permutation. The array length must equal
> +	 * the number of types in the BTF being permuted, excluding the special
> +	 * void type at ID 0. For split BTF, the length corresponds to the
> +	 * number of types added on top of the base BTF.
> +	 */
> +	__u32 *ids;
> +	/* Array of type IDs used to map from original type ID to a new permute=
d
> +	 * type ID, its length equals to the above ids */
> +	__u32 *map;
> +};
> +
> +static struct btf_permute *btf_permute_new(struct btf *btf, const struct=
 btf_permute_opts *opts)
> +{
> +	struct btf_permute *p =3D calloc(1, sizeof(struct btf_permute));
> +	__u32 *map;
> +	int err =3D 0;
> +
> +	if (!p)
> +		return ERR_PTR(-ENOMEM);
> +
> +	p->btf =3D btf;
> +	p->btf_ext =3D OPTS_GET(opts, btf_ext, NULL);
> +	p->ids =3D OPTS_GET(opts, ids, NULL);
> +	if (!p->ids) {
> +		err =3D -EINVAL;
> +		goto done;
> +	}
> +
> +	map =3D calloc(btf->nr_types, sizeof(*map));
> +	if (!map) {
> +		err =3D -ENOMEM;
> +		goto done;
> +	}
> +	p->map =3D map;
> +
> +done:
> +	if (err) {
> +		btf_permute_free(p);
> +		return ERR_PTR(err);
> +	}
> +
> +	return p;
> +}
> +
> +static void btf_permute_free(struct btf_permute *p)
> +{
> +	if (p->map) {
> +		free(p->map);
> +		p->map =3D NULL;
> +	}
> +	free(p);
> +}
> +
> +/*
> + * Shuffle BTF types.
> + *
> + * Rearranges types according to the permutation map in p->ids. The p->m=
ap
> + * array stores the mapping from original type IDs to new shuffled IDs,
> + * which is used in the next phase to update type references.
> + */
> +static int btf_permute_shuffle_types(struct btf_permute *p)
> +{
> +	struct btf *btf =3D p->btf;
> +	const struct btf_type *t;
> +	__u32 *new_offs =3D NULL;
> +	void *l, *new_types =3D NULL;
> +	int i, id, len, err;
> +
> +	new_offs =3D calloc(btf->nr_types, sizeof(*new_offs));
> +	new_types =3D calloc(btf->hdr->type_len, 1);
> +	if (!new_types || !new_offs) {
> +		err =3D -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	l =3D new_types;
> +	for (i =3D 0; i < btf->nr_types; i++) {
> +		id =3D p->ids[i];
> +		t =3D btf__type_by_id(btf, id);
> +		len =3D btf_type_size(t);
> +		memcpy(l, t, len);
> +		new_offs[i] =3D l - new_types;
> +		p->map[id - btf->start_id] =3D btf->start_id + i;
> +		l +=3D len;
> +	}
> +
> +	free(btf->types_data);
> +	free(btf->type_offs);
> +	btf->types_data =3D new_types;
> +	btf->type_offs =3D new_offs;
> +	return 0;
> +
> +out_err:
> +	return err;
> +}
> +
> +/*
> + * Remap referenced type IDs into permuted type IDs.
> + *
> + * After BTF types are permuted, their final type IDs may differ from or=
iginal
> + * ones. The map from original to a corresponding permuted type ID is st=
ored
> + * in btf_permute->map and is populated during shuffle phase. During rem=
apping
> + * phase we are rewriting all type IDs  referenced from any BTF type (e.=
g.,
> + * struct fields, func proto args, etc) to their final deduped type IDs.
> + */
> +static int btf_permute_remap_types(struct btf_permute *p)
> +{
> +	struct btf *btf =3D p->btf;
> +	int i, r;
> +
> +	for (i =3D 0; i < btf->nr_types; i++) {
> +		struct btf_type *t =3D btf_type_by_id(btf, btf->start_id + i);
> +		struct btf_field_iter it;
> +		__u32 *type_id;
> +
> +		r =3D btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
> +		if (r)
> +			return r;
> +
> +		while ((type_id =3D btf_field_iter_next(&it))) {

The code below repeats logic it btf_permute_remap_type_id(), please
use it here. Better yet, generalize btf_dedup_remap_types() and avoid
a copy-paste altogether.

> +			__u32 new_id =3D *type_id;
> +
> +			/* skip references that point into the base BTF */
> +			if (new_id < btf->start_id)
> +				continue;
> +
> +			new_id =3D p->map[new_id - btf->start_id];
> +			if (new_id > BTF_MAX_NR_TYPES)
> +				return -EINVAL;
> +
> +			*type_id =3D new_id;
> +		}
> +	}
> +
> +	if (!p->btf_ext)
> +		return 0;
> +
> +	r =3D btf_ext_visit_type_ids(p->btf_ext, btf_permute_remap_type_id, p);
> +	if (r)
> +		return r;
> +
> +	return 0;
> +}
> +
> +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
> +{
> +	struct btf_permute *p =3D ctx;
> +	__u32 new_type_id =3D *type_id;
> +
> +	/* skip references that point into the base BTF */
> +	if (new_type_id < p->btf->start_id)
> +		return 0;
> +
> +	new_type_id =3D p->map[*type_id - p->btf->start_id];
> +	if (new_type_id > BTF_MAX_NR_TYPES)
> +		return -EINVAL;
> +
> +	*type_id =3D new_type_id;
> +	return 0;
> +}
> +
> +/*
> + * btf_sort.c is included directly to avoid function call overhead
> + * when accessing BTF private data, as this file is shared between
> + * libbpf and kernel and may be called frequently.
> + */
> +#include "./btf_sort.c"
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index ccfd905f03df..3aac0a729bd5 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -149,6 +149,7 @@ LIBBPF_API __s32 btf__find_by_name_kind(const struct =
btf *btf,
>  					const char *type_name, __u32 kind);
>  LIBBPF_API __u32 btf__type_cnt(const struct btf *btf);
>  LIBBPF_API const struct btf *btf__base_btf(const struct btf *btf);
> +LIBBPF_API __u32 btf__start_id(const struct btf *btf);
>  LIBBPF_API const struct btf_type *btf__type_by_id(const struct btf *btf,
>  						  __u32 id);
>  LIBBPF_API size_t btf__pointer_size(const struct btf *btf);
> @@ -273,6 +274,22 @@ LIBBPF_API int btf__dedup(struct btf *btf, const str=
uct btf_dedup_opts *opts);
>   */
>  LIBBPF_API int btf__relocate(struct btf *btf, const struct btf *base_btf=
);
> =20
> +struct btf_permute_opts {
> +	size_t sz;
> +	/* optional .BTF.ext info along the main BTF info */
> +	struct btf_ext *btf_ext;
> +	/* Array of type IDs used for permutation. The array length must equal
> +	 * the number of types in the BTF being permuted, excluding the special
> +	 * void type at ID 0. For split BTF, the length corresponds to the
> +	 * number of types added on top of the base BTF.
> +	 */
> +	__u32 *ids;
> +	size_t :0;
> +};
> +#define btf_permute_opts__last_field ids
> +
> +LIBBPF_API int btf__permute(struct btf *btf, const struct btf_permute_op=
ts *opts);
> +
>  struct btf_dump;
> =20
>  struct btf_dump_opts {
> diff --git a/tools/lib/bpf/btf_sort.c b/tools/lib/bpf/btf_sort.c
> new file mode 100644
> index 000000000000..553c5f5e61bd
> --- /dev/null
> +++ b/tools/lib/bpf/btf_sort.c
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +/* Copyright (c) 2025 Xiaomi */
> +
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +
> +#ifdef __KERNEL__
> +
> +#define btf_type_by_id				(struct btf_type *)btf_type_by_id
> +#define btf__str_by_offset			btf_str_by_offset
> +#define btf__type_cnt				btf_nr_types
> +#define btf__start_id				btf_start_id
> +#define libbpf_err(x)				x
> +
> +#else
> +
> +#define notrace
> +
> +#endif /* __KERNEL__ */
> +
> +/*
> + * Skip the sorted check if the number of BTF types is below this thresh=
old.
> + * The value 4 is chosen based on the theoretical break-even point where
> + * linear search (N/2) and binary search (LOG2(N)) require approximately
> + * the same number of comparisons.
> + */
> +#define BTF_CHECK_SORT_THRESHOLD  4
> +
> +struct btf;
> +
> +static int cmp_btf_kind_name(int ka, const char *na, int kb, const char =
*nb)
> +{
> +	return (ka - kb) ?: strcmp(na, nb);
> +}
> +
> +/*
> + * Sort BTF types by kind and name in ascending order, placing named typ=
es
> + * before anonymous ones.
> + */
> +static int btf_compare_type_kinds_names(const void *a, const void *b, vo=
id *priv)
> +{
> +	struct btf *btf =3D (struct btf *)priv;
> +	struct btf_type *ta =3D btf_type_by_id(btf, *(__u32 *)a);
> +	struct btf_type *tb =3D btf_type_by_id(btf, *(__u32 *)b);
> +	const char *na, *nb;
> +	bool anon_a, anon_b;
> +	int ka, kb;
> +
> +	na =3D btf__str_by_offset(btf, ta->name_off);
> +	nb =3D btf__str_by_offset(btf, tb->name_off);
> +	anon_a =3D str_is_empty(na);
> +	anon_b =3D str_is_empty(nb);
> +
> +	/* ta w/o name is greater than tb */
> +	if (anon_a && !anon_b)
> +		return 1;
> +	/* tb w/o name is smaller than ta */
> +	if (!anon_a && anon_b)
> +		return -1;
> +
> +	ka =3D btf_kind(ta);
> +	kb =3D btf_kind(tb);
> +
> +	if (anon_a && anon_b)
> +		return ka - kb;
> +
> +	return cmp_btf_kind_name(ka, na, kb, nb);
> +}
> +
> +static __s32 notrace __btf_find_by_name_kind(const struct btf *btf, int =
start_id,
> +				   const char *type_name, __u32 kind)
> +{
> +	const struct btf_type *t;
> +	const char *tname;
> +	int err =3D -ENOENT;
> +
> +	if (!btf)
> +		goto out;
> +
> +	if (start_id < btf__start_id(btf)) {
> +		err =3D __btf_find_by_name_kind(btf->base_btf, start_id, type_name, ki=
nd);
> +		if (err =3D=3D -ENOENT)
> +			start_id =3D btf__start_id(btf);
> +	}
> +
> +	if (err =3D=3D -ENOENT) {
> +		if (btf->nr_sorted_types) {
> +			/* binary search */
> +			__s32 start, end, mid, found =3D -1;
> +			int ret;
> +
> +			start =3D start_id;
> +			end =3D start + btf->nr_sorted_types - 1;
> +			/* found the leftmost btf_type that matches */
> +			while(start <=3D end) {
> +				mid =3D start + (end - start) / 2;
> +				t =3D btf_type_by_id(btf, mid);
> +				tname =3D btf__str_by_offset(btf, t->name_off);
> +				ret =3D cmp_btf_kind_name(BTF_INFO_KIND(t->info), tname,
> +							kind, type_name);
> +				if (ret < 0)
> +					start =3D mid + 1;
> +				else {
> +					if (ret =3D=3D 0)
> +						found =3D mid;
> +					end =3D mid - 1;
> +				}
> +			}
> +
> +			if (found !=3D -1)
> +				return found;
> +		} else {
> +			/* linear search */
> +			__u32 i, total;
> +
> +			total =3D btf__type_cnt(btf);
> +			for (i =3D start_id; i < total; i++) {
> +				t =3D btf_type_by_id(btf, i);
> +				if (btf_kind(t) !=3D kind)
> +					continue;
> +
> +				tname =3D btf__str_by_offset(btf, t->name_off);
> +				if (tname && !strcmp(tname, type_name))
> +					return i;
> +			}
> +		}
> +	}
> +
> +out:
> +	return err;
> +}
> +
> +/* start_id specifies the starting BTF to search */
> +static __s32 notrace _btf_find_by_name_kind(const struct btf *btf, int s=
tart_id,
> +				   const char *type_name, __u32 kind)
> +{
> +	if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
> +		return 0;
> +
> +	return libbpf_err(__btf_find_by_name_kind(btf, start_id, type_name, kin=
d));
> +}
> +
> +static void btf_check_sorted(struct btf *btf, int start_id)
> +{
> +	const struct btf_type *t;
> +	int i, n, nr_sorted_types;
> +
> +	n =3D btf__type_cnt(btf);
> +	if (btf->nr_types < BTF_CHECK_SORT_THRESHOLD)
> +		return;
> +
> +	n--;
> +	nr_sorted_types =3D 0;
> +	for (i =3D start_id; i < n; i++) {
> +		int k =3D i + 1;
> +
> +		if (btf_compare_type_kinds_names(&i, &k, btf) > 0)
> +			return;
> +
> +		t =3D btf_type_by_id(btf, k);
> +		if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
> +			nr_sorted_types++;
> +	}
> +
> +	t =3D btf_type_by_id(btf, start_id);
> +	if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
> +		nr_sorted_types++;
> +
> +	if (nr_sorted_types < BTF_CHECK_SORT_THRESHOLD)
> +		return;
> +
> +	btf->nr_sorted_types =3D nr_sorted_types;
> +}
> diff --git a/tools/lib/bpf/btf_sort.h b/tools/lib/bpf/btf_sort.h
> new file mode 100644
> index 000000000000..4dedc67286d9
> --- /dev/null
> +++ b/tools/lib/bpf/btf_sort.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> +/* Copyright (c) 2025 Xiaomi */
> +
> +#ifndef __BTF_SORT_H
> +#define __BTF_SORT_H
> +
> +static __s32 _btf_find_by_name_kind(const struct btf *btf, int start_id,=
 const char *type_name, __u32 kind);
> +static int btf_compare_type_kinds_names(const void *a, const void *b, vo=
id *priv);
> +static void btf_check_sorted(struct btf *btf, int start_id);
> +
> +#endif
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 8ed8749907d4..8ce7b1d08650 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -452,3 +452,9 @@ LIBBPF_1.7.0 {
>  		bpf_map__set_exclusive_program;
>  		bpf_map__exclusive_program;
>  } LIBBPF_1.6.0;
> +
> +LIBBPF_1.8.0 {

I think we are still at 1.7.

> +	global:
> +		btf__start_id;
> +		btf__permute;
> +} LIBBPF_1.7.0;
> diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_versio=
n.h
> index 99331e317dee..c446c0cd8cf9 100644
> --- a/tools/lib/bpf/libbpf_version.h
> +++ b/tools/lib/bpf/libbpf_version.h
> @@ -4,6 +4,6 @@
>  #define __LIBBPF_VERSION_H
> =20
>  #define LIBBPF_MAJOR_VERSION 1
> -#define LIBBPF_MINOR_VERSION 7
> +#define LIBBPF_MINOR_VERSION 8
> =20
>  #endif /* __LIBBPF_VERSION_H */

