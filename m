Return-Path: <bpf+bounces-46405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20DE9E9A8E
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 16:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB2918866EA
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B791E9B30;
	Mon,  9 Dec 2024 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="k2OGCTq/"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D2C1E9B02;
	Mon,  9 Dec 2024 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758240; cv=none; b=X2copQByppKrsiY1tAeCO9TLfBhW1AjQoo5JwW17X5xkAxQn2jY0dKcJRph6+pZYUj0J7Q3g+9DOeQxx74GRxCaBU7xsR9G0w+bcimlxhODKDRMipchZfNM1HcL9IQGTi+vTCSEK03ywQZ1WKrZD2kVuvBDuhWbYAL4RzLahPnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758240; c=relaxed/simple;
	bh=+pmhuNRkhswua6SLOMooYPuHorwMijotTGOprK61MMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGN3LlvAu3eUJ3MMFeD06DP6ToCYtKcsJraYfx2kk8/ZvSaYn0u83EFSVNMnCTnXGtKx6oOVWFcfd7n6OTXRYfyhG8WKwFKe6MYEfzTld/8XBS4bNJJ+6CxSuTfMU+ERv5C2dTI1fagR3BgVHDOVc1J7IhfLs/I5uTC62dBBgvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=k2OGCTq/; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=4oXAF
	o3Aka3mJCel7XLaaZYfLNktYuW8pXDmkjHW2Rg=; b=k2OGCTq/vVnTuKqqoxLYp
	V8P9g7HlCw3cNTRUoCOTOjR1lXujMOPot/GspsuEWOS0mxudDBlFUKi5rNp3FzQK
	nMF8RYb30PCnnThOj7EdhUIWcXglgKGrT0KXzHVYFDtIb5VtylZmG55oRW88vI/8
	2LFNUAiBPx1kR1BtQ2eNhA=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAnl61uDFdn8utwDA--.9599S2;
	Mon, 09 Dec 2024 23:27:49 +0800 (CST)
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
	linux-kernel@vger.kernel.org,
	song@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	mhal@rbox.co,
	yonghong.song@linux.dev,
	daniel@iogearbox.net,
	xiyou.wangcong@gmail.com,
	horms@kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf v2 0/2] bpf: fix wrong copied_seq calculation and add tests
Date: Mon,  9 Dec 2024 23:27:38 +0800
Message-ID: <20241209152740.281125-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnl61uDFdn8utwDA--.9599S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFyrGFyfXw4kuryDAFyxKrg_yoW5Cw4kpF
	WkC3yFgrnrtFWIvF1DAayIqr4rGw4rCay5Jr1Fqay3Ars8Kr1fZrn7Ka13Zr95GrWrZF15
	Zr1UJrs09w1DZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi5ku7UUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwawp2dXCYWxWwAAsI

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

Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")

---
v1-v2: fix patchwork fail by adding Fixes tag
---

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


