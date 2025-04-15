Return-Path: <bpf+bounces-55915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFDEA89101
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 03:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006AE3B2D7A
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 01:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEB4199223;
	Tue, 15 Apr 2025 01:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="4XE3aCOx";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="pflZgK1D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5315B54C;
	Tue, 15 Apr 2025 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744679193; cv=none; b=a90GT4aWdGKxQmnJiaX1FlulOQmEY+Xs3V7CXnCEDO0HJ5dG/SjN77Y4awGUvXn5pVj/hE6S6grApR1PJRz808d2TGKL6yY4aY0NVEVQ6fJyL+6VEYNBBBYhqyfbG8GBzdO7AdzMMRLWSn2hxMQQnq9qIn+/KKhf+85T5JmNM40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744679193; c=relaxed/simple;
	bh=mRdxcCyz9Wa8G3XYNb0Hs2Idss2ELFSgAEytfFDPHiY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WufJeUT7OuXsfhcMRrIWxSnTGpzX+PLiYW/huuwK6erzC8SRdzOjXTgKhRJ/3A3em2gQTwS8CBABP5y2OaqZKMdQBXmeZGDb9JYHQiZCn6NFxAiCx9B47STL+byiLCgzA0EaWqNBW4xKyq7TkTaZyv1On3vKV93jp8eNiV4zSD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=4XE3aCOx; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=pflZgK1D; arc=none smtp.client-ip=160.80.4.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 53F0rsZa015796;
	Tue, 15 Apr 2025 02:53:59 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id ABE851228DB;
	Tue, 15 Apr 2025 02:54:16 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1744678457; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5D3RC7ITnpDs+DKKDxLRzxADpKFmVqiUi5BSFovN7pk=;
	b=4XE3aCOxSOWQXxVPfPJQ/8j9qb/XUF5XGbbjxdXp/jv1nl16AM6FvVfAnJZ+TLJuXof7Ct
	nGGmH14KIpZJRcDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1744678457; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5D3RC7ITnpDs+DKKDxLRzxADpKFmVqiUi5BSFovN7pk=;
	b=pflZgK1DbJZiq9GJVMMcMqq1HPOzCVnE8ouTL/HsQlXJtav3aA2n4dPapkRYlykQ/bziPj
	YfW58Nr+SS4pNmFRm93EbedNAOsMwBck/X0oW6xdMpuGE20iQnAZku++KrmImtd6y7J7c/
	23PLUxCSneK2bMkOz7d7E3l/uNweVFaDqY1ToNwIFIQfsc2q8R0r4nW2n/8B9ZDSlZz2GZ
	HVjuxnGozCIMKPBQPiMIYCwstCSyEDm7H5FUJb+Q19yZuIsgx4fC8Km9PFWsklLxUkgdsa
	e/XUtvHDHdnLDL0CKkJAmlOhgfay120Xv6JD5GE1FLR8K1HI5CMyIV2vaVhVSA==
Date: Tue, 15 Apr 2025 02:54:16 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Sebastian Sewior
 <bigeasy@linutronix.de>,
        Stanislav Fomichev <stfomichev@gmail.com>,
        Network
 Development <netdev@vger.kernel.org>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>, bpf
 <bpf@vger.kernel.org>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo
 Lungaroni <paolo.lungaroni@uniroma2.it>,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net] net: lwtunnel: disable preemption when required
Message-Id: <20250415025416.0273812f0322a6b1728d9c7b@uniroma2.it>
In-Reply-To: <d326726d-7050-4e88-b950-f49cf5901d34@uliege.be>
References: <20250403083956.13946-1-justin.iurman@uliege.be>
	<Z-62MSCyMsqtMW1N@mini-arch>
	<cb0df409-ebbf-4970-b10c-4ea9f863ff00@uliege.be>
	<CAADnVQLiM5MA3Xyrkqmubku6751ZPrDk6v-HmC1jnOaL47=t+g@mail.gmail.com>
	<20250404141955.7Rcvv7nB@linutronix.de>
	<85eefdd9-ec5d-4113-8a50-5d9ea11c8bf5@uliege.be>
	<CAADnVQK7vNPbMS7T9TUOW7s6HNbfr4H8CWbjPgVXW7xa+ybPsw@mail.gmail.com>
	<d326726d-7050-4e88-b950-f49cf5901d34@uliege.be>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Fri, 11 Apr 2025 20:34:54 +0200
Justin Iurman <justin.iurman@uliege.be> wrote:

