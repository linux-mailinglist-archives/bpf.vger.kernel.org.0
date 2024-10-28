Return-Path: <bpf+bounces-43277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016809B2807
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 07:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822801F21BAF
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 06:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4361D18EFF9;
	Mon, 28 Oct 2024 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K0RhwyT9"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5D918DF7D;
	Mon, 28 Oct 2024 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098399; cv=none; b=c4qfNBn5j51yoL+3EXdu9Efx3YfikviUeoTht9JpPuVP2EPZjhiQnfGwFJlwZuCpGwD5uQPUR8rJK8kVftuumO0ugZ/0owA67gJ1bRVTHigBw3TlVBk5mTIUngat7fw9gIbIK1Fy71XQxpXTjMr+u3vbCN0i62CJ3T5dbdXKZrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098399; c=relaxed/simple;
	bh=TogJYoeh0M9kdGAtiQR8MXVdXkWmgbpwWJ/bfasQLnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BBEGgACj+d+DaypwAaZbfslVwI0YGlynAMMmvgSIma8nS9Cp9EVlP3Kw8keRAtDg4xcbARKWoZZTY4UZEJOQ4zhsuCODSN30396UO6A3EW3VaJhzrmqZuPUakVPxQMW7ByyhaUh40ux9u87gbzEdvKpSQ1ggOu0vBgHeQ1obTYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K0RhwyT9; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=gb2og
	vjqOAk5QavOCwc2NuFRUeYMEbkQL5DGyoyp6jw=; b=K0RhwyT9lrnEBzG7oLml+
	KHV8RdDgoO1TjUfU42azWbIZFsM1SSSTv0a1OF6BF+FKZszOxxt7Q624XnwVr7U6
	L+Cbq9HXA1j1cUi8I2obcPI0zghGuzLNxbxo7nFeFLPrWGqTVmcmiVgmV/SvKe9C
	Z2GR1sWy0TIGMQXECzDS1w=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDn70W0NB9nqv9XBw--.5137S2;
	Mon, 28 Oct 2024 14:52:42 +0800 (CST)
From: mrpre <mrpre@163.com>
To: xiyou.wangcong@gmail.com
Cc: yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	edumazet@google.com,
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
Date: Mon, 28 Oct 2024 14:52:26 +0800
Message-ID: <20241028065226.35568-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn70W0NB9nqv9XBw--.5137S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr1rCFy7WFWfXr43KFy5CFg_yoW8ZrWxpF
	ZrGw109a1DJFyDAr4vyFZ7JF13u3ySka4Uurn5WayfArsI9r1SgFWvkw4ayF1YgF4vv3Wa
	qrWYqr1q93WDAwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piX_-PUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDx2Gp2cfJFjVrQACsN

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
v1 -> v2: add more commit message to describle the issue
          v1: https://lore.kernel.org/bpf/Zx1S9vf2i7O+BNE+@pop-os.localdomain/T/
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


