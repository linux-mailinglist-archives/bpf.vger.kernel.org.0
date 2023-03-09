Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EC56B2CBE
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 19:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCISQg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 13:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCISQ2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 13:16:28 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0E862339
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 10:16:27 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id u5so2900074plq.7
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 10:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678385787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ja976wsA5at/UYB3/h2hvtKvzR3I6ZfoH61KeEz16s0=;
        b=lYmmk19MDOidtG3zTrd6toukcLPnEaVIvbT2EtR2LwbwBbEdky2euoO1PleooYD/HS
         +SA75eIGysBy5vRz0GMk29MfxDf7kvGes4SuiA+1iUvRC54uUcP+7B4BcoAWvGBkCnQG
         wFT5y6xDp6+khMj197EKKU3kukQAmDgzzkvmoMJPHjVzwEhYdwHTaSoRG52E4wY3/CyJ
         /fZERJ8NHNbVeFcM+o5/QqkIO2g4gunQVG1592zzO3AzmrK/ea+gAyxzJwsAj7cS17yI
         pXt+/a0pjEM5VeCMAd72D0vo9aX/1eoykO/3OMUZ9QH1+LEtlwyhg/4Drv/JoqjJ1gYB
         URCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678385787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ja976wsA5at/UYB3/h2hvtKvzR3I6ZfoH61KeEz16s0=;
        b=f5eXwioEN7CAGfVWmY7HTYPvdlQgMN2+BwGpPxyZqzmYqyYV0JrjAh3qwLo9/XN/AH
         4yShvTrZ41WPwzoflxWMKO2YFy5ZzFhWa8tIw52zvxKM7zeRlXrM2CtjG9ooFtMMQjqw
         qtAdhbOz3NpvlflYH+tzq2SNVU6Os2ENgTIl5kyy69H/nUguNbvsSKJpsCsq0M+Samwk
         9bBW1y7pKXXQyjls3Krg9u0DasB1E2h5TZwjr9FniTgv06c9IfZwtr3OvSsWGWnFNcdO
         Y0vNTiI2Q5JhmZ5ZL5b55LHL3rXCm+Bhpg31e2Ps+srfAOl9JQtib5bOz+LsK6fcaXO6
         5Bsg==
X-Gm-Message-State: AO0yUKUUBtLisFIgV364iVgdU6BVhrYu80hyuD41cmXU43xsk/zwOAMG
        +kh0NedXtvjQPJrTrvTOPEg8jF6yIvc=
X-Google-Smtp-Source: AK7set+KlYWUeggecIvMZfI5zhYpaNFOViogci6UJZW5vq2Wy6OwlWkvNPnGUlYfLFCu4mlUs+mThg==
X-Received: by 2002:a17:902:d50f:b0:19e:aafe:f7e9 with SMTP id b15-20020a170902d50f00b0019eaafef7e9mr23177060plg.25.1678385786966;
        Thu, 09 Mar 2023 10:16:26 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21cf::103c? ([2620:10d:c090:400::5:3f40])
        by smtp.gmail.com with ESMTPSA id lh3-20020a170903290300b0019a91895cdfsm11952281plb.50.2023.03.09.10.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 10:16:26 -0800 (PST)
Message-ID: <742b762d-14f7-8d1e-4aeb-8bb0634dba4b@gmail.com>
Date:   Thu, 9 Mar 2023 10:16:24 -0800
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
 <ce5b0ed3-f093-888d-9dbe-3f6f07bdac06@gmail.com>
 <74abb86f-e0c2-8a0b-c90d-502ffda1571e@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <74abb86f-e0c2-8a0b-c90d-502ffda1571e@linux.dev>
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



On 3/9/23 09:09, Martin KaFai Lau wrote:
> On 3/8/23 4:22 PM, Kui-Feng Lee wrote:
>>
>>
>> On 3/8/23 13:42, Martin KaFai Lau wrote:
>>> On 3/7/23 4:50 PM, Kui-Feng Lee wrote:
>>>> @@ -11566,22 +11591,34 @@ struct bpf_link *bpf_program__attach(const 
>>>> struct bpf_program *prog)
>>>>       return link;
>>>>   }
>>>> +struct bpf_link_struct_ops {
>>>> +    struct bpf_link link;
>>>> +    int map_fd;
>>>> +};
>>>> +
>>>>   static int bpf_link__detach_struct_ops(struct bpf_link *link)
>>>>   {
>>>> +    struct bpf_link_struct_ops *st_link;
>>>>       __u32 zero = 0;
>>>> -    if (bpf_map_delete_elem(link->fd, &zero))
>>>> -        return -errno;
>>>> +    st_link = container_of(link, struct bpf_link_struct_ops, link);
>>>> -    return 0;
>>>> +    if (st_link->map_fd < 0) {
>>>
>>> map_fd < 0 should always be true?
>>
>> If the user pass a wrong link, it can fail.
> 
> I may have missed something. How can user directly pass a link to this 
> static function?

Ouch! You are right. This check is not necessary. I mixed it with the 
old detach feature.


> 
>> I check it here explicitly even the kernel returns
>> an error for deleting an element of a struct_ops w/ link.
> Yep, the kernel should have stopped the delete if the user somehow 
> corrupted the map_fd to -1.
> 
>>
>>>
>>>> +        /* Fake bpf_link */
>>>> +        if (bpf_map_delete_elem(link->fd, &zero))
>>>> +            return -errno;
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    /* Doesn't support detaching. */
>>>> +    return -EOPNOTSUPP;
> 
