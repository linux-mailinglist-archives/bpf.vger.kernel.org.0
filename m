Return-Path: <bpf+bounces-50441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E15CA279C7
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 19:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3EC1882CDF
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF46821773F;
	Tue,  4 Feb 2025 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhIenCxa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88F21639F;
	Tue,  4 Feb 2025 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693847; cv=none; b=J1JzWZO4eW4OGCBzAMZnLKoXM1EaFtdppA2AtoDotkCL1GhvlkEjsWp0JfoCOj1Gby44RgTrCvliyebZ3Jvk3lhmBYpqjb/HK4E7dPN1fkRgqiJo/kOKzQqZn+llL+fu5+aOHVQnYqJFbFbEkIThO44pRCCgXu/jnzWBqk+WD+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693847; c=relaxed/simple;
	bh=r4VaYJrwHCXDlAcfMr7sr6lS0pk7V2NSw4LKzmX9i5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N2KMy9oOrXkBMg2NDNFu+R0U1fMV+uffKGxVJLMfmAN8nwCNKzaBSyghWKTJjo3xG4VRTlq1pnPYQ41qvqta/oE0bQOixNfzrFXrKx2oTACAehtYlSZHaleCbJ3LrO5YChhUe7ZPHfJnYqtm6Thvs3YyInMntTZaFkYzoe45cQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhIenCxa; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f9d9ee2ec2so497365a91.1;
        Tue, 04 Feb 2025 10:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738693845; x=1739298645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FM0Dc99ZK+Ah2fMPgdFn/MAVtyk4O2Sk7UtUiTgjHeU=;
        b=XhIenCxa+x0Fr8heG2zmxUjQB1QVlklyYbQ0CR0Zjf21ZXWBlag3uiIRV7vGg4zABz
         R/O4XuFbv//ks39ep8K+XuDrgn7TOfkpQyslwvAQkoXoREvGzWAxgThg84rmGD8X8slS
         ZnEYUYuxxfq8FiCNp6DJ6cQpXbVwSMMDVjikEUDMvhAqU3ZMJUlnq4QXKotEfT4AXwWX
         Wuoo90qQ4HCdipfmblveOrPmUfDmLBwrz7LA/PT/CmFCNtkGNRiuNOXlJrRJp6buiT+Y
         ehoG/sHhlrjOOHMqKYyUvi9wGem6ftA4QM7PD+edExgCPXit/RayVdy4Je6pPcwDNocO
         AAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738693845; x=1739298645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FM0Dc99ZK+Ah2fMPgdFn/MAVtyk4O2Sk7UtUiTgjHeU=;
        b=c9jsaaiVZNLNIk64CuFYerW8DFFL9QVsfuUm3dW2i1dYtcMKqouTVckY78DtAG+nYM
         wGgqHno57Zp5eyKcEqzATf4SJZvaRCpmxzJXBGRB/SmqatnwIpM+s4g8WshZIJvosd+8
         3+T1X1fZHQLnS//SUT7Hc5/CS7dTTvYJKU0e2GbmPGaO37+006la5jQKEMlsV5Bp1vob
         9lQKagpEyg1QhE2AIykv2czRgTpLe03c487CzUTFRI3euUKbipeL2zGHq0BSXcm9RA07
         FT7FZxHmcc1iLisC987aO+XzVe1eDf13DuA1th72lydga6fEA7TAooWn/zhYTiMfukJJ
         mjWA==
X-Forwarded-Encrypted: i=1; AJvYcCXf0nu1enUfeIGyoDaw1b+dIVdJs9pi8MDPSXFWxMqldxNzBRQtkBr9qZeWUHztZrW2BCfgcQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwRMD+Cc0Re9B2Pni1fGmXIZEattuKV1VbdhcC0kimFigO04LT
	/3RWNsda/vlim509tlR3YtkalGziVxCeDqMGi00qXaMwTXKpbpiM
X-Gm-Gg: ASbGncuNdhINak37nuU/8t22rp8m/AVBdpe+mFdz9Q5xX/76yxXwCE57C01C8aziRbb
	/7ohZsX1ayPUso0sdgQg2Yj1VcY0tW9TLUHJXcpnL2SUKzww6jG7KU4BIM1G09vgaEntnCOVYpf
	CHJhuMaNmIow/D4zegH2TwsCNktCiQg4Amq3oQ6thgZPea4iwi95g9fkkc3KQzShiGXdOluh6Ok
	ZcPkV/ey2u3zOYxpLhfJ3T0G06kEOP3VFY+cO2tYCj7KnwbG2LG4DDbEnx14uOcFpbS5WEPc3o+
	uTla23e+oDLh0CsGaNufIW8BuUq1+oYQJvgTDl9p2cYpwqjfloNmWQ==
X-Google-Smtp-Source: AGHT+IGW/lfQI8wLtkgL7QxXbTFdNeXgvTYsAxIWS0wlp7Mg/ZIYtiBso7AMQObTsXmQ++fbPqk+dA==
X-Received: by 2002:a17:90b:56c4:b0:2ee:d186:fe48 with SMTP id 98e67ed59e1d1-2f83ac73abamr39272578a91.28.1738693844779;
        Tue, 04 Feb 2025 10:30:44 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848a99a45sm11590591a91.38.2025.02.04.10.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:30:44 -0800 (PST)
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
Subject: [PATCH bpf-next v8 02/12] bpf: prepare for timestamping callbacks use
Date: Wed,  5 Feb 2025 02:30:14 +0800
Message-Id: <20250204183024.87508-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250204183024.87508-1-kerneljasonxing@gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Later, four callback points to report information to user space
based on this patch will be introduced.

As to skb initialization here, users can follow these three steps
as below to fetch the shared info from the exported skb in the bpf
prog:
1. skops_kern = bpf_cast_to_kern_ctx(skops);
2. skb = skops_kern->skb;
3. shinfo = bpf_core_cast(skb->head + skb->end, struct skb_shared_info);

More details can be seen in the last selftest patch of the series.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/net/sock.h |  7 +++++++
 net/core/sock.c    | 15 +++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 7916982343c6..6f4d54faba92 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2923,6 +2923,13 @@ int sock_set_timestamping(struct sock *sk, int optname,
 			  struct so_timestamping timestamping);
 
 void sock_enable_timestamps(struct sock *sk);
+#if defined(CONFIG_CGROUP_BPF)
+void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op);
+#else
+static inline void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
+{
+}
+#endif
 void sock_no_linger(struct sock *sk);
 void sock_set_keepalive(struct sock *sk);
 void sock_set_priority(struct sock *sk, u32 priority);
diff --git a/net/core/sock.c b/net/core/sock.c
index eae2ae70a2e0..41db6407e360 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -948,6 +948,21 @@ int sock_set_timestamping(struct sock *sk, int optname,
 	return 0;
 }
 
+#if defined(CONFIG_CGROUP_BPF)
+void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
+{
+	struct bpf_sock_ops_kern sock_ops;
+
+	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
+	sock_ops.op = op;
+	sock_ops.is_fullsock = 1;
+	sock_ops.sk = sk;
+	bpf_skops_init_skb(&sock_ops, skb, 0);
+	/* Timestamping bpf extension supports only TCP and UDP full socket */
+	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
+}
+#endif
+
 void sock_set_keepalive(struct sock *sk)
 {
 	lock_sock(sk);
-- 
2.43.5


