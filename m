Return-Path: <bpf+bounces-46157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0DD9E54EA
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 13:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9056B18828A2
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 12:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCC6217723;
	Thu,  5 Dec 2024 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p8XzPql1"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F030D21767D;
	Thu,  5 Dec 2024 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400314; cv=none; b=W5Q/iVJfkY3a/kUGG3cbUV7qMD9R7IEdchuYZL9RpJipdWaEwyT90p1G3oaFrz7xxTc0q1oZUlIm03hqQcbIwFFGfG1ne3daFy1UGz7/4Ur4nsA7wGU7GvBQNI5voaNg8FQRzpIV36qZzACtXaqSRaNWv9Sw/Zq80EPRm0/iP7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400314; c=relaxed/simple;
	bh=cpBM2mHDOk8ghk0zarIdMmXK6Uy4RCjaekgr+BJriak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JvFarl9yfD8wwF8b0q+sjn+gYa0bA6Feh7qTcWbHnZHDLeNAM4RMypaIahDwfeTCq4oKmPy/mMOVZ4wrZ3s1Jbd359HgxQDbbZHGc/HuSkmaUp5iw3Z2DeWHMjzRigKIXikdtkpmi3IjlokXB1aPaZlkEZKFfJtckhU41Lwd7tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=p8XzPql1; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=uOnIC
	0uuIhcqnFHtdax/VPuxtdeWTkpS66gXN6eM3hg=; b=p8XzPql1BtP0RomjTZmJK
	IpqRQyoeQkggqGnFuHuxvTcdQivRtbNmRH04lI9JcXdrn4rMKh7iIwdtXZPGP0UQ
	Y5xvNw6dUVEAxskpMu+MrM30S+fOVET37Ctzua8lUxGxwgE6lOVEjmbFlcxpECGk
	75ODRe75FoNLc+5LQatj8Q=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgA347I+llFnx_IkAQ--.41744S2;
	Thu, 05 Dec 2024 20:02:15 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	ast@kernel.org,
	edumazet@google.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	song@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	mhal@rbox.co,
	yonghong.song@linux.dev,
	daniel@iogearbox.net,
	xiyou.wangcong@gmail.com,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf 0/2] bpf: fix wrong copied_seq calculation and add tests
Date: Thu,  5 Dec 2024 20:02:02 +0800
Message-ID: <20241205120204.229737-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgA347I+llFnx_IkAQ--.41744S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr4fZw4rtw4UZr4xXr1rtFb_yoW5CrWfpF
	WkC3yFgrnrtFyIvr1kAa4Iqr4rGw4ruay5Jr1Fqay3A398Kr93Zrn7KF43Zr95GrWrZF15
	Zr1jqrsY9w1DZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziU73PUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWw6sp2dRlGM-sQAAsR

bpf: fix wrong copied_seq calculation and add tests

A previous commit described in this topic
https://lore.kernel.org/bpf/20230523025618.113937-9-john.fastabend@gmail.com
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

Modifying tcp_read_sock() or strparser implementation directly is
unreasonable, as it is widely used in other modules.

Here, we introduce a method tcp_bpf_read_sock() to replace 
'sk->sk_socket->ops->read_sock' (like 'tls_build_proto()' does in
tls_main.c). Such replacement action was also used in updating
tcp_bpf_prots in tcp_bpf.c, so it's not weird.
(Note that checkpatch.pl may complain missing 'const' qualifier when we
define the bpf-specified 'proto_ops', but we have to do because we need
update it).

Also we remove strparser check in tcp_eat_skb() since we implement custom
function tcp_bpf_read_sock() without copied_seq updating.

Since strparser currently supports only TCP, it's sufficient for 'ops' to
inherit inet_stream_ops.

In strparser's implementation, regardless of partial or full reads,
it completely clones the entire skb, allowing us to unconditionally
free skb in tcp_bpf_read_sock().

We added test cases for bpf + strparser and separated them from
sockmap_basic. This is because we need to add more test cases for
strparser in the future.

---
Jiayuan Chen (2):
  bpf: fix wrong copied_seq calculation
  selftests/bpf: add strparser test for bpf

 include/linux/skmsg.h                         |   1 +
 include/net/tcp.h                             |   1 +
 net/core/skmsg.c                              |   3 +
 net/ipv4/tcp.c                                |   2 +-
 net/ipv4/tcp_bpf.c                            |  77 +++++-
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  53 ----
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 255 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_strp.c   |  51 ++++
 8 files changed, 386 insertions(+), 57 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_strp.c


base-commit: 5a6ea7022ff4d2a65ae328619c586d6a8909b48b
-- 
2.43.5


