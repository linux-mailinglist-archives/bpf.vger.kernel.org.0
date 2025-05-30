Return-Path: <bpf+bounces-59381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38088AC9713
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 23:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1AE4A7983
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 21:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DAD283CAA;
	Fri, 30 May 2025 21:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="H1ekHiW/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AA5210184
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640694; cv=none; b=Fxj1P+8dvXO4TptITqDSrsVrxdFbkGc7hLsbFIk1u81DKC0AgrwsMRM3Twhf2zKWDSbmseZGYPGpf32Lp2XGg+c3roU1jtGPmUcrsbxAJ7Ue2BwX2WSr/1NS8wL0yUH6xW0+yFSttF6gG/B2vrYOgWL+8Yk+sDTjc1+5OB6IHqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640694; c=relaxed/simple;
	bh=J9WHRyvRODERSUE/XtH3ualLiF0NfpgkyfMoaf1Ef5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qvs1ljfYUyPvreKi7D+K4f/JLoDu7inCQ98F4Vw60Y5mghi5S/PSLofppdCIwhL0ileQDfNfJNPIb3whjkHERpD0x5tFD3lqu3ouw471gLfcoYYmRlfem4eFX7XSnO/oUKR7uH64N6kiiY1I4FavL/y69XeeRSLfJwBrX6XSNx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=H1ekHiW/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30eccc61f96so373301a91.2
        for <bpf@vger.kernel.org>; Fri, 30 May 2025 14:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748640693; x=1749245493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrPFMR4OHikyTVTJ8EtBy3d62qMwlWrkmeEZ+t0fDVs=;
        b=H1ekHiW/D6rmw+E5kMQMKtGPOTCLQUxK8DQHOViCRsB5q6kKEofVvm3+PTeNCW4gJt
         HFHCCSmEZ4sYmHgeckr1er6bw3vX876KavDNUe+Iy9GQP/opLvUX2ZO4MxsdUpddEJp9
         BQUhYwjCKNR0XOKIiaB9X/bMwjChxDOgQleEvuICCw5r3Ab93mVKFEYCWeAJTahAkzyr
         9U07Oprf+povqvtEp9znIKXAG1I0wWnGuu3py9FaYoIApg7PpxuikVpU2N23GnTqD9u4
         h2uyKzRZ3DVRvvIdLOH2boJPnoQYwsdaOm5rvrUl2fMc2o1EoWCdaMudedKMGP5+tX7i
         p73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748640693; x=1749245493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrPFMR4OHikyTVTJ8EtBy3d62qMwlWrkmeEZ+t0fDVs=;
        b=Im6FedRUFnDrIAx71GPYsHto5ujp0p+LzB5spSXyoT5mWYPw3PCOXNiM1frvDB1wq8
         WYLnaXletj+ClpnBVNkDTiH91kZ7PUJcycs1SdUzznomhhP7mWKrAYe5K0+gX0EMTjaX
         xNJ0V4ZvR3tmJW6gW2Tb1+J/TbgCBTMgwECoUpUGt5apE8vXNim+vJsdAEGA26p0/7af
         /ppNquFNeEnTkfHZ3HyJwnrn+49kNoJgymbI84lelCRIwaYIEA7jCgoeqS8PWUu+L/Zf
         wiQMAf4DIvCPJXCtk+pKZ2+2JL+AjqvpDx1cYZUMPYckGErHqqcw1rTeStXrR6cKMwyV
         vRUA==
X-Forwarded-Encrypted: i=1; AJvYcCWmnXTEEf72MPpvMAlXlZNjQE6skY+AQ4ffUUsSCHVBKJ0AOlU2hXvJ3aJWH5oO6cQlftg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBUk5OQl15R2heOURD8yHVODNxY14JB7H1jBtQWEGmHN89PooM
	Tz6bchTfGA2hzxp2wc2WDOLa+Qp5cSIxtnwp6xEj3jRtMVl8mXHvDaIe9EtY6h+o70k=
X-Gm-Gg: ASbGncvd+quhLJWULEuJiEAtaDn03Uj2GVHprrMw7YskU4Fmk1RjcNZytaaRr3MoRWt
	16xboOLNd7NMDFs1Am7HOal/AB7rBj3GOJVpsxOUdw7wXIKyRExUAJaLhAkXd9/o9L0QyQk0vcA
	rwzxEenLgRDja+Hm2N5sb8U/xJEZixpzVnWV9+RBKPrJ+e+MaKlNhLK/Kab6yFVq8xzrTsA7MTe
	dgYt71FY1B9hTPsZt1RCU4PfMV/zL7eLtLsFzl7GxzpwQNcKm5QacUbznVXmpqRPe/i0/7iUjUF
	L9hat0UjFwENtgHN8L6mCXq9tbEgfi30bZ352tdDRx1fjQNWhRM=
