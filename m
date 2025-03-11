Return-Path: <bpf+bounces-53792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A69E3A5BB4B
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 09:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B6C27A1269
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 08:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC08522D7BE;
	Tue, 11 Mar 2025 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/uf9Wz5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C6A22DFA9;
	Tue, 11 Mar 2025 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683400; cv=none; b=CxGn92lH3r22rgo6byLs5uf/BK0clgfsV9dGdR2zkMbrXLvhGFf42QPhnOTa4OubHoJgeCwQlZJgobx32FxfW3q2UU94/MIw45jJiMKV04hFiHgD7zLAGCNbq31XVBg5FNltgVK8Q+dB6VtkNX9zfZOfu+dIIDNZjK1KQhrkVQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683400; c=relaxed/simple;
	bh=1Nev+uW7q8B+cnoxYN5r30c5l2xZWT/obb5YhbPolSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HqR6q2ECgBQw+yQj17CpOii0QLdxiKPeoBfjpNshswyXRf8zWRH+3yTuASz2f/VSI8khAHb92e+SJ2MCzHQtMmnoAyAqsXQgQC6bL84+hosdg0DDhtYIfrrpGzV5FFfVhsnx8WS/lwCK36IVnuoaGUuoaGpp0OWLNGzompQYhVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/uf9Wz5; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so7465984a12.0;
        Tue, 11 Mar 2025 01:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741683397; x=1742288197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxHvSCBBLJ3SzhSpW3tXxMHjDj/bK42aG+z0QqhjsL8=;
        b=E/uf9Wz5T8ShyUF2uQvX2mYS37b2jTgty2yDNGaCAc11Wsh2cpeTi4QhIl6SI9uHvS
         D9VYlc6qiec3Ox+xn/t2pIFMxcJUIqYM/9D1XQcTpQeSfIIwcrGxLcncpAwngFbyfg5Q
         W0AkWwANfj9GhxcZTLzAcmPBqe1TxJfchY6BK8klXkXYjWRbLNOTn7cnIUbjHIeAr5Po
         aWXxu/7qXKRgA89ImzXt5dKqwmj9eWW6Y53cZ1fdG3aurTw5+082Or1oJS/AVAjZEzFN
         iI+xmw6tphNVcchHCTsN7Fhdf8+buyrjTNt9XG3UarVceyTvBSUpHxZq0Kc5YHDKyWGq
         iZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741683397; x=1742288197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxHvSCBBLJ3SzhSpW3tXxMHjDj/bK42aG+z0QqhjsL8=;
        b=Q9w/3DBygzv9My6Cp+BQZ4bkWBQaILb68/0OJ1YtviDNorcX4nsnGbgFDAEE/CIxV7
         A8VL+CAQSnKaEn4hwwIhs6nvtwK41RF5xPozcKb8QY6OPUz/mD+DcQ5nunz/jdWUbsE9
         J4vXKVNJV7dUmMDRW4P4dn8K/E5um903E6+skhBgsWZ3GBz17SBSrifcyUk9Z0of2FcN
         VmR8PMn2dZFFjJS1sJ86Q0pA8JP4dGDqS31/rS57a0oXSSVeBi92XZ5FsoNt21AEyDUb
         5q5Z4/Ygg4y+yY5ecnsTVhbiAzjEc8g4BIFRJJodxm4CgqhipfLC4Mfn+dZlFT9kcVH+
         lwOg==
X-Forwarded-Encrypted: i=1; AJvYcCUguuNbpnchpdjRqOwBHbnL4efST+IoqL0hs1cIDMl3Lnp55dzUnbAmVN7hQ9RcQcyJRWSFGhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHUdjx/XM3KdMM8XiPkOGopjnsZ8vdov2pJmxWdkAl9QF6NAex
	dLS49wpNeJvqDZsH/XAEzVnnp7t9UVrQRI1wwZt5C+gPFcfwyEy5
X-Gm-Gg: ASbGnct3g3bpYl01A/Yk/KZ/LvbPHehhkKKrbJDA761PG5cD5pMTG0LlLwlU/YrY28u
	hlUp2OdCbnIsZRYPWwF19UN28rzTt3Jg/cf3FFt2K2Ouhe8ilbjs3DQv8lsFsIwS+rYVEqdTo/R
	QFkas12jPSrClsTxbPNnpCv1etKuDj/680H00qCnAA2AjmnAd2RVFGETGDsKyBbNgwHHvDK3YQK
	ke2hRjpN7eWpvtijZ6RnM8nk9YLoYLf5zROC3eLGtmr60QfGUenk+SmNPSUFAblw+/Bo2wXY0ac
	SrzHXYiEAWqM1dSSAHu9bEo4lHBnntgGqbrt7+A58D1vGhgGhUKhDSLDp8avXs/z8H9iy9qVdGJ
	rcES0PCth35gMqCSu
X-Google-Smtp-Source: AGHT+IGBI7uywvZnq32p5y/Lsc/62pd/2vz/L3GzsElETNfb7sMw4QxQTTkOw82Xpbe5z2ipeERczg==
X-Received: by 2002:a05:6402:40cc:b0:5e6:4ac8:c37a with SMTP id 4fb4d7f45d1cf-5e64ac8c64bmr12289907a12.30.1741683396771;
        Tue, 11 Mar 2025 01:56:36 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c766a16esm7965571a12.60.2025.03.11.01.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:56:36 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 4/6] tcp: support TCP_RTO_MIN_US for set/getsockopt use
Date: Tue, 11 Mar 2025 09:54:35 +0100
Message-Id: <20250311085437.14703-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250311085437.14703-1-kerneljasonxing@gmail.com>
References: <20250311085437.14703-1-kerneljasonxing@gmail.com>
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
index 9745c7f18170..e850550deb6f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -803,7 +803,7 @@ u32 tcp_delack_max(const struct sock *sk);
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
index 08d73f17e816..2a0fd56358c3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3339,7 +3339,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	icsk->icsk_probes_out = 0;
 	icsk->icsk_probes_tstamp = 0;
 	icsk->icsk_rto = TCP_TIMEOUT_INIT;
-	icsk->icsk_rto_min = TCP_RTO_MIN;
+	WRITE_ONCE(icsk->icsk_rto_min, TCP_RTO_MIN);
 	icsk->icsk_delack_max = TCP_DELACK_MAX;
 	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	tcp_snd_cwnd_set(tp, TCP_INIT_CWND);
@@ -3820,6 +3820,14 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
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
@@ -4659,6 +4667,12 @@ int do_tcp_getsockopt(struct sock *sk, int level,
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


