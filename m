Return-Path: <bpf+bounces-32640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B37CC91133C
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 22:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4111C21E3C
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 20:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BB847F53;
	Thu, 20 Jun 2024 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="PbVyRhQd"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFB5B65D;
	Thu, 20 Jun 2024 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718915467; cv=none; b=gDLlgSx4NYyY7KkU7Pj7o1N43V7jFXXUx4g30Tgu+LKaS+DUFp8svEXiF6z/Fg1Stq4LzIXv2nZbvzwz3NGLD6Iko2j90nDAomAhfsLpjXyC1I+755EwToeIg6eui/KAX0hVsLNd7OR02+WiYza7WNsFiGElvTcOvvM8Sazh9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718915467; c=relaxed/simple;
	bh=GTr7qVEeKn8TpSqiDvAM54tg3OmXyYPRreLBfCPwZZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vz5eW5C32/PH2ouUDGHDAIdDsKxavj79EOYyFp7i4sEpZDVkyPQefz8fLwnz0ubvD2X9dTjna4/2H05PyYUSFfymnI86hVD1F6J4lk2T0wEjv8vJFH/FZCEpX5ysHw2QLZlpZL+a0HNmTNTPkC4mKTL7Xxk7zcRxGtY9QGR0frA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=PbVyRhQd; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sKOQl-005IDA-62; Thu, 20 Jun 2024 22:30:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From; bh=/MWyKTy3B9tRc0V1xGrHnx5w5Mqy/KcYsqLepwKLRvw=; b=PbVyRhQd5rVRj
	JLw7GsKKjwFpOgeqL5pn2xfSdYMz/NYrK8j9S2++uySZuBtiMQlXVGBkkBaQcxTmj8fiG+MkgoraJ
	ECXA1AM2UHiNz3gnoG41ito6KyGFXeoQQBnN659aSivEzLvpyRM+wDlMUCJDLuLsx0WPlI4pbxMkS
	byKtNgyaPZ8MqC7wNbEnxFe2yfweM15c7GUk8gs7FjfSv+gilXkK4FMd003eM0o0DaAZo6xpoE8gz
	EOouKx4EreHXpBpeVK40jQnrayxsfjew6H5UEjRJciKfulggWAEFdNuXg/fuuc9r/kVYFE3uiKHNH
	Hnxs5ejlgNMfSXqwh0bOA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sKOQk-0000Ph-DL; Thu, 20 Jun 2024 22:30:50 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sKOQi-00HTXs-Vv; Thu, 20 Jun 2024 22:30:49 +0200
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
	Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net] af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash
Date: Thu, 20 Jun 2024 22:20:05 +0200
Message-ID: <20240620203009.2610301-1-mhal@rbox.co>
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
 net/unix/af_unix.c  | 30 +++++++++++++++++++++++++++++-
 net/unix/unix_bpf.c |  3 +++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5e695a9a609c..3a55d075f199 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2653,10 +2653,38 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 
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
+
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+	if (skb) {
+		bool drop = false;
+
+		spin_lock(&sk->sk_receive_queue.lock);
+		if (skb == u->oob_skb) {
+			WRITE_ONCE(u->oob_skb, NULL);
+			drop = true;
+		}
+		spin_unlock(&sk->sk_receive_queue.lock);
+
+		if (drop) {
+			WARN_ON_ONCE(skb_unref(skb));
+			kfree_skb(skb);
+			skb = NULL;
+			err = -EAGAIN;
+		}
+	}
+#endif
+
+	mutex_unlock(&u->iolock);
+	return skb ? recv_actor(sk, skb) : err;
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


