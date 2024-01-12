Return-Path: <bpf+bounces-19414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA2782BB33
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 07:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB441F26832
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 06:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208A65C8EA;
	Fri, 12 Jan 2024 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eGugH5Wn"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1871B28E
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 06:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a413b206-df50-4445-a4de-494339ea1ce6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705040411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3CefQsNxnc4oyPR3RnCTgbsveJDAg5y8po7bcHYoXE=;
	b=eGugH5WneMC3LUSY8pnvckG0sQRCSCeTE8Pl/bt2dIyyMk5x/VenzZHMHbycivuvE+S8jt
	odwR6ppAtTpHHeXYzc1AB13H17MK4tejkjDd3JixZx7D4mMF1BWtkbHKYG+mCjTW7PAaD0
	4SB4xhj6/PSTKQ6KnEpd2GFYMFyUqUs=
Date: Thu, 11 Jan 2024 22:20:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 bpf-next 0/6] bpf: tcp: Support arbitrary SYN Cookie at
 TC.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20231221012806.37137-1-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231221012806.37137-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/20/23 5:28 PM, Kuniyuki Iwashima wrote:
> Under SYN Flood, the TCP stack generates SYN Cookie to remain stateless
> for the connection request until a valid ACK is responded to the SYN+ACK.
> 
> The cookie contains two kinds of host-specific bits, a timestamp and
> secrets, so only can it be validated by the generator.  It means SYN
> Cookie consumes network resources between the client and the server;
> intermediate nodes must remember which nodes to route ACK for the cookie.
> 
> SYN Proxy reduces such unwanted resource allocation by handling 3WHS at
> the edge network.  After SYN Proxy completes 3WHS, it forwards SYN to the
> backend server and completes another 3WHS.  However, since the server's
> ISN differs from the cookie, the proxy must manage the ISN mappings and
> fix up SEQ/ACK numbers in every packet for each connection.  If a proxy
> node goes down, all the connections through it are terminated.  Keeping
> a state at proxy is painful from that perspective.
> 
> At AWS, we use a dirty hack to build truly stateless SYN Proxy at scale.
> Our SYN Proxy consists of the front proxy layer and the backend kernel
> module.  (See slides of LPC2023 [0], p37 - p48)
> 
> The cookie that SYN Proxy generates differs from the kernel's cookie in
> that it contains a secret (called rolling salt) (i) shared by all the proxy
> nodes so that any node can validate ACK and (ii) updated periodically so
> that old cookies cannot be validated and we need not encode a timestamp for
> the cookie.  Also, ISN contains WScale, SACK, and ECN, not in TS val.  This
> is not to sacrifice any connection quality, where some customers turn off
> TCP timestamps option due to retro CVE.
> 
> After 3WHS, the proxy restores SYN, encapsulates ACK into SYN, and forward
> the TCP-in-TCP packet to the backend server.  Our kernel module works at
> Netfilter input/output hooks and first feeds SYN to the TCP stack to
> initiate 3WHS.  When the module is triggered for SYN+ACK, it looks up the
> corresponding request socket and overwrites tcp_rsk(req)->snt_isn with the
> proxy's cookie.  Then, the module can complete 3WHS with the original ACK
> as is.
> 
> This way, our SYN Proxy does not manage the ISN mappings nor wait for
> SYN+ACK from the backend thus can remain stateless.  It's working very
> well for high-bandwidth services like multiple Tbps, but we are looking
> for a way to drop the dirty hack and further optimise the sequences.
> 
> If we could validate an arbitrary SYN Cookie on the backend server with
> BPF, the proxy would need not restore SYN nor pass it.  After validating
> ACK, the proxy node just needs to forward it, and then the server can do
> the lightweight validation (e.g. check if ACK came from proxy nodes, etc)
> and create a connection from the ACK.
> 
> This series allows us to create a full sk from an arbitrary SYN Cookie,
> which is done in 3 steps.
> 
>    1) At tc, BPF prog calls a new kfunc to create a reqsk and configure
>       it based on the argument populated from SYN Cookie.  The reqsk has
>       its listener as req->rsk_listener and is passed to the TCP stack as
>       skb->sk.
> 
>    2) During TCP socket lookup for the skb, skb_steal_sock() returns a
>       listener in the reuseport group that inet_reqsk(skb->sk)->rsk_listener
>       belongs to.
> 
>    3) In cookie_v[46]_check(), the reqsk (skb->sk) is fully initialised and
>       a full sk is created.
> 
> The kfunc usage is as follows:
> 
>      struct bpf_tcp_req_attrs attrs = {
>          .mss = mss,
>          .wscale_ok = wscale_ok,
>          .rcv_wscale = rcv_wscale, /* Server's WScale < 15 */
>          .snd_wscale = snd_wscale, /* Client's WScale < 15 */
>          .tstamp_ok = tstamp_ok,
>          .rcv_tsval = tsval,
>          .rcv_tsecr = tsecr, /* Server's Initial TSval */
>          .usec_ts_ok = usec_ts_ok,
>          .sack_ok = sack_ok,
>          .ecn_ok = ecn_ok,
>      }
> 
>      skc = bpf_skc_lookup_tcp(...);
>      sk = (struct sock *)bpf_skc_to_tcp_sock(skc);
>      bpf_sk_assign_tcp_reqsk(skb, sk, attrs, sizeof(attrs));
>      bpf_sk_release(skc);
> 
> [0]: https://lpc.events/event/17/contributions/1645/attachments/1350/2701/SYN_Proxy_at_Scale_with_BPF.pdf
> 
> 
> Changes:
>    v7:
>      * Patch 5 & 6
>        * Drop MPTCP support

I think Yonghong's (thanks!) cpuv4 patch 
(https://lore.kernel.org/bpf/20240110051348.2737007-1-yonghong.song@linux.dev/) 
has addressed the issue that the selftest in patch 6 has encountered.

There are some minor comments in v7. Please respin v8 when the cpuv4 patch has 
concluded so that it can kick off the CI also.


