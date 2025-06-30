Return-Path: <bpf+bounces-61862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B7AAEE579
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 19:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A4C17BB9E
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 17:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA22293B53;
	Mon, 30 Jun 2025 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="q9G1YIaK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D649241CB7
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303850; cv=none; b=EOKWY8dl16kRqibU91d3/DjRFwk3Fr5kGrqn3Pd6NpNqATx+GV/z4/2O7HYwKJ6fDIa0SMk6ll2BeRkseLb8VlGRtE5Q7LCoJTjCQsWAXm2FaUW9DlMQNoicbS/6BwVzztS6m8gL6xYD+pKnrc+AQ92v7+Crt1WrclkLqzVY6rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303850; c=relaxed/simple;
	bh=P2TM48kjMxPSr7YwvwYsCNfh+euwlg0K2KRkqviR9cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2diH5pPHxWWWKSWB1OgaX4SlwQhTIlQtXSbloBrb+GZOv9TwKm/0qQo+td4lpGkJbI2HC8zwH/JgOnKegPeUR7YTTqFpmkS5HhUlSy1SaZEFKCa6JM622Uu7AFxEr8Erz34KCCO8wRp+8WnjWH6GGhDB1bZGJvcUHNocQn/tBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=q9G1YIaK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748e1816d4cso311471b3a.2
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751303849; x=1751908649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=q9G1YIaKfMtFMMDFtr6iLQzISckJd6FBYr9JIR6886XM59vHD6N7cbvTvb9yNQiYKH
         6FLfqpCDg5MqVyWwjHWXoHOANeaR5wvUjod3iBd+xo3Lhcquj+mQPLQ6p2qjdVVCtBwy
         BoXXBwE9Q3y9nj3WudZ4hh74NQjGupxl6DLvB+DadfQP4UmXWP2pSy9QNAMK8PZJO3Od
         /np3ra2fI3ov5r0o1W0arg9CDCPXbQkYYGIsES3M0RcpxeX5dIpvsSsKXK8TuPwRL4lA
         0PaUbKOmlVXL8Pb5pdUeK6QbNeUUcP8E/m3aoeVfk834HgbQ3hRK+tWYegQBmuRfgnlH
         YYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303849; x=1751908649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=ZU0NgA0XyXTfj6THv/lzJ0GkhfRJCHIqSRGS6nUzPnqrsenSdcCO+21U+XI1reNiqE
         sg7ReD9nxfkFH/gbJoVn/klUsyXN6wgWFHnVGoeYLM+Cz5FHsA66/sOE2rOdxiXWo2Kh
         RBh05PKBGh8jfjtyJK+bc+T8xwa2Zo15yta7KV4s3g5+pfoJXzse/YHURXRiSMQGlnEH
         4EYEwGYgP1xzoFxvWXYVvYpJjiK1CnZ9iMjSL4AljYALVxxNy5TSPUX9K7uog9wVf2nP
         qieT1JQ2reYB5FPwaR1g6QdoGEFWRi1CoK7U9kidJj0+WkAr4Tm/V+BFwhZif9Vgy0VL
         STaw==
X-Forwarded-Encrypted: i=1; AJvYcCWOozptri73M8NRBH6Vo+BKGRpAIo8795O9Fc4maExgwMOup8wvrfUSRvwCJBZS6gsx1mc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd5phod3vBCimXF2Wg9ZqFIaGKMQ9AKDwcpgpieaGGkTkkhB7K
	UmK2ln4JgbbqYiJ2OKN8rwVCpbqhRXC0KHIYVGQnLIslYJZmIEeJv3ltoPi7tvfB8fA=
X-Gm-Gg: ASbGncuJokEUW88Xui54o/Uj8NRMji8jMfsvtc+w1KZF0hlvfNzWs8WTDenuDupbD9r
	rBbu3GnjRfDCZtlQyk6SsHLpHHPA3rJBhtTIaiaZgxLxPfM5VUsd4raCI6vfhDinWzPjNtQplqM
	ah5Kzu95P7NZQAdmegV5Inx75J93HJKC5md3l9XuvDgBpemwFWifH3VQuyjWhmLU5ycCEhqSdip
	521TFaLHyD2kJG9l2QHZ/6upOhiJXhvgaz3/46uWRNl3rm4eZHjUYbFspdGrfwksHI/SgeaUSG4
	9z3MuafImVwSqYMmrMnubR+rdPzVczUVd7ETdPXpzbvJEQ78o1M/uGpkJkLQ
X-Google-Smtp-Source: AGHT+IEHjfbIiymPPKtQQ5dFAvdqRmi1SUi7T7b54y72xb3Dwj1I1VzH7q/9bSodgZcp6Wd0cpY/Ug==
X-Received: by 2002:a05:6a21:9985:b0:1f3:478d:f3b4 with SMTP id adf61e73a8af0-220b1665595mr6030424637.10.1751303848581;
        Mon, 30 Jun 2025 10:17:28 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:9ab8:319d:a54b:9f64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a846sm9229232b3a.31.2025.06.30.10.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:17:28 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v3 bpf-next 01/12] bpf: tcp: Make mem flags configurable through bpf_iter_tcp_realloc_batch
Date: Mon, 30 Jun 2025 10:16:54 -0700
Message-ID: <20250630171709.113813-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630171709.113813-1-jordan@jrife.io>
References: <20250630171709.113813-1-jordan@jrife.io>
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
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_ipv4.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6a14f9e6fef6..2e40af6aff37 100644
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


