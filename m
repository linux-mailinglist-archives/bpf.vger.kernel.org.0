Return-Path: <bpf+bounces-31146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAD18D7565
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 14:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360401F2208C
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 12:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6513A1CD;
	Sun,  2 Jun 2024 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqSLBQ5f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30CD3BBF6
	for <bpf@vger.kernel.org>; Sun,  2 Jun 2024 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717332083; cv=none; b=K0hYdDQrIfHeZg+vxXs+r8pG72sEjvsxiC0qIQAogwjhzEJK1N4mi7wUMHOmhBMfhw8BfVXJYB/eXomvLtQGkSE6hA7q6dHxpw3BfEThTCZ7emlpoigyWDDLQVbv8LfNYz9BlIJk6LGLtMx8KEPDC/z7oUOnmFR08mHWw8TipPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717332083; c=relaxed/simple;
	bh=H5Q/YZRRsOj02gN/D9X85yn2pMVecvgn6VHIrHhZh1E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAGlt5B4IJFuZA4plZNZExYHXNN6S8wlDfa5nEmA/C81T+F+RbbCXE6PorJwHDIOaRG9iE5eDbPKYzMJm2sI8fizkR63lwxnKxpIePu3cN7h0XRFP78ArCguZAcf34WRCbTRCeFWsLshfKaeZ09TI1X/8YnycFdEqr1Q5MgEeCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqSLBQ5f; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4213ce259c1so136715e9.3
        for <bpf@vger.kernel.org>; Sun, 02 Jun 2024 05:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717332079; x=1717936879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cyo0mjS2DxIhHJSOupRbrsJi66S3D50Gw7jGei6v9CI=;
        b=CqSLBQ5f+f8Whv5pOOyyi+tkUnHluAsnepNv3NoYujujZLW6jX1K0AhUZ0cgInL+X4
         F1yu+Fg6osOXPFs+fO0Oo5bcSzbW7/qAGNCG7IMBfHMszcmbiSGGZprAcjcNzPiwu+nY
         /UbI12AQ+lybJ4nY9VWz+8N5Mp6KWHgLbqAglQmnP+u6ZH81GHsCJZWZEh3+xmSMaNQB
         y4wOMuLmWZ+kXL8CBfeHjt+m0r0XnDlvCGilGGavNr5+xyRdidwhaNwTR2UdhlxSrow+
         JuuaQgm4icaJSntBJl7u5nAsP35Qn2CkSNS/YOxtzvsVR1e9H0Y9fq8OZnrgjS+NqoEU
         K0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717332079; x=1717936879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cyo0mjS2DxIhHJSOupRbrsJi66S3D50Gw7jGei6v9CI=;
        b=O4MtN9A1gc78UDZXi9foEmDH+yt3S1rb29qc+2WMmvWltZJIE0Ty9o8iYviRUIhoTA
         +oRNXfFTfneSPCCYwKzmPwBDbSP/tJ/qBXmswWcEK7A7I4Bwesr+jTBdgLtVSPgutjJM
         lkep3aCJ4QhrMUOcAAFSwa7X/9MIh5hfnrQyfm5OCG09QOqIEkFficD5cPDgKY+QI5VZ
         CeA1iVmCB46dX+nOBu8NntHYEnTpXoGajxfKxXryW3r381wqGWzBzNnyPDnhI4JdfMtA
         ACB2nX3hp6awA92WzuYHaQzvxBcAHufVOy2fgfAvZ3D9QKJGF2VDaLx6RG70imBDzuYi
         a9VQ==
X-Gm-Message-State: AOJu0YyI/3MPXOR8Fdhud/Wrl6MDS2OPbVPfPNKh0fjjAB5tl0OFP8BJ
	7Ztpj6fJOv/mNfvp5Rlrz+EttXKIRNOc9XVeBrfXXIrAj5CYk51S
