Return-Path: <bpf+bounces-55364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102DBA7C625
	for <lists+bpf@lfdr.de>; Sat,  5 Apr 2025 00:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E2E3BB4BA
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 22:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D6621E0BD;
	Fri,  4 Apr 2025 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="D2tLuB0H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B68A19DFB4
	for <bpf@vger.kernel.org>; Fri,  4 Apr 2025 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743804195; cv=none; b=DokQ3YG2rt7L0xZYOH4RXTMX+XN2zYBlRA3R6EAg+RZ9sQ7UUEfJYZvLs2MSdm2C834Lv0Q15QbKPISdTqRL6xxBqfZXozM/4x9+06CrOMjIyQBU0+yYYR8m1dFa9V3vpJix1uROjU4wja9QJBREBn7KGG0c8jPm1VWHvkx9PCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743804195; c=relaxed/simple;
	bh=AHoNXwRDtFm2c3bvgnHPLkSqmYdD0JicGAZjVJtcA20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPB94Nbr410032yUKxnjTyOC4ENBt6BSY0c79cHrgncOTp2+h34QmQDM1Gt4pEkSx9PXewXarHIjg7ag3lSOtk4U09fw0xFStAYA4NU0WpCEX35q3Ae1YDd5xCRzZ8yqZbeVZZi1JGWXNmySTnFJFLTHqDcd6UnUYLOY94Yj06A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=D2tLuB0H; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736c8cee603so146564b3a.1
        for <bpf@vger.kernel.org>; Fri, 04 Apr 2025 15:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1743804193; x=1744408993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oW22utRVJlmxkJn8Ws+r1VE3x3sbMZjTXzP+gFGRXJk=;
        b=D2tLuB0HDW7l2uYlsjxH9GZDa08lbDgWs98JAFIrJJcIZMVgj8bXYJVLO9Ttum8yJ9
         2F4zGdkxx3yOumx6oNvSm1DTiFa+CpaqXoYI5ko2TLBf/hMw+osr6tEJ+AG+3AIsEA+p
         rERwxHAO/FGyb6G+8DDQl1fV8lHbledWKpoXdGVFsVo+H3Kt71Ke50/Kd3hvxhOO+nMI
         cW5V6d7JNvwICFqB//JUaTVEEC0b9fD0W+mD0UM/mRCMhHQdAo3U6tX3rfz57nfvyzHN
         GXs2j/S2K3CAKPUChXJ47bG7DtUJgBsjbnC8Y3YrpfSRWfu3cMY+XOCf/OSOUtuiH0gb
         c77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743804193; x=1744408993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oW22utRVJlmxkJn8Ws+r1VE3x3sbMZjTXzP+gFGRXJk=;
        b=X5dcWdTZb6Iz67GkpsMWENjb4V0rQ4sj2Tz/HXHSRbfAvyaEWHmMB2DdgXYmNNVW+h
         IFFEZd9dOpsGA0qPT0g3GCQzCZG02HRez1SMKxXoFVz8xpEQfWo56LMtmNa7Z1OO8fKt
         veACIPv/eMAcExA4hRY1HAz+f6NUh7GaBjSPqTADSdL0QlWp9ZaZF061BnQUygYqBgZ4
         fh+DZ0skK1ZdkdL9gGiSTjVUvjPtD3zzu3ceqUe4SqCmxWsFesI/uzAdJfTK/2bNgmez
         laCvyL2DsLWZdnUyn4TWGNXJ0lUvbl7uEbpw8/6Wv8+vVyXAIPcwotA38XS+W7sGcyTv
         WLMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgGpCb63cyGgXbRXhfe3RiDlDOMfH/ihSMBaImJIFZhnxEFv3UUQvHYBJjg//zT2f12Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNOzOXuQS/drcV1I/imiU4oGaeUv7r2vAdgPCvoseG7QB1ofoH
	klvTfVDP/2Qy+XZ/aMcpq+jXg80K9MugZjnoiFuKxXhCeK26PC8AFyGQGWjdvqA=
