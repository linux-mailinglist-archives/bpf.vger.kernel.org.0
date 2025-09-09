Return-Path: <bpf+bounces-67937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8337DB50763
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 22:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9EF5E76FB
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 20:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A429135A2B4;
	Tue,  9 Sep 2025 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YABzo4v9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B39301022
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450799; cv=none; b=QJx3ozEs4TBvHwVtQZbMJrB7zCyX/tM+FGmEwzr+FPxoPQympupu/Scy8p5HiJELcmtNNnZ+xevbaJiyBthG0upqNYrpmDUrVDAmEFpKDExe9qzq7iEyR9dqVHR5Efdc6mP0/73JjkdCmtPbjLIEQZAgyanWR5YzyvUjqqOikfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450799; c=relaxed/simple;
	bh=Fct3e4B6A6ZR1i/d0po8drRvWEtKD8QIsPSJI8uf17A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VYi/WWTTcwHDSImTGWzsTrmLAze0CNOFKdCSJ669CmE5LJVFQj06YtlGPdp0/WNb71haGut51eprP4kBl4NRgdB8vi5yhj/xGVVoPHjHk/2WJYYEy9QdWu8ISjhb+UoK4KwXFHhHoWRvJB+VH0sANa3FWK6F8AeIt9xYm3Ua53k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YABzo4v9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24ca417fb41so70756235ad.1
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757450796; x=1758055596; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1lvZ1o30VYBTsa6ogSGZDG7Gv6CnhJma3tgeQqrmyfc=;
        b=YABzo4v9cO8fy33ueWodrnsvbBq/pR4rGUEQH4zz5YHRoj7x+jEP5oSU3mW8r0qkRA
         VT++il4H8lCiOlwnZPj1KRb/B2yZmiTmtST6m8/tU22hZvkSPuRDa1YTeF1lB9XxNsuY
         U8+Jl9WomXfaMHOUUqyJyZrtmBm64OpDFUoMOcUQDox37yilABm6Vgsjxph1l9R5t2lK
         YzNsraQXa4zcYiBuh9brmIjwbRrt9BS4zpuuydkbdSIxORjGu3G8eQKsQYZC6mZ/2y6n
         wfTZMk5K9WJ3nDR4ZycL8gLxTcBbHkW5+a9LunFbfs9gMpqytdPPTjPI1l0YQyH9WaK+
         r6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757450796; x=1758055596;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1lvZ1o30VYBTsa6ogSGZDG7Gv6CnhJma3tgeQqrmyfc=;
        b=gtmqb57i6mLTWimyC8BCmk09ujmLLEr7lnQmT733itjqv8HUEeQzXfYl4q7F2fXM/q
         g/VKd4xlrVJ9wPEsp1pflOHEJQV1uIlaaEKP+ykhesloLCR7Y94GhPGFIFcmedmiasf8
         2BZyj1MqKJS/UOaGv1ac+nuHXXzyy4klosl7zQXcc8Z4tuPQTvrwdWoMQ43MKLrof3bJ
         0yTQBRno6Zl3Rms1EXUEUAmS52l37SFjeTw7u2AeRVUg1BJNH+jvhcLkgtvQEWmx7Zk1
         4YI6j5LQA/33F9lKNXJLrhJXkH9D0tOswLZlb/psAummtOrCqg3v2lTq5SiDYNAPIcZt
         P4yg==
X-Forwarded-Encrypted: i=1; AJvYcCVZS9WLTOtvSmFBx+4oLUphmmcDDt5+vhzYgo+d+qF0hJisDwkK4D8GS1t8QRTsBPNuAe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcscP0LrAGYDQzR0rXoPcp2Ynx1uwYyMlmTpNvFW1B4Fy6ZL5g
	XENFLKxfr8hUVEX3o7sG8ppT84+SXqpxPBTYpneDTQ2Q6umFntkYe9p/+Nkl8BmY+pefr47tGdq
	hyggz4w==
X-Google-Smtp-Source: AGHT+IHJWpCbproYlIy0hWLsQ9DM7XbYS5ndVs6oC3FnBSa72bBmwQxAbv2ImylNXstMVut5vWZ8nKYnfMk=
X-Received: from pjbnd14.prod.google.com ([2002:a17:90b:4cce:b0:31f:3227:1724])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ce:b0:24c:ba67:95
 with SMTP id d9443c01a7336-2516f04ed3bmr138281735ad.9.1757450796500; Tue, 09
 Sep 2025 13:46:36 -0700 (PDT)
Date: Tue,  9 Sep 2025 20:45:30 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909204632.3994767-1-kuniyu@google.com>
Subject: [PATCH v7 bpf-next/net 0/6] bpf: Allow decoupling memcg from sk->sk_prot->memory_allocated.
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

If the socket has sk->sk_memcg this memory is also charged to the memcg
as sock in memory.stat.

