Return-Path: <bpf+bounces-62851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AB2AFF525
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 01:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915684E7659
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 23:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE69238C25;
	Wed,  9 Jul 2025 23:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="qVI9hyZN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4C22472BC
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 23:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102226; cv=none; b=r00zXP/gCvz4778OvHZnXI6w+kEjM64AUTCSVsEqz8/a3Q1xrM1XQ61xyPDgRqvTQTor5QFkAk9lKUaOVfThaAsxEj4INbBapoOXAkJIU1FMcN0TCq24lXh+GIafn+w8g0A+4Q3izAHz5uqGyYwVkIRjhpqRARwtWjis3p4Z8BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102226; c=relaxed/simple;
	bh=a51HgorEIgGCAVUbMsfE6xOpMv7c+DqcFSKtMtvMLIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HM5PKJmkOnGvHpwCInsa56V7KIbPKfLFwPAYKZM/uC74v0VLvBRuRZ46RsAfGVt3MCbjoDA229LaIMezAjU7QJT5mLEzaJrAQVwzyRUHp4fZFEdrv/lG7n0OYVlemGgqUhndNRZ/ok7ihPYwR0KcafgRiM3WLDx2DLTDuN+dTL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=qVI9hyZN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748fadc0bc5so65672b3a.0
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 16:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752102223; x=1752707023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Vze6RhlSTESRUYOf4wcKBQGRaLuvTgL6/CGzGYUzwU=;
        b=qVI9hyZN0i+cDJ2QVO+28a32eRMr82BhFCqIDSC3vilKDcvimmprwidxIilXCsOlW1
         UFQCNgPSsSENXu3fAK9w/BUFW7l76+mksF9dS3v+KYqxyzPZD3Q/AUpPwek8NnkaVnUk
         wCwzMZWwMO8CxQKTRxpoXrU8vQ57OOvcZY3/JBbqtxghqSzleHcoEMDpePeIJoYKMEad
         eeIA/vcpAyD39C79wSnmaj8nvPvr0TwMaj5a5olJoyVNq41dM6WZL61iUdmsgfo4RKit
         XRcfpwVqAz7LNswOkuv/6+NPCO6bJw56sZACtWSbiOn4l7mOvStcPP84cTHwAXq1FoYj
         GNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102223; x=1752707023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Vze6RhlSTESRUYOf4wcKBQGRaLuvTgL6/CGzGYUzwU=;
        b=V0HIg9AqflCgneO6q/fBDCO87I6/Yh7oAvVTgKjKvhIxbv0MxxV5h1pDU1tqrQhajq
         HcplVtvTRVwQqzg+Ibwl3118uN9ijhXu5shUaZcbOqYHA2DnBQ74JQL9FKImLsSnQPqf
         q7o5p1tGZrEgvJXin432scm1knJn+x4dZsS+JYosGYCZ/VWevsYlHJgtNzJoHqdBxa95
         T9a9If6I+X+QjTkyhe+wlWLwHcHkSFG2j24vMJtjPyXaB2z1Y/wnR2f6Dga2GfgUSKb1
         3THY7aDNb2BMN+ityjQUs4g4P2H5jubs92xjcR3wL/TOFfjGwnlnuM2S5nqwEPF/PCxS
         nRzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvorvU6R48p9xv82+gJBwYyXkTQzbtL3mZ5RRCI8OlNYicuuz+a/eYfTqA/pEDPbkbtK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPRRfkFRFVWzPLrDE+fA8Lev9Y9aghbVzyYkZtA0XiWH7XJ7C6
	SOOyqvJ7LcgkS7Fa/ztk5fWH0qKRUKKe4PBfTnK01Jn5lb3YizyVMYgtMkWFSyf69gI=
X-Gm-Gg: ASbGnctB7p/ydBeRxKeuvVvufyao0qw9jePlab76bu5NeaB4mI1mdVHDxUBLyXL1wEu
	+dG00AbplprSpC/iZQiVatZX9AcM7bmiPMyrgSaq3VvluSib0fL02FDowIX3GG6VKT7ds66HVrE
	jii2YiQfnnQHv9N/kXg7MHFhdtyYYeo5KOsfLlmY6CF01DKEXsXLbrYPV5fgDhEbKXjJOH+0lfh
	UDqqERfvu9wL9oclKSl8sq9UQCVaebfDqwcwzlAPXwPkc06OIr4dvFgPlyExzxMDAjKSJzpz4yK
	Q09/sWYyBPBmgAagPI6KE14rqfmyh2T2p5tXr8oFRLS8Z9it3Ls=
X-Google-Smtp-Source: AGHT+IHxf4oLIO0+ttlvW8KJw4gaG4ax4Ylps8Tu49UNEkuqCbvZOs2i/uy+yjH/Qee81AlITLoLww==
X-Received: by 2002:a17:903:1a67:b0:235:225d:308f with SMTP id d9443c01a7336-23ddb1a1392mr26675445ad.4.1752102222791;
        Wed, 09 Jul 2025 16:03:42 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad212sm2679015ad.80.2025.07.09.16.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 16:03:42 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 04/12] bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch items
Date: Wed,  9 Jul 2025 16:03:24 -0700
Message-ID: <20250709230333.926222-5-jordan@jrife.io>
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

Prepare for the next patch that tracks cookies between iterations by
converting struct sock **batch to union bpf_tcp_iter_batch_item *batch
inside struct bpf_tcp_iter_state.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_ipv4.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 50ef605dfa01..d2128a2b33bc 100644
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
 	WARN_ON_ONCE(iter->end_sk != expected);
 done:
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


