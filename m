Return-Path: <bpf+bounces-4426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF2174B227
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 15:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148E028172E
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 13:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C51C8FE;
	Fri,  7 Jul 2023 13:48:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB3BC8E3
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 13:48:35 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0585CAF
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 06:48:34 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8062c1ee1so12825755ad.3
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 06:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688737713; x=1691329713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vp6gF/HK/ZF4U48X8WAh1ib4ToX+UsDFi8qnoETrDog=;
        b=CJj7MGkXzuhgioMNW4z/nNdJpC9pDAF3kpofJATdyrV+NuXO/WQZU9CPxK+opRkruc
         d/G63UzLmgLtMLJY1TN9LJyckg/iJ7rD39TAK2P/1LF/6zxJe0JwWEw0R5Iem+2IbV/p
         eiSTNHTgE2n+Uoy5Vs+ReExwodCfqWXa2TmBhdKpxwsc754avEOcNNfjGRj2EzdrjrIM
         I1iSbrdXjD3aTVpMMk+ptYfuYh73zv9pSocT0zG2O41abOE2MGuioOIjDDcNqEQQQDDI
         x636Q+cU+Y0JdybImTeU70nmzdkFk83jPP7hd5eKtdPVdTeUHBSdHFTRQvVTqk7/CtP1
         W0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688737713; x=1691329713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vp6gF/HK/ZF4U48X8WAh1ib4ToX+UsDFi8qnoETrDog=;
        b=HffyL3QNBgqO5fL1qYcM9NK2JoiZEIMreo6OPCC2HmBEQo7xu83YilEo+fJTSRW88h
         faaPJ6eE1hzV4YUQjpDonAmv311XqJ0t8xs79nLlFW0/Ddpv/YpMxA/l7gSpU0Yd7P0A
         ljYn63E9N/I7p3VNJJLdGuxA9kgs4E0fAA90oYEyzk24n8tBN5vT8ROr4rCBoaSicy26
         3uMjoDC1KJJZBe7SAWGSviGPsaQsD8yoNt0zZa+PHGPIqqY2wyVNw+SIgrpXLkXBDCdJ
         hmSGkEDb5AUBEK3YD5D+b5faN9vaY1PkC3ux5NV4lYv8bR9EWBSNxxo5XEQyMXyOXuLi
         iJIQ==
X-Gm-Message-State: ABy/qLaP2EphM+vqUZTyGkK644FHvILUfrPLvIfWrea+UpYo9WafFRg8
	DNxmd9LOvTSP8txWaOIh1SQ=
X-Google-Smtp-Source: APBJJlHs3U3pwKv+I8Tzrpq9dGdzS4GEp5yCbDTlNhRXPsbKMmQ1ALqcaDVv/F1Jxraa81AJj5GZog==
X-Received: by 2002:a17:902:b942:b0:1b6:797d:33fb with SMTP id h2-20020a170902b94200b001b6797d33fbmr4583633pls.64.1688737713329;
        Fri, 07 Jul 2023 06:48:33 -0700 (PDT)
Received: from [192.168.1.9] ([14.238.228.104])
        by smtp.gmail.com with ESMTPSA id iz5-20020a170902ef8500b001b8649e52f8sm3275865plb.254.2023.07.07.06.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 06:48:33 -0700 (PDT)
Message-ID: <32d67707-b831-9a98-4cb9-fcb27c8806ef@gmail.com>
Date: Fri, 7 Jul 2023 20:48:29 +0700
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
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <bd1477f2-a51e-a795-4f25-a32d6ab46530@gmail.com>
 <ZKcE+wMWGdVFSBX2@google.com>
Content-Language: en-US
From: Anh Tuan Phan <tuananhlfc@gmail.com>
In-Reply-To: <ZKcE+wMWGdVFSBX2@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/7/23 01:16, Stanislav Fomichev wrote:
> On 07/06, Anh Tuan Phan wrote:
>> Update the Documentation to mention that some samples require pahole
>> v1.16 and kernel built with CONFIG_DEBUG_INFO_BTF=y
>>
>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
>> ---
>>  samples/bpf/README.rst | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
>> index 57f93edd1957..631592b83d60 100644
>> --- a/samples/bpf/README.rst
>> +++ b/samples/bpf/README.rst
>> @@ -14,6 +14,9 @@ Compiling requires having installed:
>>  Note that LLVM's tool 'llc' must support target 'bpf', list version
>>  and supported targets with command: ``llc --version``
>>
>> +Some samples require pahole version 1.16 as a dependency. See
>> +https://docs.kernel.org/bpf/bpf_devel_QA.html for reference.
>> +
> 
> Any reason no to add pahole 1.16 to this section above?
>> Compiling requires having installed:
>  * clang >= version 3.4.0
>  * llvm >= version 3.7.1
>  * pahole >= version 1.16
> 
> Although clang 3.4 probably won't get you anywhere these days. The
> whole README seems a bit outdated :-)
>

Put pahole requirement as your idea is better, thanks for suggestion.
Will update it and clang version as well. For clang version, I think I
can update min version as 11.0.0 (reference from
https://www.kernel.org/doc/html/next/process/changes.html). Do you see
any other potential outdated things in this document? I follow the above
steps and it help me compile the sample code successfully.

>>  Clean and configuration
>>  -----------------------
>>
>> @@ -28,6 +31,10 @@ Configure kernel, defconfig for instance::
>>
>>   make defconfig
>>
>> +Some samples require support for BPF Type Format (BTF). To enable it,
>> open the
>> +generated config file, or use menuconfig (by "make menuconfig") to
>> enable the
>> +following configs: CONFIG_BPF_SYSCALL and CONFIG_DEBUG_INFO_BTF.
>> +
> 
> This is usually enabled by default, so why special case it here?
> Maybe, if you want some hints about the config, we should add
> a reference to tools/testing/selftests/bpf/config ?
> 

The config CONFIG_DEBUG_INFO_BTF is disabled for some distros at least
for mine. I ran "make defconfig" and it's not enabled by default so I
think it worth to mention it here to help novice get started. I'll
update it to reference to tools/testing/selftests/bpf/config .

>>  Kernel headers
>>  --------------
>>
>> -- 
>> 2.34.1

