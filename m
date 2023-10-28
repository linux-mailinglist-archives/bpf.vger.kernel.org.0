Return-Path: <bpf+bounces-13554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 248CD7DA799
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 16:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F14D1C20A0B
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 14:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD024156F8;
	Sat, 28 Oct 2023 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hB2yTmFg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF73C22
	for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 14:52:13 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0DCCC
	for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 07:52:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e855d7dacso4821228a12.0
        for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 07:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698504730; x=1699109530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C3sOrKXtdkYN1kNphCstbIX2JMS94mKwJnBvVNI9yew=;
        b=hB2yTmFgutlPaRpoiBIj2dyLDlBw+6mJ61q+7NwR3DuYYqDACVe8JuhIrTTdjxlmnf
         pyKBpP+RLCCIxtA1378Xe/BGCJdUBVj/JHvaCWp5/fjMplQBEd0UkladyNMvgvgCSeQK
         eecEoud5o/z/QXgKrSJhNyLzGfual/sHib1uUh7quruJFYUBMIqghvTpk02x9CzX8a56
         Lp59Llh3VyM1/sjZ4qG+JSU8/OutZONd6GERkM6wocBSqcdE3OW/EirY8VRbpxhy5iyh
         +GV+AQl/pJKlou5jmuNnvx1Bsq6nMGstChwMf/m3vciUTnDj5WPzO1stBv4ytyUTh2uc
         mAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698504730; x=1699109530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3sOrKXtdkYN1kNphCstbIX2JMS94mKwJnBvVNI9yew=;
        b=smfoxLGiokxVdDkyVfpn4JYQKbbcqAXHNh616fffuazdKmRNwNl+CqzZi8DghUplvt
         EMYGPhBL0kVjsqiITXAbB7KMtUEFeLNY2OdZmRH6m4L9Rc6cUgmNxfp0Q/H6U+nfS6l9
         YRZLK76vUcV/8wCy+LhvO0j6fdmEkMKK4XMvH2FywGBH7dX5OaGOxr6vp2p4OYJ4Ze/3
         E23dguvC9cnht+7OOR7HWexmToFNaR4cywaDAy43WQjyUGRVObbc/RFPd0QxoEEIVhgi
         ytnizVMd5sXWrcqA/wo2rLYTmllveE1Uj95OBMYWEnXJ2D/bdtkKqyH93TGKHpPObxAW
         zKoQ==
X-Gm-Message-State: AOJu0YzPPiadvZ8x2GB3PuS9lwhPgtBUCq967tsv8cplz6Jw0CP/v507
	Aldc4mvIOjsY9uHZ3bJNvzc=
X-Google-Smtp-Source: AGHT+IFfA/ugjp0gGiUagGrnPtbyKo58sdZzGbNIvFZQWqQwoujhmPpjLFJsE/UCo1XXBLPtv018Hg==
X-Received: by 2002:a05:6402:1843:b0:533:c75a:6f6 with SMTP id v3-20020a056402184300b00533c75a06f6mr3950572edy.12.1698504729618;
        Sat, 28 Oct 2023 07:52:09 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p19-20020a50cd93000000b0053e8bb112adsm3040388edi.53.2023.10.28.07.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 07:52:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 28 Oct 2023 16:52:07 +0200
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v1 bpf-next 2/4] bpf: Refactor btf_find_field with
 btf_field_info_search
Message-ID: <ZT0gF7kRnen7x14H@krava>
References: <20231023220030.2556229-1-davemarchevsky@fb.com>
 <20231023220030.2556229-3-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023220030.2556229-3-davemarchevsky@fb.com>

On Mon, Oct 23, 2023 at 03:00:28PM -0700, Dave Marchevsky wrote:

SNIP

