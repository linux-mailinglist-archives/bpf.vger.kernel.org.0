Return-Path: <bpf+bounces-71453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847ACBF3BC9
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 23:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11987403E53
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 21:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA1A335BB4;
	Mon, 20 Oct 2025 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcGnAo1M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2447F334376;
	Mon, 20 Oct 2025 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995600; cv=none; b=RLVeJhraf+HtAmTcmGgNgM2tlUFhKLnohnJogMdXoWjm/9DX8owZY+4S8Ndfe1tlAyil0LBXsyl0bAkAjIDYLwaYZWQGHbpwI471k0CQQf0azZPtJaXPvGPIz+JZiad6UmPNqCuDZp3xPlThwCTvXR0vjKZwZap2428zUfn9lNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995600; c=relaxed/simple;
	bh=DRd802f5exnLaclDVcYebexReKq2Tf4Z2+WujxdpHRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vAAXpetTi/FfQeOf9KFmLANBrye1xY9bi3txTYdvyELUosOfpCc6DKHE4aP7FJQbEoZMV1UfjFwO7KQr0LohYzoOLi9TTxOe7StBu9p6wrYpNdN93KN5uSB3TtnWbw+mg7SFbkuAkNEcoTcjo2S2aaVyVX2/jRrbpncfw7/7KKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcGnAo1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F5DC116D0;
	Mon, 20 Oct 2025 21:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760995599;
	bh=DRd802f5exnLaclDVcYebexReKq2Tf4Z2+WujxdpHRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IcGnAo1Mz0zC5oVWNKby1vukxRqj2rdF0P4el4augMkYq15Svy5c+IpjUL+e14xJS
	 V5Bg3rm8cxBqsks359TeYYA3z/Z4naIzHwLhQ4dguEaj2mCXRKLJA+pQSKsBqaCjwH
	 H7RztJmhM3Nvp8XUHdjaXG1lQhj0M6noQJ5eAAOtZfMiXMubBFQxc99hiyW8LQPo1h
	 /+Jyu/LUhCeyHCFKNQLkMjl+I8uZG+rzUoWspwL9AHSLDLS0uaaL3OOYE33yYzUAtL
	 ZbP91Hpa9kEfQVv+XhqzVNcMLEfHp40z0MJepDXwRqrGoSuIMxd50oXYirULzNXq++
	 xT6ftVoLqB/AQ==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 3/9] net: Convert proto_ops bind() callbacks to use sockaddr_unspec
Date: Mon, 20 Oct 2025 14:26:32 -0700
Message-Id: <20251020212639.1223484-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020212125.make.115-kees@kernel.org>
References: <20251020212125.make.115-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=54817; i=kees@kernel.org; h=from:subject; bh=DRd802f5exnLaclDVcYebexReKq2Tf4Z2+WujxdpHRQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnfVnLn/X7urmF6L7Bx6fkA78D9E3zfOih63sxQ/Nix6 +oeQbWEjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgInsYWH4X9kWuvBDY++Gb1Wp n0UF1ny7IeO+0pWvPG9JWK07bwHHXUaGddODtwcrs/9n2Lj5TtQj9n3MezVfXbmgpdhQl7pl4+m F3AA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Update all struct proto_ops bind() callback function prototypes from
"struct sockaddr *" to "struct sockaddr_unspec *" to avoid lying to the
compiler about object sizes. Calls into struct proto handlers gain casts
that will be removed in the struct proto conversion patch.

No binary changes expected.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/net.h                                  |  4 ++--
 include/net/inet_common.h                            |  2 +-
 include/net/ipv6.h                                   |  2 +-
 include/net/sock.h                                   |  2 +-
 net/rds/rds.h                                        |  2 +-
 net/smc/smc.h                                        |  2 +-
 crypto/af_alg.c                                      |  2 +-
 drivers/block/drbd/drbd_receiver.c                   |  4 ++--
 drivers/infiniband/hw/erdma/erdma_cm.c               |  4 ++--
 drivers/infiniband/sw/siw/siw_cm.c                   |  6 +++---
 drivers/isdn/mISDN/l1oip_core.c                      |  2 +-
 drivers/isdn/mISDN/socket.c                          |  4 ++--
 drivers/net/ppp/pptp.c                               |  4 ++--
 drivers/nvme/host/tcp.c                              |  2 +-
 drivers/nvme/target/tcp.c                            |  2 +-
 drivers/target/iscsi/iscsi_target_login.c            |  2 +-
 drivers/xen/pvcalls-back.c                           |  2 +-
 fs/afs/rxrpc.c                                       |  6 +++---
 fs/dlm/lowcomms.c                                    |  6 +++---
 fs/ocfs2/cluster/tcp.c                               |  4 ++--
 fs/smb/client/connect.c                              |  2 +-
 fs/smb/server/transport_tcp.c                        |  4 ++--
 net/9p/trans_fd.c                                    |  2 +-
 net/appletalk/ddp.c                                  |  2 +-
 net/atm/pvc.c                                        |  4 ++--
 net/atm/svc.c                                        |  2 +-
 net/ax25/af_ax25.c                                   |  2 +-
 net/bluetooth/hci_sock.c                             |  2 +-
 net/bluetooth/iso.c                                  |  4 ++--
 net/bluetooth/l2cap_sock.c                           |  2 +-
 net/bluetooth/rfcomm/core.c                          |  4 ++--
 net/bluetooth/rfcomm/sock.c                          |  2 +-
 net/bluetooth/sco.c                                  |  2 +-
 net/can/isotp.c                                      |  2 +-
 net/can/j1939/socket.c                               |  2 +-
 net/can/raw.c                                        |  2 +-
 net/core/sock.c                                      |  2 +-
 net/ieee802154/socket.c                              |  4 ++--
 net/ipv4/af_inet.c                                   |  4 ++--
 net/ipv4/udp_tunnel_core.c                           |  2 +-
 net/ipv6/af_inet6.c                                  |  4 ++--
 net/ipv6/ip6_udp_tunnel.c                            |  2 +-
 net/iucv/af_iucv.c                                   |  2 +-
 net/l2tp/l2tp_core.c                                 |  4 ++--
 net/llc/af_llc.c                                     |  2 +-
 net/mctp/af_mctp.c                                   |  2 +-
 net/mctp/test/route-test.c                           |  2 +-
 net/mptcp/protocol.c                                 |  6 +++---
 net/mptcp/subflow.c                                  |  2 +-
 net/netfilter/ipvs/ip_vs_sync.c                      |  4 ++--
 net/netlink/af_netlink.c                             |  2 +-
 net/netrom/af_netrom.c                               |  2 +-
 net/nfc/llcp_sock.c                                  |  4 ++--
 net/packet/af_packet.c                               | 11 ++++++-----
 net/phonet/socket.c                                  |  8 ++++----
 net/qrtr/af_qrtr.c                                   |  2 +-
 net/qrtr/ns.c                                        |  2 +-
 net/rds/bind.c                                       |  2 +-
 net/rds/tcp_connect.c                                |  2 +-
 net/rds/tcp_listen.c                                 |  2 +-
 net/rose/af_rose.c                                   |  2 +-
 net/rxrpc/af_rxrpc.c                                 |  2 +-
 net/rxrpc/rxperf.c                                   |  2 +-
 net/smc/af_smc.c                                     |  2 +-
 net/socket.c                                         |  6 +++---
 net/sunrpc/clnt.c                                    |  4 ++--
 net/sunrpc/svcsock.c                                 |  2 +-
 net/sunrpc/xprtsock.c                                |  4 ++--
 net/tipc/socket.c                                    |  4 ++--
 net/unix/af_unix.c                                   |  4 ++--
 net/vmw_vsock/af_vsock.c                             |  4 ++--
 net/x25/af_x25.c                                     |  2 +-
 net/xdp/xsk.c                                        |  2 +-
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c |  2 +-
 74 files changed, 113 insertions(+), 112 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index ec09620f40f7..c85db0dc351e 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -163,7 +163,7 @@ struct proto_ops {
 	struct module	*owner;
 	int		(*release)   (struct socket *sock);
 	int		(*bind)	     (struct socket *sock,
-				      struct sockaddr *myaddr,
+				      struct sockaddr_unspec *myaddr,
 				      int sockaddr_len);
 	int		(*connect)   (struct socket *sock,
 				      struct sockaddr *vaddr,
@@ -345,7 +345,7 @@ int kernel_sendmsg(struct socket *sock, struct msghdr *msg, struct kvec *vec,
 int kernel_recvmsg(struct socket *sock, struct msghdr *msg, struct kvec *vec,
 		   size_t num, size_t len, int flags);
 
-int kernel_bind(struct socket *sock, struct sockaddr *addr, int addrlen);
+int kernel_bind(struct socket *sock, struct sockaddr_unspec *addr, int addrlen);
 int kernel_listen(struct socket *sock, int backlog);
 int kernel_accept(struct socket *sock, struct socket **newsock, int flags);
 int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index c17a6585d0b0..3ebd2aa0f052 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -42,7 +42,7 @@ int inet_shutdown(struct socket *sock, int how);
 int inet_listen(struct socket *sock, int backlog);
 int __inet_listen_sk(struct sock *sk, int backlog);
 void inet_sock_destruct(struct sock *sk);
-int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len);
+int inet_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int addr_len);
 int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 /* Don't allocate port at this moment, defer to connect. */
 #define BIND_FORCE_ADDRESS_NO_PORT	(1 << 0)
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 2ccdf85f34f1..5c5ccb84a188 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1208,7 +1208,7 @@ void ipv6_local_rxpmtu(struct sock *sk, struct flowi6 *fl6, u32 mtu);
 void inet6_cleanup_sock(struct sock *sk);
 void inet6_sock_destruct(struct sock *sk);
 int inet6_release(struct socket *sock);
-int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len);
+int inet6_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int addr_len);
 int inet6_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
 		  int peer);
