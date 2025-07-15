Return-Path: <bpf+bounces-63279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 166BAB04CCB
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 02:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE641AA1755
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 00:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F95E1552FA;
	Tue, 15 Jul 2025 00:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="G1FHzJlm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42C510E3
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 00:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752539185; cv=none; b=hxqnA4pGtqODBUNOYHRbXkoD/AppttEd5/bD1SKYPZx2+aIa7iTXSil6HJXCr2+dMI+HuthUVN35rDVRwJGOanfAiVmcuaVU2KAt9XgJGKZwQ39aSjFyvY3iIrFdDYvVGLHieGLa9IPXC5KdNj+jCt3JPluqnjlS84hUoa0kypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752539185; c=relaxed/simple;
	bh=LiV8jHKcIjJme1/D5vj/00XvOEmMQMptlJ6ONy5ps8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQTChx+U8mjh5rwQo0eOvS0NUTV5R9GfG/WcGIManOe6Qvq6Df+tBYaoGGDxPuLfsALREfK0YPyr6lRP2rxYbPjllGM8LNx6gbCvQed5PS2mzH2hEeXlUHiMqt+bd1Bc3jj7k+muxG6bY+Jrdp096HHb5ps0Zc06nzv9sG1uWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=G1FHzJlm; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fadb9a0325so43795846d6.2
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 17:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752539182; x=1753143982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Mlpwfj3URCo7lhI788Fsy/bl58+0MG3EEAGnhLZHaE=;
        b=G1FHzJlmUFib2oeWagMri3DgmAng4+2A0ymNEFXcjIX3Jo471oWRZ8JKAvUZb8qq4r
         vL7Lviyu1euxl3a7dr8PGxyK8zvPqyr6yCjmX01pMMRQFExU8d1u465Exde1pUOQXqDx
         JpNbbNrpbuP1KkMezl373b5labnd0OeIaP2nJontdKbMp6ZQvA9hNzdgCGSqUB8UxeEb
         g4tPwwLjpPKagdkb7p3kKrmj327+uscM8o2xq1Z8M9a1SJmil2HQ/AIIOycGlZxsS9nh
         euhcieJuzKBEEe04s7orvxCPfKKl7r3z3x5CF8WKJ8ud39cyipyI5u5olFzdLzHAFesL
         FeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752539182; x=1753143982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Mlpwfj3URCo7lhI788Fsy/bl58+0MG3EEAGnhLZHaE=;
        b=kzMjGmZgQHHHWn9a8GMisPr4DdfACOEEm+WCBPtcx1ExjCAT14nmN+C6b0nZ1e7FWJ
         6spf4c43rY5KLtvZpPI6J6CPCpD8R1yGPANp5Lo4XrkiSH8pcJfmxsS+o2xekxBXJR8K
         aUkVpAFLPBBg8ek69FTTIifmOJd2tmIqhAO+uSy+FO8fS7o0llV9MfnbH4QhNKfdkOci
         b33270FtcHqfwDpEoqMZHNGeLqWYfYaCSq2Q6uOHwRoTZuymMAf+Cv1clO/8Ue8jREDO
         N6mREIiN9Km3rSQLi2oj1GKGSKBDdpwggKIrXL3/0vmkDbqc13paPdnhFcNhvIREhA13
         5Bdg==
X-Forwarded-Encrypted: i=1; AJvYcCV9s5lQrXLd2Ah1oArcvk5EhJzyuc6b7RuKWLkom1eX+k2qvj/7Z506xkE1Qh72AP86PSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLjjMEW8B+0jte03KV8OvqQQPnNTOIOUPTL55v+5N+6WfHCRQv
	8QdviMM1JfkogiUlhNwsZ35ShxHcUYjBpd2HJcft9nBhd3ZSMFvwT3ossE0CIrZrVZQ=
X-Gm-Gg: ASbGncsDQpTi/PUlha3PexIw3VJ0n5jRlPscklCQBFYFVpkzsAvJajbFmDbBhAPjVJH
	a0BHivw2DsAYG2nJg8SY+d3YLrgEAdABH3L3KD/IgONUaHdSpeov/WHhZPQ7U90WeQIr69DoLhD
	utpDD65/qa15tC5L06Xz2CcCrt3O6x/Mlr8uNkVQh8sCxJxTN+29eff3Ca0Uk0D0+jRnzD1yjEo
	4icXedK6ILBUsO5luvlBuT+Ttc2AvvjpeL4N0GeaT/WbdjibTc0vb3uc9MyA10NDxpDkvZzTARV
	3UUDUQwZAgPvdjoI5m6vBN5BE3FfVym3yJXDyBdgL/rfVLo2KnujamKMwrIPdMCGY/Nyczy3x5I
	yPtrqPP4Bo8eXtAal569esMVcvVIhSD6GxxTJK3YtTYnhqUc=
X-Google-Smtp-Source: AGHT+IGq5NuM2gYxO5y5Q/ZrhH0BxEUoJ3LwVIlugtZFybZHtEhx2FKOOI4VDSQ3wT6tdREu1nnDrA==
X-Received: by 2002:a05:6214:1cc3:b0:702:c15f:3291 with SMTP id 6a1803df08f44-704a38b3207mr273136436d6.22.1752539182318;
        Mon, 14 Jul 2025 17:26:22 -0700 (PDT)
Received: from [10.73.214.168] ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d5d5absm52458586d6.83.2025.07.14.17.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 17:26:21 -0700 (PDT)
Message-ID: <755110eb-9dea-4df6-b207-21bc06491498@bytedance.com>
Date: Mon, 14 Jul 2025 17:26:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch bpf-next v4 4/4] tcp_bpf: improve ingress redirection
 performance with message corking
