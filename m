Return-Path: <bpf+bounces-42258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1239A1749
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 02:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F37B280C0B
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 00:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9437E17C68;
	Thu, 17 Oct 2024 00:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dC1VgyTC"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D0F17588
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 00:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729126117; cv=none; b=e8YBFnhb45UlzwtwQwsTNx31nHX0oYYN9AQYpNRGggAME+iwkwD5S/ydPDOu8WQgPljxuG+vR/KfXEMwh4zkpw9zlUzM5ZOYortCXsj9mOzH1kJtTjNltFtg1ekX7pw361vqItmhGqoK8EsUhZmS6zT5Pqd9x6M2t2iyBv8JVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729126117; c=relaxed/simple;
	bh=Q1Zyx8GG9SEmUQwxBdlocYMPPhSi+dNevB1/jCoZCD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pgvqudtjP0Dqg4zfW2iSL3WDsZo3KkB/OH+uaVThjAqDhgqaHbI9DJJVe+dnVOECwp+f/e54dawIQ7umL1U+qRd40D0MpyNCoh6lgIQeFPU9sWZNruNRlOVunUcFOvkwNy+xN+mqYl/clKqNnLCgODnXalCNqse6NT8k2ploRS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dC1VgyTC; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <095d241a-44d5-461f-8d64-356676a44e8b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729126108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3iL9evQOvPFUCNej+Y9UMpXM8GfQq85q1dwBovHgvB8=;
	b=dC1VgyTChjiqtDPCz+9JC5bdbOAKi+q6MdHEpjOFbWaE9gbb7XINkGvBaX4aJJQIgFX68j
	D1uSM/697PosxsGPzBpO3MkgN40wv/rzz5sFvEex08uMj+bNJfrZ4VPdUzignaBLoZ1dhU
	X7lUpQwm5t4zLNeCCw+NgSP4Bcs3dQU=
Date: Wed, 16 Oct 2024 17:48:20 -0700
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoD-fzq7dSwkM4nRE8vF-y=+RO1y8X=95+D8Gv3QXTRWCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/16/24 3:36 AM, Jason Xing wrote:
>>> If the skb carries the timestamp, there are three cases:
>>> 1) non-bpf case and users uses setsockopt()
>>> 2) cmsg case
>>> 3) bpf case

These should have tests in the selftests/bpf/ sooner than later. (More below).

>>>
>>> #1 and #2 are already handled well before this patch. I only need to
>>> test if sk_tsflags_bpf has those flags. If so, it means we hit #3, or
>>> else it could be #1 or #2, then we will let the old way print
>>> timestamps in __skb_tstamp_tx().
>>
>> hmm... I am still not sure I fully understand...but I think I may start getting it.
> 
> Sorry, my bad. I gave the wrong answer...
> 
> It should be:
> Testing if if sk_tsflags has SOF_TIMESTAMPING_SOFTWARE flag should

You meant adding SOF_TIMESTAMPING_SOFTWARE test to the sk_tstamp_tx_flags()?

Before any bpf changes, if I read __skb_tstamp_tx() correctly, the current 
behavior is to just queue to the sk_error_queue as long as there is 
"SOF_TIMESTAMPING_TX_*" set in the skb's tx_flags and it is regardless of the 
sk_tsflags. This will eventually get ignored when user read it from the error 
queue because the SOF_TIMESTAMPING_SOFTWARE is not set in sk_tsflags? I suspect 
the user space will still read something from the error queue unless there is 
SOF_TIMESTAMPING_OPT_TSONLY but it won't have the tstamp cmsg.

Adding SOF_TIMESTAMPING_SOFTWARE test to the sk_tstamp_tx_flags() will stop it 
from even queuing to the error queue? I think it is ok but I am not sure if 
anyone is depending on the above behavior.

> work fine. If it has the flag, we could use skb_tstamp_tx_output() to
> print based on patch [4/12]; if not, we will use
> bpf_skb_tstamp_tx_output() to print.
> 
> If users use traditional ways of deploying SO_TIMESTAMPING, sk_tsflags
> always has SOF_TIMESTAMPING_SOFTWARE which is a software report flag
> (please see Documentation/networking/timestamping.rst). We can see a
> good example on how to use in
> tools/testing/selftests/net/txtimestamp.c:
> do_test()
> {
>          sock_opt = SOF_TIMESTAMPING_SOFTWARE |
>          ...
>          if (setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING,
>                                (char *) &sock_opt, sizeof(sock_opt)))
> }
> 
>>
>> Is it the reason that the bpf_setsockopt() cannot clear the sk_tsflags_bpf once
>> it is set in patch 2? It is not a usable api tbh. It will be a surprise to many.
>> It has to be able to set and clear.
> 
> I cannot find a good time to clear all the sockets which are set
> through the BPF program. If we detach the BPF program, it will not
> print of course. Does it really matter if we don't clear the
> sk_tsflags_bpf?

