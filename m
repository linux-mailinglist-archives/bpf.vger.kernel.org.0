Return-Path: <bpf+bounces-39665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA276975C51
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 23:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64CA9B223CF
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 21:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169701531C0;
	Wed, 11 Sep 2024 21:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="HAkJNKQr"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D1043144;
	Wed, 11 Sep 2024 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726089335; cv=none; b=m+gRSNyUZ9yZpzXnw+1aoMAJxbBnl409FZr79dRj+G4vLL/KPDkhiF3xCHzxj9Hos5pC7v2XmsP2xhmvdvhF6EirpB2EVhGVzvBQWw8yv3b9DzaqgO9gl5VOdguAu017nVrTINT0lL8Zwhp4yblUR4b8fGIBPKAa+9uR0jjTo9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726089335; c=relaxed/simple;
	bh=aiD4jhs3FNjaxej74Kkim9aO3yEkdJdFx125jZtqfoU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RHfKkE1mxYV3AHMx3G7Evw7zvuOEpT7ZmNP5+OE0FDdkK6WHjk+1M2osaQkIsudL5nGUuEBe5/vS7PFg8J4+p3uQk4EYjNLVy8S6ari2dr3DED92x3v5nqxyPYbZJRbxSI9Gh0DmMvhV4tM/u0R7vOiN/SlIqIuLXQwP/JE9tGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=HAkJNKQr; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=lMzcWWA+32JebC4lylEGT5XwBsI22pFn2wLTuzdXq00=; b=HAkJNKQr4KBd4s7PeQ9YfwGj8J
	Rt6kDy/2CrPL+ismsJp3v4JlYm0IrH//fql/4W0288/eH3bgtguvBZfJjhiM/wz717LZBq/oZqOXc
	ARhnAztLyp32QhHNjM+1t22UhnY8DwiUqT/BbvFqCMurcuYvSydBWf5deZM0vmlaRU1GVYqxv7Tbr
	vfGLMbjT0zXvYkh4+hclqlp6MDmoQaXyYuRa1QH+h3XZnNLJrT/93dfvhWW45GMQDN+QQF8hJLGDY
	13n9Bu4OEYZfZW8YFVrWKWygJ6vTyVdayYIPYMLpYUmn17caWovYDl5PNFLfLQphVZ640eLlumy5x
	83eKsOYQ==;
Received: from 55.249.197.178.dynamic.cust.swisscom.net ([178.197.249.55] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1soUgQ-000AhQ-R0; Wed, 11 Sep 2024 23:15:26 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf-next 2024-09-11
Date: Wed, 11 Sep 2024 23:15:25 +0200
Message-Id: <20240911211525.13834-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27395/Wed Sep 11 10:32:20 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 12 non-merge commits during the last 16 day(s) which contain
a total of 20 files changed, 228 insertions(+), 30 deletions(-).

There's a minor merge conflict in netkit driver, resolve as follows
(https://lore.kernel.org/bpf/2444df33-cd03-a929-9ce8-3cf1376d3f78@iogearbox.net):

  	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
  	dev->priv_flags |= IFF_PHONY_HEADROOM;
  	dev->priv_flags |= IFF_NO_QUEUE;
+ 	dev->priv_flags |= IFF_DISABLE_NETPOLL;
 +	dev->lltx = true;
  
  	dev->ethtool_ops = &netkit_ethtool_ops;
  	dev->netdev_ops  = &netkit_netdev_ops;

The main changes are:

1) Enable bpf_dynptr_from_skb for tp_btf such that this can be used to easily
   parse skbs in BPF programs attached to tracepoints, from Philo Lu.

2) Add a cond_resched() point in BPF's sock_hash_free() as there have been
   several syzbot soft lockup reports recently, from Eric Dumazet.

3) Fix xsk_buff_can_alloc() to account for queue_empty_descs which got noticed
   when zero copy ice driver started to use it, from Maciej Fijalkowski.

4) Move the xdp:xdp_cpumap_kthread tracepoint before cpumap pushes skbs up via
   netif_receive_skb_list() to better measure latencies, from Daniel Xu.

5) Follow-up to disable netpoll support from netkit, from Daniel Borkmann.

6) Improve xsk selftests to not assume a fixed MAX_SKB_FRAGS of 17 but instead
   gather the actual value via /proc/sys/net/core/max_skb_frags, also from
   Maciej Fijalkowski.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Breno Leitao, Cong Wang, Jakub Kicinski, Jakub Sitnicki, Jesper Dangaard 
Brouer, John Fastabend, Magnus Karlsson, Martin KaFai Lau, Nikolay 
Aleksandrov, Stanislav Fomichev, syzbot

----------------------------------------------------------------

The following changes since commit f8fdda9e4f988c210b1e4519a28ddbf7d29b0038:

  Merge branch 'tc-adjust-network-header-after-2nd-vlan-push' (2024-08-27 11:37:46 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to b1339be951ad31947ae19bc25cb08769bf255100:

  sock_map: Add a cond_resched() in sock_hash_free() (2024-09-11 22:16:04 +0200)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Daniel Borkmann (1):
      netkit: Disable netpoll support

Daniel Xu (1):
      bpf, cpumap: Move xdp:xdp_cpumap_kthread tracepoint before rcv

Eric Dumazet (1):
      sock_map: Add a cond_resched() in sock_hash_free()

Maciej Fijalkowski (2):
      xsk: Bump xsk_queue::queue_empty_descs in xp_can_alloc()
      selftests/xsk: Read current MAX_SKB_FRAGS from sysctl knob

Martin KaFai Lau (1):
      Merge branch 'bpf: Allow skb dynptr for tp_btf'

Philo Lu (5):
      bpf: Support __nullable argument suffix for tp_btf
      selftests/bpf: Add test for __nullable suffix in tp_btf
      tcp: Use skb__nullable in trace_tcp_send_reset
      bpf: Allow bpf_dynptr_from_skb() for tp_btf
      selftests/bpf: Expand skb dynptr selftests for tp_btf

Simon Horman (1):
      bpf, sockmap: Correct spelling skmsg.c

Yaxin Chen (1):
      tcp_bpf: Remove an unused parameter for bpf_tcp_ingress()

 drivers/net/netkit.c                               |  1 +
 include/trace/events/tcp.h                         | 12 +++---
 kernel/bpf/btf.c                                   |  3 ++
 kernel/bpf/cpumap.c                                |  6 ++-
 kernel/bpf/verifier.c                              | 36 ++++++++++++++++--
 net/core/filter.c                                  |  3 +-
 net/core/skmsg.c                                   |  2 +-
 net/core/sock_map.c                                |  1 +
 net/ipv4/tcp_bpf.c                                 |  4 +-
 net/xdp/xsk_buff_pool.c                            | 10 ++++-
 net/xdp/xsk_queue.h                                |  5 ---
 .../selftests/bpf/bpf_testmod/bpf_testmod-events.h |  6 +++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |  2 +
 tools/testing/selftests/bpf/prog_tests/dynptr.c    | 37 ++++++++++++++++++-
 .../selftests/bpf/prog_tests/tp_btf_nullable.c     | 14 +++++++
 tools/testing/selftests/bpf/progs/dynptr_fail.c    | 25 +++++++++++++
 tools/testing/selftests/bpf/progs/dynptr_success.c | 23 ++++++++++++
 .../selftests/bpf/progs/test_tp_btf_nullable.c     | 24 ++++++++++++
 tools/testing/selftests/bpf/xskxceiver.c           | 43 +++++++++++++++++++---
 tools/testing/selftests/bpf/xskxceiver.h           |  1 -
 20 files changed, 228 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tp_btf_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c

