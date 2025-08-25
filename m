Return-Path: <bpf+bounces-66448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C214B34C2C
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 22:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56333A6F46
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 20:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B3228751B;
	Mon, 25 Aug 2025 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dIgXY5Uw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CC122128B
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154522; cv=none; b=PDYrvieUOWG3UiWNs/3UujR20ui3L453fH8dLSAswmSImVLXaIturqTk+rXsiroSJY9GuVOumjPhgj4860J5ifqThpiJIkzhbcwbpsrW9NflXzoqvSPHnA51zuUA3zA8lj15E+FQCxJh/gleKUEV1X+VuqDaG+sI/LZ4BBLI1/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154522; c=relaxed/simple;
	bh=kYQAydJ1EbY++ZoDGw98a3TCSnvGYjIyMoBPPqEFuEo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DX35s3xR7pc4oZ+w2N7PX9v7H5OtxZzj/udb2aTSRxHpJbYXIEh4QAsbVdexrtT8eGhuAdLhIMTzthg5/2y2/73U6xkafz8Ew43NzMWWD/nAerRK6OCKTjbvdPIdN4Q5H2OnJg4C2fGwsKlAr9xXN5IiJ9mccFziD8exikxPV6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dIgXY5Uw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3234811cab3so4970446a91.3
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 13:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756154521; x=1756759321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FMMTN25MPwEpLEWhbHeAChLLjarQ3wWFKtFm5KRVlQw=;
        b=dIgXY5Uwu1q6yePVoWW5mtpF52PhrWJ4/MBGDL2hw6GN6qLt33VpWoypGeSlcOxSOn
         WVP9Npd32EGaJR1PS3OnkV8YRBHXAw0FPpAahnIKFHdCB2eDwEWXfLK9RCenlg/ockCU
         u/4hCXDnuT4ro6EjNc1ZOq2n+Qo9isMifEpIiutsLJoLJjIvESgbYV1A12rmULCBdx4u
         hm/hXn/e8rFmoQ8k8LJwQd3WVW+PP1rn+8W2q8muwVUHdUApxOaz14WvWommExmJhBPV
         239CTspPsBaCvaG0MoRrjbhp0HDwOjpWJFFN1w2m6ae/23+oTXPkXzQJZYismEiTtljT
         pCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756154521; x=1756759321;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FMMTN25MPwEpLEWhbHeAChLLjarQ3wWFKtFm5KRVlQw=;
        b=ZPw8sdWerjshN+n9tVb0L/TLuSks+NON/gZfAK/2hoLhkuMxhIOyhL55RTKil4/cUu
         2tWK86RMtkgC2QGGIULiAcAbVzpFYyYPokc8kFd315uBnrDZ4eEPZ8ck07X+Nf2Ldq54
         eKRN7AZaql/GbOnA0Rke3hhhDPaJm05o9sOrJgEYjijYoOhw/NY2lHdU8+bJ9HgmBs9g
         WyYwNMWBUnBJp7sUZw0lmUb2FoLetHVTPgxJ8opSn4R7GJLvhWBb60PEFzBc+pvgGXrN
         3CmSvYK/3k0AQrR5QYcTrtWGPv9forwH5Yau278SGEVg6DJY3mygvOG6XbavyqS2Uomi
         VSvA==
X-Forwarded-Encrypted: i=1; AJvYcCUvdEx1s3nYAvPtptOZFV4zYSzxoNAqItut7/zr5yIAcCmyy4Z3jztI89c8zU7sCSqb4Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzygU658QvyCHoPqS1/Ja207vY+CO1i7ercjifwBahtdU1LJDEa
	c08RlSWz7E3YfAy4hpaJsJjngagoPMRjMpxyNot5e7cX10NsLQDxf99TXl2rm5P5PP/hnAvNBD1
	vvrInUA==
