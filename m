Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C538B6BF723
	for <lists+bpf@lfdr.de>; Sat, 18 Mar 2023 02:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjCRBMF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 21:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCRBME (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 21:12:04 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF03A8829
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 18:12:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j13so7109158pjd.1
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 18:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679101919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=51r38L4LcEC63BEw/C5OdJZN7HW68vQcEBH3KamEpn8=;
        b=Iyipmc9FehT8ubbiwiEHg/8Hgle3/9fVNQAU4pQKznpJjx2eTmccMCyhY0iRL6LB54
         8ZFWEKAPrZBXC4Qsf5C1w++snqvOuSJGWfKYXhkJJpzZPQCfpbIKSN9pIyXZjwbmn5G/
         G7BsfvAmQELEIM71nlX/h2Z6bw60i7rF5tFQ/0h0vo0WAbdWETbogWdNERAzGfpt3GkC
         0W1KgwZQSo+VPBj6lkaPQDLai7XJbgsutmxzcyoYfvkFJ4nkizflvFUBEQQfFjZPv5u+
         5YOJVOIXaP0VNc2oLSedcJXujwt1MQL8gPwa3H3orbcNcZsegPk/9QrxfbhRc87rSddp
         6Qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679101919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51r38L4LcEC63BEw/C5OdJZN7HW68vQcEBH3KamEpn8=;
        b=OLPFWJrm8cEt8H9DVj66DuDQjN27NGcrl1xH9mzJPqOxz1/sup6s4zIFa976Rh9OwA
         qlw03krx5ry9B7udm/VBdiDMbarGQZ7w8lmOL2Kr25KGZcv58onHJW05X1rKHb5ABJ/I
         bEiXqMfypHeYq3zakNBmTFvHaEWXL5PMJVrvZozfbwvjzJRpyEGwYO03MYbZ0UkESzB8
         XQj4gfcJyUJglaRtMVxW090Lh9WPEZbw9TnGekyKE/1iQ+UYjwlkziE/k9y9yNtM7f7C
         od7oKwFyjnWc8L+nvlOdwaIWiTKMdc3B6J5Pd7NH/1F02B3LYGtVMfH32ePB/eOVkulB
         0Gmw==
X-Gm-Message-State: AO0yUKVJ9p7kevHomgCBTUT7vkoaLz/Cja3TFutBQDzCEg8WkZP1+Zyr
        Q1aa5EByfoEq5Q9oCiBuIFA=
X-Google-Smtp-Source: AK7set/oa5KH45KVLT20CFd/FPj7wa4B2eBq8Lc7uRVnWP+BMq/7ZUmlen5R3iCe9zATHRqogWHP5A==
X-Received: by 2002:a05:6a21:78a0:b0:cc:d891:b2b1 with SMTP id bf32-20020a056a2178a000b000ccd891b2b1mr12422938pzc.35.1679101919666;
        Fri, 17 Mar 2023 18:11:59 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::1380? ([2620:10d:c090:400::5:87c3])
        by smtp.gmail.com with ESMTPSA id s22-20020aa78296000000b0060c55143fdesm2134927pfm.68.2023.03.17.18.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 18:11:59 -0700 (PDT)
Message-ID: <6fed9361-ba07-c387-14d4-2fee2d161b5f@gmail.com>
Date:   Fri, 17 Mar 2023 18:11:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v7 5/8] bpf: Update the struct_ops of a bpf_link.
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230316023641.2092778-1-kuifeng@meta.com>
 <20230316023641.2092778-6-kuifeng@meta.com>
 <690c5fff-4828-c849-c946-1f1a29e168c8@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <690c5fff-4828-c849-c946-1f1a29e168c8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/17/23 12:23, Martin KaFai Lau wrote:
