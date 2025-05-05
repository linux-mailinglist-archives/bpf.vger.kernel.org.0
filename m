Return-Path: <bpf+bounces-57386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0E7AA9E7C
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 23:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAE11A803FF
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 21:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7626274FF5;
	Mon,  5 May 2025 21:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YUglTeyG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5323D1F3FDC;
	Mon,  5 May 2025 21:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746482330; cv=none; b=NWkXYIQUvnjZxvG/TcNo4fy4+Nls0lsndecuBvKHk+CwFfVUMhJFEeUj5lvqm26M6ytOF9QH6eWL6+j11W0i19p8ZWCt+f6XxK1Vn1ByzpjVHHf4zZT3ZCgdzcKljo0cxrIXCy8CPqjjI851x/z1oKMvz3GDCADHUkrbpsZwv/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746482330; c=relaxed/simple;
	bh=i3whlHYDID9LxxVt1nZAs0gFveuL4P85f04XnemesQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/ECgfQEH1lrL2suvDYZmKZpzndPMTxIJiA6c8EqEwkumSy3VEJcPsD3ZVkoALHuXFBpIvootKVzsjAo+WlwH8q+ekWrQsausdNdbSevi4ED1hMzHQsMv1ONR9RwzVC25rii+Wz3N9M5iJvwFA3V1u8bDDPQdN2A8dOVGmTzKpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YUglTeyG; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746482329; x=1778018329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U8pXsI48l7lZhj6eGBAtsF/dBe1rJdtjO2TvQ/GzuW0=;
  b=YUglTeyGtl4UPvRdQPyCbsqEgTLgH1KilLURF+xbXLQRqZRunCOzkGWJ
   /sS2TO/kxqLJZypt47P4gPVoDGCDRQ4iQ2AW20KkDIsNWvTR4F0BHnlJJ
   u76pACaF+HC1YDE1zqUtY/UHvZi78XJ3P9LBfRH/+klhnvllU3ZBD3gHs
   w=;
X-IronPort-AV: E=Sophos;i="6.15,264,1739836800"; 
   d="scan'208";a="495749924"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 21:58:44 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:50809]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.21:2525] with esmtp (Farcaster)
 id 9fcfe636-1e4f-4860-9158-450504399ac4; Mon, 5 May 2025 21:58:43 +0000 (UTC)
X-Farcaster-Flow-ID: 9fcfe636-1e4f-4860-9158-450504399ac4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 21:58:43 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 21:58:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
CC: Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
	"Stanislav Fomichev" <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=
	<mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>,
	"Ondrej Mosnacek" <omosnace@redhat.com>, Casey Schaufler
	<casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>
Subject: [PATCH v1 bpf-next 1/5] af_unix: Call security_unix_may_send() in sendmsg() for all socket types
Date: Mon, 5 May 2025 14:56:46 -0700
Message-ID: <20250505215802.48449-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505215802.48449-1-kuniyu@amazon.com>
References: <20250505215802.48449-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Currently, security_unix_may_send() is invoked only for SOCK_DGRAM
sockets during connect() and sendmsg().

For SOCK_STREAM and SOCK_SEQPACKET sockets, an equivalent check
already occurs during connect(), making an additional hook in
sendmsg() unnecessary.

However, we want to leverage BPF LSM to inspect the skb during
sendmsg(), either to scrub file descriptors passed via SCM_RIGHTS
or to reject such an skb.

As a preparation, let's call security_unix_may_send() for SOCK_STREAM
and SOCK_SEQPACKET in sendmsg().

Note that SELinux, SMACK, and Landlock use security_unix_may_send().
To avoid unintentionally triggering the hook for SOCK_STREAM and
SOCK_SEQPACKET, an additional socket type check is added in each LSM.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c         | 31 ++++++++++++++++++++++---------
 security/landlock/task.c   |  3 +++
 security/selinux/hooks.c   |  3 +++
 security/smack/smack_lsm.c |  3 +++
 4 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f78a2492826f..769db3f8f41b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2101,11 +2101,9 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out_unlock;
 	}
 
-	if (sk->sk_type != SOCK_SEQPACKET) {
-		err = security_unix_may_send(sk->sk_socket, other->sk_socket);
-		if (err)
-			goto out_unlock;
-	}
+	err = security_unix_may_send(sk->sk_socket, other->sk_socket);
+	if (err)
+		goto out_unlock;
 
 	/* other == sk && unix_peer(other) != sk if
 	 * - unix_peer(sk) == NULL, destination address bound to sk
@@ -2201,9 +2199,14 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 
 	if (sock_flag(other, SOCK_DEAD) ||
 	    (other->sk_shutdown & RCV_SHUTDOWN)) {
-		unix_state_unlock(other);
 		err = -EPIPE;
-		goto out;
+		goto out_unlock;
+	}
+
+	if (!fds_sent) {
+		err = security_unix_may_send(sock, other->sk_socket);
+		if (err)
+			goto out_unlock;
 	}
 
 	maybe_add_creds(skb, sock, other);
@@ -2219,6 +2222,8 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 	other->sk_data_ready(other);
 
 	return 0;
+out_unlock:
+	unix_state_unlock(other);
 out:
 	consume_skb(skb);
 	return err;
@@ -2296,8 +2301,6 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		if (err < 0)
 			goto out_free;
 
-		fds_sent = true;
-
 		if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES)) {
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 			err = skb_splice_from_iter(skb, &msg->msg_iter, size,
@@ -2322,6 +2325,16 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		    (other->sk_shutdown & RCV_SHUTDOWN))
 			goto out_pipe_unlock;
 
+		if (!fds_sent) {
+			err = security_unix_may_send(sock, other->sk_socket);
+			if (err) {
+				unix_state_unlock(other);
+				goto out_free;
+			}
+		}
+
+		fds_sent = true;
+
 		maybe_add_creds(skb, sock, other);
 		scm_stat_add(other, skb);
 		skb_queue_tail(&other->sk_receive_queue, skb);
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 2385017418ca..f15e6b0c56f8 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -305,6 +305,9 @@ static int hook_unix_may_send(struct socket *const sock,
 	if (!subject)
 		return 0;
 
+	if (sock->sk->sk_type != SOCK_DGRAM)
+		return 0;
+
 	/*
 	 * Checks if this datagram socket was already allowed to be connected
 	 * to other.
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e7a7dcab81db..9fb4cd442ffd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5106,6 +5106,9 @@ static int selinux_socket_unix_may_send(struct socket *sock,
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 
+	if (sock->sk->sk_type != SOCK_DGRAM)
+		return 0;
+
 	ad_net_init_from_sk(&ad, &net, other->sk);
 
 	return avc_has_perm(ssec->sid, osec->sid, osec->sclass, SOCKET__SENDTO,
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 99833168604e..00aa1e7513c1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3904,6 +3904,9 @@ static int smack_unix_may_send(struct socket *sock, struct socket *other)
 	smk_ad_setfield_u_net_sk(&ad, other->sk);
 #endif
 
+	if (sock->sk->sk_type != SOCK_DGRAM)
+		return 0;
+
 	if (smack_privileged(CAP_MAC_OVERRIDE))
 		return 0;
 
-- 
2.49.0


