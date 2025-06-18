Return-Path: <bpf+bounces-60964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AA1ADF294
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CBB1BC3233
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163632F1995;
	Wed, 18 Jun 2025 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="W/pDwm6Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043D12F0022
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263953; cv=none; b=goEPjCGmays/Shq0yKu5qn5kki+gK1hTfFE4zpWScgyYWIKkRb8QMXK5360EOIWaehL5yriy0jzsH1MVHfHBe/ZeUNJ0vx/1w4mF1TRUxMFPlyfgQO0B1uC8o8h4SxqMgd49urPK+B7z8fRIBOBnFOvkCI50k3rdm6DB5Pf4yGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263953; c=relaxed/simple;
	bh=GwBxoJ6qLK9haRwaaLOPQUwJCZTreCiI3hry7JjvtJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdbaFQcoI0JEoVC0gBSn87rgMHk3z5J//M6nn2PJLYrkmjRD2OIFA+jvxui3hqc7ElvIyVVwyR1KyOXOJMOBDPJtTMB+5VCI3A6EZ3Df4yaH3MyEmobs4da4xAS79e7+08aq3dIgofpCtJRKy4moDziCL3Z9ELosPCP+1x2ItcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=W/pDwm6Z; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313fab41fd5so907699a91.1
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1750263951; x=1750868751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7N+H1ABM0/1l0EoaOVNZ+9Ez2EiRvzUde47kyk7MSA=;
        b=W/pDwm6ZZ1fZjVBR/ulvCf7tEU57nhKN3hXcFmzqExgbdqYd1sd/Tm+Lm4dxaN0ZWt
         o7rAev5rXWZgPMeoaRk0LeBXxjiTidYdL/LP7CFax7vhaDJ15ynDeZTZLGVQAZb1zqU7
         GhHr7xuCAEZpeFe2bKEQLCuIF1iQSlWFBw98FXsPg8bTw2LN0DxYIifoxvJ8cs4yHUQG
         MgDcjSuPEoJePTwFUuQORjEmiuq3tqNghpsZvgm4WoyB4h12ZdddJ+rsJKx+pv8Zhiri
         Am7kRuHaVc0UaLnoxfJumqbrJXvV6/9rHv0cMcb3orpfiNDqwDrKKB+5NWnn7RUi7Kc1
         wGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263951; x=1750868751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7N+H1ABM0/1l0EoaOVNZ+9Ez2EiRvzUde47kyk7MSA=;
        b=vS1Kq/EGsxDhtKKs5IZNgUJsYgbX8RH/1mW/Maijqw7oC1oeRw8dpSi7BxdKQ219Yh
         TmSB+fLFuzV8YrqxTGE+jU508LyxBdIUXeNHFYhzXKpsC2MJp6VFqKOIU21rXu9+Cr+W
         selAeWw2N/LvwXSdT7zazhp0ios5PFnyytl2mFlhTjzXG1mrUUKVm0PZjaXGS6qEXQI0
         BNsM4WYQDjaTIOe5+6zNlsui3PjmcWBaU9jY1/fI6njj/FRgu7iKLl9GFrHIuWDFl8eQ
         TVhQI3RB1IEvPrFhhpWEUb6c34bn8Nm2C6/7cJov3bd58giuCz2/P+J5MaorOsNxGsu+
         xWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5iKYNLT2kKpGS1OzbU//CxXSjjWROgGcWKSQuXW5oHvcCMrAUM7Qe8LU5K/eQE85RImM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+xeTVISIUSp5aG6ff79ezYiPShNW+jbClyGfVYcvJx7NZ12dN
	lyQrCygZmKEjFMPptYZ4vobytAYxJP4zSNDNH305hFaTSGbkT1OicdCwUdcb/p8LwTU=
X-Gm-Gg: ASbGncu4ps3j3l3N5plG8aYQ8UtzOG5Zftu1HYqYnO587yIsbQWXpfrndfBzwEvLh+K
	Deaz1FRdkMeWRi2nLOLuUBWjiVQM0VU5/2LeINm8AsVgapmkpIpjsvH2jHcmAGihyQJT2/PmSLJ
	MLAaYn8u7sYzgj+ETcr83jBuR9SGBoEr1TpETYIy5kkkMOMNwHJHgwyQxBd+qwVVuNVp2v1O8PR
	Tm6A1JZlQeOzfwWWEla16cxBOamyfb2e0YGDW0JxSoP3kPYwDFqIW7/x5ZXJkCwz3kSp7EY/IKc
	x4/qFtN3mcBVmKT4d0vmPKlgGaQiBX3IIOrBKGE7EdUky3PA+WI=
