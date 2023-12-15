Return-Path: <bpf+bounces-18055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D48B481546A
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 00:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844E0285F7D
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 23:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5297118ECE;
	Fri, 15 Dec 2023 23:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8LQyujJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4542918EC4
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 23:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5de93b677f4so10532467b3.2
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 15:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702682744; x=1703287544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x3qa15Eo9XiATzelOOvbYG1t14N7GxBfgMZWfXnB1dk=;
        b=B8LQyujJWyPAEk0ypsTGFnEBUZbq1IuwfSk4FOf2GLKYBounKrSEy/23V+BxUNsA0M
         sLIdITdaDUFyHiXf4aA8AlYr3UAS1Wj8H02jV2bhEyUEsHfO0OdE1G2NGhHoctJyUcKW
         nC8qSBxrVh88NUmOaci0roWEW0HHcmYetTp7hwy2GPstvBHy7E63fIVdiGP+G2OX1vlC
         OGIiWUncbWgcZk2Rm+AhSdaYkJf/LVDQvQAS9gcisz2aFZANrv7UUAbRMbM695wxnJgn
         HU+YyCHNLEIsarxShYaK/3vTUeM+2JdvCNvfJbepH6x9FG7JgT8NMQ3uhAF8oWVhW21p
         Ytbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702682744; x=1703287544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3qa15Eo9XiATzelOOvbYG1t14N7GxBfgMZWfXnB1dk=;
        b=U3WkFrQvBp1HemwxekeF44Nz/prxvdTamsGakVIs8QqDIU3yFh6UFM2HAiObSWZL3r
         TFioBeJvO7n6AAB2nNWBElLyCDbxwiWeyJm/3+V0XtGx5aN6SWzDTy4pWRkYw6J6Fxp6
         26324oSxr1eU+KjG1d8ashe7iMvbJ1CHGBFLHvfL66k+8kn1DeJFVc/oT03GtHaahiCi
         YJruLO2Lxwwzmc136YpR6ee5JUKxzNjOiTaOSk8rA3XQ/OXMKH8oqGR8AWK5bv+t49rY
         rMLX73Q0tyAjwq9JOZWsXQPyeHAfVgzhPOEm1YlL+ILq14dcxHRkBay/XdqRxrMSIbQM
         ACgA==
X-Gm-Message-State: AOJu0YxlLtOjGmB/LlMteWM999kOcf2DZbM5AKaYKuS0p2XuXbmMkh8Z
	BZFpByJoGKE86LJlcd97XSI=
X-Google-Smtp-Source: AGHT+IGr0R3wMPPlln/5jZsSeQflgXzIAaiL0Qk3t+m69nsP47QLlpBNGHN7zorfwsAJnxxuEGe4Bg==
X-Received: by 2002:a81:a150:0:b0:5e4:72ce:6d1 with SMTP id y77-20020a81a150000000b005e472ce06d1mr1369965ywg.19.1702682744109;
        Fri, 15 Dec 2023 15:25:44 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:cff8:4904:6a61:98b6? ([2600:1700:6cf8:1240:cff8:4904:6a61:98b6])
        by smtp.gmail.com with ESMTPSA id j62-20020a0dc741000000b005da626a84a2sm6701658ywd.30.2023.12.15.15.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 15:25:43 -0800 (PST)
Message-ID: <7ddc9157-1eba-41b1-a3fd-bbf315f9cfb9@gmail.com>
Date: Fri, 15 Dec 2023 15:25:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v13 08/14] bpf: hold module for
 bpf_struct_ops_map.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-9-thinker.li@gmail.com>
 <0a8849cd-b8ca-4219-b7cc-5331c42fc190@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <0a8849cd-b8ca-4219-b7cc-5331c42fc190@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/14/23 21:54, Martin KaFai Lau wrote:
> On 12/8/23 4:27 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> To ensure that a module remains accessible whenever a struct_ops 
>> object of
>> a struct_ops type provided by the module is still in use.
>>
>> struct bpf_strct_ops_map doesn't hold a refcnt to btf anymore sicne a
> 
> s /bpf_strct_/bpf_struct_/
> 
> s/sicne/since/
> 
>> module will hold a refcnt to it's btf already. But, struct_ops 
>> programs are
>> different. They hold their associated btf, not the module since they need
>> only btf to assure their types (signatures).
> 
> The patch subject is not accurate. The patch holds the module refcnt 
> when verifying the bpf prog also. May be "hold module refcnt in 
> struct_ops map creation and prog verification".
> 
> The commit message also is inaccurate on the prog load. It did not 
> mention the module is also held when loading struct_ops prog but it is 
> only held during the verification time. Please explain why it is only 
> needed during the verification time.
> 
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   include/linux/bpf.h          |  1 +
>>   include/linux/bpf_verifier.h |  1 +
>>   kernel/bpf/bpf_struct_ops.c  | 28 +++++++++++++++++++++++-----
>>   kernel/bpf/verifier.c        | 10 ++++++++++
>>   4 files changed, 35 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 91bcd62d6fcf..c5c7cc4552f5 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1681,6 +1681,7 @@ struct bpf_struct_ops {
>>       void (*unreg)(void *kdata);
>>       int (*update)(void *kdata, void *old_kdata);
>>       int (*validate)(void *kdata);
>> +    struct module *owner;
>>       const char *name;
>>       struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
>>   };
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 314b679fb494..01113bcdd479 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -651,6 +651,7 @@ struct bpf_verifier_env {
>>       u32 prev_insn_idx;
>>       struct bpf_prog *prog;        /* eBPF program being verified */
>>       const struct bpf_verifier_ops *ops;
>> +    struct module *attach_btf_mod;    /* The owner module of 
>> prog->aux->attach_btf */
>>       struct bpf_verifier_stack_elem *head; /* stack of verifier 
>> states to be processed */
>>       int stack_size;            /* number of states to be processed */
>>       bool strict_alignment;        /* perform strict pointer 
>> alignment checks */
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index f943f8378e76..a838f7c7d583 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -641,12 +641,15 @@ static void __bpf_struct_ops_map_free(struct 
>> bpf_map *map)
>>           bpf_jit_uncharge_modmem(PAGE_SIZE);
>>       }
>>       bpf_map_area_free(st_map->uvalue);
>> -    btf_put(st_map->btf);
>>       bpf_map_area_free(st_map);
>>   }
>>   static void bpf_struct_ops_map_free(struct bpf_map *map)
>>   {
>> +    struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map 
>> *)map;
>> +
>> +    module_put(st_map->st_ops_desc->st_ops->owner);
> 
> The module_get was not done on st_ops->owner when st_map->btf is 
> btf_vmlinux (i.e. not module). Although it probably does not matter, I 
> would feel more comfortable if it only releases for the things that it 
> did acquire earlier.
> 
>      /* st_ops->owner was acquired during map_alloc to implicitly holds
>       * the btf's refcnt. The acquire was only done when btf_is_module()
>       * st_map->btf cannot be NULL here.
>       */
>      if (btf_is_module(st_map->btf))
>          module_put(st_map->st_ops_desc->st_ops->owner);

Sure! I will update it.

> 
>> +
>>       /* The struct_ops's function may switch to another struct_ops.
>>        *
>>        * For example, bpf_tcp_cc_x->init() may switch to
>> @@ -681,6 +684,7 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>       size_t st_map_size;
>>       struct bpf_struct_ops_map *st_map;
>>       const struct btf_type *t, *vt;
>> +    struct module *mod = NULL;
>>       struct bpf_map *map;
>>       struct btf *btf;
>>       int ret;
>> @@ -690,10 +694,20 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>           btf = btf_get_by_fd(attr->value_type_btf_obj_fd);
>>           if (IS_ERR(btf))
>>               return ERR_PTR(PTR_ERR(btf));
>> -    } else {
>> +
>> +        if (btf != btf_vmlinux) {
>> +            mod = btf_try_get_module(btf);
>> +            if (!mod) {
>> +                btf_put(btf);
>> +                return ERR_PTR(-EINVAL);
>> +            }
>> +        }
>> +        /* mod (NULL for btf_vmlinux) holds a refcnt to btf. We
>> +         * don't need an extra refcnt here.
>> +         */
>> +        btf_put(btf);
>> +    } else
>>           btf = btf_vmlinux;
>> -        btf_get(btf);
>> -    }
>>       st_ops_desc = bpf_struct_ops_find_value(btf, 
>> attr->btf_vmlinux_value_type_id);
>>       if (!st_ops_desc) {
>> @@ -756,7 +770,7 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>   errout_free:
>>       __bpf_struct_ops_map_free(map);
>>   errout:
>> -    btf_put(btf);
>> +    module_put(mod);
>>       return ERR_PTR(ret);
>>   }
>> @@ -886,6 +900,10 @@ static int bpf_struct_ops_map_link_update(struct 
>> bpf_link *link, struct bpf_map
>>       if (!bpf_struct_ops_valid_to_reg(new_map))
>>           return -EINVAL;
>> +    /* The old map is holding the refcount for the owner module.  The
>> +     * ownership of the owner module refcount is going to be
>> +     * transferred from the old map to the new map.
>> +     */
> 
> This part I don't understand. Both old and new map hold its own module's 
> refcount at map_alloc time and release its own module refcnt during 
> map_free().
> Where the module refcount transfer happened?

Sorry! This comment is not more valid. I will remove it.

> 
>>       if (!st_map->st_ops_desc->st_ops->update)
>>           return -EOPNOTSUPP;
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 795c16f9cf57..c303cf2fb5ff 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20079,6 +20079,14 @@ static int check_struct_ops_btf_id(struct 
>> bpf_verifier_env *env)
>>       }
>>       btf = prog->aux->attach_btf;
>> +    if (btf != btf_vmlinux) {
> 
>      if (btf_is_module(btf)) {
> 

Got it!

>> +        /* Make sure st_ops is valid through the lifetime of env */
>> +        env->attach_btf_mod = btf_try_get_module(btf);
>> +        if (!env->attach_btf_mod) {
>> +            verbose(env, "owner module of btf is not found\n");
>> +            return -ENOTSUPP;
>> +        }
>> +    }
>>       btf_id = prog->aux->attach_btf_id;
>>       st_ops_desc = bpf_struct_ops_find(btf, btf_id);
>> @@ -20792,6 +20800,8 @@ int bpf_check(struct bpf_prog **prog, union 
>> bpf_attr *attr, bpfptr_t uattr, __u3
>>           env->prog->expected_attach_type = 0;
>>       *prog = env->prog;
>> +
>> +    module_put(env->attach_btf_mod);
>>   err_unlock:
>>       if (!is_priv)
>>           mutex_unlock(&bpf_verifier_lock);
> 

