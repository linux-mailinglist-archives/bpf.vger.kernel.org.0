Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3762F48C38E
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 12:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240120AbiALLwe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 06:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiALLwd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 06:52:33 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60EDC06173F
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 03:52:32 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso3291059wmj.2
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 03:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dWWXhXRs/vD15WuDE/MFAsr3LMUcPSOEB8loGJUeRvU=;
        b=Y3vOxfTozZB5pnGEMCoUK5DFGep995bDtRFI1HiQdRE5i8B3HTXGTmhQSOR2ozk4Nf
         hxRKL91m9ywzdifi8M36NZGjZbXXiao33jIHc+n/6TYiEP2JT0zDQU06xMwMMsB0SSuN
         967eapAtExyJ9rRSZ6AqFjoCzw+VCZoBELzVXcyr0hcRO93k/NBAmm5j99JS2EThz7qN
         3Zs9qW/VQspsL9S0h8C16qurULZxf46YAi3GlvtdXz11EADLSoe4ET4BEXfJqBOQEYrL
         9BtUR8OXHAFjxWVDZDNfsjRnYE3nSmlSnTklxLddlQGb4LRaPEssbyfSzl0P8ZKNVj04
         W6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dWWXhXRs/vD15WuDE/MFAsr3LMUcPSOEB8loGJUeRvU=;
        b=3Jyjq0gyaf4tb0TXYv8UkE6q1qTmaJXaK4hTgn0BfbCjl1rPtwXd/e6lmWWITQ7KAG
         MzRkcAeWr2NuRbKjL3a64b4t3UbGsuKPmSmxAWUjlDE5tJ8KZ/Lc6Bc78ODQBYXh/V/X
         NEmB579iZS3u+7ednLkdb1OOMeThw0ukTwXYm7oHz1bW9n4Z7Cqg7xQXA0GP6v8wUDMG
         cTvjBj9bLJSEzjbmfIUqaYiP/XYvNlMV9trURF4OCNDuTeCk2K6iYzMBsCxNLbR8rn0t
         KX72stXza/1E//XyOMJUI/Hwhm76vmK6NQoz/c3mwSqDbAp7uHyw6qeLGUwsVBT7NWoD
         Vjfg==
X-Gm-Message-State: AOAM533vovIXrprO0Kef8jr6q51o21byR9TNc67QDZVkCfwlI1NUiBVT
        Vl15Fiv8W6z5QYvDvL5KmsunXQ==
X-Google-Smtp-Source: ABdhPJz/T8i1ndQ95AJQ1BhbMue7YxP392WtdYyALL1mT1abfL97jXQqBYSc4pv3sDAGMlow9+83BA==
X-Received: by 2002:a7b:c449:: with SMTP id l9mr6440439wmi.160.1641988351371;
        Wed, 12 Jan 2022 03:52:31 -0800 (PST)
Received: from ?IPv6:2a02:6b6d:f804:0:1381:d05e:375f:8daf? ([2a02:6b6d:f804:0:1381:d05e:375f:8daf])
        by smtp.gmail.com with ESMTPSA id az4sm252078wrb.14.2022.01.12.03.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 03:52:31 -0800 (PST)
Subject: Re: [PATCH v5] bpf/scripts: add an error if the correct number of
 helpers are not generated
To:     Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, joe@cilium.io,
        fam.zheng@bytedance.com, cong.wang@bytedance.com,
        alexei.starovoitov@gmail.com, song@kernel.org
References: <20220111184418.196442-1-usama.arif@bytedance.com>
 <e5ad3ed1-3d4e-f4cc-6eb9-073c0cca11d4@isovalent.com>
 <e3d4673b-08be-09fd-0a87-b679713146b5@bytedance.com>
 <bdf4ec41-58fa-d0db-f2d2-f6575c4444b8@isovalent.com>
