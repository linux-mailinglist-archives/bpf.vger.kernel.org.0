Return-Path: <bpf+bounces-69089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ECCB8BFE7
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 07:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0761BC7550
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 05:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59F922B584;
	Sat, 20 Sep 2025 05:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i5jt548H"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E5F1EDA0F
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 05:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758346565; cv=none; b=nji74jlq1ooBQKaAbUQUYE54ld5XnkIAIKWBCaGouXe9f8ynZyGeFCZ9kNoAsHBlww2ccOncv7CampvVjO5CcW4JrJ27D0vsy9vSQpACoy0+BEeOvaAUo177eWdnSeQtz63CSTn+POuBO2IH8Y2le0T3e8tUwbKGb2Gw695UjEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758346565; c=relaxed/simple;
	bh=6GUSGhH7iH6qlbzKQTJqLsT/G5+ZBbV5Qiet3tAaEss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xk/ZcocnniZgzLlqca1jR3uboA4Hi9xEON4IoKPgLoj7w6Uwn7fgyIEiJqb3XdkFSV62RJ3e0D9Ov9NdV4sjDBvU+P8vRaxin4KaEDksBiFkQagTdgsCvuxrAzeVxh09kTGTxWMqUhZwC4yC5WHyBrjWKGpoW1wtFKEx24n8a5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i5jt548H; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Sep 2025 22:35:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758346560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A8oShWp+jyYTmS3lFg8b1TLwM872xRV/IX2A9bRG5Zs=;
	b=i5jt548HiVx2xm8O+ycp2nEyTRBRWOcMY7teFd/oprs/Gp5/5JF7LqjqlzeHDiHcUeuWIV
	1zCq2qT3KZG3yoXbmDp/QLGB7S4eSnCSHTquLTlqyCkhv5AYMzlrr9ARraqy2mVRNFV6pP
	+iMoAUM0hukuaKamYH5gcJZ9bvQoMuQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v10 bpf-next/net 3/6] net-memcg: Introduce
 net.core.memcg_exclusive sysctl.
Message-ID: <bn7f2mwrkbdfhyodf74nfx6qnbpfmqm2gzkgvnuulcq3ha6sib@2oxhp2xgfwha>
References: <20250920000751.2091731-1-kuniyu@google.com>
 <20250920000751.2091731-4-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920000751.2091731-4-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Sep 20, 2025 at 12:07:17AM +0000, Kuniyuki Iwashima wrote:
> If net.core.memcg_exclusive is 1 when sk->sk_memcg is allocated,
> the socket is flagged with SK_MEMCG_EXCLUSIVE internally and skips
> the global per-protocol memory accounting.
> 
> OTOH, for accept()ed child sockets, this flag is inherited from
> the listening socket in sk_clone_lock() and set in __inet_accept().
> This is to preserve the decision by BPF which will be supported later.
> 
> Given sk->sk_memcg can be accessed in the fast path, it would
> be preferable to place the flag field in the same cache line as
> sk->sk_memcg.
> 
> However, struct sock does not have such a 1-byte hole.
> 
> Let's store the flag in the lowest bit of sk->sk_memcg and check
> it in mem_cgroup_sk_exclusive().
> 
> Tested with a script that creates local socket pairs and send()s a
> bunch of data without recv()ing.
> 
> Setup:
> 
>   # mkdir /sys/fs/cgroup/test
>   # echo $$ >> /sys/fs/cgroup/test/cgroup.procs
>   # sysctl -q net.ipv4.tcp_mem="1000 1000 1000"
> 
> Without net.core.memcg_exclusive, charged to memcg & tcp_mem:
> 
>   # prlimit -n=524288:524288 bash -c "python3 pressure.py" &
>   # cat /sys/fs/cgroup/test/memory.stat | grep sock
>   sock 22642688 <-------------------------------------- charged to memcg
>   # cat /proc/net/sockstat| grep TCP
>   TCP: inuse 2006 orphan 0 tw 0 alloc 2008 mem 5376 <-- charged to tcp_mem
>   # ss -tn | head -n 5
>   State Recv-Q Send-Q Local Address:Port  Peer Address:Port
>   ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:53188
>   ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:49972
>   ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:53868
>   ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:53554
>   # nstat | grep Pressure || echo no pressure
>   TcpExtTCPMemoryPressures        1                  0.0
> 
> With net.core.memcg_exclusive=1, only charged to memcg:
> 
>   # sysctl -q net.core.memcg_exclusive=1
>   # prlimit -n=524288:524288 bash -c "python3 pressure.py" &
>   # cat /sys/fs/cgroup/test/memory.stat | grep sock
>   sock 2757468160 <------------------------------------ charged to memcg
>   # cat /proc/net/sockstat | grep TCP
>   TCP: inuse 2006 orphan 0 tw 0 alloc 2008 mem 0 <- NOT charged to tcp_mem
>   # ss -tn | head -n 5
>   State Recv-Q Send-Q  Local Address:Port  Peer Address:Port
>   ESTAB 111000 0           127.0.0.1:36019    127.0.0.1:49026
>   ESTAB 110000 0           127.0.0.1:36019    127.0.0.1:45630
>   ESTAB 110000 0           127.0.0.1:36019    127.0.0.1:44870
>   ESTAB 111000 0           127.0.0.1:36019    127.0.0.1:45274
>   # nstat | grep Pressure || echo no pressure
>   no pressure
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v8: Fix build failure when CONFIG_NET=n
> ---
>  Documentation/admin-guide/sysctl/net.rst |  9 ++++++
>  include/net/netns/core.h                 |  3 ++
>  include/net/sock.h                       | 39 ++++++++++++++++++++++--
>  mm/memcontrol.c                          | 12 +++++++-
>  net/core/sock.c                          |  1 +
>  net/core/sysctl_net_core.c               | 11 +++++++
>  net/ipv4/af_inet.c                       |  4 +++
>  7 files changed, 76 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> index 2ef50828aff1..7272194dcf45 100644
> --- a/Documentation/admin-guide/sysctl/net.rst
> +++ b/Documentation/admin-guide/sysctl/net.rst
> @@ -212,6 +212,15 @@ mem_pcpu_rsv
>  
>  Per-cpu reserved forward alloc cache size in page units. Default 1MB per CPU.
>  
> +memcg_exclusive
> +---------------
> +
> +Skip charging socket buffers to the per-protocol global memory accounting
> +(controlled by net.ipv4.tcp_mem, etc) if they are already charged to the
> +cgroup memory controller ("sock" in memory.stat file).
> +
> +Default: 0
> +
>  rmem_default
>  ------------
>  
> diff --git a/include/net/netns/core.h b/include/net/netns/core.h
> index 9b36f0ff0c20..ec511088e67d 100644
> --- a/include/net/netns/core.h
> +++ b/include/net/netns/core.h
> @@ -16,6 +16,9 @@ struct netns_core {
>  	int	sysctl_optmem_max;
>  	u8	sysctl_txrehash;
>  	u8	sysctl_tstamp_allow_data;
> +#ifdef CONFIG_MEMCG
> +	u8	sysctl_memcg_exclusive;
> +#endif

Hmm will this be a system level or namespace level sysctl? Seems like ns
level, any reason to go with netns level?


