Return-Path: <bpf+bounces-12840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CCF7D124D
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 17:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62BF41C2102B
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 15:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA091DA4C;
	Fri, 20 Oct 2023 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhTkQLww"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21671DA3F;
	Fri, 20 Oct 2023 15:12:29 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE77FA;
	Fri, 20 Oct 2023 08:12:27 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7af45084eso10571007b3.0;
        Fri, 20 Oct 2023 08:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697814746; x=1698419546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jkIX9pkO5/Tsxh3X28JoJEQJmjUmQKmAAJHUvc8itGc=;
        b=KhTkQLww2IiXES/RxJdc1HC8JmjXhZA6AxCUnEqlY8pi2JvryAzjCTs3i4gP7uGDgN
         9bbgG2UzIw0GZ8n2KSWsTLHRFO81Cuvf/a0jt0pMXCU1Yfjc0oj7fW0H7W4wezHoQYyl
         dSLL2W0EBVI40jycaSFoOvSrxQdCT/nh4nINky4SeYRkc/HGhCk28yqU11L9ckYQEs+Z
         jhWvjrfO9nOOCI6HE0LoyrYE3hScS95cLKzTVPj43S/AdJG7qRK4Rr3AoABweqLtHpky
         YEUVbTat4F8h4ApisWNeP7u6HH/2CkUCu1aMiJBabKWjfKzi2/3XwCY52rs7McleIQaI
         iHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697814746; x=1698419546;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkIX9pkO5/Tsxh3X28JoJEQJmjUmQKmAAJHUvc8itGc=;
        b=PdQxXN4RPX98CXwx0byAGXd1YTxYEv5wlNX1SaADPGToLvLaaPIViP21oo2fsUJo6V
         ME2jl3B7DKxKoWdc9TiAtKSh8IMu8xGiHSC6UUBiFzxGUBDye+1qwcOoGD3eynD5Z2kg
         50OYndRLKUY+5q3k074XsW7WagAKeNmCmRsbNQCzOJp1nZa0xRTkgiIehsi5DNfAvhRY
         GlO5AWlyzyi85AoxR6kvyEeBEnjmVJULLm57UgKxPuUEut5IK5UhIkmAdKnP+kIptVKz
         /+6y0d9aSNpoIbifBl+HZ0ko2DsER+8sFnn/9rXML5r2XOQlCYSbZLhZYuPtm+wFwj/i
         EJHQ==
X-Gm-Message-State: AOJu0YxOy4u8dRipoF+gnkRh6EZ2FEKQcVkXQn0m5YCE4ou5W06jqcwf
	abyopYqWcHax3d2+9ng1l2o=
X-Google-Smtp-Source: AGHT+IEEitKGpoHWJfRDrz3lMA1sSvMPWQl7klCdmBN/wkKoqOKr9prEOoLCHiwJ1ru/DkDHUUHmOQ==
X-Received: by 2002:a81:5258:0:b0:5a7:b797:d1e4 with SMTP id g85-20020a815258000000b005a7b797d1e4mr2218035ywb.21.1697814746035;
        Fri, 20 Oct 2023 08:12:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:74bb:66ec:3132:3e97? ([2600:1700:6cf8:1240:74bb:66ec:3132:3e97])
        by smtp.gmail.com with ESMTPSA id g142-20020a0ddd94000000b005a8073e2062sm752011ywe.33.2023.10.20.08.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 08:12:25 -0700 (PDT)
Message-ID: <9e7ec07f-bc03-4e62-a0f6-28f668a1ec42@gmail.com>
Date: Fri, 20 Oct 2023 08:12:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kui-Feng Lee <sinquersw@gmail.com>
Subject: Re: [PATCH bpf-next v5 6/9] bpf, net: switch to dynamic registration
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231017162306.176586-1-thinker.li@gmail.com>
 <20231017162306.176586-7-thinker.li@gmail.com>
 <72104b12-4573-7f6d-183e-4761673329e2@linux.dev>
