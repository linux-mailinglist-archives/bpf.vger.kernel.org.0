Return-Path: <bpf+bounces-56277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF762A9444B
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 17:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1823117A4E3
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 15:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EB11DF72E;
	Sat, 19 Apr 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="vPTYydIS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9D71DDC0F
	for <bpf@vger.kernel.org>; Sat, 19 Apr 2025 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745078292; cv=none; b=nFIauWxi09SRcrnayj8foyWBFFs5364iXwgZFe7Vgdj4VrMHiq+wCqxkIge/ek+OeLhisXBwI5YS68y27UrMYMqSWVur8B0KuMJHUzDJgsN2aegOE9P8G2yA8jKTUiXm1TflfRjwrgOLamqHoPFtvW74/SYxihv4uBnLDvRexpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745078292; c=relaxed/simple;
	bh=IB/qvuVBkNoELVVm0IKpr+V9WQcltfeYsfdKQqo2BWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUfFjuLjbGKTyAO/UQUyehzDAVpW5HOhTyhw4nHysqckAu0MQX09NPMy8uxY1roHZ3FG5ZCY/umCk3PiyyNbvWZrD4WnpSILE49SWsUvv8HUBSOke5gBN/VbYXxd49fUgRBOFno85nsFbtpiBgDHdf62/HYIi7WZJRDAk3VYBCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=vPTYydIS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22403c99457so4066265ad.3
        for <bpf@vger.kernel.org>; Sat, 19 Apr 2025 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745078290; x=1745683090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9gbCNiQ+y8HUaE+W6y8YEShtYnd+/dcegXASkNVABE=;
        b=vPTYydISfigVT9R7po9w0XI+Wxt802he2Nq17TnQ8bvySm5Vju6EhzSLCGyo5wkUrG
         M7CseeczBuwPT59rwkm3gp7EJA/7ntdWIidQQcEekxuPZ9Kw5P4vocwKfuW04TO+MNcB
         DbqZADaS9Su/z8Eb0reMrgkK1v6DM8YzO0AbuF6LSb+Sydajd81CWfIx59scBA+2oS+k
         iaP1wMmbPaCjM1SsWqxGYWRoesf/499JHPlrGpl2K3r+ProTYHdy4yI74qbuMhqP9GDu
         J+xgPzP/4eqRUvO1/qvymk4dv0q2Tn4XR+RUQXs/wate378T5czTGlZkK/PT0LP4tCsg
         fyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745078290; x=1745683090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9gbCNiQ+y8HUaE+W6y8YEShtYnd+/dcegXASkNVABE=;
        b=MpX8/KBCb57T5K33JcjgQzFvZd7jEwTZfxWEMxV70FER/e73rcJS/Uow8DYkRF1Dsx
         OdcfKGn9JqJCRsNIoCgqLF5K7m5CxKRWluUzc/OYz1EgfJQL8ZrQCz/zE+6iw9dD/qDU
         4Byo413fyS87dRklXrVFN792Ekiuw27AwQ8cUJDAAHoEwTnfwVQV2Avc7hJL7ig4YXTK
         GO62ZeWDORLZQkWBAiGjpE1z2cghoXWO9Am/m1nTRqdDhjJmrSf04IUIjJPPqwX2zsT9
         0yGp74p3cUuy0C2ryT9gieVSucmJmaF8dWyPydUP8Sq8n4Wzn5FRCs8sC8OoG9mUXs7x
         cbHw==
X-Forwarded-Encrypted: i=1; AJvYcCWnNDExX6Phm7crflOECBrJuFOSvrsyrRWxFXGrYqcT8e2tYN354MCIaVpurJwqirWcAM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+IZc4qc+SZVRIIghhRtrD3k61wmalv628cZU7OgAfHZ3rEc5M
	764qAj9RINK5G2uaYI9BK3i+6ztnl9gZ7Jg8f2TAJ1myjNOwbXSukaI2DHoKmQs=
X-Gm-Gg: ASbGncv36DPkDgTHzQsbHHBzdalUcp/TLPbdFzWUKissloGD3MPnWIdqEbgvNVflcTh
	4peZOyw1B2WL1c+MNyaSgQvMw7UWVyKjBPe6Bx8AI3A7H+2Bx3+5OPhaHO0Jod93n6xOYbtj3h4
	+GOhK9gamuypxkJz0r/ZaiwmLKU4FsYGSsiaY05YnISNBXg3cJLeqE/O7c3wqNLCuJOgIzZqe+q
	Ai3rOG8jvhhmrvGmGB69WBSiULaZ+hJpl0sLGlda2zgHGViHNgLX7XlCwjPX1DghGC7fHtEQ4bk
	wORU/kzoCTrk1H/SvIsY2uJTCZcGgQ==
X-Google-Smtp-Source: AGHT+IFWNTa+2uuLbzUYIrOvLAxNoctrrfBqbHbCZvuFKhisyD/38/3byOIohM77r1Wb3z5R1yt4rw==
X-Received: by 2002:a17:902:e54a:b0:223:5696:44d6 with SMTP id d9443c01a7336-22c5361b458mr37007615ad.12.1745078290007;
        Sat, 19 Apr 2025 08:58:10 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:1195:fa96:2874:6b2c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8be876sm3464157b3a.36.2025.04.19.08.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 08:58:09 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v4 bpf-next 2/6] bpf: udp: Make sure iter->batch always contains a full bucket snapshot
Date: Sat, 19 Apr 2025 08:57:59 -0700
Message-ID: <20250419155804.2337261-3-jordan@jrife.io>
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
 net/ipv4/udp.c | 61 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0ac31dec339a..d3128261e4cb 100644
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
@@ -3454,15 +3460,28 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
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
-	if (!iter->end_sk)
-		return NULL;
+	if (!iter->end_sk) {
+		sk = NULL;
+		goto done;
+	}
+
+	sk = iter->batch[0];
 
 	if (iter->end_sk == batch_sks) {
 		/* Batching is done for the current bucket; return the first
@@ -3471,16 +3490,30 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
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
 	}
+	err = bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2,
+					 resizes ? GFP_USER : GFP_ATOMIC);
+	if (err) {
+		sk = ERR_PTR(err);
+		goto done;
+	}
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


