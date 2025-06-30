Return-Path: <bpf+bounces-61865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395F8AEE57F
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 19:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB681618FE
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 17:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EDD29827E;
	Mon, 30 Jun 2025 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="KvpbmUk5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8C3295519
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303854; cv=none; b=oLr3brRIiiFsPnZVie52mSAWmvUlSNcnPXalY4FGkDel2Uvg2KLG3nQGbWJ/FF+Vz0YmIyvqYvzmhBropW591fj7Ko8mGhgTiPWQZ7lILi8QxoUT70nhTJagXKzOuDH19LDDiWUAqnLi/4kG8K99dMvmbEUE55upvxRsu6CIJA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303854; c=relaxed/simple;
	bh=1IzGHn+BTM6yQpzOWnyED3u7ZROoOCyUmCVD/qp2/eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUao/MOu3MFsZzM7BMZcdQ4hXgn8cZuaxE4HK+OWlM++HdzOWJYH/ETgLbDJGhmMxqx2TXydNFJlA7ay7bc4KWrziJmA1602DlvhyyufQ1N5BlHLmn8B07uu16BJSF7/o9I5c89yBVSOWxaedKm4Ftl2KH4RCqbiSgxZcGdPPqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=KvpbmUk5; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7493d4e0d01so356301b3a.1
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751303852; x=1751908652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voEHSxfM7pe9T+qAHz1hneeq/Ybf6HPk2JyjjjkAA6E=;
        b=KvpbmUk5KNRfeGNKj6pTQ/5nHvC0J+T5aszDW6thHgHnhIIjsKRmkRd8y7z5DSOEkn
         xNXvxjLa6bCi9eUbzBFYo/Ay/ZyGpy7k+TDtRKpig0y9UWEKxlK4tXRcrRE/MCim9osM
         zRFYhfqH/gFlTGjKKxIB06GzMiuUzmNLkT7zoDDWJat6VRaGMyLfY/cfdUPrIYqYxWl2
         P/4G7kCEtFmTWOFHCgfAiawHHgrcspp5xPX2Zk9BhFA3OHLAG4RhSF2cGbYFkb22THqR
         31RfR7cND6ouny1ov2sK3nEVjA13946ofyZBof8sWiovmGKPl9n24ruORJCfOgx74Ngx
         2LFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303852; x=1751908652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voEHSxfM7pe9T+qAHz1hneeq/Ybf6HPk2JyjjjkAA6E=;
        b=LkX2HT3sFSoDre2HQkidbNUnul43jt8/8OSllciWJMCunZvSuv+/58Oe1e/D349VeI
         dtzDAK8L5b/FmxyF86E9rpFXKjSoabK6t0g4pi3ZW/s0sTwlverqVd/tq1mBxUktONb/
         O54XCMISuMD9ehHWkXNhz7MqnnzIxMxBfU//1TTG0YlC/o29GzdGzyNqFL9M9wjV2KpB
         olrCMqT9yS0FsHyxU4NbOmxFbtyyDScDgxt1HwJ50xDF6RgphBn84gQp21YMWFzys53d
         cHzecdqDljgr9/BPR0M1WVTE42/Bj+hgWrsxrLXs0cJ+2YEMLN9PfreeVS9vgRjGmpiK
         tK5w==
X-Forwarded-Encrypted: i=1; AJvYcCVbRtW2sqyCaZLoP1yBaBjXl49qGBpPbEf96O9qpzmPJFEM9XYgT+ERvHXIStqWtguLdd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnrwh6rPBv2m48/1gCK8TqGL7szPmQxFChG1Sc1efmlCz1toYf
	/2ij4Ilnhd18Mojn1EVpgwnWy+oYhCiqxbllvaXEbiRMdSw830h0LHn9aZbX5CkNegI=
X-Gm-Gg: ASbGncuotgVXhRAVbZinb5cXWhMZKuXGSNO7eVMbnzpq1XJFpF4rvs1h0/4hshw5RLm
	tLeDXKptHYaNJ9gpDhkiT58v/eHamQbNcMtCxJmKn7wzXcy27apAvfAOAZn8r+4mp6hJN4lAu82
	7p/D9EsSwgD4aI2fyv6qRYtsh512YMMkh7nPNYh1SEkl5Ojg5GQ1djpkSKpmTPZJ0anDETbgC3D
	RfNEdyZVa3PwqcuSLWC5lPGy8jXzoHr+FZtBRYCo3hBzOXoUPUFhjvGGgPkV4DKeSXQ6YFvrF/F
	1vGyu/L0S3SEBhrwVFEv2YYp1km20t+hg6SegqUYuAYtLs8LPA==
