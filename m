Return-Path: <bpf+bounces-67329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47046B42960
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 21:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A5B1BC3381
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 19:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF1E2D77F6;
	Wed,  3 Sep 2025 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X54OjFmk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CD71F3FE2
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926163; cv=none; b=IQ11CU8gEvpt99tHGBKjbstysUxeB+L8zZ1sdtqP9uQXwVFlcSGwu+/vV3npdGeWCqLoN543L+KF7cKLW14S612RaXotsZrfs7beb9Wx+uiPoiPf1EFE4h8Ua5h5ePJnLEBSWt1i8Hf6amPB7nZxiwQQO+b3fBX9N6AII7Bat8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926163; c=relaxed/simple;
	bh=aVMvJyTzN8bMk8EyS6qIA/nvsHIy/MRrnKep+4pm2sg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NBgq9FcOUJNdfTcw3CqrX45on3ZbRd+nNA35dI6tPggUemnmIXoBSfjNmKX/3P8opqs8pEJ9Hl/wA3bxK2W+lSkGmzzGZHKx8I5f8q1CSqAzKHk++H+BDb/mOigEzQUc7apldut5QTJNZe1J+l+bI3PTPx7/wHYl3rLNdCoElAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X54OjFmk; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24b2b347073so3130395ad.1
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 12:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756926161; x=1757530961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tctmA+MOFCK1JuJooM9ZVRBdF2hhEopZDWzgeLTAk8s=;
        b=X54OjFmknlhY5993zJyGLf9FGgh+rFdtt8/BZsj+b8WAnj16Xg+/8TP7kzO34pPOkI
         5IUZ8MZU1ZP/TuVQYhtPkPBhmur80B/gcADDBmRYqqPcmrRDDeF/cq/bqDsP5aw5l7pC
         e7YK48qXxXSPol/svBLtG0Bp0kle/5E8YHOPsdbibmjAJsEMGBwiCTJlPDpOSiL23Frv
         +m5Q+bhUpqzn2P0uw0BkxI68EpmXWD7qB7qPn1/541bAjlSHDK4+b/glA1jbwgZvbSDE
         h3nmsb7lthNpikdrrM1kiUkGxzqL3fXGqz5moUjFJaOsdGvS9sAbjeHkoMrH/s6otPK4
         uxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756926161; x=1757530961;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tctmA+MOFCK1JuJooM9ZVRBdF2hhEopZDWzgeLTAk8s=;
        b=T+9K8o7HSw7mQOjIQTQdufdaOeN/56A43nLm8hLw9tQwWmByOvAiqohoV92/EMTYtl
         15e0mdVggHKTT7uivbrHfBrY1x5lmI81CNkUJYA1gLAkhe2Dn6/mEwNN159OzZHe3TyP
         Ge9fjW/3boIvlyVYCJSsekp7JcnU0FWy9IZJWTgKaLfIOES1tFfl5TAbVSUL7j+i6Ei3
         kmQHQTJthN2p+8LiNlX/3frrBKD/fmQleUf8y2S11YlKfmXt87omQkR1WVXXnc+2Mfmf
         BXU0ZhRMgBtPsiVOcLogqhZy7l6PZ9y6E3rI1MSViY94ZHUIL2DKmMjtiJeQHZftt/tT
         wggQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlng0qGc+fAFWoekUHfP6rEjBvPCvMhK730wUoT3LNiaGyrlocNUnINSsrM1F9T2zuiBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN64i9TkblM8M2ugahDUrxaALTlwkcvmHn1GY/sihvYW8j09dM
	PeOv5eemoO93+cgoUzSMQhCNFH+SyCUn9OdvlSp2dAegbl2B8A9kVEf2N2dCYsb/jpyP4xlZN/3
	pNfAWhw==
X-Google-Smtp-Source: AGHT+IGIezD7fpUgbTbIGDaY6VBaac5pRrDVKRuqqxA2wTjKkcEduSIV28bc5Uv7asFRLkiAxHIahBUcY80=
X-Received: from pjuj14.prod.google.com ([2002:a17:90a:d00e:b0:327:5633:47d0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d503:b0:24c:ba8a:6f23
 with SMTP id d9443c01a7336-24cba8a7245mr7398395ad.35.1756926161375; Wed, 03
 Sep 2025 12:02:41 -0700 (PDT)
Date: Wed,  3 Sep 2025 19:01:59 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903190238.2511885-1-kuniyu@google.com>
Subject: [PATCH v5 bpf-next/net 0/5] bpf: Allow decoupling memcg from sk->sk_prot->memory_allocated.
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
  v5:
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


Kuniyuki Iwashima (5):
  tcp: Save lock_sock() for memcg in inet_csk_accept().
  bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
  bpf: Introduce SK_BPF_MEMCG_FLAGS and SK_BPF_MEMCG_SOCK_ISOLATED.
  net-memcg: Allow decoupling memcg from global protocol memory
    accounting.
  selftest: bpf: Add test for SK_BPF_MEMCG_SOCK_ISOLATED.

 include/net/proto_memory.h                    |  15 +-
 include/net/sock.h                            |  50 ++++
 include/net/tcp.h                             |  10 +-
 include/uapi/linux/bpf.h                      |   6 +
 net/core/filter.c                             |  82 +++++++
 net/core/sock.c                               |  65 ++++--
 net/ipv4/af_inet.c                            |  37 +++
 net/ipv4/inet_connection_sock.c               |  26 +--
 net/ipv4/tcp.c                                |   3 +-
 net/ipv4/tcp_output.c                         |  10 +-
 net/mptcp/protocol.c                          |   3 +-
 net/tls/tls_device.c                          |   4 +-
 tools/include/uapi/linux/bpf.h                |   6 +
 .../selftests/bpf/prog_tests/sk_memcg.c       | 218 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/sk_memcg.c  |  38 +++
 15 files changed, 517 insertions(+), 56 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_memcg.c

-- 
2.51.0.338.gd7d06c2dae-goog


