Return-Path: <bpf+bounces-70948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D556BDBD61
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 01:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B9C192181A
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 23:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417BB2E7199;
	Tue, 14 Oct 2025 23:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ob2dd6O9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAD72459E7
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 23:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760486169; cv=none; b=pGzx04nlGO1hhSBAm6+0F8ryw1pSnBuLUF9XEsjMydWSFPCM1eNdgiB+6BgdGbEpnqzI2usNndkLkacfrFhbCDe8tmtQv3AUX6YNarFb3IC9RApFhZKUvDeM4yqmj4qMELYBxZ2i9VcUJo7Wu4cc5ym6HNDdPQgLp6f7g70iVdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760486169; c=relaxed/simple;
	bh=sYSwbOepeC2HBUqzQoCBldYsMSX/QG1XcPhz8TbBoJ0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nXJroHJtAJAGHfxnny2imCW8Lc7vSNk/zU+y2YvZOVuRpGK0gJT2Bf1137Q+MOYjnOf2TIHgZz6csDi7D0YJwWVxXa/fKo22KGhpAKhaC36BjtuhvISOrC4FnH557ZyAdztyf+/vZzu/rPOEuplqz1s8aGPKbR7eb3XtnS+8fAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ob2dd6O9; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b609c0f6522so16507965a12.3
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 16:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760486167; x=1761090967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yeQPu6kQ816hQcFR7LQIi6/9F5Pify18YOjgMFMW6ig=;
        b=Ob2dd6O9Sy3ZMyX+1BOOzWT4qPYYzoj0JY67bufbwAMWMHFW1Ge4H5z+09eME4P1r1
         5wJgjDZ7Mb6I7nua71P2IbKA3o7l3Yxmrg3QY4iwkRbH0G3S06JiAyEGLXQhmjr9I9Ab
         xTNNVzcLkZJhyV3A+HUHROVUPF2jQJgcFAJ2Y/luU2dLpNbP/Wpu/n9vyXATM4eqIO11
         g2p5WuQbeW8HW8V5BMqESWSQKvFBZEVch26AKeJ6wd5ENF3p25kB5yXZMI2N0zz831cP
         Dsuoj9nrZuPDfXM2dg6Qfvu+8JxjKnTt8Yx+h8FBpo5mLNLmCrehbOZCck2IymP88TpE
         iprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760486167; x=1761090967;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yeQPu6kQ816hQcFR7LQIi6/9F5Pify18YOjgMFMW6ig=;
        b=VZYKhM+ebFPjdJn0VK1mqZqS0Nn/XbAzRnJqHijyqhfUxfzIGe85CZSwx+9ClK7Itl
         eTreBZDjS5gp/rzZVMU7Rmyv2TdsAgBTgg821RsqH35JnbbpSOJUeh8XNK8m1UNj64J7
         2BTFIeBVXSgpWpklHPP2B0KvgWDX+yyNNZHoU5RHhNdzRURJWrFyGOqFbT6O7BOASpF3
         idsxRudJxJ8+GTTIL2QHlD9hNlzLNzjtTxCoxm4/GitFMjgzy3VOVqFE3nYw5qKKAJm6
         Qk2gx+/e+uxV0X3PIe02ynkNB0m1iwCvYXvQBxtbegZt5OzCI3CGFNDW1zC6TcaLNvzO
         0rWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxYiTw6MlNazqusDLDljQe87q+JnmvpE7+7O5gT/OauBCKl0HcTqrUq+ljo8no2ppuii0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV1BbwY8ji34hagmjDfr7MfRIup0v9FXGVzMNKyBqOj3hN5XO1
	O3nS5SQqil8ejHyg0XF6/7fKtCBD9q0wKbRl39h7IUk+xGfQFf6QYbWZLB36/w5bgt9ST+3dOYE
	PaprTgA==
X-Google-Smtp-Source: AGHT+IGNAgMuXVn5V3vDoVPP1uN2RVg9SI68TDlVSJLmjtKcgR+k7LVMUCplVpq0j2+dLZGWEgQbOcZ2eVo=
X-Received: from pfbbm22.prod.google.com ([2002:a05:6a00:3216:b0:772:13b2:f328])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7e0b:b0:32b:7000:9ed
 with SMTP id adf61e73a8af0-32da845e7cemr30060957637.48.1760486167322; Tue, 14
 Oct 2025 16:56:07 -0700 (PDT)
Date: Tue, 14 Oct 2025 23:54:53 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014235604.3057003-1-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 0/6] bpf: Allow opt-out from sk->sk_prot->memory_allocated.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series allows opting out of the global per-protocol memory
accounting if socket is configured as such by sysctl or BPF prog.

This series is the successor of the series below [0], but the changes
now fall in net and bpf subsystems only.

I discussed with Roman Gushchin offlist, and he suggested not mixing
two independent subsystems and it would be cleaner not to depend on
memcg.

So, sk->sk_memcg and memcg code are no longer touched, and instead we
use another hole near sk->sk_prot to store a flag for the pure net
opt-out feature.

Overview of the series:

  patch 1 is misc cleanup
  patch 2 allows opt-out from sk->sk_prot->memory_allocated
  patch 3 introduces net.core.bypass_prot_mem
  patch 4 & 5 supports flagging sk->sk_bypass_prot_mem via bpf_setsockopt()
  patch 6 is selftest

Thank you very much for all your help, Shakeel, Roman, Martin, and Eric!


[0]: https://lore.kernel.org/bpf/20250920000751.2091731-1-kuniyu@google.com/


Changes:
  v2:
    * Patch 2:
      * Fill kdoc for skc_bypass_prot_mem
    * Patch 6
      * Fix server fd leak in tcp_create_sockets()
      * Avoid close(0) in check_bypass()

  v1: https://lore.kernel.org/bpf/20251007001120.2661442-1-kuniyu@google.com/


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
 .../bpf/prog_tests/sk_bypass_prot_mem.c       | 289 ++++++++++++++++++
 .../selftests/bpf/progs/sk_bypass_prot_mem.c  | 104 +++++++
 18 files changed, 568 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_bypass_prot_mem.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c

-- 
2.51.0.788.g6d19910ace-goog


