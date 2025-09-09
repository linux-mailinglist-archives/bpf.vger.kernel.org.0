Return-Path: <bpf+bounces-67909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C227B503C5
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 19:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9348A7AAD63
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C793136CC8D;
	Tue,  9 Sep 2025 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="JsgrpyGe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA0E362062
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437225; cv=none; b=bqVqwiKrerIxUCY8t2Bk/855BwHc86wvq9EsdQ1/lNt3a1WalgDrVcP3siUdQA8uT3qvy+1i5kDT5ZfS5/mK9zoQVo8mWraX3ocoHVZccWCgDxQSNXJbPeRdjtSJ5JsKmhmoisboFAMgYPaV2EGn0vLbz9G6bvVllX+xun72gds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437225; c=relaxed/simple;
	bh=dJIab5j+1C7ih06UneKl/sFuXu89UJz1T56aE8cIn6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lHCY5Z/TFFKfhNFmBPCJpLeBFtYYyRj4v3CQFB7VRGhp8EbxskPjckOy+KqHHX+ULWZcGTaWavoH0n/2FdZE66etqig2nlh4zypSFeOG5WK7JDLpjZNZZo0FzdDz3PzKxnFlv8EFwfz0/7RueRjmkEJDuU8EQ4GfQytz2gA0q4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=JsgrpyGe; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b520539e95bso488897a12.3
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437221; x=1758042021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HjLSgY7Xj98L3yWJwAaqLxtdGuKBUK0ssqAZ2uBwQwc=;
        b=JsgrpyGeu63jjCYawV3Uo85qFcV+skYSxjaEywxkLQLr94LvAG+Axtm/68mhpKkciu
         q6fQlHOKpyEPElHJURoYuH55ROYMfWa8dnpKrmyMJNzPaLT0PSVk6E03BdLwZoBHE7EK
         0iQdANC+o2QTPU6CQ+bQa5sIw5F2DgJKNC4RZMWFqgyqYvqlrnwQYSRD+oz1m4TRAfJr
         RbJ38rI1xR2k+D8MUIew9CXaMWBfFIfG9jskIlDu33CwXaTUOooVDrk/DVxeKsltf/AI
         u4q3TYoy5j1fRH2JkbGyfuqmfKwW0gWLog298wEAGmEXeoP5l9RnRj9q+UDQ1R92BYX3
         1xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437221; x=1758042021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjLSgY7Xj98L3yWJwAaqLxtdGuKBUK0ssqAZ2uBwQwc=;
        b=do+L6qG+yL7DTXoGLPK7UMpd70/gdKwT8CF2e7hDI0JMwaUOLoi2ZECEf/5wNn9iov
         sEAgajBvpcLS/3SzUWpy0QVAY9jn3dw4PS674d3QAOPVd4DIeKX57TCYMlznRYOdh3yW
         CaKSu3tL3XQbUNCUEPAcGbyRsHNN/qt2TIxul4vyHS7NJrFthgL/w/tDMaZFw/EWkizH
         8JLsuAZMW5gOYUW0KJHGfUXOvhs1EzBlumLpJk9xMpPsZ0AlVXENbOn2/c2T53PW8Wqo
         dBWMehI9aFJotDIvlBqWEGT1RJiy+A8bjh/JFvdsQ9ZHZAQBG/o2tmCQQt19B7GGGKUR
         lpbA==
X-Gm-Message-State: AOJu0YwFZqKPEYLgsRjHWl8peKcLHoDwjFMNbfDvXn1fCakz/24q7Kcn
	73BZ25LgFZEjfFjjVwuH+nqrc5uKT5l/Rq1cOpOPQdWIyxM7BgXVSq8ZGFa5uEJX6jVi3ov2p/4
	lMtss
X-Gm-Gg: ASbGnctLrQhrIOtv4d4bgBiQ1CMXAabCmdLht2vojb6NUgBKdVxnIzKxYm+vrZxWX9i
	/02c8/gJmf8xZSuiW2TLg1ezFLGFYI9AqoZg7YZw1JrpkG3qwuwbuGefFH1/4vYVM9rfius9QjL
	jHRdKZGckOyVe+6/O1L9qjhx3rGcQSIuYXDHXLw+f8vscWP92R1T+pisbOVzfwKqHHXbfBzeH2g
	ulW7EzKzCsGufx9QMvIgDQr0hzzt3wO072dxcjmnzymgrLZ9boPnWydCSzG5Lbw0Wg+HGPHMrRL
	9HAezefkvRnsDbJT/ngpcTkQSlfySwQY5bREMpgtupffNFfKaama+Z0nuXoSsNC8jJWb2IJCoBT
	mELmgB/swjIELzoDDzGe4pw1EDb5IVIBtQwM=
