Return-Path: <bpf+bounces-1908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862E37235B1
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 05:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7D61C20B47
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 03:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78F9638;
	Tue,  6 Jun 2023 03:20:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D64394
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 03:20:48 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40AC11B
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 20:20:46 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6af6fe73f11so5252403a34.0
        for <bpf@vger.kernel.org>; Mon, 05 Jun 2023 20:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686021646; x=1688613646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ntz136Kv/Z3zkhnJ6VCfDwRACVjWDfGBtrEKcKvWUw=;
        b=DqncP1yN7WvbpQmN3FIeaCkq3uY5TqNpLAQQZx+mpFCIDPZvMnxMND6j6piAILHxFZ
         12jQKJcLNw78VtiWS4VyU11ZsmRDw6Dm9et5QMiEjYJNXlcwuH9TUqH1n1MLaIhSUkTs
         Y8w0K3I95RBssUjpOT6c8Zsifk7Gma0/7XBfQ1cROortF+wRJO3JkSGKcAbymSdKpDlR
         ctkPxm3/qZqnPj+G0p4YMdNPBpMYuCeMovBjxu0SX6DztNyyVNBIiJFQGjXpmmifSSjk
         byeo1qdtYt3G1C80N/sjLfejh1dzK48I6TyppSVCdXCZd55kwmdvI4+0jQUA9jixYidH
         9z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686021646; x=1688613646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ntz136Kv/Z3zkhnJ6VCfDwRACVjWDfGBtrEKcKvWUw=;
        b=jPFzj4/CdhJ/62jTHdYCpHg/tVD8CboA+lCa0e985qnfKPmqZye2EFHH8m9EVBZdcA
         K+NQb0AipT8Ph3ctuwWZsEbqIEAmYKBoHssXhcuPMFZFy1Ll4qeti9ua2o01mH3v+ZwU
         qfodWbjCUS9dEdFva2TJL9OvymxC19jkj3J3b2/TLPLV8TZtWghkVgNQZtrIHmHzET1I
         LdN2q1TcVpYfZqlppMCJlrZAZnmuuatR+4NcTSj4wOJ83ZXog2UdgIJFiQ5HLVhS3Cf2
         N3msbbxkBMrCsATLKwxUgvqKjoVzgZZ0gO8EJqfHGqnFAX1oNJyiJKqcf24AiWHexpwF
         y7wg==
X-Gm-Message-State: AC+VfDzj7Y9frUMzMVyx0ExUl6F+E60y1JyR/LKuyjEMT1bO7Ar0HsA2
	zYLe8GuPcR96dLF6verIrRAVPA==
X-Google-Smtp-Source: ACHHUZ6YuXJUXGWkdpcGrIlzXzS0Yda3ftDJl98KfFEAf+y0rJ12iMkNK2jsHTija0uGTAdiexMjcw==
X-Received: by 2002:a9d:67d3:0:b0:6ab:1d99:5dc6 with SMTP id c19-20020a9d67d3000000b006ab1d995dc6mr821640otn.3.1686021646162;
        Mon, 05 Jun 2023 20:20:46 -0700 (PDT)
Received: from [10.71.57.173] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j1-20020aa78d01000000b0065329194416sm5769668pfe.193.2023.06.05.20.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 20:20:45 -0700 (PDT)
Message-ID: <2d138e12-9273-46e6-c219-96c665f38f0f@bytedance.com>
Date: Tue, 6 Jun 2023 11:20:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: Re: [PATCH bpf-next] bpf: getsockopt hook to get optval without
 checking kernel retval
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
References: <20230601024900.22902-1-zhoufeng.zf@bytedance.com>
 <5bc1ac0d-cea8-19e5-785a-cd72140d8cdb@linux.dev>
 <20881602-9afc-96b7-3d58-51c31e3f50b7@bytedance.com>
 <d7be9d22-c6aa-da2a-77fc-9638ad1e0f15@linux.dev>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <d7be9d22-c6aa-da2a-77fc-9638ad1e0f15@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

