Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBA36983B9
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 19:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjBOSpV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 13:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBOSpV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 13:45:21 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44B93E625
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 10:44:48 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id k13so21217152plg.0
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 10:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S0KA2uCZnqmqgPCfDAfmDXtMzOkX3aSRPkGCBdYDBqs=;
        b=pMX4Lt16WI5jYdetrMDwKyJL4vP9wD+NhXkhatIEdGMZCliLRBnDjKBB+XYoF3bapE
         VXEuMVHfJ2Lf+n4xQmTWOBclNjdJKkTd3dd15gXC8rCgHC8GRV9zJYOIhObwQ3s0s4En
         a8Xrgltb7kWtjgnBvp0Qms1+BSPDu4+kdOc9c3Q3OCKXdLPScqQ2xsy+xHW5x0rs607O
         urCUgg990S8Ber+6ZvzKQAAGScFCjnop7p4pqkZFbx87wjWFDmP5sXpnALvHox9eBhj+
         y/1A/UIX+hJlP04twMRVD3x7iZ7cnwAoE3CMcrhOYLTRg1cUMEae0dappSuv9f+Zv1uj
         0wTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0KA2uCZnqmqgPCfDAfmDXtMzOkX3aSRPkGCBdYDBqs=;
        b=az/hhO+7/tgK2LMy5UTk8d8j/NW3vWkVWfm85FKKTCsqQzzGtYnifD21rmD08w3WH/
         3CeB7Iq7btIZDD8c0LDbQkW9230D3K27AwglZcF6M81hHh5RDD0K8IlkRfQl45xCHqEA
         iENBOHTjtIUYt3ZFXIvmlLrIGK7BiTis/3G6hVtMsHRhtUhXqYojOLSfzweWQmNirhvA
         Du4l1/uMSDaO5H7JBKBvlWQiBmXyxqONjTkPZELZH4JZDFfUu5jtXo/fbhBdWShb6upC
         y9iCb9MXkB/L/akZ/HOlj40KHYoRI0MF7trvU226unTJBCrif2S+d61+CGp084mMzGL5
         4Ckg==
X-Gm-Message-State: AO0yUKUV8vVIkGCfSL72rivlOBJ+lkh8F/jobUrCyrqux2DP/SLYkyS/
        vJqnzX+acIaHPPZlFD3GSHE=
X-Google-Smtp-Source: AK7set828GBarcDnJxTM6XblTy3BdI4CG7ugjB2pNWPbCqt2qVNcBmSvw006ZH+emD10n1Y6HLHK7w==
X-Received: by 2002:a05:6a20:3c8b:b0:be:22b4:9e6a with SMTP id b11-20020a056a203c8b00b000be22b49e6amr3604168pzj.61.1676486654824;
        Wed, 15 Feb 2023 10:44:14 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21e8::1452? ([2620:10d:c090:400::5:1af8])
        by smtp.gmail.com with ESMTPSA id s15-20020a63924f000000b004e28be19d1csm3916425pgn.32.2023.02.15.10.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 10:44:14 -0800 (PST)
Message-ID: <7149cfe4-7ae4-a8e9-6f85-38e488080f28@gmail.com>
Date:   Wed, 15 Feb 2023 10:44:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH bpf-next 4/7] libbpf: Create a bpf_link in
 bpf_map__attach_struct_ops().
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-5-kuifeng@meta.com> <Y+xKOq4gW58IDMWE@google.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <Y+xKOq4gW58IDMWE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2/14/23 18:58, Stanislav Fomichev wrote:
> On 02/14, Kui-Feng Lee wrote:
>> bpf_map__attach_struct_ops() was creating a dummy bpf_link as a
>> placeholder, but now it is constructing an authentic one by calling
>> bpf_link_create() if the map has the BPF_F_LINK flag.
>
>> You can flag a struct_ops map with BPF_F_LINK by calling
>> bpf_map__set_map_flags().
>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   tools/lib/bpf/libbpf.c | 73 +++++++++++++++++++++++++++++++++---------
>>   1 file changed, 58 insertions(+), 15 deletions(-)
>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 75ed95b7e455..1eff6a03ddd9 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -11430,29 +11430,41 @@ struct bpf_link *bpf_program__attach(const 
>> struct bpf_program *prog)
>>       return link;
>>   }
>
>> +struct bpf_link_struct_ops_map {
>> +    struct bpf_link link;
>> +    int map_fd;
>> +};
>
> Ah, ok, now you're adding bpf_link_struct_ops_map. I guess I'm now
> confused why you haven't done it in the first patch :-/

