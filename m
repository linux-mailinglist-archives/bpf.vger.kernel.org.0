Return-Path: <bpf+bounces-72908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEFFC1D7D0
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 22:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B463B3B5B51
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 21:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C38732D437;
	Wed, 29 Oct 2025 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5S9LhPd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2153F31B830;
	Wed, 29 Oct 2025 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774269; cv=none; b=cF6IEh6uK0CG2qhrH1MKb7lg6/y5GRHltj8+gWHl3Euo//vRevWjHtdaGRVOD9/r+zzP9C+9CEv56xzU13JXVXTX85gHtaO5gwdsvNGlxvp7YTait6S6jbB9VCIgfimRJARrzfeW4p34rj0OkHrrJlxAPx4GUQ1deshhVthryzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774269; c=relaxed/simple;
	bh=vt9ux/r4/zsVulKw+GrtHYCH8WIHFA6hZ/6+L1YSLVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M/vugwpfEscVOv3h/0IQU3EahTNvLX8JX8BFIJJ8+6ofP4pT/v2LuRjTRw/q+zSxA1ZqQQFoB47mJUKTdvYAaq2n1y/wAELLYylyWlzIBOwuaL+3hQ0uiZ5MN95NEN9bwnJCb1T9L3iJSsZw6jtKBRIsIUNvT6dQQnYE4s4AUlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5S9LhPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A529BC2BCB1;
	Wed, 29 Oct 2025 21:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761774268;
	bh=vt9ux/r4/zsVulKw+GrtHYCH8WIHFA6hZ/6+L1YSLVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5S9LhPdW/vMsLHHMms7O0WD+F9QtwkWhbIkUnKhFbfigYlnYEYbpILUeT28/HRzd
	 EWg88r5vFo7B7jndJ760XU+Rv/Nd0exKqVNtEmQ06kwDQxQLcOi2jCPc/VY96y69si
	 +GvtwI7OeoM8vL7NLfB88X/dBrQ6um/OYjhe4v19Zg1IrdJD98kE9Gk+VVDGTVjjJD
	 zcIvFu0xunMu/MZkqhMJhBuH4cbS6y3SzBPDGn0dTVJh5UuydlpfKiVHWdh0lc/OAC
	 Uilg1VTFU5Yab3BBd6g8mk2/k/X6/J4q5wYpHOUO6/AVLIt73bAN6jLxsjAYy/rd0e
	 PRLfCQHKd8C+g==
From: Kees Cook <kees@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
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
Subject: [net-next PATCH v4 7/7] net: Convert struct sockaddr to fixed-size "sa_data[14]"
Date: Wed, 29 Oct 2025 14:44:04 -0700
Message-Id: <20251029214428.2467496-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029214355.work.602-kees@kernel.org>
References: <20251029214355.work.602-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5440; i=kees@kernel.org; h=from:subject; bh=vt9ux/r4/zsVulKw+GrtHYCH8WIHFA6hZ/6+L1YSLVk=; b=owGbwMvMwCVmps19z/KJym7G02pJDJlMXYuzb7V2Z63fua3wgM+Bls6nLdJdb56tT9TLfr5ZL c11n3RSRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwET8nRkZLql7n97fvS/I4ciN NW9armdKzTl8KnfVSx291w2XhJq/SjEyNDUuPrs8Z11Ou+fVgi/uycE/smZe4OBda7E+R8ptxW4 LPgA=
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

Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
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
index 2acfa44927da..e29b67ad124f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9885,7 +9885,7 @@ DECLARE_RWSEM(dev_addr_sem);
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
index 833f2cf97178..8316ca59088a 100644
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


