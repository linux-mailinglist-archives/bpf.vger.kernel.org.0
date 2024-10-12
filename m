Return-Path: <bpf+bounces-41798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4E999B0A0
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 06:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60BC5B23350
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 04:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198AE129E9C;
	Sat, 12 Oct 2024 04:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoY6tOEz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA7A41;
	Sat, 12 Oct 2024 04:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728706027; cv=none; b=KpZWQe0eTXSNz2Inm+cF64gnMXFsAzqYcA02VU9PjAmKRZqa/1kKEv4YaLqsEUzGghOz9bnoBYBCCbepiqqceSF16AAKIucqQAgNg3Lk+cWdpKcoWbaMEkNY6OVz+bq5/tsN8++iGqrxfwIJqQop7CGCXsroydjnjBROo2rqwis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728706027; c=relaxed/simple;
	bh=wJnv0tTqU0CMlRstJzGHN2WlH8u1NBlKQiQvV5YyzXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VpDLQNnn5wrzQYrNw66WkoUBsxVx72PZZ38B1Arnxpg2AqDil0u8u2SlVGwYUSGg2dsyCphH5PRVnWU7g0LnHjak0qFMppguk9jiqZ6Mej8verbGhhM/MDpnQnITClMxUzsJzG5GXazJdMaVrAY8arVwsp9+NYHAN4UbOSzieWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoY6tOEz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ca1b6a80aso11020035ad.2;
        Fri, 11 Oct 2024 21:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728706025; x=1729310825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhkJToL5ye2pJS5PepNqyb+cP4g8tXstix29oTK5pK0=;
        b=VoY6tOEzdcb8Qb8iQgMpuVPAc2RH5aOwDB9K57ru4xOI0w3gMCWM/5UxBAAkvYCfNw
         +GeelSGptKt5tQ+4MJMYg7bmb1IVmd6BlX2n/R661pbUb11IKGXQBCJgqgYJEmL3PpSW
         jDAFIvOdlVQ/wx+/nujMX0FaAGAAMw8jGp3gl/UynPYYh/6IEvDQH1z5KzR6RA+ecGVE
         VU28TFuyD9uyYKS38ClJMPkYmY2JFDUtvEiP/25x0UpV7m99g6rdEimLUNzQfN3RtnTn
         yT4Hkac8CsTGbdzJzsiVU6F12IpO6LpdmruXPkxMAsWmpwiMDPRI99IomiK7XKJAJSR4
         oKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728706025; x=1729310825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhkJToL5ye2pJS5PepNqyb+cP4g8tXstix29oTK5pK0=;
        b=IND1unF2XaLKB7zK/6PxdN+pBOmwRansWeb+qh+oJwlxelIYjK31ENO1r8fpfGcdBO
         SDITb7eLlbrRfWa89iLnkpuBmjQDwPY+epPtdfVLbmrluQ6/H/yfoxsmb3f5sJXI6FZW
         qeTXJx8qIbaa+gr9+Su1u2PNkzlvwHuqfy+bXN5rr2rUPAlkRZizdWmqmlmTLw6JQ/tD
         Yr/e8WjZJrwzBw4EjnJ5Dvnt3aoJT9cK8/lYyEb19MlZclMaz6jeCu/w9+qCgJ83FfUJ
         oDSL278ZVqCrridniLsjYuO4mpSWLaHECnkM6MFqevf+GEAzu8LJRmLRIlDCkDuaIL+S
         7wfg==
X-Forwarded-Encrypted: i=1; AJvYcCVHRO7AePR3Z8TF3ItxGX24xw+lSrjIp9ipn/bKGupNJrVRGh7Hwv+5icvJkVS1ZXfKjGsSDyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx08nGj78Nce3U8b8faHJCxjX1wOCn4a4P+S02owo0r7vhdq7Xn
	5RvZ3R4u+ZfzQWUXUjL3spn1v6FXYGlqlpHQS70qUgdENBEM1AT4
