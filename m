Return-Path: <bpf+bounces-48647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67951A0A8A4
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 12:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9471E167F58
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 11:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C1F1B392A;
	Sun, 12 Jan 2025 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkOamo4J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC361AF0C8;
	Sun, 12 Jan 2025 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681923; cv=none; b=Hz4uR1o1CRw/z69PTyFBaVHWtCB6ygQwOCH7gBi0HZ9MufP2ALRQtlCHXFZq3YKfqiP9yAfF+dTvSkkiWj3cmVnZManSjeIOJ+Mio2clMMNcsntpa/EZvLDlhw1fV8goDeJ4t3A3eT6cTqCr8ERaqAPTLfw30MXHhxfUkJ/z2Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681923; c=relaxed/simple;
	bh=P/NHx5OEjipLf4SoTZq/dtCgh3EtgrlGbSyeEsZVCaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GWzgaaUdtxwSDijXw2SeLIwC6m5cos41yK54+600QUMnnlpwtulfdM9N7XyPHYMOWBTp+EU1cncNab1o2U9nX6d3+xAdw8u7dVqpp5MNcIXZN8av0X8q14NTNUiRqwz9XHfzmZ9M+EciATSTFXlTzRWTfS6XKjqLuRCeoxFllFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkOamo4J; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21675fd60feso78010185ad.2;
        Sun, 12 Jan 2025 03:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736681921; x=1737286721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcP/mlvoDSBLf6CXQO6H4lxilPQTJXjgBrRAWxyv3VY=;
        b=jkOamo4J8ZUg03IOICbtncC5RdKhhSWFOj7qzEn2g2tSpw6zizF/Qdd/ryRMcAM5Ru
         6MG8spaA4I31S0wisvQBWIfafOupIILgdee5R05w7ivrU+fpjOOvGtZ04Xh8kX55+ZW6
         Kxr61N8jYBCMIAVVPHHETjh/BfDsG076xhFBCDxfxNPUL5tepcqB4jE+LObsuhvo2yPY
         GYh6HGqNhoAkCG79Md37hp2taD26TNQr61ElB9bMxks2iSsscYFnCRfpmbPANDcXX+Op
         HUcGOg4TFc1pGSi5XVTP4kVidJyXfV35YfbOHQ1/3Dsc6jYfGKUGNlCADVUIJHpJvsqu
         6zXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736681921; x=1737286721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcP/mlvoDSBLf6CXQO6H4lxilPQTJXjgBrRAWxyv3VY=;
        b=wk1k+WwFSNl+b6dqxD86qVkNrtrIwXCDqEepVI/Idylg0ZBGZyPFCZeZGo/P2Ewygx
         AMPHSNZKoVdeaDi4nkRM3+DP+bYGjUiw4Cs0vFByFB7Fyu8wEc6wdXNPIpjEmPcbDmyj
         DLomiOK7pQ9VmRLz8h+PYPnwNw8cB+nVNZl79gF4FfsNOrXExo6dp5FigC+oT4bpOJ60
         Nawp6e7iIAeWLSr4tEErvzRi4ErqCsQLIMfqXU5RlCHcM6NbqjV9sbt2N/1V0QLraaYL
         uBB4H94bz3h3Lm1DbW6Uk6PHEuLdOk9hqxtTK8qszv4g3FiweHNiLyCF8Tq6oLLK8KwF
         7vQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVguoXOBw+kENNlw6dItHLh+gtbpiuf1WAnW20uYnWI/iFPaLbfoB2+xIdRrjL1oSaOl3EnGJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX9dObBKPSaEcSw+Bl4Rv1bk5wa6iFgsa3SGpXcsGd7rvhf/vF
	5bDpeFx9uAo5U9nqm8iL4EvpL7N4ZsS2teW5n8Yn8aRG5CX3Smhb
X-Gm-Gg: ASbGncvE27P0ZbXu/VFkNHpMTiZSHUQnpTFAdwKOyB+4dFfn5+17lRce2QN8yKJXp5b
	kk8yGu+NChe7ZGe3UNY+TsUiaP5VM8hOQ4iyWncqf5ZZGPy0YqZkP1YePxOWwLuSb07o5a6fALs
	5y6ocyn+HKE5Ze5Pm2kkD8xZSnqemjPxOcKjwLvy1j4iGLjyUGzZKYPp3Yhhf/p1nvTmDxyT259
	BUIH1e2x3LBvwu8TfzlszgCiH1oPJyKdDlnLR8IM0KdhADBgR6YolZc88KeX4iCzlgARdF977nj
	lqF16tZcjTBp3es0V8Q=
X-Google-Smtp-Source: AGHT+IH8fChqzS+3WK5BIKB0C0AWwwgBXBsdDijrGtOVPgT8brg0YBjwffhhAfJvNFTGThNPpVvUUQ==
X-Received: by 2002:a17:903:120b:b0:216:3e87:c9fc with SMTP id d9443c01a7336-21a83f48c19mr246070305ad.5.1736681921016;
        Sun, 12 Jan 2025 03:38:41 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253a98sm37353765ad.224.2025.01.12.03.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 03:38:40 -0800 (PST)
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
Subject: [PATCH net-next v5 08/15] net-timestamp: support sw SCM_TSTAMP_SND for bpf extension
Date: Sun, 12 Jan 2025 19:37:41 +0800
Message-Id: <20250112113748.73504-9-kerneljasonxing@gmail.com>
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

Support SCM_TSTAMP_SND case. Then we will get the software
timestamp when the driver is about to send the skb. Later, I
will support the hardware timestamp.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         | 2 +-
 include/uapi/linux/bpf.h       | 5 +++++
 net/core/skbuff.c              | 3 +++
 tools/include/uapi/linux/bpf.h | 5 +++++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 30901dfb4539..4f38c17c67a7 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4578,7 +4578,7 @@ void skb_sw_tstamp_tx(struct sk_buff *orig_skb);
 static inline void skb_tx_timestamp(struct sk_buff *skb)
 {
 	skb_clone_tx_timestamp(skb);
-	if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
+	if (skb_shinfo(skb)->tx_flags & (SKBTX_SW_TSTAMP | SKBTX_BPF))
 		skb_sw_tstamp_tx(skb);
 }
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 72f93c6e45c1..a6d761f07f67 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7027,6 +7027,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_SW_OPT_CB,	/* Called when skb is about to send
+					 * to the nic when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 169c6d03d698..0fb31df4ed95 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5578,6 +5578,9 @@ static void __skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk, int tstype
 	case SCM_TSTAMP_SCHED:
 		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
 		break;
+	case SCM_TSTAMP_SND:
+		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
+		break;
 	default:
 		return;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 891217ab6d2d..73fc0a95c9ca 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7020,6 +7020,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_SW_OPT_CB,	/* Called when skb is about to send
+					 * to the nic when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


