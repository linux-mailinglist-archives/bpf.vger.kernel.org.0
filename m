Return-Path: <bpf+bounces-41800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22A799B0A4
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 06:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 047E6B2343F
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 04:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C65D12CD88;
	Sat, 12 Oct 2024 04:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUlDydMk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8CCA41;
	Sat, 12 Oct 2024 04:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728706037; cv=none; b=i4pP/9EVQcLqOfzaYOnMPVxaRHgHFH62urxlSmmOUM9R9XIAz2mCGW9HCpqh0mNPrknTKO4nOXXJYcJB0rgLLEHahc42k43CQWUP9hfH7nMjRAE816sdhZ29uyqTxvuYJn11+HttY3dPQcIozx8vV5QmCqADSxZpg4yGk+onMuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728706037; c=relaxed/simple;
	bh=qMTb6Yx/idR+PoJPwqe6W83I/MrE1JYLd5TNr/QChh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rI7Lqj4NCT9B5wVsMvMbqryd0PvcdLZHnZsgXP7+oE9gx2MozRwF9Gr6UI/mHMSHZnfRsYaXzr8U+/mpcMRpn4BatSk1cODgAsmul3iMk4mqc5xKgu9RipYKxfaEZzVrETXjzcAI18sdUn0LEu8/RWjLSECzdH4d8uKgrh3GHTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUlDydMk; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20bb610be6aso27909505ad.1;
        Fri, 11 Oct 2024 21:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728706035; x=1729310835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJnps7CANHVZ0rSjZN72iSKjT69c16RYHWcaWeFxSnI=;
        b=lUlDydMk2hNAdxLQCLPqQOq4qG+eih0p1H+hc9WfaAfQu0nDvbcdRKWwCjyx/nV6i0
         YXHitiqaPxco2JS9s7kZc7IFQ6TyG3coIZ8MlfRBdf98SMBtDrtzv/P1jimkPF17txVI
         yvtn+l0XT94hhZASXUOCrNayTdjMld/NB3PoMDwBMXSqw9R+1dM7m+WSrV1lfq6sFvye
         eKg5mcjjpZneuoLi4ortlpM8tU6FfbHIpbHVMg5qqRf/owc4hhV1Q0hF9pJD/JCTyUNa
         AndTYUPPJJyX2l0NECAFdPLCNUag2aatHCFHinitMAgsCg0W6NczbhnSNdB1uPIUQrwu
         WDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728706035; x=1729310835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJnps7CANHVZ0rSjZN72iSKjT69c16RYHWcaWeFxSnI=;
        b=Tq3LHf2hMoy9RC8PjsYdnNiiWYU/zOOC1acoPFVgjpTBCtwUBTaHEUVufBy/ExG1vU
         M8rW8lt7ka+FdD8/nUH0ahucj9OirgNO7eFf+Y02pxJddbsg8txXJB3e0VqRPRQ3ZdxY
         ZN7cyh7qb4F3fc/fsjUf3idVmGfsqb/wfmzxFiYzp8Hg7y1DPmJPRSYozqQlL8xnU9Nm
         kv1x07MVaIEXO/9HrId38dqjmtK+Hq7yLr4TLm8dkiPPaeSZXk18ym3rxOfLYJol+NnG
         LRQh/Xy2e2guFnCJ5YaHh+AqBCaCr9VXzttS6zbbDq3wkADDuRzfkhpr7sBmicvu9Ssk
         M7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfnZOHv50VpBEchXWyibKmY8KbO0FmFyqgHZf/kDAT708AhLosUBcHVsMl6VDnqXRwi8QFlJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2OVf2PXgq08q6r4Zt1rALY5x+LPFsoTyMvD5zYTm5za4N7V1U
	8L/js25bfwEMl4BlROCmvZiWf2UjSboCU3/SxG0ch6ggRUtQ60CV
X-Google-Smtp-Source: AGHT+IFJXzj4phvdryzflx9rWeLz6xiFCVsDs4lm4pwRQKzWjIwO0tYlP9l8vHd+2Te8Xudh68+m6w==
X-Received: by 2002:a17:903:244e:b0:20c:bbac:2013 with SMTP id d9443c01a7336-20cbbac21bamr27507175ad.48.1728706034932;
        Fri, 11 Oct 2024 21:07:14 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c21301dsm30939685ad.199.2024.10.11.21.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:07:14 -0700 (PDT)
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
Subject: [PATCH net-next v2 03/12] net-timestamp: reorganize in skb_tstamp_tx_output()
Date: Sat, 12 Oct 2024 12:06:42 +0800
Message-Id: <20241012040651.95616-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241012040651.95616-1-kerneljasonxing@gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

It's a prep for bpf print function later. This patch only put the
original generating logic into one function. No functional changes.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
My thought is keeping each patch small helps people to review.
---
 net/core/skbuff.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ab0a59f1e14d..f36eb9daa31a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5540,18 +5540,15 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
 
-void __skb_tstamp_tx(struct sk_buff *orig_skb,
-		     const struct sk_buff *ack_skb,
-		     struct skb_shared_hwtstamps *hwtstamps,
-		     struct sock *sk, int tstype)
+static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
+				 const struct sk_buff *ack_skb,
+				 struct skb_shared_hwtstamps *hwtstamps,
+				 struct sock *sk, int tstype)
 {
 	struct sk_buff *skb;
 	bool tsonly, opt_stats = false;
 	u32 tsflags;
 
-	if (!sk)
-		return;
-
 	tsflags = READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR]);
 	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
 	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
@@ -5595,6 +5592,17 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 
 	__skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
 }
+
+void __skb_tstamp_tx(struct sk_buff *orig_skb,
+		     const struct sk_buff *ack_skb,
+		     struct skb_shared_hwtstamps *hwtstamps,
+		     struct sock *sk, int tstype)
+{
+	if (!sk)
+		return;
+
+	skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstype);
+}
 EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
 
 void skb_tstamp_tx(struct sk_buff *orig_skb,
-- 
2.37.3


