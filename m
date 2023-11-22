Return-Path: <bpf+bounces-15711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDD57F5375
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 23:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC042281704
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 22:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EE31CFB5;
	Wed, 22 Nov 2023 22:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGUDUo4I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BAB12A
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 14:34:02 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1f5da5df68eso194276fac.2
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 14:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700692441; x=1701297241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LTyvGhvB2OxkbSaI7uLEdu0Nsv3TNQQOeDdEG6iSln0=;
        b=TGUDUo4IeKWktbkarAZRDEKVvKusWEHEfA3hyJ7gxq6gouy6pNcAeEtG7VmId6afGV
         Zokbb4S4LmrH+PDLoHWNTdl8AyRBsmellU8RcwwH1R+tktOzwPr3wQW9NrnYZgNFy/kg
         FOrMaI7ZFCXWuATppBtsd/Psb9/7A6AlaegketxXdiD/SAU1aVPIG+rWIQsXz/wG8WzD
         c7Yus7/cXF5/2xh5phj17R34lFi0IYEx2s36/1w7mlbx0Uk8pKhGIvkvZJkN0xUN1aIu
         DGXLbRYVQJz3wzuWr8JGhgb4OvXDbYNsNKyBp/0Inb1rb+lzh90fwA1VDPLtkexxJri+
         4bPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700692441; x=1701297241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LTyvGhvB2OxkbSaI7uLEdu0Nsv3TNQQOeDdEG6iSln0=;
        b=dgDVq6L5sEjk+faMkVYsWYCT4RsRQvcNr3QS74yVFQxiEeE2x/O5YR9Hdnc+OK2qGU
         +/dgiJ4gtcj+xxOSfBY7KTauTjHW1R9aUjOwBrsDNNZZvFLM/UT1POjPRRlf21gzbcCM
         ysP16H7pGv+fxRm0wSQgWvwsPjziDhAKYL4XMyGsyk9jEd+nVtwaXuGgM04LTjWXKm2X
         zH/m3Tdr5bo9H90VhGS7EmVrZCDTZIAf3LWrClULmUdkSHy2qmQcKaXSmQnSMZa/OlpQ
         tK5YOm0Zrwn69WPzPmuSt0iwwLA8OhWps/RnFKOYrv/8XbtY9dbQAkvOOkGTOnXBIEzQ
         C+ZA==
X-Gm-Message-State: AOJu0YwMKmFRxcF7Pdzyq5nCIvjQTkZeuoaix+3TB7Plz+nmiIg3CK/c
	vQs4SvkVKOhSasyD6ie2LTzVOHnncKk=
X-Google-Smtp-Source: AGHT+IGOC1oZFDCYLuJWD9GA3tMxKu9/mxOYB2t3CAFjlsV5PQ2q5wCR78SaAtUe53ybx15dZkgSwA==
X-Received: by 2002:a05:6870:1f14:b0:1ea:2d32:d8cd with SMTP id pd20-20020a0568701f1400b001ea2d32d8cdmr4285284oab.42.1700692441193;
        Wed, 22 Nov 2023 14:34:01 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:5a79:4034:522e:2b90? ([2600:1700:6cf8:1240:5a79:4034:522e:2b90])
        by smtp.gmail.com with ESMTPSA id pd10-20020a0568701f0a00b001f948215975sm10270oab.42.2023.11.22.14.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 14:34:00 -0800 (PST)
Message-ID: <180568df-308f-4bc5-8a54-a9f224123429@gmail.com>
Date: Wed, 22 Nov 2023 14:33:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v11 07/13] bpf: pass attached BTF to the
 bpf_struct_ops subsystem
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231106201252.1568931-1-thinker.li@gmail.com>
 <20231106201252.1568931-8-thinker.li@gmail.com>
 <5cbae302-7fa6-5625-921a-c6f548bcc3a2@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <5cbae302-7fa6-5625-921a-c6f548bcc3a2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/9/23 18:04, Martin KaFai Lau wrote:
