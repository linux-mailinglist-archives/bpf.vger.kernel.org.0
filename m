Return-Path: <bpf+bounces-55781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 825CAA86593
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 20:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7551B60827
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 18:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EE0268C6B;
	Fri, 11 Apr 2025 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="h4L5+AEd"
X-Original-To: bpf@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE4D258CF9;
	Fri, 11 Apr 2025 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744396510; cv=none; b=TDgzL8vjL+Sw66FuC8U6JJzJXqTo0i5vBJPuolXiF+WBlCXrIu5Y3xIXOZelkwNWSf7nkPhG626qZv/yoAuTv2Mz+rIhpWFeVXJ0HSPOobBDtOIhK8L2QcVT5G6gPNCfkUTHqNARNTJAK9bUg0vc2hP2V9OT5GM6enpEled1EZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744396510; c=relaxed/simple;
	bh=VQMOJG3Xqbh63yqzujMlUkJSDrYr802XZZoo1HqtRHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rb6Q9RYIhogbmjIn6NDVvews635ZfyELI9zk7II83m40vzhc6rMQBRO3BoC5TFowCHpiK+MlGaliltYRD2UVdZ1dnlrhD/M7X22mSYGWYdjIIJcC3ddvGRxNCbTRODm2gch8ubxtOR4GLpIvQ/w7aI4g8RFgxa0CnmUkUPsRHEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=h4L5+AEd; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 57D67200AA23;
	Fri, 11 Apr 2025 20:34:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 57D67200AA23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1744396494;
	bh=0bU/LLcWU/+qPBXm2MJVcx++Q1pemdvGqFVxOn0R6GE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h4L5+AEdRxSHF27y+pMyMwCnolm5EmwH8wiLUIW1WqGFtEMssVU51Od8Q+3gyGqnY
	 WhQH+ZCJlA75C71rS5sPVrveywdSQ5gBAztJCaTRApaOKLUURZndQEUO3bEa8sogPs
	 JK5dYiLM5gSGzasQRQUqeE50bOEpTlNLl5HLBI6ddlY2BLpZNo1du6EhvtFSwj41Ud
	 iEX5IZSs2NnPJ1AEjiAz+1gRClSH8Ujm6CKY5hrAIasVqt5jQdZsRC8b5qJN3f+Tmu
	 xz796zUfCZFSkTaaX59WmzLmn26zi6yKEFbCVuNPvZyalYVoUNKtxUgLhJueGYjM6h
	 kZCjiDKH5gBNQ==
Message-ID: <d326726d-7050-4e88-b950-f49cf5901d34@uliege.be>
Date: Fri, 11 Apr 2025 20:34:54 +0200
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
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <CAADnVQK7vNPbMS7T9TUOW7s6HNbfr4H8CWbjPgVXW7xa+ybPsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/7/25 19:54, Alexei Starovoitov wrote:
> On Sun, Apr 6, 2025 at 1:59 AM Justin Iurman <justin.iurman@uliege.be> wrote:
>>
>> On 4/4/25 16:19, Sebastian Sewior wrote:
>>> Alexei, thank you for the Cc.
>>>
>>> On 2025-04-03 13:35:10 [-0700], Alexei Starovoitov wrote:
>>>> Stating the obvious...
>>>> Sebastian did a lot of work removing preempt_disable from the networking
>>>> stack.
>>>> We're certainly not adding them back.
>>>> This patch is no go.
>>>
>>> While looking through the code, it looks as if lwtunnel_xmit() lacks a
>>> local_bh_disable().
>>
>> Thanks Sebastian for the confirmation, as the initial idea was to use
>> local_bh_disable() as well. Then I thought preempt_disable() would be
>> enough in this context, but I didn't realize you made efforts to remove
>> it from the networking stack.
>>
>> @Alexei, just to clarify: would you ACK this patch if we do
>> s/preempt_{disable|enable}()/local_bh_{disable|enable}()/g ?
> 
> You need to think it through and not sprinkle local_bh_disable in
> every lwt related function.
> Like lwtunnel_input should be running with bh disabled already.

