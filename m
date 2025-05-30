Return-Path: <bpf+bounces-59382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE6CAC9719
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 23:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D378188D46A
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 21:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48430283C82;
	Fri, 30 May 2025 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="UGX3FGdS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5236027702A
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640699; cv=none; b=D1BNbDub4p9SIYOxbuQHt/9QqC2O+b6b0aKhiuH9NxoWyfAome156EfZYkKJ45GuqNk+HXC+wM7XPRDQYwCsSwFppug1diPDjrc1meNKGJDiYj8UFXTKXddp7tvP//EdilMycZ6sX59T0Q4aPITlAA4ag+jEDhiZbl+JUrMKsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640699; c=relaxed/simple;
	bh=FOcUHNTpKxanwjKC5eDfYqm4hOoO4sD1M81ThFNCU5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbV32aQ5MwzOfdxkxT1Zpwa+sZn+XjKD8PSxCPoXFO9QaWlMxlAZ1tY+SC9z4uorG/BosZPZURVtxY1ef0oHrQBIxEN4Uc6ji6T6YFoILMx8kwkww/l36nW2QpY3CebmQve9BWZynNtXsG91Lvw76glMrdcUF7mrIAVPVxOpXbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=UGX3FGdS; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b2705e3810cso272005a12.0
        for <bpf@vger.kernel.org>; Fri, 30 May 2025 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748640698; x=1749245498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAuMzqm0JIrbgbPTkm58pDclP9IWfOkAF/9DsG83V1U=;
        b=UGX3FGdSQB0ZcGIpAl6a+wQIJtFMwQYWB3GLu6jPsMyLEfiTHTwpotqmvVHG/fLUTp
         PZEwYhHyEAWC5rnGcNeX8b5yles6APPUTgya/3XWrflmUETDHqynBrF3VImO4VUfvgkM
         RkJn4BxMtOhlnn8OHNq/Y5tCKB+/xVhDcVQmRQ/EwWZVhIjwuOS7O4CJeQLA5gtDX+Yf
         CcLHfvT+iudaF0CBMijLM8wieVy5se4NGyIHK6NA9xguqALyH4yXgmqwZqWjxHs+OUS5
         USc9dR5frRvGr/rthu7tX1Nr1C/QUrNrXyNI0sZqxh3drXA+X4WSRq9ptbjba37/JQMV
         1fHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748640698; x=1749245498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAuMzqm0JIrbgbPTkm58pDclP9IWfOkAF/9DsG83V1U=;
        b=avxV/mn98jKJD0k6nb9T4g7pZvvaznuIr6iHQH02RC7wPpIIXRPcGlPV8ff3yJWywz
         uJ/fn4ufynQJ22GWfAa+hfHQCz0AUT7HlhK6SRKET4Suwce1SmOchGa6INluQruiH5dT
         i+NTfLyiFfB19zroYkaJy+5Q/AzehshaxHvktItnC31t5sSH8F/opfVJYeWfuhPIA292
         SLDPhMsohJpOGBQI+rPSwzlMv5/YAeygj4d1DQVDPQGuCk48sXVtWDTONsiqfYz4GtfS
         0ymVNBUUEtn1aRwr7fuIG71xtzjVEj9o7BL1Lrbzbq+QQ1fggAOPUI7jaN0cQ3VdOktH
         FGuw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ7NfHMdUz4SKPZ/IQR6rQul+V6q0dcD1mc7epM8e5rYkXvHrVk8FhuKuTxR1sexcX6o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznM9uF1qAtXEWUZC/mvjHdp2q538ZxcclyEII0Ws1iunhXCBLs
	OndvTsXbCkGcPiXjjP5+D6NjNAzzGLZwjfz4+OiRAv0g41hP7k5Qj8FxsFS0/0AHOIA=
