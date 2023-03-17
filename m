Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965A36BF47F
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjCQVmm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCQVme (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:42:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A7DA279
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 14:41:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so6652779pjz.1
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 14:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679089212;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P758vDYdsMV7GFnOFc9ZssF1eK8/BtU47OPtmEOidEo=;
        b=YEhC4ZvP94sUS3hqurfT9m7L7mQTm7BizBNL5I5YlcpzDmpA7WfWNv2W1hsJeDO8uq
         9bTgVatudKfzLiDhe/0QhVKpDFMQ2Iklxu9Ua/2xrfg/e5Lj4SD6Lse6nQx8A8gTTCV3
         e//qVoCXkPrXAXXaKU1gG7KgCaN0gMPGv8usFSDiy5O2FhY+Id5b/pjFc98fH8P26aFc
         ZYG0eo0METJLHv+wp6/T9Ti2L6UmoJ9RtiK0ZYJ+J8bE5p8YmUg+1FGdvTqYup5T4P0n
         PSR1OR7/sGIO15wGx2KybgdHxQ5rjt00Ifmscf7RFR/6slbTGSJehlyzNe2QO2vF9Ppi
         6EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679089212;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P758vDYdsMV7GFnOFc9ZssF1eK8/BtU47OPtmEOidEo=;
        b=K6CgObZ41yUSBXbHemsDmur7voFEZvbQ6rHU4MJXnOfc8WoK4XQQu7+1FBrtApMoT/
         gSiJXi4WAmAABe2zFunuL3aG+wN0F4cH0puATnZ/TqMJs0i56N739Rt57ZN4Iq7eQrhD
         FSAVfKj2bCsb9FAArHhBMDyu+jJY92+UGnYUowfiWZ6bmBzknRqXaxIMW1okMc0kwArr
         MrVGrEbSDr9CKtMubbj+dKQNCoO8NDe1ZiXPiFXJL/4WnR0AikASKbmG5rCT+rsNgWOz
         zfBMKxLPeON5ypea/nOHdUuqdB9AjoZacOcjHZg/ZtFC1SrdxxeWuJNQYYWIq045b62e
         NdXQ==
X-Gm-Message-State: AO0yUKU5zQRJUkyY+9DvGw8Kxcs6l07ZP7E6Dsy7Hbmy9Cn4K54cAYok
        8Oogsco39lQc1NAVweGbgobN/s6LpSM=
X-Google-Smtp-Source: AK7set9ksl+24bFaAxUEnyL+/BJIImsV6FnhzvCf/qcdAZP88XWXAi2JK5dMn173FY3lCV/CEaO5oQ==
X-Received: by 2002:a17:903:283:b0:19a:e96a:58b3 with SMTP id j3-20020a170903028300b0019ae96a58b3mr10557122plr.22.1679089212441;
        Fri, 17 Mar 2023 14:40:12 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::1380? ([2620:10d:c090:400::5:87c3])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902b20a00b001a0403f6a97sm1971696plr.202.2023.03.17.14.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 14:40:12 -0700 (PDT)
Message-ID: <a4dcfcf6-ac5b-3767-daf7-a055dfcac3cb@gmail.com>
Date:   Fri, 17 Mar 2023 14:40:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v7 6/8] libbpf: Update a bpf_link with another
 struct_ops.
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230316023641.2092778-1-kuifeng@meta.com>
 <20230316023641.2092778-7-kuifeng@meta.com>
 <2cb64258-e566-00c3-7a40-f63e90f3bf97@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <2cb64258-e566-00c3-7a40-f63e90f3bf97@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/17/23 12:42, Martin KaFai Lau wrote:
> On 3/15/23 7:36 PM, Kui-Feng Lee wrote:
>> Introduce bpf_link__update_map(), which allows to atomically update
>> underlying struct_ops implementation for given struct_ops BPF link
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   tools/lib/bpf/libbpf.c   | 30 ++++++++++++++++++++++++++++++
>>   tools/lib/bpf/libbpf.h   |  1 +
>>   tools/lib/bpf/libbpf.map |  1 +
>>   3 files changed, 32 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 6dbae7ffab48..63ec1f8fe8a0 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -11659,6 +11659,36 @@ struct bpf_link 
>> *bpf_map__attach_struct_ops(const struct bpf_map *map)
>>       return &link->link;
>>   }
>> +/*
>> + * Swap the back struct_ops of a link with a new struct_ops map.
>> + */
>> +int bpf_link__update_map(struct bpf_link *link, const struct bpf_map 
>> *map)
>> +{
>> +    struct bpf_link_struct_ops *st_ops_link;
>> +    __u32 zero = 0;
>> +    int err, fd;
>> +
>> +    if (!bpf_map__is_struct_ops(map) || map->fd < 0)
>> +        return -EINVAL;
>> +
>> +    st_ops_link = container_of(link, struct bpf_link_struct_ops, link);
>> +    /* Ensure the type of a link is correct */
>> +    if (st_ops_link->map_fd < 0)
>> +        return -EINVAL;
>> +
>> +    err = bpf_map_update_elem(map->fd, &zero, 
>> map->st_ops->kern_vdata, 0);
>> +    if (err && err != -EBUSY)
>> +        return err;
>> +
>> +    fd = bpf_link_update(link->fd, map->fd, NULL);
> 
> bpf_link_update() returns ok/error. Using "fd = ..." is confusing. Use 
> "err = ..." instead and remove the need of "int fd;".

got it.

> 
>> +    if (fd < 0)
>> +        return fd;
>> +
>> +    st_ops_link->map_fd = map->fd;
>> +
>> +    return 0;
>> +}
>> +
>>   typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct 
>> perf_event_header *hdr,
>>                                 void *private_data);
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index db4992a036f8..1615e55e2e79 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -719,6 +719,7 @@ bpf_program__attach_freplace(const struct 
>> bpf_program *prog,
>>   struct bpf_map;
>>   LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct 
>> bpf_map *map);
>> +LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const 
>> struct bpf_map *map);
>>   struct bpf_iter_attach_opts {
>>       size_t sz; /* size of this struct for forward/backward 
>> compatibility */
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index 50dde1f6521e..cc05be376257 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -387,6 +387,7 @@ LIBBPF_1.2.0 {
>>       global:
>>           bpf_btf_get_info_by_fd;
>>           bpf_link_get_info_by_fd;
>> +        bpf_link__update_map;
>>           bpf_map_get_info_by_fd;
>>           bpf_prog_get_info_by_fd;
>>   } LIBBPF_1.1.0;
> 
