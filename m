Return-Path: <bpf+bounces-32812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F80D9136A4
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 00:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151911F224BD
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 22:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D3C757E0;
	Sat, 22 Jun 2024 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="oR6lf0t0"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AEEDDCD;
	Sat, 22 Jun 2024 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719095685; cv=none; b=RPX/y0sU+LGGAP/2Zz7J0IT+LrUmMtwvcLOmFSKw0Va3+uKWK7/ajlokqpvKTTx6gcvqYrJOzRaAkXW+uFJsFP3rmWuY3Y9Hi4ObkmA1ZVQr6P9sSO2rYSlw8iM5m2dLM9J/vzos7g0/ByQ5QFWkg+d0at2EoxO5GyfyNCLstfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719095685; c=relaxed/simple;
	bh=2ZKzeRYWp4J6nTt0VwlwNYCBGkcHoAYLMQGkKXZZqxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5DvjrHToFElTeUOS1hUsELCC2xBP/KlGz9el0LgfhE1113+0CwFgjRnUpLgl1foEu5mWBcb00gdhl0G/RaFgrt5GbcFIti0XSSvd9U8FtD2f4wIdg4ZOv3QAZ0koiHrV1ARab7zAdWGnjfCQcXvW8AH8IubAjnpvEK1svpVrF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=oR6lf0t0; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sL9JR-008ha0-W0; Sun, 23 Jun 2024 00:34:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From; bh=EcVM4biueuVyljjFa33ofGrK0b45C09o4BeBDnLdYJ0=; b=oR6lf0t0D4X2w
	TBP+4RXAbDqjgAhikey6ikQPa3rkqnS4VyTtCSwXIZim3oXLS5QgWBc60KHFzJJW6MkcqSuvMAYCI
	+eBVXp66vriTueec0JbYq90B9wgL5avnl+lM79vcmoe10V+T3f/kPXE9YLrNfkRIdXvHYowF5YzwL
	JdIGedy41+CxvxzsUkV/ghtDn7HF9QSB5k7eVPGoHQfBCSOnqiTH5sa2G3/K7UyzHgTs1hDTSkiMy
	qK45nRraXogeEIiRuiTPVgDG7CDMdbgNlXnCk2wFEf0KADW+CVAYE3BGMpEWfM8bflj/9m8UrN7Hg
	PIA5x4adZxK/E1a/F62VQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sL9JL-0001i5-K0; Sun, 23 Jun 2024 00:34:19 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sL9J1-00791R-NI; Sun, 23 Jun 2024 00:33:59 +0200
From: Michal Luczaj <mhal@rbox.co>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	kuniyu@amazon.com,
	Rao.Shoaib@oracle.com,
	Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf v2] af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash
Date: Sun, 23 Jun 2024 00:25:12 +0200
Message-ID: <20240622223324.3337956-1-mhal@rbox.co>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_UNIX socket tracks the most recent OOB packet (in its receive queue)
with an `oob_skb` pointer. BPF redirecting does not account for that: when
an OOB packet is moved between sockets, `oob_skb` is left outdated. This
results in a single skb that may be accessed from two different sockets.

Take the easy way out: silently drop MSG_OOB data targeting any socket that
is in a sockmap or a sockhash. Note that such silent drop is akin to the
fate of redirected skb's scm_fp_list (SCM_RIGHTS, SCM_CREDENTIALS).

For symmetry, forbid MSG_OOB in unix_bpf_recvmsg().

Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
v2:
  - Reduce time under mutex, restructure (Kuniyuki)
  - Handle unix_release_sock() race

v1: https://lore.kernel.org/netdev/20240620203009.2610301-1-mhal@rbox.co/

 net/unix/af_unix.c  | 41 ++++++++++++++++++++++++++++++++++++++++-
 net/unix/unix_bpf.c |  3 +++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5e695a9a609c..b7b7ee84bec0 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2653,10 +2653,49 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 
 static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
+	struct unix_sock *u = unix_sk(sk);
+	struct sk_buff *skb;
+	int err;
+
 	if (unlikely(READ_ONCE(sk->sk_state) != TCP_ESTABLISHED))
 		return -ENOTCONN;
 
-	return unix_read_skb(sk, recv_actor);
+	mutex_lock(&u->iolock);
+	skb = skb_recv_datagram(sk, MSG_DONTWAIT, &err);
+	mutex_unlock(&u->iolock);
+	if (!skb)
+		return err;
+
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+	if (unlikely(skb == READ_ONCE(u->oob_skb))) {
+		bool drop = false;
+
+		unix_state_lock(sk);
+
+		if (sock_flag(sk, SOCK_DEAD)) {
+			unix_state_unlock(sk);
+			kfree_skb(skb);
+			return -ECONNRESET;
+		}
+
+		spin_lock(&sk->sk_receive_queue.lock);
+		if (likely(skb == u->oob_skb)) {
+			WRITE_ONCE(u->oob_skb, NULL);
+			drop = true;
+		}
+		spin_unlock(&sk->sk_receive_queue.lock);
+
+		unix_state_unlock(sk);
+
+		if (drop) {
+			WARN_ON_ONCE(skb_unref(skb));
+			kfree_skb(skb);
+			return -EAGAIN;
+		}
+	}
+#endif
+
+	return recv_actor(sk, skb);
 }
 
 static int unix_stream_read_generic(struct unix_stream_read_state *state,
diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index bd84785bf8d6..bca2d86ba97d 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -54,6 +54,9 @@ static int unix_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 	struct sk_psock *psock;
 	int copied;
 
+	if (flags & MSG_OOB)
+		return -EOPNOTSUPP;
+
 	if (!len)
 		return 0;
 
-- 
2.45.1


