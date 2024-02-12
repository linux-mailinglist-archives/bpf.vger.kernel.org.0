Return-Path: <bpf+bounces-21731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A893851287
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 12:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F83B28310A
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 11:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4699B39860;
	Mon, 12 Feb 2024 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki8iF0Nm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D5439FE4
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738325; cv=none; b=WncrSpB+99WLCleFGIlfsz6BiJu2y4MfTfEbYQkcVkIcNhah7qm5/Sr8Rp/dla2Foo7JY7FeHIG+gAc0jFYKZ6wG8ViGCBAZVz8fv67qR3WEoRarUIfuBUarvsgCCTyL1SEvvmjdp6i++gMGCyY/z1BoJ4cbmOzvxvUHGU28du0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738325; c=relaxed/simple;
	bh=sVDJ/EtpbRGHAcpzkw3MVk/+8Pr+Aq01FX8miJaSXL8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7EcXrEtUCjCA66b7/wy4R9aB5PVJmf9WjnTJyRWmRRO+gfsY3LXD9w5qMAPfgdPs2wS96tyuWm0A8c5DNg7zd9zjz9V6+jV+koIH1vtOkjxNBt/S70MbVJh69ZZj+yZ2aA6hneoR0h+mqQ0D4jA5aIpeLRsGs9pmNfy0sar0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ki8iF0Nm; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso4330787a12.3
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 03:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707738322; x=1708343122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/UQS+FsUEF6t5v3hp2JFG6zD8I0GA9IlzjWWopjJx1I=;
        b=ki8iF0NmIyc9I54sP5M91Pk8IfWpfE07/G+5J9E+LzX6qdnxhV0ndxqfclP197s2Ep
         eNil20DFBZG7S0fCvRECWprdsmJb+XhkUyuUk+mNtjSS6dGwP0TD1CO31ohJbQBe9+sK
         JUh2HbviVY9p71eBLtDMViyETCJFRRDE1ox0FCAL1RmyTL/7eME36zqZt35PLxNz7NJ4
         GzWw8oNz4Zghn0fIse2EyHek00XIYZFLBfUnlpkQlK6xK+giz5WI1VB+Iagg6NlXKBY1
         UaQOudNb9cin7u6DGIdZIZc3p9Di7vhjASudN1Ef2LjSTo0QQjdNtH/5WTHYge6sPNIj
         p5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738322; x=1708343122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UQS+FsUEF6t5v3hp2JFG6zD8I0GA9IlzjWWopjJx1I=;
        b=Xy179+6ob4nymNzjxgtnHA/ZDcmINAqU5rOIrhq/o2fKeIyA7Ut6tkdvNy3lX8LFJm
         iODKZ+u9OHA545pnsTV5ORPgNaJTx9xWSkzzlbEJQtW2x7h+e209TWagnBI624pMMFfF
         EevUpFoX55h7F0+99NQXlNBj2SEDjA8rbYVc4x6lVsgPQtSm6rc+nYIl4k9klFXFyF31
         tL+NK9iWZfIpZKQhqEPkp5fSzHfNVjhkjVG2BqDhKNYmtO750H4SwFjAsH5M9Etkh9Mu
         74dhjGTbCQ08pIvLO+qHnWK/xjqRiBbF9whSpH04OkkQzH0jdngW5RIIMDY4q7ObB7lH
         1ifg==
X-Gm-Message-State: AOJu0YzT02y6QBITs1MMZvRyIX6uXXH45YbI5FFnzZl/kcv6THZkFFFt
	r/KWWabvUMKTEMrqvP1U0q1W+gjVuY83F8o+EMeWW0tZhf5rQlgz
