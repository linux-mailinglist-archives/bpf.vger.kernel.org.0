Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDEF699CE8
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 20:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjBPTRb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 14:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBPTRb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 14:17:31 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB454CC86
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 11:17:30 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gd1so2905372pjb.1
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 11:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fdf6sBX88ANpc5BMyy9KxzpYpwpnep98pIKNPNpH40=;
        b=KsYwdPIuqhuZ+DDJodYsgAZvufZiT+EL3qWX3dVhOLjpOaFTs8HtOt/4fXorIefpWv
         Ay96/gWST8M2m3wTZOCCohLpsuZrnhEZk/e2bOumWdk3b94W5O2G2ODl0dyl/at8wRa7
         jW5D3Jc5b1Ba5qzN7ipC93/JYEmAv8WCkTmokDLlwKzYkZG0eJMmvoazajSawAEMkO5V
         N7i2bUuA99zQ2fCyG0n1ydjcVHue2E+V1tFsdixmsAeBJVUnjuNTIj7+I/iZTEwwn+kt
         gGy/vTGqNQQEIg9xbTyCfExvCdAukfUYzNl1SRSUdOt/fcY1kUmtnkw5gIfZYbEMayS6
         UNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fdf6sBX88ANpc5BMyy9KxzpYpwpnep98pIKNPNpH40=;
        b=EMiLCMth+coMAc2HC51kQVqpfu00hYpqVun6oe46EClWUNeAw1aIbG23EOkVPaoS30
         5L9LiV1FDfnP/DP6yIIqEC8G5sXA4oeIku5PBr8Cefs64nmSzO01C8likg2igVMpsLLg
         qNy6RdxJmdSAj69k0KCpiaYob5xvywMVd92wDV/xIYDSjoPWRS9uFEw1fd9FWkaJQ0c1
         pY13RZm1ZD3xEzHsRnGfKaUCPFf1gIWtUGJ0fBfGSH7HwVdUnvvdhfDohLgTS6k0VhOu
         uZ8rtuHEdpubO8WavlfpOKVYdVlqe9xoxiEsNS2K3txTPl0tXcUvPJafjayEJEc/qmVB
         Ddvw==
X-Gm-Message-State: AO0yUKUr02E2T9J7GKwR3KilKqOBw+dxPtEoz2n4fUt0D7nWQkuFqcVh
        pg4uL/OLHJs/SSo0BGbM9NSa7jiMCM4=
X-Google-Smtp-Source: AK7set+0TG4KHAdIZLRZDSrO5/a4TgsjBHQGPjFM+mL6CQZCxszoWyHI4gJrJHfykMg1pM7kJa1xPA==
X-Received: by 2002:a17:902:ea12:b0:199:4be8:be48 with SMTP id s18-20020a170902ea1200b001994be8be48mr3364380plg.19.1676575049313;
        Thu, 16 Feb 2023 11:17:29 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21e8::12ef? ([2620:10d:c090:400::5:962a])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001992521f23esm1670890pll.100.2023.02.16.11.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 11:17:28 -0800 (PST)
Message-ID: <0d674d85-4278-c840-b16b-2a42143cf502@gmail.com>
Date:   Thu, 16 Feb 2023 11:17:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH bpf-next 5/7] bpf: Update the struct_ops of a bpf_link.
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-6-kuifeng@meta.com>
 <2651cae9-43a5-451b-b93f-874b3624e990@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <2651cae9-43a5-451b-b93f-874b3624e990@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/15/23 17:02, Martin KaFai Lau wrote:
