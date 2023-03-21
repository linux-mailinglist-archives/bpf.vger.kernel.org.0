Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6268C6C3E3A
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 00:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCUXDg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 19:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCUXDc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 19:03:32 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAFC4615A
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 16:03:31 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bn14so2099069pgb.11
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 16:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679439811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i8uAzwsUjjRao5bzMotzUD2My8AoYzMd+XOM33ouM/g=;
        b=GQ3a/f5wNVREljrUYyxYLNRYZkqk7vHlIAHI8mifqrTL5n7mWaLkMNMTT+dfXqTBQv
         28LBPlWLSsKzX00KOv8dsigBLheyzAyCPqaGugJ/uMfSFD7SpN2sP9j6CyQbQ13h4rUo
         aSeqwik80HXNYphnRhXCZXlhN8O5gAt4gI3fI38DhfcHFpz0mhiJry20gtDGRYOvI8P/
         feKkKk1D7T42lJsHC7PdeTz3SZbZMHYSAjkjkzPMnLYAgaUbujcBEKNGtpilHBwq7oBJ
         T+aWxu4UMYpxUnl238/ieG7FHCFHAvc/dbOzjChOxIIw+wkaxdp5nhBLaDOadEoRNswJ
         7+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679439811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8uAzwsUjjRao5bzMotzUD2My8AoYzMd+XOM33ouM/g=;
        b=earJF7SI6jn3Tl6XU1ExAtPR39EwPsX9awR19Yj9WK7D0tIFRhRf8Vykpz46sLX17z
         JHphYf33k+wBlOI1RCcpsGAp6TL1jUA9yqG5BnGMf0jwja0FnN8D5Qm4qwwH4luhWa0I
         DG8KEjQnmkQHze9OllEIcUro6qJJ37Nua8d1sr2X1M6QQ45+9AewhmFC9FkyB2STl2dV
         bIN422AuKDb/cJc9ELuo64GIYczrGatYW3XRWDZVbHIiS2ufkVP6SFxq2nlC0uPRjcNp
         19xdLC3RAsmdTmiG17BChsDTodoi73M86WBVlcrsoWJEEpSYzTVL+nrmy0D0eNDldica
         yWmQ==
X-Gm-Message-State: AO0yUKVWfJJXJ+MSTDgcK5jTjr2bdHVi1C07fRWpnd857s09jFCVtaus
        /Q2E9YWytLkz7lP2Z3lQ1Ec=
X-Google-Smtp-Source: AK7set8u5HVkgyZ6S7NFJwpRUxMqn3a8tKpQ9ja/3IqxbhwU0sWhWTEt5uYztLRq74G/v3mQ6i4Cdg==
X-Received: by 2002:aa7:842c:0:b0:624:3061:7dbf with SMTP id q12-20020aa7842c000000b0062430617dbfmr1264149pfn.25.1679439810500;
        Tue, 21 Mar 2023 16:03:30 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:7b5b:78a7:738b:7b20? ([2620:10d:c090:500::7:e86])
        by smtp.gmail.com with ESMTPSA id e12-20020a62ee0c000000b005d866d184b5sm8648913pfi.46.2023.03.21.16.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 16:03:29 -0700 (PDT)
Message-ID: <4adb8751-1ae4-fcd8-096e-e3c6681aa2b3@gmail.com>
Date:   Tue, 21 Mar 2023 16:03:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v9 4/8] libbpf: Create a bpf_link in
 bpf_map__attach_struct_ops().
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230320195644.1953096-1-kuifeng@meta.com>
 <20230320195644.1953096-5-kuifeng@meta.com>
 <6157e6c1-1085-b4da-120b-98ccbdfa411d@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <6157e6c1-1085-b4da-120b-98ccbdfa411d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/21/23 10:49, Martin KaFai Lau wrote:
> On 3/20/23 12:56 PM, Kui-Feng Lee wrote:
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
>> @@ -11596,31 +11637,32 @@ struct bpf_link 
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
>> +    if (err && err != -EBUSY) {
>> +        free(link);
>> +        return libbpf_err_ptr(err);
>> +    }
>> -        if (!prog)
>> -            continue;
>> +    link->link.detach = bpf_link__detach_struct_ops;
>> -        prog_fd = bpf_program__fd(prog);
>> -        kern_data = st_ops->kern_vdata + st_ops->kern_func_off[i];
>> -        *(unsigned long *)kern_data = prog_fd;
>> +    if (!(map->def.map_flags & BPF_F_LINK)) {
> 
> hmm... This still does not look right. 'err' could be -EBUSY here and 
> should not be treated as success for non BPF_F_LINK case. The above 'err 
> && err != -EBUSY' check should also consider the BPF_F_LINK map_flags.

Ouch! Will fixed it.

> 
> [ Replied on the wrong v9, so copy-and-paste the reply back to this v9. ]
> 
>> +        /* w/o a real link */
>> +        link->link.fd = map->fd;
>> +        link->map_fd = -1;
>> +        return &link->link;
>>       }
>> -    err = bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
>> -    if (err) {
>> -        err = -errno;
>> +    fd = bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, NULL);
>> +    if (fd < 0) {
>>           free(link);
>> -        return libbpf_err_ptr(err);
>> +        return libbpf_err_ptr(fd);
>>       }
>> -    link->detach = bpf_link__detach_struct_ops;
>> -    link->fd = map->fd;
>> +    link->link.fd = fd;
>> +    link->map_fd = map->fd;
>> -    return link;
>> +    return &link->link;
>>   }
>>   typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct 
>> perf_event_header *hdr,
> 
