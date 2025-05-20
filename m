Return-Path: <bpf+bounces-58570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87252ABDDCC
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 16:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BF53BADA8
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66D524EA8E;
	Tue, 20 May 2025 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="sooNYNY2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB0D24CEFD
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752682; cv=none; b=MjKdARwD44+as4obgYceY/kwciCB8rQQdRJJ9h2Mcgc0Di8DB8TMwoMHcjK3mx+qEQ+Iw6I0vGXgyDQh52biMaSK5SXOH+2lP/WJKlzuZa2LjNOnue2sLRpwpMjGeJtpuxDOGJMiW9lxjEO9buVcEWHf33eSpxh0dZOysXFesm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752682; c=relaxed/simple;
	bh=WIy1K5Zi3cbfRnGHKADBXTpyqPYOsXOffcZapjAOWm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0Nqwplnk9t3EIWw32ZxCcrSeNYZ9RQNGK5sX8DVeWOYJrBkNZKCB7y+RXWh5FT6nNBHW6sd8BjMTvX/wtucr/aPLkzI7Ky/Wclci4mHsEiU3rcab3YI45IzH7bTiuyKst3xqFpzu7fJ3ao57r0Jt44hW5M6GgSr2sYqqJ0pFjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=sooNYNY2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-742a018da9cso767692b3a.1
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747752679; x=1748357479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eg6AdZOsXkhsKOkMLR1fCGcx34uMYpSLdofTpoEeoAE=;
        b=sooNYNY2YAUd6sajSJwT0fFcFGzoPtLe7Jp1x9zZbDPueBFUFXXeG44FYJ3Xpqq35H
         9wx23g7kNN21TkHJzWy/CqyHNjdIB4qd03ZrQ9Pif/DPY2T47UWwxU3DYe6XCJiuDsSC
         Ak9kxQUGbLyY3gOg2RpPEk58nZS5v8HGdkbBloAtJfQZhk6Bzdb7y77DUp8btFGIl11R
         n9y6abCWaJMu+sP9Pld/8ItcIsXqBxlbmWKm1MoYbteDOjo6hLzp3LOU5vOAQSr43Oga
         64EoeGV2xZin7M93AloFrfOf/fZMs+ys0LJCbs3NdB7V43r7YM8bKrLGBlO8qowbTTm1
         /WoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752679; x=1748357479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eg6AdZOsXkhsKOkMLR1fCGcx34uMYpSLdofTpoEeoAE=;
        b=q4PYz/4lG16XW8OGZh4TksSp00Cy658eh8WoxTRq9a7NWvPdA74A5Dmp4yLrffWRSD
         SpQ7q++i/Ypi945ZRzN3OoNn50ss3Mt3ZE4//6MrPz1OinK/Tzvm/zp9JA1XuArbz14u
         8PdwyWcZBpAMy1SqNI5V6GnqI9ExxwHVfxBKGWvVKfNYw164w8Lu/nBBwgWZYxc+VpRd
         8s7a2NI/ZPXaOHPcWbmSQc6uS3vCfqw9QRxUpsMlC1clOhV+DQalvwv3HGRQ8UM9mf4p
         OP/ijvHN2UEQVV9jKGSnFWYnvuTp5K8TO7UIYj4fO817CqtB+nNkk+rOxZlW+shtKnAQ
         K5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUm2h6WCFuN/QL3tm99SncC7LEPo3IA4qMSIld3GEn1w8s6Rc0ERiEAlgDx2jPN4869jrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaTwKB0iKOcNbee2nEH9hfn1LDU94z5mpm8b9MCJasHFA6QeXV
	TA0UMoZuySauGwEc6VlX0CLxY5W8PixWHGIZV3JHr/3ILqWU7ZmaOBuOtUGf4XKn8RI=
X-Gm-Gg: ASbGncubXWif4MugCJ9Z1voL9UATI0ujBCdxIJ11vaz40NJSdLLb4oy9uZDa8dTsAQR
	N8HKUH+fCT7JqxK5iEGQkKZTsUla2gXNeGyPVUV3GBSlOkTt1UB+hY7L0IdFZrP3B44BnrTKps4
	PINd0Ss8zembwhmsGDbiQSJTvwm8hUddlo7f2JmsXMF1PCx2GJcKhJbkVAWzH30OFw07F4dh5bA
	oPGAYr/dDFzZ8doEdqKpe7/FoJdo+HL1S//714Ro6Ul1aUiq2z/sIVPP8u7SZg38SZA8to11J2t
	D4a7TDUXoB8xNaIqN1auaHNSHfoSEaTdaKCUtUOfHhpTWS97MXQ=
