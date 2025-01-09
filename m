Return-Path: <bpf+bounces-48379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD5EA0720A
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 10:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077591889EA2
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 09:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC141216E2A;
	Thu,  9 Jan 2025 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Z1gxGGOW"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C431215196;
	Thu,  9 Jan 2025 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415964; cv=none; b=mDHXpUTSXx8Ln+BGf/nlYHHSkn0bzNHv7LlNVxqGalmtPOECkIfcQu0vEer8WwVXchhIkHMGbHRWJEp6bnHRXpoEM+FJoSZ59ZGLdKPA+0j61CbK6Gl1yt92S8A+0L+IAouB+tZFp3YDZkRz4aVSQo1Z0nyotOo5UtrwH3Ccugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415964; c=relaxed/simple;
	bh=/Qa2UjJ0b5rnf65YAmkRT5HsCFtqyO4xwOCtnsfcApo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vyon5o3CwVd+eEDy4s+e+uKfyIv/vCwK8jef01N8xq+CV8Ed//VEDiotFk5DXrb8XHy+qq31gSNRMvNsxkbRJGVC828ZWha/x00Pzha5NXTjfsb9OT+ESDl/KU2nPDYZk3OJHxQ5tCV4/ukGD4GDNKf34NjrtPl7XYasZTdqMsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Z1gxGGOW; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=8xhBr
	X7bFrX+P2iFnaqQorXCjWJV0bubNbzGOosUR34=; b=Z1gxGGOWeKHi/9pD9FUKC
	c0QA35WxF+8XMBH74lLwCMDOfWohqxuuScW5pUKM2xwfH8d3+qD2ZT9TMtBstL+J
	HxYWGcx/NBmyNR380IXxlEPtb/U9CcYyDYaaTO0jJDSU5gR7sQ/s8MDWllWHt4mI
	Z93Msfp7w+LJuX9sSogvPI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBnDnRlmn9no5XNEA--.12216S2;
	Thu, 09 Jan 2025 17:44:16 +0800 (CST)
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
Subject: [PATCH bpf v5 0/3] bpf: fix wrong copied_seq calculation and add tests
Date: Thu,  9 Jan 2025 17:43:58 +0800
Message-ID: <20250109094402.50838-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBnDnRlmn9no5XNEA--.12216S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFyrGFyfXw4kuryDAFyxKrg_yoW5Xr13pa
	4kC34rGrsrtFyIvws7A392gF4Fgw4rGayUGF1Fg3yfZr4jkry5trs7Kayavr98GrWfZFyU
	ur15Wrs0934DZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_pnQ7UUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDxHPp2d-mjQFwwAAsG

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
V3 -> v5:
https://lore.kernel.org/bpf/20241218053408.437295-1-mrpre@163.com/
Avoid introducing new proto_ops. (Daniel Borkmann).
Add more edge test cases for strparser + bpf.
Fix patchwork fail of test cases code.
Fix psock fetch without rcu lock.

V1 -> V3:
https://lore.kernel.org/bpf/20241209152740.281125-1-mrpre@163.com/
Fix patchwork fail by adding Fixes tag.
Save skb data offset for ENOMEM. (John Fastabend)
---

Jiayuan Chen (3):
  bpf: fix wrong copied_seq calculation
  selftests/bpf: add strparser test for bpf
  bpf, strparser, docs: Add new callback for bpf

 Documentation/networking/strparser.rst        |  11 +-
 include/linux/skmsg.h                         |   2 +
 include/net/strparser.h                       |   2 +
 include/net/tcp.h                             |   3 +
 net/core/skmsg.c                              |  51 ++
 net/ipv4/tcp.c                                |  31 +-
 net/strparser/strparser.c                     |  11 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  53 --
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 452 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_strp.c   |  53 ++
 10 files changed, 608 insertions(+), 61 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_strp.c

-- 
2.43.5


