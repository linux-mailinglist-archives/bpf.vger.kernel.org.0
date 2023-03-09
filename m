Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9FA6B2CD1
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 19:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjCISUE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 13:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjCISUC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 13:20:02 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D095DDCF69
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 10:19:49 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p6so2974533plf.0
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 10:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678385989;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OMemhnr9a4/8ZMHpQbCi0SxkJQXC6TgafSP+1PT/VKU=;
        b=CeeS/l8FRimmiEL9U/5Br9t4C7VZYNxO2ppNYvN8VlXu/Ce52QfGWLDt4WrquyUlr9
         C+1DedPnhj/l2CiE12KfSEHYs/zE5S4u5UH8Zy3oc6z7xGIRH7hhY1THxAPfd34urfwL
         xPBPr7/dEbp/57rfuZw41tt/rDkGqtyibSjqxshlL0QfN9ruq+pF5epmVBH0THzKg6+x
         vfckG6mMwdvA4cBzYSJFQzwe7bF0FzWNH0NUMdKHZjgYc/e8swlhRokWuRyPo0x2AUrQ
         I8k7lkc5OTUqKKRYhlGGF9UIvN6kcOxnbS/ifRWS8YYDMtGsPHOATJIo6ajaLaFqSpx6
         id1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678385989;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMemhnr9a4/8ZMHpQbCi0SxkJQXC6TgafSP+1PT/VKU=;
        b=hthopLLX8buiRuBkBYtRsba0yPdzXRhf2WzUBK34qIwIjYpoU1zyt/ADbYEsiGlVWD
         7+i3NOdnwekJgF71iVGc8Nv3MfJ0O/eG9DhB8WWJbwu+1t2rZYsRIlSUvjlHYbHHbUzL
         /yOS1ErO2yk6ZtiZz+XyaCH21zsJubmP/fXTVOnpOSKB1aniYm/i3LMDMtqGwiz3/s9V
         lsuax5BuevJThBWkrYOIHx9DM7WbDRQ5GHmDPu7EGOsy+UbCy0/ZsZFWfKb7B6R1GLne
         noY+Dfw05Av4sviqnwMfQQ5J2kamksT8qd8UjXavKbhh9wd6RQEJLAJyE0J79GWNWAmC
         pjwA==
X-Gm-Message-State: AO0yUKVFGRa/i2sI0AaWsSoV363469X0SpadC0yhRQOFRB8FNNeBIb5F
        0qc6BqJ+Wqnt8WPq0mxpN/o=
X-Google-Smtp-Source: AK7set9STuBIgV87WwQ/NHoWSY4nYHjPyDBl5VQe6GGU655pStZ2PW1mp+MNfi3BaJbvBEfGRqTLQQ==
X-Received: by 2002:a05:6a20:748c:b0:cc:5b1d:7d8d with SMTP id p12-20020a056a20748c00b000cc5b1d7d8dmr22520574pzd.17.1678385989318;
        Thu, 09 Mar 2023 10:19:49 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21cf::103c? ([2620:10d:c090:400::5:3f40])
        by smtp.gmail.com with ESMTPSA id j14-20020a62e90e000000b005a8de0f4c76sm11856776pfh.17.2023.03.09.10.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 10:19:48 -0800 (PST)
Message-ID: <93461e0c-b38b-cd9d-a92b-5dad062d5cc1@gmail.com>
Date:   Thu, 9 Mar 2023 10:19:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v5 4/8] libbpf: Create a bpf_link in
 bpf_map__attach_struct_ops().
Content-Language: en-US, en-ZW
From:   Kui-Feng Lee <sinquersw@gmail.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230308005050.255859-1-kuifeng@meta.com>
 <20230308005050.255859-5-kuifeng@meta.com>
 <1b416290-733b-0470-3217-6e477e574931@linux.dev>
 <ce5b0ed3-f093-888d-9dbe-3f6f07bdac06@gmail.com>
 <74abb86f-e0c2-8a0b-c90d-502ffda1571e@linux.dev>
 <742b762d-14f7-8d1e-4aeb-8bb0634dba4b@gmail.com>
In-Reply-To: <742b762d-14f7-8d1e-4aeb-8bb0634dba4b@gmail.com>
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



On 3/9/23 10:16, Kui-Feng Lee wrote:
> 
> 
> On 3/9/23 09:09, Martin KaFai Lau wrote:
>> On 3/8/23 4:22 PM, Kui-Feng Lee wrote:
>>>
>>>
>>> On 3/8/23 13:42, Martin KaFai Lau wrote:
>>>> On 3/7/23 4:50 PM, Kui-Feng Lee wrote:
>>>>> @@ -11566,22 +11591,34 @@ struct bpf_link 
>>>>> *bpf_program__attach(const struct bpf_program *prog)
>>>>>       return link;
>>>>>   }
>>>>> +struct bpf_link_struct_ops {
>>>>> +    struct bpf_link link;
>>>>> +    int map_fd;
>>>>> +};
>>>>> +
>>>>>   static int bpf_link__detach_struct_ops(struct bpf_link *link)
>>>>>   {
>>>>> +    struct bpf_link_struct_ops *st_link;
>>>>>       __u32 zero = 0;
>>>>> -    if (bpf_map_delete_elem(link->fd, &zero))
>>>>> -        return -errno;
>>>>> +    st_link = container_of(link, struct bpf_link_struct_ops, link);
>>>>> -    return 0;
>>>>> +    if (st_link->map_fd < 0) {
>>>>
>>>> map_fd < 0 should always be true?
>>>
>>> If the user pass a wrong link, it can fail.
>>
>> I may have missed something. How can user directly pass a link to this 
>> static function?
> 
> Ouch! You are right. This check is not necessary. I mixed it with the 
> old detach feature.

By the way, I will keep this test here since this function will handle
the case w/o a link as well.

> 
> 
>>
>>> I check it here explicitly even the kernel returns
>>> an error for deleting an element of a struct_ops w/ link.
>> Yep, the kernel should have stopped the delete if the user somehow 
>> corrupted the map_fd to -1.
>>
>>>
>>>>
>>>>> +        /* Fake bpf_link */
>>>>> +        if (bpf_map_delete_elem(link->fd, &zero))
>>>>> +            return -errno;
>>>>> +        return 0;
>>>>> +    }
>>>>> +
>>>>> +    /* Doesn't support detaching. */
>>>>> +    return -EOPNOTSUPP;
>>