Just won't to mix the libbpf part and kernel part in one patch.


>
> And what are these fake bpf_links? Can you share more about it means?

For the next version, I will detail it in the commit log. In a nutshell, 
before this point, there was no bpf_link for struct_ops. Libbpf 
attempted to create an equivalent interface to other BPF programs by 
providing a simulated bpf_link instead of a true one from the kernel; 
that fake bpf_link stores FDs associated with struct_ops maps rather 
than real bpf_links.


>
>> +
>>   static int bpf_link__detach_struct_ops(struct bpf_link *link)
>>   {
>> +    struct bpf_link_struct_ops_map *st_link;
>>       __u32 zero = 0;
>
>> -    if (bpf_map_delete_elem(link->fd, &zero))
>> +    st_link = container_of(link, struct bpf_link_struct_ops_map, link);
>> +
>> +    if (st_link->map_fd < 0) {
>> +        /* Fake bpf_link */
>> +        if (bpf_map_delete_elem(link->fd, &zero))
>> +            return -errno;
>> +        return 0;
>> +    }
>> +
>> +    if (bpf_map_delete_elem(st_link->map_fd, &zero))
>> +        return -errno;
>> +
>> +    if (close(link->fd))
>>           return -errno;
>
>>       return 0;
>>   }
>
>> -struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>> +/*
>> + * Update the map with the prepared vdata.
>> + */
>> +static int bpf_map__update_vdata(const struct bpf_map *map)
>>   {
>>       struct bpf_struct_ops *st_ops;
>> -    struct bpf_link *link;
>>       __u32 i, zero = 0;
>> -    int err;
>> -
>> -    if (!bpf_map__is_struct_ops(map) || map->fd == -1)
>> -        return libbpf_err_ptr(-EINVAL);
>> -
>> -    link = calloc(1, sizeof(*link));
>> -    if (!link)
>> -        return libbpf_err_ptr(-EINVAL);
>
>>       st_ops = map->st_ops;
>>       for (i = 0; i < btf_vlen(st_ops->type); i++) {
>> @@ -11468,17 +11480,48 @@ struct bpf_link 
>> *bpf_map__attach_struct_ops(const struct bpf_map *map)
>>           *(unsigned long *)kern_data = prog_fd;
>>       }
>
>> -    err = bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
>> +    return bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
>> +}
>> +
>> +struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>> +{
>> +    struct bpf_link_struct_ops_map *link;
>> +    int err, fd;
>> +
>> +    if (!bpf_map__is_struct_ops(map) || map->fd == -1)
>> +        return libbpf_err_ptr(-EINVAL);
>> +
>> +    link = calloc(1, sizeof(*link));
>> +    if (!link)
>> +        return libbpf_err_ptr(-EINVAL);
>> +
>> +    err = bpf_map__update_vdata(map);
>>       if (err) {
>>           err = -errno;
>>           free(link);
>>           return libbpf_err_ptr(err);
>>       }
>
>> -    link->detach = bpf_link__detach_struct_ops;
>> -    link->fd = map->fd;
>> +    link->link.detach = bpf_link__detach_struct_ops;
>
>> -    return link;
>> +    if (!(map->def.map_flags & BPF_F_LINK)) {
>> +        /* Fake bpf_link */
>> +        link->link.fd = map->fd;
>> +        link->map_fd = -1;
>> +        return &link->link;
>> +    }
>> +
>> +    fd = bpf_link_create(map->fd, -1, BPF_STRUCT_OPS_MAP, NULL);
>> +    if (fd < 0) {
>> +        err = -errno;
>> +        free(link);
>> +        return libbpf_err_ptr(err);
>> +    }
>> +
>> +    link->link.fd = fd;
>> +    link->map_fd = map->fd;
>> +
>> +    return &link->link;
>>   }
>
>>   typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct 
>> perf_event_header *hdr,
>> -- 
>> 2.30.2
>
