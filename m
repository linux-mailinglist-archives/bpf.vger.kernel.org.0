Return-Path: <bpf+bounces-72907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8352C1D7CA
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 22:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745D118916E5
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 21:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876583203AE;
	Wed, 29 Oct 2025 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz93ftrK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BB731A056;
	Wed, 29 Oct 2025 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774268; cv=none; b=IREeV0RKzRpp0Tp9C/eprER3ZSFpUCuLfeJ1L3RPlziCy8cUymuHzMSE0rbvWKcmfZ9iuBL+YFy27Ol8eVoH/DsUhBG6dhcJlHUyVK0dtITYIadT66pXAJmrNhnc8sATbJtBSz7105WOKVsMprs+EbETSRbjJ9OiintX+R30HY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774268; c=relaxed/simple;
	bh=ZbBOlFQuP1Bp2zCCApgX/HQ7KdMd1fQtbNwx/C1GUGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q1M1N0cM63bpNr/mEl/vlavV1IPg3Mo8uK+LDaq/kD3fSawNrYmQ1dzd+qOOjRBrVzmrhuhqKYDN3aeg60zpSjP19M+QK+BRkOL4DI1KswkgU/HRKCYlsAnODTjk6XL4PS6xWMjfjzbKS8a38yCf4dH+4QWqreQa775pDIdyT2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz93ftrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647D8C113D0;
	Wed, 29 Oct 2025 21:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761774268;
	bh=ZbBOlFQuP1Bp2zCCApgX/HQ7KdMd1fQtbNwx/C1GUGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sz93ftrKRykivX7JeTvAehTw/KfOsV5F1uSFlaLhQCSqMmdxH3xx+VekQDQd8XCaC
	 6LloPEE4W2jJ6c3EPQ6fdQYrBGpsCEqR2W19NjEMOprHaA5X2JBOxhMRsd8rtuEJDv
	 b69XwGJxhFTRAMfrX5Ll1ud1NEgrZadeK4sJ2oSFNcqyhd2bn87WoIrerZesxjZDBL
	 LEJ135pm7nLwNKK+weQdtxm240QUNHbmgB/9js8R/+sjdcMUvRKEoCD7GautxcFgR+
	 r4elm6n1q0jH1blSV5Yp6R5Dyun/QrUFoiI/HOnVFu8nDWu0TqnY8ehkozh5YiFoPl
	 apFYb7NrfhH/Q==
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
Subject: [net-next PATCH v4 2/7] net: Convert proto_ops connect() callbacks to use sockaddr_unsized
Date: Wed, 29 Oct 2025 14:43:59 -0700
Message-Id: <20251029214428.2467496-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029214355.work.602-kees@kernel.org>
References: <20251029214355.work.602-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=54119; i=kees@kernel.org; h=from:subject; bh=ZbBOlFQuP1Bp2zCCApgX/HQ7KdMd1fQtbNwx/C1GUGc=; b=owGbwMvMwCVmps19z/KJym7G02pJDJlMXQu5whfsEmHZsfuYc3G9QF/7irkZb+O2vn0y+erxU +8mTU451VHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjARiVuMDEvWZhibxa9bv3Pn +evFdj8dwyYJLLCbojtH7puk94v313UY/nu/3MY06bzFj/wvR9O+PL50W9xa9mLqHvWV5dw/Vk/ SLOcBAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Update all struct proto_ops connect() callback function prototypes from
"struct sockaddr *" to "struct sockaddr_unsized *" to avoid lying to the
compiler about object sizes. Calls into struct proto handlers gain casts
that will be removed in the struct proto conversion patch.

No binary changes expected.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/bpf-cgroup.h                         |  6 +++---
 include/linux/net.h                                |  4 ++--
 include/net/inet_common.h                          |  6 +++---
 include/net/sctp/sctp.h                            |  2 +-
 include/net/sock.h                                 |  2 +-
 include/net/vsock_addr.h                           |  2 +-
 net/smc/smc.h                                      |  2 +-
 drivers/block/drbd/drbd_receiver.c                 |  2 +-
 drivers/infiniband/hw/erdma/erdma_cm.c             |  2 +-
 drivers/infiniband/sw/siw/siw_cm.c                 |  2 +-
 drivers/net/ppp/pppoe.c                            |  4 ++--
 drivers/net/ppp/pptp.c                             |  4 ++--
 drivers/net/wireless/ath/ath10k/qmi.c              |  2 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |  2 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |  2 +-
 drivers/nvme/host/tcp.c                            |  2 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    |  2 +-
 drivers/xen/pvcalls-back.c                         |  2 +-
 fs/coredump.c                                      |  2 +-
 fs/dlm/lowcomms.c                                  |  2 +-
 fs/ocfs2/cluster/tcp.c                             |  2 +-
 fs/smb/client/connect.c                            |  2 +-
 net/9p/trans_fd.c                                  |  6 +++---
 net/appletalk/ddp.c                                |  2 +-
 net/atm/pvc.c                                      |  4 ++--
 net/atm/svc.c                                      |  2 +-
 net/ax25/af_ax25.c                                 |  2 +-
 net/bluetooth/iso.c                                |  2 +-
 net/bluetooth/l2cap_sock.c                         |  2 +-
 net/bluetooth/rfcomm/core.c                        |  2 +-
 net/bluetooth/rfcomm/sock.c                        |  3 ++-
 net/bluetooth/sco.c                                |  2 +-
 net/caif/caif_socket.c                             |  2 +-
 net/can/bcm.c                                      |  2 +-
 net/can/j1939/socket.c                             |  2 +-
 net/ceph/messenger.c                               |  2 +-
 net/core/sock.c                                    |  2 +-
 net/ieee802154/socket.c                            |  4 ++--
 net/ipv4/af_inet.c                                 | 14 +++++++-------
 net/ipv4/tcp.c                                     |  2 +-
 net/ipv4/udp_tunnel_core.c                         |  2 +-
 net/ipv6/ip6_udp_tunnel.c                          |  2 +-
 net/iucv/af_iucv.c                                 |  4 ++--
 net/l2tp/l2tp_core.c                               |  4 ++--
 net/l2tp/l2tp_ppp.c                                |  2 +-
 net/llc/af_llc.c                                   |  2 +-
 net/mctp/af_mctp.c                                 |  2 +-
 net/mctp/test/utils.c                              |  5 +++--
 net/mptcp/subflow.c                                |  2 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |  2 +-
 net/netlink/af_netlink.c                           |  2 +-
 net/netrom/af_netrom.c                             |  4 ++--
 net/nfc/llcp_sock.c                                |  2 +-
 net/nfc/rawsock.c                                  |  2 +-
 net/phonet/socket.c                                |  6 +++---
 net/qrtr/af_qrtr.c                                 |  2 +-
 net/rds/af_rds.c                                   |  2 +-
 net/rds/tcp_connect.c                              |  2 +-
 net/rose/af_rose.c                                 |  3 ++-
 net/rxrpc/af_rxrpc.c                               |  2 +-
 net/sctp/socket.c                                  |  4 ++--
 net/smc/af_smc.c                                   |  4 ++--
 net/socket.c                                       |  8 ++++----
 net/sunrpc/clnt.c                                  |  2 +-
 net/sunrpc/xprtsock.c                              |  5 +++--
 net/tipc/socket.c                                  |  2 +-
 net/unix/af_unix.c                                 |  8 ++++----
 net/vmw_vsock/af_vsock.c                           |  6 +++---
 net/vmw_vsock/vsock_addr.c                         |  2 +-
 net/x25/af_x25.c                                   |  2 +-
 samples/qmi/qmi_sample_client.c                    |  2 +-
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  2 +-
 72 files changed, 110 insertions(+), 106 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index aedf573bdb42..a7fb4f46974f 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -238,7 +238,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 ({									       \
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled(atype))					       \
-		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, uaddrlen, \
+		__ret = __cgroup_bpf_run_filter_sock_addr(sk, (struct sockaddr *)uaddr, uaddrlen, \
 							  atype, NULL, NULL);  \
 	__ret;								       \
 })
