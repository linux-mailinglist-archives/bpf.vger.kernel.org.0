Return-Path: <bpf+bounces-43632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FB59B747D
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 07:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26E4284E95
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 06:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473571465A5;
	Thu, 31 Oct 2024 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D9urGUXf"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CE313DDAE
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730356051; cv=none; b=TxgVxGh59Wexq1F9dmZf5TQz9jmvm1EHebxA47UYjPyp4DqE5M6t4Sqabwan0+ck1+gfP8FnrW1JKsQcFhX2SAAOTT73b+gQu9j7YJc81zXL/K1FhtBFJW8TzIFU/J5NaGWPyHiIwcD1O16RL+qVho/YRbpklJvputN8FHzEKhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730356051; c=relaxed/simple;
	bh=LNnicIiLWUGsYxKk4aqOOgdoeTCcxPTZXfcZIkLSLWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vsfz0NqEUMfHffUCmJ80BDhRr5ShN0K3gZ+015uGNUFV7Tg3d9dCwXihXjNUn4TTydmgDghs03PJluaa5L9oRMBGg4+7Hy6SjuPilBld8jR1CnTY5U/YlLWUI8ry8wOM33dvdBf7XWT7D0lKMKcizEi9VGJozppGUsua5RLYf+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D9urGUXf; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d138a81d-f9f5-4d51-bedd-3916d377699d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730356043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTt0daxcPq5U9kriisaXUUnPi8tyERB4VX2SVL7WQIc=;
	b=D9urGUXfa2UEEUQCdjDhpO6dFznPP+kXX4yRYcuApneDyqXOFvjBK8+tqG1Dz+qLLpo8Di
	7Id/HMCtwmPsInwUJJoXdvJDTxkcuFxAKr06zjm0IMLTV8YgHCpkOz5ZYywDHFTvC3vn8O
	jGgH1J5ZeG3u8olYWkB5wAVFkxJPTi0=
Date: Wed, 30 Oct 2024 23:27:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
To: Jason Xing <kerneljasonxing@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: willemb@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-3-kerneljasonxing@gmail.com>
 <61e8c5cf-247f-484e-b3cc-27ab86e372de@linux.dev>
 <CAL+tcoDB8UvNMfTwmvTJb1JvCGDb3ESaJMszh4-Qa=ey0Yn3Vg@mail.gmail.com>
 <67218fb61dbb5_31d4d029455@willemb.c.googlers.com.notmuch>
 <CAL+tcoBhfZ4XB5QgCKKbNyq+dfm26fPsvXfbWbV=jAEKYeLDEg@mail.gmail.com>
 <67219e5562f8c_37251929465@willemb.c.googlers.com.notmuch>
 <CAL+tcoDonudsr800HmhDir7f0B6cx0RPwmnrsRmQF=yDUJUszg@mail.gmail.com>
 <3c7c5f25-593f-4b48-9274-a18a9ea61e8f@linux.dev>
 <CAL+tcoAy2ryOpLi2am=T68GaFG1ACCtYmcJzDoEOan-0u3aaWw@mail.gmail.com>
 <672269c08bcd5_3c834029423@willemb.c.googlers.com.notmuch>
 <CAL+tcoA7Uddjx3OJzTB3+kqmKRt6KQN4G1VDCbE+xwEhATQpQQ@mail.gmail.com>
 <CAL+tcoDL0by6epqExL0VVMqfveA_awZ3PE9mfwYi3OmovZf3JQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoDL0by6epqExL0VVMqfveA_awZ3PE9mfwYi3OmovZf3JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/30/24 5:13 PM, Jason Xing wrote:
> I realized that we will have some new sock_opt flags like
> TS_SCHED_OPT_CB in patch 4, so we can control whether to print or
> not... For each sock_opt point, they will be called without caring if
> related flags in skb are set. Well, it's meaningless to add more
> control of skb tsflags at each TS_xx_OPT_CB point.
> 
> Am I understanding in a correct way? Now, I'm totally fine with this great idea!
Yes, I think so.

The sockops prog can choose to ignore any BPF_SOCK_OPS_TS_*_CB. The are only 3: 
SCHED, SND, and ACK. If the hwtstamp is available from a NIC, I think it would 
be quite wasteful to throw it away. ACK can be controlled by the 
TCP_SKB_CB(skb)->bpf_txstamp_ack.

Going back to my earlier bpf_setsockopt(SOL_SOCKET, BPF_TX_TIMESTAMPING) 
comment. I think it may as well go back to use the "u8 
bpf_sock_ops_cb_flags;" and use the bpf_sock_ops_cb_flags_set() helper to 
enable/disable the timestamp related callback hook. May be add one 
BPF_SOCK_OPS_TX_TIMESTAMPING_CB_FLAG.

For tx, one new hook should be at the sendmsg and should be around 
tcp_tx_timestamp (?) for tcp. Another hook is __skb_tstamp_tx() which should be 
similar to your patch. Add a new kfunc to set shinfo->tx_flags |= SKBTX_BPF 
and/or TCP_SKB_CB(skb)->bpf_txstamp_ack during sendmsg.


For rx, add one BPF_SOCK_OPS_RX_TIMESTAMPING_CB_FLAG. bpf_sock_ops_cb_flags 
needs to move from the tcp_sock to the sock because it will be used by UDP also. 
When enabling or disabling this flag, it needs to take care of the 
net_{enable,disable}_timestamp. The same for the __sk_destruct() also.


