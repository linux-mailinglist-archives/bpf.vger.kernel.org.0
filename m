Return-Path: <bpf+bounces-55566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E8BA82E8E
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 20:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35DC8A0DFD
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 18:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5AC278141;
	Wed,  9 Apr 2025 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="kogw9feN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEA327701D
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744222968; cv=none; b=ID6Yfj+gDKan3pTLhMZBKYg+gJBB+IwHMYDd6aMqiPaU2N3WdJvqonixRIac0tRWoKcaxt5UV4Qq/FvShHR3Lz8tA5bb5Ur+moiU3L8z7rl+Kc4/+V6bONmxJhzerNKSHsUHsap2g5a1K7zLMyO6mTkiJaj/eie20UXEjLYsGmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744222968; c=relaxed/simple;
	bh=9Ty13kz+vG892eEU/2suz2+F7mpuey8R9EO5xxq9kNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UeYosBdQ8Ueem2HO8judBSS9Fe8QlXO66OCM2VtkgU5/Og3sDfXEZ3AOkqhMBz8OpX+G3EeGtXgaAFwA0koVJ8/DappwBeaYxJY+O19qchvzY+mtigCcOeBLjZv0eLIhGb6D6T/NQHv3rC3u04BIVwy6ye6kPpB1dV9txntpCEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=kogw9feN; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-737685eda9aso711137b3a.3
        for <bpf@vger.kernel.org>; Wed, 09 Apr 2025 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744222965; x=1744827765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISVnKv8eaf3vmQhEyj3tVD+8xYJUfBBYc2rhhs4las8=;
        b=kogw9feNWyrhq174XY8xBW1jdsC5gs3x10yiDjU9dvraynZN2+VFbmBwVXhh2LkZ1n
         6Cpk26soXh59pPfXrb4n9mIKRf4UHn5QNIXl7uFf0GhwTsZEv25MNGJIxLRCHQtly3cw
         gdhblEioFgHVuakRucAq3sG4+sMiJ4+do3p5FF+JGp1HsQ0PhtmcWx4Dr/3COFZsX0DN
         0yjSxZaogkmahQpfX2CpGt0xhUHk9NSAVtjHeO3HN4zCYL7bMuHRleprvG+2npa2UeGu
         6qQb9Mcqc5lg54xRyOPxle060TjQk0hzFkVuUMN872wl9loor4ZnBG+Q8wIiQz7SFCps
         DvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744222965; x=1744827765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISVnKv8eaf3vmQhEyj3tVD+8xYJUfBBYc2rhhs4las8=;
        b=N1mh50WzmfnfpsfREgisuN9h2yMZCKOSx/jSVIXNgVKfWpKZ3sz4WiNs1zcjRmianE
         8rRWFs4GrYrQl4uuSIGgSXan8dkjPXqcTo1evcJo/zXHv0jle+KBOaMe17elwt8uKY1o
         2Fqlk06Ek7O1Wyaxz+023ZBu2JqRO1FofnLXgDlu+K3JXCUyIMGFmDqw8ZBa+RfsmCuj
         7pESKByRJjg4PkuuWwkP8VjI94m+P/EdLebYze2tPdgErNnHQw6iO080UKfuMnuxJiRo
         OxIxH3UvC9resh/R0gd6QPz7IOWawg5Ig80JNIO1OxJWP7DEnF2U/ViBlgj42LgZmqCH
         fEjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6dNIixsuCNiVp4FySoEVh1tGoy+Eti/nOwlwyD4aW69gou7pW2indiputmEvRGdzWmzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO4EzQJq2n4/qrxyTHinlZM9j9wqOaTXE9n8xJuiXTSH35d8Uu
	22k9w2ObjURs4aKv/wLDce65ZgxJIV/tcYf8WRv/0d2o+8JnWctl1q9mYzZe5m8=
X-Gm-Gg: ASbGncuuBM2pA8vyqCwXj7JTQVEtfg1kiDRa7bYfotRf97wKrzg+7JsMlwpt6yE4Cds
	s+XjVOotm2OTkBRCinmC+V38TpO3ejLV0g4ysWO1gUti8oNCxGkCHrpWK0iiW5TELaPSixABY/S
	MrxqMO8eYjOrYC4x9+P3DDghhV0vabRBGDuZupZZyJKrnERF4iWl+ZNc3X2+mZrbXRyLGVzPNch
	weORgY1DwJlwoPXmBLKJCLLF5WXTxw9Fkj/zKo/Jq+y9MMxnRehXkGKflgavCD6onDVnokCFhwI
	LD4f3VHEJwgbbCDsxjB9qvLH1N/hlw==
X-Google-Smtp-Source: AGHT+IGq3htNAA0EkBA5+Y5S+GWVypggO99v4XIcdwKhyHKXM7AKce3ggyPxtD75f/rgwHNcQQ5MCg==
X-Received: by 2002:a05:6a00:2187:b0:730:8c9d:5842 with SMTP id d2e1a72fcca58-73bae551359mr1797432b3a.5.1744222964313;
        Wed, 09 Apr 2025 11:22:44 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:2f6b:1a9a:d8b7:a414])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d2ae5fsm1673021b3a.20.2025.04.09.11.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:22:44 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v1 bpf-next 2/5] bpf: udp: Avoid socket skips and repeats during iteration
Date: Wed,  9 Apr 2025 11:22:31 -0700
Message-ID: <20250409182237.441532-3-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409182237.441532-1-jordan@jrife.io>
References: <20250409182237.441532-1-jordan@jrife.io>
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
index 59c3281962b9..f6a579d61717 100644
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