X-Google-Smtp-Source: AGHT+IGlc0VUwt90tiL1X0fXzTJQTe3dmhTtm3a56wxKj35Rs9roFJ5fdvAmK4DuDTnPpCReBc3Uzg==
X-Received: by 2002:a05:6a20:6a25:b0:24e:ced1:d93 with SMTP id adf61e73a8af0-25344db73e9mr9488093637.4.1757437221119;
        Tue, 09 Sep 2025 10:00:21 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:20 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 00/14] bpf: Efficient socket destruction
Date: Tue,  9 Sep 2025 09:59:54 -0700
Message-ID: <20250909170011.239356-1-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MOTIVATION
==========
In Cilium we use SOCK_ADDR hooks (cgroup/connect4, cgroup/sendmsg4, ...)
to do socket-level load balancing, translating service VIPs to real
backend IPs. This is more efficient than per-packet service VIP
translation, but there's a consequence: UDP sockets connected to a stale
backend will keep trying to talk to it once its gone instead of traffic
being redirected to an active backend. To bridge this gap, we forcefully
terminate such sockets from the control plane, forcing applications to
recreate these sockets and start talking to an active backend. In the
past, we've used netlink + sock_diag for this purpose, but have started
using BPF socket iterators coupled with bpf_sock_destroy() in an effort
to do most dataplane management in BPF and improve the efficiency of
socket termination. bpf_sock_destroy() was introduced by Aditi for this
very purpose in [1]. More recently, this kind of forceful socket
destruction was extended to cover TCP sockets as well so that they more
quickly receive a reset when the backend they're connected to goes away
instead of relying on timeouts [2].

When a backend goes away, the process to destroy all sockets connected
to that backend looks roughly like this:

for each network namespace:
    enter the network namespace
    create a socket iterator 
    for each socket in the network namespace:
        run the iterator BPF program:
            if sk was connected to the backend:
                bpf_sock_destroy(sk)

Clearly, this creates a lot of repeated work, and it became evident in
scale tests that create many sockets or frequent service backend churn
that this approach won't scale well.

For a simple illustration, I set up a scenario where there are one
hundred different workloads each running in their own network namespace
and observed the time it took to iterate through all namespaces and
sockets to destroy a handful of connected sockets in those namespaces.
I repeated this five times, each time increasing the number of sockets
in the system's UDP hash by 10x using a script that creates lots of
connected sockets.

                    +---------+----------------+
                    | Sockets | Iteration Time |
                    +---------+----------------+
                    | 100     | 6.35ms         |
                    | 1000    | 4.03ms         |
                    | 10000   | 20.0ms         |
                    | 100000  | 103ms          |
                    | 1000000 | 9.38s          |
                    +---------+----------------+
                      Namespaces = 100
                      [CPU] AMD Ryzen 9 9900X

Iteration takes longer as more sockets are added. All the while, CPU
utilization is high with `perf top` showing `bpf_iter_udp_batch` at the
top:

  70.58%  [kernel]                 [k] bpf_iter_udp_batch

Although this example uses UDP sockets, a similar trend should be
present with TCP sockets and iterators as well. Even low numbers of
sockets and sub-second times can be problematic in clusters with high
churn or where a burst of backend deletions occurs.

This can be slightly improved by doing some extra bookkeeping that lets
us skip certain namespaces that we know don't contain sockets connected
to the backend, but in general we're boxed in by three limitations:

1. BPF socket iterators scan through every socket in the system's UDP or
   TCP socket hash tables to find those belonging to the current network
   namespace, since by default all namespaces share the same set of
   global tables. As the number of sockets in a system grows, more time
   will be spent filtering out unrelated sockets. You could use
   udp_child_hash_entries and tcp_child_ehash_entries to give each
   namespace its own table and avoid these noisy neighbor effects, but
   managing this automatically for each workload is tricky, uses more
   memory than necessary, and still doesn't avoid unnecessary filtering,
   because...