X-Google-Smtp-Source: AGHT+IHOLIcJ60eI2w8jPC3Z8ZS0BpXVxWlubAW59YeZgPgao9Z5i1/92kajeuVfEF93/Yq+L2qu7A==
X-Received: by 2002:a17:903:22d1:b0:20c:79f1:fee9 with SMTP id d9443c01a7336-20cbb183470mr34035755ad.11.1728706024915;
        Fri, 11 Oct 2024 21:07:04 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c21301dsm30939685ad.199.2024.10.11.21.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:07:04 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 01/12] net-timestamp: introduce socket tsflag requestors
Date: Sat, 12 Oct 2024 12:06:40 +0800
Message-Id: <20241012040651.95616-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241012040651.95616-1-kerneljasonxing@gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

We need a separate tsflag to control bpf extension feature so that
we will not affect the behaviors of existing applications.

The idea of introducing requestors for better extension (not only
serving bpf extension) comes from Vadim Fedorenko.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/ip.h       |  2 +-
 include/net/sock.h     | 15 +++++++++++----
 net/can/j1939/socket.c |  2 +-
 net/core/skbuff.c      |  5 +++--
 net/core/sock.c        |  8 ++++----
 net/ipv4/ip_output.c   |  2 +-
 net/ipv4/ip_sockglue.c |  2 +-
 net/ipv4/tcp.c         |  2 +-
 net/ipv6/ip6_output.c  |  2 +-
 net/ipv6/ping.c        |  2 +-
 net/ipv6/raw.c         |  2 +-
 net/ipv6/udp.c         |  2 +-
 net/sctp/socket.c      |  2 +-
 net/socket.c           |  4 ++--
 14 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index bab084df1567..b0a836aebc33 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -96,7 +96,7 @@ static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
 	ipcm_init(ipcm);
 
 	ipcm->sockc.mark = READ_ONCE(inet->sk.sk_mark);
-	ipcm->sockc.tsflags = READ_ONCE(inet->sk.sk_tsflags);
+	ipcm->sockc.tsflags = READ_ONCE(inet->sk.sk_tsflags[SOCKETOPT_TS_REQUESTOR]);
 	ipcm->oif = READ_ONCE(inet->sk.sk_bound_dev_if);
 	ipcm->addr = inet->inet_saddr;
 	ipcm->protocol = inet->inet_num;
