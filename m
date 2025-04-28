Return-Path: <bpf+bounces-56858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9232A9F7E3
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 20:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3ABE1778E9
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 18:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAAB296D25;
	Mon, 28 Apr 2025 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="yw0DzEPN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0E2296D05
	for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863257; cv=none; b=lW8JYoN8IrYraJxaXlagg0sa9/iL3rCENcwcmldu0YApibqomQzgZFqVkES9jP81tCMAE3qmesEiJf7HAjh6CwPbWckd15KpTCclub2gbG8R8CoE7t7+u4BcnxMNaU46G2ZXTngAAtAHLqGATiYwrhueXi6YCKUlPQNgqTOTkFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863257; c=relaxed/simple;
	bh=fSsOGbki3CVx5J1cHe8qATiJPybBhmfhAbbK39GNp70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyyOCRrFHdAgor+DVbHpWyknt9u7ZNYDj5qGtIlVe5u7EGBrE3+2lsDMKiN71L95my79ccxdsFQi6o7qkwOk73LaKsLa9PlmtOY/CNZ2tMdSA2PJM7YAL+USGqkW/+omv134PmQHiyxdK6I3IX4ggstwnq0zPEE0afRSc2EK0VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=yw0DzEPN; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2240d930f13so11235795ad.3
        for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 11:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745863254; x=1746468054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pIQxidNRxxC+rqxDLfPw8KhfiE0oT6/ueoXyw5JGNk=;
        b=yw0DzEPNJZOm6rxnPUyNWO8c1dKSJZurFsjPVcKcMNyR/07+9EapMEKswhYRfd7zo/
         u3vfQmOIBrab6zVYOB7qdH1WSwLNfb9rPG/2fPqQ7vcep/MvbwEkBAAdqBUeBCqAV4sB
         OpCAuYwZKBL+T3oaM6zYvzph7eTH3WYQnOJ63IxmXkkZAEtjtPN0ecb9Q/d52/fgB2DH
         wDqZUgj8C8GtT9NgvJkmgMEbPzJNUFu/+YHKxXdELz4yYNvNSxsU76xB0cXD5MF4ZD7F
         CRoqF39gA2XdKHDlqxfRz7HhZ3TpXQca4IZb5Cs8rC+iTV9CuTrTMHJrTpu+ycaXhXwP
         MKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745863254; x=1746468054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pIQxidNRxxC+rqxDLfPw8KhfiE0oT6/ueoXyw5JGNk=;
        b=H2udGMhlZpbzemhvdCGN4ebr1fA64QDAPBqEzgV/FtmAUuLcU5U4Gdy68PkjbGdTkO
         3Yn9fZZAeTlNYuGkzZuJEM+xoAi5v2pen9WNDeWZKGrBQJNnbQiMB707hiTupxEgas+a
         2So1orzNMeFwwnwNgRGlGTW2Iil/9zQYboj7WRHRufIxhJP0qtQhhJX1N49gBE1Ippt9
         ilZ5F3cpIRbzRawttgo3+F4NiWV0ykKQRtR91RRHX1EQaW07BxDEbVn/y2VWObj55y2c
         aFWnSLFE61AuBwrmwj0Q9e/CUD9/41IrnqrAJcOZdVh8rMsEz3kD7YXZgoceV3LTyDcn
         pUJA==
X-Forwarded-Encrypted: i=1; AJvYcCXrPNhEvKq5uc54En4f3SHHcpX4p91KdploxXhfEo1upDdSkRJs9EGH6BEA3QiG4C6S1tI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd8Pqd8gWWH2fzkHNPS2PcKCRvF/RCffb+MnQSn/dmJO6lONFJ
	zXI+ogm4GzMxvSsEIkXPNdf7lXnVhINxqRrq81sT7nED6j9zzD8rmyLKxKbyGxU=
