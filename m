Return-Path: <bpf+bounces-9539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E837798C73
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 20:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E141C20C8A
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 18:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B78D14F7C;
	Fri,  8 Sep 2023 18:14:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0389F14F61;
	Fri,  8 Sep 2023 18:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49D0C43140;
	Fri,  8 Sep 2023 18:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694196867;
	bh=Q+Kkr+ZYm11zYNlNwZDS25MAglr6vzBpgws0ioLKZS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPmryIPg5gRGnNrSjKMNpmiV0nf7CADMeJGAyovOvc+/yvIH8VxWPUdoXJ0AfpQDZ
	 T9E7YhoVgCgiSUK0aBPCrmj0rhxhxdU8HQHY9rfklj7C16yybifgz4t+o6n2+5RPLU
	 3B/uWEK9w5VYkqzR/JrSeshmT86e/xooT0czoJN5e3aU5pZO2NODcZfxJ5xIruR70S
	 4rlWlSq3efVZpr9NQb8E863MySw7Ot5Ye/qv0Np8kCm0L/0RXpcT2En8lytNg2t8Ha
	 2d4KbjQBqU07NqKFVU3T9Gi+oiYYyROGhgGKylZBhvF8woIH4ble8ytXDhsv+MRiRx
	 O4g9QmMDFjwjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	dsahern@kernel.org,
	matthieu.baerts@tessares.net,
	martineau@kernel.org,
	kevin.brodsky@arm.com,
	alexander@mihalicyn.com,
	leitao@debian.org,
	lucien.xin@gmail.com,
	dhowells@redhat.com,
	kernelxing@tencent.com,
	andriy.shevchenko@linux.intel.com,
	axboe@kernel.dk,
	asml.silence@gmail.com,
	netdev@vger.kernel.org,
	v9fs@lists.linux.dev,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 19/45] net: annotate data-races around sock->ops
Date: Fri,  8 Sep 2023 14:13:00 -0400
Message-Id: <20230908181327.3459042-19-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181327.3459042-1-sashal@kernel.org>
References: <20230908181327.3459042-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 1ded5e5a5931bb8b31e15b63b655fe232e3416b2 ]

IPV6_ADDRFORM socket option is evil, because it can change sock->ops
while other threads might read it. Same issue for sk->sk_family
being set to AF_INET.

Adding READ_ONCE() over sock->ops reads is needed for sockets
that might be impacted by IPV6_ADDRFORM.

Note that mptcp_is_tcpsk() can also overwrite sock->ops.

Adding annotations for all sk->sk_family reads will require
more patches :/

BUG: KCSAN: data-race in ____sys_sendmsg / do_ipv6_setsockopt

write to 0xffff888109f24ca0 of 8 bytes by task 4470 on cpu 0:
do_ipv6_setsockopt+0x2c5e/0x2ce0 net/ipv6/ipv6_sockglue.c:491
ipv6_setsockopt+0x57/0x130 net/ipv6/ipv6_sockglue.c:1012
udpv6_setsockopt+0x95/0xa0 net/ipv6/udp.c:1690
sock_common_setsockopt+0x61/0x70 net/core/sock.c:3663
__sys_setsockopt+0x1c3/0x230 net/socket.c:2273
__do_sys_setsockopt net/socket.c:2284 [inline]
__se_sys_setsockopt net/socket.c:2281 [inline]
__x64_sys_setsockopt+0x66/0x80 net/socket.c:2281
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff888109f24ca0 of 8 bytes by task 4469 on cpu 1:
sock_sendmsg_nosec net/socket.c:724 [inline]
sock_sendmsg net/socket.c:747 [inline]
____sys_sendmsg+0x349/0x4c0 net/socket.c:2503
___sys_sendmsg net/socket.c:2557 [inline]
__sys_sendmmsg+0x263/0x500 net/socket.c:2643
__do_sys_sendmmsg net/socket.c:2672 [inline]
__se_sys_sendmmsg net/socket.c:2669 [inline]
__x64_sys_sendmmsg+0x57/0x60 net/socket.c:2669
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0xffffffff850e32b8 -> 0xffffffff850da890

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 4469 Comm: syz-executor.1 Not tainted 6.4.0-rc5-syzkaller-00313-g4c605260bc60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20230808135809.2300241-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/net.h      |   2 +-
 net/9p/trans_fd.c        |   4 +-
 net/core/scm.c           |   3 +-
 net/core/skmsg.c         |   8 ++-
 net/core/sock.c          |  24 +++++--
 net/ipv6/ipv6_sockglue.c |   8 +--
 net/mptcp/protocol.c     |   8 +--
 net/socket.c             | 136 +++++++++++++++++++++++----------------
 net/unix/scm.c           |   3 +-
 9 files changed, 118 insertions(+), 78 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 41c608c1b02c2..c9b4a63791a45 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -123,7 +123,7 @@ struct socket {
 
 	struct file		*file;
 	struct sock		*sk;
-	const struct proto_ops	*ops;
+	const struct proto_ops	*ops; /* Might change with IPV6_ADDRFORM or MPTCP. */
 
 	struct socket_wq	wq;
 };
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 00b684616e8d9..c4015f30f9fa7 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -1019,7 +1019,7 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
 		}
 	}
 
