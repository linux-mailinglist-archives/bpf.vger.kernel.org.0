Return-Path: <bpf+bounces-51803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4971AA3924D
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 06:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2DF17A3987
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 05:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220DC1ACECF;
	Tue, 18 Feb 2025 05:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMwiUcYA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA83ECF;
	Tue, 18 Feb 2025 05:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739854955; cv=none; b=p8gniiyt+/ES7Hv0e7yAD/uCsZHL9w1+k29MHaLjfS6fKqMTUkcsFIuZWOrQnbx+WXhZpYy+GwxfyxcvH0Qupi6x4LyHLj8b1r0s5f9LE3lfzlK6ToVYB/TNzm9NI8gTyyCV0OrXA3vWBf+QC0lmmgM+0MowT/m/QkYPRWbmz3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739854955; c=relaxed/simple;
	bh=eTHtJrLTgKPapbvhe7qwd0kLWB4F9Df0+/dv2qnCE3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QQkaLdkzM7Dbej0REY+kOnruDQdQDAn/vd4lnmia8HTerRY8jZezX+aAh1nqhhkDxu4X1lKa++HF7FYkWIJoiL9NZs96lqd5rc4nxcEUnI6hb/ojfGLz6ATElUVZoyIgQunXqSj/SHfJgS3gsFy3BrXSJyuOpBqlu4tvMFBczMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMwiUcYA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22104c4de96so41232565ad.3;
        Mon, 17 Feb 2025 21:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739854953; x=1740459753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJ9F212PtsSHKIVUZOrPA2mk84naWjg27j0jUX3VDVs=;
        b=aMwiUcYAbUcy5ARrj4oXyeg4tLU979DmpiWnpLt/wiFUbDjn3EAGYvvxacLx81tGEs
         TTv7LU6xkuTx8NWFwcOoFs88LmLdS813WvNLMyngSPeqK9vrC04kAYz12G1WoMYYS8BH
         302+4Tu/F3lU10oPxVhMll7RKsqiDWaPkGeKx27HciKrW6BUZPlldz6DRxruZq7QdkNT
         VWB8gaM/uBiDbKoz3K0/qJUkogYe8hOREF2wslD7HoshCavOqO6RkbmAfP5EngkAWJ5L
         SMykXDj+VLFcJCcoxFsNuF2nCLojlvffRk1ZeR8TVNlhG1pfN1DUXoXIuUev3NmpZ6hf
         PEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739854953; x=1740459753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJ9F212PtsSHKIVUZOrPA2mk84naWjg27j0jUX3VDVs=;
        b=B2Uqv/mT9/B8W+6pris1pBZud/MQAqXzFtbVE1oenQpXMr9ysr5TH6UNoOxy8HGpQg
         p7cDz5iOQxrva2CAGZnG4j/hnXbsW4nbEc5waIDv15Sio4p8C3cSckxIYVmOFqDroHsz
         G54J+7VzLz6xNVhuTF1TSsPz67X4J7E5ZJ7lpN5t8Sqi8hl+K8OJYfISF4zjOkbna+05
         ir6Cc2l14v9ti4x+dm3Q7ic7pZRIsoqt2ONdEEyrBZORu16x35/1YTYLtPzGVp+1tQsB
         TuZ+5Qp5ZfO79uG0wzEVizr6eWezxf4a+okwki1z0iJm0zHiszBLt2RaxdkdhflrHTNp
         3Rtw==
X-Forwarded-Encrypted: i=1; AJvYcCVsQunptakvm5HsCcUvnu6+LnhAMxNQKEgYMVRNcr1oQbSMxEx03BOrJ2dQJkoXtpGIAIau0XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV5NPeXbnt72kg5+D0X5DX9l+zyvB8luCha18IqLqv0HnDZrG9
	M1g0wH78uIngRsgTT2VvTApQHD3v6pbwNr297Li1nXjcuBBoFA4v
X-Gm-Gg: ASbGncvXuLNZeD3rpSRa4oleAKN5coTpr1roR4UPRiaLMnh7y+M+m4WIk0GVxZcku3L
	7JAIhjiKyeQylzrHdyhgcFce72pzcWYi49giRZLc23KffQU0aC+gGVr3bxSinT0zzK950lBAJym
	EqjROYRs8Il9zrSY7KoYmuSTXVg0WtrhtOOiORUEEApGpwu7oz7Y8MRn0zvtz9zN8WYqqHvBqqe
	ACPIbQgbkG6kQ/zZ0MnaipRyCIxWMBpcBd1pm4BJicWKe6wlVkWk3PNO0wVopsdrOSbj2Ha5w1S
	d6V47dkXVgDNQDT8X9bF7vwXy4QydEot3EfYBeCfR046oB0z8/BVJ22k9umMclo=
X-Google-Smtp-Source: AGHT+IF5jNJ1zaRLc4VHBX0frpikS9WNXmW8Uck/woIYq2085fB3pqq5bGx8lkSyYr9T4ObYzUp9Eg==
X-Received: by 2002:a05:6a20:72a6:b0:1ee:615c:6c8e with SMTP id adf61e73a8af0-1ee8cacbf27mr18660115637.9.1739854953526;
        Mon, 17 Feb 2025 21:02:33 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adda5be52f1sm4337938a12.34.2025.02.17.21.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:02:33 -0800 (PST)
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
Subject: [PATCH bpf-next v12 05/12] net-timestamp: prepare for isolating two modes of SO_TIMESTAMPING
Date: Tue, 18 Feb 2025 13:01:18 +0800
Message-Id: <20250218050125.73676-6-kerneljasonxing@gmail.com>
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

No functional changes here. Only add test to see if the orig_skb
matches the usage of application SO_TIMESTAMPING.

In this series, bpf timestamping and previous socket timestamping
are implemented in the same function __skb_tstamp_tx(). To test
the socket enables socket timestamping feature, this function
skb_tstamp_tx_report_so_timestamping() is added.

In the next patch, another check for bpf timestamping feature
will be introduced just like the above report function, namely,
skb_tstamp_tx_report_bpf_timestamping(). Then users will be able
to know the socket enables either or both of features.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/skbuff.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a441613a1e6c..341a3290e898 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5539,6 +5539,23 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
 
+static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
+						 struct skb_shared_hwtstamps *hwtstamps,
+						 int tstype)
+{
+	switch (tstype) {
+	case SCM_TSTAMP_SCHED:
+		return skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP;
+	case SCM_TSTAMP_SND:
+		return skb_shinfo(skb)->tx_flags & (hwtstamps ? SKBTX_HW_TSTAMP :
+						    SKBTX_SW_TSTAMP);
+	case SCM_TSTAMP_ACK:
+		return TCP_SKB_CB(skb)->txstamp_ack;
+	}
+
+	return false;
+}
+
 void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		     const struct sk_buff *ack_skb,
 		     struct skb_shared_hwtstamps *hwtstamps,
@@ -5551,6 +5568,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (!sk)
 		return;
 
+	if (!skb_tstamp_tx_report_so_timestamping(orig_skb, hwtstamps, tstype))
+		return;
+
 	tsflags = READ_ONCE(sk->sk_tsflags);
 	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
 	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
-- 
2.43.5


