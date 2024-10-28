Return-Path: <bpf+bounces-43294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3649B9B2E82
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 12:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2A0281DA5
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 11:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAA11DFE21;
	Mon, 28 Oct 2024 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijrkOPfr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FEB1DFE1A;
	Mon, 28 Oct 2024 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113631; cv=none; b=KUrF+79BeujOM/FxxBucoqAbNpf4bJwJmpL75SlCHeAHQYL3Zu/8vhP8+FEuJaINAy8w/l5Sn43h5CwVyXzZs7wbqk+32ejbfKjmfX2aFpc1w6nwmZh6S0BJUW4ORBWx6HO0an30hN9P3Wp9m7Io6fNqyua7VAcrK/mpOuue0tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113631; c=relaxed/simple;
	bh=naY7CtjoB9IrV3TEwv/nvbhSAmGOWFPsJ+ZuPtYqdQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bU09kE0EBbaLrqj7aFrBnlvxkyhGe0P79xO3GwOzgMFX7pU0PpedC/tmGr1XKKqwyqFBEH3j3RWKW4deP+H+4M5hPFmDfWzyaRigQCzXAIXPqyQ2fBR/0f9URkVuXs93sAoEsALaUmNP3xX+pbqJiIVhR8tzlPvayfzlFCSwSro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijrkOPfr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c77459558so33377955ad.0;
        Mon, 28 Oct 2024 04:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730113629; x=1730718429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr+4i8cCzp+FuMOnay9glCuPHx7TEpMQfkeXjRl7GDE=;
        b=ijrkOPfr2pxVJ8Cgzd+I+LGqETlKyuECJR4cQe3OriLHws5e50U+YAT3cWQ/999G+u
         B39AYDToe8ZF+0UN4s2mixiQJOnKe2syUBo/5dH/6MtnlhhwXWoI9tuhcnFeNa+CK/fA
         qdxT/txd6XFV02Lji+hRHJqHrvwPvRuFQbEJfR0esvwWmUOEKYMoSYP6qRLNj8rAgBfU
         075mOt6AE6nS3lU/yv22lSr1YOrLFJPCnLTA4HsRm99dcDm4MhFPqRngI77XfH3u3RI9
         e/1GUVYcBGE4BQTutALXGn0yMuqaGJSM+LlOj6zDLBUMrC7mPrab7s6ChPFCpOtCYzgv
         1+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730113629; x=1730718429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gr+4i8cCzp+FuMOnay9glCuPHx7TEpMQfkeXjRl7GDE=;
        b=BuqvWsiG5SF21wYaCs1tj1rCD3JF640WOCxYaMrGF+VgVR3mezISH7LCaGqaUMThjP
         +jTACEy8X/6xsdHDjCSfvnENM1RJ/goE+Lt4cv5WH55cCAhCYhIfNzd4ASCwDwjaZv/6
         vnFwcm0Buvdj3nSGZivsmsw8l+vCx9IlUoDcLSjZ95qsKiW+ItdnumqWCUVtlMp4Qyoe
         2EPUAMnjXxGPxkaOdlVkj6GUlu80lQ4g+RbMOFFopGJhLtyd+VybhFzOhuhiXCu2ZlZ3
         vIIUAAwn/wIputSlEUYgZ75mvwLWKmcQ6P+3WkmVxaFfHEY7STHnY+3akov7QE80VMP9
         TcYw==
X-Forwarded-Encrypted: i=1; AJvYcCV9smphzBuLPHyc4yutsBbjbHi1H8oLokB1k8GLCVh21SzGEJ7rLbER5NzTiZ53PXoMsIZkEd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQlMI62G3DvsAKxj0S+B2VhT1UzqYkYiM5NvMHZ4MxxVQNHwnd
	yOVc+veVDXi+eygo1X5kdYo0uOgAZxPgfBACgTuo+Ki7uCVvJHCf
X-Google-Smtp-Source: AGHT+IEKqIt3nLqhQYbdKR3ljfkcQ++BF5w592JEqClSOBZZwOvZpPnDgOmOCPGp+4Rd1PgQDZQYvg==
X-Received: by 2002:a17:902:e54f:b0:20b:7731:e3df with SMTP id d9443c01a7336-210c6c6a143mr129792015ad.43.1730113628700;
        Mon, 28 Oct 2024 04:07:08 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04bdb6sm48130905ad.255.2024.10.28.04.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:07:08 -0700 (PDT)
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
Subject: [PATCH net-next v3 11/14] net-timestamp: support OPT_ID for TCP proto
Date: Mon, 28 Oct 2024 19:05:32 +0800
Message-Id: <20241028110535.82999-12-kerneljasonxing@gmail.com>
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

Let it work for TCP proto.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6b23b4aa3c91..f77dc7a4a98e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -488,6 +488,8 @@ static void tcp_tx_timestamp_bpf(struct sock *sk, struct sk_buff *skb)
 		sock_tx_timestamp_bpf(tsflags, &shinfo->tx_flags);
 		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
 			tcb->txstamp_ack = 1;
+		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
+			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
 	}
 }
 
-- 
2.37.3


