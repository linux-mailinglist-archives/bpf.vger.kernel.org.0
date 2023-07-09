Return-Path: <bpf+bounces-4528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6632B74C4B5
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 16:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F842810A4
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F6C79E0;
	Sun,  9 Jul 2023 14:38:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537BB2917
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 14:38:04 +0000 (UTC)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B330102
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 07:38:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-262e839647eso2797847a91.2
        for <bpf@vger.kernel.org>; Sun, 09 Jul 2023 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688913482; x=1691505482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6zPSyF1+6E2Wjz3CS7EukTNOIkm3ZHJEPN7gEbtToo=;
        b=TToCebSVTvycnIUkfg46DjbuMDJz02IW6q6jKS6wGcX/KyKDYQf22orpQsQLeL3FuX
         Sytkk/6OPw3OpUaQJTJtlwOKvAVS2bAi6vhKODn0H2xFBkemHu1vYLIiAiWh2+B8eyfT
         hvdmy/beMi+9R6uWtY988ObtxHj1r28nFV6QCPL5me66TaDG7HY++YX+oeRh3dT5tUB0
         xZbE52fAfrNDRdydX3DUil1Ik+8iZvDWmATJT3X51mtl+T9VVcYLSDI39AovbIu3zLus
         FU40l6qd6Yh9Dna8ksW5OQ8hA/onXGkxYehW6fv1Rkx48+CyeT0oMIX1bQDvUFn7RRzR
         i9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688913482; x=1691505482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6zPSyF1+6E2Wjz3CS7EukTNOIkm3ZHJEPN7gEbtToo=;
        b=GuL2iYyxHbsvSHNyk0J+v9yBKOFnBAJXFOGjz5GStlwt9UD7oZ66u5kBiK1cqfEYbd
         r3+1gpyyU65sd9IGd2peZsp7HQCxboyY31IpB/Mymn5skp9WG7CqUHuOf8ZucpMNlgY5
         fXJWpNprIuO/aP/qSldZyxd7n8Z0ozkPm1Xw4VJ3JI4htHG0wu+iD0JhPrILh00UG7O8
         5kHkwV5W6h4wtfH33iiBRP0AknwTZYOw6K418QZWuk77wrrTjT0nueIoN4Fk8NmuZfq1
         kMlrQNOjINji52C7ajOamxkKvTPFs9q4MCzFKjT8p4jh1Cywc+9K5Zt3suGVi0VivIbz
         ngPw==
X-Gm-Message-State: ABy/qLbDIFJV0XD84E9bzxb5KO6FxKHQJ8fy55NlOs4kIjKfR3q9nMsB
	1kLaEq5EZ7uZWZEmvzSAZV0U3M6BAg3p55rW
X-Google-Smtp-Source: APBJJlGf/CVqklZ7ImwM/1O4eKhjI6NJ5FyAxBf4+Rkyc2MSEwfMsv9qHVuVJ1a8Y3jPnBbUQrOpEA==
X-Received: by 2002:a17:90a:bb84:b0:25b:e07f:4c43 with SMTP id v4-20020a17090abb8400b0025be07f4c43mr10465169pjr.10.1688913481835;
        Sun, 09 Jul 2023 07:38:01 -0700 (PDT)
Received: from [192.168.1.9] ([14.238.228.104])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a004b00b00265892de629sm4524728pjb.29.2023.07.09.07.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 07:38:01 -0700 (PDT)
Message-ID: <5d336a9a-8ae5-2b1f-7af3-a94818867b40@gmail.com>
Date: Sun, 9 Jul 2023 21:37:58 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] samples/bpf: Add more instructions to build
 dependencies and, configuration in README.rst
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <bd1477f2-a51e-a795-4f25-a32d6ab46530@gmail.com>
 <ZKcE+wMWGdVFSBX2@google.com>
 <32d67707-b831-9a98-4cb9-fcb27c8806ef@gmail.com>
 <ZKhEEJfzCyYI7BfH@google.com>
From: Anh Tuan Phan <tuananhlfc@gmail.com>
In-Reply-To: <ZKhEEJfzCyYI7BfH@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Stanislav,

I have updated the Documentation according to your suggestion. Please
see it in the below patch. Thanks!