X-Google-Smtp-Source: AGHT+IERLtVIjbbm9ImxS1NjVC+qA8ruylRbpeWTse0ekd+LRYnX8LK1W31HiKxCL0UGmKVdQkwhfw==
X-Received: by 2002:a05:6a00:2d98:b0:736:a9b1:722a with SMTP id d2e1a72fcca58-742a98cc928mr9719795b3a.7.1747752678636;
        Tue, 20 May 2025 07:51:18 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:276d:b09e:9f33:af8d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829bb3sm8242993b3a.100.2025.05.20.07.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:51:18 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v1 bpf-next 02/10] bpf: tcp: Make sure iter->batch always contains a full bucket snapshot
Date: Tue, 20 May 2025 07:50:49 -0700
Message-ID: <20250520145059.1773738-3-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520145059.1773738-1-jordan@jrife.io>
References: <20250520145059.1773738-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Require that iter->batch always contains a full bucket snapshot. This
invariant is important to avoid skipping or repeating sockets during
iteration when combined with the next few patches. Before, there were
two cases where a call to bpf_iter_tcp_batch may only capture part of a
bucket:

1. When bpf_iter_tcp_realloc_batch() returns -ENOMEM.
2. When more sockets are added to the bucket while calling
   bpf_iter_tcp_realloc_batch(), making the updated batch size
   insufficient.

In cases where the batch size only covers part of a bucket, it is
possible to forget which sockets were already visited, especially if we
have to process a bucket in more than two batches. This forces us to
choose between repeating or skipping sockets, so don't allow this:

1. Stop iteration and propagate -ENOMEM up to userspace if reallocation
   fails instead of continuing with a partial batch.
2. Try bpf_iter_tcp_realloc_batch() with GFP_USER just as before, but if
   we still aren't able to capture the full bucket, call
   bpf_iter_tcp_realloc_batch() again while holding the bucket lock to
   guarantee the bucket does not change. On the second attempt use
   GFP_NOWAIT since we hold onto the spin lock.

I did some manual testing to exercise the code paths where GFP_NOWAIT is
used and where ERR_PTR(err) is returned. I used the realloc test cases
included later in this series to trigger a scenario where a realloc
happens inside bpf_iter_tcp_batch and made a small code tweak to force
the first realloc attempt to allocate a too-small batch, thus requiring
another attempt with GFP_NOWAIT. Some printks showed both reallocs with
the tests passing:

May 09 18:18:55 crow kernel: resize batch TCP_SEQ_STATE_LISTENING
May 09 18:18:55 crow kernel: again GFP_USER
May 09 18:18:55 crow kernel: resize batch TCP_SEQ_STATE_LISTENING
May 09 18:18:55 crow kernel: again GFP_NOWAIT
May 09 18:18:57 crow kernel: resize batch TCP_SEQ_STATE_ESTABLISHED
May 09 18:18:57 crow kernel: again GFP_USER
May 09 18:18:57 crow kernel: resize batch TCP_SEQ_STATE_ESTABLISHED
May 09 18:18:57 crow kernel: again GFP_NOWAIT

With this setup, I also forced each of the bpf_iter_tcp_realloc_batch
calls to return -ENOMEM to ensure that iteration ends and that the
read() in userspace fails.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/ipv4/tcp_ipv4.c | 96 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 68 insertions(+), 28 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 158c025a82ff..27022018194a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3057,7 +3057,10 @@ static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
 	if (!new_batch)
 		return -ENOMEM;
 
-	bpf_iter_tcp_put_batch(iter);
+	if (flags != GFP_NOWAIT)
+		bpf_iter_tcp_put_batch(iter);
+
+	memcpy(new_batch, iter->batch, sizeof(*iter->batch) * iter->end_sk);
 	kvfree(iter->batch);
 	iter->batch = new_batch;
 	iter->max_sk = new_batch_sz;
@@ -3066,69 +3069,85 @@ static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
 }
 
 static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
