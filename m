Return-Path: <bpf+bounces-30992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED8D8D5898
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 04:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75AE8B22045
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 02:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371837710C;
	Fri, 31 May 2024 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbw4D/2G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C766F2EA
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717122154; cv=none; b=Mom0RkC7P46nLHeG/dWUXx6rr4MuKYww6OCcxuJagtFEzp4rwHkyjxi1/VuvmuBmJtQs0qg2yLsz2jpaHW8vTI4/tGw/fhrUI4Vn80H+6GmG8saCBBlLb4vYmMamniTx0fE0Y5z0jpHVfjzAYF4CsMvODLrED1fDdV3fSNqQN0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717122154; c=relaxed/simple;
	bh=BHr6ZYRZqWh+Zag4lFl8feRJFGp6HnUf7yoNxw6f1w4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jk/dyPFpRSGlP/rg3+SySaJnFzySi7eOrhrGKlhHuUmmxcMRSjwPT9VEokM8k0dwyxhv4vllu5MfiGlapYqR5O7kYXcxSDtCI/NjpxS51sVg6+3rGU0NwX+GfFKc2umSNEEWynGye8aFgfzqzvmTyF1LQXLWGWbxMRwHdWNE/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbw4D/2G; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f62fae8c3cso6041875ad.3
        for <bpf@vger.kernel.org>; Thu, 30 May 2024 19:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717122152; x=1717726952; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LC4pnwZt6wpy7EFymTsOyIJM6EK7iPPY4mCn3OGZqJU=;
        b=cbw4D/2GHY0oItY6BcPFLv0y/a1tpsf0KIM2p3enqdkufBboEUhvvg5//4zz689uaZ
         DoD1SRX/nvT99rm/EX6seyKiISj4uvM1lOD0ufl8NPItdAzzWn2dCw5G2OZWwDkajlLm
         KINWbnbzlm4YNeTAOTQdlHmfDsmQl3H3KW62OZvb2FTQB4lcwLzFdMiFYICC31AE5kU4
         VGtmDJ0ckfsCEguJ5WzH0zU1IbqNR84eVHWwS7GYuKeCJf2u2lPoi+0uL0VFxkwymSiU
         PIOi38GookMzysqpwAFGWlmCiWM8bs4Rne0aW/KclKggvubl09Yd1xPf5WQwbWK8cF8/
         xrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717122152; x=1717726952;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LC4pnwZt6wpy7EFymTsOyIJM6EK7iPPY4mCn3OGZqJU=;
        b=ux911T5EO2BXFyS+l4PNJ69uoGbYeKmJT1Pz61juC6JNlnUnL/s6WX0mGqoKnEuACR
         9u8Sq2chqPXmRIi/0/mIHtdZmZlxGj2MltoeJVFKWiE38SJeNgEmX80WDxZU3zSPykKl
         9MC+BMHoSJAiuhPwe0Z35U/FLMnDtZhtTdhRLT7TVMgIsVC/axu65cgIiGqy6PvKJpby
         sbulEEOWLlzAOrHDPsMtq9Zo+3DPdCGHviv2ZI0A/UPibp8x3fdLiuzhLwKnX3xPVLW2
         ZTwlBTmnvJgDMNFQ1IKi6WDimzaonCZ894Rnr59Kh+h7HdDDEb73dK/uDsPBudbOzErU
         K10A==
X-Forwarded-Encrypted: i=1; AJvYcCUkF6Rp7yOewikXgofkuPsXIsMJdiIMTpZPwveg2UHDjkv0fDXzaAuG8ZojES0SBdof4Hwhl/pr4dxK0Xf6RxzJKGpD
X-Gm-Message-State: AOJu0YyZYMVCAc5wpxN71TOtGdyh7RAIvkQ/0jl/40b0GXF3uEU2br/c
	tPjQOzIDLEFE6psXjWjeVLina2JrljMVqGnCX3gGli6eAC/4IWZl