-	err = csocket->ops->connect(csocket,
+	err = READ_ONCE(csocket->ops)->connect(csocket,
 				    (struct sockaddr *)&sin_server,
 				    sizeof(struct sockaddr_in), 0);
 	if (err < 0) {
@@ -1060,7 +1060,7 @@ p9_fd_create_unix(struct p9_client *client, const char *addr, char *args)
 
 		return err;
 	}
-	err = csocket->ops->connect(csocket, (struct sockaddr *)&sun_server,
+	err = READ_ONCE(csocket->ops)->connect(csocket, (struct sockaddr *)&sun_server,
 			sizeof(struct sockaddr_un) - 1, 0);
 	if (err < 0) {
 		pr_err("%s (%d): problem connecting socket: %s: %d\n",
diff --git a/net/core/scm.c b/net/core/scm.c
index 3cd7dd377e53f..880027ecf5165 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -130,6 +130,7 @@ EXPORT_SYMBOL(__scm_destroy);
 
 int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
 {
+	const struct proto_ops *ops = READ_ONCE(sock->ops);
 	struct cmsghdr *cmsg;
 	int err;
 
@@ -153,7 +154,7 @@ int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
 		switch (cmsg->cmsg_type)
 		{
 		case SCM_RIGHTS:
-			if (!sock->ops || sock->ops->family != PF_UNIX)
+			if (!ops || ops->family != PF_UNIX)
 				goto error;
 			err=scm_fp_copy(cmsg, &p->fp);
 			if (err<0)
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index ef1a2eb6520bf..a0659fc29bcca 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1204,13 +1204,17 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
 static void sk_psock_verdict_data_ready(struct sock *sk)
 {
 	struct socket *sock = sk->sk_socket;
+	const struct proto_ops *ops;
 	int copied;
 
 	trace_sk_data_ready(sk);
 
-	if (unlikely(!sock || !sock->ops || !sock->ops->read_skb))
+	if (unlikely(!sock))
 		return;
-	copied = sock->ops->read_skb(sk, sk_psock_verdict_recv);
+	ops = READ_ONCE(sock->ops);
+	if (!ops || !ops->read_skb)
+		return;
+	copied = ops->read_skb(sk, sk_psock_verdict_recv);
 	if (copied >= 0) {
 		struct sk_psock *psock;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index a80b6b8633edc..9d4560db7c26e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1283,14 +1283,19 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_RCVLOWAT:
+		{
+		int (*set_rcvlowat)(struct sock *sk, int val) = NULL;
+
 		if (val < 0)
 			val = INT_MAX;
-		if (sock && sock->ops->set_rcvlowat)
-			ret = sock->ops->set_rcvlowat(sk, val);
+		if (sock)
+			set_rcvlowat = READ_ONCE(sock->ops)->set_rcvlowat;
+		if (set_rcvlowat)
+			ret = set_rcvlowat(sk, val);
 		else
 			WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
 		break;
-
+		}
 	case SO_RCVTIMEO_OLD:
 	case SO_RCVTIMEO_NEW:
 		ret = sock_set_timeout(&sk->sk_rcvtimeo, optval,
@@ -1388,11 +1393,16 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_PEEK_OFF:
-		if (sock->ops->set_peek_off)
-			ret = sock->ops->set_peek_off(sk, val);
+		{
+		int (*set_peek_off)(struct sock *sk, int val);
+
+		set_peek_off = READ_ONCE(sock->ops)->set_peek_off;
+		if (set_peek_off)
+			ret = set_peek_off(sk, val);
 		else
 			ret = -EOPNOTSUPP;
 		break;
+		}
 
 	case SO_NOFCS:
 		sock_valbool_flag(sk, SOCK_NOFCS, valbool);
@@ -1825,7 +1835,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 	{
 		struct sockaddr_storage address;
 
-		lv = sock->ops->getname(sock, (struct sockaddr *)&address, 2);
+		lv = READ_ONCE(sock->ops)->getname(sock, (struct sockaddr *)&address, 2);
 		if (lv < 0)
 			return -ENOTCONN;
 		if (lv < len)
@@ -1867,7 +1877,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_PEEK_OFF:
-		if (!sock->ops->set_peek_off)
+		if (!READ_ONCE(sock->ops)->set_peek_off)
 			return -EOPNOTSUPP;
 
 		v.val = READ_ONCE(sk->sk_peek_off);
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index ae818ff462248..ca377159967c8 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -474,8 +474,8 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 				WRITE_ONCE(sk->sk_prot, &tcp_prot);
 				/* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
 				WRITE_ONCE(icsk->icsk_af_ops, &ipv4_specific);
-				sk->sk_socket->ops = &inet_stream_ops;
-				sk->sk_family = PF_INET;
+				WRITE_ONCE(sk->sk_socket->ops, &inet_stream_ops);
+				WRITE_ONCE(sk->sk_family, PF_INET);
 				tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
 			} else {
 				struct proto *prot = &udp_prot;
@@ -488,8 +488,8 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 
 				/* Paired with READ_ONCE(sk->sk_prot) in inet6_dgram_ops */
 				WRITE_ONCE(sk->sk_prot, prot);
-				sk->sk_socket->ops = &inet_dgram_ops;
-				sk->sk_family = PF_INET;
+				WRITE_ONCE(sk->sk_socket->ops, &inet_dgram_ops);
+				WRITE_ONCE(sk->sk_family, PF_INET);
 			}
 
 			/* Disable all options not to allocate memory anymore,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d80658547836f..a7d1130dfe329 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -67,11 +67,11 @@ static bool mptcp_is_tcpsk(struct sock *sk)
 		 * Hand the socket over to tcp so all further socket ops
 		 * bypass mptcp.
 		 */
-		sock->ops = &inet_stream_ops;
+		WRITE_ONCE(sock->ops, &inet_stream_ops);
 		return true;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	} else if (unlikely(sk->sk_prot == &tcpv6_prot)) {
-		sock->ops = &inet6_stream_ops;
+		WRITE_ONCE(sock->ops, &inet6_stream_ops);
 		return true;
 #endif
 	}
@@ -3684,7 +3684,7 @@ static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 		goto unlock;
 	}
 
-	err = ssock->ops->bind(ssock, uaddr, addr_len);
+	err = READ_ONCE(ssock->ops)->bind(ssock, uaddr, addr_len);
 	if (!err)
 		mptcp_copy_inaddrs(sock->sk, ssock->sk);
 
@@ -3718,7 +3718,7 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	inet_sk_state_store(sk, TCP_LISTEN);
 	sock_set_flag(sk, SOCK_RCU_FREE);
 
-	err = ssock->ops->listen(ssock, backlog);
+	err = READ_ONCE(ssock->ops)->listen(ssock, backlog);
 	inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
 	if (!err) {
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
diff --git a/net/socket.c b/net/socket.c
index 2b0e54b2405c8..5d4e37595e9aa 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -136,9 +136,10 @@ static void sock_splice_eof(struct file *file);
 static void sock_show_fdinfo(struct seq_file *m, struct file *f)
 {
 	struct socket *sock = f->private_data;
+	const struct proto_ops *ops = READ_ONCE(sock->ops);
 
-	if (sock->ops->show_fdinfo)
-		sock->ops->show_fdinfo(m, sock);
+	if (ops->show_fdinfo)
+		ops->show_fdinfo(m, sock);
 }
 #else
 #define sock_show_fdinfo NULL
@@ -646,12 +647,14 @@ EXPORT_SYMBOL(sock_alloc);
 
 static void __sock_release(struct socket *sock, struct inode *inode)
 {
-	if (sock->ops) {
-		struct module *owner = sock->ops->owner;
+	const struct proto_ops *ops = READ_ONCE(sock->ops);
+
+	if (ops) {
+		struct module *owner = ops->owner;
 
 		if (inode)
 			inode_lock(inode);
-		sock->ops->release(sock);
+		ops->release(sock);
 		sock->sk = NULL;
 		if (inode)
 			inode_unlock(inode);
@@ -722,7 +725,7 @@ static noinline void call_trace_sock_send_length(struct sock *sk, int ret,
 
 static inline int sock_sendmsg_nosec(struct socket *sock, struct msghdr *msg)
 {
-	int ret = INDIRECT_CALL_INET(sock->ops->sendmsg, inet6_sendmsg,
+	int ret = INDIRECT_CALL_INET(READ_ONCE(sock->ops)->sendmsg, inet6_sendmsg,
 				     inet_sendmsg, sock, msg,
 				     msg_data_left(msg));
 	BUG_ON(ret == -EIOCBQUEUED);
@@ -786,13 +789,14 @@ int kernel_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 			  struct kvec *vec, size_t num, size_t size)
 {
 	struct socket *sock = sk->sk_socket;
+	const struct proto_ops *ops = READ_ONCE(sock->ops);
 
-	if (!sock->ops->sendmsg_locked)
+	if (!ops->sendmsg_locked)
 		return sock_no_sendmsg_locked(sk, msg, size);
 
 	iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, vec, num, size);
 
-	return sock->ops->sendmsg_locked(sk, msg, msg_data_left(msg));
+	return ops->sendmsg_locked(sk, msg, msg_data_left(msg));
 }
 EXPORT_SYMBOL(kernel_sendmsg_locked);
 
@@ -1017,7 +1021,8 @@ static noinline void call_trace_sock_recv_length(struct sock *sk, int ret, int f
 static inline int sock_recvmsg_nosec(struct socket *sock, struct msghdr *msg,
 				     int flags)
 {
-	int ret = INDIRECT_CALL_INET(sock->ops->recvmsg, inet6_recvmsg,
+	int ret = INDIRECT_CALL_INET(READ_ONCE(sock->ops)->recvmsg,
+				     inet6_recvmsg,
 				     inet_recvmsg, sock, msg,
 				     msg_data_left(msg), flags);
 	if (trace_sock_recv_length_enabled())
@@ -1072,19 +1077,23 @@ static ssize_t sock_splice_read(struct file *file, loff_t *ppos,
 				unsigned int flags)
 {
 	struct socket *sock = file->private_data;
+	const struct proto_ops *ops;
 
-	if (unlikely(!sock->ops->splice_read))
+	ops = READ_ONCE(sock->ops);
+	if (unlikely(!ops->splice_read))
 		return copy_splice_read(file, ppos, pipe, len, flags);
 
-	return sock->ops->splice_read(sock, ppos, pipe, len, flags);
+	return ops->splice_read(sock, ppos, pipe, len, flags);
 }
 
 static void sock_splice_eof(struct file *file)
 {
 	struct socket *sock = file->private_data;
+	const struct proto_ops *ops;
 
-	if (sock->ops->splice_eof)
-		sock->ops->splice_eof(sock);
+	ops = READ_ONCE(sock->ops);
+	if (ops->splice_eof)
+		ops->splice_eof(sock);
 }
 
 static ssize_t sock_read_iter(struct kiocb *iocb, struct iov_iter *to)
@@ -1181,13 +1190,14 @@ EXPORT_SYMBOL(vlan_ioctl_set);
 static long sock_do_ioctl(struct net *net, struct socket *sock,
 			  unsigned int cmd, unsigned long arg)
 {
+	const struct proto_ops *ops = READ_ONCE(sock->ops);
 	struct ifreq ifr;
 	bool need_copyout;
 	int err;
 	void __user *argp = (void __user *)arg;
 	void __user *data;
 
-	err = sock->ops->ioctl(sock, cmd, arg);
+	err = ops->ioctl(sock, cmd, arg);
 
 	/*
 	 * If this ioctl is unknown try to hand it down
@@ -1216,6 +1226,7 @@ static long sock_do_ioctl(struct net *net, struct socket *sock,
 
 static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 {
+	const struct proto_ops  *ops;
 	struct socket *sock;
 	struct sock *sk;
 	void __user *argp = (void __user *)arg;
@@ -1223,6 +1234,7 @@ static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	struct net *net;
 
 	sock = file->private_data;
+	ops = READ_ONCE(sock->ops);
 	sk = sock->sk;
 	net = sock_net(sk);
 	if (unlikely(cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15))) {
@@ -1280,23 +1292,23 @@ static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 			break;
 		case SIOCGSTAMP_OLD:
 		case SIOCGSTAMPNS_OLD:
-			if (!sock->ops->gettstamp) {
+			if (!ops->gettstamp) {
 				err = -ENOIOCTLCMD;
 				break;
 			}
-			err = sock->ops->gettstamp(sock, argp,
-						   cmd == SIOCGSTAMP_OLD,
-						   !IS_ENABLED(CONFIG_64BIT));
+			err = ops->gettstamp(sock, argp,
+					     cmd == SIOCGSTAMP_OLD,
+					     !IS_ENABLED(CONFIG_64BIT));
 			break;
 		case SIOCGSTAMP_NEW:
 		case SIOCGSTAMPNS_NEW:
-			if (!sock->ops->gettstamp) {
+			if (!ops->gettstamp) {
 				err = -ENOIOCTLCMD;
 				break;
 			}
-			err = sock->ops->gettstamp(sock, argp,
-						   cmd == SIOCGSTAMP_NEW,
-						   false);
+			err = ops->gettstamp(sock, argp,
+					     cmd == SIOCGSTAMP_NEW,
+					     false);
 			break;
 
 		case SIOCGIFCONF:
@@ -1357,9 +1369,10 @@ EXPORT_SYMBOL(sock_create_lite);
 static __poll_t sock_poll(struct file *file, poll_table *wait)
 {
 	struct socket *sock = file->private_data;
+	const struct proto_ops *ops = READ_ONCE(sock->ops);
 	__poll_t events = poll_requested_events(wait), flag = 0;
 
-	if (!sock->ops->poll)
+	if (!ops->poll)
 		return 0;
 
 	if (sk_can_busy_loop(sock->sk)) {
@@ -1371,14 +1384,14 @@ static __poll_t sock_poll(struct file *file, poll_table *wait)
 		flag = POLL_BUSY_LOOP;
 	}
 
-	return sock->ops->poll(file, sock, wait) | flag;
+	return ops->poll(file, sock, wait) | flag;
 }
 
 static int sock_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct socket *sock = file->private_data;
 
-	return sock->ops->mmap(file, sock, vma);
+	return READ_ONCE(sock->ops)->mmap(file, sock, vma);
 }
 
 static int sock_close(struct inode *inode, struct file *filp)
@@ -1728,7 +1741,7 @@ int __sys_socketpair(int family, int type, int protocol, int __user *usockvec)
 		goto out;
 	}
 
-	err = sock1->ops->socketpair(sock1, sock2);
+	err = READ_ONCE(sock1->ops)->socketpair(sock1, sock2);
 	if (unlikely(err < 0)) {
 		sock_release(sock2);
 		sock_release(sock1);
@@ -1789,7 +1802,7 @@ int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen)
 						   (struct sockaddr *)&address,
 						   addrlen);
 			if (!err)
-				err = sock->ops->bind(sock,
+				err = READ_ONCE(sock->ops)->bind(sock,
 						      (struct sockaddr *)
 						      &address, addrlen);
 		}
@@ -1823,7 +1836,7 @@ int __sys_listen(int fd, int backlog)
 
 		err = security_socket_listen(sock, backlog);
 		if (!err)
-			err = sock->ops->listen(sock, backlog);
+			err = READ_ONCE(sock->ops)->listen(sock, backlog);
 
 		fput_light(sock->file, fput_needed);
 	}
@@ -1843,6 +1856,7 @@ struct file *do_accept(struct file *file, unsigned file_flags,
 	struct file *newfile;
 	int err, len;
 	struct sockaddr_storage address;
+	const struct proto_ops *ops;
 
 	sock = sock_from_file(file);
 	if (!sock)
@@ -1851,15 +1865,16 @@ struct file *do_accept(struct file *file, unsigned file_flags,
 	newsock = sock_alloc();
 	if (!newsock)
 		return ERR_PTR(-ENFILE);
+	ops = READ_ONCE(sock->ops);
 
 	newsock->type = sock->type;
-	newsock->ops = sock->ops;
+	newsock->ops = ops;
 
 	/*
 	 * We don't need try_module_get here, as the listening socket (sock)
 	 * has the protocol module (sock->ops->owner) held.
 	 */
-	__module_get(newsock->ops->owner);
+	__module_get(ops->owner);
 
 	newfile = sock_alloc_file(newsock, flags, sock->sk->sk_prot_creator->name);
 	if (IS_ERR(newfile))
@@ -1869,14 +1884,13 @@ struct file *do_accept(struct file *file, unsigned file_flags,
 	if (err)
 		goto out_fd;
 
-	err = sock->ops->accept(sock, newsock, sock->file->f_flags | file_flags,
+	err = ops->accept(sock, newsock, sock->file->f_flags | file_flags,
 					false);
 	if (err < 0)
 		goto out_fd;
 
 	if (upeer_sockaddr) {
-		len = newsock->ops->getname(newsock,
-					(struct sockaddr *)&address, 2);
+		len = ops->getname(newsock, (struct sockaddr *)&address, 2);
 		if (len < 0) {
 			err = -ECONNABORTED;
 			goto out_fd;
@@ -1989,8 +2003,8 @@ int __sys_connect_file(struct file *file, struct sockaddr_storage *address,
 	if (err)
 		goto out;
 
-	err = sock->ops->connect(sock, (struct sockaddr *)address, addrlen,
-				 sock->file->f_flags | file_flags);
+	err = READ_ONCE(sock->ops)->connect(sock, (struct sockaddr *)address,
+				addrlen, sock->file->f_flags | file_flags);
 out:
 	return err;
 }
@@ -2039,7 +2053,7 @@ int __sys_getsockname(int fd, struct sockaddr __user *usockaddr,
 	if (err)
 		goto out_put;
 
-	err = sock->ops->getname(sock, (struct sockaddr *)&address, 0);
+	err = READ_ONCE(sock->ops)->getname(sock, (struct sockaddr *)&address, 0);
 	if (err < 0)
 		goto out_put;
 	/* "err" is actually length in this case */
@@ -2071,13 +2085,15 @@ int __sys_getpeername(int fd, struct sockaddr __user *usockaddr,
 
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
 	if (sock != NULL) {
+		const struct proto_ops *ops = READ_ONCE(sock->ops);
+
 		err = security_socket_getpeername(sock);
 		if (err) {
 			fput_light(sock->file, fput_needed);
 			return err;
 		}
 
-		err = sock->ops->getname(sock, (struct sockaddr *)&address, 1);
+		err = ops->getname(sock, (struct sockaddr *)&address, 1);
 		if (err >= 0)
 			/* "err" is actually length in this case */
 			err = move_addr_to_user(&address, err, usockaddr,
@@ -2227,6 +2243,7 @@ int __sys_setsockopt(int fd, int level, int optname, char __user *user_optval,
 		int optlen)
 {
 	sockptr_t optval = USER_SOCKPTR(user_optval);
+	const struct proto_ops *ops;
 	char *kernel_optval = NULL;
 	int err, fput_needed;
 	struct socket *sock;
@@ -2255,12 +2272,13 @@ int __sys_setsockopt(int fd, int level, int optname, char __user *user_optval,
 
 	if (kernel_optval)
 		optval = KERNEL_SOCKPTR(kernel_optval);
+	ops = READ_ONCE(sock->ops);
 	if (level == SOL_SOCKET && !sock_use_custom_sol_socket(sock))
 		err = sock_setsockopt(sock, level, optname, optval, optlen);
-	else if (unlikely(!sock->ops->setsockopt))
+	else if (unlikely(!ops->setsockopt))
 		err = -EOPNOTSUPP;
 	else
-		err = sock->ops->setsockopt(sock, level, optname, optval,
+		err = ops->setsockopt(sock, level, optname, optval,
 					    optlen);
 	kfree(kernel_optval);
 out_put:
@@ -2285,6 +2303,7 @@ int __sys_getsockopt(int fd, int level, int optname, char __user *optval,
 		int __user *optlen)
 {
 	int max_optlen __maybe_unused;
+	const struct proto_ops *ops;
 	int err, fput_needed;
 	struct socket *sock;
 
@@ -2299,12 +2318,13 @@ int __sys_getsockopt(int fd, int level, int optname, char __user *optval,
 	if (!in_compat_syscall())
 		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
 
+	ops = READ_ONCE(sock->ops);
 	if (level == SOL_SOCKET)
 		err = sock_getsockopt(sock, level, optname, optval, optlen);
-	else if (unlikely(!sock->ops->getsockopt))
+	else if (unlikely(!ops->getsockopt))
 		err = -EOPNOTSUPP;
 	else
-		err = sock->ops->getsockopt(sock, level, optname, optval,
+		err = ops->getsockopt(sock, level, optname, optval,
 					    optlen);
 
 	if (!in_compat_syscall())
@@ -2332,7 +2352,7 @@ int __sys_shutdown_sock(struct socket *sock, int how)
 
 	err = security_socket_shutdown(sock, how);
 	if (!err)
-		err = sock->ops->shutdown(sock, how);
+		err = READ_ONCE(sock->ops)->shutdown(sock, how);
 
 	return err;
 }
@@ -3324,6 +3344,7 @@ static int compat_sock_ioctl_trans(struct file *file, struct socket *sock,
 	void __user *argp = compat_ptr(arg);
 	struct sock *sk = sock->sk;
 	struct net *net = sock_net(sk);
+	const struct proto_ops *ops;
 
 	if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15))
 		return sock_ioctl(file, cmd, (unsigned long)argp);
@@ -3333,10 +3354,11 @@ static int compat_sock_ioctl_trans(struct file *file, struct socket *sock,
 		return compat_siocwandev(net, argp);
 	case SIOCGSTAMP_OLD:
 	case SIOCGSTAMPNS_OLD:
-		if (!sock->ops->gettstamp)
+		ops = READ_ONCE(sock->ops);
+		if (!ops->gettstamp)
 			return -ENOIOCTLCMD;
-		return sock->ops->gettstamp(sock, argp, cmd == SIOCGSTAMP_OLD,
-					    !COMPAT_USE_64BIT_TIME);
+		return ops->gettstamp(sock, argp, cmd == SIOCGSTAMP_OLD,
+				      !COMPAT_USE_64BIT_TIME);
 
 	case SIOCETHTOOL:
 	case SIOCBONDSLAVEINFOQUERY:
@@ -3417,6 +3439,7 @@ static long compat_sock_ioctl(struct file *file, unsigned int cmd,
 			      unsigned long arg)
 {
 	struct socket *sock = file->private_data;
+	const struct proto_ops *ops = READ_ONCE(sock->ops);
 	int ret = -ENOIOCTLCMD;
 	struct sock *sk;
 	struct net *net;
@@ -3424,8 +3447,8 @@ static long compat_sock_ioctl(struct file *file, unsigned int cmd,
 	sk = sock->sk;
 	net = sock_net(sk);
 
-	if (sock->ops->compat_ioctl)
-		ret = sock->ops->compat_ioctl(sock, cmd, arg);
+	if (ops->compat_ioctl)
+		ret = ops->compat_ioctl(sock, cmd, arg);
 
 	if (ret == -ENOIOCTLCMD &&
 	    (cmd >= SIOCIWFIRST && cmd <= SIOCIWLAST))
@@ -3449,7 +3472,7 @@ static long compat_sock_ioctl(struct file *file, unsigned int cmd,
 
 int kernel_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 {
-	return sock->ops->bind(sock, addr, addrlen);
+	return READ_ONCE(sock->ops)->bind(sock, addr, addrlen);
 }
 EXPORT_SYMBOL(kernel_bind);
 
@@ -3463,7 +3486,7 @@ EXPORT_SYMBOL(kernel_bind);
 
 int kernel_listen(struct socket *sock, int backlog)
 {
-	return sock->ops->listen(sock, backlog);
+	return READ_ONCE(sock->ops)->listen(sock, backlog);
 }
 EXPORT_SYMBOL(kernel_listen);
 
@@ -3481,6 +3504,7 @@ EXPORT_SYMBOL(kernel_listen);
 int kernel_accept(struct socket *sock, struct socket **newsock, int flags)
 {
 	struct sock *sk = sock->sk;
+	const struct proto_ops *ops = READ_ONCE(sock->ops);
 	int err;
 
 	err = sock_create_lite(sk->sk_family, sk->sk_type, sk->sk_protocol,
@@ -3488,15 +3512,15 @@ int kernel_accept(struct socket *sock, struct socket **newsock, int flags)
 	if (err < 0)
 		goto done;
 
-	err = sock->ops->accept(sock, *newsock, flags, true);
+	err = ops->accept(sock, *newsock, flags, true);
 	if (err < 0) {
 		sock_release(*newsock);
 		*newsock = NULL;
 		goto done;
 	}
 
-	(*newsock)->ops = sock->ops;
-	__module_get((*newsock)->ops->owner);
+	(*newsock)->ops = ops;
+	__module_get(ops->owner);
 
 done:
 	return err;
@@ -3519,7 +3543,7 @@ EXPORT_SYMBOL(kernel_accept);
 int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
 		   int flags)
 {
-	return sock->ops->connect(sock, addr, addrlen, flags);
+	return READ_ONCE(sock->ops)->connect(sock, addr, addrlen, flags);
 }
 EXPORT_SYMBOL(kernel_connect);
 
@@ -3534,7 +3558,7 @@ EXPORT_SYMBOL(kernel_connect);
 
 int kernel_getsockname(struct socket *sock, struct sockaddr *addr)
 {
-	return sock->ops->getname(sock, addr, 0);
+	return READ_ONCE(sock->ops)->getname(sock, addr, 0);
 }
 EXPORT_SYMBOL(kernel_getsockname);
 
@@ -3549,7 +3573,7 @@ EXPORT_SYMBOL(kernel_getsockname);
 
 int kernel_getpeername(struct socket *sock, struct sockaddr *addr)
 {
-	return sock->ops->getname(sock, addr, 1);
+	return READ_ONCE(sock->ops)->getname(sock, addr, 1);
 }
 EXPORT_SYMBOL(kernel_getpeername);
 
@@ -3563,7 +3587,7 @@ EXPORT_SYMBOL(kernel_getpeername);
 
 int kernel_sock_shutdown(struct socket *sock, enum sock_shutdown_cmd how)
 {
-	return sock->ops->shutdown(sock, how);
+	return READ_ONCE(sock->ops)->shutdown(sock, how);
 }
 EXPORT_SYMBOL(kernel_sock_shutdown);
 
diff --git a/net/unix/scm.c b/net/unix/scm.c
index f9152881d77f6..e9dde7176c8a3 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -29,10 +29,11 @@ struct sock *unix_get_socket(struct file *filp)
 	/* Socket ? */
 	if (S_ISSOCK(inode->i_mode) && !(filp->f_mode & FMODE_PATH)) {
 		struct socket *sock = SOCKET_I(inode);
+		const struct proto_ops *ops = READ_ONCE(sock->ops);
 		struct sock *s = sock->sk;
 
 		/* PF_UNIX ? */
-		if (s && sock->ops && sock->ops->family == PF_UNIX)
+		if (s && ops && ops->family == PF_UNIX)
 			u_sock = s;
 	} else {
 		/* Could be an io_uring instance */
-- 
2.40.1


