Return-Path: <bpf+bounces-48350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E426A06C62
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 04:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0275116430E
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 03:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C70143759;
	Thu,  9 Jan 2025 03:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oB4alu/p"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B6F4A2D;
	Thu,  9 Jan 2025 03:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736394137; cv=none; b=ryiXTUa0F40wSQFHx80Nq2W/IfyD9m2KcXpszLO+hd2kaaCLqG+nJdMyuJ8k2u+nGJVmrHbZdI0K0dMRij9gGgvUCNWaq6aeO4ZTYuFdYRUcmGzXurvRe4sEBK3fBoyLN9V0o2tq3mDjBtj+fsJwq2kYUcFON/ErMQC9AiS9+jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736394137; c=relaxed/simple;
	bh=LJZ2nUI/GG2GnRM8M1WxMzv6vt9edqJCSAD+UOgdUmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eO8L6bD/zGCAoz7BcGL1jSAIBcIs0E721NRJNYj1GuJ2bkFMjqhvIVjjfQt6H7IudS+3nuzaQQiecyMZuuL9lfYw73DzsEnJbxKg0S9vv90sOn/YaeaD6aIt1NhQqp+0npVG+cCV172fE5pikYwtc23NAWxqtZ9WhFGNWCM8kPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oB4alu/p; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=CebMC
	NI4PIbKZdhA2SCMDBTyDltj8KPOIjjMYZgPmkw=; b=oB4alu/pe6qBbOXN3IdZ2
	BTps/B432eL58V4dCx1TDs4hoQqIHAi0gm3SYsXo4wO0hjevUA18VtIT9gsLDrUa
	nQkk9iOAouIk6qinObfrMOk+bzo1K6d65TDp3cxnPcZiZrIW+ubA60Bt37f730I9
	cdpnBCXinNQ+An/UJ5k+Ew=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAXYaYcRX9na6O1Jw--.42275S2;
	Thu, 09 Jan 2025 11:40:22 +0800 (CST)
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
Subject: [PATCH bpf v4 0/3] bpf: fix wrong copied_seq calculation
Date: Thu,  9 Jan 2025 11:40:02 +0800
Message-ID: <20250109034005.861063-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAXYaYcRX9na6O1Jw--.42275S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFyrGFyfXw4kuryDAFyxKrg_yoW5GFWDpa
	ykC34rGrsrtFyIvwsrA3yIgF4Fgw4rGayUGr1Fg3yfZr4UKryYqrs7Kayayr98GrWrZFyU
	ur15Wrs0934DuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piCeHfUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWxnPp2d-PnPPEgAAsi

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
V3 -> v4:
https://lore.kernel.org/bpf/20241218053408.437295-1-mrpre@163.com/
Avoid introducing new proto_ops. (Daniel Borkmann).
Add more edge test cases for strparser + bpf.
Fix patchwork fail of test cases code.

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
 net/core/skmsg.c                              |  42 ++
 net/ipv4/tcp.c                                |  31 +-
 net/strparser/strparser.c                     |  11 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  53 --
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 452 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_strp.c   |  53 ++
 10 files changed, 599 insertions(+), 61 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_strp.c

-- 
2.43.5


