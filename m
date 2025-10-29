Return-Path: <bpf+bounces-72906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F49C1D7C4
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 22:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 249D64E2288
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 21:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70704320380;
	Wed, 29 Oct 2025 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mx/jlpR8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C4131A05E;
	Wed, 29 Oct 2025 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774268; cv=none; b=HyZn6psqe1zX5qFYNIdYLI9JTEr295GrJE/SkduxbBZD5f2prLXXAFjRySC5BXugJZp1WfDAiDJYDml1nyh/k75NWTxNbVmanhjYeMgwfHwtY2Wab/SxDsmRv/MimX29k3v/ZvIxWhtkF7+FJ3TM3dhM0V43v2pgfZcVLyA1QNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774268; c=relaxed/simple;
	bh=NlNDSA05zWRdRcwbKy+PdJuFtlX8ALadsYS0rvlQODM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e8sblloCSwEW2hXJQH+Hd+48VjzxtYIQ/Ges0iEKLcVFF3G05bY2ILt7grhKKoq2n5pDNGw4+k8CsB06VG7R/XCr3q5T7O/WJlC0quwYmyr0RiPcoRwrJSpPlNpXkNGePOw4f5ttAN5GyYWgXC2+UIQvxQkn+a4gj9YnHmCm4Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mx/jlpR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEF4C116D0;
	Wed, 29 Oct 2025 21:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761774268;
	bh=NlNDSA05zWRdRcwbKy+PdJuFtlX8ALadsYS0rvlQODM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mx/jlpR84TRG/p9BA0YM7vC+sAnJzBSd5/gJJD1iVLptFB1xo7tKqGIWso5XySETv
	 mw5wPYvyj83z2jcv+wd+33QuaZntPhdIJ2/P+RWQIDdrsMAkLSRlyJJXJ9qE/fE2yo
	 lzdqilgu6LvewO59uwSpaivmbFxmmBidtPb2yf1rkOeGLuAgG4dASUr2Oq4bE7A3RD
	 ZE/356i7smIf7aIKhVisw6aG5oyuhBbYgI0JTpTfWLqoUZOOZBvIzxNJB9f+cve01t
	 Lm821uCVXA5FX1sVBnrXaEsI9qWEK8DBQnngqJlEcTuMyRA3RtX9IlWXrwUrhDeyd1
	 Cp3sCjmA8cGfA==
From: Kees Cook <kees@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [net-next PATCH v4 4/7] net: Convert proto callbacks from sockaddr to sockaddr_unsized
Date: Wed, 29 Oct 2025 14:44:01 -0700
Message-Id: <20251029214428.2467496-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029214355.work.602-kees@kernel.org>
References: <20251029214355.work.602-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=33000; i=kees@kernel.org; h=from:subject; bh=NlNDSA05zWRdRcwbKy+PdJuFtlX8ALadsYS0rvlQODM=; b=owGbwMvMwCVmps19z/KJym7G02pJDJlMXYuqJbU5+l9bnrZ1eejzNIknrtl79TwLy96Lc33kT 79jVizpKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmMhsQUaGfSV5hvtdnBQWny95 WypS/qR8vtJav0srcrm1rVaKq0hFMDJMl30meD/Xb9qvwG1mzEIvbxREJXOG3nvWb3DiU+cmv6s 8AA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Convert struct proto pre_connect(), connect(), bind(), and bind_add()
callback function prototypes from struct sockaddr to struct sockaddr_unsized.
This does not change per-implementation use of sockaddr for passing around
an arbitrarily sized sockaddr struct. Those will be addressed in future
patches.

Additionally removes the no longer referenced struct sockaddr from
include/net/inet_common.h.

