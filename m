Return-Path: <bpf+bounces-55937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A33EA89791
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 11:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9311894C85
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78C3284697;
	Tue, 15 Apr 2025 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="FdYpkC8r"
X-Original-To: bpf@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07E51624CE;
	Tue, 15 Apr 2025 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708213; cv=none; b=U6rL9J/luxsZK1G2rf+G+py1CBb1g3NqvVtTyrlCqWObPiJsHEX3Tyf0Y4CZ0DxbmBa1OBs6A7e2LbOAU8xkrJKmm6s1Q8Bo1eu7EMp4Xds9tU9qkNdYdOM7WDrx6uPS76XN6PHVzxYI24sLFtQErAZoS9qjUT8MccwS9Oa+ab0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708213; c=relaxed/simple;
	bh=h2ArVH3qZFGXjdMX8JG6QGs7L/Tfo41LxNCQU2OMTBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkO4c7ly+QemX53s724CAgcLryZDoFDR4Q/k2nmIx8XLEPFWEc8DzDaRIjquZPc+EgbBu/5coAQDfQhmsBgasr7rC+2yAePKW22vQrY3t+vyHQz6BwxdLGCUFLg0w8++dMH1Srx7GSpCCxDuXCqwZk9LRdcXoqGtIKSwqhsSsDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=FdYpkC8r; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id C9DDF200CCEB;
	Tue, 15 Apr 2025 11:10:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be C9DDF200CCEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1744708202;
	bh=eQufNntKfiHJqzsIZr8O0/rtd7FT0xn0S2YrcLl34kI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FdYpkC8rMJkBVj1bXwAPxx4JiDcZ6DpAMA0O8lNf+yg8ZnnBcpMcPO5nM4ByYUXeF
	 bc+p22UWjqM+En1zCAuPgelRf5tHX8ejJRDzMZppiDsDpd+b+SgcZ5c1dbiXL1dCzV
	 Bl3dagddNHjIcPmrWXmlg8yGo9tC/HetcpDJ10L/WOJ0JThpfYpZ98UsAeLIyQy5Nh
	 bzkYvijjW8WxwFUyAWctwMe9KK8ul6LHoCQqJxVXMSl8FrmZq60qhb4Y/8T51eaTky
	 t6NMTw95FwCMwKnxNakpBQeZ7XPpZI4g2KF0BZo78Nc333/aEwez7aXFCbl5b6Sr/f
	 7HETdTlM25kXA==
Message-ID: <3cee5141-c525-4e83-830e-bf21828aed51@uliege.be>
Date: Tue, 15 Apr 2025 11:10:01 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: lwtunnel: disable preemption when required
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Sebastian Sewior <bigeasy@linutronix.de>,
 Stanislav Fomichev <stfomichev@gmail.com>,
 Network Development <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 bpf <bpf@vger.kernel.org>, Stefano Salsano <stefano.salsano@uniroma2.it>,
 Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
References: <20250403083956.13946-1-justin.iurman@uliege.be>
 <Z-62MSCyMsqtMW1N@mini-arch> <cb0df409-ebbf-4970-b10c-4ea9f863ff00@uliege.be>
 <CAADnVQLiM5MA3Xyrkqmubku6751ZPrDk6v-HmC1jnOaL47=t+g@mail.gmail.com>
 <20250404141955.7Rcvv7nB@linutronix.de>
 <85eefdd9-ec5d-4113-8a50-5d9ea11c8bf5@uliege.be>
 <CAADnVQK7vNPbMS7T9TUOW7s6HNbfr4H8CWbjPgVXW7xa+ybPsw@mail.gmail.com>
 <d326726d-7050-4e88-b950-f49cf5901d34@uliege.be>
 <20250415025416.0273812f0322a6b1728d9c7b@uniroma2.it>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20250415025416.0273812f0322a6b1728d9c7b@uniroma2.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/25 02:54, Andrea Mayer wrote:> I have been looking into the 
