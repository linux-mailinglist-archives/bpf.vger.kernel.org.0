Return-Path: <bpf+bounces-52638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEF1A460AF
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 14:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394311895C30
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 13:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF82E221F16;
	Wed, 26 Feb 2025 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mV9OhvO4"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3858218ABB
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576200; cv=none; b=ZvaWvfpT+sF2XIPzTfD9I66pFad0IhWwucK+CqdlEpU1zmO2P6RNz68hD6cUxVYqV0rK2C0SDiYLPxHi3k1o5uuEQQNHS6f143/r8OC78SwMmBa7MQamaeFT/bm9LpEc8RXNxAso9PMDqbeIm/2IFemQKRxkJ2Q+WZS7PbyqBPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576200; c=relaxed/simple;
	bh=DxPWP8rrv4ONenG/F6SsO3l4pfuop1FPheHU8L80WlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p65063HmsOf9Wy/t8hVE4s4hHJc1wy/avbQ94S0phFtyuMXZ7JRF6WzJjTl6qDZw2X3brQCzhjRRxO+XHOiCOYMB8Zh65yHjvzUpR851HH0z6cJdt87Wy+Xo810pIfCnX1z0xGqYiliG6rUNnd5680/Tjrvg5ldX8GuK4CszAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mV9OhvO4; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740576195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sz9Qjoc4T3rOFnOy9pSBe7N5DwMb8DWcqD7jnhchAio=;
	b=mV9OhvO46Jn4Y10khTwmaVDDqE9IPSMjc8H05+YyNGaUk/mvD8zERXwvGf0AWsEu0M9XJ/
	TrulscdG7HjTAW8vcTffVqW7P8yT2iJioRzw/Gej4EhoHRIcWeMNt9zTxF8Rp2cq/ubtXF
	EvYYoLy4Q192+yi3s0IjylKHJUm5QIE=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: cong.wang@bytedance.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	mhal@rbox.co,
	jiayuan.chen@linux.dev,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mrpre@163.com,
	syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v1 1/3] bpf, sockmap: avoid using sk_socket after free
Date: Wed, 26 Feb 2025 21:22:40 +0800
Message-ID: <20250226132242.52663-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250226132242.52663-1-jiayuan.chen@linux.dev>
References: <20250226132242.52663-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use RCU lock to protect sk_socket, preventing concurrent close and release
by another thread.

Because TCP/UDP are already within a relatively large critical section:
'''
ip_local_deliver_finish
  rcu_read_lock
  ip_protocol_deliver_rcu
      tcp_rcv/udp_rcv
  rcu_read_unlock
'''

Adding rcu_read_{un}lock() at the entrance and exit of sk_data_ready
will not increase performance overhead.

Reported-by: syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/6734c033.050a0220.2a2fcc.0015.GAE@google.com/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/skmsg.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 0ddc4c718833..1b71ae1d1bf5 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1222,27 +1222,35 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
 
 static void sk_psock_verdict_data_ready(struct sock *sk)
 {
-	struct socket *sock = sk->sk_socket;
+	struct socket *sock;
 	const struct proto_ops *ops;
 	int copied;
 
 	trace_sk_data_ready(sk);
 
+	/* We need RCU to prevent the sk_socket from being released.
+	 * Especially for Unix sockets, we are currently in the process
+	 * context and do not have RCU protection.
+	 */
+	rcu_read_lock();
+	sock = sk->sk_socket;
 	if (unlikely(!sock))
-		return;
+		goto unlock;
+
 	ops = READ_ONCE(sock->ops);
 	if (!ops || !ops->read_skb)
-		return;
+		goto unlock;
+
 	copied = ops->read_skb(sk, sk_psock_verdict_recv);
 	if (copied >= 0) {
 		struct sk_psock *psock;
 
-		rcu_read_lock();
 		psock = sk_psock(sk);
 		if (psock)
 			sk_psock_data_ready(sk, psock);
-		rcu_read_unlock();
 	}
+unlock:
+	rcu_read_unlock();
 }
 
 void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
-- 
2.47.1