> On 11/6/23 12:12 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Every kernel module has its BTF, comprising information on types 
>> defined in
>> the module. The BTF fd (attr->value_type_btf_obj_fd) passed from 
>> userspace
> 
> I would highlight this patch (adds) value_type_btf_obj_fd.
> 
>> helps the bpf_struct_ops to lookup type information and description of 
>> the
>> struct_ops type, which is necessary for parsing the layout of map element
>> values and registering maps. The descriptions are looked up by matching a
>> type id (attr->btf_vmlinux_value_type_id) against bpf_struct_ops_desc(s)
>> defined in a BTF. If the struct_ops type is defined in a module, the
>> bpf_struct_ops needs to know the module BTF to lookup the
>> bpf_struct_ops_desc.
>>
>> The bpf_prog includes attach_btf in aux which is passed along with the
>> bpf_attr when loading the program. The purpose of attach_btf is to
> 
> I read it as "attach_btf" is passed in the bpf_attr. This has been in my 
> head for a while. I sort of know what is the actual uapi, so didn't get 
> to it yet.
> 
> We have already discussed a bit of this offline. I think it meant 
> attr->attach_btf_obj_fd here.
> 
> This patch is mainly about how the userspace passing kmod's btf to the 
> kernel during map creation and prog load and also what uapi does it use. 
> The commit message should mention this patch is reusing the existing 
> attr->attach_btf_obj_fd for the userspace to pass the kmod's btf when 
> loading the struct_ops prog. I need to go back to the syscall.c code to 
> figure out and also leap forward to the later libbpf patch to confirm it.
> 
> I depend on the commit message to help the review. It is much 
> appreciated if the commit message is clear and accurate on things like: 
> what it wants to do, how it does it (addition/deletion/changes), and 
> what are the major changes.
Got it! I will rewrite the commit log to make it easier to read the
patch.

> 
>> determine the btf type of attach_btf_id. The attach_btf_id is then 
>> used to
>> identify the traced function for a trace program. In the case of 
>> struct_ops
>> programs, it is used to identify the struct_ops type of the struct_ops
>> object that a program is attached to.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   include/uapi/linux/bpf.h       |  5 +++
>>   kernel/bpf/bpf_struct_ops.c    | 57 ++++++++++++++++++++++++----------
>>   kernel/bpf/syscall.c           |  2 +-
>>   kernel/bpf/verifier.c          |  9 ++++--
>>   tools/include/uapi/linux/bpf.h |  5 +++
>>   5 files changed, 57 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 0f6cdf52b1da..fd20c52606b2 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1398,6 +1398,11 @@ union bpf_attr {
>>            * to using 5 hash functions).
>>            */
>>           __u64    map_extra;
>> +
>> +        __u32   value_type_btf_obj_fd;    /* fd pointing to a BTF
>> +                         * type data for
>> +                         * btf_vmlinux_value_type_id.
>> +                         */
>>       };
>>       struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 4ba6181ed1c4..2fb1b21f989a 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -635,6 +635,7 @@ static void __bpf_struct_ops_map_free(struct 
>> bpf_map *map)
>>           bpf_jit_uncharge_modmem(PAGE_SIZE);
>>       }
>>       bpf_map_area_free(st_map->uvalue);
>> +    btf_put(st_map->btf);
>>       bpf_map_area_free(st_map);
>>   }
>> @@ -675,15 +676,30 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>       struct bpf_struct_ops_map *st_map;
>>       const struct btf_type *t, *vt;
>>       struct bpf_map *map;
>> +    struct btf *btf;
>>       int ret;
>> -    st_ops_desc = bpf_struct_ops_find_value(btf_vmlinux, 
>> attr->btf_vmlinux_value_type_id);
>> -    if (!st_ops_desc)
>> -        return ERR_PTR(-ENOTSUPP);
>> +    if (attr->value_type_btf_obj_fd) {
>> +        /* The map holds btf for its whole life time. */
>> +        btf = btf_get_by_fd(attr->value_type_btf_obj_fd);
>> +        if (IS_ERR(btf))
>> +            return ERR_PTR(PTR_ERR(btf));
>> +    } else {
>> +        btf = btf_vmlinux;
>> +        btf_get(btf);
>> +    }
>> +
>> +    st_ops_desc = bpf_struct_ops_find_value(btf, 
>> attr->btf_vmlinux_value_type_id);
>> +    if (!st_ops_desc) {
>> +        ret = -ENOTSUPP;
>> +        goto errout;
>> +    }
>>       vt = st_ops_desc->value_type;
>> -    if (attr->value_size != vt->size)
>> -        return ERR_PTR(-EINVAL);
>> +    if (attr->value_size != vt->size) {
>> +        ret = -EINVAL;
>> +        goto errout;
>> +    }
>>       t = st_ops_desc->type;
>> @@ -694,17 +710,18 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>           (vt->size - sizeof(struct bpf_struct_ops_value));
>>       st_map = bpf_map_area_alloc(st_map_size, NUMA_NO_NODE);
>> -    if (!st_map)
>> -        return ERR_PTR(-ENOMEM);
>> +    if (!st_map) {
>> +        ret = -ENOMEM;
>> +        goto errout;
>> +    }
>> +    st_map->btf = btf;
> 
> How about do the "st_map->btf = btf;" assignment the same as where the 
> current code is doing (a few lines below). Would it avoid the new "btf = 
> NULL;" dance during the error case?
> 
> nit, if moving a line, I would move the following "st_map->st_ops_desc = 
> st_ops_desc;" to the later and close to where "st_map->btf = btf;" is.