X-Google-Smtp-Source: AGHT+IFo8QSMR5x70ZxacAYiDsgqN5V0KAJHsYDI4igY7kQSKbZjsJ+CS8YlcTb1rMB3LWCWyCrbOg==
X-Received: by 2002:a05:6a00:1702:b0:736:355b:5df6 with SMTP id d2e1a72fcca58-747bda36189mr2383978b3a.6.1748640692712;
        Fri, 30 May 2025 14:31:32 -0700 (PDT)
Received: from t14.. ([2607:fb91:20c7:44b2:2a24:2057:271e:f269])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed4399sm3496763b3a.77.2025.05.30.14.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 14:31:32 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 bpf-next 04/12] bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch items
Date: Fri, 30 May 2025 14:30:46 -0700
Message-ID: <20250530213059.3156216-5-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530213059.3156216-1-jordan@jrife.io>
References: <20250530213059.3156216-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the next patch that tracks cookies between iterations by
converting struct sock **batch to union bpf_tcp_iter_batch_item *batch
inside struct bpf_tcp_iter_state.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_ipv4.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ac00015d5e7a..c51ac10fc351 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3014,12 +3014,16 @@ static int tcp4_seq_show(struct seq_file *seq, void *v)
 }
 
 #ifdef CONFIG_BPF_SYSCALL
+union bpf_tcp_iter_batch_item {
+	struct sock *sk;
+};
+
 struct bpf_tcp_iter_state {
 	struct tcp_iter_state state;
 	unsigned int cur_sk;
 	unsigned int end_sk;
 	unsigned int max_sk;
-	struct sock **batch;
+	union bpf_tcp_iter_batch_item *batch;
 };
 
 struct bpf_iter__tcp {
@@ -3045,13 +3049,13 @@ static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
 	unsigned int cur_sk = iter->cur_sk;
 
 	while (cur_sk < iter->end_sk)
-		sock_gen_put(iter->batch[cur_sk++]);
+		sock_gen_put(iter->batch[cur_sk++].sk);
 }
 
 static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
 				      unsigned int new_batch_sz, gfp_t flags)
 {
-	struct sock **new_batch;
+	union bpf_tcp_iter_batch_item *new_batch;
 
 	new_batch = kvmalloc(sizeof(*new_batch) * new_batch_sz,
 			     flags | __GFP_NOWARN);
@@ -3078,7 +3082,7 @@ static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
 	struct sock *sk;
 
 	sock_hold(*start_sk);
-	iter->batch[iter->end_sk++] = *start_sk;
+	iter->batch[iter->end_sk++].sk = *start_sk;
 
 	sk = sk_nulls_next(*start_sk);
 	*start_sk = NULL;
@@ -3086,7 +3090,7 @@ static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
-				iter->batch[iter->end_sk++] = sk;
+				iter->batch[iter->end_sk++].sk = sk;
 			} else if (!*start_sk) {
 				/* Remember where we left off. */
 				*start_sk = sk;
@@ -3107,7 +3111,7 @@ static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
 	struct sock *sk;
 
 	sock_hold(*start_sk);
-	iter->batch[iter->end_sk++] = *start_sk;
+	iter->batch[iter->end_sk++].sk = *start_sk;
 
 	sk = sk_nulls_next(*start_sk);
 	*start_sk = NULL;
@@ -3115,7 +3119,7 @@ static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
-				iter->batch[iter->end_sk++] = sk;
+				iter->batch[iter->end_sk++].sk = sk;
 			} else if (!*start_sk) {
 				/* Remember where we left off. */
 				*start_sk = sk;
@@ -3211,7 +3215,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	bpf_iter_tcp_unlock_bucket(seq);
 
 	WARN_ON_ONCE(iter->end_sk != expected);
-	return iter->batch[0];
+	return iter->batch[0].sk;
 }
 
 static void *bpf_iter_tcp_seq_start(struct seq_file *seq, loff_t *pos)
@@ -3246,11 +3250,11 @@ static void *bpf_iter_tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		 * st->bucket.  See tcp_seek_last_pos().
 		 */
 		st->offset++;
-		sock_gen_put(iter->batch[iter->cur_sk++]);
+		sock_gen_put(iter->batch[iter->cur_sk++].sk);
 	}
 
 	if (iter->cur_sk < iter->end_sk)
-		sk = iter->batch[iter->cur_sk];
+		sk = iter->batch[iter->cur_sk].sk;
 	else
 		sk = bpf_iter_tcp_batch(seq);
 
-- 
2.43.0


