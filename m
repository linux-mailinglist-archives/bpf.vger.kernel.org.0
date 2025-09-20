Return-Path: <bpf+bounces-69088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3621B8BFBF
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 07:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A0C587A5B
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 05:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D31F2264B2;
	Sat, 20 Sep 2025 05:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="exiykBpS"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F738FBF6
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 05:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758345946; cv=none; b=uQnHZkG9Eld5nT0NVQJN6oDq88PrPSJffCgn84LHz7gZeFDZCWr13pDdQlH2/kn3psdVSpR1dszSuMAW97QMjoplqLwiZLCiSbEbEsMEm+WXBJF+6ZcZCATIWvFwqJOsyOkxoznYV/rlXjVIxUh/6QGqPemFLU7EtYCuDC26Ptc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758345946; c=relaxed/simple;
	bh=QNE6JwnXly+mWd96aubzzvl60EH9gsf0nIMSgBBVriA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUyc5UiwNwfs8mLSAOxMzgrmnj7ryld6qfaLSEAQ24EAcePK1ippsQwmcUqGaJR6JMJVC9QmgYcrqRYw0ht0RWBC46zIQcLqkvrEoqtXFgfrb3t3oIUIA/4+p/nd/GNeQ86BEKZDrstATlwuYCEz4g8se6KJDy8lxHHN+LJGQ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=exiykBpS; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Sep 2025 22:25:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758345932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D665f2tdr5KdYiTvb8QZC8/mR3WOtZXH7Ffvv+ILTgU=;
	b=exiykBpSN2yFOfd8BuI+zGB8ZyHEJIq21jPMWdyNcNxHHyzm3DJ6JSCQ8DZQ1xZNKVS5xM
	IrCFMsKDL5oy/dTsHJVsb7qfI4sRhfyPQQVhiCnXHpMCo9ygTe1ej45qtRyUNpbY3P+XRd
	1hbb0aa63YW0Vv6f7hzPWLL2hY+NALU=
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
Subject: Re: [PATCH v10 bpf-next/net 2/6] net-memcg: Allow decoupling memcg
 from global protocol memory accounting.
Message-ID: <ddrg3ex7rbogxeacbegm3e7bewb2rmnxccw4jsyhdpdksz2qng@2xbs7jvhzzhk>
References: <20250920000751.2091731-1-kuniyu@google.com>
 <20250920000751.2091731-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920000751.2091731-3-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Sep 20, 2025 at 12:07:16AM +0000, Kuniyuki Iwashima wrote:
> Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> buffers and charge memory to per-protocol global counters pointed to by
> sk->sk_proto->memory_allocated.
> 
> If a socket has sk->sk_memcg, this memory is also charged to memcg as
> "sock" in memory.stat.
> 
> We do not need to pay costs for two orthogonal memory accounting
> mechanisms.  A microbenchmark result is in the subsequent bpf patch.
> 
> Let's decouple sockets under memcg from the global per-protocol memory
> accounting if mem_cgroup_sk_exclusive() returns true.
> 
> Note that this does NOT disable memcg, but rather the per-protocol one.
> 
> mem_cgroup_sk_exclusive() starts to return true in the following patches,
> and then, the per-protocol memory accounting will be skipped.
> 
> In __inet_accept(), we need to reclaim counts that are already charged
> for child sockets because we do not allocate sk->sk_memcg until accept().
> 
> trace_sock_exceed_buf_limit() will always show 0 as accounted for the
> memcg-exclusive sockets, but this can be obtained in memory.stat.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Nacked-by: Johannes Weiner <hannes@cmpxchg.org>

This looks good to me now, let's ask Johannes to take a look again and if
he still has any concerns.

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

