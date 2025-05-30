Return-Path: <bpf+bounces-59379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAE6AC970E
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 23:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1EA24A7544
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 21:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11675283FCA;
	Fri, 30 May 2025 21:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Oe2uws8x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC7021322F
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 21:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640685; cv=none; b=OQQ+ddzthnbZbExhWw5LPnZczrveeNxuk9B8etfkGtqLdmo0aguRD1dEL1/rVeS/QrmYOzH906GyyQF4OAx7qYPPw5sf/5pm5XOyfVLMvnF0uVTneyF1Tfbi2Ui0bwp+fExs9HwaY1JL7gfFLp14GCXIUdzfKQt6j6EpwysyrP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640685; c=relaxed/simple;
	bh=GwBxoJ6qLK9haRwaaLOPQUwJCZTreCiI3hry7JjvtJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqxWEjuIuMhaLmdc6/t6Bnh6lJmAkZXFOMPZio7Wph4wBAZJ96BkII7K83xOlB5sLL/f+hVHt4Cpb/aBfg5bErXOo/O8TP5T89ZhhYxUHMkVVE+LU4gl43odRhDWCSdk5vjrlD2l/WemBhYDQAs+FwjbECIT2NcBwVFA3njKMQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Oe2uws8x; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742a018da9cso424771b3a.1
        for <bpf@vger.kernel.org>; Fri, 30 May 2025 14:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748640682; x=1749245482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7N+H1ABM0/1l0EoaOVNZ+9Ez2EiRvzUde47kyk7MSA=;
        b=Oe2uws8xkdZ2S5XJJdoZgPjRBh/b5UTkhyS2hau0jn/VYwONGhHJS9QlbfXWyULzTJ
         LOSXZj5JFZwdPsSm0F61RAcdXO9q3aEhkUat9EOUWt2CDl6u2kUrNeJo5kxAEVwKKnxN
         tmkFJyRL3qS8jz0wLdXXJIeNSBAotM8wosIeeTah/Zs1AIGHdKuUBIHyK1vRitCOrzZA
         cQqHoVgFeSs+APKihpa9vfRoorglbmJ5nnaczrqsWMyDq/TE13meePrajrJNMOJRFQHI
         JWVhMhHvv9WknulHrFGnBU1pT/0wrPGtrPHkPZfmHP0LRr8hNeQKXIGLtSS0JViy5cy1
         1LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748640682; x=1749245482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7N+H1ABM0/1l0EoaOVNZ+9Ez2EiRvzUde47kyk7MSA=;
        b=wsUIZkooKo1VXHoC+6acQ5eZSxuvS2jBbr9tJOhoKp7E9GpFsq+OOEFSsJK2PAVDX1
         Cyra0sxqy5RdP30HlcgjwxdKeojfUzyBaB1CvTMmDZ7+Qco/5d7IRL6kaRCIkVcaVeLa
         s6a9sKtfDXFlpP0DA7pV88Jc0bdR0c0SaZF6KKl0owwlsWkt1IdaO2qKWbPr5gCt44j+
         RMqyO7mTKWAA62QnSfpXIMr08/Au824RQJQpO3df/PRjchkctLEde1/cKe9D3kkrMmBD
         WvnFnPXQjMhMDQ9jl0gJiPj17YDFg4vciswvFP/FUqyqSnRCqpkj9mKLX+GmhkEWIw2c
         hUJg==
X-Forwarded-Encrypted: i=1; AJvYcCWb/4HWXScujL1dLuqUrMeWjkd6qoYVpEctexiK6RGimr+CPg7YdxrGgZXqlgQ/r9xc5vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRALnrjv6XtDuQ6t15x23UCgUTrMMRWIGfws82xHhF0RRoY7gV
	bv3kq7fBEXrRfEPgLPE42NR84eDlkvEhdHMg3krzOkNpdUVHOJ/cdKmXOp0lqZWETSFK7eoaNC3
	R6kd2bjI=
X-Gm-Gg: ASbGnctMbTQlZkeZXPOzR5nXV1ckzxsWKhSL40AzXOiHyAWlfT5xgXXFDkZ7x8B1JPO
	fiNgTKm4+BxuEAroTNc+kVSwt6nTNPftEX/fPwpQhQGx59Mf/gIEpice5Zkp8MaBdeqCAqR4hAc
	JgArUz5A/61PHOhhYHlBzfdseXyKWmJgHVKe3CLvChlGljPGaTtXB8unKrKl6A6tWIT6muuKr8R
	+6YtYwIi2VFR8dM1EhO7iu3dIFMQXO6yPNZHXBgceG2jNGW10s0GExWGUsRz91svwqYc7t2xrJS
	1YlHkrG/zFz9LVQjBTot2JUeonavfGjVeakXUOL/to8iRn3Kakw=
X-Google-Smtp-Source: AGHT+IGuSRVtBy4t7izCy2no4e/WJr4zf1BhI+zXGNP8OEPxr+FF/+UPu4oXA6ZtADpNl6kVjUJQjw==
X-Received: by 2002:a05:6a00:a17:b0:725:f462:2ebb with SMTP id d2e1a72fcca58-747c0adbf9emr2322863b3a.0.1748640682507;
        Fri, 30 May 2025 14:31:22 -0700 (PDT)
Received: from t14.. ([2607:fb91:20c7:44b2:2a24:2057:271e:f269])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed4399sm3496763b3a.77.2025.05.30.14.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 14:31:22 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 bpf-next 02/12] bpf: tcp: Make sure iter->batch always contains a full bucket snapshot
Date: Fri, 30 May 2025 14:30:44 -0700
Message-ID: <20250530213059.3156216-3-jordan@jrife.io>
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