Yes, it matters. The same reason goes for why the existing bpf prog can clear 
the tp->bpf_sock_ops_cb_flags. Yes, detach will automatically not taking the 
timestamp. For sockops program that stays forever, not all usages expect to do 
timestamping for the whole lifetime of the connection. If there is a way for the 
prog to turn it on, it should have a way for the prog to turn it off.

What is the concern of allowing the bpf prog to disable something that it has 
enabled before?

While we are on bpf_sock_ops_cb_flags, the 
BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG addition is mostly a dup of whatever in 
the new sk_tsflags_bpf. It is something we need to clean up later when we decide 
what interface to use for bpf timestamping.

> 
>>
>> Does it also mean either the bpf or the user space can enable the timetstamping
>> but not both? I don't think we can assume this also. It will be hard to deploy
>> the bpf prog in production to collect continuous data. The user space may have
>> some timestamping enabled but the bpf may want to do its parallel investigation
>> also. The user space may rollout timestamping in the future and suddenly break
>> the bpf prog.
> 
> Well, IIUC, it's also the basic idea from the current series which
> allows both happening at the same time. Let us put it in a simple way,
> I hope that if the app uses the SO_TIMESTAMPING feature already, then
> one admin deploys the BPF program, that app should be traced both in
> bpf and non-bpf ways.
> 
> But Willem doesn't agree about this approach[1] because of hard to debug.
> 
> [1]: https://lore.kernel.org/all/670dda9437147_2e6c4029461@willemb.c.googlers.com.notmuch/
> Regarding to this link, I have a few more words to say: the socket
> could be set through bpf_setsockopt() in different phases not like
> setsockopt(), so in some cases we cannot make setsockopt hard failed.
> 
> After rethinking this point more, I still reckon that letting BPF
> program trace timestamping parallelly without caring whether the
> socket is set to the SO_TIMESTAMPING feature through setsockopt()

I am afraid having both work in parallel is needed. Otherwise, it will be very 
hard to deploy a bpf prog to run continuously in scale. Being able to collect 
timestamp without worrying about application changes/updates/downgrades is 
important. e.g. App changes from no time stamping to time stamping

Please help to add selftests to show how the above cases (1), (2), (3), and 
other tsflags/txflags sharing cases will work. This should not be delayed until 
the discussion is done. It is needed sooner or later to prove both bpf and 
non-bpf ways can work at the same time. It will help the reviewer and also help 
to think about the design with a real use case in bpf prog.

The example in patch 0 only prints the reported tstamp, can you share how it 
will be used to investigate issue? Is it also useful to know when the skb is 
written to the kernel during sendmsg()?

Regarding the bpf_setsockopt() can be called in different phase, 
bpf_setsockopt() is not limited to sockops program. e.g. it can also be called 
from a bpf-tcp-cc (congestion control). Not a tcp-cc expert but I won't be 
surprised people will try to trigger some on-and-off timestamping from 
bpf-tcp-cc to measure some delay.


More about bpf_setsockopt() in different phase, understand that UDP is not your 
priority. However, it needs to have some clarity on how UDP will work and how to 
enable it. UDP usually has no connect/established phase.

Regarding the SOF_TIMESTAMPING_* support, can you list out what else you are 
planning to support in the future. You mentioned the SOF_TIMESTAMPING_TX_ACK in 
another thread. What else?

> method. It means I would like to keep this part in patch [04/12]:
> @@ -5601,6 +5636,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>          if (!sk)
>                  return;
> 
> +       if (static_branch_unlikely(&bpf_tstamp_control))
> +               bpf_skb_tstamp_tx_output(sk, tstype);
> +
>          skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk,
> tstype);
>   }
>   EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
> 
>>
>> [ getting late here. will continue later. ]
> 
> Thanks for your effort :)
> 
> Thanks,
> Jason