-						 struct sock *start_sk)
+						 struct sock **start_sk)
 {
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
 	struct bpf_tcp_iter_state *iter = seq->private;
-	struct tcp_iter_state *st = &iter->state;
 	struct hlist_nulls_node *node;
 	unsigned int expected = 1;
 	struct sock *sk;
 
-	sock_hold(start_sk);
-	iter->batch[iter->end_sk++] = start_sk;
+	sock_hold(*start_sk);
+	iter->batch[iter->end_sk++] = *start_sk;
 
-	sk = sk_nulls_next(start_sk);
+	sk = sk_nulls_next(*start_sk);
+	*start_sk = NULL;
 	sk_nulls_for_each_from(sk, node) {
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
 				iter->batch[iter->end_sk++] = sk;
+			} else if (!*start_sk) {
+				/* Remember where we left off. */
+				*start_sk = sk;
 			}
 			expected++;
 		}
 	}
-	spin_unlock(&hinfo->lhash2[st->bucket].lock);
 
 	return expected;
 }
 
 static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
-						   struct sock *start_sk)
+						   struct sock **start_sk)
 {
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
 	struct bpf_tcp_iter_state *iter = seq->private;
-	struct tcp_iter_state *st = &iter->state;
 	struct hlist_nulls_node *node;
 	unsigned int expected = 1;
 	struct sock *sk;
 
-	sock_hold(start_sk);
-	iter->batch[iter->end_sk++] = start_sk;
+	sock_hold(*start_sk);
+	iter->batch[iter->end_sk++] = *start_sk;
 
-	sk = sk_nulls_next(start_sk);
+	sk = sk_nulls_next(*start_sk);
+	*start_sk = NULL;
 	sk_nulls_for_each_from(sk, node) {
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
 				iter->batch[iter->end_sk++] = sk;
+			} else if (!*start_sk) {
+				/* Remember where we left off. */
+				*start_sk = sk;
 			}
 			expected++;
 		}
 	}
-	spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
 
 	return expected;
 }
 
+static void bpf_iter_tcp_unlock_bucket(struct seq_file *seq)
+{
+	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+
+	if (st->state == TCP_SEQ_STATE_LISTENING)
+		spin_unlock(&hinfo->lhash2[st->bucket].lock);
+	else
+		spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
+}
+
 static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 {
 	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
 	struct bpf_tcp_iter_state *iter = seq->private;
 	struct tcp_iter_state *st = &iter->state;
+	int prev_bucket, prev_state;
 	unsigned int expected;
-	bool resized = false;
+	int resizes = 0;
 	struct sock *sk;
+	int err;
 
 	/* The st->bucket is done.  Directly advance to the next
 	 * bucket instead of having the tcp_seek_last_pos() to skip
@@ -3149,29 +3168,50 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	/* Get a new batch */
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
-	iter->st_bucket_done = false;
+	iter->st_bucket_done = true;
 
+	prev_bucket = st->bucket;
+	prev_state = st->state;
 	sk = tcp_seek_last_pos(seq);
 	if (!sk)
 		return NULL; /* Done */
+	if (st->bucket != prev_bucket || st->state != prev_state)
+		resizes = 0;
+	expected = 0;
 
+fill_batch:
 	if (st->state == TCP_SEQ_STATE_LISTENING)
-		expected = bpf_iter_tcp_listening_batch(seq, sk);
+		expected += bpf_iter_tcp_listening_batch(seq, &sk);
 	else
-		expected = bpf_iter_tcp_established_batch(seq, sk);
+		expected += bpf_iter_tcp_established_batch(seq, &sk);
 
-	if (iter->end_sk == expected) {
-		iter->st_bucket_done = true;
-		return sk;
-	}
+	if (unlikely(resizes <= 1 && iter->end_sk != expected)) {
+		resizes++;
+
+		if (resizes == 1) {
+			bpf_iter_tcp_unlock_bucket(seq);
 
-	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
-						    GFP_USER)) {
-		resized = true;
-		goto again;
+			err = bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
+							 GFP_USER);
+			if (err)
+				return ERR_PTR(err);
+			goto again;
+		}
+
+		err = bpf_iter_tcp_realloc_batch(iter, expected, GFP_NOWAIT);
+		if (err) {
+			bpf_iter_tcp_unlock_bucket(seq);
+			return ERR_PTR(err);
+		}
+
+		expected = iter->end_sk;
+		goto fill_batch;
 	}
 
-	return sk;
+	bpf_iter_tcp_unlock_bucket(seq);
+
+	WARN_ON_ONCE(iter->end_sk != expected);
+	return iter->batch[0];
 }
 
 static void *bpf_iter_tcp_seq_start(struct seq_file *seq, loff_t *pos)
-- 
2.43.0


