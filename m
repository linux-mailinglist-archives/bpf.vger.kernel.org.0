Return-Path: <bpf+bounces-4601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950DA74D613
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 14:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503D22812E4
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 12:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECB3111BD;
	Mon, 10 Jul 2023 12:58:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A3411C83
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 12:58:55 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540DFE5
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 05:58:54 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-66f3fc56ef4so3557926b3a.0
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688993934; x=1691585934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q9L8qD0X2vq74e+v0kZxcRU61ZAt6WRkkLMg8q0MrwU=;
        b=oj2XFuSgzkJvH+IOFlqGA+IKNT2pvvQz9x//gHRJcqdQY8ILtMS+O6HbEWReSZydR1
         13CYXUt/8YddkmyMAip4YtjRcqRxWoeYAcxAXcCCAFOjpUVLucOPg3pvX+qQzYd/X0Nv
         LLxqeGoMk4t6a1xBjMCs0qiqKpuPpWAm1xqRDdOSXFq2Rbp52srW4Y8IzflHFw16kp5F
         2MzwnhoJ/NqCvYSqkpUVipP+fvB3RVcRxZPqEWA33Q5Y/Aoyecy1qgdmuI8UOtt0zXWo
         inkgo6PEGcHtRdSN92wI3qZljOgqq02ZgtGEvG3BETiPiwE3ZsN3AV3+FTyEdAkGnPL/
         v/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688993934; x=1691585934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q9L8qD0X2vq74e+v0kZxcRU61ZAt6WRkkLMg8q0MrwU=;
        b=DNV7bRwxy8OIip2V3hr4NcvcuH8YLdyihlD4z9ccxPBCpxBwuOcChIe5VplldAdnDZ
         Pygf0LxOTfh2v6yP4D19YOgH3sDv5QkeNxSo2HwSes5WURcjhRi95MTA/a9d98YbqSvi
         z9v2pfsK9jG1G44wvxdbBhy0WYvJd99gGV1IKq1Fu0+Wc+EAOZG+lJ4okcmtV5Bi/zRF
         /W5d6/4uxpeEaGdIpbD99BWLH3RreVXrc6LSDFbnpOgpaTXxIzDncnD9O9tEQZMekdCR
         pncELqRj9e6jrIO+B0LnJ7PflrmrR0/cuahZ+GO37n+bA+FH5n9ZJ/NVVLxYAeTwpVST
         DlPw==
X-Gm-Message-State: ABy/qLaen7WG7jpIGcAewDszJACANt82EqdDZ9LjCGReKKvoglDznwL2
	SYHuN8M6lDXRr41PPz9M1v2EcgflVBb05bLR
X-Google-Smtp-Source: APBJJlHyHouPD+n5UmyiRi0Iugnev8RylTrKdtRfrlRfLmeUEYxNcx0QcpHlhlIy9VhDSZi3w9BzLA==
X-Received: by 2002:a17:903:41c2:b0:1b2:676d:1143 with SMTP id u2-20020a17090341c200b001b2676d1143mr19759555ple.15.1688993933585;
        Mon, 10 Jul 2023 05:58:53 -0700 (PDT)
Received: from [192.168.1.9] ([14.238.228.104])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001b89536974bsm8406548plb.202.2023.07.10.05.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 05:58:53 -0700 (PDT)
Message-ID: <8db199b8-e339-8d7b-5ada-9210607d866f@gmail.com>
Date: Mon, 10 Jul 2023 19:58:50 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] samples/bpf: Add more instructions to build
 dependencies and, configuration in README.rst
To: Khalid Masum <khalid.masum.92@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, daniel@iogearbox.net,
 martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 bpf@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <bd1477f2-a51e-a795-4f25-a32d6ab46530@gmail.com>
 <ZKcE+wMWGdVFSBX2@google.com>
 <32d67707-b831-9a98-4cb9-fcb27c8806ef@gmail.com>
 <ZKhEEJfzCyYI7BfH@google.com>
 <5d336a9a-8ae5-2b1f-7af3-a94818867b40@gmail.com>
 <CAABMjtHc4Vu=_L4rOhy1a-m0nQ-ptHe68qXJd__mSQAgO+t_iw@mail.gmail.com>