2. ...it's necessary to visit all sockets in a network namespace to find
   the one(s) you're looking for, since there's no predictible order in
   the system hash tables. Similar to the last point, this creates
   unnecessary work.
3. bpf_sock_destroy() only works from BPF socket iterator contexts
   currently.

OVERVIEW
========
It would be ideal if we could visit only the set of sockets we're
interested in without lots of wasteful filtering. This patch series
seeks to enable this with the following changes:

* Making bpf_sock_destroy() work with BPF_MAP_TYPE_SOCKHASH map 
  iterators.
* Enabling control over bucketing behavior of BPF_MAP_TYPE_SOCKHASH to
  ensure that all sockets sharing the same key prefix are grouped in
  the same bucket.
* Adding a key prefix filter to BPF_MAP_TYPE_SOCKHASH map iterators that
  limits iteration to only the bucket containing keys with the given
  prefix, and therefore, a single bucket.
* A new sockops event, BPF_SOCK_OPS_UDP_CONNECTED_CB, that allows us to
  automatically insert connected UDP sockets into a
  BPF_MAP_TYPE_SOCKHASH in the same way
  BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB does for connect()ed TCP sockets.

This gives us the means to maintain a socket index where we can
efficiently retrieve and destroy the set of sockets sharing some common
property, in our case the backend address, without any additional
iteration or filtering.

The basic idea looks like this:

* `map_extra` may be used to specify the number of bytes from the key
  that a BPF_MAP_TYPE_SOCKHASH uses to determine a socket's hash bucket.

  ```
  struct sock_hash_key {
          __u32 bucket_key;
          __u64 cookie;
  } __packed;

  struct {
          __uint(type, BPF_MAP_TYPE_SOCKHASH);
          __uint(max_entries, 16);
          __ulong(map_extra, offsetof(struct sock_hash_key, cookie));
          __type(key, struct sock_hash_key);
          __type(value, __u64);
  } sock_hash SEC(".maps");
  ```

  In this example, all keys sharing the same `bucket_key` would be
  bucketed together. In our case, `bucket_key` would be replaced with a
  backend ID or (destination address, port) tuple.
* `key_prefix` may be used to parametrize a BPF_MAP_TYPE_SOCKHASH map
  iterator so that it only visits the bucket matching that key prefix. 

  ```
  union bpf_iter_link_info {
          struct {
                 __u32 map_fd;
                 union {
                         /* Parameters for socket hash iterators. */
                         struct {
                                  __aligned_u64 key_prefix;
                                  __u32         key_prefix_len;
                         } sock_hash;
	         };
          } map;
	...
  };
  ```
* The contents of the BPF_MAP_TYPE_SOCKHASH are automatically managed
  using a sockops program that inserts connected TCP and UDP sockets
  into the map.

SERIES STRUCTURE
================
* Part one makes bpf_sock_destroy() usable from BPF_MAP_TYPE_SOCKHASH
  and BPF_MAP_TYPE_SOCKMAP map iterators culimnating in the expansion of
  the existing bpf_sock_destroy() selftests to cover its use from these
  new contexts. I was unsure about whether or not to include the changes
  to BPF_MAP_TYPE_SOCKMAP, since the use case I describe above would
  only make use of BPF_MAP_TYPE_SOCKHASH, but it felt strange to make
  one compatible with bpf_sock_destroy() and not the other. So, for now
  I've included it in this series.
* Part two enables key prefix-based bucketing control and map iterator
  filtering for BPF_MAP_TYPE_SOCKHASH, making it possible to efficiently
  iterate through and destroy a set of sockets whose keys share a common
  prefix.
* Part three introduces the BPF_SOCK_OPS_UDP_CONNECTED_CB sockops
  callback, a new event that happens at the end of connect() for UDP
  sockets. Again, I was on the fence about whether or not I wanted to
  include this in the series, since it feels like it could be its own
  standalone change, but ultimately to make the other changes useful
  there needs to be a way to automatically manage the contents of the
  BPF_MAP_TYPE_SOCKHASH for connect()ed UDP sockets in the same way that
  BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB works for TCP sockets. I've added
  this to the end of the series along with a set of tests that show the
  desired end-to-end flow from insertion of TCP and UDP sockets into the
  map to iteration and destruction using a key prefix filter.

