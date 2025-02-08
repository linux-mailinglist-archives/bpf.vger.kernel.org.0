Return-Path: <bpf+bounces-50860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67B6A2D58E
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 11:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC483AB997
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 10:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB2B1B4132;
	Sat,  8 Feb 2025 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrJzXeSX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785941B0F19;
	Sat,  8 Feb 2025 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739010788; cv=none; b=pqyu/1wSWvu7X9GixHReWiwXy9jSfhwgu3mBj87LMKZ9jIrDCLRnwY7FPLojNYt1hi3O9SbOSgppXT9Ir6Q0+yHSTGj5kxp8HzWEg8Wdz+e1t1jsBL2DbC6MYAJXjHUU7MIuehiqKM+nX8aODwptJLNYDq5QlZf3yoNtKH6YE0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739010788; c=relaxed/simple;
	bh=IlqaLcRRZSP5Rth+fhpwWXcyQ+Z4wQMk2AP6Txtu+Po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dbnvJrnrwc7/8wnOSwK+srTlM6HCOxf+dJa97JKXWcujxrQZzb0TnnfBFzLGJdzXL0ZL/4LRhsmbEHjXptwrFXc2G7cFf5fLUXRRbCSg6nv4A16TiWAbbaOFYxQK9Gx3g/cJGmzOGjQBA8f8e0U52Ee/BLu9QqOtEp6Oteksy0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrJzXeSX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f62cc4088so15856815ad.3;
        Sat, 08 Feb 2025 02:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739010786; x=1739615586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FALFc4HhQbB1E7bCuhAiI1KaUPwu7ksfpIboAbt+Xo=;
        b=MrJzXeSXxlOhNfu/kbRN4A5/R/GWcKbpbAiIc5cnAINpneIWy45wo9NKZkXb5/y06C
         Y0MyDXep4/4rhi7yh8DDUlpB9jYGrs9mKyOeN7njUdmWRtkz9hz+PL05oSNvJl9IgQot
         +MlMupzAsnU8Bxno2sFYy2xah8Bv2MTQ/PtaXdc9tf/INPY0cnLrn1rO40Oa77WZ9QxO
         64M4rZMQMTPG5g8tEshq0yVgZJ8VBWKeUx5KlazYMcSqu2BVGS0vAQ86ar/sSELgMnjr
         0LjAgnF8Z0LNt81ZqSjH6x4bXwEQUgA07JT7ZyZOu/gTxeWJWCvNlcvPRUmbFzhNHfLX
         GlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739010786; x=1739615586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FALFc4HhQbB1E7bCuhAiI1KaUPwu7ksfpIboAbt+Xo=;
        b=baJjuW3kVdL+AURDTRrZMZpuvAtzs9CpcLRZVlky2cjNffKd6WDo/K0LU6Qvst8/O9
         BeG4kF+ZV3dzluSrQLghmqANAvNp3x8TAov+EXDcn4vBJflBUKTh7k2YIcRr4xMvvRYv
         s9vM0P8ulSEK9W91Qz71V9yi3tWgsT3hofsY7L+jUQ+Zx/vwK4475ItdQPLrxYi4duEc
         bZZmIO7UOJNnrKHxgvJ2tuHftdBb8yJxk24aqBtV6gfoDUDHiBeBik6FG6kZCRxLIj4b
         mKY0g7bP7G19x7p8XUE/9qd4iOKjQtXe/YFltrtDSJznbzB3B5OtZb2BIbhZM1R83HkQ
         uS2A==
X-Forwarded-Encrypted: i=1; AJvYcCU5MpUEyIzAkw1m4XOmzF/ErnaUalQLIWqtYvdhs8hoD7Ccve0Hqh4gSBXM+uJDlkR6l9yKGKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL2qN9NHu+IHYr5L2DKp7JY2NTJio50u/WfVd/gRAc2GGiPtO1
	iBHNoaz4FmVH5W2rovM9Yfr64lhmVDEvQfqmp6JcGGiIt9Ap66qr
X-Gm-Gg: ASbGncvotovcwp1bjj9yc4+bbAvPJ6xmkUpzbQGNFp3B77XrXtfEKcQJj7dZdHWO1Le
	a2s1A58EAW/P27JAU2r60yYgNC/n6NTi+HTlKKNXoaG9gKKIx76rJOITKx5woJP11HPI5BQO6KW
	PoE+V0VPxyi2LLJdmtr+/J9SvMwxKD7zCoHyKkG5NTOiNLnDhfYO827uLj0XSx9DJU+DHPhdqW3
	az3JBKS33YM8OucKMEmwTjhc0OErilFzstEEPDs6oszMeGVyt1BL9lc5Fz5G0caGPd0di+RI3TJ
	Ahm80dBRmpPgsGBAgaD1VfTHEqQhJ6nJLWbXqNUn42IK7yp+7VpSVw==
X-Google-Smtp-Source: AGHT+IFSS7nzQWnjGPfhfhv4YXupBemOjbZLWXCIUZ61GJoQM9lnWcYGfKxfI2hoMeigvjlknGLv9A==
X-Received: by 2002:a17:902:d48d:b0:21e:ffaf:8908 with SMTP id d9443c01a7336-21f4e73b55fmr91253625ad.34.1739010785820;
        Sat, 08 Feb 2025 02:33:05 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af58sm44527835ad.70.2025.02.08.02.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 02:33:05 -0800 (PST)
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
Subject: [PATCH bpf-next v9 07/12] bpf: support sw SCM_TSTAMP_SND of SO_TIMESTAMPING
Date: Sat,  8 Feb 2025 18:32:15 +0800
Message-Id: <20250208103220.72294-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250208103220.72294-1-kerneljasonxing@gmail.com>
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support sw SCM_TSTAMP_SND case. Then users will get the software
timestamp when the driver is about to send the skb. Later,
the hardware timestamp will be supported.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h         |  2 +-
 include/uapi/linux/bpf.h       |  4 ++++
 net/core/skbuff.c              | 10 ++++++++--
 tools/include/uapi/linux/bpf.h |  4 ++++
 4 files changed, 17 insertions(+), 3 deletions(-)

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
index 30d2c078966b..6a1083bcf779 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7036,6 +7036,10 @@ enum {
 					 * dev layer when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_SW_OPT_CB,	/* Called when skb is about to send
+					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
+					 * feature is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6f55eb90a632..74c04cbe5acd 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5557,7 +5557,8 @@ static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
 
 static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
 						  struct sock *sk,
-						  int tstype)
+						  int tstype,
+						  bool sw)
 {
 	int op;
 
@@ -5565,6 +5566,11 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
 	case SCM_TSTAMP_SCHED:
 		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
 		break;
+	case SCM_TSTAMP_SND:
+		if (!sw)
+			return;
+		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
+		break;
 	default:
 		return;
 	}
@@ -5585,7 +5591,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		return;
 
 	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
-		skb_tstamp_tx_report_bpf_timestamping(orig_skb, sk, tstype);
+		skb_tstamp_tx_report_bpf_timestamping(orig_skb, sk, tstype, sw);
 
 	if (!skb_tstamp_tx_report_so_timestamping(orig_skb, tstype, sw))
 		return;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index eed91b7296b7..9bd1c7c77b17 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7029,6 +7029,10 @@ enum {
 					 * dev layer when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_SW_OPT_CB,	/* Called when skb is about to send
+					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
+					 * feature is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


