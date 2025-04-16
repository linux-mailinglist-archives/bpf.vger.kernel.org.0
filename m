Return-Path: <bpf+bounces-56077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC28A90FB1
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 01:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B4A1900D1B
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 23:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C5124C066;
	Wed, 16 Apr 2025 23:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="cX2vhnb1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5422824BBF6
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 23:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744846600; cv=none; b=k7BzqXYb+L/UsZopqva9K9CqyrLqGojqqwrIo1jq+PPhZQ2O4865fOVmKQz4BhLiyUOdpeRCf+cgBXZF3SQl0bnom5eeBj6bGXhGJ1O6cGwONLeOhneAYAzW5DHBz2Vx0L21SjA34gzoP6mri/I0Qo4tDzU5M8x6kf3YWZ0Wl5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744846600; c=relaxed/simple;
	bh=zaE+396ROcTWAjcHFPe2BtH+pcEEuQFFjnAb9+BfFg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdksMfgGFgV7zsK3h5OqDcJlsr7ZMXESBh+Nm7CDRlgJ/I/NFwMNK3BNZG6qXPL2H8qtZ7T8wy4YBoE7UcfRZKDepmkpmASbZCZZDn6Cc1+7+EVihGSkh28m30XR/dXxdf8mCwVRmvlhdZ2mmPVjZ9Hes6htBTN+App8bMAIxTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=cX2vhnb1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff62f9b6e4so26104a91.0
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 16:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744846598; x=1745451398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZ7SLZCLGXYTHRW+/oBLz9DzTLKdwrsn+Bb6jL5W9/U=;
        b=cX2vhnb1TA6QCWTkrXno73tJo8GDJWd8Lrm3rXuOjQMdb3GGt8PgS7HkYi45I4Fke2
         zia0Ma5hWIyYwP4yvZ9MNkkY6qpRpfPPeyqMpkW2XjVlXvvcpPF+Kc9jaUFF87Xgl5DV
         5OpLX8Ngvw+feCGQqzAYzvJduc/5o/G0Rg4AKZrx9jTHS1hjp4Sj0o6kH261R0BNhFIJ
         5kkgknrKl3yy4Md9NubWuxmgGdNIH2H6B/yCDKqL5nfNATkEF7V3bT6J1SOnOoLGDwZS
         +8Psp9hfBmTafpk3Jj3eUfTh6k2QzRj1J1CWJo0MTgO3if2Cak/PskiD7lN3O2P+XeF2
         t8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744846598; x=1745451398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZ7SLZCLGXYTHRW+/oBLz9DzTLKdwrsn+Bb6jL5W9/U=;
        b=Hk+0OJ8inNoeG6vSs0VUOpjQwFakDNJX8vYdGPuQvfb+JVW8sWKKYkHaVLQ8CCXUu/
         jzcbK6wSaf1e8vuKlJjyeIWq3V5PWOJCJL/5E30USK2HiOTzxJaQovwfsAUNx7NZPczw
         aTBPEhoXRMXJ8zNmESjyvVkubCiO5vRn8GNF1DuYkvPkO1yJDwgfFmKPdrtDHJuxdsuK
         l3LQzuJWgK0Eh21Jndw4EQPtvznNBi/WwIaLKGiwAQhFHFBlAnNsaU0fsRQx7BfiUYGk
         hnHEhEvqzJ4aT6P8jQuR1z/NXcCNZ2aeFsdy+vW9iQHBwrnXolIKJt8hciPiZ2DGS8OE
         8QyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnhjL6Cn26P1cBz5CG+ekL4zTfDn9JqXcQZziHEMRrf9hBGHLzMPpv8iGtd418V3exjW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT29rQp7qGbaqtLItGr3NF3iK2ZVQI8vu8lgi9nIyatNZVBw0S
	fbV0rBTHya9/XyguuxiG5TMEcyOAdaDEJrrg0ISIoGazB3jr6O1Cj+5awTF9a5o=
