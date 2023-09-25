Return-Path: <bpf+bounces-10812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE827AE21F
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 01:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 114491C20880
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A14026290;
	Mon, 25 Sep 2023 23:13:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA8812B62
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 23:13:49 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCB2BE
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 16:13:48 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d8198ca891fso8420987276.1
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 16:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695683627; x=1696288427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ADQ+RN7TAxqsH5Qp0OhVd3zVhIfZp49xhqVIlUevcVY=;
        b=kL/ETSgAIpIpZDMb4CV2BLic7WyoBIC38SElV4g5pQkoRkVPFUlf1ElzY6RhDFxnSC
         w2Aqiuqq83IH6IuTzj39ACsuk70TJ9Vp4JxBB8eDOWpAGDnPF7VB2nzHrM5uu5TZECP3
         ED6CTlP9KWejzLnvXtM8AXeibZ4Ry9A7nx5ePTrI3MU8TuHQIJb+7f1U7P8qK2g3xQWG
         XwLW0PMyfVy9lF+vP6VCwKIECa11EO7kDac1G39WhgCPuknsbHow2K6Qaq4bWmCc38Oy
         3iLTj4A4AMK0g/VNJ7AC0ezVmIiHDTuA0OSdt6HHjpFqqFSecOi30UVc7nJfRM3XnNDv
         SbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695683627; x=1696288427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADQ+RN7TAxqsH5Qp0OhVd3zVhIfZp49xhqVIlUevcVY=;
        b=v4NIHvV0rzQ1M0QgTwwHrR0FwEouNE/72SFCFMAyXjBFcS1yNMHKnbDuOcAYYXvd5O
         RUkzTY88b5ARN1DWtSWE2GV3hpeFuqD0nAbjwD7FLHr7cl8UCCbouqyVlWKfvaWr/fk1
         YnhPcZJkiFHSZwoAMNzKjjxAZ+Ldbzb3AX7KXUVeNZdwhk2nbTTHoVMlkj9RkF39PvvC
         mbgKDpvuXcfxVPQc6UclVzFEELt0ETfmb+ffWuHnZpNi3L+lk7rxv5Z2ViIytDCmMFXN
         eXbVF3twLAreSpt3zOwkFbNE9Q24pfe3l3DKzeNgU5R4A+Mrxu+KkUTdLnbyxcgr6/IZ
         HUfw==
X-Gm-Message-State: AOJu0YxsMO7MbbqfW4O5foJajxMWsdAA7SBk7Wj5sRH9h4y6kPXR/yn8
	Wn7e5O4oJAcTCe5PDlAIdgI/rEfCulc=
X-Google-Smtp-Source: AGHT+IEko/va81OiuCdUn5EJRIgwd+mcASBWCScK/tjm5gulG5OFWAKaEU/KqSn+vmOlWjpB/Xvxyw==
X-Received: by 2002:a25:c347:0:b0:d81:4107:7a3 with SMTP id t68-20020a25c347000000b00d81410707a3mr7903940ybf.23.1695683627607;
        Mon, 25 Sep 2023 16:13:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:f7cd:fd6d:2b89:f093? ([2600:1700:6cf8:1240:f7cd:fd6d:2b89:f093])
        by smtp.gmail.com with ESMTPSA id q7-20020a5b0f87000000b00d749efa85a1sm2339393ybh.41.2023.09.25.16.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 16:13:47 -0700 (PDT)
Message-ID: <aa28fc7d-9cdb-f302-f66e-3cd2d969e253@gmail.com>
Date: Mon, 25 Sep 2023 16:13:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC bpf-next v3 03/11] bpf: add register and unregister
 functions for struct_ops.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20230920155923.151136-1-thinker.li@gmail.com>
 <20230920155923.151136-4-thinker.li@gmail.com>
 <75489013-0364-a91a-66d8-2d600a159246@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <75489013-0364-a91a-66d8-2d600a159246@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/25/23 16:07, Martin KaFai Lau wrote:
> On 9/20/23 8:59 AM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Provide registration functions to add/remove struct_ops types.
>>
>> Currently, it does linear search to find a struct_ops type. It should be
>> fine for now since we don't have many struct_ops types.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   include/linux/bpf.h         |  9 +++++++++
>>   include/linux/btf.h         | 27 +++++++++++++++++++++++++++
>>   kernel/bpf/bpf_struct_ops.c | 11 -----------
>>   kernel/bpf/btf.c            |  2 +-
>>   4 files changed, 37 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 30063a760b5a..67554f2f81b7 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1634,6 +1634,11 @@ struct bpf_struct_ops {
>>       u32 value_id;
>>   };
>> +struct bpf_struct_ops_mod {
>> +    struct module *owner;
> 
> After reading patch 5, I don't think this new 'struct 
> bpf_struct_ops_mod' is needed.
> 
>> +    struct bpf_struct_ops *st_ops;
> 
> In patch 5, 'struct module *owner' has been added to 'bpf_struct_ops'. 
> st_ops itself should already have the 'owner'.
> 
>> +};
>> +
>>   #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
>>   #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + 
>> POISON_POINTER_DELTA))
>>   const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id);
>> @@ -3205,4 +3210,8 @@ static inline bool bpf_is_subprog(const struct 
>> bpf_prog *prog)
>>       return prog->aux->func_idx != 0;
>>   }
>> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>> +int register_bpf_struct_ops(struct bpf_struct_ops_mod *mod);
> 
> This should be register_bpf_struct_ops(struct bpf_struct_ops *st_ops) 
> instead.