No binary changes expected.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/net/inet_common.h |  5 ++---
 include/net/ip.h          |  4 ++--
 include/net/ipv6.h        |  8 ++++----
 include/net/ipv6_stubs.h  |  2 +-
 include/net/ping.h        |  2 +-
 include/net/sock.h        | 10 +++++-----
 include/net/tcp.h         |  2 +-
 include/net/udp.h         |  2 +-
 fs/dlm/lowcomms.c         |  4 ++--
 net/core/filter.c         |  5 +++--
 net/core/sock.c           |  2 +-
 net/ieee802154/socket.c   | 12 ++++++------
 net/ipv4/af_inet.c        | 14 +++++++-------
 net/ipv4/datagram.c       |  4 ++--
 net/ipv4/ping.c           |  8 ++++----
 net/ipv4/raw.c            |  3 ++-
 net/ipv4/tcp_ipv4.c       |  4 ++--
 net/ipv4/udp.c            |  6 ++++--
 net/ipv6/af_inet6.c       |  6 +++---
 net/ipv6/datagram.c       |  8 ++++----
 net/ipv6/ping.c           |  2 +-
 net/ipv6/raw.c            |  3 ++-
 net/ipv6/tcp_ipv6.c       |  6 +++---
 net/ipv6/udp.c            |  5 +++--
 net/l2tp/l2tp_ip.c        |  6 ++++--
 net/l2tp/l2tp_ip6.c       |  5 +++--
 net/mptcp/pm_kernel.c     |  4 ++--
 net/mptcp/protocol.c      |  7 ++++---
 net/phonet/pep.c          |  3 ++-
 net/phonet/socket.c       |  4 ++--
 net/sctp/socket.c         |  9 +++++----
 31 files changed, 88 insertions(+), 77 deletions(-)

diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index ebafd96912bb..5dd2bf24449e 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -19,7 +19,6 @@ struct msghdr;
 struct net;
 struct page;
 struct sock;
-struct sockaddr;
 struct socket;
 
 int inet_release(struct socket *sock);
@@ -43,7 +42,7 @@ int inet_listen(struct socket *sock, int backlog);
 int __inet_listen_sk(struct sock *sk, int backlog);
 void inet_sock_destruct(struct sock *sk);
 int inet_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len);
-int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len);
+int inet_bind_sk(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len);
 /* Don't allocate port at this moment, defer to connect. */
 #define BIND_FORCE_ADDRESS_NO_PORT	(1 << 0)
 /* Grab and release socket lock. */
@@ -52,7 +51,7 @@ int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 #define BIND_FROM_BPF			(1 << 2)
 /* Skip CAP_NET_BIND_SERVICE check. */
 #define BIND_NO_CAP_NET_BIND_SERVICE	(1 << 3)
-int __inet_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
+int __inet_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
 		u32 flags);
 int inet_getname(struct socket *sock, struct sockaddr *uaddr,
 		 int peer);
diff --git a/include/net/ip.h b/include/net/ip.h
index 380afb691c41..69d5cef46004 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -261,8 +261,8 @@ static inline u8 ip_sendmsg_scope(const struct inet_sock *inet,
 }
 
 /* datagram.c */
-int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
-int ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
+int __ip4_datagram_connect(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len);
+int ip4_datagram_connect(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len);
 
 void ip4_datagram_release_cb(struct sock *sk);
 
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 2188bad9a687..74fbf1ad8065 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1188,10 +1188,10 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 int ipv6_getsockopt(struct sock *sk, int level, int optname,
 		    char __user *optval, int __user *optlen);
 
-int __ip6_datagram_connect(struct sock *sk, struct sockaddr *addr,
+int __ip6_datagram_connect(struct sock *sk, struct sockaddr_unsized *addr,
 			   int addr_len);
-int ip6_datagram_connect(struct sock *sk, struct sockaddr *addr, int addr_len);
-int ip6_datagram_connect_v6_only(struct sock *sk, struct sockaddr *addr,
+int ip6_datagram_connect(struct sock *sk, struct sockaddr_unsized *addr, int addr_len);
+int ip6_datagram_connect_v6_only(struct sock *sk, struct sockaddr_unsized *addr,
 				 int addr_len);
 int ip6_datagram_dst_update(struct sock *sk, bool fix_sk_saddr);
 void ip6_datagram_release_cb(struct sock *sk);
@@ -1209,7 +1209,7 @@ void inet6_cleanup_sock(struct sock *sk);
 void inet6_sock_destruct(struct sock *sk);
 int inet6_release(struct socket *sock);
 int inet6_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len);
-int inet6_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len);
+int inet6_bind_sk(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len);
 int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
 		  int peer);
 int inet6_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