在 2023/6/1 23:50, Martin KaFai Lau 写道:
> On 5/31/23 11:05 PM, Feng Zhou wrote:
>> 在 2023/6/1 13:37, Martin KaFai Lau 写道:
>>> On 5/31/23 7:49 PM, Feng zhou wrote:
>>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>>
>>>> Remove the judgment on retval and pass bpf ctx by default. The
>>>> advantage of this is that it is more flexible. Bpf getsockopt can
>>>> support the new optname without using the module to call the
>>>> nf_register_sockopt to register.
>>>>
>>>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>> ---
>>>>   kernel/bpf/cgroup.c | 35 +++++++++++++----------------------
>>>>   1 file changed, 13 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>>>> index 5b2741aa0d9b..ebad5442d8bb 100644
>>>> --- a/kernel/bpf/cgroup.c
>>>> +++ b/kernel/bpf/cgroup.c
>>>> @@ -1896,30 +1896,21 @@ int 
>>>> __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>>>>       if (max_optlen < 0)
>>>>           return max_optlen;
>>>> -    if (!retval) {
>>>> -        /* If kernel getsockopt finished successfully,
>>>> -         * copy whatever was returned to the user back
>>>> -         * into our temporary buffer. Set optlen to the
>>>> -         * one that kernel returned as well to let
>>>> -         * BPF programs inspect the value.
>>>> -         */
>>>> -
>>>> -        if (get_user(ctx.optlen, optlen)) {
>>>> -            ret = -EFAULT;
>>>> -            goto out;
>>>> -        }
>>>> +    if (get_user(ctx.optlen, optlen)) {
>>>> +        ret = -EFAULT;
>>>> +        goto out;
>>>> +    }
>>>> -        if (ctx.optlen < 0) {
>>>> -            ret = -EFAULT;
>>>> -            goto out;
>>>> -        }
>>>> -        orig_optlen = ctx.optlen;
>>>> +    if (ctx.optlen < 0) {
>>>> +        ret = -EFAULT;
>>>> +        goto out;
>>>> +    }
>>>> +    orig_optlen = ctx.optlen;
>>>> -        if (copy_from_user(ctx.optval, optval,
>>>> -                   min(ctx.optlen, max_optlen)) != 0) {
>>>> -            ret = -EFAULT;
>>>> -            goto out;
>>>> -        }
>>>> +    if (copy_from_user(ctx.optval, optval,
>>>> +                min(ctx.optlen, max_optlen)) != 0) {
>>> What is in optval that is useful to copy from if the kernel didn't 
>>> handle the optname?
>>
>> For example, if the user customizes a new optname, it will not be 
>> processed if the kernel does not support it. Then the data stored in 
>> optval is the data put 
> 
> 
> 
>> by the user. If this part can be seen by bpf prog, the user can 
>> implement processing logic of the custom optname through bpf prog.
> 
> This part does not make sense. It is a (get)sockopt. Why the bpf prog 
> should expect anything useful in the original __user optval? Other than 
> unnecessary copy for other common cases, it looks like a bad api, so 
> consider it a NAK.
> 
>>
>>>
>>> and there is no selftest also.
>>>
>>
>> Yes, if remove this restriction, everyone thinks it's ok, I'll add it 
>> in the next version.
>>
>>>> +        ret = -EFAULT;
>>>> +        goto out;
>>>>       }
>>>>       lock_sock(sk);
>>>
>>
> 

According to my understanding, users will have such requirements, 
customize an optname, which is not available in the kernel. All logic is 
completed in bpf prog, and bpf prog needs to obtain the user data passed 
in by the system call, and then return the data required by the user 
according to this data.

For optname not in the kernel, the error code is
#define ENOPROTOOPT 92/* Protocol not available */
Whether to consider the way of judging with error codes,
If (! retval | | retval == -ENOPROTOOPT)


