Return-Path: <bpf+bounces-51066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC8BA2FE7E
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 00:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0829162FAD
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 23:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2737025A2AD;
	Mon, 10 Feb 2025 23:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qHdmZz6B"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81EB249F9
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739230652; cv=none; b=SFskAl8wmHm7Kyuqj+lfjwj2Icm7NaGxuHBhLjn/yV6G8zvE3oN3OAJcwxgGsJxOcnM/3XvN2+qlFsRS5RYxRzLgDR2kBJo1iSP56QO4RUyXlDTbSyH/yL1xlMnwraw/1rBQE9PYAzGcjm4yggGbVq7T38K7mY9S0GZ2ur+usmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739230652; c=relaxed/simple;
	bh=1qtdn71ObmNp9aZBVtrHNeaseGZ29P4U495yM4Hk614=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYSMkxFouD3aXxSCGdBQOS8uW1CuW6+KzR46wKGy8exj1w4pWODrYeOC82PfxMsBcQNSAIjQJH6oknP0dqan/ZuXrjx/wFaq/H53SkwzY+xmPkjKeuu4KvU033AJsef8jpdBR7QTkuYKOR3v88QFne4SuGpiBrjMekNS2jK6kIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qHdmZz6B; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a483c1dd-f593-4f6b-9afe-bfb6d43647bf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739230647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LoxrzS3D8x66wVSwChufAa4JKS4tQcWHhbVBM+VizHo=;
	b=qHdmZz6BkihEfFJQPCLSythTec0ZxYsj15eya/WS4hdXQ/sK11Q9mInWFzDedpfukuC4Tr
	V9/Lv8BFR15kAVRNAwI0gAv2hqTLOFBkIDDV17No2b1iBytR7s9Jzrqs+VtuDJ3uH/hPCY
	hTbhGXUneag0fDU0i06CFn+EllVs4Kk=
Date: Mon, 10 Feb 2025 15:37:19 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 00/12] net-timestamp: bpf extension to equip
 applications transparently
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250208103220.72294-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/8/25 2:32 AM, Jason Xing wrote:
> "Timestamping is key to debugging network stack latency. With
> SO_TIMESTAMPING, bugs that are otherwise incorrectly assumed to be
> network issues can be attributed to the kernel." This is extracted
> from the talk "SO_TIMESTAMPING: Powering Fleetwide RPC Monitoring"
> addressed by Willem de Bruijn at netdevconf 0x17).
> 
> There are a few areas that need optimization with the consideration of
> easier use and less performance impact, which I highlighted and mainly
> discussed at netconf 2024 with Willem de Bruijn and John Fastabend:
> uAPI compatibility, extra system call overhead, and the need for
> application modification. I initially managed to solve these issues
> by writing a kernel module that hooks various key functions. However,
> this approach is not suitable for the next kernel release. Therefore,
> a BPF extension was proposed. During recent period, Martin KaFai Lau
> provides invaluable suggestions about BPF along the way. Many thanks
> here!
> 
> In this series, only support foundamental codes and tx for TCP.

typo: fundamental.... This had been brought up before (in v7?).

By fundamental, I suspect you meant (?) bpf timestamping infrastructure, like: 
"This series adds the BPF networking timestamping infrastructure. This series 
also adds TX timestamping support for TCP. The RX timestamping and UDP support 
will be added in the future."

> This approach mostly relies on existing SO_TIMESTAMPING feature, users

It reuses most of the tx timestamping callback that is currently enabled by the 
SO_TIMESTAMPING. However, I don't think there is a lot of overlap in term of the 
SO_TIMESTAMPING api which does feel like API reuse when first reading this comment.

