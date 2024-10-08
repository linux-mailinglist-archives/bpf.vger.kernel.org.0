Return-Path: <bpf+bounces-41235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFCB9944CF
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D0D284A95
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1998E1CEEA0;
	Tue,  8 Oct 2024 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eT4qJswF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4187C199225;
	Tue,  8 Oct 2024 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381123; cv=none; b=XzQxbzq2pZVtOS6lALhCVnz4fWRYTvSx99WLiDW/fIqWrIH2BUlDnbfJZiSNkGQx+q57YLVcswWGmYgoj9FV/lR3q/alOyEFeP+XaThusr/mRNT+VpiCguyBHh+xcQ1XMk7ZxD4vzKIgpFMsLuVRMFYhmh1trHsEzRcNuuoFB2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381123; c=relaxed/simple;
	bh=MJshw9h40ymJ3Nc5HZrkDmJA46p/ympzLgaX5/Ab3AM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VDxWWoTFmpIl/94P8WzHuu2wQJcZqEUjNPfzM6KuXmmQxqbXILyOxrnh3TwhADtGTqzM3B/JH9Fz0qT0Chgg5t7MjU8ubqxo1u8hLBLz3jA/OmrxKE08yAXlxRoitC9n+0q0j/L34Z1curKrTL0YtUuHdOzpT7nICr85YHSzgXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eT4qJswF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b7eb9e81eso64436535ad.2;
        Tue, 08 Oct 2024 02:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728381122; x=1728985922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUComqhPeUxBF0aXy60LKQQCYmV3hHWBJE0MF5/cSug=;
        b=eT4qJswF5N860zomFa1gdpM31oc/eIcBQPTL8qcL+rqj4WFVrSBmuGmxipJjN355bA
         kM7L4rzIVEY5KZ+VTv5obxaRcYXwik66Sj5PEw+a9i87q6f9Rib4bGPGZFxyyCOYYu00
         nDVt6oQqUVc5sOYU/3cpOhKIB8XO+mpc6sixf0ARwmbuZjCj0d+8RXI67Okm9wsDyu22
         y5Ga8c1s586nh0Cbg8wbZXy4PsCpAGlAWj1P0lrb6WU73UngATBJIPHTszP7agpj/dt8
         q6dPpO0gIW5nVjGy8NGUDK57TExErgOLbEg/qMLWNOk27xyqLM17qqZwrwROBmcDt+90
         WRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728381122; x=1728985922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUComqhPeUxBF0aXy60LKQQCYmV3hHWBJE0MF5/cSug=;
        b=eVaNjZJdTrdrBuqTPy1H1uvMB7uqpiVZ4azJ47S+GRaKpS6jXeo/gZzN2FLTNeYYjm
         9oZ7OPslN6qTV52bl/nLVgE9kRz/Ekn/6mrR6hcWegPTCI31OG0pvXsFyWno7M3M0bjy
         DWXTyvDYDsd941RMTBfzfkz+xqDPM+AmIG6SNdY1lzH9JVLFAH6rUarOGP0f4QBZK9Sl
         iiOiJ9WZCuyI2Em5+YZBL2QSZrOextTMoy33Uof99i9SCizXCJX+QpyizNFaEOhNgvoB
         rV4PCnEIvinX8PElTwkdohPh8Lh25tWG0PqelA1Am7prJM6V91gR+UblLhx/dCoOBO1N
         xo8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8bx/i8ZNk72pP+moolnSKQ4Ikd9pTy5hmrOWJ2xYKQVYvOBS8gQQAfwSoo1dLILR6cXFquwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjersDqjWoLWCpgnk4oOrGiM4hGqgQjXAG3yya82ZVBfMEDRHG
	tIEROJm26VScbsgu6Yqgmy1sRfvK9ejngdURBHGZTvwN1nHS5DwTO3GLig==
