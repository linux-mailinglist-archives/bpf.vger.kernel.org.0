Return-Path: <bpf+bounces-49324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6923A175BD
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 02:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3E5E7A2814
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F14B17DE2D;
	Tue, 21 Jan 2025 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdOG+VBV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F1013C8EA;
	Tue, 21 Jan 2025 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737423011; cv=none; b=FU1JhEtgblSmX1b1SgZekBjbWgwU6z9nGAVBi8rXYdPxI2remAgYGOCm5Z1qa0TuoZ1ZNi7v8j7RQ4k26ccLvqcDMd40n6e6pZNVu/zm7JD3tuCqiW8ExcN+M+tolDIt5xHBXgjKjjYc5YpbMCSg6e5rNBU0njRVcsm0+CPTHj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737423011; c=relaxed/simple;
	bh=qgLgc+vtWhxd3wDw4kFYbDMlFJVL1MhDz8zW3gWKabs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JdAJrk+UeiH3K+C2XPl8gKJT04NatsSZTNEBMBrFMxU4X2kiLT4LKd+Ejo4s3oXW8BGvKBDweVMrsknSAC9Gf6sLm85d5aAtShdEN+YEjrEPV92LAXVCblks+rdyPLoIGPctR2C/Zp/pYTQZywZt9G2BP885LMpk4ajZTmDa1Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdOG+VBV; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso9342662a91.1;
        Mon, 20 Jan 2025 17:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737423009; x=1738027809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KivH3GOTURvpBe4gz30uCxSbbTX4Z4qxExfXxl7mwmc=;
        b=AdOG+VBVuo9QcYhNmYMb/bAFOrOiPX0/sb7cXF5AshiJrMNqMG0WoruIi6XNVdOGEU
         7OADrCSKzwdd3ApQ5aIuVITfia22VBsD9tx+IE7fWVMGSGV4UQbPQvVL/z8C8pp36Cze
         EnjLP/MfBSJ6bGl4lLgQj7L0FHz0WZPEhd3wx+q+Qdj8bVA88LuO2JCh/gMjFE6wrpMx
         r2NudEuulAiP4RGYl+X1clr4kN3FhuGvlP+dSnbN6x2+lERYTgoHJjvYwjCtCJx8tuU7
         TCM3K/ZQ4E0YgpphXwtl9x2OMZzFsdonKf6jGNUYh1DxgNdTe7UJ1zTbgj8nCtAgbmQJ
         GMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737423009; x=1738027809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KivH3GOTURvpBe4gz30uCxSbbTX4Z4qxExfXxl7mwmc=;
        b=vRjOM7CyQlWbCjF4uvD45Xl+6D1DPtzn24qwapyxp5cSlzFbaxBf39mduJd81NEcgG
         53ht95pR7Zi4d2iSSltqJvqnq7rV1c6rvB5zA5cr+KbUsNAmF9AkjdJvYwoDsGMZ8VLp
         J6l1VQpOJWuwvhtc6ffGy36VI54Vxc41CL9QIKZkIKQkZT7L6j41oaREW8N7M/SmJ37y
         Dd0ZukN7QrtOdc3dLe0OtKCO+ozMjFWPKyTA2Hommn+pQM6A6vgzwsYnQTwUMc2Qc2bN
         30t2AulrllYom9DyKYGClyiDOv05eMEgRCVxNp7ysEg72nbLAQ7TrT8AIs4QGpgamCPY
         zQmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNmnIxsCRX1X63drYAMBiyDMXwBCL9MVmAX1O5+bi6svzGPp3AFsaKOcNEiqZb4f1H9427tMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXWXuv891FHGDRRVU4algg3k8EA9yTTvvnVz/h5DBIC8L3XjfZ
	yhyEh/f5HQrR+P2YRhvCrPeZXe5j6b61xjFLLW1jzhmzuDxNzj4N
X-Gm-Gg: ASbGncu2BDTQJgOBd2xIwZyaJmFAXdXHJF8MAqRdj645USu7MoG5P3dqaNOipXo3MHO
	NiaUJ/4TJjMiBEL+LhqV3SF4kN+9ALSZiMxoOHGKatio6Rm6KcgfUbiRmeqa+GxhfioHIlL6yOi
	N+20ozDc7MaLVBgWs5Lx1VH7X41SdkfYTEE0Ve9JXpmyYr8iX2bKbJyjNE1Pxwo8orl2+l7ZS/K
	8figRdJLKzJNWZXiwIjePrkP7UAKgj2Lms2DZcI4uXcEwGsKYc/4MaPmxwMm944vlvdWd8R5EL7
	pee8AYpMLhCua+Dclxz6U6je8c18TJmk
X-Google-Smtp-Source: AGHT+IGYCM24sXUmp0++3Ui6KWM+HKLLhPpJC2OmIX6jXID0jpZLMxIHzms3EHv9ATL9itib3wjT1Q==
X-Received: by 2002:aa7:888e:0:b0:725:de58:b2ea with SMTP id d2e1a72fcca58-72d8c4aef17mr40788001b3a.6.1737423008793;
        Mon, 20 Jan 2025 17:30:08 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba55c13sm7702059b3a.129.2025.01.20.17.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 17:30:08 -0800 (PST)
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
Subject: [RFC PATCH net-next v6 10/13] net-timestamp: make TCP tx timestamp bpf extension work
Date: Tue, 21 Jan 2025 09:28:58 +0800
Message-Id: <20250121012901.87763-11-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250121012901.87763-1-kerneljasonxing@gmail.com>
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make partial of the feature work finally. After this, user can
fully use the bpf prog to trace the tx path for TCP type.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/ipv4/tcp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..0a41006b10d1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -492,6 +492,15 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
 			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
 	}
+
+	if (SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
+		struct skb_shared_info *shinfo = skb_shinfo(skb);
+		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
+
+		tcb->txstamp_ack_bpf = 1;
+		shinfo->tx_flags |= SKBTX_BPF;
+		shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+	}
 }
 
 static bool tcp_stream_is_readable(struct sock *sk, int target)
-- 
2.43.5


