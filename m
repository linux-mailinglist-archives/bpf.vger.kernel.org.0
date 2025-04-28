Return-Path: <bpf+bounces-56855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4375EA9F7DE
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 20:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980C4179328
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 18:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133D82951C3;
	Mon, 28 Apr 2025 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="As1awrik"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1335D2951C9
	for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863251; cv=none; b=oB2fe00lj5B1wXtZ7LGbbzO/xYthKijkYouI7pYJAhcRJQNwt8a4BdVDS0lTzMpeEUjlBvKSrnOHBEHUL/DFooy+SkldJosxp/+kVG7ca2UCXiyxuTwAHPDIoPXF+QSZYuJWtw+KeK4TFtDTtZ7PnYFk13CQ3EhRSZDGpKXRIT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863251; c=relaxed/simple;
	bh=DcC6hQQfWgUS1HtSq/cjmGeFPVEuBMkeJQ6frrBLXvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzgubzklmRvR2rIdJaSbwE6vurJA40qcu8IyYUzSZ/4cBtroFIOaAH6bmXHgaMl1JwFXzbhqGPrSP6nu/7s+/kSEQiA3kSaEfMmyAOfPJnH2zGOdTHTsqdUw7oncHoSaCW+Kwc7pvwY6JxuhaIEl4kd3xN52F0j6TyUcYz6uI38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=As1awrik; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2240b4de10eso10780225ad.1
        for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 11:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745863249; x=1746468049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WWeiZJRKKYF5HkQ3913zsmGfWMP8nPsTkurWoap798=;
        b=As1awrikEQjnvwopIsyicnC0bJMToXug1CXs30luiq1E5SogV+S+bsCt4tb1WjbM1z
         PNc53o/Iwlzd61S55V2IEnv6yUkjrsFwHTvd3xES9CqBv9fzcJMsd+4hQbUeR15XUpM+
         s+6/ZM6P7uS6luHt23vbfXQoaB4sLhk+8vKBt/GAVsw9I94485Ecj5olDXSnxNlYWb8/
         JiB0KpsoVHg6xcegq1olQz9e2ct7Enourx0VronWL+3GDCCAZs9g7I7RUJ3zK1DiH4BT
         iv2usyPd87CKZSqkJ1+9GNK8/zhXEfAIt3E8GLiUh1oh9d1QeYF8uwBGsh4tFUqXDS9k
         E0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745863249; x=1746468049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WWeiZJRKKYF5HkQ3913zsmGfWMP8nPsTkurWoap798=;
        b=TUpMAehOjudtAKclZmkS648aCgpyfb7uWN+TF2hK2cls3rfm0EhgW2+Kil6MhZO2LN
         iwKSIsSnIcfJoHdrTaG4jOoBH/E1ApyDmfyVVpnLv+4VAA+5oAVb8xs6RktezfRb/MZm
         8tqG/3KtY1yZFtz4k1SJtUby4yjEEkMuKOgO9G48X67FIQp6/cGQB2hM3n7J2s4U0oRp
         kPwKOarH+zLX8DedNqKofsBFdfr03aRkBLt8kPVV5BNIYhKto5FSBMsTr5pTVZW2u/vx
         BkHDEnB4NlaY0Ox6P/1vCuUV6diNLYpzONAhWrbWt+l/OA5o3YlktRWtxLrw9aj4CVLw
         TfjA==
X-Forwarded-Encrypted: i=1; AJvYcCWYEAQ1QZPjL8RyANNJU6SfCTybFYQ61XMCws5jt4DqLk1PkSMoC9zjyR/WRT4fVnsfcYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYhOHE06e6bVU8pSFNAPr2ugEzGORn08Z2+eNMj0Ms8gNkMQLl
	4QVxZlDc16s/OTwpv1ZIjaf3sTTlomNQLr8SEbBNIHbNO83G5PfHKCihCgPm//E=