> only needs to pass certain flags through bpf_setsocktopt() to a separate
> tsflags. Please see the last selftest patch in this series.
> 
> ---
> v8
> Link: https://lore.kernel.org/all/20250128084620.57547-1-kerneljasonxing@gmail.com/
> 1. adjust some commit messages and titles
> 2. add sk cookie in selftests
> 3. handle the NULL pointer in hwstamp
> 4. use kfunc to do selective sampling
> 
> v7
> Link: https://lore.kernel.org/all/20250121012901.87763-1-kerneljasonxing@gmail.com/
> 1. target bpf-next tree
> 2. simplely and directly stop timestamping callbacks calling a few BPF
> CALLS due to safety concern.
> 3. add more new testcases and adjust the existing testcases
> 4. revise some comments of new timestamping callbacks
> 5. remove a few BPF CGROUP locks
> 
> RFC v6
> In the meantime, any suggestions and reviews are welcome!
> Link: https://lore.kernel.org/all/20250112113748.73504-1-kerneljasonxing@gmail.com/
> 1. handle those safety problem by using the correct method.
> 2. support bpf_getsockopt.
> 3. adjust the position of BPF_SOCK_OPS_TS_TCP_SND_CB
> 4. fix mishandling the hardware timestamp error
> 5. add more corresponding tests
> 
> v5
> Link: https://lore.kernel.org/all/20241207173803.90744-1-kerneljasonxing@gmail.com/
> 1. handle the safety issus when someone tries to call unrelated bpf
> helpers.
> 2. avoid adding direct function call in the hot path like
> __dev_queue_xmit()
> 3. remove reporting the hardware timestamp and tskey since they can be
> fetched through the existing helper with the help of
> bpf_skops_init_skb(), please see the selftest.
> 4. add new sendmsg callback in tcp_sendmsg, and introduce tskey_bpf used
> by bpf program to correlate tcp_sendmsg with other hook points in patch [13/15].
> 
> v4
> Link: https://lore.kernel.org/all/20241028110535.82999-1-kerneljasonxing@gmail.com/
> 1. introduce sk->sk_bpf_cb_flags to let user use bpf_setsockopt() (Martin)
> 2. introduce SKBTX_BPF to enable the bpf SO_TIMESTAMPING feature (Martin)
> 3. introduce bpf map in tests (Martin)
> 4. I choose to make this series as simple as possible, so I only support
> most cases in the tx path for TCP protocol.
> 
> v3
> Link: https://lore.kernel.org/all/20241012040651.95616-1-kerneljasonxing@gmail.com/
> 1. support UDP proto by introducing a new generation point.
> 2. for OPT_ID, introducing sk_tskey_bpf_offset to compute the delta
> between the current socket key and bpf socket key. It is desiged for
> UDP, which also applies to TCP.
> 3. support bpf_getsockopt()
> 4. use cgroup static key instead.
> 5. add one simple bpf selftest to show how it can be used.
> 6. remove the rx support from v2 because the number of patches could
> exceed the limit of one series.
> 
> V2
> Link: https://lore.kernel.org/all/20241008095109.99918-1-kerneljasonxing@gmail.com/
> 1. Introduce tsflag requestors so that we are able to extend more in the
> future. Besides, it enables TX flags for bpf extension feature separately
> without breaking users. It is suggested by Vadim Fedorenko.
> 2. introduce a static key to control the whole feature. (Willem)
> 3. Open the gate of bpf_setsockopt for the SO_TIMESTAMPING feature in
> some TX/RX cases, not all the cases.
> 
> Jason Xing (12):
>    bpf: add support for bpf_setsockopt()
>    bpf: prepare for timestamping callbacks use
>    bpf: stop unsafely accessing TCP fields in bpf callbacks
>    bpf: stop calling some sock_op BPF CALLs in new timestamping callbacks
>    net-timestamp: prepare for isolating two modes of SO_TIMESTAMPING
>    bpf: support SCM_TSTAMP_SCHED of SO_TIMESTAMPING
>    bpf: support sw SCM_TSTAMP_SND of SO_TIMESTAMPING
>    bpf: support hw SCM_TSTAMP_SND of SO_TIMESTAMPING
>    bpf: support SCM_TSTAMP_ACK of SO_TIMESTAMPING
>    bpf: add a new callback in tcp_tx_timestamp()
>    bpf: support selective sampling for bpf timestamping
>    selftests/bpf: add simple bpf tests in the tx path for timestamping
>      feature
> 
>   include/linux/filter.h                        |   1 +
>   include/linux/skbuff.h                        |  12 +-
>   include/net/sock.h                            |  10 +
>   include/net/tcp.h                             |   5 +-
>   include/uapi/linux/bpf.h                      |  30 ++
>   kernel/bpf/btf.c                              |   1 +
>   net/core/dev.c                                |   3 +-
>   net/core/filter.c                             |  75 ++++-
>   net/core/skbuff.c                             |  48 ++-
>   net/core/sock.c                               |  15 +
>   net/dsa/user.c                                |   2 +-
>   net/ipv4/tcp.c                                |   4 +
>   net/ipv4/tcp_input.c                          |   2 +
>   net/ipv4/tcp_output.c                         |   2 +
>   net/socket.c                                  |   2 +-
>   tools/include/uapi/linux/bpf.h                |  23 ++
>   .../bpf/prog_tests/so_timestamping.c          |  79 +++++
>   .../selftests/bpf/progs/so_timestamping.c     | 312 ++++++++++++++++++
>   18 files changed, 612 insertions(+), 14 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamping.c
>   create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c
> 


