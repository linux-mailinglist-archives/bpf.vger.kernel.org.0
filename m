Return-Path: <bpf+bounces-57387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA73AA9E80
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 23:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB4B17BB1F
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 21:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0A0274FE0;
	Mon,  5 May 2025 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Rzj3csR+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B41F3FDC;
	Mon,  5 May 2025 21:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746482358; cv=none; b=hV8HlGWZw6vKAjL7t2Gujkq22Uuez/6C1PZUNNHDZ2Nm/rLe7suTGmTkEiQwGvdaTKEqZix01lUtpPhDzqe/x6TPfzaxZ2tFkVRjmCKgsw5FLganmPppHkRQijkLL7HTgXQ6fOs5XGInNaQKwczB7K+5KjEl7eFmU/CQ/xlqQ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746482358; c=relaxed/simple;
	bh=C9KLVq9cVjRJ4wYT4c/blaxdTuuP10Z/pPI7HGen4BA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2hNLN4OohDXpLHA9jfv91QlsxD/DK4O9mfF89Tarh0LjfCafKaMUpATpUcqYD0fzREt+LxKOSvQLHsXTGWG3O3gd4X66BSq2hO3Z87WkcMH+Dw6HhbFvZRQg6oYDrBvXigMBRWjO3MUj5tMnv3rmJeRnFC2gYYPTdcLQ1YuWzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Rzj3csR+; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746482358; x=1778018358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OOf8CsFSvcDfLD2W22m5/ufzA23qNJ8NtKdvdVy8JNs=;
  b=Rzj3csR+HcVJpB9+qz8S8F0BnYx+IDP5xDQQOqjFZ2792asWl/8ZqNEB
   3dBnTxYEkZRMvOECr3LVCyLnCMtUvEBGOIcX8Y7cM+kDUgMCeETu5n1jo
   4Iv/hgh1XfCKH/DdtzaZDWJyRy7q4z7w6dxAbw8W6btgXycBPaDtKcIAs
   g=;
X-IronPort-AV: E=Sophos;i="6.15,264,1739836800"; 
   d="scan'208";a="822043681"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 21:59:11 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:40062]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.6:2525] with esmtp (Farcaster)
 id eb3131df-808c-47d1-8552-93ba7ad15fa2; Mon, 5 May 2025 21:59:10 +0000 (UTC)
X-Farcaster-Flow-ID: eb3131df-808c-47d1-8552-93ba7ad15fa2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 21:59:09 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 21:59:04 +0000
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
Subject: [PATCH v1 bpf-next 2/5] af_unix: Pass skb to security_unix_may_send().
Date: Mon, 5 May 2025 14:56:47 -0700
Message-ID: <20250505215802.48449-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

As long as recvmsg() or recvmmsg() is used with cmsg, it is not
possible to avoid receiving file descriptors via SCM_RIGHTS.

This behaviour has occasionally been flagged as problematic.

For instance, as noted on the uAPI Group page [0], an untrusted peer
could send a file descriptor pointing to a hung NFS mount and then
close it.  Once the receiver calls recvmsg() with msg_control, the
descriptor is automatically installed, and then the responsibility
for the final close() now falls on the receiver, which may result
in blocking the process for a long time.

Let's pass the skb to security_unix_may_send() so that BPF LSM can
inspect it and selectively prevent such a sendmsg().

Note that only the LSM_HOOK() macro uses the __nullable suffix for
skb to inform the verifier that the skb could be NULL at connect().
Without it, I was able to load a bpf prog without NULL check
against skb.

Sample:

SEC("lsm/unix_may_send")
int BPF_PROG(unix_refuse_scm_rights,
	     struct socket *sock, struct socket *other, struct sk_buff *skb)
{
	struct unix_skb_parms *cb;

	if (!skb)
		return 0;

	cb = (struct unix_skb_parms *)skb->cb;
	if (!cb->fp)
		return 0;

	return -EPERM;
}

Link: https://uapi-group.org/kernel-features/#disabling-reception-of-scm_rights-for-af_unix-sockets #[0]
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
I guess there is no generic version of raw_tp_null_args[] ?
---
 include/linux/lsm_hook_defs.h | 3 ++-
 include/linux/security.h      | 5 +++--
 net/unix/af_unix.c            | 8 ++++----
 security/landlock/task.c      | 3 ++-
 security/security.c           | 5 +++--
 security/selinux/hooks.c      | 3 ++-
 security/smack/smack_lsm.c    | 3 ++-
 7 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index bf3bbac4e02a..762c7f2f7dee 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -318,7 +318,8 @@ LSM_HOOK(int, 0, watch_key, struct key *key)
 #ifdef CONFIG_SECURITY_NETWORK
 LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
 	 struct sock *newsk)
