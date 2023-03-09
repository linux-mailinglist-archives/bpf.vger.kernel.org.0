Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463FD6B17C3
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 01:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCIAWL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 19:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCIAWK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 19:22:10 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A83864B3B
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 16:22:08 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id ce8-20020a17090aff0800b0023a61cff2c6so4844078pjb.0
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 16:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678321328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBrgrhiqIunTg7Gy4AIxstMR18pdoox+VhLH3sz7YHk=;
        b=E2HDMJUxQqFUwxwDdpGxU0S2TtREN+0iruK7bP8QjujIrf+9kraQ6rnn6YOrMpv2bX
         K/z1lrG3WJlvKzB1U/lruAuTDU5+V+wB5UrePNFXQNp8H5vYtvvzK27XMUwz0J5vQbtM
         zqoCH61Jl73DpcfNZL4eZtn+jzVhkNsmrlVAjLN/eVOSisXKejsuNhAA1QDHt4IN9oId
         w0o60TM4FKYHpSt89DKQ0fs90I+6YXKYkS+qB7qeC2gU91/HdDzPKNK8L+iGHEc//048
         gqjMQBhuq5pPwxbxhiVIyOXmjPy6HcYeUmm3RnGGCEW3w/E22BSshAmwhaSv1RiShVul
         /IoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678321328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBrgrhiqIunTg7Gy4AIxstMR18pdoox+VhLH3sz7YHk=;
        b=TAz29hnatsNjMtenfeZurJEny+tv201O+tJsoUPPzOIr0LegDcab1ZNdADs4e9zwMv
         yc4QlRnTpjc35Rv9A77XfOhFblU+8jPVDsLwYvOK2SIk4x9ySmhaMuDZmx/o/+Ux4uGm
         P8RiSsxaHMWqipQzygSFg4f9LIU6J6sKR4LpKrJHdL2ipOV9KWEQ5tnDjBOMZu0yC/sY
         oUDbmqRQM6pGe0PB9WV7LHRqpVojgt1d+cZgt8y+h6moRhnuNHX7E8X9vV2Hd3tqgnpK
         0HKO5ntEhuO1ysWKY8MPt9J20zeekS5V1O15nRug8nDp3jp3+1ORv3ehsa6SgO2yMPGq
         MeNw==
X-Gm-Message-State: AO0yUKWXfKhJKMl06Ohugz5USdF5oqozC7hb2gbcyAq9muxYQo3kAv1p
        6iYTpX3rWTgZlLif3bd+7yY=
X-Google-Smtp-Source: AK7set+yZ3GRITbmE1J3psp85y1r0MFNKd93tG4X/Z94fKf1PO3RkUGkvwwbT1U9N4qLRJz2OeAqDQ==
X-Received: by 2002:a17:90a:190f:b0:237:d867:2260 with SMTP id 15-20020a17090a190f00b00237d8672260mr24954147pjg.4.1678321328018;
        Wed, 08 Mar 2023 16:22:08 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21d6::1660? ([2620:10d:c090:400::5:78e2])
        by smtp.gmail.com with ESMTPSA id b7-20020a17090a800700b00233db0db3dfsm327381pjn.7.2023.03.08.16.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 16:22:07 -0800 (PST)
Message-ID: <ce5b0ed3-f093-888d-9dbe-3f6f07bdac06@gmail.com>
Date:   Wed, 8 Mar 2023 16:22:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v5 4/8] libbpf: Create a bpf_link in
 bpf_map__attach_struct_ops().
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230308005050.255859-1-kuifeng@meta.com>
 <20230308005050.255859-5-kuifeng@meta.com>
 <1b416290-733b-0470-3217-6e477e574931@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <1b416290-733b-0470-3217-6e477e574931@linux.dev>
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



On 3/8/23 13:42, Martin KaFai Lau wrote:
> On 3/7/23 4:50 PM, Kui-Feng Lee wrote:
>> @@ -11566,22 +11591,34 @@ struct bpf_link *bpf_program__attach(const 
>> struct bpf_program *prog)
>>       return link;
>>   }
>> +struct bpf_link_struct_ops {
>> +    struct bpf_link link;
>> +    int map_fd;
>> +};
>> +
>>   static int bpf_link__detach_struct_ops(struct bpf_link *link)
>>   {
>> +    struct bpf_link_struct_ops *st_link;
>>       __u32 zero = 0;
>> -    if (bpf_map_delete_elem(link->fd, &zero))
>> -        return -errno;
>> +    st_link = container_of(link, struct bpf_link_struct_ops, link);
>> -    return 0;
>> +    if (st_link->map_fd < 0) {
> 
> map_fd < 0 should always be true?

If the user pass a wrong link, it can fail.
I check it here explicitly even the kernel returns
an error for deleting an element of a struct_ops w/ link.

> 
>> +        /* Fake bpf_link */
>> +        if (bpf_map_delete_elem(link->fd, &zero))
>> +            return -errno;
>> +        return 0;
>> +    }
>> +
>> +    /* Doesn't support detaching. */
>> +    return -EOPNOTSUPP;
>>   }
>>   struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>>   {
>> -    struct bpf_struct_ops *st_ops;
>> -    struct bpf_link *link;
>> -    __u32 i, zero = 0;
>> -    int err;
>> +    struct bpf_link_struct_ops *link;
>> +    __u32 zero = 0;
>> +    int err, fd;
>>       if (!bpf_map__is_struct_ops(map) || map->fd == -1)
>>           return libbpf_err_ptr(-EINVAL);
>> @@ -11590,31 +11627,34 @@ struct bpf_link 
>> *bpf_map__attach_struct_ops(const struct bpf_map *map)
>>       if (!link)
>>           return libbpf_err_ptr(-EINVAL);
>> -    st_ops = map->st_ops;
>> -    for (i = 0; i < btf_vlen(st_ops->type); i++) {
>> -        struct bpf_program *prog = st_ops->progs[i];
>> -        void *kern_data;
>> -        int prog_fd;
>> +    /* kern_vdata should be prepared during the loading phase. */
>> +    err = bpf_map_update_elem(map->fd, &zero, 
>> map->st_ops->kern_vdata, 0);
>> +    if (err) {
>> +        err = -errno;
>> +        free(link);
>> +        return libbpf_err_ptr(err);
>> +    }
>> -        if (!prog)
>> -            continue;
>> -        prog_fd = bpf_program__fd(prog);
>> -        kern_data = st_ops->kern_vdata + st_ops->kern_func_off[i];
>> -        *(unsigned long *)kern_data = prog_fd;
>> +    if (!(map->def.map_flags & BPF_F_LINK)) {
>> +        /* Fake bpf_link */
>> +        link->link.fd = map->fd;
>> +        link->map_fd = -1;
>> +        link->link.detach = bpf_link__detach_struct_ops;
>> +        return &link->link;
>>       }
>> -    err = bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
>> -    if (err) {
>> +    fd = bpf_link_create(map->fd, -1, BPF_STRUCT_OPS, NULL);
>> +    if (fd < 0) {
>>           err = -errno;
>>           free(link);
>>           return libbpf_err_ptr(err);
>>       }
>> -    link->detach = bpf_link__detach_struct_ops;
>> -    link->fd = map->fd;
>> +    link->link.fd = fd;
>> +    link->map_fd = map->fd;
> 
> Does it need to set link->link.detach?

Yes, I have made some changes to this part. The new code will set
link->link.detach for BPF_F_LINK as well to cleanup fd.

> 
>> -    return link;
>> +    return &link->link;
>>   }
>>   typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct 
>> perf_event_header *hdr,
> 
