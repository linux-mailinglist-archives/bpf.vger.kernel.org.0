Return-Path: <bpf+bounces-73402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A03FC2E972
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 01:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C180F3BF470
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 00:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F4821E097;
	Tue,  4 Nov 2025 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyuNl6cS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A3C1DF73A;
	Tue,  4 Nov 2025 00:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215978; cv=none; b=b4ZOVrg2Z7R1NsJqD3mhLQfoDphKDYy5/IBtf728AEJ5/gYpdkGexgtHpwHxTZmhgvIBxEjASUAPYpYIk+t9/lPd2kTgAqlfVDMyjVnJWSxhVESzVH56i0D+2BGYBGXRDJVI2xKnBmX1hHmA6tEC2fqtjfA9j4vC5kws1+IzDjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215978; c=relaxed/simple;
	bh=h9qVPr5wmZiEP5RXjW8UY6IDzbdd+PZL37PTBxL5oHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oZyXvDaNlsraO5XNJsYhJnLy+DCwLO9S86G9FYyodSMbKtPwRTLt1Glp/kuZhs+wvXcYEcPGbxziNqlz+LmLcELCInLB9TvfedGlsoPRlbNmrJZcSaOOf/TVvUvGKmIfmHXYC9cMG9Bddxr8kJC6txU7+qEm0O5ec3HqETsP4tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyuNl6cS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B03BC2BCB6;
	Tue,  4 Nov 2025 00:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762215978;
	bh=h9qVPr5wmZiEP5RXjW8UY6IDzbdd+PZL37PTBxL5oHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JyuNl6cSg4lwSpHU5FkSN7/ea9ozvoKEURGwzt/d5ExqvtrXU/Ybi+MqbgwScXnKq
	 AWzxs9fXzHRnieQ4l+L859iAl0OcVjbGCet0Q+VxM53sVrZ2QpbvELC442cgv8vAKH
	 nvfIskOmxq52WLvvqT6YlRchZnggu+lQks8KIUT7EHnDFJkLZ0itJkoak3UeHod1V9
	 lFkj4k2iePbqaLy7BF+B3EyUOQJfYLR60Pk2w+aSE8o6NdInPgLgf47OKwtHDa0YCi
	 2paYpLTiP5bPI3knnS90QgmxNU2CXKoMU2mL63iRx7KXghylgr3E4JlQe9Lcpv3OLl
	 RQaCLK229m1PA==
From: Kees Cook <kees@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	Jakub Kicinski <kuba@kernel.org>,
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
Subject: [PATCH net-next v5 8/8] net: Convert struct sockaddr to fixed-size "sa_data[14]"
Date: Mon,  3 Nov 2025 16:26:16 -0800
Message-Id: <20251104002617.2752303-8-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104002608.do.383-kees@kernel.org>
References: <20251104002608.do.383-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5438; i=kees@kernel.org; h=from:subject; bh=h9qVPr5wmZiEP5RXjW8UY6IDzbdd+PZL37PTBxL5oHw=; b=owGbwMvMwCVmps19z/KJym7G02pJDJmcHuoWE/Z/262s0Ch/uvvylIMXggSKmu/4vM3VatVeG yS396RPRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwETObGFk6K91nKgQNsdG9DGD 1lZuDa1VbQsfzdrD1z7pm9Mc9qtbLzIydGwzuljyb+oMlaLUu43qbvWXtieyrPt42um+rMR7NbE oXgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Revert struct sockaddr from flexible array to fixed 14-byte "sa_data",
to solve over 36,000 -Wflex-array-member-not-at-end warnings, since
struct sockaddr is embedded within many network structs.

With socket/proto sockaddr-based internal APIs switched to use struct
sockaddr_unsized, there should be no more uses of struct sockaddr that
depend on reading beyond the end of struct sockaddr::sa_data that might
trigger bounds checking.

Comparing an x86_64 "allyesconfig" vmlinux build before and after this
patch showed no new "ud1" instructions from CONFIG_UBSAN_BOUNDS nor any
new "field-spanning" memcpy CONFIG_FORTIFY_SOURCE instrumentations.

Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/socket.h                         |  6 ++----
 tools/perf/trace/beauty/include/linux/socket.h |  5 +----
 net/core/dev.c                                 |  2 +-
 net/core/dev_ioctl.c                           |  2 +-
 net/ipv4/arp.c                                 |  2 +-
 net/packet/af_packet.c                         | 10 +++++-----
 6 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 7b1a01be29da..944027f9765e 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -32,12 +32,10 @@ typedef __kernel_sa_family_t	sa_family_t;
  *	1003.1g requires sa_family_t and that sa_data is char.
  */
 
