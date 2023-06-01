Return-Path: <bpf+bounces-1590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BAD71A342
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 17:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C151C21061
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 15:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FD622D7B;
	Thu,  1 Jun 2023 15:51:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12104BA2F
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 15:51:15 +0000 (UTC)
Received: from out-47.mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C8710C8
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 08:50:54 -0700 (PDT)
Message-ID: <d7be9d22-c6aa-da2a-77fc-9638ad1e0f15@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1685634627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+uwm5sKeEoY5cesBkbtx6UCMG7Wp0HpraPauEHbi8U=;
	b=XnSG8ZAfWTZlVL1f6ZN9vwYCjOJhTWjNer5HpwNa+Fh1TBsgmkOegDmhCpDmULbPOlwYeJ
	XF3cEhBAHkD4fmIv65SZLTkqbmOaMT5E5P60BJa/zOq71mF1SPzmlVhkcHGMfh/79prl4N
	Vywt23qrWrMGZb/eCXKS1b9rebwHXII=
Date: Thu, 1 Jun 2023 08:50:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: getsockopt hook to get optval without
 checking kernel retval
Content-Language: en-US
To: Feng Zhou <zhoufeng.zf@bytedance.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
References: <20230601024900.22902-1-zhoufeng.zf@bytedance.com>
 <5bc1ac0d-cea8-19e5-785a-cd72140d8cdb@linux.dev>
 <20881602-9afc-96b7-3d58-51c31e3f50b7@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20881602-9afc-96b7-3d58-51c31e3f50b7@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/31/23 11:05 PM, Feng Zhou wrote:
> 在 2023/6/1 13:37, Martin KaFai Lau 写道:
>> On 5/31/23 7:49 PM, Feng zhou wrote:
>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>
>>> Remove the judgment on retval and pass bpf ctx by default. The
>>> advantage of this is that it is more flexible. Bpf getsockopt can
>>> support the new optname without using the module to call the
>>> nf_register_sockopt to register.
>>>
>>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>>> ---
>>>   kernel/bpf/cgroup.c | 35 +++++++++++++----------------------
>>>   1 file changed, 13 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>>> index 5b2741aa0d9b..ebad5442d8bb 100644
>>> --- a/kernel/bpf/cgroup.c
>>> +++ b/kernel/bpf/cgroup.c
>>> @@ -1896,30 +1896,21 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock 
>>> *sk, int level,
>>>       if (max_optlen < 0)
>>>           return max_optlen;
>>> -    if (!retval) {
>>> -        /* If kernel getsockopt finished successfully,
>>> -         * copy whatever was returned to the user back
>>> -         * into our temporary buffer. Set optlen to the
>>> -         * one that kernel returned as well to let
>>> -         * BPF programs inspect the value.
>>> -         */
>>> -
>>> -        if (get_user(ctx.optlen, optlen)) {
>>> -            ret = -EFAULT;
>>> -            goto out;
>>> -        }
>>> +    if (get_user(ctx.optlen, optlen)) {
>>> +        ret = -EFAULT;
>>> +        goto out;
>>> +    }
>>> -        if (ctx.optlen < 0) {
>>> -            ret = -EFAULT;
>>> -            goto out;
>>> -        }
>>> -        orig_optlen = ctx.optlen;
>>> +    if (ctx.optlen < 0) {
>>> +        ret = -EFAULT;
>>> +        goto out;
>>> +    }
>>> +    orig_optlen = ctx.optlen;
>>> -        if (copy_from_user(ctx.optval, optval,
>>> -                   min(ctx.optlen, max_optlen)) != 0) {
>>> -            ret = -EFAULT;
>>> -            goto out;
>>> -        }
>>> +    if (copy_from_user(ctx.optval, optval,
>>> +                min(ctx.optlen, max_optlen)) != 0) {
>> What is in optval that is useful to copy from if the kernel didn't handle the 
>> optname?
> 
> For example, if the user customizes a new optname, it will not be processed if 
> the kernel does not support it. Then the data stored in optval is the data put 



> by the user. If this part can be seen by bpf prog, the user can implement 
> processing logic of the custom optname through bpf prog.

This part does not make sense. It is a (get)sockopt. Why the bpf prog should 
expect anything useful in the original __user optval? Other than unnecessary 
copy for other common cases, it looks like a bad api, so consider it a NAK.

> 
>>
>> and there is no selftest also.
>>
> 
> Yes, if remove this restriction, everyone thinks it's ok, I'll add it in the 
> next version.
> 
>>> +        ret = -EFAULT;
>>> +        goto out;
>>>       }
>>>       lock_sock(sk);
>>
> 


