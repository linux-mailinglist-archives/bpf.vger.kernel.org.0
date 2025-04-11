Return-Path: <bpf+bounces-55769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4C2A864DE
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 19:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6D41BA266F
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 17:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455D023A98E;
	Fri, 11 Apr 2025 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="weRTnPGV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2FB23957E
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392975; cv=none; b=SyDt8Df+82THaiihpHFLPWVUYcoiFdxNbUO6FJopChuznmo2DrzUK7kmQAtz7stkgpcOCkFbLm+nIn4i78x9bjV2kdF00cM3eR9+K8ZybkJnEEj69CgWpGe2YLlvEjEFS07il0rKkwBWEoUebh6rdTQ6hbpLOtX5UB3iU6IYwlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392975; c=relaxed/simple;
	bh=9fC7Vf/A4vMPVbJKN1iuQynlZX6OURoYPm5Ca12woMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cx3bVoCUML8QBOam03TrNLkxwOAIR3JYJ9kMuK0lr32aKgr9bCPCziYVEc8L0ZyjHGk4+pfzFXixToasxklHcMkxqZgjjAzzypMMlvt5tuH8mTBO5+ow9/XVLzR+FvFAgBhgcZNTUREhTGgCBIcWWcS+Cl1DB+K07PbBaac1f/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=weRTnPGV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2240b4de10eso4021915ad.1
        for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 10:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744392973; x=1744997773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jl6ReKdPx8C/wt1azRG5LHr9+7n0dogd4Ak9kATps7w=;
        b=weRTnPGVWs7BfeX3JbMIGM4VjdYw7OQmDbdkeejTtNFUKR/bGyf99ggtR4MqRZtyNj
         GNlDTuWQD1Kg7fTW4WZs0581IixKft5eqJfyoDLezGbVDu0r/YRzxGzCdSVZIs218fzM
         gUBnSM0PQQC/RSJceekiLeEH1PvlLyvQE6XUInouFAbB6GqtmPxaeoxKJZ6MFmgfxMQE
         F9rWvzXQP1FsVsP2XxYm7r73DHX//su/OVd6Q9m4QFzSwrP2ULoAUfVYzQ6KLEDa5WS5
         g21cobQABx9bO7JROOFpwUthXF+5ON84x0VR//TMbZjrXg6KY8qG28wXgoHFtNqsOLAg
         B2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744392973; x=1744997773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jl6ReKdPx8C/wt1azRG5LHr9+7n0dogd4Ak9kATps7w=;
        b=X7bqiDlCihlmw2KPxfIsqEA7cSrBUjibjwVLEyN6rrhRIjYoODbueEknAw88EG5cX/
         YPw9kPYBIK56VWLT1xdu3djUWEbLr9yHmWi4YeD4cZJWKAP8aSsiIbGmD32ASso1v7Vh
         h0gLkMfQ1f4aecBjvRw04bvjRLHnhrQnf4QKI1vXGmNBwDuBoXyH8EOoaC/luvIZyQyI
         okPtY1E6itQg0jpx+dvo/3fxqPnsvoBpvqmZ2/TDfZwvBxcwijObx0GcVotReMy3c21q
         TCwEtJzHAkLnmi0vheaf9PL9II8SBP5zknQpZxxesulMLCapxMEpUir+gbF7tyVR5jNG
         kuzg==
X-Forwarded-Encrypted: i=1; AJvYcCUZdsWA5YrzDrBpURPPJYVjPYOeKvruweZGpw1tHwcZCgM3cJKkjurkdJqtuLMIBfGPu90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Ga/7N1VNRpiZ9HOZ6Hs3NTlCnIORycs7fhNq+ute/vbJHd2c
	yPXS1Mzyj3yaval3ccTtmT6fIVJtmrnAEpTqdOL4jK0c0y+UtxepnIYM8R2k1tE=
X-Gm-Gg: ASbGncuPjpWPTo0WXQrkboXErhc/fnXIq/4lo046W+QLIcxRU2TPLcg97HePyt3su0T
	9La8gbzw7XN+jlVzWcfi/gQK+PSXGe+IyAQ9KPi7OE9ZxdL2gzotYdgQcFqZnZzEgWJg62quDH9
	IzEwUb38gA3zfmqTE2t5N1FTu8nk4p8lkV9qCQ7TlLl3eTz4oqGUulY3GzW9KWcl2T7sbL1DQi3
	pLY6YcTezhHRKe8jnXCCpvbUfElw90S+s/VAySXa9cAvJvzM6ja7v0lygI+ym++FUGkcoc4cLgD
	qZZY8kgHHNHXifJYuVBUV7RGPN4Jvxh5LCLL4uYE
X-Google-Smtp-Source: AGHT+IHA6F2ScngkODDG7KjuerntZEdhx5hqKmKUBYeBa9HE/sPPCY6NWCVsaUWfwi21xQYLrqKW/A==
X-Received: by 2002:a17:902:ef02:b0:215:435d:b41a with SMTP id d9443c01a7336-22bea49d0abmr19592845ad.1.1744392973591;
        Fri, 11 Apr 2025 10:36:13 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:fd98:4c7f:39fa:a5c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb6a50sm52317725ad.205.2025.04.11.10.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:36:13 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v2 bpf-next 3/5] bpf: udp: Avoid socket skips and repeats during iteration
Date: Fri, 11 Apr 2025 10:35:43 -0700
Message-ID: <20250411173551.772577-4-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411173551.772577-1-jordan@jrife.io>
References: <20250411173551.772577-1-jordan@jrife.io>
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
 net/ipv4/udp.c      | 77 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 62 insertions(+), 18 deletions(-)

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
index 1e8ae08d24db..6e7c3c113320 100644
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
@@ -3393,27 +3395,43 @@ struct bpf_udp_iter_state {
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
 	int err = 0;
 
 	resume_bucket = state->bucket;
-	resume_offset = iter->offset;
 
 	/* The current batch is done, so advance the bucket. */
 	if (iter->st_bucket_done)
@@ -3429,6 +3447,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	 * before releasing the bucket lock. This allows BPF programs that are
 	 * called in seq_show to acquire the bucket lock if needed.
 	 */
+	find_cookie = iter->cur_sk;
+	end_cookie = iter->end_sk;
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
 	iter->st_bucket_done = false;
@@ -3440,18 +3460,26 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		if (hlist_empty(&hslot2->head))
 			continue;
 
-		iter->offset = 0;
 		spin_lock_bh(&hslot2->lock);
-		udp_portaddr_for_each_entry(sk, &hslot2->head) {
+		/* Initialize sk to the first socket in hslot2. */
+		sk = hlist_entry_safe(hslot2->head.first, struct sock,
+				      __sk_common.skc_portaddr_node);
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
@@ -3499,10 +3527,8 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
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
@@ -3572,8 +3598,19 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
 
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
@@ -3844,6 +3881,10 @@ static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
 		return -ENOMEM;
 
 	bpf_iter_udp_put_batch(iter);
+	/* Make sure the new batch has the cookies of the sockets we haven't
+	 * visited yet.
+	 */
+	memcpy(new_batch, iter->batch, sizeof(*iter->batch) * iter->end_sk);
 	kvfree(iter->batch);
 	iter->batch = new_batch;
 	iter->max_sk = new_batch_sz;
-- 
2.43.0


