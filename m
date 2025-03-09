Return-Path: <bpf+bounces-53684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BF3A58412
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 13:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53E8188EF89
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 12:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4721DC9B4;
	Sun,  9 Mar 2025 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQAKUzQg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD181D8DE1;
	Sun,  9 Mar 2025 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741523447; cv=none; b=QcxI6prrzD6CPBjA3As0wK/EKCl7M/adfOllc4eIkimCrRQCnHB7axfS9BlTKqu+MR8EPjkwdq2Gg1DjttB/bhzOqdBNuvQFuQWEvITz0JnkPOf3mmex+0e+6q/P19iFZKwS6t00+QXXpiIwjO1md8uMBequbUVBVi4BWKytksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741523447; c=relaxed/simple;
	bh=xTMrN36bij1AikHHfA7m5YEBkf6M/2HBO0jrShslRLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k7gtaG7AFdthiL2U/LB9hD4LDOQq49TQwEtkl8AQVrBxLMozEkSlb+GhTLrllpQ4x3jkWTrC0+oJtfA5ZTqtSQt4iB+SVFVg45EKQ81T9W1I2ACkEVpnsgpzDhKVkNESJBmT1KUsAJXqpobw74IHeb6JNWpkgwmKsqEZV5mkQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQAKUzQg; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so6293080a12.1;
        Sun, 09 Mar 2025 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741523441; x=1742128241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BO2xlrq5fqYUEm4YKWHIWY3dZF50PYhXmG4ZHDashi4=;
        b=PQAKUzQgU3NRRIIpx1L+hvmIB8hoQqzFHAEqMdVPypvu7q95rms2vm2LNs6wypsCcP
         9ORYe8gAVGbrzwSWbPjzNX3t07lsPhO2NUQnSWDqlrWzlhtqEJcT8U1UOoS45k9ZlOhM
         zujKIWRPqJtSsox+AYIxD0MDM+uvjs3n6qWIOX5Mpi83ld50bSMSpjZ1KXEGMAZInUzz
         MtuPdwqAwNwfNjIUnDFM1QMR5E3juq+1BDB6a/5QfY8HMrBuRg/SraDFR3Qb/UVDhEzs
         BEN6DiIeVcnbGtbR5/KV/nISMlkzf0WZ8Sd9axUt++RbuRFpmd9i+Uy/41TB3H1Ux9MZ
         mS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741523441; x=1742128241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BO2xlrq5fqYUEm4YKWHIWY3dZF50PYhXmG4ZHDashi4=;
        b=o2AGA8CviQWbsMA9gUMB/emWKT3FwCQ4tee9A2Yx6PJQofOdbwpHmWpOGvb4yOmywZ
         4G2hZX0hh4oq33KIwDpogZ0G7FR/maMb9K5xTNJSkuiRteuTUyXus2/x0b4PVd6FTXSi
         SkXbOwL64ChW68U5a8/k/uDW0uhr4HVqBeTkWtLr2cXvcjU5I8Wh3nWKFW8A1mIUs4if
         5yB2LUi702IU1hMqEMZNeEa4gfFSKik1NjBoaUr+RtE7J26+mUXLId0U7AMhBPq3jMEg
         +YbVYUS6CZbPCyzLfhYa6FF4oqFf207Wq5i7Bviij2SHmRuDIFOGD62Uxc8tQZAOOif+
         DKXw==
X-Forwarded-Encrypted: i=1; AJvYcCUyiB1RZ5h5oEfk8ifcVkKKL6PV8YDTwj1g/UvsSmqwi4mpX6tN41jom/C+kwTx5mjkNo3kY0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOp2PlW9L4BCkaH/b6uwofXkZxaWioMa3WroqMtOwbJWSTjRU6
	nNXiHHqxpMu9ztl6DRfU3ndrp1Fu4KmJQy8TtfcK0VFAkQUF44gB
X-Gm-Gg: ASbGncu5Ag5ln7Ta+OE5Mee7YsFVWwDy9oje9QiqPII4MViz3CAKyXWvOofvaPo92/p
	9gsRPJ0ymZQvjfJk+cfeSd5czDQhkxvKs+whcLUjxP/12W4Pu3ojsOKaubPKvkpeAh4BeEuH8fQ
	oZOmtFARsUV0uPG+IQ1UZdgRqVcFOuJVuLmOfPXPO/E828+pGg5yUExMCucqTriq5HMoB4MUA+P
	AGJBtaQ0uV/xcOzRb/iEkrJ91aFfAlen61FKeSJJXQ08KZBd45Dg7/J3Crx4OqS3dWXfuAf7hMq
	2LCp85l+n4BLhwXPB2M6XN5iKxcSKsxyakCwwEMhoyT/8bXzn5FyGb/0XA49gg876Gw4lAOXer1
	GgTJlNQ==
