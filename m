Return-Path: <bpf+bounces-21750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458B0851C04
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 18:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF67A1F22AAB
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 17:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14E13F9DE;
	Mon, 12 Feb 2024 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6ZTxzBw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888BA3F9CE
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760226; cv=none; b=ueMR/tKP5S8A/9yfjF7T/pi0HPn+IzUyFTCtNugFiSanMvwBzwd4PecqPcbd0GNhbfpVaUubQig1JknKfAqvwZQNc/00AeKYI09v21q5+xmyjGzcgWdLqhztY7daOrvxMB2XEmqL9/6FxQxvPAHX0gryHUEeT0KvMdDbvcViDt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760226; c=relaxed/simple;
	bh=xVxMl9vrUvkn3WCLREztAjLpiJpKh/mJtabZuP4KQWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hv2g3eUC1ZGUg7majB69SK+Zs5Xc7+2xge6kzytoRVZoY2LxpflQBp+F0m/IND7EE4CwOGUCHQMsN6PDa3gbyItngKdtozvkHG8fj38yfSsVFALZeWOr9a1zyXnu/mNuyHMht091YAcXsZF6yHwEZUpr0buksJwm+VvCdfMgfn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6ZTxzBw; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso556505276.2
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 09:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707760223; x=1708365023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uoUFYWfF2r2sgb0abwyPjf+GNTcoAPT+E0f2qU2iCXA=;
        b=W6ZTxzBwAwgGw5EVGLJD28Bxssip1fNNwhuIwA06XNqxFR3rxjyD+zdH2/KbgXDobN
         NWzPKpMUDbDhZJg9Oj21oWZOIqcIHYGE8Lv8nd4WTtHESx/mr412A6XQMGRkU1olMJIZ
         0hlQD5XBRBE5KZiTTP2a+UrEsXP0zbJcB3xxRYrBxD4pI1AaKQKwvBo7Q6dR9C4ceLNt
         nSNiF6m0KrUriYlsrlaRxenDEu6tfL7gmKsLij0+Hkp/67HXDL6CCt1ztX1Gtpry5sPD
         FMiPtTZK+H0PrrURvU0Txe9oFvZCMXpzCGo+934R37ht+APdB5m9bXmzJ7jUkNWt8QZq
         eUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707760223; x=1708365023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uoUFYWfF2r2sgb0abwyPjf+GNTcoAPT+E0f2qU2iCXA=;
        b=UTdx9J3O/7D+YqNTy297o2ylTF1E0SGvwKu2v1OCxvEuNa2BdHokQapUOt0TxmXAcn
         V+aigIVd5rMofk6W7PjvJntgWtyMaAiv820qvp8K9mpEq55mB0vmJT6kJztPd2MUIAB+
         QWkkqLZnglp7Ui6gwiiTs5AT5MiUPW91bau7xN8wi2FtAGPjqS2y7cYCxDk/0mD3ioMB
         lp3IMAk5xN8/6OMnhbBRYgVRenC1A5ZSjwBZ/QS5sONvaXDTk133OrWNuxSZqH8umKHH
         e7JLkZK6gHAWUE3p9gP7NVO18yad0hx0fY5yLOeDB8+cwH/xxerHGKWrqeXT3zeExnUj
         3flA==
X-Gm-Message-State: AOJu0YwXE1krmSA2zOZzjdFTyGs0zq59jpSc55cO77w+Oz281Hiqr84O
	WM2zcWe1LaWU5i6eTVN+KcKE8XtKRTIPplW5YGga4bsQ0AwUaRhu
X-Google-Smtp-Source: AGHT+IGTflLTUL3apWmoH2hw5AEapNg/XT1jR/XNu2fsEhFD63Ir8YsJQmxcjgJMy1jNnT5wsGsZJg==
X-Received: by 2002:a0d:eb54:0:b0:602:b343:60c9 with SMTP id u81-20020a0deb54000000b00602b34360c9mr5284049ywe.26.1707760223441;
        Mon, 12 Feb 2024 09:50:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWW3omzMb8IS9PhieLlh8AJ11oMAaSC/5sB5+2fuMCOFZHoSu45livsOrrusOFEwx/Loi7JSWrSOiB7Kw2DDYmAtDnN2ygMpB2uQl7mRTr6Ih7qJITjir9CNGMWGULYmnG36ee6Ds3vluxAOzhdndF0ObOGgvu5WjmZ97VXbUPeRB0hVsaksMvSlr5eIFEp+ra4/yjhYbZNQpFF782fCnmkWuDRXi1eLeLvGhMpTNOjjNxhRAjgPRkN7IIX9MJ0vzRLpTwjUXfA41ZtnroXkT+zgSUXmt/U0o+Gthwjj4UNufQ=