To: Jakub Sitnicki <jakub@cloudflare.com>,
 Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, john.fastabend@gmail.com,
 zhoufeng.zf@bytedance.com, Amery Hung <amery.hung@bytedance.com>,
 Cong Wang <cong.wang@bytedance.com>
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
 <20250701011201.235392-5-xiyou.wangcong@gmail.com>
 <87ecuyn5x2.fsf@cloudflare.com>
 <509939c4-2e3e-41a6-888f-cbbf6d4c93cb@bytedance.com>
 <87a55lmrwn.fsf@cloudflare.com> <aGdWhRi/0KLTFL8k@pop-os.localdomain>
 <87cyabhotr.fsf@cloudflare.com>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <87cyabhotr.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 1:51 AM, Jakub Sitnicki wrote:
> On Thu, Jul 03, 2025 at 09:20 PM -07, Cong Wang wrote:
>> On Thu, Jul 03, 2025 at 01:32:08PM +0200, Jakub Sitnicki wrote:
>>> I'm all for reaping the benefits of batching, but I'm not thrilled about
>>> having a backlog worker on the path. The one we have on the sk_skb path
>>> has been a bottleneck:
>>
>> It depends on what you compare with. If you compare it with vanilla
>> TCP_BPF, we did see is 5% latency increase. If you compare it with
>> regular TCP, it is still much better. Our goal is to make Cillium's
>> sockops-enable competitive with regular TCP, hence we compare it with
>> regular TCP.
>>
>> I hope this makes sense to you. Sorry if this was not clear in our cover
>> letter.
> 
> Latency-wise I think we should be comparing sk_msg send-to-local against
> UDS rather than full-stack TCP.
> 
> There is quite a bit of guessing on my side as to what you're looking
> for because the cover letter doesn't say much about the use case.
> 

Let me add more details to the use cases,

Assume user space code uses TCP to connect to a peer which may be
local or remote. We are trying to use sockmap to transparently
accelerate the TCP connection where both the sender and the receiver are
on the same machine. User space code does not need to be modified, local
connections will be accelerated, remote connections remain the same.
Because of the transparency here, UDS is not an option here. UDS
requires user-space code change, and it means users know they are
talking to local peer.

We assume that since we bypass the Linux network stack, better tput,
latency and cpu usage will be observed. However, it's not ths case, tput
is worse when the message size is small (<64k).

It's similar to cilium "sockops-enable" config, which is deprecated
mostly because of performance. The config uses sockmap to manage the
TCP connection between pods in the same machine.

https://github.com/cilium/cilium/blob/v1.11.4/bpf/sockops/bpf_sockops.c

> For instance, do you control the sender?  Why not do big writes on the
> sender side if raw throughput is what you care about?
> 

As described above, we assume user space uses TCP, and we cannot change
the user space code.

>>> 1) There's no backpressure propagation so you can have a backlog
>>> build-up. One thing to check is what happens if the receiver closes its
>>> window.
>>
>> Right, I am sure there are still a lot of optimizations we can further
>> improve. The only question is how much we need for now. How about
>> optimizing it one step each time? :)
> 
> This is introducing a quite a bit complexity from the start. I'd like to
> least explore if it can be done in a simpler fashion before committing to
> it.
> 
> You point at wake-ups as being the throughput killer. As an alternative,
> can we wake up the receiver conditionally? That is only if the receiver
> has made progress since on the queue since the last notification. This
> could also be a form of wakeup moderation.
> 

wake-up is indeed one of the throughput killer, and I agree it can be
mitigated by waking up the receiver conditionally.

IIRC, sock lock is another __main__ throughput killer,
In the tcp_bpf_sendmsg, the context of sender process,
we need to lock_sock(sender) -> release_sock(sender) -> lock_sock(recv)
-> release_sock(recv) -> lock_sock(sender) -> release_sock(sender).

This makes the sender somewhat dependent to the receiver, when the 
receiver is working, the sender will be blocked.

    sender                      receiver
tcp_bpf_sendmsg
                            tcp_bpf_recvmsg (working)
tcp_bpf_sendmsg (blocked)


We introduce kworker here mainly to solve the sock lock issue, we want
to have senders only need to acquire sender sock lock, receivers only
need to acquire receiver sock lock. Only the kworker, as a middle man,
needs to have both sender and receiver lock to transfer the data from
the sender to the receiver. As a result, tcp_bpf_sendmsg and
tcp_bpf_recvmsg can be independent to each other.

    sender                      receiver
tcp_bpf_sendmsg
                            tcp_bpf_recvmsg (working)
tcp_bpf_sendmsg
tcp_bpf_sendmsg
...

>>> 2) There's a scheduling latency. That's why the performance of splicing
>>> sockets with sockmap (ingress-to-egress) looks bleak [1].
>>
>> Same for regular TCP, we have to wakeup the receiver/worker. But I may
>> misunderstand this point?
> 
> What I meant is that, in the pessimistic case, to deliver a message we
> now have to go through two wakeups:
> 
> sender -wakeup-> kworker -wakeup-> receiver
> 
>>> So I have to dig deeper...
>>>
>>> Have you considered and/or evaluated any alternative designs? For
>>> instance, what stops us from having an auto-corking / coalescing
>>> strategy on the sender side?
>>
>> Auto corking _may_ be not as easy as TCP, since essentially we have no
>> protocol here, just a pure socket layer.
> 
> You're right. We don't have a flush signal for auto-corking on the
> sender side with sk_msg's.
> 
> What about what I mentioned above - can we moderate the wakeups based on
> receiver making progress? Does that sound feasible to you?
> 
> Thanks,
> -jkbs