COMPARISON
==========
Using the same experiment as before...

      +---------+----------------------+----------------------+
      | Sockets | Iteration Time (Old) | Iteration Time (New) |
      +---------+----------------------+----------------------+
      | 100     | 6.35ms               | 54.2us               |
      | 1000    | 4.03ms               | 43.7us               |
      | 10000   | 20.0ms               | 44.1us               |
      | 100000  | 103ms                | 40.8us               |
      | 1000000 | 9.38s                | 47.6us               |
      +---------+---------------------------------------------+
        Namespaces = 100
        [CPU] AMD Ryzen 9 9900X

...iteration time remained constant regardless of the number of sockets
that exist, and even comparing with the best case time (4.03ms) for
destruction using socket iterators, the map-based approach was ~98%
faster. As a secondary benefit, this also simplifies the control plane
and iterator program logic, as we don't need to worry about iterating
through different namespaces or filtering.

                  +---------+--------------------+
                  | Sockets | Memory Utilization |
                  +---------+--------------------+
                  | 100     | 16.0MiB            |
                  | 1000    | 16.0MiB            |
                  | 10000   | 16.7MiB            |
                  | 100000  | 22.7MiB            |
                  | 1000000 | 84.7MiB            |
                  +---------+--------------------+
                    key_size    = 16B
                    max_entries = 1 << 20

Looking at memory, a socket hash with `1 << 20` max_entries uses
~16.0MiB empty and ~84.7MiB with 1000000 entries (almost full), which
seems like a decent compute/memory tradeoff.

One possible drawback/concern of this approach is that, if you're not
careful, low key prefix cardinality can lead to large buckets and slow
down connect() calls. I encountered this situation while running these
tests when I accidentally created thousands of UDP sockets connected to
the same (addr, port) tuple and saw connect() calls take longer and
longer, since all sockets were added to the same bucket. In practice,
I'm not sure how much of a concern this is, but it's certainly possible
to slow down connect() for certain endpoint addresses this way. Further
partitioning could be done by adding new dimensions to the keys, e.g.
network namespace cookie, to better mitigate and isolate these effects
if needed.

Thanks for any feedback!

Jordan

[1]: https://lore.kernel.org/bpf/20230519225157.760788-1-aditi.ghag@isovalent.com/
[2]: https://github.com/cilium/cilium/pull/40304

Jordan Rife (14):
  bpf: Use reference counting for struct bpf_shtab_elem
  bpf: Hold socket lock in socket hash iterator
  bpf: Hold socket lock in socket map iterator
  bpf: Mark sk as PTR_TRUSTED in sockmap iterator context
  selftests/bpf: Test bpf_sock_destroy() with sockmap iterators
  bpf: Enable precise bucketing control for socket hashes
  bpf: Support key prefix filtering for socket hash iterators
  selftests/bpf: Fix off by one error in remove_all_established
  selftests/bpf: Test socket hash iterator resume scenarios
  selftests/bpf: Socket map + sockops insert and destroy
  bpf: Introduce BPF_SOCK_OPS_UDP_CONNECTED_CB
  bpf: Allow bpf_sock_(map|hash)_update from
    BPF_SOCK_OPS_UDP_CONNECTED_CB
  selftests/bpf: Extend insert and destroy tests for UDP sockets
  bpf, doc: Document map_extra and key prefix filtering for socket hash

 Documentation/bpf/bpf_iterators.rst           |  11 +
 Documentation/bpf/map_sockmap.rst             |   6 +
 include/linux/bpf.h                           |   4 +
 include/net/udp.h                             |  43 ++
 include/uapi/linux/bpf.h                      |  10 +
 kernel/bpf/syscall.c                          |   1 +
 net/core/sock_map.c                           | 326 ++++++++++++---
 net/ipv4/udp.c                                |   1 +
 net/ipv6/udp.c                                |   1 +
 tools/include/uapi/linux/bpf.h                |  10 +
 .../selftests/bpf/prog_tests/sock_destroy.c   | 119 +++++-
 .../bpf/prog_tests/sock_iter_batch.c          | 121 +++++-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 387 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_iter_sockmap.c    |  14 +
 .../selftests/bpf/progs/sock_destroy_prog.c   |  63 +++
 .../selftests/bpf/progs/sock_iter_batch.c     |  31 ++
 .../selftests/bpf/progs/test_sockmap_update.c |  44 ++
 17 files changed, 1102 insertions(+), 90 deletions(-)

-- 
2.43.0