X-Gm-Gg: ASbGncuFmmOTEpcFEWVYNnIQFj5Ykpud1x9ZOuzE/pjU9DI69lGKtNdtzKt5vHuc2vd
	/7bEgglHZq9BoE9AhjoRgUq1kK2tTDOd9ynPD8gdYG/KANq1H4O02Ojf+EzaxmG6KhNiVXWZN0n
	qjfRYae3vB524fIFAMzGBkEwnCdVCS5SBNW46FscCw6pvnozfw7kzhgu3LVoQClNEwna6qRnE+O
	c+IBRFXZheRXFxOy4UAW/bsKac/fzXedtTbfYpfUPWoMJrQJ6BSNtX6GfaeRfWAPuet1Ijq402R
	TTwqWw+Uke5jEP5Q9wWC5CgT16bL/J+8TA==
X-Google-Smtp-Source: AGHT+IGaykBQ7/5sO0otaUbqM/5rc7e/jYb7eG8PE8gq8NbAOfvwTnAn260qSbjbjwTbVDnHEHOZaQ==
X-Received: by 2002:a05:6a00:a91:b0:72a:a7a4:99ca with SMTP id d2e1a72fcca58-739e48f8d69mr2915275b3a.2.1743804192641;
        Fri, 04 Apr 2025 15:03:12 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d158:c069:399b:1ed0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0deddfsm3953570b3a.162.2025.04.04.15.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 15:03:12 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [RFC PATCH bpf-next 2/3] bpf: udp: Avoid socket skips and repeats during iteration
Date: Fri,  4 Apr 2025 15:02:17 -0700
Message-ID: <20250404220221.1665428-3-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404220221.1665428-1-jordan@jrife.io>
References: <20250404220221.1665428-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the offset-based approach for tracking progress through a bucket
in the UDP table with one based on socket cookies. Remember the cookies
of unprocessed sockets from the last batch and use this list to
pick up where we left off or, in the case that the next socket
disappears between reads, find the first socket after that point that
still exists in the bucket and resume from there.

In order to make the control flow a bit easier to follow inside
bpf_iter_udp_batch, introduce the udp_portaddr_for_each_entry_from macro
and use this to split bucket processing into two stages: finding the
starting point and adding items to the next batch. Originally, I
implemented this patch inside a single udp_portaddr_for_each_entry loop,
as it was before, but I found the resulting logic a bit messy. Overall,
this version seems more readable.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 include/linux/udp.h |  3 ++
 net/ipv4/udp.c      | 78 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 63 insertions(+), 18 deletions(-)

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
index 59c3281962b9..00cec269c149 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -93,6 +93,7 @@
 #include <linux/inet.h>
 #include <linux/netdevice.h>
 #include <linux/slab.h>
+#include <linux/sock_diag.h>
 #include <net/tcp_states.h>
 #include <linux/skbuff.h>
 #include <linux/proc_fs.h>
