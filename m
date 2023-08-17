Return-Path: <bpf+bounces-8011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C430677FD83
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 20:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73333281F2E
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 18:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E59174D4;
	Thu, 17 Aug 2023 18:11:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31A1171BB
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 18:10:59 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B118E26A5
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 11:10:58 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-586a684e85aso1038057b3.2
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 11:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692295858; x=1692900658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3gp1BwSBuA5NQiBWkOOROLVjgBoN0j9Svcp93oVgso=;
        b=a73ewx8T++7uUoDM4PBhf1Z/JewZOvlnTq9wRV14K55B1jWgtfxpaVOjo8P51jmsdY
         8mMIvKztOZo1TggvKVoJamT9PVF8wT+Q1eSPuMDHk23N9FmZbwdT3CJ1cWHr688FGtY1
         n0tenCTJNCuUwWMEVzfn2G/SlJxkzOsdwunehAmqxj0CGNCIM/ablRgsLzE2PCP/P8VU
         lp3fYzKXROPUdKQFguBb1bxBvJ10RUEIJG1Pmww6Ij1ue8HPVZsgfF+bVrN0l/YItAV9
         X1s57c36Cpw1ZeXak7dXtSHG5VP4NOHLVR7M4NNGkVXLUvK4uEiAX7/OO6wW4j/moj7o
         Om0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692295858; x=1692900658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3gp1BwSBuA5NQiBWkOOROLVjgBoN0j9Svcp93oVgso=;
        b=GhktFNx4fl1xWUDfLoGJoNIXyobrqfB6G+qrqlBF12prFbMjcP3Mpe1vUGLwHN8SzZ
         394WeqrMQoaMPkIlUooLxMbQUkK6bWcUjdMkiH/8N5PIUAhtYVBDXYmMuUMClSwfDy9I
         oN8RzydeCa7tu9P3RPqcqUTMbQAZZuYnzENlJdoRrdBckmdt4anXXxXjIVF+QJ0679lt
         cJ77e6TcfoSS+WM3qBZ49EyHvqRKhcNpKazlubM922aKvtQoyydxZq23zzvyL7ypelPF
         IQEOaNBybAuFEgLj7h62cJj8F2kRDR7LaJpj1VfEFdXgGo2TGA7hOZyy/Dhlxk8f0e0L
         c1RQ==
X-Gm-Message-State: AOJu0Yy6edT0by4OBVZDTCHWD4FiOLqCodo0OK/ts8hqUs7JG1RabZ2B
	dh/Pfq8idclbewO95lr5LrA=
X-Google-Smtp-Source: AGHT+IG34uYSfL0KFyF87t1k+Kj7rc50eumBJsUpRoaS8wEH2KtIjPmKPPh9iHHUxmHr5epuKTDEmQ==
X-Received: by 2002:a81:6087:0:b0:58c:4af1:b9c4 with SMTP id u129-20020a816087000000b0058c4af1b9c4mr118018ywb.44.1692295857803;
        Thu, 17 Aug 2023 11:10:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:5ef6:83:35d0:e69d? ([2600:1700:6cf8:1240:5ef6:83:35d0:e69d])
        by smtp.gmail.com with ESMTPSA id d13-20020a81ab4d000000b00583b144fe51sm18797ywk.118.2023.08.17.11.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 11:10:57 -0700 (PDT)
Message-ID: <30416b82-96ad-95e2-e272-cefacb1cbead@gmail.com>
Date: Thu, 17 Aug 2023 11:10:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next v3 3/5] bpf: Prevent BPF programs from access the
 buffer pointed by user_optval.
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@google.com,
 yonghong.song@linux.dev
References: <20230815174712.660956-1-thinker.li@gmail.com>
 <20230815174712.660956-4-thinker.li@gmail.com>
 <4950fffc-4c63-a4f1-f35c-5823e1e4238c@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <4950fffc-4c63-a4f1-f35c-5823e1e4238c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/16/23 17:55, Martin KaFai Lau wrote:
> On 8/15/23 10:47 AM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Since the buffer pointed by ctx->user_optval is in user space, BPF 
>> programs
>> in kernel space should not access it directly.  They should use
>> bpf_copy_from_user() and bpf_copy_to_user() to move data between user and
>> kernel space.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   kernel/bpf/cgroup.c   | 16 +++++++++--
>>   kernel/bpf/verifier.c | 66 +++++++++++++++++++++----------------------
>>   2 files changed, 47 insertions(+), 35 deletions(-)
>>
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index b977768a28e5..425094e071ba 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -2494,12 +2494,24 @@ static bool cg_sockopt_is_valid_access(int 
>> off, int size,
>>       case offsetof(struct bpf_sockopt, optval):
>>           if (size != sizeof(__u64))
>>               return false;
>> -        info->reg_type = PTR_TO_PACKET;
>> +        if (prog->aux->sleepable)
>> +            /* Prohibit access to the memory pointed by optval
>> +             * in sleepable programs.
>> +             */
>> +            info->reg_type = PTR_TO_PACKET | MEM_USER;
> 
> Is MEM_USER needed to call bpf_copy_from_user()?
> 
> Also, from looking at patch 4, the optval could be changed from user 
> memory to kernel memory during runtime. Is it useful to check MEM_USER 
> during the verifier load time?

It has been checked.
optval & optval_end are exported and can be used to compute the size
of the user space buffer. However, it can not be used to read the
content of the user space buffer.

To be specific, __check_mem_access() will fail due to having MEM_USER
in reg->type. However, it is implicit. I will make it explicit if
necessary.

> 
> How about just return false here to disallow sleepable prog to use 
> ->optval and ->optval_end. Enforce sleepable prog to stay with the 
> bpf_dynptr_read/write API and avoid needing the optval + len > 
> optval_end check in the sleepable bpf prog. WDYT?

Then, we need to export another variable to get the size of the buffer
pointed by optval. Then, I would like to have a new context type
instead of struct bpf_sockopt for the sleepable programs. With the new
type, we can remove optval & optval_end completely from the view of
sleepable ones. They will get errors of accessing optval & optval_end
as early as compile time.

> 
> Regarding ->optlen, do you think the sleepable prog can stay with the 
> bpf_dynptr_size() and bpf_dynptr_adjust() such that no need to expose 
> optlen to the sleepable prog also.
> 
>> +        else
>> +            info->reg_type = PTR_TO_PACKET;
>>           break;
>>       case offsetof(struct bpf_sockopt, optval_end):
>>           if (size != sizeof(__u64))
>>               return false;
>> -        info->reg_type = PTR_TO_PACKET_END;
>> +        if (prog->aux->sleepable)
>> +            /* Prohibit access to the memory pointed by
>> +             * optval_end in sleepable programs.
>> +             */
>> +            info->reg_type = PTR_TO_PACKET_END | MEM_USER;
>> +        else
>> +            info->reg_type = PTR_TO_PACKET_END;
>>           break;
> 

