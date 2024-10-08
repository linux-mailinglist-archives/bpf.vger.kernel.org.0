Return-Path: <bpf+bounces-41232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD42A9944C9
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D02E1C252E9
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81748191F97;
	Tue,  8 Oct 2024 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfQu+o/M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BA017C21E;
	Tue,  8 Oct 2024 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381109; cv=none; b=B/wTTm3E2aJB7NDdm99/PZMB9iDKyNh+apwXdNHPS3dy3SsYNvaN3/ivJNJqskUDR1qgL+ACxK0ikycFAw+XBXSQl9gW1izqqfFIf07p1O/zAahN6en75EmApN4M7xIZq+38/D7i1blabTfbHwgLChAYkOZD2bNi/Pz97xzgc/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381109; c=relaxed/simple;
	bh=CdcNbFmj/bL/6uD9+d/679NJU9rum9bMsXDAJjKvDOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BssBzSuq4zeMWhqTO8cYEoBt/XoiilCWSVOwFxMOpgc5g4/uJsW9R2dd0b/iZRMCWKEcbcV669MaNfciTrhKpMTsLq8Xquiv6aRzsUck8MB20vWTP9ohslFig5OxY/ega1J6tzSartXeupetKIL4OnoP+oQj9ZEhlcZ8FC9+vnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfQu+o/M; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20bc2970df5so40747505ad.3;
        Tue, 08 Oct 2024 02:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728381107; x=1728985907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsFjHqgPX322hbM4j/dBTNJ41SGcpn/JA6FQ4Q+UX+g=;
        b=DfQu+o/MVysqC3PbSn6ecM24IC8wsnWZCORjIX1ymuS+sFZa52Ppk1il2e+jOKwy8z
         euHWlhtsvJ2MCw/kj4I9F+Vmi/0JsFw6re38mNED5I46ID4c6jFJDzXG6x7pqp7ouk+f
         dVqQMqzrJw1q8phHH/4YEFamPXbKuMr+PLV6hSXWSw5j8JchwVQBEb2je31LJoYxKUmv
         L9Is+/mypoJcUlCEPCjQK9zx72KQGrKRr56nPFjFy3S6ctpbaw+pnNB64F9YpBvcBc9J
         CiaKxBp6aKO+if/+tm6/A61xDP7oqEFBkX8XtQP/Kirlf0YA2juAubKbqbSAYxQETTvJ
         Li9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728381107; x=1728985907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsFjHqgPX322hbM4j/dBTNJ41SGcpn/JA6FQ4Q+UX+g=;
        b=qr9E8W2sPlLI/3Bc2yljhcmcx5j5CiN+JUaK8Y9EIT/MuSMiIYkv7xFGCFLiNbeutB
         MxvZ9LWWAVCxgl/Blbi8FGNmlQcsVeqGhT/vKDNfda61b1PbiDfqKYBBCw9Ci+1E4ByS
         DE4PAIcoCZpO2uviv/nuVIdmjSgbKRhMtlf0ZzjlI3yvtSd6Ru/e2SkPm/vaO5xvImTK
         T6gMBEuZmFgU/qqu7GjX+EaKSio717p4YYl84pOX0xEpIUyOdxs+H5jBVpqP2B+16Pur
         BOIf8ARWUoi+SS3VGNXtHsZaRarAGS8mXAz1BB8vej0gvWLVibPzjijiM3TYpEP+XrsN
         MkbA==
X-Forwarded-Encrypted: i=1; AJvYcCXZRJ8DUdkrCJcGGkoHvilNvWiSQrGqXfSHOOfKy7P2HN1uTTJngLWh+jP3JjNj0DhbeB5bS1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQ35s3HKu8wzklgcN9b2pwG6Xd6OwILr+djOUbA6ReGSqr3p4
	I3sQTakuLotMc8n01639KowvRzTvYt6rz04ZCmPy0veN7egg8fXe
X-Google-Smtp-Source: AGHT+IGuc9HxuUtVZ/7LheyhiZWU8gxyIjufa2GjwQ7uvRWNvozrn52GobYqVaKJXYbOJ5u3eP5D7g==
X-Received: by 2002:a17:902:ccc1:b0:20b:951f:6dff with SMTP id d9443c01a7336-20bfd9987c4mr222171255ad.0.1728381106985;
        Tue, 08 Oct 2024 02:51:46 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cfd25sm52527345ad.73.2024.10.08.02.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:51:46 -0700 (PDT)
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
Subject: [PATCH net-next 6/9] net-timestamp: add tx OPT_ID_TCP support for bpf case
Date: Tue,  8 Oct 2024 17:51:06 +0800
Message-Id: <20241008095109.99918-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241008095109.99918-1-kerneljasonxing@gmail.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

