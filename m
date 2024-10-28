Return-Path: <bpf+bounces-43291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0A49B2E7B
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 12:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA111C22236
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 11:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5EF1DF990;
	Mon, 28 Oct 2024 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwxkoph8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112401DF98B;
	Mon, 28 Oct 2024 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113615; cv=none; b=otBwYbomv6JXXkU+8EiWmd8nkS7zkywqWdgjJ0/AhIs2Zbysr1r6y3fju0DCjJxtmPldt/JSbRvZJCn8wWcN9zrOLbzj+2u/JjJtyLyNlcZHP13ggzHzwqla8x2GhtgsCknvmcdEDCt3gwHt4kSHliS+8ovCSxVFSGTu5gadw7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113615; c=relaxed/simple;
	bh=n59BzMmHj6QmEvAChM4e1p/F3ui3YNRam2jhSBSZ950=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BIEqrcEwm8+BXzgwZsE1N6isR3ug8lRCrDLpOGwdxTvp3lcyQ7EkjPE4M36F0cRaNmCpMiFjK1W4bVwKqu9Hxcmu41rixJiZTohGTWXRD/7CBgpnvu6GfvtJCJX8EIeVRZWUBxmylFq7OIFMf3pg/+ngNU3UCXmjKQQN+MMauNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rwxkoph8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c6f492d2dso45409825ad.0;
        Mon, 28 Oct 2024 04:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730113612; x=1730718412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeswT7sbfdIj+jdoLx1KrvMNiLwQSxPjrFinnXgTtJw=;
        b=Rwxkoph86Ygw5UhminZPJ31N2oikEO6GSeswkKZVrd7b6Ah7P49Ei7MwbcGXP/3uCe
         3S+WpWLMwrz4X7J846MkueCnWZmJapaK+b0dXaLWh/Kq6/T9I6i1k8X+B783h/OS7Qkq
         LHb8uDhEyaZtoVatJpeYYze3zz1cn5W2ZpNreNtuYYnbc2sE7QMOwoRJ4q1AsDafwa9K
         g5CPEAl0DBl3/LIW0ZE8KYJvr2veBeRkKM+7Dn855n7spYNR0t63oH4qYWaqb5CweIYc
         S9rtb5Ambq6ecqt/V2BtT6QIrgT+zuLiDhtcR5JRGzWwSNT+7ukjB7IxRgmpmv4nFHKN
         y0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730113612; x=1730718412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeswT7sbfdIj+jdoLx1KrvMNiLwQSxPjrFinnXgTtJw=;
        b=lYkAcr+GVO7Nr5OWPf39Z/EXl0wyOJNNmpkqsRyfAmkJ+Q+WxpFEe5nCbHTiCpUMfG
         1Uo5KHffsi/yKJ11hSl/cQCBlqD6g9Gr7xGyP20maJzlvUDVZqU7e/q+FBx0GNxfperF
         Plht7Q5tQWuc4Of3fm7EEuwM2Nv1dusv9O7G86eQNpP0F9Z7Ldp3PgHCuJorp1ED8wqH
         UmQmek2ksm6RvArFyaex0tMJVE4fVGcG1pp+RQj8hk8aqs+v6rdChbod90zYQSSxQkNB
         tzqOqw3NhAZmrc44wbai+QkpRMsgkonIbFk/fpr8BNbmB75ACTbaYdPJ4/YbGoWBToxf
         8psA==
X-Forwarded-Encrypted: i=1; AJvYcCW54t+arW0WIccSTcoZUK3UPw9WWjvFGOUSzQXy2FU0b0agVGhuJHqZJFDoTVVhGlcE/B+nvHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz4kaRTUqFG22pyKjbMw6qX98KPTm1rCX2N5QS/0xuziSgG0B9
	2NaW937pVglLXvmBjwkiaIemZ5kfty3z9e49I4JLcDrcyk+RXQVB