>  
>  #undef field_mask_test_name_check_seen
>  #undef field_mask_test_name
>  
> +static int __struct_member_check_align(u32 off, enum btf_field_type field_type)
> +{
> +	u32 align = btf_field_type_align(field_type);
> +
> +	if (off % align)
> +		return -EINVAL;
> +	return 0;
> +}
> +
>  static int btf_find_struct_field(const struct btf *btf,
> -				 const struct btf_type *t, u32 field_mask,
> -				 struct btf_field_info *info, int info_cnt)
> +				 const struct btf_type *t,
> +				 struct btf_field_info_search *srch)
>  {
> -	int ret, idx = 0, align, sz, field_type;
>  	const struct btf_member *member;
> -	struct btf_field_info tmp;
> -	u32 i, off, seen_mask = 0;
> +	int ret, field_type;
> +	u32 i, off, sz;
>  
>  	for_each_member(i, t, member) {
>  		const struct btf_type *member_type = btf_type_by_id(btf,
>  								    member->type);
> -
> -		field_type = btf_get_field_type(__btf_name_by_offset(btf, member_type->name_off),
> -						field_mask, &seen_mask, &align, &sz);
> -		if (field_type == 0)
> -			continue;
> -		if (field_type < 0)
> -			return field_type;
> -
>  		off = __btf_member_bit_offset(t, member);
>  		if (off % 8)
>  			/* valid C code cannot generate such BTF */
>  			return -EINVAL;
>  		off /= 8;
> -		if (off % align)
> +
> +		field_type = btf_get_field_type_by_name(btf, member_type, srch);
> +		if (field_type < 0)
> +			return field_type;
> +
> +		if (field_type == 0) {
> +			/* Maybe it's a kptr. Use BPF_KPTR_REF for align
> +			 * checks, all ptrs have same align.
> +			 * btf_maybe_find_kptr will find actual kptr type
> +			 */
> +			if (__struct_member_check_align(off, BPF_KPTR_REF))
> +				continue;
> +
> +			ret = btf_maybe_find_kptr(btf, member_type, off, srch);
> +			if (ret < 0)
> +				return ret;
> +			continue;
> +		}

would it be possible to split the change to:
  - factor the arguments to 'struct btf_field_info_search *srch' and
    passing it to btf_find_field and all related descedant calls
  - factor the allignment handling

I can't see these two changes being dependent on each other,
if that's the case I think the change would be simpler

jirka

> +
> +		sz = btf_field_type_size(field_type);
> +		if (__struct_member_check_align(off, field_type))
>  			continue;
>  
>  		switch (field_type) {
> @@ -3453,64 +3542,81 @@ static int btf_find_struct_field(const struct btf *btf,
>  		case BPF_RB_NODE:
>  		case BPF_REFCOUNT:
>  			ret = btf_find_struct(btf, member_type, off, sz, field_type,
> -					      idx < info_cnt ? &info[idx] : &tmp);
> -			if (ret < 0)
> -				return ret;
> -			break;
> -		case BPF_KPTR_UNREF:
> -		case BPF_KPTR_REF:
> -		case BPF_KPTR_PERCPU:
> -			ret = btf_find_kptr(btf, member_type, off, sz,
> -					    idx < info_cnt ? &info[idx] : &tmp);
> +					      srch);
>  			if (ret < 0)
>  				return ret;
>  			break;
>  		case BPF_LIST_HEAD:
>  		case BPF_RB_ROOT:
>  			ret = btf_find_graph_root(btf, t, member_type,
> -						  i, off, sz,
> -						  idx < info_cnt ? &info[idx] : &tmp,
> -						  field_type);
> +						  i, off, sz, srch, field_type);
>  			if (ret < 0)
>  				return ret;
>  			break;
> +		/* kptr fields are not handled in this switch, see
> +		 * btf_maybe_find_kptr above
> +		 */
> +		case BPF_KPTR_UNREF:
> +		case BPF_KPTR_REF:
> +		case BPF_KPTR_PERCPU:
>  		default:
>  			return -EFAULT;
>  		}
> -
> -		if (ret == BTF_FIELD_IGNORE)
> -			continue;
> -		if (idx >= info_cnt)
> -			return -E2BIG;
> -		++idx;
>  	}
> -	return idx;
> +	return srch->idx;
> +}
> +
> +static int __datasec_vsi_check_align_sz(const struct btf_var_secinfo *vsi,
> +					enum btf_field_type field_type,
> +					u32 expected_sz)
> +{
> +	u32 off, align;
> +
> +	off = vsi->offset;
> +	align = btf_field_type_align(field_type);
> +
> +	if (vsi->size != expected_sz)
> +		return -EINVAL;
> +	if (off % align)
> +		return -EINVAL;
> +
> +	return 0;
>  }
>  
>  static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
> -				u32 field_mask, struct btf_field_info *info,
> -				int info_cnt)
> +				struct btf_field_info_search *srch)
>  {
> -	int ret, idx = 0, align, sz, field_type;
>  	const struct btf_var_secinfo *vsi;
> -	struct btf_field_info tmp;
> -	u32 i, off, seen_mask = 0;
> +	int ret, field_type;
> +	u32 i, off, sz;
>  
>  	for_each_vsi(i, t, vsi) {
>  		const struct btf_type *var = btf_type_by_id(btf, vsi->type);
>  		const struct btf_type *var_type = btf_type_by_id(btf, var->type);
>  
> -		field_type = btf_get_field_type(__btf_name_by_offset(btf, var_type->name_off),
> -						field_mask, &seen_mask, &align, &sz);
> -		if (field_type == 0)
> -			continue;
> +		off = vsi->offset;
> +		field_type = btf_get_field_type_by_name(btf, var_type, srch);
>  		if (field_type < 0)
>  			return field_type;
>  
> -		off = vsi->offset;
> -		if (vsi->size != sz)
> +		if (field_type == 0) {
> +			/* Maybe it's a kptr. Use BPF_KPTR_REF for sz / align
> +			 * checks, all ptrs have same sz / align.
> +			 * btf_maybe_find_kptr will find actual kptr type
> +			 */
> +			sz = btf_field_type_size(BPF_KPTR_REF);
> +			if (__datasec_vsi_check_align_sz(vsi, BPF_KPTR_REF, sz))
> +				continue;
> +
> +			ret = btf_maybe_find_kptr(btf, var_type, off, srch);
> +			if (ret < 0)
> +				return ret;
>  			continue;
> -		if (off % align)
> +		}
> +
> +		sz = btf_field_type_size(field_type);
> +
> +		if (__datasec_vsi_check_align_sz(vsi, field_type, sz))
>  			continue;
>  
>  		switch (field_type) {
> @@ -3520,48 +3626,38 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
>  		case BPF_RB_NODE:
>  		case BPF_REFCOUNT:
>  			ret = btf_find_struct(btf, var_type, off, sz, field_type,
> -					      idx < info_cnt ? &info[idx] : &tmp);
> -			if (ret < 0)
> -				return ret;
> -			break;
> -		case BPF_KPTR_UNREF:
> -		case BPF_KPTR_REF:
> -		case BPF_KPTR_PERCPU:
> -			ret = btf_find_kptr(btf, var_type, off, sz,
> -					    idx < info_cnt ? &info[idx] : &tmp);
> +					      srch);
>  			if (ret < 0)
>  				return ret;
>  			break;
>  		case BPF_LIST_HEAD:
>  		case BPF_RB_ROOT:
>  			ret = btf_find_graph_root(btf, var, var_type,
> -						  -1, off, sz,
> -						  idx < info_cnt ? &info[idx] : &tmp,
> +						  -1, off, sz, srch,
>  						  field_type);
>  			if (ret < 0)
>  				return ret;
>  			break;
> +		/* kptr fields are not handled in this switch, see
> +		 * btf_maybe_find_kptr above
> +		 */
> +		case BPF_KPTR_UNREF:
> +		case BPF_KPTR_REF:
> +		case BPF_KPTR_PERCPU:
>  		default:
>  			return -EFAULT;
>  		}
> -
> -		if (ret == BTF_FIELD_IGNORE)
> -			continue;
> -		if (idx >= info_cnt)
> -			return -E2BIG;
> -		++idx;
>  	}
> -	return idx;
> +	return srch->idx;
>  }
>  
>  static int btf_find_field(const struct btf *btf, const struct btf_type *t,
> -			  u32 field_mask, struct btf_field_info *info,
> -			  int info_cnt)
> +			  struct btf_field_info_search *srch)
>  {
>  	if (__btf_type_is_struct(t))
> -		return btf_find_struct_field(btf, t, field_mask, info, info_cnt);
> +		return btf_find_struct_field(btf, t, srch);
>  	else if (btf_type_is_datasec(t))
> -		return btf_find_datasec_var(btf, t, field_mask, info, info_cnt);
> +		return btf_find_datasec_var(btf, t, srch);
>  	return -EINVAL;
>  }
>  
> @@ -3729,47 +3825,51 @@ static int btf_field_cmp(const void *_a, const void *_b, const void *priv)
>  struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t,
>  				    u32 field_mask, u32 value_size)
>  {
> -	struct btf_field_info info_arr[BTF_FIELDS_MAX];
> +	struct btf_field_info_search srch;
>  	u32 next_off = 0, field_type_size;
> +	struct btf_field_info *info;
>  	struct btf_record *rec;
>  	int ret, i, cnt;
>  
> -	ret = btf_find_field(btf, t, field_mask, info_arr, ARRAY_SIZE(info_arr));
> -	if (ret < 0)
> -		return ERR_PTR(ret);
> -	if (!ret)
> -		return NULL;
> +	memset(&srch, 0, sizeof(srch));
> +	srch.field_mask = field_mask;
> +	ret = btf_find_field(btf, t, &srch);
> +	if (ret <= 0)
> +		goto end_srch;
>  
>  	cnt = ret;
>  	/* This needs to be kzalloc to zero out padding and unused fields, see
>  	 * comment in btf_record_equal.
>  	 */
>  	rec = kzalloc(offsetof(struct btf_record, fields[cnt]), GFP_KERNEL | __GFP_NOWARN);
> -	if (!rec)
> -		return ERR_PTR(-ENOMEM);
> +	if (!rec) {
> +		ret = -ENOMEM;
> +		goto end_srch;
> +	}
>  
>  	rec->spin_lock_off = -EINVAL;
>  	rec->timer_off = -EINVAL;
>  	rec->refcount_off = -EINVAL;
>  	for (i = 0; i < cnt; i++) {
> -		field_type_size = btf_field_type_size(info_arr[i].type);
> -		if (info_arr[i].off + field_type_size > value_size) {
> -			WARN_ONCE(1, "verifier bug off %d size %d", info_arr[i].off, value_size);
> +		info = &srch.infos[i];
> +		field_type_size = btf_field_type_size(info->type);
> +		if (info->off + field_type_size > value_size) {
> +			WARN_ONCE(1, "verifier bug off %d size %d", info->off, value_size);
>  			ret = -EFAULT;
>  			goto end;
>  		}
> -		if (info_arr[i].off < next_off) {
> +		if (info->off < next_off) {
>  			ret = -EEXIST;
>  			goto end;
>  		}
> -		next_off = info_arr[i].off + field_type_size;
> +		next_off = info->off + field_type_size;
>  
> -		rec->field_mask |= info_arr[i].type;
> -		rec->fields[i].offset = info_arr[i].off;
> -		rec->fields[i].type = info_arr[i].type;
> +		rec->field_mask |= info->type;
> +		rec->fields[i].offset = info->off;
> +		rec->fields[i].type = info->type;
>  		rec->fields[i].size = field_type_size;
>  
> -		switch (info_arr[i].type) {
> +		switch (info->type) {
>  		case BPF_SPIN_LOCK:
>  			WARN_ON_ONCE(rec->spin_lock_off >= 0);
>  			/* Cache offset for faster lookup at runtime */
> @@ -3788,17 +3888,17 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
>  		case BPF_KPTR_UNREF:
>  		case BPF_KPTR_REF:
>  		case BPF_KPTR_PERCPU:
> -			ret = btf_parse_kptr(btf, &rec->fields[i], &info_arr[i]);
> +			ret = btf_parse_kptr(btf, &rec->fields[i], info);
>  			if (ret < 0)
>  				goto end;
>  			break;
>  		case BPF_LIST_HEAD:
> -			ret = btf_parse_list_head(btf, &rec->fields[i], &info_arr[i]);
> +			ret = btf_parse_list_head(btf, &rec->fields[i], info);
>  			if (ret < 0)
>  				goto end;
>  			break;
>  		case BPF_RB_ROOT:
> -			ret = btf_parse_rb_root(btf, &rec->fields[i], &info_arr[i]);
> +			ret = btf_parse_rb_root(btf, &rec->fields[i], info);
>  			if (ret < 0)
>  				goto end;
>  			break;
> @@ -3828,10 +3928,13 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
>  
>  	sort_r(rec->fields, rec->cnt, sizeof(struct btf_field), btf_field_cmp,
>  	       NULL, rec);
> +	kfree(srch.infos);
>  
>  	return rec;
>  end:
>  	btf_record_free(rec);
> +end_srch:
> +	kfree(srch.infos);
>  	return ERR_PTR(ret);
>  }
>  
> -- 
> 2.34.1
> 
> 