X-Google-Smtp-Source: AGHT+IF1hmkE5IktAECpEbGQLUouOW/1C05yoPNppgqHxSMNctJVhs8Zf8CFIXCfM1Di++xkAqfyDg==
X-Received: by 2002:a17:90b:17c6:b0:313:2f9a:13c0 with SMTP id 98e67ed59e1d1-313f1befa77mr10035977a91.1.1750263951189;
        Wed, 18 Jun 2025 09:25:51 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d683:8e90:dec5:4c47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2768c6sm137475a91.44.2025.06.18.09.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:25:50 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RESEND PATCH v2 bpf-next 02/12] bpf: tcp: Make sure iter->batch always contains a full bucket snapshot
Date: Wed, 18 Jun 2025 09:25:33 -0700
Message-ID: <20250618162545.15633-3-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618162545.15633-1-jordan@jrife.io>
References: <20250618162545.15633-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Require that iter->batch always contains a full bucket snapshot. This
invariant is important to avoid skipping or repeating sockets during
iteration when combined with the next few patches. Before, there were
two cases where a call to bpf_iter_tcp_batch may only capture part of a
bucket:

1. When bpf_iter_tcp_realloc_batch() returns -ENOMEM.
2. When more sockets are added to the bucket while calling
   bpf_iter_tcp_realloc_batch(), making the updated batch size
   insufficient.

In cases where the batch size only covers part of a bucket, it is
possible to forget which sockets were already visited, especially if we
have to process a bucket in more than two batches. This forces us to
choose between repeating or skipping sockets, so don't allow this:

1. Stop iteration and propagate -ENOMEM up to userspace if reallocation
   fails instead of continuing with a partial batch.
2. Try bpf_iter_tcp_realloc_batch() with GFP_USER just as before, but if
   we still aren't able to capture the full bucket, call
   bpf_iter_tcp_realloc_batch() again while holding the bucket lock to
   guarantee the bucket does not change. On the second attempt use
   GFP_NOWAIT since we hold onto the spin lock.

I did some manual testing to exercise the code paths where GFP_NOWAIT is
used and where ERR_PTR(err) is returned. I used the realloc test cases
included later in this series to trigger a scenario where a realloc
happens inside bpf_iter_tcp_batch and made a small code tweak to force
the first realloc attempt to allocate a too-small batch, thus requiring
another attempt with GFP_NOWAIT. Some printks showed both reallocs with
the tests passing:

May 09 18:18:55 crow kernel: resize batch TCP_SEQ_STATE_LISTENING
May 09 18:18:55 crow kernel: again GFP_USER
May 09 18:18:55 crow kernel: resize batch TCP_SEQ_STATE_LISTENING
May 09 18:18:55 crow kernel: again GFP_NOWAIT
May 09 18:18:57 crow kernel: resize batch TCP_SEQ_STATE_ESTABLISHED
May 09 18:18:57 crow kernel: again GFP_USER
May 09 18:18:57 crow kernel: resize batch TCP_SEQ_STATE_ESTABLISHED
May 09 18:18:57 crow kernel: again GFP_NOWAIT

With this setup, I also forced each of the bpf_iter_tcp_realloc_batch
calls to return -ENOMEM to ensure that iteration ends and that the
read() in userspace fails.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_ipv4.c | 96 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 68 insertions(+), 28 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 2e40af6aff37..69c976a07434 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3057,7 +3057,10 @@ static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
 	if (!new_batch)
 		return -ENOMEM;
 
-	bpf_iter_tcp_put_batch(iter);
+	if (flags != GFP_NOWAIT)
+		bpf_iter_tcp_put_batch(iter);
+
+	memcpy(new_batch, iter->batch, sizeof(*iter->batch) * iter->end_sk);
 	kvfree(iter->batch);
 	iter->batch = new_batch;
 	iter->max_sk = new_batch_sz;
@@ -3066,69 +3069,85 @@ static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
 }
 
 static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
