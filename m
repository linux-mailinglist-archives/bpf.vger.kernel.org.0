Return-Path: <bpf+bounces-56076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD2DA90FAF
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 01:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC5F3BB3A0
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 23:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7B624BC17;
	Wed, 16 Apr 2025 23:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="DE5AYBdx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627502459F4
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 23:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744846599; cv=none; b=mtxOyl6j2w4fSkmrIUjK6KDSVuEpezwYas448eh+A8H4y1e9qh9LnXIElMBK3B7U8hRAAUyqg3Aw8oLsV23j8kQuoM7A8nc61SQPDr59lIqaka2qwwhjqHucjTC/WGdVBehM13p6cdHIS+bTe3UiD/CXzYFOyjERgtw8BNkoVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744846599; c=relaxed/simple;
	bh=T4u93ZK4i6nXowiYmrKs91AuEqAj01f9tIHi5qvZZRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJDwZgQIhvgR3680qhAQKQYBIGfMFBaFi2TQlGXn7ATEGeuqyl4cYb7+r+Qsz89tJ3Ywl1txctXk8LEO+fffhvYSVRmXbJFEbGDpYhx/1yb6/UPmUFcEIR2asm2YciSS9YlFTeQBnidlvBJiOzqNXa7n8dzslwENnCk3Zc2/9pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=DE5AYBdx; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7393eab4a75so29559b3a.2
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 16:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744846597; x=1745451397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CU78l3KYCqubxrwFxUXf4O9o6ESmLMh5YiQPMirX7Y=;
        b=DE5AYBdxsml7PSOEFHXR/k3NCrt8YYnZCoZ1P3yS4y7qC6kedxoJsmZXbQjeZW/QGq
         H3rqIYQIGu4inr0xESD2bbGp1ktBr15RrOVKthhDkmz3rJ5XwY5wJKgqBEtSSJJW6btF
         ii8fGhEFIGUo3bYq490is3kzRlAEBbfETkcYutKPunQdpHonkLpUIqk7kQhQile99OLA
         /eehbQnMllTYkOwWBXQTvTJJB2QTMHArDADBGxBS5I5QptOhZdk2aKlhU5lYklR02Jtr
         6JsIYBLxxfrJPhOb1nw9IVbGw6jSfET5IHewtHwoquqAkFziY9mD04ueMXa81X1teOX9
         X6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744846597; x=1745451397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CU78l3KYCqubxrwFxUXf4O9o6ESmLMh5YiQPMirX7Y=;
        b=VUKX6dr3vtD1G2pDZCgFw7lYFD51OnScPyY7U3PbfL2MAjNkIb9SItVbqw+m2JEu6k
         rrTuMv0uIwuF9kFPlD01cc4NN/3VVO2GUmJlTFiTXYY18LcPl4t+YPiLWpMz3Ay8/cFM
         DcQNqmwNZf87InZ0WEOWcqVGEuSru9V4co0g8Dsd5pTWHoEM6IS28yhR1FphukxKdm6R
         FHL3fywf5hapfp94Q7p5XGxUGXpgyORFfy9+rpRSL6oo/eRrgJny5HeFaUZi2pnibHjr
         mpPgP64ewvBColDp36ZUCMHLH1TVBg+KW+gjaszXlLk7VNXxkKpVtA7DvrH6icomdngq
         ehMw==
X-Forwarded-Encrypted: i=1; AJvYcCUxWmu6BOTS5P7An9mLRgFRh/ZlG2g5ra+AtYd2UCQ8QBDSqi7kBH4CBq3NkfUeNnRmQrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR9vWueDTf03my2AScWIEurxM/fA7WqQqCsOS6pf8sSjMG+Rt9
	p//wnTrKR9xsLANETAjVXhn2MsVcNOzusdyC6BHHDWGgxjMNYGKA8tKZICL+McTf1e4iy6x+87u
	qfxM=
