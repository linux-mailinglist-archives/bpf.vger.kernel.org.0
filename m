Return-Path: <bpf+bounces-13600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C883A7DBA2F
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 13:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F78628137A
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 12:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047A415E99;
	Mon, 30 Oct 2023 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsmhA6LI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECA6EAD7
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 12:56:37 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEDAC2
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 05:56:36 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so7480432a12.3
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698670594; x=1699275394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SC9OY4LwtuxhvT0PwqjLGNf4dnoK3EoYdTYaMOpKanc=;
        b=JsmhA6LIhfMdlfxKg9hd2FX1cgApyp8Qqgqtw/V4YQ2rqyQYrjJZ1Kr/3LT9+yItVN
         PmF+gtSNdvM33SM18vsS5MTh2rhybBTiU0+zaknk4HFUIU8ejoeWXpmrwNgV32KPiSFD
         MkSVy/+Y6kTxBdUqQ2whPEo+wn27rRMS4zS/v4uZ7ObXLqqdwEMsT9qi0nRsyvWPehA/
         7MOFOrQ2mFuuTSKeWb2E4+jbeVhoHhvzQPwWiyS26rBzauBqcjZ0vi/s4HKvJH1P+7rH
         nxYlGIKzb0g7aj45439ayaljRIrxO3ib1Qmp+2VFelzMOP1T2gTCHsHztUMKjSjt5bI9
         hqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698670594; x=1699275394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC9OY4LwtuxhvT0PwqjLGNf4dnoK3EoYdTYaMOpKanc=;
        b=SHha9Bx4Bh8LlyKPf7CBFZAmV6G/nJ7mHjw0/qlYkPCJIvjLk+KfLHLGrqRkMo9PgC
         IHHf0MPfftPTlaO1l1uQ1nlWXyYTkQmz6LZGqmJsFgQ2CrS27VNXIYwcg+/oCDKY6eSi
         +aqIEIZVWA4XeV8ud2IhFtZhLdU4SB4ze20iRn+XdoZcG0FU6gaVc7mREPfn4KxSEEXr
         CiHwDbQBZU8aivLpJdF+lldSm3hIfaFoOhxtkyY0/vqB9F5tl9Qpx0V01wupNoWeylAY
         HjeuXvcFdeA1zhLpTBImgXPfLbDn4WIk5Xc/YS5xzFZMUPp2jA6Vh9sklhViSOVjUS1P
         EaWw==
X-Gm-Message-State: AOJu0YzvcY6ASRlRcRTtSTILGLFwCMSzU791db9vXYrM8rmJfQ3bz2Ny
	hK/WI7hkQFcRrPKIx02X3x0=
X-Google-Smtp-Source: AGHT+IED2x/KVKrVVFvd28ZywZXHuvQ6T4h0Xs4AWnYumsrSjBUIGvVWNwK2+21nQ5NicMEa8l3DAQ==
X-Received: by 2002:a50:8e13:0:b0:53f:f47f:3d5 with SMTP id 19-20020a508e13000000b0053ff47f03d5mr7873347edw.32.1698670594293;
        Mon, 30 Oct 2023 05:56:34 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id b1-20020a056402138100b0054026e95beesm6054355edv.76.2023.10.30.05.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:56:34 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Oct 2023 13:56:32 +0100
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v1 bpf-next 3/4] btf: Descend into structs and arrays
 during special field search
Message-ID: <ZT+oAHR3YB93H7XQ@krava>
References: <20231023220030.2556229-1-davemarchevsky@fb.com>
 <20231023220030.2556229-4-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023220030.2556229-4-davemarchevsky@fb.com>

On Mon, Oct 23, 2023 at 03:00:29PM -0700, Dave Marchevsky wrote:

SNIP