Content-Language: en-US
From: Anh Tuan Phan <tuananhlfc@gmail.com>
In-Reply-To: <CAABMjtHc4Vu=_L4rOhy1a-m0nQ-ptHe68qXJd__mSQAgO+t_iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/9/23 22:21, Khalid Masum wrote:
> Hi,
> 
> On Sun, Jul 9, 2023 at 8:38 PM Anh Tuan Phan <tuananhlfc@gmail.com> wrote:
>>
>> Hi Stanislav,
>>
>> I have updated the Documentation according to your suggestion. Please
>> see it in the below patch. Thanks!
>>
>> On 7/7/23 23:57, Stanislav Fomichev wrote:
>>> On 07/07, Anh Tuan Phan wrote:
>>>>
>>>>
>>>> On 7/7/23 01:16, Stanislav Fomichev wrote:
>>>>> On 07/06, Anh Tuan Phan wrote:
>>>>>> Update the Documentation to mention that some samples require pahole
>>>>>> v1.16 and kernel built with CONFIG_DEBUG_INFO_BTF=y
>>>>>>
>>>>>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
>>>>>> ---
>>>>>>  samples/bpf/README.rst | 7 +++++++
>>>>>>  1 file changed, 7 insertions(+)
>>>>>>
>>>>>> diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
>>>>>> index 57f93edd1957..631592b83d60 100644
>>>>>> --- a/samples/bpf/README.rst
>>>>>> +++ b/samples/bpf/README.rst
>>>>>> @@ -14,6 +14,9 @@ Compiling requires having installed:
>>>>>>  Note that LLVM's tool 'llc' must support target 'bpf', list version
>>>>>>  and supported targets with command: ``llc --version``
>>>>>>
>>>>>> +Some samples require pahole version 1.16 as a dependency. See
>>>>>> +https://docs.kernel.org/bpf/bpf_devel_QA.html for reference.
>>>>>> +
>>>>>
>>>>> Any reason no to add pahole 1.16 to this section above?
>>>>>> Compiling requires having installed:
>>>>>  * clang >= version 3.4.0
>>>>>  * llvm >= version 3.7.1
>>>>>  * pahole >= version 1.16
>>>>>
>>>>> Although clang 3.4 probably won't get you anywhere these days. The
>>>>> whole README seems a bit outdated :-)
>>>>>
>>>>
>>>> Put pahole requirement as your idea is better, thanks for suggestion.
>>>> Will update it and clang version as well. For clang version, I think I
>>>> can update min version as 11.0.0 (reference from
>>>> https://www.kernel.org/doc/html/next/process/changes.html). Do you see
>>>> any other potential outdated things in this document? I follow the above
>>>> steps and it help me compile the sample code successfully.
>>>
>>> Maybe we can reference that doc instead here? Otherwise that copy-pasted
>>> 11.0.0 will also get old. Just mention here that we need
>>> clang/llvm/pahole to compile the samples and for specific versions
>>> put a link to process/changes.rst
>>>
>>>>>>  Clean and configuration
>>>>>>  -----------------------
>>>>>>
>>>>>> @@ -28,6 +31,10 @@ Configure kernel, defconfig for instance::
>>>>>>
>>>>>>   make defconfig
>>>>>>
>>>>>> +Some samples require support for BPF Type Format (BTF). To enable it,
>>>>>> open the
>>>>>> +generated config file, or use menuconfig (by "make menuconfig") to
>>>>>> enable the
>>>>>> +following configs: CONFIG_BPF_SYSCALL and CONFIG_DEBUG_INFO_BTF.
>>>>>> +
>>>>>
>>>>> This is usually enabled by default, so why special case it here?
>>>>> Maybe, if you want some hints about the config, we should add
>>>>> a reference to tools/testing/selftests/bpf/config ?
>>>>>
>>>>
>>>> The config CONFIG_DEBUG_INFO_BTF is disabled for some distros at least
>>>> for mine. I ran "make defconfig" and it's not enabled by default so I
>>>> think it worth to mention it here to help novice get started. I'll
>>>> update it to reference to tools/testing/selftests/bpf/config .
>>>>
>>>>>>  Kernel headers
>>>>>>  --------------
>>>>>>
>>>>>> --
>>>>>> 2.34.1
>>
>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
>> ---
>>
>> Change from the original patch:
>>
>> - Move pahole to the list installed requirements
>> - Remove minimal version and link the related doc
>> - Add a reference of kernel configuration
>>
>>  samples/bpf/README.rst | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
>> index 57f93edd1957..e18500753ba5 100644
>> --- a/samples/bpf/README.rst
>> +++ b/samples/bpf/README.rst
>> @@ -8,9 +8,12 @@ Build dependencies
>>  ==================
>>
>>  Compiling requires having installed:
>> - * clang >= version 3.4.0
>> - * llvm >= version 3.7.1
>> + * clang
>> + * llvm
>> + * pahole
>>
>> +The minimal version of the above software is referenced in
>> +https://www.kernel.org/doc/html/next/process/changes.html.
> 
> I think it is better to not use docs from linux-next as it keeps changing
> too frequently. How about using the latest documentation's link instead? :)
> 
> https://www.kernel.org/doc/html/latest/process/changes.html
> 
> However, something to think about is: If future versions of clang, llvm etc
> do not support compiling our code as it is now, it may become misleading.
> 

Thanks, I'll update the documentation's link in the next version.

> 
>>  Note that LLVM's tool 'llc' must support target 'bpf', list version
>>  and supported targets with command: ``llc --version``
>>
>> @@ -24,7 +27,8 @@ after some changes (on demand)::
>>   make -C samples/bpf clean
>>   make clean
>>
>> -Configure kernel, defconfig for instance::
>> +Configure kernel, defconfig for instance
>> +(see "tools/testing/selftests/bpf/config" for a reference config)::
>>
>>   make defconfig
>>
>> --
> 
> thanks,
>   -- Khalid Masum

