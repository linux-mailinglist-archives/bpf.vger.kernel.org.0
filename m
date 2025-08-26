Return-Path: <bpf+bounces-66581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4E3B3725A
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 20:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8475366D90
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9413705AC;
	Tue, 26 Aug 2025 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nSw2q73s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A93705A6
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233607; cv=none; b=Y0Q+yHcbNPX6AQNUWH7oEcNO4VYK8acpUAkcTZzTFZET9u0tzdtUGiKH7dyrPvsdmMbYJ4TwbN9cAKDw+mU2YL6taR4fJIRUsZI4EUlKL39PZ/hrgmRPnUlwsGY2/zovWVIBP2XiI4RXTsAd9LN83hHSJVsC0VK4VDfQSi4SbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233607; c=relaxed/simple;
	bh=DZD1/UiSrQPMYLN+2rnhBwl8wtfzw7x/KnfzdjcCNw0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ONqALdUVGPhEpAZ72NzdVSVFKttSP3jt0Ttnca+UQZyKQy4svodvBaGG9/zLImxcV1+PV8b95eeoiKYILEv4CAqvCxMHmAzIl4uV37vfIBL+NCk6/Ky32aoVczrygUmv71WhZhkS/IHHfjFP4O/iH3d8pvu8g4o2/qQJZInYTpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nSw2q73s; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e395107e2so5549268b3a.3
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 11:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756233605; x=1756838405; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/D0iGYqZJinvw13rmeSwsC8silq8/DzFLQf/dLNvUlI=;
        b=nSw2q73sRCgupvlOoWDNQnDzrEaIFqm8jauPzbs7jl4eS4BbgYEANcGDK9/IqGcIBC
         2YagYuN4biVAq3AZXoeN94qAq89OTVBj7Ne8gcm0POiadTGBx5o2JUcqGPft/XBaatCm
         K6vmkGXMZkwcw3fYo7WA/zrqq85v1wKQqSAt+TEdD2980OYijk6lkVliUMG2LbQePKQX
         Tq61EVmH4bOF/4qncB5Ya2Yc7sqkEUwJQH/JDvMw1WnQbQEpCAhEB6AlEpGHSlfXgOTf
         9DiukFr1ELdKJIwHpEpvuAcM2rl9idk/5ASZ/oA22OLPImheLiFjwpXX0DPjJQQExZvN
         cVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756233605; x=1756838405;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/D0iGYqZJinvw13rmeSwsC8silq8/DzFLQf/dLNvUlI=;
        b=XyXAjv0oChNQtbE/TVnX8wTm0KFT6wvvrj4I/RFfJIwUyLzphPqy/ezZb66wqmb+bz
         5MxaYBinyeoZbdjoJmb67BOp5jHafrKasNACJjBbj1Mrh/3Eq8d57NRLlS79tBpqKtzw
         1PRTV8Zlkxy775+WUIUaYm365+alekldQF1m04/M80iaua0SGcwKg/NUGwJZ9ZNSxwOX
         jP503HPa69wV5fOdE9fsT8+TKBKuPjToi2Px7tphcYoxCIjMGQ+rfYBqBRIvOCcuCLK5
         rBbubJKj8osLgGs8wy6pfwfnAzUlhZ5d6DqhD3RPH6TsmCegoT+MZHtW4ust28aHunaD
         T0Fg==
X-Forwarded-Encrypted: i=1; AJvYcCW5GSf3kksTzv7clWxhRMhScpyiU+gPzRJLXMYD5nTxz8Kb0A59s4/QWbWvO33qz/IREwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZwMlNtw4FkSdgCYzepglvKnGCzyphwa0eoqe5zmbaP0BD/1N
	xkQOHNmuVoV63CsdHHpWTH1lDAyVbNEFor2QYn4Rkg2sno9LrKp0fsfhp9uZZL/yxLjRHVTj9Tj
	9Kql/Ng==
X-Google-Smtp-Source: AGHT+IFNYZO06Ci78+fQrIlTmwTkuN+AAnQOFOtAKF+1yypumVaGXB2LY1oOyXkhgS2i9y3mXPS0Zwr2r+k=
X-Received: from pfbcp25.prod.google.com ([2002:a05:6a00:3499:b0:76b:fefc:8d72])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d84:b0:243:971d:cd84
 with SMTP id adf61e73a8af0-243971dd02bmr1692095637.22.1756233605259; Tue, 26
 Aug 2025 11:40:05 -0700 (PDT)
Date: Tue, 26 Aug 2025 18:38:06 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250826183940.3310118-1-kuniyu@google.com>
Subject: [PATCH v3 bpf-next/net 0/5] bpf: Allow decoupling memcg from sk->sk_prot->memory_allocated.
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

  patch 1 & 2 are prep
  patch 3 intorduces SK_BPF_MEMCG_SOCK_ISOLATED for bpf_setsockopt()
  patch 4 decouples memcg from sk_prot->memory_allocated based on the flag
  patch 5 is selftest


Changes:
  v3:
    * Drop accept() hook and use BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB instead
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



Kuniyuki Iwashima (5):
  tcp: Save lock_sock() for memcg in inet_csk_accept().
  bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
  bpf: Introduce SK_BPF_MEMCG_FLAGS and SK_BPF_MEMCG_SOCK_ISOLATED.
  net-memcg: Allow decoupling memcg from global protocol memory
    accounting.
  selftest: bpf: Add test for SK_BPF_MEMCG_SOCK_ISOLATED.

 include/net/proto_memory.h                    |  15 +-
 include/net/sock.h                            |  48 ++++
 include/net/tcp.h                             |  10 +-
 include/uapi/linux/bpf.h                      |   6 +
 net/core/filter.c                             |  52 ++++-
 net/core/sock.c                               |  64 +++--
 net/ipv4/af_inet.c                            |  37 +++
 net/ipv4/inet_connection_sock.c               |  26 +--
 net/ipv4/tcp.c                                |   3 +-
 net/ipv4/tcp_output.c                         |  10 +-
 net/mptcp/protocol.c                          |   3 +-
 net/tls/tls_device.c                          |   4 +-
 tools/include/uapi/linux/bpf.h                |   6 +
 .../selftests/bpf/prog_tests/sk_memcg.c       | 218 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/sk_memcg.c  |  30 +++
 15 files changed, 475 insertions(+), 57 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_memcg.c

-- 
2.51.0.318.gd7df087d1a-goog


