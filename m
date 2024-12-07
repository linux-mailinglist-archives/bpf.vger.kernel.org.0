Return-Path: <bpf+bounces-46358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B004E9E8154
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 18:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADC4281FB9
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 17:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DB514EC4B;
	Sat,  7 Dec 2024 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWbrokWS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101C442A9B;
	Sat,  7 Dec 2024 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733593134; cv=none; b=awVTpKfyHDMeTYSxiqJwWUQBn1YRSPokHHhs0fmSU54iJvN6P9oPQXxvqibZgX/sUJbYEbH0UZTsR7JB7P3oszmulbbdlqzZs5BwWj+Cr+HpM5ltcpUu4fBK7Mft37EZWnXSuyGf/CrYXmDqyB2S4wR+oC0htY1BvspzeJngQJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733593134; c=relaxed/simple;
	bh=WMHReHnfY8HibaxppHoHkZCfBIOGpMfkz5hGHeanU2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QgbP+Yji8HxuPzSVqmWF2vidHTtuLlfvEJUs2N9rnHbQ7uGOW8gE2j1oTBJ9Z21gq0jIwb9EuFX5K/hPPNHMGQog0PZsPHnrydccJs1BGA52Fa68np/z3LkpKWgONPZSTAAvxV0/iltij1LNkd9nUW9w0xdCO9pvyn+iZ2vJNuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWbrokWS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef748105deso1200405a91.1;
        Sat, 07 Dec 2024 09:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733593132; x=1734197932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODtaCeYjtQhiwKPGhadiifDorbYuULAxkb+qbLl3fpc=;
        b=hWbrokWSrZh4YlAIUBhrvT+RDtAlalhxdNikf/RaGXe3GdRXMvFQHZmarQZxFsmjEI
         Jh1LHTdQnI+4dpHsPa7I2LwHGjQJByaa12Sywy0o9IaqXbuDk61RCNDG57by2bulVOaW
         FXnIYvpCCJAzU3GBHiydoN7x0hvh8FMnzEIEdeC5rwxR2S7Ax2X1tIfDseWwBZhrPYaB
         iqUDGfaY+vAhrq1Nobkx4LEbAd/n0mFEBLvy13jZzkuUFzRFguO9YWQIpzPgKym+gtkw
         hp8573l1AlJoGTHEUxxG1yMOzAynbtGCHZImUdono74zadFiLFOdH+owDGMHCfIZpZxt
         LcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733593132; x=1734197932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODtaCeYjtQhiwKPGhadiifDorbYuULAxkb+qbLl3fpc=;
        b=ST+GWkspscXcOrbwwVX/FwO1SXCuQgHqAicqH4kvxOIoH5GbsIS+ocWNaZTXyBv3gJ
         Lti/5W0hNWof2HfJNRflElznwisWmS4Uem7t0v9DJja9tYneHALZq96o/bbzrYFgbbWJ
         41+XiTXJDBAhyOUEgqq3dPRMcpRg0gZJaFxNSbQu8y8Bud0D5wc4x7w1hSpBNIAVAWFi
         IDhhvz6X3Cd5oAY10EDj3KUg2y3qeGkYX3mclxUsMkKGF5QUOnytlKMLSIhm75j4QPRr
         J+jVqtGm7f+IAJJG97xFQELzRxn13xKXSDMUbGwJtFiOpM3W7YzfZPCXwoohYu+aCcv5
         Qu6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQw3/UsMK6l3502jSThehuv6qFgW+Qr0l1NbnwvxJuetAuus0sXyvM0EgE/ugfF4KZ3JSel5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL6PxzjOBIl7V1rYPlafuIqHgle/AAln8GjEHAzcnKAQ22HF+v
	Mu/yD0Fnpyyfdlf3Ji2jxayqviqkNj6b9AdoJqpJV4jyfGJr5BlE
X-Gm-Gg: ASbGncvRlqFCsNNo9lIfE1+OeQcwSnMcs6PxqJcU1X9iF13J2vutCcX3+2kYVj+cOAf
	z9qzUz31E7EJOsZxFBvLkWBp9OX/swIYNCO16YiPrvSWQ5yNOQfBGCtam1XWY3YZ5Ed1/CW+LhM
	T5gxE8H095Pava5kOexraNgGzO8yXwYwGg0zaOtSfB8OGV95OhiRliKLfsF2In14b1BibIRrBlT
	OpejmUzhCJqxaUbQdKX1VvU1vTRt78Eb++lKegjv7wgLoW1969LBEdD+SrgdvE7IvCg8bSJjLBC
	+OegOTT5BLIr