X-Gm-Gg: ASbGncs2Bjb6uokZ94OnnQwEo5wqYWOSVEkBJI5+lj07zgndY8/CPU0yVowS31OWbUR
	6IJa8UXbse3pr/uUA2c47UUunsEkfmzQ3Wop0lS7CBAyvp+GnRC/tLcW8TMoBXL6FfwaI5n6W9W
	USXWhypzt4w2RC2H+v/T7n8QtOPyPjyw4tuoRe7JKRAaHc/k09rx2IDMo8LBKcXAnRvOdosC1k6
	Zg3WdIUbiMrpMGwyynVZgqc365IjyY23IKSBGIMcVlK5Bdu2oUGRgzxAvtfvQjGFFC72H7mfpuC
	HZp+dRiCBLlRkvUAkvaK+gYX0en6qoDiGFCk
X-Google-Smtp-Source: AGHT+IEnUMoxWudgXew32hi7NRq0c5njnCA7xkmVPczH350Z4pxCHr5+gAdUBvTpfcEWBvb7v/3/6A==
X-Received: by 2002:a17:902:c952:b0:224:1212:7da1 with SMTP id d9443c01a7336-22de6f2164amr153635ad.13.1745863249227;
        Mon, 28 Apr 2025 11:00:49 -0700 (PDT)
