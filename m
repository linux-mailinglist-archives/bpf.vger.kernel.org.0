Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF054BBD95
	for <lists+bpf@lfdr.de>; Fri, 18 Feb 2022 17:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiBRQeA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 11:34:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbiBRQd7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 11:33:59 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD39231936
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 08:33:42 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id k25so16268538ejp.5
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 08:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3tzBrQk55bUQm5yB2RTC/EQ8rQTLh+HMuvH4lsPn2BQ=;
        b=77xnsW1auREOKvDvdIy7f8DrqHJt4+bHLMzAuaMMg9JxIlUUMTajV0Q+6rWcuok8Fl
         XgrecWw/KSfZ/LEPczr63pL1UJAA02FnV29Ja7cxxM5eXstH4xLkFGvBg67f8tex3vCU
         sFpne6IDlPeHUXLNtk0l8xR6+9CVLAWjCffc601oW1cOM0twab9PL8zCXVvTI+w8DVBw
         fYR0NGYZUHEm1WJXKN5MzLzAJWktK4Nvsfbqnc/7LS6uqtzWGQvHW2Pu+XoPOAbjhyNU
         e39Oz+DS0YKp8uYvWL3X13RWGO4qui+Glyln0HLQ8ht+oxI+yYE+g+jb8p2ApWJ8lBgs
         5yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3tzBrQk55bUQm5yB2RTC/EQ8rQTLh+HMuvH4lsPn2BQ=;
        b=W8Nadh7IEbuYPrpaaI+QYr8iZDkV+j7fr1hbeEd8LC9E0zjbzSwpOS6y4Bnhij+i5H
         T2RguDDX+lJbKf7ex4+FcZuyqmgsckJFA4z52szNUrX2/SSfKpPXXOZ1S3D56H46hfsS
         ESYsMEr+pOlAmTAHvoQbLnYU0mLoLk6xyZWUM/INLfflSwniLqCWKf2jKD5lM5/mig8n
         T3ApiS3OjNLYEza6R1WXAutTLHDXxuh7FQY/lyYhcSNKpJHUioL+AgZl+isq0YY4AuYF
         XKRodR/fVykV4deWC/oKJN3FMZ1UbdjSJA0zo8cp3+DzLULN8CjQ6W5S6bMsGMt+GBPb
         3aiw==
X-Gm-Message-State: AOAM5338lLFG1kztGSg/BHB8HC74n7rq2ubIbzTeo1INyuq+g37cb4mI
        YKn+HNTekvCZuqsXyunQj06xgQ==
X-Google-Smtp-Source: ABdhPJwrEpZ2PDEXRpXfS1mn8CJU6MljGUNAhXEXJl5fhkp1smSbPgepiQmxzQCLB1BQtin2VPXqig==
X-Received: by 2002:a17:907:271b:b0:6b8:7863:bf3e with SMTP id w27-20020a170907271b00b006b87863bf3emr7465306ejk.188.1645202020622;
        Fri, 18 Feb 2022 08:33:40 -0800 (PST)
Received: from [192.168.1.8] ([149.86.75.111])
        by smtp.gmail.com with ESMTPSA id f19sm4745258edu.22.2022.02.18.08.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 08:33:39 -0800 (PST)
Message-ID: <8bc2a0fd-2e54-471f-d908-a0144e0588fe@isovalent.com>
Date:   Fri, 18 Feb 2022 16:33:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] bpftool: Allow building statically
Content-Language: en-GB
To:     Nikolay Borisov <nborisov@suse.com>, andrii@kernel.org
Cc:     ast@kernel.org, bpf@vger.kernel.org
References: <20220217120435.2245447-1-nborisov@suse.com>
 <8c890e30-d701-0da4-c6f9-f5ca7d80d7ee@isovalent.com>
 <dee15742-da4b-1622-8c0a-cc95a6c7ee91@suse.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <dee15742-da4b-1622-8c0a-cc95a6c7ee91@suse.com>
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

2022-02-18 18:14 UTC+0200 ~ Nikolay Borisov <nborisov@suse.com>
> 
> 
> On 18.02.22 г. 18:08 ч., Quentin Monnet wrote:
>> 2022-02-17 14:04 UTC+0200 ~ Nikolay Borisov <nborisov@suse.com>
>>> Sometime it can be useful to haul around a statically built version of
>>> bpftool. Simply add support for passing STATIC=1 while building to build
>>> the tool statically.
>>>
>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>> ---
>>>
>>> Currently the bpftool being distributed as part of libbpf-tools under
>>> bcc project
>>> is dynamically built on a system using GLIBC 2.28, this makes the
>>> tool unusable on
>>> ubuntu 18.04 for example. Perhaps after this patch has landed the
>>> bpftool in bcc
>>> can be turned into a static binary.
>>>
>>>   tools/bpf/bpftool/Makefile | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
>>> index 83369f55df61..835621e215e4 100644
>>> --- a/tools/bpf/bpftool/Makefile
>>> +++ b/tools/bpf/bpftool/Makefile
>>> @@ -13,6 +13,10 @@ else
>>>     Q = @
>>>   endif
>>>
>>> +ifeq ($(STATIC),1)
>>> +    CFLAGS += --static
>>> +endif
>>> +
>>>   BPF_DIR = $(srctree)/tools/lib/bpf
>>>
>>>   ifneq ($(OUTPUT),)
>>> -- 
>>> 2.25.1
>>>
>>
>> Why not just pass the flag on the command line? I don't think the
>> Makefile overwrites it:
>>
>>      $ CFLAGS=--static make
> 
> Yeah, this also works, I initially thought that overriding a variable on
> the command line would require having the override directive in the
> makefile but apparently is not the case. I guess this patch can be
> scratched.

You'd need something if the Makefile was initialising the variable, with
something like "CFLAGS = -O2" or "CFLAGS := -O2". But bpftool's Makefile
always uses "CFLAGS += ...", meaning it appends to the current value, so
you can pass whatever you want from the command line, as long as it
doesn't get overwritten by another flag (for example, passing "-O0"
would not work I think, since we add "-O2" in the Makefile).
