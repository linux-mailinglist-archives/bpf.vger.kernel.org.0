Return-Path: <bpf+bounces-70936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A21ABDBB05
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 00:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FD8D500C46
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 22:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E7430F7FE;
	Tue, 14 Oct 2025 22:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSQXqy8A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160BD2FE07B;
	Tue, 14 Oct 2025 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481815; cv=none; b=QXzeZi+6267Fw0MSzw3E42Ve7x32DE9Tq1uFLFOgOevL3aIDCSvaCV9WEsDtFjpzMSha2CJsOl4rIaXiJooal1g2iGuwwoKVhrrl1ce3h6cfs53yBnW7Ygwcxw1/pp9lZ3AM4p1c1Jm6bupFqRIZf+2znLG7otAzBkUOOACBNkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481815; c=relaxed/simple;
	bh=SCu74n1QPb+l2An5uCSZFkG0ZSJa3rxMAjAeYpfmuRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XfzJkSzZIoK3Fh8OUQY6SwGEAepnhqBoH1cP0TQgJ4yrJiKzwDciHLnHF1rhQsY597WBvVrmNSu5oDDNM9+0czF1SGu9QSWe2QV+a5C+zDAdKKfM4lKo9PXmEfWOEKeoOhMTOXOQ3y7MTZOzN2v8KI/YP3tLJJ4NpXklDZmkFA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSQXqy8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D56C2BCB4;
	Tue, 14 Oct 2025 22:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760481814;
	bh=SCu74n1QPb+l2An5uCSZFkG0ZSJa3rxMAjAeYpfmuRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aSQXqy8AUKC5UtJny77311sXYVq1AUY7VuBjdZiQ4c/KsTDrwZVJXe5wGNUOBzSWg
	 QI6reDaaKtF5gKyuVskA8NEVj7819ABywl72FoEMsrA7KkpVoZ5SwsoHYPJ2k+nFxf
	 GLMxNzgHb2wi+skpXBiJNtHY2V95WPhdWGwPuQP5mAFUP4B1Px+f2l02Go2LKU/YRK
	 Lket5ITuS3H/pP880YX/ErXPPOfO5zimbBDjnfQNpyRK9nzhyfnCqE2xqBBqTm9F43
	 K0rV9ff+iUubu9CK9jGNLjvalsTWn2gKVzXJy7jjNSuWv1AeNZdOLwpKRpquyY8zCd
	 HUlt7Qy/USmgw==
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
Subject: [PATCH v2 10/10] net: Convert struct sockaddr to fixed-size "sa_data[14]"
Date: Tue, 14 Oct 2025 15:43:32 -0700
Message-Id: <20251014224334.2344521-10-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014223349.it.173-kees@kernel.org>
References: <20251014223349.it.173-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5439; i=kees@kernel.org; h=from:subject; bh=SCu74n1QPb+l2An5uCSZFkG0ZSJa3rxMAjAeYpfmuRs=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnvLglHni+0KhBxmfq1hiHc+Z380vp3eaJBtjMdM85M0 pT7cOBoRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwESCeBgZzvpU3FvHdUNJ96Hi DkVFpoVGXGb7Eg/M1wzeJztjiWy6GSPDYuFzd13uCnxb6ZdtPIl9+87IwCP/Nznbfg9UOTvt+Y9 dDAA=
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