@@ -3386,6 +3387,7 @@ struct bpf_iter__udp {
 
 union bpf_udp_iter_batch_item {
 	struct sock *sock;
+	__u64 cookie;
 };
 
 struct bpf_udp_iter_state {
@@ -3393,26 +3395,42 @@ struct bpf_udp_iter_state {
 	unsigned int cur_sk;
 	unsigned int end_sk;
 	unsigned int max_sk;
-	int offset;
 	union bpf_udp_iter_batch_item *batch;
 	bool st_bucket_done;
 };
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
 				      unsigned int new_batch_sz);
+static struct sock *bpf_iter_udp_resume(struct sock *first_sk,
+					union bpf_udp_iter_batch_item *cookies,
+					int n_cookies)
+{
+	struct sock *sk = NULL;
+	int i = 0;
+
+	for (; i < n_cookies; i++) {
+		sk = first_sk;
+		udp_portaddr_for_each_entry_from(sk)
+			if (cookies[i].cookie == atomic64_read(&sk->sk_cookie))
+				goto done;
+	}
+done:
+	return sk;
+}
+
 static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 {
 	struct bpf_udp_iter_state *iter = seq->private;
 	struct udp_iter_state *state = &iter->state;
+	unsigned int find_cookie, end_cookie = 0;
 	struct net *net = seq_file_net(seq);
-	int resume_bucket, resume_offset;
 	struct udp_table *udptable;
 	unsigned int batch_sks = 0;
 	bool resized = false;
+	int resume_bucket;
 	struct sock *sk;
 
 	resume_bucket = state->bucket;
-	resume_offset = iter->offset;
 
 	/* The current batch is done, so advance the bucket. */
 	if (iter->st_bucket_done)
@@ -3428,6 +3446,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	 * before releasing the bucket lock. This allows BPF programs that are
 	 * called in seq_show to acquire the bucket lock if needed.
 	 */
+	find_cookie = iter->cur_sk;
+	end_cookie = iter->end_sk;
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
 	iter->st_bucket_done = false;
@@ -3439,18 +3459,26 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		if (hlist_empty(&hslot2->head))
 			continue;
 
-		iter->offset = 0;
 		spin_lock_bh(&hslot2->lock);
-		udp_portaddr_for_each_entry(sk, &hslot2->head) {
+		/* Initialize sk to the first socket in hslot2. */
+		udp_portaddr_for_each_entry(sk, &hslot2->head)
+			break;
+		/* Resume from the first (in iteration order) unseen socket from
+		 * the last batch that still exists in resume_bucket. Most of
+		 * the time this will just be where the last iteration left off
+		 * in resume_bucket unless that socket disappeared between
+		 * reads.
+		 *
+		 * Skip this if end_cookie isn't set; this is the first
+		 * batch, we're on bucket zero, and we want to start from the
+		 * beginning.
+		 */
+		if (state->bucket == resume_bucket && end_cookie)
+			sk = bpf_iter_udp_resume(sk,
+						 &iter->batch[find_cookie],
+						 end_cookie - find_cookie);
+		udp_portaddr_for_each_entry_from(sk) {
 			if (seq_sk_match(seq, sk)) {
-				/* Resume from the last iterated socket at the
-				 * offset in the bucket before iterator was stopped.
-				 */
-				if (state->bucket == resume_bucket &&
-				    iter->offset < resume_offset) {
-					++iter->offset;
-					continue;
-				}
 				if (iter->end_sk < iter->max_sk) {
 					sock_hold(sk);
 					iter->batch[iter->end_sk++].sock = sk;
@@ -3494,10 +3522,8 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	/* Whenever seq_next() is called, the iter->cur_sk is
 	 * done with seq_show(), so unref the iter->cur_sk.
 	 */
-	if (iter->cur_sk < iter->end_sk) {
+	if (iter->cur_sk < iter->end_sk)
 		sock_put(iter->batch[iter->cur_sk++].sock);
-		++iter->offset;
-	}
 
 	/* After updating iter->cur_sk, check if there are more sockets
 	 * available in the current bucket batch.
@@ -3567,8 +3593,19 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
 
 static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
 {
-	while (iter->cur_sk < iter->end_sk)
-		sock_put(iter->batch[iter->cur_sk++].sock);
+	union bpf_udp_iter_batch_item *item;
+	unsigned int cur_sk = iter->cur_sk;
+	__u64 cookie;
+
+	/* Remember the cookies of the sockets we haven't seen yet, so we can
+	 * pick up where we left off next time around.
+	 */
+	while (cur_sk < iter->end_sk) {
+		item = &iter->batch[cur_sk++];
+		cookie = __sock_gen_cookie(item->sock);
+		sock_put(item->sock);
+		item->cookie = cookie;
+	}
 }
 
 static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
@@ -3839,6 +3876,11 @@ static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
 		return -ENOMEM;
 
 	bpf_iter_udp_put_batch(iter);
+	WARN_ON_ONCE(new_batch_sz < iter->max_sk);
+	/* Make sure the new batch has the cookies of the sockets we haven't
+	 * visited yet.
+	 */
+	memcpy(new_batch, iter->batch, iter->end_sk);
 	kvfree(iter->batch);
 	iter->batch = new_batch;
 	iter->max_sk = new_batch_sz;
-- 
2.43.0