+/* Deprecated for in-kernel use. Use struct sockaddr_unsized instead. */
 struct sockaddr {
 	sa_family_t	sa_family;	/* address family, AF_xxx	*/
-	union {
-		char sa_data_min[14];		/* Minimum 14 bytes of protocol address	*/
-		DECLARE_FLEX_ARRAY(char, sa_data);
-	};
+	char		sa_data[14];	/* 14 bytes of protocol address	*/
 };
 
 /**
diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index 3b262487ec06..77d7c59f5d8b 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -34,10 +34,7 @@ typedef __kernel_sa_family_t	sa_family_t;
 
 struct sockaddr {
 	sa_family_t	sa_family;	/* address family, AF_xxx	*/
-	union {
-		char sa_data_min[14];		/* Minimum 14 bytes of protocol address	*/
-		DECLARE_FLEX_ARRAY(char, sa_data);
-	};
+	char		sa_data[14];	/* 14 bytes of protocol address	*/
 };
 
 struct linger {
diff --git a/net/core/dev.c b/net/core/dev.c
index 8e862a48e0a6..c38405dce744 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9936,7 +9936,7 @@ DECLARE_RWSEM(dev_addr_sem);
 /* "sa" is a true struct sockaddr with limited "sa_data" member. */
 int netif_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
 {
-	size_t size = sizeof(sa->sa_data_min);
+	size_t size = sizeof(sa->sa_data);
 	struct net_device *dev;
 	int ret = 0;
 
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index ad54b12d4b4c..b3ce0fb24a69 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -596,7 +596,7 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 		if (ifr->ifr_hwaddr.sa_family != dev->type)
 			return -EINVAL;
 		memcpy(dev->broadcast, ifr->ifr_hwaddr.sa_data,
-		       min(sizeof(ifr->ifr_hwaddr.sa_data_min),
+		       min(sizeof(ifr->ifr_hwaddr.sa_data),
 			   (size_t)dev->addr_len));
 		netdev_lock_ops(dev);
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index f3bfecf8a234..7f3863daaa40 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1189,7 +1189,7 @@ static int arp_req_get(struct net *net, struct arpreq *r)
 
 	read_lock_bh(&neigh->lock);
 	memcpy(r->arp_ha.sa_data, neigh->ha,
-	       min(dev->addr_len, sizeof(r->arp_ha.sa_data_min)));
+	       min(dev->addr_len, sizeof(r->arp_ha.sa_data)));
 	r->arp_flags = arp_state_to_flags(neigh);
 	read_unlock_bh(&neigh->lock);
 
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index fccad2a529cc..494d628d10a5 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3284,7 +3284,7 @@ static int packet_bind_spkt(struct socket *sock, struct sockaddr_unsized *uaddr,
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr *sa = (struct sockaddr *)uaddr;
-	char name[sizeof(sa->sa_data_min) + 1];
+	char name[sizeof(sa->sa_data) + 1];
 
 	/*
 	 *	Check legality
@@ -3295,8 +3295,8 @@ static int packet_bind_spkt(struct socket *sock, struct sockaddr_unsized *uaddr,
 	/* uaddr->sa_data comes from the userspace, it's not guaranteed to be
 	 * zero-terminated.
 	 */
-	memcpy(name, sa->sa_data, sizeof(sa->sa_data_min));
-	name[sizeof(sa->sa_data_min)] = 0;
+	memcpy(name, sa->sa_data, sizeof(sa->sa_data));
+	name[sizeof(sa->sa_data)] = 0;
 
 	return packet_do_bind(sk, name, 0, 0);
 }
@@ -3581,11 +3581,11 @@ static int packet_getname_spkt(struct socket *sock, struct sockaddr *uaddr,
 		return -EOPNOTSUPP;
 
 	uaddr->sa_family = AF_PACKET;
-	memset(uaddr->sa_data, 0, sizeof(uaddr->sa_data_min));
+	memset(uaddr->sa_data, 0, sizeof(uaddr->sa_data));
 	rcu_read_lock();
 	dev = dev_get_by_index_rcu(sock_net(sk), READ_ONCE(pkt_sk(sk)->ifindex));
 	if (dev)
-		strscpy(uaddr->sa_data, dev->name, sizeof(uaddr->sa_data_min));
+		strscpy(uaddr->sa_data, dev->name, sizeof(uaddr->sa_data));
 	rcu_read_unlock();
 
 	return sizeof(*uaddr);
-- 
2.34.1


