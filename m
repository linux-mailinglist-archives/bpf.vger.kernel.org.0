Return-Path: <bpf+bounces-15324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 482437F0438
	for <lists+bpf@lfdr.de>; Sun, 19 Nov 2023 04:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA9C1F21051
	for <lists+bpf@lfdr.de>; Sun, 19 Nov 2023 03:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1574A22;
	Sun, 19 Nov 2023 03:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBdsCaJG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C751186D;
	Sun, 19 Nov 2023 03:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2FBC433C8;
	Sun, 19 Nov 2023 03:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700364611;
	bh=cF0DfcV5jamol5ijl6UjVG5UKkxViwvd/MyyuGVd+BA=;
	h=From:To:Cc:Subject:Date:From;
	b=hBdsCaJGdZ2wVZzBQvYwx5V2OQ7oa1M6OoRgE+VCZa8PfHDjXti9f1yOfblQk/KTg
	 +dd0jNGo67QWr12l2Cq/M+PM1jQnRtaw4rvcncHpW4tBNsXok+ZpXXGgqpM8ims2Qs
	 fEqrRIfMTusjsz3AIa8q/dPzRlG39Hmjx786uNOSNo8Yk6mhDqxjbovL/mYOnNWHhx
	 5LxQyp4jHWNk0xJuEMNIBChxBJQ2MCGzLoMHaQZKEZd4bfWExXuiYoD3l6C3QYBsbq
	 oeBgzCVmCciQRtownB0jtrgft1lcJ1Zg0QXOjXdGUDrIVNHB4ECYLWOViNUGzu+Ywv
	 Kx5CeLAXoPFAw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	jmaloy@redhat.com,
	ying.xue@windriver.com,
	sgarzare@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	kuniyu@amazon.com,
	mptcp@lists.linux.dev,
	linux-sctp@vger.kernel.org,
	linux-s390@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net] net: fill in MODULE_DESCRIPTION()s for SOCK_DIAG modules
