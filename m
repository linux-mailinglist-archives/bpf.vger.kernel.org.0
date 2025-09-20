Return-Path: <bpf+bounces-69021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 285BEB8BAA4
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 02:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D280F7E60C8
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 00:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E8563CB;
	Sat, 20 Sep 2025 00:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LhAU1TiE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268EC3C1F
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 00:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758326877; cv=none; b=jiTaGdf14Cx8psjWvvjniHG6S/+aHddB4GAi+TwNCoQXrlWCzCnBIlEiHg2dB70+rLAH6/siRNUkmvYqMl45VLl0V4XrCoxl0AR4nkMRBNllwzpvzvbDteEiLw6jwWIQm8hVKmt5KzWYNA2xnebKkI/ZMFeHXWNgHKpBgEoow+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758326877; c=relaxed/simple;
	bh=ysHWEV9/jntsplvkDq3zMUOyPbd06nXaQfoYPjmAaYE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V6OxcAgGc9PdC2FBSWdf7/r5TidRD//LG1wOtDAs9u5ZrUBcHTQ9C8pWSox8ufKtZ6iqiYWhpJb9i3+s+7qYC4YyT3rNqd2rJqhL2RpAgmiK+RRxZIcyTpACWz3U1xmlohDFDlvwuhjBPvYIgxNeWuSV2/7naIHmN4z5aSc3dJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LhAU1TiE; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso2478215b3a.2
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 17:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758326875; x=1758931675; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tBPCDa1BwrCDaG2MKnSZz5xWcZReITqMcnnoyvUjUOM=;
        b=LhAU1TiE/kJoYcVgrHurSHxDE0Te2skbOeuo6MBjGO1orpK4zQTEbmrJyiJz5CtlVV
         4taeTnT7fzG3+IhsZopBfE/KXKC57yXNEVR8HENPzUWoY4a458UqyuiVuq0z0H4/5tjK
         7Zz9gjpz71RPrK3Hex9o7uWcGJ6s43IPXi5nR/CUTqRLQYLMZ/K1t6q4oBX+RzWtsfKb
         gUr9wjj2WJjrWjkbl0UB9TwkAfJfh7NncZ+r2mvGKe+Sx4bXkrcT1v2ulklvaT67hyiW
         uAE6ElpjP8ddp4fVx4Aeb1KO58W3F+r/tbmXPJ9Ux2FUnMl+azLxM5Fpvu5AvLJu3mGl
         h/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758326875; x=1758931675;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tBPCDa1BwrCDaG2MKnSZz5xWcZReITqMcnnoyvUjUOM=;
        b=a1L4lGyHag6/UmWsXPQu6qv1YsHASK7xCjX7X4qtZR32woQqDVST48KjgXnPCiEl0m
         zfMHscGVhy1ma0dCUoxf4i31H6FL/fDdx8FD2GZWo/6a1Sp4Y+vnA3g+u7mYBjF2ImeG
         olluLxYGDFHyxqNbj5xFo4jkBc1aiir4OcQ/wOD2dV6zAkTy674Yok7d0+2iGSscmrGL
         0R8YggcO77KZUzI1hhyeNSVyete6Osg5pPRaYzWNkLUVkI+ApoOyk9tDrapvPctKRqVt
         +wtBUBsAbpd2RiAOQFmZe5dOzAP9OpyWCzLrgE5yDqPHCVSSqJNC26yPb6b76Ceoro0k
         bAXg==
X-Forwarded-Encrypted: i=1; AJvYcCXeBpsBKQz4dsX2oKbwm6k/dNhZ2CnnVEHex0aBlrqe2toLcvOMgG5jACrUBAeciMUSyN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyjfFRGBG18jc42rgHrW2tyaHItYFDgjN1RVUuh8/Sd0lFeml9
	gtRCPiDcEdX//yD2kwFQr/XPkTL/eOPTXjdcPVds0CnG6g8f+OgOGLdUM+VpFcB9v/W0sI6Bcb1
	TvqewkQ==
X-Google-Smtp-Source: AGHT+IEXDf7nacWEI/oa+ZtfzEtDnx2tfPDu/AzKrhopjxl+ogWjkA3uCBAJ18VKmHTpFatswhJUpDVjJSc=
X-Received: from pfx29.prod.google.com ([2002:a05:6a00:a45d:b0:77c:7706:8702])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:13a7:b0:776:1de4:aee8
 with SMTP id d2e1a72fcca58-77e4a0fafc8mr6196551b3a.0.1758326875331; Fri, 19
 Sep 2025 17:07:55 -0700 (PDT)
