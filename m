Return-Path: <bpf+bounces-29745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C288C62AD
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 10:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215711C217F9
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 08:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBEA4D58E;
	Wed, 15 May 2024 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QsQvGTrh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8274C627
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715761159; cv=none; b=M7zU02xNA93ieLOZ9+HYifnLvfUwBDyvWairDS64rj0SM2mSoA/Q8+VDeadui5rS4/rfjNW/ndYKz4d6rOnLXv53/KRKsnohETdJtYC0vIo/R3TYtwRsvcwEMLbzPBe6+XxL6TkG1TSDPja2OeUMsxRO1+XtMPVku/HikFoqsfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715761159; c=relaxed/simple;
	bh=z0zhb+QV5hbyDviqfqShLmfRPBX/cjad8dM1YySRgs0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QIOD6OiEyibjqnIjo6xoNC5TTJJvFJznQOMTXlMx6o1hM/PTMUCj8q5koEvU0DCZJO2aU6eH614vJxtfDwAkN3HHQQLuIZEEwN8hW0xfe0dkZ7MVruMtqxXVuA0CeJOt2B23+kt7G+a+YTisy/GhLEnIflQr2j19cD5x4ND6D24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QsQvGTrh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1eca195a7c8so53651625ad.2
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 01:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715761156; x=1716365956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6o942XCtPQjJiLKQGAB2J6bVbP8KodkalImgwSTnKDA=;
        b=QsQvGTrhnpwebbyYY/Q+CU5nrmWrfAiWwts09HERCMxvx6e3Rb2fWvam+V54WAP8v4
         Ogn38adBu7w7Zz70k7QlGw2M3+IvUx+mjFgNwR8ZDPU08pZxdmoVuJ1Fi8AdVOXIRj3f
         RAkUTiEIqnmo/+ptB91+imVf8G4LolonmDKNvKUswr1VMxJkOKBq/hKZHKBlYoJnVsBl
         NR2Fwd7PdpwZeuwVSoASvv61IflCajGLB7alSxmXhGGWNjJJB4RG0tXAUG6s23K4VAWi
         skcL9fVZ2awcg+HBb7g/YdfP4pWxfZ3AhWsJLS4rLSV7cqkod8scnSmGHh2SWB0kvALl
         kpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715761156; x=1716365956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6o942XCtPQjJiLKQGAB2J6bVbP8KodkalImgwSTnKDA=;
        b=olp55KmK94b1h9V0xotnf94W5rwA6wndtCnfemWs4K+l0ebVuRZn53u8843JNUZd0j
         3nwJb4BbBLEJ2lT4sLN4YWbD5OjiWetqCFldMmGCVQfy6pufLzD2oUY26dYCt9BYoHeH
         Ot68NCUlkWy/UzayJ9uBY1uMJrJrhZeLRlF399ESq1aMaNsNiaHbfYk1Yp4BeHa2+idv
         BYKUyCu1k7II7S/G4sKxEk0oBvnhKYKe+mu6PUBWyNzjJ2VMT/WK1HNXNBgnV8YEW5y0
         Xt7V/SoCAzRcIN7D4DvKiu9hzkFaidu9a2QenFokbQjUky/ag4FONZSowtXg8adbJ7pu
         zNDA==
X-Forwarded-Encrypted: i=1; AJvYcCUdkMd9Sejl2jdnmT8CH40r1WuGqxA+Jarh5b4MdB0D+bh5JwZ+uj7wVPxI2+thsFCsQdQBuQKH/70R0aVxO3P6ZN48
X-Gm-Message-State: AOJu0YyU7sQooZwHM6ffr6b2y6qgIcBK07hkfoSi3BdMkL09G/gOjqTA
	cbEQmFYzWYtgK+XGksxrZFgWxGCfrZ50B6DeP5uwq+dFtydUUXP/6m6Z69OE2Tg=
