Return-Path: <bpf+bounces-47195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EAA9F5E50
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 06:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED59188C06B
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 05:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41588154439;
	Wed, 18 Dec 2024 05:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kSaLxwd7"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98830143C72;
	Wed, 18 Dec 2024 05:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734500148; cv=none; b=k41I7wzQuemAxM1bLfyZgLfIQGIGuiHIG/vGk2sYIGn5ELI5qzOkEVP6PU4UcKdcuBoaGU74keWPFRYelgxvpEtBbNiw2fDWMgY/tENvG+qkKAmVQPWxU7Mu+29Rvs8WlSnvkixJtDJ0UW3AtoOYnsjyfScd5UIwTBtVzlqyqgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734500148; c=relaxed/simple;
	bh=tOv70svTsw5JyE7ZRJMqQry+EwpddJvzh9JBA924Ws0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dptVNyvq9Cc4sfGgglbzowOxtv/RcOo0JVsrHUNRg36cslRqLUXfa1pi4jzW8cRXXznYCaonAa43j8UlTOIT7fPa8LpEO/1RwDnWqYBPu+Ryqe6aPq6aMMIusH3ePHNa23fzlb715TmNBmOn+ClVcI+ctodTscoyeTJGQTC5jwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kSaLxwd7; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=K4Dtg
	rKG1R64fHEoii+RKwFL3H1AcpX+UCf6j3HNLBo=; b=kSaLxwd7HaFGlnoaV4hY6
	kIyoL4s3WErZznBym/y770iBYiANLpbYXPiT+s9+WWOyWClyugUM51jSYaIqZcdr
	v3buBs0Zya+PaW2v9QqPFqBySgCAEdovKDO9kuQRimxl4bse/Qq/+qhcQdb/bgi6
	4CBtGpHD/lcDbjTDHi6cLU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXf3juXmJn1VZZBQ--.30577S2;
	Wed, 18 Dec 2024 13:34:46 +0800 (CST)
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
Subject: [PATCH bpf v3 0/2] bpf: fix wrong copied_seq calculation and add tests
Date: Wed, 18 Dec 2024 13:34:06 +0800
Message-ID: <20241218053408.437295-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXf3juXmJn1VZZBQ--.30577S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFyrGFyfXw4kuryDAFyxKrg_yoW5CFyxpF
	WkC3yFgrnrtFWIvFnrAayIqF4rGw4rCay5Jr1rXay3Zr4UKr93Zrn7KF43Zr95GrW5ZF15
	Zr15Xrs09w1DZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziYFAPUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWw25p2diVznI9QABsf

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

We added test cases for bpf + strparser and separated them from
sockmap_basic. This is because we need to add more test cases for
strparser in the future.

Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")

---
v2-v3: save skb data offset for ENOMEM. (John Fastabend)
https://lore.kernel.org/bpf/20241209152740.281125-1-mrpre@163.com/#r

v1-v2: fix patchwork fail by adding Fixes tag

---
Jiayuan Chen (2):
  bpf: fix wrong copied_seq calculation
  selftests/bpf: add strparser test for bpf

 include/linux/skmsg.h                         |   2 +
 include/net/tcp.h                             |   1 +
 net/core/skmsg.c                              |   3 +
 net/ipv4/tcp.c                                |   2 +-
 net/ipv4/tcp_bpf.c                            | 108 +++++-
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  53 ---
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 344 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_strp.c   |  51 +++
 8 files changed, 507 insertions(+), 57 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_strp.c


base-commit: 5a6ea7022ff4d2a65ae328619c586d6a8909b48b
-- 
2.43.5


