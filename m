Return-Path: <bpf+bounces-68246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AECB55578
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 19:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349A718953DD
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 17:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92EE32142F;
	Fri, 12 Sep 2025 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DeZhgqmK"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DB11DE4CE
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757698200; cv=none; b=GzqE0hVNRKd/xEA3Q6CHnFxxC9pvj6WF0NSjNwMQi+zZZbVLDC+iKX/SV7O8X6VMhv14QA7OMr6Q6MXS6EaeV87QHL69xmj5YIGRDM0q08NubR1jx3CCAItePHGM11gc0m5VfAHqpBALpX9oKtL7IQ+PCotAKayo/wxDb3FTk68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757698200; c=relaxed/simple;
	bh=Z1xFc4kWydanc6mTiHOzn4cmKEU6izxR+7X1a1Lgo3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8zNd5qsrNifHeoK3CS+HRDDxhDbTvA+Dj4XaDDazI34Mm74ozgVGZLyac/Mrsr0b4ykQVSI0DMeoKcWwL3hl+07gsQRP6rm/0Dbn+zqWkiaPYm7IgegtrVI5C3i/ByXw2gMGYkxLVxlqu/75QzrsaA6iBJrKdJb67AOnoT4PJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DeZhgqmK; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <80b309fe-6ba0-4ca5-a0b7-b04485964f5d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757698185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RwQTlkyZSo9/pvc8bk9JLJLXcS+5IKS20oI3BS5xNeg=;
	b=DeZhgqmKh2wTtYqyV2EbZ7nlICrIHLfC1ZZFz7YJakOBKogfBtJKIYcXDvAIsfbBeuZlDr
	kSmUUjnz7yHAMpKFHEACsArwwaadMfdjzc4Nx8DWYJNXgpJ1TkSIFbUiYkZ3ThTp7YCOnV
	QCwIpe2daZC+1TBrCCKsr0E+zzyWOfM=
Date: Fri, 12 Sep 2025 10:29:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 00/14] bpf: Efficient socket destruction
To: Jordan Rife <jordan@jrife.io>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev
 <sdf@fomichev.me>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Aditi Ghag
 <aditi.ghag@isovalent.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250909170011.239356-1-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/9/25 9:59 AM, Jordan Rife wrote:
> MOTIVATION
> ==========
> In Cilium we use SOCK_ADDR hooks (cgroup/connect4, cgroup/sendmsg4, ...)
> to do socket-level load balancing, translating service VIPs to real
> backend IPs. This is more efficient than per-packet service VIP
> translation, but there's a consequence: UDP sockets connected to a stale
> backend will keep trying to talk to it once its gone instead of traffic
> being redirected to an active backend. To bridge this gap, we forcefully
> terminate such sockets from the control plane, forcing applications to
> recreate these sockets and start talking to an active backend. In the
> past, we've used netlink + sock_diag for this purpose, but have started
> using BPF socket iterators coupled with bpf_sock_destroy() in an effort
> to do most dataplane management in BPF and improve the efficiency of
> socket termination. bpf_sock_destroy() was introduced by Aditi for this
> very purpose in [1]. More recently, this kind of forceful socket
> destruction was extended to cover TCP sockets as well so that they more
> quickly receive a reset when the backend they're connected to goes away
> instead of relying on timeouts [2].
> 
> When a backend goes away, the process to destroy all sockets connected
> to that backend looks roughly like this:
> 
> for each network namespace:
>      enter the network namespace
>      create a socket iterator
>      for each socket in the network namespace:
>          run the iterator BPF program:
>              if sk was connected to the backend:
>                  bpf_sock_destroy(sk)
> 
> Clearly, this creates a lot of repeated work, and it became evident in
> scale tests that create many sockets or frequent service backend churn
> that this approach won't scale well.
> 
> For a simple illustration, I set up a scenario where there are one
> hundred different workloads each running in their own network namespace
> and observed the time it took to iterate through all namespaces and
> sockets to destroy a handful of connected sockets in those namespaces.

How many sockets were destroyed?

> I repeated this five times, each time increasing the number of sockets
> in the system's UDP hash by 10x using a script that creates lots of
> connected sockets.
> 
>                      +---------+----------------+
>                      | Sockets | Iteration Time |
>                      +---------+----------------+
>                      | 100     | 6.35ms         |
>                      | 1000    | 4.03ms         |
>                      | 10000   | 20.0ms         |
>                      | 100000  | 103ms          |
>                      | 1000000 | 9.38s          |
>                      +---------+----------------+
>                        Namespaces = 100
>                        [CPU] AMD Ryzen 9 9900X
> 
> Iteration takes longer as more sockets are added. All the while, CPU
> utilization is high with `perf top` showing `bpf_iter_udp_batch` at the
> top:
> 
>    70.58%  [kernel]                 [k] bpf_iter_udp_batch
> 
> Although this example uses UDP sockets, a similar trend should be
> present with TCP sockets and iterators as well. Even low numbers of
> sockets and sub-second times can be problematic in clusters with high
> churn or where a burst of backend deletions occurs.