X-Google-Smtp-Source: AGHT+IFefMGJc8/9y9H6/hxYXZ9Qk64RhZ26zkIsXH4S4PUlDM9BxUb3Gqa04Vj5NduTf1WgT5++Gg==
X-Received: by 2002:a17:906:1290:b0:ac2:7f28:684e with SMTP id a640c23a62f3a-ac27f286d1bmr358358766b.6.1741523440974;
        Sun, 09 Mar 2025 05:30:40 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac29c19603dsm39144066b.38.2025.03.09.05.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 05:30:40 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
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
	horms@kernel.org,
	kuniyu@amazon.com,
	ncardwell@google.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next 3/5] tcp: support TCP_RTO_MIN_US for set/getsockopt use
Date: Sun,  9 Mar 2025 13:30:02 +0100
Message-Id: <20250309123004.85612-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250309123004.85612-1-kerneljasonxing@gmail.com>
References: <20250309123004.85612-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support adjusting RTO MIN for socket level in non BPF case.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 Documentation/networking/ip-sysctl.rst |  4 ++--
 include/net/tcp.h                      |  2 +-
 include/uapi/linux/tcp.h               |  1 +
 net/ipv4/tcp.c                         | 16 +++++++++++++++-
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 054561f8dcae..56eabcff0ed0 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1229,8 +1229,8 @@ tcp_pingpong_thresh - INTEGER
 tcp_rto_min_us - INTEGER
 	Minimal TCP retransmission timeout (in microseconds). Note that the
 	rto_min route option has the highest precedence for configuring this
-	setting, followed by the TCP_BPF_RTO_MIN socket option, followed by
-	this tcp_rto_min_us sysctl.
+	setting, followed by the TCP_BPF_RTO_MIN and TCP_RTO_MIN_US socket
+        options, followed by this tcp_rto_min_us sysctl.
 
 	The recommended practice is to use a value less or equal to 200000
 	microseconds.
diff --git a/include/net/tcp.h b/include/net/tcp.h
index a9bc959fb102..b5873ac43483 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -806,7 +806,7 @@ u32 tcp_delack_max(const struct sock *sk);
 static inline u32 tcp_rto_min(const struct sock *sk)
 {
 	const struct dst_entry *dst = __sk_dst_get(sk);
-	u32 rto_min = inet_csk(sk)->icsk_rto_min;
+	u32 rto_min = READ_ONCE(inet_csk(sk)->icsk_rto_min);
 
 	if (dst && dst_metric_locked(dst, RTAX_RTO_MIN))
 		rto_min = dst_metric_rtt(dst, RTAX_RTO_MIN);
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 32a27b4a5020..b2476cf7058e 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -137,6 +137,7 @@ enum {
 
 #define TCP_IS_MPTCP		43	/* Is MPTCP being used? */
 #define TCP_RTO_MAX_MS		44	/* max rto time in ms */
+#define TCP_RTO_MIN_US		45	/* min rto time in us */
 
 #define TCP_REPAIR_ON		1
 #define TCP_REPAIR_OFF		0
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index eb5a60c7a9cc..cec944a83c2d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3352,7 +3352,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	icsk->icsk_probes_out = 0;
 	icsk->icsk_probes_tstamp = 0;
 	icsk->icsk_rto = TCP_TIMEOUT_INIT;
-	icsk->icsk_rto_min = TCP_RTO_MIN;
+	WRITE_ONCE(icsk->icsk_rto_min, TCP_RTO_MIN);
 	icsk->icsk_delack_max = TCP_DELACK_MAX;
 	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	tcp_snd_cwnd_set(tp, TCP_INIT_CWND);
@@ -3833,6 +3833,14 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		WRITE_ONCE(inet_csk(sk)->icsk_rto_max, msecs_to_jiffies(val));
 		return 0;
+	case TCP_RTO_MIN_US: {
+		int rto_min = usecs_to_jiffies(val);
+
+		if (rto_min > TCP_RTO_MIN || rto_min < TCP_TIMEOUT_MIN)
+			return -EINVAL;
+		WRITE_ONCE(inet_csk(sk)->icsk_rto_min, rto_min);
+		return 0;
+	}
 	}
 
 	sockopt_lock_sock(sk);
@@ -4672,6 +4680,12 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	case TCP_RTO_MAX_MS:
 		val = jiffies_to_msecs(tcp_rto_max(sk));
 		break;
+	case TCP_RTO_MIN_US: {
+		int rto_min = READ_ONCE(inet_csk(sk)->icsk_rto_min);
+
+		val = jiffies_to_usecs(rto_min);
+		break;
+	}
 	default:
 		return -ENOPROTOOPT;
 	}
-- 
2.43.5


