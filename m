Return-Path: <bpf+bounces-70463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB30BBFD5C
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 02:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1463BDF17
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 00:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1155405F7;
	Tue,  7 Oct 2025 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJ2VcesT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90DA11CA0
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795886; cv=none; b=SPFj5AWBasRonNLx92el4awnKs6ibQmEHLg/Hsoin5zhmm8wQ+7m335UjRQpFpfXDj2xsYMzUKtg1nWhY3WvHNN6DRRYjgq44po7tyghQYPtfTbgTDuUz92SNdh4803jaFncSkRmTbfPTsuYyiKYBcHJCzKWtP3oLg9U2mmTBNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795886; c=relaxed/simple;
	bh=OjB9U/glNklQYiP94Pw7OMVIVeV+esVdx+igohJW9Kk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZBHbDMIoPkBHlYQ5pDJbwPufQhURkLqeWz6bKPztVPI5A9gSYcutTuJbSNXv+oAxr3qT7e+Z9u8GlSIs8gXtLtHluXyxmqqSLtN4GzNUOzaetBx1lxJWu5jBi4GTk+Sna+S18PJqEvixYXYZFsyweagsBF1QZDLyAw8Qz1mZ3fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dJ2VcesT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33274f8ff7cso8220272a91.0
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 17:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759795884; x=1760400684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jJBHN3rUg1YIOkUWt9hwotdn59mxOIV3QI8iAsT03sY=;
        b=dJ2VcesTWdLbE76MXM9GNb5M9cuABP6bz4srlw9IWWgY5Gnn/mT3FokDQhgD7EOdBm
         qNNgj64MtwaG7t4wPCI8JK/+XCVr0ESA+Az6YSRcz9H/jY/3unwnUvRMvn/NrWAfDJqX
         WP+GjwTZcK2t3cBykIq2ecQ8hu/Fe6gcvCCDz6S05qYqkXzBzaHHQIq0lzNmm0gbudHz
         jAIprurH2bV87OTqBsRSki6pKFe35CojWZPpKFmno7bYFje8kSEvpmpudxLjgbw6vxaf
         l2q2rmN+ZRXjmpdd9904KoAUXJpq42ROA5CU/mctvmGvAjyOiN8K5t+HRiJfByOgQ1w8
         YFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795884; x=1760400684;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJBHN3rUg1YIOkUWt9hwotdn59mxOIV3QI8iAsT03sY=;
        b=qa3mAChBIliO2LIrjUus/MnoM66QN/zwuZWABK5ueZ42Kb/YBRQ3aBXg25/D2UF1pq
         t/NnUzaEh6lPYQCoa6rYY3vpxa4MC6pPT1wjEni9sHQE6vUYz14rP4j8yXsqKMDZCSY8
         O/6eu9rvZXS099qEsg8q+9UExxmYqTf+5L3uGDghMUDal1rIfU46C28wWSDWQUoCeU9I
         xLHf92gELt9FPXEZMLVosGHvnHKYsFGO1AMgnsvB2uxEO7gOx0Qy5sTBKkEH6OVRmL14
         kUsvwHWufSqKvuGUpF68V7J6j3y3qeXlsuqMbr3a+QPRmCvjPjaniTCJxPOoWjD6Fxov
         TGMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ1/wlBvz+tqDFQf+98eFras3fqFIq2LZTvlEaULO6mdG65GYRvgjU8F42vPAbXC3qJiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuqiFUDmn/9K2u/mFjdgCyuo3RFX67eDIoYuZheUDRu1hTeCCc
	ommZfL81YIzjpSOkoaPYHSIXSZC5Rg2o2WGpZal1q1UIHJhbJYGjaxe9mpNxOxqf5JNft/+7FNz
	vVqX+cw==
X-Google-Smtp-Source: AGHT+IFkcaYku7xK7pNlim0fBSQFL2WTduLoSh4WUJl6xK6pXTW9E81i1TZcGo0o0pCX4QtcmQ71Qm5AXHY=
X-Received: from pjxx8.prod.google.com ([2002:a17:90b:58c8:b0:31f:2a78:943])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c8b:b0:339:a243:e96d
 with SMTP id 98e67ed59e1d1-339c27d1164mr16953343a91.36.1759795884175; Mon, 06
 Oct 2025 17:11:24 -0700 (PDT)
Date: Tue,  7 Oct 2025 00:07:25 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251007001120.2661442-1-kuniyu@google.com>
Subject: [PATCH bpf-next/net 0/6] bpf: Allow opt-out from sk->sk_prot->memory_allocated.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series allows opting out of the global per-protocol memory
accounting if socket is configured as such by sysctl or BPF prog.

This series is v11 of the series below [0], but I start as a new series
because the changes now fall in net and bpf subsystems only.

I discussed with Roman Gushchin offlist, and he suggested not mixing
two independent subsystems and it would be cleaner not to depend on
memcg.

So, sk->sk_memcg and memcg code are no longer touched, and instead we
use another hole near sk->sk_prot to store a flag for the net feature.

Overview of the series:

  patch 1 is misc cleanup
  patch 2 allows opt-out from sk->sk_prot->memory_allocated
  patch 3 introduces net.core.bypass_prot_mem
  patch 4 & 5 supports flagging sk->sk_bypass_prot_mem via bpf_setsockopt()
  patch 6 is selftest


[0]: https://lore.kernel.org/bpf/20250920000751.2091731-1-kuniyu@google.com/


Note: de7342228b73 is needed to build selftest on bpf-next/net.


Kuniyuki Iwashima (6):
  tcp: Save lock_sock() for memcg in inet_csk_accept().
  net: Allow opt-out from global protocol memory accounting.
  net: Introduce net.core.bypass_prot_mem sysctl.
  bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
  bpf: Introduce SK_BPF_BYPASS_PROT_MEM.
  selftest: bpf: Add test for sk->sk_bypass_prot_mem.

 Documentation/admin-guide/sysctl/net.rst      |   8 +
 include/net/netns/core.h                      |   1 +
 include/net/proto_memory.h                    |   3 +
 include/net/sock.h                            |   3 +
 include/net/tcp.h                             |   3 +
 include/uapi/linux/bpf.h                      |   2 +
 net/core/filter.c                             |  79 +++++
 net/core/sock.c                               |  37 ++-
 net/core/sysctl_net_core.c                    |   9 +
 net/ipv4/af_inet.c                            |  22 ++
 net/ipv4/inet_connection_sock.c               |  25 --
 net/ipv4/tcp.c                                |   3 +-
 net/ipv4/tcp_output.c                         |   7 +-
 net/mptcp/protocol.c                          |   7 +-
 net/tls/tls_device.c                          |   3 +-
 tools/include/uapi/linux/bpf.h                |   1 +
 .../bpf/prog_tests/sk_bypass_prot_mem.c       | 282 ++++++++++++++++++
 .../selftests/bpf/progs/sk_bypass_prot_mem.c  | 104 +++++++
 18 files changed, 561 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_bypass_prot_mem.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c

-- 
2.51.0.710.ga91ca5db03-goog