For TCP, is it possible to abort the connection in BPF_SOCK_OPS_RTO_CB to stop 
the retry? RTO is not a per packet event.

Does it have a lot of UDP connected sockets left to iterate in production?

> 
> This can be slightly improved by doing some extra bookkeeping that lets
> us skip certain namespaces that we know don't contain sockets connected
> to the backend, but in general we're boxed in by three limitations:
> 
> 1. BPF socket iterators scan through every socket in the system's UDP or
>     TCP socket hash tables to find those belonging to the current network
>     namespace, since by default all namespaces share the same set of
>     global tables. As the number of sockets in a system grows, more time
>     will be spent filtering out unrelated sockets. You could use
>     udp_child_hash_entries and tcp_child_ehash_entries to give each

I assume the sockets that need to be destroyed could be in different child 
hashtables (i.e. in different netns) even child_[e]hash is used?

>     namespace its own table and avoid these noisy neighbor effects, but
>     managing this automatically for each workload is tricky, uses more
>     memory than necessary, and still doesn't avoid unnecessary filtering,
>     because...
> 2. ...it's necessary to visit all sockets in a network namespace to find
>     the one(s) you're looking for, since there's no predictible order in
>     the system hash tables. Similar to the last point, this creates
>     unnecessary work.
> 3. bpf_sock_destroy() only works from BPF socket iterator contexts
>     currently.
> 
> OVERVIEW
> ========
> It would be ideal if we could visit only the set of sockets we're
> interested in without lots of wasteful filtering. This patch series
> seeks to enable this with the following changes:
> 
> * Making bpf_sock_destroy() work with BPF_MAP_TYPE_SOCKHASH map
>    iterators.
> * Enabling control over bucketing behavior of BPF_MAP_TYPE_SOCKHASH to
>    ensure that all sockets sharing the same key prefix are grouped in
>    the same bucket.
> * Adding a key prefix filter to BPF_MAP_TYPE_SOCKHASH map iterators that
>    limits iteration to only the bucket containing keys with the given
>    prefix, and therefore, a single bucket.
> * A new sockops event, BPF_SOCK_OPS_UDP_CONNECTED_CB, that allows us to
>    automatically insert connected UDP sockets into a
>    BPF_MAP_TYPE_SOCKHASH in the same way
>    BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB does for connect()ed TCP sockets.
> 
> This gives us the means to maintain a socket index where we can
> efficiently retrieve and destroy the set of sockets sharing some common
> property, in our case the backend address, without any additional
> iteration or filtering.
> 
> The basic idea looks like this:
> 
> * `map_extra` may be used to specify the number of bytes from the key
>    that a BPF_MAP_TYPE_SOCKHASH uses to determine a socket's hash bucket.
> 
>    ```
>    struct sock_hash_key {
>            __u32 bucket_key;
>            __u64 cookie;
>    } __packed;
> 
>    struct {
>            __uint(type, BPF_MAP_TYPE_SOCKHASH);
>            __uint(max_entries, 16);
>            __ulong(map_extra, offsetof(struct sock_hash_key, cookie));
>            __type(key, struct sock_hash_key);
>            __type(value, __u64);
>    } sock_hash SEC(".maps");
>    ```
> 
>    In this example, all keys sharing the same `bucket_key` would be
>    bucketed together. In our case, `bucket_key` would be replaced with a
>    backend ID or (destination address, port) tuple.

Before diving into the discussion whether it is a good idea to add another key 
to a bpf hashmap, it seems that a hashmap does not actually fit your use case. A 
different data structure (or at least a different way of grouping sk) is needed. 
Have you considered using the bpf_list_head/bpf_rb_root/bpf_arena? Potentially, 
the sk could be stored as a __kptr but I don't think it is supported yet, aside 
from considerations when sk is closed, etc. However, it can store the numeric 
ip/port and then use the bpf_sk_lookup helper, which can take netns_id. 
Iteration could potentially be done in a sleepable SEC("syscall") program in 
test_prog_run, where lock_sock is allowed. TCP sockops has a state change 
callback (i.e. for tracking TCP_CLOSE) but connected udp does not have it now.

> * `key_prefix` may be used to parametrize a BPF_MAP_TYPE_SOCKHASH map
>    iterator so that it only visits the bucket matching that key prefix.
> 
>    ```
>    union bpf_iter_link_info {
>            struct {
>                   __u32 map_fd;
>                   union {
>                           /* Parameters for socket hash iterators. */
>                           struct {
>                                    __aligned_u64 key_prefix;
>                                    __u32         key_prefix_len;
>                           } sock_hash;
> 	         };
>            } map;
> 	...
>    };
>    ```
> * The contents of the BPF_MAP_TYPE_SOCKHASH are automatically managed
>    using a sockops program that inserts connected TCP and UDP sockets
>    into the map.
> 



