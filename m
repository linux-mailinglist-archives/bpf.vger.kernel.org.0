Return-Path: <bpf+bounces-9311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04517933C3
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 04:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B3D2811F1
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 02:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D31B65F;
	Wed,  6 Sep 2023 02:29:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7D262B
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 02:29:39 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785B7132
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 19:29:38 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so2640382b3a.1
        for <bpf@vger.kernel.org>; Tue, 05 Sep 2023 19:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693967378; x=1694572178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vidjzallWCqGNJ4gQFjA4ceb3YWqlWEG95rOsPPmbHQ=;
        b=iXK+Z2+ZWqVH9vUyecIwdoDhMWf7WSdUgt++BTVCu1nNk5bZTfWCzu45en+6rwpsKz
         v8JrxovfdQWx4SLJuc0ZsCpqg6DK6/uZ0Nsy8OTIvBrsLLZGqS46cmdbTpCOWf7hLl0E
         0QbERsl0XVNrOSfNczcPQe8DwnvN3gbycGbqGzDo082JXnO2h01QXxY/9tBf8al0r4jP
         21dpVu9xTWMoJHebfZNLaOyXBR1RPdcXoFUrcXq4iZH9z28UmeAF7W9JDeukjgTg9Cx4
         583ysmzCf19MguNGXuPu0KaIhh7NnF4L7gab/XUt9H0jMx/ySlMgEEa7dLOexZjlHxE9
         St2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693967378; x=1694572178;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vidjzallWCqGNJ4gQFjA4ceb3YWqlWEG95rOsPPmbHQ=;
        b=DQ+8rMWxMBHUgnE2Dj9rRVWsiWyETS69Eftwx5R8R26DqZH5o6CXrNOMKLJIet8R1r
         mVE3QywASWIwWoHehxIOYCNR/J1xxKith+zSNW4oK4WCkFD3xHYaY990hk2AdUI5qUaH
         Kqj+8Uh7J5BwDjEIxPEe3jhc5RUfTORkrPUwtWitvRvqJ3rrGO3n4luNDJ6hDIfzNl7q
         ea3HIkEttzrc2pnse4yEE95SjqS1tn1qR6c8EddMawUYTM1FBvOOgkkz4PHXGmL5Wv3t
         UEkfE4BgQE426z+g5D2VmVzCPFjeLbnca5sGtxvGkjrFPq4MnKZsgWlgaGg32AmDg9cf
         kWAg==
X-Gm-Message-State: AOJu0YwgQGCeRNy3+Nahu1fbjarrLUMxuH97HLbe4NV/+WQHaDz8uLbi
	/Um6Rysc2LzUUuzCascM/TA=
X-Google-Smtp-Source: AGHT+IFEWZ6d96FwJRyrCr+7/M5nTc+C1UkIc7V398IE+Cc+RMjmQ2FoAIa2z8CZEo9/IWUBXV7MLg==
X-Received: by 2002:a05:6a20:1605:b0:14d:7511:1c2 with SMTP id l5-20020a056a20160500b0014d751101c2mr18908625pzj.55.1693967377884;
        Tue, 05 Sep 2023 19:29:37 -0700 (PDT)
Received: from [10.22.67.252] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id t23-20020a1709028c9700b001bdb85291casm9948854plo.208.2023.09.05.19.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 19:29:37 -0700 (PDT)
Message-ID: <66bc25c8-17ca-c456-d9c3-a9522c0aafdf@gmail.com>
Date: Wed, 6 Sep 2023 10:29:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH bpf-next v4 3/4] selftests/bpf: Correct map_fd to
 data_fd in tailcalls
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 iii@linux.ibm.com, jakub@cloudflare.com, bpf@vger.kernel.org
References: <20230903151448.61696-1-hffilwlqm@gmail.com>
 <20230903151448.61696-4-hffilwlqm@gmail.com> <ZPd/+49iX6DrSyCE@boxer>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <ZPd/+49iX6DrSyCE@boxer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/9/23 03:22, Maciej Fijalkowski wrote:
> On Sun, Sep 03, 2023 at 11:14:47PM +0800, Leon Hwang wrote:
>> Get and check data_fd. It should not to check map_fd again.
>>
>> Fixes: 79d49ba048ec ("bpf, testing: Add various tail call test cases")
>> Fixes: 3b0379111197 ("selftests/bpf: Add tailcall_bpf2bpf tests")
>> Fixes: 5e0b0a4c52d3 ("selftests/bpf: Test tail call counting with bpf2bpf and data on stack")
>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> 
> This could be pulled out of this RFC set and sent separately to bpf tree,
> given that Ilya is taking a look at addressing s390 jit.

Yeah, I'll do it.

> 
>> ---
>>  tools/testing/selftests/bpf/prog_tests/tailcalls.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>> index 58fe2c586ed76..b20d7f77a5bce 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>> @@ -274,7 +274,7 @@ static void test_tailcall_count(const char *which)
>>  		return;
>>  
>>  	data_fd = bpf_map__fd(data_map);
>> -	if (CHECK_FAIL(map_fd < 0))
>> +	if (CHECK_FAIL(data_fd < 0))
>>  		return;
>>  
>>  	i = 0;
>> @@ -355,7 +355,7 @@ static void test_tailcall_4(void)
>>  		return;
>>  
>>  	data_fd = bpf_map__fd(data_map);
>> -	if (CHECK_FAIL(map_fd < 0))
>> +	if (CHECK_FAIL(data_fd < 0))
>>  		return;
>>  
>>  	for (i = 0; i < bpf_map__max_entries(prog_array); i++) {
>> @@ -445,7 +445,7 @@ static void test_tailcall_5(void)
>>  		return;
>>  
>>  	data_fd = bpf_map__fd(data_map);
>> -	if (CHECK_FAIL(map_fd < 0))
>> +	if (CHECK_FAIL(data_fd < 0))
>>  		return;
> 
> shouldn't this be 'goto out' ? applies to the rest of the code i believe.

Good point. I'll correct some other 'return' to 'goto out' meanwhile.

Thanks,
Leon

> 
>>  
>>  	for (i = 0; i < bpf_map__max_entries(prog_array); i++) {
>> @@ -634,7 +634,7 @@ static void test_tailcall_bpf2bpf_2(void)
>>  		return;
>>  
>>  	data_fd = bpf_map__fd(data_map);
>> -	if (CHECK_FAIL(map_fd < 0))
>> +	if (CHECK_FAIL(data_fd < 0))
>>  		return;
>>  
>>  	i = 0;
>> @@ -808,7 +808,7 @@ static void test_tailcall_bpf2bpf_4(bool noise)
>>  		return;
>>  
>>  	data_fd = bpf_map__fd(data_map);
>> -	if (CHECK_FAIL(map_fd < 0))
>> +	if (CHECK_FAIL(data_fd < 0))
>>  		return;
>>  
>>  	i = 0;
>> @@ -872,7 +872,7 @@ static void test_tailcall_bpf2bpf_6(void)
>>  	ASSERT_EQ(topts.retval, 0, "tailcall retval");
>>  
>>  	data_fd = bpf_map__fd(obj->maps.bss);
>> -	if (!ASSERT_GE(map_fd, 0, "bss map fd"))
>> +	if (!ASSERT_GE(data_fd, 0, "bss map fd"))
>>  		goto out;
>>  
>>  	i = 0;
>> -- 
>> 2.41.0
>>