X-Gm-Gg: ASbGncsvOh8ZKvLZQsW37id0klb25VjMChfPGU46Scrr0m03koZTPWei6ayhXORuPDg
	mAAcM11/OuIHsuMVB9T1X0+P7yzMCL+gCHHdZKpCI74vsRHypjmobJd6QEoO7g8168TdNmTIdGJ
	ZHldNbnJYXswHp1GeQPMzrdxP7hP/4tliKNAAmu8oM5k+ro7G1nQs7tvzpV7Ml1CAzBEhNMLAMi
	xWsX3jWSILQHhQhS5WPYoB719s7dWWjZDiAfNFA3+YuUp74ePtkmTwn6MdPt6b3/2CKCgcesyPb
	KMACjC/QOIPjvaUpRPC1H9jC4A==
X-Google-Smtp-Source: AGHT+IFpR7XUKJU+YzeVEZCVWxYnC1kGGTO9qZ4/6ijp4nGBG5eCzNulrIbVYR6Idkw69yrlz37Sxg==
X-Received: by 2002:a17:902:f649:b0:223:49ce:67a2 with SMTP id d9443c01a7336-22de6ee2a81mr91365ad.9.1745863253984;
        Mon, 28 Apr 2025 11:00:53 -0700 (PDT)
Received: from t14.. ([104.133.9.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52214ebsm86204235ad.246.2025.04.28.11.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 11:00:53 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 5/7] bpf: udp: Avoid socket skips and repeats during iteration
Date: Mon, 28 Apr 2025 11:00:29 -0700
Message-ID: <20250428180036.369192-6-jordan@jrife.io>
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

Replace the offset-based approach for tracking progress through a bucket
in the UDP table with one based on socket cookies. Remember the cookies
of unprocessed sockets from the last batch and use this list to
pick up where we left off or, in the case that the next socket
disappears between reads, find the first socket after that point that
still exists in the bucket and resume from there.

This approach guarantees that all sockets that existed when iteration
began and continue to exist throughout will be visited exactly once.
Sockets that are added to the table during iteration may or may not be
seen, but if they are they will be seen exactly once.

Initialize iter->state.bucket to -1 to ensure that on the first call to
bpf_iter_udp_batch, the resume_bucket case is not hit. It's not strictly
accurate that we are resuming from bucket zero when we create the first
batch, and this avoids adding special case logic for just that bucket.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/ipv4/udp.c | 63 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 866ad29e15bb..4e2aa9b9e52d 100644
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
@@ -3392,6 +3393,7 @@ struct bpf_iter__udp {
 
 union bpf_udp_iter_batch_item {
 	struct sock *sock;
+	__u64 cookie;
 };
 
 struct bpf_udp_iter_state {
@@ -3399,26 +3401,42 @@ struct bpf_udp_iter_state {
 	unsigned int cur_sk;
 	unsigned int end_sk;
 	unsigned int max_sk;
-	int offset;
 	union bpf_udp_iter_batch_item *batch;
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
 	int resizes = 0;
 	struct sock *sk;
 	int err = 0;
 
 	resume_bucket = state->bucket;
-	resume_offset = iter->offset;
 
 	/* The current batch is done, so advance the bucket. */
 	if (iter->cur_sk == iter->end_sk)
@@ -3434,6 +3452,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	 * before releasing the bucket lock. This allows BPF programs that are
 	 * called in seq_show to acquire the bucket lock if needed.
 	 */
+	find_cookie = iter->cur_sk;
+	end_cookie = iter->end_sk;
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
 	batch_sks = 0;
@@ -3444,21 +3464,21 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
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
+		 */
+		if (state->bucket == resume_bucket)
+			sk = bpf_iter_udp_resume(sk, &iter->batch[find_cookie],
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
@@ -3525,10 +3545,8 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
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
@@ -3598,10 +3616,19 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
 
 static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
 {
+	union bpf_udp_iter_batch_item *item;
 	unsigned int cur_sk = iter->cur_sk;
+	__u64 cookie;
 
-	while (iter->cur_sk < iter->end_sk)
-		sock_put(iter->batch[cur_sk++].sock);
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
@@ -3895,6 +3922,8 @@ static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
 	if (ret)
 		bpf_iter_fini_seq_net(priv_data);
 
+	iter->state.bucket = -1;
+
 	return ret;
 }
 
-- 
2.43.0


