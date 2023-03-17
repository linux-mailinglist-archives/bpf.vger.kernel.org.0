Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BF36BF35F
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCQVA3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCQVAX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:00:23 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D85EB255A
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 14:00:21 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id k2so6594049pll.8
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 14:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679086821;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qe5qEpjGKP2k6P99IGcpA1zzjrWOI8DmjEmj1sFHkv0=;
        b=HV5a9UEYN6rnWMz5q+Nh9w1Kt1/y8Q+GSkrMYjtQZqjeJ1VqK3Ub7UaX5Obw/5LYUQ
         b4svSqCXrh0KItm1mFkarkustqTxkCevdPmdMPpR6OKMHLmZc1dmtMIRECRC03ZQT9qR
         ziDNW0b0VK/IVBNfGuO8L2/f3gJEcwuF53qccgWr7/Y4zE/xjE829sBn+bm/Tnll1ofu
         nZ78i7aeJS7vbRO1LrK8jkGmhUS6XufVQVIquUTFh3TYHfWyNcMdNK8GCn3nq9iL5C6u
         1KdFvXNdd9uYw6mapBeXz42/8DGUFmeULmgKOERadX+S4f2gBIpsouDPwa1XDjQa+3rF
         5fNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679086821;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qe5qEpjGKP2k6P99IGcpA1zzjrWOI8DmjEmj1sFHkv0=;
        b=Ph5gfL14dnf9AdUme9PX1jWm1GXf2xPg1Avvbfwlh12Gz1zT3DEfdCFtpgUEyiqmJ5
         4jRsIz+xV6DHNipTSJXJo7JT8KVId2At8DVhpe78+ms3kWCG6mQSoaj2zTDP++tnFZZ2
         DcHabOVxNUO9cWJiSB7xv6G8j6oWoH/lWeWPo0ZOYh1P7Zv1UZawT1huZmicP/OqtkxK
         EmQDBnt0ssK8J4zisueL2ZiA8L7ERF7845MFQqfl3gC2+ZSngE3XR/WxfMwpzYATwlDm
         UUPXkkZ5WF6Z39Lmn5bJjm+mlHMoIzoj6TzmQDQmIIHqYQLT0bKndO/RQsdXuP82Rcvp
         B6Qg==
X-Gm-Message-State: AO0yUKVgKuOZ5Ee+2cmBzYORSN+f2pHxKtaF6i+HEj9/vMnx3uJJIGd7
        5g2XPf0mZ6eIYfPTj2MsvvyGBH4G/D4=
X-Google-Smtp-Source: AK7set8lFQyfU8cOpArl32r6BOJTZcVwGM7exSIevR55K9Q0ClOAzqUSN94DY67YdcPW0ak3119ZoA==
X-Received: by 2002:a17:903:283:b0:19d:244:a3a8 with SMTP id j3-20020a170903028300b0019d0244a3a8mr10438787plr.10.1679086821137;
        Fri, 17 Mar 2023 14:00:21 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::1380? ([2620:10d:c090:400::5:87c3])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b0019468fe44d3sm1971334plk.25.2023.03.17.14.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 14:00:20 -0700 (PDT)
Message-ID: <0d93b64f-ec74-0ad4-26fb-c66306f1492f@gmail.com>
Date:   Fri, 17 Mar 2023 14:00:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v7 4/8] libbpf: Create a bpf_link in
 bpf_map__attach_struct_ops().
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230316023641.2092778-1-kuifeng@meta.com>
 <20230316023641.2092778-5-kuifeng@meta.com>
 <228648b6-c6f0-d194-2e72-c7aaf095a35d@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <228648b6-c6f0-d194-2e72-c7aaf095a35d@linux.dev>
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



On 3/17/23 11:44, Martin KaFai Lau wrote:
> On 3/15/23 7:36 PM, Kui-Feng Lee wrote:
>> @@ -11590,31 +11631,32 @@ struct bpf_link 
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
> 
> It should not fail for BPF_F_LINK struct_ops when err is EBUSY.
> The struct_ops map can attach, detach, and then attach again.
> 
> It needs a test for this case.

Got it!

> 
>> +        free(link);
>> +        return libbpf_err_ptr(err);
>> +    }
> 
