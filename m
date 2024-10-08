Return-Path: <bpf+bounces-41227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B679944C8
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18415B27BFE
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DA41C0DFA;
	Tue,  8 Oct 2024 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2wKhMES"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB270192D9E;
	Tue,  8 Oct 2024 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381084; cv=none; b=nyinnNoSufzK5YI7Mvof18M4Q+Y8vOMAVtSmi9SHXgBVEGBgAQtaN/MrdWFWx02+ww4RNvuOH3wO/Cqt9BTG3SMTVTd56wSA76iTBJB1LbBCsJIz1tBr5FBRwND6sxiiJwjPPqKIspH5S5uwTX+kWHDRkYz6XHc0pdb2IF1XeQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381084; c=relaxed/simple;
	bh=XyKDjomI7bRN80weKUjk082/xw7xQNSA2YquxGBT97g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s0776gWNnw7s5kEq3696UQUSKLyP4gpaykzLpN5uSnTFq9gP8NA8tcTs8S7R8VaE1+1JH8Ooa4bN/ot38Iy3mygodFdcq9BMQWaIRaj27MrFn0lOQgtxY3kZDGSbhBPeR2vjNQB1/xdNvapcNSi0x1xwQDpzODGrw1jmz0oyY8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2wKhMES; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b6c311f62so47285925ad.0;
        Tue, 08 Oct 2024 02:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728381082; x=1728985882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CC4xycADMX0MXqW/i8Kf8ekcDmoE5R4kuSDQeZIq8GA=;
        b=U2wKhMES6KALSKoAUfdadp3K3KlOt9IYxNKeHFePXY2oQqREgmKTKduIYspMAvJgD2
         MBlOSD93eqWHr9YHD38tzIwZ1i3brhZ5gz7f7rc1Yca/AurD3iMjF9tPX+W03Cf8CZVl
         tOQ+/OcBaN6jCGDBpmvVZ/y/1Mve+O90EQ3Ey1wggk0n35tBm1r+aAbGYE/E5BsRYOWQ
         JOSxqLImUZu8WXMDlClhfUj6h1cnKtDbkSqD8n0mv8p3O4KQ7M26cF64vJTHNAyJbX2L
         OiIQTbLCuJkHTsP6K1hURoqDt3DDzVEepBnWnnT0ENOngx1UthniNQ7GrOZjxXqO6m9R
         EtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728381082; x=1728985882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CC4xycADMX0MXqW/i8Kf8ekcDmoE5R4kuSDQeZIq8GA=;
        b=jh7OE1bD18XanxcQtaV5nzRTBN8gLIr19CH6jHQmlqyf6BeydnRfWMUtiFT5wPv31v
         mQczqGyeE7ikb+L8vOmroHS00QpCPHqX6l5s0aS+hn56R0xDufO491gcNV9273ZifCsi
         b6C/0HzVnmzcOzFFaeGM28hLEh2BKly+qs+tK8MrMMIG2o97ZdL+/5kqU5UdgQfgn34c
         77pH8JEadORQOOvn5T71IohOMBt6+KVlEp1BBRjhN7jGX6lEpVnJ61CLtx+3qrR2LrY8
         xcjcsghsemWJrK2tJsR9SyGeGc+fLAmcxRIgFvLKVnzZZgaZY9vZ6p1WOt/A7ubTf9u7
         2sOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxI++VmBDd7zrMym+qofWWDhQnfvP9RBbmqV64Qrl86srM26vQAvnJNAYAiDd8Go+dKXTvawE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywds9JDpSVB/FBD/Gw9/67PVnGX/KTFOzqkEroYv+5lleuc+1/O
	wx0E/jT2ahK6D+Cvhal5cN5OkS02wWwB8CfkZUc24m9yMTa0Zm+O
X-Google-Smtp-Source: AGHT+IHZKKTgDgRW+il9PUCNNf+O2wDjQjHDRmo5RLHOU1NRBNkq3Jbt/D8pHAlkUor65q7GCEZEFQ==
X-Received: by 2002:a17:902:e745:b0:20b:c1e4:2d70 with SMTP id d9443c01a7336-20bfe294c52mr226434235ad.23.1728381082143;
        Tue, 08 Oct 2024 02:51:22 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cfd25sm52527345ad.73.2024.10.08.02.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:51:21 -0700 (PDT)
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
Subject: [PATCH net-next 1/9] net-timestamp: add bpf infrastructure to allow exposing more information later
Date: Tue,  8 Oct 2024 17:51:01 +0800
Message-Id: <20241008095109.99918-2-kerneljasonxing@gmail.com>
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

Implement basic codes so that we later can easily add each tx points.
Introducing BPF_SOCK_OPS_ALL_CB_FLAGS used as a test statement can help use
control whether to output or not.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/uapi/linux/bpf.h       |  5 ++++-
 net/core/skbuff.c              | 18 ++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  5 ++++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c6cd7c7aeeee..157e139ed6fc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6900,8 +6900,11 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Call bpf when the kernel is generating tx timestamps.
+	 */
+	BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 /* List of known BPF sock_ops operators.
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 74149dc4ee31..5ff1a91c1204 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5539,6 +5539,21 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
 
+static bool bpf_skb_tstamp_tx(struct sock *sk, u32 scm_flag,
+			      struct skb_shared_hwtstamps *hwtstamps)
+{
+	struct tcp_sock *tp;
+
+	if (!sk_is_tcp(sk))
+		return false;
+
+	tp = tcp_sk(sk);
+	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG))
+		return true;
+
+	return false;
+}
+
 void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		     const struct sk_buff *ack_skb,
 		     struct skb_shared_hwtstamps *hwtstamps,
@@ -5551,6 +5566,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (!sk)
 		return;
 
+	if (bpf_skb_tstamp_tx(sk, tstype, hwtstamps))
+		return;
+
 	tsflags = READ_ONCE(sk->sk_tsflags);
 	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
 	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1fb3cb2636e6..93853d9d4922 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6899,8 +6899,11 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Call bpf when the kernel is generating tx timestamps.
+	 */
+	BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 /* List of known BPF sock_ops operators.
-- 
2.37.3


