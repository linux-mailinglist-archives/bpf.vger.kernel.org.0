Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60D16C3E40
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 00:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCUXE6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 19:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjCUXE5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 19:04:57 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AB8E04D
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 16:04:56 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id fd25so10061472pfb.1
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 16:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679439896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFNVS4tZKUIZ0V1cCCUq6Wui5QCkGCB8MzLHYLAND3o=;
        b=heU5nqZRXMIxIMYqNmDGPBs8O3B0N7bCxTWoOgA0oe+Tx+gau3C7QwYbndLozUSuhr
         8D/LCTjVncvXDcXiNzTeNHg+Y58/v1Mg1hZMqtfNKaf6XVkrQMNyGFHX7WJ6rh6Q2diW
         ORu2nofp9eypWE72nrNpiKYKi2AHR4cPF73Abh3fOLd1+HGJrW1mqzw9ciqfn5+ZQBB4
         F4nvIupk60O/f+sIy3wpanme7ogn3acGOFE52baFAlR1fgQcZB/xoQUFC09Q4HA/+M/c
         +ZXYOZ8gAANXADsdTN8qSn9YDWeK1Zd4cU8ICQ4fJN+CWklDLQApIkHYFUkcISFwDgZ4
         56xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679439896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFNVS4tZKUIZ0V1cCCUq6Wui5QCkGCB8MzLHYLAND3o=;
        b=bWaA5Gap85bGR4hG1fL8mkl/4PhevsYLx5KIWzOgA1EuqJOE9MsRB9PMn+P120uM/P
         E+RG3dPcjUAlPBzcuKp+3oxKSvTD3sKRWuEgTSEbN5IlKdWL1ebw9+v27jpM5LP6yfTS
         Krx24yq+kgDi4Y397BBHD4vMs8467YcedRy3JX0wR2mg7+GYKHBkx8JnRrffwfYaTfT9
         Ke7Y+i9NwjToxSBPjPF6fE4pJb/o12ZTL61YdUftZdcWaEVeRNT4+HzSIyuN0gqoG0gZ
         bDnEKKuADv4xetLWLmOGAQCx4Ja+T9gjmTymgDSA7/yjpkHCDHxn9E2FFdxfZzW3R9+R
         +YFg==
X-Gm-Message-State: AO0yUKWRV2NxRwgPIkiA24wFPknNUwyPQQzK3n5wEcWix/RB8Aeb0YU5
        m1EaLZyphfIVy8dBRqiSil4=
X-Google-Smtp-Source: AK7set9JONTlBvfg/RkFp/1puwaH5acQy5CxvJauybTGjBJGQjFd2b7SdK0n+02fNMlIkfh8FuNfaQ==
X-Received: by 2002:aa7:9821:0:b0:625:6d5b:c019 with SMTP id q1-20020aa79821000000b006256d5bc019mr1140988pfl.11.1679439896148;
        Tue, 21 Mar 2023 16:04:56 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:7b5b:78a7:738b:7b20? ([2620:10d:c090:500::7:e86])
        by smtp.gmail.com with ESMTPSA id j11-20020aa7928b000000b0061a829d2679sm8736285pfa.37.2023.03.21.16.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 16:04:55 -0700 (PDT)
Message-ID: <f65beae4-4729-b2ee-46d6-f1f81cc321e8@gmail.com>
Date:   Tue, 21 Mar 2023 16:04:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v9 6/8] libbpf: Update a bpf_link with another
 struct_ops.
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230320195644.1953096-1-kuifeng@meta.com>
 <20230320195644.1953096-7-kuifeng@meta.com>
 <57c40769-52a9-70e4-31f1-8ea6e0e73fa4@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <57c40769-52a9-70e4-31f1-8ea6e0e73fa4@linux.dev>
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



On 3/21/23 14:04, Martin KaFai Lau wrote:
> On 3/20/23 12:56 PM, Kui-Feng Lee wrote:
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 56a60ab2ca8f..f84d68c049e3 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -11639,6 +11639,11 @@ struct bpf_link 
>> *bpf_map__attach_struct_ops(const struct bpf_map *map)
>>       /* kern_vdata should be prepared during the loading phase. */
>>       err = bpf_map_update_elem(map->fd, &zero, 
>> map->st_ops->kern_vdata, 0);
>> +    /* It can be EBUSY if the map has been used to create or
>> +     * update a link before.  We don't allow updating the value of
>> +     * a struct_ops once it is set.  That ensures that the value
>> +     * never changed.  So, it is safe to skip EBUSY.
>> +     */
> 
> This belongs to the earlier patch (4?).
> 

Got it!

>>       if (err && err != -EBUSY) {
>>           free(link);
>>           return libbpf_err_ptr(err);
> 