X-Google-Smtp-Source: AGHT+IFp/0WSHlFwf51dpIRDWguzGf04W18v5b64Q3TwcE6L6lJ130j48idUvGdNVCPOMTVbDLdohg==
X-Received: by 2002:a05:600c:4fc9:b0:416:7470:45ad with SMTP id 5b1f17b1804b1-4212e07630emr60014435e9.17.1717332078639;
        Sun, 02 Jun 2024 05:41:18 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b51082dsm82767485e9.0.2024.06.02.05.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 05:41:18 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 2 Jun 2024 14:41:16 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH RFC bpf-next] libbpf: implement BTF field iterator
Message-ID: <ZlxobN6wOiXgifAB@krava>
References: <20240601014505.3443241-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601014505.3443241-1-andrii@kernel.org>

On Fri, May 31, 2024 at 06:45:05PM -0700, Andrii Nakryiko wrote:
> Switch from callback-based iteration over BTF type ID and string offset
> fields to an iterator-based approach.
> 
> Switch all existing internal use cases to this new iterator.
> 
> We have .BTF.ext fields iteration, those could be switched to
> iterator-based implementation as well, but this is left as a follow up.
> 
> We also convert bpftool's use of this libbpf-internal API.
> 
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/bpf/bpftool/gen.c         |  17 +-
>  tools/lib/bpf/btf.c             | 334 ++++++++++++++++++--------------
>  tools/lib/bpf/libbpf_internal.h |  26 ++-
>  tools/lib/bpf/linker.c          |  55 +++---
>  4 files changed, 253 insertions(+), 179 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index b3979ddc0189..7b9c0255a2cf 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -2379,15 +2379,6 @@ static int btfgen_record_obj(struct btfgen_info *info, const char *obj_path)
>  	return err;
>  }
>  
> -static int btfgen_remap_id(__u32 *type_id, void *ctx)
> -{
> -	unsigned int *ids = ctx;
> -
> -	*type_id = ids[*type_id];
> -
> -	return 0;
> -}
> -
>  /* Generate BTF from relocation information previously recorded */
>  static struct btf *btfgen_get_btf(struct btfgen_info *info)
>  {
> @@ -2466,11 +2457,13 @@ static struct btf *btfgen_get_btf(struct btfgen_info *info)
>  
>  	/* second pass: fix up type ids */
>  	for (i = 1; i < btf__type_cnt(btf_new); i++) {
> +		struct btf_field_iter it;
>  		struct btf_type *btf_type = (struct btf_type *) btf__type_by_id(btf_new, i);
> +		__u32 *type_id;
>  
> -		err = btf_type_visit_type_ids(btf_type, btfgen_remap_id, ids);
> -		if (err)
> -			goto err_out;
> +		btf_field_iter_init(&it, btf_type, BTF_FIELD_ITER_IDS);

lgtm, should we check return value from btf_field_iter_init?

jirka

> +		while ((type_id = btf_field_iter_next(&it)))
> +			*type_id = ids[*type_id];
>  	}
>  
>  	free(ids);
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 2d0840ef599a..0c39f9b3f98b 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1739,9 +1739,8 @@ struct btf_pipe {
>  	struct hashmap *str_off_map; /* map string offsets from src to dst */
>  };
>  
> -static int btf_rewrite_str(__u32 *str_off, void *ctx)
> +static int btf_rewrite_str(struct btf_pipe *p, __u32 *str_off)
>  {
> -	struct btf_pipe *p = ctx;
>  	long mapped_off;
>  	int off, err;
>  
> @@ -1774,7 +1773,9 @@ static int btf_rewrite_str(__u32 *str_off, void *ctx)
>  int btf__add_type(struct btf *btf, const struct btf *src_btf, const struct btf_type *src_type)
>  {
>  	struct btf_pipe p = { .src = src_btf, .dst = btf };
> +	struct btf_field_iter it;
>  	struct btf_type *t;
> +	__u32 *str_off;
>  	int sz, err;
>  
>  	sz = btf_type_size(src_type);
> @@ -1791,28 +1792,16 @@ int btf__add_type(struct btf *btf, const struct btf *src_btf, const struct btf_t
>  
>  	memcpy(t, src_type, sz);
>  
> -	err = btf_type_visit_str_offs(t, btf_rewrite_str, &p);
> -	if (err)
> -		return libbpf_err(err);
> +	btf_field_iter_init(&it, t, BTF_FIELD_ITER_STRS);
> +	while ((str_off = btf_field_iter_next(&it))) {
> +		err = btf_rewrite_str(&p, str_off);
> +		if (err)
> +			return libbpf_err(err);
> +	}
>  
>  	return btf_commit_type(btf, sz);
>  }
>  
> -static int btf_rewrite_type_ids(__u32 *type_id, void *ctx)
> -{
> -	struct btf *btf = ctx;
> -
> -	if (!*type_id) /* nothing to do for VOID references */
> -		return 0;
> -
> -	/* we haven't updated btf's type count yet, so
> -	 * btf->start_id + btf->nr_types - 1 is the type ID offset we should
> -	 * add to all newly added BTF types
> -	 */
> -	*type_id += btf->start_id + btf->nr_types - 1;
> -	return 0;
> -}
> -
>  static size_t btf_dedup_identity_hash_fn(long key, void *ctx);
>  static bool btf_dedup_equal_fn(long k1, long k2, void *ctx);
>  
> @@ -1858,6 +1847,9 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
>  	memcpy(t, src_btf->types_data, data_sz);
>  
>  	for (i = 0; i < cnt; i++) {
> +		struct btf_field_iter it;
> +		__u32 *type_id, *str_off;
> +
>  		sz = btf_type_size(t);
>  		if (sz < 0) {
>  			/* unlikely, has to be corrupted src_btf */
> @@ -1869,14 +1861,25 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
>  		*off = t - btf->types_data;
>  
>  		/* add, dedup, and remap strings referenced by this BTF type */
> -		err = btf_type_visit_str_offs(t, btf_rewrite_str, &p);
> -		if (err)
> -			goto err_out;
> +		btf_field_iter_init(&it, t, BTF_FIELD_ITER_STRS);
> +		while ((str_off = btf_field_iter_next(&it))) {
> +			err = btf_rewrite_str(&p, str_off);
> +			if (err)
> +				goto err_out;
> +		}
>  
>  		/* remap all type IDs referenced from this BTF type */
> -		err = btf_type_visit_type_ids(t, btf_rewrite_type_ids, btf);
> -		if (err)
> -			goto err_out;
> +		btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
> +		while ((type_id = btf_field_iter_next(&it))) {
> +			if (!*type_id) /* nothing to do for VOID references */
> +				continue;
> +
> +			/* we haven't updated btf's type count yet, so
> +			 * btf->start_id + btf->nr_types - 1 is the type ID offset we should
> +			 * add to all newly added BTF types
> +			 */
> +			*type_id += btf->start_id + btf->nr_types - 1;
> +		}
>  
>  		/* go to next type data and type offset index entry */
>  		t += sz;
> @@ -3453,11 +3456,16 @@ static int btf_for_each_str_off(struct btf_dedup *d, str_off_visit_fn fn, void *
>  	int i, r;
>  
>  	for (i = 0; i < d->btf->nr_types; i++) {
> +		struct btf_field_iter it;
>  		struct btf_type *t = btf_type_by_id(d->btf, d->btf->start_id + i);
> +		__u32 *str_off;
>  
> -		r = btf_type_visit_str_offs(t, fn, ctx);
> -		if (r)
> -			return r;
> +		btf_field_iter_init(&it, t, BTF_FIELD_ITER_STRS);
> +		while ((str_off = btf_field_iter_next(&it))) {
> +			r = fn(str_off, ctx);
> +			if (r)
> +				return r;
> +		}
>  	}
>  
>  	if (!d->btf_ext)
> @@ -4919,10 +4927,20 @@ static int btf_dedup_remap_types(struct btf_dedup *d)
>  
>  	for (i = 0; i < d->btf->nr_types; i++) {
>  		struct btf_type *t = btf_type_by_id(d->btf, d->btf->start_id + i);
> +		struct btf_field_iter it;
> +		__u32 *type_id;
> +
> +		btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
> +		while ((type_id = btf_field_iter_next(&it))) {
> +			__u32 resolved_id, new_id;
> +
> +			resolved_id = resolve_type_id(d, *type_id);
> +			new_id = d->hypot_map[resolved_id];
> +			if (new_id > BTF_MAX_NR_TYPES)
> +				return -EINVAL;
>  
> -		r = btf_type_visit_type_ids(t, btf_dedup_remap_type_id, d);
> -		if (r)
> -			return r;
> +			*type_id = new_id;
> +		}
>  	}
>  
>  	if (!d->btf_ext)
> @@ -5003,134 +5021,166 @@ struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_bt
>  	return btf__parse_split(path, vmlinux_btf);
>  }
>  
> -int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit, void *ctx)
> +int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t, enum btf_field_iter_kind iter_kind)
>  {
> -	int i, n, err;
> -
> -	switch (btf_kind(t)) {
> -	case BTF_KIND_INT:
> -	case BTF_KIND_FLOAT:
> -	case BTF_KIND_ENUM:
> -	case BTF_KIND_ENUM64:
> -		return 0;
> +	it->p = NULL;
> +	it->m_idx = -1;
> +	it->off_idx = 0;
> +	it->vlen = 0;
>  
> -	case BTF_KIND_FWD:
> -	case BTF_KIND_CONST:
> -	case BTF_KIND_VOLATILE:
> -	case BTF_KIND_RESTRICT:
> -	case BTF_KIND_PTR:
> -	case BTF_KIND_TYPEDEF:
> -	case BTF_KIND_FUNC:
> -	case BTF_KIND_VAR:
> -	case BTF_KIND_DECL_TAG:
> -	case BTF_KIND_TYPE_TAG:
> -		return visit(&t->type, ctx);
> -
> -	case BTF_KIND_ARRAY: {
> -		struct btf_array *a = btf_array(t);
> -
> -		err = visit(&a->type, ctx);
> -		err = err ?: visit(&a->index_type, ctx);
> -		return err;
> -	}
> -
> -	case BTF_KIND_STRUCT:
> -	case BTF_KIND_UNION: {
> -		struct btf_member *m = btf_members(t);
> -
> -		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
> -			err = visit(&m->type, ctx);
> -			if (err)
> -				return err;
> -		}
> -		return 0;
> -	}
> -
> -	case BTF_KIND_FUNC_PROTO: {
> -		struct btf_param *m = btf_params(t);
> -
> -		err = visit(&t->type, ctx);
> -		if (err)
> -			return err;
> -		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
> -			err = visit(&m->type, ctx);
> -			if (err)
> -				return err;
> +	switch (iter_kind) {
> +	case BTF_FIELD_ITER_IDS:
> +		switch (btf_kind(t)) {
> +		case BTF_KIND_UNKN:
> +		case BTF_KIND_INT:
> +		case BTF_KIND_FLOAT:
> +		case BTF_KIND_ENUM:
> +		case BTF_KIND_ENUM64:
> +			it->desc = (struct btf_field_desc){};
> +			break;
> +		case BTF_KIND_FWD:
> +		case BTF_KIND_CONST:
> +		case BTF_KIND_VOLATILE:
> +		case BTF_KIND_RESTRICT:
> +		case BTF_KIND_PTR:
> +		case BTF_KIND_TYPEDEF:
> +		case BTF_KIND_FUNC:
> +		case BTF_KIND_VAR:
> +		case BTF_KIND_DECL_TAG:
> +		case BTF_KIND_TYPE_TAG:
> +			it->desc = (struct btf_field_desc) { 1, {offsetof(struct btf_type, type)} };
> +			break;
> +		case BTF_KIND_ARRAY:
> +			it->desc = (struct btf_field_desc) {
> +				2, {sizeof(struct btf_type) + offsetof(struct btf_array, type),
> +				    sizeof(struct btf_type) + offsetof(struct btf_array, index_type)}
> +			};
> +			break;
> +		case BTF_KIND_STRUCT:
> +		case BTF_KIND_UNION:
> +			it->desc = (struct btf_field_desc) {
> +				0, {},
> +				sizeof(struct btf_member),
> +				1, {offsetof(struct btf_member, type)}
> +			};
> +			break;
> +		case BTF_KIND_FUNC_PROTO:
> +			it->desc = (struct btf_field_desc) {
> +				1, {offsetof(struct btf_type, type)},
> +				sizeof(struct btf_param),
> +				1, {offsetof(struct btf_param, type)}
> +			};
> +			break;
> +		case BTF_KIND_DATASEC:
> +			it->desc = (struct btf_field_desc) {
> +				0, {},
> +				sizeof(struct btf_var_secinfo),
> +				1, {offsetof(struct btf_var_secinfo, type)}
> +			};
> +			break;
> +		default:
> +			return -EINVAL;
>  		}
> -		return 0;
> -	}
> -
> -	case BTF_KIND_DATASEC: {
> -		struct btf_var_secinfo *m = btf_var_secinfos(t);
> -
> -		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
> -			err = visit(&m->type, ctx);
> -			if (err)
> -				return err;
> +		break;
> +	case BTF_FIELD_ITER_STRS:
> +		switch (btf_kind(t)) {
> +		case BTF_KIND_UNKN:
> +			it->desc = (struct btf_field_desc) {};
> +			break;
> +		case BTF_KIND_INT:
> +		case BTF_KIND_FLOAT:
> +		case BTF_KIND_FWD:
> +		case BTF_KIND_ARRAY:
> +		case BTF_KIND_CONST:
> +		case BTF_KIND_VOLATILE:
> +		case BTF_KIND_RESTRICT:
> +		case BTF_KIND_PTR:
> +		case BTF_KIND_TYPEDEF:
> +		case BTF_KIND_FUNC:
> +		case BTF_KIND_VAR:
> +		case BTF_KIND_DECL_TAG:
> +		case BTF_KIND_TYPE_TAG:
> +		case BTF_KIND_DATASEC:
> +			it->desc = (struct btf_field_desc) {
> +				1, {offsetof(struct btf_type, name_off)}
> +			};
> +			break;
> +		case BTF_KIND_ENUM:
> +			it->desc = (struct btf_field_desc) {
> +				1, {offsetof(struct btf_type, name_off)},
> +				sizeof(struct btf_enum),
> +				1, {offsetof(struct btf_enum, name_off)}
> +			};
> +			break;
> +		case BTF_KIND_ENUM64:
> +			it->desc = (struct btf_field_desc) {
> +				1, {offsetof(struct btf_type, name_off)},
> +				sizeof(struct btf_enum64),
> +				1, {offsetof(struct btf_enum64, name_off)}
> +			};
> +			break;
> +		case BTF_KIND_STRUCT:
> +		case BTF_KIND_UNION:
> +			it->desc = (struct btf_field_desc) {
> +				1, {offsetof(struct btf_type, name_off)},
> +				sizeof(struct btf_member),
> +				1, {offsetof(struct btf_member, name_off)}
> +			};
> +			break;
> +		case BTF_KIND_FUNC_PROTO:
> +			it->desc = (struct btf_field_desc) {
> +				1, {offsetof(struct btf_type, name_off)},
> +				sizeof(struct btf_param),
> +				1, {offsetof(struct btf_param, name_off)}
> +			};
> +			break;
> +		default:
> +			return -EINVAL;
>  		}
> -		return 0;
> -	}
> -
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> -}
>  
> -int btf_type_visit_str_offs(struct btf_type *t, str_off_visit_fn visit, void *ctx)
> -{
> -	int i, n, err;
> +	if (it->desc.m_sz)
> +		it->vlen = btf_vlen(t);
>  
> -	err = visit(&t->name_off, ctx);
> -	if (err)
> -		return err;
> +	it->p = t;
> +	return 0;
> +}
>  
> -	switch (btf_kind(t)) {
> -	case BTF_KIND_STRUCT:
> -	case BTF_KIND_UNION: {
> -		struct btf_member *m = btf_members(t);
> +__u32 *btf_field_iter_next(struct btf_field_iter *it)
> +{
> +	if (!it->p)
> +		return NULL;
>  
> -		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
> -			err = visit(&m->name_off, ctx);
> -			if (err)
> -				return err;
> -		}
> -		break;
> +	if (it->m_idx < 0) {
> +		if (it->off_idx < it->desc.t_cnt)
> +			return it->p + it->desc.t_offs[it->off_idx++];
> +		/* move to per-member iteration */
> +		it->m_idx = 0;
> +		it->p += sizeof(struct btf_type);
> +		it->off_idx = 0;
>  	}
> -	case BTF_KIND_ENUM: {
> -		struct btf_enum *m = btf_enum(t);
>  
> -		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
> -			err = visit(&m->name_off, ctx);
> -			if (err)
> -				return err;
> -		}
> -		break;
> +	/* if type doesn't have members, stop */
> +	if (it->desc.m_sz == 0) {
> +		it->p = NULL;
> +		return NULL;
>  	}
> -	case BTF_KIND_ENUM64: {
> -		struct btf_enum64 *m = btf_enum64(t);
>  
> -		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
> -			err = visit(&m->name_off, ctx);
> -			if (err)
> -				return err;
> -		}
> -		break;
> +	if (it->off_idx >= it->desc.m_cnt) {
> +		/* exhausted this member's fields, go to the next member */
> +		it->m_idx++;
> +		it->p += it->desc.m_sz;
> +		it->off_idx = 0;
>  	}
> -	case BTF_KIND_FUNC_PROTO: {
> -		struct btf_param *m = btf_params(t);
>  
> -		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
> -			err = visit(&m->name_off, ctx);
> -			if (err)
> -				return err;
> -		}
> -		break;
> -	}
> -	default:
> -		break;
> -	}
> +	if (it->m_idx < it->vlen)
> +		return it->p + it->desc.m_offs[it->off_idx++];
>  
> -	return 0;
> +	it->p = NULL;
> +	return NULL;
>  }
>  
>  int btf_ext_visit_type_ids(struct btf_ext *btf_ext, type_id_visit_fn visit, void *ctx)
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index a0dcfb82e455..fc55ddce4e07 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -508,11 +508,33 @@ struct bpf_line_info_min {
>  	__u32	line_col;
>  };
>  
> +enum btf_field_iter_kind {
> +	BTF_FIELD_ITER_IDS,
> +	BTF_FIELD_ITER_STRS,
> +};
> +
> +struct btf_field_desc {
> +	/* once-per-type offsets */
> +	int t_cnt, t_offs[2];
> +	/* member struct size, or zero, if no members */
> +	int m_sz;
> +	/* repeated per-member offsets */
> +	int m_cnt, m_offs[1];
> +};
> +
> +struct btf_field_iter {
> +	struct btf_field_desc desc;
> +	void *p;
> +	int m_idx;
> +	int off_idx;
> +	int vlen;
> +};
> +
> +int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t, enum btf_field_iter_kind iter_kind);
> +__u32 *btf_field_iter_next(struct btf_field_iter *it);
>  
>  typedef int (*type_id_visit_fn)(__u32 *type_id, void *ctx);
>  typedef int (*str_off_visit_fn)(__u32 *str_off, void *ctx);
> -int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit, void *ctx);
> -int btf_type_visit_str_offs(struct btf_type *t, str_off_visit_fn visit, void *ctx);
>  int btf_ext_visit_type_ids(struct btf_ext *btf_ext, type_id_visit_fn visit, void *ctx);
>  int btf_ext_visit_str_offs(struct btf_ext *btf_ext, str_off_visit_fn visit, void *ctx);
>  __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 0d4be829551b..c23a85d0edac 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -957,19 +957,31 @@ static int check_btf_str_off(__u32 *str_off, void *ctx)
>  static int linker_sanity_check_btf(struct src_obj *obj)
>  {
>  	struct btf_type *t;
> -	int i, n, err = 0;
> +	int i, n;
>  
>  	if (!obj->btf)
>  		return 0;
>  
>  	n = btf__type_cnt(obj->btf);
>  	for (i = 1; i < n; i++) {
> +		struct btf_field_iter it;
> +		__u32 *type_id, *str_off;
> +		const char *s;
> +
>  		t = btf_type_by_id(obj->btf, i);
>  
> -		err = err ?: btf_type_visit_type_ids(t, check_btf_type_id, obj->btf);
> -		err = err ?: btf_type_visit_str_offs(t, check_btf_str_off, obj->btf);
> -		if (err)
> -			return err;
> +		btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
> +		while ((type_id = btf_field_iter_next(&it))) {
> +			if (*type_id >= n)
> +				return -EINVAL;
> +		}
> +
> +		btf_field_iter_init(&it, t, BTF_FIELD_ITER_STRS);
> +		while ((str_off = btf_field_iter_next(&it))) {
> +			s = btf__str_by_offset(obj->btf, *str_off);
> +			if (!s)
> +				return -EINVAL;
> +		}
>  	}
>  
>  	return 0;
> @@ -2234,22 +2246,6 @@ static int linker_fixup_btf(struct src_obj *obj)
>  	return 0;
>  }
>  
> -static int remap_type_id(__u32 *type_id, void *ctx)
> -{
> -	int *id_map = ctx;
> -	int new_id = id_map[*type_id];
> -
> -	/* Error out if the type wasn't remapped. Ignore VOID which stays VOID. */
> -	if (new_id == 0 && *type_id != 0) {
> -		pr_warn("failed to find new ID mapping for original BTF type ID %u\n", *type_id);
> -		return -EINVAL;
> -	}
> -
> -	*type_id = id_map[*type_id];
> -
> -	return 0;
> -}
> -
>  static int linker_append_btf(struct bpf_linker *linker, struct src_obj *obj)
>  {
>  	const struct btf_type *t;
> @@ -2323,10 +2319,23 @@ static int linker_append_btf(struct bpf_linker *linker, struct src_obj *obj)
>  	/* remap all the types except DATASECs */
>  	n = btf__type_cnt(linker->btf);
>  	for (i = start_id; i < n; i++) {
> +		struct btf_field_iter it;
>  		struct btf_type *dst_t = btf_type_by_id(linker->btf, i);
> +		__u32 *type_id;
>  
> -		if (btf_type_visit_type_ids(dst_t, remap_type_id, obj->btf_type_map))
> -			return -EINVAL;
> +		btf_field_iter_init(&it, dst_t, BTF_FIELD_ITER_IDS);
> +		while ((type_id = btf_field_iter_next(&it))) {
> +			int new_id = obj->btf_type_map[*type_id];
> +
> +			/* Error out if the type wasn't remapped. Ignore VOID which stays VOID. */
> +			if (new_id == 0 && *type_id != 0) {
> +				pr_warn("failed to find new ID mapping for original BTF type ID %u\n",
> +					*type_id);
> +				return -EINVAL;
> +			}
> +
> +			*type_id = obj->btf_type_map[*type_id];
> +		}
>  	}
>  
>  	/* Rewrite VAR/FUNC underlying types (i.e., FUNC's FUNC_PROTO and VAR's
> -- 
> 2.43.0
> 
> 