@@ -248,7 +248,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled(atype))	{				       \
 		lock_sock(sk);						       \
-		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, uaddrlen, \
+		__ret = __cgroup_bpf_run_filter_sock_addr(sk, (struct sockaddr *)uaddr, uaddrlen, \
 							  atype, t_ctx, NULL); \
 		release_sock(sk);					       \
 	}								       \
@@ -266,7 +266,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled(atype))	{				       \
 		lock_sock(sk);						       \
-		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, uaddrlen, \
+		__ret = __cgroup_bpf_run_filter_sock_addr(sk, (struct sockaddr *)uaddr, uaddrlen, \
 							  atype, NULL, &__flags); \
 		release_sock(sk);					       \
 		if (__flags & BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE)	       \
diff --git a/include/linux/net.h b/include/linux/net.h
index 0e316f063113..db6bc997ca5b 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -166,7 +166,7 @@ struct proto_ops {
 				      struct sockaddr_unsized *myaddr,
 				      int sockaddr_len);
 	int		(*connect)   (struct socket *sock,
-				      struct sockaddr *vaddr,
+				      struct sockaddr_unsized *vaddr,
 				      int sockaddr_len, int flags);
 	int		(*socketpair)(struct socket *sock1,
 				      struct socket *sock2);
@@ -348,7 +348,7 @@ int kernel_recvmsg(struct socket *sock, struct msghdr *msg, struct kvec *vec,
 int kernel_bind(struct socket *sock, struct sockaddr_unsized *addr, int addrlen);
 int kernel_listen(struct socket *sock, int backlog);
 int kernel_accept(struct socket *sock, struct socket **newsock, int flags);
-int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
+int kernel_connect(struct socket *sock, struct sockaddr_unsized *addr, int addrlen,
 		   int flags);
 int kernel_getsockname(struct socket *sock, struct sockaddr *addr);
 int kernel_getpeername(struct socket *sock, struct sockaddr *addr);
diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index 1666cf6f539e..ebafd96912bb 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -23,11 +23,11 @@ struct sockaddr;
 struct socket;
 
 int inet_release(struct socket *sock);
-int inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
+int inet_stream_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 			int addr_len, int flags);
-int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
+int __inet_stream_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 			  int addr_len, int flags, int is_sendmsg);
-int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
+int inet_dgram_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 		       int addr_len, int flags);
 int inet_accept(struct socket *sock, struct socket *newsock,
 		struct proto_accept_arg *arg);
diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index e96d1bd087f6..d3178a1542d0 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -85,7 +85,7 @@ void sctp_udp_sock_stop(struct net *net);
 /*
  * sctp/socket.c
  */
-int sctp_inet_connect(struct socket *sock, struct sockaddr *uaddr,
+int sctp_inet_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 		      int addr_len, int flags);
 int sctp_backlog_rcv(struct sock *sk, struct sk_buff *skb);
 int sctp_inet_listen(struct socket *sock, int backlog);
