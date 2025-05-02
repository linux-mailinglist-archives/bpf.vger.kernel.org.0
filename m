Return-Path: <bpf+bounces-57245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76F0AA7701
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 18:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254543ABA21
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 16:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9561426560D;
	Fri,  2 May 2025 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="y1As+8mP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D125F98C
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202545; cv=none; b=u9RaNY9c+X4S066wUaN4uJXO45Nh4rS0FaC8FETW4E16QdmoX0Koh3fM/MeRpTXWhTjloCDAaOKVOYM2ajZe+e04WnYO0v6/r2tzO1dgsJ+rMTObM4Cjbpl5J/luAEr3SOdnxUyKAXaWETP3tx2Y6UQfqEpfpEPP1yIK9LNIdOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202545; c=relaxed/simple;
	bh=+280y9ND9E2CR2I/4+arX4s/g7F22tRViZCAm6v9h7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjixf97ti5DpingvaP9CmwdQcaRsaM4ZT1SuC3YhzLLZq735BONOMjv7H7HqC0C17joNkWXWVzleGz/PMO4D6MXEgDIbhFXyFpScvTK0JGgc3Llh3fg+soeZfSWkPrQNL7mr1VSOJBp2K/MdbFFSLUIqUBRQ0OY8AZI1xNXSugk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=y1As+8mP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224104a9230so3674295ad.1
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 09:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1746202542; x=1746807342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZEJHpG1VEMEXMQuSs0YhIKMl1vCl9L7SQtwCmv4JVo=;
        b=y1As+8mPKB17YkMm8vuHr2ymJ0p8sC3MblZFpSnlKPWVONFi1Ypu84I0yUR/AyPZzA
         p7bVACvrBNzcdnBpO05otnkb1OZez1v1JjB7yzDs5noXsh1xND7HwtG2OqrEV7Z4veqA
         FCbXkS5wp2oclN6GWe45SI8S0v97Rc+oiYQ8BlUA8025vMNG73bXwl12n7IsOdxVBwhU
         7W6fst+kkrTfUkNGgPPWnHov+LO3EY9gvclw4P1/J30DNEpd3//Z4tHHL06wE+BlMlT6
         gABd3ZNuzP2ckSnveYCO8tiMb5BJ2uMH+Ah04E7X06PvkMLpnIeQpUG87pUI76QOAQPS
         f0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746202542; x=1746807342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZEJHpG1VEMEXMQuSs0YhIKMl1vCl9L7SQtwCmv4JVo=;
        b=O2Wx6uTVPwxicPSmUUi/p9fNp/hbgcuJmp4620OVltyqxle9/uJ2xBW3aXz9i5jnbx
         Ua8XbT+GGJDr0LDadHuHdAaAC3qhROFQrNCCGQ9XULj55itd9bFlDtAx6gVbtxVRCNbj
         G2BOaqzhAVPbglCdqW8PluEUZCKHrdsFVm3S3W1miFkbgkDwMH6IT+JDIq3crt21riiT
         907XP3IwN6Kt/7sXPcWYzG4ammIkMlCuRHh5PEN7Uv/ZlOpwUvoF5M/yRNyrZtniWXWN
         yIQhOcC0UwH6bBNhiToa1EJvAazDUh7QNrwxSPKqQnrsKSJK5XCK2uvxLrw5dsBOKN8b
         3GZw==
X-Forwarded-Encrypted: i=1; AJvYcCXd92RfQ0Q54pUAa2N4QweIaXHleJcQjfmjB8E/B4JwvWYH64h3iLWEa7jvQinfVTfY0YY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3aOAjF0Oke6Zxip+/20iCQxkwHJBreF7WNv7Qk8T09vMgwck/
	WF/xw+a1c27hixygmbCJIe0MRx6gDINYNkxNp3dI3c5hkvT5MUBEHubyW9HDibU=
X-Gm-Gg: ASbGncsdYlwG5Nt1Y8bmTwgFUjAECa364mEiobt6sYkyy3lWgIk4KLiD3O4dNzxlged
	PG1QzIDB+In5L408lO/CusKkAh59ntM5numPj/2Bi32t1YffX7B5v8SE2Lo7gfbq7tuBs+qmNjh
	dIRlZQy74+VhtI/xQfbBr5vgcHSm+RhwQ9WJFTr1iI/xe/gwaEm0qgqSb6WEJOcHJeSdu6U77aX
	w2qPr0tebwA4CoafnEXLkYx2NdGgmGE3K2dsibcnQNgxqALLxJ2rpnKXX3JzbaMMsM0iB4dZzGa
	DaIXEd2LTyb494KutBcfD+swK5jdMQ==
X-Google-Smtp-Source: AGHT+IGHLj5ms47hnKAeJUJ2KUGP0W1Tv5fdlRpmBQ35cbEzXxiv8K2qECLCHd1DQrXuPc5rBGV+8g==
X-Received: by 2002:a17:902:d504:b0:223:659d:ac66 with SMTP id d9443c01a7336-22e103446c8mr21761315ad.12.1746202541918;
        Fri, 02 May 2025 09:15:41 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:7676:294c:90a5:2828])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e95c3sm9572135ad.68.2025.05.02.09.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 09:15:41 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 5/7] bpf: udp: Avoid socket skips and repeats during iteration
Date: Fri,  2 May 2025 09:15:24 -0700
Message-ID: <20250502161528.264630-6-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502161528.264630-1-jordan@jrife.io>
References: <20250502161528.264630-1-jordan@jrife.io>
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

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/ipv4/udp.c | 61 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 9cbd43a69509..cf6285bae4f5 100644
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
 	struct sock *sk;
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
 					iter->batch[iter->end_sk++].sk = sk;
@@ -3525,10 +3545,8 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	/* Whenever seq_next() is called, the iter->cur_sk is
 	 * done with seq_show(), so unref the iter->cur_sk.
 	 */
-	if (iter->cur_sk < iter->end_sk) {
+	if (iter->cur_sk < iter->end_sk)
 		sock_put(iter->batch[iter->cur_sk++].sk);
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
-		sock_put(iter->batch[cur_sk++].sk);
+	/* Remember the cookies of the sockets we haven't seen yet, so we can
+	 * pick up where we left off next time around.
+	 */
+	while (cur_sk < iter->end_sk) {
+		item = &iter->batch[cur_sk++];
+		cookie = sock_gen_cookie(item->sk);
+		sock_put(item->sk);
+		item->cookie = cookie;
+	}
 }
 
 static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
-- 
2.43.0