> On 4/7/25 19:54, Alexei Starovoitov wrote:
> > On Sun, Apr 6, 2025 at 1:59 AM Justin Iurman <justin.iurman@uliege.be> wrote:
> >>
> >> On 4/4/25 16:19, Sebastian Sewior wrote:
> >>> Alexei, thank you for the Cc.
> >>>
> >>> On 2025-04-03 13:35:10 [-0700], Alexei Starovoitov wrote:
> >>>> Stating the obvious...
> >>>> Sebastian did a lot of work removing preempt_disable from the networking
> >>>> stack.
> >>>> We're certainly not adding them back.
> >>>> This patch is no go.
> >>>
> >>> While looking through the code, it looks as if lwtunnel_xmit() lacks a
> >>> local_bh_disable().
> >>
> >> Thanks Sebastian for the confirmation, as the initial idea was to use
> >> local_bh_disable() as well. Then I thought preempt_disable() would be
> >> enough in this context, but I didn't realize you made efforts to remove
> >> it from the networking stack.
> >>
> >> @Alexei, just to clarify: would you ACK this patch if we do
> >> s/preempt_{disable|enable}()/local_bh_{disable|enable}()/g ?
> > 
> > You need to think it through and not sprinkle local_bh_disable in
> > every lwt related function.
> > Like lwtunnel_input should be running with bh disabled already.
> 
> Having nested calls to local_bh_{disable|enable}() is fine (i.e., 
> disabling BHs when they're already disabled), but I guess it's cleaner 
> to avoid it here as you suggest. And since lwtunnel_input() is indeed 
> (always) running with BHs disabled, no changes needed. Thanks for the 
> reminder.
> 
> > I don't remember the exact conditions where bh is disabled in xmit path.
> 
> Right. Not sure for lwtunnel_xmit(), but lwtunnel_output() can

Justin, thanks for the Cc.

I have been looking into the behavior of the lwtunnel_xmit() function in both
task and softirq contexts. To facilitate this investigation, I have written a
simple eBPF program that only prints messages to the trace pipe. This program
is attached to the LWT BPF XMIT hook by configuring a route (on my test node)
with a destination address (DA) pointing to an external node, referred to as
x.x.x.x, within my testbed network.

To trigger that LWT BPF XMIT instance from a softirq context, it is sufficient
to receive (on the test node) a packet with a DA matching x.x.x.x. This packet
is then processed through the forwarding path, eventually leading to the
ip_output() function. Processing ends with a call to ip_finish_output2(), which
then calls lwtunnel_xmit().

Below is the stack trace from my testing machine, highlighting the key
functions involved in this processing path:

 ============================================
  <IRQ>                                         
  ...
  lwtunnel_xmit+0x18/0x3f0                      
  ip_finish_output2+0x45a/0xcc0                 
  ip_output+0xe2/0x380                          
  NF_HOOK.constprop.0+0x7e/0x2f0                
  ip_rcv+0x4bf/0x4d0                            
  __netif_receive_skb_one_core+0x11c/0x130      
  process_backlog+0x277/0x980
  __napi_poll.constprop.0+0x58/0x260
  net_rx_action+0x396/0x6e0
  handle_softirqs+0x116/0x640
  do_softirq+0xa9/0xe0
  </IRQ>
 ============================================

Conversely, to trigger lwtunnel_xmit() from the task context, simply ping
x.x.x.x on the same testing node. Below is the corresponding stack trace:

 ============================================
  <TASK>                                                               
  ...
  lwtunnel_xmit+0x18/0x3f0                                             
  ip_finish_output2+0x45a/0xcc0                                        
  ip_output+0xe2/0x380                                                 
  ip_push_pending_frames+0x17a/0x200                                   
  raw_sendmsg+0x9fa/0x1060                                             
  __sys_sendto+0x294/0x2e0                                             
  __x64_sys_sendto+0x6d/0x80                                           
  do_syscall_64+0x64/0x140                                             
  entry_SYSCALL_64_after_hwframe+0x76/0x7e                             
  </TASK>    
 ============================================

So also for the lwtunnel_xmit(), we need to make sure that the functions
dev_xmit_recursion{_inc/dec}() and the necessary logic to avoid lwt recursion
are protected, i.e. inside a local_bh_{disable/enable} block.

> definitely run with or without BHs disabled. So, what I propose is the 
> following logic (applied to lwtunnel_xmit() too): if BHs disabled then 
> NOP else local_bh_disable(). Thoughts on this new version? (sorry, my 
> mailer messes it up, but you got the idea):
> 
> diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
> index e39a459540ec..d44d341683c5 100644
> --- a/net/core/lwtunnel.c
> +++ b/net/core/lwtunnel.c
> @@ -331,8 +331,13 @@ int lwtunnel_output(struct net *net, struct sock 
> *sk, struct sk_buff *skb)
>   	const struct lwtunnel_encap_ops *ops;
>   	struct lwtunnel_state *lwtstate;
>   	struct dst_entry *dst;
> +	bool in_softirq;
>   	int ret;
> 
> +	in_softirq = in_softirq();
> +	if (!in_softirq)
> +		local_bh_disable();
> +

In a non-preemptible real-time environment (i.e., when !PREEMPT_RT), the
in_softirq() expands to softirq_count(), which in turn uses the preempt_count()
function. On my x86 architecture, preempt_count() accesses the per-CPU
__preempt_count variable.

If in_softirq() returns 0, it indicates that no softirqs are currently being
processed on the local CPU and BH are not disabled. Therefore, following the
logic above, we disable bottom halves (BH) on that particular CPU.

However, there is my opinion an issue that can occur: between the check on
in_softirq() and the call to local_bh_disable(), the task may be scheduled on
another CPU. As a result, the check on in_softirq() becomes ineffective because
we may end up disabling BH on a CPU that is not the one we just checked (with
if (in_softirq()) { ... }).


>   	if (dev_xmit_recursion()) {
>   		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
>   				     __func__);
> @@ -345,11 +350,13 @@ int lwtunnel_output(struct net *net, struct sock 
> *sk, struct sk_buff *skb)
>   		ret = -EINVAL;
>   		goto drop;
>   	}
> -	lwtstate = dst->lwtstate;
> 
> +	lwtstate = dst->lwtstate;
>   	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
> -	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
> -		return 0;
> +	    lwtstate->type > LWTUNNEL_ENCAP_MAX) {
> +		ret = 0;
> +		goto out;
> +	}
> 
>   	ret = -EOPNOTSUPP;
>   	rcu_read_lock();
> @@ -364,10 +371,12 @@ int lwtunnel_output(struct net *net, struct sock 
> *sk, struct sk_buff *skb)
>   	if (ret == -EOPNOTSUPP)
>   		goto drop;
> 
> -	return ret;
> -
> +	goto out;
>   drop:
>   	kfree_skb(skb);
> +out:
> +	if (!in_softirq)
> +		local_bh_enable();
> 
>   	return ret;
>   }
> @@ -378,8 +387,13 @@ int lwtunnel_xmit(struct sk_buff *skb)
>   	const struct lwtunnel_encap_ops *ops;
>   	struct lwtunnel_state *lwtstate;
>   	struct dst_entry *dst;
> +	bool in_softirq;
>   	int ret;
> 
> +	in_softirq = in_softirq();
> +	if (!in_softirq)
> +		local_bh_disable();
> +
>   	if (dev_xmit_recursion()) {
>   		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
>   				     __func__);
> @@ -394,10 +408,11 @@ int lwtunnel_xmit(struct sk_buff *skb)
>   	}
> 
>   	lwtstate = dst->lwtstate;
> -
>   	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
> -	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
> -		return 0;
> +	    lwtstate->type > LWTUNNEL_ENCAP_MAX) {
> +		ret = 0;
> +		goto out;
> +	}
> 
>   	ret = -EOPNOTSUPP;
>   	rcu_read_lock();
> @@ -412,10 +427,12 @@ int lwtunnel_xmit(struct sk_buff *skb)
>   	if (ret == -EOPNOTSUPP)
>   		goto drop;
> 
> -	return ret;
> -
> +	goto out;
>   drop:
>   	kfree_skb(skb);
> +out:
> +	if (!in_softirq)
> +		local_bh_enable();
> 
>   	return ret;
>   }
> @@ -428,6 +445,8 @@ int lwtunnel_input(struct sk_buff *skb)
>   	struct dst_entry *dst;
>   	int ret;
> 
> +	WARN_ON_ONCE(!in_softirq());
> +

What about DEBUG_NET_WARN_ON_ONCE instead?

Ciao,
Andrea

>   	if (dev_xmit_recursion()) {
>   		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
>   				     __func__);
> @@ -440,8 +459,8 @@ int lwtunnel_input(struct sk_buff *skb)
>   		ret = -EINVAL;
>   		goto drop;
>   	}
> -	lwtstate = dst->lwtstate;
> 
> +	lwtstate = dst->lwtstate;
>   	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
>   	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
>   		return 0;
> @@ -460,10 +479,8 @@ int lwtunnel_input(struct sk_buff *skb)
>   		goto drop;
> 
>   	return ret;
> -
>   drop:
>   	kfree_skb(skb);
> -
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(lwtunnel_input);

