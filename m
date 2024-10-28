Return-Path: <bpf+bounces-43285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 182F89B2E6E
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 12:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF35281D86
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 11:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E351DA0FE;
	Mon, 28 Oct 2024 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeoUdT3I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4731D934C;
	Mon, 28 Oct 2024 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113582; cv=none; b=jMXNLJKAytmamnWVBJtNqKzf37z+nlEdAZ7cY/YN48y8rGT67Ei+PL7S7XMEFF3j0IkK0E9QymPhp1A9D2B89Y6oTKqHLzQwLJARNtlqcmJ2bZvJDbRiz4Bmy72tl23wsTjNy4NiA4zIIQde27m/P/TKOXPlDla0/ADVn9M72Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113582; c=relaxed/simple;
	bh=PuZIRkUQ8K4Nbm3rnLNZvyqyKXl0Mb7338tg/MZoXI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VBJl0IdNV0mn1DTpW+g51EKJWdKniYP/gnU2cfjSnSeMtwczdUgjZCuylTRTXdrvq7Y4ADpcgTbAPY0bwyNJcctwpNTfJKY/+QUO2UHeftx+YyjXWQeES3MUcLIx1uMkUf7l4Z9Awc5PcqSDJIu49Di1f5LhffK2pGbCngLnKsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeoUdT3I; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cd76c513cso36271005ad.3;
        Mon, 28 Oct 2024 04:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730113580; x=1730718380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVgQ8n9shhywkNLwNDFzDUD4fM/nq8q7zXQRUAnSVLE=;
        b=TeoUdT3IcDFJe7u7tveqNBWnmBxLSHaTdu1YIKoSVIkW7SqlHtLy7vGhjhFfdBooYH
         BjR3iE4uF9/m5isjuYsOsxKFNXhYISVNDCNfBa+hLqlKgXikqyYe1mMaB85eRX1fQ/Ks
         +8gTbw/NI3/90CVVjh1GbrhPME7SdU2T7ZMjHGzhT84wYYyQ4b+JxSe+TDOVBkB2IO7F
         ip9MfcVPiR7xJV9gONm/z49l5EtuQDnGDRyEJsf0KLglFa0IS4WrdeompTscUTe3uf7T
         qRQv71gBSNL210FW+YmmEn05om7oiQtZKA6Rbe/2vk/xj8K5kN8sg3M/1gxDE1G751RH
         lWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730113580; x=1730718380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVgQ8n9shhywkNLwNDFzDUD4fM/nq8q7zXQRUAnSVLE=;
        b=Oy+vCNqZt+4b8YCkSnIJlrf4QCHfxpleQlFvAo2vYoVGww5+s58T3nCM4fpgjXMDf9
         3UObz466+2VOY1diJ1vXoLp+D0gEDL7RoY4fCp+dP6CM34NKHIUo7wD7xPWNAhBBkTBi
         PGh08uJJnNd2+1GMtO4uSUuI63N5DjV/vFB6nRN0OGKsvgVe9rrSNh/FrCBqv9TlKwFz
         SJ5z19VWGIb7sGkgjIFScVaz7nGpc/Dle+GfWHimH0y1s3c3fLUEeqH+mRTXkduCzwQh
         utDAINN2A3HpxjjtPxgBXt2wjoNNML9dlsfqYOCr/72SrII7EFJbMYTMB+TglyZHNztM
         H7Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWViIC8rk4lgP2pPg2WrxyWOmEPPkZAgHdGb5JxN65F0j8Exjah15kAOYiXVbcBSpYW9RwjCUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDvJe5g3QQlDt+2zTjuV1pLyehULPOD6qvZz7njc+aiUaMpra/
	G3hCWI2ZqvJH3ifhJWhlEqkld+wwbIbvFTapcE61B6oa9ijGObHV
X-Google-Smtp-Source: AGHT+IGlgNB91QL9FotI+bnG6jfjoA8j9fo7eaWaJjJKUApuUYxeq0SvnK4qviKm36X7aLqaj4lZkg==
X-Received: by 2002:a17:903:41c3:b0:20c:b606:d014 with SMTP id d9443c01a7336-210c6c7351amr88597595ad.44.1730113579592;
        Mon, 28 Oct 2024 04:06:19 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04bdb6sm48130905ad.255.2024.10.28.04.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:06:19 -0700 (PDT)
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
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 02/14] net-timestamp: allow two features to work parallelly
Date: Mon, 28 Oct 2024 19:05:23 +0800
Message-Id: <20241028110535.82999-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241028110535.82999-1-kerneljasonxing@gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This patch has introduced a separate sk_tsflags_bpf for bpf
extension, which helps us let two feature work nearly at the
same time.

Each feature will finally take effect on skb_shinfo(skb)->tx_flags,
say, tcp_tx_timestamp() for TCP or skb_setup_tx_timestamp() for
other types, so in __skb_tstamp_tx() we are unable to know which
feature is turned on, unless we check each feature's own socket
flag field.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h |  1 +
 net/core/skbuff.c  | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 7464e9f9f47c..5384f1e49f5c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -445,6 +445,7 @@ struct sock {
 	u32			sk_reserved_mem;
 	int			sk_forward_alloc;
 	u32			sk_tsflags;
+	u32			sk_tsflags_bpf;
 	__cacheline_group_end(sock_write_rxtx);
 
 	__cacheline_group_begin(sock_write_tx);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 1cf8416f4123..39309f75e105 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5539,6 +5539,32 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
 
+/* This function is used to test if application SO_TIMESTAMPING feature
+ * or bpf SO_TIMESTAMPING feature is loaded by checking its own socket flags.
+ */
+static bool sk_tstamp_tx_flags(struct sock *sk, u32 tsflags, int tstype)
+{
+	u32 testflag;
+
+	switch (tstype) {
+	case SCM_TSTAMP_SCHED:
+		testflag = SOF_TIMESTAMPING_TX_SCHED;
+		break;
+	case SCM_TSTAMP_SND:
+		testflag = SOF_TIMESTAMPING_TX_SOFTWARE;
+		break;
+	case SCM_TSTAMP_ACK:
+		testflag = SOF_TIMESTAMPING_TX_ACK;
+		break;
+	default:
+		return false;
+	}
+	if (tsflags & testflag)
+		return true;
+
+	return false;
+}
+
 static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
 				 const struct sk_buff *ack_skb,
 				 struct skb_shared_hwtstamps *hwtstamps,
@@ -5549,6 +5575,9 @@ static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
 	u32 tsflags;
 
 	tsflags = READ_ONCE(sk->sk_tsflags);
+	if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
+		return;
+
 	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
 	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
 		return;
@@ -5592,6 +5621,15 @@ static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
 	__skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
 }
 
+static void skb_tstamp_tx_output_bpf(struct sock *sk, int tstype)
+{
+	u32 tsflags;
+
+	tsflags = READ_ONCE(sk->sk_tsflags_bpf);
+	if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
+		return;
+}
+
 void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		     const struct sk_buff *ack_skb,
 		     struct skb_shared_hwtstamps *hwtstamps,
@@ -5600,6 +5638,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (!sk)
 		return;
 
+	skb_tstamp_tx_output_bpf(sk, tstype);
 	skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstype);
 }
 EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
-- 
2.37.3


