Return-Path: <bpf+bounces-56555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B965A99C44
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 01:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B4E3ACFE5
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 23:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AA6244688;
	Wed, 23 Apr 2025 23:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="BTMzqnDS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BEC22F77E
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745452291; cv=none; b=bnEU4ZGcDD7n+FpgZDOt5qGb1YwGZrMKgUAfRCoLntDwb6dj4MFhtkL5/Ie2pBJ7KuaggHPdsdOJDNMiRhxUcOAiKRn2PHmHLwxQ2Ne+5RRjFc07HYkaLtAzcXbGbMwPPo0g4NR5d55IIfVqSuKH92XVLjUwObScGCM75MBXztU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745452291; c=relaxed/simple;
	bh=FBj7LZvfNV2C2B/oOGS6wGyUDLX8RKZiFkdPqgHg2rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zc1o9Q5eTjidhpj5Qp61MGx8iThdoidPtAFUxgdsCCMlfMWGJn2JXvUySRZtLTkeEFnCzyhhUH8k+CIN9HbztxwQqGJoXBf8fjBsfHYxBvS5gpWseP0rXHLMCxZ6EKUPBSyWOXG6Hq0hFC3jAXis5q0R5J3CpXVJOMuDMuSQoag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=BTMzqnDS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223fd44daf8so692705ad.2
        for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 16:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745452289; x=1746057089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nu1ma7oh32WGDFCcqk3JijchsOGs9eeCKBsDLWEj1bM=;
        b=BTMzqnDSmjt3obzPBBseHcyEda3j+NkY7n9FT8MAcKF5czung8C1sFgZBSWC0vnlFD
         bmfVyMvdT0Ok8HMw1tGDFWZt/tcyPMpEquRnpqTdYlUMf+6xxkxd7TZGGafghDDDvoNr
         kIEll6ySvqOn3ZlGWM7S8RIpW6cXwj9mOEGw8AQOESh6tQXFZUyud8H7XjEc2V815KhX
         nLTme0I+Vf0ZvmVf9JBi+/LVZd8t6MRiklkfafgpemmwIZdP6Or0DuZBslIJSgVmz1tx
         3kDIvc+rycn90nzHOZOWQM69snlIBlkyKtULFdaQt6CuVb9jd2TLinoMcZn+bQuWuIlI
         QWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745452289; x=1746057089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nu1ma7oh32WGDFCcqk3JijchsOGs9eeCKBsDLWEj1bM=;
        b=cNgjpJc7uhzL+V8QA4DUdSLlzmfsI5YuftfeXrOKo7z5jVEruQajd+k8vD8A6IvlbJ
         OlbgOVqCf2Tim4RPDqWVTN9EBzFYxIQ53sfOoZIZ4So9I6mG+8nakeLjYS6WiPMoirjR
         NsIk44FzebsVeRGCFq6AKfFSbsC8bM4+12ZNsfMmn/Cfs7f+iWw+z6V2P2ANqkhpKbxe
         mr51wHwhtuh2cbNghXFQGbiqscO7mNKxxLyjWOSNt3CMA1Y+PszHvFiY3QhRsSzhLuVx
         vlknl4bOHqniksFVThqyBsplDbSbS8vNcfknLzmzCz4zPeHIFnimCM816jRBBxiC5ItR
         COwg==
X-Forwarded-Encrypted: i=1; AJvYcCXUe0PT8au59gOdh7bmjcTQxaxRcp0pRQs7enjHHPkEddcyc9uf7PuYKOd3++3woRFKB58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKxDeHG1+vHFHSDn9C/Ndd2X5jfo6DllD48t3O1IMKfM1j1KM0
	ftPqhek8dEXRUM3OBV9KnLogs1pZu80OToraBUlSXdVG52NhqjSylezQLptraEQ=
X-Gm-Gg: ASbGncsOLVit1BbiRsKswIlZCHNrb4bXvf0mo/UKpiu5posIxuprY2sSPQtEOgMSPTS
	3/z+WpWh8hDw+6wPGbXzAbUW+38t1o1oPrtZWvPeL+8Ak0CDy/qBe3RXPpBT/E2wgUAs+L3LfCI
	l+KFR7iSqRzYFXMK5lNOItx4P9RlLnsWWsg01yVSojN1veOypH+YyajYeu2UluhzZRnFBDm1nzg
	ELwLiTSxupsDxH0eNnbjyAOUxmNdiEb18EQDT46MzDiLAfR9Md80J5HD4737jnFBQJt2b4b5dSp
	tZyvS4DzJV/px1b4h7lTE6m0SRHX55T2rdKU6Y0u
X-Google-Smtp-Source: AGHT+IEBr7R4hUlvqm1XZ6RC0wMA10N6hNOWvSsEtC5k7HY9kXTwQ3suKQEksBOg8YD9rvFAGxny5A==
X-Received: by 2002:a17:902:cecc:b0:21d:cdb7:876c with SMTP id d9443c01a7336-22db3bb9e87mr2350345ad.3.1745452289274;
        Wed, 23 Apr 2025 16:51:29 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:f4b1:8a64:c239:dca3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76cfasm499175ad.47.2025.04.23.16.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 16:51:28 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v5 bpf-next 2/6] bpf: udp: Make sure iter->batch always contains a full bucket snapshot
