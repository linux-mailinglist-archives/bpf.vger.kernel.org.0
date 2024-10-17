Return-Path: <bpf+bounces-42334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A339A2EFF
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 22:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B41DB24014
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7383DAC07;
	Thu, 17 Oct 2024 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TMifkkxV"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D552296E8
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729197820; cv=none; b=RCC9qHFlO0V6xkbefwpxaAVO4AbFebva/5SS1NkC3Mq3Uj4yig0OOduLhtmLEOan987iKb1bV+s6Wt/40KOqIB6xDQQGe0t5KClbkoo2v4Cf1dfHyi4Dp/OV28Ld3eYMelvjosdTKlB3pKyy8qEL2cpA5/016Dn7rlc7RppoSNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729197820; c=relaxed/simple;
	bh=tMm7xy8L2IkmHQdL1eD1YWOFVRhjX3YAFqy4Ta9wKUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJT7PceFYxipWh8SLwQJ0YdRto4/MqCbCtb/ndfPTjU4e2dfXULjIZ9uHjQkeb2ZcbNCAdLM/3UkdHwWWxgnaXVWCfvVfUNAWlJx1/kr7dX5AbW8+MY8qLcbywX8tEOBpKe42SPNFVP+mRE1Kocbcvc2/WP6u+zfMOYrWo5/WI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TMifkkxV; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <95f10d3d-8bed-46ea-852c-791592e67070@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729197812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/GWZGVpgNnNX+/6bs8uzatYA7LCL+Ql1FgsqDg2sAZ8=;
	b=TMifkkxVZTi97W4TXAh0KEliihPUvQ6pFLuMjzoNnl5AZR5Y6Ye7uxUVLvU+mFubvVTUIp
	jEiI/gJKLUSMF5ZCCHhi5YD0SLkYshtDk0nXpoxJkmylQio354CpTYevhuKmgDx9DlNJeD
	3V6ERlTNELY3OqzLiTEd+TpkLBByUsc=
Date: Thu, 17 Oct 2024 13:43:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 04/12] net-timestamp: add static key to
 control the whole bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 willemdebruijn.kernel@gmail.com, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com>
 <dbddb085-183e-47bf-8bc7-ec6eac4d877f@linux.dev>
 <CAL+tcoBieZ3_ZX3PRY8k7-C6Rv2g=Mr1U1NAQkQpbHYYvtWpTQ@mail.gmail.com>
 <CAL+tcoBXj=EO-sk-dS+dN-pCZf8OKeOZ4LXb9GZnja3EfOhXYg@mail.gmail.com>
 <9f050a5c-644f-4fbb-ac37-53edfd160edc@linux.dev>
 <CAL+tcoDyt=3hjwdx8Wk-abKg=qQsY=7UKu9=TU4iUAk5gMT2MQ@mail.gmail.com>
 <5398c020-e9b4-49d2-a5fa-dca047296ddd@linux.dev>
 <CAL+tcoDb84bgUUpK9PjijWDt+xw=u2nKkoWf1Gjvkjf--XJ6VA@mail.gmail.com>
 <c669769f-8437-46cc-95b4-d3f84c1c95b7@linux.dev>
 <CAL+tcoD-fzq7dSwkM4nRE8vF-y=+RO1y8X=95+D8Gv3QXTRWCA@mail.gmail.com>
 <095d241a-44d5-461f-8d64-356676a44e8b@linux.dev>
 <CAL+tcoDKuomdJVYo6FVNH60NojYRNp3zjNyt8Tr8Od1Fp2BfWA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoDKuomdJVYo6FVNH60NojYRNp3zjNyt8Tr8Od1Fp2BfWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/16/24 7:28 PM, Jason Xing wrote:
> On Thu, Oct 17, 2024 at 8:48 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 10/16/24 3:36 AM, Jason Xing wrote:
>>>>> If the skb carries the timestamp, there are three cases:
>>>>> 1) non-bpf case and users uses setsockopt()
>>>>> 2) cmsg case
>>>>> 3) bpf case
>>
>> These should have tests in the selftests/bpf/ sooner than later. (More below).
>>
>>>>>
>>>>> #1 and #2 are already handled well before this patch. I only need to
>>>>> test if sk_tsflags_bpf has those flags. If so, it means we hit #3, or
>>>>> else it could be #1 or #2, then we will let the old way print
>>>>> timestamps in __skb_tstamp_tx().
>>>>
>>>> hmm... I am still not sure I fully understand...but I think I may start getting it.
>>>
>>> Sorry, my bad. I gave the wrong answer...
>>>
>>> It should be:
>>> Testing if if sk_tsflags has SOF_TIMESTAMPING_SOFTWARE flag should
>>
>> You meant adding SOF_TIMESTAMPING_SOFTWARE test to the sk_tstamp_tx_flags()?
> 
> Yep.
> 
>>
>> Before any bpf changes, if I read __skb_tstamp_tx() correctly, the current
>> behavior is to just queue to the sk_error_queue as long as there is
>> "SOF_TIMESTAMPING_TX_*" set in the skb's tx_flags and it is regardless of the
>> sk_tsflags. This will eventually get ignored when user read it from the error
>> queue because the SOF_TIMESTAMPING_SOFTWARE is not set in sk_tsflags?
> 
> Totally correct. SOF_TIMESTAMPING_SOFTWARE is a report flag while
> SOF_TIMESTAMPING_TX_* are generation flags. Without former, users can
> read the skb from the errqueue but are not able to parse the
> timestamps. Please see
> tcp_recvmsg()->inet_recv_error()->ip_recv_error()->sock_recv_timestamp()->__sock_recv_timestamp():
> if ((tsflags & SOF_TIMESTAMPING_SOFTWARE...
>         ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))

afaict, __sock_recv_timestamp does not put the timestamp cmsg but ip_recv_error 
still returns the skb to the user.

I suspect we are talking the same thing. When SOF_TIMESTAMPING_SOFTWARE is not 
set in sk and SOF_TIMESTAMPING_TX_* is set in cmsg, the existing (aka 
traditional) way is that the generated skb will still be queued in the error 
queue. The user space can still read it but just won't have the timestamp cmsg.

If I understand how the v3 may look like, the skb will not be queued in the 
error queue at all because the sk has no SOF_TIMESTAMPING_SOFTWARE. The user 
space won't get it from the error queue which is a change of behavior. I was 
saying I am fine but not sure if someone depends on this behavior.

I think we start talking pass each other on this. I will wait for the code on 
this part and the selftest first.

> 
>> I suspect
>> the user space will still read something from the error queue unless there is
>> SOF_TIMESTAMPING_OPT_TSONLY but it won't have the tstamp cmsg.
> 
> No, please see above.
> 
>>
>> Adding SOF_TIMESTAMPING_SOFTWARE test to the sk_tstamp_tx_flags() will stop it
>> from even queuing to the error queue? I think it is ok but I am not sure if
>> anyone is depending on the above behavior.
> 
> SOF_TIMESTAMPING_SOFTWARE is only used in traditional SO_TIMESTAMPING

Got it. This part is now understood.

It is one of the reasons for my earlier question on which SOF_* that bpf needs 
to support. I want to simplify the naming part of the SOF_* in bpf_sesockopt but 
lets leave these nits for a little later.

However, it will be very useful to highlight which SOF_* will never be used in 
bpf in v3.

> features including cmsg mode. But it will not be used in bpf mode. So
> the test statement is enough to divided those three cases into two
> groups.

