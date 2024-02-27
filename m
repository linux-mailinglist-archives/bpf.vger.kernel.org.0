Return-Path: <bpf+bounces-22799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C88D286A1D4
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 22:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED74AB22E76
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 21:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21B814F961;
	Tue, 27 Feb 2024 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIeT0/bI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA012D60B
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 21:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709070434; cv=none; b=ML5PyElLhlg1t2KdA3cIaQQQ0daLm5jrV3Noz79khyxluGG/fc4ZUb5jZadwffo33/G/eEKb8H6dRuS1fvvh13RJrtJdmc/5psaYOOkhVx4C9g1DQhJT+D4tHgBElB2M/MUJUWG2DRzn8VLdETuuTyhtF7+0dNFKfAkMc/DNmEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709070434; c=relaxed/simple;
	bh=5LUNI+L7P3y+V91/39RTW2K4GnSFsQLInpmfjv7PuVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDRXFON0N3vPxhL+YXKMNmb2cvtYrKfFlYvk0ZfqtLVM4lS7pKt9dyywTm8HU/UVcCV99A6kb584bRPsD3kWzSkAiM76s2QtJ++vvgsbXiOGiL72fG9AdrnMPOgv8dDhuIyXKHv/uiIUSUvDdlH7o5V5U+ePw4V2K9S4Sgi2Op0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIeT0/bI; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-608841dfcafso44803887b3.2
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 13:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709070432; x=1709675232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z3k+FPzNBlXbp2ho45iP9PWwLvfSm4PQl3LPAgvYQ0M=;
        b=QIeT0/bISAHU6amftJsrfrPCrmeXHuMkb48qkDf6WVhf63HY7Lp2Lv9tpA8CgXs/dI
         N0Dv/CjrvmTFxDW5kjTbjtgu9UEy08LPx1AXC9eSzZr0vhTRbcYef9vErNyBOewxweEZ
         jedbwRpw1gbX4Z6w1nTnoitY5hONLT/ChEjVusLcixUceQgrDtxKme121GQ8rmslk43R
         wLTXWp6qIS92DZrtAE0YGvUmVouSs5D2JyHs+p31BcDEUOUuYrW4boFqjJoNu3nWrqIu
         LMFBc2sypFPzZ2DamdgVBNH3shIEy2eVNw643M6f/39i6nyHpIEcqOIBlzx8O/iE4Wnv
         b4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709070432; x=1709675232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3k+FPzNBlXbp2ho45iP9PWwLvfSm4PQl3LPAgvYQ0M=;
        b=G623zJr0RY9kFE2APxnytWwVvzqCfFsMs93sa/HOR74O1ByLpT5D7Ejb8Kgq9s73pa
         0rbRP/5dPkc5wJj53dijjprVskp2luCuGYO0hOEoVlW2MidXnkovmPsXSbcxgoy2m5/C
         l6512XavzRfkaUUg1jhhWyedIAR3b5i6ybByOeu2hcmKFjIygVA9iXYXMFi+qzbHBrYV
         lr0aM0jUzqMwONh/yicQM2OKfM6TcL1Y56Ctzjjx5u48SEGk0kLSafDphftwIy0paQzR
         qP18owrx8qZEdPzyLoimdS9+qmABsDWR8jiXxMwddRlSYNzdnZtyvuVanVjGbEfvN+ue
         fBpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWegPP3ZOIabOHakwXrqdwV2Yc4qtRoHvhYJ+yPF/zwvzNQ9YndrZ/As/o3XO5d6bxe/Q5qy/DjOrfBZgEN39op9WTA
X-Gm-Message-State: AOJu0Yz9YCIfGhymrwAY+Ge14lfH61vvpEOzI7CGtIJWWaQq+I08gBK6
	GROnEAhpSMKB7dPutSV7ZmZKXMFFid3crC6IbYl8BTpcw8FB0jmzuf6dMg0P