Content-Language: en-US
In-Reply-To: <72104b12-4573-7f6d-183e-4761673329e2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/18/23 18:49, Martin KaFai Lau wrote:
> On 10/17/23 9:23 AM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Replace the static list of struct_ops types with pre-btf 
>> struct_ops_tab to
>> enable dynamic registration.
>>
>> Both bpf_dummy_ops and bpf_tcp_ca now utilize the registration function
>> instead of being listed in bpf_struct_ops_types.h.
>>
>> Cc: netdev@vger.kernel.org
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   include/linux/bpf.h               |   2 +
>>   include/linux/btf.h               |  29 +++++++
>>   kernel/bpf/bpf_struct_ops.c       | 124 +++++++++++++++---------------
>>   kernel/bpf/bpf_struct_ops_types.h |  12 ---
>>   kernel/bpf/btf.c                  |   2 +-
>>   net/bpf/bpf_dummy_struct_ops.c    |  14 +++-
>>   net/ipv4/bpf_tcp_ca.c             |  16 +++-
>>   7 files changed, 119 insertions(+), 80 deletions(-)
>>   delete mode 100644 kernel/bpf/bpf_struct_ops_types.h
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 1e1647c8b0ce..b0f33147aa93 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -3207,4 +3207,6 @@ static inline bool bpf_is_subprog(const struct 
>> bpf_prog *prog)
>>       return prog->aux->func_idx != 0;
>>   }
>> +int register_bpf_struct_ops(struct bpf_struct_ops *st_ops);
>> +
>>   #endif /* _LINUX_BPF_H */
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index aa2ba77648be..fdc83aa10462 100644
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
>> @@ -577,4 +580,30 @@ int btf_add_struct_ops(struct bpf_struct_ops 
>> *st_ops);
>>   const struct bpf_struct_ops **
>>   btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
>> +enum bpf_struct_ops_state {
>> +    BPF_STRUCT_OPS_STATE_INIT,
>> +    BPF_STRUCT_OPS_STATE_INUSE,
>> +    BPF_STRUCT_OPS_STATE_TOBEFREE,
>> +    BPF_STRUCT_OPS_STATE_READY,
>> +};
>> +
>> +struct bpf_struct_ops_common_value {
>> +    refcount_t refcnt;
>> +    enum bpf_struct_ops_state state;
>> +};
>> +#define BPF_STRUCT_OPS_COMMON_VALUE struct 
>> bpf_struct_ops_common_value common
> 
> Since there is 'struct bpf_struct_ops_common_value' now, the 
> BPF_STRUCT_OPS_COMMON_VALUE macro is not as useful as before. Lets 
> remove it.

Agree

> 
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
>> +}
> 
> I think the bpp_struct_ops_* should not be in btf.h. Probably move them 
> to bpf.h instead. or there is some other considerations I am missing?

Yes, I think bpf.h is the right place.