X-Google-Smtp-Source: AGHT+IHI+WcJIpqELDy8RGM66tpEtzKyoRTJVU5B+eg3WFHk0UGxbPwQWArmZgUCP3NuW+7+g7FLng==
X-Received: by 2002:a17:906:ae5a:b0:a3c:af1a:fac4 with SMTP id lf26-20020a170906ae5a00b00a3caf1afac4mr1149685ejb.5.1707738321992;
        Mon, 12 Feb 2024 03:45:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfAKnsDouwPSf9HdSSxX2+NIRw4Fsd4foWhW3zhvaQiGbeUatA8+b46vsNuuDs/3x9B0GKUTVf/ozDRv9w8xMr/47Y7M6BHc4hclqt5TexGQ2AMFeVB/j0/5LdOuKgadcSsTTBgtRSFx76KATZSa9FGL4nWserZhjXlkFedarSp61yTnUG6kWpP7EtEngJneNhKEYnUPA3XeDcBaFY9Xg18JjrvpFgTJkYv2WkVaT3fHiK+D8UT37Lmwj0tnEAn6CGXXoTN2W0w+tn5HTPAHztrKE73egFf8JU57ddWPYRfw==
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id i8-20020a170906250800b00a37624d003fsm123429ejb.121.2024.02.12.03.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:45:21 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 12 Feb 2024 12:45:19 +0100
To: thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
	song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
	davemarchevsky@meta.com, dvernet@meta.com, sinquersw@gmail.com,
	kuifeng@meta.com
Subject: Re: [PATCH bpf-next v8 3/4] bpf: Create argument information for
 nullable arguments.
Message-ID: <ZcoEzyRzxLUWWhw4@krava>
References: <20240209023750.1153905-1-thinker.li@gmail.com>
 <20240209023750.1153905-4-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209023750.1153905-4-thinker.li@gmail.com>

On Thu, Feb 08, 2024 at 06:37:49PM -0800, thinker.li@gmail.com wrote:

SNIP

>  enum bpf_struct_ops_state {
> @@ -1790,6 +1806,7 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>  			     struct btf *btf,
>  			     struct bpf_verifier_log *log);
>  void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
> +void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc);
>  #else
>  #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
>  static inline bool bpf_try_module_get(const void *data, struct module *owner)
> @@ -1814,6 +1831,10 @@ static inline void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struc
>  {
>  }
>  
> +static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc, int len)
> +{
> +}

extra len argument?

jirka


SNIP

