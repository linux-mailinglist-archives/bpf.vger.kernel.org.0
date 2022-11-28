Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F24C63A05F
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 05:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiK1EL3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Nov 2022 23:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiK1EL2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Nov 2022 23:11:28 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48867C4
        for <bpf@vger.kernel.org>; Sun, 27 Nov 2022 20:11:27 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so12743892pjh.2
        for <bpf@vger.kernel.org>; Sun, 27 Nov 2022 20:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6TTNVq8KlwMWNDt6prBttynq1f8pAp4ny7XN9tOp038=;
        b=MTxuyf4KWdpR7isd8x7awUWaDlw16icwuI3uPgrMqb1cBZmq7LrdzxChonz2Be79u/
         t9T4Xtu/cW5d3f6ts4UjVfGdJm6FbYzIpQBv0bw4tQlW+ICoWiBRzXmPNatyjUoEl7pZ
         1BJwdu2cJ2EFLOgzNkFRCAJpeHmG59jafZg7dQT9OB8z3g12uGacF0v5/MiY4TIjrzFT
         Ait/KI6OHPr696880xzEb9wLs3K+utMLrAwy99zAcfFewpZH2gNadQvwkQz6tMkzx/h8
         677RhqWPSCSwmnVqUF2SRZ2uBI598V5TqmEk/FED1jX+aGKZROa56nm3r+MIQZ68Kwc2
         ipcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TTNVq8KlwMWNDt6prBttynq1f8pAp4ny7XN9tOp038=;
        b=GQfO7HtRFtmhowdyuesMqiiulgtz1TzEvfjUWY1PQ2/e3Jww8pVm/SwCP+nQrKkYQj
         D73dO0N1ejbrExicAVK35Q77ir3jafEuZzrfOMyD2oXG3m4Xc4bskYoOd5UtZER40AGV
         PmSsWYclDFNrHZZcIdiDmwATiYXyqegUAtmR8STT4FtAs8ZFuMRT238p3QbP2RlrLfsp
         rlyw0HsPv1hglKOYThELiGLteew0SyZPitAEodScpvkfo9JFU8XDjUV4DPDM6wNQEk66
         K7O1tVZB+FslkmHxchLQgkhaqc0kd4rP7f5dSWaY3fATM92KYfDvP1i97wWoVMAL+cL8
         9X8w==
X-Gm-Message-State: ANoB5pnYMT+MfNWWeTVbwDNoRcZY4rSc+vuou672WqvVlll6CA4xDQoG
        SkwDjyoyV5d16Vz8/4nGZc3ZBtZdx1NhUw==
X-Google-Smtp-Source: AA0mqf56coNToBltXUR3MTTTFEYH5/J3ix0OyIrnyA1Z0gjfXsl1nYfcvO7OMZsxom+u+OVrxCVpLQ==
X-Received: by 2002:a17:90b:e18:b0:219:31ed:22be with SMTP id ge24-20020a17090b0e1800b0021931ed22bemr4373904pjb.75.1669608686762;
        Sun, 27 Nov 2022 20:11:26 -0800 (PST)
Received: from [192.168.255.10] ([43.132.98.43])
        by smtp.gmail.com with ESMTPSA id z10-20020a170903018a00b00177f4ef7970sm7676763plg.11.2022.11.27.20.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 20:11:26 -0800 (PST)
Message-ID: <5ea24d9b-97b9-3da2-5d9e-5f4ea5ecea8e@gmail.com>
Date:   Mon, 28 Nov 2022 12:11:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH bpf 1/2] bpf: Check timer_off for map_in_map only when map
 value have timer
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <20221126105351.2578782-1-hengqi.chen@gmail.com>
 <20221126105351.2578782-2-hengqi.chen@gmail.com>
 <CAADnVQJ8B0oDss95P+qfQx7r0Xr8RmY-_9dAincqESzyD+ZG+w@mail.gmail.com>
 <94b5a28c-56dd-74a1-e4f5-5b5c2ffeca2a@gmail.com>
 <CAADnVQJRjW+nWtj5Kd6pHCyjKkRnjLiMSG22vXBPCp41UbASag@mail.gmail.com>
 <f6d20c9c-a411-92aa-798a-27e1bc341b1a@gmail.com>
 <CAADnVQJp-GHNCbGCJENZvnA70Hwy=-5OUHTQxx+iEK5D=hDmsQ@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <CAADnVQJp-GHNCbGCJENZvnA70Hwy=-5OUHTQxx+iEK5D=hDmsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/11/28 11:14, Alexei Starovoitov wrote:
> On Sun, Nov 27, 2022 at 7:07 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>>
>>
>> On 2022/11/28 10:49, Alexei Starovoitov wrote:
>>> On Sun, Nov 27, 2022 at 6:42 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>>>
>>>> Hi, Alexei:
>>>>
>>>> On 2022/11/28 08:44, Alexei Starovoitov wrote:
>>>>> On Sat, Nov 26, 2022 at 2:54 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>>>>>
>>>>>> The timer_off value could be -EINVAL or -ENOENT when map value of
>>>>>> inner map is struct and contains no bpf_timer. The EINVAL case happens
>>>>>> when the map is created without BTF key/value info, map->timer_off
>>>>>> is set to -EINVAL in map_create(). The ENOENT case happens when
>>>>>> the map is created with BTF key/value info (e.g. from BPF skeleton),
>>>>>> map->timer_off is set to -ENOENT as what btf_find_timer() returns.
>>>>>> In bpf_map_meta_equal(), we expect timer_off to be equal even if
>>>>>> map value does not contains bpf_timer. This rejects map_in_map created
>>>>>> with BTF key/value info to be updated using inner map without BTF
>>>>>> key/value info in case inner map value is struct. This commit lifts
>>>>>> such restriction.
>>>>>
>>>>> Sorry, but I prefer to label this issue as 'wont-fix'.
>>>>> Mixing BTF enabled and non-BTF inner maps is a corner case
>>>>
>>>> We do have such usecase. The BPF progs and maps are pinned to bpffs
>>>> using BPF object file. And the map_in_map is updated by some other
>>>> process which don't have access to such BTF info.
>>>>
>>>>> that is not worth fixing.
>>>>
>>>> Is there a way to get this fixed for v5.x series only ?
>>>>
>>>>> At some point we will require all programs and maps to contain BTF.
>>>>> It's necessary for introspection.
>>>>
>>>> We don't care much about BTF for introspection. In production, we always
>>>> have a version field and some reserved fields in the map value for backward
>>>> compatibility. The interpretation of such map values are left to upper layer.
>>>
>>> That "interpretation of such map values are left to upper layer"...
>>> is exactly the reason why we will enforce BTF in the future.
>>> Production engineers and people outside of "upper layer" sw team
>>> has to be able to debug maps and progs.
>>
>> Fine.
>>
>> In libbpf, we have:
>>
>>   if (is_inner) {
>>         pr_warn("map '%s': inner def can't be pinned.\n", map_name);
>>         return -EINVAL;
>>   }
>>
>>
>> Can we lift this restriction so that we can have an easy way to access BTF info
>> via pinned map ?
> 
> Probably. Note that __uint(pinning, LIBBPF_PIN_BY_NAME)
> is the only mode libbpf understands. It's simplistic.
> but why do you want to use that mode?
> Just pin it directly with bpf_map__pin() ?
> Or even more low level bpf_obj_pin() ?

Will try. 

Currently, we use `__uint(pinning, LIBBPF_PIN_BY_NAME)` and let
libbpf and Cilium's ebpf go library handle all the pinning jobs.