diff --git a/include/net/sock.h b/include/net/sock.h
index b32f1424ecc5..8cf278c957b3 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -234,6 +234,13 @@ struct sock_common {
 struct bpf_local_storage;
 struct sk_filter;
 
+enum {
+	SOCKETOPT_TS_REQUESTOR = 0,
+	BPFPROG_TS_REQUESTOR,
+
+	__MAX_TS_REQUESTOR,
+};
+
 /**
   *	struct sock - network layer representation of sockets
   *	@__sk_common: shared layout with inet_timewait_sock
@@ -444,7 +451,7 @@ struct sock {
 	socket_lock_t		sk_lock;
 	u32			sk_reserved_mem;
 	int			sk_forward_alloc;
-	u32			sk_tsflags;
+	u32			sk_tsflags[__MAX_TS_REQUESTOR];
 	__cacheline_group_end(sock_write_rxtx);
 
 	__cacheline_group_begin(sock_write_tx);
@@ -1809,7 +1816,7 @@ static inline void sockcm_init(struct sockcm_cookie *sockc,
 			       const struct sock *sk)
 {
 	*sockc = (struct sockcm_cookie) {
-		.tsflags = READ_ONCE(sk->sk_tsflags)
+		.tsflags = READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR])
 	};
 }
 
@@ -2617,7 +2624,7 @@ static inline void
 sock_recv_timestamp(struct msghdr *msg, struct sock *sk, struct sk_buff *skb)
 {
 	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
-	u32 tsflags = READ_ONCE(sk->sk_tsflags);
+	u32 tsflags = READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR]);
 	ktime_t kt = skb->tstamp;
 	/*
 	 * generate control messages if
@@ -2652,7 +2659,7 @@ static inline void sock_recv_cmsgs(struct msghdr *msg, struct sock *sk,
 			   SOF_TIMESTAMPING_RAW_HARDWARE)
 
 	if (sk->sk_flags & FLAGS_RECV_CMSGS ||
-	    READ_ONCE(sk->sk_tsflags) & TSFLAGS_ANY)
+	    READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR]) & TSFLAGS_ANY)
 		__sock_recv_cmsgs(msg, sk, skb);
 	else if (unlikely(sock_flag(sk, SOCK_TIMESTAMP)))
 		sock_write_timestamp(sk, skb->tstamp);
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 305dd72c844c..8f5799930a93 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -996,7 +996,7 @@ static void __j1939_sk_errqueue(struct j1939_session *session, struct sock *sk,
 	if (!(jsk->state & J1939_SOCK_ERRQUEUE))
 		return;
 
-	tsflags = READ_ONCE(sk->sk_tsflags);
+	tsflags = READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR]);
 	switch (type) {
 	case J1939_ERRQUEUE_TX_ACK:
 		if (!(tsflags & SOF_TIMESTAMPING_TX_ACK))
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 00afeb90c23a..ab0a59f1e14d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5490,7 +5490,8 @@ static void __skb_complete_tx_timestamp(struct sk_buff *skb,
 	serr->ee.ee_info = tstype;
 	serr->opt_stats = opt_stats;
 	serr->header.h4.iif = skb->dev ? skb->dev->ifindex : 0;
-	if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
+	if (READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR]) &
+	    SOF_TIMESTAMPING_OPT_ID) {
 		serr->ee.ee_data = skb_shinfo(skb)->tskey;
 		if (sk_is_tcp(sk))
 			serr->ee.ee_data -= atomic_read(&sk->sk_tskey);
@@ -5551,7 +5552,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (!sk)
 		return;
 
-	tsflags = READ_ONCE(sk->sk_tsflags);
+	tsflags = READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR]);
 	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
 	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
 		return;
diff --git a/net/core/sock.c b/net/core/sock.c
index 083d438d8b6f..52c8c5a5ba27 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -908,7 +908,7 @@ int sock_set_timestamping(struct sock *sk, int optname,
 		return -EINVAL;
 
 	if (val & SOF_TIMESTAMPING_OPT_ID &&
-	    !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
+	    !(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR] & SOF_TIMESTAMPING_OPT_ID)) {
 		if (sk_is_tcp(sk)) {
 			if ((1 << sk->sk_state) &
 			    (TCPF_CLOSE | TCPF_LISTEN))
@@ -932,7 +932,7 @@ int sock_set_timestamping(struct sock *sk, int optname,
 			return ret;
 	}
 
-	WRITE_ONCE(sk->sk_tsflags, val);
+	WRITE_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR], val);
 	sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname == SO_TIMESTAMPING_NEW);
 
 	if (val & SOF_TIMESTAMPING_RX_SOFTWARE)
@@ -1797,7 +1797,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		 * Don't change the beviour for the old case SO_TIMESTAMPING_OLD.
 		 */
 		if (optname == SO_TIMESTAMPING_OLD || sock_flag(sk, SOCK_TSTAMP_NEW)) {
-			v.timestamping.flags = READ_ONCE(sk->sk_tsflags);
+			v.timestamping.flags = READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR]);
 			v.timestamping.bind_phc = READ_ONCE(sk->sk_bind_phc);
 		}
 		break;
@@ -2930,7 +2930,7 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 	case SCM_TS_OPT_ID:
 		if (sk_is_tcp(sk))
 			return -EINVAL;