It would work. But, I also need to init st_map->btf as NULL. Or, it may
fail at errout_free to free an invalid pointer if I read it correctly.

> 
>>       st_map->st_ops_desc = st_ops_desc;
>>       map = &st_map->map;
>>       ret = bpf_jit_charge_modmem(PAGE_SIZE);
>> -    if (ret) {
>> -        __bpf_struct_ops_map_free(map);
>> -        return ERR_PTR(ret);
>> -    }
>> +    if (ret)
>> +        goto errout_free;
>>       st_map->image = bpf_jit_alloc_exec(PAGE_SIZE);
>>       if (!st_map->image) {
>> @@ -713,25 +730,31 @@ static struct bpf_map 
>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>            * here.
>>            */
>>           bpf_jit_uncharge_modmem(PAGE_SIZE);
>> -        __bpf_struct_ops_map_free(map);
>> -        return ERR_PTR(-ENOMEM);
>> +        ret = -ENOMEM;
>> +        goto errout_free;
>>       }
>>       st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
>>       st_map->links =
>>           bpf_map_area_alloc(btf_type_vlen(t) * sizeof(struct 
>> bpf_links *),
>>                      NUMA_NO_NODE);
>>       if (!st_map->uvalue || !st_map->links) {
>> -        __bpf_struct_ops_map_free(map);
>> -        return ERR_PTR(-ENOMEM);
>> +        ret = -ENOMEM;
>> +        goto errout_free;
>>       }
>> -    st_map->btf = btf_vmlinux;
> 
> The old code initializes "st_map->btf" here.
> 
>> -
>>       mutex_init(&st_map->lock);
>>       set_vm_flush_reset_perms(st_map->image);
>>       bpf_map_init_from_attr(map, attr);
>>       return map;
>> +
>> +errout_free:
>> +    __bpf_struct_ops_map_free(map);
>> +    btf = NULL;        /* has been released */
>> +errout:
>> +    btf_put(btf);
>> +
>> +    return ERR_PTR(ret);
>>   }
>>   static u64 bpf_struct_ops_map_mem_usage(const struct bpf_map *map)
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 0ed286b8a0f0..974651fe2bee 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -1096,7 +1096,7 @@ static int map_check_btf(struct bpf_map *map, 
>> const struct btf *btf,
>>       return ret;
>>   }
>> -#define BPF_MAP_CREATE_LAST_FIELD map_extra
>> +#define BPF_MAP_CREATE_LAST_FIELD value_type_btf_obj_fd
>>   /* called via syscall */
>>   static int map_create(union bpf_attr *attr)
>>   {
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index bdd166cab977..3f446f76d4bf 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20086,6 +20086,7 @@ static int check_struct_ops_btf_id(struct 
>> bpf_verifier_env *env)
>>       const struct btf_member *member;
>>       struct bpf_prog *prog = env->prog;
>>       u32 btf_id, member_idx;
>> +    struct btf *btf;
>>       const char *mname;
>>       if (!prog->gpl_compatible) {
>> @@ -20093,8 +20094,10 @@ static int check_struct_ops_btf_id(struct 
>> bpf_verifier_env *env)
>>           return -EINVAL;
>>       }
>> +    btf = prog->aux->attach_btf;
>> +
>>       btf_id = prog->aux->attach_btf_id;
>> -    st_ops_desc = bpf_struct_ops_find(btf_vmlinux, btf_id);
>> +    st_ops_desc = bpf_struct_ops_find(btf, btf_id);
>>       if (!st_ops_desc) {
>>           verbose(env, "attach_btf_id %u is not a supported struct\n",
>>               btf_id);
>> @@ -20111,8 +20114,8 @@ static int check_struct_ops_btf_id(struct 
>> bpf_verifier_env *env)
>>       }
>>       member = &btf_type_member(t)[member_idx];
>> -    mname = btf_name_by_offset(btf_vmlinux, member->name_off);
>> -    func_proto = btf_type_resolve_func_ptr(btf_vmlinux, member->type,
>> +    mname = btf_name_by_offset(btf, member->name_off);
>> +    func_proto = btf_type_resolve_func_ptr(btf, member->type,
>>                              NULL);
>>       if (!func_proto) {
>>           verbose(env, "attach to invalid member %s(@idx %u) of struct 
>> %s\n",
>> diff --git a/tools/include/uapi/linux/bpf.h 
>> b/tools/include/uapi/linux/bpf.h
>> index 0f6cdf52b1da..fd20c52606b2 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -1398,6 +1398,11 @@ union bpf_attr {
>>            * to using 5 hash functions).
>>            */
>>           __u64    map_extra;
>> +
>> +        __u32   value_type_btf_obj_fd;    /* fd pointing to a BTF
>> +                         * type data for
>> +                         * btf_vmlinux_value_type_id.
>> +                         */
>>       };
>>       struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
> 