Received: from ?IPV6:2600:1700:6cf8:1240:e85e:3ff0:f75c:4129? ([2600:1700:6cf8:1240:e85e:3ff0:f75c:4129])
        by smtp.gmail.com with ESMTPSA id w199-20020a0dd4d0000000b006077f869225sm2403ywd.73.2024.02.12.09.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:50:23 -0800 (PST)
Message-ID: <ecded04a-6917-49ee-ae83-e1bfa43bd725@gmail.com>
Date: Mon, 12 Feb 2024 09:50:21 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 3/4] bpf: Create argument information for
 nullable arguments.
Content-Language: en-US
To: Jiri Olsa <olsajiri@gmail.com>, thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 davemarchevsky@meta.com, dvernet@meta.com, kuifeng@meta.com
References: <20240209023750.1153905-1-thinker.li@gmail.com>
 <20240209023750.1153905-4-thinker.li@gmail.com> <ZcoEzyRzxLUWWhw4@krava>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ZcoEzyRzxLUWWhw4@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/12/24 03:45, Jiri Olsa wrote:
> On Thu, Feb 08, 2024 at 06:37:49PM -0800, thinker.li@gmail.com wrote:
> 
> SNIP
> 
>>   enum bpf_struct_ops_state {
>> @@ -1790,6 +1806,7 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>>   			     struct btf *btf,
>>   			     struct bpf_verifier_log *log);
>>   void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
>> +void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc);
>>   #else
>>   #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
>>   static inline bool bpf_try_module_get(const void *data, struct module *owner)
>> @@ -1814,6 +1831,10 @@ static inline void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struc
>>   {
>>   }
>>   
>> +static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc, int len)
>> +{
>> +}
> 
> extra len argument?

Yes, this one should be removed.

