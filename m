Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF494DE9E7
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 18:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiCSR5A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 13:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiCSR47 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 13:56:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC2E1ADA6
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 10:55:38 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p8so12160062pfh.8
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 10:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KOvNBj9xZOZ9A0YNO9ZlocMh7zYARV0x+lbblrSV6HU=;
        b=lxKMtx5Z6DNVN6vDRxnHwo7LvcCHAdGTEtrhMsrwlFaESmpTBBqoo3vo2C5C/bC+Ou
         CvsEXM81wY6tPifoC5vXN4X9XG7zjE91tDLvht/h2aX3Mkd5Cg1S816cESsUVSE/GsdH
         V8tJlHHrsd9eU3Zp4dg0NeUL+zt/GCpxu/Ig0DLKfHlal11vySafnqIV0hzKUta2eMTd
         ENib0DU/nChMl0xgVyU73gBDYy/1qnvyKYy14Jm/kp1b0NZw1nxPu7nP/iX6H3GYdq3T
         FyxIzJtlU6EqMKL+FCwiF9m7OpqN5J6rLlWytiTSCm/g7lO2dLRfm5SIlRCsukLxtix7
         jr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KOvNBj9xZOZ9A0YNO9ZlocMh7zYARV0x+lbblrSV6HU=;
        b=EPy04rMp75e28DRitm/fmvNFfogBOAR0ffwp6vDVDRGgE8MfZqKaAdTk8wP5O+2wPq
         LhNp48J73qRjKvEykf03JCEsWefKDHUK/SuD/d1Elubd2AiFWwL4gC462AE7qgZa4YTp
         xBXD0ogsPkrV32xallslq2pBLnMMhhBI9m2NwnE8+Hlo6sZmyYZVqIpRkYeQj8yG1Pf0
         dimYlHDPOtP8ACJ1lvH2nb/56VEAlYEutsjqh/mX/gdGJofjmYSZiADVwLjyY7b+dOTr
         Wok6TA2CfhkfsO58ufymOfm2J0PeCS01h2xdQtegF6LscNyciJXMxva78GafThEK1Tsr
         A2/g==
X-Gm-Message-State: AOAM530uY2VktypFTRw3oCVrA8W7EeO0Ocy2GZFjwV+wFZ3Jr1xYoyMv
        R+YR6P3iWTfws6DP2CxL9rFDSV3USa4=
X-Google-Smtp-Source: ABdhPJwiCwyvdjQNG7n40zawr8mc7KB1b4/Zq6fUU1HwfgIiLT279/pgLwPkzQEzZpbK2jdFN6SWtA==
X-Received: by 2002:a05:6a00:230b:b0:4fa:7ca6:b1d5 with SMTP id h11-20020a056a00230b00b004fa7ca6b1d5mr5532609pfh.11.1647712537306;
        Sat, 19 Mar 2022 10:55:37 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:a65d])
        by smtp.gmail.com with ESMTPSA id 96-20020a17090a09e900b001c6dc775159sm2253684pjo.46.2022.03.19.10.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 10:55:36 -0700 (PDT)
Date:   Sat, 19 Mar 2022 10:55:34 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v2 02/15] bpf: Make btf_find_field more generic
Message-ID: <20220319175534.blttnx6vexrctych@ast-mbp.dhcp.thefacebook.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
 <20220317115957.3193097-3-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317115957.3193097-3-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 17, 2022 at 05:29:44PM +0530, Kumar Kartikeya Dwivedi wrote:
> Next commit's field type will not be struct, but pointer, and it will
> not be limited to one offset, but multiple ones. Make existing
> btf_find_struct_field and btf_find_datasec_var functions amenable to use
> for finding BTF ID pointers in map value, by taking a moving spin_lock
> and timer specific checks into their own function.
> 
> The alignment, and name are checked before the function is called, so it
> is the last point where we can skip field or return an error before the
> next loop iteration happens. This is important, because we'll be
> potentially reallocating memory inside this function in next commit, so
> being able to do that when everything else is in order is going to be
> more convenient.
> 
> The name parameter is now optional, and only checked if it is not NULL.
> 
> The size must be checked in the function, because in case of PTR it will
> instead point to the underlying BTF ID it is pointing to (or modifiers),
> so the check becomes wrong to do outside of function, and the base type
> has to be obtained by removing modifiers.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/btf.c | 120 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 86 insertions(+), 34 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 17b9adcd88d3..5b2824332880 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3161,71 +3161,109 @@ static void btf_struct_log(struct btf_verifier_env *env,
>  	btf_verifier_log(env, "size=%u vlen=%u", t->size, btf_type_vlen(t));
>  }
>  
> +enum {
> +	BTF_FIELD_SPIN_LOCK,
> +	BTF_FIELD_TIMER,
> +};
> +
> +struct btf_field_info {
> +	u32 off;
> +};
> +
> +static int btf_find_field_struct(const struct btf *btf, const struct btf_type *t,
> +				 u32 off, int sz, struct btf_field_info *info)
> +{
> +	if (!__btf_type_is_struct(t))
> +		return 0;
> +	if (t->size != sz)
> +		return 0;
> +	if (info->off != -ENOENT)
> +		/* only one such field is allowed */
> +		return -E2BIG;
> +	info->off = off;
> +	return 0;
> +}
> +
>  static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t,
> -				 const char *name, int sz, int align)
> +				 const char *name, int sz, int align, int field_type,
> +				 struct btf_field_info *info)
>  {
>  	const struct btf_member *member;
> -	u32 i, off = -ENOENT;
> +	u32 i, off;
> +	int ret;
>  
>  	for_each_member(i, t, member) {
>  		const struct btf_type *member_type = btf_type_by_id(btf,
>  								    member->type);
> -		if (!__btf_type_is_struct(member_type))
> -			continue;
> -		if (member_type->size != sz)
> -			continue;
> -		if (strcmp(__btf_name_by_offset(btf, member_type->name_off), name))
> -			continue;
> -		if (off != -ENOENT)
> -			/* only one such field is allowed */
> -			return -E2BIG;
> +
>  		off = __btf_member_bit_offset(t, member);
> +
> +		if (name && strcmp(__btf_name_by_offset(btf, member_type->name_off), name))
> +			continue;
>  		if (off % 8)
>  			/* valid C code cannot generate such BTF */
>  			return -EINVAL;
>  		off /= 8;
>  		if (off % align)
>  			return -EINVAL;
> +
> +		switch (field_type) {
> +		case BTF_FIELD_SPIN_LOCK:
> +		case BTF_FIELD_TIMER:

Since spin_lock vs timer is passed into btf_find_struct_field() as field_type
argument there is no need to pass name, sz, align from the caller.
Pls make btf_find_spin_lock() to pass BTF_FIELD_SPIN_LOCK only
and in the above code do something like:
 switch (field_type) {
 case BTF_FIELD_SPIN_LOCK:
     name = "bpf_spin_lock";
     sz = ...
     break;
 case BTF_FIELD_TIMER:
     name = "bpf_timer";
     sz = ...
     break;
 }
 switch (field_type) {
 case BTF_FIELD_SPIN_LOCK:
 case BTF_FIELD_TIMER:
	if (!__btf_type_is_struct(member_type))
		continue;
	if (strcmp(__btf_name_by_offset(btf, member_type->name_off), name))
        ...
        btf_find_field_struct(btf, member_type, off, sz, info);
 }

It will cleanup the later patch which passes NULL, sizeof(u64), alignof(u64)
only to pass something into the function.
With above suggestion it wouldn't need to pass dummy args. BTF_FIELD_KPTR will be enough.

> +			ret = btf_find_field_struct(btf, member_type, off, sz, info);
> +			if (ret < 0)
> +				return ret;
> +			break;
> +		default:
> +			return -EFAULT;
> +		}
>  	}
> -	return off;
> +	return 0;
>  }
>  
>  static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
> -				const char *name, int sz, int align)
> +				const char *name, int sz, int align, int field_type,
> +				struct btf_field_info *info)
>  {
>  	const struct btf_var_secinfo *vsi;
> -	u32 i, off = -ENOENT;
> +	u32 i, off;
> +	int ret;
>  
>  	for_each_vsi(i, t, vsi) {
>  		const struct btf_type *var = btf_type_by_id(btf, vsi->type);
>  		const struct btf_type *var_type = btf_type_by_id(btf, var->type);
>  
> -		if (!__btf_type_is_struct(var_type))
> -			continue;
> -		if (var_type->size != sz)
> +		off = vsi->offset;
> +
> +		if (name && strcmp(__btf_name_by_offset(btf, var_type->name_off), name))
>  			continue;
>  		if (vsi->size != sz)
>  			continue;
> -		if (strcmp(__btf_name_by_offset(btf, var_type->name_off), name))
> -			continue;
> -		if (off != -ENOENT)
> -			/* only one such field is allowed */
> -			return -E2BIG;
> -		off = vsi->offset;
>  		if (off % align)
>  			return -EINVAL;
> +
> +		switch (field_type) {
> +		case BTF_FIELD_SPIN_LOCK:
> +		case BTF_FIELD_TIMER:
> +			ret = btf_find_field_struct(btf, var_type, off, sz, info);
> +			if (ret < 0)
> +				return ret;
> +			break;
> +		default:
> +			return -EFAULT;
> +		}
>  	}
> -	return off;
> +	return 0;
>  }
>  
>  static int btf_find_field(const struct btf *btf, const struct btf_type *t,
> -			  const char *name, int sz, int align)
> +			  const char *name, int sz, int align, int field_type,
> +			  struct btf_field_info *info)
>  {
> -
>  	if (__btf_type_is_struct(t))
> -		return btf_find_struct_field(btf, t, name, sz, align);
> +		return btf_find_struct_field(btf, t, name, sz, align, field_type, info);
>  	else if (btf_type_is_datasec(t))
> -		return btf_find_datasec_var(btf, t, name, sz, align);
> +		return btf_find_datasec_var(btf, t, name, sz, align, field_type, info);
>  	return -EINVAL;
>  }
>  
> @@ -3235,16 +3273,30 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
>   */
>  int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t)
>  {
> -	return btf_find_field(btf, t, "bpf_spin_lock",
> -			      sizeof(struct bpf_spin_lock),
> -			      __alignof__(struct bpf_spin_lock));
> +	struct btf_field_info info = { .off = -ENOENT };
> +	int ret;
> +
> +	ret = btf_find_field(btf, t, "bpf_spin_lock",
> +			     sizeof(struct bpf_spin_lock),
> +			     __alignof__(struct bpf_spin_lock),
> +			     BTF_FIELD_SPIN_LOCK, &info);
> +	if (ret < 0)
> +		return ret;
> +	return info.off;
>  }
>  
>  int btf_find_timer(const struct btf *btf, const struct btf_type *t)
>  {
> -	return btf_find_field(btf, t, "bpf_timer",
> -			      sizeof(struct bpf_timer),
> -			      __alignof__(struct bpf_timer));
> +	struct btf_field_info info = { .off = -ENOENT };
> +	int ret;
> +
> +	ret = btf_find_field(btf, t, "bpf_timer",
> +			     sizeof(struct bpf_timer),
> +			     __alignof__(struct bpf_timer),
> +			     BTF_FIELD_TIMER, &info);
> +	if (ret < 0)
> +		return ret;
> +	return info.off;
>  }
>  
>  static void __btf_struct_show(const struct btf *btf, const struct btf_type *t,
> -- 
> 2.35.1
> 

-- 