X-Gm-Gg: ASbGncszDEpvdWM9MBx/R4tqpmwSQ8oZnksLqWRdWkR+pXqrOh9zQsLqdSEszN163ru
	YBP0BIwkKsN7n7mXfcv9b/v4AVZ5Yc4hrJCQKeZVTILR+xZaL926TVzXlICElY1BpY80+wrzCgj
	7DsAPunFd8xP/qeVE71IqA63UuAY0AgbgzdQIZ1yVFx+9k6RvduuHRuGzVYgUCLWmzzSYhXfyTn
	77UOGuhVb8QVHpckuLS5pNki4FFFpLZTnNeHV1NrFyv0laJgBAzo/XJixDw02AaNVTlSU2rIGoG
	X9EwbyfVVC//0LFQnja9L8leebU6ywlVCh1keWM3dNDSrRCfbXs=
X-Google-Smtp-Source: AGHT+IGshsPyEOoWsXyOdXlzAJMIQj+RTcFf8IsiQ9hJ8hrwBshnt9FodASwItJPDM5O3eiKgMemKg==
X-Received: by 2002:a05:6a00:1815:b0:742:938a:3eca with SMTP id d2e1a72fcca58-747bda0937cmr2671386b3a.3.1748640697646;
        Fri, 30 May 2025 14:31:37 -0700 (PDT)
Received: from t14.. ([2607:fb91:20c7:44b2:2a24:2057:271e:f269])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed4399sm3496763b3a.77.2025.05.30.14.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 14:31:37 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 bpf-next 05/12] bpf: tcp: Avoid socket skips and repeats during iteration
Date: Fri, 30 May 2025 14:30:47 -0700
Message-ID: <20250530213059.3156216-6-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530213059.3156216-1-jordan@jrife.io>
References: <20250530213059.3156216-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the offset-based approach for tracking progress through a bucket
in the TCP table with one based on socket cookies. Remember the cookies
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
 net/ipv4/tcp_ipv4.c | 142 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 114 insertions(+), 28 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c51ac10fc351..f32adf0b7cf5 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -58,6 +58,7 @@
 #include <linux/times.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/sock_diag.h>
 
 #include <net/net_namespace.h>
 #include <net/icmp.h>
