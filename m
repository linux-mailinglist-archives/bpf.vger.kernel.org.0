Return-Path: <bpf+bounces-61866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C12B2AEE580
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 19:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36171189F5B8
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 17:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5CD299922;
	Mon, 30 Jun 2025 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="vILY2IjH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE52980A3
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303855; cv=none; b=F+jfKxZkTvn4lYhxbaQYVwxAt/FOoiQpHOR7Q1Y9wMA9xzJ0Gzef7xVXhf9Alfgh76DSC8TaNdSrlaGnkyN3xv29jmHT+nB4bOTNai/av9yzrDlKUrAZ3UpCXul8n7tJdF3morwkYlYoOTfvK1fd1hPTJ/2kLHkcHhbDJBGbA9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303855; c=relaxed/simple;
	bh=KjkulpfRgwCQa5gUm4oIB2APMH1lL+8F7zcN7H97jvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLPE7jLwzC9wl8T+pwCw9dJwDOqbfexFtN0dafvPrBsopNp3FSlFN/YicT2oR+C4+Gl48GXQecLuqVL8rEGR5vmpnMUTCGcGmaQfLVPsXHQJmkmt8vHeUcOjyVlo28u4v1XcHhobtCb7irl8VFxHIrBGzFYXinMAPQS7zoA7Y6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=vILY2IjH; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b31c9132688so589040a12.1
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 10:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751303853; x=1751908653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jxq8g2AG0XtmP9xE2u9NV4N0bOP3D5JmIz+kjdGhtnE=;
        b=vILY2IjH3o76+a5yZkzIO0KxLifTKJQj0VN0LkXzT53s1sqy8uvcYwSZNVvD0A9j7t
         CkyYWdHNuV2njugfpZBfbvkZZy7T+lOFZ9XB+IUfPVPe2D5YN4mmfR3axFz5VbymorF1
         CEX052oTzQnSkPlQsETrZ9S1n7huhz132Ra8dOa2D/ifcOnK/YWQ1Zewzb26vipMcsMk
         BCKqyWbHrq9mTbrWhGiga9PBMQwOpjHOayAbvt39hnxry8cY0k4fw2v7TQfC9Qo1wjAs
         OysKxS3NZ4fQRcqCLH73b2ojYp8xTVZ/V5J4NjFHRQr/EiiFtZCGFyn4J4g7qVN6hxnj
         pb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303853; x=1751908653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jxq8g2AG0XtmP9xE2u9NV4N0bOP3D5JmIz+kjdGhtnE=;
        b=UvM+J2HgrvMEGP3BFgt6k2sptw0AVrB5rxSnyXloEYswsHamlx2w+bWtYa14gsaWoP
         SK+xZdnHe8vT8Xa7/JF4vvpjAZEdzKW47YbpiKwKWYjut+Q5fz9JiHohtlnhZLapqB8H
         oEuPoJDAnkPuo2c8mLLvdTAI/LM2grC2a54sMsvXu6CfJhabWePG29i2R148AQCBfUQK
         2xzL7p7awr2ZN3yROQ0dQ33Onw+JIksd97QIbZXy/iXvuImb0yW1YVIYe7JlHf3Btpln
         Q9Y6Pzoy+UTFHeGpCntbRp6t+qpgjUvVpvBvNe4fQDLK7FCH3sg4OoWSmK3e6OAlP7eB
         KGdA==
X-Forwarded-Encrypted: i=1; AJvYcCUTLcH5ZlUUZv+LM0fx5ZKy/xVc/HbTvUMLZhXDvHRf09kwYO9HorvCqIN671SLXtLF/OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBizDVLKKjVHcvxj6gMZis+wEPlA3vW6C4057qKicfHA8xVJ4l
	gjtiOwQtOTfyrs+SocAio4JvhwHwTDnNJH2dZomTA2hFNasSdBinacyhf1eF4WeKeY96BtA6YwN
	PoVsBTjU=
X-Gm-Gg: ASbGncvnhSdbiPBBIeoDUN6aj/0vSapdeavVOyLUxLTPSUu/3db36MvIVdICRLRJm43
	c4lZSnU5bCAKsAaxVA4JgCscpk4YWX0TP+bPukN+vqbDOvQXwB2kcO+Xhs6/UpVVor1I+2EmbBZ
	od5+dr7WBGpftCSQnBZ8hyYNgVxuILx/ap41JZ/i3pK1h/lAjTVLqp9oTW8RbApWh0g893jTBgP
	h4BxA5hpRmwYJLZC+sP4FYJOiO0zbWjutNPO05UJHEIlq4kYevMsRP4HaXl3AlBsS13Yn6Ulm8w
	9e5oMnwZKS6hO2uAxmHnUuAfojfvI6TKHMYs+kzThG+lpwcakA==
X-Google-Smtp-Source: AGHT+IE91c5MR7gfel5lRqPixNTk1xmitKI1p4UMpUQfoAeKjm0wbSbcB3Vwmx9bzGi2rxorpjaCFg==
X-Received: by 2002:a05:6a00:140d:b0:747:ae55:12e with SMTP id d2e1a72fcca58-74b0a4f7149mr5418919b3a.1.1751303852733;
        Mon, 30 Jun 2025 10:17:32 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:9ab8:319d:a54b:9f64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a846sm9229232b3a.31.2025.06.30.10.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:17:32 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v3 bpf-next 05/12] bpf: tcp: Avoid socket skips and repeats during iteration
Date: Mon, 30 Jun 2025 10:16:58 -0700
Message-ID: <20250630171709.113813-6-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630171709.113813-1-jordan@jrife.io>
References: <20250630171709.113813-1-jordan@jrife.io>
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
 net/ipv4/tcp_ipv4.c | 147 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 115 insertions(+), 32 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index bb51d62066a4..510053836a3c 100644
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
@@ -3070,6 +3081,106 @@ static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
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
@@ -3154,32 +3265,12 @@ static void bpf_iter_tcp_unlock_bucket(struct seq_file *seq)
 
 static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 {
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
 	struct bpf_tcp_iter_state *iter = seq->private;
-	struct tcp_iter_state *st = &iter->state;
 	unsigned int expected;
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
-	iter->cur_sk = 0;
-	iter->end_sk = 0;
-
-	sk = tcp_seek_last_pos(seq);
+	sk = bpf_iter_tcp_resume(seq);
 	if (!sk)
 		return NULL; /* Done */
 
@@ -3195,10 +3286,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	if (err)
 		return ERR_PTR(err);
 
-	iter->cur_sk = 0;
-	iter->end_sk = 0;
-
-	sk = tcp_seek_last_pos(seq);
+	sk = bpf_iter_tcp_resume(seq);
 	if (!sk)
 		return NULL; /* Done */
 
@@ -3250,11 +3338,6 @@ static void *bpf_iter_tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
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