We do not need to pay costs for two orthogonal memory accounting
mechanisms.

This series allows decoupling memcg from the global memory accounting
(memcg + tcp_mem -> memcg) if socket is configured as such by sysctl
or BPF prog.


Overview of the series:

  patch 1 & 2 prepare for decoupling memcg from sk_prot->memory_allocated
    based on the SK_MEMCG_EXCLUSIVE flag
  patch 3 introduces net.core.memcg_exclusive sysctl
  patch 4 & 5 supports flagging SK_MEMCG_EXCLUSIVE via bpf_setsockopt()
  patch 6 is selftest


Changes:
  v7:
    * Rename s/ISOLATED/EXCLUSIVE/
    * Add patch 3 (net.core.memcg_exclusive sysctl)
    * Reorder the core patch 2 before sysctl + bpf changes
    * Patch 6
      * Add test for sysctl

  v6: https://lore.kernel.org/netdev/20250908223750.3375376-1-kuniyu@google.com/
    * Patch 4
      * Update commit message
    * Patch 5
      * Trace sk_prot->memory_allocated + sk_prot->memory_per_cpu_fw_alloc

  v5: https://lore.kernel.org/netdev/20250903190238.2511885-1-kuniyu@google.com/
    * Patch 2
      * Rename new variants to bpf_sock_create_{get,set}sockopt()
    * Patch 3
      * Limit getsockopt() to BPF_CGROUP_INET_SOCK_CREATE
    * Patch 5
      * Use kern_sync_rcu()
      * Double NR_SEND to 128

  v4: https://lore.kernel.org/netdev/20250829010026.347440-1-kuniyu@google.com/
    * Patch 2
      * Use __bpf_setsockopt() instead of _bpf_setsockopt()
      * Add getsockopt() for a cgroup with multiple bpf progs running
    * Patch 3
      * Only allow inet_create() to set flags
      * Inherit flags from listener to child in sk_clone_lock()
      * Support clearing flags
    * Patch 5
      * Only use inet_create() hook
      * Test bpf_getsockopt()
      * Add serial_ prefix
      * Reduce sleep() and the amount of sent data

  v3: https://lore.kernel.org/netdev/20250826183940.3310118-1-kuniyu@google.com/
    * Drop patches for accept() hook
    * Patch 1
      * Merge if blocks
    * Patch2
      * Drop bpf_func_proto for accept()
    * Patch 3
      * Allow flagging without sk->sk_memcg
      * Inherit SK_BPF_MEMCG_SOCK_ISOLATED in __inet_accept()

  v2: https://lore.kernel.org/bpf/20250825204158.2414402-1-kuniyu@google.com/
    * Patch 2
      * Define BPF_CGROUP_RUN_PROG_INET_SOCK_ACCEPT() when CONFIG_CGROUP_BPF=n
    * Patch 5
      * Make 2 new bpf_func_proto static
    * Patch 6
      * s/mem_cgroup_sk_set_flag/mem_cgroup_sk_set_flags/ when CONFIG_MEMCG=n
      * Use finer CONFIG_CGROUP_BPF instead of CONFIG_BPF_SYSCALL for ifdef

  v1: https://lore.kernel.org/netdev/20250822221846.744252-1-kuniyu@google.com/


Kuniyuki Iwashima (6):
  tcp: Save lock_sock() for memcg in inet_csk_accept().
  net-memcg: Allow decoupling memcg from global protocol memory
    accounting.
  net-memcg: Introduce net.core.memcg_exclusive sysctl.
  bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
  bpf: Introduce SK_BPF_MEMCG_FLAGS and SK_BPF_MEMCG_EXCLUSIVE.
  selftest: bpf: Add test for SK_MEMCG_EXCLUSIVE.

 Documentation/admin-guide/sysctl/net.rst      |   9 +
 include/net/netns/core.h                      |   3 +
 include/net/proto_memory.h                    |  15 +-
 include/net/sock.h                            |  47 +++-
 include/net/tcp.h                             |  10 +-
 include/uapi/linux/bpf.h                      |   6 +
 mm/memcontrol.c                               |  13 +-
 net/core/filter.c                             |  82 ++++++
 net/core/sock.c                               |  65 +++--
 net/core/sysctl_net_core.c                    |  11 +
 net/ipv4/af_inet.c                            |  37 +++
 net/ipv4/inet_connection_sock.c               |  26 +-
 net/ipv4/tcp.c                                |   3 +-
 net/ipv4/tcp_output.c                         |  10 +-
 net/mptcp/protocol.c                          |   3 +-
 net/tls/tls_device.c                          |   4 +-
 tools/include/uapi/linux/bpf.h                |   6 +
 .../selftests/bpf/prog_tests/sk_memcg.c       | 261 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/sk_memcg.c  | 146 ++++++++++
 19 files changed, 699 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_memcg.c

-- 
2.51.0.384.g4c02a37b29-goog


