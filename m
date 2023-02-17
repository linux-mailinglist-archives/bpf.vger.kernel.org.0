Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FF369AAE9
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 12:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjBQL7g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 06:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBQL7e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 06:59:34 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFB066CD1
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 03:59:27 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bt27so396001wrb.3
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 03:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DK/CgSsg2KwVUYyuOX48SIewHpMap41EOxdkYauGL+U=;
        b=DaO8/T6pfK2bL6R+cFwOPAfo2qnGIEEq/pDwUjVNfgqTHtyJ/avOI7tJs35bCZhdOX
         sOkX2pbuRPd5WdlVfRj8x8OskvFmaTmB37RqQbPYKTX72LDrJw7BfpR/kdxjz5zKww/C
         h1uaHTghnuGauW5a0FFMUtFHURob5ic07Y2uv4R0Ky1l6ac3hpGW6ejlf91oNU3OWZnM
         oW/5CUcBJ/rTHse/ipWRDhCq5mf0jiqkjSB8XwcmBffGoWFyYUOHM6oFWJbUgA73lT2S
         Kxu2t3WFASjYHB4j2Lfk3Pj+YV5H15pBL4JtMlXXx1X+Um3KO7SQjMY3vUJetn2ry3Fl
         +zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DK/CgSsg2KwVUYyuOX48SIewHpMap41EOxdkYauGL+U=;
        b=gPSrsOszOb5ln9rqVH/sKOUAU3eHlWJNoAMKIcCCa3x+24yW0BHXDVIIJsPsHeyzJv
         A5sv9hrYLW+qaL28c7XxNH2WaIqot7UnTjvrngBGyZn1mozvU/3VC+XaXwIfL1qFlBBG
         uvrfJyQkpPBcFDC/zicYlNvEQhlvJsvFLjdfnA7VVwTUXRXAMAwxGOi86QqfPz3vvgxS
         2RA1WeQfkz9hO1cc+fHYYYcyPjTpDPn4Lg6gr3cyVecb6/mxKItduImWbIagk4DaCrTe
         5Jj8dDCFunxIszKBYZfChSMcAPHeABhV5nFwdiX4SqzHaV8nFFV3syee/hDj4eqnhLjf
         wqTA==
X-Gm-Message-State: AO0yUKVv2L8hv36GP2CA4k+giIoPRYaUT95mbg7cVGYEhx3/VW7MAA5V
        in0oMngcc8a7/DAf32GTnFbZfAXBEvtawGfZ1Qsjlw==
X-Google-Smtp-Source: AK7set+Qveqt0pg/bWul6375wPA3LNybD2SBr+dVEeJo3j7HvJi6kFQrqjyJctyGZUwpvFKU+WEYPQ==
X-Received: by 2002:a5d:5386:0:b0:2bf:f4f7:be9c with SMTP id d6-20020a5d5386000000b002bff4f7be9cmr66516wrv.14.1676635165906;
        Fri, 17 Feb 2023 03:59:25 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:e171:8c51:c644:618e? ([2a02:8011:e80c:0:e171:8c51:c644:618e])
        by smtp.gmail.com with ESMTPSA id a17-20020adff7d1000000b002c3d29d83d2sm4038818wrq.63.2023.02.17.03.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 03:59:25 -0800 (PST)
Message-ID: <33f48f89-15d0-58a7-b5ce-a934f4379166@isovalent.com>
Date:   Fri, 17 Feb 2023 11:59:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RFC] libbbpf/bpftool: Support 32-bit Architectures.
Content-Language: en-GB
To:     Puranjay Mohan <puranjay12@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com
References: <CANk7y0joRFw2F4iAuN9r-dWWMvOmbFZz_J4rhGhgVFjdnxPTYw@mail.gmail.com>
 <Y+2J+jIFIxGOW32X@google.com>
 <CAEf4BzaQJfB0Qh2Wn5wd9H0ZSURbzWBfKkav8xbkhozqTWXndw@mail.gmail.com>
 <CANk7y0iKQX7BdGabDgHmTa=BXc_WCh3rkh5xjqJqc56FJs-QUA@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CANk7y0iKQX7BdGabDgHmTa=BXc_WCh3rkh5xjqJqc56FJs-QUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-02-17 11:25 UTC+0100 ~ Puranjay Mohan <puranjay12@gmail.com>