> On 2/14/23 2:17 PM, Kui-Feng Lee wrote:
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index d16ca06cf09a..d329621fc721 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -752,11 +752,66 @@ static int 
>> bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
>>       return 0;
>>   }
>> +static int bpf_struct_ops_map_link_update(struct bpf_link *link, 
>> struct bpf_map *new_map)
>> +{
>> +    struct bpf_struct_ops_value *kvalue;
>> +    struct bpf_struct_ops_map *st_map, *old_st_map;
>> +    struct bpf_map *old_map;
>> +    int err;
>> +
>> +    if (new_map->map_type != BPF_MAP_TYPE_STRUCT_OPS || 
>> !(new_map->map_flags & BPF_F_LINK))
>> +        return -EINVAL;
>> +
>> +    old_map = link->map;
>> +
>> +    /* It does nothing if the new map is the same as the old one.
>> +     * A struct_ops that backs a bpf_link can not be updated or
>> +     * its kvalue would be updated and causes inconsistencies.
>> +     */
>> +    if (old_map == new_map)
>> +        return 0;
>> +
>> +    /* The new and old struct_ops must be the same type. */
>> +    st_map = (struct bpf_struct_ops_map *)new_map;
>> +    old_st_map = (struct bpf_struct_ops_map *)old_map;
>> +    if (st_map->st_ops != old_st_map->st_ops)
>> +        return -EINVAL;
>> +
>> +    /* Assure the struct_ops is updated (has value) and not
>> +     * backing any other link.
>> +     */
>> +    kvalue = &st_map->kvalue;
>> +    if (kvalue->state != BPF_STRUCT_OPS_STATE_INUSE ||
>> +        refcount_read(&kvalue->refcnt) != 0)
>> +        return -EINVAL;
>> +
>> +    bpf_map_inc(new_map);
>> +    refcount_set(&kvalue->refcnt, 1);
>> +
>> +    set_memory_rox((long)st_map->image, 1);
>> +    err = st_map->st_ops->update(kvalue->data, old_st_map->kvalue.data);
>> +    if (err) {
>> +        refcount_set(&kvalue->refcnt, 0);
>> +
>> +        set_memory_nx((long)st_map->image, 1);
>> +        set_memory_rw((long)st_map->image, 1);
>> +        bpf_map_put(new_map);
>> +        return err;
>> +    }
>> +
>> +    link->map = new_map;
> 
> Similar here, does this link_update operation needs a lock?

The update function of tcp_ca checks if the name is unique with the 
protection of a lock.  bpf_struct_ops_map_update_elem() also check and 
update state of the kvalue to prevent changing kvalue.  Only one of 
thread will success to register or update at any moment.

> 
>> +
>> +    bpf_struct_ops_kvalue_put(&old_st_map->kvalue);
>> +
>> +    return 0;
>> +}
>> +
>>   static const struct bpf_link_ops bpf_struct_ops_map_lops = {
>>       .release = bpf_struct_ops_map_link_release,
>>       .dealloc = bpf_struct_ops_map_link_dealloc,
>>       .show_fdinfo = bpf_struct_ops_map_link_show_fdinfo,
>>       .fill_link_info = bpf_struct_ops_map_link_fill_link_info,
>> +    .update_struct_ops = bpf_struct_ops_map_link_update,
> 
> This seems a little non-intuitive to add a struct_ops specific thing to 
> the generic bpf_link_ops. May be avoid adding ".update_struct_ops" and 
> directly call the bpf_struct_ops_map_link_update() from link_update()?

It has `.update_prog` for BPF programs so `.update_struct_ops` or 
`.update_map` is not that weird for me.  It would be better to have a 
`.update_link` to receive either a bpf_prog or bpf_map, and remove 
`.update_prog`.

> 
> 
>>   };
>>   int link_create_struct_ops_map(union bpf_attr *attr, bpfptr_t uattr)
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 54e172d8f5d1..1341634863b5 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -4650,6 +4650,32 @@ static int link_create(union bpf_attr *attr, 
>> bpfptr_t uattr)
>>       return ret;
>>   }
>> +#define BPF_LINK_UPDATE_STRUCT_OPS_LAST_FIELD 
>> link_update_struct_ops.new_map_fd
> 
> Why it is needed? Does it hit error without it?

It can be removed now.

> 
>> +
>> +static int link_update_struct_ops(struct bpf_link *link, union 
>> bpf_attr *attr)
>> +{
>> +    struct bpf_map *new_map;
>> +    int ret = 0;
>> +
>> +    new_map = bpf_map_get(attr->link_update.new_map_fd);
>> +    if (IS_ERR(new_map))
>> +        return -EINVAL;
>> +
>> +    if (new_map->map_type != BPF_MAP_TYPE_STRUCT_OPS) {
>> +        ret = -EINVAL;
>> +        goto out_put_map;
>> +    }
> 
> How about BPF_F_REPLACE?

Do you mean the new_map should be labeled with BPF_F_REPLACE to replace 
the old one?


> 
>> +
>> +    if (link->ops->update_struct_ops)
>> +        ret = link->ops->update_struct_ops(link, new_map); > +    else
>> +        ret = -EINVAL;
>> +
>> +out_put_map:
>> +    bpf_map_put(new_map);
>> +    return ret;
>> +}
>> +
>>   #define BPF_LINK_UPDATE_LAST_FIELD link_update.old_prog_fd
>>   static int link_update(union bpf_attr *attr)
>> @@ -4670,6 +4696,11 @@ static int link_update(union bpf_attr *attr)
>>       if (IS_ERR(link))
>>           return PTR_ERR(link);
>> +    if (link->type == BPF_LINK_TYPE_STRUCT_OPS) {
>> +        ret = link_update_struct_ops(link, attr);
>> +        goto out_put_link;
>> +    }
>> +
>>       new_prog = bpf_prog_get(attr->link_update.new_prog_fd);
>>       if (IS_ERR(new_prog)) {
>>           ret = PTR_ERR(new_prog);
>> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
>> index 66ce5fadfe42..558b01d5250f 100644
>> --- a/net/ipv4/bpf_tcp_ca.c
>> +++ b/net/ipv4/bpf_tcp_ca.c
>> @@ -239,8 +239,6 @@ static int bpf_tcp_ca_init_member(const struct 
>> btf_type *t,
>>           if (bpf_obj_name_cpy(tcp_ca->name, utcp_ca->name,
>>                        sizeof(tcp_ca->name)) <= 0)
>>               return -EINVAL;
>> -        if (tcp_ca_find(utcp_ca->name))
>> -            return -EEXIST;
> 
> This change is not obvious. Please put some comment in the commit 
> message about this change.
> 
sure!
