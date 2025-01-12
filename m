Return-Path: <bpf+bounces-48651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8032FA0A8AE
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 12:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7580A18890DA
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 11:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3BA1B0F39;
	Sun, 12 Jan 2025 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lul8ypMW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB9C1ACECA;
	Sun, 12 Jan 2025 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681946; cv=none; b=SQQqLhjBcZt3B3iJ48D8gtneHJ1qAXxMNJ7oEvy6IhZKRAQqy7oKI6DtFyqNqDh0mAHMZswxjiQJWVIqrOauOq6BD/ivEVx1DCwk7aDMPN/7hj2rJvV+Ls8hpYk9W4q7MJsRABrgc6BZF7iLUihZ/7ejo0GKZktQ+lF6qHeSCQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681946; c=relaxed/simple;
	bh=qgLgc+vtWhxd3wDw4kFYbDMlFJVL1MhDz8zW3gWKabs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JpHwW/oM/OuWntvizq6uY+DRC21ujbDte1l8N8x+ThM8Mj4Fi/KHGYa33WmF/nLLpU4MHKH18JEg/ICxGWLbk+KcHo/y/7fNWzMcDBJVXZZ6zHuLi1A/DieoivVFtvZjv6wXtqmdQEmjtODulhbRLPAAdzaooXQbaGyntt+x1vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lul8ypMW; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso4720059a91.1;
        Sun, 12 Jan 2025 03:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736681944; x=1737286744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KivH3GOTURvpBe4gz30uCxSbbTX4Z4qxExfXxl7mwmc=;
        b=Lul8ypMWkSkN2JnPYsS6lRqo3wYiXxNVA5OuSqA8GncPLzRmU+cBBS5xffOMbczE7j
         G+xlwimrtigCazP4xOS4u++W//yieg88Z06SRC6o10gighCPevcyDBVvq/mDF4gLHgd1
         cDeqge1Lr+5nuv9OxT7L45gyRLuJ6q0f4i2nCAVCTgo+0AIbae7ytzIK4UvDuV+LlupZ
         TAYZYgdrfvvz01OdbZFkjX6UrFENQlt1bwf1hPH6zZgrUdGwum8LG6y83MCsvnjUD1Ty
         w9irX1t6yJzPm4ArY0EFwesgdy8gYRlo2haGs7ndhwzDZGGQU5rFGrn8HwCY7PXR3uGo
         o0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736681944; x=1737286744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KivH3GOTURvpBe4gz30uCxSbbTX4Z4qxExfXxl7mwmc=;
        b=f2gWO/0uqH3xr7oYhONH/WbF5pEHGOg8d49FjZGftwAAOeTLX9W3v7+A5WXFVQT1VS
         qN4lldQRakBmi8kCgOmfyQNErwsBOLWux2NUgCfaYHTV77+zv5i4FDyqqb6Eu2IHrc/0
         iAo0JeANpjUmPTC5meG1dMdPAt3cqPpFDR2SYEiOPrPdVFUjLlcwx544bt3UCZ74R/sd
         HKXcARWeDANxePHeP4TE7wlVu09PTrexiTg4t9aLmwrbTjBqqRAyVlWwsxXIoMsAQOAB
         TKPnrlfsZJld152TukUG67+13sXYlLlm/sc7gvEPJtzxJDmuBhYU1TiYVlXzT6r5PaSL
         iHPA==
X-Forwarded-Encrypted: i=1; AJvYcCUZGW9hfRvnNO2McNubdPxqT0ty7C1w4ojWL08duG0cHvKOGb03WVp8GkyXWGP/cHplBWkZiaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwgDudDctECF3e2jd1vj6E3lP+8RJTHFiu9T4XpQcJTojvAcRU
	oJSX4gd4Y88lhZje59Mcw8cfnxZU6l/7v88DG6HF2bi6Gd6ldGRB
X-Gm-Gg: ASbGncsPysglBialFD0mf9wECjLy0AmPZh8HONEi8BWh9oogkeRLKBFZ/gHovIENmhY
	UAPfr1O2W4OUBOp7NF5MHh8WhO+YNCi7Hxyx+H0rfqUFJizW1zUSdtqjC2tNMLkXZiBc03+uUpA
	3q60IPUWRmwfLEfGmOzi9P/ze14qU/kDOGIuOx9WGvUjBcg5KuPgRWLZvUeDyYrySKPmkAZv/qI
	I40it75cycaE++fV4c8KSZb6ln6OfBSZQBvSTRllvdECXSyROsqTv2vWOtGo7ZjagBdqZjTRoxW
	Bk2PP5pqrSOGYw2mHsA=
X-Google-Smtp-Source: AGHT+IFlBE2of8yhL+90szVdy1s0kLksAdfi3OnOceLTRUnttsVmeqA/MREdA1M/UiW6VaUsMcRs7Q==
X-Received: by 2002:a17:90a:dfcb:b0:2ee:863e:9ff6 with SMTP id 98e67ed59e1d1-2f548eae2ecmr27094390a91.16.1736681944030;
        Sun, 12 Jan 2025 03:39:04 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253a98sm37353765ad.224.2025.01.12.03.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 03:39:03 -0800 (PST)
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
Subject: [PATCH net-next v5 12/15] net-timestamp: make TCP tx timestamp bpf extension work
Date: Sun, 12 Jan 2025 19:37:45 +0800
Message-Id: <20250112113748.73504-13-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250112113748.73504-1-kerneljasonxing@gmail.com>
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
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


