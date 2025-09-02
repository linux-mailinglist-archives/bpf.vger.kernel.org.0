Return-Path: <bpf+bounces-67224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 491DEB40E8F
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 22:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23251A862EF
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 20:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4533334F466;
	Tue,  2 Sep 2025 20:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e4YUdtjU"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E2345733
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756844819; cv=none; b=ZnK0uFXo3oavoIn5USNxPtOi2gg4Ewbg1D9y4tBx74bfYvUwB+hwqVfouKVWBh1wK9k6ByNBHV7cmO5NYpOJ/kzZQhESR6R2OZAy8hda+8s5LfEGqPqLGTPx5Orof9GEpkxbEh2MrHghsX4pPCpcQY92BpXdD8HHZe16qfIuX0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756844819; c=relaxed/simple;
	bh=xolwOpeTIEl7bNlBNJEyAMGvb0OQ38wfob8QOMCem5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iY+dITAqry11sP8LnXVSezA2pjjjJqboBJ/oJzCh8h2SEyhNBc8Ry2ZTaDOEt9hyHbWezDV6lSnDazAMrlXGM6WLimlqJZ5tgpcO0m/OmEYJ3iLzzYUGVdxIVOZ/xzBqEFmIjNaqoYaVqPRnJvgs2IOyD7onkmooodJFoYNWBUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e4YUdtjU; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <904c1ffb-107e-4f14-89b7-d42ac9a5aa14@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756844806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ94nWEV+/6MS6+T1j2jeofZZK9FFAv+4G5+J+OXcIw=;
	b=e4YUdtjUqWGvMULsTGYhkKRi9v38Ch/ks1BIkiBSkgOF73LrkEEijSNy0qr99SZS7JD8jK
	ixgvkWg8s898+MZHqY0fnAxAK2yB3O/nt7GPkTKxrQDR6SR8OFSisdFldSELhgx2UXLDAq
	I3CCPo2LfSVTmvHq6p6z/RslgUgmoRc=
Date: Tue, 2 Sep 2025 13:26:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next/net 5/5] selftest: bpf: Add test for
 SK_BPF_MEMCG_SOCK_ISOLATED.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250829010026.347440-1-kuniyu@google.com>
 <20250829010026.347440-6-kuniyu@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250829010026.347440-6-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/28/25 6:00 PM, Kuniyuki Iwashima wrote:
> The test does the following for IPv4/IPv6 x TCP/UDP sockets
> with/without BPF prog.
> 
>    1. Create socket pairs
>    2. Send a bunch of data that requires more than 256 pages
>    3. Read memory_allocated from the 3rd column in /proc/net/protocols
>    4. Check if unread data is charged to memory_allocated
> 
> If BPF prog is attached, memory_allocated should not be changed,
> but we allow a small error (up to 10 pages) in case other processes
> on the host use some amounts of TCP/UDP memory.
> 
> At 2., the test actually sends more than 1024 pages because the sysctl
> net.core.mem_pcpu_rsv is 256 is by default, which means 256 pages are
> buffered per cpu before reporting to sk->sk_prot->memory_allocated.
> 
>    BUF_SINGLE (1024) * NR_SEND (64) * NR_SOCKETS (64) / 4096
>    = 1024 pages
> 
> When I reduced it to 512 pages, the following assertion for the
> non-isolated case got flaky.
> 
>    ASSERT_GT(memory_allocated[1], memory_allocated[0] + 256, ...)
> 
> Another contributor to slowness is 150ms sleep to make sure 1 RCU
> grace period passes because UDP recv queue is destroyed after that.

There is a kern_sync_rcu() in testing_helpers.c.

> 
>    # time ./test_progs -t sk_memcg
>    #370/1   sk_memcg/TCP       :OK
>    #370/2   sk_memcg/UDP       :OK
>    #370/3   sk_memcg/TCPv6     :OK
>    #370/4   sk_memcg/UDPv6     :OK
>    #370     sk_memcg:OK
>    Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
> 
>    real	0m1.214s
>    user	0m0.014s
>    sys	0m0.318s

Thanks. It finished much faster in my setup also comparing with the earlier 
revision. However, it is a bit flaky when I run it in a loop:

check_isolated:FAIL:not isolated unexpected not isolated: actual 861 <= expected 861

I usually can hit this at ~40-th iteration.


