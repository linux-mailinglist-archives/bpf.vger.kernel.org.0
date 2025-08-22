Return-Path: <bpf+bounces-66316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6ABB324EF
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2135A62382D
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 22:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5412836A3;
	Fri, 22 Aug 2025 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9GibFaq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631611F875A
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755901131; cv=none; b=N/fMWtbTcEz5sIZsWkzkCCWx/UQ5Fn7uofsmuWhYCuZg489Hu0Kl2hI9nKnccsAJBp7FA9h+Ctfygn6DVgvlimGbq3H8xMn+KUXgDTFoe3Quwlh+amLVK9Pizmtznws0fXvaAbgt9/1zuN7tqJIhQ74ZmqdDFyWj7SOjIP3wLt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755901131; c=relaxed/simple;
	bh=c6mGLJgnTfpuQVOeGknUJj9bW3ATLSK7ZiU6ojmW638=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c6oEcCCtoT0jfk1By8aj3PHFBVbgvWMxo2SQwIrYJH0tkpoabzTZpoYP55GNVAr8ZfNMQkUFE8LwY5SpTQNs3xFdKL2TpEkCRAmXagXZK+btM22ZJtEGXYWgzcj8xrqxBtow7K9ipZScQxkXj0p/ewPp/xWtV4xmwqBG388MRpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9GibFaq; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581187c6so33967245ad.1
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 15:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755901130; x=1756505930; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hIkFgcvZcrojvPgSQkeYBl88OThm773qw4A5aWmF2/E=;
        b=I9GibFaqUi/SA+k5orIueBlgXvtftKRfO+CHUteFnOxeFuDRpiemVV7r+cPQmWuyIG
         wSlCAbsAjFR8LSlE9KlPt37hhcfdm+tUAuKXwApqascarwcWaShFs2VbGdN+VrYwoGI8
         Tg3WDUDVxro7CMG3O0cOxrOkPi/Ei1Yw/p7Ux1CTf/ybFjaIOlHtianSKe39UyICq0Tn
         K2eYwYaWx5jghetDv4v7BkwWdyYxCHXJ1jXWcERWbVj14dtHFfGdP2cuzqpSM/IzjzUR
         SPGz8wjO46lwpB/KvWBINpz+awc0e+ozM8QbCXoVnmJCm53IoTkx8gafLJPV5zuc7U7Y
         wS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755901130; x=1756505930;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hIkFgcvZcrojvPgSQkeYBl88OThm773qw4A5aWmF2/E=;
        b=B/sq11KQOxnyEvf0pECrdetVngh424J+HQSnfQw4pCflqyYgHfJUhuBqYwQdn1LLIC
         fACoCpWdMZSn0NkS+JQIGk/oqozxnK+xmsusydmDwLge1nXtkRuGme1J7edETF5VXdrD
         zM4KpIT8+8CwGquBvxNS4xjSEO55ejLCTaeZ8YNJ7IyIt0hKjR9mtjWj9FfRsfMAqYXd
         lm640f9+flfaCtWXkVIVNBpnyB5X1jz59vws9+1IXSS7BnRb4HouAG55su3IvI7P3tzd
         XhRngNSu9C7NskQamq8Xa3KX/9ONa+bOvujX/lQI6pMmildauAcVMQk1Hgzru2J/OgbZ
         mOpw==
X-Forwarded-Encrypted: i=1; AJvYcCUA+q5WAKrTMpUNxPRNXq25B+CCeSqCygZPLx4UnzOyQChyo67PBPdPtd5zvI+lWfPr5lA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFqlhr0xxVG//VUrSzE73iUVQOVwnVllBqK777JKsjGjtKnoXy
	GOFeAZlLEDCyJTBeONb7fvDf9Wxw0qQ/e6YJjvqpJc6NoInlTdX6kkk+fd292sIZyAc7YAdKsJ7
	RTHtFyA==
X-Google-Smtp-Source: AGHT+IFLHNvGZFfSmyvczIBxR9kNhc5Bj1TRhTXcI3X2GP4drWc5WEHm4SlD8eb3yfX7ynv+xuI7cnSQ1E8=
X-Received: from plaq19.prod.google.com ([2002:a17:903:2053:b0:23f:fd13:e74d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec2:b0:246:61e:b564
 with SMTP id d9443c01a7336-2462f1d82c4mr56035705ad.61.1755901129678; Fri, 22
 Aug 2025 15:18:49 -0700 (PDT)
Date: Fri, 22 Aug 2025 22:17:55 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822221846.744252-1-kuniyu@google.com>
Subject: [PATCH v1 bpf-next/net 0/8] bpf: Allow decoupling memcg from sk->sk_prot->memory_allocated.
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
 include/linux/bpf-cgroup.h                    |   4 +
 include/net/proto_memory.h                    |  15 +-
 include/net/sock.h                            |  48 ++++
 include/net/tcp.h                             |  10 +-
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/cgroup.c                           |   2 +
 kernel/bpf/syscall.c                          |   3 +
 net/core/filter.c                             |  75 +++++-
 net/core/sock.c                               |  64 ++++--
 net/ipv4/af_inet.c                            |  34 +++
 net/ipv4/inet_connection_sock.c               |  26 +--
 net/ipv4/tcp.c                                |   3 +-
 net/ipv4/tcp_output.c                         |  10 +-
 net/mptcp/protocol.c                          |   3 +-
 net/tls/tls_device.c                          |   4 +-
 tools/bpf/bpftool/cgroup.c                    |   6 +-
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/lib/bpf/libbpf.c                        |   2 +
 .../selftests/bpf/prog_tests/sk_memcg.c       | 214 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/sk_memcg.c  |  29 +++
 21 files changed, 508 insertions(+), 59 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_memcg.c

-- 
2.51.0.rc2.233.g662b1ed5c5-goog


