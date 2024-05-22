Return-Path: <bpf+bounces-30319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1AB8CC5F9
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 20:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB96B2177C
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 18:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963261411CD;
	Wed, 22 May 2024 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db3L3yYf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF8F182B9
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716400862; cv=none; b=cZhluxxMGPAIDJmHJsIQfqPwN7N5oQCEAidhmJvIAdhvqupISRJ5F5LHEpC+C8LjCu+9H+DxHxPF0kqbUDjXYewZ2TR4VCRm0SPMlZWkXsXQIV/61JJwTKXP/ScvHMZjo3VSR5Hx5ak5vNWF/VooqtaOXWCORDaijMh8PRf5cEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716400862; c=relaxed/simple;
	bh=q6jxgTakBX0Uwr55j8vviPX5PjTkBM/o6GXGqr/kgFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5elN5aRjexf6Wkyrhee5kW7hfJDZZ8QtFi7s0gAWKh2k7OabwdmShqvsrz8KIeU0mji5Oa9MiOXVrcA75mZf2ktOyMuEM2BCd3X3JgDzH6Z2PwR7haCU8CsGAAIeUSwROXTOInY8k1v2bmgM3HRH1ZYuDoRax/2yf1uEfsKID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Db3L3yYf; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6114c9b4d83so46873927b3.3
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716400859; x=1717005659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ZsYsoTEG2LgAtv5xe3euDuHQZTP8idR5p4NFukEtpc=;
        b=Db3L3yYfgADeCetY0VAlYtohJolA1PF2CxbGuN9wXcMvFRdInBrzP7nq93DrygijcP
         dXjEEdtoo8uthKybn/BcLa8xRyShtubcf/xi10qGUpGRQ/P/tJgu6ZzUscJMkL0fla/p
         +Ay7WJ4RXkSi5zoxYFgrkS0Fme+Zw2n/O5FiCM8/omlyUSC5GmCMxYMKqMSadMr2S9el
         uXTPBjeVJjrTubUWhIRH9zfH0VHHGnJpGUJ05JHajYRvJp3nVUEHSgXYbrwmNR40Mpu5
         omnJHw8Wd/rWNEPjeVL0YpaoEPN00KAb0C0wP1N/pi4wdidtp7wUEDWNho66MYGf2SrJ
         F6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716400859; x=1717005659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZsYsoTEG2LgAtv5xe3euDuHQZTP8idR5p4NFukEtpc=;
        b=KY/Cbvmek1nV8wx4R1eKZNRMZUPmTXsrb7PnbKRkpFl9N/Lp1vNlzp4g+BZqTStSpB
         y80AZm0g/aLcEUoxfPIeWirnPp6yDz9QhqkkQModFU58nZbMH25U+iBmei+CmXWE/pao
         d7/l2W5pv+IOzoAlNElVBzP/j0vnWQMV1GwXGHbbVEzcmtGTJ6kTIDKMyKsTDA4ArIZn
         bHseT9pJrfl7q/yamEWOEzWA0q65DaJ/iMblScwpC1lvVLaXKlENiRJrclQMaVq0GZ5j
         qD/I/gwUFoA+EucrgkI7YSHDE8Dz52nCZzTPbKZ1oJj4Xzd/knsIIgYyWrfxzUEc/TKX
         2fKw==
X-Forwarded-Encrypted: i=1; AJvYcCV24hGFTWwZAB7GckdOH0tv1BHZBhTjKQl7iJOP/T9GoiJ6NZl7MtVxntvCsAKXZDi2VyFyty8pzTeYiwhdG7QH+wzq
X-Gm-Message-State: AOJu0YxFzcW/mnu/3a8Fb7Z68PTe0cB2yT6cOTktawBfK9za69rtR7q4
	GQ44Yp8VRCRLgvsgavl9+pQD334fdJ7mQEWshKehxEBd+bpavt+K