diff --git a/include/net/sock.h b/include/net/sock.h
index 60bcb13f045c..ba20d4721a6e 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1901,7 +1901,7 @@ int sock_cmsg_send(struct sock *sk, struct msghdr *msg,
  * Functions to fill in entries in struct proto_ops when a protocol
  * does not implement a particular function.
  */
-int sock_no_bind(struct socket *, struct sockaddr *, int);
+int sock_no_bind(struct socket *sock, struct sockaddr_unspec *saddr, int len);
 int sock_no_connect(struct socket *, struct sockaddr *, int, int);
 int sock_no_socketpair(struct socket *, struct socket *);
 int sock_no_accept(struct socket *, struct socket *, struct proto_accept_arg *);
diff --git a/net/rds/rds.h b/net/rds/rds.h
index 5b1c072e2e7f..11d9ae2e9922 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -735,7 +735,7 @@ extern wait_queue_head_t rds_poll_waitq;
 
 
 /* bind.c */
-int rds_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len);
+int rds_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int addr_len);
 void rds_remove_bound(struct rds_sock *rs);
 struct rds_sock *rds_find_bound(const struct in6_addr *addr, __be16 port,
 				__u32 scope_id);
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 2c9084963739..cd2d8a6c52e5 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -42,7 +42,7 @@ void smc_unhash_sk(struct sock *sk);
 void smc_release_cb(struct sock *sk);
 
 int smc_release(struct socket *sock);
-int smc_bind(struct socket *sock, struct sockaddr *uaddr,
+int smc_bind(struct socket *sock, struct sockaddr_unspec *uaddr,
 	     int addr_len);
 int smc_connect(struct socket *sock, struct sockaddr *addr,
 		int alen, int flags);
diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index ca6fdcc6c54a..d334f7c7f67c 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -145,7 +145,7 @@ void af_alg_release_parent(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(af_alg_release_parent);
 
-static int alg_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+static int alg_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int addr_len)
 {
 	const u32 allowed = CRYPTO_ALG_KERN_DRIVER_ONLY;
 	struct sock *sk = sock->sk;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index caaf2781136d..a6b91452026a 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -450,7 +450,7 @@ static struct socket *drbd_try_connect(struct drbd_connection *connection)
 	*  a free one dynamically.
 	*/
 	what = "bind before connect";
-	err = sock->ops->bind(sock, (struct sockaddr *) &src_in6, my_addr_len);
+	err = sock->ops->bind(sock, (struct sockaddr_unspec *) &src_in6, my_addr_len);
 	if (err < 0)
 		goto out;
 
@@ -537,7 +537,7 @@ static int prepare_listen_socket(struct drbd_connection *connection, struct acce
 	drbd_setbufsize(s_listen, sndbuf_size, rcvbuf_size);
 
 	what = "bind before listen";
-	err = s_listen->ops->bind(s_listen, (struct sockaddr *)&my_addr, my_addr_len);
+	err = s_listen->ops->bind(s_listen, (struct sockaddr_unspec *)&my_addr, my_addr_len);
 	if (err < 0)
 		goto out;
 
diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/hw/erdma/erdma_cm.c
index e0acc185e719..e819e9d627d1 100644
--- a/drivers/infiniband/hw/erdma/erdma_cm.c
+++ b/drivers/infiniband/hw/erdma/erdma_cm.c
@@ -993,7 +993,7 @@ static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 	int ret;
 
 	sock_set_reuseaddr(s->sk);
-	ret = s->ops->bind(s, laddr, laddrlen);
+	ret = s->ops->bind(s, (struct sockaddr_unspec *)laddr, laddrlen);
 	if (ret)
 		return ret;
 	ret = s->ops->connect(s, raddr, raddrlen, flags);
@@ -1315,7 +1315,7 @@ int erdma_create_listen(struct iw_cm_id *id, int backlog)
 	if (ipv4_is_zeronet(laddr->sin_addr.s_addr))
 		s->sk->sk_bound_dev_if = dev->netdev->ifindex;
 
-	ret = s->ops->bind(s, (struct sockaddr *)laddr,
+	ret = s->ops->bind(s, (struct sockaddr_unspec *)laddr,
 			   sizeof(struct sockaddr_in));
 	if (ret)
 		goto error;
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 708b13993fdf..7c3883bcaccf 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1340,7 +1340,7 @@ static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 			return rv;
 	}
 
-	rv = s->ops->bind(s, laddr, size);
+	rv = s->ops->bind(s, (struct sockaddr_unspec *)laddr, size);
 	if (rv < 0)
 		return rv;
 
@@ -1789,7 +1789,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 				goto error;
 			}
 		}
-		rv = s->ops->bind(s, (struct sockaddr *)laddr,
+		rv = s->ops->bind(s, (struct sockaddr_unspec *)laddr,
 				  sizeof(struct sockaddr_in));
 	} else {
 		struct sockaddr_in6 *laddr = &to_sockaddr_in6(id->local_addr);
@@ -1813,7 +1813,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 				goto error;
 			}
 		}
