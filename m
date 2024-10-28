Return-Path: <bpf+bounces-43276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942449B2539
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 07:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05073B209F8
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 06:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C59918E04D;
	Mon, 28 Oct 2024 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M5UadF+U"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95B1142E86;
	Mon, 28 Oct 2024 06:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730096715; cv=none; b=vGo3cPzZMlQJy8nTthJfKmVdFvZan/lzLKMRAK+FmFYkxyurSBoLFLEKe50W8FPQpY63NN7Cq/SJNZH11pTOHdODcJpBMOMPf/IY79kmG7FbI5YOYtoKxJ8ExHHVbPkTRui5VIS5NobGRYf7tTfahpQWx1nhtLBp/4KdtppXHEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730096715; c=relaxed/simple;
	bh=V4+xfa194CBFp5q3Inlgr8aVzHzK5NZ5xiP0OuJVVKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFcTPqlVjRvZitxhuMgDJe++SqedsRKVcBjoA7vOkHxx0Bxc5YQXxi7H341Dv0cOG2nWTUhxFq44hXqbjD3Kh0QL3OPZMs6pkSbSm6ONykfuS3AEWPzBCc8T2I8Mw7qAsv6WQqqJhhB6fAOPU1KSQPCLdVBD153gdWLcVMuWr0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M5UadF+U; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=MnCJU
	2J3pJ6fwUvA85VlD1sdw0N2m8tj2xG8I7tc5pg=; b=M5UadF+UJiIiYXpJuOvA8
	xaDhrgCah03hkeerzByUdAGNoXhmsfL8ZZrSNMUl8QvFgc5j+TORgOK29Zv6zd7N
	+BTr36Wb69mVOViai8nsvVF2zZCEVrMD6pLmaayOlAJmj8JqmnCHyvauyO5F70Hr
	VStn42LJUl6OPJejqzegxI=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnDzAfLh9nUZxTBw--.19283S2;
	Mon, 28 Oct 2024 14:24:36 +0800 (CST)
From: mrpre <mrpre@163.com>
To: xiyou.wangcong@gmail.com
Cc: edumazet@google.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mrpre <mrpre@163.com>
Subject: [PATCH v2] bpf: fix filed access without lock
Date: Mon, 28 Oct 2024 14:23:34 +0800
Message-ID: <20241028062334.35488-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241021013705.14105-1-mrpre@163.com>
References: <20241021013705.14105-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnDzAfLh9nUZxTBw--.19283S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr1rCFy7WFWfXr43KFy5CFg_yoW8CFy3pF
	ZrGw109a1DJFWDAr4vyFZ7JF13W3ySka4Uurn5uayfArsI9r1fKFWvkw4ayF1YgF4vvw1a
	qrWjqr1q93WDA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piX_-PUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDxyGp2cfJbW6RwAAsn

The tcp_bpf_recvmsg_parser() function, running in user context,
retrieves seq_copied from tcp_sk without holding the socket lock, and
stores it in a local variable seq. However, the softirq context can
modify tcp_sk->seq_copied concurrently, for example, n tcp_read_sock().

As a result, the seq value is stale when it is assigned back to
tcp_sk->copied_seq at the end of tcp_bpf_recvmsg_parser(), leading to
incorrect behavior.

Due to concurrency, the copied_seq field in tcp_bpf_recvmsg_parser()
might be set to an incorrect value (less than the actual copied_seq) at
the end of function: 'WRITE_ONCE(tcp->copied_seq, seq)'. This causes the
'offset' to be negative in tcp_read_sock()->tcp_recv_skb() when
processing new incoming packets (sk->copied_seq - skb->seq becomes less
than 0), and all subsequent packets will be dropped.

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
V1 -> V2: add more commit message to describle the issue
---
 net/ipv4/tcp_bpf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index e7658c5d6b79..7b44d4ece8b2 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -221,9 +221,9 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 				  int flags,
 				  int *addr_len)
 {
-	struct tcp_sock *tcp = tcp_sk(sk);
+	struct tcp_sock *tcp;
+	u32 seq;
 	int peek = flags & MSG_PEEK;
-	u32 seq = tcp->copied_seq;
 	struct sk_psock *psock;
 	int copied = 0;
 
@@ -238,7 +238,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 		return tcp_recvmsg(sk, msg, len, flags, addr_len);
 
 	lock_sock(sk);
-
+	tcp = tcp_sk(sk);
+	seq = tcp->copied_seq;
 	/* We may have received data on the sk_receive_queue pre-accept and
 	 * then we can not use read_skb in this context because we haven't
 	 * assigned a sk_socket yet so have no link to the ops. The work-around
-- 
2.43.5


