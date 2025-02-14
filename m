Return-Path: <bpf+bounces-51626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9F3A3692D
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 00:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066411893DEA
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 23:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D9C1FDE0B;
	Fri, 14 Feb 2025 23:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gBeCBJyb"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF29F1FC7C5
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 23:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739576719; cv=none; b=iUn804sKGAZEY0M0yqg/Di9qT+sLCBwS9prduSbwZnZXBhZFpQXl4zgo3B4+24czrMYP4khI9LYVdjm29HiLx10FaIhGhyub+mX5zigePnnbkyW2ZiZpnifUf63cH7WpelOgxZri4eZ+CvoN8FT6JdJgUmAm2HogpEsyMyGNjOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739576719; c=relaxed/simple;
	bh=eJnlGiIFKX0kTrmBW81BBvK9y5Lnvi1/VnIPm5zRaFI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FE2AUirv3ijgWdHeEvoNjA6DsZzYhYPA8B3Rpoe0xpyUiN4REe3XMHqEs680BfqgJxl/BfACg2PACf4JICrNGWDdIzjhkvXh5ztczZBPWgKB1fiiajDC4xL4d1g7MEOe/gq/BH6LBbohFJpcIA6C0X/WMLMLdAVKccZMQO7Gq88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gBeCBJyb; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3dab11ad-5cba-486f-a429-575433a719dc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739576703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCv2WEDpsdXaZn/vUqoQMgt2vJwHfBc+e4BMlG/vF54=;
	b=gBeCBJyb6Q0Bk4d4hgs2Hi4YinW3em++zOKOyxC0vQ9jGboDMRuPHHWVFRu7clbZB2MCfq
	c5sxEkEcB9TgfFtjHOJ00PMVBSmo28V7GEsZhx32WMGorWLnIbzksrXaPk2tsTD/Hehhoe
	BwtpAIoXnJIXkFIDIYMdyXfkYJ+TkSI=
Date: Fri, 14 Feb 2025 15:44:53 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
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
 <b3f30f7d-e0c3-4064-b27e-6e9a18b90076@linux.dev>
 <CAL+tcoB2EO_FJis4wp7WkMdEZQyftwuG2X6z0UrJEFaYnSocNg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAL+tcoB2EO_FJis4wp7WkMdEZQyftwuG2X6z0UrJEFaYnSocNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/13/25 10:56 PM, Jason Xing wrote:
> On Fri, Feb 14, 2025 at 2:40 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 2/13/25 10:12 PM, Jason Xing wrote:
>>> On Fri, Feb 14, 2025 at 1:41 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> On 2/13/25 7:09 PM, Jason Xing wrote:
>>>>> On Fri, Feb 14, 2025 at 10:14 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>>>
>>>>>> On 2/13/25 3:57 PM, Jason Xing wrote:
>>>>>>> On Fri, Feb 14, 2025 at 7:41 AM Stanislav Fomichev<stfomichev@gmail.com> wrote:
>>>>>>>> On 02/13, Jason Xing wrote:
>>>>>>>>> Support bpf_setsockopt() to set the maximum value of RTO for
>>>>>>>>> BPF program.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Jason Xing<kerneljasonxing@gmail.com>
>>>>>>>>> ---
>>>>>>>>>      Documentation/networking/ip-sysctl.rst | 3 ++-
>>>>>>>>>      include/uapi/linux/bpf.h               | 2 ++
>>>>>>>>>      net/core/filter.c                      | 6 ++++++
>>>>>>>>>      tools/include/uapi/linux/bpf.h         | 2 ++
>>>>>>>>>      4 files changed, 12 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
>>>>>>>>> index 054561f8dcae..78eb0959438a 100644
>>>>>>>>> --- a/Documentation/networking/ip-sysctl.rst
>>>>>>>>> +++ b/Documentation/networking/ip-sysctl.rst
>>>>>>>>> @@ -1241,7 +1241,8 @@ tcp_rto_min_us - INTEGER
>>>>>>>>>
>>>>>>>>>      tcp_rto_max_ms - INTEGER
>>>>>>>>>           Maximal TCP retransmission timeout (in ms).
>>>>>>>>> -     Note that TCP_RTO_MAX_MS socket option has higher precedence.
>>>>>>>>> +     Note that TCP_BPF_RTO_MAX and TCP_RTO_MAX_MS socket option have the
>>>>>>>>> +     higher precedence for configuring this setting.
>>>>>>>> The cover letter needs more explanation about the motivation.
>>>>>>
>>>>>> +1
>>>>>>
>>>>>> I haven't looked at the patches. The cover letter has no word on the use case.
>>>>
>>>> The question was your _use case_ in bpf. Not what the TCP_RTO_MAX_MS does. Your
>>>> current use case is to have bpf setting it after reading the tcp header option,
>>>> like the selftest in patch 3?
>>>
>>> Oops, I misunderstood the real situation of the tcp header option
>>> test. My intention is to bpf_setsockopt() just like setget_sockopt
>>> does.
>>>
>>> Thanks for reminding me. I will totally remove the header test in the
>>> next version.
>>
>> If your use case was in the header, it is ok although it won't be the first
> 
> I was planning to add a simple test to only see if the rto max for bpf
> feature works, so I found the rto min selftests and then did a similar
> one.
> 
>> useful place I have in my mind. Regardless, it is useful to say a few words
>> where you are planning to set it in the bpf. During a cb in sockops or during
>> socket create ...etc. Without it, we can only guess from the selftest :(
> 
> I see your point. After evaluating and comparing those two tests, I
> think the setsock_opt is a better place to go. Do we even apply the
> use of rto min to setsock_opt as well?
> 
> What do you think?

Adding to sol_tcp_tests[] as Kuniyuki suggested should be the straight forward way.

Please still describe how you are going to use it in bpf in the cover letter.

> 
>>
>>>
>>>>
>>>>>
>>>>> I will add and copy some words from Eric's patch series :)
>>>>
>>>>
>>>>>>> I am targeting the net-next tree because of recent changes[1] made by
>>>>>>> Eric. It probably hasn't merged into the bpf-next tree.
>>>>>>
>>>>>> There is the bpf-next/net tree. It should have the needed changes.
>>>>>
>>>>> [1] was recently merged in the net-next tree, so the only one branch I
>>>>> can target is net-next.
>>>>>
>>>>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=ae9b3c0e79bc
>>>>>
>>>>> Am I missing something?
>>>>
>>>> There is a net branch:
>>                 ^^^
>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
>>>
>>> But this branch hasn't included the rto max feature. I was trying to
>>
>> Which branch? I was talking about the **net** branch. Not the master branch. Try
>> to pull again if your local copy does not have it. The net branch should have
>> the TCP_RTO_MAX_MS patches.
> 
> Oh, I always use the master branch, never heard of net branch. You're
> right, I checked out the net branch and then found it. Thanks.
> 
> One more thing I have to ask in advance is that in this case what the
> title looks like? [patch bpf] or [patch bpf net]?

[PATCH bpf-next]


