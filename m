Return-Path: <bpf+bounces-43879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 507799BB1D4
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 11:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827E31C221A2
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 10:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDED1CACED;
	Mon,  4 Nov 2024 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvjVUIn5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F89D1C9EDC;
	Mon,  4 Nov 2024 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717522; cv=none; b=YaXaCV/7fbBh8NX7VyiMsnC739DNifP4jIgHHMmtV3I7QvQ6w70udLwVHYvVJrso49b9A29dMDZs8blDobgIIkSQUfpzIWhQvYgBSzwILOP9+5P7Gt6iQa11/Dt0+RIKaCSAOX8/X/SVhqviasfeODMrETchnmUnsjCD2f0Q/A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717522; c=relaxed/simple;
	bh=SxhuDvpyLe08lQ2cNq/7Bt+sb16e8KR2Hp9PnBmPFoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOkAMhFXstoepMC2aRU5SRlTfqeVuxn/dEtydZIJGc76ggwwMPHeh2nQT2/Ldv86V2+XBDfqghJI2/3zGEKx891MiYwwmheeaGeBxBbEK5j1a+uM6SVJ72F8f5ViPBjh00q7xoFV2Ft1/sFber55gUcSy6ktUZODanfH0qPrBGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvjVUIn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22CBC4CED2;
	Mon,  4 Nov 2024 10:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717522;
	bh=SxhuDvpyLe08lQ2cNq/7Bt+sb16e8KR2Hp9PnBmPFoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YvjVUIn5BAq6WQIPIONyBf7Z5lRX+XW+YNYt0akaAfsEfulWE7pF1AjMikohY0khe
	 FKMu4JLnktoW9S1msqTzEdmkDA2G5hZv0JnGgwaJ8vH1rsejy4eY6N6tetZ4agGHDo
	 O8BH31FL4BWliNH/EuZhmHX0L+0SChOEefOZRlPFimBryemmO4PBSgeEDcskm8x9FX
	 6If96hExdhmDNwLjn6aoHXYY89rpVA4LxHHyEpVvztkXhOybKL0Vc8Uf8zBuQ//nYN
	 ns7+POATb4gLo2Nb8Cwq2JPdFSsySOUP6aTM40Fd2PfLviOUTOcQ/DMn9x9BiSGqkf
	 giuikhbrQc16Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiayuan Chen <mrpre@163.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 20/21] bpf: fix filed access without lock
Date: Mon,  4 Nov 2024 05:49:56 -0500
Message-ID: <20241104105048.96444-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105048.96444-1-sashal@kernel.org>
References: <20241104105048.96444-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.6
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <mrpre@163.com>

[ Upstream commit a32aee8f0d987a7cba7fcc28002553361a392048 ]

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
Link: https://lore.kernel.org/r/20241028065226.35568-1-mrpre@163.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_bpf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index fe6178715ba05..915286c3615a2 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -221,11 +221,11 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 				  int flags,
 				  int *addr_len)
 {
-	struct tcp_sock *tcp = tcp_sk(sk);
 	int peek = flags & MSG_PEEK;
-	u32 seq = tcp->copied_seq;
 	struct sk_psock *psock;
+	struct tcp_sock *tcp;
 	int copied = 0;
+	u32 seq;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len, addr_len);
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
2.43.0