Date: Sat, 18 Nov 2023 19:30:06 -0800
Message-ID: <20231119033006.442271-1-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to all the sock diag modules in one fell swoop.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: dsahern@kernel.org
CC: matttbe@kernel.org
CC: martineau@kernel.org
CC: marcelo.leitner@gmail.com
CC: lucien.xin@gmail.com
CC: kgraul@linux.ibm.com
CC: wenjia@linux.ibm.com
CC: jaka@linux.ibm.com
CC: alibuda@linux.alibaba.com
CC: tonylu@linux.alibaba.com
CC: guwen@linux.alibaba.com
CC: jmaloy@redhat.com
CC: ying.xue@windriver.com
CC: sgarzare@redhat.com
CC: bjorn@kernel.org
CC: magnus.karlsson@intel.com
CC: maciej.fijalkowski@intel.com
CC: kuniyu@amazon.com
CC: mptcp@lists.linux.dev
CC: linux-sctp@vger.kernel.org
CC: linux-s390@vger.kernel.org
CC: tipc-discussion@lists.sourceforge.net
CC: virtualization@lists.linux.dev
CC: bpf@vger.kernel.org
---
 net/ipv4/inet_diag.c   | 1 +
 net/ipv4/raw_diag.c    | 1 +
 net/ipv4/tcp_diag.c    | 1 +
 net/ipv4/udp_diag.c    | 1 +
 net/mptcp/mptcp_diag.c | 1 +
 net/packet/diag.c      | 1 +
 net/sctp/diag.c        | 1 +
 net/smc/smc_diag.c     | 1 +
 net/tipc/diag.c        | 1 +
 net/unix/diag.c        | 1 +
 net/vmw_vsock/diag.c   | 1 +
 net/xdp/xsk_diag.c     | 1 +
 12 files changed, 12 insertions(+)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index f01aee832aab..7d0e7aaa71e0 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -1481,5 +1481,6 @@ static void __exit inet_diag_exit(void)
 module_init(inet_diag_init);
 module_exit(inet_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("INET/INET6: socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 2 /* AF_INET */);
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 10 /* AF_INET6 */);
diff --git a/net/ipv4/raw_diag.c b/net/ipv4/raw_diag.c
index 63a40e4b678f..fe2140c8375c 100644
--- a/net/ipv4/raw_diag.c
+++ b/net/ipv4/raw_diag.c
@@ -257,5 +257,6 @@ static void __exit raw_diag_exit(void)
 module_init(raw_diag_init);
 module_exit(raw_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RAW socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 2-255 /* AF_INET - IPPROTO_RAW */);
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 10-255 /* AF_INET6 - IPPROTO_RAW */);
diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index 01b50fa79189..4cbe4b44425a 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -247,4 +247,5 @@ static void __exit tcp_diag_exit(void)
 module_init(tcp_diag_init);
 module_exit(tcp_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("TCP socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 2-6 /* AF_INET - IPPROTO_TCP */);
diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
index de3f2d31f510..dc41a22ee80e 100644
--- a/net/ipv4/udp_diag.c
+++ b/net/ipv4/udp_diag.c
@@ -296,5 +296,6 @@ static void __exit udp_diag_exit(void)
 module_init(udp_diag_init);
 module_exit(udp_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("UDP socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 2-17 /* AF_INET - IPPROTO_UDP */);
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 2-136 /* AF_INET - IPPROTO_UDPLITE */);
diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 8df1bdb647e2..5409c2ea3f57 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -245,4 +245,5 @@ static void __exit mptcp_diag_exit(void)
 module_init(mptcp_diag_init);
 module_exit(mptcp_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MPTCP socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 2-262 /* AF_INET - IPPROTO_MPTCP */);
diff --git a/net/packet/diag.c b/net/packet/diag.c
index f6b200cb3c06..9a7980e3309d 100644
--- a/net/packet/diag.c
+++ b/net/packet/diag.c
@@ -262,4 +262,5 @@ static void __exit packet_diag_exit(void)
 module_init(packet_diag_init);
 module_exit(packet_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PACKET socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 17 /* AF_PACKET */);
diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index c3d6b92dd386..eb05131ff1dd 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -527,4 +527,5 @@ static void __exit sctp_diag_exit(void)
 module_init(sctp_diag_init);
 module_exit(sctp_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SCTP socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 2-132);
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 7ff2152971a5..a584613aca12 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -268,5 +268,6 @@ static void __exit smc_diag_exit(void)
 module_init(smc_diag_init);
 module_exit(smc_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SMC socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 43 /* AF_SMC */);
 MODULE_ALIAS_GENL_FAMILY(SMCR_GENL_FAMILY_NAME);
diff --git a/net/tipc/diag.c b/net/tipc/diag.c
index 73137f4aeb68..18733451c9e0 100644
--- a/net/tipc/diag.c
+++ b/net/tipc/diag.c
@@ -113,4 +113,5 @@ module_init(tipc_diag_init);
 module_exit(tipc_diag_exit);
 
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("TIPC socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, AF_TIPC);
diff --git a/net/unix/diag.c b/net/unix/diag.c
index 616b55c5b890..bec09a3a1d44 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -339,4 +339,5 @@ static void __exit unix_diag_exit(void)
 module_init(unix_diag_init);
 module_exit(unix_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("UNIX socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 1 /* AF_LOCAL */);
diff --git a/net/vmw_vsock/diag.c b/net/vmw_vsock/diag.c
index a2823b1c5e28..2e29994f92ff 100644
--- a/net/vmw_vsock/diag.c
+++ b/net/vmw_vsock/diag.c
@@ -174,5 +174,6 @@ static void __exit vsock_diag_exit(void)
 module_init(vsock_diag_init);
 module_exit(vsock_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("VMware Virtual Sockets monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG,
 			       40 /* AF_VSOCK */);
diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
index 22b36c8143cf..9f8955367275 100644
--- a/net/xdp/xsk_diag.c
+++ b/net/xdp/xsk_diag.c
@@ -211,4 +211,5 @@ static void __exit xsk_diag_exit(void)
 module_init(xsk_diag_init);
 module_exit(xsk_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("XDP socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, AF_XDP);
-- 
2.42.0


