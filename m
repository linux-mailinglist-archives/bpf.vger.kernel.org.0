Return-Path: <bpf+bounces-34023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF8B929A3C
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 01:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3AE1F212FD
	for <lists+bpf@lfdr.de>; Sun,  7 Jul 2024 23:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE2A6F2FD;
	Sun,  7 Jul 2024 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Mh7peUDT"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99577101D4;
	Sun,  7 Jul 2024 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720394835; cv=none; b=ZZIZl24mhjJ/onyOMaX/XZFEBo/Nj32GfgsuWv+AUi1CDaKz0IPO6Tmaud009M7F2EGCrl9ujDr/jlrIPWpAwmDg0LmHgSxKOEnyP01NhTQfgABgfX4PErITZ9fKkuRjRb8aF2yi0Nkh5P64vRdCEkyNpmVbHe2RYgI8xOTTn0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720394835; c=relaxed/simple;
	bh=LRwdrUN8Ya95nK4RNxzM5XFpnqtnV35sN1AGNWTIjZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWUESFfZU2kFpNqKU2aCKoe4RcL07jCFo+8uzszTERTNB0IkJeMT+kVid7oxl28kWunF1LNEwAvbSpTXw8IVLlFAFFd1nest/HXdSIMiZXqdngGp/TtAQdTi5iufRK1dOBNJ9BqKmJdjjclwlSQ5nDTPuzJYE1+0BttUk69UR1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Mh7peUDT; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sQaNs-00Ept8-UE; Mon, 08 Jul 2024 00:29:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From;
	bh=9ya+VAvIvTkB/qGZf2DhEiH2W3KKLDsuPGXHcP/Gz8A=; b=Mh7peUDTeab3CkG33Pq7prRrqs
	eHKC/u1l70TK7NPlhHte4cvTKsObeaJbwwQHRaweAVMqLfD7GrB8Pmi7lCMlTrJB3uaRVy8UtSlJj
	mN9DOLf+pb190E317QNcgnEmaFAFFzLN6uXj7gHn0ydJzYzekmtlaSXjD1pXIN0CIa5GAVz8d03cA
	JVXUHfN+PS6EkbGQblHSgSn5R97D4UJY39lj094mSf6+GmHd25RQJ6Hh1KnpaC4DDdN+egGolnwsr
	O0wfojePPvQrIIXkHBdSpRERC8wufIV39Ikzz/mEKYjiTA/+ZhzMoVLI7q38qB3BgLPjnZvxtjaHg
	0eaJFLxw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sQaNs-0003NT-Kl; Mon, 08 Jul 2024 00:29:28 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sQaNa-009IHx-92; Mon, 08 Jul 2024 00:29:10 +0200
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
	cong.wang@bytedance.com,
	Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf v3 1/4] af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash
Date: Sun,  7 Jul 2024 23:28:22 +0200
Message-ID: <20240707222842.4119416-2-mhal@rbox.co>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240707222842.4119416-1-mhal@rbox.co>
References: <20240707222842.4119416-1-mhal@rbox.co>
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
 net/unix/af_unix.c  | 41 ++++++++++++++++++++++++++++++++++++++++-
 net/unix/unix_bpf.c |  3 +++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 142f56770b77..11cb5badafb6 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2667,10 +2667,49 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 
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
2.45.2


