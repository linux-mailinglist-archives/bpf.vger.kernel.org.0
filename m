Return-Path: <bpf+bounces-34738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD6C930738
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 22:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C66B2332E
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B400144315;
	Sat, 13 Jul 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="f/ja2CLs"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0352D600;
	Sat, 13 Jul 2024 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720900976; cv=none; b=txoULYMLHg5GKircZXFOJQMHkqRr78oF4i6jQ0p1p0kCSrOg+btSua7z45ThuW87JiCpr59q9k7tqcEZNOHeOzA+tMrO3NfbjceAiSqH9LVq5pLU9nN4o50WO9blmSFtlCPgy/h1fpJgA4HSt9ojY/CLPY+pH6QLBagTx0Oy6Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720900976; c=relaxed/simple;
	bh=+P/vqdtIVMUmrCjxItY5rzn3MvZTP6yM+1xHudPHF8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l22Cor0DNR7P+JDglt9/k+MMvK11kBrwMPuyESKi9aJKUucKTE7I743t3TQPt41YrNOeHSXFzGMS+JuK1P64XvVUlZP2XR81VlC5wrQ2OtVdLibtpmNIelCPbRkYJ1RMSHjCK3amaDtENDPcWWmBXbBQyDodVgHkMcTQYLylRI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=f/ja2CLs; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sSix7-00DSpH-NI; Sat, 13 Jul 2024 22:02:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From;
	bh=lUwXv8N7UXRlLsl9YGKfb4QYhHnVhwP01XC59RQ8/40=; b=f/ja2CLsSHFyJQbC5JLToGNW5o
	bkBwrwYg7oRPP4C2GVY9Lk+iOC5X6Thky5qYXqNfX+TMhyYNb7PuHElbeZeXeHsxWamafqLR9Q1U9
	KAKn1L18OPGwHoN3H+R7Wmffu/kvbo0bnAcqWB/1GgwXK8kMC4+UayEY+jsUin5D0s4GFkFM3gc95
	ghclr2g5guGtdWxiX5CWFEMXIMhCK6v4cbYZM+CeW/8L5NcuAFoz0DuHq7tPybb0S8iREO06Ubl0l
	umSdr0Q3sIZ1U4pqzefM+5XeiK6CtepXbeY4OTOKA2E8TX/cbOjY48LHoXhHIDcJaEUN4HKymCGUz
	9+od4yRg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sSix6-0006if-EP; Sat, 13 Jul 2024 22:02:40 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sSix3-000dGr-KM; Sat, 13 Jul 2024 22:02:37 +0200
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
Subject: [PATCH bpf v4 1/4] af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash
Date: Sat, 13 Jul 2024 21:41:38 +0200
Message-ID: <20240713200218.2140950-2-mhal@rbox.co>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713200218.2140950-1-mhal@rbox.co>
References: <20240713200218.2140950-1-mhal@rbox.co>
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
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
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


