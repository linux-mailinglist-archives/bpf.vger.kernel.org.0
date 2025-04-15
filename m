Return-Path: <bpf+bounces-55938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B19AA897DC
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 11:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD3D16A813
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 09:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CC22820DA;
	Tue, 15 Apr 2025 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="UEIM/HiP"
X-Original-To: bpf@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C0027FD68;
	Tue, 15 Apr 2025 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709157; cv=none; b=hBLZmiZI54PqJ+Qdv/jMgwBSj8/dm3UUIoUrSs9QXdngGIlgYQlacAKR7Soh42BjtcCCDVf4x8qZ7jenmDJO5ALzm8qO6lVnOryvS2P5jXgVhSSpOW3+muth8r+8b+9Ije2YHAXBJxS6karMart+V3TpoXL2HkyDUZ7TkeOTVcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709157; c=relaxed/simple;
	bh=ytDuicykfqxTsQX4cJhgtKs+BJvoEITplUzVLGWV8L0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itN/3MHIT69+ttb8WFD0UPyUiQJiEkVxbW5OKVHUkFFBeI9F4DVIbh9vr4/+RqpPSB6jw0flPTq+vpMc9BviqQaqfLmeZN1olrFZq9qSLPwQVFIyiUayiyTKs5NwPKMDC909MtRzRVkAKy5+3TKTK3+RU+Xtedw+HojS94xygiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=UEIM/HiP; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 19DCE200DF84;
	Tue, 15 Apr 2025 11:25:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 19DCE200DF84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1744709153;
	bh=VIyob7deFo4f05HYLzENtLpGESAZmECjGyEhhqncH/A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UEIM/HiP26jXRWjeojcOwTwPOCRGdGwA8KXJwKirLK/UsvB8NKP17B5FIaWn1Qmuw
	 AthgCwJ4KvE3cMiDEOGMHz/3EJRAzKJ3DguqsR4OYlEx9ZHiXHUfi3ZNhxIEpSCfn9
	 DnYKq4E0yNMj9akNoXi/BfQluBFZp/mdlbEQDbmSCZvhmSOb/ZmkLsazMHIpOWF9yM
	 +jseXHsgOTLUIgeAhLe9pumt49GS1rV1rMXs3E9EW+zwigkc/kRG56o1bGRcOJmi6U
	 ouywGZ0NWwILViEOjc3qmLP929SSh9dnz6TlgwW7Djur0AR9xlIis8ZZcPiCryjks7
	 /pDpO0fKM2y0w==
Message-ID: <89c7c05b-096a-4db9-b1dc-d2a95e89f160@uliege.be>
Date: Tue, 15 Apr 2025 11:25:52 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: lwtunnel: disable preemption when required
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Sebastian Sewior <bigeasy@linutronix.de>,
 Stanislav Fomichev <stfomichev@gmail.com>,
 Network Development <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 bpf <bpf@vger.kernel.org>, Andrea Mayer <andrea.mayer@uniroma2.it>
References: <20250403083956.13946-1-justin.iurman@uliege.be>
 <Z-62MSCyMsqtMW1N@mini-arch> <cb0df409-ebbf-4970-b10c-4ea9f863ff00@uliege.be>
 <CAADnVQLiM5MA3Xyrkqmubku6751ZPrDk6v-HmC1jnOaL47=t+g@mail.gmail.com>
 <20250404141955.7Rcvv7nB@linutronix.de>
 <85eefdd9-ec5d-4113-8a50-5d9ea11c8bf5@uliege.be>
 <CAADnVQK7vNPbMS7T9TUOW7s6HNbfr4H8CWbjPgVXW7xa+ybPsw@mail.gmail.com>
 <d326726d-7050-4e88-b950-f49cf5901d34@uliege.be>
 <CAADnVQ++4Lf0ucHjfyK0OakPYsbN2Q9yX0Ru3ymWo4YtLOi-HA@mail.gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <CAADnVQ++4Lf0ucHjfyK0OakPYsbN2Q9yX0Ru3ymWo4YtLOi-HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/15/25 01:13, Alexei Starovoitov wrote:
> On Fri, Apr 11, 2025 at 11:34 AM Justin Iurman <justin.iurman@uliege.be> wrote:
>>
>> On 4/7/25 19:54, Alexei Starovoitov wrote:
>>> On Sun, Apr 6, 2025 at 1:59 AM Justin Iurman <justin.iurman@uliege.be> wrote:
>>>>
>>>> On 4/4/25 16:19, Sebastian Sewior wrote:
>>>>> Alexei, thank you for the Cc.
>>>>>
>>>>> On 2025-04-03 13:35:10 [-0700], Alexei Starovoitov wrote:
>>>>>> Stating the obvious...
>>>>>> Sebastian did a lot of work removing preempt_disable from the networking
>>>>>> stack.
>>>>>> We're certainly not adding them back.
>>>>>> This patch is no go.
>>>>>
>>>>> While looking through the code, it looks as if lwtunnel_xmit() lacks a
>>>>> local_bh_disable().
>>>>
>>>> Thanks Sebastian for the confirmation, as the initial idea was to use
>>>> local_bh_disable() as well. Then I thought preempt_disable() would be
>>>> enough in this context, but I didn't realize you made efforts to remove
>>>> it from the networking stack.
>>>>
>>>> @Alexei, just to clarify: would you ACK this patch if we do
>>>> s/preempt_{disable|enable}()/local_bh_{disable|enable}()/g ?
>>>
>>> You need to think it through and not sprinkle local_bh_disable in
>>> every lwt related function.
>>> Like lwtunnel_input should be running with bh disabled already.
>>
>> Having nested calls to local_bh_{disable|enable}() is fine (i.e.,
>> disabling BHs when they're already disabled), but I guess it's cleaner
>> to avoid it here as you suggest. And since lwtunnel_input() is indeed
>> (always) running with BHs disabled, no changes needed. Thanks for the
>> reminder.
>>
>>> I don't remember the exact conditions where bh is disabled in xmit path.
>>
>> Right. Not sure for lwtunnel_xmit(), but lwtunnel_output() can
>> definitely run with or without BHs disabled. So, what I propose is the
>> following logic (applied to lwtunnel_xmit() too): if BHs disabled then
>> NOP else local_bh_disable(). Thoughts on this new version? (sorry, my
>> mailer messes it up, but you got the idea):
>>
>> diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
>> index e39a459540ec..d44d341683c5 100644
>> --- a/net/core/lwtunnel.c
>> +++ b/net/core/lwtunnel.c
>> @@ -331,8 +331,13 @@ int lwtunnel_output(struct net *net, struct sock
>> *sk, struct sk_buff *skb)
>>          const struct lwtunnel_encap_ops *ops;
>>          struct lwtunnel_state *lwtstate;
>>          struct dst_entry *dst;
>> +       bool in_softirq;
>>          int ret;
>>
>> +       in_softirq = in_softirq();
>> +       if (!in_softirq)
>> +               local_bh_disable();
>> +
> 
> This looks like a hack to me.
> 
> Instead analyze the typical xmit path. If bh is not disabled

This is already what I did, and it's exactly the reason why I ended up 
with the above proposal. It's not only about the xmit path but also the 
output path. Of course, having BHs disabled only where they need to 
without useless nested calls would be nice, but in reality the solution 
is not perfect and makes it even more difficult to visualize the path(s) 
with or without BHs disabled IMO.

For both lwtunnel_xmit() and lwtunnel_output(), the common functions 
which are closest in depth and where BHs should be disabled are 
ip_local_out() and ip6_local_out(). And even when it's not required 
(which is the tradeoff). The other solution was -v1, which you NACK'ed. 
Please see my reply to Andrea for the whole story. To summarize, I'd say 
that it's either (a) what you suggest, i.e., non-required BH disable 
calls vs. (b) nested BH disable calls. With tradeoffs for each.

> then add local_bh_disable(). It's fine if it happens to be nested
> in some cases.