> 
>>
>>> work fine. If it has the flag, we could use skb_tstamp_tx_output() to
>>> print based on patch [4/12]; if not, we will use
>>> bpf_skb_tstamp_tx_output() to print.
>>>
>>> If users use traditional ways of deploying SO_TIMESTAMPING, sk_tsflags
>>> always has SOF_TIMESTAMPING_SOFTWARE which is a software report flag
>>> (please see Documentation/networking/timestamping.rst). We can see a
>>> good example on how to use in
>>> tools/testing/selftests/net/txtimestamp.c:
>>> do_test()
>>> {
>>>           sock_opt = SOF_TIMESTAMPING_SOFTWARE |
>>>           ...
>>>           if (setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING,
>>>                                 (char *) &sock_opt, sizeof(sock_opt)))
>>> }
>>>
>>>>
>>>> Is it the reason that the bpf_setsockopt() cannot clear the sk_tsflags_bpf once
>>>> it is set in patch 2? It is not a usable api tbh. It will be a surprise to many.
>>>> It has to be able to set and clear.
>>>
>>> I cannot find a good time to clear all the sockets which are set
>>> through the BPF program. If we detach the BPF program, it will not
>>> print of course. Does it really matter if we don't clear the
>>> sk_tsflags_bpf?
>>
>> Yes, it matters. The same reason goes for why the existing bpf prog can clear
>> the tp->bpf_sock_ops_cb_flags. Yes, detach will automatically not taking the
>> timestamp. For sockops program that stays forever, not all usages expect to do
>> timestamping for the whole lifetime of the connection. If there is a way for the
>> prog to turn it on, it should have a way for the prog to turn it off.
> 
> I see what you meant here. If we don't clear sk_tsflags_bpf, after we
> detach the bpf program, it will do nothing in __skb_tstamp_tx() and
> return earlier. It is almost equal to the effect of turning off. It is
> why I don't handle clearing the flag.
> 
>>
>> What is the concern of allowing the bpf prog to disable something that it has
>> enabled before?
> 
> Let me give one instance:
> If one socket is established and stays idle, how can the bpf program
> clear the tsflags from that socket? I have no idea.

bpf_tcp_iter prog can. That said, the idle connection example is too carry away 
as an excuse that bpf_setsockopt does not need to support turning-off. Sure, 
idle connection is as good as off. and yes, detach is as good as off also.

I am now acting as a broken clock repeating myself that not all use cases run 
for 5 mins and then detach, so I need to be specific here that bpf_setsockopt 
not supporting off is a nack. There are many use cases in production that the 
bpf prog runs forever and wants to turn it on-and-off.

Again, bpf sockops prog is not the only one can bpf_setsockopt(). bpf-tcp-cc 
that runs forever can also bpf_setsockopt to ask the sockops bpf prog to do 
periodic timestamping when needed. bpf_tcp_iter can also bpf_setsockopt to turn 
it off if needed.

I am not asking to clear the sk_tsflags_bpf when the bpf prog is detached. I am 
asking to support clearing the sk_tsflags_bpf in bpf_setsockopt().

I have still yet heard a technical reason why bpf_setsockopt cannot clear the bits.

> 
>>
>> While we are on bpf_sock_ops_cb_flags, the
>> BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG addition is mostly a dup of whatever in
>> the new sk_tsflags_bpf. It is something we need to clean up later when we decide
>> what interface to use for bpf timestamping.
> 
> I'm not sure if I understand correctly. I mimicked the use of
> BPF_SOCK_OPS_RTO_CB_FLAG. Do you mean we can remove the use of
> bpf_sock_ops_cb_flags_set() in BPF program?

In patch 5, I meant the BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG is redundant. 
It is as good as testing and setting sk_tsflags_bpf alone.

This could be some cleanup for the later stage of the set.

 > >>