X-Gm-Gg: ASbGncuLQUe7T4f6t+gBLKLoSdUcJ4sUzxvlWaO0vAyXNkBPv8ehW8y9Ekd0vhe4CGy
	3Ii7+uF/mqFx7h5umJMD7D3reiu4bqj0NYzgmxW9KthTUQkYqDZXxWvfVOI0ve0WC276wtVNLhH
	K9P5/QNWaeLsdxU9ThJkL0YET7rT72hazYX+EKHuCQPM1sO+bj4SnxVJj7X7kx9XnGkO4DJMFrA
	yiGMlTtv6IgLDutX6kl8eGGWePSOR691pH3cQ5lVLXI4hEa24XYsceWj7ACyr1CDStK/FxcCNu7
	xkCpV/BEXmUHmiasAcdYGBBTXw1q2Q==
X-Google-Smtp-Source: AGHT+IEy+ZlYYSjCwQTYAtozEIj2xsPa9bStRoPqXdQNWUMFyZVp69PgubRYmOZ1R5A+TsxwMVgNJQ==
X-Received: by 2002:a17:90b:4d10:b0:2ff:78dd:2875 with SMTP id 98e67ed59e1d1-3086d45a927mr792822a91.5.1744846598511;
        Wed, 16 Apr 2025 16:36:38 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:b7fc:bdc8:4289:858f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308611d6166sm2269251a91.7.2025.04.16.16.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 16:36:38 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v3 bpf-next 3/6] bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch items
Date: Wed, 16 Apr 2025 16:36:18 -0700
Message-ID: <20250416233622.1212256-4-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416233622.1212256-1-jordan@jrife.io>
References: <20250416233622.1212256-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the next patch that tracks cookies between iterations by
converting struct sock **batch to union bpf_udp_iter_batch_item *batch
inside struct bpf_udp_iter_state.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/udp.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 4802d3fa37ed..bcbee5cbb504 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3385,13 +3385,17 @@ struct bpf_iter__udp {
 	int bucket __aligned(8);
 };
 
+union bpf_udp_iter_batch_item {
+	struct sock *sock;
+};
+
 struct bpf_udp_iter_state {
 	struct udp_iter_state state;
 	unsigned int cur_sk;
 	unsigned int end_sk;
 	unsigned int max_sk;
 	int offset;
-	struct sock **batch;
+	union bpf_udp_iter_batch_item *batch;
 	bool st_bucket_done;
 };
 
@@ -3455,7 +3459,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 				}
 				if (iter->end_sk < iter->max_sk) {
 					sock_hold(sk);
-					iter->batch[iter->end_sk++] = sk;
+					iter->batch[iter->end_sk++].sock = sk;
 				}
 				batch_sks++;
 			}
@@ -3479,7 +3483,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	if (!iter->end_sk)
 		goto done;
 
-	sk = iter->batch[0];
+	sk = iter->batch[0].sock;
 
 	if (iter->end_sk == batch_sks) {
 		/* Batching is done for the current bucket; return the first
@@ -3523,7 +3527,7 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	 * done with seq_show(), so unref the iter->cur_sk.
 	 */
 	if (iter->cur_sk < iter->end_sk) {
-		sock_put(iter->batch[iter->cur_sk++]);
+		sock_put(iter->batch[iter->cur_sk++].sock);
 		++iter->offset;
 	}
 
@@ -3531,7 +3535,7 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	 * available in the current bucket batch.
 	 */
 	if (iter->cur_sk < iter->end_sk)
-		sk = iter->batch[iter->cur_sk];
+		sk = iter->batch[iter->cur_sk].sock;
 	else
 		/* Prepare a new batch. */
 		sk = bpf_iter_udp_batch(seq);
@@ -3596,7 +3600,7 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
 static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
 {
 	while (iter->cur_sk < iter->end_sk)
-		sock_put(iter->batch[iter->cur_sk++]);
+		sock_put(iter->batch[iter->cur_sk++].sock);
 }
 
 static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
@@ -3859,7 +3863,7 @@ DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
 				      unsigned int new_batch_sz, int flags)
 {
-	struct sock **new_batch;
+	union bpf_udp_iter_batch_item *new_batch;
 
 	new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
 				   flags | __GFP_NOWARN);
-- 
2.43.0


