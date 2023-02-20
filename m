Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB2669C9DA
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 12:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjBTL2f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 06:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjBTL2e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 06:28:34 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6671D9EFE
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 03:28:33 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id m14-20020a7bce0e000000b003e00c739ce4so601594wmc.5
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 03:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+zj7fOWapFcgtYn6DJ8nOEgU7V5J9dKKDx+uq+Yz9KQ=;
        b=fxYN7MKL4esuec0mN+xmjRdYQU0a43vwLT7OpqP+zo0y5/85Q7JnGfnyayc3mUdrk+
         WNuSq8geIeuZyoJQ3oilIhejjy73ITltqCcj2B1k9v1CSfevY6VMScxP5Kz5ImwVVSn4
         ADz8W/78xSOcCS91pNt0hMbrQDHXwsyl/lJovfo0CrsB+dIQaPjXQo3jt/kDtKJRaErN
         AdyOttG3ravfS/iwCMDt8JUdOWKklZe/uumCNA4toSe9HfiFzm7mbcscOFzpt+FEAOMQ
         4k4g8NhJCAUtvLVTzmYSJzcxaIY6Y3AwAf2VBVs0nxA68wjQaJx0ye/jwbTVO+U58PoF
         fgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zj7fOWapFcgtYn6DJ8nOEgU7V5J9dKKDx+uq+Yz9KQ=;
        b=5dqoS6FtwVa/lciVV8s40udW7MXVsBbwZOEsQZAUvLJRvMsahXHTgDxb1Ecq2FAb6L
         XZbgeKr3DscpuKqQzO9/o67LBv51PwuEZPbuWevnCqmOPv28MPKeQi0HeZeLVrMbYjPQ
         19EPxNVKv2bxpAkbSm90/eOlHvfe14VD4SbbJVYCxy9p+0Q9AfgCmssSFqhgIug7AxGE
         Xf6WsoCn070ZbZcYY7gQYx0PB+WZx+SZfC0n9jMvDLNpmJi9ccDsiklE/q7L+RTv3vPI
         naAoo2QaqfxyRO7kxNbkMPwyiChBz18GHNDGCAb2s+rxsKzVfREWAaFOuHEpNUWakNVJ
         nhkg==
X-Gm-Message-State: AO0yUKW99PhAO9Mr0LuMMIUC+gd9g+yIHH2OtvNmH/z4F0c31/e8QdWg
        W/xwaDl97X83WcCoBcr3o0tAUg==
X-Google-Smtp-Source: AK7set9UOJNoOi7/STFWWR5JRXPy1zs9Zknb4a+VNf4wF1+4bCCSyoxBeBi3O0KOoFiFA4mCeK2n9A==
X-Received: by 2002:a05:600c:994:b0:3e2:152d:894e with SMTP id w20-20020a05600c099400b003e2152d894emr674527wmp.15.1676892511745;
        Mon, 20 Feb 2023 03:28:31 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:b111:6cf9:8ad7:838a? ([2a02:8011:e80c:0:b111:6cf9:8ad7:838a])
        by smtp.gmail.com with ESMTPSA id n23-20020a7bc5d7000000b003b47b80cec3sm8732982wmk.42.2023.02.20.03.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 03:28:31 -0800 (PST)
Message-ID: <f0c40278-6355-1e35-cfca-fc28cc791a91@isovalent.com>
Date:   Mon, 20 Feb 2023 11:28:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RFC] libbbpf/bpftool: Support 32-bit Architectures.
Content-Language: en-GB
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com
References: <CANk7y0joRFw2F4iAuN9r-dWWMvOmbFZz_J4rhGhgVFjdnxPTYw@mail.gmail.com>
 <Y+2J+jIFIxGOW32X@google.com>
 <CAEf4BzaQJfB0Qh2Wn5wd9H0ZSURbzWBfKkav8xbkhozqTWXndw@mail.gmail.com>
 <CANk7y0iKQX7BdGabDgHmTa=BXc_WCh3rkh5xjqJqc56FJs-QUA@mail.gmail.com>
 <33f48f89-15d0-58a7-b5ce-a934f4379166@isovalent.com>
 <CAEf4BzYutCfUPgPk-DDDGFd9Uue6Dm5ymZ=GTpHokN6JM+_mxA@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4BzYutCfUPgPk-DDDGFd9Uue6Dm5ymZ=GTpHokN6JM+_mxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-02-17 13:56 UTC-0800 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Fri, Feb 17, 2023 at 3:59 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> 2023-02-17 11:25 UTC+0100 ~ Puranjay Mohan <puranjay12@gmail.com>