diff --git a/include/net/sock.h b/include/net/sock.h
index 3e0618514ce4..3e672a92560b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1902,7 +1902,7 @@ int sock_cmsg_send(struct sock *sk, struct msghdr *msg,
  * does not implement a particular function.
  */
 int sock_no_bind(struct socket *sock, struct sockaddr_unsized *saddr, int len);
-int sock_no_connect(struct socket *, struct sockaddr *, int, int);
+int sock_no_connect(struct socket *sock, struct sockaddr_unsized *saddr, int len, int flags);
 int sock_no_socketpair(struct socket *, struct socket *);
 int sock_no_accept(struct socket *, struct socket *, struct proto_accept_arg *);
 int sock_no_getname(struct socket *, struct sockaddr *, int);
diff --git a/include/net/vsock_addr.h b/include/net/vsock_addr.h
index cf8cc140d68d..c3f4cc206198 100644
--- a/include/net/vsock_addr.h
+++ b/include/net/vsock_addr.h
@@ -16,7 +16,7 @@ bool vsock_addr_bound(const struct sockaddr_vm *addr);
 void vsock_addr_unbind(struct sockaddr_vm *addr);
 bool vsock_addr_equals_addr(const struct sockaddr_vm *addr,
 			    const struct sockaddr_vm *other);
-int vsock_addr_cast(const struct sockaddr *addr, size_t len,
+int vsock_addr_cast(const struct sockaddr_unsized *addr, size_t len,
 		    struct sockaddr_vm **out_addr);
 
 #endif
diff --git a/net/smc/smc.h b/net/smc/smc.h
index a008dbe6d6f6..9e6af72784ba 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -44,7 +44,7 @@ void smc_release_cb(struct sock *sk);
 int smc_release(struct socket *sock);
 int smc_bind(struct socket *sock, struct sockaddr_unsized *uaddr,
 	     int addr_len);
-int smc_connect(struct socket *sock, struct sockaddr *addr,
+int smc_connect(struct socket *sock, struct sockaddr_unsized *addr,
 		int alen, int flags);
 int smc_accept(struct socket *sock, struct socket *new_sock,
 	       struct proto_accept_arg *arg);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index d9296f74f902..33bc91665fe8 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -458,7 +458,7 @@ static struct socket *drbd_try_connect(struct drbd_connection *connection)
 	 * stay C_WF_CONNECTION, don't go Disconnecting! */
 	disconnect_on_error = 0;
 	what = "connect";
-	err = sock->ops->connect(sock, (struct sockaddr *) &peer_in6, peer_addr_len, 0);
+	err = sock->ops->connect(sock, (struct sockaddr_unsized *) &peer_in6, peer_addr_len, 0);
 
 out:
 	if (err < 0) {
diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/hw/erdma/erdma_cm.c
index ef66a6359eb9..ed21ba0037a4 100644
--- a/drivers/infiniband/hw/erdma/erdma_cm.c
+++ b/drivers/infiniband/hw/erdma/erdma_cm.c
@@ -996,7 +996,7 @@ static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 	ret = s->ops->bind(s, (struct sockaddr_unsized *)laddr, laddrlen);
 	if (ret)
 		return ret;
-	ret = s->ops->connect(s, raddr, raddrlen, flags);
+	ret = s->ops->connect(s, (struct sockaddr_unsized *)raddr, raddrlen, flags);
 	return ret < 0 ? ret : 0;
 }
 
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 7fe118cacb3f..eb0bd4f79a85 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1344,7 +1344,7 @@ static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 	if (rv < 0)
 		return rv;
 
-	rv = s->ops->connect(s, raddr, size, flags);
+	rv = s->ops->connect(s, (struct sockaddr_unsized *)raddr, size, flags);
 
 	return rv < 0 ? rv : 0;
 }
diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 4ac6afce267b..4275b393a454 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -608,8 +608,8 @@ static int pppoe_release(struct socket *sock)
 	return 0;
 }
 
-static int pppoe_connect(struct socket *sock, struct sockaddr *uservaddr,
-		  int sockaddr_len, int flags)
+static int pppoe_connect(struct socket *sock, struct sockaddr_unsized *uservaddr,
+			 int sockaddr_len, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr_pppox *sp = (struct sockaddr_pppox *)uservaddr;
diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index d07e87a0974c..b18acd810561 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -415,8 +415,8 @@ static int pptp_bind(struct socket *sock, struct sockaddr_unsized *uservaddr,
 	return error;
 }
 
-static int pptp_connect(struct socket *sock, struct sockaddr *uservaddr,
-	int sockaddr_len, int flags)
+static int pptp_connect(struct socket *sock, struct sockaddr_unsized *uservaddr,
+			int sockaddr_len, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr_pppox *sp = (struct sockaddr_pppox *) uservaddr;
diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index f1f33af0170a..8275345631a0 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -986,7 +986,7 @@ static int ath10k_qmi_new_server(struct qmi_handle *qmi_hdl,
 
 	ath10k_dbg(ar, ATH10K_DBG_QMI, "wifi fw qmi service found\n");
 
-	ret = kernel_connect(qmi_hdl->sock, (struct sockaddr *)&qmi->sq,
+	ret = kernel_connect(qmi_hdl->sock, (struct sockaddr_unsized *)&qmi->sq,
 			     sizeof(qmi->sq), 0);
 	if (ret) {
 		ath10k_err(ar, "failed to connect to a remote QMI service port\n");
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index aea56c38bf8f..ff6a97e328b8 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -3177,7 +3177,7 @@ static int ath11k_qmi_ops_new_server(struct qmi_handle *qmi_hdl,
 	sq->sq_node = service->node;
 	sq->sq_port = service->port;
 
-	ret = kernel_connect(qmi_hdl->sock, (struct sockaddr *)sq,
+	ret = kernel_connect(qmi_hdl->sock, (struct sockaddr_unsized *)sq,
 			     sizeof(*sq), 0);
 	if (ret) {
 		ath11k_warn(ab, "failed to connect to qmi remote service: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 36325e62aa24..cf9c25df3ffd 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3740,7 +3740,7 @@ static int ath12k_qmi_ops_new_server(struct qmi_handle *qmi_hdl,
 	sq->sq_node = service->node;
 	sq->sq_port = service->port;
 
-	ret = kernel_connect(qmi_hdl->sock, (struct sockaddr *)sq,
+	ret = kernel_connect(qmi_hdl->sock, (struct sockaddr_unsized *)sq,
 			     sizeof(*sq), 0);
 	if (ret) {
 		ath12k_warn(ab, "qmi failed to connect to remote service %d\n", ret);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 35d0bd91f6fd..6795b8286c35 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1872,7 +1872,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	dev_dbg(nctrl->device, "connecting queue %d\n",
 			nvme_tcp_queue_id(queue));
 
-	ret = kernel_connect(queue->sock, (struct sockaddr *)&ctrl->addr,
+	ret = kernel_connect(queue->sock, (struct sockaddr_unsized *)&ctrl->addr,
 		sizeof(ctrl->addr), 0);
 	if (ret) {
 		dev_err(nctrl->device,
diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 4fb66986cc22..fdb94dc4a730 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -463,7 +463,7 @@ static int qcom_slim_qmi_init(struct qcom_slim_ngd_ctrl *ctrl,
 	}
 
 	rc = kernel_connect(handle->sock,
-				(struct sockaddr *)&ctrl->qmi.svc_info,
+				(struct sockaddr_unsized *)&ctrl->qmi.svc_info,
 				sizeof(ctrl->qmi.svc_info), 0);
 	if (rc < 0) {
 		dev_err(ctrl->dev, "Remote Service connect failed: %d\n", rc);
diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index da1b516b9cfd..c5b6f6fa11eb 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -409,7 +409,7 @@ static int pvcalls_back_connect(struct xenbus_device *dev,
 	ret = sock_create(AF_INET, SOCK_STREAM, 0, &sock);
 	if (ret < 0)
 		goto out;
-	ret = inet_stream_connect(sock, sa, req->u.connect.len, 0);
+	ret = inet_stream_connect(sock, (struct sockaddr_unsized *)sa, req->u.connect.len, 0);
 	if (ret < 0) {
 		sock_release(sock);
 		goto out;
diff --git a/fs/coredump.c b/fs/coredump.c
index 5c1c381ee380..14837d9e2abb 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -708,7 +708,7 @@ static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *
 	 */
 	pidfs_coredump(cprm);
 
-	retval = kernel_connect(socket, (struct sockaddr *)(&addr), addr_len,
+	retval = kernel_connect(socket, (struct sockaddr_unsized *)(&addr), addr_len,
 				O_NONBLOCK | SOCK_COREDUMP);
 
 	if (retval) {
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 0500421b6e3b..f832dafdaca8 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1599,7 +1599,7 @@ static int dlm_connect(struct connection *con)
 
 	log_print_ratelimited("connecting to %d", con->nodeid);
 	make_sockaddr(&addr, dlm_config.ci_tcp_port, &addr_len);
-	result = kernel_connect(sock, (struct sockaddr *)&addr, addr_len, 0);
+	result = kernel_connect(sock, (struct sockaddr_unsized *)&addr, addr_len, 0);
 	switch (result) {
 	case -EINPROGRESS:
 		/* not an error */
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index c7734193d8d7..79b281e32f4c 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1638,7 +1638,7 @@ static void o2net_start_connect(struct work_struct *work)
 	remoteaddr.sin_port = node->nd_ipv4_port;
 
 	ret = sc->sc_sock->ops->connect(sc->sc_sock,
-					(struct sockaddr *)&remoteaddr,
+					(struct sockaddr_unsized *)&remoteaddr,
 					sizeof(remoteaddr),
 					O_NONBLOCK);
 	if (ret == -EINPROGRESS)
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 96d972263020..73120988661a 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3411,7 +3411,7 @@ generic_ip_connect(struct TCP_Server_Info *server)
 		 socket->sk->sk_sndbuf,
 		 socket->sk->sk_rcvbuf, socket->sk->sk_rcvtimeo);
 
-	rc = kernel_connect(socket, saddr, slen,
+	rc = kernel_connect(socket, (struct sockaddr_unsized *)saddr, slen,
 			    server->noblockcnt ? O_NONBLOCK : 0);
 	/*
 	 * When mounting SMB root file systems, we do not want to block in
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index ef517bb307e2..49d674f5e73a 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -1018,7 +1018,7 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
 	}
 
 	err = READ_ONCE(csocket->ops)->connect(csocket,
-					       (struct sockaddr *)&stor,
+					       (struct sockaddr_unsized *)&stor,
 					       sizeof(stor), 0);
 	if (err < 0) {
 		pr_err("%s (%d): problem connecting socket to %s\n",
@@ -1058,8 +1058,8 @@ p9_fd_create_unix(struct p9_client *client, const char *addr, char *args)
 
 		return err;
 	}
-	err = READ_ONCE(csocket->ops)->connect(csocket, (struct sockaddr *)&sun_server,
-			sizeof(struct sockaddr_un) - 1, 0);
+	err = READ_ONCE(csocket->ops)->connect(csocket, (struct sockaddr_unsized *)&sun_server,
+					       sizeof(struct sockaddr_un) - 1, 0);
 	if (err < 0) {
 		pr_err("%s (%d): problem connecting socket: %s: %d\n",
 		       __func__, task_pid_nr(current), addr, err);
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 45db43cde67f..2a01fff46c9d 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1204,7 +1204,7 @@ static int atalk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int a
 }
 
 /* Set the address we talk to */
-static int atalk_connect(struct socket *sock, struct sockaddr *uaddr,
+static int atalk_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 			 int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/atm/pvc.c b/net/atm/pvc.c
index 62fdf07c53de..8f5e76f5dd9e 100644
--- a/net/atm/pvc.c
+++ b/net/atm/pvc.c
@@ -56,10 +56,10 @@ static int pvc_bind(struct socket *sock, struct sockaddr_unsized *sockaddr,
 	return error;
 }
 
-static int pvc_connect(struct socket *sock, struct sockaddr *sockaddr,
+static int pvc_connect(struct socket *sock, struct sockaddr_unsized *sockaddr,
 		       int sockaddr_len, int flags)
 {
-	return pvc_bind(sock, (struct sockaddr_unsized *)sockaddr, sockaddr_len);
+	return pvc_bind(sock, sockaddr, sockaddr_len);
 }
 
 static int pvc_setsockopt(struct socket *sock, int level, int optname,
diff --git a/net/atm/svc.c b/net/atm/svc.c
index 1906a493c8aa..005964250ecd 100644
--- a/net/atm/svc.c
+++ b/net/atm/svc.c
@@ -153,7 +153,7 @@ static int svc_bind(struct socket *sock, struct sockaddr_unsized *sockaddr,
 	return error;
 }
 
-static int svc_connect(struct socket *sock, struct sockaddr *sockaddr,
+static int svc_connect(struct socket *sock, struct sockaddr_unsized *sockaddr,
 		       int sockaddr_len, int flags)
 {
 	DEFINE_WAIT(wait);
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 23c558ff9682..7ebbff2f0020 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -1175,7 +1175,7 @@ static int ax25_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int ad
  *	FIXME: nonblock behaviour looks like it may have a bug.
  */
 static int __must_check ax25_connect(struct socket *sock,
-	struct sockaddr *uaddr, int addr_len, int flags)
+	struct sockaddr_unsized *uaddr, int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
 	ax25_cb *ax25 = sk_to_ax25(sk), *ax25t;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 1fda214a815d..58cc835fec3b 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1080,7 +1080,7 @@ static int iso_sock_bind(struct socket *sock, struct sockaddr_unsized *addr,
 	return err;
 }
 
-static int iso_sock_connect(struct socket *sock, struct sockaddr *addr,
+static int iso_sock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 			    int alen, int flags)
 {
 	struct sockaddr_iso *sa = (struct sockaddr_iso *)addr;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ca7394d8fa4e..9ee189c815d4 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -178,7 +178,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr_unsized *addr, i
 	return err;
 }
 
-static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
+static int l2cap_sock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 			      int alen, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d62fd6c57617..57b1dca8141f 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -808,7 +808,7 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 	addr.l2_psm    = cpu_to_le16(L2CAP_PSM_RFCOMM);
 	addr.l2_cid    = 0;
 	addr.l2_bdaddr_type = BDADDR_BREDR;
-	*err = kernel_connect(sock, (struct sockaddr *) &addr, sizeof(addr), O_NONBLOCK);
+	*err = kernel_connect(sock, (struct sockaddr_unsized *)&addr, sizeof(addr), O_NONBLOCK);
 	if (*err == 0 || *err == -EINPROGRESS)
 		return s;
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 8c8762bbc6de..be6639cd6f59 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -371,7 +371,8 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr_unsized *addr,
 	return err;
 }
 
-static int rfcomm_sock_connect(struct socket *sock, struct sockaddr *addr, int alen, int flags)
+static int rfcomm_sock_connect(struct socket *sock, struct sockaddr_unsized *addr,
+			       int alen, int flags)
 {
 	struct sockaddr_rc *sa = (struct sockaddr_rc *) addr;
 	struct sock *sk = sock->sk;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 01d878205e58..7afe65e7ff37 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -639,7 +639,7 @@ static int sco_sock_bind(struct socket *sock, struct sockaddr_unsized *addr,
 	return err;
 }
 
-static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen, int flags)
+static int sco_sock_connect(struct socket *sock, struct sockaddr_unsized *addr, int alen, int flags)
 {
 	struct sockaddr_sco *sa = (struct sockaddr_sco *) addr;
 	struct sock *sk = sock->sk;
diff --git a/net/caif/caif_socket.c b/net/caif/caif_socket.c
index 039dfbd367c9..af218742af5a 100644
--- a/net/caif/caif_socket.c
+++ b/net/caif/caif_socket.c
@@ -734,7 +734,7 @@ static int setsockopt(struct socket *sock, int lvl, int opt, sockptr_t ov,
  *  o sock->state: holds the SS_* socket state and is updated by connect and
  *	disconnect.
  */
-static int caif_connect(struct socket *sock, struct sockaddr *uaddr,
+static int caif_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 			int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 5e690a2377e4..7eba8ae01a5b 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1657,7 +1657,7 @@ static int bcm_release(struct socket *sock)
 	return 0;
 }
 
-static int bcm_connect(struct socket *sock, struct sockaddr *uaddr, int len,
+static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int len,
 		       int flags)
 {
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index a2abedc757d0..6272326dd614 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -535,7 +535,7 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, in
 	return ret;
 }
 
-static int j1939_sk_connect(struct socket *sock, struct sockaddr *uaddr,
+static int j1939_sk_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 			    int len, int flags)
 {
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index f8181acaf870..70b25f4ecba6 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -460,7 +460,7 @@ int ceph_tcp_connect(struct ceph_connection *con)
 	set_sock_callbacks(sock, con);
 
 	con_sock_state_connecting(con);
-	ret = kernel_connect(sock, (struct sockaddr *)&ss, sizeof(ss),
+	ret = kernel_connect(sock, (struct sockaddr_unsized *)&ss, sizeof(ss),
 			     O_NONBLOCK);
 	if (ret == -EINPROGRESS) {
 		dout("connect %s EINPROGRESS sk_state = %u\n",
diff --git a/net/core/sock.c b/net/core/sock.c
index 6c8d50338f71..e6e38b6b6b33 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3426,7 +3426,7 @@ int sock_no_bind(struct socket *sock, struct sockaddr_unsized *saddr, int len)
 }
 EXPORT_SYMBOL(sock_no_bind);
 
-int sock_no_connect(struct socket *sock, struct sockaddr *saddr,
+int sock_no_connect(struct socket *sock, struct sockaddr_unsized *saddr,
 		    int len, int flags)
 {
 	return -EOPNOTSUPP;
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 99ddfad9bb88..b93fd85f248a 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -107,7 +107,7 @@ static int ieee802154_sock_bind(struct socket *sock, struct sockaddr_unsized *ua
 	return sock_no_bind(sock, uaddr, addr_len);
 }
 
-static int ieee802154_sock_connect(struct socket *sock, struct sockaddr *uaddr,
+static int ieee802154_sock_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 				   int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
@@ -118,7 +118,7 @@ static int ieee802154_sock_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (uaddr->sa_family == AF_UNSPEC)
 		return sk->sk_prot->disconnect(sk, flags);
 
-	return sk->sk_prot->connect(sk, uaddr, addr_len);
+	return sk->sk_prot->connect(sk, (struct sockaddr *)uaddr, addr_len);
 }
 
 static int ieee802154_dev_ioctl(struct sock *sk, struct ifreq __user *arg,
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index e70126c5ae44..3421a2d30845 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -567,7 +567,7 @@ int __inet_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 	return err;
 }
 
-int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
+int inet_dgram_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 		       int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
@@ -584,14 +584,14 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
 		return prot->disconnect(sk, flags);
 
 	if (BPF_CGROUP_PRE_CONNECT_ENABLED(sk)) {
-		err = prot->pre_connect(sk, uaddr, addr_len);
+		err = prot->pre_connect(sk, (struct sockaddr *)uaddr, addr_len);
 		if (err)
 			return err;
 	}
 
 	if (data_race(!inet_sk(sk)->inet_num) && inet_autobind(sk))
 		return -EAGAIN;
-	return prot->connect(sk, uaddr, addr_len);
+	return prot->connect(sk, (struct sockaddr *)uaddr, addr_len);
 }
 EXPORT_SYMBOL(inet_dgram_connect);
 
@@ -623,7 +623,7 @@ static long inet_wait_for_connect(struct sock *sk, long timeo, int writebias)
  *	Connect to a remote host. There is regrettably still a little
  *	TCP 'magic' in here.
  */
-int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
+int __inet_stream_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 			  int addr_len, int flags, int is_sendmsg)
 {
 	struct sock *sk = sock->sk;
@@ -671,12 +671,12 @@ int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 			goto out;
 
 		if (BPF_CGROUP_PRE_CONNECT_ENABLED(sk)) {
-			err = sk->sk_prot->pre_connect(sk, uaddr, addr_len);
+			err = sk->sk_prot->pre_connect(sk, (struct sockaddr *)uaddr, addr_len);
 			if (err)
 				goto out;
 		}
 
-		err = sk->sk_prot->connect(sk, uaddr, addr_len);
+		err = sk->sk_prot->connect(sk, (struct sockaddr *)uaddr, addr_len);
 		if (err < 0)
 			goto out;
 
@@ -741,7 +741,7 @@ int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 }
 EXPORT_SYMBOL(__inet_stream_connect);
 
-int inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
+int inet_stream_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 			int addr_len, int flags)
 {
 	int err;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8a18aeca7ab0..8f089f92522b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1062,7 +1062,7 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 		}
 	}
 	flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
-	err = __inet_stream_connect(sk->sk_socket, uaddr,
+	err = __inet_stream_connect(sk->sk_socket, (struct sockaddr_unsized *)uaddr,
 				    msg->msg_namelen, flags, 1);
 	/* fastopen_req could already be freed in __inet_stream_connect
 	 * if the connection times out or gets rst
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 11e5a88c923d..b1f667c52cb2 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -38,7 +38,7 @@ int udp_sock_create4(struct net *net, struct udp_port_cfg *cfg,
 		udp_addr.sin_family = AF_INET;
 		udp_addr.sin_addr = cfg->peer_ip;
 		udp_addr.sin_port = cfg->peer_udp_port;
-		err = kernel_connect(sock, (struct sockaddr *)&udp_addr,
+		err = kernel_connect(sock, (struct sockaddr_unsized *)&udp_addr,
 				     sizeof(udp_addr), 0);
 		if (err < 0)
 			goto error;
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index b0d9286b33c8..cef3e0210744 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -52,7 +52,7 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 		       sizeof(udp6_addr.sin6_addr));
 		udp6_addr.sin6_port = cfg->peer_udp_port;
 		err = kernel_connect(sock,
-				     (struct sockaddr *)&udp6_addr,
+				     (struct sockaddr_unsized *)&udp6_addr,
 				     sizeof(udp6_addr), 0);
 	}
 	if (err < 0)
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 894c53317e92..57467037014a 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -667,7 +667,7 @@ static int iucv_sock_autobind(struct sock *sk)
 	return err;
 }
 
-static int afiucv_path_connect(struct socket *sock, struct sockaddr *addr)
+static int afiucv_path_connect(struct socket *sock, struct sockaddr_unsized *addr)
 {
 	DECLARE_SOCKADDR(struct sockaddr_iucv *, sa, addr);
 	struct sock *sk = sock->sk;
@@ -713,7 +713,7 @@ static int afiucv_path_connect(struct socket *sock, struct sockaddr *addr)
 }
 
 /* Connect an unconnected socket */
-static int iucv_sock_connect(struct socket *sock, struct sockaddr *addr,
+static int iucv_sock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 			     int alen, int flags)
 {
 	DECLARE_SOCKADDR(struct sockaddr_iucv *, sa, addr);
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 4b5e372a5cd4..c4f4a57cd67c 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1513,7 +1513,7 @@ static int l2tp_tunnel_sock_create(struct net *net,
 			       sizeof(ip6_addr.l2tp_addr));
 			ip6_addr.l2tp_conn_id = peer_tunnel_id;
 			err = kernel_connect(sock,
-					     (struct sockaddr *)&ip6_addr,
+					     (struct sockaddr_unsized *)&ip6_addr,
 					     sizeof(ip6_addr), 0);
 			if (err < 0)
 				goto out;
@@ -1538,7 +1538,7 @@ static int l2tp_tunnel_sock_create(struct net *net,
 			ip_addr.l2tp_family = AF_INET;
 			ip_addr.l2tp_addr = cfg->peer_ip;
 			ip_addr.l2tp_conn_id = peer_tunnel_id;
-			err = kernel_connect(sock, (struct sockaddr *)&ip_addr,
+			err = kernel_connect(sock, (struct sockaddr_unsized *)&ip_addr,
 					     sizeof(ip_addr), 0);
 			if (err < 0)
 				goto out;
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 5e12e7ce17d8..ae4543d5597b 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -684,7 +684,7 @@ static struct l2tp_tunnel *pppol2tp_tunnel_get(struct net *net,
 
 /* connect() handler. Attach a PPPoX socket to a tunnel UDP socket
  */
-static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
+static int pppol2tp_connect(struct socket *sock, struct sockaddr_unsized *uservaddr,
 			    int sockaddr_len, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index e5bb0c0d708c..59d593bb5d18 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -477,7 +477,7 @@ static int llc_ui_shutdown(struct socket *sock, int how)
  *	This function will autobind if user did not previously call bind.
  *	Returns: 0 upon success, negative otherwise.
  */
-static int llc_ui_connect(struct socket *sock, struct sockaddr *uaddr,
+static int llc_ui_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 			  int addrlen, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 5b1ef50637b7..209a963112e3 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -128,7 +128,7 @@ static int mctp_bind(struct socket *sock, struct sockaddr_unsized *addr, int add
 /* Used to set a specific peer prior to bind. Not used for outbound
  * connections (Tag Owner set) since MCTP is a datagram protocol.
  */
-static int mctp_connect(struct socket *sock, struct sockaddr *addr,
+static int mctp_connect(struct socket *sock, struct sockaddr_unsized *addr,
 			int addrlen, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/mctp/test/utils.c b/net/mctp/test/utils.c
index 953d41902771..35f6be814567 100644
--- a/net/mctp/test/utils.c
+++ b/net/mctp/test/utils.c
@@ -279,7 +279,7 @@ void mctp_test_bind_run(struct kunit *test,
 		addr.smctp_addr.s_addr = setup->peer_addr;
 		/* connect() type must match bind() type */
 		addr.smctp_type = setup->bind_type;
-		rc = kernel_connect(*sock, (struct sockaddr *)&addr,
+		rc = kernel_connect(*sock, (struct sockaddr_unsized *)&addr,
 				    sizeof(addr), 0);
 		KUNIT_EXPECT_EQ(test, rc, 0);
 	}
@@ -292,5 +292,6 @@ void mctp_test_bind_run(struct kunit *test,
 	addr.smctp_type = setup->bind_type;
 
 	*ret_bind_errno =
-		kernel_bind(*sock, (struct sockaddr *)&addr, sizeof(addr));
+		kernel_bind(*sock, (struct sockaddr_unsized *)&addr,
+			    sizeof(addr));
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d90237bf433c..30961b3d1702 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1680,7 +1680,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 
 	sock_hold(ssk);
 	list_add_tail(&subflow->node, &msk->conn_list);
-	err = kernel_connect(sf, (struct sockaddr *)&addr, addrlen, O_NONBLOCK);
+	err = kernel_connect(sf, (struct sockaddr_unsized *)&addr, addrlen, O_NONBLOCK);
 	if (err && err != -EINPROGRESS) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTXCONNECTERR);
 		pr_debug("msk=%p local=%d remote=%d connect error: %d\n",
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index d8c089ef387c..5a0c6f42bd8f 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1501,7 +1501,7 @@ static int make_send_sock(struct netns_ipvs *ipvs, int id,
 	}
 
 	get_mcast_sockaddr(&mcast_addr, &salen, &ipvs->mcfg, id);
-	result = kernel_connect(sock, (struct sockaddr *)&mcast_addr,
+	result = kernel_connect(sock, (struct sockaddr_unsized *)&mcast_addr,
 				salen, 0);
 	if (result < 0) {
 		pr_err("Error connecting to the multicast addr\n");
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index b4110994776d..ee95b2c4f0c3 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1056,7 +1056,7 @@ static int netlink_bind(struct socket *sock, struct sockaddr_unsized *addr,
 	return err;
 }
 
-static int netlink_connect(struct socket *sock, struct sockaddr *addr,
+static int netlink_connect(struct socket *sock, struct sockaddr_unsized *addr,
 			   int alen, int flags)
 {
 	int err = 0;
diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 33468124d53d..5ed1a71ceec1 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -632,8 +632,8 @@ static int nr_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr
 	return 0;
 }
 
-static int nr_connect(struct socket *sock, struct sockaddr *uaddr,
-	int addr_len, int flags)
+static int nr_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
+		      int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct nr_sock *nr = nr_sk(sk);
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 26e6ceb48a82..f1be1e84f665 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -648,7 +648,7 @@ static int llcp_sock_release(struct socket *sock)
 	return err;
 }
 
-static int llcp_sock_connect(struct socket *sock, struct sockaddr *_addr,
+static int llcp_sock_connect(struct socket *sock, struct sockaddr_unsized *_addr,
 			     int len, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/nfc/rawsock.c b/net/nfc/rawsock.c
index 5125392bb68e..b049022399ae 100644
--- a/net/nfc/rawsock.c
+++ b/net/nfc/rawsock.c
@@ -73,7 +73,7 @@ static int rawsock_release(struct socket *sock)
 	return 0;
 }
 
-static int rawsock_connect(struct socket *sock, struct sockaddr *_addr,
+static int rawsock_connect(struct socket *sock, struct sockaddr_unsized *_addr,
 			   int len, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/phonet/socket.c b/net/phonet/socket.c
index 478b02647733..9391378083a4 100644
--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -214,8 +214,8 @@ static int pn_socket_autobind(struct socket *sock)
 	return 0; /* socket was already bound */
 }
 
-static int pn_socket_connect(struct socket *sock, struct sockaddr *addr,
-		int len, int flags)
+static int pn_socket_connect(struct socket *sock, struct sockaddr_unsized *addr,
+			     int len, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct pn_sock *pn = pn_sk(sk);
@@ -252,7 +252,7 @@ static int pn_socket_connect(struct socket *sock, struct sockaddr *addr,
 	pn->resource = pn_sockaddr_get_resource(spn);
 	sock->state = SS_CONNECTING;
 
-	err = sk->sk_prot->connect(sk, addr, len);
+	err = sk->sk_prot->connect(sk, (struct sockaddr *)addr, len);
 	if (err) {
 		sock->state = SS_UNCONNECTED;
 		pn->dobject = 0;
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 00bd3dd9f0f9..dab839f61ee9 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -1084,7 +1084,7 @@ static int qrtr_recvmsg(struct socket *sock, struct msghdr *msg,
 	return rc;
 }
 
-static int qrtr_connect(struct socket *sock, struct sockaddr *saddr,
+static int qrtr_connect(struct socket *sock, struct sockaddr_unsized *saddr,
 			int len, int flags)
 {
 	DECLARE_SOCKADDR(struct sockaddr_qrtr *, addr, saddr);
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 4a7217fbeab6..b396c673dfaf 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -533,7 +533,7 @@ static int rds_getsockopt(struct socket *sock, int level, int optname,
 
 }
 
-static int rds_connect(struct socket *sock, struct sockaddr *uaddr,
+static int rds_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 		       int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index 1eff3b03ab77..92891b0d224d 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -173,7 +173,7 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 	 * own the socket
 	 */
 	rds_tcp_set_callbacks(sock, cp);
-	ret = kernel_connect(sock, addr, addrlen, O_NONBLOCK);
+	ret = kernel_connect(sock, (struct sockaddr_unsized *)addr, addrlen, O_NONBLOCK);
 
 	rdsdebug("connect to address %pI6c returned %d\n", &conn->c_faddr, ret);
 	if (ret == -EINPROGRESS)
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 47369eab5aec..fd67494f2815 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -765,7 +765,8 @@ static int rose_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int ad
 	return err;
 }
 
-static int rose_connect(struct socket *sock, struct sockaddr *uaddr, int addr_len, int flags)
+static int rose_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len,
+			int flags)
 {
 	struct sock *sk = sock->sk;
 	struct rose_sock *rose = rose_sk(sk);
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 245f37a74394..0c2c68c4b07e 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -481,7 +481,7 @@ EXPORT_SYMBOL(rxrpc_kernel_set_notifications);
  * - this just targets it at a specific destination; no actual connection
  *   negotiation takes place
  */
-static int rxrpc_connect(struct socket *sock, struct sockaddr *addr,
+static int rxrpc_connect(struct socket *sock, struct sockaddr_unsized *addr,
 			 int addr_len, int flags)
 {
 	struct sockaddr_rxrpc *srx = (struct sockaddr_rxrpc *)addr;
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index ed8293a34240..a3d7607c1c7a 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4822,7 +4822,7 @@ static int sctp_connect(struct sock *sk, struct sockaddr *addr,
 	return err;
 }
 
-int sctp_inet_connect(struct socket *sock, struct sockaddr *uaddr,
+int sctp_inet_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 		      int addr_len, int flags)
 {
 	if (addr_len < sizeof(uaddr->sa_family))
@@ -4831,7 +4831,7 @@ int sctp_inet_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (uaddr->sa_family == AF_UNSPEC)
 		return -EOPNOTSUPP;
 
-	return sctp_connect(sock->sk, uaddr, addr_len, flags);
+	return sctp_connect(sock->sk, (struct sockaddr *)uaddr, addr_len, flags);
 }
 
 /* Only called when shutdown a listening SCTP socket. */
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 60cc812ce633..367eb97841f6 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1642,7 +1642,7 @@ static void smc_connect_work(struct work_struct *work)
 	release_sock(&smc->sk);
 }
 
-int smc_connect(struct socket *sock, struct sockaddr *addr,
+int smc_connect(struct socket *sock, struct sockaddr_unsized *addr,
 		int alen, int flags)
 {
 	struct sock *sk = sock->sk;
@@ -1694,7 +1694,7 @@ int smc_connect(struct socket *sock, struct sockaddr *addr,
 		rc = -EALREADY;
 		goto out;
 	}
-	rc = kernel_connect(smc->clcsock, addr, alen, flags);
+	rc = kernel_connect(smc->clcsock, (struct sockaddr_unsized *)addr, alen, flags);
 	if (rc && rc != -EINPROGRESS)
 		goto out;
 
diff --git a/net/socket.c b/net/socket.c
index aaefb2e519a7..101a7ed574e7 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2099,8 +2099,8 @@ int __sys_connect_file(struct file *file, struct sockaddr_storage *address,
 	if (err)
 		goto out;
 
-	err = READ_ONCE(sock->ops)->connect(sock, (struct sockaddr *)address,
-				addrlen, sock->file->f_flags | file_flags);
+	err = READ_ONCE(sock->ops)->connect(sock, (struct sockaddr_unsized *)address,
+					    addrlen, sock->file->f_flags | file_flags);
 out:
 	return err;
 }
@@ -3662,14 +3662,14 @@ EXPORT_SYMBOL(kernel_accept);
  *	Returns 0 or an error code.
  */
 
-int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
+int kernel_connect(struct socket *sock, struct sockaddr_unsized *addr, int addrlen,
 		   int flags)
 {
 	struct sockaddr_storage address;
 
 	memcpy(&address, addr, addrlen);
 
-	return READ_ONCE(sock->ops)->connect(sock, (struct sockaddr *)&address,
+	return READ_ONCE(sock->ops)->connect(sock, (struct sockaddr_unsized *)&address,
 					     addrlen, flags);
 }
 EXPORT_SYMBOL(kernel_connect);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 318ee24ad900..58442ae1c2da 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1474,7 +1474,7 @@ static int rpc_sockname(struct net *net, struct sockaddr *sap, size_t salen,
 		goto out_release;
 	}
 
-	err = kernel_connect(sock, sap, salen, 0);
+	err = kernel_connect(sock, (struct sockaddr_unsized *)sap, salen, 0);
 	if (err < 0) {
 		dprintk("RPC:       can't connect UDP socket (%d)\n", err);
 		goto out_release;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 95732a45b059..2e1fe6013361 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2005,7 +2005,7 @@ static int xs_local_finish_connecting(struct rpc_xprt *xprt,
 
 	xs_stream_start_connect(transport);
 
-	return kernel_connect(sock, xs_addr(xprt), xprt->addrlen, 0);
+	return kernel_connect(sock, (struct sockaddr_unsized *)xs_addr(xprt), xprt->addrlen, 0);
 }
 
 /**
@@ -2405,7 +2405,8 @@ static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 
 	/* Tell the socket layer to start connecting... */
 	set_bit(XPRT_SOCK_CONNECTING, &transport->sock_state);
-	return kernel_connect(sock, xs_addr(xprt), xprt->addrlen, O_NONBLOCK);
+	return kernel_connect(sock, (struct sockaddr_unsized *)xs_addr(xprt),
+			      xprt->addrlen, O_NONBLOCK);
 }
 
 /**
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 14f75ee88ddf..767f943e331d 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2565,7 +2565,7 @@ static bool tipc_sockaddr_is_sane(struct sockaddr_tipc *addr)
  *
  * Return: 0 on success, errno otherwise
  */
-static int tipc_connect(struct socket *sock, struct sockaddr *dest,
+static int tipc_connect(struct socket *sock, struct sockaddr_unsized *dest,
 			int destlen, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 8e92d63fa95b..2743e68d129a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -855,7 +855,7 @@ static int unix_listen(struct socket *sock, int backlog)
 
 static int unix_release(struct socket *);
 static int unix_bind(struct socket *, struct sockaddr_unsized *, int);
-static int unix_stream_connect(struct socket *, struct sockaddr *,
+static int unix_stream_connect(struct socket *, struct sockaddr_unsized *,
 			       int addr_len, int flags);
 static int unix_socketpair(struct socket *, struct socket *);
 static int unix_accept(struct socket *, struct socket *, struct proto_accept_arg *arg);
@@ -877,7 +877,7 @@ static int unix_dgram_sendmsg(struct socket *, struct msghdr *, size_t);
 static int unix_dgram_recvmsg(struct socket *, struct msghdr *, size_t, int);
 static int unix_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
 static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
-static int unix_dgram_connect(struct socket *, struct sockaddr *,
+static int unix_dgram_connect(struct socket *, struct sockaddr_unsized *,
 			      int, int);
 static int unix_seqpacket_sendmsg(struct socket *, struct msghdr *, size_t);
 static int unix_seqpacket_recvmsg(struct socket *, struct msghdr *, size_t,
@@ -1523,7 +1523,7 @@ static void unix_state_double_unlock(struct sock *sk1, struct sock *sk2)
 	unix_state_unlock(sk2);
 }
 
-static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
+static int unix_dgram_connect(struct socket *sock, struct sockaddr_unsized *addr,
 			      int alen, int flags)
 {
 	struct sockaddr_un *sunaddr = (struct sockaddr_un *)addr;
@@ -1642,7 +1642,7 @@ static long unix_wait_for_peer(struct sock *other, long timeo)
 	return timeo;
 }
 
-static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
+static int unix_stream_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 			       int addr_len, int flags)
 {
 	struct sockaddr_un *sunaddr = (struct sockaddr_un *)uaddr;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index fca26e279845..12e57ca93a04 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -995,7 +995,7 @@ vsock_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr_len)
 
 	sk = sock->sk;
 
-	if (vsock_addr_cast((struct sockaddr *)addr, addr_len, &vm_addr) != 0)
+	if (vsock_addr_cast(addr, addr_len, &vm_addr) != 0)
 		return -EINVAL;
 
 	lock_sock(sk);
@@ -1328,7 +1328,7 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 }
 
 static int vsock_dgram_connect(struct socket *sock,
-			       struct sockaddr *addr, int addr_len, int flags)
+			       struct sockaddr_unsized *addr, int addr_len, int flags)
 {
 	int err;
 	struct sock *sk;
@@ -1528,7 +1528,7 @@ static void vsock_connect_timeout(struct work_struct *work)
 	sock_put(sk);
 }
 
-static int vsock_connect(struct socket *sock, struct sockaddr *addr,
+static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 			 int addr_len, int flags)
 {
 	int err;
diff --git a/net/vmw_vsock/vsock_addr.c b/net/vmw_vsock/vsock_addr.c
index 223b9660a759..a986aa6fff9b 100644
--- a/net/vmw_vsock/vsock_addr.c
+++ b/net/vmw_vsock/vsock_addr.c
@@ -57,7 +57,7 @@ bool vsock_addr_equals_addr(const struct sockaddr_vm *addr,
 }
 EXPORT_SYMBOL_GPL(vsock_addr_equals_addr);
 
-int vsock_addr_cast(const struct sockaddr *addr,
+int vsock_addr_cast(const struct sockaddr_unsized *addr,
 		    size_t len, struct sockaddr_vm **out_addr)
 {
 	if (len < sizeof(**out_addr))
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index ca8006d8f792..af8762b24039 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -743,7 +743,7 @@ static int x25_wait_for_connection_establishment(struct sock *sk)
 	return rc;
 }
 
-static int x25_connect(struct socket *sock, struct sockaddr *uaddr,
+static int x25_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 		       int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/samples/qmi/qmi_sample_client.c b/samples/qmi/qmi_sample_client.c
index b27d861f354f..d1814582319b 100644
--- a/samples/qmi/qmi_sample_client.c
+++ b/samples/qmi/qmi_sample_client.c
@@ -468,7 +468,7 @@ static int qmi_sample_probe(struct platform_device *pdev)
 		return ret;
 
 	sq = dev_get_platdata(&pdev->dev);
-	ret = kernel_connect(sample->qmi.sock, (struct sockaddr *)sq,
+	ret = kernel_connect(sample->qmi.sock, (struct sockaddr_unsized *)sq,
 			     sizeof(*sq), 0);
 	if (ret < 0) {
 		pr_err("failed to connect to remote service port\n");
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 0497b5dea25c..8eeebaa951f0 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -900,7 +900,7 @@ __bpf_kfunc int bpf_kfunc_call_kernel_connect(struct addr_args *args)
 		goto out;
 	}
 
-	err = kernel_connect(sock, (struct sockaddr *)&args->addr,
+	err = kernel_connect(sock, (struct sockaddr_unsized *)&args->addr,
 			     args->addrlen, 0);
 out:
 	mutex_unlock(&sock_lock);
-- 
2.34.1