> On 3/15/23 7:36 PM, Kui-Feng Lee wrote:
>> +static int bpf_struct_ops_map_link_update(struct bpf_link *link, 
>> struct bpf_map *new_map)
>> +{
>> +    struct bpf_struct_ops_map *st_map, *old_st_map;
>> +    struct bpf_struct_ops_link *st_link;
>> +    struct bpf_map *old_map;
>> +    int err = 0;
>> +
>> +    st_link = container_of(link, struct bpf_struct_ops_link, link);
>> +    st_map = container_of(new_map, struct bpf_struct_ops_map, map);
>> +
>> +    if (!bpf_struct_ops_valid_to_reg(new_map))
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&update_mutex);
>> +
>> +    old_map = rcu_dereference_protected(st_link->map, 
>> lockdep_is_held(&update_mutex));
>> +    old_st_map = container_of(old_map, struct bpf_struct_ops_map, map);
>> +    /* The new and old struct_ops must be the same type. */
>> +    if (st_map->st_ops != old_st_map->st_ops) {
>> +        err = -EINVAL;
>> +        goto err_out;
>> +    }
>> +
>> +    err = st_map->st_ops->update(st_map->kvalue.data, 
>> old_st_map->kvalue.data);
> 
> I don't think it has completely addressed Andrii's comment in v4 
> regarding BPF_F_REPLACE: 
> https://lore.kernel.org/bpf/CAEf4BzbK8s+VFG5HefydD7CRLzkRFKg-Er0PKV_-C2-yttfXzA@mail.gmail.com/
> 
> For now, tcp_update_congestion_control() enforces the same cc-name. 
> However, it is still not the same as what BPF_F_REPLACE intented to do: 
> update only when it is the same old-map. Same cc-name does not 
> necessarily mean the same old-map.
> 
>> +    if (err)
>> +        goto err_out;
>> +
>> +    bpf_map_inc(new_map);
>> +    rcu_assign_pointer(st_link->map, new_map);
>> +    bpf_map_put(old_map);
>> +
>> +err_out:
>> +    mutex_unlock(&update_mutex);
>> +
>> +    return err;
>> +}
>> +
>>   static const struct bpf_link_ops bpf_struct_ops_map_lops = {
>>       .dealloc = bpf_struct_ops_map_link_dealloc,
>>       .show_fdinfo = bpf_struct_ops_map_link_show_fdinfo,
>>       .fill_link_info = bpf_struct_ops_map_link_fill_link_info,
>> +    .update_map = bpf_struct_ops_map_link_update,
>>   };
>>   int bpf_struct_ops_link_create(union bpf_attr *attr)
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 5a45e3bf34e2..6fa10d108278 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -4676,6 +4676,21 @@ static int link_create(union bpf_attr *attr, 
>> bpfptr_t uattr)
>>       return ret;
>>   }
>> +static int link_update_map(struct bpf_link *link, union bpf_attr *attr)
>> +{
>> +    struct bpf_map *new_map;
>> +    int ret = 0;
> 
> nit. init zero is unnecessarily.
> 
>> +
>> +    new_map = bpf_map_get(attr->link_update.new_map_fd);
>> +    if (IS_ERR(new_map))
>> +        return -EINVAL;
>> +
>> +    ret = link->ops->update_map(link, new_map);
>> +
>> +    bpf_map_put(new_map);
>> +    return ret;
>> +}
>> +
>>   #define BPF_LINK_UPDATE_LAST_FIELD link_update.old_prog_fd
>>   static int link_update(union bpf_attr *attr)
>> @@ -4696,6 +4711,11 @@ static int link_update(union bpf_attr *attr)
>>       if (IS_ERR(link))
>>           return PTR_ERR(link);
>> +    if (link->ops->update_map) {
>> +        ret = link_update_map(link, attr);
>> +        goto out_put_link;
>> +    }
>> +
>>       new_prog = bpf_prog_get(attr->link_update.new_prog_fd);
>>       if (IS_ERR(new_prog)) {
>>           ret = PTR_ERR(new_prog);
>> diff --git a/net/bpf/bpf_dummy_struct_ops.c 
>> b/net/bpf/bpf_dummy_struct_ops.c
>> index ff4f89a2b02a..158f14e240d0 100644
>> --- a/net/bpf/bpf_dummy_struct_ops.c
>> +++ b/net/bpf/bpf_dummy_struct_ops.c
>> @@ -222,12 +222,18 @@ static void bpf_dummy_unreg(void *kdata)
>>   {
>>   }
>> +static int bpf_dummy_update(void *kdata, void *old_kdata)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +
>>   struct bpf_struct_ops bpf_bpf_dummy_ops = {
>>       .verifier_ops = &bpf_dummy_verifier_ops,
>>       .init = bpf_dummy_init,
>>       .check_member = bpf_dummy_ops_check_member,
>>       .init_member = bpf_dummy_init_member,
>>       .reg = bpf_dummy_reg,
>> +    .update = bpf_dummy_update,
> 
> When looking at this together in patch 5, the changes in 
> bpf_dummy_struct_ops.c should not be needed.

I don't follow you.
If we don't assign a function to .update, it will fail in
bpf_struct_ops_map_link_update(). Of course, I can add a check
in bpf_struct_ops_map_link_update() to return an error if .update
is NULL.


> 
> 