-		tsflags = READ_ONCE(sk->sk_tsflags);
+		tsflags = READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR]);
 		if (!(tsflags & SOF_TIMESTAMPING_OPT_ID))
 			return -EINVAL;
 		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index e5c55a95063d..ded504458d5d 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1050,7 +1050,7 @@ static int __ip_append_data(struct sock *sk,
 	cork->length += length;
 
 	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
-	    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
+	    READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR]) & SOF_TIMESTAMPING_OPT_ID) {
 		if (cork->flags & IPCORK_TS_OPT_ID) {
 			tskey = cork->ts_opt_id;
 		} else {
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index cf377377b52d..fac8f593c43a 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -509,7 +509,7 @@ static bool ipv4_datagram_support_cmsg(const struct sock *sk,
 	 * or without payload (SOF_TIMESTAMPING_OPT_TSONLY).
 	 */
 	info = PKTINFO_SKB_CB(skb);
-	if (!(READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_CMSG) ||
+	if (!(READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR]) & SOF_TIMESTAMPING_OPT_CMSG) ||
 	    !info->ipi_ifindex)
 		return false;
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 82cc4a5633ce..6c8968eb4427 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2245,7 +2245,7 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			struct scm_timestamping_internal *tss)
 {
 	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
-	u32 tsflags = READ_ONCE(sk->sk_tsflags);
+	u32 tsflags = READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR]);
 	bool has_timestamping = false;
 
 	if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 205673179b3c..c983e0ca6f72 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1547,7 +1547,7 @@ static int __ip6_append_data(struct sock *sk,
 	}
 
 	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
-	    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
+	    READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR]) & SOF_TIMESTAMPING_OPT_ID) {
 		if (cork->flags & IPCORK_TS_OPT_ID) {
 			tskey = cork->ts_opt_id;
 		} else {
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 88b3fcacd4f9..0080b7c3a475 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -119,7 +119,7 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		return -EINVAL;
 
 	ipcm6_init_sk(&ipc6, sk);
-	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
+	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR]);
 	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
 
 	fl6.flowi6_oif = oif;
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 8476a3944a88..cd02aa02d813 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -778,7 +778,7 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	fl6.flowi6_uid = sk->sk_uid;
 
 	ipcm6_init(&ipc6);
-	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
+	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR]);
 	ipc6.sockc.mark = fl6.flowi6_mark;
 
 	if (sin6) {
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 52dfbb2ff1a8..008cc0282338 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1349,7 +1349,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	ipcm6_init(&ipc6);
 	ipc6.gso_size = READ_ONCE(up->gso_size);
-	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
+	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR]);
 	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
 
 	/* destination address check */
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 078bcb3858c7..f66f21d6363e 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9463,7 +9463,7 @@ void sctp_copy_sock(struct sock *newsk, struct sock *sk,
 	newsk->sk_type = sk->sk_type;
 	newsk->sk_bound_dev_if = sk->sk_bound_dev_if;
 	newsk->sk_flags = sk->sk_flags;
-	newsk->sk_tsflags = sk->sk_tsflags;
+	memcpy(newsk->sk_tsflags, sk->sk_tsflags, sizeof(u32) * __MAX_TS_REQUESTOR);
 	newsk->sk_no_check_tx = sk->sk_no_check_tx;
 	newsk->sk_no_check_rx = sk->sk_no_check_rx;
 	newsk->sk_reuse = sk->sk_reuse;
diff --git a/net/socket.c b/net/socket.c
index 3b1b65b9f471..24619a27909a 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -845,7 +845,7 @@ static bool skb_is_swtx_tstamp(const struct sk_buff *skb, int false_tstamp)
 
 static ktime_t get_timestamp(struct sock *sk, struct sk_buff *skb, int *if_index)
 {
-	bool cycles = READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_BIND_PHC;
+	bool cycles = READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR]) & SOF_TIMESTAMPING_BIND_PHC;
 	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
 	struct net_device *orig_dev;
 	ktime_t hwtstamp;
@@ -944,7 +944,7 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 	}
 
 	memset(&tss, 0, sizeof(tss));
-	tsflags = READ_ONCE(sk->sk_tsflags);
+	tsflags = READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR]);
 	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
 	     (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
 	      skb_is_err_queue(skb) ||
-- 
2.37.3


