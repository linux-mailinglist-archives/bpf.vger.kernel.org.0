Return-Path: <bpf+bounces-68049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28220B520D3
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 21:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108E41C84A6A
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 19:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59AD2D663F;
	Wed, 10 Sep 2025 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GysDpfYX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C580C2D46C9
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532065; cv=none; b=kaTxLI5TtYXpqeDWjp3R4sPZbbdzje+HTfikQElRzZs8pUe9kWknhlvTOxQo0vclokmLcxUbTXkd2QXPo/XMZIEIMiBAQ7Ebc4EBLF7TYi7Sr6wlZlEWP8R6w8nB3YbZvAmDF5eP5vZs5lvwfz80wS/UA5QZ9l4p295eXSkILDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532065; c=relaxed/simple;
	bh=sBYGs2uL/jBibU5/FMcYVIoNZzFfcXQnjzRFTYs91eI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cXP03lTqze7amPPbxi8y2/Rjf2zgEMAKuTNbxsT1MTPfwLBg+ZViBRPErHOVa4+v+OjJBvMc0HjjgzOA08q6EuJlgWgx3SaeL8zHqbhMpamx9KghJ2MELc8ttj/3gDYjUNIRvIuRYXj3tIAJ+idmumLEYf8gjlz6d3dgJBH6wto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GysDpfYX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32b51b26802so6642566a91.2
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 12:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757532062; x=1758136862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/1WBVdvwIuyJ1BMcrGSObTQQxDhWvlT3oxngQNOdXp8=;
        b=GysDpfYXimXlqVDpbF0uwL8iaJrhzkzTcGHD9bIjbOixS5x+AMKKt541YfA9FkQW6B
         vMVbSc1WvRENm685TK2L0BWt53QQknzygRX78aqWGoT08rFsyUJ3vovAkc169TY6vFKK
         mvOAvNKPLsNq4x+i5SQslzzGwen6gDcuD7yCVD3tJ2uzzml6QR/Z/+XpGYqYin3in60y
         orfL9HRc1VFGAnuZ8rMYX0s0ZfD1dF0sP+GxSSG1Ird3Uyk14BaYgsnONa32eioSZLKW
         rh9s8crokCJLwSkHGQhz14Eau5SCAWDvUgI6KJpD6mjCbkiPhXiXsdD4DlaAGNgUI+hb
         KhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757532062; x=1758136862;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/1WBVdvwIuyJ1BMcrGSObTQQxDhWvlT3oxngQNOdXp8=;
        b=jd0nkVR6k/u2QNCHp/zIo/jdapZGabTAWRaW6avlyTGJEHuhMV3i9E1II/RJ90mGtJ
         CTTYsUosfBikEx/gEm1ukqGj2S+0LzzxF6ZHhgCwar8LEjjrTbaO8ywHh8LGTeSxWxi1
         DN9iksy29BQ1u4ENMsNWnfermKyZroQ7yI0gH4fthKuERZniLeitwVm2TTBgY84rrnwZ
         ZaCYJIS1LLXritcQD+/qFALvAgIeA0nOtioK6nXWKNx2NYsP1/IrqnG4dvEY3seVjQOQ
         9CRUPkkmfPb2yyLYCFrncaR7o60LhDcWIxd8omb11Zr9aSiKSjpGQoi/ylaX8VYYusdg
         Mqhw==
X-Forwarded-Encrypted: i=1; AJvYcCXoZa7X7NtmBfEJA+0WmnTXjsK09OomXL+bzmBMUW4ippuKaEoWw/Iag90lLeezGkRFu60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaoIsouq07tvCsRF1KSuZi3geKfvI4FWmhOF3iM8jT6FR/wQzf
	boDViFuUufcsu7n7pZKfP1FZIqcOyl4VBABrjwEiDjCflNXqe4rMzAVnGLY69h6X05CZr6bIa2a
	KW60fpQ==
X-Google-Smtp-Source: AGHT+IE1vgu40SixS1cgM064xhFVxZVa2Q4XnOMPwQtitvNJYWmnFXcXX/m1+TyuaRIoJ8Yv7VyKjI6c4QE=
X-Received: from pjbqa11.prod.google.com ([2002:a17:90b:4fcb:b0:32d:a359:8e4d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f8e:b0:32b:9f1e:ef0e
 with SMTP id 98e67ed59e1d1-32d43f66628mr21695832a91.23.1757532062009; Wed, 10
 Sep 2025 12:21:02 -0700 (PDT)
Date: Wed, 10 Sep 2025 19:19:27 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250910192057.1045711-1-kuniyu@google.com>
Subject: [PATCH v8 bpf-next/net 0/6] bpf: Allow decoupling memcg from sk->sk_prot->memory_allocated.
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
  v8:
    * Patch 3: Fix build failure when CONFIG_NET=n

  v7: https://lore.kernel.org/netdev/20250909204632.3994767-1-kuniyu@google.com/
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
 mm/memcontrol.c                               |  15 +-
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
 19 files changed, 701 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_memcg.c

-- 
2.51.0.384.g4c02a37b29-goog


