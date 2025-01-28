Return-Path: <bpf+bounces-49943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD9DA20684
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 09:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5078E3A4F6A
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 08:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD0D1E0086;
	Tue, 28 Jan 2025 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQtln9N4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A051DED67;
	Tue, 28 Jan 2025 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738054062; cv=none; b=mkQl1+NqWtEVDlST34m82P6xMJ1aWvXve6ODsPjbhgx8nkHbuIA31DKCx+ZvQfrp+9dBrVEnb/+trGYGgyH7AFxftWIp+uf5T+C2BfB8PaPJLGXsRMW8ufG648BcatzgPL8ZIakZAd5O2wGjFfsk/jNywIfDHE627VxPIF+w9MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738054062; c=relaxed/simple;
	bh=799BK+r9QuZWg9Gtk48q6q1sa2nNf/sTykN5qorac7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z1F2dUsdt6Y3poK+Nv9OltQ38pHXdugIIi+aUa/Mj35WNU2/BlOlFLjFUq43Fm5l3tz8/u8ANvb6OyIjJal0ys2kbaotMmF7Z3qWAVl2mOmeOtf6cB52bfSKGokd5xKsW9QpAVUd9PxkI5tw6XAtMTscLc6ALYpfSqpW10/iaOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQtln9N4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2164b1f05caso91349195ad.3;
        Tue, 28 Jan 2025 00:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738054060; x=1738658860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNUgFFnrif8jgeaUElfsrSn4qMqyCaNOvtGck2c3Qpc=;
        b=fQtln9N4UQuZO35sIvgYF5ZsaQwDafdNKloPgDlTsfrYCbEuqyUV6+VOwNsKlcZo65
         ZHYS4H8g9qZ5UDHtmOFOv4/g3nRI1wm+JP9e/DPHeOxKW/bmSfZ5QCSWQ40iUi1F6f8x
         52TFbqRtT9F7Nhwt+IBcJR+TbW+ljpXfWv/10CbG6lIBUMQ0+VRnOBABdD076UI+cW3r
         Zgjwwax/alcFlfPeeIlIQ6VEdXZb975dzDVnLSoLGDbIjUShHENTN5jySPATuj6s4QU4
         0QRIYY0ANHpZkoKnANwKgchbu9PvvQcaFlW81YgiRPYLHBuzcB/fN0XV+/eG5N1bffJa
         1fRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738054060; x=1738658860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNUgFFnrif8jgeaUElfsrSn4qMqyCaNOvtGck2c3Qpc=;
        b=sdNiJDhOuuh4fjpJ/jKKED5pm7Vj+J8GlPBL9eOh1ioBiEXEzWpvYGUuETS9AfVJcG
         Fht3Wsz11QLSMiFcF3EZ4/EO2BarppyEd89SB8avmKFr4l3E348efVyouKkQiPDi2l76
         0YL4IsKAp8C+iIH8IfE+Br7m2cXtmrwgYG06DadggNb02vuJnXUwKMjx9hc57tz2HHhZ
         WS5ee84zWNiTdJzj+Lk/wKqXNavn2jVIWvm9f11QNfTL9qm1XsGP7tIlbZ1MhzbOhARA
         7lwz7zuFO17+KOl3yefl2TF2Udp/JCo3D5N64Sn7coGH94AavrlD7ENMx5I2GtkbSMGO
         QqOg==
X-Forwarded-Encrypted: i=1; AJvYcCUIRfxW7aKyhBYiOlLn5q41/sZVpikpdAldGfv51mofJfdYRov1WPvNaxPN5SziEJnK8FRBEys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeSwGQWJckJAngTivbLr/xkgDk43SNkvUsljVEtypx53exLYpQ
	on8jvQfMNlKIpvnN+uOoVPbUBV0bE71luqD5GcmvfXdfHcUgt4RC
X-Gm-Gg: ASbGncsYKsW+2XT0oeQyara9CbLchTxbFNzw84ZWUbviKanWvk6nQsKw8qEJHUxyt3n
	zOOcHid9LzVouwfqv7cL1XQsIbtbYd5nwCADW419W9LAfQ2Nu9/ft6d86GxE9j7GANhgYSeuq+o
	OP4gokoAKyRELqb+0zgtc/fZTK0irPzySapGvoBdjDjLNbDuETsQ0wyHrSyPEpbJ5CYOEDe8q1Q
	9+GhaAa8SWszBdTm64Q0T746qebA+Zj1g0UVZw1T0aPOwAAeKsScgll5VIpLOci2gR07VXFn8dj
	hCL0fLtyQeaRJGeXHZL6naXA7RmmZWWj/Qd+OtyBbrDSVzrU8v46GQ==
X-Google-Smtp-Source: AGHT+IGeOLZdZJxvcoHQ3oD57LURLSjLYP9tMx5Q1Wtn3wIXuY8cVkpR6xi+1D6q/lqpupBQI7gljg==
X-Received: by 2002:a17:902:cf0b:b0:216:2af7:a2a3 with SMTP id d9443c01a7336-21c3560726cmr767853725ad.53.1738054059083;
        Tue, 28 Jan 2025 00:47:39 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e2b8sm75873275ad.205.2025.01.28.00.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 00:47:38 -0800 (PST)
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
Subject: [PATCH bpf-next v7 12/13] net-timestamp: introduce cgroup lock to avoid affecting non-bpf cases
Date: Tue, 28 Jan 2025 16:46:19 +0800
Message-Id: <20250128084620.57547-13-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250128084620.57547-1-kerneljasonxing@gmail.com>
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introducing the lock to avoid affecting the applications which
are not using timestamping bpf feature.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/ipv4/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b2f1fd216df1..a2ac57543b6d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -493,7 +493,8 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
 	}
 
-	if (SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
 
-- 
2.43.5


