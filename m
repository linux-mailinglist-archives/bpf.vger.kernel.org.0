Return-Path: <bpf+bounces-56276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD55A9444A
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 17:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832A8189EC18
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE461DF248;
	Sat, 19 Apr 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="bFlqG/bF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA0C1D514E
	for <bpf@vger.kernel.org>; Sat, 19 Apr 2025 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745078291; cv=none; b=Xf6sPKN/gxcEdgoSZb/j3uL+WBD+SyoCUFuwGdzUVKoyC8J0HQ2Y4jiTnPW/Hi5IUn0x4BEMtxN/LmFFjc/I/hWtUACXwMENsvVyiICL72ZRBCg8uj3xbsK+pjic1kCKLyPLf6u3xb3bLON9bKXAMiMrkXKiBHqWkJ4yyKxqpuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745078291; c=relaxed/simple;
	bh=aaNcjAggGzajn421WtwlUUhGoU4T/w9h9mWzPOqksEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOqsI7lUdjIQy/qAFkTm3Zy3+qxjRg+7VkP3Sv3HxzxGsLMlIrSOSSFj+wHZefGJXIlqfagjJPUZ5moM1KTuzVokVF05x4AGNMrKQNUDmHvUNsNEh1ZKF3IUF/7l8kRE41+IsCRzMPRfnuzqs8CsYj3nkHRaPTu05XA0p4h2vmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=bFlqG/bF; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so654669a91.1
        for <bpf@vger.kernel.org>; Sat, 19 Apr 2025 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745078289; x=1745683089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcR3qNY5OnJnRoRte86S6UevB3XwzFNbcqfVprWZqms=;
        b=bFlqG/bFlpkY/ykt2Aeh270yxBfDq5qCbmKwkbmoOUGpvZy7mc0WMcqr2nLBj0Pz6+
         nCy4krfEUWj8zDOMjQyvCjLPFfNI46yHsE8pvBCcG8dTyy7mw5U7J8Ne3XQLZiciuLBc
         44AOX8Y6Kmw9qhW8RY1cQQ9ea12xpE/8mQztxLcAmGU8JWI6gVbqjoEqn54rnIbQuyms
         8hc0TIi+lIHbNMtz90D1v1UIDeFEZXR8lOHh3VgEckSk4TDVYdBqyi7fOEF17bdLVzfv
         tApQbodlnfDlpvqWZv9uaY7iq5PzhrZuygqFO2p1L2TfL5nqbo/0crL9BcKzpAupmoiV
         SrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745078289; x=1745683089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcR3qNY5OnJnRoRte86S6UevB3XwzFNbcqfVprWZqms=;
        b=SIfTFS/9qv+D7n4OZVSezQT88SHmcBx/mB4lsKheUNRrrbk49d1MCgWti4v0VI2FAJ
         LPCp3eBFOszGNs+OO9gAW37mwFBDy+GiG0oETpFN6GmphL2rbvjfbzlGoZmvrnwNseCr
         Rdpe0+osqciOSNGFTVa2zjK9S0iRC5V+yt83mwN8SvoY9cAg4SzWnWrFXZNu5gw/0EsJ
         NFHZ1WpDlD7waye5u2PW6d5wmHjvVt4Sd+ZaPlw4OSn6tkX1YhteLyiFtorl/gKLIddy
         DeN+a4ZhrAti+dli10WH85X7GQSWKwDuM6FaLoafYTetW1c7LPjvFwE1Gt8ulOmnHOqV
         8jUw==
X-Forwarded-Encrypted: i=1; AJvYcCWP+1WYIpf2XnbzTW0Y0ShY2xJ1cmn/TdPfsuTHHHKtUFRU3oaJb1dkZ6aWfJInz7+ibgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+wTBtW4CkTzvoYG1l/EBenYiEkWVgI9qvBLSal4G/63yZO17g
	uTlTogBN7WxttPJvPB0IpCPM1uipoWXfdjE7jf6q2m1zcdZOfY2Y5hbYhS+WjLo=
X-Gm-Gg: ASbGncvbAz7RecGzJfsHhAbnPMM/xsy1Xz7sWI4lMMwByp+GeUCxbDoh2BiLWxcgas7
	QAwRjF7I+zVXjG6kVOvGymQr76jJeracRTSMv+BMCgDkQb93gEvYSbyB4YGN0EkVcaPAhQoXa4i
	BDUlOngWdfujKHiIgxBw+CP2+Z07XFksXIvsDU5yTFkBYZXa0HO0c9roVkljaIfoMP7urdzwXVM
	l3pYMwLn+CTEBHbuhtyVVTaobTwoNySpgH3cx7KVKWrKqB9AyW8DHm5FKKB2u6AqpOoiOWKzbmL
	5RpITkDs9AYw6tZqh971kuO/pLQP8g==
X-Google-Smtp-Source: AGHT+IHpSG1Yw8p+U7M76MoE3JR+c3kgUiqxOUfo8o+bN/9pt5LExG/gfMiODUgLiOCcO6yzjdCIXQ==
X-Received: by 2002:a05:6a00:a95:b0:736:4d90:f9c0 with SMTP id d2e1a72fcca58-73dc144d908mr3018415b3a.1.1745078289029;
        Sat, 19 Apr 2025 08:58:09 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:1195:fa96:2874:6b2c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8be876sm3464157b3a.36.2025.04.19.08.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 08:58:08 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v4 bpf-next 1/6] bpf: udp: Make mem flags configurable through bpf_iter_udp_realloc_batch
Date: Sat, 19 Apr 2025 08:57:58 -0700
Message-ID: <20250419155804.2337261-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250419155804.2337261-1-jordan@jrife.io>
References: <20250419155804.2337261-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the next two patches which need to be able to choose either
GFP_USER or GFP_ATOMIC for calls to bpf_iter_udp_realloc_batch by making
memory flags configurable.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/udp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index d0bffcfa56d8..0ac31dec339a 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3395,7 +3395,7 @@ struct bpf_udp_iter_state {
 };
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
-				      unsigned int new_batch_sz);
+				      unsigned int new_batch_sz, int flags);
 static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 {
 	struct bpf_udp_iter_state *iter = seq->private;
@@ -3471,7 +3471,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		iter->st_bucket_done = true;
 		goto done;
 	}
-	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
+	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2,
+						    GFP_USER)) {
 		resized = true;
 		/* After allocating a larger batch, retry one more time to grab
 		 * the whole bucket.
@@ -3825,12 +3826,12 @@ DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
 		     struct udp_sock *udp_sk, uid_t uid, int bucket)
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
-				      unsigned int new_batch_sz)
+				      unsigned int new_batch_sz, int flags)
 {
 	struct sock **new_batch;
 
 	new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
-				   GFP_USER | __GFP_NOWARN);
+				   flags | __GFP_NOWARN);
 	if (!new_batch)
 		return -ENOMEM;
 
@@ -3853,7 +3854,7 @@ static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
 	if (ret)
 		return ret;
 
-	ret = bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ);
+	ret = bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ, GFP_USER);
 	if (ret)
 		bpf_iter_fini_seq_net(priv_data);
 
-- 
2.43.0


