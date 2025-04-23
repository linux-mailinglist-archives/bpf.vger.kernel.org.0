Return-Path: <bpf+bounces-56557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7CEA99C45
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 01:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 326D87A38D2
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 23:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255BB256C6B;
	Wed, 23 Apr 2025 23:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="E4kKSDwL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C36244683
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 23:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745452293; cv=none; b=bN1WyxW24wJ+u7ObMtGmCJbRd/YQL9oP7i3nmxTzHCrlfV5VFOVWukPk7JLHfZrbSGoQpXoxmg89IMOKI9PPQ385sINgn0cz4AsBDjiIVAxB4ZqjYd69DwXYsvN9L5hTKm1LApmsi6dMVymr4+ARt1q2YUQe8gx0ulp/H8BPQTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745452293; c=relaxed/simple;
	bh=e18A5ujs5bpiJs6BN03CYgNXOTAczKUsk3LohV8g7fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKEiRXcNmN4HHltoV2PobtfRUEksGpMPW87K0Nvmlah0IBMdswXKZOXGQzRBn4yn4HkYdchASvzarDScYFOsOxavKNot9/I6YL4WGv7wBEfn57NdZfY1NHthdFzr0VR169QgRoEhna/ZNPmZQGebBY/OADhqMax8B2Qx+9l0tNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=E4kKSDwL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22792ef6215so684005ad.2
        for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 16:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745452291; x=1746057091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GdhJzQfmrjGatlAKTx2E3HZJ59Bz4H+Mq6UwhBMBHE=;
        b=E4kKSDwLJZIjfjY8/q6od5kBIkuPwllADS20W+0HZ2jPcRS5MenRpx2tS78DjAxgf+
         F81+Zbv25rX7KNM21u8YgioZTXXzrKP4PYkrJsJMXjpYd4Wr8/vVZYtlzEN1JY8Kx2R/
         Tt3VPYXZpSByrv5BslKXjNDarf3rVkb6XTepjUG3yotC1i0Eprc6XG+QQSl5d6W4TrIU
         MuIJIr4ahVieMako3SqDYC69kgmI6MVjr0UuCsbU+rcun28EnBByGG5RzhyasSnK00g7
         eTneZlQ3qgpOh5DsJwdA8rBp50wZbKB8bWGqqzOl+jzLZy2ZRg98sa/YT15qVSamphL7
         YWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745452291; x=1746057091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GdhJzQfmrjGatlAKTx2E3HZJ59Bz4H+Mq6UwhBMBHE=;
        b=GC4O4rhEe+sfKYkdZbwnL8nmG3c+P/ivVIHivwQbD7rAwK5VIJMJzx3igjJXWCVM7s
         GEuQfXDW5UcEJi0FAN9mRfob0x5GKIKNR8b9sOhDHLEU5MBNct+tFtrscs4j+VGrV8y0
         VLU3co5UrlNQLr9rGBqC4br4VrXO9tLbpYiV0Qh3dLSN9DQNjeoqu0N2+ieE4p0u5s8e
         DLI7s3UpZLxXmGccoD8a9j5R+5n7Yzkkgzyr2lEwQBGRUrVntkYyvHhmxe9WHhdPIkZG
         m+kMCat5j2BOk0UarU0tziDRyrkYGmdhd+jOWNlZoqQ0lUEvgQ7G9O/6CirVZKIbSn7q
         Xofg==
X-Forwarded-Encrypted: i=1; AJvYcCVisUDFoNYq0ZXuAcUS1UVtgo6qyJ+04Z7n6BzFdJqJCHi6QDX4meCoHAV/505IY7XTLOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeEuTWu/3+/Q6xWVPSjpKKzwd7B6zRrERvcuHa8oRX7iyEIXM8
	Lq9qc5MKneZdvmSgzeQI1amH1IHhS5AXOEA7fnjgNH/klBbB6NuwfOqtNBID+dM=
