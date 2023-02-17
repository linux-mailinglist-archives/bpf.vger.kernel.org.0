Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C0F69B561
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 23:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBQWRx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 17:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjBQWRw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 17:17:52 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A41165687
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 14:17:44 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id mj16so2602715pjb.3
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 14:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwmCU4WDcPhY4C/VpscM/5R3WUcCJ6LltOvPVt84Tr8=;
        b=PFk+HaK42YLjit0/DioaZH4tBgM9gs0yOpXN1dNLbIt5PFvD2xBLNX2dOqrBHvkXJb
         YkDRmR3Wiqca4TNIkZeWGo+3/igD0+6NS/jiEY/HEj26BrRjG0kMXx4LbDOx5CSiZtp5
         4iDzWTJsMZ3UxEXpi0kJ11xkfUuwn7wPAwTiwyd6tKvRbyow66/VdP01YyAX6mbjeI/2
         15sRHV8HhuyNLkJem3kwMcRjjbCXU2NKFJP/aBlz6Y+54l6ZG0lO/C3l7O1dPqH70VyP
         aiuLQtdJAicjuEgE5PgnWLWKYEk8IM3VmqkSxDvcX+xLvT70dFpg4vLGxjbYKVlSScQU
         SODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwmCU4WDcPhY4C/VpscM/5R3WUcCJ6LltOvPVt84Tr8=;
        b=rMfKuQ48nXfb+eelug4jUQetvL8LiXQxPi9q9NhYFDpnYiS4vi1DJ+rUzhgnMydk33
         G0TvxjBtL3lWrDPCViR3ou3G2WMShDk3bdCKzuHWjWxNTi65+NBPCFtROBn5hc/TiOnM
         zDDzmE84tH9wvkGC1vATbNJV3xokIPV+68TGjZPOjBwLYYcOptcKNSR1JRNbGFQ29kR5
         r7e4eLmrNxIc9iXLVb8Lb2Dm/PI1vEaoU6+2D5CwpkiXxJBgaSK/w/jCNHNn6ctQwbyt
         TiVTuZFaE4WPmr2UpUmjXx1IaKcg/LoRrc1OEL6jBPXc1786KoO3H751CNEj05gKdyf0
         uj9w==
X-Gm-Message-State: AO0yUKX8gDMOfHAQYLCkZL/HCP80M3nNMwQOvl76MygGgMANV2mH3Suh
        C2AMRXSXWT2WkYK1p9+F6yw=
X-Google-Smtp-Source: AK7set9Gnf1PnD8z/yoylvbcq4/YiNi8u5TJt4OnDwvMn3kGCuTBT57gQjnCyckzklFdYDK663nG+Q==
X-Received: by 2002:a17:902:7c90:b0:196:2b0d:feb7 with SMTP id y16-20020a1709027c9000b001962b0dfeb7mr1601973pll.13.1676672263586;
        Fri, 17 Feb 2023 14:17:43 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21cf::1210? ([2620:10d:c090:400::5:2cec])
        by smtp.gmail.com with ESMTPSA id jn11-20020a170903050b00b0019952745898sm3584817plb.161.2023.02.17.14.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 14:17:43 -0800 (PST)
Message-ID: <c7633871-fd41-69ae-13b2-62abee113f65@gmail.com>
Date:   Fri, 17 Feb 2023 14:17:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH bpf-next 3/7] bpf: Register and unregister a struct_ops by
 their bpf_links.
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-4-kuifeng@meta.com>
 <4f5012d6-e07a-2602-3526-d43244d9d978@linux.dev>
 <28a01a8a-77d2-dcdc-eda4-a6ff7c7b54c0@gmail.com>
 <64d1219c-3d07-733a-17cc-17bb8fd27827@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <64d1219c-3d07-733a-17cc-17bb8fd27827@linux.dev>
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



On 2/16/23 14:38, Martin KaFai Lau wrote:
> On 2/16/23 8:42 AM, Kui-Feng Lee wrote:
>>>> @@ -638,6 +647,8 @@ static struct bpf_map 
>>>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>>>       set_vm_flush_reset_perms(st_map->image);
>>>>       bpf_map_init_from_attr(map, attr);
>>>> +    map->map_flags |= attr->map_flags & BPF_F_LINK;
>>>
>>> This should have already been done in bpf_map_init_from_attr().
>>
>> bpf_map_init_from_attr() will filter out all flags except BPF_F_RDONLY 
>> & BPF_F_WRONLY.
> 
> should be the opposite:
> 
> static u32 bpf_map_flags_retain_permanent(u32 flags)
> {
>      /* Some map creation flags are not tied to the map object but
>           * rather to the map fd instead, so they have no meaning upon
>           * map object inspection since multiple file descriptors with
>           * different (access) properties can exist here. Thus, given
>           * this has zero meaning for the map itself, lets clear these
>           * from here.
>           */
>      return flags & ~(BPF_F_RDONLY | BPF_F_WRONLY);
> }

Got it! Thank you!