>>>
>>>>
>>>> Does it also mean either the bpf or the user space can enable the timetstamping
>>>> but not both? I don't think we can assume this also. It will be hard to deploy
>>>> the bpf prog in production to collect continuous data. The user space may have
>>>> some timestamping enabled but the bpf may want to do its parallel investigation
>>>> also. The user space may rollout timestamping in the future and suddenly break
>>>> the bpf prog.
>>>
>>> Well, IIUC, it's also the basic idea from the current series which
>>> allows both happening at the same time. Let us put it in a simple way,
>>> I hope that if the app uses the SO_TIMESTAMPING feature already, then
>>> one admin deploys the BPF program, that app should be traced both in
>>> bpf and non-bpf ways.
>>>
>>> But Willem doesn't agree about this approach[1] because of hard to debug.
>>>
>>> [1]: https://lore.kernel.org/all/670dda9437147_2e6c4029461@willemb.c.googlers.com.notmuch/
>>> Regarding to this link, I have a few more words to say: the socket
>>> could be set through bpf_setsockopt() in different phases not like
>>> setsockopt(), so in some cases we cannot make setsockopt hard failed.
>>>
>>> After rethinking this point more, I still reckon that letting BPF
>>> program trace timestamping parallelly without caring whether the
>>> socket is set to the SO_TIMESTAMPING feature through setsockopt()
>>
>> I am afraid having both work in parallel is needed. Otherwise, it will be very
>> hard to deploy a bpf prog to run continuously in scale. Being able to collect
>> timestamp without worrying about application changes/updates/downgrades is
>> important. e.g. App changes from no time stamping to time stamping
> 
> Sorry, I didn't make myself clear. Yesterday, I said I agreed with you
> :) So let me keep the current logic of printing (see the
> __skb_tstamp_tx() function in patch [04/12]) in the next version. Then
> I don't need to add some test statements to distinguish which way of
> printing.
> 
>>
>> Please help to add selftests to show how the above cases (1), (2), (3), and
>> other tsflags/txflags sharing cases will work. This should not be delayed until
>> the discussion is done. It is needed sooner or later to prove both bpf and
>> non-bpf ways can work at the same time. It will help the reviewer and also help
>> to think about the design with a real use case in bpf prog.
> 
> Got it. But I'm not sure where I should put those test cases? Could
> you help me point out a good example that I can follow?

Have you looked at the selftests/bpf directory?

prog_tests/setget_sockopt.c may be something closer to what you need.

There is a recent one in the mailing list also:

https://lore.kernel.org/all/20241016-syncookie-v1-0-3b7a0de12153@bootlin.com/

The expectation is to be able to run the test like this: ./test_progs -t 
setget_sockopt

> 
>>
>> The example in patch 0 only prints the reported tstamp, can you share how it
>> will be used to investigate issue?
> 
> No problem. Please see chapter 3 about "goal" in
> https://netdev.bots.linux.dev/netconf/2024/jason_xing.pdf.

Thanks.

> 
>> Is it also useful to know when the skb is
>> written to the kernel during sendmsg()?
> 
> You are right. Before this patch, normally applications will record an
> accurate timestamp before do sendmsg().
> 
> After you remind me of this, I feel that we can add the timestamp
> print in the future for bpf use.

Yes, please add the sendmsg timestamp capturing in the selftest. It is useful.

> 
>>
>> Regarding the bpf_setsockopt() can be called in different phase,
>> bpf_setsockopt() is not limited to sockops program. e.g. it can also be called
>> from a bpf-tcp-cc (congestion control). Not a tcp-cc expert but I won't be
>> surprised people will try to trigger some on-and-off timestamping from
>> bpf-tcp-cc to measure some delay.
>>
>>
>> More about bpf_setsockopt() in different phase, understand that UDP is not your
>> priority. However, it needs to have some clarity on how UDP will work and how to
>> enable it. UDP usually has no connect/established phase.
> 
> For now, I don't expect an extension for UDP because it will bring too
> much extra work. Could we discuss this later? I mean, after we finish
> the basic bpf extension :)

Later is fine but before this set lands. I am not asking a full UDP 
implementation but need ideas on how that may look like. We need some clarity on 
how UDP will work and also how much new sockops API extension will be needed to 
decide if sockops is the correct one going forward. I don't want to end up tcp 
is in sockops and UDP (and others) is non sockops.

That said, the current priority is to get bpf prog and user space work without 
stepping on each other first.

> 
>>
>> Regarding the SOF_TIMESTAMPING_* support, can you list out what else you are
>> planning to support in the future. You mentioned the SOF_TIMESTAMPING_TX_ACK in
>> another thread. What else?
> 
> In this patch series, I support
> SOF_TIMESTAMPING_TX_SCHED|SOF_TIMESTAMPING_TX_ACK|SOF_TIMESTAMPING_TX_SOFTWARE,
> which you've already noticed from the BPF example in patch [0/12].
> They all come from the original design of SO_TIMESTAMPING feature.
> 
> The question you proposed is what I am willing to implement in the
> future, like adding one hook in tcp_write_xmit()? It's part of my
> plans to extend in the future, not be included in this series.


