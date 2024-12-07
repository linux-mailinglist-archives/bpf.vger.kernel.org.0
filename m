Return-Path: <bpf+bounces-46361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BB99E8157
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 18:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65B42817F7
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 17:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEB714EC4B;
	Sat,  7 Dec 2024 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+J/Sepj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDD914AD29;
	Sat,  7 Dec 2024 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733593151; cv=none; b=ZA7AzvIGMiS4MosuO758me/BcSNbXEK/mOS/XoG4Vzgf8xyCBHARjfboxGvzk9ioTpp0bZk72/0isWtLDJ2UzLOygNjhMz0DIgktHy+B/EE4t5eGiuC0rIUqPUuAxIp0fDggJFyP8HnYI2RyXxiGfkXG84Qjd076qfXTdhOVYE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733593151; c=relaxed/simple;
	bh=bijsTIYVd1LX8XtwU0X8HN1VCD+Us+RVP5e7v+JXFcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lva9n727w0ia6Nqn5qosgT0cuis0BHZER0FDbuVy/V44PUvrJmVptMiBHADBq+Qfjchw/5vQF/certV859L5UkC3VPIo6yGfowtJsGkqcJEfSQGT2ORd80RORAPi+eZPfgr0XLGGUk3RcMLPyMYxFwo+KJAaQ2Uta1mUv+BMGgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+J/Sepj; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fd2ff40782so1147258a12.2;
        Sat, 07 Dec 2024 09:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733593149; x=1734197949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBXPcNbj0KzOTzC7jsNG44PhQDfUznpDf2OHrcTnaTA=;
        b=R+J/SepjgtuSjCONQyWQVsvxnKwue3ekb3GjbTvQa1pV3XL+hAy0HQ7HwnGbrrWrHp
         5ZnPptDVHAWMSFaOeQAky9Lxnix2ZhgAmF2L+j5HfEWk1eHdBm+HzAlPUTiJLQdekvr8
         g3ThvBrkIRG5Fh41rA0HyX6mp2lu8jBmmmqG6ip1y7CZkzbagUlgykll7Jg+NE6YgBBN
         a31u8kMIsX8D3xiScXAd+aa/WG5gBemPUvZx9aYfL4Urt120FqWcE2UIdH5kIF+e3Hu0
         WnPq1CE4RC6mAiZVa9GBlseQJizWJ9xZkfGjOq6uICABcKyRRd8oExfVtK5HCgbG3Uf3
         1aNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733593149; x=1734197949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBXPcNbj0KzOTzC7jsNG44PhQDfUznpDf2OHrcTnaTA=;
        b=m0LHGX0m+aUjIXLb7u/VJqbdq2IFWOP2RMUOswOMazLRXuarPHTT42vapAcv/oL1kd
         7wgFL00FpwK3IP4xyGNxgb7SVym5tmNfY3P3QdybTxUo+wnxGdmmNfeLYsS2p8uypdtF
         2XdGg19Ad6k7NoAoe5iGTmafEDHXdsG2ynTxYWyOnM6hMdTGUlnbDSmDEd4ilwhe2fU7
         6yCjLoyxySTBos/skMVF+lkAn9wY+2Xj3RBhmARSlhgpLmzaN8FjmtNdQ+iUO1X4vwve
         kDIoPCqDLYIU0E44pTbYuur7c8GvvPNr3ZTtXSNuwP/vHDwD94uYdq23ohQmHVt6N0pt
         WlMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd3VEsDlYA6zJ2UNhaOWEdbX6VxeyLp+95BhPg+1LRlhWlu3y8tTdiFTBf4bUux2HBOIe3jU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSc59f++ImAYewDWhW4Bu/ZAUzvCq1+PUkmBcBRR6KxOaFlCnv
	qJq7BtsDh36rwX/RUZaalnV+7xOuBtqAELmnHW7+Qe3vqn5F1wYZ
X-Gm-Gg: ASbGncvo8vODo16tcBGTh3RBBhi83wBicw2HdgM9fxD+wYpHZOezrDOAqGB/T84HgNY
	SD/DpdjC8uwi1oyaqzAVKjE7OC82V74KaRVQC2riNPanWpqtFI/BlRxc37RRa1lv3pIESa4I+Tc
	0Q/yrtX7U7eEawqh3ewj67hH/3UbGcf6LNSdvY9k4DXjAr/oqzoCk34O1ZAXzSoWkli6xGJLp7u
	+C0l7OkFcvOndSD+QKG7wEAbLsmyM5K4/huy1SaSc+c0jPhM0I58YBkaxPlSfWfKWwG1VFTqvc1
	D+z/7tslzcd/
X-Google-Smtp-Source: AGHT+IGzETtGy6/iqy/C4tSKGI2KE3aHV92j1Gb92HBISGwW2w/DjSUM97/LFBUTSyyLCQIk4mzFdA==
X-Received: by 2002:a17:90a:d88e:b0:2ee:aef4:2c5d with SMTP id 98e67ed59e1d1-2ef6ab10353mr10473345a91.26.1733593149538;
        Sat, 07 Dec 2024 09:39:09 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708b807sm6963793a91.43.2024.12.07.09.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 09:39:08 -0800 (PST)
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
Subject: [PATCH net-next v4 10/11] net-timestamp: export the tskey for TCP bpf extension
Date: Sun,  8 Dec 2024 01:38:02 +0800
Message-Id: <20241207173803.90744-11-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241207173803.90744-1-kerneljasonxing@gmail.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

For now, there are three phases where we are not able to fetch
the right seqno from the skops->skb_data, because:
1) in __dev_queue_xmit(), the skb->data doesn't point to the start
offset in tcp header.
2) in tcp_ack_tstamp(), the skb doesn't have the tcp header.

In the long run, we may add other trace points for bpf extension.
And the shinfo->tskey is always the same value for both bpf and
non-bpf cases. With that said, let's directly use shinfo->tskey
for TCP protocol.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/skbuff.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7c59ef501c74..2e13643f791c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5544,7 +5544,7 @@ static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb,
 				int tstype)
 {
 	struct timespec64 tstamp;
-	u32 args[2] = {0, 0};
+	u32 args[3] = {0, 0, 0};
 	int op;
 
 	if (!sk)
@@ -5569,7 +5569,10 @@ static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb,
 		return;
 	}
 
-	bpf_skops_tx_timestamping(sk, skb, op, 2, args);
+	if (sk_is_tcp(sk))
+		args[2] = skb_shinfo(skb)->tskey;
+
+	bpf_skops_tx_timestamping(sk, skb, op, 3, args);
 }
 
 static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
-- 
2.37.3


