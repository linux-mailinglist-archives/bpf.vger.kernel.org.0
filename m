Return-Path: <bpf+bounces-62849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 944F6AFF522
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 01:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CB51C47841
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 23:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C74924679E;
	Wed,  9 Jul 2025 23:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="RXIIjt2Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404C8237A3B
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102222; cv=none; b=uysMrZfifsTbBa9wZ2ETSjvLf6U+yLb4n+3F/5FQjwuXNKoItLJijkhwa3Oig+RpzIxgRHk3pxMrjqaNUzLRS8IbZEIDu8CO1uM1y0WPTipaE/qc2NjUnho+7R71oPYn550jxxIVAzkM21QFYkcuUTZKyFaf27qc+uneB8ryLuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102222; c=relaxed/simple;
	bh=X2KBXE9XrAwenzh9ej9gHeOTHfpS4BCmkyXWHuVU1ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlAFSzmtPl/o1gB8phNqSVjB4+sFKX340im42Agj+WH3j66aBVp4Ye/Y/1qdYmiVFRbYIuCr4eT4fIOZk1IIsiO+BmJ/AkVpo1iZsvIwWWDj8zF7Sml9dD+BZHhUg/MiA4YkgziOkeP21qvHaoCwJ5acX0xRXT/6xMxkVtzqkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=RXIIjt2Q; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b26fabda6d9so87698a12.1
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 16:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752102220; x=1752707020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0VjMzRhhkpd/1HKsTytas5+E+ZQEpUjMSfUPoDJGy4=;
        b=RXIIjt2Q57HsrLf5CsGV9LpETjeyAwqGrFAFSaby6setyfvnoT8KDccY4Hq8g45J/O
         3TdTlCHr+zdjMmJDfquoQGRrzJPD54+jS8r4Ws9seFjuvvXdlm9VP71tdXXFMZkWa1hK
         nmeymeYLJsJLZbXySCk5S0xGpPvod5rnGr0EgEmelh3cj/eTuv1U8HAHLITj91UoAKm8
         M4GUeaLJLYOmCzLR2juWifvtlfLGDYf7l1udl6ku5RbwdVEVrSObSduqCPxwXvslftIY
         NflDPo/5MpM8+iQzEOrd2i9tnUsMs5lEvNSixOrK+GYcic3VbzY3UafMMpIVhSux9i0O
         cK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102220; x=1752707020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0VjMzRhhkpd/1HKsTytas5+E+ZQEpUjMSfUPoDJGy4=;
        b=dZXUy77NdE0XX9A60gzKufjWwTxCZ1k1OxF21t7ULfAkkQKfdYWNyGF5TC7WfRE7sf
         3uJdHVxOwrezinbhyJPEXiS4ZKytATrZldg7JvaPjnr88RLNnK9GKigml5hN4/6MH78Q
         RzI4psUCu8jr3Ym4yH2xoE+vzzyoq06e7nwfPtCHul4Bsw9yo5TSXpbRixMfrCxjynie
         7VLWsrKdAndy0hKc0dCRKz1L878bg7zideBAexB8Yyu+kNyAM1EOonI+GBqnTqxSdRQL
         IHVkKbg72A2pWBc7OEDudaK9I8wjFiNpd1pFAoEr1BAia0ppqTJ11wFjSiTc9sVCQMgm
         2+UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpTm5tzWEJXRVbzRW0B3V4uWfhg4ED90JC1g3PCMSEGEPaPM7creScfYTlJs1EKHR5ph8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcYBZUzqgEc/sM3JUW1rG9yy31eEe1XrCVDU8CiUE5xgfFUq+3
	KNqziyLHok/rZzRRRBRID+sOV5pOMNNrq4FLf3CP/1SQyoZc+jVxVLnN+Ybbt52SCR4=
X-Gm-Gg: ASbGnctfanGBa/AS64CaEIBUx84xkFO+aRMhKCdiEkkLvX6JzgkpCSEmKIOI6IO8OVB
	d4OIN85k5Z7A6Y/1N3oNVMJo00ui7LQVd4Ijws5J+wMfhU2VUapy/D1KjJjnoBNYE75wM2ub61K
	SXtTC8OGEbWEhnEWsv0G3Rq43L2KOvPZcALWh3Dgx+xejFhgEXxO6Hje5ZLYgAkaJYmStfUA6Y3
	eBVmkcF1x1Cjsyhg/daT0tH7bxqdg9A+RAn1REKt7U+NjLab4d17hY8V2ysc0JKGKBRwpqalJQt
	+LRf/GWtzxOSbJDT4wQIFS5qQNNgXL/9BMG6kWE8sKcvegGzpsY=
