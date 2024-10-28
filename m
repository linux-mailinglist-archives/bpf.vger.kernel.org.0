Return-Path: <bpf+bounces-43296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192819B2E86
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 12:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2A9281438
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 11:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4B21E009E;
	Mon, 28 Oct 2024 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxLZRzFB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1031DB34C;
	Mon, 28 Oct 2024 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113643; cv=none; b=XzrENGb1MV91mASA4qcj9wg/oLePwJJVzmJY6pR6iVpJvee5VioClX2f51+BB8JYQYgL9hac1+W8EStnvbuw5K5kXqjH+kSWFClH90pT9Obd502ZNQGyUJx/cGcqRU9oDuthxvlMTJF6fu/vejWPJOJllRFUnftlB/zYkkUiRqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113643; c=relaxed/simple;
	bh=gc7sMEz8w/SdDhyc4WhS0XzsJ2M2y6Jr99bjT9PW+ic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sbO5Sw25ZQk3UjahPtXHNfAfEKP5eBy+zBKdOPXM6ObZbVKfx4MmXTM8kopKAxjtPW4jZepcpojT5knM7R4uQPyYjpgqlIPY4nkluGSJer0FZbafClnM3BQvS4f8L6H+qr9rhfruUcrjRegidZSRWKaOFix5x7ALgtDvO2PHomM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxLZRzFB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cceb8d8b4so22915025ad.1;
        Mon, 28 Oct 2024 04:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730113639; x=1730718439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N78hzla9PU2zrMdQqV/v5ebIzT/i06+c8vQHZBaPa0=;
        b=IxLZRzFBSffgGJXG+BBarnjeEZWzTjCOZjpnxPY0R3nJPPLYgXgUSeF/ghYfuaJy2N
         JzgxVudgmoeZszQrbU9kw9GbuJdXMmCNs7mbCKOGZ9NDUWF1fq7/NZigAPgtdMgl8i2H
         sg7l1NiJWlFaUMS4cE1zYDFAPFGqci9A74M0a34QTJ3omAGKxlExzFaf9DcK+mJv9jl4
         GtohWDdujhS0031ILkHVWx5ClQ9wKeHN0v7M4Y/vNhVNamimoSviWNAAP3lNQMWBxwk4
         8tZtiA0chNmpeoXb/q59B8DlWCqlGBQSx7gbBEbZAFVDqhz4+eEsoBXN9NucgqAy1PP4
         V9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730113639; x=1730718439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9N78hzla9PU2zrMdQqV/v5ebIzT/i06+c8vQHZBaPa0=;
        b=NP5m72Iwq/0ux5ksKiA8GTb8qJoJR7YgGuj/kuBbKnr8+UwiMUvx0gbyhGbNlkTKR5
         MLFtt7Fri4MP6sTSHvXw+ca6qaRNvi3ZgjOZgc3DYpo/3itLei61ZA0fTu229I0UzcSO
         SHz2P+S9ONxYp0Bw0HrBDG0XMVsdOmwTRDOyHvfxcvke1A4zB/dCDqJWS1ytdPRooG0p
         0uS44+hy23hdkWYuZSqsMXRYzbLaHbREjLdKZ0tGTYREOcz3H0iscHAXrN1EgyxvZ8Dp
         jJq/6ExFUIXDjf7AjI8M00Q0x9Z7o1vnD1FweWPwkMIAFC9YrAP+EbAQBmIT6VZd1Z2c
         D25A==
X-Forwarded-Encrypted: i=1; AJvYcCUrjZ5a7DNq+x1IjFAwfNqiwj5VzW2ocWpuy0gxwNZaj3N7feQyLVOvm8ZUtVFbeSoa7ko6rOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTj+MBM6MPv2qiwFocTMM793JJ/qbbOMhoy25tGA9OrPcyed0t
	f5iXYq1JVdYVqdvIgdGIZhDeQTQ0tniM9AAdi1lXKbiBA8W339pU
X-Google-Smtp-Source: AGHT+IEi0jG3733tXMr2ugBFpzIwkxw5XaKqvZSLsUv2FMo5X/asabPguZMw8sVyHWIf0UjjoSfWVA==
X-Received: by 2002:a17:902:ec88:b0:20c:6bff:fcb1 with SMTP id d9443c01a7336-210c5937885mr118446405ad.1.1730113639404;
        Mon, 28 Oct 2024 04:07:19 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04bdb6sm48130905ad.255.2024.10.28.04.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:07:19 -0700 (PDT)
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
Subject: [PATCH net-next v3 13/14] net-timestamp: use static key to control bpf extension
Date: Mon, 28 Oct 2024 19:05:34 +0800
Message-Id: <20241028110535.82999-14-kerneljasonxing@gmail.com>
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

