Return-Path: <bpf+bounces-48650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC24A0A8AC
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 12:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39BB166FEB
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 11:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821D61B4F2B;
	Sun, 12 Jan 2025 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXgSeHGP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B721B0F04;
	Sun, 12 Jan 2025 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681940; cv=none; b=BPfqD1ykqD7yGK0HLAvtM/Hx1hVOR8vCu2zr1II9JsRWJe5L6SCINxfp8LttZN7bdeBtSzFioidteos+i1ATEybVWbfVgILhCakJt+qn5dSTKFay+f8KxwF010h6q1jRFeAu2q4W68Qid2ZiEZJWoMic6bE/xqILSqg936Of3sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681940; c=relaxed/simple;
	bh=l0HwOE6TA6jWDZ53BRGT8mO7j3+7n0GEQvnNRfFQObo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U4qosKv0FHKva2EGqtr7asN+7wWxwGXJiGSnxh//+sNa7p9sbgzMsrE5vdnljO1rZ4eh8hzOah6US9MVKWPTgXG8rGteeOfHvqFug7kVB3sXue5LN+GBrnK9tjYubzoI8XUiHB8ttTYkhrD17crVC+26jHzynb1mr1UoaFkmt0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXgSeHGP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21636268e43so77525945ad.2;
        Sun, 12 Jan 2025 03:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736681938; x=1737286738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6Ff54bFoCS8x70EOGd3R+aVHVP1OimJz7qjsT1++RA=;
        b=nXgSeHGPLpcYancyWIr9+DXI1PHxPT+kEb/qUyA0+4d7r0T/1vNT1v3cqE6TEP07B/
         tK1uE9CRlGBn/NRB3zXx732e9ZPjQWJx70zVjir36jgj5oe/UjORQZZxpFnP775wKxHt
         wCH1s+q5xfTh0drfiihpfhBDJNW0HvPyCRzhmMPRubaeUO2YT3zGAFwckNocJD8ocO0P
         jedj9vMy0eECsaegIoFs434XDENzV1dS954b2SS0emK4hl0NRUP3MFzQ/6+cnRkj6a+J
         bPGcyoSTDmPJyNoJLXwRsUqglfc2FRQ6siPTJNQr/H/ns5Xq8YPIuwANTBRydx69/EK+
         sFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736681938; x=1737286738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6Ff54bFoCS8x70EOGd3R+aVHVP1OimJz7qjsT1++RA=;
        b=QoJRkesPM1X6JjqybZYYs7TUbu4GbRQS/UeAFWRLcJChvP64V5SyKKkPZheSvNisCx
         Lmb3l76NIuhPMbnEEez3A/p3rbaFMFsLRxRc4+1I8KX5KDH2AiL2w/2IJNiZgNRNtIHc
         YK+PlXpvvm+JUWf17yKpIRBUGDj1gErqFcjAH89iV82Z/PQ+bPLAnYHUTyRjdiwZl3XW
         1p8zn+a3+HOrhn9Hghyx8IcdtgSCIe9AyPL9umlhxAKudF8V77DUnE0M1sJJlwHN2bQz
         zriKMBSS3BT/K/1Zfy9hS2t3gnbHWC8zuj9Wcf0MDnb7+uBYEXB6VTjiuHFyvr4hiK5X
         iHeA==
X-Forwarded-Encrypted: i=1; AJvYcCV3bK0ViyrYvx+TT8tGWScUzN5Ng+BAm6YXdebr/sgUSlokt9L/kwcI3y0/R670WIFwEg/nLBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaFqUhG4k9dc0Pn6PZ4NT8qjJdDIT9J2/37JWExWFkwuHS1Qgu
	u43TmojZf6+ATHKnsXCNWa34BVewifk5YKULQVd8qVLdzvKmxb9yZq+Fq/MI
X-Gm-Gg: ASbGnctoiTWr37EOeMEK/FkFY9sJRdlyYo3VyonfoJnazjMfs5C4ZeUikxTyrWI46kx
	vNNLtVFvxDBFfmAIL+ne1oDLE2fVUnd/lrzBqSQlBiV761ItX0hxnI3OexmMHnBjhYGWQfG9A9q
	cC33Jg9Hijp5xS+TV7REecz5ujexMmJEnd+McdOWINhiKY1h8oTmhRrreG9s9ZBMEODYRnt1+Fw
	XHeFr7cFFIC15VCZa6vPCTOfVA27RbJ7+BvWb+VSaAcljYzyi9r4QBWxafJB1Hc2lpS+dlZrGDX
	VpDioYT8EkqRe839Uy0=
X-Google-Smtp-Source: AGHT+IFHxfDRw5UTDYrd265TKY9WUTby7ZQmi8Z11rkFC9AktvRhKkh9JMGe0aimuD+Ktt+hg1SBaw==
X-Received: by 2002:a17:902:dac6:b0:216:4a8a:2665 with SMTP id d9443c01a7336-21a84012a17mr257867615ad.50.1736681938120;
        Sun, 12 Jan 2025 03:38:58 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253a98sm37353765ad.224.2025.01.12.03.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 03:38:57 -0800 (PST)
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
Subject: [PATCH net-next v5 11/15] net-timestamp: support export skb to the userspace
Date: Sun, 12 Jan 2025 19:37:44 +0800
Message-Id: <20250112113748.73504-12-kerneljasonxing@gmail.com>
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

People can follow these three steps as below to fetch the shared info
from the exported skb in the bpf prog:
1. skops_kern = bpf_cast_to_kern_ctx(skops);
2. skb = skops_kern->skb;
3. shinfo = bpf_core_cast(skb->head + skb->end, struct skb_shared_info);

It's worth to highlight we will be able to fetch the hwstamp, tskey
and more key information extracted from the skb.

More details can be seen in the last selftest patch of the series.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index dbb9326ae9d1..2f54e60a50d4 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -958,6 +958,7 @@ void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
 	if (sk_is_tcp(sk) && sk_fullsock(sk))
 		sock_ops.is_fullsock = 1;
 	sock_ops.sk = sk;
+	bpf_skops_init_skb(&sock_ops, skb, 0);
 	sock_ops.timestamp_used = 1;
 	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
 }
-- 
2.43.5


