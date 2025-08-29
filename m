Return-Path: <bpf+bounces-66966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2889B3B5CD
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 10:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33E4565B06
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 08:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352E62BE7AD;
	Fri, 29 Aug 2025 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ey2I/2V7"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315EF296BB3;
	Fri, 29 Aug 2025 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756455268; cv=none; b=Rg+UpqC+9/dFyiupbj8lcp7XB7C7kdrvkgWfTfglAglOsYhYTfvCfTpYN8c99cYEvbozU8sqDF+8DPVThMDVJq+sAz/oCC3BHICq1c/YdLO2qqdqvh4IEw2PSMH3NPx/PoXQDNGEN1blx/9cRgCib7GrvirQRvMjZEe2kduTmEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756455268; c=relaxed/simple;
	bh=+ZdTRFxuDhTf9uWA31xbLCkEzI9NqcQmBiyU6qfZfTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFWJOSDt9zo24pKWKSu6rLgwS6iuyysoHxg4HrmoOVosgpImqKaJ9i/NAgSJpASh2EAwa2sId8nuCBanff+vZktQX9oSw3yzMESUxsTNsNfW9q54NOSQgvhkbTeDR8dOVLJFn5mD6kNn/VC6z+qGebzwPilYxJ/Glnb36JQlMXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ey2I/2V7; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=KMtG8ofuNmtfm661TEIC5f1H8ncu2MEQYNCvo3zmC/0=; b=ey2I/2V7tqpysZo0T2mbAmzibz
	IMCOUNQUi1FK1ufsRLKqm3ntQ69TBUZddJcs8KPBb1KN2F28b9UTrONZTXLia6bxO7NQ6kF7JrdL+
	oTx2MzLX7xNjmoaRFbZfFVuqXKUbLNgA/UkHczZAs9h7a6xDo1K7AtuzpGxP50TuE3r14UTEhoA65
	t2BlMOKPRmJcFUdKEugPIg9DtO4Jz6Bo7VQI6BPb2bKCh7RWcSxe5dgXt6ABsAW4Ieh9BppgaujAg
	oT6AUhco2LZyhsj9zl3OrKlceeqHS2pCU48jaOIeKfdzuZmUdtLk8zaHRdKvEbrs7930wEHZgyCIQ
	dUyH+V3g==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uruFT-000Ah7-1f;
	Fri, 29 Aug 2025 10:14:15 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1uruFS-0000xo-1n;
	Fri, 29 Aug 2025 10:14:14 +0200
Message-ID: <96158e58-da9a-4661-a47b-e7b85856ac90@iogearbox.net>
Date: Fri, 29 Aug 2025 10:14:13 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/cls_cgroup: Fix task_get_classid() during qdisc
 run
To: Yafang Shao <laoar.shao@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, bigeasy@linutronix.de, tgraf@suug.ch, paulmck@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>
References: <20250822064200.38149-1-laoar.shao@gmail.com>
 <1d3ba6ba-5c1e-4d3f-980a-8ad75101f04d@redhat.com>
 <CALOAHbBdiPZ_YVhBJeV517Xqz8=cuGo6jhhta_QXy5-eQ6EN4g@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CALOAHbBdiPZ_YVhBJeV517Xqz8=cuGo6jhhta_QXy5-eQ6EN4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27746/Thu Aug 28 10:27:00 2025)