X-Google-Smtp-Source: AGHT+IELp7iJAl1g8RI4hS7+vxFcLa36F2p1sSzf3KervtMfeEq37sWtPBKzjDFft6AlQ0rnKrBJJw==
X-Received: by 2002:a17:903:2452:b0:20b:8c13:533f with SMTP id d9443c01a7336-20bfdff0141mr175711685ad.24.1728381121713;
        Tue, 08 Oct 2024 02:52:01 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cfd25sm52527345ad.73.2024.10.08.02.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:52:01 -0700 (PDT)
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
Subject: [PATCH net-next 9/9] net-timestamp: add bpf support for rx software/hardware timestamp
Date: Tue,  8 Oct 2024 17:51:09 +0800
Message-Id: <20241008095109.99918-10-kerneljasonxing@gmail.com>
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

Now it's time to let the bpf for rx timestamp take effect.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/tcp.h              | 14 ++++++++++++++
 include/uapi/linux/bpf.h       |  5 +++++
 net/ipv4/tcp.c                 | 28 +++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |  5 +++++
 4 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 739a9fb83d0c..416a039da472 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2676,6 +2676,14 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return tcp_call_bpf(sk, op, 3, args);
 }
 
+static inline int tcp_call_bpf_4arg(struct sock *sk, int op, u32 arg1, u32 arg2,
+				    u32 arg3, u32 arg4)
+{
+	u32 args[4] = {arg1, arg2, arg3, arg4};
+
+	return tcp_call_bpf(sk, op, 4, args);
+}
+
 #else
 static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 {
@@ -2693,6 +2701,12 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return -EPERM;
 }
 
+static inline int tcp_call_bpf_4arg(struct sock *sk, int op, u32 arg1, u32 arg2,
+				    u32 arg3, u32 arg4)
+{
+	return -EPERM;
+}
+
 #endif
 
 static inline u32 tcp_timeout_init(struct sock *sk)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3c28d74d14ea..ffaa483f1362 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7045,6 +7045,11 @@ enum {
 					 * flag for other three tx timestamp
 					 * use.
 					 */
+	BPF_SOCK_OPS_TS_RX_OPT_CB,	/* Called when tcp layer tries to
+					 * receive skbs with timestamps when
+					 * SO_TIMESTAMPING feature is on
+					 * It indicates the recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 938e2bff4fa6..f6addd26db9f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2278,10 +2278,36 @@ static int tcp_zerocopy_receive(struct sock *sk,
 
 static bool tcp_bpf_recv_timestamp(struct sock *sk, struct scm_timestamping_internal *tss)
 {
+	u32 tsflags = READ_ONCE(sk->sk_tsflags);
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RX_TIMESTAMPING_OPT_CB_FLAG))
+	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RX_TIMESTAMPING_OPT_CB_FLAG)) {
+		u32 hw_sec, hw_nsec, sw_sec, sw_nsec;
+
+		if (!(tsflags & (SOF_TIMESTAMPING_RX_SOFTWARE |
+		      SOF_TIMESTAMPING_RX_HARDWARE)))
+			return true;
+
+		if (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) {
+			sw_sec = tss->ts[0].tv_sec;
+			sw_nsec = tss->ts[0].tv_nsec;
+		} else {
+			sw_sec = 0;
+			sw_nsec = 0;
+		}
+
+		if (tsflags & SOF_TIMESTAMPING_RX_HARDWARE) {
+			hw_sec = tss->ts[2].tv_sec;
+			hw_nsec = tss->ts[2].tv_nsec;
+		} else {
+			hw_sec = 0;
+			hw_nsec = 0;
+		}
+
+		tcp_call_bpf_4arg(sk, BPF_SOCK_OPS_TS_RX_OPT_CB,
+				  sw_sec, sw_nsec, hw_sec, hw_nsec);
 		return true;
+	}
 
 	return false;
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ff17cd820bde..8a87fee2e012 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7044,6 +7044,11 @@ enum {
 					 * flag for other three tx timestamp
 					 * use.
 					 */
+	BPF_SOCK_OPS_TS_RX_OPT_CB,	/* Called when tcp layer tries to
+					 * receive skbs with timestamps when
+					 * SO_TIMESTAMPING feature is on
+					 * It indicates the recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.37.3


