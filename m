Return-Path: <bpf+bounces-48652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D59BFA0A8B0
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 12:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AAAA1887183
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 11:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FC31B3921;
	Sun, 12 Jan 2025 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q67H8ejr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F71ACECA;
	Sun, 12 Jan 2025 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681951; cv=none; b=oktZhz9uC/+MZJD+p6mXyRPUJiH8VAd4YJkfrt3KrFf4VmHUOlihMjLKox/h5BSaBmsNO/tGX9SG1gSAUJuhzXf7GG9ghIbN+fEcdT7XT0i86yszGdSPgQte1iHjhu6zAG/4ntKHZRaFotOrL5Hq7dYQaRLrjlqjC7k4EUJHy9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681951; c=relaxed/simple;
	bh=LwCw6WpEg/QEKA3nZCYhr2XUsxdpeWC+8nm7yYVCRxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tICEFomGRJf8KKd+LCrqzrqKr9hPlr/6hAj1MMoBCMAT/bSUjizGVLHc3RoiKbHuXo/yImyrMuRv7G+FeOCDq8X8zoxP3EX/7WC3OrwL1Uj4v9PlsJ75xFIX0J8+kwBGsUnzoys2arx9fYuYVy/Xkjct0RY3mSFgoaV9YPlkegg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q67H8ejr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216634dd574so37777705ad.2;
        Sun, 12 Jan 2025 03:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736681949; x=1737286749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5BuJ/CgfMGnhCq877MungxJulK/ZfX46Mt9P4NHQK4=;
        b=Q67H8ejrGV0aVV7J3VELIkvIbbmbVIo5CoCF68dn4AC+xZ1dVUrfPFoII06kJwGWHH
         5roZ6juTkrALhktyQl7+T0uOWY6lpxh7+g8hVNCjgJ5TRSRYpNk21eshaO7kmkfhuD94
         I81EC0RGS8qfebdxe2yStwcQ9+ObtY6u7/nem8gxstGwkMg6HY3zk1LN4OSTk0OnslHb
         USnIlYR4ZEoHH1ny30EXq3lpZH2Osh2E9Afn8pWtgJFdv4z5c9p5rhZr8J21gSXgHAX/
         YxO8rLUl29pjL7pWQiFuZN21wwSr4wp3RkeKEKSK09EDR8TbQr9qsT/rQ/BrwkYiwXMb
         rKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736681949; x=1737286749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5BuJ/CgfMGnhCq877MungxJulK/ZfX46Mt9P4NHQK4=;
        b=wn4lmWCQjMFLUUgFn9WHQzad4vXExxNugDKGIRMaSkRfy69YKw/Gb/Rar5W6IvY16V
         iV9p/0qqLXho59/UT2uqlvLycrY/QNeaHdOm/E52orGsAmjKM7J+J+SGYXu4DscWIE+1
         l/WT6Z1iqQ1S80O0wq3M2JVRMsyjL4LjrhcceQDzqx7tEFR7FB3Ec1VSoev41pEmESKz
         AWEF6cXCSJxmXg9SpEnG3Wab2APjF8Cq5J3l3M8khtNItlMMoQyhU0w9K0xq6qqHIFE2
         QB3wpt3BnPc1IZ0DEsKX0RrkYfLEZ+ZG0elH7w/tWecJI4IDvEpqWMyQeGwiRTPFcwPG
         xtrw==
X-Forwarded-Encrypted: i=1; AJvYcCUZQUxeLbH1nDDS00GJK7HbJ9NzffPJxCJfECNmbAN/xnYuRnNOKlKjN4nRQ56ZdVGAe2Kf9zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+l3VQXWaB0dO7ghMGDM6IMOu2GpNLQzyhdbt+aqyfK6aM1ZGE
	9huAsxiQnUb9rcdofrsFr3mlN0rbfdcofcu8r49B/1EP18UjoM1C
X-Gm-Gg: ASbGncv49VQqmF1cWhNUOseqQUJWJpsKJIMvQma2P/qwCbA74uK+ds2kGhfZzB7OU/v
	AeclRoU6Lf5VS/Mt3tNCk2CihWhKp70WyOgH5jT+mMZmb1t4D4qaWFEy/uPV0JrIEaQEPkVvcUk
	wrTtiOabvRyy1Sda5vd9AdRSAquGBIynPmsXP2HE+JrcG6vkO6bXGnnxc1MkNMYuoRfJUA7nmC6
	E9sceJJqarazhlk2KdmvG0OiBHsd3xJxCwyzL6mTLUoIeF285HTf1k/07G8TYwnp9V45qI37DKJ
	yFbFfzCJd3fE61Jfm9c=
