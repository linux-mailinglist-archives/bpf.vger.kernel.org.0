Return-Path: <bpf+bounces-49052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD73DA13BB3
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 15:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FFF3A9C35
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 14:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF5422B5B2;
	Thu, 16 Jan 2025 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IhR5O/2s"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881FF3BBC5;
	Thu, 16 Jan 2025 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036473; cv=none; b=hlZ6wWimzptHD2cUA5ThLhzdoqDVmJOGv/Z2SMzjaqymC4CCpt2BgyziDqUKSNuJYs3rzHF9iBjiWUBV3kL1gh9Jumu7JBOgQ1QvDnsoXQK5BhBRRozasHLmi+Y47BhK78ARjBP7KQA1CGh4wlIe+KcmyFAw5J79vmIFi0ED8WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036473; c=relaxed/simple;
	bh=qDDszGLFZbkocWudTbx04OroDq+KUvoNCTQGknbvHvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MD22rRfkk84uJtUBvUO1jxkpBMJS8i6z/kO8pjeI1ABlJYEGqc+tUyw/I/pyX9FpfRIPsCPQs82J8vbdbgmz7tZGzbrD+c7swEwtWl/kfeMnLyrQjcH5OrX+2bRHyhem+HrIIdt1fE0gHbNm/hnLDDinyLHmapKI5MtsCFx9TMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IhR5O/2s; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=NBocW
	ZCLvopgnMePJRakkB0MKYnFNzqXan9lXnHlZjE=; b=IhR5O/2s51aftDVwCswFF
	xp1Ec4Fw2HLFUcLa7olpjt6np144C/8mYwGbWN0BPjW0eS0N+WvPRmFRP/jYjkDq
	EstF/5C9KAoex+f6ChSLvmNZwTecN/VUV1Pll8ws97EiDhsbsAejJ1RhlR/0U8QA
	BuK/HsOgGP2IfmPtB9OayI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3d5IwEolnR5IwGg--.20972S2;
	Thu, 16 Jan 2025 22:05:46 +0800 (CST)
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
Subject: [PATCH bpf v7 0/5] bpf: fix wrong copied_seq calculation and add tests
Date: Thu, 16 Jan 2025 22:05:26 +0800
Message-ID: <20250116140531.108636-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3d5IwEolnR5IwGg--.20972S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFyrGFyfXw4kuryDAFyxKrg_yoW5Ar4UpF
	WkC34rGr47tFyIvw4DA392gF4rKw4rCayUKF1Fq3yfAw4jkryYyrs2ka4aqr98GrWrZF1U
	ur15Wr4Y934DAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_pnQ7UUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwvWp2eJDhZJNQAAs-

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
V3 -> V7:
https://lore.kernel.org/bpf/20250109094402.50838-1-mrpre@163.com/
https://lore.kernel.org/bpf/20241218053408.437295-1-mrpre@163.com/
Avoid introducing new proto_ops. (Jakub Sitnicki).
Add more edge test cases for strparser + bpf.
Fix patchwork fail of test cases code.
Fix psock fetch without rcu lock.
Move code of modifying to tcp_bpf.c.

V1 -> V3:
https://lore.kernel.org/bpf/20241209152740.281125-1-mrpre@163.com/
Fix patchwork fail by adding Fixes tag.
Save skb data offset for ENOMEM. (John Fastabend)

Jiayuan Chen (5):
  strparser: add read_sock callback
  bpf: fix wrong copied_seq calculation
  bpf: disable non stream socket for strparser
  selftests/bpf: fix invalid flag of recv()
  selftests/bpf: add strparser test for bpf

 Documentation/networking/strparser.rst        |  11 +-
 include/linux/skmsg.h                         |   4 +
 include/net/strparser.h                       |   2 +
 include/net/tcp.h                             |   3 +
 net/core/skmsg.c                              |  23 +
 net/core/sock_map.c                           |  13 +-
 net/ipv4/tcp.c                                |  29 +-
 net/ipv4/tcp_bpf.c                            |  47 ++
 net/strparser/strparser.c                     |  11 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  59 +--
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 452 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_strp.c   |  53 ++
 12 files changed, 642 insertions(+), 65 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_strp.c

-- 
2.43.5