> Hi,
> Thanks for the response.
> 
> On Thu, Feb 16, 2023 at 11:13 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Wed, Feb 15, 2023 at 5:48 PM Stanislav Fomichev <sdf@google.com> wrote:
>>>
>>> On 02/15, Puranjay Mohan wrote:
>>>> The BPF selftests fail to compile on 32-bit architectures as the skeleton
>>>> generated by bpftool doesn’t take into consideration the size difference
>>>> of
>>>> variables on 32-bit/64-bit architectures.
>>>
>>>> As an example,
>>>> If a bpf program has a global variable of type: long, its skeleton will
>>>> include
>>>> a bss map that will have a field for this variable. The long variable in
>>>> BPF is
>>>> 64-bit. if we are working on a 32-bit machine, the generated skeleton has
>>>> to
>>>> compile for that machine where long is 32-bit.
>>>
>>>> A reproducer for this issue:
>>>>          root@56ec59aa632f:~# cat test.bpf.c
>>>>          long var;
>>>
>>>>          root@56ec59aa632f:~# clang -target bpf -g -c test.bpf.c
>>>
>>>>          root@56ec59aa632f:~# bpftool btf dump file test.bpf.o format raw
>>>>          [1] INT 'long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
>>>>          [2] VAR 'var' type_id=1, linkage=global
>>>>          [3] DATASEC '.bss' size=0 vlen=1
>>>>                 type_id=2 offset=0 size=8 (VAR 'var')
>>>
>>>>         root@56ec59aa632f:~# bpftool gen skeleton test.bpf.o > skeleton.h
>>>
>>>>         root@56ec59aa632f:~# echo "#include \"skeleton.h\"" > test.c
>>>
>>>>         root@56ec59aa632f:~# gcc test.c
>>>>         In file included from test.c:1:
>>>>         skeleton.h: In function 'test_bpf__assert':
>>>>         skeleton.h:231:2: error: static assertion failed: "unexpected
>>>> size of \'var\'"
>>>>           231 |  _Static_assert(sizeof(s->bss->var) == 8, "unexpected
>>>> size of 'var'");
>>>>                  |  ^~~~~~~~~~~~~~
>>>
>>>> One naive solution for this would be to map ‘long’ to ‘long long’ and
>>>> ‘unsigned long’ to ‘unsigned long long’. But this doesn’t solve everything
>>>> because this problem is also seen with pointers that are 64-bit in BPF and
>>>> 32-bit in 32-bit machines.
>>>
>>>> I want to work on solving this and am looking for ideas to solve it
>>>> efficiently.
>>>> The main goal is to make libbbpf/bpftool host architecture agnostic.
>>>
>>> Looks like bpftool needs to be aware of the target architecture. The
>>> same way gcc is doing with build-host-target triplet. I don't
>>> think this can be solved with a bunch of typedefs? But I've long
>>> forgotten how a pure 32-bit machine looks, so I can't give any
>>> useful input :-(
>>
>> Yeah, I'd rather avoid making bpftool aware of target architecture.
>> Three is 32 vs 64 bitness, there is also little/big endianness, etc.

I'd rather avoid that too, but for addressing the endianness issue with
cross-compiling, reported by Christophe and where the bytecode is not
stored with the right endianness in the skeleton file, do you see an
alternative?

>>
>> So I'd recommend never using "long" (and similar types that depend on
>> bitness of the platform, like size_t, etc) for global variables. Also
>> don't use pointer types as types of the variable. Stick to __u64,
>> __u32, etc.
> 
> I feel if we follow. this convention then it will work out but
> currently a lot of selftests use these
> architecture dependent variable types and therefore don't even compile
> for 32-bit architectures
> because of the _Static_asserts in the skeleton.
> 
> Do you suggest replacing all these with __u64, __u32, etc. in the
> selftests so that they compile on every architecture?
> 
>>
>> Note that all this is irrelevant for static global variables, as they
>> are not exposed in the BPF skeleton.
>>
>> In general, mixing 32-bit host architecture with (always) 64-bit BPF
>> architecture always requires more care. And BPF skeleton is just one
>> aspect of this.
>>
>>>
>>>
>>>> Thanks,
>>>> Puranjay Mohan.
> 
> 
> 

