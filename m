Return-Path: <bpf+bounces-52054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE1BA3D24A
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 08:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DBAC7A95F8
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 07:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858421E990E;
	Thu, 20 Feb 2025 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmOvdyZK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988FB198E81;
	Thu, 20 Feb 2025 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036634; cv=none; b=vBWZ5W1BkGPVN8P8PLvJIyBlB0ogK0QXKtZsjeYsdau87FXioxUsl9d4P78Dv6Y0RvBwnADvl3566z6HAheSMvCDMpRryosuF/dvAJaEluF01L4ILQdfj9K0t9WqQrFkRgHZcCSzOR9Js7dzBsQ+H30poKgNaXSHG1jsS0u+jiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036634; c=relaxed/simple;
	bh=hroW5I6Dr6LnEAbVDw2T0BlqrZU5dRCIZeqE11C5wm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LJeMalp4YXQGPHapb7h89CYHMpvaokHUkaozLzU7QMzixqIeTaFNQSZa26MKGFvb6jR0PAJfDxqzIohufRuaxa4jluDFOrMpwi+pVHTqqQIlgDPSwJ7U2VhtPfFDYJMhIxDzv4LYOxo48gHe2+ZFr4WzUaz91kvoGhuzV/su83w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmOvdyZK; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fc33aef343so1290476a91.1;
        Wed, 19 Feb 2025 23:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740036632; x=1740641432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVcwCmBIPrNKOU3UyL7A8k6pR2axRK5QWFDs8fBPHiE=;
        b=hmOvdyZKM1oMvqXFWj6tD3oF9Dgq1lWuBuhPtnIafmcMJbZPsF7oX5V9pG/o1UTIHw
         7mfjzH5/dGXSx2MYwPm3BSv706rTP2DUyP1QNQheN66XE259lTJUL5huJS5B2qydBl7h
         szX2y771rDcfc0WrHDX9/wQNWyJOM2WSu3meKLIvJyXWd3JTRleeq5jk+KsePmX1nL0r
         N8ch9FWxvb0YyKFpe0rUgSbWy5t0AIwhTUawxlApkfP6QzZTZSJyz8c1p0qa1H5K7myH
         bFs1HfIuQnVXUlDr7HCa0WPltLpfbyUO6gzGLs9HfRj47AJbKxAn4jXDGi8pOWGEepjh
         /U0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036632; x=1740641432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVcwCmBIPrNKOU3UyL7A8k6pR2axRK5QWFDs8fBPHiE=;
        b=wYOsU2F8fEum33JpDAeBV9RGnRscwhJ3QNeayNSvm6Usctx68ayoJi1+7zntahJwad
         eCn7F9miCMh7ZqDOGnARHp4fGYk1BIwaGyG6m5AZKb5YhRP0Zcwl3Sb85foaaqoCiIAm
         iJu/Lz/8oLhfMX3TDswqJx/Y6BUfh47VTjiRh+eTFNysl+8fb3tp5E9HiYe5jqdpDVkR
         64Sqr73dK1XMIxfiaRZsnqyhSAu0SGlZetqRyaMdgheMWi4RwanS4z4arAm7YVCr1/4f
         f0gkYpzy0WmaZG1f+W4fQvLEhnqXzI+d0yPowoJUyKGsiWvKD8ZQGcNgWo8D1egDD31Z
         SNAA==
X-Forwarded-Encrypted: i=1; AJvYcCXk14YKoIZHMh8RYLudwrEVzPRua1Jgcbqa+g1ZtpkHNDYkI0htwU8C0ooumrLrQqsSV8alN4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ZOQFmpDEoVElVpAt4pVDZqrKNL6/N+GuW1zUaXtd9JoNYtGO
	73rpI9iZtGcd9L4/Pococ32YOktjV5+5EjUVoBret0GJfbNiNh0d
