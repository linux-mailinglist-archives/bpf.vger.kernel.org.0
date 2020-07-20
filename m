Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F30225F50
	for <lists+bpf@lfdr.de>; Mon, 20 Jul 2020 14:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgGTMtI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jul 2020 08:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbgGTMtE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jul 2020 08:49:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CDDC061794;
        Mon, 20 Jul 2020 05:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1rnPvvPPecmSNTNnxYXIswE+KjAHjGp1wPZw9d1lRuE=; b=IFMqt8wlpOji34hocDEPM6oed0
        pvd6FCQxTDtRIlVnyQpR7z6BtMiOeI4twLsXMlluYfYJAF21LBZzmJw+y6h+1yBhV71TpMhE3XQK2
        Boy2R++HB6bXj6P6VxIAXYPajjp19GwTH3AQtY0rUg7XQkfFQEe9IRSdecu2MXCuy0i8CzLCJMPS/
        eestCvCbndy2CkSkBc1PCkpauY7Ow/OWi86eAEHYDkyg15ky1xxm9vTCOrd3Z2tmPbiUcbqhM/T55
        SeGLz3R/YXhDiPpD8SVVpCWXv35NPIsDQzhRkb1MI+P17fE2XiEnXtd9DXnei0uhaClMC9sxnLmZ+
        qFdVS77Q==;
Received: from [2001:4bb8:105:4a81:2a8f:15b1:2c3:7be7] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxVDp-0004fB-Uz; Mon, 20 Jul 2020 12:48:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Eric Dumazet <edumazet@google.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, bridge@lists.linux-foundation.org,
        linux-can@vger.kernel.org, dccp@vger.kernel.org,
        linux-decnet-user@lists.sourceforge.net,
        linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org,
        mptcp@lists.01.org, lvs-devel@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-afs@lists.infradead.org,
        tipc-discussion@lists.sourceforge.net, linux-x25@vger.kernel.org
Subject: [PATCH 24/24] net: pass a sockptr_t into ->setsockopt
Date:   Mon, 20 Jul 2020 14:47:37 +0200
Message-Id: <20200720124737.118617-25-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720124737.118617-1-hch@lst.de>
References: <20200720124737.118617-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rework the remaining setsockopt code to pass a sockptr_t instead of a
plain user pointer.  This removes the last remaining set_fs(KERNEL_DS)
outside of architecture specific code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 crypto/af_alg.c                           |  7 ++--
 drivers/crypto/chelsio/chtls/chtls_main.c | 18 ++++++-----
 drivers/isdn/mISDN/socket.c               |  4 +--
 include/linux/net.h                       |  4 ++-
 include/net/inet_connection_sock.h        |  3 +-
 include/net/ip.h                          |  2 +-
 include/net/ipv6.h                        |  4 +--
 include/net/sctp/structs.h                |  2 +-
 include/net/sock.h                        |  4 +--
 include/net/tcp.h                         |  4 +--
 net/atm/common.c                          |  6 ++--
 net/atm/common.h                          |  2 +-
 net/atm/pvc.c                             |  2 +-
 net/atm/svc.c                             |  6 ++--
 net/ax25/af_ax25.c                        |  6 ++--
 net/bluetooth/hci_sock.c                  |  8 ++---
 net/bluetooth/l2cap_sock.c                | 22 ++++++-------
 net/bluetooth/rfcomm/sock.c               | 12 ++++---
 net/bluetooth/sco.c                       |  6 ++--
 net/caif/caif_socket.c                    |  8 ++---
 net/can/j1939/socket.c                    | 12 +++----
 net/can/raw.c                             | 16 +++++-----
 net/core/sock.c                           |  2 +-
 net/dccp/dccp.h                           |  2 +-
 net/dccp/proto.c                          | 20 ++++++------
 net/decnet/af_decnet.c                    | 16 ++++++----
 net/ieee802154/socket.c                   |  6 ++--
 net/ipv4/ip_sockglue.c                    | 13 +++-----
 net/ipv4/raw.c                            |  8 ++---
 net/ipv4/tcp.c                            |  5 ++-
 net/ipv4/udp.c                            |  6 ++--
 net/ipv4/udp_impl.h                       |  4 +--
 net/ipv6/ipv6_sockglue.c                  | 10 +++---
 net/ipv6/raw.c                            | 10 +++---
 net/ipv6/udp.c                            |  6 ++--
 net/ipv6/udp_impl.h                       |  4 +--
 net/iucv/af_iucv.c                        |  4 +--
 net/kcm/kcmsock.c                         |  6 ++--
 net/l2tp/l2tp_ppp.c                       |  4 +--
 net/llc/af_llc.c                          |  4 +--
 net/mptcp/protocol.c                      | 14 ++++----
 net/netlink/af_netlink.c                  |  4 +--
 net/netrom/af_netrom.c                    |  4 +--
 net/nfc/llcp_sock.c                       |  6 ++--
 net/packet/af_packet.c                    | 39 ++++++++++++-----------
 net/phonet/pep.c                          |  4 +--
 net/rds/af_rds.c                          | 30 ++++++++---------
 net/rds/rdma.c                            | 14 ++++----
 net/rds/rds.h                             |  6 ++--
 net/rose/af_rose.c                        |  4 +--
 net/rxrpc/af_rxrpc.c                      |  8 ++---
 net/rxrpc/ar-internal.h                   |  4 +--
 net/rxrpc/key.c                           |  9 +++---
 net/sctp/socket.c                         |  4 +--
 net/smc/af_smc.c                          |  4 +--
 net/socket.c                              | 23 ++++---------
 net/tipc/socket.c                         |  8 ++---
 net/tls/tls_main.c                        | 17 +++++-----
 net/vmw_vsock/af_vsock.c                  |  4 +--
 net/x25/af_x25.c                          |  4 +--
 net/xdp/xsk.c                             |  8 ++---
 61 files changed, 248 insertions(+), 258 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 29f71428520b4b..892242a42c3ec9 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -197,8 +197,7 @@ static int alg_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	return err;
 }
 
