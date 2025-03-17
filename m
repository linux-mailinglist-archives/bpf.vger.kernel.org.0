Return-Path: <bpf+bounces-54172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28005A64730
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 10:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8191890B10
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 09:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BD522A4CB;
	Mon, 17 Mar 2025 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kjeZM4wm"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE869221F1E
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203412; cv=none; b=EE4c0ADYM8abQGuOFasRRNKRDrZ5OU9gDeNRHBwPF6hJ3A8NSdCUnQyNyGXNuuHDrfDvWyHUrJbIKY7+rAGBeI7l5B3Oje7Haw2LVZSDWuiE6VsF3U74C1xb+wprFC/glYob+E3lD70fqh61n1cmQqGfA6z82hDkCe1Ar91gZNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203412; c=relaxed/simple;
	bh=ZIX3geUdBSeJYpNGzQADiA9T7cBZmrvzoLXT/2FyWtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYpMw8EDaD0q2FlfdxlS8YoWYn7cz1YHHq3JY6yXwwG1z3FAg70JjX9d5I6B1cKNDmw3cOpI46pXlDpnqY0aJyDvQ3VC2nSL/eyeCTjmjy11GnNVYfgyE9/a2VNS1X408txwrVo1rp1/4jZv0ssOZpntuZZ56DPst8mtA3tHEaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kjeZM4wm; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742203408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdwQIuLJzVvoXmm2B8tL+Siu69JpG95Yy4OLKWooBQA=;
	b=kjeZM4wmaAXTcUfazsjza9u4rHM+R+vbSP+IntEAgmWUMWpxLnLT1Gb9BFg9iGW1tCV4AC
	dMChDBqgXiaCabRuKNzN6muJoubLdZYMtSM1c4ezMPVXBFMYdVpppJqYQ4oq1URlQJUP0S
	fkKQR2eOiJLoPwDXWoSgwwZ0bR3s0Dk=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: xiyou.wangcong@gmail.com,
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
	syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v3 2/3] bpf, sockmap: avoid using sk_socket after free when reading
Date: Mon, 17 Mar 2025 17:22:55 +0800
Message-ID: <20250317092257.68760-3-jiayuan.chen@linux.dev>
In-Reply-To: <20250317092257.68760-1-jiayuan.chen@linux.dev>
References: <20250317092257.68760-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There are potential concurrency issues, as shown below.
'''
CPU0                               CPU1
sk_psock_verdict_data_ready:
  socket *sock = sk->sk_socket
  if (!sock) return
                                   close(fd):
                                     ...
                                     ops->release()
  if (!sock->ops) return
                                     sock->ops = NULL
                                     rcu_call(sock)
                                     free(sock)
  READ_ONCE(sock->ops)
  ^
  use 'sock' after free
'''

RCU is not applicable to Unix sockets read path, because the Unix socket
implementation itself assumes it's always in process context and heavily
uses mutex_lock, so, we can't call read_skb within rcu lock.

Incrementing the psock reference count would not help either, since
sock_map_close() does not wait for data_ready() to complete its execution.

While we don't utilize sk_socket here, implementing read_skb at the sock
layer instead of socket layer might be architecturally preferable ?
However, deferring this optimization as current fix adequately addresses
the immediate issue.

Fixes: c63829182c37 ("af_unix: Implement ->psock_update_sk_prot()")
Reported-by: syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/6734c033.050a0220.2a2fcc.0015.GAE@google.com/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/skmsg.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 6101c1bb279a..5e913b62929e 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1231,17 +1231,24 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
 
 static void sk_psock_verdict_data_ready(struct sock *sk)
 {
-	struct socket *sock = sk->sk_socket;
+	struct socket *sock;
 	const struct proto_ops *ops;
 	int copied;
 
 	trace_sk_data_ready(sk);
 
-	if (unlikely(!sock))
+	rcu_read_lock();
+	sock = sk->sk_socket;
+	if (unlikely(!sock)) {
+		rcu_read_unlock();
 		return;
+	}
 	ops = READ_ONCE(sock->ops);
-	if (!ops || !ops->read_skb)
+	if (!ops || !ops->read_skb) {
+		rcu_read_unlock();
 		return;
+	}
+	rcu_read_unlock();
 	copied = ops->read_skb(sk, sk_psock_verdict_recv);
 	if (copied >= 0) {
 		struct sk_psock *psock;
-- 
2.47.1


