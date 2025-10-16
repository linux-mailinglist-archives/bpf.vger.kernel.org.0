Return-Path: <bpf+bounces-71160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 635EFBE56F6
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 22:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE3A54FA9D4
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4197D2DBF49;
	Thu, 16 Oct 2025 20:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dto6BePv"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62972DF139
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 20:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647561; cv=none; b=nDtz+a7b2DOBamjDTq5r517JeUPRhlQPKyTYp6ngAN5ePe7PX/uempb7LS4XyQ3ALIF2ZaenMKoDS0Qxe1OtXYBirbTEltyRcCttIH/mPusc1PUya6oG0xyIj5F8nlTZQkM19EKQzZP39cbgKiDa68xPHeHRU/08M7OuMsp6xdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647561; c=relaxed/simple;
	bh=uPiRufTru4Cw/BXb7fyHHt8/LdAZGFCJrYCPL6AZsdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DpLgbhcmIx19qZbjAy+cBIpl4zs4f/w8YcUv5w6Tk0ZmJYO3cze5wnyYzV8eyiKXW3qm6S21a4euH5mp/P2RS3/Bz2o+k1+PtrGbB7wfbgvov4cld9KzPRSkUaGlAsLpDFxHhI3A4AbRQMm2gzAKbm/Dp/tvOgBvYPELAhAaklM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dto6BePv; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760647547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yfSLM4BxLDXSTtvggk83X6KgpFlWpsImSmzLOrT8U4Y=;
	b=dto6BePvR8fqsRREiZ5Qa05uSFWN0dxq7OkFTV9b+Dfyz0r5aFW1LwBiZg11mgYK8f5J4/
	MEkhj7cFnJyoH/tDEwDZYwnLhFP5JXJJBwWEnniHQ9K5gT9Kcp4v2e2jF8uhhwwQav8s+r
	w4CmC7FUw9CxsofiJnvZsuhQbHGGXqA=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf-next 2025-10-16
Date: Thu, 16 Oct 2025 13:45:39 -0700
Message-ID: <20251016204539.773707-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 6 non-merge commits during the last 1 day(s) which contain
a total of 18 files changed, 577 insertions(+), 38 deletions(-).

The main changes are:

1) Bypass the global per-protocol memory accounting either by setting
   a netns sysctl or using bpf_setsockopt in a bpf program,
   from Kuniyuki Iwashima.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Eric Dumazet, Roman Gushchin, Shakeel Butt

----------------------------------------------------------------

The following changes since commit 55db64ddd6a12c5157a61419a11a18fc727e8286:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-10-16 11:06:28 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 03de843bd0806184505f1e8099ff4ca9a8665dbb:

  Merge branch 'bpf-allow-opt-out-from-sk-sk_prot-memory_allocated' (2025-10-16 12:15:10 -0700)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Kuniyuki Iwashima (6):
      tcp: Save lock_sock() for memcg in inet_csk_accept().
      net: Allow opt-out from global protocol memory accounting.
      net: Introduce net.core.bypass_prot_mem sysctl.
      bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
      bpf: Introduce SK_BPF_BYPASS_PROT_MEM.
      selftests/bpf: Add test for sk->sk_bypass_prot_mem.

Martin KaFai Lau (1):
      Merge branch 'bpf-allow-opt-out-from-sk-sk_prot-memory_allocated'

 Documentation/admin-guide/sysctl/net.rst           |   8 +
 include/net/netns/core.h                           |   1 +
 include/net/proto_memory.h                         |   3 +
 include/net/sock.h                                 |   3 +
 include/net/tcp.h                                  |   3 +
 include/uapi/linux/bpf.h                           |   2 +
 net/core/filter.c                                  |  85 ++++++
 net/core/sock.c                                    |  37 ++-
 net/core/sysctl_net_core.c                         |   9 +
 net/ipv4/af_inet.c                                 |  22 ++
 net/ipv4/inet_connection_sock.c                    |  25 --
 net/ipv4/tcp.c                                     |   3 +-
 net/ipv4/tcp_output.c                              |   7 +-
 net/mptcp/protocol.c                               |   7 +-
 net/tls/tls_device.c                               |   3 +-
 tools/include/uapi/linux/bpf.h                     |   1 +
 .../selftests/bpf/prog_tests/sk_bypass_prot_mem.c  | 292 +++++++++++++++++++++
 .../selftests/bpf/progs/sk_bypass_prot_mem.c       | 104 ++++++++
 18 files changed, 577 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_bypass_prot_mem.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c