Received: from t14.. ([104.133.9.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52214ebsm86204235ad.246.2025.04.28.11.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 11:00:48 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v6 bpf-next 2/7] bpf: udp: Make sure iter->batch always contains a full bucket snapshot
Date: Mon, 28 Apr 2025 11:00:26 -0700
Message-ID: <20250428180036.369192-3-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428180036.369192-1-jordan@jrife.io>
References: <20250428180036.369192-1-jordan@jrife.io>
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
2. Try bpf_iter_udp_realloc_batch() with GFP_USER just as before, but if
   we still aren't able to capture the full bucket, call
   bpf_iter_udp_realloc_batch() again while holding the bucket lock to
   guarantee the bucket does not change. On the second attempt use
   GFP_NOWAIT since we hold onto the spin lock.

Introduce the udp_portaddr_for_each_entry_from macro and use it instead
of udp_portaddr_for_each_entry to make it possible to continue iteration
from an arbitrary socket. This is required for this patch in the
GFP_NOWAIT case to allow us to fill the rest of a batch starting from
the middle of a bucket and the later patch which skips sockets that were
already seen.

Testing all scenarios directly is a bit difficult, but I did some manual
testing to exercise the code paths where GFP_NOWAIT is used and where
ERR_PTR(err) is returned. I used the realloc test case included later
in this series to trigger a scenario where a realloc happens inside
bpf_iter_udp_batch and made a small code tweak to force the first
realloc attempt to allocate a too-small batch, thus requiring
another attempt with GFP_NOWAIT. Some printks showed both reallocs with
the tests passing:

Apr 25 23:16:24 crow kernel: go again GFP_USER
Apr 25 23:16:24 crow kernel: go again GFP_NOWAIT

With this setup, I also forced each of the bpf_iter_udp_realloc_batch
calls to return -ENOMEM to ensure that iteration ends and that the
read() in userspace fails.

[1]: https://lore.kernel.org/bpf/CABi4-ogUtMrH8-NVB6W8Xg_F_KDLq=yy-yu-tKr2udXE2Mu1Lg@mail.gmail.com/
[2]: https://lore.kernel.org/bpf/7ed28273-a716-4638-912d-f86f965e54bb@linux.dev/

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 include/linux/udp.h |  3 ++
 net/ipv4/udp.c      | 81 ++++++++++++++++++++++++++++++---------------
 2 files changed, 58 insertions(+), 26 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 0807e21cfec9..a69da9c4c1c5 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -209,6 +209,9 @@ static inline void udp_allow_gso(struct sock *sk)
 #define udp_portaddr_for_each_entry(__sk, list) \
 	hlist_for_each_entry(__sk, list, __sk_common.skc_portaddr_node)
 
+#define udp_portaddr_for_each_entry_from(__sk) \
+	hlist_for_each_entry_from(__sk, __sk_common.skc_portaddr_node)
+
 #define udp_portaddr_for_each_entry_rcu(__sk, list) \
 	hlist_for_each_entry_rcu(__sk, list, __sk_common.skc_portaddr_node)
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 6a3c351aa06e..5fe22f4f43d7 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3410,8 +3410,9 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	int resume_bucket, resume_offset;
 	struct udp_table *udptable;
 	unsigned int batch_sks = 0;
-	bool resized = false;
+	int resizes = 0;
 	struct sock *sk;
+	int err = 0;
 
 	resume_bucket = state->bucket;
 	resume_offset = iter->offset;
@@ -3432,18 +3433,21 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	 */
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
-	iter->st_bucket_done = false;
+	iter->st_bucket_done = true;
 	batch_sks = 0;
 
 	for (; state->bucket <= udptable->mask; state->bucket++) {
 		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket].hslot;
 
 		if (hlist_empty(&hslot2->head))
-			continue;
+			goto next_bucket;
 
 		iter->offset = 0;
 		spin_lock_bh(&hslot2->lock);
-		udp_portaddr_for_each_entry(sk, &hslot2->head) {
+		sk = hlist_entry_safe(hslot2->head.first, struct sock,
+				      __sk_common.skc_portaddr_node);
+fill_batch:
+		udp_portaddr_for_each_entry_from(sk) {
 			if (seq_sk_match(seq, sk)) {
 				/* Resume from the last iterated socket at the
 				 * offset in the bucket before iterator was stopped.
@@ -3460,33 +3464,55 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 				batch_sks++;
 			}
 		}
+
+		/* Allocate a larger batch and try again. */
+		if (unlikely(resizes <= 1 && iter->end_sk &&
+			     iter->end_sk != batch_sks)) {
+			resizes++;
+
+			/* First, try with GFP_USER to maximize the chances of
+			 * grabbing more memory.
+			 */
+			if (resizes == 1) {
+				spin_unlock_bh(&hslot2->lock);
+				err = bpf_iter_udp_realloc_batch(iter,
+								 batch_sks * 3 / 2,
+								 GFP_USER);
+				if (err)
+					return ERR_PTR(err);
+				/* Start over. */
+				goto again;
+			}
+
+			/* Next, hold onto the lock, so the bucket doesn't
+			 * change while we get the rest of the sockets.
+			 */
+			err = bpf_iter_udp_realloc_batch(iter, batch_sks,
+							 GFP_NOWAIT);
+			if (err) {
+				spin_unlock_bh(&hslot2->lock);
+				return ERR_PTR(err);
+			}
+
+			/* Pick up where we left off. */
+			sk = iter->batch[iter->end_sk - 1];
+			sk = hlist_entry_safe(sk->__sk_common.skc_portaddr_node.next,
+					      struct sock,
+					      __sk_common.skc_portaddr_node);
+			batch_sks = iter->end_sk;
+			goto fill_batch;
+		}
+
 		spin_unlock_bh(&hslot2->lock);
 
 		if (iter->end_sk)
 			break;
+next_bucket:
+		resizes = 0;
 	}
 
-	/* All done: no batch made. */
-	if (!iter->end_sk)
-		return NULL;
-
-	if (iter->end_sk == batch_sks) {
-		/* Batching is done for the current bucket; return the first
-		 * socket to be iterated from the batch.
-		 */
-		iter->st_bucket_done = true;
-		goto done;
-	}
-	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2,
-						    GFP_USER)) {
-		resized = true;
-		/* After allocating a larger batch, retry one more time to grab
-		 * the whole bucket.
-		 */
-		goto again;
-	}
-done:
-	return iter->batch[0];
+	WARN_ON_ONCE(iter->end_sk != batch_sks);
+	return iter->end_sk ? iter->batch[0] : NULL;
 }
 
 static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -3841,7 +3867,10 @@ static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
 	if (!new_batch)
 		return -ENOMEM;
 
-	bpf_iter_udp_put_batch(iter);
+	if (flags != GFP_NOWAIT)
+		bpf_iter_udp_put_batch(iter);
+
+	memcpy(new_batch, iter->batch, sizeof(*iter->batch) * iter->end_sk);
 	kvfree(iter->batch);
 	iter->batch = new_batch;
 	iter->max_sk = new_batch_sz;
-- 
2.43.0


