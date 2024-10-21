Return-Path: <bpf+bounces-42560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8799A5896
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 03:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F2C1C20C82
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 01:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2206417BA0;
	Mon, 21 Oct 2024 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dc1bdN8V"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9B610A3E;
	Mon, 21 Oct 2024 01:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729474685; cv=none; b=l+2SLK9x/M/mM6ad8GQuWsfJET8jVWx0wtNswcBbbnITQKivt0ws5eojuHxXxludotSbcIWh6qjzELwYfH0VFeVCEPxxskozZWV8vxwB0HS2jtkzADJn0DMZ1oIhrwngsTcBH753VKeupwA9aSqJbPE6GwDOGi9Epf2E3FxqSzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729474685; c=relaxed/simple;
	bh=bxM0ZLnlcZakhZciREqbmanZ3MijgpsLdgCyFRhr840=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hybb4iDSaplTyMVeFvR6gjHmomRtdALDJaxr1cVyTqFGu1d/cZa6eGkWwPeTyw6Rw/I1meMYmr+evZ0FE+HhcEdwn1a/694HdWNpLkWbcxPKpOd1wtWgo8d8YLz8ijDOPkQQdOAKSdOegKXw4bhJAkz3GGcXwBAPW3fh03Q70OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dc1bdN8V; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=upPl/
	vJF+V+jNENLlbjlbuE9AJVSMOuiWd7sj3jAOxE=; b=dc1bdN8VSSUJMIstf7spe
	RtDvdUWoIw0tzK7f3d3vWbPZ619PuH9MIac0NX0Z8kzhXY9wk44nrc46O20ZIYDs
	tIYvO28vHdciTxftiSySrGpXU9BPRHsZGXKxlaku9tOsjbMo2aMFG3vMpJqrQ7KO
	6oKLeFWFyqkY0h4BddFgKA=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCHr_VEsBVn0pyDCQ--.33600S2;
	Mon, 21 Oct 2024 09:37:13 +0800 (CST)
From: mrpre <mrpre@163.com>
To: edumazet@google.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mrpre <mrpre@163.com>
Subject: [PATCH] bpf: fix filed access without lock
Date: Mon, 21 Oct 2024 09:37:05 +0800
Message-ID: <20241021013705.14105-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHr_VEsBVn0pyDCQ--.33600S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr1rCFy7Ar1fKr4rKw48Zwb_yoW8GFyrpF
	y7Cw109a1qyFWDAr4vyFWkJF13W3ySka4Uurn5W3y3Arsrur13tFWkKw4YyF1F9Fs2yF4a
	qrWjgF1jka1DCwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piuyIUUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDwl-p2cVqsaoXQAAs1

The tcp_bpf_recvmsg_parser() function, running in user context,
retrieves seq_copied from tcp_sk without holding the socket lock, and
stores it in a local variable seq. However, the softirq context can
modify tcp_sk->seq_copied concurrently, for example, n tcp_read_sock().

As a result, the seq value is stale when it is assigned back to
tcp_sk->copied_seq at the end of tcp_bpf_recvmsg_parser(), leading to
incorrect behavior.

Signed-off-by: mrpre <mrpre@163.com>
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