-		rv = s->ops->bind(s, (struct sockaddr *)laddr,
+		rv = s->ops->bind(s, (struct sockaddr_unspec *)laddr,
 				  sizeof(struct sockaddr_in6));
 	}
 	if (rv) {
diff --git a/drivers/isdn/mISDN/l1oip_core.c b/drivers/isdn/mISDN/l1oip_core.c
index f732f6614d37..8b740ea954d1 100644
--- a/drivers/isdn/mISDN/l1oip_core.c
+++ b/drivers/isdn/mISDN/l1oip_core.c
@@ -676,7 +676,7 @@ l1oip_socket_thread(void *data)
 	hc->sin_remote.sin_port = htons((unsigned short)hc->remoteport);
 
 	/* bind to incoming port */
-	if (socket->ops->bind(socket, (struct sockaddr *)&hc->sin_local,
+	if (socket->ops->bind(socket, (struct sockaddr_unspec *)&hc->sin_local,
 			      sizeof(hc->sin_local))) {
 		printk(KERN_ERR "%s: Failed to bind socket to port %d.\n",
 		       __func__, hc->localport);
diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
index b215b28cad7b..86ea8ff6710a 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -462,7 +462,7 @@ static int data_sock_getsockopt(struct socket *sock, int level, int optname,
 }
 
 static int
-data_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
+data_sock_bind(struct socket *sock, struct sockaddr_unspec *addr, int addr_len)
 {
 	struct sockaddr_mISDN *maddr = (struct sockaddr_mISDN *) addr;
 	struct sock *sk = sock->sk;
@@ -696,7 +696,7 @@ base_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 }
 
 static int
-base_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
+base_sock_bind(struct socket *sock, struct sockaddr_unspec *addr, int addr_len)
 {
 	struct sockaddr_mISDN *maddr = (struct sockaddr_mISDN *) addr;
 	struct sock *sk = sock->sk;
diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 90737cb71892..057eaeac65f9 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -382,8 +382,8 @@ static int pptp_rcv(struct sk_buff *skb)
 	return NET_RX_DROP;
 }
 
-static int pptp_bind(struct socket *sock, struct sockaddr *uservaddr,
-	int sockaddr_len)
+static int pptp_bind(struct socket *sock, struct sockaddr_unspec *uservaddr,
+		     int sockaddr_len)
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr_pppox *sp = (struct sockaddr_pppox *) uservaddr;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1413788ca7d5..35a4ed84f65a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1831,7 +1831,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	sk_set_memalloc(queue->sock->sk);
 
 	if (nctrl->opts->mask & NVMF_OPT_HOST_TRADDR) {
-		ret = kernel_bind(queue->sock, (struct sockaddr *)&ctrl->src_addr,
+		ret = kernel_bind(queue->sock, (struct sockaddr_unspec *)&ctrl->src_addr,
 			sizeof(ctrl->src_addr));
 		if (ret) {
 			dev_err(nctrl->device,
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 470bf37e5a63..1ac59ea4621f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2055,7 +2055,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	if (so_priority > 0)
 		sock_set_priority(port->sock->sk, so_priority);
 
-	ret = kernel_bind(port->sock, (struct sockaddr *)&port->addr,
+	ret = kernel_bind(port->sock, (struct sockaddr_unspec *)&port->addr,
 			sizeof(port->addr));
 	if (ret) {
 		pr_err("failed to bind port socket %d\n", ret);
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index c2ac9a99ebbb..f29af16fb780 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -822,7 +822,7 @@ int iscsit_setup_np(
 	sock_set_reuseaddr(sock->sk);
 	ip_sock_set_freebind(sock->sk);
 
-	ret = kernel_bind(sock, (struct sockaddr *)&np->np_sockaddr, len);
+	ret = kernel_bind(sock, (struct sockaddr_unspec *)&np->np_sockaddr, len);
 	if (ret < 0) {
 		pr_err("kernel_bind() failed: %d\n", ret);
 		goto fail;
diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index fd7ed65e0197..275d9e7060f6 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -650,7 +650,7 @@ static int pvcalls_back_bind(struct xenbus_device *dev,
 	if (ret < 0)
 		goto out;
 
-	ret = inet_bind(map->sock, (struct sockaddr *)&req->u.bind.addr,
+	ret = inet_bind(map->sock, (struct sockaddr_unspec *)&req->u.bind.addr,
 			req->u.bind.len);
 	if (ret < 0)
 		goto out;
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index c1cadf8fb346..f2f8b1d9db2e 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -82,16 +82,16 @@ int afs_open_socket(struct afs_net *net)
 	if (ret < 0)
 		pr_err("Couldn't create RxGK CM key: %d\n", ret);
 
-	ret = kernel_bind(socket, (struct sockaddr *) &srx, sizeof(srx));
+	ret = kernel_bind(socket, (struct sockaddr_unspec *) &srx, sizeof(srx));
 	if (ret == -EADDRINUSE) {
 		srx.transport.sin6.sin6_port = 0;
-		ret = kernel_bind(socket, (struct sockaddr *) &srx, sizeof(srx));
+		ret = kernel_bind(socket, (struct sockaddr_unspec *) &srx, sizeof(srx));
 	}
 	if (ret < 0)
 		goto error_2;
 
 	srx.srx_service = YFS_CM_SERVICE;
-	ret = kernel_bind(socket, (struct sockaddr *) &srx, sizeof(srx));
+	ret = kernel_bind(socket, (struct sockaddr_unspec *) &srx, sizeof(srx));
 	if (ret < 0)
 		goto error_2;
 
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 9a0b6c2b6b01..8eebab5387ec 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1134,7 +1134,7 @@ static int sctp_bind_addrs(struct socket *sock, __be16 port)
 		make_sockaddr(&localaddr, port, &addr_len);
 
 		if (!i)
-			result = kernel_bind(sock, addr, addr_len);
+			result = kernel_bind(sock, (struct sockaddr_unspec *)addr, addr_len);
 		else
 			result = sock_bind_add(sock->sk, addr, addr_len);
 
@@ -1813,7 +1813,7 @@ static int dlm_tcp_bind(struct socket *sock)
 	memcpy(&src_addr, &dlm_local_addr[0], sizeof(src_addr));
 	make_sockaddr(&src_addr, 0, &addr_len);
 
-	result = kernel_bind(sock, (struct sockaddr *)&src_addr,
+	result = kernel_bind(sock, (struct sockaddr_unspec *)&src_addr,
 			     addr_len);
 	if (result < 0) {
 		/* This *may* not indicate a critical error */
@@ -1852,7 +1852,7 @@ static int dlm_tcp_listen_bind(struct socket *sock)
 
 	/* Bind to our port */
 	make_sockaddr(&dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
-	return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
+	return kernel_bind(sock, (struct sockaddr_unspec *)&dlm_local_addr[0],
 			   addr_len);
 }
 
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index b05d4e9d13b2..66054520122f 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1615,7 +1615,7 @@ static void o2net_start_connect(struct work_struct *work)
 	myaddr.sin_addr.s_addr = mynode->nd_ipv4_address;
 	myaddr.sin_port = htons(0); /* any port */
 
-	ret = sock->ops->bind(sock, (struct sockaddr *)&myaddr,
+	ret = sock->ops->bind(sock, (struct sockaddr_unspec *)&myaddr,
 			      sizeof(myaddr));
 	if (ret) {
 		mlog(ML_ERROR, "bind failed with %d at address %pI4\n",
@@ -2002,7 +2002,7 @@ static int o2net_open_listening_sock(__be32 addr, __be16 port)
 	INIT_WORK(&o2net_listen_work, o2net_accept_many);
 
 	sock->sk->sk_reuse = SK_CAN_REUSE;
-	ret = sock->ops->bind(sock, (struct sockaddr *)&sin, sizeof(sin));
+	ret = sock->ops->bind(sock, (struct sockaddr_unspec *)&sin, sizeof(sin));
 	if (ret < 0) {
 		printk(KERN_ERR "o2net: Error %d while binding socket at "
 		       "%pI4:%u\n", ret, &addr, ntohs(port)); 
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index dd12f3eb61dc..5631e1b53e8c 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3112,7 +3112,7 @@ bind_socket(struct TCP_Server_Info *server)
 		struct socket *socket = server->ssocket;
 
 		rc = kernel_bind(socket,
-				 (struct sockaddr *) &server->srcaddr,
+				 (struct sockaddr_unspec *) &server->srcaddr,
 				 sizeof(server->srcaddr));
 		if (rc < 0) {
 			struct sockaddr_in *saddr4;
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 7a1e3dcc2cde..f6f8df0274e2 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -519,10 +519,10 @@ static int create_socket(struct interface *iface)
 	}
 
 	if (ipv4)
-		ret = kernel_bind(ksmbd_socket, (struct sockaddr *)&sin,
+		ret = kernel_bind(ksmbd_socket, (struct sockaddr_unspec *)&sin,
 				  sizeof(sin));
 	else
-		ret = kernel_bind(ksmbd_socket, (struct sockaddr *)&sin6,
+		ret = kernel_bind(ksmbd_socket, (struct sockaddr_unspec *)&sin6,
 				  sizeof(sin6));
 	if (ret) {
 		pr_err("Failed to bind socket: %d\n", ret);
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index a516745f732f..82537798d126 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -966,7 +966,7 @@ static int p9_bind_privport(struct socket *sock)
 			((struct sockaddr_in *)&stor)->sin_port = htons((ushort)port);
 		else
 			((struct sockaddr_in6 *)&stor)->sin6_port = htons((ushort)port);
-		err = kernel_bind(sock, (struct sockaddr *)&stor, sizeof(stor));
+		err = kernel_bind(sock, (struct sockaddr_unspec *)&stor, sizeof(stor));
 		if (err != -EADDRINUSE)
 			break;
 	}
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 30242fe10341..f00e22318dfa 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1149,7 +1149,7 @@ static int atalk_autobind(struct sock *sk)
 }
 
 /* Set the address 'our end' of the connection */
-static int atalk_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+static int atalk_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int addr_len)
 {
 	struct sockaddr_at *addr = (struct sockaddr_at *)uaddr;
 	struct sock *sk = sock->sk;
diff --git a/net/atm/pvc.c b/net/atm/pvc.c
index 66d9a9bd5896..c57d6ac7cede 100644
--- a/net/atm/pvc.c
+++ b/net/atm/pvc.c
@@ -24,7 +24,7 @@ static int pvc_shutdown(struct socket *sock, int how)
 	return 0;
 }
 
-static int pvc_bind(struct socket *sock, struct sockaddr *sockaddr,
+static int pvc_bind(struct socket *sock, struct sockaddr_unspec *sockaddr,
 		    int sockaddr_len)
 {
 	struct sock *sk = sock->sk;
@@ -59,7 +59,7 @@ static int pvc_bind(struct socket *sock, struct sockaddr *sockaddr,
 static int pvc_connect(struct socket *sock, struct sockaddr *sockaddr,
 		       int sockaddr_len, int flags)
 {
-	return pvc_bind(sock, sockaddr, sockaddr_len);
+	return pvc_bind(sock, (struct sockaddr_unspec *)sockaddr, sockaddr_len);
 }
 
 static int pvc_setsockopt(struct socket *sock, int level, int optname,
diff --git a/net/atm/svc.c b/net/atm/svc.c
index f8137ae693b0..1e7e4b412d1d 100644
--- a/net/atm/svc.c
+++ b/net/atm/svc.c
@@ -97,7 +97,7 @@ static int svc_release(struct socket *sock)
 	return 0;
 }
 
-static int svc_bind(struct socket *sock, struct sockaddr *sockaddr,
+static int svc_bind(struct socket *sock, struct sockaddr_unspec *sockaddr,
 		    int sockaddr_len)
 {
 	DEFINE_WAIT(wait);
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 6ef8b2a57a9b..ea336cd4c9e9 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -1094,7 +1094,7 @@ static int ax25_release(struct socket *sock)
  *	that we've implemented support for SO_BINDTODEVICE. It is however small
  *	and trivially backward compatible.
  */
-static int ax25_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+static int ax25_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int addr_len)
 {
 	struct sock *sk = sock->sk;
 	struct full_sockaddr_ax25 *addr = (struct full_sockaddr_ax25 *)uaddr;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index fc866759910d..9091cf69df4f 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1185,7 +1185,7 @@ static int hci_sock_compat_ioctl(struct socket *sock, unsigned int cmd,
 }
 #endif
 
-static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
+static int hci_sock_bind(struct socket *sock, struct sockaddr_unspec *addr,
 			 int addr_len)
 {
 	struct sockaddr_hci haddr;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 9b263d061e05..43965787f473 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -944,7 +944,7 @@ static int iso_sock_create(struct net *net, struct socket *sock, int protocol,
 	return 0;
 }
 
-static int iso_sock_bind_bc(struct socket *sock, struct sockaddr *addr,
+static int iso_sock_bind_bc(struct socket *sock, struct sockaddr_unspec *addr,
 			    int addr_len)
 {
 	struct sockaddr_iso *sa = (struct sockaddr_iso *)addr;
@@ -1022,7 +1022,7 @@ static int iso_sock_bind_pa_sk(struct sock *sk, struct sockaddr_iso *sa,
 	return err;
 }
 
-static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
+static int iso_sock_bind(struct socket *sock, struct sockaddr_unspec *addr,
 			 int addr_len)
 {
 	struct sockaddr_iso *sa = (struct sockaddr_iso *)addr;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 814fb8610ac4..5a152584c096 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -80,7 +80,7 @@ static int l2cap_validate_le_psm(u16 psm)
 	return 0;
 }
 
-static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
+static int l2cap_sock_bind(struct socket *sock, struct sockaddr_unspec *addr, int alen)
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 96250807b32b..612992b59890 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -781,7 +781,7 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 	addr.l2_psm    = 0;
 	addr.l2_cid    = 0;
 	addr.l2_bdaddr_type = BDADDR_BREDR;
-	*err = kernel_bind(sock, (struct sockaddr *) &addr, sizeof(addr));
+	*err = kernel_bind(sock, (struct sockaddr_unspec *)&addr, sizeof(addr));
 	if (*err < 0)
 		goto failed;
 
@@ -2068,7 +2068,7 @@ static int rfcomm_add_listener(bdaddr_t *ba)
 	addr.l2_psm    = cpu_to_le16(L2CAP_PSM_RFCOMM);
 	addr.l2_cid    = 0;
 	addr.l2_bdaddr_type = BDADDR_BREDR;
-	err = kernel_bind(sock, (struct sockaddr *) &addr, sizeof(addr));
+	err = kernel_bind(sock, (struct sockaddr_unspec *)&addr, sizeof(addr));
 	if (err < 0) {
 		BT_ERR("Bind failed %d", err);
 		goto failed;
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 913402806fa0..f253d43683ce 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -324,7 +324,7 @@ static int rfcomm_sock_create(struct net *net, struct socket *sock,
 	return 0;
 }
 
-static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
+static int rfcomm_sock_bind(struct socket *sock, struct sockaddr_unspec *addr, int addr_len)
 {
 	struct sockaddr_rc sa;
 	struct sock *sk = sock->sk;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index ab0cf442d57b..0ede08e15f8f 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -605,7 +605,7 @@ static int sco_sock_create(struct net *net, struct socket *sock, int protocol,
 	return 0;
 }
 
-static int sco_sock_bind(struct socket *sock, struct sockaddr *addr,
+static int sco_sock_bind(struct socket *sock, struct sockaddr_unspec *addr,
 			 int addr_len)
 {
 	struct sockaddr_sco *sa = (struct sockaddr_sco *) addr;
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 74ee1e52249b..b9070e113db9 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1246,7 +1246,7 @@ static int isotp_release(struct socket *sock)
 	return 0;
 }
 
-static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
+static int isotp_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int len)
 {
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
 	struct sock *sk = sock->sk;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 88e7160d4248..4dfa3a299301 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -440,7 +440,7 @@ static int j1939_sk_sanity_check(struct sockaddr_can *addr, int len)
 	return 0;
 }
 
-static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
+static int j1939_sk_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int len)
 {
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
 	struct j1939_sock *jsk = j1939_sk(sock->sk);
diff --git a/net/can/raw.c b/net/can/raw.c
index a53853f5e9af..43aa0654fc8d 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -449,7 +449,7 @@ static int raw_release(struct socket *sock)
 	return 0;
 }
 
-static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
+static int raw_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int len)
 {
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
 	struct sock *sk = sock->sk;
diff --git a/net/core/sock.c b/net/core/sock.c
index dc03d4b5909a..e409c2d20d12 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3420,7 +3420,7 @@ EXPORT_SYMBOL_GPL(sk_set_peek_off);
  * function, some default processing is provided.
  */
 
-int sock_no_bind(struct socket *sock, struct sockaddr *saddr, int len)
+int sock_no_bind(struct socket *sock, struct sockaddr_unspec *saddr, int len)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 18d267921bb5..c1b832afb27b 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -96,13 +96,13 @@ static int ieee802154_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	return sk->sk_prot->sendmsg(sk, msg, len);
 }
 
-static int ieee802154_sock_bind(struct socket *sock, struct sockaddr *uaddr,
+static int ieee802154_sock_bind(struct socket *sock, struct sockaddr_unspec *uaddr,
 				int addr_len)
 {
 	struct sock *sk = sock->sk;
 
 	if (sk->sk_prot->bind)
-		return sk->sk_prot->bind(sk, uaddr, addr_len);
+		return sk->sk_prot->bind(sk, (struct sockaddr *)uaddr, addr_len);
 
 	return sock_no_bind(sock, uaddr, addr_len);
 }
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 3109c5ec38f3..71cab1f522d6 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -464,9 +464,9 @@ int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	return __inet_bind(sk, uaddr, addr_len, flags);
 }
 
-int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+int inet_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int addr_len)
 {
-	return inet_bind_sk(sock->sk, uaddr, addr_len);
+	return inet_bind_sk(sock->sk, (struct sockaddr *)uaddr, addr_len);
 }
 EXPORT_SYMBOL(inet_bind);
 
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 54386e06a813..b478b73113bf 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -29,7 +29,7 @@ int udp_sock_create4(struct net *net, struct udp_port_cfg *cfg,
 	udp_addr.sin_family = AF_INET;
 	udp_addr.sin_addr = cfg->local_ip;
 	udp_addr.sin_port = cfg->local_udp_port;
-	err = kernel_bind(sock, (struct sockaddr *)&udp_addr,
+	err = kernel_bind(sock, (struct sockaddr_unspec *)&udp_addr,
 			  sizeof(udp_addr));
 	if (err < 0)
 		goto error;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 1b0314644e0c..623b47cbbf4f 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -465,9 +465,9 @@ int inet6_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 }
 
 /* bind for INET6 API */
-int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+int inet6_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int addr_len)
 {
-	return inet6_bind_sk(sock->sk, uaddr, addr_len);
+	return inet6_bind_sk(sock->sk, (struct sockaddr *)uaddr, addr_len);
 }
 EXPORT_SYMBOL(inet6_bind);
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 0ff547a4bff7..78d7297e3db7 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -40,7 +40,7 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 	memcpy(&udp6_addr.sin6_addr, &cfg->local_ip6,
 	       sizeof(udp6_addr.sin6_addr));
 	udp6_addr.sin6_port = cfg->local_udp_port;
-	err = kernel_bind(sock, (struct sockaddr *)&udp6_addr,
+	err = kernel_bind(sock, (struct sockaddr_unspec *)&udp6_addr,
 			  sizeof(udp6_addr));
 	if (err < 0)
 		goto error;
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 6c717a7ef292..5e7f89d79a2e 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -562,7 +562,7 @@ static void __iucv_auto_name(struct iucv_sock *iucv)
 }
 
 /* Bind an unbound socket */
-static int iucv_sock_bind(struct socket *sock, struct sockaddr *addr,
+static int iucv_sock_bind(struct socket *sock, struct sockaddr_unspec *addr,
 			  int addr_len)
 {
 	DECLARE_SOCKADDR(struct sockaddr_iucv *, sa, addr);
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 369a2f2e459c..6ab3354402fc 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1503,7 +1503,7 @@ static int l2tp_tunnel_sock_create(struct net *net,
 			memcpy(&ip6_addr.l2tp_addr, cfg->local_ip6,
 			       sizeof(ip6_addr.l2tp_addr));
 			ip6_addr.l2tp_conn_id = tunnel_id;
-			err = kernel_bind(sock, (struct sockaddr *)&ip6_addr,
+			err = kernel_bind(sock, (struct sockaddr_unspec *)&ip6_addr,
 					  sizeof(ip6_addr));
 			if (err < 0)
 				goto out;
@@ -1530,7 +1530,7 @@ static int l2tp_tunnel_sock_create(struct net *net,
 			ip_addr.l2tp_family = AF_INET;
 			ip_addr.l2tp_addr = cfg->local_ip;
 			ip_addr.l2tp_conn_id = tunnel_id;
-			err = kernel_bind(sock, (struct sockaddr *)&ip_addr,
+			err = kernel_bind(sock, (struct sockaddr_unspec *)&ip_addr,
 					  sizeof(ip_addr));
 			if (err < 0)
 				goto out;
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 5958a80fe14c..889804f0e4f4 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -337,7 +337,7 @@ static int llc_ui_autobind(struct socket *sock, struct sockaddr_llc *addr)
  *	otherwise all hell will break loose.
  *	Returns: 0 upon success, negative otherwise.
  */
-static int llc_ui_bind(struct socket *sock, struct sockaddr *uaddr, int addrlen)
+static int llc_ui_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int addrlen)
 {
 	struct sockaddr_llc *addr = (struct sockaddr_llc *)uaddr;
 	struct sock *sk = sock->sk;
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index b99ba14f39d2..9e0f33b16ebd 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -49,7 +49,7 @@ static bool mctp_sockaddr_ext_is_ok(const struct sockaddr_mctp_ext *addr)
 	       !addr->__smctp_pad0[2];
 }
 
-static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
+static int mctp_bind(struct socket *sock, struct sockaddr_unspec *addr, int addrlen)
 {
 	struct sock *sk = sock->sk;
 	struct mctp_sock *msk = container_of(sk, struct mctp_sock, sk);
diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 69a3ccfc6310..74aad652fc29 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -205,7 +205,7 @@ static void __mctp_route_test_init(struct kunit *test,
 	addr.smctp_network = netid;
 	addr.smctp_addr.s_addr = 8;
 	addr.smctp_type = 0;
-	rc = kernel_bind(sock, (struct sockaddr *)&addr, sizeof(addr));
+	rc = kernel_bind(sock, (struct sockaddr_unspec *)&addr, sizeof(addr));
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
 	*devp = dev;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0292162a14ee..846d0718d87c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3832,7 +3832,7 @@ static struct proto mptcp_prot = {
 	.no_autobind	= true,
 };
 
-static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+static int mptcp_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int addr_len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
 	struct sock *ssk, *sk = sock->sk;
@@ -3846,10 +3846,10 @@ static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	}
 
 	if (sk->sk_family == AF_INET)
-		err = inet_bind_sk(ssk, uaddr, addr_len);
+		err = inet_bind_sk(ssk, (struct sockaddr *)uaddr, addr_len);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	else if (sk->sk_family == AF_INET6)
-		err = inet6_bind_sk(ssk, uaddr, addr_len);
+		err = inet6_bind_sk(ssk, (struct sockaddr *)uaddr, addr_len);
 #endif
 	if (!err)
 		mptcp_copy_inaddrs(sk, ssk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e8325890a322..f77630451fb4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1660,7 +1660,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 		addrlen = sizeof(struct sockaddr_in6);
 #endif
 	ssk->sk_bound_dev_if = local->ifindex;
-	err = kernel_bind(sf, (struct sockaddr *)&addr, addrlen);
+	err = kernel_bind(sf, (struct sockaddr_unspec *)&addr, addrlen);
 	if (err) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTXBINDERR);
 		pr_debug("msk=%p local=%d remote=%d bind error: %d\n",
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 3402675bf521..c9a97f8a6ce0 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1435,7 +1435,7 @@ static int bind_mcastif_addr(struct socket *sock, struct net_device *dev)
 	sin.sin_addr.s_addr  = addr;
 	sin.sin_port         = 0;
 
-	return kernel_bind(sock, (struct sockaddr *)&sin, sizeof(sin));
+	return kernel_bind(sock, (struct sockaddr_unspec *)&sin, sizeof(sin));
 }
 
 static void get_mcast_sockaddr(union ipvs_sockaddr *sa, int *salen,
@@ -1542,7 +1542,7 @@ static int make_receive_sock(struct netns_ipvs *ipvs, int id,
 
 	get_mcast_sockaddr(&mcast_addr, &salen, &ipvs->bcfg, id);
 	sock->sk->sk_bound_dev_if = dev->ifindex;
-	result = kernel_bind(sock, (struct sockaddr *)&mcast_addr, salen);
+	result = kernel_bind(sock, (struct sockaddr_unspec *)&mcast_addr, salen);
 	if (result < 0) {
 		pr_err("Error binding to the multicast addr\n");
 		goto error;
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 2b46c0cd752a..91433fa79041 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -968,7 +968,7 @@ static void netlink_undo_bind(int group, long unsigned int groups,
 			nlk->netlink_unbind(sock_net(sk), undo + 1);
 }
 
-static int netlink_bind(struct socket *sock, struct sockaddr *addr,
+static int netlink_bind(struct socket *sock, struct sockaddr_unspec *addr,
 			int addr_len)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 3331669d8e33..4accfe4abeb9 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -561,7 +561,7 @@ static int nr_release(struct socket *sock)
 	return 0;
 }
 
-static int nr_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+static int nr_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int addr_len)
 {
 	struct sock *sk = sock->sk;
 	struct nr_sock *nr = nr_sk(sk);
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 57a2f97004e1..7d4fe806c4bf 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -56,7 +56,7 @@ static struct proto llcp_sock_proto = {
 	.obj_size = sizeof(struct nfc_llcp_sock),
 };
 
-static int llcp_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
+static int llcp_sock_bind(struct socket *sock, struct sockaddr_unspec *addr, int alen)
 {
 	struct sock *sk = sock->sk;
 	struct nfc_llcp_sock *llcp_sock = nfc_llcp_sock(sk);
@@ -146,7 +146,7 @@ static int llcp_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	return ret;
 }
 
-static int llcp_raw_sock_bind(struct socket *sock, struct sockaddr *addr,
+static int llcp_raw_sock_bind(struct socket *sock, struct sockaddr_unspec *addr,
 			      int alen)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 173e6edda08f..73bea76ea45d 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3279,11 +3279,12 @@ static int packet_do_bind(struct sock *sk, const char *name, int ifindex,
  *	Bind a packet socket to a device
  */
 
-static int packet_bind_spkt(struct socket *sock, struct sockaddr *uaddr,
+static int packet_bind_spkt(struct socket *sock, struct sockaddr_unspec *uaddr,
 			    int addr_len)
 {
 	struct sock *sk = sock->sk;
-	char name[sizeof(uaddr->sa_data_min) + 1];
+	struct sockaddr *sa = (struct sockaddr *)uaddr;
+	char name[sizeof(sa->sa_data_min) + 1];
 
 	/*
 	 *	Check legality
@@ -3294,13 +3295,13 @@ static int packet_bind_spkt(struct socket *sock, struct sockaddr *uaddr,
 	/* uaddr->sa_data comes from the userspace, it's not guaranteed to be
 	 * zero-terminated.
 	 */
-	memcpy(name, uaddr->sa_data, sizeof(uaddr->sa_data_min));
-	name[sizeof(uaddr->sa_data_min)] = 0;
+	memcpy(name, sa->sa_data, sizeof(sa->sa_data_min));
+	name[sizeof(sa->sa_data_min)] = 0;
 
 	return packet_do_bind(sk, name, 0, 0);
 }
 
-static int packet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+static int packet_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int addr_len)
 {
 	struct sockaddr_ll *sll = (struct sockaddr_ll *)uaddr;
 	struct sock *sk = sock->sk;
diff --git a/net/phonet/socket.c b/net/phonet/socket.c
index db2d552e9b32..ede4a21012f6 100644
--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -153,7 +153,7 @@ EXPORT_SYMBOL(pn_sock_unhash);
 
 static DEFINE_MUTEX(port_mutex);
 
-static int pn_socket_bind(struct socket *sock, struct sockaddr *addr, int len)
+static int pn_socket_bind(struct socket *sock, struct sockaddr_unspec *addr, int len)
 {
 	struct sock *sk = sock->sk;
 	struct pn_sock *pn = pn_sk(sk);
@@ -163,7 +163,7 @@ static int pn_socket_bind(struct socket *sock, struct sockaddr *addr, int len)
 	u8 saddr;
 
 	if (sk->sk_prot->bind)
-		return sk->sk_prot->bind(sk, addr, len);
+		return sk->sk_prot->bind(sk, (struct sockaddr *)addr, len);
 
 	if (len < sizeof(struct sockaddr_pn))
 		return -EINVAL;
@@ -206,8 +206,8 @@ static int pn_socket_autobind(struct socket *sock)
 
 	memset(&sa, 0, sizeof(sa));
 	sa.spn_family = AF_PHONET;
-	err = pn_socket_bind(sock, (struct sockaddr *)&sa,
-				sizeof(struct sockaddr_pn));
+	err = pn_socket_bind(sock, (struct sockaddr_unspec *)&sa,
+			     sizeof(struct sockaddr_pn));
 	if (err != -EINVAL)
 		return err;
 	BUG_ON(!pn_port(pn_sk(sock->sk)->sobject));
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 00c51cf693f3..5c952946f9f0 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -824,7 +824,7 @@ static int qrtr_autobind(struct socket *sock)
 }
 
 /* Bind socket to specified sockaddr. */
-static int qrtr_bind(struct socket *sock, struct sockaddr *saddr, int len)
+static int qrtr_bind(struct socket *sock, struct sockaddr_unspec *saddr, int len)
 {
 	DECLARE_SOCKADDR(struct sockaddr_qrtr *, addr, saddr);
 	struct qrtr_sock *ipc = qrtr_sk(sock->sk);
diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 3de9350cbf30..643f697bc9d6 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -714,7 +714,7 @@ int qrtr_ns_init(void)
 	sq.sq_port = QRTR_PORT_CTRL;
 	qrtr_ns.local_node = sq.sq_node;
 
-	ret = kernel_bind(qrtr_ns.sock, (struct sockaddr *)&sq, sizeof(sq));
+	ret = kernel_bind(qrtr_ns.sock, (struct sockaddr_unspec *)&sq, sizeof(sq));
 	if (ret < 0) {
 		pr_err("failed to bind to socket\n");
 		goto err_wq;
diff --git a/net/rds/bind.c b/net/rds/bind.c
index 97a29172a8ee..f4d88f9e3dd6 100644
--- a/net/rds/bind.c
+++ b/net/rds/bind.c
@@ -160,7 +160,7 @@ void rds_remove_bound(struct rds_sock *rs)
 	rs->rs_bound_addr = in6addr_any;
 }
 
-int rds_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+int rds_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int addr_len)
 {
 	struct sock *sk = sock->sk;
 	struct rds_sock *rs = rds_sk_to_rs(sk);
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index a0046e99d6df..d807d5d11ad2 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -145,7 +145,7 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 		addrlen = sizeof(sin);
 	}
 
-	ret = kernel_bind(sock, addr, addrlen);
+	ret = kernel_bind(sock, (struct sockaddr_unspec *)addr, addrlen);
 	if (ret) {
 		rdsdebug("bind failed with %d at address %pI6c\n",
 			 ret, &conn->c_laddr);
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 91e34af3fe5d..773ed3c110e4 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -290,7 +290,7 @@ struct socket *rds_tcp_listen_init(struct net *net, bool isv6)
 		addr_len = sizeof(*sin);
 	}
 
-	ret = kernel_bind(sock, (struct sockaddr *)&ss, addr_len);
+	ret = kernel_bind(sock, (struct sockaddr_unspec *)&ss, addr_len);
 	if (ret < 0) {
 		rdsdebug("could not bind %s listener socket: %d\n",
 			 isv6 ? "IPv6" : "IPv4", ret);
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 543f9e8ebb69..320030d67f13 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -693,7 +693,7 @@ static int rose_release(struct socket *sock)
 	return 0;
 }
 
-static int rose_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+static int rose_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int addr_len)
 {
 	struct sock *sk = sock->sk;
 	struct rose_sock *rose = rose_sk(sk);
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 36df0274d7b7..ea506d7f83cd 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -127,7 +127,7 @@ static int rxrpc_validate_address(struct rxrpc_sock *rx,
 /*
  * bind a local address to an RxRPC socket
  */
-static int rxrpc_bind(struct socket *sock, struct sockaddr *saddr, int len)
+static int rxrpc_bind(struct socket *sock, struct sockaddr_unspec *saddr, int len)
 {
 	struct sockaddr_rxrpc *srx = (struct sockaddr_rxrpc *)saddr;
 	struct rxrpc_local *local;
diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
index 2ea71e3831f7..8bbef974d31a 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -211,7 +211,7 @@ static int rxperf_open_socket(void)
 
 	ret = rxrpc_sock_set_security_keyring(socket->sk, rxperf_sec_keyring);
 
-	ret = kernel_bind(socket, (struct sockaddr *)&srx, sizeof(srx));
+	ret = kernel_bind(socket, (struct sockaddr_unspec *)&srx, sizeof(srx));
 	if (ret < 0)
 		goto error_2;
 
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 77b99e8ef35a..a5d22f222352 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -421,7 +421,7 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
 	return sk;
 }
 
-int smc_bind(struct socket *sock, struct sockaddr *uaddr,
+int smc_bind(struct socket *sock, struct sockaddr_unspec *uaddr,
 	     int addr_len)
 {
 	struct sockaddr_in *addr = (struct sockaddr_in *)uaddr;
diff --git a/net/socket.c b/net/socket.c
index e8892b218708..1e0e2da03616 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1872,7 +1872,7 @@ int __sys_bind_socket(struct socket *sock, struct sockaddr_storage *address,
 				   addrlen);
 	if (!err)
 		err = READ_ONCE(sock->ops)->bind(sock,
-						 (struct sockaddr *)address,
+						 (struct sockaddr_unspec *)address,
 						 addrlen);
 	return err;
 }
@@ -3583,13 +3583,13 @@ static long compat_sock_ioctl(struct file *file, unsigned int cmd,
  *	Returns 0 or an error.
  */
 
-int kernel_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
+int kernel_bind(struct socket *sock, struct sockaddr_unspec *addr, int addrlen)
 {
 	struct sockaddr_storage address;
 
 	memcpy(&address, addr, addrlen);
 
-	return READ_ONCE(sock->ops)->bind(sock, (struct sockaddr *)&address,
+	return READ_ONCE(sock->ops)->bind(sock, (struct sockaddr_unspec *)&address,
 					  addrlen);
 }
 EXPORT_SYMBOL(kernel_bind);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 8ca354ecfd02..5ab0404da2cc 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1457,12 +1457,12 @@ static int rpc_sockname(struct net *net, struct sockaddr *sap, size_t salen,
 	switch (sap->sa_family) {
 	case AF_INET:
 		err = kernel_bind(sock,
-				(struct sockaddr *)&rpc_inaddr_loopback,
+				(struct sockaddr_unspec *)&rpc_inaddr_loopback,
 				sizeof(rpc_inaddr_loopback));
 		break;
 	case AF_INET6:
 		err = kernel_bind(sock,
-				(struct sockaddr *)&rpc_in6addr_loopback,
+				(struct sockaddr_unspec *)&rpc_in6addr_loopback,
 				sizeof(rpc_in6addr_loopback));
 		break;
 	default:
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 7b90abc5cf0e..1259cccd883c 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1557,7 +1557,7 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 		ip6_sock_set_v6only(sock->sk);
 	if (type == SOCK_STREAM)
 		sock->sk->sk_reuse = SK_CAN_REUSE; /* allow address reuse */
-	error = kernel_bind(sock, sin, len);
+	error = kernel_bind(sock, (struct sockaddr_unspec *)sin, len);
 	if (error < 0)
 		goto bummer;
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 3aa987e7f072..e55e9e6fb776 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1845,8 +1845,8 @@ static int xs_bind(struct sock_xprt *transport, struct socket *sock)
 	memcpy(&myaddr, &transport->srcaddr, transport->xprt.addrlen);
 	do {
 		rpc_set_port((struct sockaddr *)&myaddr, port);
-		err = kernel_bind(sock, (struct sockaddr *)&myaddr,
-				transport->xprt.addrlen);
+		err = kernel_bind(sock, (struct sockaddr_unspec *)&myaddr,
+				  transport->xprt.addrlen);
 		if (err == 0) {
 			if (transport->xprt.reuseport)
 				transport->srcport = port;
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 1574a83384f8..dc8166db49a9 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -710,7 +710,7 @@ int tipc_sk_bind(struct socket *sock, struct sockaddr *skaddr, int alen)
 	return res;
 }
 
-static int tipc_bind(struct socket *sock, struct sockaddr *skaddr, int alen)
+static int tipc_bind(struct socket *sock, struct sockaddr_unspec *skaddr, int alen)
 {
 	struct tipc_uaddr *ua = (struct tipc_uaddr *)skaddr;
 	u32 atype = ua->addrtype;
@@ -726,7 +726,7 @@ static int tipc_bind(struct socket *sock, struct sockaddr *skaddr, int alen)
 			return -EACCES;
 		}
 	}
-	return tipc_sk_bind(sock, skaddr, alen);
+	return tipc_sk_bind(sock, (struct sockaddr *)skaddr, alen);
 }
 
 /**
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 768098dec231..c25dee3162ef 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -854,7 +854,7 @@ static int unix_listen(struct socket *sock, int backlog)
 }
 
 static int unix_release(struct socket *);
-static int unix_bind(struct socket *, struct sockaddr *, int);
+static int unix_bind(struct socket *, struct sockaddr_unspec *, int);
 static int unix_stream_connect(struct socket *, struct sockaddr *,
 			       int addr_len, int flags);
 static int unix_socketpair(struct socket *, struct socket *);
@@ -1477,7 +1477,7 @@ static int unix_bind_abstract(struct sock *sk, struct sockaddr_un *sunaddr,
 	return err;
 }
 
-static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+static int unix_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int addr_len)
 {
 	struct sockaddr_un *sunaddr = (struct sockaddr_un *)uaddr;
 	struct sock *sk = sock->sk;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 4c2db6cca557..0c52b0410d7b 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -987,7 +987,7 @@ static int vsock_release(struct socket *sock)
 }
 
 static int
-vsock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
+vsock_bind(struct socket *sock, struct sockaddr_unspec *addr, int addr_len)
 {
 	int err;
 	struct sock *sk;
@@ -995,7 +995,7 @@ vsock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 
 	sk = sock->sk;
 
-	if (vsock_addr_cast(addr, addr_len, &vm_addr) != 0)
+	if (vsock_addr_cast((struct sockaddr *)addr, addr_len, &vm_addr) != 0)
 		return -EINVAL;
 
 	lock_sock(sk);
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 655d1e0ae25f..b6a42ea0e3be 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -670,7 +670,7 @@ static int x25_release(struct socket *sock)
 	return 0;
 }
 
-static int x25_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+static int x25_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int addr_len)
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr_x25 *addr = (struct sockaddr_x25 *)uaddr;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7b0c68a70888..d4a3a51ca988 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1241,7 +1241,7 @@ static bool xsk_validate_queues(struct xdp_sock *xs)
 	return xs->fq_tmp && xs->cq_tmp;
 }
 
-static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
+static int xsk_bind(struct socket *sock, struct sockaddr_unspec *addr, int addr_len)
 {
 	struct sockaddr_xdp *sxdp = (struct sockaddr_xdp *)addr;
 	struct sock *sk = sock->sk;
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 8074bc5f6f20..341165915994 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -923,7 +923,7 @@ __bpf_kfunc int bpf_kfunc_call_kernel_bind(struct addr_args *args)
 		goto out;
 	}
 
-	err = kernel_bind(sock, (struct sockaddr *)&args->addr, args->addrlen);
+	err = kernel_bind(sock, (struct sockaddr_unspec *)&args->addr, args->addrlen);
 out:
 	mutex_unlock(&sock_lock);
 
-- 
2.34.1