X-Google-Smtp-Source: AGHT+IF6iqLYPRveAXjLyiN6jpZXY4KU+qybcnprdwiK8tZ4fuM3DpSMrUU5p57vI0T1+ZR2c3I5qg==
X-Received: by 2002:a17:902:e845:b0:234:bfd3:50df with SMTP id d9443c01a7336-23ddb1b4618mr25244655ad.5.1752102220309;
        Wed, 09 Jul 2025 16:03:40 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad212sm2679015ad.80.2025.07.09.16.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 16:03:40 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 02/12] bpf: tcp: Make sure iter->batch always contains a full bucket snapshot
Date: Wed,  9 Jul 2025 16:03:22 -0700
Message-ID: <20250709230333.926222-3-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709230333.926222-1-jordan@jrife.io>
References: <20250709230333.926222-1-jordan@jrife.io>
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

Jun 27 00:00:53 crow kernel: again GFP_USER
Jun 27 00:00:53 crow kernel: again GFP_NOWAIT
Jun 27 00:00:53 crow kernel: again GFP_USER
Jun 27 00:00:53 crow kernel: again GFP_NOWAIT

With this setup, I also forced each of the bpf_iter_tcp_realloc_batch
calls to return -ENOMEM to ensure that iteration ends and that the
read() in userspace fails.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/ipv4/tcp_ipv4.c | 109 +++++++++++++++++++++++++++++++-------------
 1 file changed, 77 insertions(+), 32 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 2e40af6aff37..8dfb87be422e 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3057,7 +3057,7 @@ static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
 	if (!new_batch)
 		return -ENOMEM;
 
-	bpf_iter_tcp_put_batch(iter);
+	memcpy(new_batch, iter->batch, sizeof(*iter->batch) * iter->end_sk);
 	kvfree(iter->batch);
 	iter->batch = new_batch;
 	iter->max_sk = new_batch_sz;
@@ -3066,69 +3066,95 @@ static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
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
 
+static unsigned int bpf_iter_fill_batch(struct seq_file *seq,
+					struct sock **start_sk)
+{
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+
+	if (st->state == TCP_SEQ_STATE_LISTENING)
+		return bpf_iter_tcp_listening_batch(seq, start_sk);
+	else
+		return bpf_iter_tcp_established_batch(seq, start_sk);
+}
+
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
 	unsigned int expected;
-	bool resized = false;
 	struct sock *sk;
+	int err;
 
 	/* The st->bucket is done.  Directly advance to the next
 	 * bucket instead of having the tcp_seek_last_pos() to skip
@@ -3145,33 +3171,52 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 		}
 	}
 
-again:
-	/* Get a new batch */
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
-	iter->st_bucket_done = false;
+	iter->st_bucket_done = true;
 
 	sk = tcp_seek_last_pos(seq);
 	if (!sk)
 		return NULL; /* Done */
 
-	if (st->state == TCP_SEQ_STATE_LISTENING)
-		expected = bpf_iter_tcp_listening_batch(seq, sk);
-	else
-		expected = bpf_iter_tcp_established_batch(seq, sk);
+	expected = bpf_iter_fill_batch(seq, &sk);
+	if (likely(iter->end_sk == expected))
+		goto done;
 
-	if (iter->end_sk == expected) {
-		iter->st_bucket_done = true;
-		return sk;
-	}
+	/* Batch size was too small. */
+	bpf_iter_tcp_unlock_bucket(seq);
+	bpf_iter_tcp_put_batch(iter);
+	err = bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
+					 GFP_USER);
+	if (err)
+		return ERR_PTR(err);
+
+	iter->cur_sk = 0;
+	iter->end_sk = 0;
+
+	sk = tcp_seek_last_pos(seq);
+	if (!sk)
+		return NULL; /* Done */
+
+	expected = bpf_iter_fill_batch(seq, &sk);
+	if (likely(iter->end_sk == expected))
+		goto done;
 
-	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
-						    GFP_USER)) {
-		resized = true;
-		goto again;
+	/* Batch size was still too small. Hold onto the lock while we try
+	 * again with a larger batch to make sure the current bucket's size
+	 * does not change in the meantime.
+	 */
+	err = bpf_iter_tcp_realloc_batch(iter, expected, GFP_NOWAIT);
+	if (err) {
+		bpf_iter_tcp_unlock_bucket(seq);
+		return ERR_PTR(err);
 	}
 
-	return sk;
+	expected = bpf_iter_fill_batch(seq, &sk);
+	WARN_ON_ONCE(iter->end_sk != expected);
+done:
+	bpf_iter_tcp_unlock_bucket(seq);
+	return iter->batch[0];
 }
 
 static void *bpf_iter_tcp_seq_start(struct seq_file *seq, loff_t *pos)
-- 
2.43.0


