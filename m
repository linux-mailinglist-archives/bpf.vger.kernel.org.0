Return-Path: <bpf+bounces-30351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA308CCA3B
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 03:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E85B21C51
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 01:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAD617FF;
	Thu, 23 May 2024 01:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3KsP54c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9D17EF
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 01:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716426373; cv=none; b=kcu0AlLJByIU2o6if/2CUmrw0FUAxVCkrmpEcca5Mn0cLX65q9fScuAf+4J1IpvjFn4lo2zzsTh4yv1xAXOU6P0sTJlVgtA2EaQfEq3AAhL5ulyCqKgZI7eEBLomb7HuLbDdEt3SpRd+mDUzy8sKudb4XDnYMk77TGARemGa8v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716426373; c=relaxed/simple;
	bh=/lzG7N8HRRuJAEICZpQKiSVgOSJ26jUCEV+Q7IFSI+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c00girb+oFALyxZ+j2Z6QmiOZYTWPkoxS2u4u0sBi152kAc77SxUlKdBlNJeVf/0xH8r3IsA+cSHO1Wi7ndvwu2uw7915S70q8OkICgvI1plQV+kepFpJB9+iM0sIik0GQGuTfjsq/GVbl7gGEx2OmxN9+Xrjn9ZEd4J3ecTTNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3KsP54c; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-627f5b7b75bso3243747b3.0
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 18:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716426370; x=1717031170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+hyC9kKIJm71KxO3GvQ0uNFEfo/Pu1LbXa9+dx28FU=;
        b=e3KsP54cXrJ20TJZYgX0t6r9CvjsZDebVrgROnAdg4MvG7QIiC56h1yrqaizChfFKD
         Qi+TlXuTpCT2S03fn4EBapi0voMDi7YKUEJ4SoJ6L8ob8pBQFMKYTkOFSnOTMtxgAWM9
         oOmm94j+hVNZEyG8cZGO3GukpbCw35tPALSQ4lbhdIL3fbqsHOeLlpOoW11wZxeWQSFE
         iPDCXnWhcZPeOo98UqLom8n6ju5/wYiHhNxHzmT4TxHxazzLShuOr2y+ZZuWo0jpmNLk
         0OrPkiOG3NuaJlZ4wrH3RoCj6kxJIxh4zgz1YzBKq75wQGqu5/DV60yFIUNnBCp2EBVy
         Y+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716426370; x=1717031170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+hyC9kKIJm71KxO3GvQ0uNFEfo/Pu1LbXa9+dx28FU=;
        b=ZapXMFM/Aw9i9YNSXgV42YnZ6d0av5GWcCectUaZxWQDCHfp7Ny7RhISaC7ZxLF4f0
         VVLquuZGMKV17VpXA7B7q9bq1Y2gGrdNnhjy+n7db25LTREvDI7bPk//zK5cNE0wN0Sc
         f0XESr7dVVZmWljWG3KW24os/Y+51Pu6ihskJZUI/Z1p/cdzZa2QqEJvnJilinAA7imh
         vtfM1M9RULCOJceyu1UBw/4/OqiGcwre3xc7DwvxUq2aSwORYo8WJxv+6ggCE5AfmBDL
         wQnJMK9G2H5zIxw8a7W6wAlrVeLAs6ZV7ZO7OQSv6WJlhmhTrGF/zfpXzB7gJt1KD7wq
         fHtw==
X-Forwarded-Encrypted: i=1; AJvYcCVxqqLwEFJqvwjLvaoypo7W/PLRPXVjh5jRorzLfafNRIelVTTPacEPYIGDJAOJ60g+HhebO+2cUc8MkG0fTsHMePky
X-Gm-Message-State: AOJu0YwgZ21ndNiT6yOHrIMi8QtffChyx8/te7gH0bf8wQ20RjpYWgm0
	kB/w7r02FQDnLnRrcLqW1KxfWEIBG/x+tEr/dXUQB94wO/0fpowk
X-Google-Smtp-Source: AGHT+IG60hqKD5VGVxdJ4XuBkpk/q9qC5OgnNY6s07ynKODaYLeiHdmn3tuxxFc5isJvA2vSPt+gvA==
X-Received: by 2002:a81:a150:0:b0:618:a587:7a41 with SMTP id 00721157ae682-6283499fabamr6155137b3.16.1716426370284;
        Wed, 22 May 2024 18:06:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:e51c:68a4:2c6a:a550? ([2600:1700:6cf8:1240:e51c:68a4:2c6a:a550])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e26e166sm59887917b3.58.2024.05.22.18.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 18:06:09 -0700 (PDT)
Message-ID: <456f98bc-a430-4fa4-b2d0-344fe50821f4@gmail.com>
Date: Wed, 22 May 2024 18:06:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 bpf-next 07/11] libbpf: split BTF relocation
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
 <20240517102246.4070184-8-alan.maguire@oracle.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240517102246.4070184-8-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/17/24 03:22, Alan Maguire wrote:
> Map distilled base BTF type ids referenced in split BTF and their
> references to the base BTF passed in, and if the mapping succeeds,
> reparent the split BTF to the base BTF.
> 
> Relocation is done by first verifying that distilled base BTF
> only consists of named INT, FLOAT, ENUM, FWD, STRUCT and
> UNION kinds; then we sort these to speed lookups.  Once sorted,
> the base BTF is iterated, and for each relevant kind we check
> for an equivalent in distilled base BTF.  When found, the
> mapping from distilled -> base BTF id and string offset is recorded.
> 
> Once all mappings are established, we can update type ids
> and string offsets in split BTF and reparent it to the new base.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
[...]
> +/* Comparison between base BTF type (search type) and distilled base types (target).
> + * Because there is no bsearch_r() we need to use the search key - which also is
> + * the first element of struct btf_relocate * - as a means to retrieve the
> + * struct btf_relocate *.
> + */
> +static int cmp_base_and_distilled_btf_types(const void *idbase, const void *iddist)
> +{
> +	struct btf_relocate *r = (struct btf_relocate *)idbase;
> +	const struct btf_type *tbase = btf_type_by_id(r->base_btf, *(__u32 *)idbase);

"*(__u32 *)idbase" together with the previous line is a little difficult
to decrypt. Using "r->search_id" here is more intuitive, easier to read.

> +	const struct btf_type *tdist = btf_type_by_id(r->dist_base_btf, *(__u32 *)iddist);
> +
> +	return strcmp(btf__name_by_offset(r->base_btf, tbase->name_off),
> +		      btf__name_by_offset(r->dist_base_btf, tdist->name_off));
> +}
> +
> +/* Build a map from distilled base BTF ids to base BTF ids. To do so, iterate
> + * through base BTF looking up distilled type (using binary search) equivalents.
> + */
> +static int btf_relocate_map_distilled_base(struct btf_relocate *r)
> +{
> +	struct btf_type *t;
> +	const char *name;
> +	__u32 id;
> +
> +	/* generate a sort index array of type ids sorted by name for distilled
> +	 * base BTF to speed lookups.
> +	 */
> +	for (id = 1; id < r->nr_dist_base_types; id++)
> +		r->dist_base_index[id] = id;
> +	qsort_r(r->dist_base_index, r->nr_dist_base_types, sizeof(__u32), cmp_btf_types,
> +		(struct btf *)r->dist_base_btf);
> +
> +	for (id = 1; id < r->nr_base_types; id++) {
> +		struct btf_type *dist_t;
> +		int dist_kind, kind;
> +		bool compat_kind;
> +		__u32 *dist_id;
> +
> +		t = btf_type_by_id(r->base_btf, id);
> +		kind = btf_kind(t);
> +		/* distilled base consists of named types only. */
> +		if (!t->name_off)
> +			continue;
> +		switch (kind) {
> +		case BTF_KIND_INT:
> +		case BTF_KIND_FLOAT:
> +		case BTF_KIND_ENUM:
> +		case BTF_KIND_ENUM64:
> +		case BTF_KIND_FWD:
> +		case BTF_KIND_STRUCT:
> +		case BTF_KIND_UNION:
> +			break;
> +		default:
> +			continue;
> +		}
> +		r->search_id = id;
> +		dist_id = bsearch(&r->search_id, r->dist_base_index, r->nr_dist_base_types,
> +				  sizeof(__u32), cmp_base_and_distilled_btf_types);
> +		if (!dist_id)
> +			continue;
> +		if (!*dist_id || *dist_id > r->nr_dist_base_types) {
> +			pr_warn("base BTF id [%d] maps to invalid distilled base BTF id [%d]\n",
> +				id, *dist_id);
> +			return -EINVAL;
> +		}
> +		/* validate that kinds are compatible */
> +		dist_t = btf_type_by_id(r->dist_base_btf, *dist_id);
> +		dist_kind = btf_kind(dist_t);
> +		name = btf__name_by_offset(r->dist_base_btf, dist_t->name_off);
> +		compat_kind = dist_kind == kind;
> +		if (!compat_kind) {
> +			switch (dist_kind) {
> +			case BTF_KIND_FWD:
> +				compat_kind = kind == BTF_KIND_STRUCT || kind == BTF_KIND_UNION;
> +				break;
> +			case BTF_KIND_ENUM:
> +				compat_kind = kind == BTF_KIND_ENUM64;
> +				break;
> +			default:
> +				break;
> +			}
> +			if (!compat_kind) {
> +				pr_warn("kind incompatibility (%d != %d) between distilled base type '%s'[%d] and base type [%d]\n",
> +					dist_kind, kind, name, *dist_id, id);
> +				return -EINVAL;
> +			}
> +		}
> +		/* validate that int, float struct, union sizes are compatible;
> +		 * distilled base BTF encodes an empty STRUCT/UNION with
> +		 * specific size for cases where a type is embedded in a split
> +		 * type (so has to preserve size info).  Do not error out
> +		 * on mismatch as another size match may occur for an
> +		 * identically-named type.
> +		 */
> +		switch (btf_kind(dist_t)) {
> +		case BTF_KIND_INT:
> +			if (*(__u32 *)(t + 1) != *(__u32 *)(dist_t + 1))
> +				continue;

I know we have code like this here and there. But, could we just use
btf_int_encoding() and btf_int_offset() or invent another function to
return this value and make this comparison more meaningful?
Or just a line of comment to explain what it is.

> +			if (t->size != dist_t->size)
> +				continue;
> +			break;
> +		case BTF_KIND_FLOAT:
> +		case BTF_KIND_STRUCT:
> +		case BTF_KIND_UNION:
> +			if (t->size != dist_t->size)
> +				continue;
> +			break;
> +		default:
> +			break;
> +		}
> +		/* map id and name */
> +		r->map[*dist_id] = id;
> +		r->str_map[dist_t->name_off] = t->name_off;
> +	}
> +	/* ensure all distilled BTF ids have a mapping... */
> +	for (id = 1; id < r->nr_dist_base_types; id++) {
> +		if (r->map[id])
> +			continue;
> +		t = btf_type_by_id(r->dist_base_btf, id);
> +		name = btf__name_by_offset(r->dist_base_btf, t->name_off);
> +		pr_warn("distilled base BTF type '%s' [%d] is not mapped to base BTF id\n",
> +			name, id);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
[...]