> -			ret = btf_maybe_find_kptr(btf, member_type, off, srch);
> +			ret = btf_find_aggregate_field(btf, member_type, srch,
> +						       struct_field_off + off,
> +						       rec);
>  			if (ret < 0)
>  				return ret;
>  			continue;
> @@ -3541,15 +3587,17 @@ static int btf_find_struct_field(const struct btf *btf,
>  		case BPF_LIST_NODE:
>  		case BPF_RB_NODE:
>  		case BPF_REFCOUNT:
> -			ret = btf_find_struct(btf, member_type, off, sz, field_type,
> -					      srch);
> +			ret = btf_find_struct(btf, member_type,
> +					      struct_field_off + off,
> +					      sz, field_type, srch);
>  			if (ret < 0)
>  				return ret;
>  			break;
>  		case BPF_LIST_HEAD:
>  		case BPF_RB_ROOT:
>  			ret = btf_find_graph_root(btf, t, member_type,
> -						  i, off, sz, srch, field_type);
> +						  i, struct_field_off + off, sz,
> +						  srch, field_type);
>  			if (ret < 0)
>  				return ret;
>  			break;
> @@ -3566,6 +3614,82 @@ static int btf_find_struct_field(const struct btf *btf,
>  	return srch->idx;
>  }
>  
> +static int btf_flatten_array_field(const struct btf *btf,
> +				   const struct btf_type *t,
> +				   struct btf_field_info_search *srch,
> +				   int array_field_off, int rec)
> +{
> +	int ret, start_idx, elem_field_cnt;
> +	const struct btf_type *elem_type;
> +	struct btf_field_info *info;
> +	u32 i, j, off, nelems;
> +
> +	if (!btf_type_is_array(t))
> +		return -EINVAL;

seems this check is not needed, it's called only for
btf_type_is_array(t)

> +	nelems = __multi_dim_elem_type_nelems(btf, t, &elem_type);
> +	if (!nelems || !__btf_type_is_struct(elem_type))
> +		return srch->idx;
> +
> +	start_idx = srch->idx;
> +	ret = btf_find_struct_field(btf, elem_type, srch, array_field_off + off, rec);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* No btf_field_info's added */
> +	if (srch->idx == start_idx)
> +		return srch->idx;
> +
> +	elem_field_cnt = srch->idx - start_idx;
> +	info = __next_field_infos(srch, elem_field_cnt * (nelems - 1));
> +	if (IS_ERR_OR_NULL(info))
> +		return PTR_ERR(info);
> +
> +	/* Array elems after the first can copy first elem's btf_field_infos
> +	 * and adjust offset
> +	 */
> +	for (i = 1; i < nelems; i++) {
> +		memcpy(info, &srch->infos[start_idx],
> +		       elem_field_cnt * sizeof(struct btf_field_info));
> +		for (j = 0; j < elem_field_cnt; j++) {
> +			info->off += (i * elem_type->size);
> +			info++;
> +		}
> +	}
> +	return srch->idx;
> +}
> +
> +static int btf_find_aggregate_field(const struct btf *btf,
> +				    const struct btf_type *t,
> +				    struct btf_field_info_search *srch,
> +				    int field_off, int rec)
> +{
> +	u32 orig_field_mask;
> +	int ret;
> +
> +	/* Dig up to 4 levels deep */
> +	if (rec >= 4)
> +		return -E2BIG;

do we need to fails in here? should we just stop descend?
and continue the search in upper layers

> +
> +	orig_field_mask = srch->field_mask;
> +	srch->field_mask &= BPF_KPTR;
> +
> +	if (!srch->field_mask) {
> +		ret = 0;
> +		goto reset_field_mask;
> +	}

could this be just

	if (!(srch->field_mask & BPF_KPTR))
		return 0;

but I don't understand why there's the BPF_KPTR restriction in here


jirka

> +
> +	if (__btf_type_is_struct(t))
> +		ret = btf_find_struct_field(btf, t, srch, field_off, rec + 1);
> +	else if (btf_type_is_array(t))
> +		ret = btf_flatten_array_field(btf, t, srch, field_off, rec + 1);
> +	else
> +		ret = -EINVAL;
> +
> +reset_field_mask:
> +	srch->field_mask = orig_field_mask;
> +	return ret;
> +}
> +
>  static int __datasec_vsi_check_align_sz(const struct btf_var_secinfo *vsi,
>  					enum btf_field_type field_type,
>  					u32 expected_sz)
> @@ -3605,10 +3729,19 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
>  			 * btf_maybe_find_kptr will find actual kptr type
>  			 */
>  			sz = btf_field_type_size(BPF_KPTR_REF);
> -			if (__datasec_vsi_check_align_sz(vsi, BPF_KPTR_REF, sz))
> +			if (srch->field_mask & BPF_KPTR &&
> +			    !__datasec_vsi_check_align_sz(vsi, BPF_KPTR_REF, sz)) {
> +				ret = btf_maybe_find_kptr(btf, var_type, off, srch);
> +				if (ret < 0)
> +					return ret;
> +				if (ret == BTF_FIELD_FOUND)
> +					continue;
> +			}
> +
> +			if (!(btf_type_is_array(var_type) || __btf_type_is_struct(var_type)))
>  				continue;
>  
> -			ret = btf_maybe_find_kptr(btf, var_type, off, srch);
> +			ret = btf_find_aggregate_field(btf, var_type, srch, off, 0);
>  			if (ret < 0)
>  				return ret;
>  			continue;
> @@ -3655,7 +3788,7 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
>  			  struct btf_field_info_search *srch)
>  {
>  	if (__btf_type_is_struct(t))
> -		return btf_find_struct_field(btf, t, srch);
> +		return btf_find_struct_field(btf, t, srch, 0, 0);
>  	else if (btf_type_is_datasec(t))
>  		return btf_find_datasec_var(btf, t, srch);
>  	return -EINVAL;
> -- 
> 2.34.1
> 
> 