X-Google-Smtp-Source: AGHT+IG1jh/Ss3MmYKJA1z+sp2xzVCqgyLTUmHPEWseTMdZmTl3XKVnz/3xrsx8dKGT/dnjx+E+viQ==
X-Received: by 2002:a17:902:da87:b0:1f4:a36c:922c with SMTP id d9443c01a7336-1f636fee6a9mr6794855ad.20.1717122152283;
        Thu, 30 May 2024 19:22:32 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63235e06asm4704345ad.81.2024.05.30.19.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 19:22:31 -0700 (PDT)
Message-ID: <7da6ec1c366bb7b5461b10eeaaa75945b74815be.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 3/9] libbpf: split BTF relocation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
 quentin@isovalent.com,  mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev,  song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com,  kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, houtao1@huawei.com, 
 bpf@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org,
 nathan@kernel.org
Date: Thu, 30 May 2024 19:22:30 -0700
In-Reply-To: <20240528122408.3154936-4-alan.maguire@oracle.com>
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
	 <20240528122408.3154936-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 13:24 +0100, Alan Maguire wrote:

[...]

> +/* Build a map from distilled base BTF ids to base BTF ids. To do so, it=
erate
> + * through base BTF looking up distilled type (using binary search) equi=
valents.
> + */
> +static int btf_relocate_map_distilled_base(struct btf_relocate *r)
> +{

I have several observations about this algorithm.

The algorithm does Base.Cnt * log2(Dist.Cnt) binary searches.
However, it might be better to switch searches around
and look for distilled {name,size} pairs in base btf,
doing Dist.Cnt * log2(Base.cnt) searches instead.
Suppose Base.Cnt =3D 2**20 and Dist.Cnt =3D 2**10, in such case:
  - Base.Cnt * log2(Dist.Cnt) =3D 2**20 * 10
  - Dist.Cnt * log2(Base.cnt) =3D 2**10 * 20, which is smaller

The algorithm might not handle name duplicates in the distilled BTF well,
e.g. in theory, the following is a valid C code

  struct foo { int f; }; // sizeof(struct foo) =3D=3D 4
  typedef int foo;       // sizeof(foo) =3D=3D 4

Suppose that these types are a part of the distilled BTF.
Depending on which one would end up first in 'dist_base_info_sorted'
bsearch might fail to find one or the other.

Also, algorithm does not report an error if there are several
types with the same name and size in the base BTF.

I suggest to modify the algorithm as follows:
- let 'base_info_sorted' be a set of tuples {kind,name,size,id}
  corresponding to the base BTF, sorted by kind, name and size;
- add a custom utility bsearch_unique, that behaves like bsearch,
  but returns NULL if entry is non-unique with regards to current
  predicate (e.g. use bsearch but also check neighbors);
- for each type D in the distilled base:
  - use bsearch_unique to find entry E in 'base_info_sorted'
    that matches D.{kind,name,size} sub-tuple;
  - if E exists, set id_map[D] :=3D E.id;
  - if E does not exist:
    - if id_map[D] =3D=3D BTF_IS_EMBEDDED, report an error;
    - if id_map[D] !=3D BTF_IS_EMBEDDED:
      - use bsearch_unique to find entry E in 'base_info_sorted'
        that matches D.{kind,name} sub-tuple;
      - if E exists, set id_map[D] :=3D E.id;
      - otherwise, report an error.

This allows to:
- flip the search order, potentially gaining some speed;
- drop the 'base_name_cnt' array and logic;
- handle the above hypothetical name conflict example.

Wdyt?

> +	struct btf_name_info *dist_base_info_sorted;
> +	struct btf_type *base_t, *dist_t, *split_t;
> +	__u8 *base_name_cnt =3D NULL;
> +	int err =3D 0;
> +	__u32 id;
> +
> +	/* generate a sort index array of name/type ids sorted by name for
> +	 * distilled base BTF to speed name-based lookups.
> +	 */
> +	dist_base_info_sorted =3D calloc(r->nr_dist_base_types, sizeof(*dist_ba=
se_info_sorted));
> +	if (!dist_base_info_sorted) {
> +		err =3D -ENOMEM;
> +		goto done;
> +	}
> +	for (id =3D 0; id < r->nr_dist_base_types; id++) {
> +		dist_t =3D btf_type_by_id(r->dist_base_btf, id);
> +		dist_base_info_sorted[id].name =3D btf__name_by_offset(r->dist_base_bt=
f,
> +								     dist_t->name_off);
> +		dist_base_info_sorted[id].id =3D id;
> +		dist_base_info_sorted[id].size =3D dist_t->size;
> +		dist_base_info_sorted[id].needs_size =3D true;
> +	}
> +	qsort(dist_base_info_sorted, r->nr_dist_base_types, sizeof(*dist_base_i=
nfo_sorted),
> +	      cmp_btf_name_size);
> +
> +	/* Mark distilled base struct/union members of split BTF structs/unions
> +	 * in id_map with BTF_IS_EMBEDDED; this signals that these types
> +	 * need to match both name and size, otherwise embeddding the base
> +	 * struct/union in the split type is invalid.
> +	 */
> +	for (id =3D r->nr_dist_base_types; id < r->nr_split_types; id++) {
> +		split_t =3D btf_type_by_id(r->btf, id);
> +		if (btf_is_composite(split_t)) {
> +			err =3D btf_type_visit_type_ids(split_t, btf_mark_embedded_composite_=
type_ids,
> +						      r);
> +			if (err < 0)
> +				goto done;
> +		}
> +	}
> +
> +	/* Collect name counts for composite types in base BTF.  If multiple
> +	 * instances of a struct/union of the same name exist, we need to use
> +	 * size to determine which to map to since name alone is ambiguous.
> +	 */
> +	base_name_cnt =3D calloc(r->base_str_len, sizeof(*base_name_cnt));
> +	if (!base_name_cnt) {
> +		err =3D -ENOMEM;
> +		goto done;
> +	}
> +	for (id =3D 1; id < r->nr_base_types; id++) {
> +		base_t =3D btf_type_by_id(r->base_btf, id);
> +		if (!btf_is_composite(base_t) || !base_t->name_off)
> +			continue;
> +		if (base_name_cnt[base_t->name_off] < 255)
> +			base_name_cnt[base_t->name_off]++;
> +	}
> +
> +	/* Now search base BTF for matching distilled base BTF types. */
> +	for (id =3D 1; id < r->nr_base_types; id++) {
> +		struct btf_name_info *dist_name_info, base_name_info =3D {};
> +		int dist_kind, base_kind;
> +
> +		base_t =3D btf_type_by_id(r->base_btf, id);
> +		/* distilled base consists of named types only. */
> +		if (!base_t->name_off)
> +			continue;
> +		base_kind =3D btf_kind(base_t);
> +		base_name_info.id =3D id;
> +		base_name_info.name =3D btf__name_by_offset(r->base_btf, base_t->name_=
off);
> +		switch (base_kind) {
> +		case BTF_KIND_INT:
> +		case BTF_KIND_FLOAT:
> +		case BTF_KIND_ENUM:
> +		case BTF_KIND_ENUM64:
> +			/* These types should match both name and size */
> +			base_name_info.needs_size =3D true;
> +			base_name_info.size =3D base_t->size;
> +			break;
> +		case BTF_KIND_FWD:
> +			/* No size considerations for fwds. */
> +			break;
> +		case BTF_KIND_STRUCT:
> +		case BTF_KIND_UNION:
> +			/* Size only needs to be used for struct/union if there
> +			 * are multiple types in base BTF with the same name.
> +			 * If there are multiple _distilled_ types with the same
> +			 * name (a very unlikely scenario), that doesn't matter
> +			 * unless corresponding _base_ types to match them are
> +			 * missing.
> +			 */
> +			base_name_info.needs_size =3D base_name_cnt[base_t->name_off] > 1;
> +			base_name_info.size =3D base_t->size;
> +			break;
> +		default:
> +			continue;
> +		}
> +		dist_name_info =3D bsearch(&base_name_info, dist_base_info_sorted,
> +					 r->nr_dist_base_types, sizeof(*dist_base_info_sorted),
> +					 cmp_btf_name_size);
> +		if (!dist_name_info)
> +			continue;
> +		if (!dist_name_info->id || dist_name_info->id > r->nr_dist_base_types)=
 {
> +			pr_warn("base BTF id [%d] maps to invalid distilled base BTF id [%d]\=
n",
> +				id, dist_name_info->id);
> +			err =3D -EINVAL;
> +			goto done;
> +		}
> +		dist_t =3D btf_type_by_id(r->dist_base_btf, dist_name_info->id);
> +		dist_kind =3D btf_kind(dist_t);
> +
> +		/* Validate that the found distilled type is compatible.
> +		 * Do not error out on mismatch as another match may occur
> +		 * for an identically-named type.
> +		 */
> +		switch (dist_kind) {
> +		case BTF_KIND_FWD:
> +			switch (base_kind) {
> +			case BTF_KIND_FWD:
> +				if (btf_kflag(dist_t) !=3D btf_kflag(base_t))
> +					continue;
> +				break;
> +			case BTF_KIND_STRUCT:
> +				if (btf_kflag(base_t))
> +					continue;
> +				break;
> +			case BTF_KIND_UNION:
> +				if (!btf_kflag(base_t))
> +					continue;
> +				break;
> +			default:
> +				continue;
> +			}
> +			break;
> +		case BTF_KIND_INT:
> +			if (dist_kind !=3D base_kind ||
> +			    btf_int_encoding(base_t) !=3D btf_int_encoding(dist_t))
> +				continue;
> +			break;
> +		case BTF_KIND_FLOAT:
> +			if (dist_kind !=3D base_kind)
> +				continue;
> +			break;
> +		case BTF_KIND_ENUM:
> +			/* ENUM and ENUM64 are encoded as sized ENUM in
> +			 * distilled base BTF.
> +			 */
> +			if (dist_kind !=3D base_kind && base_kind !=3D BTF_KIND_ENUM64)
> +				continue;
> +			break;
> +		case BTF_KIND_STRUCT:
> +		case BTF_KIND_UNION:
> +			/* size verification is required for embedded
> +			 * struct/unions.
> +			 */
> +			if (r->id_map[dist_name_info->id] =3D=3D BTF_IS_EMBEDDED &&
> +			    base_t->size !=3D dist_t->size)
> +				continue;
> +			break;
> +		default:
> +			continue;
> +		}
> +		/* map id and name */
> +		r->id_map[dist_name_info->id] =3D id;
> +		r->str_map[dist_t->name_off] =3D base_t->name_off;
> +	}
> +	/* ensure all distilled BTF ids now have a mapping... */
> +	for (id =3D 1; id < r->nr_dist_base_types; id++) {
> +		const char *name;
> +
> +		if (r->id_map[id] && r->id_map[id] !=3D BTF_IS_EMBEDDED)
> +			continue;
> +		dist_t =3D btf_type_by_id(r->dist_base_btf, id);
> +		name =3D btf__name_by_offset(r->dist_base_btf, dist_t->name_off);
> +		pr_warn("distilled base BTF type '%s' [%d] is not mapped to base BTF i=
d\n",
> +			name, id);
> +		err =3D -EINVAL;
> +		break;
> +	}
> +done:
> +	free(base_name_cnt);
> +	free(dist_base_info_sorted);
> +	return err;
> +}

[...]

