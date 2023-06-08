Return-Path: <bpf+bounces-2090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA667275DB
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 05:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9DC2815D1
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 03:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0468111E;
	Thu,  8 Jun 2023 03:39:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746C210EF
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 03:39:35 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522582705
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 20:39:30 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f6c6020cfbso1014421cf.2
        for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 20:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686195569; x=1688787569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvtGe+47bQaQV8brBLmNwnumVany/JnICTxUNCusye0=;
        b=J65mhKmDzbLJbBnIRnqiuaaqadLBTovoBsSmppOCs2lltGkoL+ca38+UuosfJrHo+X
         aum8iksSgOf9WzvZGVp5bzCBnwnYzzIuo+aTxhN+ZdlUTkOZ2JrKD8+DPFULwXEKpWkT
         Cqjp64BwdglaVgMmKeTq2Hal8w1gpzEgW3l/GCS2GS/suK/82V1kjycHKdZR+tpgMf1a
         s1i/+DE2ohpgAeVh/mqcAK1W9ob8CceFBtb2C1hUCvID0BOSkDIqyhgT7LJEmNxHQlzB
         9d5T87S27x4aWfKqovv6ws+buo1N3ntSN59FwEatChjC++Su/ZMrpBNIkMaxdIlOd/9P
         YGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686195569; x=1688787569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PvtGe+47bQaQV8brBLmNwnumVany/JnICTxUNCusye0=;
        b=cTSFnX9orAWGcMKVx4V+rDsRhvXgKyRHz7xgMQgAhEsEXBinpOw8mOoB/MMJSPtHEM
         8F83Wod4U0b/ORYNfG3+I6gG48JLkZZDAlIznRgo1zEJm7nbhvD68+GEDWL5WnjiJtTs
         Z1oQ5MkLjChabSzfQ/zoBB641exMomQdHDFDGlMHzoDTqk9XH+++2Cr1fAeUqMj5/Wen
         4XPbJpwEOd7MNSO8VOsnRepWgjzdvYoyucbGGXtG4d88ywiwrfzqAoZ83KUCKPiczGti
         nUd43vFo683x9kk+fGPhMiaBC2P6mo/xhpvhUID2jzpkk7su+xGqTygnr07s/P4c+ECI
         OYdg==
X-Gm-Message-State: AC+VfDwCk1++Y5QOZDH//+1bO6hGnRjmSrKl4bi3G4ijD8BNnVJ1KhvR
	ozKULv4YMb3VHecGagdzeIQ4aQ==
X-Google-Smtp-Source: ACHHUZ7/oM6oXW9uifA0GKweKEIcqiKoiqNo1XWxhdtGPeucV6PjfQ1N+nJe2D8iucOwcT/tAcLkzQ==
X-Received: by 2002:ac8:5a11:0:b0:3f6:e3aa:a61f with SMTP id n17-20020ac85a11000000b003f6e3aaa61fmr6035006qta.19.1686195568988;
        Wed, 07 Jun 2023 20:39:28 -0700 (PDT)
Received: from [10.71.57.173] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b001affb590696sm236480plg.216.2023.06.07.20.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 20:39:28 -0700 (PDT)
Message-ID: <c902419b-e265-75ff-1275-338dbfd69cda@bytedance.com>
Date: Thu, 8 Jun 2023 11:39:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: Re: Re: [PATCH bpf-next] bpf: getsockopt hook to get optval
 without checking kernel retval
To: Stanislav Fomichev <sdf@google.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org
References: <20230601024900.22902-1-zhoufeng.zf@bytedance.com>
 <5bc1ac0d-cea8-19e5-785a-cd72140d8cdb@linux.dev>
 <20881602-9afc-96b7-3d58-51c31e3f50b7@bytedance.com>
 <d7be9d22-c6aa-da2a-77fc-9638ad1e0f15@linux.dev>
 <2d138e12-9273-46e6-c219-96c665f38f0f@bytedance.com>
 <CAKH8qBtxNuwvawZ3v1-eK0RovPHu5AtYpays29TjxE2s-2RHpQ@mail.gmail.com>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <CAKH8qBtxNuwvawZ3v1-eK0RovPHu5AtYpays29TjxE2s-2RHpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