X-Google-Smtp-Source: AGHT+IE0Tp/nkeQoAgxyOrKCqmlHOOVkx2bN3Y5izXGaS+n1h7frSEZjQ3iqwC2l7+Dq1Tz03RhONw==
X-Received: by 2002:a17:902:ec84:b0:218:a4ea:a786 with SMTP id d9443c01a7336-21a8400b2a8mr273245095ad.53.1736681949401;
        Sun, 12 Jan 2025 03:39:09 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253a98sm37353765ad.224.2025.01.12.03.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 03:39:08 -0800 (PST)
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
	jolsa@kernel.org,
	horms@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next v5 13/15] net-timestamp: support tcp_sendmsg for bpf extension
Date: Sun, 12 Jan 2025 19:37:46 +0800
Message-Id: <20250112113748.73504-14-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250112113748.73504-1-kerneljasonxing@gmail.com>
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce tskey_bpf to correlate tcp_sendmsg timestamp with other
three points (SND/SW/ACK). More details can be found in the
selftest.

For TCP, tskey_bpf is used to store the initial write_seq value
the moment tcp_sendmsg is called, so that the last skb of this
call will have the same tskey_bpf with tcp_sendmsg bpf callback.

UDP works similarly because tskey_bpf can increase by one everytime
udp_sendmsg gets called. It will be implemented soon.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         |  2 ++
 include/uapi/linux/bpf.h       |  3 +++
 net/core/sock.c                |  3 ++-
 net/ipv4/tcp.c                 | 10 ++++++++--
 tools/include/uapi/linux/bpf.h |  3 +++
 5 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index d3ef8db94a94..3b7b470d5d89 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -609,6 +609,8 @@ struct skb_shared_info {
 	};
 	unsigned int	gso_type;
 	u32		tskey;
+	/* For TCP, it records the initial write_seq when sendmsg is called */
+	u32		tskey_bpf;
 
 	/*
 	 * Warning : all fields before dataref are cleared in __alloc_skb()
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a0aff1b4eb61..87420c0f2235 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7037,6 +7037,9 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_TCP_SND_CB,	/* Called when every tcp_sendmsg
+					 * syscall is triggered
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/sock.c b/net/core/sock.c
index 2f54e60a50d4..e74ab0e2979d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -958,7 +958,8 @@ void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
 	if (sk_is_tcp(sk) && sk_fullsock(sk))
 		sock_ops.is_fullsock = 1;
 	sock_ops.sk = sk;
-	bpf_skops_init_skb(&sock_ops, skb, 0);
+	if (skb)
+		bpf_skops_init_skb(&sock_ops, skb, 0);
 	sock_ops.timestamp_used = 1;
 	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
 }
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0a41006b10d1..b6e0db5e4ead 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -477,7 +477,7 @@ void tcp_init_sock(struct sock *sk)
 }
 EXPORT_SYMBOL(tcp_init_sock);
 
-static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
+static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc, u32 first_write_seq)
 {
 	struct sk_buff *skb = tcp_write_queue_tail(sk);
 	u32 tsflags = sockc->tsflags;
@@ -500,6 +500,7 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 		tcb->txstamp_ack_bpf = 1;
 		shinfo->tx_flags |= SKBTX_BPF;
 		shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+		shinfo->tskey_bpf = first_write_seq;
 	}
 }
 
@@ -1067,10 +1068,15 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 	int flags, err, copied = 0;
 	int mss_now = 0, size_goal, copied_syn = 0;
 	int process_backlog = 0;
+	u32 first_write_seq = 0;
 	int zc = 0;
 	long timeo;
 
 	flags = msg->msg_flags;
+	if (SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING)) {
+		first_write_seq = tp->write_seq;
+		bpf_skops_tx_timestamping(sk, NULL, BPF_SOCK_OPS_TS_TCP_SND_CB);
+	}
 
 	if ((flags & MSG_ZEROCOPY) && size) {
 		if (msg->msg_ubuf) {
@@ -1331,7 +1337,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 out:
 	if (copied) {
-		tcp_tx_timestamp(sk, &sockc);
+		tcp_tx_timestamp(sk, &sockc, first_write_seq);
 		tcp_push(sk, flags, mss_now, tp->nonagle, size_goal);
 	}
 out_nopush:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0fe7d663a244..3769e38e052d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7030,6 +7030,9 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_TCP_SND_CB,	/* Called when every tcp_sendmsg
+					 * syscall is triggered
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


