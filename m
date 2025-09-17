Return-Path: <bpf+bounces-68694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E10DCB818BF
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 21:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C2C1C8046D
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 19:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E650130AADB;
	Wed, 17 Sep 2025 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FBxpw1IU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6D62FF662
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136464; cv=none; b=C+Opyv7e7x/ASlmUUF7Zu0jomUgNILh1gLKfiJPow859F/7MFq7CKq31ZiIVo++aTctYn60QvxB/zW1v3fLOMFDAjOM5ji5haZMPfQqlmnEDVCbrbfU4nC5zEYVBhnJlRwV2GhOjmuIQ8LBeNu9AVU5kmciP5KVV3mtoVTUTxVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136464; c=relaxed/simple;
	bh=Vd9qNZWDGL7ikShcQOSspb5EV2nqMn5JZHk4wc/qcJ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Py/9Ow7Lelww1ukEIfw+fbguoDZoPHY5dDqO0Cfl3mVvZ/9+kTf4Wf30djH5z61u9spZ/l/yPBwBeyLSUbdRY13drX3hDngk+/457RoHP8CU8MMiEyUaM48OsZ/kCeD4/MNwO3gjzk0Sw2re+QLyRu2eqqNYkGp5TYge1U1LOGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FBxpw1IU; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7723d779674so152173b3a.3
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758136462; x=1758741262; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l0akSjZfbj6Vf3Tl8NTruMY+vgfk0nXr+wClAWAUBvI=;
        b=FBxpw1IUWgQAcBxQqaF6eVxIdIAlhgUIW/NVwQL8YdlXqjqggmfHAFdiSP8U4/Olt1
         dYUMbvvDFBsGnPbpbmMxhf7VsVBZEJP6eyOJm46NF1K0a8p/JDwscoxAl+7vUOxq3zEK
         6jYiZfdfZZa6KHtzIvwTTif2VQB6koNngVGqBclnO9WumJ0ZIAwAwcPbjhDHjJblYkPJ
         8gwgqesdtUapDk7/ecrPhsFVm2fcfDIQZqG6IRLD1m1DlkwK4wUxbNoSAJ6g9dfR+dSI
         5AAg6TFbGJZ4VvRMew/2WRFMKxMRTXoBuJb1JeIHrqthBWWoJau6Z2Bf9h+Xq3lOUnZs
         WraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758136462; x=1758741262;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l0akSjZfbj6Vf3Tl8NTruMY+vgfk0nXr+wClAWAUBvI=;
        b=U++6UaMxWW4FlB9MDwgXOYjdQyRypz6YEGyntjPCgZ0dziN+LZ1L42Lf+en8Un23MA
         S9OJiSK1eX1gEnufdSxaQhGCziItIjovUf4RszTKAtEmwguArb6IXA4lTHFGXcJL+PF5
         lyffnDC8xSJeERxnWXlMHkNWN5uajT7Rw+BAHwahM+J0jHTRHDOEFvrhv5+v86cU2qsO
         bIgFSsNSI9kKAtxdwVi6xc1rH1IeV70NeqvucRY4+U0AZT0o8ikYHgRfU2V5Z+E7Bnsf
         knN7oo06jaiCUi9so+lBt1DiFstYtL070P3jfGDJB3tBAXKlvUU8tOZp+xjNOrRbaCVs
         atZA==
X-Forwarded-Encrypted: i=1; AJvYcCXcNxcdTehyxv0hVrt9etWZUTY8m5vZORkmN3roYTOlD8Qm4JAtBFZWB7VR/g9AKj50n00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwATViHe8ttOAyo+/unc12qnS2ejSXVbeQjv3gaveUA6hLxjl/e
	dre1H1vXaJ5rlUb7Dona8ssP3FROsPT3JqM24TwVbhNC3iIowD20HDCCaD99Uxjn0tD+73+iILL
	NsAm8MQ==
X-Google-Smtp-Source: AGHT+IGTGnuayicoK0UH5tP8FKqZjmrrAtqDAsabxLHs7sx0IbvZb8UMsSG+4vljfYJzHyqkb2u5N8tBCrc=
X-Received: from pgnm9.prod.google.com ([2002:a63:7d49:0:b0:b54:f9fb:b204])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:431e:b0:240:1a3a:d7bc
 with SMTP id adf61e73a8af0-27a900612a5mr4733528637.3.1758136462032; Wed, 17
 Sep 2025 12:14:22 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:13:56 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917191417.1056739-1-kuniyu@google.com>
Subject: [PATCH v9 bpf-next/net 0/6] bpf: Allow decoupling memcg from sk->sk_prot->memory_allocated.
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
  v9:
    * Patch 1: Drop sk_is_mptcp() as it's always true for MPTCP subflow
               and unnecessary for SCTP (kernel-test-robot)

  v8:
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
 include/net/sock.h                            |  47 +++-
 include/net/tcp.h                             |  10 +-
 include/uapi/linux/bpf.h                      |   6 +
 mm/memcontrol.c                               |  15 +-
 net/core/filter.c                             |  82 ++++++
 net/core/sock.c                               |  65 +++--
 net/core/sysctl_net_core.c                    |  11 +
 net/ipv4/af_inet.c                            |  36 +++
 net/ipv4/inet_connection_sock.c               |  26 +-
 net/ipv4/tcp.c                                |   3 +-
 net/ipv4/tcp_output.c                         |  10 +-
 net/mptcp/protocol.c                          |   3 +-
 net/tls/tls_device.c                          |   4 +-
 tools/include/uapi/linux/bpf.h                |   6 +
 .../selftests/bpf/prog_tests/sk_memcg.c       | 261 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/sk_memcg.c  | 146 ++++++++++
 19 files changed, 700 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_memcg.c

-- 
2.51.0.384.g4c02a37b29-goog


