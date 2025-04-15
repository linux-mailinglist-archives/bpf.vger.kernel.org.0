Return-Path: <bpf+bounces-55946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1341A89CFB
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 13:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6DB16D91B
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 11:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340C529293B;
	Tue, 15 Apr 2025 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="HLurYtxM"
X-Original-To: bpf@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E361D47AD;
	Tue, 15 Apr 2025 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744718215; cv=none; b=hcwfNa9pciXBnLUrqIxaFDwO4+UP5eMREuni77/RDrWXVjTKpSezI2wV6ToNW19UL/B4lo7XZV4jd4RBC9bHIq4gvjbQCCy2qBykRkFCUDCJw7vH7VDRrBZADvuuvWKeIkqaRMkgkwxMxj5g19oDwWc6eE0+v+72u7rscQ1snJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744718215; c=relaxed/simple;
	bh=6NSjC0cA85gGvJi5Tm1VWJmxI4ZbmrQ+ThICd6rwfYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1nPvescAdWx9YwHgedox0QK37QaZUVevclOURw3CZc9q/gZwwh1HjhgaxVNdVvYIscSgLl1O8S+sFx10+FC+1/o8fhBnVu/XeuTHJ0d5dSECFVVLFLuMpCKI0eiX9oI2bdSydYIt4QOwxO6xpNM8SsQkum5BJP3OKVRf0oDH60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=HLurYtxM; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 4D71C200A8C2;
	Tue, 15 Apr 2025 13:56:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 4D71C200A8C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1744718211;
	bh=a3BpEMddM3IDfIMB+xtSMcNoBlDrtg1EzGQaGUx9E9I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HLurYtxMWaj3xJdSp2lNhCe04bcghZX3Iksdy0QrNHW6cqiXwHa3ZQaH4obqUrG3b
	 yjuSfHPxmdRF7wtYL/gbOCP+x/kJgz3sMnQJNksTdBmVbjyj8bPrfub09anR/VklXp
	 p5faELIKmAfYph3kErpLch+lP9Z8MqhCclX9aLSW74yEOL29FeqRo/WFNQjSMWhjPZ
	 S6fsdY4nS0QTlgKcG7H/fJmUcJ066vQTvZ3zGhw+xPUtaBjPJzxsEKPtfhkjGL8zOg
	 7bZ/OmleLkHQnXuHmHQudmpG8ajik2O4kh2tHpFLn2Gk8KHTqNZef5xKBB9a4RnaqX
	 zBWtWdLKSAgEA==
Message-ID: <5df6bc58-df2d-4d11-9447-b3bf06876cdc@uliege.be>
Date: Tue, 15 Apr 2025 13:56:51 +0200
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
> then add local_bh_disable(). It's fine if it happens to be nested
> in some cases.

FYI, and based on my previous response, the patch would look like this 
in that case (again, my mailer messes long lines up, sorry). I'll let 
others comment on which solution/tradeoff seems better.

diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index e39a459540ec..d0cb0f2f9efe 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -333,6 +333,8 @@ int lwtunnel_output(struct net *net, struct sock 
*sk, struct sk_buff *skb)
  	struct dst_entry *dst;
  	int ret;

+	DEBUG_NET_WARN_ON_ONCE(!in_softirq());
+
  	if (dev_xmit_recursion()) {
  		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
  				     __func__);
@@ -380,6 +382,8 @@ int lwtunnel_xmit(struct sk_buff *skb)
  	struct dst_entry *dst;
  	int ret;

+	DEBUG_NET_WARN_ON_ONCE(!in_softirq());
+
  	if (dev_xmit_recursion()) {
  		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
  				     __func__);
@@ -428,6 +432,8 @@ int lwtunnel_input(struct sk_buff *skb)
  	struct dst_entry *dst;
  	int ret;

+	DEBUG_NET_WARN_ON_ONCE(!in_softirq());
+
  	if (dev_xmit_recursion()) {
  		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
  				     __func__);
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 6e18d7ec5062..89bda2f424bb 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -124,10 +124,13 @@ int ip_local_out(struct net *net, struct sock *sk, 
struct sk_buff *skb)
  {
  	int err;

+	local_bh_disable();
+
  	err = __ip_local_out(net, sk, skb);
  	if (likely(err == 1))
  		err = dst_output(net, sk, skb);

+	local_bh_enable();
  	return err;
  }
  EXPORT_SYMBOL_GPL(ip_local_out);
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index 806d4b5dd1e6..bb40196edeb6 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -150,10 +150,13 @@ int ip6_local_out(struct net *net, struct sock 
*sk, struct sk_buff *skb)
  {
  	int err;

+	local_bh_disable();
+
  	err = __ip6_local_out(net, sk, skb);
  	if (likely(err == 1))
  		err = dst_output(net, sk, skb);

+	local_bh_enable();
  	return err;
  }
  EXPORT_SYMBOL_GPL(ip6_local_out);