On 8/29/25 5:23 AM, Yafang Shao wrote:
> On Thu, Aug 28, 2025 at 3:55 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 8/22/25 8:42 AM, Yafang Shao wrote:
>>> During recent testing with the netem qdisc to inject delays into TCP
>>> traffic, we observed that our CLS BPF program failed to function correctly
>>> due to incorrect classid retrieval from task_get_classid(). The issue
>>> manifests in the following call stack:
>>>
>>>          bpf_get_cgroup_classid+5
>>>          cls_bpf_classify+507
>>>          __tcf_classify+90
>>>          tcf_classify+217
>>>          __dev_queue_xmit+798
>>>          bond_dev_queue_xmit+43
>>>          __bond_start_xmit+211
>>>          bond_start_xmit+70
>>>          dev_hard_start_xmit+142
>>>          sch_direct_xmit+161
>>>          __qdisc_run+102             <<<<< Issue location
>>>          __dev_xmit_skb+1015
>>>          __dev_queue_xmit+637
>>>          neigh_hh_output+159
>>>          ip_finish_output2+461
>>>          __ip_finish_output+183
>>>          ip_finish_output+41
>>>          ip_output+120
>>>          ip_local_out+94
>>>          __ip_queue_xmit+394
>>>          ip_queue_xmit+21
>>>          __tcp_transmit_skb+2169
>>>          tcp_write_xmit+959
>>>          __tcp_push_pending_frames+55
>>>          tcp_push+264
>>>          tcp_sendmsg_locked+661
>>>          tcp_sendmsg+45
>>>          inet_sendmsg+67
>>>          sock_sendmsg+98
>>>          sock_write_iter+147
>>>          vfs_write+786
>>>          ksys_write+181
>>>          __x64_sys_write+25
>>>          do_syscall_64+56
>>>          entry_SYSCALL_64_after_hwframe+100
>>>
>>> The problem occurs when multiple tasks share a single qdisc. In such cases,
>>> __qdisc_run() may transmit skbs created by different tasks. Consequently,
>>> task_get_classid() retrieves an incorrect classid since it references the
>>> current task's context rather than the skb's originating task.
>>>
>>> Given that dev_queue_xmit() always executes with bh disabled, we can safely
>>> use in_softirq() instead of in_serving_softirq() to properly identify the
>>> softirq context and obtain the correct classid.
>>>
>>> The simple steps to reproduce this issue:
>>> 1. Add network delay to the network interface:
>>>    such as: tc qdisc add dev bond0 root netem delay 1.5ms
>>> 2. Create two distinct net_cls cgroups, each running a network-intensive task
>>> 3. Initiate parallel TCP streams from both tasks to external servers.
>>>
>>> Under this specific condition, the issue reliably occurs. The kernel
>>> eventually dequeues an SKB that originated from Task-A while executing in
>>> the context of Task-B.
>>>
>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>> Cc: Thomas Graf <tgraf@suug.ch>
>>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>>
>>> v1->v2: use softirq_count() instead of in_softirq()
>>> ---
>>>   include/net/cls_cgroup.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/net/cls_cgroup.h b/include/net/cls_cgroup.h
>>> index 7e78e7d6f015..668aeee9b3f6 100644
>>> --- a/include/net/cls_cgroup.h
>>> +++ b/include/net/cls_cgroup.h
>>> @@ -63,7 +63,7 @@ static inline u32 task_get_classid(const struct sk_buff *skb)
>>>         * calls by looking at the number of nested bh disable calls because
>>>         * softirqs always disables bh.
>>>         */
>>> -     if (in_serving_softirq()) {
>>> +     if (softirq_count()) {
>>>                struct sock *sk = skb_to_full_sk(skb);
>>>
>>>                /* If there is an sock_cgroup_classid we'll use that. */
>>
>> AFAICS the above changes the established behavior for a slightly
>> different scenario:
> 
> right.
> 
>> <sock S is created by task A>
>> <class ID for task A is changed>
>> <skb is created by sock S xmit and classified>
>>
>> prior to this patch the skb will be classified with the 'new' task A
>> classid, now with the old/original one.
>>
>> I'm unsure if such behavior change is acceptable;
> 
> The classid of a skb is only meaningful within its original network
> context, not from a random task.

Do you mean by original network context original netns? We also have
bpf_skb_cgroup_classid() as well as bpf_get_cgroup_classid_curr(), both
exposed to tcx, which kind of detangles what task_get_classid() is doing.
I guess if you have apps in its own netns and the skb->sk is retained all
the way to phys dev in hostns then bpf_skb_cgroup_classid() might be a
better choice (assuming classid stays constant from container orchestrator
PoV).

>> I think at very least
>> it should be mentioned in the changelog and likely this change should
>> target net-next.
> 
> Will add this to the commit log and tag it for net-next in the next version.