> +/* Clean up the arg_info in a struct bpf_struct_ops_desc. */
> +void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc)
> +{
> +	struct bpf_struct_ops_arg_info *arg_info;
> +	int i;
> +
> +	arg_info = st_ops_desc->arg_info;
> +	if (!arg_info)
> +		return;
> +
> +	for (i = 0; i < btf_type_vlen(st_ops_desc->type); i++)
> +		kfree(arg_info[i].info);
> +
> +	kfree(arg_info);
> +}
> +
>  int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>  			     struct btf *btf,
>  			     struct bpf_verifier_log *log)
>  {
>  	struct bpf_struct_ops *st_ops = st_ops_desc->st_ops;
> +	struct bpf_struct_ops_arg_info *arg_info;
>  	const struct btf_member *member;
>  	const struct btf_type *t;
>  	s32 type_id, value_id;
>  	char value_name[128];
>  	const char *mname;
> -	int i;
> +	int i, err;
>  
>  	if (strlen(st_ops->name) + VALUE_PREFIX_LEN >=
>  	    sizeof(value_name)) {
> @@ -160,6 +320,17 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>  	if (!is_valid_value_type(btf, value_id, t, value_name))
>  		return -EINVAL;
>  
> +	arg_info = kcalloc(btf_type_vlen(t), sizeof(*arg_info),
> +			   GFP_KERNEL);
> +	if (!arg_info)
> +		return -ENOMEM;
> +
> +	st_ops_desc->arg_info = arg_info;
> +	st_ops_desc->type = t;
> +	st_ops_desc->type_id = type_id;
> +	st_ops_desc->value_id = value_id;
> +	st_ops_desc->value_type = btf_type_by_id(btf, value_id);
> +
>  	for_each_member(i, t, member) {
>  		const struct btf_type *func_proto;
>  
> @@ -167,40 +338,52 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>  		if (!*mname) {
>  			pr_warn("anon member in struct %s is not supported\n",
>  				st_ops->name);
> -			return -EOPNOTSUPP;
> +			err = -EOPNOTSUPP;
> +			goto errout;
>  		}
>  
>  		if (__btf_member_bitfield_size(t, member)) {
>  			pr_warn("bit field member %s in struct %s is not supported\n",
>  				mname, st_ops->name);
> -			return -EOPNOTSUPP;
> +			err = -EOPNOTSUPP;
> +			goto errout;
>  		}
>  
>  		func_proto = btf_type_resolve_func_ptr(btf,
>  						       member->type,
>  						       NULL);
> -		if (func_proto &&
> -		    btf_distill_func_proto(log, btf,
> +		if (!func_proto)
> +			continue;
> +
> +		if (btf_distill_func_proto(log, btf,
>  					   func_proto, mname,
>  					   &st_ops->func_models[i])) {
>  			pr_warn("Error in parsing func ptr %s in struct %s\n",
>  				mname, st_ops->name);
> -			return -EINVAL;
> +			err = -EINVAL;
> +			goto errout;
>  		}
> +
> +		err = prepare_arg_info(btf, st_ops->name, mname,
> +				       func_proto,
> +				       arg_info + i);
> +		if (err)
> +			goto errout;
>  	}
>  
>  	if (st_ops->init(btf)) {
>  		pr_warn("Error in init bpf_struct_ops %s\n",
>  			st_ops->name);
> -		return -EINVAL;
> +		err = -EINVAL;
> +		goto errout;
>  	}
>  
> -	st_ops_desc->type_id = type_id;
> -	st_ops_desc->type = t;
> -	st_ops_desc->value_id = value_id;
> -	st_ops_desc->value_type = btf_type_by_id(btf, value_id);
> -
>  	return 0;
> +
> +errout:
> +	bpf_struct_ops_desc_release(st_ops_desc);
> +
> +	return err;
>  }
>  
>  static int bpf_struct_ops_map_get_next_key(struct bpf_map *map, void *key,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index db53bb76387e..533f02b92c94 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1699,6 +1699,13 @@ static void btf_free_struct_meta_tab(struct btf *btf)
>  static void btf_free_struct_ops_tab(struct btf *btf)
>  {
>  	struct btf_struct_ops_tab *tab = btf->struct_ops_tab;
> +	int i;
> +
> +	if (!tab)
> +		return;
> +
> +	for (i = 0; i < tab->cnt; i++)
> +		bpf_struct_ops_desc_release(&tab->ops[i]);
>  
>  	kfree(tab);
>  	btf->struct_ops_tab = NULL;
> @@ -6130,6 +6137,26 @@ static bool prog_args_trusted(const struct bpf_prog *prog)
>  	}
>  }
>  
> +int btf_ctx_arg_offset(struct btf *btf, const struct btf_type *func_proto,
> +		       u32 arg_no)
> +{
> +	const struct btf_param *args;
> +	const struct btf_type *t;
> +	int off = 0, i;
> +	u32 sz;
> +
> +	args = btf_params(func_proto);
> +	for (i = 0; i < arg_no; i++) {
> +		t = btf_type_by_id(btf, args[i].type);
> +		t = btf_resolve_size(btf, t, &sz);
> +		if (IS_ERR(t))
> +			return PTR_ERR(t);
> +		off += roundup(sz, 8);
> +	}
> +
> +	return off;
> +}
> +
>  bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  		    const struct bpf_prog *prog,
>  		    struct bpf_insn_access_aux *info)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c92d6af7d975..72ca27f49616 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20419,6 +20419,12 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
>  		}
>  	}
>  
> +	/* btf_ctx_access() used this to provide argument type info */
> +	prog->aux->ctx_arg_info =
> +		st_ops_desc->arg_info[member_idx].info;
> +	prog->aux->ctx_arg_info_size =
> +		st_ops_desc->arg_info[member_idx].cnt;
> +
>  	prog->aux->attach_func_proto = func_proto;
>  	prog->aux->attach_func_name = mname;
>  	env->ops = st_ops->verifier_ops;
> -- 
> 2.34.1
> 
> 

