Return-Path: <bpf+bounces-52052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3287A3D243
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 08:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B1D16EFAD
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 07:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DEE1E9907;
	Thu, 20 Feb 2025 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY+Mr/+J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88093198E81;
	Thu, 20 Feb 2025 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036622; cv=none; b=Zm3ItEZqwHZ0wpJlRH4hQ9lBVaSfnfDsfblEsP3V14Io/BtXu49qDWBF1KHgs0ByXON5KXyRoeySaAJXr6MRW14bXCrfceGDPxlrcKHsVbjNpQbzs3owlPznG53gelkV0mTZkywR6LuJs+l0pukt7gVBPRsqnJxKCAxqa4gJfNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036622; c=relaxed/simple;
	bh=QnkYLGR0o0oh4JHZ1jUcf0VUu0sG49ZtxlYMSdcro+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RKfkZ/BnMtLoMsTJv1epNgiNOPbqQie65OZM0THNM1X308DiQuAhYjBNWXtuU4Da+krnVBQf7ai2wJiy4CgYAqu6YdZXxR8iBXUeKOycjOXL1A/tm7YzDeKIK5LYsFjq9Bu7ZCF6spHdksrkW0uU4F9f81/VWntbH9HaVnIMx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WY+Mr/+J; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220d601886fso8203935ad.1;
        Wed, 19 Feb 2025 23:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740036620; x=1740641420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B65KFV6AD6yU5phhSrRrO9qdMMHj6DYghKCH3Cqv1DY=;
        b=WY+Mr/+J2/n3g1xMB040xzEtOgtQU10hb0918fwSRSCmHPgNkIvL4yJUnOs6a+CqWc
         0HdZTuLHboKjfK7cbb4M2P46Qh5xhmSCPbKo+vX4mTWx9hDJhMWhsdo+yIEjKA8BBSPQ
         KWAW17ihB/k7HAst21noT+sEox8dkWFsWlqYJcejOP+IpnGgMDrKqVLUSCiEKnFb6+UO
         x8RywcfGaKebgvirX45Px2f/1YveKk0wl0ulYTxF6mHTFoAOen84odU1Vqzalcb+nV6t
         IwPNJ5dn5PX3MUekEbNfj42CwDsNDWI5YK9mJ4lluJtcJ/7v4vJj3rlTwYWle9nuzuPP
         F++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036620; x=1740641420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B65KFV6AD6yU5phhSrRrO9qdMMHj6DYghKCH3Cqv1DY=;
        b=vmRWBYfkqlq8FkVvmsAZVnG67aIXXD6PrUTtPdROyePVN0UOvZcw4b5lE+02xch0Vb
         8c+cEPg/PsBco5JkI8LvrBhdp7flFpNUr7TLJLMuaLjDiyF6MAvLO3nfMAl5fLDXvGXd
         7xF4w0lRB/oasIECpb2yBd0k3fv63sZcwdtt/Wh2/k6jNoaRgvE69mhoQwD843xlDxTy
         68b0ZXNSmUR2m6EyX0nwVM6Z0ybxKo/2YABaX5cTqkQxcTV34aWq78wVYROMendQ+lzr
         AoTBkCsI+LqSYjZ2cYOLAVoMI9y/0Fbib0qKfwgbCnfNHAfE4F2YWwLE66ItMOZnxwz8
         kMzA==
X-Forwarded-Encrypted: i=1; AJvYcCV9/byWs/cydGlHNEs5giwPBnveeiHO00Ibwdzuk7/X/xSVpEA83fsUgKNz30JOzj2EVWTr6qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW3xTub4CPWHQMjWsPiC/qasFFpcb0VgzjBE1l1m3MBFCWixGg
	NBVnez4eIGXerVISpVAWs+cnPeg72Wj8WqAxgnw1/Zv69wk8YO2L
X-Gm-Gg: ASbGncvuDw/IDYmr1ZxpgWRST1GcOMl6fnYhnIvel2k5YTsmy8+gYGJ+Dufrz1HjZaH
	VQZx/lFqxtPmTaqI8jK0CxZl7RAFLZtMg6X68wb8Amvr5NB/GDXXB2OWr426HyfbaDbW+yYBajt
	+pZPjAf3UWH+eZw0cpX5uA8yI5ACeDLgqqT7QJVV4jsxdcLdVmQYWOpe52WfpJ8OjtH5cyIDcCy
	TNapWjrGalBcK53HmFDMdbFMPpuBMqYoa4C7O4OEbgazbDXrHdTmKMgO3Y6csDm8QwWmp2xWiQt
	4y/5vztw6OY86Cv+uIS7Zuw2c//9Lb28GZy3aVNVfWbAvFeqJCoDB3uOZM00hds=
X-Google-Smtp-Source: AGHT+IG+B3MQ90cGIGbgwYLS6Kz77P4yW6P4p/ivaBXxM71emFDscyQWaa2GEeYItFHL/1zKxnshgg==
X-Received: by 2002:a17:902:ea11:b0:220:ea7a:8e63 with SMTP id d9443c01a7336-22103f19fc8mr324133045ad.17.1740036619688;
        Wed, 19 Feb 2025 23:30:19 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d643sm114048205ad.126.2025.02.19.23.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:30:19 -0800 (PST)
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
Subject: [PATCH bpf-next v13 05/12] net-timestamp: prepare for isolating two modes of SO_TIMESTAMPING
Date: Thu, 20 Feb 2025 15:29:33 +0800
Message-Id: <20250220072940.99994-6-kerneljasonxing@gmail.com>
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

Reviewed-by: Willem de Bruijn <willemb@google.com>
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