>>> Hi,
>>> Thanks for the response.
>>>
>>> On Thu, Feb 16, 2023 at 11:13 PM Andrii Nakryiko
>>> <andrii.nakryiko@gmail.com> wrote:
>>>>
>>>> On Wed, Feb 15, 2023 at 5:48 PM Stanislav Fomichev <sdf@google.com> wrote:
>>>>>
>>>>> On 02/15, Puranjay Mohan wrote:
>>>>>> The BPF selftests fail to compile on 32-bit architectures as the skeleton
>>>>>> generated by bpftool doesn’t take into consideration the size difference
>>>>>> of
>>>>>> variables on 32-bit/64-bit architectures.
>>>>>
>>>>>> As an example,
>>>>>> If a bpf program has a global variable of type: long, its skeleton will
>>>>>> include
>>>>>> a bss map that will have a field for this variable. The long variable in
>>>>>> BPF is
>>>>>> 64-bit. if we are working on a 32-bit machine, the generated skeleton has
>>>>>> to
>>>>>> compile for that machine where long is 32-bit.
>>>>>
>>>>>> A reproducer for this issue:
>>>>>>          root@56ec59aa632f:~# cat test.bpf.c
>>>>>>          long var;
>>>>>
>>>>>>          root@56ec59aa632f:~# clang -target bpf -g -c test.bpf.c
>>>>>
>>>>>>          root@56ec59aa632f:~# bpftool btf dump file test.bpf.o format raw
>>>>>>          [1] INT 'long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
>>>>>>          [2] VAR 'var' type_id=1, linkage=global
>>>>>>          [3] DATASEC '.bss' size=0 vlen=1
>>>>>>                 type_id=2 offset=0 size=8 (VAR 'var')
>>>>>
>>>>>>         root@56ec59aa632f:~# bpftool gen skeleton test.bpf.o > skeleton.h
>>>>>
>>>>>>         root@56ec59aa632f:~# echo "#include \"skeleton.h\"" > test.c
>>>>>
>>>>>>         root@56ec59aa632f:~# gcc test.c
>>>>>>         In file included from test.c:1:
>>>>>>         skeleton.h: In function 'test_bpf__assert':
>>>>>>         skeleton.h:231:2: error: static assertion failed: "unexpected
>>>>>> size of \'var\'"
>>>>>>           231 |  _Static_assert(sizeof(s->bss->var) == 8, "unexpected
>>>>>> size of 'var'");
>>>>>>                  |  ^~~~~~~~~~~~~~
>>>>>
>>>>>> One naive solution for this would be to map ‘long’ to ‘long long’ and
>>>>>> ‘unsigned long’ to ‘unsigned long long’. But this doesn’t solve everything
>>>>>> because this problem is also seen with pointers that are 64-bit in BPF and
>>>>>> 32-bit in 32-bit machines.
>>>>>
>>>>>> I want to work on solving this and am looking for ideas to solve it
>>>>>> efficiently.
>>>>>> The main goal is to make libbbpf/bpftool host architecture agnostic.
>>>>>
>>>>> Looks like bpftool needs to be aware of the target architecture. The
>>>>> same way gcc is doing with build-host-target triplet. I don't
>>>>> think this can be solved with a bunch of typedefs? But I've long
>>>>> forgotten how a pure 32-bit machine looks, so I can't give any
>>>>> useful input :-(
>>>>
>>>> Yeah, I'd rather avoid making bpftool aware of target architecture.
>>>> Three is 32 vs 64 bitness, there is also little/big endianness, etc.
>>
>> I'd rather avoid that too, but for addressing the endianness issue with
>> cross-compiling, reported by Christophe and where the bytecode is not
>> stored with the right endianness in the skeleton file, do you see an
>> alternative?
> 
> So bytecode is just a byte array, by itself endianness shouldn't
> matter. The contents of it (ELF itself) is supposed to be of correct
> target endianness, though, right? Or what problem we are talking about
> here? Can you please summarize?

TL;DR: When cross-compiling, host little-endian bootstrap bpftool cannot
open a big-endian ELF to generate a skeleton from it and build target
big-endian bpftool.

Long version: Currently, bpftool's Makefile compiles the
skeleton-related programs (skeletons/*.bpf.c) without paying attention
to the target architecture. When cross-compiling, say on a host with LE
for a target with BE, this leads to runtime failure on "bpftool prog
show", because bpftool cannot load the LE bytecode on the BE target
machine. This is Christophe's output in [0].

So the first fix is to make the Makefile aware of the target endianness
somehow, and to build this ELF with target endianness. But this is not
enough, because when (host) boostrap bpftool opens the ELF to generate
the skeleton from it before building the final (target) bpftool binary,
then bpf_object__check_endianness() in libbpf refuses to open the ELF if
endianness is not the same as on the host [1].

The way I see it, we'd need to make sure libbpf can work with ELFs of a
different endianness -- assuming that's doable -- and to pass it an
option to tell whether LE or BE is expected for a given ELF. Which in
turn would require bootstrap bpftool to be aware of the target
endianness. Or do you see a simpler way?


[0]
https://lore.kernel.org/bpf/0792068b-9aff-d658-5c7d-086e6d394c6c@csgroup.eu/
[1]
https://lore.kernel.org/bpf/21b09e52-142d-92f5-4f8b-e4190f89383b@csgroup.eu/
