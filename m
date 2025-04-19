Return-Path: <bpf+bounces-56279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3861A94451
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 17:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21F5189EB35
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 15:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC021E0DFE;
	Sat, 19 Apr 2025 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="eDhKN8te"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCAB1DF73C
	for <bpf@vger.kernel.org>; Sat, 19 Apr 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745078294; cv=none; b=PKVwQfHWJ9ollM0PKeEiXACcw/lnhZPDICSAgeLOWm1MCAoLWKNe5/qR2ijxwevL/dehEESge7THqaRdDK791ALnAxalliHTDKwkVtlWr9mQUUjL4BFdzXyjIjQRVk3jl0MJmG3rUGIZXmh8WeBHwX0ARFvfreh1v0BVixWXijM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745078294; c=relaxed/simple;
	bh=wRxeAltoZzfEN6xOTYcrjYnKQrVosbflDTlg9dI9CuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5YAolDqsX7zE3vk2cPRtMSNA45Z/jmhgKSgVE/eOYi09pW2K3i/iIWnj10b1KrBlm3aKFwL4VuFcnHQjDIM1zh4/QphjtwqgO93mglzoczePVtT9Bs1HdNbsv1BwwmAMgvIWUJFTySi+S1H1Tf2tgvra6GW+/QBm6zXrWrPl1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=eDhKN8te; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73de145c639so2099b3a.1
        for <bpf@vger.kernel.org>; Sat, 19 Apr 2025 08:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745078292; x=1745683092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJz/DKd+SyfwJrSN217KEOOrpQawXIPq6hbCTcWU3lE=;
        b=eDhKN8teMm4WLGb6wEP3A3/DFi/HvyFUN6LWN+9l8bDD3yO1N9LOYhsOJYPjfEx/2y
         9G6qR1BnAyuFCvWu/U63QS2VPETD3j2lhIS8dfSCRpcWYKEu9ZQtLVMOG8dDDj5DYEwq
         hN60mEzIqz3cAl0EN47haTHeX0Ma2v8SwwY4uSYIb0Xjb+ikzVp6hfaBtOLUUZFVJ/ie
         TA2YQZWqmqfgvXxY5UftmnNj+mshCnhRhrTEFRA18eTZAD+eyddT6lYk4s1Qd80mnQDf
         mB+LSC765aGUtVV+Lgx5oqJxTVPYMR+6XytoX93LhASJUjDn8cyNYxaFz3vIhaW6Hzw2
         BMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745078292; x=1745683092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJz/DKd+SyfwJrSN217KEOOrpQawXIPq6hbCTcWU3lE=;
        b=ULipbwaMfGKLP0kzxeim2aOWlr6IzD7GS1OrC4FHeJQTm+LJQbcQFB376I/sLx7EAg
         oJPRQ84oB5L5gf3ETk+7pfFQ+Jj8uE0JRBcBsj85xphtiTrUablg5kXUI8FrJ9Liz2cx
         Gn7UcKFEfN37PzDNwjQ0+I4tZslQUVeos46ceUUvK0gbRamGqx4lz6PIXvgr6atUtMzQ
         VT0rmT2H9RkrijvvayoiIZTzUCmuFUfiqg4RZ7flCF17H8YyZtPoazL+yr/W8BvIy0XG
         VoLiD7BlwXJ11W55jvJQs4ar+hPrsP8rydl7upR5p8Ts2RlGE+dDc/1QEHKifTtpcAwV
         U3yw==
X-Forwarded-Encrypted: i=1; AJvYcCVDdzbrsOhDSE4dnxN8WmVfKaTMui5/1ZMh1yVP7P64R7dC/lpDC0y7LB4fDiGHVKYXl4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywckp9obd08LxfaR3kWcERaNzMmPSYOTO5XSuS6GyuSkLfeLSM3
	nFhQXKIxfsdSYdG4GmfhwpepWiaYfrL9lgCTt+ow9213Ms6as2u9WK6D9Kl2a58=
X-Gm-Gg: ASbGncs8GgFCePhOkI+6c20ObJjU9rwAQeYC/aTOj6Jp5tLn0zvqil4nXbfa0UKy4IR
	YWqNdswG7VqwfdO4FqiBvl0Uc+MuEiqKjyhjfR5qaEXq9DUFNzAFqAPeqjROlMKMs/ZwgfX/Dk9
	0sDMoYIVlHucVUmsJvEa9StLMVy9/umUD/RbF6Z3JtXt2iTYOJpERkMmm1Y2Q2R+Tc6z6qHfNIz
	5v/P07YgnWHUZ2driNRWd+H/MOEActL+kg5jSBwWxojTUn85Uns80Y8uqh+MhBtlRm8csB6NDiy
	BcUVZ9i7yVR0G4wOUou6LhOy3am29w==
X-Google-Smtp-Source: AGHT+IEpXoH4m6ZY7mfRwZUxap2KHQQVIMA9kzePqu3uqomtmo5c7vtiKDri2mZHerNe+707od48LQ==
X-Received: by 2002:a05:6a00:1312:b0:739:b1df:2bf1 with SMTP id d2e1a72fcca58-73dc15d3551mr2826023b3a.5.1745078292012;
        Sat, 19 Apr 2025 08:58:12 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:1195:fa96:2874:6b2c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8be876sm3464157b3a.36.2025.04.19.08.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 08:58:11 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v4 bpf-next 4/6] bpf: udp: Avoid socket skips and repeats during iteration
Date: Sat, 19 Apr 2025 08:58:01 -0700
Message-ID: <20250419155804.2337261-5-jordan@jrife.io>
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
index 261dd7f508dd..701f99e30244 100644
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
@@ -3387,6 +3388,7 @@ struct bpf_iter__udp {
 
 union bpf_udp_iter_batch_item {
 	struct sock *sock;
+	__u64 cookie;
 };
 
 struct bpf_udp_iter_state {
@@ -3394,28 +3396,44 @@ struct bpf_udp_iter_state {
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
 	int resizes = MAX_REALLOC_ATTEMPTS;
-	int resume_bucket, resume_offset;
 	struct udp_table *udptable;
 	unsigned int batch_sks = 0;
 	spinlock_t *lock = NULL;
+	int resume_bucket;
 	struct sock *sk;
 	int err = 0;
 
 	resume_bucket = state->bucket;
-	resume_offset = iter->offset;
 
 	/* The current batch is done, so advance the bucket. */
 	if (iter->st_bucket_done)
@@ -3431,6 +3449,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	 * before releasing the bucket lock. This allows BPF programs that are
 	 * called in seq_show to acquire the bucket lock if needed.
 	 */
+	find_cookie = iter->cur_sk;
+	end_cookie = iter->end_sk;
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
 	iter->st_bucket_done = false;
@@ -3442,21 +3462,29 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		if (hlist_empty(&hslot2->head))
 			goto next_bucket;
 
-		iter->offset = 0;
 		if (!lock) {
 			lock = &hslot2->lock;
 			spin_lock_bh(lock);
 		}
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
@@ -3528,10 +3556,8 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
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
@@ -3601,8 +3627,19 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
 
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
@@ -3873,6 +3910,10 @@ static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
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


