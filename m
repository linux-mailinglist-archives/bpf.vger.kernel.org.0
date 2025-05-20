Return-Path: <bpf+bounces-58569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A076BABDDC7
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 16:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A0F3A4FF6
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D437224C076;
	Tue, 20 May 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Hr4agdy/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05260248895
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752679; cv=none; b=K6IWX2WpT0krWmssSGgy5OO8aOanChd4ZOm1ESch/yCJZrakEfCTm5KFJ8rU9gBhC29WUZW98/zR5bNBi28orqtdRrlrx7b5JRC1bpmX5KDduroOUZ9Q3E7YaF7JYS+9Y6lJTp9ASow5B89a0jjVMt5wY0iZzLtAMj2TeZiaTvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752679; c=relaxed/simple;
	bh=5VghPWpATwuhOW7kZiB0WxzkkIh1CpcPgpHXW0YtKYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3nsoux95jhA1hJ0XUcvwnh+M5ZXpcd7bnypQTlZWwkA34sZKgZnQgA2BGLu2iBNs5BfMZ4WbMMLrlTikBwG5EeTViSIm5i0dlpz3JhpXASlf9sVol2KB1zEQkOlWHZyC8ZXCs9Od6FcXLjnpow71ghNQT9kUwNqkm6FISOLhfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Hr4agdy/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742766ebaa7so630808b3a.0
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747752677; x=1748357477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXbBM6tDMYpfirU9S6eabgGRxcgYKJ3B3jkW3fZ9rWU=;
        b=Hr4agdy/ENjA4KWauRIqcKF9wkj0dLUNwJpM3/0KBVV2gj2dDpT751cxI0s+jw0SNC
         guJ+WBt+oCKGlkx7qB75c6LVBbW7JrX6i/N//CDkuPdS9jB6pGWjGUK/w9sD0pRIUDNw
         nGNGInGunYrDunbbxS5hZMHHA2ydSE8yK9+q/z8AcgpOZ5a00S4NwzRd5CpmgPAiw3dV
         RIvNeV4WqVZ91uep8qyL2AewmzIibhSu1I1soVBQQQUDw42ZslWXxZ1JdQj4gjAXxwYH
         FEmXpvVo0SgpeZcV5BtN6e3A6Aa0XicB6r/3JjqkWavzsjKWUHiLRyW25Kfa4Au8fkZ2
         vOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752677; x=1748357477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXbBM6tDMYpfirU9S6eabgGRxcgYKJ3B3jkW3fZ9rWU=;
        b=UPMHhSqK7XKMF2RO74XGTPjfzBoI/+kJ6/xzt6F1vegaMdNuZVXjWgqZ3RVYrzxRqb
         eTgnabjRTklRnVFMzGP/GGJq2DyQwPaqP4WAlPO/uo8ODT23WES5dbGhM+NN1J6AuluN
         tFokLbZZPZDiCQuZopsHfqadF+refVfQTIHMuHWyRJkePvXtRgNZAoZMIo4e7AgtRtiL
         W8zWVXEllMFNGFz3+FLy3clPDhLc4Gi5mOrFApC+vOqvOmFIWWZ9rNGPS6XJ+aaEnliT
         lgPWSC4TNPK4K2PcWJiLbfPpMGM/UJjLDa4RRyzu5GAI+Uh5Eh3gHt6Kyj8cFu1AQHuG
         /hew==
X-Forwarded-Encrypted: i=1; AJvYcCVxy4bcLiv6B5LXJSoir85P3ewhGUwIpXyrN9dHVYREhFCij+pCD633hFGAxKYHtVTLky0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW313DYGE1tiK8an2iyecKa1SLMrW544yv/A4p1Az32rFCjwiy
	jE6z8G6Z2WANypx8l55xgE6GrIqARQOcj+H7zw97COG6ueXCkwVTS0Ma5Ap9rfiHMgM=
X-Gm-Gg: ASbGncsbmTQixMkHLD8JoB4h870JxIAawNADxwsTgyi5bGvI1hvdbQgeNRda/ZQPN+w
	4uNea+sdxKMkGNQ/AkeUSXXFxol2WfSirhLPg548EslTgvSjq3K5UcD6sqH4MfQY+qBV7EhBaoc
	FcUQzQum5PJpmgXBimXcTgfGwOrym4mqYC7eIrwXk+cxGDfG4lQ5i0t1J97jqgY2t4tAUwXySPB
	P11H4TTv4YnM3Ikr4IMgnmeP9t6P34YUs77ceSuvAPfB88+S+U9EYYw6wEXCIKgy/vCZpBfsgLk
	6MjOHg6sU/YkMi0ZoECl35aeOxLGo0My7b3/v9o0+mzUs2FkY2c=
X-Google-Smtp-Source: AGHT+IFxalQzvm1VFb4Y6HvIYzS3dt3d7BMaWPN/v/YGcEAP9/yXctxmSxkKm8dtmsYTzC+PddVV6w==
X-Received: by 2002:a05:6a00:4614:b0:742:a02f:ad92 with SMTP id d2e1a72fcca58-742a9914f79mr8414307b3a.5.1747752677193;
        Tue, 20 May 2025 07:51:17 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:276d:b09e:9f33:af8d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829bb3sm8242993b3a.100.2025.05.20.07.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:51:16 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v1 bpf-next 01/10] bpf: tcp: Make mem flags configurable through bpf_iter_tcp_realloc_batch
Date: Tue, 20 May 2025 07:50:48 -0700
Message-ID: <20250520145059.1773738-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520145059.1773738-1-jordan@jrife.io>
References: <20250520145059.1773738-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the next patch which needs to be able to choose either
GFP_USER or GFP_NOWAIT for calls to bpf_iter_tcp_realloc_batch.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/ipv4/tcp_ipv4.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d5b5c32115d2..158c025a82ff 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3048,12 +3048,12 @@ static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
 }
 
 static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
-				      unsigned int new_batch_sz)
+				      unsigned int new_batch_sz, gfp_t flags)
 {
 	struct sock **new_batch;
 
 	new_batch = kvmalloc(sizeof(*new_batch) * new_batch_sz,
-			     GFP_USER | __GFP_NOWARN);
+			     flags | __GFP_NOWARN);
 	if (!new_batch)
 		return -ENOMEM;
 
@@ -3165,7 +3165,8 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 		return sk;
 	}
 
-	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2)) {
+	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
+						    GFP_USER)) {
 		resized = true;
 		goto again;
 	}
@@ -3596,7 +3597,7 @@ static int bpf_iter_init_tcp(void *priv_data, struct bpf_iter_aux_info *aux)
 	if (err)
 		return err;
 
-	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ);
+	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ, GFP_USER);
 	if (err) {
 		bpf_iter_fini_seq_net(priv_data);
 		return err;
-- 
2.43.0