X-Google-Smtp-Source: AGHT+IGeqy2YHO1mO5h1zuYyZ9G2DiuNqJUGD1OTGeCWLTHo4YEre+U7b6HRcvv0RxM6Bz+owGJ2nQ==
X-Received: by 2002:a05:6a00:b00b:b0:730:8526:5dbc with SMTP id d2e1a72fcca58-74b0a633743mr3679620b3a.3.1751303851723;
        Mon, 30 Jun 2025 10:17:31 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:9ab8:319d:a54b:9f64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a846sm9229232b3a.31.2025.06.30.10.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:17:31 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 04/12] bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch items
Date: Mon, 30 Jun 2025 10:16:57 -0700
Message-ID: <20250630171709.113813-5-jordan@jrife.io>
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

Prepare for the next patch that tracks cookies between iterations by
converting struct sock **batch to union bpf_tcp_iter_batch_item *batch
inside struct bpf_tcp_iter_state.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_ipv4.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 8a1fd64d8891..bb51d62066a4 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3014,12 +3014,16 @@ static int tcp4_seq_show(struct seq_file *seq, void *v)
 }
 
 #ifdef CONFIG_BPF_SYSCALL
+union bpf_tcp_iter_batch_item {
+	struct sock *sk;
+};
+
 struct bpf_tcp_iter_state {
 	struct tcp_iter_state state;
 	unsigned int cur_sk;
 	unsigned int end_sk;
 	unsigned int max_sk;
-	struct sock **batch;
+	union bpf_tcp_iter_batch_item *batch;
 };
 
 struct bpf_iter__tcp {
@@ -3045,13 +3049,13 @@ static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
 	unsigned int cur_sk = iter->cur_sk;
 
 	while (cur_sk < iter->end_sk)
-		sock_gen_put(iter->batch[cur_sk++]);
+		sock_gen_put(iter->batch[cur_sk++].sk);
 }
 
 static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
 				      unsigned int new_batch_sz, gfp_t flags)
 {
-	struct sock **new_batch;
+	union bpf_tcp_iter_batch_item *new_batch;
 
 	new_batch = kvmalloc(sizeof(*new_batch) * new_batch_sz,
 			     flags | __GFP_NOWARN);
@@ -3075,7 +3079,7 @@ static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
 	struct sock *sk;
 
 	sock_hold(*start_sk);
-	iter->batch[iter->end_sk++] = *start_sk;
+	iter->batch[iter->end_sk++].sk = *start_sk;
 
 	sk = sk_nulls_next(*start_sk);
 	*start_sk = NULL;
@@ -3083,7 +3087,7 @@ static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
-				iter->batch[iter->end_sk++] = sk;
+				iter->batch[iter->end_sk++].sk = sk;
 			} else if (!*start_sk) {
 				/* Remember where we left off. */
 				*start_sk = sk;
@@ -3104,7 +3108,7 @@ static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
 	struct sock *sk;
 
 	sock_hold(*start_sk);
-	iter->batch[iter->end_sk++] = *start_sk;
+	iter->batch[iter->end_sk++].sk = *start_sk;
 
 	sk = sk_nulls_next(*start_sk);
 	*start_sk = NULL;
@@ -3112,7 +3116,7 @@ static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
-				iter->batch[iter->end_sk++] = sk;
+				iter->batch[iter->end_sk++].sk = sk;
 			} else if (!*start_sk) {
 				/* Remember where we left off. */
 				*start_sk = sk;
@@ -3216,7 +3220,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 done:
 	WARN_ON_ONCE(iter->end_sk != expected);
 	bpf_iter_tcp_unlock_bucket(seq);
-	return iter->batch[0];
+	return iter->batch[0].sk;
 }
 
 static void *bpf_iter_tcp_seq_start(struct seq_file *seq, loff_t *pos)
@@ -3251,11 +3255,11 @@ static void *bpf_iter_tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		 * st->bucket.  See tcp_seek_last_pos().
 		 */
 		st->offset++;
-		sock_gen_put(iter->batch[iter->cur_sk++]);
+		sock_gen_put(iter->batch[iter->cur_sk++].sk);
 	}
 
 	if (iter->cur_sk < iter->end_sk)
-		sk = iter->batch[iter->cur_sk];
+		sk = iter->batch[iter->cur_sk].sk;
 	else
 		sk = bpf_iter_tcp_batch(seq);
 
-- 
2.43.0


