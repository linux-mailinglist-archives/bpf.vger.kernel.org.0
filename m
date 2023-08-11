Return-Path: <bpf+bounces-7621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7489F779B52
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 01:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F421C20B95
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 23:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6414D3D3A5;
	Fri, 11 Aug 2023 23:27:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9D4329D4
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 23:27:27 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26D4E71
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 16:27:26 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d67869054bfso768316276.3
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 16:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691796446; x=1692401246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWTzZ3tIHZIYyDIto6DZR1q9kl6UvKsRfV5fS3NGZNs=;
        b=OB5UmedBCaKmeeWSLRwKsl1s0Wb9Nr9G+qxV3FksmBezgHwCqOVAC9FAJOolLw0ALf
         GDBAHLwIwBj33LzxbQrlLxGDsm421F+s6MIJ1tDSxgggZfi081ccTuy5GvjV5jLwssvt
         i1aHB3RRVmtRzho7jwFOGodio9GF8owe0fyUd6TAtFl2jR7mQ/VGYwg5echByZ25VBQe
         afmjTs/NaQL9etsYRwf/cYPDwHwoubxU7vm3+UoBsj0bTpdvzVWWxW6yg/NBx3LnjTeB
         2tEaeswzV4yV0S+JZVVN3HgL2IEGVlNGDEKoHd561YH/F2hYTyGicgs4yLt+cu8Sj5e0
         u95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796446; x=1692401246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWTzZ3tIHZIYyDIto6DZR1q9kl6UvKsRfV5fS3NGZNs=;
        b=aLwIYCMmHH54RF2KoQIo/mYmPbtoqLTtf7QjcqQ3FkoDG1rHa+l3gFjMlQoguf6BwY
         ljy4gEGe1Y8qN9dEef5Ga5lUB2bz9JMl/l3iB6R4CcsFUpdfz/8ZdlV8p6MDviczy9/G
         dKMoNWmP+S2w8VCdrpN+obusZjyfp1BjefzbBVuyayUVWO65a0JnYV1Pzjh5uWHTpEby
         3tymdwaIMjmds+GRJn+k5iQgApnbcB54sUMNiGpeZn8i1TxC7HmcLTlkgSXE2x4ygzNc
         sDcGPlJSM+EV9Tz2r7ALpySgzvdDJGGgrnVXR6bQgaNpB+Eh8UOEymQHxcRZVtZfLRaS
         Tkgg==
X-Gm-Message-State: AOJu0YypQBWG5x7esj7ucB1EwlI256zwRNCjgPPa/RShvrrSUZqXsfGd
	C+OKm5VnY7pmmtcyS3mQ8Qj/6CJtD0g=
X-Google-Smtp-Source: AGHT+IHkh/iQMta8WtmBw6y9D+Luz6jWjn/b1iSHaYSIAzDFnE9nJc0Yqf2vuLBhIlfV7ld18/3+wA==
X-Received: by 2002:a05:6902:4cf:b0:d06:c66c:6c6 with SMTP id v15-20020a05690204cf00b00d06c66c06c6mr2854985ybs.0.1691796446061;
        Fri, 11 Aug 2023 16:27:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:680f:f8a3:c49b:84db? ([2600:1700:6cf8:1240:680f:f8a3:c49b:84db])
        by smtp.gmail.com with ESMTPSA id u6-20020a05690201c600b00d1dd5c6c035sm1125886ybh.62.2023.08.11.16.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 16:27:25 -0700 (PDT)
Message-ID: <6a634e79-db63-df29-9d18-93387191f937@gmail.com>
Date: Fri, 11 Aug 2023 16:27:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next v2 4/6] bpf: Provide bpf_copy_from_user() and
 bpf_copy_to_user().
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 yonghong.song@linux.dev, kuifeng@meta.com
References: <20230811043127.1318152-1-thinker.li@gmail.com>
 <20230811043127.1318152-5-thinker.li@gmail.com> <ZNa+vhzXxYYOzk96@google.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ZNa+vhzXxYYOzk96@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/11/23 16:05, Stanislav Fomichev wrote:
> On 08/10, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <kuifeng@meta.com>
>>
>> Provide bpf_copy_from_user() and bpf_copy_to_user() to the BPF programs
>> attached to cgroup/{set,get}sockopt. bpf_copy_to_user() is a new kfunc to
>> copy data from an kernel space buffer to a user space buffer. They are only
>> available for sleepable BPF programs. bpf_copy_to_user() is only available
>> to the BPF programs attached to cgroup/getsockopt.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   kernel/bpf/cgroup.c  |  6 ++++++
>>   kernel/bpf/helpers.c | 31 +++++++++++++++++++++++++++++++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 5bf3115b265c..c15a72860d2a 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -2461,6 +2461,12 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>>   #endif
>>   	case BPF_FUNC_perf_event_output:
>>   		return &bpf_event_output_data_proto;
>> +
>> +	case BPF_FUNC_copy_from_user:
>> +		if (prog->aux->sleepable)
>> +			return &bpf_copy_from_user_proto;
>> +		return NULL;
> 
> If we just allow copy to/from, I'm not sure I understand how the buffer
> sharing between sleepable/non-sleepable works.
> 
> Let's assume I have two progs in the chain:
> 1. non-sleepable - copies the buffer, does some modifications; since
>     we don't copy the buffer back after every prog run, the modifications
>     stay in the kernel buffer
> 2. sleepable - runs and just gets the user pointer? does it mean this
>    sleepable program doesn't see the changes from (1)?
> 
> IOW, do we need some custom sockopt copy_to/from that handle this
> potential buffer location transparently or am I missing something?
> 
> Assuming we want to support this at all. If we do, might deserve a
> selftest.

It is why BPF_SOCKOPT_FLAG_OPTVAL_USER is there.
It helps programs to make a right decision.
However, I am going to remove bpf_copy_from_user()
since we have bpf_so_optval_copy_to() and bpf_so_optval_copy_to_r().
Does it make sense to you?