Date: Sat, 20 Sep 2025 00:07:14 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250920000751.2091731-1-kuniyu@google.com>
Subject: [PATCH v10 bpf-next/net 0/6] bpf: Allow decoupling memcg from sk->sk_prot->memory_allocated.
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

If the socket has sk->sk_memcg, this memory is also charged to the memcg
as sock in memory.stat.

We do not need to pay costs for two orthogonal memory accounting
mechanisms.

This series allows decoupling memcg from the global memory accounting
(memcg + tcp_mem -> memcg) if socket is configured as such by sysctl
or BPF prog.


Overview of the series:

  patch 1 & 2 prepares for decoupling memcg from sk_prot->memory_allocated
    based on the SK_MEMCG_EXCLUSIVE flag
  patch 3 introduces net.core.memcg_exclusive
  patch 4 & 5 supports flagging SK_MEMCG_EXCLUSIVE via bpf_setsockopt()
  patch 6 is selftest


Changes:
  v10:
    * Patch 6:
      * Clean up iterations in ->create_sockets() (Martin)
      * Move ASSERT inside if to avoid noisy log in ->create_sockets()
      * Make run_test() static (Martin)
      * Remove fexit progs & possible infinite loop in get_memory_allocated() (Martin)
      * Use test__start_subtest() with if (Martin)
      * Drain UDP recv queue before close() (Martin)
      * Reduce NR_PAGES to 32 to make test faster

  v9: https://lore.kernel.org/netdev/20250917191417.1056739-1-kuniyu@google.com/
    * Patch 1: Drop sk_is_mptcp() as it's always true for MPTCP subflow
               and unnecessary for SCTP (kernel-test-robot)

  v8: https://lore.kernel.org/netdev/20250910192057.1045711-1-kuniyu@google.com/
    * Patch 3: Fix build failure when CONFIG_NET=n (kernel-test-robot)

  v7: https://lore.kernel.org/netdev/20250909204632.3994767-1-kuniyu@google.com/
    * Rename s/ISOLATED/EXCLUSIVE/ (Shakeel)
    * Add patch 3 (net.core.memcg_exclusive sysctl) (Shakeel)
    * Reorder the core patch 2 before sysctl + bpf changes
    * Patch 6
      * Add test for sysctl

  v6: https://lore.kernel.org/netdev/20250908223750.3375376-1-kuniyu@google.com/
    * Patch 4
      * Update commit message (Shakeel)
    * Patch 5
      * Trace sk_prot->memory_allocated + sk_prot->memory_per_cpu_fw_alloc (Martin)

  v5: https://lore.kernel.org/netdev/20250903190238.2511885-1-kuniyu@google.com/
    * Patch 2
      * Rename new variants to bpf_sock_create_{get,set}sockopt() (Martin)
    * Patch 3
      * Limit getsockopt() to BPF_CGROUP_INET_SOCK_CREATE (Martin)
    * Patch 5
      * Use kern_sync_rcu() (Martin)
      * Double NR_SEND to 128

  v4: https://lore.kernel.org/netdev/20250829010026.347440-1-kuniyu@google.com/
    * Patch 2
      * Use __bpf_setsockopt() instead of _bpf_setsockopt() (Martin)
      * Add getsockopt() for a cgroup with multiple bpf progs running (Martin)
    * Patch 3
      * Only allow inet_create() to set flags (Martin)
      * Inherit flags from listener to child in sk_clone_lock() (Martin)
      * Support clearing flags (Martin)
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
 include/net/sock.h                            |  47 ++-
 include/net/tcp.h                             |  10 +-
 include/uapi/linux/bpf.h                      |   6 +
 mm/memcontrol.c                               |  15 +-
 net/core/filter.c                             |  82 +++++
 net/core/sock.c                               |  65 ++--
 net/core/sysctl_net_core.c                    |  11 +
 net/ipv4/af_inet.c                            |  36 +++
 net/ipv4/inet_connection_sock.c               |  26 +-
 net/ipv4/tcp.c                                |   3 +-
 net/ipv4/tcp_output.c                         |  10 +-
 net/mptcp/protocol.c                          |   3 +-
 net/tls/tls_device.c                          |   4 +-
 tools/include/uapi/linux/bpf.h                |   6 +
 .../selftests/bpf/prog_tests/sk_memcg.c       | 282 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/sk_memcg.c  | 105 +++++++
 19 files changed, 680 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_memcg.c

-- 
2.51.0.470.ga7dc726c21-goog