Having nested calls to local_bh_{disable|enable}() is fine (i.e., 
disabling BHs when they're already disabled), but I guess it's cleaner 
to avoid it here as you suggest. And since lwtunnel_input() is indeed 
(always) running with BHs disabled, no changes needed. Thanks for the 
reminder.

> I don't remember the exact conditions where bh is disabled in xmit path.

Right. Not sure for lwtunnel_xmit(), but lwtunnel_output() can 
definitely run with or without BHs disabled. So, what I propose is the 
following logic (applied to lwtunnel_xmit() too): if BHs disabled then 
NOP else local_bh_disable(). Thoughts on this new version? (sorry, my 
mailer messes it up, but you got the idea):

diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index e39a459540ec..d44d341683c5 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -331,8 +331,13 @@ int lwtunnel_output(struct net *net, struct sock 
*sk, struct sk_buff *skb)
  	const struct lwtunnel_encap_ops *ops;
  	struct lwtunnel_state *lwtstate;
  	struct dst_entry *dst;
+	bool in_softirq;
  	int ret;

+	in_softirq = in_softirq();
+	if (!in_softirq)
+		local_bh_disable();
+
  	if (dev_xmit_recursion()) {
  		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
  				     __func__);
@@ -345,11 +350,13 @@ int lwtunnel_output(struct net *net, struct sock 
*sk, struct sk_buff *skb)
  		ret = -EINVAL;
  		goto drop;
  	}
-	lwtstate = dst->lwtstate;

+	lwtstate = dst->lwtstate;
  	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
-	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
-		return 0;
+	    lwtstate->type > LWTUNNEL_ENCAP_MAX) {
+		ret = 0;
+		goto out;
+	}

  	ret = -EOPNOTSUPP;
  	rcu_read_lock();
@@ -364,10 +371,12 @@ int lwtunnel_output(struct net *net, struct sock 
*sk, struct sk_buff *skb)
  	if (ret == -EOPNOTSUPP)
  		goto drop;

-	return ret;
-
+	goto out;
  drop:
  	kfree_skb(skb);
+out:
+	if (!in_softirq)
+		local_bh_enable();

  	return ret;
  }
@@ -378,8 +387,13 @@ int lwtunnel_xmit(struct sk_buff *skb)
  	const struct lwtunnel_encap_ops *ops;
  	struct lwtunnel_state *lwtstate;
  	struct dst_entry *dst;
+	bool in_softirq;
  	int ret;

+	in_softirq = in_softirq();
+	if (!in_softirq)
+		local_bh_disable();
+
  	if (dev_xmit_recursion()) {
  		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
  				     __func__);
@@ -394,10 +408,11 @@ int lwtunnel_xmit(struct sk_buff *skb)
  	}

  	lwtstate = dst->lwtstate;
-
  	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
-	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
-		return 0;
+	    lwtstate->type > LWTUNNEL_ENCAP_MAX) {
+		ret = 0;
+		goto out;
+	}

  	ret = -EOPNOTSUPP;
  	rcu_read_lock();
@@ -412,10 +427,12 @@ int lwtunnel_xmit(struct sk_buff *skb)
  	if (ret == -EOPNOTSUPP)
  		goto drop;

-	return ret;
-
+	goto out;
  drop:
  	kfree_skb(skb);
+out:
+	if (!in_softirq)
+		local_bh_enable();

  	return ret;
  }
@@ -428,6 +445,8 @@ int lwtunnel_input(struct sk_buff *skb)
  	struct dst_entry *dst;
  	int ret;

+	WARN_ON_ONCE(!in_softirq());
+
  	if (dev_xmit_recursion()) {
  		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
  				     __func__);
@@ -440,8 +459,8 @@ int lwtunnel_input(struct sk_buff *skb)
  		ret = -EINVAL;
  		goto drop;
  	}
-	lwtstate = dst->lwtstate;

+	lwtstate = dst->lwtstate;
  	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
  	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
  		return 0;
@@ -460,10 +479,8 @@ int lwtunnel_input(struct sk_buff *skb)
  		goto drop;

  	return ret;
-
  drop:
  	kfree_skb(skb);
-
  	return ret;
  }
  EXPORT_SYMBOL_GPL(lwtunnel_input);