It is still required since the caller doesn't assign a module
to st_ops->owner.  I will force developers to fill st_ops->owner
before calling this function.

> 
>> +#endif
>> +
>>   #endif /* _LINUX_BPF_H */
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index 5fabe23aedd2..8d50e46b21bc 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -12,6 +12,8 @@
>>   #include <uapi/linux/bpf.h>
>>   #define BTF_TYPE_EMIT(type) ((void)(type *)0)
>> +#define BTF_STRUCT_OPS_TYPE_EMIT(type) {((void)(struct type *)0);    \
>> +        ((void)(struct bpf_struct_ops_##type *)0); }
>>   #define BTF_TYPE_EMIT_ENUM(enum_val) ((void)enum_val)
>>   /* These need to be macros, as the expressions are used in assembler 
>> input */
>> @@ -200,6 +202,7 @@ u32 btf_obj_id(const struct btf *btf);
>>   bool btf_is_kernel(const struct btf *btf);
>>   bool btf_is_module(const struct btf *btf);
>>   struct module *btf_try_get_module(const struct btf *btf);
>> +struct btf *btf_get_module_btf(const struct module *module);
>>   u32 btf_nr_types(const struct btf *btf);
>>   bool btf_member_is_reg_int(const struct btf *btf, const struct 
>> btf_type *s,
>>                  const struct btf_member *m,
>> @@ -580,4 +583,28 @@ int btf_add_struct_ops(struct bpf_struct_ops 
>> *st_ops,
>>   const struct bpf_struct_ops **
>>   btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
>> +enum bpf_struct_ops_state {
>> +    BPF_STRUCT_OPS_STATE_INIT,
>> +    BPF_STRUCT_OPS_STATE_INUSE,
>> +    BPF_STRUCT_OPS_STATE_TOBEFREE,
>> +    BPF_STRUCT_OPS_STATE_READY,
>> +};
>> +
>> +#define BPF_STRUCT_OPS_COMMON_VALUE            \
>> +    refcount_t refcnt;                \
>> +    enum bpf_struct_ops_state state
>> +
>> +/* bpf_struct_ops_##_name (e.g. bpf_struct_ops_tcp_congestion_ops) is
>> + * the map's value exposed to the userspace and its btf-type-id is
>> + * stored at the map->btf_vmlinux_value_type_id.
>> + *
>> + */
>> +#define DEFINE_STRUCT_OPS_VALUE_TYPE(_name)            \
>> +extern struct bpf_struct_ops bpf_##_name;            \
>> +                                \
>> +struct bpf_struct_ops_##_name {                    \
>> +    BPF_STRUCT_OPS_COMMON_VALUE;                \
>> +    struct _name data ____cacheline_aligned_in_smp;        \
>> +};
>> +
>>   #endif
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 627cf1ea840a..cd688e9033b5 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -13,17 +13,6 @@
>>   #include <linux/btf_ids.h>
>>   #include <linux/rcupdate_wait.h>
>> -enum bpf_struct_ops_state {
>> -    BPF_STRUCT_OPS_STATE_INIT,
>> -    BPF_STRUCT_OPS_STATE_INUSE,
>> -    BPF_STRUCT_OPS_STATE_TOBEFREE,
>> -    BPF_STRUCT_OPS_STATE_READY,
>> -};
>> -
>> -#define BPF_STRUCT_OPS_COMMON_VALUE            \
>> -    refcount_t refcnt;                \
>> -    enum bpf_struct_ops_state state
>> -
>>   struct bpf_struct_ops_value {
>>       BPF_STRUCT_OPS_COMMON_VALUE;
>>       char data[] ____cacheline_aligned_in_smp;
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 3fb9964f8672..73d19ef99306 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -7532,7 +7532,7 @@ struct module *btf_try_get_module(const struct 
>> btf *btf)
>>   /* Returns struct btf corresponding to the struct module.
>>    * This function can return NULL or ERR_PTR.
>>    */
>> -static struct btf *btf_get_module_btf(const struct module *module)
>> +struct btf *btf_get_module_btf(const struct module *module)
>>   {
>>   #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>>       struct btf_module *btf_mod, *tmp;
> 