X-Google-Smtp-Source: AGHT+IHbsDUw8cIX2vcZQ2UnRPPj3MOiiGon+CgnRCeBuF7y54uL6Ef85ttVBeKZw/iYIrD1vR8NUg==
X-Received: by 2002:a17:90a:e703:b0:2ee:7824:be93 with SMTP id 98e67ed59e1d1-2ef6ab27ce6mr8562313a91.34.1733593132367;
        Sat, 07 Dec 2024 09:38:52 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708b807sm6963793a91.43.2024.12.07.09.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 09:38:52 -0800 (PST)
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
Subject: [PATCH net-next v4 07/11] net-timestamp: support hwtstamp print for bpf extension
Date: Sun,  8 Dec 2024 01:37:59 +0800
Message-Id: <20241207173803.90744-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241207173803.90744-1-kerneljasonxing@gmail.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Passing the hwtstamp to bpf prog which can print.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h |  6 ++++--
 net/core/skbuff.c  | 17 +++++++++++++----
 net/core/sock.c    |  4 +++-
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index f88a00108a2f..9bc883573208 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2921,9 +2921,11 @@ int sock_set_timestamping(struct sock *sk, int optname,
 
 void sock_enable_timestamps(struct sock *sk);
 #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
-void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op);
+void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op,
+			       u32 nargs, u32 *args);
 #else
-static inline void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
+static inline void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op,
+					     u32 nargs, u32 *args)
 {
 }
 #endif
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 48b0c71e9522..182a44815630 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5539,8 +5539,12 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
 
-static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb, int tstype)
+static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb,
+				struct skb_shared_hwtstamps *hwtstamps,
+				int tstype)
 {
+	struct timespec64 tstamp;
+	u32 args[2] = {0, 0};
 	int op;
 
 	if (!sk)
@@ -5552,6 +5556,11 @@ static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb, int tstype
 		break;
 	case SCM_TSTAMP_SND:
 		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
+		if (hwtstamps) {
+			tstamp = ktime_to_timespec64(hwtstamps->hwtstamp);
+			args[0] = tstamp.tv_sec;
+			args[1] = tstamp.tv_nsec;
+		}
 		break;
 	case SCM_TSTAMP_ACK:
 		op = BPF_SOCK_OPS_TS_ACK_OPT_CB;
@@ -5560,7 +5569,7 @@ static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb, int tstype
 		return;
 	}
 
-	bpf_skops_tx_timestamping(sk, skb, op);
+	bpf_skops_tx_timestamping(sk, skb, op, 2, args);
 }
 
 static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
@@ -5651,7 +5660,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (unlikely(skb_tstamp_is_set(orig_skb, tstype, false)))
 		skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstype);
 	if (unlikely(skb_tstamp_is_set(orig_skb, tstype, true)))
-		__skb_tstamp_tx_bpf(sk, orig_skb, tstype);
+		__skb_tstamp_tx_bpf(sk, orig_skb, hwtstamps, tstype);
 }
 EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
 
@@ -5662,7 +5671,7 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
 
 	skb_tstamp_tx_output(orig_skb, NULL, hwtstamps, orig_skb->sk, tstype);
 	if (unlikely(skb_tstamp_is_set(orig_skb, tstype, true)))
-		__skb_tstamp_tx_bpf(orig_skb->sk, orig_skb, tstype);
+		__skb_tstamp_tx_bpf(orig_skb->sk, orig_skb, hwtstamps, tstype);
 }
 EXPORT_SYMBOL_GPL(skb_tstamp_tx);
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 79cb5c74c76c..504939bafe0c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -942,7 +942,8 @@ int sock_set_timestamping(struct sock *sk, int optname,
 }
 
 #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
-void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
+void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op,
+			       u32 nargs, u32 *args)
 {
 	struct bpf_sock_ops_kern sock_ops;
 
@@ -952,6 +953,7 @@ void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
 	sock_ops.op = op;
 	sock_ops.is_fullsock = 1;
 	sock_ops.sk = sk;
+	memcpy(sock_ops.args, args, nargs * sizeof(*args));
 	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
 }
 #endif
-- 
2.37.3