X-Google-Smtp-Source: AGHT+IF6d/W4Yo2LrkrguO1XU3nDvMacgFTgK8CP9HvoWsXbWN+cimFoOuYgDT/rUCCpozdXxpbsZg==
X-Received: by 2002:a17:903:2283:b0:20c:8331:cb6e with SMTP id d9443c01a7336-210c68c951cmr122758555ad.19.1730113612271;
        Mon, 28 Oct 2024 04:06:52 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04bdb6sm48130905ad.255.2024.10.28.04.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:06:51 -0700 (PDT)
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
	shuah@kernel.org,
	ykolal@fb.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 08/14] net-timestamp: make bpf for tx timestamp work
Date: Mon, 28 Oct 2024 19:05:29 +0800
Message-Id: <20241028110535.82999-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241028110535.82999-1-kerneljasonxing@gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Until now, we've already prepared the generation related work, so
it's time to let it work finally for both TCP and UDP protos.

This is how I use in bpf program:
1) for UDP
case BPF_SOCK_OPS_TS_UDP_SND_CB:
	bpf_setsockopt(...);

2) for TCP
case BPF_SOCK_OPS_TCP_CONNECT_CB:
	bpf_setsockopt(...)

3) common part used to report the timestamp
case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
	dport = bpf_ntohl(skops->remote_port);
	sport = skops->local_port;
	bpf_printk(...);

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h    |  6 ++++++
 net/ipv4/ip_output.c  |  1 +
 net/ipv4/tcp.c        | 16 ++++++++++++++++
 net/ipv6/ip6_output.c |  1 +
 4 files changed, 24 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index cf7fea456455..cf687efbea9f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2710,6 +2710,12 @@ static inline void sock_tx_timestamp(struct sock *sk,
 	_sock_tx_timestamp(sk, sockc, tx_flags, NULL);
 }
 
+static inline void sock_tx_timestamp_bpf(u32 tsflags, __u8 *tx_flags)
+{
+	if (tsflags)
+		__sock_tx_timestamp(tsflags, tx_flags);
+}
+
 static inline void skb_setup_tx_timestamp(struct sk_buff *skb,
 					  const struct sockcm_cookie *sockc)
 {
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 0065b1996c94..9d94a209057b 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1332,6 +1332,7 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 	cork->transmit_time = ipc->sockc.transmit_time;
 	cork->tx_flags = 0;
 	sock_tx_timestamp(sk, &ipc->sockc, &cork->tx_flags);
+	sock_tx_timestamp_bpf(READ_ONCE(sk->sk_tsflags_bpf), &cork->tx_flags);
 	if (ipc->sockc.tsflags & SOCKCM_FLAG_TS_OPT_ID) {
 		cork->flags |= IPCORK_TS_OPT_ID;
 		cork->ts_opt_id = ipc->sockc.ts_opt_id;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 82cc4a5633ce..6b23b4aa3c91 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -477,6 +477,20 @@ void tcp_init_sock(struct sock *sk)
 }
 EXPORT_SYMBOL(tcp_init_sock);
 
+static void tcp_tx_timestamp_bpf(struct sock *sk, struct sk_buff *skb)
+{
+	u32 tsflags = READ_ONCE(sk->sk_tsflags_bpf);
+
+	if (tsflags && skb) {
+		struct skb_shared_info *shinfo = skb_shinfo(skb);
+		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
+
+		sock_tx_timestamp_bpf(tsflags, &shinfo->tx_flags);
+		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
+			tcb->txstamp_ack = 1;
+	}
+}
+
 static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 {
 	struct sk_buff *skb = tcp_write_queue_tail(sk);
@@ -492,6 +506,8 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
 			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
 	}
+
+	tcp_tx_timestamp_bpf(sk, skb);
 }
 
 static bool tcp_stream_is_readable(struct sock *sk, int target)
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f7b4608bb316..230e8d5a792c 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1402,6 +1402,7 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	cork->base.tx_flags = 0;
 	cork->base.mark = ipc6->sockc.mark;
 	sock_tx_timestamp(sk, &ipc6->sockc, &cork->base.tx_flags);
+	sock_tx_timestamp_bpf(READ_ONCE(sk->sk_tsflags_bpf), &cork->base.tx_flags);
 	if (ipc6->sockc.tsflags & SOCKCM_FLAG_TS_OPT_ID) {
 		cork->base.flags |= IPCORK_TS_OPT_ID;
 		cork->base.ts_opt_id = ipc6->sockc.ts_opt_id;
-- 
2.37.3


