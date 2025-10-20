Return-Path: <bpf+bounces-71457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB5DBF3BDE
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 23:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997D8421DA2
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 21:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59E0337113;
	Mon, 20 Oct 2025 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWupwVqu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CF8334C29;
	Mon, 20 Oct 2025 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995600; cv=none; b=RD02tbJIz66BSoeaiFucm2kQ4UNcvdvjkIeZgOmeGJZZm4OhhmyvB5yf879gg+nHaCBy8mxk3eKmNdKof7pzBgqAbM0Jg3aEmVBnSNTtugEABEUhsAYyexJU8EJj73mW169qQradOy4D7ymz1GIh8YCrCAVG8zipI7uIkwrtiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995600; c=relaxed/simple;
	bh=SCu74n1QPb+l2An5uCSZFkG0ZSJa3rxMAjAeYpfmuRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BlOvyZLwXTEKi/vo3aBcQ43ZS4nUxLP493b4pZKkJ4WDu2IpL7a2t4zoK3enNZKVGzqZqCEkRI6sGoP5Cj3yN0vJX/DwSOBMQd8c+kD1Hc+kRdFYu6NL9gwL2MPdS62w2aiqVC9nrgB3u33KqfFdsBvUxoabdn/e1MPtU1onf0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWupwVqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185C1C2BCAF;
	Mon, 20 Oct 2025 21:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760995600;
	bh=SCu74n1QPb+l2An5uCSZFkG0ZSJa3rxMAjAeYpfmuRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PWupwVquFABXyx8izrOyH52uk+n0bjRp8LX/1IgdPgsNptGbdJBrNFTZStQZy2NET
	 MRDXy3XtQmsfErftOnBRL5OvCdALn0TsB6BI0ZWHFjWAuaspwylFY0s2o2y7hRcSSN
	 cq6jBigAeM/SlwpgTJvQ0VyckhiZJjpSlta4s8uvEGwruoBBXmYkrurvepp3HXoRN0
	 9/CYz4YUMWNXy2nYvb4wdk3swoIkdAtVoxSyS5JC6qhdcbh3ouOjjCM0SY7rbY8D2B
	 NivoEJ2iad/bXqaavfxBXq44x8WMvr24e3f2wguIgUQeDb5OMiPQHg8qBkM/Fz/kj+
	 BdZDDl9hHTgig==
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
Subject: [PATCH v3 9/9] net: Convert struct sockaddr to fixed-size "sa_data[14]"
Date: Mon, 20 Oct 2025 14:26:38 -0700
Message-Id: <20251020212639.1223484-9-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020212125.make.115-kees@kernel.org>
References: <20251020212125.make.115-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5439; i=kees@kernel.org; h=from:subject; bh=SCu74n1QPb+l2An5uCSZFkG0ZSJa3rxMAjAeYpfmuRs=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnfVvJGni+0KhBxmfq1hiHc+Z380vp3eaJBtjMdM85M0 pT7cOBoRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwETuGDIy/O7Tr2lO0nmlWXnO 5TjP3JV7lXSk4/IdlN0nnrloL2O7i5Fh8qPbtRIqshZ6U9xOvD6YFnWL27Cxofr+BEdmXrVvLF+ YAQ==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Revert struct sockaddr from flexible array to fixed 14-byte "sa_data",
solves over 36,000 -Wflex-array-member-not-at-end warnings, since struct
sockaddr is embedded within many network structs.

With socket/proto sockaddr-based internal APIs switched to use struct
sockaddr_unspec, there should be no more uses of struct sockaddr that
depend on reading beyond the end of struct sockaddr::sa_data that might
trigger bounds checking.

Comparing an x86_64 "allyesconfig" vmlinux build before and after this
patch showed no new "ud1" instructions from CONFIG_UBSAN_BOUNDS nor any
explicit "field-spanning" memcpy CONFIG_FORTIFY_SOURCE instrumentations.

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
index 27f57c7ee02a..5e9d83cec850 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -32,12 +32,10 @@ typedef __kernel_sa_family_t	sa_family_t;
  *	1003.1g requires sa_family_t and that sa_data is char.
  */
 
+/* Deprecated for in-kernel use. Use struct sockaddr_unspec instead. */
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
index a64cef2c537e..6dc5861f87b0 100644
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
index 73bea76ea45d..d21483cae94f 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3284,7 +3284,7 @@ static int packet_bind_spkt(struct socket *sock, struct sockaddr_unspec *uaddr,
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr *sa = (struct sockaddr *)uaddr;
-	char name[sizeof(sa->sa_data_min) + 1];
+	char name[sizeof(sa->sa_data) + 1];
 
 	/*
 	 *	Check legality
@@ -3295,8 +3295,8 @@ static int packet_bind_spkt(struct socket *sock, struct sockaddr_unspec *uaddr,
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


