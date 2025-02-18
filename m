Return-Path: <bpf+bounces-51800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF6BA39247
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 06:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C971116E6E0
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 05:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BAC1A5B98;
	Tue, 18 Feb 2025 05:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDLEyWJv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4418C1AF0B5;
	Tue, 18 Feb 2025 05:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739854937; cv=none; b=oztRBTzVTjQIzanGoUBygB9TqO0+ZtKciihcHbblGyrxnqkr7QxVayp6I29YrzreIT1+qPTJog3kvZhYXi72Dy8o+OKS6slZxzFUb0zshKur/cqoLQlSeKlCr5KdAcbHSaChs5cZjaMan4SGiECJVFKdX2mPGERNd491HBPfAIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739854937; c=relaxed/simple;
	bh=xKbudb0FUrth0r9fVulR0YQSW9YlrDYUxAjIB9W3r94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBRXg+JHPwlenbd2o/1dE6YH1TQAxu2NIscqkq8iF8kH5k4eH2JhF6WlArctMcJZK4pQKbjecKVeyEmgSZAvlvz//0B+RYX3f8lLiT2TK+N5WTFvfgZ3FtWiFrrtury4taGnetvfFuIfaB9v0sHOSRR254lK4xb3rBhCFoI6gIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDLEyWJv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c8cf98bbso101135775ad.1;
        Mon, 17 Feb 2025 21:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739854935; x=1740459735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCClYBX4dv1juFzLnShvLFoS82zgt+5gs+BbDuAzfbU=;
        b=GDLEyWJvLOEbe3puWmfBBA1hCImQeI3tUiJGy1ReVIu1qiv6LUbM2YjTrdMhQYtB43
         34Hz9hWAqHHXiAv9oUbfAb4DIbUu08wMxiirf33Y6KYbsujpCNRWVOa6B4SIc24EdLR+
         ea4kbKOp8UKO6XMGlYmW72LVxC97N96EYrSb8mdgIA0s930L4dy4YfHUrH3O69mw+RF4
         hgTG2Yxj/+XqeLvZtwGoS8wdiJ58Qo5XMzk/PT3PZgEFHSP9GZ3Y7SNVjOi3JBTVTYNk
         eh2MqSBVz+yiqAUCZzN8sgBe/N6p3pLagj8l8R1Mx1rp5vhulS/+zTZ6J0cSHbnBLTRX
         hdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739854935; x=1740459735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCClYBX4dv1juFzLnShvLFoS82zgt+5gs+BbDuAzfbU=;
        b=xCy/NsE+lxSKy50YfvnMCNFnLw5hAuAC8yrZsKeuTMzYo3VecnoSgs70FgFnXw6+0X
         FsmOO0vleh08DN/643NFg3EQWaz0RF1hcZpETU3KJUcUtbJ830iBnGwJRZPOMnozcKc5
         eTpZELttxAmxTiEv1YeUIiruQoUA4hZXarCAiM0Qm+1BbpzXX4a6L6Ey8BYlOPeeXocW
         UDFo92x2wtkGhoJHUxpN7ojaaF7V5DWu0WIwVUpXhDFv2kp5q7cTJzcQJP1RfQpFkqJ6
         nCzsYSEvdNe//+lNk50/U+lx8OrfROger8Q5VjeIJSIJ9bd9I/rOXIRXg5Tz7ckxsYlA
         mv5w==
X-Forwarded-Encrypted: i=1; AJvYcCVcZOFJ5fB3qWKcCq4Nv2VLuqe6Qabx6SiEd8VG09RhKoeoiV0n5BzrYQYCuEZlhAssgt9Vkn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvGPNo6TdS2Es84zt6jRdm9DVFHqk6Rgrdas8h2dhQVGOWpQcu
	QR6rsk55p93Za0m7c8ioBhEj5DTVeiR419iYlEp6qtErKR8fzYF+R47d/mwBi+Ewcw==
X-Gm-Gg: ASbGncucY2rBg8knDspNP9jpShpvRG11Y705jFgmb78H/HfvMrF7CQHjxgu5GmGscor
	BZNQ6hjAtXV9xy9X1ZPUA7La1XN56rYEHufodMZFQ3v2NfTmHXBZAIbhXjPznt1vX2A7/diEbiN
	sRmeCLYF5eJAcs3I0zhxcOhU57A71Sk1cSiOCR1P3PwBngXSkosgVufaytWGDUEnOaatIDy9ZP4
	htklOPpL9FprTiPfxjF8ErByDYCMwITSaZyW1qw1cr7/nS44S+6C+YOD09eJ3I0Sc/RxizY0lXK
	0W8G46GRIfJe0VwQ4QEKQDHuwRoaqAUGqzu7/M6LU3/fqT8DDoxEY7IlWIVDtQ4=
X-Google-Smtp-Source: AGHT+IH/L1/jtW7zZyUJGIuQ9OaKIw5soUDOH3dF6adpivdAR4s+e8QQHBDG80QcRAsDWNgb/IigSQ==
X-Received: by 2002:a05:6a00:4b16:b0:732:1eb2:7bf3 with SMTP id d2e1a72fcca58-7326190da79mr19491632b3a.21.1739854935456;
        Mon, 17 Feb 2025 21:02:15 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adda5be52f1sm4337938a12.34.2025.02.17.21.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:02:15 -0800 (PST)
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
Subject: [PATCH bpf-next v12 02/12] bpf: prepare the sock_ops ctx and call bpf prog for TX timestamping
Date: Tue, 18 Feb 2025 13:01:15 +0800
Message-Id: <20250218050125.73676-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250218050125.73676-1-kerneljasonxing@gmail.com>
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new bpf_skops_tx_timestamping() function
that prepares the "struct bpf_sock_ops" ctx and then executes the
sockops BPF program.

The subsequent patch will utilize bpf_skops_tx_timestamping() at
the existing TX timestamping kernel callbacks (__sk_tstamp_tx
specifically) to call the sockops BPF program. Later, four callback
points to report information to user space based on this patch will
be introduced.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/net/sock.h |  7 +++++++
 net/core/sock.c    | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

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
index eae2ae70a2e0..bde45569d4da 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -948,6 +948,20 @@ int sock_set_timestamping(struct sock *sk, int optname,
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
+	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
+}
+#endif
+
 void sock_set_keepalive(struct sock *sk)
 {
 	lock_sock(sk);
-- 
2.43.5