X-Google-Smtp-Source: AGHT+IFTUwiJNyWOsbzTp6pRpgB9m0eUC6Glae9hWMuyLisZlQCovQbtlX2+eLTEXgevQKBmCwMkQg==
X-Received: by 2002:a81:ae54:0:b0:607:76c6:4ed9 with SMTP id g20-20020a81ae54000000b0060776c64ed9mr3594745ywk.41.1709070431797;
        Tue, 27 Feb 2024 13:47:11 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:76a2:1c3:c564:933e? ([2600:1700:6cf8:1240:76a2:1c3:c564:933e])
        by smtp.gmail.com with ESMTPSA id h127-20020a0df785000000b00607cea349f5sm2011206ywf.36.2024.02.27.13.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 13:47:11 -0800 (PST)
Message-ID: <fdac1d86-9e30-46b3-a1b7-5878dd49b1b8@gmail.com>
Date: Tue, 27 Feb 2024 13:47:09 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/8] libbpf: allow version suffixes (___smth)
 for struct_ops types
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev, void@manifault.com
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-2-eddyz87@gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240227204556.17524-2-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/24 12:45, Eduard Zingerman wrote:
> E.g. allow the following struct_ops definitions:
> 
>      struct bpf_testmod_ops___v1 { int (*test)(void); };
>      struct bpf_testmod_ops___v2 { int (*test)(void); };
> 
>      SEC(".struct_ops.link")
>      struct bpf_testmod_ops___v1 a = { .test = ... }
>      SEC(".struct_ops.link")
>      struct bpf_testmod_ops___v2 b = { .test = ... }
> 
> Where both bpf_testmod_ops__v1 and bpf_testmod_ops__v2 would be
> resolved as 'struct bpf_testmod_ops' from kernel BTF.
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   tools/lib/bpf/libbpf.c | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 01f407591a92..abe663927013 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -948,7 +948,7 @@ static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
>   				   const char *name, __u32 kind);
>   
>   static int
> -find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
> +find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
>   			   struct module_btf **mod_btf,
>   			   const struct btf_type **type, __u32 *type_id,
>   			   const struct btf_type **vtype, __u32 *vtype_id,
> @@ -957,15 +957,21 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
>   	const struct btf_type *kern_type, *kern_vtype;
>   	const struct btf_member *kern_data_member;
>   	struct btf *btf;
> -	__s32 kern_vtype_id, kern_type_id;
> +	__s32 kern_vtype_id, kern_type_id, err;
> +	char *tname;
>   	__u32 i;
>   
> +	tname = strndup(tname_raw, bpf_core_essential_name_len(tname_raw));
> +	if (!tname)
> +		return -ENOMEM;
> +
>   	kern_type_id = find_ksym_btf_id(obj, tname, BTF_KIND_STRUCT,
>   					&btf, mod_btf);
>   	if (kern_type_id < 0) {
>   		pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n",
>   			tname);
> -		return kern_type_id;
> +		err = kern_type_id;
> +		goto err_out;
>   	}
>   	kern_type = btf__type_by_id(btf, kern_type_id);
>   
> @@ -979,7 +985,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
>   	if (kern_vtype_id < 0) {
>   		pr_warn("struct_ops init_kern: struct %s%s is not found in kernel BTF\n",
>   			STRUCT_OPS_VALUE_PREFIX, tname);
> -		return kern_vtype_id;
> +		err = kern_vtype_id;
> +		goto err_out;
>   	}
>   	kern_vtype = btf__type_by_id(btf, kern_vtype_id);
>   
> @@ -997,7 +1004,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
>   	if (i == btf_vlen(kern_vtype)) {
>   		pr_warn("struct_ops init_kern: struct %s data is not found in struct %s%s\n",
>   			tname, STRUCT_OPS_VALUE_PREFIX, tname);
> -		return -EINVAL;
> +		err = -EINVAL;
> +		goto err_out;
>   	}
>   
>   	*type = kern_type;
> @@ -1007,6 +1015,10 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
>   	*data_member = kern_data_member;

Where is going to free tname when it successes?

>   
>   	return 0;
> +
> +err_out:
> +	free(tname);
> +	return err;
>   }
>   
>   static bool bpf_map__is_struct_ops(const struct bpf_map *map)