X-Google-Smtp-Source: AGHT+IHxionK0+nIcG7A4rlHEnd+nc/SyYieKdzrZkT3nTaWhI9foWjqT8Y4Pxxt719sWOwSeLtRUkkv12U=
X-Received: from pjbsp3.prod.google.com ([2002:a17:90b:52c3:b0:31f:61fc:b283])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d918:b0:320:ff84:ceb5
 with SMTP id 98e67ed59e1d1-32515edcae2mr15057069a91.16.1756154520765; Mon, 25
 Aug 2025 13:42:00 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:41:23 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825204158.2414402-1-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 0/8] bpf: Allow decoupling memcg from sk->sk_prot->memory_allocated.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some protocols (e.g., TCP, UDP) have their own memory accounting for
socket buffers and charge memory to global per-protocol counters such
as /proc/net/ipv4/tcp_mem.

When running under a non-root cgroup, this memory is also charged to
the memcg as sock in memory.stat.

Sockets of such protocols are still subject to the global limits,
thus affected by a noisy neighbour outside cgroup.

This makes it difficult to accurately estimate and configure appropriate
global limits.

This series allows decoupling memcg from the global memory accounting
if socket is configured as such by BPF prog.

This simplifies the memcg configuration while keeping the global limits
within a reasonable range, which is only 10% of the physical memory by
default.

Overview of the series:

  patch 1 is a prep
  patch 2 ~ 4 add a new bpf hook for accept()
  patch 5 & 6 intorduce SK_BPF_MEMCG_SOCK_ISOLATED for bpf_setsockopt()
  patch 7 decouples memcg from sk_prot->memory_allocated based on the flag
  patch 8 is selftest


Changes:
  v2:
    * Patch 2
      * Define BPF_CGROUP_RUN_PROG_INET_SOCK_ACCEPT() when CONFIG_CGROUP_BPF=n
    * Patch 5
      * Make 2 new bpf_func_proto static
    * Patch 6
      * s/mem_cgroup_sk_set_flag/mem_cgroup_sk_set_flags/ when CONFIG_MEMCG=n
      * Use finer CONFIG_CGROUP_BPF instead of CONFIG_BPF_SYSCALL for ifdef

  v1: https://lore.kernel.org/netdev/20250822221846.744252-1-kuniyu@google.com/


Kuniyuki Iwashima (8):
  tcp: Save lock_sock() for memcg in inet_csk_accept().
  bpf: Add a bpf hook in __inet_accept().
  libbpf: Support BPF_CGROUP_INET_SOCK_ACCEPT.
  bpftool: Support BPF_CGROUP_INET_SOCK_ACCEPT.
  bpf: Support bpf_setsockopt() for
    BPF_CGROUP_INET_SOCK_(CREATE|ACCEPT).
  bpf: Introduce SK_BPF_MEMCG_FLAGS and SK_BPF_MEMCG_SOCK_ISOLATED.
  net-memcg: Allow decoupling memcg from global protocol memory
    accounting.
  selftest: bpf: Add test for SK_BPF_MEMCG_SOCK_ISOLATED.

 include/linux/bpf-cgroup-defs.h               |   1 +
 include/linux/bpf-cgroup.h                    |   5 +
 include/net/proto_memory.h                    |  15 +-
 include/net/sock.h                            |  48 ++++
 include/net/tcp.h                             |  10 +-
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/cgroup.c                           |   2 +
 kernel/bpf/syscall.c                          |   3 +
 net/core/filter.c                             |  75 +++++-
 net/core/sock.c                               |  64 +++--
 net/ipv4/af_inet.c                            |  34 +++
 net/ipv4/inet_connection_sock.c               |  26 +--
 net/ipv4/tcp.c                                |   3 +-
 net/ipv4/tcp_output.c                         |  10 +-
 net/mptcp/protocol.c                          |   3 +-
 net/tls/tls_device.c                          |   4 +-
 tools/bpf/bpftool/cgroup.c                    |   6 +-
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/lib/bpf/libbpf.c                        |   2 +
 .../selftests/bpf/prog_tests/sk_memcg.c       | 218 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/sk_memcg.c  |  29 +++
 21 files changed, 513 insertions(+), 59 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_memcg.c

-- 
2.51.0.261.g7ce5a0a67e-goog