X-Google-Smtp-Source: AGHT+IGyIUQP5/jV4ek/IYlzznDIgtey2ZBRw/KUggbAJWH7I+QWAIAXS3+lSyUFheIqIbO7WmQ3gw==
X-Received: by 2002:a05:690c:f96:b0:61a:ae79:816a with SMTP id 00721157ae682-627e46f8cd6mr33498357b3.31.1716400859025;
        Wed, 22 May 2024 11:00:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:e51c:68a4:2c6a:a550? ([2600:1700:6cf8:1240:e51c:68a4:2c6a:a550])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e37952csm60060297b3.118.2024.05.22.11.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 11:00:58 -0700 (PDT)
Message-ID: <f8d4e364-98ed-4c75-ab87-326f5ba928b1@gmail.com>
Date: Wed, 22 May 2024 11:00:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 bpf-next 01/11] libbpf: add btf__distill_base()
 creating split BTF with distilled base BTF
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
 <20240517102246.4070184-2-alan.maguire@oracle.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240517102246.4070184-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/17/24 03:22, Alan Maguire wrote:
> To support more robust split BTF, adding supplemental context for the
> base BTF type ids that split BTF refers to is required.  Without such
> references, a simple shuffling of base BTF type ids (without any other
> significant change) invalidates the split BTF.  Here the attempt is made
> to store additional context to make split BTF more robust.
> 
> This context comes in the form of distilled base BTF providing minimal
> information (name and - in some cases - size) for base INTs, FLOATs,
> STRUCTs, UNIONs, ENUMs and ENUM64s along with modified split BTF that
> points at that base and contains any additional types needed (such as
> TYPEDEF, PTR and anonymous STRUCT/UNION declarations).  This
> information constitutes the minimal BTF representation needed to
> disambiguate or remove split BTF references to base BTF.  The rules
> are as follows:
> 
> - INT, FLOAT are recorded in full.
> - if a named base BTF STRUCT or UNION is referred to from split BTF, it
>    will be encoded either as a zero-member sized STRUCT/UNION (preserving
>    size for later relocation checks) or as a named FWD.  Only base BTF
>    STRUCT/UNIONs that are either embedded in split BTF STRUCT/UNIONs or
>    that have multiple STRUCT/UNION instances of the same name need to
>    preserve size information, so a FWD representation will be used in
>    most cases.
> - if an ENUM[64] is named, a ENUM forward representation (an ENUM
>    with no values) is used.
> - in all other cases, the type is added to the new split BTF.
> 
> Avoiding struct/union/enum/enum64 expansion is important to keep the
> distilled base BTF representation to a minimum size.
> 
> When successful, new representations of the distilled base BTF and new
> split BTF that refers to it are returned.  Both need to be freed by the
> caller.
> 
> So to take a simple example, with split BTF with a type referring
> to "struct sk_buff", we will generate distilled base BTF with a
> FWD struct sk_buff, and the split BTF will refer to it instead.
> 
> Tools like pahole can utilize such split BTF to populate the .BTF
> section (split BTF) and an additional .BTF.base section.  Then
> when the split BTF is loaded, the distilled base BTF can be used
> to relocate split BTF to reference the current (and possibly changed)
> base BTF.
> 
> So for example if "struct sk_buff" was id 502 when the split BTF was
> originally generated,  we can use the distilled base BTF to see that
> id 502 refers to a "struct sk_buff" and replace instances of id 502
> with the current (relocated) base BTF sk_buff type id.
> 
> Distilled base BTF is small; when building a kernel with all modules
> using distilled base BTF as a test, ovreall module size grew by only
> 5.3Mb total across ~2700 modules.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>   tools/lib/bpf/btf.c      | 409 ++++++++++++++++++++++++++++++++++++++-
>   tools/lib/bpf/btf.h      |  20 ++
>   tools/lib/bpf/libbpf.map |   1 +
>   3 files changed, 424 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 2d0840ef599a..953929d196c3 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1771,9 +1771,8 @@ static int btf_rewrite_str(__u32 *str_off, void *ctx)
>   	return 0;
>   }
>   
> -int btf__add_type(struct btf *btf, const struct btf *src_btf, const struct btf_type *src_type)
> +static int btf_add_type(struct btf_pipe *p, const struct btf_type *src_type)
>   {
> -	struct btf_pipe p = { .src = src_btf, .dst = btf };
>   	struct btf_type *t;
>   	int sz, err;
>   
> @@ -1782,20 +1781,27 @@ int btf__add_type(struct btf *btf, const struct btf *src_btf, const struct btf_t
>   		return libbpf_err(sz);
>   
>   	/* deconstruct BTF, if necessary, and invalidate raw_data */
> -	if (btf_ensure_modifiable(btf))
> +	if (btf_ensure_modifiable(p->dst))
>   		return libbpf_err(-ENOMEM);
>   
> -	t = btf_add_type_mem(btf, sz);
> +	t = btf_add_type_mem(p->dst, sz);
>   	if (!t)
>   		return libbpf_err(-ENOMEM);
>   
>   	memcpy(t, src_type, sz);
>   
> -	err = btf_type_visit_str_offs(t, btf_rewrite_str, &p);
> +	err = btf_type_visit_str_offs(t, btf_rewrite_str, p);
>   	if (err)
>   		return libbpf_err(err);
>   
> -	return btf_commit_type(btf, sz);
> +	return btf_commit_type(p->dst, sz);
> +}
> +
> +int btf__add_type(struct btf *btf, const struct btf *src_btf, const struct btf_type *src_type)
> +{
> +	struct btf_pipe p = { .src = src_btf, .dst = btf };
> +
> +	return btf_add_type(&p, src_type);
>   }
>   
>   static int btf_rewrite_type_ids(__u32 *type_id, void *ctx)
> @@ -5212,3 +5218,394 @@ int btf_ext_visit_str_offs(struct btf_ext *btf_ext, str_off_visit_fn visit, void
>   
>   	return 0;
>   }
> +
> +#define BTF_NEEDS_SIZE	(1 << 31)	/* flag set if either struct/union is
> +					 * embedded - and thus size info must
> +					 * be preserved - or if there are
> +					 * multiple instances of the same
> +					 * struct/union - where size can be
> +					 * used to clarify which is wanted.
> +					 */
> +#define BTF_ID(id)		(id & ~BTF_NEEDS_SIZE)
> +
> +struct btf_distill {
> +	struct btf_pipe pipe;
> +	int *ids;
> +	unsigned int split_start_id;
> +	unsigned int split_start_str;
> +	unsigned int diff_id;
> +};
> +
> +/* Check if a member of a split BTF struct/union refers to a base BTF
> + * struct/union.  Members can be const/restrict/volatile/typedef
> + * reference types, but if a pointer is encountered, type is no longer
> + * considered embedded.
> + */
> +static int btf_find_embedded_composite_type_ids(__u32 *id, void *ctx)
> +{
> +	struct btf_distill *dist = ctx;
> +	const struct btf_type *t;
> +	__u32 next_id = *id;
> +
> +	do {
> +		if (next_id == 0)
> +			return 0;
> +		t = btf_type_by_id(dist->pipe.src, next_id);
> +		switch (btf_kind(t)) {
> +		case BTF_KIND_CONST:
> +		case BTF_KIND_RESTRICT:
> +		case BTF_KIND_VOLATILE:
> +		case BTF_KIND_TYPEDEF:
> +		case BTF_KIND_TYPE_TAG:
> +			next_id = t->type;
> +			break;
> +		case BTF_KIND_ARRAY: {
> +			struct btf_array *a = btf_array(t);
> +
> +			next_id = a->type;
> +			break;
> +		}
> +		case BTF_KIND_STRUCT:
> +		case BTF_KIND_UNION:
> +			dist->ids[next_id] |= BTF_NEEDS_SIZE;
> +			return 0;
> +		default:
> +			return 0;
> +		}
> +
> +	} while (1);
> +
> +	return 0;
> +}
> +
> +/* Check if composite type has a duplicate-named type; if it does, retain
> + * size information to help guide later relocation towards the correct type.
> + * For example there are duplicate 'dma_chan' structs in vmlinux BTF;
> + * one is size 112, the other 16.  Having size information allows relocation
> + * to choose the right one.
> + */
> +static int btf_mark_composite_dups(struct btf_distill *dist, __u32 id)
> +{
> +	__u8 *cnt = calloc(dist->split_start_str, sizeof(__u8));
> +	struct btf_type *t;
> +	int i;
> +
> +	if (!cnt)
> +		return -ENOMEM;
> +
> +	/* First pass; collect name counts for composite types. */
> +	for (i = 1; i < dist->split_start_id; i++) {
> +		t = btf_type_by_id(dist->pipe.src, i);
> +		if (!btf_is_composite(t) || !t->name_off)
> +			continue;
> +		if (cnt[t->name_off] < 255)
> +			cnt[t->name_off]++;
> +	}
> +	/* Second pass; mark composite types with multiple instances of the
> +	 * same name as needing size information.
> +	 */
> +	for (i = 1; i < dist->split_start_id; i++) {
> +		/* id not needed or is already preserving size information */
> +		if (!dist->ids[i] || (dist->ids[i] & BTF_NEEDS_SIZE))
> +			continue;
> +		t = btf_type_by_id(dist->pipe.src, i);
> +		if (!btf_is_composite(t) || !t->name_off)
> +			continue;
> +		if (cnt[t->name_off] > 1)
> +			dist->ids[i] |= BTF_NEEDS_SIZE;
> +	}
> +	free(cnt);
> +
> +	return 0;
> +}
> +
> +static bool btf_is_eligible_named_fwd(const struct btf_type *t)
> +{
> +	return (btf_is_composite(t) || btf_is_any_enum(t)) && t->name_off != 0;
> +}
> +
> +static int btf_add_distilled_type_ids(__u32 *id, void *ctx)
> +{
> +	struct btf_distill *dist = ctx;
> +	struct btf_type *t = btf_type_by_id(dist->pipe.src, *id);
> +	int err;
> +
> +	if (!*id)
> +		return 0;
> +	/* split BTF id, not needed */
> +	if (*id >= dist->split_start_id)
> +		return 0;
> +	/* already added ? */
> +	if (BTF_ID(dist->ids[*id]) > 0)
> +		return 0;
> +
> +	/* only a subset of base BTF types should be referenced from split
> +	 * BTF; ensure nothing unexpected is referenced.
> +	 */
> +	switch (btf_kind(t)) {
> +	case BTF_KIND_INT:
> +	case BTF_KIND_FLOAT:
> +	case BTF_KIND_FWD:
> +	case BTF_KIND_ARRAY:
> +	case BTF_KIND_STRUCT:
> +	case BTF_KIND_UNION:
> +	case BTF_KIND_TYPEDEF:
> +	case BTF_KIND_ENUM:
> +	case BTF_KIND_ENUM64:
> +	case BTF_KIND_PTR:
> +	case BTF_KIND_CONST:
> +	case BTF_KIND_RESTRICT:
> +	case BTF_KIND_VOLATILE:
> +	case BTF_KIND_FUNC_PROTO:
> +	case BTF_KIND_TYPE_TAG:
> +		dist->ids[*id] |= *id;
> +		break;
> +	default:
> +		pr_warn("unexpected reference to base type[%u] of kind [%u] when creating distilled base BTF.\n",
> +			*id, btf_kind(t));
> +		return -EINVAL;
> +	}
> +
> +	/* struct/union members not needed, except for anonymous structs
> +	 * and unions, which we need since name won't help us determine
> +	 * matches; so if a named struct/union, no need to recurse
> +	 * into members.
> +	 */
> +	if (btf_is_eligible_named_fwd(t))
> +		return 0;
> +
> +	/* ensure references in type are added also. */
> +	err = btf_type_visit_type_ids(t, btf_add_distilled_type_ids, ctx);
> +	if (err < 0)
> +		return err;
> +	return 0;
> +}
> +
> +static int btf_add_distilled_types(struct btf_distill *dist)
> +{
> +	bool adding_to_base = dist->pipe.dst->start_id == 1;
> +	int id = btf__type_cnt(dist->pipe.dst);
> +	struct btf_type *t;
> +	int i, err = 0;
> +
> +	/* Add types for each of the required references to either distilled
> +	 * base or split BTF, depending on type characteristics.
> +	 */
> +	for (i = 1; i < dist->split_start_id; i++) {
> +		const char *name;
> +		int kind;
> +
> +		if (!BTF_ID(dist->ids[i]))
> +			continue;
> +		t = btf_type_by_id(dist->pipe.src, i);
> +		kind = btf_kind(t);
> +		name = btf__name_by_offset(dist->pipe.src, t->name_off);
> +
> +		/* Named int, float, fwd struct, union, enum[64] are added to
> +		 * base; everything else is added to split BTF.
> +		 */
> +		switch (kind) {
> +		case BTF_KIND_INT:
> +		case BTF_KIND_FLOAT:
> +		case BTF_KIND_FWD:
> +		case BTF_KIND_STRUCT:
> +		case BTF_KIND_UNION:
> +		case BTF_KIND_ENUM:
> +		case BTF_KIND_ENUM64:
> +			if ((adding_to_base && !t->name_off) || (!adding_to_base && t->name_off))
> +				continue;
> +			break;
> +		default:
> +			if (adding_to_base)
> +				continue;
> +			break;
> +		}
> +		if (dist->ids[i] & BTF_NEEDS_SIZE) {
> +			/* If a named struct/union in base BTF is referenced as a type
> +			 * in split BTF without use of a pointer - i.e. as an embedded
> +			 * struct/union - add an empty struct/union preserving size
> +			 * since size must be consistent when relocating split and
> +			 * possibly changed base BTF.  Similarly, when a struct/union
> +			 * has multiple instances of the same name in the original
> +			 * base BTF, retain size to help relocation later pick the
> +			 * right struct/union.
> +			 */
> +			err = btf_add_composite(dist->pipe.dst, kind, name, t->size);
> +		} else if (btf_is_eligible_named_fwd(t)) {
> +			/* If not embedded, use a fwd for named struct/unions since we
> +			 * can match via name without any other details.
> +			 */
> +			switch (kind) {
> +			case BTF_KIND_STRUCT:
> +				err = btf__add_fwd(dist->pipe.dst, name, BTF_FWD_STRUCT);
> +				break;
> +			case BTF_KIND_UNION:
> +				err = btf__add_fwd(dist->pipe.dst, name, BTF_FWD_UNION);
> +				break;
> +			case BTF_KIND_ENUM:
> +				err = btf__add_enum(dist->pipe.dst, name, t->size);
> +				break;
> +			case BTF_KIND_ENUM64:
> +				err = btf__add_enum(dist->pipe.dst, name, t->size);

Should this be btf__add_enum64() instead of btf__add_enum()?

> +				break;
> +			default:
> +				pr_warn("unexpected kind [%u] when creating distilled base BTF.\n",
> +					btf_kind(t));
> +				return -EINVAL;
> +			}
> +		} else {
> +			err = btf_add_type(&dist->pipe, t);
> +		}
> +		if (err < 0)
> +			break;
> +		dist->ids[i] = id++;
> +	}
> +	return err;
> +}
> +

[...]

