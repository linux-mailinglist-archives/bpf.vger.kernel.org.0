Return-Path: <bpf+bounces-48770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AB4A107B7
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 14:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C263A6209
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 13:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667EF284A48;
	Tue, 14 Jan 2025 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EMDhdoUL"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D580236EA7;
	Tue, 14 Jan 2025 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736861136; cv=none; b=Ueigp8DlyTM+tTR+S2sDBmVKEzNdruD0820k7xRwuAB/nh53EdAuz9DxenKVzoPuggus5arPuEhwCFm5qulLdz47OSTQEW069scTAoJ/uWLnw45kxWl18jKY+Z6Nnm2V7MWz8NEiuQGUQ6tPJkv7sYU5+tBYHLNnkMuD86Nn35M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736861136; c=relaxed/simple;
	bh=n2AzDWonAYwOKLO8ylv2VcNlw6AmQ0C+qfIbvQL/okU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H1ILRSuJ83MB0+EQoEoB5ZBMD9kp5mwBf4B/MtE2TW08SJn0uBTKNpSDtqoHwKDX1lram6RsZp82eNBqhoCsM9cBTwBEvYOXiYL97yPDOYVG03aoqUJRsbS09/6B16xOWjPYlFyMNPyoN2IstjUhDLJzqGKCmN3iOQ/gUeuNy5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EMDhdoUL; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=qL454
	SbW0mXAyAJzaI/Sx5ya8UOqFy/+uOgDo0q8WoA=; b=EMDhdoULd1Gt5CODbNGbF
	UQzLi0+76G2tJ8CfM3AaaFELBWUUipbuHtQd/I66sLjOy+3OYtCs0qI0gBW8pSai
	LYxEga62+Pr34prqu5zECGlJOfenx8dPbayWjfX66eSIyqS01QRDVwsmaI9RbV+m
	jRvpW7XYAnEjNzhdC1qyz0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCn_E1RZYZnl71AAw--.33013S2;
	Tue, 14 Jan 2025 21:23:40 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com
Cc: netdev@vger.kernel.org,
	martin.lau@linux.dev,
	ast@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	song@kernel.org,
	andrii@kernel.org,
	mhal@rbox.co,
	yonghong.song@linux.dev,
	daniel@iogearbox.net,
	xiyou.wangcong@gmail.com,
	horms@kernel.org,
	corbet@lwn.net,
	eddyz87@gmail.com,
	cong.wang@bytedance.com,
	shuah@kernel.org,
	mykolal@fb.com,
	jolsa@kernel.org,
	haoluo@google.com,
	sdf@fomichev.me,
	kpsingh@kernel.org,
	linux-doc@vger.kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf v6 0/3] bpf: fix wrong copied_seq calculation and add tests
Date: Tue, 14 Jan 2025 21:23:08 +0800
Message-ID: <20250114132312.49407-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCn_E1RZYZnl71AAw--.33013S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFyrGFyfXw4kuryDAFyxKrg_yoW5Wr4xpF
	WkC34rGr47tFyxZws7A3yIgF4Fgw4rCayUGr1Sq3yfZr4jkryYyrs29ayaqrn8GrWfZF1j
	9r15Wrn0934DZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_pnQ7UUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwXUp2eGZBAZbgAAsb

A previous commit described in this topic
http://lore.kernel.org/bpf/20230523025618.113937-9-john.fastabend@gmail.com
directly updated 'sk->copied_seq' in the tcp_eat_skb() function when the
action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
the update logic for 'sk->copied_seq' was moved to
tcp_bpf_recvmsg_parser() to ensure the accuracy of the 'fionread' feature.

That commit works for a single stream_verdict scenario, as it also
modified 'sk_data_ready->sk_psock_verdict_data_ready->tcp_read_skb'
to remove updating 'sk->copied_seq'.

However, for programs where both stream_parser and stream_verdict are
active(strparser purpose), tcp_read_sock() was used instead of
tcp_read_skb() (sk_data_ready->strp_data_ready->tcp_read_sock)
tcp_read_sock() now still update 'sk->copied_seq', leading to duplicated
updates.

In summary, for strparser + SK_PASS, copied_seq is redundantly calculated
in both tcp_read_sock() and tcp_bpf_recvmsg_parser().

The issue causes incorrect copied_seq calculations, which prevent
correct data reads from the recv() interface in user-land.

Also we added test cases for bpf + strparser and separated them from
sockmap_basic, as strparser has more encapsulation and parsing
capabilities compared to sockmap.

Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")

---
V3 -> V6:
https://lore.kernel.org/bpf/20250109094402.50838-1-mrpre@163.com/
https://lore.kernel.org/bpf/20241218053408.437295-1-mrpre@163.com/
Avoid introducing new proto_ops. (Daniel Borkmann).
Add more edge test cases for strparser + bpf.
Fix patchwork fail of test cases code.
Fix psock fetch without rcu lock.
Move code of modifying to tcp_bpf.c.

V1 -> V3:
https://lore.kernel.org/bpf/20241209152740.281125-1-mrpre@163.com/
Fix patchwork fail by adding Fixes tag.
Save skb data offset for ENOMEM. (John Fastabend)
---
Jiayuan Chen (3):
  bpf: fix wrong copied_seq calculation
  selftests/bpf: add strparser test for bpf
  strparser, docs: Add new callback

 Documentation/networking/strparser.rst        |  11 +-
 include/linux/skmsg.h                         |   2 +
 include/net/strparser.h                       |   2 +
 include/net/tcp.h                             |   8 +
 net/core/skmsg.c                              |  22 +-
 net/ipv4/tcp.c                                |  29 +-
 net/ipv4/tcp_bpf.c                            |  41 ++
 net/strparser/strparser.c                     |  11 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  53 --
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 452 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_strp.c   |  53 ++
 11 files changed, 622 insertions(+), 62 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_strp.c

-- 
2.43.5