On 7/7/23 23:57, Stanislav Fomichev wrote:
> On 07/07, Anh Tuan Phan wrote:
>>
>>
>> On 7/7/23 01:16, Stanislav Fomichev wrote:
>>> On 07/06, Anh Tuan Phan wrote:
>>>> Update the Documentation to mention that some samples require pahole
>>>> v1.16 and kernel built with CONFIG_DEBUG_INFO_BTF=y
>>>>
>>>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
>>>> ---
>>>>  samples/bpf/README.rst | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
>>>> index 57f93edd1957..631592b83d60 100644
>>>> --- a/samples/bpf/README.rst
>>>> +++ b/samples/bpf/README.rst
>>>> @@ -14,6 +14,9 @@ Compiling requires having installed:
>>>>  Note that LLVM's tool 'llc' must support target 'bpf', list version
>>>>  and supported targets with command: ``llc --version``
>>>>
>>>> +Some samples require pahole version 1.16 as a dependency. See
>>>> +https://docs.kernel.org/bpf/bpf_devel_QA.html for reference.
>>>> +
>>>
>>> Any reason no to add pahole 1.16 to this section above?
>>>> Compiling requires having installed:
>>>  * clang >= version 3.4.0
>>>  * llvm >= version 3.7.1
>>>  * pahole >= version 1.16
>>>
>>> Although clang 3.4 probably won't get you anywhere these days. The
>>> whole README seems a bit outdated :-)
>>>
>>
>> Put pahole requirement as your idea is better, thanks for suggestion.
>> Will update it and clang version as well. For clang version, I think I
>> can update min version as 11.0.0 (reference from
>> https://www.kernel.org/doc/html/next/process/changes.html). Do you see
>> any other potential outdated things in this document? I follow the above
>> steps and it help me compile the sample code successfully.
> 
> Maybe we can reference that doc instead here? Otherwise that copy-pasted
> 11.0.0 will also get old. Just mention here that we need
> clang/llvm/pahole to compile the samples and for specific versions
> put a link to process/changes.rst
>  
>>>>  Clean and configuration
>>>>  -----------------------
>>>>
>>>> @@ -28,6 +31,10 @@ Configure kernel, defconfig for instance::
>>>>
>>>>   make defconfig
>>>>
>>>> +Some samples require support for BPF Type Format (BTF). To enable it,
>>>> open the
>>>> +generated config file, or use menuconfig (by "make menuconfig") to
>>>> enable the
>>>> +following configs: CONFIG_BPF_SYSCALL and CONFIG_DEBUG_INFO_BTF.
>>>> +
>>>
>>> This is usually enabled by default, so why special case it here?
>>> Maybe, if you want some hints about the config, we should add
>>> a reference to tools/testing/selftests/bpf/config ?
>>>
>>
>> The config CONFIG_DEBUG_INFO_BTF is disabled for some distros at least
>> for mine. I ran "make defconfig" and it's not enabled by default so I
>> think it worth to mention it here to help novice get started. I'll
>> update it to reference to tools/testing/selftests/bpf/config .
>>
>>>>  Kernel headers
>>>>  --------------
>>>>
>>>> -- 
>>>> 2.34.1

Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
---

Change from the original patch:

- Move pahole to the list installed requirements
- Remove minimal version and link the related doc
- Add a reference of kernel configuration

 samples/bpf/README.rst | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
index 57f93edd1957..e18500753ba5 100644
--- a/samples/bpf/README.rst
+++ b/samples/bpf/README.rst
@@ -8,9 +8,12 @@ Build dependencies
 ==================

 Compiling requires having installed:
- * clang >= version 3.4.0
- * llvm >= version 3.7.1
+ * clang
+ * llvm
+ * pahole

+The minimal version of the above software is referenced in
+https://www.kernel.org/doc/html/next/process/changes.html.
 Note that LLVM's tool 'llc' must support target 'bpf', list version
 and supported targets with command: ``llc --version``

@@ -24,7 +27,8 @@ after some changes (on demand)::
  make -C samples/bpf clean
  make clean

-Configure kernel, defconfig for instance::
+Configure kernel, defconfig for instance
+(see "tools/testing/selftests/bpf/config" for a reference config)::

  make defconfig

-- 
2.34.1