Date: Wed, 23 Apr 2025 16:51:10 -0700
Message-ID: <20250423235115.1885611-3-jordan@jrife.io>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250423235115.1885611-1-jordan@jrife.io>
References: <20250423235115.1885611-1-jordan@jrife.io>
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
2. Retry bpf_iter_udp_realloc_batch() two times without holding onto the
   bucket lock (hslot2->lock) so that we can use GFP_USER and maximize
   the chances that memory allocation succeeds. On the third attempt, if
   we still haven't been able to capture a full bucket snapshot, hold
   onto the bucket lock through bpf_iter_udp_realloc_batch() to
   guarantee that the bucket size doesn't change while we allocate more
   memory and fill the batch. On the last pass, we must use GFP_ATOMIC
   since we hold onto the spin lock.

Introduce the udp_portaddr_for_each_entry_from macro and use it instead
of udp_portaddr_for_each_entry to make it possible to continue iteration
from an arbitrary socket. This is required for this patch in the
GFP_ATOMIC case to allow us to fill the rest of a batch starting from
the middle of a bucket and the later patch which skips sockets that were
already seen.

Testing all scenarios directly is a bit difficult, but I did some manual
testing to exercise the code paths where GFP_ATOMIC is used and where
where ERR_PTR(err) is returned. I used the realloc test case included
later in this series to trigger a scenario where a realloc happens
inside bpf_iter_udp_batch and made a small code tweak to force the first
two realloc attempts to allocate a too-small buffer, thus requiring
another attempt until the GFP_ATOMIC case is hit. Some printks showed
three reallocs with the tests passing:

Apr 16 00:08:32 crow kernel: go again (mem_flags=GFP_USER)
Apr 16 00:08:32 crow kernel: go again (mem_flags=GFP_USER)
Apr 16 00:08:32 crow kernel: go again (mem_flags=GFP_ATOMIC)

With this setup, I also forced bpf_iter_udp_realloc_batch to return
-ENOMEM on one of the retries to ensure that iteration ends and that the
read() in userspace fails and incremented batch_sks to hit the
WARN_ON_ONCE condition.

[1]: https://lore.kernel.org/bpf/CABi4-ogUtMrH8-NVB6W8Xg_F_KDLq=yy-yu-tKr2udXE2Mu1Lg@mail.gmail.com/
[2]: https://lore.kernel.org/bpf/7ed28273-a716-4638-912d-f86f965e54bb@linux.dev/

Signed-off-by: Jordan Rife <jordan@jrife.io>
Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
---
 include/linux/udp.h |  3 +++
 net/ipv4/udp.c      | 62 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 50 insertions(+), 15 deletions(-)

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
index 6a3c351aa06e..0960e42f2d2c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3383,6 +3383,7 @@ int udp4_seq_show(struct seq_file *seq, void *v)
 }
 
 #ifdef CONFIG_BPF_SYSCALL
+#define MAX_REALLOC_ATTEMPTS 2
 struct bpf_iter__udp {
 	__bpf_md_ptr(struct bpf_iter_meta *, meta);
 	__bpf_md_ptr(struct udp_sock *, udp_sk);
@@ -3410,8 +3411,9 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	int resume_bucket, resume_offset;
 	struct udp_table *udptable;
 	unsigned int batch_sks = 0;
-	bool resized = false;
 	struct sock *sk;
+	int resizes = 0;
+	int err = 0;
 
 	resume_bucket = state->bucket;
 	resume_offset = iter->offset;
@@ -3439,11 +3441,14 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
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
@@ -3460,10 +3465,34 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 				batch_sks++;
 			}
 		}
+
+		if (unlikely(resizes == MAX_REALLOC_ATTEMPTS) && iter->end_sk &&
+		    iter->end_sk != batch_sks) {
+			/* This is the last realloc attempt, so keep holding the
+			 * lock to ensure that the bucket does not change.
+			 */
+			err = bpf_iter_udp_realloc_batch(iter, batch_sks,
+							 GFP_ATOMIC);
+			if (err) {
+				spin_unlock_bh(&hslot2->lock);
+				return ERR_PTR(err);
+			}
+
+			sk = iter->batch[iter->end_sk - 1];
+			sk = hlist_entry_safe(sk->__sk_common.skc_portaddr_node.next,
+					      struct sock,
+					      __sk_common.skc_portaddr_node);
+			batch_sks = iter->end_sk;
+			resizes++;
+			goto fill_batch;
+		}
+
 		spin_unlock_bh(&hslot2->lock);
 
 		if (iter->end_sk)
 			break;
+next_bucket:
+		resizes = 0;
 	}
 
 	/* All done: no batch made. */
@@ -3475,18 +3504,18 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		 * socket to be iterated from the batch.
 		 */
 		iter->st_bucket_done = true;
-		goto done;
+		return iter->batch[0];
 	}
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
+
+	if (WARN_ON_ONCE(resizes >= MAX_REALLOC_ATTEMPTS))
+		return iter->batch[0];
+
+	err = bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2, GFP_USER);
+	if (err)
+		return ERR_PTR(err);
+
+	resizes++;
+	goto again;
 }
 
 static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -3841,7 +3870,10 @@ static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
 	if (!new_batch)
 		return -ENOMEM;
 
-	bpf_iter_udp_put_batch(iter);
+	if (flags != GFP_ATOMIC)
+		bpf_iter_udp_put_batch(iter);
+
+	memcpy(new_batch, iter->batch, sizeof(*iter->batch) * iter->end_sk);
 	kvfree(iter->batch);
 	iter->batch = new_batch;
 	iter->max_sk = new_batch_sz;
-- 
2.48.1