From:   Usama Arif <usama.arif@bytedance.com>
Message-ID: <f811ae37-7574-3285-cdb1-2d76f51f8902@bytedance.com>
Date:   Wed, 12 Jan 2022 11:52:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <bdf4ec41-58fa-d0db-f2d2-f6575c4444b8@isovalent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/01/2022 11:04, Quentin Monnet wrote:
> 2022-01-12 10:19 UTC+0000 ~ Usama Arif <usama.arif@bytedance.com>
>>
>>
>> On 12/01/2022 10:01, Quentin Monnet wrote:
>>> 2022-01-11 18:44 UTC+0000 ~ Usama Arif <usama.arif@bytedance.com>
>>>> Currently bpf_helper_defs.h and the bpf helpers man page are
>>>> auto-generated
>>>> using function documentation present in bpf.h. If the documentation
>>>> for the
>>>> helper is missing or doesn't follow a specific format for e.g. if a
>>>> function
>>>> is documented as:
>>>>    * long bpf_kallsyms_lookup_name( const char *name, int name_sz, int
>>>> flags, u64 *res )
>>>> instead of
>>>>    * long bpf_kallsyms_lookup_name(const char *name, int name_sz, int
>>>> flags, u64 *res)
>>>> (notice the extra space at the start and end of function arguments)
>>>> then that helper is not dumped in the auto-generated header and
>>>> results in
>>>> an invalid call during eBPF runtime, even if all the code specific to
>>>> the
>>>> helper is correct.
>>>>
>>>> This patch checks the number of functions documented within the
>>>> header file
>>>> with those present as part of #define __BPF_FUNC_MAPPER and generates an
>>>> error in the header file and the man page if they don't match. It is not
>>>> needed with the currently documented upstream functions, but can help in
>>>> debugging when developing new helpers when there might be missing or
>>>> misformatted documentation.
>>>>
>>>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>>>>
>>>> ---
>>>> v4->v5:
>>>> - Converted warning to error incase of missing/misformatted helper doc
>>>>     (suggested by Song Liu)
>>>
>>> I don't think it was converted to an error in the sense that Song meant
>>> it? Unless I'm missing something you simply changed the message so that
>>> it prints "error" instead of "warning", but the script still goes on
>>> without returning any error code, and a failure won't be detected by the
>>> CI for example.
>>>
>>> Could you make the script break out on errors, and print a message to
>>> stderr so that it's visible even if the generated output is redirected
>>> to a file, please?
>>>
>>
>> It does now print an error to stdout while building an eBPF application.
>> For e.g. if you introduce a space in the doc as in the commit message like:
>>
>> diff --git a/tools/include/uapi/linux/bpf.h
>> b/tools/include/uapi/linux/bpf.h
>> index ba5af15e25f5..5bf80dbb820b 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -4908,7 +4908,7 @@ union bpf_attr {
>>    *
>>    *             **-ENOENT** if architecture does not support branch
>> records.
>>    *
>> - * long bpf_trace_vprintk(const char *fmt, u32 fmt_size, const void
>> *data, u32 data_len)
>> + * long bpf_trace_vprintk( const char *fmt, u32 fmt_size, const void
>> *data, u32 data_len)
>>    *     Description
>>    *             Behaves like **bpf_trace_printk**\ () helper, but takes
>> an array of u64
>>    *             to format and can handle more format args as a result.
>> @@ -4938,6 +4938,12 @@ union bpf_attr {
>>    *             **-ENOENT** if symbol is not found.
>>    *
>>    *             **-EPERM** if caller does not have permission to obtain
>> kernel address.
>>
>> and build samples/bpf:
>>
>> make  LLVM_STRIP=llvm-strip-13 M=samples/bpf > /tmp/samplesbuild.out
>>
>> you get the following at stderr returning an error code
>>
>> make[2]: *** [Makefile:186:
>> /data/usaari01/ebpf/linux/samples/bpf/bpftool/pid_iter.bpf.o] Error 1
>> make[2]: *** Waiting for unfinished jobs....
>> In file included from skeleton/profiler.bpf.c:4:
>> In file included from
>> /data/usaari01/ebpf/linux/samples/bpf/bpftool//bootstrap/libbpf//include/bpf/bpf_helpers.h:11:
>>
>> /data/usaari01/ebpf/linux/samples/bpf/bpftool//bootstrap/libbpf//include/bpf/bpf_helper_defs.h:5:2:
>> error: The number of unique helpers in description (176) don't match the
>> number of unique helpers defined in __BPF_FUNC_MAPPER (180)
>> #error The number of unique helpers in description (176) don't match the
>> number of unique helpers defined in __BPF_FUNC_MAPPER (180)
>>   ^
>> /data/usaari01/ebpf/linux/samples/bpf/bpftool//bootstrap/libbpf//include/bpf/bpf_helper_defs.h:7:2:
>> error: The description for FN(trace_vprintk) is not present or formatted
>> correctly.
>> #error The description for FN(trace_vprintk) is not present or formatted
>> correctly.
>>   ^
> 
> Right, my bad, I tried your patch to generate the header but didn't go
> so far as to include it and try to compile a program.
> 
>> But i am guessing that you want an error while the script is run as well?
>> If we do this:
>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
>> index adf08fa963a4..4ce982ce58f2 100755
>> --- a/scripts/bpf_doc.py
>> +++ b/scripts/bpf_doc.py
>> @@ -397,6 +397,7 @@ HELPERS
>>       The description for %s is not present or formatted correctly.
>>   ''' % (self.define_unique_helpers[nr_desc_unique_helpers])
>>               print(header_error)
>> +            print(header_error, file = sys.stderr)
>>
>>           print(header_description)
>>
>> @@ -693,6 +694,7 @@ class PrinterHelpers(Printer):
>>   #error The description for %s is not present or formatted correctly.
>>   ''' % (self.define_unique_helpers[nr_desc_unique_helpers])
>>               print(header_error)
>> +            print(header_error, file = sys.stderr)
>>
>>           for fwd in self.type_fwds:
>>               print('%s;' % fwd)
>>
>> then an error will be printed while the script is run and also later
>> while the eBPF application is compiled. I can send this in next version
>> if thats the preference?
> 
> Yes, this is what I meant. From my point of view it would be best if we
> had this message, and also if we could make bpf_doc.py raise an
> Exception on such errors. Given that we can tell at this step already
> that compiling will fail, we should as well break the workflow here,
> there's not much point in carrying on and calling the compiler.
> 

Thanks, i have sent v6 which raises an Exception. No point in writing to 
the auto-generated header/rst if the script raises an Exception as the 
actual helpers wont be written so i have moved the check to the constructor.

> Thanks,
> Quentin
> 