-LSM_HOOK(int, 0, unix_may_send, struct socket *sock, struct socket *other)
+LSM_HOOK(int, 0, unix_may_send, struct socket *sock, struct socket *other,
+	 struct sk_buff *skb__nullable)
 LSM_HOOK(int, 0, socket_create, int family, int type, int protocol, int kern)
 LSM_HOOK(int, 0, socket_post_create, struct socket *sock, int family, int type,
 	 int protocol, int kern)
diff --git a/include/linux/security.h b/include/linux/security.h
index cc9b54d95d22..5de77accee80 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1630,7 +1630,7 @@ static inline int security_watch_key(struct key *key)
 #ifdef CONFIG_SECURITY_NETWORK
 
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk);
-int security_unix_may_send(struct socket *sock,  struct socket *other);
+int security_unix_may_send(struct socket *sock,  struct socket *other, struct sk_buff *skb);
 int security_socket_create(int family, int type, int protocol, int kern);
 int security_socket_post_create(struct socket *sock, int family,
 				int type, int protocol, int kern);
@@ -1692,7 +1692,8 @@ static inline int security_unix_stream_connect(struct sock *sock,
 }
 
 static inline int security_unix_may_send(struct socket *sock,
-					 struct socket *other)
+					 struct socket *other,
+					 struct sk_buff *skb)
 {
 	return 0;
 }
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 769db3f8f41b..692cce579c89 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1447,7 +1447,7 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 		if (!unix_may_send(sk, other))
 			goto out_unlock;
 
-		err = security_unix_may_send(sk->sk_socket, other->sk_socket);
+		err = security_unix_may_send(sk->sk_socket, other->sk_socket, NULL);
 		if (err)
 			goto out_unlock;
 
@@ -2101,7 +2101,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out_unlock;
 	}
 
-	err = security_unix_may_send(sk->sk_socket, other->sk_socket);
+	err = security_unix_may_send(sk->sk_socket, other->sk_socket, skb);
 	if (err)
 		goto out_unlock;
 
@@ -2204,7 +2204,7 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 	}
 
 	if (!fds_sent) {
-		err = security_unix_may_send(sock, other->sk_socket);
+		err = security_unix_may_send(sock, other->sk_socket, skb);
 		if (err)
 			goto out_unlock;
 	}
@@ -2326,7 +2326,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto out_pipe_unlock;
 
 		if (!fds_sent) {
-			err = security_unix_may_send(sock, other->sk_socket);
+			err = security_unix_may_send(sock, other->sk_socket, skb);
 			if (err) {
 				unix_state_unlock(other);
 				goto out_free;
diff --git a/security/landlock/task.c b/security/landlock/task.c
index f15e6b0c56f8..aeb712d3fa8f 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -295,7 +295,8 @@ static int hook_unix_stream_connect(struct sock *const sock,
 }
 
 static int hook_unix_may_send(struct socket *const sock,
-			      struct socket *const other)
+			      struct socket *const other,
+			      struct sk_buff *skb)
 {
 	size_t handle_layer;
 	const struct landlock_cred_security *const subject =
diff --git a/security/security.c b/security/security.c
index fb57e8fddd91..875dbc7ba34f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4531,9 +4531,10 @@ EXPORT_SYMBOL(security_unix_stream_connect);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_unix_may_send(struct socket *sock,  struct socket *other)
+int security_unix_may_send(struct socket *sock,  struct socket *other,
+			   struct sk_buff *skb)
 {
-	return call_int_hook(unix_may_send, sock, other);
+	return call_int_hook(unix_may_send, sock, other, skb);
 }
 EXPORT_SYMBOL(security_unix_may_send);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9fb4cd442ffd..fcf14fb76e7f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5099,7 +5099,8 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 }
 
 static int selinux_socket_unix_may_send(struct socket *sock,
-					struct socket *other)
+					struct socket *other,
+					struct sk_buff *skb)
 {
 	struct sk_security_struct *ssec = selinux_sock(sock->sk);
 	struct sk_security_struct *osec = selinux_sock(other->sk);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 00aa1e7513c1..33827f4c5c76 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3890,7 +3890,8 @@ static int smack_unix_stream_connect(struct sock *sock,
  * Return 0 if a subject with the smack of sock could access
  * an object with the smack of other, otherwise an error code
  */
-static int smack_unix_may_send(struct socket *sock, struct socket *other)
+static int smack_unix_may_send(struct socket *sock, struct socket *other,
+			       struct sk_buff *skb)
 {
 	struct socket_smack *ssp = smack_sock(sock->sk);
 	struct socket_smack *osp = smack_sock(other->sk);
-- 
2.49.0