We can set OPT_ID|OPT_ID_TCP before we initialize the last skb
from each sendmsg. We only set the socket once like how we use
setsockopt() with OPT_ID|OPT_ID_TCP flags.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/skbuff.c | 16 +++++++++++++---
 net/ipv4/tcp.c    | 19 +++++++++++++++----
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2b1b2f7d271a..a60aec450970 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5540,6 +5540,7 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
 EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
 
 static bool bpf_skb_tstamp_tx(struct sock *sk, u32 scm_flag,
+			      struct sk_buff *skb,
 			      struct skb_shared_hwtstamps *hwtstamps)
 {
 	struct tcp_sock *tp;
@@ -5550,7 +5551,7 @@ static bool bpf_skb_tstamp_tx(struct sock *sk, u32 scm_flag,
 	tp = tcp_sk(sk);
 	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG)) {
 		struct timespec64 tstamp;
-		u32 cb_flag;
+		u32 cb_flag, key = 0;
 
 		switch (scm_flag) {
 		case SCM_TSTAMP_SCHED:
@@ -5566,11 +5567,20 @@ static bool bpf_skb_tstamp_tx(struct sock *sk, u32 scm_flag,
 			return true;
 		}
 
+		/* We require user to set OPT_ID_TCP to generate key value
+		 * in a robust way.
+		 */
+		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID &&
+		    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID_TCP) {
+			key = skb_shinfo(skb)->tskey;
+			key -= atomic_read(&sk->sk_tskey);
+		}
+
 		if (hwtstamps)
 			tstamp = ktime_to_timespec64(hwtstamps->hwtstamp);
 		else
 			tstamp = ktime_to_timespec64(ktime_get_real());
-		tcp_call_bpf_2arg(sk, cb_flag, tstamp.tv_sec, tstamp.tv_nsec);
+		tcp_call_bpf_3arg(sk, cb_flag, key, tstamp.tv_sec, tstamp.tv_nsec);
 		return true;
 	}
 
@@ -5589,7 +5599,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (!sk)
 		return;
 
-	if (bpf_skb_tstamp_tx(sk, tstype, hwtstamps))
+	if (bpf_skb_tstamp_tx(sk, tstype, orig_skb, hwtstamps))
 		return;
 
 	tsflags = READ_ONCE(sk->sk_tsflags);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ddf4089779b5..1d52640f9ff4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -477,7 +477,7 @@ void tcp_init_sock(struct sock *sk)
 }
 EXPORT_SYMBOL(tcp_init_sock);
 
-static u32 bpf_tcp_tx_timestamp(struct sock *sk)
+static u32 bpf_tcp_tx_timestamp(struct sock *sk, int copied)
 {
 	u32 flags;
 
@@ -491,10 +491,21 @@ static u32 bpf_tcp_tx_timestamp(struct sock *sk)
 	if (!(flags & SOF_TIMESTAMPING_TX_RECORD_MASK))
 		return 0;
 
+	/* We require users to set both OPT_ID and OPT_ID_TCP flags
+	 * together here, or else the key might be inaccurate.
+	 */
+	if (flags & SOF_TIMESTAMPING_OPT_ID &&
+	    flags & SOF_TIMESTAMPING_OPT_ID_TCP &&
+	    !(sk->sk_tsflags & (SOF_TIMESTAMPING_OPT_ID | SOF_TIMESTAMPING_OPT_ID_TCP))) {
+		atomic_set(&sk->sk_tskey, (tcp_sk(sk)->write_seq - copied));
+		sk->sk_tsflags |= (SOF_TIMESTAMPING_OPT_ID | SOF_TIMESTAMPING_OPT_ID_TCP);
+	}
+
 	return flags;
 }
 
-static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
+static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc,
+			     int copied)
 {
 	struct sk_buff *skb = tcp_write_queue_tail(sk);
 	u32 tsflags = sockc->tsflags;
@@ -503,7 +514,7 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 	if (!skb)
 		return;
 
-	flags = bpf_tcp_tx_timestamp(sk);
+	flags = bpf_tcp_tx_timestamp(sk, copied);
 	if (flags)
 		tsflags = flags;
 
@@ -1347,7 +1358,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 out:
 	if (copied) {
-		tcp_tx_timestamp(sk, &sockc);
+		tcp_tx_timestamp(sk, &sockc, copied);
 		tcp_push(sk, flags, mss_now, tp->nonagle, size_goal);
 	}
 out_nopush:
-- 
2.37.3