index 8a3465c8c2c5..d3013e721b14 100644
--- a/include/net/ipv6_stubs.h
+++ b/include/net/ipv6_stubs.h
@@ -80,7 +80,7 @@ extern const struct ipv6_stub *ipv6_stub __read_mostly;
 
 /* A stub used by bpf helpers. Similarly ugly as ipv6_stub */
 struct ipv6_bpf_stub {
-	int (*inet6_bind)(struct sock *sk, struct sockaddr *uaddr, int addr_len,
+	int (*inet6_bind)(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
 			  u32 flags);
 	struct sock *(*udp6_lib_lookup)(const struct net *net,
 				     const struct in6_addr *saddr, __be16 sport,
diff --git a/include/net/ping.h b/include/net/ping.h
index 9634b8800814..05bfd594a64c 100644
--- a/include/net/ping.h
+++ b/include/net/ping.h
@@ -58,7 +58,7 @@ void ping_unhash(struct sock *sk);
 
 int  ping_init_sock(struct sock *sk);
 void ping_close(struct sock *sk, long timeout);
-int  ping_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len);
+int  ping_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len);
 void ping_err(struct sk_buff *skb, int offset, u32 info);
 int  ping_getfrag(void *from, char *to, int offset, int fraglen, int odd,
 		  struct sk_buff *);
diff --git a/include/net/sock.h b/include/net/sock.h
index 3e672a92560b..7f707df66b53 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1260,10 +1260,10 @@ struct proto {
 	void			(*close)(struct sock *sk,
 					long timeout);
 	int			(*pre_connect)(struct sock *sk,
-					struct sockaddr *uaddr,
+					struct sockaddr_unsized *uaddr,
 					int addr_len);
 	int			(*connect)(struct sock *sk,
-					struct sockaddr *uaddr,
+					struct sockaddr_unsized *uaddr,
 					int addr_len);
 	int			(*disconnect)(struct sock *sk, int flags);
 
@@ -1292,9 +1292,9 @@ struct proto {
 					   size_t len, int flags, int *addr_len);
 	void			(*splice_eof)(struct socket *sock);
 	int			(*bind)(struct sock *sk,
-					struct sockaddr *addr, int addr_len);
+					struct sockaddr_unsized *addr, int addr_len);
 	int			(*bind_add)(struct sock *sk,
-					struct sockaddr *addr, int addr_len);
+					struct sockaddr_unsized *addr, int addr_len);
 
 	int			(*backlog_rcv) (struct sock *sk,
 						struct sk_buff *skb);
@@ -3085,7 +3085,7 @@ void sock_set_reuseaddr(struct sock *sk);
 void sock_set_reuseport(struct sock *sk);
 void sock_set_sndtimeo(struct sock *sk, s64 secs);
 
-int sock_bind_add(struct sock *sk, struct sockaddr *addr, int addr_len);
+int sock_bind_add(struct sock *sk, struct sockaddr_unsized *addr, int addr_len);
 
 int sock_get_timeout(long timeo, void *optval, bool old_timeval);
 int sock_copy_user_timeval(struct __kernel_sock_timeval *tv,
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5ca230ed526a..d5f07571f0f8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -530,7 +530,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 				  struct request_sock *req_unhash,
 				  bool *own_req);
 int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb);