@@ -3016,6 +3017,7 @@ static int tcp4_seq_show(struct seq_file *seq, void *v)
 #ifdef CONFIG_BPF_SYSCALL
 union bpf_tcp_iter_batch_item {
 	struct sock *sk;
+	__u64 cookie;
 };
 
 struct bpf_tcp_iter_state {
@@ -3046,10 +3048,19 @@ static int tcp_prog_seq_show(struct bpf_prog *prog, struct bpf_iter_meta *meta,
 
 static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
 {
+	union bpf_tcp_iter_batch_item *item;
 	unsigned int cur_sk = iter->cur_sk;
+	__u64 cookie;
 
-	while (cur_sk < iter->end_sk)
-		sock_gen_put(iter->batch[cur_sk++].sk);
+	/* Remember the cookies of the sockets we haven't seen yet, so we can
+	 * pick up where we left off next time around.
+	 */
+	while (cur_sk < iter->end_sk) {
+		item = &iter->batch[cur_sk++];
+		cookie = sock_gen_cookie(item->sk);
+		sock_gen_put(item->sk);
+		item->cookie = cookie;
+	}
 }
 
 static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
@@ -3073,6 +3084,106 @@ static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
 	return 0;
 }
 
+static struct sock *bpf_iter_tcp_resume_bucket(struct sock *first_sk,
+					       union bpf_tcp_iter_batch_item *cookies,
+					       int n_cookies)
+{
+	struct hlist_nulls_node *node;
+	struct sock *sk;
+	int i;
+
+	for (i = 0; i < n_cookies; i++) {
+		sk = first_sk;
+		sk_nulls_for_each_from(sk, node) {
+			if (cookies[i].cookie == atomic64_read(&sk->sk_cookie))
+				return sk;
+		}
+	}
+
+	return NULL;
+}
+
+static struct sock *bpf_iter_tcp_resume_listening(struct seq_file *seq)
+{
+	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+	unsigned int find_cookie = iter->cur_sk;
+	unsigned int end_cookie = iter->end_sk;
+	int resume_bucket = st->bucket;
+	struct sock *sk;
+
+	if (end_cookie && find_cookie == end_cookie)
+		++st->bucket;
+
+	sk = listening_get_first(seq);
+	iter->cur_sk = 0;
+	iter->end_sk = 0;
+
+	if (sk && st->bucket == resume_bucket && end_cookie) {
+		sk = bpf_iter_tcp_resume_bucket(sk, &iter->batch[find_cookie],
+						end_cookie - find_cookie);
+		if (!sk) {
+			spin_unlock(&hinfo->lhash2[st->bucket].lock);
+			++st->bucket;
+			sk = listening_get_first(seq);
+		}
+	}
+
+	return sk;
+}
+
+static struct sock *bpf_iter_tcp_resume_established(struct seq_file *seq)
+{
+	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+	unsigned int find_cookie = iter->cur_sk;
+	unsigned int end_cookie = iter->end_sk;
+	int resume_bucket = st->bucket;
+	struct sock *sk;
+
+	if (end_cookie && find_cookie == end_cookie)
+		++st->bucket;
+
+	sk = established_get_first(seq);
+	iter->cur_sk = 0;
+	iter->end_sk = 0;
+
+	if (sk && st->bucket == resume_bucket && end_cookie) {
+		sk = bpf_iter_tcp_resume_bucket(sk, &iter->batch[find_cookie],
+						end_cookie - find_cookie);
+		if (!sk) {
+			spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
+			++st->bucket;
+			sk = established_get_first(seq);
+		}
+	}
+
+	return sk;
+}
+
+static struct sock *bpf_iter_tcp_resume(struct seq_file *seq)
+{
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+	struct sock *sk = NULL;
+
+	switch (st->state) {
+	case TCP_SEQ_STATE_LISTENING:
+		sk = bpf_iter_tcp_resume_listening(seq);
+		if (sk)
+			break;
+		st->bucket = 0;
+		st->state = TCP_SEQ_STATE_ESTABLISHED;
+		fallthrough;
+	case TCP_SEQ_STATE_ESTABLISHED:
+		sk = bpf_iter_tcp_resume_established(seq);
+	}
+
+	return sk;
+}
+
 static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
 						 struct sock **start_sk)
 {
@@ -3145,7 +3256,6 @@ static void bpf_iter_tcp_unlock_bucket(struct seq_file *seq)
 
 static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 {
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
 	struct bpf_tcp_iter_state *iter = seq->private;
 	struct tcp_iter_state *st = &iter->state;
 	int prev_bucket, prev_state;
@@ -3154,29 +3264,10 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	struct sock *sk;
 	int err;
 
-	/* The st->bucket is done.  Directly advance to the next
-	 * bucket instead of having the tcp_seek_last_pos() to skip
-	 * one by one in the current bucket and eventually find out
-	 * it has to advance to the next bucket.
-	 */
-	if (iter->end_sk && iter->cur_sk == iter->end_sk) {
-		st->offset = 0;
-		st->bucket++;
-		if (st->state == TCP_SEQ_STATE_LISTENING &&
-		    st->bucket > hinfo->lhash2_mask) {
-			st->state = TCP_SEQ_STATE_ESTABLISHED;
-			st->bucket = 0;
-		}
-	}
-
 again:
-	/* Get a new batch */
-	iter->cur_sk = 0;
-	iter->end_sk = 0;
-
 	prev_bucket = st->bucket;
 	prev_state = st->state;
-	sk = tcp_seek_last_pos(seq);
+	sk = bpf_iter_tcp_resume(seq);
 	if (!sk)
 		return NULL; /* Done */
 	if (st->bucket != prev_bucket || st->state != prev_state)
@@ -3245,11 +3336,6 @@ static void *bpf_iter_tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		 * meta.seq_num is used instead.
 		 */
 		st->num++;
-		/* Move st->offset to the next sk in the bucket such that
-		 * the future start() will resume at st->offset in
-		 * st->bucket.  See tcp_seek_last_pos().
-		 */
-		st->offset++;
 		sock_gen_put(iter->batch[iter->cur_sk++].sk);
 	}
 
-- 
2.43.0