behavior of the lwtunnel_xmit() function in both
> task and softirq contexts. To facilitate this investigation, I have written a
> simple eBPF program that only prints messages to the trace pipe. This program
> is attached to the LWT BPF XMIT hook by configuring a route (on my test node)
> with a destination address (DA) pointing to an external node, referred to as
> x.x.x.x, within my testbed network.
> 
> To trigger that LWT BPF XMIT instance from a softirq context, it is sufficient
> to receive (on the test node) a packet with a DA matching x.x.x.x. This packet
> is then processed through the forwarding path, eventually leading to the
> ip_output() function. Processing ends with a call to ip_finish_output2(), which
> then calls lwtunnel_xmit().
> 
> Below is the stack trace from my testing machine, highlighting the key
> functions involved in this processing path:
> 
>   ============================================
>    <IRQ>
>    ...
>    lwtunnel_xmit+0x18/0x3f0
>    ip_finish_output2+0x45a/0xcc0
>    ip_output+0xe2/0x380
>    NF_HOOK.constprop.0+0x7e/0x2f0
>    ip_rcv+0x4bf/0x4d0
>    __netif_receive_skb_one_core+0x11c/0x130
>    process_backlog+0x277/0x980
>    __napi_poll.constprop.0+0x58/0x260
>    net_rx_action+0x396/0x6e0
>    handle_softirqs+0x116/0x640
>    do_softirq+0xa9/0xe0
>    </IRQ>
>   ============================================
> 
> Conversely, to trigger lwtunnel_xmit() from the task context, simply ping
> x.x.x.x on the same testing node. Below is the corresponding stack trace:
> 
>   ============================================
>    <TASK>
>    ...
>    lwtunnel_xmit+0x18/0x3f0
>    ip_finish_output2+0x45a/0xcc0
>    ip_output+0xe2/0x380
>    ip_push_pending_frames+0x17a/0x200
>    raw_sendmsg+0x9fa/0x1060
>    __sys_sendto+0x294/0x2e0
>    __x64_sys_sendto+0x6d/0x80
>    do_syscall_64+0x64/0x140
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    </TASK>
>   ============================================
> 
> So also for the lwtunnel_xmit(), we need to make sure that the functions
> dev_xmit_recursion{_inc/dec}() and the necessary logic to avoid lwt recursion
> are protected, i.e. inside a local_bh_{disable/enable} block.

That's correct, and I ended up with the same conclusion as yours on the 
possible paths for lwtunnel_xmit() depending on the context (task vs 
irq). Based on your description, we're using a similar approach with 
eBPF :-) Note that paths are similar for lwtunnel_output() (see below).

> In a non-preemptible real-time environment (i.e., when !PREEMPT_RT), the
> in_softirq() expands to softirq_count(), which in turn uses the preempt_count()
> function. On my x86 architecture, preempt_count() accesses the per-CPU
> __preempt_count variable.
> 
> If in_softirq() returns 0, it indicates that no softirqs are currently being
> processed on the local CPU and BH are not disabled. Therefore, following the
> logic above, we disable bottom halves (BH) on that particular CPU.
> 
> However, there is my opinion an issue that can occur: between the check on
> in_softirq() and the call to local_bh_disable(), the task may be scheduled on
> another CPU. As a result, the check on in_softirq() becomes ineffective because
> we may end up disabling BH on a CPU that is not the one we just checked (with
> if (in_softirq()) { ... }).

Hmm, I think it's correct... good catch. I went for this solution to (i) 
avoid useless nested BHs disable calls; and (ii) avoid ending up with a 
spaghetti graph of possible paths with or without BHs disabled (i.e., 
with single entry points, namely lwtunnel_xmit() and lwtunnel_output()), 
which otherwise makes it hard to maintain the code IMO.

So, if we want to follow what Alexei suggests (see his last response), 
we'd need to disable BHs in both ip_local_out() and ip6_local_out(). 
These are the common functions which are closest in depth, and so for 
both lwtunnel_xmit() and lwtunnel_output(). But... at the "cost" of 
disabling BHs even when it may not be required. Indeed, ip_local_out() 
and ip6_local_out() both call dst_output(), which one is usually not 
lwtunnel_output() (and there may not even be a lwtunnel_xmit() to call 
either).

The other solution is to always call local_bh_disable() in both 
lwtunnel_xmit() and lwtunnel_output(), at the cost of disabling BHs when 
they were already. Which was basically -v1 and received a NACK from Alexei.

At the moment, I'm not sure what's best.

