Return-Path: <bpf+bounces-51529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0EBA3574A
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 07:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903C516EA58
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 06:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D0D202C4C;
	Fri, 14 Feb 2025 06:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eDyUEOLp"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BE620103A
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739515254; cv=none; b=aXIooEc9AMMn95HEFINSMVFRAWpgao8Q2BhcRS/gPjK2nEhwApqh9k04oVq5vvnX0StKSqqcO/Ic2+mRpWcQCJIasGrVVwt7XYSIu2xpfhfhFh8wa52+WVxD+ULnpFIvu50rMGftxu0+oeaArHy2R+CQ1fecu/5tRrrfFDTSnDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739515254; c=relaxed/simple;
	bh=gQkZOhHkkoJQgcml6XH6gn2rZuZrtBkjv+qrfFXtv5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1hLat19ityipMA5IXgXf7Hm1BD92SvhstxoUWEbuHzoD28sGNBcyF2MIKq/A9kNEnIgXr0ifWk01Ii5d56jAsVbYU+A0QqR+UDjq3kP8buqZ+NUNqV2tlUGr0GeCbQ7FSGR1mb+zDWHGQsWNyl3AiJzPd7odE+pdus1weSpo5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eDyUEOLp; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b3f30f7d-e0c3-4064-b27e-6e9a18b90076@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739515249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hznrz1rqasWSZGNDFCigviZ3D5CcsvUofn3aGepH9iw=;
	b=eDyUEOLpoioJCv3rRUrFR4tGi/uYARog1RoLgsCPOWr/yDgazDO/hKSA7rmCQrlnNwQDxI
	9zjQsn15Hduz467b77nXCDEi5uBKOseliaj0AyuIENwvMIwRZiVRArFMqqSw+c7lhzJ9Gm
	7ZLFS2HR1fg38yPObezZhNOz3g3ASWA=
Date: Thu, 13 Feb 2025 22:40:43 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/3] bpf: add TCP_BPF_RTO_MAX for bpf_setsockopt
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 horms@kernel.org, ncardwell@google.com, kuniyu@amazon.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250213004355.38918-1-kerneljasonxing@gmail.com>
 <20250213004355.38918-3-kerneljasonxing@gmail.com>
 <Z66DL7uda3fwNQfH@mini-arch>
 <CAL+tcoATv6HX5G6wOrquGyyj8C7bFgRZNnWBwnPTKD1gb4ZD=g@mail.gmail.com>
 <039bfa0d-3d61-488e-9205-bef39499db6e@linux.dev>
 <CAL+tcoBAv5QuGeiGYUakhxBwVEsut7Gaa-96YOH03h57jtTVaQ@mail.gmail.com>
 <86453e67-d5dc-4565-bdd6-6383273ed819@linux.dev>
 <CAL+tcoApvV0vyiTKdaMWMp8F=ZWSodUg0zD+eq_F6kp=oh=hmA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoApvV0vyiTKdaMWMp8F=ZWSodUg0zD+eq_F6kp=oh=hmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/13/25 10:12 PM, Jason Xing wrote:
> On Fri, Feb 14, 2025 at 1:41 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 2/13/25 7:09 PM, Jason Xing wrote:
>>> On Fri, Feb 14, 2025 at 10:14 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> On 2/13/25 3:57 PM, Jason Xing wrote:
>>>>> On Fri, Feb 14, 2025 at 7:41 AM Stanislav Fomichev<stfomichev@gmail.com> wrote:
>>>>>> On 02/13, Jason Xing wrote:
>>>>>>> Support bpf_setsockopt() to set the maximum value of RTO for
>>>>>>> BPF program.
>>>>>>>
>>>>>>> Signed-off-by: Jason Xing<kerneljasonxing@gmail.com>
>>>>>>> ---
>>>>>>>     Documentation/networking/ip-sysctl.rst | 3 ++-
>>>>>>>     include/uapi/linux/bpf.h               | 2 ++
>>>>>>>     net/core/filter.c                      | 6 ++++++
>>>>>>>     tools/include/uapi/linux/bpf.h         | 2 ++
>>>>>>>     4 files changed, 12 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
>>>>>>> index 054561f8dcae..78eb0959438a 100644
>>>>>>> --- a/Documentation/networking/ip-sysctl.rst
>>>>>>> +++ b/Documentation/networking/ip-sysctl.rst
>>>>>>> @@ -1241,7 +1241,8 @@ tcp_rto_min_us - INTEGER
>>>>>>>
>>>>>>>     tcp_rto_max_ms - INTEGER
>>>>>>>          Maximal TCP retransmission timeout (in ms).
>>>>>>> -     Note that TCP_RTO_MAX_MS socket option has higher precedence.
>>>>>>> +     Note that TCP_BPF_RTO_MAX and TCP_RTO_MAX_MS socket option have the
>>>>>>> +     higher precedence for configuring this setting.
>>>>>> The cover letter needs more explanation about the motivation.
>>>>
>>>> +1
>>>>
>>>> I haven't looked at the patches. The cover letter has no word on the use case.
>>
>> The question was your _use case_ in bpf. Not what the TCP_RTO_MAX_MS does. Your
>> current use case is to have bpf setting it after reading the tcp header option,
>> like the selftest in patch 3?
> 
> Oops, I misunderstood the real situation of the tcp header option
> test. My intention is to bpf_setsockopt() just like setget_sockopt
> does.
> 
> Thanks for reminding me. I will totally remove the header test in the
> next version.

If your use case was in the header, it is ok although it won't be the first 
useful place I have in my mind. Regardless, it is useful to say a few words 
where you are planning to set it in the bpf. During a cb in sockops or during 
socket create ...etc. Without it, we can only guess from the selftest :(

> 
>>
>>>
>>> I will add and copy some words from Eric's patch series :)
>>
>>
>>>>> I am targeting the net-next tree because of recent changes[1] made by
>>>>> Eric. It probably hasn't merged into the bpf-next tree.
>>>>
>>>> There is the bpf-next/net tree. It should have the needed changes.
>>>
>>> [1] was recently merged in the net-next tree, so the only one branch I
>>> can target is net-next.
>>>
>>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=ae9b3c0e79bc
>>>
>>> Am I missing something?
>>
>> There is a net branch:
               ^^^

>> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> 
> But this branch hasn't included the rto max feature. I was trying to

Which branch? I was talking about the **net** branch. Not the master branch. Try 
to pull again if your local copy does not have it. The net branch should have 
the TCP_RTO_MAX_MS patches.

> say that what I wrote is based on the rto max feature which only
> exists in the net-next tree for now.
> 