X-Gm-Gg: ASbGncswe+LQ9vWPkD6UNnzBTqAe0/Zecv0psrJOgmQ+COhW4aUiod9SxiVXb6f/VoB
	L49JSME0U71ZHHVK6fvugwLeH9vLCY4NozTBnjbqm6ZeeOaxv4n8C2F+NXYblvHbGcuiGzqyQxH
	0AFz/CBcvfW+zVwuNmnrG6rzXKRpjFQMWcJbZEz6RL9l5ov8Bbcrf0BMBzajSAqbptcyJIOH9pE
	zbbnwqCxsR0aWA4z+rBO/r069f/IgATV8xZW6Dj+3sfyp76MAjDtFLycbjg41OIjAb7KT+hJVDE
	6APkMdNru66OhKXfZGYynKWt02RvDNqTpGOYa+Fv
X-Google-Smtp-Source: AGHT+IFDofTtSJXLw5DZkY2X3uNBzhGsKy7SV4664T+3ysYadN6V8bBzPIXNkQy+YZf9PlOKrhLw+A==
X-Received: by 2002:a17:902:d48a:b0:220:e1e6:446e with SMTP id d9443c01a7336-22db3bd5b37mr2023425ad.1.1745452291493;
        Wed, 23 Apr 2025 16:51:31 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:f4b1:8a64:c239:dca3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76cfasm499175ad.47.2025.04.23.16.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 16:51:31 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v5 bpf-next 4/6] bpf: udp: Avoid socket skips and repeats during iteration
Date: Wed, 23 Apr 2025 16:51:12 -0700
Message-ID: <20250423235115.1885611-5-jordan@jrife.io>
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

Replace the offset-based approach for tracking progress through a bucket
in the UDP table with one based on socket cookies. Remember the cookies
of unprocessed sockets from the last batch and use this list to
pick up where we left off or, in the case that the next socket
disappears between reads, find the first socket after that point that
still exists in the bucket and resume from there.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/ipv4/udp.c | 68 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 6f1835078715..1519da600c49 100644
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
@@ -3393,6 +3394,7 @@ struct bpf_iter__udp {
 
 union bpf_udp_iter_batch_item {
 	struct sock *sock;
+	__u64 cookie;
 };
 
 struct bpf_udp_iter_state {
@@ -3400,27 +3402,43 @@ struct bpf_udp_iter_state {
 	unsigned int cur_sk;
 	unsigned int end_sk;
 	unsigned int max_sk;
-	int offset;
 	union bpf_udp_iter_batch_item *batch;
 	bool st_bucket_done;
 };
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
 				      unsigned int new_batch_sz, int flags);
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
+	int resume_bucket;
 	struct sock *sk;
 	int resizes = 0;
 	int err = 0;
 
 	resume_bucket = state->bucket;
-	resume_offset = iter->offset;
 
 	/* The current batch is done, so advance the bucket. */
 	if (iter->st_bucket_done)
@@ -3436,6 +3454,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	 * before releasing the bucket lock. This allows BPF programs that are
 	 * called in seq_show to acquire the bucket lock if needed.
 	 */
+	find_cookie = iter->cur_sk;
+	end_cookie = iter->end_sk;
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
 	iter->st_bucket_done = false;
@@ -3447,21 +3467,26 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		if (hlist_empty(&hslot2->head))
 			goto next_bucket;
 
-		iter->offset = 0;
 		spin_lock_bh(&hslot2->lock);
 		sk = hlist_entry_safe(hslot2->head.first, struct sock,
 				      __sk_common.skc_portaddr_node);
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
 fill_batch:
 		udp_portaddr_for_each_entry_from(sk) {
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
@@ -3530,10 +3555,8 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
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
@@ -3603,8 +3626,19 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
 
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
+		cookie = sock_gen_cookie(item->sock);
+		sock_put(item->sock);
+		item->cookie = cookie;
+	}
 }
 
 static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
-- 
2.48.1