X-Gm-Gg: ASbGncuGaYzrK6f4L1lJNVPeDb/zuLrrdGeB3/NHNNYSt/PAVj2rZtX/WCNZlODz/bD
	MtqZnIgZoSsPm3tfugTXqWVOp1f3EhV1Ko6Da1FEHF2KVVIzugwD48tyztTY8/dIQg2gcs6cIr2
	GHvWDFL2CpP8cDvfEMb+G2KKjaThQbJVAvcrWFtDftcMCL8blvDfKsQjLz/PDBiZtfM0a42ALcD
	OAuSXeu8dSjylzYoXyvnhBfLfQCdzDH9QtbSQaPk9lrTRuistGKk9WB0pLOI8PEqx1gxcBsdEKm
	weTVXA5F4Mz05+JEBvqm7NcbExQ/pg==
X-Google-Smtp-Source: AGHT+IFoTfKhWq7MvMwiRy0WQ4sULiT7A/Tqk3HaQunebL2abV0nZBjDhaQ98zdvgBb6fsIZpzdssw==
X-Received: by 2002:a17:90b:4b08:b0:305:5f20:b28c with SMTP id 98e67ed59e1d1-3086d444463mr966294a91.5.1744846597432;
        Wed, 16 Apr 2025 16:36:37 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:b7fc:bdc8:4289:858f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308611d6166sm2269251a91.7.2025.04.16.16.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 16:36:37 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v3 bpf-next 2/6] bpf: udp: Make sure iter->batch always contains a full bucket snapshot
Date: Wed, 16 Apr 2025 16:36:17 -0700
Message-ID: <20250416233622.1212256-3-jordan@jrife.io>
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

Require that iter->batch always contains a full bucket snapshot. This
invariant is important to avoid skipping or repeating sockets during
iteration when combined with the next few patches. Before, there were
two cases where a call to bpf_iter_udp_batch may only capture part of a
bucket:

1. When bpf_iter_udp_realloc_batch() returns -ENOMEM [1].
2. When more sockets are added to the bucket while calling
   bpf_iter_udp_realloc_batch(), making the updated batch size
   insufficient [2].

In cases where the batch size only covers part of a bucket, it is
possible to forget which sockets were already visited, especially if we
have to process a bucket in more than two batches. This forces us to
choose between repeating or skipping sockets, so don't allow this:

1. Stop iteration and propagate -ENOMEM up to userspace if reallocation
   fails instead of continuing with a partial batch.
2. Retry bpf_iter_udp_realloc_batch() up to two times if we fail to
   capture the full bucket. On the third attempt, hold onto the bucket
   lock (hslot2->lock) through bpf_iter_udp_realloc_batch() with
   GFP_ATOMIC to guarantee that the bucket size doesn't change before
   our next attempt. Try with GFP_USER first to improve the chances
   that memory allocation succeeds; only use GFP_ATOMIC as a last
   resort.

Testing all scenarios directly is a bit difficult, but I did some manual
testing to exercise the code paths where GFP_ATOMIC is used and where
where ERR_PTR(err) is returned to make sure there are no deadlocks. I
used the realloc test case included later in this series to trigger a
scenario where a realloc happens inside bpf_iter_udp_realloc_batch and
made a small code tweak to force the first two realloc attempts to
allocate a too-small buffer, thus requiring another attempt until the
GFP_ATOMIC case is hit. Some printks showed three reallocs with the
tests passing:

Apr 16 00:08:32 crow kernel: go again (mem_flags=GFP_USER)
Apr 16 00:08:32 crow kernel: go again (mem_flags=GFP_USER)
Apr 16 00:08:32 crow kernel: go again (mem_flags=GFP_ATOMIC)

With this setup, I also forced bpf_iter_udp_realloc_batch to return
-ENOMEM on one of the retries to ensure that iteration ends and that the
read() in userspace fails, forced the hlist_empty condition to be true
on the GFP_ATOMIC pass to test the first WARN_ON_ONCE condition code
path, and walked back iter->end_sk on the GFP_ATOMIC pass to test the
second WARN_ON_ONCE condition code path. In each case, locks were
released and the loop terminated.