> 
>> +
>>   #endif
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 60445ff32275..175068b083cb 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -13,19 +13,6 @@
>>   #include <linux/btf_ids.h>
>>   #include <linux/rcupdate_wait.h>
>> -enum bpf_struct_ops_state {
>> -    BPF_STRUCT_OPS_STATE_INIT,
>> -    BPF_STRUCT_OPS_STATE_INUSE,
>> -    BPF_STRUCT_OPS_STATE_TOBEFREE,
>> -    BPF_STRUCT_OPS_STATE_READY,
>> -};
>> -
>> -struct bpf_struct_ops_common_value {
>> -    refcount_t refcnt;
>> -    enum bpf_struct_ops_state state;
>> -};
>> -#define BPF_STRUCT_OPS_COMMON_VALUE struct 
>> bpf_struct_ops_common_value common
>> -
>>   struct bpf_struct_ops_value {
>>       BPF_STRUCT_OPS_COMMON_VALUE;
>>       char data[] ____cacheline_aligned_in_smp;
>> @@ -72,35 +59,6 @@ static DEFINE_MUTEX(update_mutex);
>>   #define VALUE_PREFIX "bpf_struct_ops_"
>>   #define VALUE_PREFIX_LEN (sizeof(VALUE_PREFIX) - 1)
>> -/* bpf_struct_ops_##_name (e.g. bpf_struct_ops_tcp_congestion_ops) is
>> - * the map's value exposed to the userspace and its btf-type-id is
>> - * stored at the map->btf_vmlinux_value_type_id.
>> - *
>> - */
>> -#define BPF_STRUCT_OPS_TYPE(_name)                \
>> -extern struct bpf_struct_ops bpf_##_name;            \
>> -                                \
>> -struct bpf_struct_ops_##_name {                        \
>> -    BPF_STRUCT_OPS_COMMON_VALUE;                \
>> -    struct _name data ____cacheline_aligned_in_smp;        \
>> -};
>> -#include "bpf_struct_ops_types.h"
>> -#undef BPF_STRUCT_OPS_TYPE
>> -
>> -enum {
>> -#define BPF_STRUCT_OPS_TYPE(_name) BPF_STRUCT_OPS_TYPE_##_name,
>> -#include "bpf_struct_ops_types.h"
>> -#undef BPF_STRUCT_OPS_TYPE
>> -    __NR_BPF_STRUCT_OPS_TYPE,
>> -};
>> -
>> -static struct bpf_struct_ops * const bpf_struct_ops[] = {
>> -#define BPF_STRUCT_OPS_TYPE(_name)                \
>> -    [BPF_STRUCT_OPS_TYPE_##_name] = &bpf_##_name,
>> -#include "bpf_struct_ops_types.h"
>> -#undef BPF_STRUCT_OPS_TYPE
>> -};
>> -
>>   const struct bpf_verifier_ops bpf_struct_ops_verifier_ops = {
>>   };
>> @@ -234,16 +192,51 @@ static void bpf_struct_ops_init_one(struct 
>> bpf_struct_ops *st_ops,
>>   }
>> +static int register_bpf_struct_ops_btf(struct bpf_struct_ops *st_ops,
>> +                       struct btf *btf)
> 
> Please combine this function into register_bpf_struct_ops(). They are 
> both very short.
> 

Got it!

>> +{
>> +    struct bpf_verifier_log *log;
>> +    int err;
>> +
>> +    if (st_ops == NULL)
>> +        return -EINVAL;
>> +
>> +    log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
>> +    if (!log) {
>> +        err = -ENOMEM;
>> +        goto errout;
>> +    }
>> +
>> +    log->level = BPF_LOG_KERNEL;
>> +
>> +    bpf_struct_ops_init_one(st_ops, btf, st_ops->owner, log);
>> +
>> +    err = btf_add_struct_ops(st_ops);
>> +
>> +errout:
>> +    kfree(log);
>> +
>> +    return err;
>> +}
>> +
>> +int register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
> 
> Similar to the register kfunc counterpart, can this be moved to btf.c 
> instead by extern-ing bpf_struct_ops_init_one()? or there are some other 
> structs/functions need to extern?

It is wierd to move a function of bpf_struct_ops to btf.
But, kfunc already did that, I don't mind to follow it.

> 
>> +{
>> +    struct btf *btf;
>> +    int err;
>> +
>> +    btf = btf_get_module_btf(st_ops->owner);
>> +    if (!btf)
>> +        return -EINVAL;
>> +    err = register_bpf_struct_ops_btf(st_ops, btf);
>> +    btf_put(btf);
>> +
>> +    return err;
>> +}
>> +EXPORT_SYMBOL_GPL(register_bpf_struct_ops);
>> +
>>   void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
> 
> The bpf_struct_ops_init() is pretty much only finding the btf 
> "module_id" and "common_value_id". Lets use the BTF_ID_LIST to do it 
> instead. Then the newly added bpf_struct_ops_init_one() could use a 
> proper name bpf_struct_ops_init() instead of having the special "_one" 
> suffix.

Got it!

> 
>>   {
>> -    struct bpf_struct_ops *st_ops;
>>       s32 module_id, common_value_id;
>> -    u32 i;
>> -
>> -    /* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
>> -#define BPF_STRUCT_OPS_TYPE(_name) BTF_TYPE_EMIT(struct 
>> bpf_struct_ops_##_name);
>> -#include "bpf_struct_ops_types.h"
>> -#undef BPF_STRUCT_OPS_TYPE
>>       module_id = btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
>>       if (module_id < 0) {
>> @@ -259,11 +252,6 @@ void bpf_struct_ops_init(struct btf *btf, struct 
>> bpf_verifier_log *log)
>>           return;
>>       }
>>       common_value_type = btf_type_by_id(btf, common_value_id);
>> -
>> -    for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
>> -        st_ops = bpf_struct_ops[i];
>> -        bpf_struct_ops_init_one(st_ops, btf, NULL, log);
>> -    }
>>   }
>>   extern struct btf *btf_vmlinux;
>> @@ -271,32 +259,44 @@ extern struct btf *btf_vmlinux;
>>   static const struct bpf_struct_ops *
>>   bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
>>   {
>> +    const struct bpf_struct_ops *st_ops = NULL;
>> +    const struct bpf_struct_ops **st_ops_list;
>>       unsigned int i;
>> +    u32 cnt = 0;
>>       if (!value_id || !btf_vmlinux)
> 
> The "!btf_vmlinux" should have been changed to "!btf" in the earlier 
> patch (patch 2?),

This is not btf. It mean to check if btf_vmlinux is initialized.
It is not necessary anymore.
For checking btf, the following btf_get_struct_ops() will keep cnt zero
if btf is NULL, so it is unnecessary as well.

> 
> and is this null check still needed now?
> 
>>           return NULL;
>> -    for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
>> -        if (bpf_struct_ops[i]->value_id == value_id)
>> -            return bpf_struct_ops[i];
>> +    st_ops_list = btf_get_struct_ops(btf, &cnt);
>> +    for (i = 0; i < cnt; i++) {
>> +        if (st_ops_list[i]->value_id == value_id) {
>> +            st_ops = st_ops_list[i];
> 
> nit. Like the change in the earlier patch that is being replaced here,
> directly "return st_ops_list[i];".

Got it!

> 
>> +            break;
>> +        }
>>       }
>> -    return NULL;
>> +    return st_ops;
>>   }
>>   const struct bpf_struct_ops *bpf_struct_ops_find(struct btf *btf, 
>> u32 type_id)
>>   {
>> +    const struct bpf_struct_ops *st_ops = NULL;
>> +    const struct bpf_struct_ops **st_ops_list;
>>       unsigned int i;
>> +    u32 cnt;
>>       if (!type_id || !btf_vmlinux)
>>           return NULL;
>> -    for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
>> -        if (bpf_struct_ops[i]->type_id == type_id)
>> -            return bpf_struct_ops[i];
>> +    st_ops_list = btf_get_struct_ops(btf, &cnt);
>> +    for (i = 0; i < cnt; i++) {
>> +        if (st_ops_list[i]->type_id == type_id) {
>> +            st_ops = st_ops_list[i];
> 
> Same.

Ack!

> 
>> +            break;
>> +        }
>>       }
>> -    return NULL;
>> +    return st_ops;
>>   }
>>   static int bpf_struct_ops_map_get_next_key(struct bpf_map *map, void 
>> *key,
>> diff --git a/kernel/bpf/bpf_struct_ops_types.h 
>> b/kernel/bpf/bpf_struct_ops_types.h
>> deleted file mode 100644
>> index 5678a9ddf817..000000000000
>> --- a/kernel/bpf/bpf_struct_ops_types.h
>> +++ /dev/null
>> @@ -1,12 +0,0 @@
>> -/* SPDX-License-Identifier: GPL-2.0 */
>> -/* internal file - do not include directly */
>> -
>> -#ifdef CONFIG_BPF_JIT
>> -#ifdef CONFIG_NET
>> -BPF_STRUCT_OPS_TYPE(bpf_dummy_ops)
>> -#endif
>> -#ifdef CONFIG_INET
>> -#include <net/tcp.h>
>> -BPF_STRUCT_OPS_TYPE(tcp_congestion_ops)
>> -#endif
>> -#endif
> 
> Seeing this gone is satisfying
> 
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index be5144dbb53d..990973d6057d 100644
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
>> diff --git a/net/bpf/bpf_dummy_struct_ops.c 
>> b/net/bpf/bpf_dummy_struct_ops.c
>> index 5918d1b32e19..724bb7224079 100644
>> --- a/net/bpf/bpf_dummy_struct_ops.c
>> +++ b/net/bpf/bpf_dummy_struct_ops.c
>> @@ -7,7 +7,7 @@
>>   #include <linux/bpf.h>
>>   #include <linux/btf.h>
>> -extern struct bpf_struct_ops bpf_bpf_dummy_ops;
>> +static struct bpf_struct_ops bpf_bpf_dummy_ops;
> 
> Is it still needed ?

Yes, it will be used by bpf_struct_ops_test_run().


> 
> 
> 