X-Gm-Gg: ASbGnctlgmMhCzfjH0e5PJy4o3Z5lALa1Aq82jUXLJ/B3Igq6qcXqs7Di44yJSCgEhg
	Kzmf7UHyZmtj4dT2HTyGJE1O10u3BYEzQfWA9KzfiPwQy2ixPOGF89cmtjEdcBXbtW+xLzvf5qR
	XyNSMZOeZnsF59K8cxmseUuP7DjpYRLoNVlMC2JsjzNNSFwdQOfQU/8YJc29hwL/BOr6A7U8oVY
	NoYDWLq2qXYfhLzkjCRwMZQk3QVx2WRmardbvHz6K4csm+2FRs0oOTC4dDaQj3Q9zLX773LB7Dg
	kNTUJUwIm2rK4RjyD7JeFoV1m8VfC1c/Vl+WTQy1ue5Y/60o7itmNkhchNsHaHE=
X-Google-Smtp-Source: AGHT+IE9FIIr2DXQYA8MCCXBY5uVqKIwLAGMfkf7tCP5wSoArZGznxJQd6PiBbROGMYNyAm/5h8KVA==
X-Received: by 2002:a17:90b:278b:b0:2f2:8bdd:cd8b with SMTP id 98e67ed59e1d1-2fcb5ac05f1mr10591700a91.29.1740036631957;
        Wed, 19 Feb 2025 23:30:31 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d643sm114048205ad.126.2025.02.19.23.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:30:31 -0800 (PST)
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
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v13 07/12] bpf: add BPF_SOCK_OPS_TSTAMP_SND_SW_CB callback
Date: Thu, 20 Feb 2025 15:29:35 +0800
Message-Id: <20250220072940.99994-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250220072940.99994-1-kerneljasonxing@gmail.com>
References: <20250220072940.99994-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support sw SCM_TSTAMP_SND case for bpf timestamping.

Add a new sock_ops callback, BPF_SOCK_OPS_TSTAMP_SND_SW_CB. This
callback will occur at the same timestamping point as the user
space's software SCM_TSTAMP_SND. The BPF program can use it to
get the same SCM_TSTAMP_SND timestamp without modifying the
user-space application.

Based on this patch, BPF program will get the software
timestamp when the driver is ready to send the skb. In the
sebsequent patch, the hardware timestamp will be supported.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         | 2 +-
 include/uapi/linux/bpf.h       | 4 ++++
 net/core/skbuff.c              | 9 ++++++++-
 tools/include/uapi/linux/bpf.h | 4 ++++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 52f6e033e704..76582500c5ea 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4568,7 +4568,7 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
 static inline void skb_tx_timestamp(struct sk_buff *skb)
 {
 	skb_clone_tx_timestamp(skb);
-	if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
+	if (skb_shinfo(skb)->tx_flags & (SKBTX_SW_TSTAMP | SKBTX_BPF))
 		skb_tstamp_tx(skb, NULL);
 }
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7bcd8b955598..59adcef3326a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7040,6 +7040,10 @@ enum {
 					 * SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TSTAMP_SND_SW_CB,	/* Called when skb is about to send
+					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
+					 * feature is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 3206f7708974..308db7dae1ab 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5557,6 +5557,7 @@ static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
 }
 
 static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
+						  struct skb_shared_hwtstamps *hwtstamps,
 						  struct sock *sk,
 						  int tstype)
 {
@@ -5566,6 +5567,11 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
 	case SCM_TSTAMP_SCHED:
 		op = BPF_SOCK_OPS_TSTAMP_SCHED_CB;
 		break;
+	case SCM_TSTAMP_SND:
+		if (hwtstamps)
+			return;
+		op = BPF_SOCK_OPS_TSTAMP_SND_SW_CB;
+		break;
 	default:
 		return;
 	}
@@ -5586,7 +5592,8 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		return;
 
 	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
-		skb_tstamp_tx_report_bpf_timestamping(orig_skb, sk, tstype);
+		skb_tstamp_tx_report_bpf_timestamping(orig_skb, hwtstamps,
+						      sk, tstype);
 
 	if (!skb_tstamp_tx_report_so_timestamping(orig_skb, hwtstamps, tstype))
 		return;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c3b950325846..1ead1e9d31be 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7037,6 +7037,10 @@ enum {
 					 * SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TSTAMP_SND_SW_CB,	/* Called when skb is about to send
+					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
+					 * feature is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