在 2023/6/7 01:04, Stanislav Fomichev 写道:
> On Mon, Jun 5, 2023 at 8:20 PM Feng Zhou <zhoufeng.zf@bytedance.com> wrote:
>>
>> 在 2023/6/1 23:50, Martin KaFai Lau 写道:
>>> On 5/31/23 11:05 PM, Feng Zhou wrote:
>>>> 在 2023/6/1 13:37, Martin KaFai Lau 写道:
>>>>> On 5/31/23 7:49 PM, Feng zhou wrote:
>>>>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>>>>
>>>>>> Remove the judgment on retval and pass bpf ctx by default. The
>>>>>> advantage of this is that it is more flexible. Bpf getsockopt can
>>>>>> support the new optname without using the module to call the
>>>>>> nf_register_sockopt to register.
>>>>>>
>>>>>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>>>> ---
>>>>>>    kernel/bpf/cgroup.c | 35 +++++++++++++----------------------
>>>>>>    1 file changed, 13 insertions(+), 22 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>>>>>> index 5b2741aa0d9b..ebad5442d8bb 100644
>>>>>> --- a/kernel/bpf/cgroup.c
>>>>>> +++ b/kernel/bpf/cgroup.c
>>>>>> @@ -1896,30 +1896,21 @@ int
>>>>>> __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>>>>>>        if (max_optlen < 0)
>>>>>>            return max_optlen;
>>>>>> -    if (!retval) {
>>>>>> -        /* If kernel getsockopt finished successfully,
>>>>>> -         * copy whatever was returned to the user back
>>>>>> -         * into our temporary buffer. Set optlen to the
>>>>>> -         * one that kernel returned as well to let
>>>>>> -         * BPF programs inspect the value.
>>>>>> -         */
>>>>>> -
>>>>>> -        if (get_user(ctx.optlen, optlen)) {
>>>>>> -            ret = -EFAULT;
>>>>>> -            goto out;
>>>>>> -        }
>>>>>> +    if (get_user(ctx.optlen, optlen)) {
>>>>>> +        ret = -EFAULT;
>>>>>> +        goto out;
>>>>>> +    }
>>>>>> -        if (ctx.optlen < 0) {
>>>>>> -            ret = -EFAULT;
>>>>>> -            goto out;
>>>>>> -        }
>>>>>> -        orig_optlen = ctx.optlen;
>>>>>> +    if (ctx.optlen < 0) {
>>>>>> +        ret = -EFAULT;
>>>>>> +        goto out;
>>>>>> +    }
>>>>>> +    orig_optlen = ctx.optlen;
>>>>>> -        if (copy_from_user(ctx.optval, optval,
>>>>>> -                   min(ctx.optlen, max_optlen)) != 0) {
>>>>>> -            ret = -EFAULT;
>>>>>> -            goto out;
>>>>>> -        }
>>>>>> +    if (copy_from_user(ctx.optval, optval,
>>>>>> +                min(ctx.optlen, max_optlen)) != 0) {
>>>>> What is in optval that is useful to copy from if the kernel didn't
>>>>> handle the optname?
>>>>
>>>> For example, if the user customizes a new optname, it will not be
>>>> processed if the kernel does not support it. Then the data stored in
>>>> optval is the data put
>>>
>>>
>>>
>>>> by the user. If this part can be seen by bpf prog, the user can
>>>> implement processing logic of the custom optname through bpf prog.
>>>
>>> This part does not make sense. It is a (get)sockopt. Why the bpf prog
>>> should expect anything useful in the original __user optval? Other than
>>> unnecessary copy for other common cases, it looks like a bad api, so
>>> consider it a NAK.
>>>
>>>>
>>>>>
>>>>> and there is no selftest also.
>>>>>
>>>>
>>>> Yes, if remove this restriction, everyone thinks it's ok, I'll add it
>>>> in the next version.
>>>>
>>>>>> +        ret = -EFAULT;
>>>>>> +        goto out;
>>>>>>        }
>>>>>>        lock_sock(sk);
>>>>>
>>>>
>>>
>>
>> According to my understanding, users will have such requirements,
>> customize an optname, which is not available in the kernel. All logic is
>> completed in bpf prog, and bpf prog needs to obtain the user data passed
>> in by the system call, and then return the data required by the user
>> according to this data.
>>
>> For optname not in the kernel, the error code is
>> #define ENOPROTOOPT 92/* Protocol not available */
>> Whether to consider the way of judging with error codes,
>> If (! retval | | retval == -ENOPROTOOPT)
> 
> I'm also failing to see what you're trying to do here. You can already
> implement custom optnames via getsockopt, so what's missing?
> If you need to pass some data from the userspace to the hook, then
> setsockopt hook will serve you better.
> getsockopt is about reading something from the kernel/bpf; ignoring
> initial user buffer value is somewhat implied here.

Thanks, you reminded me that can pass data to bpf prog by setsockopt.



