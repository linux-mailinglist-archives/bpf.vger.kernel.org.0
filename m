Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E174BC0F2
	for <lists+bpf@lfdr.de>; Fri, 18 Feb 2022 21:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbiBRUAX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 15:00:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbiBRUAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 15:00:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C474D636
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 12:00:04 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e3so16370762wra.0
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 12:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BaWIRG9VkIyqheMO545IBGNoL0E4rWyLcXo6hJwMbX0=;
        b=v/JdIJkCghQeSG5/Pn2f4BYAKRO4TRm9mRbu3aiKd4X1G/nEMHh/Wli4Wj97S/gVMU
         Rg3emXTVMJml90X9XHXqdWS0/d7qNU60disWZuVkVrU/w0J++KVjTxuDCw3dfOilEnAB
         IAPOeSFc1Qd55YikvrNGe55IMMKJSTTuloIF4u3gQ7k/BOr0+yZMUz1s3WooI4SRV8yu
         nIxhCETbdviGsyrtBhr40hs7okAYcOuEzrGO9+ylahPp9aUuUjSMG3KYFRJfby4bAV+w
         /b7p4VLKoTOeEZ+Sczu8ZDhjf9hUWOW6Tk2Ur0u8saMWhYDwra/2jD7vFQs+wb35nYbS
         1nbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BaWIRG9VkIyqheMO545IBGNoL0E4rWyLcXo6hJwMbX0=;
        b=lfIEfIVlzPFleA7RBOxRD1eShs8GE/cQv4DUt8kNEzJLjC800qwjuvc9a8GtXI+d5r
         +IWtqP3jszuN0vk/uf1CxxvNReOy+14y1oEI4GEiN/5Dc8L/zCeG7RMjeS++cruQrRjL
         W2o3jbRXAaynIwFXWlMMpo1qjXDY203ljt5W1bxgADS2U+yBPzzDFWtE1Ywlwt/4DaaH
         DhAYdFZJBtc4uPCKEbmN7CEqc0o4obTcwuICsfjS8ROUaMkIeZz5tlyO/oYRug1AscHs
         pjHmqbgGEuMDogrh+6++EZI9ZN/9x/VMRR5gvwoSJGT69B+GcupTHUWxynFgfmFLlupc
         Rh3g==
X-Gm-Message-State: AOAM530klO6qJ5Ox5KRqxFR0EsRaWxCkICX97zxN/KHAOAjzMj1X7mUb
        d1V32hOwmRu9N9rDomn2c1eayCfq7WR+WA==
X-Google-Smtp-Source: ABdhPJzHtonkt5ghTA+4HPJ9eNAeFameSNFpZJHLktooSFeBSs2r3kOEQtNEUU+BqZQuGD0jliLyQw==
X-Received: by 2002:a5d:53d2:0:b0:1e3:3a00:8de with SMTP id a18-20020a5d53d2000000b001e33a0008demr6932991wrw.78.1645214402843;
        Fri, 18 Feb 2022 12:00:02 -0800 (PST)
Received: from [192.168.1.8] ([149.86.66.54])
        by smtp.gmail.com with ESMTPSA id n9sm23157722wrx.76.2022.02.18.12.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 12:00:02 -0800 (PST)
Message-ID: <15094ca9-5659-5d12-e6a0-90d9fc2e2cec@isovalent.com>
Date:   Fri, 18 Feb 2022 20:00:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] bpftool: Allow building statically
Content-Language: en-GB
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Nikolay Borisov <nborisov@suse.com>, andrii@kernel.org
Cc:     ast@kernel.org, bpf@vger.kernel.org
References: <20220217120435.2245447-1-nborisov@suse.com>
 <8c890e30-d701-0da4-c6f9-f5ca7d80d7ee@isovalent.com>
 <dee15742-da4b-1622-8c0a-cc95a6c7ee91@suse.com>
 <8bc2a0fd-2e54-471f-d908-a0144e0588fe@isovalent.com>
 <3bf83a18-6107-ebbc-bb5d-d61fcfb25fcd@iogearbox.net>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <3bf83a18-6107-ebbc-bb5d-d61fcfb25fcd@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-02-18 20:58 UTC+0100 ~ Daniel Borkmann <daniel@iogearbox.net>
> On 2/18/22 5:33 PM, Quentin Monnet wrote:
>> 2022-02-18 18:14 UTC+0200 ~ Nikolay Borisov <nborisov@suse.com>
>>> On 18.02.22 г. 18:08 ч., Quentin Monnet wrote:
>>>> 2022-02-17 14:04 UTC+0200 ~ Nikolay Borisov <nborisov@suse.com>
>>>>> Sometime it can be useful to haul around a statically built version of
>>>>> bpftool. Simply add support for passing STATIC=1 while building to
>>>>> build
>>>>> the tool statically.
>>>>>
>>>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>>>> ---
>>>>>
>>>>> Currently the bpftool being distributed as part of libbpf-tools under
>>>>> bcc project
>>>>> is dynamically built on a system using GLIBC 2.28, this makes the
>>>>> tool unusable on
>>>>> ubuntu 18.04 for example. Perhaps after this patch has landed the
>>>>> bpftool in bcc
>>>>> can be turned into a static binary.
>>>>>
>>>>>    tools/bpf/bpftool/Makefile | 4 ++++
>>>>>    1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
>>>>> index 83369f55df61..835621e215e4 100644
>>>>> --- a/tools/bpf/bpftool/Makefile
>>>>> +++ b/tools/bpf/bpftool/Makefile
>>>>> @@ -13,6 +13,10 @@ else
>>>>>      Q = @
>>>>>    endif
>>>>>
>>>>> +ifeq ($(STATIC),1)
>>>>> +    CFLAGS += --static
>>>>> +endif
>>>>> +
>>>>>    BPF_DIR = $(srctree)/tools/lib/bpf
>>>>>
>>>>>    ifneq ($(OUTPUT),)
>>>>
>>>> Why not just pass the flag on the command line? I don't think the
>>>> Makefile overwrites it:
>>>>
>>>>       $ CFLAGS=--static make
>>>
>>> Yeah, this also works, I initially thought that overriding a variable on
>>> the command line would require having the override directive in the
>>> makefile but apparently is not the case. I guess this patch can be
>>> scratched.
>>
>> You'd need something if the Makefile was initialising the variable, with
>> something like "CFLAGS = -O2" or "CFLAGS := -O2". But bpftool's Makefile
>> always uses "CFLAGS += ...", meaning it appends to the current value, so
>> you can pass whatever you want from the command line, as long as it
>> doesn't get overwritten by another flag (for example, passing "-O0"
>> would not work I think, since we add "-O2" in the Makefile).
> 
> We don't have an in-tree readme, but the `CFLAGS=--static make` use case
> could probably be documented in [0] at minimum.
> 
> Cheers,
> Daniel
> 
>   [0] https://github.com/libbpf/bpftool

Makes sense, I'll do this. Thanks Daniel!
Quentin