-						 struct sock *start_sk)
+						 struct sock **start_sk)
 {
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
 	struct bpf_tcp_iter_state *iter = seq->private;
-	struct tcp_iter_state *st = &iter->state;
 	struct hlist_nulls_node *node;
 	unsigned int expected = 1;
 	struct sock *sk;
 
-	sock_hold(start_sk);
-	iter->batch[iter->end_sk++] = start_sk;
+	sock_hold(*start_sk);
+	iter->batch[iter->end_sk++] = *start_sk;
 
-	sk = sk_nulls_next(start_sk);
+	sk = sk_nulls_next(*start_sk);
+	*start_sk = NULL;
 	sk_nulls_for_each_from(sk, node) {
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
 				iter->batch[iter->end_sk++] = sk;
+			} else if (!*start_sk) {
+				/* Remember where we left off. */
+				*start_sk = sk;
 			}
 			expected++;
 		}
 	}
-	spin_unlock(&hinfo->lhash2[st->bucket].lock);
 
 	return expected;
 }
 
 static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
-						   struct sock *start_sk)
+						   struct sock **start_sk)
 {
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
 	struct bpf_tcp_iter_state *iter = seq->private;
-	struct tcp_iter_state *st = &iter->state;
 	struct hlist_nulls_node *node;
 	unsigned int expected = 1;
 	struct sock *sk;
 
-	sock_hold(start_sk);
-	iter->batch[iter->end_sk++] = start_sk;
+	sock_hold(*start_sk);
+	iter->batch[iter->end_sk++] = *start_sk;
 
-	sk = sk_nulls_next(start_sk);
+	sk = sk_nulls_next(*start_sk);
+	*start_sk = NULL;
 	sk_nulls_for_each_from(sk, node) {
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
 				iter->batch[iter->end_sk++] = sk;
+			} else if (!*start_sk) {
+				/* Remember where we left off. */
+				*start_sk = sk;
 			}
 			expected++;
 		}
 	}
-	spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
 
 	return expected;
 }
 
+static void bpf_iter_tcp_unlock_bucket(struct seq_file *seq)
+{
+	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+
+	if (st->state == TCP_SEQ_STATE_LISTENING)
+		spin_unlock(&hinfo->lhash2[st->bucket].lock);
+	else
+		spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
+}
+
 static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 {
 	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
 	struct bpf_tcp_iter_state *iter = seq->private;
 	struct tcp_iter_state *st = &iter->state;
+	int prev_bucket, prev_state;
 	unsigned int expected;
-	bool resized = false;
+	int resizes = 0;
 	struct sock *sk;
+	int err;
 
 	/* The st->bucket is done.  Directly advance to the next
 	 * bucket instead of having the tcp_seek_last_pos() to skip
@@ -3149,29 +3168,50 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	/* Get a new batch */
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
-	iter->st_bucket_done = false;
+	iter->st_bucket_done = true;
 
+	prev_bucket = st->bucket;
+	prev_state = st->state;
 	sk = tcp_seek_last_pos(seq);
 	if (!sk)
 		return NULL; /* Done */
+	if (st->bucket != prev_bucket || st->state != prev_state)
+		resizes = 0;
+	expected = 0;
 
+fill_batch:
 	if (st->state == TCP_SEQ_STATE_LISTENING)
-		expected = bpf_iter_tcp_listening_batch(seq, sk);
+		expected += bpf_iter_tcp_listening_batch(seq, &sk);
 	else
-		expected = bpf_iter_tcp_established_batch(seq, sk);
+		expected += bpf_iter_tcp_established_batch(seq, &sk);
 
-	if (iter->end_sk == expected) {
-		iter->st_bucket_done = true;
-		return sk;
-	}
+	if (unlikely(resizes <= 1 && iter->end_sk != expected)) {
+		resizes++;
+
+		if (resizes == 1) {
+			bpf_iter_tcp_unlock_bucket(seq);
 
-	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
-						    GFP_USER)) {
-		resized = true;
-		goto again;
+			err = bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
+							 GFP_USER);
+			if (err)
+				return ERR_PTR(err);
+			goto again;
+		}
+
+		err = bpf_iter_tcp_realloc_batch(iter, expected, GFP_NOWAIT);
+		if (err) {
+			bpf_iter_tcp_unlock_bucket(seq);
+			return ERR_PTR(err);
+		}
+
+		expected = iter->end_sk;
+		goto fill_batch;
 	}
 
-	return sk;
+	bpf_iter_tcp_unlock_bucket(seq);
+
+	WARN_ON_ONCE(iter->end_sk != expected);
+	return iter->batch[0];
 }
 
 static void *bpf_iter_tcp_seq_start(struct seq_file *seq, loff_t *pos)
-- 
2.43.0