> 
> jirka
> 
> 
> SNIP
> 
>> +/* Clean up the arg_info in a struct bpf_struct_ops_desc. */
>> +void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc)
>> +{
>> +	struct bpf_struct_ops_arg_info *arg_info;
>> +	int i;
>> +
>> +	arg_info = st_ops_desc->arg_info;
>> +	if (!arg_info)
>> +		return;
>> +
>> +	for (i = 0; i < btf_type_vlen(st_ops_desc->type); i++)
>> +		kfree(arg_info[i].info);
>> +
>> +	kfree(arg_info);
>> +}
>> +
>>   int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>>   			     struct btf *btf,
>>   			     struct bpf_verifier_log *log)
>>   {
>>   	struct bpf_struct_ops *st_ops = st_ops_desc->st_ops;
>> +	struct bpf_struct_ops_arg_info *arg_info;
>>   	const struct btf_member *member;
>>   	const struct btf_type *t;
>>   	s32 type_id, value_id;
>>   	char value_name[128];
>>   	const char *mname;
>> -	int i;
>> +	int i, err;
>>   
>>   	if (strlen(st_ops->name) + VALUE_PREFIX_LEN >=
>>   	    sizeof(value_name)) {
>> @@ -160,6 +320,17 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>>   	if (!is_valid_value_type(btf, value_id, t, value_name))
>>   		return -EINVAL;
>>   
>> +	arg_info = kcalloc(btf_type_vlen(t), sizeof(*arg_info),
>> +			   GFP_KERNEL);
>> +	if (!arg_info)
>> +		return -ENOMEM;
>> +
>> +	st_ops_desc->arg_info = arg_info;
>> +	st_ops_desc->type = t;
>> +	st_ops_desc->type_id = type_id;
>> +	st_ops_desc->value_id = value_id;
>> +	st_ops_desc->value_type = btf_type_by_id(btf, value_id);
>> +
>>   	for_each_member(i, t, member) {
>>   		const struct btf_type *func_proto;
>>   
>> @@ -167,40 +338,52 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>>   		if (!*mname) {
>>   			pr_warn("anon member in struct %s is not supported\n",
>>   				st_ops->name);
>> -			return -EOPNOTSUPP;
>> +			err = -EOPNOTSUPP;
>> +			goto errout;
>>   		}
>>   
>>   		if (__btf_member_bitfield_size(t, member)) {
>>   			pr_warn("bit field member %s in struct %s is not supported\n",
>>   				mname, st_ops->name);
>> -			return -EOPNOTSUPP;
>> +			err = -EOPNOTSUPP;
>> +			goto errout;
>>   		}
>>   
>>   		func_proto = btf_type_resolve_func_ptr(btf,
>>   						       member->type,
>>   						       NULL);
>> -		if (func_proto &&
>> -		    btf_distill_func_proto(log, btf,
>> +		if (!func_proto)
>> +			continue;
>> +
>> +		if (btf_distill_func_proto(log, btf,
>>   					   func_proto, mname,
>>   					   &st_ops->func_models[i])) {
>>   			pr_warn("Error in parsing func ptr %s in struct %s\n",
>>   				mname, st_ops->name);
>> -			return -EINVAL;
>> +			err = -EINVAL;
>> +			goto errout;
>>   		}
>> +
>> +		err = prepare_arg_info(btf, st_ops->name, mname,
>> +				       func_proto,
>> +				       arg_info + i);
>> +		if (err)
>> +			goto errout;
>>   	}
>>   
>>   	if (st_ops->init(btf)) {
>>   		pr_warn("Error in init bpf_struct_ops %s\n",
>>   			st_ops->name);
>> -		return -EINVAL;
>> +		err = -EINVAL;
>> +		goto errout;
>>   	}
>>   
>> -	st_ops_desc->type_id = type_id;
>> -	st_ops_desc->type = t;
>> -	st_ops_desc->value_id = value_id;
>> -	st_ops_desc->value_type = btf_type_by_id(btf, value_id);
>> -
>>   	return 0;
>> +
>> +errout:
>> +	bpf_struct_ops_desc_release(st_ops_desc);
>> +
>> +	return err;
>>   }
>>   
>>   static int bpf_struct_ops_map_get_next_key(struct bpf_map *map, void *key,
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index db53bb76387e..533f02b92c94 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -1699,6 +1699,13 @@ static void btf_free_struct_meta_tab(struct btf *btf)
>>   static void btf_free_struct_ops_tab(struct btf *btf)
>>   {
>>   	struct btf_struct_ops_tab *tab = btf->struct_ops_tab;
>> +	int i;
>> +
>> +	if (!tab)
>> +		return;
>> +
>> +	for (i = 0; i < tab->cnt; i++)
>> +		bpf_struct_ops_desc_release(&tab->ops[i]);
>>   
>>   	kfree(tab);
>>   	btf->struct_ops_tab = NULL;
>> @@ -6130,6 +6137,26 @@ static bool prog_args_trusted(const struct bpf_prog *prog)
>>   	}
>>   }
>>   
>> +int btf_ctx_arg_offset(struct btf *btf, const struct btf_type *func_proto,
>> +		       u32 arg_no)
>> +{
>> +	const struct btf_param *args;
>> +	const struct btf_type *t;
>> +	int off = 0, i;
>> +	u32 sz;
>> +
>> +	args = btf_params(func_proto);
>> +	for (i = 0; i < arg_no; i++) {
>> +		t = btf_type_by_id(btf, args[i].type);
>> +		t = btf_resolve_size(btf, t, &sz);
>> +		if (IS_ERR(t))
>> +			return PTR_ERR(t);
>> +		off += roundup(sz, 8);
>> +	}
>> +
>> +	return off;
>> +}
>> +
>>   bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>>   		    const struct bpf_prog *prog,
>>   		    struct bpf_insn_access_aux *info)
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index c92d6af7d975..72ca27f49616 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20419,6 +20419,12 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
>>   		}
>>   	}
>>   
>> +	/* btf_ctx_access() used this to provide argument type info */
>> +	prog->aux->ctx_arg_info =
>> +		st_ops_desc->arg_info[member_idx].info;
>> +	prog->aux->ctx_arg_info_size =
>> +		st_ops_desc->arg_info[member_idx].cnt;
>> +
>>   	prog->aux->attach_func_proto = func_proto;
>>   	prog->aux->attach_func_name = mname;
>>   	env->ops = st_ops->verifier_ops;
>> -- 
>> 2.34.1
>>
>>