-static int alg_setkey(struct sock *sk, char __user *ukey,
-		      unsigned int keylen)
+static int alg_setkey(struct sock *sk, sockptr_t ukey, unsigned int keylen)
 {
 	struct alg_sock *ask = alg_sk(sk);
 	const struct af_alg_type *type = ask->type;
@@ -210,7 +209,7 @@ static int alg_setkey(struct sock *sk, char __user *ukey,
 		return -ENOMEM;
 
 	err = -EFAULT;
-	if (copy_from_user(key, ukey, keylen))
+	if (copy_from_sockptr(key, ukey, keylen))
 		goto out;
 
 	err = type->setkey(ask->private, key, keylen);
@@ -222,7 +221,7 @@ static int alg_setkey(struct sock *sk, char __user *ukey,
 }
 
 static int alg_setsockopt(struct socket *sock, int level, int optname,
-			  char __user *optval, unsigned int optlen)
+			  sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct alg_sock *ask = alg_sk(sk);
diff --git a/drivers/crypto/chelsio/chtls/chtls_main.c b/drivers/crypto/chelsio/chtls/chtls_main.c
index d98b89d0fa6eeb..c3058dcdb33c5c 100644
--- a/drivers/crypto/chelsio/chtls/chtls_main.c
+++ b/drivers/crypto/chelsio/chtls/chtls_main.c
@@ -488,7 +488,7 @@ static int chtls_getsockopt(struct sock *sk, int level, int optname,
 }
 
 static int do_chtls_setsockopt(struct sock *sk, int optname,
-			       char __user *optval, unsigned int optlen)
+			       sockptr_t optval, unsigned int optlen)
 {
 	struct tls_crypto_info *crypto_info, tmp_crypto_info;
 	struct chtls_sock *csk;
@@ -498,12 +498,12 @@ static int do_chtls_setsockopt(struct sock *sk, int optname,
 
 	csk = rcu_dereference_sk_user_data(sk);
 
-	if (!optval || optlen < sizeof(*crypto_info)) {
+	if (sockptr_is_null(optval) || optlen < sizeof(*crypto_info)) {
 		rc = -EINVAL;
 		goto out;
 	}
 
-	rc = copy_from_user(&tmp_crypto_info, optval, sizeof(*crypto_info));
+	rc = copy_from_sockptr(&tmp_crypto_info, optval, sizeof(*crypto_info));
 	if (rc) {
 		rc = -EFAULT;
 		goto out;
@@ -525,8 +525,9 @@ static int do_chtls_setsockopt(struct sock *sk, int optname,
 		/* Obtain version and type from previous copy */
 		crypto_info[0] = tmp_crypto_info;
 		/* Now copy the following data */
-		rc = copy_from_user((char *)crypto_info + sizeof(*crypto_info),
-				optval + sizeof(*crypto_info),
+		sockptr_advance(optval, sizeof(*crypto_info));
+		rc = copy_from_sockptr((char *)crypto_info + sizeof(*crypto_info),
+				optval,
 				sizeof(struct tls12_crypto_info_aes_gcm_128)
 				- sizeof(*crypto_info));
 
@@ -541,8 +542,9 @@ static int do_chtls_setsockopt(struct sock *sk, int optname,
 	}
 	case TLS_CIPHER_AES_GCM_256: {
 		crypto_info[0] = tmp_crypto_info;
-		rc = copy_from_user((char *)crypto_info + sizeof(*crypto_info),
-				    optval + sizeof(*crypto_info),
+		sockptr_advance(optval, sizeof(*crypto_info));
+		rc = copy_from_sockptr((char *)crypto_info + sizeof(*crypto_info),
+				    optval,
 				sizeof(struct tls12_crypto_info_aes_gcm_256)
 				- sizeof(*crypto_info));
 
@@ -565,7 +567,7 @@ static int do_chtls_setsockopt(struct sock *sk, int optname,
 }
 
 static int chtls_setsockopt(struct sock *sk, int level, int optname,
-			    char __user *optval, unsigned int optlen)
+			    sockptr_t optval, unsigned int optlen)
 {
 	struct tls_context *ctx = tls_get_ctx(sk);
 
diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
index 1b2b91479107bc..2835daae9e9f3a 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -401,7 +401,7 @@ data_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 }
 
 static int data_sock_setsockopt(struct socket *sock, int level, int optname,
-				char __user *optval, unsigned int len)
+				sockptr_t optval, unsigned int len)
 {
 	struct sock *sk = sock->sk;
 	int err = 0, opt = 0;
@@ -414,7 +414,7 @@ static int data_sock_setsockopt(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case MISDN_TIME_STAMP:
-		if (get_user(opt, (int __user *)optval)) {
+		if (copy_from_sockptr(&opt, optval, sizeof(int))) {
 			err = -EFAULT;
 			break;
 		}
diff --git a/include/linux/net.h b/include/linux/net.h
index 858ff1d981540d..d48ff11808794c 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -21,6 +21,7 @@
 #include <linux/rcupdate.h>
 #include <linux/once.h>
 #include <linux/fs.h>
+#include <linux/sockptr.h>
 
 #include <uapi/linux/net.h>
 
@@ -162,7 +163,8 @@ struct proto_ops {
 	int		(*listen)    (struct socket *sock, int len);
 	int		(*shutdown)  (struct socket *sock, int flags);
 	int		(*setsockopt)(struct socket *sock, int level,
-				      int optname, char __user *optval, unsigned int optlen);
+				      int optname, sockptr_t optval,
+				      unsigned int optlen);
 	int		(*getsockopt)(struct socket *sock, int level,
 				      int optname, char __user *optval, int __user *optlen);
 	void		(*show_fdinfo)(struct seq_file *m, struct socket *sock);
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 157c60cca0ca60..1e209ce7d1bd1b 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -16,6 +16,7 @@
 #include <linux/timer.h>
 #include <linux/poll.h>
 #include <linux/kernel.h>
+#include <linux/sockptr.h>
 
 #include <net/inet_sock.h>
 #include <net/request_sock.h>
@@ -45,7 +46,7 @@ struct inet_connection_sock_af_ops {
 	u16	    net_frag_header_len;
 	u16	    sockaddr_len;
 	int	    (*setsockopt)(struct sock *sk, int level, int optname,
-				  char __user *optval, unsigned int optlen);
+				  sockptr_t optval, unsigned int optlen);
 	int	    (*getsockopt)(struct sock *sk, int level, int optname,
 				  char __user *optval, int __user *optlen);
 	void	    (*addr2sockaddr)(struct sock *sk, struct sockaddr *);
diff --git a/include/net/ip.h b/include/net/ip.h
index d66ad3a9522081..b09c48d862cc10 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -722,7 +722,7 @@ void ip_cmsg_recv_offset(struct msghdr *msg, struct sock *sk,
 			 struct sk_buff *skb, int tlen, int offset);
 int ip_cmsg_send(struct sock *sk, struct msghdr *msg,
 		 struct ipcm_cookie *ipc, bool allow_ipv6);
-int ip_setsockopt(struct sock *sk, int level, int optname, char __user *optval,
+int ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 		  unsigned int optlen);
 int ip_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
 		  int __user *optlen);
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 4c9d89b5d73268..bd1f396cc9c729 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1084,8 +1084,8 @@ struct in6_addr *fl6_update_dst(struct flowi6 *fl6,
  *	socket options (ipv6_sockglue.c)
  */
 
-int ipv6_setsockopt(struct sock *sk, int level, int optname,
-		    char __user *optval, unsigned int optlen);
+int ipv6_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
+		    unsigned int optlen);
 int ipv6_getsockopt(struct sock *sk, int level, int optname,
 		    char __user *optval, int __user *optlen);
 
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 233bbf7df5d66c..b33f1aefad0989 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -431,7 +431,7 @@ struct sctp_af {
 	int		(*setsockopt)	(struct sock *sk,
 					 int level,
 					 int optname,
-					 char __user *optval,
+					 sockptr_t optval,
 					 unsigned int optlen);
 	int		(*getsockopt)	(struct sock *sk,
 					 int level,
diff --git a/include/net/sock.h b/include/net/sock.h
index bfb2fe2fc36876..2cc3ba667908de 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1141,7 +1141,7 @@ struct proto {
 	void			(*destroy)(struct sock *sk);
 	void			(*shutdown)(struct sock *sk, int how);
 	int			(*setsockopt)(struct sock *sk, int level,
-					int optname, char __user *optval,
+					int optname, sockptr_t optval,
 					unsigned int optlen);
 	int			(*getsockopt)(struct sock *sk, int level,
 					int optname, char __user *optval,
@@ -1734,7 +1734,7 @@ int sock_common_getsockopt(struct socket *sock, int level, int optname,
 int sock_common_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 			int flags);
 int sock_common_setsockopt(struct socket *sock, int level, int optname,
-				  char __user *optval, unsigned int optlen);
+			   sockptr_t optval, unsigned int optlen);
 
 void sk_common_release(struct sock *sk);
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index e3c8e1d820214c..e0c35d56091f22 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -399,8 +399,8 @@ __poll_t tcp_poll(struct file *file, struct socket *sock,
 		      struct poll_table_struct *wait);
 int tcp_getsockopt(struct sock *sk, int level, int optname,
 		   char __user *optval, int __user *optlen);
-int tcp_setsockopt(struct sock *sk, int level, int optname,
-		   char __user *optval, unsigned int optlen);
+int tcp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
+		   unsigned int optlen);
 void tcp_set_keepalive(struct sock *sk, int val);
 void tcp_syn_ack_timeout(const struct request_sock *req);
 int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int nonblock,
diff --git a/net/atm/common.c b/net/atm/common.c
index 9b28f1fb3c69c8..84367b844b1473 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -745,7 +745,7 @@ static int check_qos(const struct atm_qos *qos)
 }
 
 int vcc_setsockopt(struct socket *sock, int level, int optname,
-		   char __user *optval, unsigned int optlen)
+		   sockptr_t optval, unsigned int optlen)
 {
 	struct atm_vcc *vcc;
 	unsigned long value;
@@ -760,7 +760,7 @@ int vcc_setsockopt(struct socket *sock, int level, int optname,
 	{
 		struct atm_qos qos;
 
-		if (copy_from_user(&qos, optval, sizeof(qos)))
+		if (copy_from_sockptr(&qos, optval, sizeof(qos)))
 			return -EFAULT;
 		error = check_qos(&qos);
 		if (error)
@@ -774,7 +774,7 @@ int vcc_setsockopt(struct socket *sock, int level, int optname,
 		return 0;
 	}
 	case SO_SETCLP:
-		if (get_user(value, (unsigned long __user *)optval))
+		if (copy_from_sockptr(&value, optval, sizeof(value)))
 			return -EFAULT;
 		if (value)
 			vcc->atm_options |= ATM_ATMOPT_CLP;
diff --git a/net/atm/common.h b/net/atm/common.h
index 5850649068bb29..a1e56e8de698a3 100644
--- a/net/atm/common.h
+++ b/net/atm/common.h
@@ -21,7 +21,7 @@ __poll_t vcc_poll(struct file *file, struct socket *sock, poll_table *wait);
 int vcc_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int vcc_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int vcc_setsockopt(struct socket *sock, int level, int optname,
-		   char __user *optval, unsigned int optlen);
+		   sockptr_t optval, unsigned int optlen);
 int vcc_getsockopt(struct socket *sock, int level, int optname,
 		   char __user *optval, int __user *optlen);
 void vcc_process_recv_queue(struct atm_vcc *vcc);
diff --git a/net/atm/pvc.c b/net/atm/pvc.c
index 02bd2a436bdf9e..53e7d3f39e26cc 100644
--- a/net/atm/pvc.c
+++ b/net/atm/pvc.c
@@ -63,7 +63,7 @@ static int pvc_connect(struct socket *sock, struct sockaddr *sockaddr,
 }
 
 static int pvc_setsockopt(struct socket *sock, int level, int optname,
-			  char __user *optval, unsigned int optlen)
+			  sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	int error;
diff --git a/net/atm/svc.c b/net/atm/svc.c
index ba144d035e3d41..4a02bcaad279f8 100644
--- a/net/atm/svc.c
+++ b/net/atm/svc.c
@@ -451,7 +451,7 @@ int svc_change_qos(struct atm_vcc *vcc, struct atm_qos *qos)
 }
 
 static int svc_setsockopt(struct socket *sock, int level, int optname,
-			  char __user *optval, unsigned int optlen)
+			  sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct atm_vcc *vcc = ATM_SD(sock);
@@ -464,7 +464,7 @@ static int svc_setsockopt(struct socket *sock, int level, int optname,
 			error = -EINVAL;
 			goto out;
 		}
-		if (copy_from_user(&vcc->sap, optval, optlen)) {
+		if (copy_from_sockptr(&vcc->sap, optval, optlen)) {
 			error = -EFAULT;
 			goto out;
 		}
@@ -475,7 +475,7 @@ static int svc_setsockopt(struct socket *sock, int level, int optname,
 			error = -EINVAL;
 			goto out;
 		}
-		if (get_user(value, (int __user *)optval)) {
+		if (copy_from_sockptr(&value, optval, sizeof(int))) {
 			error = -EFAULT;
 			goto out;
 		}
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index fd91cd34f25e03..17bf31a8969284 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -528,7 +528,7 @@ ax25_cb *ax25_create_cb(void)
  */
 
 static int ax25_setsockopt(struct socket *sock, int level, int optname,
-	char __user *optval, unsigned int optlen)
+		sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	ax25_cb *ax25;
@@ -543,7 +543,7 @@ static int ax25_setsockopt(struct socket *sock, int level, int optname,
 	if (optlen < sizeof(unsigned int))
 		return -EINVAL;
 
-	if (get_user(opt, (unsigned int __user *)optval))
+	if (copy_from_sockptr(&opt, optval, sizeof(unsigned int)))
 		return -EFAULT;
 
 	lock_sock(sk);
@@ -640,7 +640,7 @@ static int ax25_setsockopt(struct socket *sock, int level, int optname,
 
 		memset(devname, 0, sizeof(devname));
 
-		if (copy_from_user(devname, optval, optlen)) {
+		if (copy_from_sockptr(devname, optval, optlen)) {
 			res = -EFAULT;
 			break;
 		}
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index caf38a8ea6a8ba..d5eff27d5b1e17 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1842,7 +1842,7 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 }
 
 static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
-			       char __user *optval, unsigned int len)
+			       sockptr_t optval, unsigned int len)
 {
 	struct hci_ufilter uf = { .opcode = 0 };
 	struct sock *sk = sock->sk;
@@ -1862,7 +1862,7 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case HCI_DATA_DIR:
-		if (get_user(opt, (int __user *)optval)) {
+		if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
 			err = -EFAULT;
 			break;
 		}
@@ -1874,7 +1874,7 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case HCI_TIME_STAMP:
-		if (get_user(opt, (int __user *)optval)) {
+		if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
 			err = -EFAULT;
 			break;
 		}
@@ -1896,7 +1896,7 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 		}
 
 		len = min_t(unsigned int, len, sizeof(uf));
-		if (copy_from_user(&uf, optval, len)) {
+		if (copy_from_sockptr(&uf, optval, len)) {
 			err = -EFAULT;
 			break;
 		}
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a995d2c51fa7f1..a3d104123f38dd 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -703,7 +703,7 @@ static bool l2cap_valid_mtu(struct l2cap_chan *chan, u16 mtu)
 }
 
 static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
-				     char __user *optval, unsigned int optlen)
+				     sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
@@ -736,7 +736,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 		opts.txwin_size = chan->tx_win;
 
 		len = min_t(unsigned int, sizeof(opts), optlen);
-		if (copy_from_user((char *) &opts, optval, len)) {
+		if (copy_from_sockptr(&opts, optval, len)) {
 			err = -EFAULT;
 			break;
 		}
@@ -782,7 +782,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 		break;
 
 	case L2CAP_LM:
-		if (get_user(opt, (u32 __user *) optval)) {
+		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
 			err = -EFAULT;
 			break;
 		}
@@ -859,7 +859,7 @@ static int l2cap_set_mode(struct l2cap_chan *chan, u8 mode)
 }
 
 static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
-				 char __user *optval, unsigned int optlen)
+				 sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
@@ -891,7 +891,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		sec.level = BT_SECURITY_LOW;
 
 		len = min_t(unsigned int, sizeof(sec), optlen);
-		if (copy_from_user((char *) &sec, optval, len)) {
+		if (copy_from_sockptr(&sec, optval, len)) {
 			err = -EFAULT;
 			break;
 		}
@@ -939,7 +939,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (get_user(opt, (u32 __user *) optval)) {
+		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
 			err = -EFAULT;
 			break;
 		}
@@ -954,7 +954,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_FLUSHABLE:
-		if (get_user(opt, (u32 __user *) optval)) {
+		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
 			err = -EFAULT;
 			break;
 		}
@@ -990,7 +990,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		pwr.force_active = BT_POWER_FORCE_ACTIVE_ON;
 
 		len = min_t(unsigned int, sizeof(pwr), optlen);
-		if (copy_from_user((char *) &pwr, optval, len)) {
+		if (copy_from_sockptr(&pwr, optval, len)) {
 			err = -EFAULT;
 			break;
 		}
@@ -1002,7 +1002,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_CHANNEL_POLICY:
-		if (get_user(opt, (u32 __user *) optval)) {
+		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
 			err = -EFAULT;
 			break;
 		}
@@ -1050,7 +1050,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (get_user(opt, (u16 __user *) optval)) {
+		if (copy_from_sockptr(&opt, optval, sizeof(u16))) {
 			err = -EFAULT;
 			break;
 		}
@@ -1081,7 +1081,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (get_user(opt, (u8 __user *) optval)) {
+		if (copy_from_sockptr(&opt, optval, sizeof(u8))) {
 			err = -EFAULT;
 			break;
 		}
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index df14eebe80da8b..dba4ea0e1b0dc7 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -644,7 +644,8 @@ static int rfcomm_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	return len;
 }
 
-static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname, char __user *optval, unsigned int optlen)
+static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
+		sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
@@ -656,7 +657,7 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname, char __u
 
 	switch (optname) {
 	case RFCOMM_LM:
-		if (get_user(opt, (u32 __user *) optval)) {
+		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
 			err = -EFAULT;
 			break;
 		}
@@ -685,7 +686,8 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname, char __u
 	return err;
 }
 
-static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
+static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
+		sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct bt_security sec;
@@ -713,7 +715,7 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname, c
 		sec.level = BT_SECURITY_LOW;
 
 		len = min_t(unsigned int, sizeof(sec), optlen);
-		if (copy_from_user((char *) &sec, optval, len)) {
+		if (copy_from_sockptr(&sec, optval, len)) {
 			err = -EFAULT;
 			break;
 		}
@@ -732,7 +734,7 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname, c
 			break;
 		}
 
-		if (get_user(opt, (u32 __user *) optval)) {
+		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
 			err = -EFAULT;
 			break;
 		}
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index c8c3d38cdc7b56..37260baf71507b 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -791,7 +791,7 @@ static int sco_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 }
 
 static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
-			       char __user *optval, unsigned int optlen)
+			       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	int len, err = 0;
@@ -810,7 +810,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (get_user(opt, (u32 __user *) optval)) {
+		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
 			err = -EFAULT;
 			break;
 		}
@@ -831,7 +831,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		voice.setting = sco_pi(sk)->setting;
 
 		len = min_t(unsigned int, sizeof(voice), optlen);
-		if (copy_from_user((char *)&voice, optval, len)) {
+		if (copy_from_sockptr(&voice, optval, len)) {
 			err = -EFAULT;
 			break;
 		}
diff --git a/net/caif/caif_socket.c b/net/caif/caif_socket.c
index b94ecd931002e7..3ad0a1df671283 100644
--- a/net/caif/caif_socket.c
+++ b/net/caif/caif_socket.c
@@ -669,8 +669,8 @@ static int caif_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 	return sent ? : err;
 }
 
-static int setsockopt(struct socket *sock,
-		      int lvl, int opt, char __user *ov, unsigned int ol)
+static int setsockopt(struct socket *sock, int lvl, int opt, sockptr_t ov,
+		unsigned int ol)
 {
 	struct sock *sk = sock->sk;
 	struct caifsock *cf_sk = container_of(sk, struct caifsock, sk);
@@ -685,7 +685,7 @@ static int setsockopt(struct socket *sock,
 			return -EINVAL;
 		if (lvl != SOL_CAIF)
 			goto bad_sol;
-		if (copy_from_user(&linksel, ov, sizeof(int)))
+		if (copy_from_sockptr(&linksel, ov, sizeof(int)))
 			return -EINVAL;
 		lock_sock(&(cf_sk->sk));
 		cf_sk->conn_req.link_selector = linksel;
@@ -699,7 +699,7 @@ static int setsockopt(struct socket *sock,
 			return -ENOPROTOOPT;
 		lock_sock(&(cf_sk->sk));
 		if (ol > sizeof(cf_sk->conn_req.param.data) ||
-			copy_from_user(&cf_sk->conn_req.param.data, ov, ol)) {
+		    copy_from_sockptr(&cf_sk->conn_req.param.data, ov, ol)) {
 			release_sock(&cf_sk->sk);
 			return -EINVAL;
 		}
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index f7587428febdd2..78ff9b3f1d40c7 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -627,14 +627,14 @@ static int j1939_sk_release(struct socket *sock)
 	return 0;
 }
 
-static int j1939_sk_setsockopt_flag(struct j1939_sock *jsk, char __user *optval,
+static int j1939_sk_setsockopt_flag(struct j1939_sock *jsk, sockptr_t optval,
 				    unsigned int optlen, int flag)
 {
 	int tmp;
 
 	if (optlen != sizeof(tmp))
 		return -EINVAL;
-	if (copy_from_user(&tmp, optval, optlen))
+	if (copy_from_sockptr(&tmp, optval, optlen))
 		return -EFAULT;
 	lock_sock(&jsk->sk);
 	if (tmp)
@@ -646,7 +646,7 @@ static int j1939_sk_setsockopt_flag(struct j1939_sock *jsk, char __user *optval,
 }
 
 static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
-			       char __user *optval, unsigned int optlen)
+			       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct j1939_sock *jsk = j1939_sk(sk);
@@ -658,7 +658,7 @@ static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case SO_J1939_FILTER:
-		if (optval) {
+		if (!sockptr_is_null(optval)) {
 			struct j1939_filter *f;
 			int c;
 
@@ -670,7 +670,7 @@ static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
 				return -EINVAL;
 
 			count = optlen / sizeof(*filters);
-			filters = memdup_user(optval, optlen);
+			filters = memdup_sockptr(optval, optlen);
 			if (IS_ERR(filters))
 				return PTR_ERR(filters);
 
@@ -703,7 +703,7 @@ static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
 	case SO_J1939_SEND_PRIO:
 		if (optlen != sizeof(tmp))
 			return -EINVAL;
-		if (copy_from_user(&tmp, optval, optlen))
+		if (copy_from_sockptr(&tmp, optval, optlen))
 			return -EFAULT;
 		if (tmp < 0 || tmp > 7)
 			return -EDOM;
diff --git a/net/can/raw.c b/net/can/raw.c
index 59c039d73c6d58..94a9405658dc61 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -485,7 +485,7 @@ static int raw_getname(struct socket *sock, struct sockaddr *uaddr,
 }
 
 static int raw_setsockopt(struct socket *sock, int level, int optname,
-			  char __user *optval, unsigned int optlen)
+			  sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
@@ -511,11 +511,11 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 
 		if (count > 1) {
 			/* filter does not fit into dfilter => alloc space */
-			filter = memdup_user(optval, optlen);
+			filter = memdup_sockptr(optval, optlen);
 			if (IS_ERR(filter))
 				return PTR_ERR(filter);
 		} else if (count == 1) {
-			if (copy_from_user(&sfilter, optval, sizeof(sfilter)))
+			if (copy_from_sockptr(&sfilter, optval, sizeof(sfilter)))
 				return -EFAULT;
 		}
 
@@ -568,7 +568,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		if (optlen != sizeof(err_mask))
 			return -EINVAL;
 
-		if (copy_from_user(&err_mask, optval, optlen))
+		if (copy_from_sockptr(&err_mask, optval, optlen))
 			return -EFAULT;
 
 		err_mask &= CAN_ERR_MASK;
@@ -607,7 +607,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		if (optlen != sizeof(ro->loopback))
 			return -EINVAL;
 
-		if (copy_from_user(&ro->loopback, optval, optlen))
+		if (copy_from_sockptr(&ro->loopback, optval, optlen))
 			return -EFAULT;
 
 		break;
@@ -616,7 +616,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		if (optlen != sizeof(ro->recv_own_msgs))
 			return -EINVAL;
 
-		if (copy_from_user(&ro->recv_own_msgs, optval, optlen))
+		if (copy_from_sockptr(&ro->recv_own_msgs, optval, optlen))
 			return -EFAULT;
 
 		break;
@@ -625,7 +625,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		if (optlen != sizeof(ro->fd_frames))
 			return -EINVAL;
 
-		if (copy_from_user(&ro->fd_frames, optval, optlen))
+		if (copy_from_sockptr(&ro->fd_frames, optval, optlen))
 			return -EFAULT;
 
 		break;
@@ -634,7 +634,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		if (optlen != sizeof(ro->join_filters))
 			return -EINVAL;
 
-		if (copy_from_user(&ro->join_filters, optval, optlen))
+		if (copy_from_sockptr(&ro->join_filters, optval, optlen))
 			return -EFAULT;
 
 		break;
diff --git a/net/core/sock.c b/net/core/sock.c
index 9cf8318bc51de4..ff22629f10ce92 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3210,7 +3210,7 @@ EXPORT_SYMBOL(sock_common_recvmsg);
  *	Set socket options on an inet socket.
  */
 int sock_common_setsockopt(struct socket *sock, int level, int optname,
-			   char __user *optval, unsigned int optlen)
+			   sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 
diff --git a/net/dccp/dccp.h b/net/dccp/dccp.h
index 434eea91b7679d..9cc9d1ee6cdb9a 100644
--- a/net/dccp/dccp.h
+++ b/net/dccp/dccp.h
@@ -295,7 +295,7 @@ int dccp_disconnect(struct sock *sk, int flags);
 int dccp_getsockopt(struct sock *sk, int level, int optname,
 		    char __user *optval, int __user *optlen);
 int dccp_setsockopt(struct sock *sk, int level, int optname,
-		    char __user *optval, unsigned int optlen);
+		    sockptr_t optval, unsigned int optlen);
 int dccp_ioctl(struct sock *sk, int cmd, unsigned long arg);
 int dccp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 int dccp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int nonblock,
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index fd92d3fe321f08..9e58787047f197 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -402,7 +402,7 @@ int dccp_ioctl(struct sock *sk, int cmd, unsigned long arg)
 EXPORT_SYMBOL_GPL(dccp_ioctl);
 
 static int dccp_setsockopt_service(struct sock *sk, const __be32 service,
-				   char __user *optval, unsigned int optlen)
+				   sockptr_t optval, unsigned int optlen)
 {
 	struct dccp_sock *dp = dccp_sk(sk);
 	struct dccp_service_list *sl = NULL;
@@ -417,9 +417,9 @@ static int dccp_setsockopt_service(struct sock *sk, const __be32 service,
 			return -ENOMEM;
 
 		sl->dccpsl_nr = optlen / sizeof(u32) - 1;
-		if (copy_from_user(sl->dccpsl_list,
-				   optval + sizeof(service),
-				   optlen - sizeof(service)) ||
+		sockptr_advance(optval, sizeof(service));
+		if (copy_from_sockptr(sl->dccpsl_list, optval,
+				      optlen - sizeof(service)) ||
 		    dccp_list_has_service(sl, DCCP_SERVICE_INVALID_VALUE)) {
 			kfree(sl);
 			return -EFAULT;
@@ -473,7 +473,7 @@ static int dccp_setsockopt_cscov(struct sock *sk, int cscov, bool rx)
 }
 
 static int dccp_setsockopt_ccid(struct sock *sk, int type,
-				char __user *optval, unsigned int optlen)
+				sockptr_t optval, unsigned int optlen)
 {
 	u8 *val;
 	int rc = 0;
@@ -481,7 +481,7 @@ static int dccp_setsockopt_ccid(struct sock *sk, int type,
 	if (optlen < 1 || optlen > DCCP_FEAT_MAX_SP_VALS)
 		return -EINVAL;
 
-	val = memdup_user(optval, optlen);
+	val = memdup_sockptr(optval, optlen);
 	if (IS_ERR(val))
 		return PTR_ERR(val);
 
@@ -498,7 +498,7 @@ static int dccp_setsockopt_ccid(struct sock *sk, int type,
 }
 
 static int do_dccp_setsockopt(struct sock *sk, int level, int optname,
-		char __user *optval, unsigned int optlen)
+		sockptr_t optval, unsigned int optlen)
 {
 	struct dccp_sock *dp = dccp_sk(sk);
 	int val, err = 0;
@@ -520,7 +520,7 @@ static int do_dccp_setsockopt(struct sock *sk, int level, int optname,
 	if (optlen < (int)sizeof(int))
 		return -EINVAL;
 
-	if (get_user(val, (int __user *)optval))
+	if (copy_from_sockptr(&val, optval, sizeof(int)))
 		return -EFAULT;
 
 	if (optname == DCCP_SOCKOPT_SERVICE)
@@ -563,8 +563,8 @@ static int do_dccp_setsockopt(struct sock *sk, int level, int optname,
 	return err;
 }
 
-int dccp_setsockopt(struct sock *sk, int level, int optname,
-		    char __user *optval, unsigned int optlen)
+int dccp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
+		    unsigned int optlen)
 {
 	if (level != SOL_DCCP)
 		return inet_csk(sk)->icsk_af_ops->setsockopt(sk, level,
diff --git a/net/decnet/af_decnet.c b/net/decnet/af_decnet.c
index 7d51ab608fb3f1..3b53d766789d47 100644
--- a/net/decnet/af_decnet.c
+++ b/net/decnet/af_decnet.c
@@ -150,7 +150,8 @@ static struct hlist_head dn_sk_hash[DN_SK_HASH_SIZE];
 static struct hlist_head dn_wild_sk;
 static atomic_long_t decnet_memory_allocated;
 
-static int __dn_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen, int flags);
+static int __dn_setsockopt(struct socket *sock, int level, int optname,
+		sockptr_t optval, unsigned int optlen, int flags);
 static int __dn_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen, int flags);
 
 static struct hlist_head *dn_find_list(struct sock *sk)
@@ -1320,7 +1321,8 @@ static int dn_shutdown(struct socket *sock, int how)
 	return err;
 }
 
-static int dn_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
+static int dn_setsockopt(struct socket *sock, int level, int optname,
+		sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	int err;
@@ -1332,14 +1334,14 @@ static int dn_setsockopt(struct socket *sock, int level, int optname, char __use
 	/* we need to exclude all possible ENOPROTOOPTs except default case */
 	if (err == -ENOPROTOOPT && optname != DSO_LINKINFO &&
 	    optname != DSO_STREAM && optname != DSO_SEQPACKET)
-		err = nf_setsockopt(sk, PF_DECnet, optname,
-				    USER_SOCKPTR(optval), optlen);
+		err = nf_setsockopt(sk, PF_DECnet, optname, optval, optlen);
 #endif
 
 	return err;
 }
 
-static int __dn_setsockopt(struct socket *sock, int level,int optname, char __user *optval, unsigned int optlen, int flags)
+static int __dn_setsockopt(struct socket *sock, int level, int optname,
+		sockptr_t optval, unsigned int optlen, int flags)
 {
 	struct	sock *sk = sock->sk;
 	struct dn_scp *scp = DN_SK(sk);
@@ -1355,13 +1357,13 @@ static int __dn_setsockopt(struct socket *sock, int level,int optname, char __us
 	} u;
 	int err;
 
-	if (optlen && !optval)
+	if (optlen && sockptr_is_null(optval))
 		return -EINVAL;
 
 	if (optlen > sizeof(u))
 		return -EINVAL;
 
-	if (copy_from_user(&u, optval, optlen))
+	if (copy_from_sockptr(&u, optval, optlen))
 		return -EFAULT;
 
 	switch (optname) {
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 94ae9662133e30..a45a0401adc50b 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -382,7 +382,7 @@ static int raw_getsockopt(struct sock *sk, int level, int optname,
 }
 
 static int raw_setsockopt(struct sock *sk, int level, int optname,
-			  char __user *optval, unsigned int optlen)
+			  sockptr_t optval, unsigned int optlen)
 {
 	return -EOPNOTSUPP;
 }
@@ -872,7 +872,7 @@ static int dgram_getsockopt(struct sock *sk, int level, int optname,
 }
 
 static int dgram_setsockopt(struct sock *sk, int level, int optname,
-			    char __user *optval, unsigned int optlen)
+			    sockptr_t optval, unsigned int optlen)
 {
 	struct dgram_sock *ro = dgram_sk(sk);
 	struct net *net = sock_net(sk);
@@ -882,7 +882,7 @@ static int dgram_setsockopt(struct sock *sk, int level, int optname,
 	if (optlen < sizeof(int))
 		return -EINVAL;
 
-	if (get_user(val, (int __user *)optval))
+	if (copy_from_sockptr(&val, optval, sizeof(int)))
 		return -EFAULT;
 
 	lock_sock(sk);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index f7f1507b89fe24..8dc027e54c5bfb 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1401,21 +1401,19 @@ void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb)
 	skb_dst_drop(skb);
 }
 
-int ip_setsockopt(struct sock *sk, int level,
-		int optname, char __user *optval, unsigned int optlen)
+int ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
+		unsigned int optlen)
 {
 	int err;
 
 	if (level != SOL_IP)
 		return -ENOPROTOOPT;
 
-	err = do_ip_setsockopt(sk, level, optname, USER_SOCKPTR(optval),
-			       optlen);
+	err = do_ip_setsockopt(sk, level, optname, optval, optlen);
 #if IS_ENABLED(CONFIG_BPFILTER_UMH)
 	if (optname >= BPFILTER_IPT_SO_SET_REPLACE &&
 	    optname < BPFILTER_IPT_SET_MAX)
-		err = bpfilter_ip_set_sockopt(sk, optname, USER_SOCKPTR(optval),
-					      optlen);
+		err = bpfilter_ip_set_sockopt(sk, optname, optval, optlen);
 #endif
 #ifdef CONFIG_NETFILTER
 	/* we need to exclude all possible ENOPROTOOPTs except default case */
@@ -1423,8 +1421,7 @@ int ip_setsockopt(struct sock *sk, int level,
 			optname != IP_IPSEC_POLICY &&
 			optname != IP_XFRM_POLICY &&
 			!ip_mroute_opt(optname))
-		err = nf_setsockopt(sk, PF_INET, optname, USER_SOCKPTR(optval),
-				    optlen);
+		err = nf_setsockopt(sk, PF_INET, optname, optval, optlen);
 #endif
 	return err;
 }
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 2a57d633b31e00..6fd4330287c279 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -809,11 +809,11 @@ static int raw_sk_init(struct sock *sk)
 	return 0;
 }
 
-static int raw_seticmpfilter(struct sock *sk, char __user *optval, int optlen)
+static int raw_seticmpfilter(struct sock *sk, sockptr_t optval, int optlen)
 {
 	if (optlen > sizeof(struct icmp_filter))
 		optlen = sizeof(struct icmp_filter);
-	if (copy_from_user(&raw_sk(sk)->filter, optval, optlen))
+	if (copy_from_sockptr(&raw_sk(sk)->filter, optval, optlen))
 		return -EFAULT;
 	return 0;
 }
@@ -838,7 +838,7 @@ out:	return ret;
 }
 
 static int do_raw_setsockopt(struct sock *sk, int level, int optname,
-			  char __user *optval, unsigned int optlen)
+			     sockptr_t optval, unsigned int optlen)
 {
 	if (optname == ICMP_FILTER) {
 		if (inet_sk(sk)->inet_num != IPPROTO_ICMP)
@@ -850,7 +850,7 @@ static int do_raw_setsockopt(struct sock *sk, int level, int optname,
 }
 
 static int raw_setsockopt(struct sock *sk, int level, int optname,
-			  char __user *optval, unsigned int optlen)
+			  sockptr_t optval, unsigned int optlen)
 {
 	if (level != SOL_RAW)
 		return ip_setsockopt(sk, level, optname, optval, optlen);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 71cbc61c335f71..27de9380ed140e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3323,7 +3323,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 	return err;
 }
 
-int tcp_setsockopt(struct sock *sk, int level, int optname, char __user *optval,
+int tcp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 		   unsigned int optlen)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
@@ -3331,8 +3331,7 @@ int tcp_setsockopt(struct sock *sk, int level, int optname, char __user *optval,
 	if (level != SOL_TCP)
 		return icsk->icsk_af_ops->setsockopt(sk, level, optname,
 						     optval, optlen);
-	return do_tcp_setsockopt(sk, level, optname, USER_SOCKPTR(optval),
-				 optlen);
+	return do_tcp_setsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(tcp_setsockopt);
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 641303aa17d3dd..00b794a1035ce1 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2647,12 +2647,12 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 }
 EXPORT_SYMBOL(udp_lib_setsockopt);
 
-int udp_setsockopt(struct sock *sk, int level, int optname,
-		   char __user *optval, unsigned int optlen)
+int udp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
+		   unsigned int optlen)
 {
 	if (level == SOL_UDP  ||  level == SOL_UDPLITE)
 		return udp_lib_setsockopt(sk, level, optname,
-					  USER_SOCKPTR(optval), optlen,
+					  optval, optlen,
 					  udp_push_pending_frames);
 	return ip_setsockopt(sk, level, optname, optval, optlen);
 }
diff --git a/net/ipv4/udp_impl.h b/net/ipv4/udp_impl.h
index ab313702c87f30..2878d8285cafe7 100644
--- a/net/ipv4/udp_impl.h
+++ b/net/ipv4/udp_impl.h
@@ -12,8 +12,8 @@ int __udp4_lib_err(struct sk_buff *, u32, struct udp_table *);
 int udp_v4_get_port(struct sock *sk, unsigned short snum);
 void udp_v4_rehash(struct sock *sk);
 
-int udp_setsockopt(struct sock *sk, int level, int optname,
-		   char __user *optval, unsigned int optlen);
+int udp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
+		   unsigned int optlen);
 int udp_getsockopt(struct sock *sk, int level, int optname,
 		   char __user *optval, int __user *optlen);
 
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index dcd000a5a9b124..d2282f5c9760f9 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -980,8 +980,8 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 	return -EINVAL;
 }
 
-int ipv6_setsockopt(struct sock *sk, int level, int optname,
-		    char __user *optval, unsigned int optlen)
+int ipv6_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
+		    unsigned int optlen)
 {
 	int err;
 
@@ -991,14 +991,12 @@ int ipv6_setsockopt(struct sock *sk, int level, int optname,
 	if (level != SOL_IPV6)
 		return -ENOPROTOOPT;
 
-	err = do_ipv6_setsockopt(sk, level, optname, USER_SOCKPTR(optval),
-				 optlen);
+	err = do_ipv6_setsockopt(sk, level, optname, optval, optlen);
 #ifdef CONFIG_NETFILTER
 	/* we need to exclude all possible ENOPROTOOPTs except default case */
 	if (err == -ENOPROTOOPT && optname != IPV6_IPSEC_POLICY &&
 			optname != IPV6_XFRM_POLICY)
-		err = nf_setsockopt(sk, PF_INET6, optname, USER_SOCKPTR(optval),
-				    optlen);
+		err = nf_setsockopt(sk, PF_INET6, optname, optval, optlen);
 #endif
 	return err;
 }
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 594e01ad670aa6..874f01cd7aec42 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -972,13 +972,13 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 }
 
 static int rawv6_seticmpfilter(struct sock *sk, int level, int optname,
-			       char __user *optval, int optlen)
+			       sockptr_t optval, int optlen)
 {
 	switch (optname) {
 	case ICMPV6_FILTER:
 		if (optlen > sizeof(struct icmp6_filter))
 			optlen = sizeof(struct icmp6_filter);
-		if (copy_from_user(&raw6_sk(sk)->filter, optval, optlen))
+		if (copy_from_sockptr(&raw6_sk(sk)->filter, optval, optlen))
 			return -EFAULT;
 		return 0;
 	default:
@@ -1015,12 +1015,12 @@ static int rawv6_geticmpfilter(struct sock *sk, int level, int optname,
 
 
 static int do_rawv6_setsockopt(struct sock *sk, int level, int optname,
-			    char __user *optval, unsigned int optlen)
+			       sockptr_t optval, unsigned int optlen)
 {
 	struct raw6_sock *rp = raw6_sk(sk);
 	int val;
 
-	if (get_user(val, (int __user *)optval))
+	if (copy_from_sockptr(&val, optval, sizeof(val)))
 		return -EFAULT;
 
 	switch (optname) {
@@ -1062,7 +1062,7 @@ static int do_rawv6_setsockopt(struct sock *sk, int level, int optname,
 }
 
 static int rawv6_setsockopt(struct sock *sk, int level, int optname,
-			  char __user *optval, unsigned int optlen)
+			    sockptr_t optval, unsigned int optlen)
 {
 	switch (level) {
 	case SOL_RAW:
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 05353b31fa07bc..85238620541c3e 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1561,12 +1561,12 @@ void udpv6_destroy_sock(struct sock *sk)
 /*
  *	Socket option code for UDP
  */
-int udpv6_setsockopt(struct sock *sk, int level, int optname,
-		     char __user *optval, unsigned int optlen)
+int udpv6_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
+		     unsigned int optlen)
 {
 	if (level == SOL_UDP  ||  level == SOL_UDPLITE)
 		return udp_lib_setsockopt(sk, level, optname,
-					  USER_SOCKPTR(optval), optlen,
+					  optval, optlen,
 					  udp_v6_push_pending_frames);
 	return ipv6_setsockopt(sk, level, optname, optval, optlen);
 }
diff --git a/net/ipv6/udp_impl.h b/net/ipv6/udp_impl.h
index 30dfb6f1b7622a..b2fcc46c1630e0 100644
--- a/net/ipv6/udp_impl.h
+++ b/net/ipv6/udp_impl.h
@@ -17,8 +17,8 @@ void udp_v6_rehash(struct sock *sk);
 
 int udpv6_getsockopt(struct sock *sk, int level, int optname,
 		     char __user *optval, int __user *optlen);
-int udpv6_setsockopt(struct sock *sk, int level, int optname,
-		     char __user *optval, unsigned int optlen);
+int udpv6_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
+		     unsigned int optlen);
 int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len);
 int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int noblock,
 		  int flags, int *addr_len);
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index ee0add15497d96..6ee9851ac7c680 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1494,7 +1494,7 @@ static int iucv_sock_release(struct socket *sock)
 
 /* getsockopt and setsockopt */
 static int iucv_sock_setsockopt(struct socket *sock, int level, int optname,
-				char __user *optval, unsigned int optlen)
+				sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct iucv_sock *iucv = iucv_sk(sk);
@@ -1507,7 +1507,7 @@ static int iucv_sock_setsockopt(struct socket *sock, int level, int optname,
 	if (optlen < sizeof(int))
 		return -EINVAL;
 
-	if (get_user(val, (int __user *) optval))
+	if (copy_from_sockptr(&val, optval, sizeof(int)))
 		return -EFAULT;
 
 	rc = 0;
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 56fac24a627a54..56dad9565bc93b 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1265,7 +1265,7 @@ static void kcm_recv_enable(struct kcm_sock *kcm)
 }
 
 static int kcm_setsockopt(struct socket *sock, int level, int optname,
-			  char __user *optval, unsigned int optlen)
+			  sockptr_t optval, unsigned int optlen)
 {
 	struct kcm_sock *kcm = kcm_sk(sock->sk);
 	int val, valbool;
@@ -1277,8 +1277,8 @@ static int kcm_setsockopt(struct socket *sock, int level, int optname,
 	if (optlen < sizeof(int))
 		return -EINVAL;
 
-	if (get_user(val, (int __user *)optval))
-		return -EINVAL;
+	if (copy_from_sockptr(&val, optval, sizeof(int)))
+		return -EFAULT;
 
 	valbool = val ? 1 : 0;
 
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index c54cb59593ef81..c8842b2317409a 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1244,7 +1244,7 @@ static int pppol2tp_session_setsockopt(struct sock *sk,
  * session or the special tunnel type.
  */
 static int pppol2tp_setsockopt(struct socket *sock, int level, int optname,
-			       char __user *optval, unsigned int optlen)
+			       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct l2tp_session *session;
@@ -1258,7 +1258,7 @@ static int pppol2tp_setsockopt(struct socket *sock, int level, int optname,
 	if (optlen < sizeof(int))
 		return -EINVAL;
 
-	if (get_user(val, (int __user *)optval))
+	if (copy_from_sockptr(&val, optval, sizeof(int)))
 		return -EFAULT;
 
 	err = -ENOTCONN;
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 6140a3e46c26f1..7180979114e494 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -1053,7 +1053,7 @@ static int llc_ui_ioctl(struct socket *sock, unsigned int cmd,
  *	Set various connection specific parameters.
  */
 static int llc_ui_setsockopt(struct socket *sock, int level, int optname,
-			     char __user *optval, unsigned int optlen)
+			     sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc = llc_sk(sk);
@@ -1063,7 +1063,7 @@ static int llc_ui_setsockopt(struct socket *sock, int level, int optname,
 	lock_sock(sk);
 	if (unlikely(level != SOL_LLC || optlen != sizeof(int)))
 		goto out;
-	rc = get_user(opt, (int __user *)optval);
+	rc = copy_from_sockptr(&opt, optval, sizeof(opt));
 	if (rc)
 		goto out;
 	rc = -EINVAL;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 27b6f250b87dfd..30a8e697b9db9c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1627,7 +1627,7 @@ static void mptcp_destroy(struct sock *sk)
 }
 
 static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
-				       char __user *optval, unsigned int optlen)
+				       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct socket *ssock;
@@ -1643,8 +1643,8 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 			return -EINVAL;
 		}
 
-		ret = sock_setsockopt(ssock, SOL_SOCKET, optname,
-				      USER_SOCKPTR(optval), optlen);
+		ret = sock_setsockopt(ssock, SOL_SOCKET, optname, optval,
+				      optlen);
 		if (ret == 0) {
 			if (optname == SO_REUSEPORT)
 				sk->sk_reuseport = ssock->sk->sk_reuseport;
@@ -1655,12 +1655,12 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 		return ret;
 	}
 
-	return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname,
-			       USER_SOCKPTR(optval), optlen);
+	return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval,
+			       optlen);
 }
 
 static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
-			       char __user *optval, unsigned int optlen)
+			       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = (struct sock *)msk;
 	int ret = -EOPNOTSUPP;
@@ -1687,7 +1687,7 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 }
 
 static int mptcp_setsockopt(struct sock *sk, int level, int optname,
-			    char __user *optval, unsigned int optlen)
+			    sockptr_t optval, unsigned int optlen)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sock *ssk;
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 4f2c3b14ddbfa3..1d9750068cd65b 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1620,7 +1620,7 @@ static void netlink_update_socket_mc(struct netlink_sock *nlk,
 }
 
 static int netlink_setsockopt(struct socket *sock, int level, int optname,
-			      char __user *optval, unsigned int optlen)
+			      sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct netlink_sock *nlk = nlk_sk(sk);
@@ -1631,7 +1631,7 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 		return -ENOPROTOOPT;
 
 	if (optlen >= sizeof(int) &&
-	    get_user(val, (unsigned int __user *)optval))
+	    copy_from_sockptr(&val, optval, sizeof(val)))
 		return -EFAULT;
 
 	switch (optname) {
diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index f90ef6934b8f4d..6d16e1ab1a8aba 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -294,7 +294,7 @@ void nr_destroy_socket(struct sock *sk)
  */
 
 static int nr_setsockopt(struct socket *sock, int level, int optname,
-	char __user *optval, unsigned int optlen)
+		sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct nr_sock *nr = nr_sk(sk);
@@ -306,7 +306,7 @@ static int nr_setsockopt(struct socket *sock, int level, int optname,
 	if (optlen < sizeof(unsigned int))
 		return -EINVAL;
 
-	if (get_user(opt, (unsigned int __user *)optval))
+	if (copy_from_sockptr(&opt, optval, sizeof(unsigned int)))
 		return -EFAULT;
 
 	switch (optname) {
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 6da1e2334bb697..d257ed3b732ae3 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -218,7 +218,7 @@ static int llcp_sock_listen(struct socket *sock, int backlog)
 }
 
 static int nfc_llcp_setsockopt(struct socket *sock, int level, int optname,
-			       char __user *optval, unsigned int optlen)
+			       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct nfc_llcp_sock *llcp_sock = nfc_llcp_sock(sk);
@@ -241,7 +241,7 @@ static int nfc_llcp_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (get_user(opt, (u32 __user *) optval)) {
+		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
 			err = -EFAULT;
 			break;
 		}
@@ -263,7 +263,7 @@ static int nfc_llcp_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (get_user(opt, (u32 __user *) optval)) {
+		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
 			err = -EFAULT;
 			break;
 		}
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index d8d4f78f78e451..0b8160d1a6e06d 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1558,7 +1558,7 @@ static int fanout_set_data_cbpf(struct packet_sock *po, sockptr_t data,
 	return 0;
 }
 
-static int fanout_set_data_ebpf(struct packet_sock *po, char __user *data,
+static int fanout_set_data_ebpf(struct packet_sock *po, sockptr_t data,
 				unsigned int len)
 {
 	struct bpf_prog *new;
@@ -1568,7 +1568,7 @@ static int fanout_set_data_ebpf(struct packet_sock *po, char __user *data,
 		return -EPERM;
 	if (len != sizeof(fd))
 		return -EINVAL;
-	if (copy_from_user(&fd, data, len))
+	if (copy_from_sockptr(&fd, data, len))
 		return -EFAULT;
 
 	new = bpf_prog_get_type(fd, BPF_PROG_TYPE_SOCKET_FILTER);
@@ -1579,12 +1579,12 @@ static int fanout_set_data_ebpf(struct packet_sock *po, char __user *data,
 	return 0;
 }
 
-static int fanout_set_data(struct packet_sock *po, char __user *data,
+static int fanout_set_data(struct packet_sock *po, sockptr_t data,
 			   unsigned int len)
 {
 	switch (po->fanout->type) {
 	case PACKET_FANOUT_CBPF:
-		return fanout_set_data_cbpf(po, USER_SOCKPTR(data), len);
+		return fanout_set_data_cbpf(po, data, len);
 	case PACKET_FANOUT_EBPF:
 		return fanout_set_data_ebpf(po, data, len);
 	default:
@@ -3652,7 +3652,8 @@ static void packet_flush_mclist(struct sock *sk)
 }
 
 static int
-packet_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
+packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
+		  unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct packet_sock *po = pkt_sk(sk);
@@ -3672,7 +3673,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 			return -EINVAL;
 		if (len > sizeof(mreq))
 			len = sizeof(mreq);
-		if (copy_from_user(&mreq, optval, len))
+		if (copy_from_sockptr(&mreq, optval, len))
 			return -EFAULT;
 		if (len < (mreq.mr_alen + offsetof(struct packet_mreq, mr_address)))
 			return -EINVAL;
@@ -3703,7 +3704,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 		if (optlen < len) {
 			ret = -EINVAL;
 		} else {
-			if (copy_from_user(&req_u.req, optval, len))
+			if (copy_from_sockptr(&req_u.req, optval, len))
 				ret = -EFAULT;
 			else
 				ret = packet_set_ring(sk, &req_u, 0,
@@ -3718,7 +3719,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 
 		if (optlen != sizeof(val))
 			return -EINVAL;
-		if (copy_from_user(&val, optval, sizeof(val)))
+		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 
 		pkt_sk(sk)->copy_thresh = val;
@@ -3730,7 +3731,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 
 		if (optlen != sizeof(val))
 			return -EINVAL;
-		if (copy_from_user(&val, optval, sizeof(val)))
+		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 		switch (val) {
 		case TPACKET_V1:
@@ -3756,7 +3757,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 
 		if (optlen != sizeof(val))
 			return -EINVAL;
-		if (copy_from_user(&val, optval, sizeof(val)))
+		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 		if (val > INT_MAX)
 			return -EINVAL;
@@ -3776,7 +3777,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 
 		if (optlen != sizeof(val))
 			return -EINVAL;
-		if (copy_from_user(&val, optval, sizeof(val)))
+		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 
 		lock_sock(sk);
@@ -3795,7 +3796,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 
 		if (optlen < sizeof(val))
 			return -EINVAL;
-		if (copy_from_user(&val, optval, sizeof(val)))
+		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 
 		lock_sock(sk);
@@ -3809,7 +3810,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 
 		if (optlen < sizeof(val))
 			return -EINVAL;
-		if (copy_from_user(&val, optval, sizeof(val)))
+		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 
 		lock_sock(sk);
@@ -3825,7 +3826,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 			return -EINVAL;
 		if (optlen < sizeof(val))
 			return -EINVAL;
-		if (copy_from_user(&val, optval, sizeof(val)))
+		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 
 		lock_sock(sk);
@@ -3844,7 +3845,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 
 		if (optlen != sizeof(val))
 			return -EINVAL;
-		if (copy_from_user(&val, optval, sizeof(val)))
+		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 
 		po->tp_tstamp = val;
@@ -3856,7 +3857,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 
 		if (optlen != sizeof(val))
 			return -EINVAL;
-		if (copy_from_user(&val, optval, sizeof(val)))
+		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 
 		return fanout_add(sk, val & 0xffff, val >> 16);
@@ -3874,7 +3875,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 
 		if (optlen != sizeof(val))
 			return -EINVAL;
-		if (copy_from_user(&val, optval, sizeof(val)))
+		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 		if (val < 0 || val > 1)
 			return -EINVAL;
@@ -3888,7 +3889,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 
 		if (optlen != sizeof(val))
 			return -EINVAL;
-		if (copy_from_user(&val, optval, sizeof(val)))
+		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 
 		lock_sock(sk);
@@ -3907,7 +3908,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 
 		if (optlen != sizeof(val))
 			return -EINVAL;
-		if (copy_from_user(&val, optval, sizeof(val)))
+		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 
 		po->xmit = val ? packet_direct_xmit : dev_queue_xmit;
diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index 4577e43cb77782..e47d09aca4af46 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -975,7 +975,7 @@ static int pep_init(struct sock *sk)
 }
 
 static int pep_setsockopt(struct sock *sk, int level, int optname,
-				char __user *optval, unsigned int optlen)
+			  sockptr_t optval, unsigned int optlen)
 {
 	struct pep_sock *pn = pep_sk(sk);
 	int val = 0, err = 0;
@@ -983,7 +983,7 @@ static int pep_setsockopt(struct sock *sk, int level, int optname,
 	if (level != SOL_PNPIPE)
 		return -ENOPROTOOPT;
 	if (optlen >= sizeof(int)) {
-		if (get_user(val, (int __user *) optval))
+		if (copy_from_sockptr(&val, optval, sizeof(int)))
 			return -EFAULT;
 	}
 
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 1a5bf3fa4578b8..b239120dd9ca69 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -290,8 +290,7 @@ static int rds_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	return 0;
 }
 
-static int rds_cancel_sent_to(struct rds_sock *rs, char __user *optval,
-			      int len)
+static int rds_cancel_sent_to(struct rds_sock *rs, sockptr_t optval, int len)
 {
 	struct sockaddr_in6 sin6;
 	struct sockaddr_in sin;
@@ -308,14 +307,15 @@ static int rds_cancel_sent_to(struct rds_sock *rs, char __user *optval,
 		goto out;
 	} else if (len < sizeof(struct sockaddr_in6)) {
 		/* Assume IPv4 */
-		if (copy_from_user(&sin, optval, sizeof(struct sockaddr_in))) {
+		if (copy_from_sockptr(&sin, optval,
+				sizeof(struct sockaddr_in))) {
 			ret = -EFAULT;
 			goto out;
 		}
 		ipv6_addr_set_v4mapped(sin.sin_addr.s_addr, &sin6.sin6_addr);
 		sin6.sin6_port = sin.sin_port;
 	} else {
-		if (copy_from_user(&sin6, optval,
+		if (copy_from_sockptr(&sin6, optval,
 				   sizeof(struct sockaddr_in6))) {
 			ret = -EFAULT;
 			goto out;
@@ -327,21 +327,20 @@ static int rds_cancel_sent_to(struct rds_sock *rs, char __user *optval,
 	return ret;
 }
 
-static int rds_set_bool_option(unsigned char *optvar, char __user *optval,
+static int rds_set_bool_option(unsigned char *optvar, sockptr_t optval,
 			       int optlen)
 {
 	int value;
 
 	if (optlen < sizeof(int))
 		return -EINVAL;
-	if (get_user(value, (int __user *) optval))
+	if (copy_from_sockptr(&value, optval, sizeof(int)))
 		return -EFAULT;
 	*optvar = !!value;
 	return 0;
 }
 
-static int rds_cong_monitor(struct rds_sock *rs, char __user *optval,
-			    int optlen)
+static int rds_cong_monitor(struct rds_sock *rs, sockptr_t optval, int optlen)
 {
 	int ret;
 
@@ -358,8 +357,7 @@ static int rds_cong_monitor(struct rds_sock *rs, char __user *optval,
 	return ret;
 }
 
-static int rds_set_transport(struct rds_sock *rs, char __user *optval,
-			     int optlen)
+static int rds_set_transport(struct rds_sock *rs, sockptr_t optval, int optlen)
 {
 	int t_type;
 
@@ -369,7 +367,7 @@ static int rds_set_transport(struct rds_sock *rs, char __user *optval,
 	if (optlen != sizeof(int))
 		return -EINVAL;
 
-	if (copy_from_user(&t_type, (int __user *)optval, sizeof(t_type)))
+	if (copy_from_sockptr(&t_type, optval, sizeof(t_type)))
 		return -EFAULT;
 
 	if (t_type < 0 || t_type >= RDS_TRANS_COUNT)
@@ -380,7 +378,7 @@ static int rds_set_transport(struct rds_sock *rs, char __user *optval,
 	return rs->rs_transport ? 0 : -ENOPROTOOPT;
 }
 
-static int rds_enable_recvtstamp(struct sock *sk, char __user *optval,
+static int rds_enable_recvtstamp(struct sock *sk, sockptr_t optval,
 				 int optlen, int optname)
 {
 	int val, valbool;
@@ -388,7 +386,7 @@ static int rds_enable_recvtstamp(struct sock *sk, char __user *optval,
 	if (optlen != sizeof(int))
 		return -EFAULT;
 
-	if (get_user(val, (int __user *)optval))
+	if (copy_from_sockptr(&val, optval, sizeof(int)))
 		return -EFAULT;
 
 	valbool = val ? 1 : 0;
@@ -404,7 +402,7 @@ static int rds_enable_recvtstamp(struct sock *sk, char __user *optval,
 	return 0;
 }
 
-static int rds_recv_track_latency(struct rds_sock *rs, char __user *optval,
+static int rds_recv_track_latency(struct rds_sock *rs, sockptr_t optval,
 				  int optlen)
 {
 	struct rds_rx_trace_so trace;
@@ -413,7 +411,7 @@ static int rds_recv_track_latency(struct rds_sock *rs, char __user *optval,
 	if (optlen != sizeof(struct rds_rx_trace_so))
 		return -EFAULT;
 
-	if (copy_from_user(&trace, optval, sizeof(trace)))
+	if (copy_from_sockptr(&trace, optval, sizeof(trace)))
 		return -EFAULT;
 
 	if (trace.rx_traces > RDS_MSG_RX_DGRAM_TRACE_MAX)
@@ -432,7 +430,7 @@ static int rds_recv_track_latency(struct rds_sock *rs, char __user *optval,
 }
 
 static int rds_setsockopt(struct socket *sock, int level, int optname,
-			  char __user *optval, unsigned int optlen)
+			  sockptr_t optval, unsigned int optlen)
 {
 	struct rds_sock *rs = rds_sk_to_rs(sock->sk);
 	int ret;
diff --git a/net/rds/rdma.c b/net/rds/rdma.c
index a7ae11846cd7f5..ccdd304eae0a0a 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -353,21 +353,20 @@ static int __rds_rdma_map(struct rds_sock *rs, struct rds_get_mr_args *args,
 	return ret;
 }
 
-int rds_get_mr(struct rds_sock *rs, char __user *optval, int optlen)
+int rds_get_mr(struct rds_sock *rs, sockptr_t optval, int optlen)
 {
 	struct rds_get_mr_args args;
 
 	if (optlen != sizeof(struct rds_get_mr_args))
 		return -EINVAL;
 
-	if (copy_from_user(&args, (struct rds_get_mr_args __user *)optval,
-			   sizeof(struct rds_get_mr_args)))
+	if (copy_from_sockptr(&args, optval, sizeof(struct rds_get_mr_args)))
 		return -EFAULT;
 
 	return __rds_rdma_map(rs, &args, NULL, NULL, NULL);
 }
 
-int rds_get_mr_for_dest(struct rds_sock *rs, char __user *optval, int optlen)
+int rds_get_mr_for_dest(struct rds_sock *rs, sockptr_t optval, int optlen)
 {
 	struct rds_get_mr_for_dest_args args;
 	struct rds_get_mr_args new_args;
@@ -375,7 +374,7 @@ int rds_get_mr_for_dest(struct rds_sock *rs, char __user *optval, int optlen)
 	if (optlen != sizeof(struct rds_get_mr_for_dest_args))
 		return -EINVAL;
 
-	if (copy_from_user(&args, (struct rds_get_mr_for_dest_args __user *)optval,
+	if (copy_from_sockptr(&args, optval,
 			   sizeof(struct rds_get_mr_for_dest_args)))
 		return -EFAULT;
 
@@ -394,7 +393,7 @@ int rds_get_mr_for_dest(struct rds_sock *rs, char __user *optval, int optlen)
 /*
  * Free the MR indicated by the given R_Key
  */
-int rds_free_mr(struct rds_sock *rs, char __user *optval, int optlen)
+int rds_free_mr(struct rds_sock *rs, sockptr_t optval, int optlen)
 {
 	struct rds_free_mr_args args;
 	struct rds_mr *mr;
@@ -403,8 +402,7 @@ int rds_free_mr(struct rds_sock *rs, char __user *optval, int optlen)
 	if (optlen != sizeof(struct rds_free_mr_args))
 		return -EINVAL;
 
-	if (copy_from_user(&args, (struct rds_free_mr_args __user *)optval,
-			   sizeof(struct rds_free_mr_args)))
+	if (copy_from_sockptr(&args, optval, sizeof(struct rds_free_mr_args)))
 		return -EFAULT;
 
 	/* Special case - a null cookie means flush all unused MRs */
diff --git a/net/rds/rds.h b/net/rds/rds.h
index 106e862996b94d..d35d1fc3980766 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -924,9 +924,9 @@ int rds_send_pong(struct rds_conn_path *cp, __be16 dport);
 
 /* rdma.c */
 void rds_rdma_unuse(struct rds_sock *rs, u32 r_key, int force);
-int rds_get_mr(struct rds_sock *rs, char __user *optval, int optlen);
-int rds_get_mr_for_dest(struct rds_sock *rs, char __user *optval, int optlen);
-int rds_free_mr(struct rds_sock *rs, char __user *optval, int optlen);
+int rds_get_mr(struct rds_sock *rs, sockptr_t optval, int optlen);
+int rds_get_mr_for_dest(struct rds_sock *rs, sockptr_t optval, int optlen);
+int rds_free_mr(struct rds_sock *rs, sockptr_t optval, int optlen);
 void rds_rdma_drop_keys(struct rds_sock *rs);
 int rds_rdma_extra_size(struct rds_rdma_args *args,
 			struct rds_iov_vector *iov);
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index ce85656ac9c159..cf7d974e0f619a 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -365,7 +365,7 @@ void rose_destroy_socket(struct sock *sk)
  */
 
 static int rose_setsockopt(struct socket *sock, int level, int optname,
-	char __user *optval, unsigned int optlen)
+		sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct rose_sock *rose = rose_sk(sk);
@@ -377,7 +377,7 @@ static int rose_setsockopt(struct socket *sock, int level, int optname,
 	if (optlen < sizeof(int))
 		return -EINVAL;
 
-	if (get_user(opt, (int __user *)optval))
+	if (copy_from_sockptr(&opt, optval, sizeof(int)))
 		return -EFAULT;
 
 	switch (optname) {
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index cd7d0d204c7498..e6725a6de015fb 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -588,7 +588,7 @@ EXPORT_SYMBOL(rxrpc_sock_set_min_security_level);
  * set RxRPC socket options
  */
 static int rxrpc_setsockopt(struct socket *sock, int level, int optname,
-			    char __user *optval, unsigned int optlen)
+			    sockptr_t optval, unsigned int optlen)
 {
 	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
 	unsigned int min_sec_level;
@@ -639,8 +639,8 @@ static int rxrpc_setsockopt(struct socket *sock, int level, int optname,
 			ret = -EISCONN;
 			if (rx->sk.sk_state != RXRPC_UNBOUND)
 				goto error;
-			ret = get_user(min_sec_level,
-				       (unsigned int __user *) optval);
+			ret = copy_from_sockptr(&min_sec_level, optval,
+				       sizeof(unsigned int));
 			if (ret < 0)
 				goto error;
 			ret = -EINVAL;
@@ -658,7 +658,7 @@ static int rxrpc_setsockopt(struct socket *sock, int level, int optname,
 			if (rx->sk.sk_state != RXRPC_SERVER_BOUND2)
 				goto error;
 			ret = -EFAULT;
-			if (copy_from_user(service_upgrade, optval,
+			if (copy_from_sockptr(service_upgrade, optval,
 					   sizeof(service_upgrade)) != 0)
 				goto error;
 			ret = -EINVAL;
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 9a2139ebd67d73..6d29a3603a3e6e 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -909,8 +909,8 @@ extern const struct rxrpc_security rxrpc_no_security;
 extern struct key_type key_type_rxrpc;
 extern struct key_type key_type_rxrpc_s;
 
-int rxrpc_request_key(struct rxrpc_sock *, char __user *, int);
-int rxrpc_server_keyring(struct rxrpc_sock *, char __user *, int);
+int rxrpc_request_key(struct rxrpc_sock *, sockptr_t , int);
+int rxrpc_server_keyring(struct rxrpc_sock *, sockptr_t, int);
 int rxrpc_get_server_data_key(struct rxrpc_connection *, const void *, time64_t,
 			      u32);
 
diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index 0c98313dd7a8cb..94c3df392651b9 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -896,7 +896,7 @@ static void rxrpc_describe(const struct key *key, struct seq_file *m)
 /*
  * grab the security key for a socket
  */
-int rxrpc_request_key(struct rxrpc_sock *rx, char __user *optval, int optlen)
+int rxrpc_request_key(struct rxrpc_sock *rx, sockptr_t optval, int optlen)
 {
 	struct key *key;
 	char *description;
@@ -906,7 +906,7 @@ int rxrpc_request_key(struct rxrpc_sock *rx, char __user *optval, int optlen)
 	if (optlen <= 0 || optlen > PAGE_SIZE - 1)
 		return -EINVAL;
 
-	description = memdup_user_nul(optval, optlen);
+	description = memdup_sockptr_nul(optval, optlen);
 	if (IS_ERR(description))
 		return PTR_ERR(description);
 
@@ -926,8 +926,7 @@ int rxrpc_request_key(struct rxrpc_sock *rx, char __user *optval, int optlen)
 /*
  * grab the security keyring for a server socket
  */
-int rxrpc_server_keyring(struct rxrpc_sock *rx, char __user *optval,
-			 int optlen)
+int rxrpc_server_keyring(struct rxrpc_sock *rx, sockptr_t optval, int optlen)
 {
 	struct key *key;
 	char *description;
@@ -937,7 +936,7 @@ int rxrpc_server_keyring(struct rxrpc_sock *rx, char __user *optval,
 	if (optlen <= 0 || optlen > PAGE_SIZE - 1)
 		return -EINVAL;
 
-	description = memdup_user_nul(optval, optlen);
+	description = memdup_sockptr_nul(optval, optlen);
 	if (IS_ERR(description))
 		return PTR_ERR(description);
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 9a767f35971865..144808dfea9ee8 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4429,7 +4429,7 @@ static int sctp_setsockopt_pf_expose(struct sock *sk,
  *   optlen  - the size of the buffer.
  */
 static int sctp_setsockopt(struct sock *sk, int level, int optname,
-			   char __user *optval, unsigned int optlen)
+			   sockptr_t optval, unsigned int optlen)
 {
 	void *kopt = NULL;
 	int retval = 0;
@@ -4449,7 +4449,7 @@ static int sctp_setsockopt(struct sock *sk, int level, int optname,
 	}
 
 	if (optlen > 0) {
-		kopt = memdup_user(optval, optlen);
+		kopt = memdup_sockptr(optval, optlen);
 		if (IS_ERR(kopt))
 			return PTR_ERR(kopt);
 	}
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9711c9e0e515bf..4ac1d4de667691 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1731,7 +1731,7 @@ static int smc_shutdown(struct socket *sock, int how)
 }
 
 static int smc_setsockopt(struct socket *sock, int level, int optname,
-			  char __user *optval, unsigned int optlen)
+			  sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct smc_sock *smc;
@@ -1754,7 +1754,7 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 
 	if (optlen < sizeof(int))
 		return -EINVAL;
-	if (get_user(val, (int __user *)optval))
+	if (copy_from_sockptr(&val, optval, sizeof(int)))
 		return -EFAULT;
 
 	lock_sock(sk);
diff --git a/net/socket.c b/net/socket.c
index c97f83d879ae75..e44b8ac47f6f46 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2094,10 +2094,10 @@ static bool sock_use_custom_sol_socket(const struct socket *sock)
  *	Set a socket option. Because we don't know the option lengths we have
  *	to pass the user mode parameter for the protocols to sort out.
  */
-int __sys_setsockopt(int fd, int level, int optname, char __user *optval,
+int __sys_setsockopt(int fd, int level, int optname, char __user *user_optval,
 		int optlen)
 {
-	mm_segment_t oldfs = get_fs();
+	sockptr_t optval = USER_SOCKPTR(user_optval);
 	char *kernel_optval = NULL;
 	int err, fput_needed;
 	struct socket *sock;
@@ -2115,7 +2115,7 @@ int __sys_setsockopt(int fd, int level, int optname, char __user *optval,
 
 	if (!in_compat_syscall())
 		err = BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock->sk, &level, &optname,
-						     optval, &optlen,
+						     user_optval, &optlen,
 						     &kernel_optval);
 	if (err < 0)
 		goto out_put;
@@ -2124,25 +2124,16 @@ int __sys_setsockopt(int fd, int level, int optname, char __user *optval,
 		goto out_put;
 	}
 
-	if (kernel_optval) {
-		set_fs(KERNEL_DS);
-		optval = (char __user __force *)kernel_optval;
-	}
-
+	if (kernel_optval)
+		optval = KERNEL_SOCKPTR(kernel_optval);
 	if (level == SOL_SOCKET && !sock_use_custom_sol_socket(sock))
-		err = sock_setsockopt(sock, level, optname,
-				      USER_SOCKPTR(optval), optlen);
+		err = sock_setsockopt(sock, level, optname, optval, optlen);
 	else if (unlikely(!sock->ops->setsockopt))
 		err = -EOPNOTSUPP;
 	else
 		err = sock->ops->setsockopt(sock, level, optname, optval,
 					    optlen);
-
-	if (kernel_optval) {
-		set_fs(oldfs);
-		kfree(kernel_optval);
-	}
-
+	kfree(kernel_optval);
 out_put:
 	fput_light(sock->file, fput_needed);
 	return err;
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index fc388cef64715c..07419f36116a84 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -3103,7 +3103,7 @@ static int tipc_sk_leave(struct tipc_sock *tsk)
  * Returns 0 on success, errno otherwise
  */
 static int tipc_setsockopt(struct socket *sock, int lvl, int opt,
-			   char __user *ov, unsigned int ol)
+			   sockptr_t ov, unsigned int ol)
 {
 	struct sock *sk = sock->sk;
 	struct tipc_sock *tsk = tipc_sk(sk);
@@ -3124,17 +3124,17 @@ static int tipc_setsockopt(struct socket *sock, int lvl, int opt,
 	case TIPC_NODELAY:
 		if (ol < sizeof(value))
 			return -EINVAL;
-		if (get_user(value, (u32 __user *)ov))
+		if (copy_from_sockptr(&value, ov, sizeof(u32)))
 			return -EFAULT;
 		break;
 	case TIPC_GROUP_JOIN:
 		if (ol < sizeof(mreq))
 			return -EINVAL;
-		if (copy_from_user(&mreq, ov, sizeof(mreq)))
+		if (copy_from_sockptr(&mreq, ov, sizeof(mreq)))
 			return -EFAULT;
 		break;
 	default:
-		if (ov || ol)
+		if (!sockptr_is_null(ov) || ol)
 			return -EINVAL;
 	}
 
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index ec10041c6b7d41..d77f7d821130db 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -450,7 +450,7 @@ static int tls_getsockopt(struct sock *sk, int level, int optname,
 	return do_tls_getsockopt(sk, optname, optval, optlen);
 }
 
-static int do_tls_setsockopt_conf(struct sock *sk, char __user *optval,
+static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 				  unsigned int optlen, int tx)
 {
 	struct tls_crypto_info *crypto_info;
@@ -460,7 +460,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, char __user *optval,
 	int rc = 0;
 	int conf;
 
-	if (!optval || (optlen < sizeof(*crypto_info))) {
+	if (sockptr_is_null(optval) || (optlen < sizeof(*crypto_info))) {
 		rc = -EINVAL;
 		goto out;
 	}
@@ -479,7 +479,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, char __user *optval,
 		goto out;
 	}
 
-	rc = copy_from_user(crypto_info, optval, sizeof(*crypto_info));
+	rc = copy_from_sockptr(crypto_info, optval, sizeof(*crypto_info));
 	if (rc) {
 		rc = -EFAULT;
 		goto err_crypto_info;
@@ -522,8 +522,9 @@ static int do_tls_setsockopt_conf(struct sock *sk, char __user *optval,
 		goto err_crypto_info;
 	}
 
-	rc = copy_from_user(crypto_info + 1, optval + sizeof(*crypto_info),
-			    optlen - sizeof(*crypto_info));
+	sockptr_advance(optval, sizeof(*crypto_info));
+	rc = copy_from_sockptr(crypto_info + 1, optval,
+			       optlen - sizeof(*crypto_info));
 	if (rc) {
 		rc = -EFAULT;
 		goto err_crypto_info;
@@ -579,8 +580,8 @@ static int do_tls_setsockopt_conf(struct sock *sk, char __user *optval,
 	return rc;
 }
 
-static int do_tls_setsockopt(struct sock *sk, int optname,
-			     char __user *optval, unsigned int optlen)
+static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
+			     unsigned int optlen)
 {
 	int rc = 0;
 
@@ -600,7 +601,7 @@ static int do_tls_setsockopt(struct sock *sk, int optname,
 }
 
 static int tls_setsockopt(struct sock *sk, int level, int optname,
-			  char __user *optval, unsigned int optlen)
+			  sockptr_t optval, unsigned int optlen)
 {
 	struct tls_context *ctx = tls_get_ctx(sk);
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index df204c6761c453..27bbcfad9c1738 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1517,7 +1517,7 @@ static void vsock_update_buffer_size(struct vsock_sock *vsk,
 static int vsock_stream_setsockopt(struct socket *sock,
 				   int level,
 				   int optname,
-				   char __user *optval,
+				   sockptr_t optval,
 				   unsigned int optlen)
 {
 	int err;
@@ -1535,7 +1535,7 @@ static int vsock_stream_setsockopt(struct socket *sock,
 			err = -EINVAL;			  \
 			goto exit;			  \
 		}					  \
-		if (copy_from_user(&_v, optval, sizeof(_v)) != 0) {	\
+		if (copy_from_sockptr(&_v, optval, sizeof(_v)) != 0) {	\
 			err = -EFAULT;					\
 			goto exit;					\
 		}							\
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index d5b09bbff3754f..0bbb283f23c96f 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -431,7 +431,7 @@ void x25_destroy_socket_from_timer(struct sock *sk)
  */
 
 static int x25_setsockopt(struct socket *sock, int level, int optname,
-			  char __user *optval, unsigned int optlen)
+			  sockptr_t optval, unsigned int optlen)
 {
 	int opt;
 	struct sock *sk = sock->sk;
@@ -445,7 +445,7 @@ static int x25_setsockopt(struct socket *sock, int level, int optname,
 		goto out;
 
 	rc = -EFAULT;
-	if (get_user(opt, (int __user *)optval))
+	if (copy_from_sockptr(&opt, optval, sizeof(int)))
 		goto out;
 
 	if (opt)
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 26e3bba8c204a7..2e94a7e94671b6 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -702,7 +702,7 @@ struct xdp_umem_reg_v1 {
 };
 
 static int xsk_setsockopt(struct socket *sock, int level, int optname,
-			  char __user *optval, unsigned int optlen)
+			  sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct xdp_sock *xs = xdp_sk(sk);
@@ -720,7 +720,7 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 
 		if (optlen < sizeof(entries))
 			return -EINVAL;
-		if (copy_from_user(&entries, optval, sizeof(entries)))
+		if (copy_from_sockptr(&entries, optval, sizeof(entries)))
 			return -EFAULT;
 
 		mutex_lock(&xs->mutex);
@@ -747,7 +747,7 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 		else if (optlen < sizeof(mr))
 			mr_size = sizeof(struct xdp_umem_reg_v1);
 
-		if (copy_from_user(&mr, optval, mr_size))
+		if (copy_from_sockptr(&mr, optval, mr_size))
 			return -EFAULT;
 
 		mutex_lock(&xs->mutex);
@@ -774,7 +774,7 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 		struct xsk_queue **q;
 		int entries;
 
-		if (copy_from_user(&entries, optval, sizeof(entries)))
+		if (copy_from_sockptr(&entries, optval, sizeof(entries)))
 			return -EFAULT;
 
 		mutex_lock(&xs->mutex);
-- 
2.27.0

