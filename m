Return-Path: <bpf+bounces-62853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CAFAFF52F
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 01:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721D01C44582
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 23:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E621A24E4AF;
	Wed,  9 Jul 2025 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Md9jlAKt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81212472AE
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102227; cv=none; b=Vpa6YE1+wszMCmZPgJxwFxewekwiIZp3X5H5EPrMJmNpL2VBU7eH+ATCXqQMbY5Zg1kJcJpowq2dwDP0cA37S4j+LAQXlEY6zddQrXU6MysqYSFrncujgh3sxhg6VynicYUqack3KBbnsxBaWowehQjlR1+4e2Qf//wB26e4mlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102227; c=relaxed/simple;
	bh=sYWOZm0Nj5UMgVSXgPrhl24dBpDGgP/k5g9bt0RwTvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ij//Yx0ccyvUJXJyVZGvcz921ruUKsTm4+iWr8qmldPDGojfjr1CQvDqYDqeTB7TsPe+yglQbqVfhgwCkW2jDwejb+Lt4YZyY+l0RZiS5dSCbsM6pCwOqaNRueIymKkgtJfgn6CTeltsS09D1fTHme+r2Tp5cKrqTKfdKuDbgec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Md9jlAKt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2352b04c7c1so631335ad.3
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 16:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752102224; x=1752707024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pm7urr0OP6gNh2yXnRhBw1Qil6TmuRhdcNIhBL7LwuI=;
        b=Md9jlAKtf9EiWXrg8wsC255zncXR7AmBlgDqZShTq61L2eTCw0AOFLuEvmaPIpqa8l
         ul0ebbCtEowsKeJIX2SR8AtZoNUGELquk19LgJFmYSURvpd9un6wPPTtHVH8Sf0bLkyE
         tcuHdwTgopsuTtsQXqp4WisY7dqW6lbpZeGelaq5QS9jyIg8cGxqJVmu41Yk9VEYXaqm
         Jke4kc7GS6OGlQikcws0ctWJc9egJouZjdTGcpxUeQ0L+6WbuRW9mwZBsDVhh4n/6Uad
         c+vuzLxfRrLPMka9OPN1Kx19lLnWNoACODsOx0HNMdyt8/Os41Qw76NdkZT8JvgYNpVi
         hoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102224; x=1752707024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pm7urr0OP6gNh2yXnRhBw1Qil6TmuRhdcNIhBL7LwuI=;
        b=al0mldtJlSmkRsq1txt4v6GGCGBR9Ug9YMIxq4Q6vDcoPXe7v5ZawDHiMIajfyqhMp
         us4kwt2+t3CfHZ378NrhVsc2/GzVWKwT1+knQTuI+fMeIHHWWSsPGVmLCBmthPlpdMiY
         PO+146wBxR4MzqokGyrE4fKXa/OseamUmHNrfIkhAirF4lLo2wTO9QzFZVB9DZkRx8lj
         1qK0ld2om375Q0YQvw3d9pqBtArZb/DFvrawrYDBkHgdR4TQ9HWlUxl88sB8cIL4TjNm
         B/b2tpBALtJLj+u7r3JwUeIVARs+qkKRJTqBJNfIhWID1UmaGYhq2/AlUFXBheTI3GQV
         BYZg==
X-Forwarded-Encrypted: i=1; AJvYcCXibhbm68Qfq+jzRhj70LB3XSP4HM23nG6RC0TlvSUTKk7OzjkmirUdI+/A/1CR62fUBpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0oQ8bi7PhX0qIIOcNu46lj3KgRWSphIEjcviIZ8YZ4Nn8VYo5
	iuLUPWYc+ZYQSpF1tVfh8S+r6RL8pHUIB/HxlVzYztBeeKsrqVGa5smMPcLi1pRM8aA=
X-Gm-Gg: ASbGncsOYDhu4t5P1Rl4YhsECndWFjwg8SsgBMmZKni2wcT1744EOrUSSMhtEDc6tUY
	RIMKMUP1+f6YE7C/6Uqwg9F2iI6baWGkoZx+odxNblYvCIg6KoRecjLhQOSqa+bu/cvnmg8ERwe
	hxTQaOd0ABEYcIkMV3di8DL59O0BPUoZHGV+2mcDx9yQmxUewPESTJD9gZ6OVdMqwTPCDQfcH23
	mwK/GqFdKH+S8+omOS7KyKtoY0dj64jHZXie9rs7mTWgP2qZw8eGjMGAEhiD3Wk2UAQpHIRmQb0
	hpLapSbLPQhGN1CN3yeqf+E/xfASmEkNdOloD8+tn013AUDdmcQ=
X-Google-Smtp-Source: AGHT+IFYT4CjwOinJrKK56VNjt0+l7az9KvEHiC8H0ICOMPzEKl3DIj+nyx85/zhzq8Ozmgq4uvB7w==
X-Received: by 2002:a17:903:22d2:b0:235:737:7bf with SMTP id d9443c01a7336-23ddb1992d7mr25843975ad.3.1752102224020;
        Wed, 09 Jul 2025 16:03:44 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad212sm2679015ad.80.2025.07.09.16.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 16:03:43 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 05/12] bpf: tcp: Avoid socket skips and repeats during iteration
Date: Wed,  9 Jul 2025 16:03:25 -0700
Message-ID: <20250709230333.926222-6-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709230333.926222-1-jordan@jrife.io>
References: <20250709230333.926222-1-jordan@jrife.io>
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
index d2128a2b33bc..48c0ad77cc0f 100644
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
+		sk_nulls_for_each_from(sk, node)
+			if (cookies[i].cookie == atomic64_read(&sk->sk_cookie))
+				return sk;
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
+		break;
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