-int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
+int tcp_v4_connect(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len);
 int tcp_connect(struct sock *sk);
 enum tcp_synack_type {
 	TCP_SYNACK_NORMAL,
diff --git a/include/net/udp.h b/include/net/udp.h
index cffedb3e40f2..a061d1b22ddc 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -424,7 +424,7 @@ void udp4_hwcsum(struct sk_buff *skb, __be32 src, __be32 dst);
 int udp_rcv(struct sk_buff *skb);
 int udp_ioctl(struct sock *sk, int cmd, int *karg);
 int udp_init_sock(struct sock *sk);
-int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
+int udp_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len);
 int __udp_disconnect(struct sock *sk, int flags);
 int udp_disconnect(struct sock *sk, int flags);
 __poll_t udp_poll(struct file *file, struct socket *sock, poll_table *wait);
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index f832dafdaca8..b3958008ba3f 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1126,7 +1126,7 @@ static void writequeue_entry_complete(struct writequeue_entry *e, int completed)
 static int sctp_bind_addrs(struct socket *sock, __be16 port)
 {
 	struct sockaddr_storage localaddr;
-	struct sockaddr *addr = (struct sockaddr *)&localaddr;
+	struct sockaddr_unsized *addr = (struct sockaddr_unsized *)&localaddr;
 	int i, addr_len, result = 0;
 
 	for (i = 0; i < dlm_local_count; i++) {
@@ -1134,7 +1134,7 @@ static int sctp_bind_addrs(struct socket *sock, __be16 port)
 		make_sockaddr(&localaddr, port, &addr_len);
 
 		if (!i)
-			result = kernel_bind(sock, (struct sockaddr_unsized *)addr, addr_len);
+			result = kernel_bind(sock, addr, addr_len);
 		else
 			result = sock_bind_add(sock->sk, addr, addr_len);
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 76628df1fc82..cf136b444e78 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5907,7 +5907,7 @@ BPF_CALL_3(bpf_bind, struct bpf_sock_addr_kern *, ctx, struct sockaddr *, addr,
 			return err;
 		if (((struct sockaddr_in *)addr)->sin_port == htons(0))
 			flags |= BIND_FORCE_ADDRESS_NO_PORT;
-		return __inet_bind(sk, addr, addr_len, flags);
+		return __inet_bind(sk, (struct sockaddr_unsized *)addr, addr_len, flags);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (addr->sa_family == AF_INET6) {
 		if (addr_len < SIN6_LEN_RFC2133)
@@ -5917,7 +5917,8 @@ BPF_CALL_3(bpf_bind, struct bpf_sock_addr_kern *, ctx, struct sockaddr *, addr,
 		/* ipv6_bpf_stub cannot be NULL, since it's called from
 		 * bpf_cgroup_inet6_connect hook and ipv6 is already loaded
 		 */
-		return ipv6_bpf_stub->inet6_bind(sk, addr, addr_len, flags);
+		return ipv6_bpf_stub->inet6_bind(sk, (struct sockaddr_unsized *)addr,
+						 addr_len, flags);
 #endif /* CONFIG_IPV6 */
 	}
 #endif /* CONFIG_INET */
diff --git a/net/core/sock.c b/net/core/sock.c
index e6e38b6b6b33..85aa9a431bc2 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -4353,7 +4353,7 @@ bool sk_busy_loop_end(void *p, unsigned long start_time)
 EXPORT_SYMBOL(sk_busy_loop_end);
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
-int sock_bind_add(struct sock *sk, struct sockaddr *addr, int addr_len)
+int sock_bind_add(struct sock *sk, struct sockaddr_unsized *addr, int addr_len)
 {
 	if (!sk->sk_prot->bind_add)
 		return -EOPNOTSUPP;
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index b93fd85f248a..e542fbe113e7 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -102,7 +102,7 @@ static int ieee802154_sock_bind(struct socket *sock, struct sockaddr_unsized *ua
 	struct sock *sk = sock->sk;
 
 	if (sk->sk_prot->bind)
-		return sk->sk_prot->bind(sk, (struct sockaddr *)uaddr, addr_len);
+		return sk->sk_prot->bind(sk, uaddr, addr_len);
 
 	return sock_no_bind(sock, uaddr, addr_len);
 }
@@ -118,7 +118,7 @@ static int ieee802154_sock_connect(struct socket *sock, struct sockaddr_unsized
 	if (uaddr->sa_family == AF_UNSPEC)
 		return sk->sk_prot->disconnect(sk, flags);
 
-	return sk->sk_prot->connect(sk, (struct sockaddr *)uaddr, addr_len);
+	return sk->sk_prot->connect(sk, uaddr, addr_len);
 }
 
 static int ieee802154_dev_ioctl(struct sock *sk, struct ifreq __user *arg,
@@ -193,7 +193,7 @@ static void raw_close(struct sock *sk, long timeout)
 	sk_common_release(sk);
 }
 
-static int raw_bind(struct sock *sk, struct sockaddr *_uaddr, int len)
+static int raw_bind(struct sock *sk, struct sockaddr_unsized *_uaddr, int len)
 {
 	struct ieee802154_addr addr;
 	struct sockaddr_ieee802154 *uaddr = (struct sockaddr_ieee802154 *)_uaddr;
@@ -227,7 +227,7 @@ static int raw_bind(struct sock *sk, struct sockaddr *_uaddr, int len)
 	return err;
 }
 
-static int raw_connect(struct sock *sk, struct sockaddr *uaddr,
+static int raw_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 		       int addr_len)
 {
 	return -ENOTSUPP;
@@ -485,7 +485,7 @@ static void dgram_close(struct sock *sk, long timeout)
 	sk_common_release(sk);
 }
 
-static int dgram_bind(struct sock *sk, struct sockaddr *uaddr, int len)
+static int dgram_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int len)
 {
 	struct sockaddr_ieee802154 *addr = (struct sockaddr_ieee802154 *)uaddr;
 	struct ieee802154_addr haddr;
@@ -563,7 +563,7 @@ static int dgram_ioctl(struct sock *sk, int cmd, int *karg)
 }
 
 /* FIXME: autobind */
-static int dgram_connect(struct sock *sk, struct sockaddr *uaddr,
+static int dgram_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 			 int len)
 {
 	struct sockaddr_ieee802154 *addr = (struct sockaddr_ieee802154 *)uaddr;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 3421a2d30845..85aee1b18f89 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -441,7 +441,7 @@ int inet_release(struct socket *sock)
 }
 EXPORT_SYMBOL(inet_release);
 
-int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+int inet_bind_sk(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len)
 {
 	u32 flags = BIND_WITH_LOCK;
 	int err;
@@ -466,11 +466,11 @@ int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 
 int inet_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len)
 {
-	return inet_bind_sk(sock->sk, (struct sockaddr *)uaddr, addr_len);
+	return inet_bind_sk(sock->sk, uaddr, addr_len);
 }
 EXPORT_SYMBOL(inet_bind);
 
-int __inet_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
+int __inet_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
 		u32 flags)
 {
 	struct sockaddr_in *addr = (struct sockaddr_in *)uaddr;
@@ -584,14 +584,14 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 		return prot->disconnect(sk, flags);
 
 	if (BPF_CGROUP_PRE_CONNECT_ENABLED(sk)) {
-		err = prot->pre_connect(sk, (struct sockaddr *)uaddr, addr_len);
+		err = prot->pre_connect(sk, uaddr, addr_len);
 		if (err)
 			return err;
 	}
 
 	if (data_race(!inet_sk(sk)->inet_num) && inet_autobind(sk))
 		return -EAGAIN;
-	return prot->connect(sk, (struct sockaddr *)uaddr, addr_len);
+	return prot->connect(sk, uaddr, addr_len);
 }
 EXPORT_SYMBOL(inet_dgram_connect);
 
@@ -671,12 +671,12 @@ int __inet_stream_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 			goto out;
 
 		if (BPF_CGROUP_PRE_CONNECT_ENABLED(sk)) {
-			err = sk->sk_prot->pre_connect(sk, (struct sockaddr *)uaddr, addr_len);
+			err = sk->sk_prot->pre_connect(sk, uaddr, addr_len);
 			if (err)
 				goto out;
 		}
 
-		err = sk->sk_prot->connect(sk, (struct sockaddr *)uaddr, addr_len);
+		err = sk->sk_prot->connect(sk, uaddr, addr_len);
 		if (err < 0)
 			goto out;
 
diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
index c2b2cda1a7e5..1614593b6d72 100644
--- a/net/ipv4/datagram.c
+++ b/net/ipv4/datagram.c
@@ -16,7 +16,7 @@
 #include <net/tcp_states.h>
 #include <net/sock_reuseport.h>
 
-int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+int __ip4_datagram_connect(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	struct sockaddr_in *usin = (struct sockaddr_in *) uaddr;
@@ -84,7 +84,7 @@ int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len
 }
 EXPORT_SYMBOL(__ip4_datagram_connect);
 
-int ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+int ip4_datagram_connect(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len)
 {
 	int res;
 
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 5321c5801c64..ad56588107cc 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -286,7 +286,7 @@ void ping_close(struct sock *sk, long timeout)
 }
 EXPORT_IPV6_MOD_GPL(ping_close);
 
-static int ping_pre_connect(struct sock *sk, struct sockaddr *uaddr,
+static int ping_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 			    int addr_len)
 {
 	/* This check is replicated from __ip4_datagram_connect() and
@@ -301,7 +301,7 @@ static int ping_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 
 /* Checks the bind address and possibly modifies sk->sk_bound_dev_if. */
 static int ping_check_bind_addr(struct sock *sk, struct inet_sock *isk,
-				struct sockaddr *uaddr, int addr_len)
+				struct sockaddr_unsized *uaddr, int addr_len)
 {
 	struct net *net = sock_net(sk);
 	if (sk->sk_family == AF_INET) {
@@ -387,7 +387,7 @@ static int ping_check_bind_addr(struct sock *sk, struct inet_sock *isk,
 	return 0;
 }
 
-static void ping_set_saddr(struct sock *sk, struct sockaddr *saddr)
+static void ping_set_saddr(struct sock *sk, struct sockaddr_unsized *saddr)
 {
 	if (saddr->sa_family == AF_INET) {
 		struct inet_sock *isk = inet_sk(sk);
@@ -407,7 +407,7 @@ static void ping_set_saddr(struct sock *sk, struct sockaddr *saddr)
  * Moreover, we don't allow binding to multi- and broadcast addresses.
  */
 
-int ping_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+int ping_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len)
 {
 	struct inet_sock *isk = inet_sk(sk);
 	unsigned short snum;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index d54ebb7df966..5998c4cc6f47 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -697,7 +697,8 @@ static void raw_destroy(struct sock *sk)
 }
 
 /* This gets rid of all the nasties in af_inet. -DaveM */
-static int raw_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+static int raw_bind(struct sock *sk, struct sockaddr_unsized *uaddr,
+		    int addr_len)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	struct sockaddr_in *addr = (struct sockaddr_in *) uaddr;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index b1fcf3e4e1ce..e16039fabfa5 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -205,7 +205,7 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 }
 EXPORT_IPV6_MOD_GPL(tcp_twsk_unique);
 
-static int tcp_v4_pre_connect(struct sock *sk, struct sockaddr *uaddr,
+static int tcp_v4_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 			      int addr_len)
 {
 	/* This check is replicated from tcp_v4_connect() and intended to
@@ -221,7 +221,7 @@ static int tcp_v4_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 }
 
 /* This will initiate an outgoing connection. */
-int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+int tcp_v4_connect(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len)
 {
 	struct sockaddr_in *usin = (struct sockaddr_in *)uaddr;
 	struct inet_timewait_death_row *tcp_death_row;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 30dfbf73729d..ffe074cb5865 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2159,7 +2159,8 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 	goto try_again;
 }
 
-int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+int udp_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
+		    int addr_len)
 {
 	/* This check is replicated from __ip4_datagram_connect() and
 	 * intended to prevent BPF program called below from accessing bytes
@@ -2172,7 +2173,8 @@ int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 }
 EXPORT_IPV6_MOD(udp_pre_connect);
 
-static int udp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+static int udp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
+		       int addr_len)
 {
 	int res;
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 0eeb85688b50..d3cf31a89ce3 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -277,7 +277,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	goto out;
 }
 
-static int __inet6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
+static int __inet6_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
 			u32 flags)
 {
 	struct sockaddr_in6 *addr = (struct sockaddr_in6 *)uaddr;
@@ -438,7 +438,7 @@ static int __inet6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 	goto out;
 }
 
-int inet6_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+int inet6_bind_sk(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len)
 {
 	u32 flags = BIND_WITH_LOCK;
 	const struct proto *prot;
@@ -467,7 +467,7 @@ int inet6_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 /* bind for INET6 API */
 int inet6_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len)
 {
-	return inet6_bind_sk(sock->sk, (struct sockaddr *)uaddr, addr_len);
+	return inet6_bind_sk(sock->sk, uaddr, addr_len);
 }
 EXPORT_SYMBOL(inet6_bind);
 
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 33ebe93d80e3..83e03176819c 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -138,7 +138,7 @@ void ip6_datagram_release_cb(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(ip6_datagram_release_cb);
 
-int __ip6_datagram_connect(struct sock *sk, struct sockaddr *uaddr,
+int __ip6_datagram_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 			   int addr_len)
 {
 	struct sockaddr_in6	*usin = (struct sockaddr_in6 *) uaddr;
@@ -194,7 +194,7 @@ int __ip6_datagram_connect(struct sock *sk, struct sockaddr *uaddr,
 		sin.sin_port = usin->sin6_port;
 
 		err = __ip4_datagram_connect(sk,
-					     (struct sockaddr *) &sin,
+					     (struct sockaddr_unsized *)&sin,
 					     sizeof(sin));
 
 ipv4_connected:
@@ -271,7 +271,7 @@ int __ip6_datagram_connect(struct sock *sk, struct sockaddr *uaddr,
 }
 EXPORT_SYMBOL_GPL(__ip6_datagram_connect);
 
-int ip6_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+int ip6_datagram_connect(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len)
 {
 	int res;
 
@@ -282,7 +282,7 @@ int ip6_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 }
 EXPORT_SYMBOL_GPL(ip6_datagram_connect);
 
-int ip6_datagram_connect_v6_only(struct sock *sk, struct sockaddr *uaddr,
+int ip6_datagram_connect_v6_only(struct sock *sk, struct sockaddr_unsized *uaddr,
 				 int addr_len)
 {
 	DECLARE_SOCKADDR(struct sockaddr_in6 *, sin6, uaddr);
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index d7a2cdaa2631..e4afc651731a 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -45,7 +45,7 @@ static int dummy_ipv6_chk_addr(struct net *net, const struct in6_addr *addr,
 	return 0;
 }
 
-static int ping_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
+static int ping_v6_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 			       int addr_len)
 {
 	/* This check is replicated from __ip6_datagram_connect() and
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index e369f54844dd..b4cd05dba9b6 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -214,7 +214,8 @@ bool raw6_local_deliver(struct sk_buff *skb, int nexthdr)
 }
 
 /* This cleans up af_inet6 a bit. -DaveM */
-static int rawv6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+static int rawv6_bind(struct sock *sk, struct sockaddr_unsized *uaddr,
+		      int addr_len)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	struct ipv6_pinfo *np = inet6_sk(sk);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 59c4977a811a..74936757aaba 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -119,7 +119,7 @@ static u32 tcp_v6_init_ts_off(const struct net *net, const struct sk_buff *skb)
 				   ipv6_hdr(skb)->saddr.s6_addr32);
 }
 
-static int tcp_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
+static int tcp_v6_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 			      int addr_len)
 {
 	/* This check is replicated from tcp_v6_connect() and intended to
@@ -134,7 +134,7 @@ static int tcp_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 	return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, &addr_len);
 }
 
-static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
+static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 			  int addr_len)
 {
 	struct sockaddr_in6 *usin = (struct sockaddr_in6 *) uaddr;
@@ -239,7 +239,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 		tp->af_specific = &tcp_sock_ipv6_mapped_specific;
 #endif
 
-		err = tcp_v4_connect(sk, (struct sockaddr *)&sin, sizeof(sin));
+		err = tcp_v4_connect(sk, (struct sockaddr_unsized *)&sin, sizeof(sin));
 
 		if (err) {
 			icsk->icsk_ext_hdr_len = exthdrlen;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 813a2ba75824..794c13674e8a 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1282,7 +1282,7 @@ static void udp_v6_flush_pending_frames(struct sock *sk)
 	}
 }
 
-static int udpv6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
+static int udpv6_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 			     int addr_len)
 {
 	if (addr_len < offsetofend(struct sockaddr, sa_family))
@@ -1303,7 +1303,8 @@ static int udpv6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 	return BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, &addr_len);
 }
 
-static int udpv6_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+static int udpv6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
+			 int addr_len)
 {
 	int res;
 
diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index 29795d2839e8..cac1ff59cb83 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -267,7 +267,8 @@ static void l2tp_ip_destroy_sock(struct sock *sk)
 	}
 }
 
-static int l2tp_ip_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+static int l2tp_ip_bind(struct sock *sk, struct sockaddr_unsized *uaddr,
+			int addr_len)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	struct sockaddr_l2tpip *addr = (struct sockaddr_l2tpip *)uaddr;
@@ -328,7 +329,8 @@ static int l2tp_ip_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	return ret;
 }
 
-static int l2tp_ip_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+static int l2tp_ip_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
+			   int addr_len)
 {
 	struct sockaddr_l2tpip *lsa = (struct sockaddr_l2tpip *)uaddr;
 	struct l2tp_ip_net *pn = l2tp_ip_pernet(sock_net(sk));
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index ea232f338dcb..05a396ba6a3e 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -280,7 +280,8 @@ static void l2tp_ip6_destroy_sock(struct sock *sk)
 	}
 }
 
-static int l2tp_ip6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+static int l2tp_ip6_bind(struct sock *sk, struct sockaddr_unsized *uaddr,
+			 int addr_len)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	struct ipv6_pinfo *np = inet6_sk(sk);
@@ -383,7 +384,7 @@ static int l2tp_ip6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	return err;
 }
 
-static int l2tp_ip6_connect(struct sock *sk, struct sockaddr *uaddr,
+static int l2tp_ip6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 			    int addr_len)
 {
 	struct sockaddr_l2tpip6 *lsa = (struct sockaddr_l2tpip6 *)uaddr;
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index e0f44dc232aa..b3e0f55a7253 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -849,10 +849,10 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 		addrlen = sizeof(struct sockaddr_in6);
 #endif
 	if (ssk->sk_family == AF_INET)
-		err = inet_bind_sk(ssk, (struct sockaddr *)&addr, addrlen);
+		err = inet_bind_sk(ssk, (struct sockaddr_unsized *)&addr, addrlen);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	else if (ssk->sk_family == AF_INET6)
-		err = inet6_bind_sk(ssk, (struct sockaddr *)&addr, addrlen);
+		err = inet6_bind_sk(ssk, (struct sockaddr_unsized *)&addr, addrlen);
 #endif
 	if (err)
 		return err;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index beb017e507a0..317223a168f7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3722,7 +3722,8 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
 	return 0;
 }
 
-static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
+			 int addr_len)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -3846,10 +3847,10 @@ static int mptcp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int a
 	}
 
 	if (sk->sk_family == AF_INET)
-		err = inet_bind_sk(ssk, (struct sockaddr *)uaddr, addr_len);
+		err = inet_bind_sk(ssk, uaddr, addr_len);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	else if (sk->sk_family == AF_INET6)
-		err = inet6_bind_sk(ssk, (struct sockaddr *)uaddr, addr_len);
+		err = inet6_bind_sk(ssk, uaddr, addr_len);
 #endif
 	if (!err)
 		mptcp_copy_inaddrs(sk, ssk);
diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index 4db564d9d522..120e711ea78c 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -882,7 +882,8 @@ static struct sock *pep_sock_accept(struct sock *sk,
 	return newsk;
 }
 
-static int pep_sock_connect(struct sock *sk, struct sockaddr *addr, int len)
+static int pep_sock_connect(struct sock *sk, struct sockaddr_unsized *addr,
+			    int len)
 {
 	struct pep_sock *pn = pep_sk(sk);
 	int err;
diff --git a/net/phonet/socket.c b/net/phonet/socket.c
index 9391378083a4..4423d483c630 100644
--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -163,7 +163,7 @@ static int pn_socket_bind(struct socket *sock, struct sockaddr_unsized *addr, in
 	u8 saddr;
 
 	if (sk->sk_prot->bind)
-		return sk->sk_prot->bind(sk, (struct sockaddr *)addr, len);
+		return sk->sk_prot->bind(sk, addr, len);
 
 	if (len < sizeof(struct sockaddr_pn))
 		return -EINVAL;
@@ -252,7 +252,7 @@ static int pn_socket_connect(struct socket *sock, struct sockaddr_unsized *addr,
 	pn->resource = pn_sockaddr_get_resource(spn);
 	sock->state = SS_CONNECTING;
 
-	err = sk->sk_prot->connect(sk, (struct sockaddr *)addr, len);
+	err = sk->sk_prot->connect(sk, addr, len);
 	if (err) {
 		sock->state = SS_UNCONNECTED;
 		pn->dobject = 0;
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index a3d7607c1c7a..fb1f9b1d3199 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -306,7 +306,8 @@ static struct sctp_transport *sctp_addr_id2transport(struct sock *sk,
  *             sockaddr_in6 [RFC 2553]),
  *   addr_len - the size of the address structure.
  */
-static int sctp_bind(struct sock *sk, struct sockaddr *addr, int addr_len)
+static int sctp_bind(struct sock *sk, struct sockaddr_unsized *addr,
+		     int addr_len)
 {
 	int retval = 0;
 
@@ -1053,13 +1054,13 @@ static int sctp_setsockopt_bindx(struct sock *sk, struct sockaddr *addrs,
 	}
 }
 
-static int sctp_bind_add(struct sock *sk, struct sockaddr *addrs,
-		int addrlen)
+static int sctp_bind_add(struct sock *sk, struct sockaddr_unsized *addrs,
+			 int addrlen)
 {
 	int err;
 
 	lock_sock(sk);
-	err = sctp_setsockopt_bindx(sk, addrs, addrlen, SCTP_BINDX_ADD_ADDR);
+	err = sctp_setsockopt_bindx(sk, (struct sockaddr *)addrs, addrlen, SCTP_BINDX_ADD_ADDR);
 	release_sock(sk);
 	return err;
 }
-- 
2.34.1