[1]: https://lore.kernel.org/bpf/CABi4-ogUtMrH8-NVB6W8Xg_F_KDLq=yy-yu-tKr2udXE2Mu1Lg@mail.gmail.com/
[2]: https://lore.kernel.org/bpf/7ed28273-a716-4638-912d-f86f965e54bb@linux.dev/

Signed-off-by: Jordan Rife <jordan@jrife.io>
Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
---
 net/ipv4/udp.c | 57 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0ac31dec339a..4802d3fa37ed 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3377,6 +3377,7 @@ int udp4_seq_show(struct seq_file *seq, void *v)
 }
 
 #ifdef CONFIG_BPF_SYSCALL
+#define MAX_REALLOC_ATTEMPTS 3
 struct bpf_iter__udp {
 	__bpf_md_ptr(struct bpf_iter_meta *, meta);
 	__bpf_md_ptr(struct udp_sock *, udp_sk);
@@ -3401,11 +3402,13 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	struct bpf_udp_iter_state *iter = seq->private;
 	struct udp_iter_state *state = &iter->state;
 	struct net *net = seq_file_net(seq);
+	int resizes = MAX_REALLOC_ATTEMPTS;
 	int resume_bucket, resume_offset;
 	struct udp_table *udptable;
 	unsigned int batch_sks = 0;
-	bool resized = false;
+	spinlock_t *lock = NULL;
 	struct sock *sk;
+	int err = 0;
 
 	resume_bucket = state->bucket;
 	resume_offset = iter->offset;
@@ -3433,10 +3436,13 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket].hslot;
 
 		if (hlist_empty(&hslot2->head))
-			continue;
+			goto next_bucket;
 
 		iter->offset = 0;
-		spin_lock_bh(&hslot2->lock);
+		if (!lock) {
+			lock = &hslot2->lock;
+			spin_lock_bh(lock);
+		}
 		udp_portaddr_for_each_entry(sk, &hslot2->head) {
 			if (seq_sk_match(seq, sk)) {
 				/* Resume from the last iterated socket at the
@@ -3454,15 +3460,26 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 				batch_sks++;
 			}
 		}
-		spin_unlock_bh(&hslot2->lock);
 
 		if (iter->end_sk)
 			break;
+next_bucket:
+		/* Somehow the bucket was emptied or all matching sockets were
+		 * removed while we held onto its lock. This should not happen.
+		 */
+		if (WARN_ON_ONCE(!resizes))
+			/* Best effort; reset the resize budget and move on. */
+			resizes = MAX_REALLOC_ATTEMPTS;
+		if (lock)
+			spin_unlock_bh(lock);
+		lock = NULL;
 	}
 
 	/* All done: no batch made. */
 	if (!iter->end_sk)
-		return NULL;
+		goto done;
+
+	sk = iter->batch[0];
 
 	if (iter->end_sk == batch_sks) {
 		/* Batching is done for the current bucket; return the first
@@ -3471,16 +3488,30 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		iter->st_bucket_done = true;
 		goto done;
 	}
-	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2,
-						    GFP_USER)) {
-		resized = true;
-		/* After allocating a larger batch, retry one more time to grab
-		 * the whole bucket.
-		 */
-		goto again;
+
+	/* Somehow the batch size still wasn't big enough even though we held
+	 * a lock on the bucket. This should not happen.
+	 */
+	if (WARN_ON_ONCE(!resizes))
+		goto done;
+
+	resizes--;
+	if (resizes) {
+		spin_unlock_bh(lock);
+		lock = NULL;
+	}
+	err = bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2,
+					 resizes ? GFP_USER : GFP_ATOMIC);
+	if (err) {
+		sk = ERR_PTR(err);
+		goto done;
 	}
+
+	goto again;
 done:
-	return iter->batch[0];
+	if (lock)
+		spin_unlock_bh(lock);
+	return sk;
 }
 
 static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
-- 
2.43.0