X-Google-Smtp-Source: AGHT+IFOULpzfkEKoKEGmcSN0BoNscI93ZPof/9O69rlmHT7S8HVoLA+6CXd6uunVdUipbdH0C4ExQ==
X-Received: by 2002:a17:902:6546:b0:1ea:cb6f:ee5b with SMTP id d9443c01a7336-1ef43e2796fmr155486445ad.38.1715761156601;
        Wed, 15 May 2024 01:19:16 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad62fesm112051265ad.83.2024.05.15.01.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 01:19:16 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: edumazet@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	laoar.shao@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next] bpf: tcp: Improve bpf write tcp opt performance
Date: Wed, 15 May 2024 16:19:01 +0800
Message-Id: <20240515081901.91058-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Set the full package write tcp option, the test found that the loss
will be 20%. If a package wants to write tcp option, it will trigger
bpf prog three times, and call "tcp_send_mss" calculate mss_cache,
call "tcp_established_options" to reserve tcp opt len, call
"bpf_skops_write_hdr_opt" to write tcp opt, but "tcp_send_mss" before
TSO. Through bpftrace tracking, it was found that during the pressure
test, "tcp_send_mss" call frequency was 90w/s. Considering that opt
len does not change often, consider caching opt len for optimization.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 include/linux/tcp.h            |  3 +++
 include/uapi/linux/bpf.h       |  8 +++++++-
 net/ipv4/tcp_output.c          | 12 +++++++++++-
 tools/include/uapi/linux/bpf.h |  8 +++++++-
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a5e08b937b3..74437fcf94a2 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -455,6 +455,9 @@ struct tcp_sock {
 					  * to recur itself by calling
 					  * bpf_setsockopt(TCP_CONGESTION, "itself").
 					  */
+	u8	bpf_opt_len;		/* save tcp opt len implementation
+					 * BPF_SOCK_OPS_HDR_OPT_LEN_CB fast path
+					 */
 #define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) (TP->bpf_sock_ops_cb_flags & ARG)
 #else
 #define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) 0
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 90706a47f6ff..f2092de1f432 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6892,8 +6892,14 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Fast path to reserve space in a skb under
+	 * sock_ops->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB.
+	 * opt length doesn't change often, so it can save in the tcp_sock. And
+	 * set BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG to no bpf call.
+	 */
+	BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 /* List of known BPF sock_ops operators.
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ea7ad7d99245..0e7480a58012 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -488,12 +488,21 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 {
 	struct bpf_sock_ops_kern sock_ops;
 	int err;
+	struct tcp_sock *th = (struct tcp_sock *)sk;
 
-	if (likely(!BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
+	if (likely(!BPF_SOCK_OPS_TEST_FLAG(th,
 					   BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG)) ||
 	    !*remaining)
 		return;
 
+	if (likely(BPF_SOCK_OPS_TEST_FLAG(th,
+					  BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG)) &&
+	    th->bpf_opt_len) {
+		*remaining -= th->bpf_opt_len;
+		opts->bpf_opt_len = th->bpf_opt_len;
+		return;
+	}
+
 	/* *remaining has already been aligned to 4 bytes, so *remaining >= 4 */
 
 	/* init sock_ops */
@@ -538,6 +547,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 	opts->bpf_opt_len = *remaining - sock_ops.remaining_opt_len;
 	/* round up to 4 bytes */
 	opts->bpf_opt_len = (opts->bpf_opt_len + 3) & ~3;
+	th->bpf_opt_len = opts->bpf_opt_len;
 
 	*remaining -= opts->bpf_opt_len;
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 90706a47f6ff..f2092de1f432 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6892,8 +6892,14 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Fast path to reserve space in a skb under
+	 * sock_ops->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB.
+	 * opt length doesn't change often, so it can save in the tcp_sock. And
+	 * set BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG to no bpf call.
+	 */
+	BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 /* List of known BPF sock_ops operators.
-- 
2.30.2