Using the existing cgroup static key to control every possible
call in bpf extension.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/skbuff.c     | 3 ++-
 net/core/sock.c       | 4 ++--
 net/ipv4/ip_output.c  | 5 +++--
 net/ipv4/tcp.c        | 3 ++-
 net/ipv4/udp.c        | 3 ++-
 net/ipv6/ip6_output.c | 5 +++--
 6 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d1739317b97d..2e5af24802ee 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5692,7 +5692,8 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (!sk)
 		return;
 
-	skb_tstamp_tx_output_bpf(sk, tstype, orig_skb, hwtstamps);
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS))
+		skb_tstamp_tx_output_bpf(sk, tstype, orig_skb, hwtstamps);
 	skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstype);
 }
 EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
diff --git a/net/core/sock.c b/net/core/sock.c
index 914ec8046f86..3a6f7c9b6459 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1479,7 +1479,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		}
 		if (!bpf_timetamping)
 			ret = sock_set_timestamping(sk, optname, timestamping);
-		else
+		else if (cgroup_bpf_enabled(CGROUP_SOCK_OPS))
 			ret = sock_set_timestamping_bpf(sk, timestamping);
 		break;
 
@@ -1869,7 +1869,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 				v.timestamping.flags = READ_ONCE(sk->sk_tsflags);
 				v.timestamping.bind_phc = READ_ONCE(sk->sk_bind_phc);
 			}
-		} else {
+		} else if (cgroup_bpf_enabled(CGROUP_SOCK_OPS)) {
 			v.timestamping.flags = READ_ONCE(sk->sk_tsflags_bpf);
 		}
 		break;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 45033105b34c..9678a88714e5 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1058,7 +1058,7 @@ static int __ip_append_data(struct sock *sk,
 				hold_tskey = true;
 			}
 		}
-		if (!hold_tskey &&
+		if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) && !hold_tskey &&
 		    READ_ONCE(sk->sk_tsflags_bpf) & SOF_TIMESTAMPING_OPT_ID) {
 			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
 			hold_tskey = true;
@@ -1338,7 +1338,8 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 	cork->transmit_time = ipc->sockc.transmit_time;
 	cork->tx_flags = 0;
 	sock_tx_timestamp(sk, &ipc->sockc, &cork->tx_flags);
-	sock_tx_timestamp_bpf(READ_ONCE(sk->sk_tsflags_bpf), &cork->tx_flags);
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS))
+		sock_tx_timestamp_bpf(READ_ONCE(sk->sk_tsflags_bpf), &cork->tx_flags);
 	if (ipc->sockc.tsflags & SOCKCM_FLAG_TS_OPT_ID) {
 		cork->flags |= IPCORK_TS_OPT_ID;
 		cork->ts_opt_id = ipc->sockc.ts_opt_id;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f77dc7a4a98e..8f42c254bc7e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -509,7 +509,8 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
 	}
 
-	tcp_tx_timestamp_bpf(sk, skb);
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS))
+		tcp_tx_timestamp_bpf(sk, skb);
 }
 
 static bool tcp_stream_is_readable(struct sock *sk, int target)
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index e768421abc37..27cf2f8a9409 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1264,7 +1264,8 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (!corkreq) {
 		struct inet_cork cork;
 
-		timestamp_call_bpf(sk, BPF_SOCK_OPS_TS_UDP_SND_CB, 0, NULL);
+		if (cgroup_bpf_enabled(CGROUP_SOCK_OPS))
+			timestamp_call_bpf(sk, BPF_SOCK_OPS_TS_UDP_SND_CB, 0, NULL);
 		skb = ip_make_skb(sk, fl4, getfrag, msg, ulen,
 				  sizeof(struct udphdr), &ipc, &rt,
 				  &cork, msg->msg_flags);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index ec956ada7179..3a96fb09f068 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1402,7 +1402,8 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	cork->base.tx_flags = 0;
 	cork->base.mark = ipc6->sockc.mark;
 	sock_tx_timestamp(sk, &ipc6->sockc, &cork->base.tx_flags);
-	sock_tx_timestamp_bpf(READ_ONCE(sk->sk_tsflags_bpf), &cork->base.tx_flags);
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS))
+		sock_tx_timestamp_bpf(READ_ONCE(sk->sk_tsflags_bpf), &cork->base.tx_flags);
 	if (ipc6->sockc.tsflags & SOCKCM_FLAG_TS_OPT_ID) {
 		cork->base.flags |= IPCORK_TS_OPT_ID;
 		cork->base.ts_opt_id = ipc6->sockc.ts_opt_id;
@@ -1556,7 +1557,7 @@ static int __ip6_append_data(struct sock *sk,
 				hold_tskey = true;
 			}
 		}
-		if (!hold_tskey &&
+		if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) && !hold_tskey &&
 		    READ_ONCE(sk->sk_tsflags_bpf) & SOF_TIMESTAMPING_OPT_ID) {
 			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
 			hold_tskey = true;
-- 
2.37.3


