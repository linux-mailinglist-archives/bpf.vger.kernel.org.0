Return-Path: <bpf+bounces-63227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36CDB04729
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 20:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247641646F0
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 18:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A624426C39E;
	Mon, 14 Jul 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="ynvLsYdG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA6E26D4C2
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516574; cv=none; b=ioVqou0wGnMxN5l5/xDnA1SWKMyVxgHUGmeoCLLcfXa74iLuLZehw36O4LzL9/z/AB6i2axTYxGzlmk37GT+GwdaJ3yUOgrVWk9RcnC3iOao9yd39eDKqCKAVQT6RjUGUNsTAHoLLieVQY+r8hS/7NLqME7PhzRPxKFORq/0Mpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516574; c=relaxed/simple;
	bh=a51HgorEIgGCAVUbMsfE6xOpMv7c+DqcFSKtMtvMLIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eyv5r5exDHWSloYdY5LYk2wP3IVeZ6nk+e3Qc2W9beHTXoUP/W+8EPTUxay/oATN5YRAFmLIKHwUGlGzC7qW613l+OBptPx7xwtf420RFpb285vL+hYy3LAc+rS6ms+s+SLLtY14VgcFmqt2rYqlR/dYb9GRpq2qaoOzAfoft4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=ynvLsYdG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2369dd5839dso7380715ad.3
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752516572; x=1753121372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Vze6RhlSTESRUYOf4wcKBQGRaLuvTgL6/CGzGYUzwU=;
        b=ynvLsYdGXtGTnTf4F1qtSGlF3sAWfdcG4TlfouzSAMR9T4dZuqjHorg7pmYeV08W+R
         IkVLxfE4+BYgrHvOqft50RJKBt6cmUEqQ/cSqawvJ8m+eHSTjQEGQCMyGlSi5GcacH1e
         oTUu9e1r8NLtOHnMlTB9+2XugmlQR4Bcet5JTpszWFCPQp5jNc6KCEiGX95varcymuqS
         ji/yU1mzC2ISNSAKjdNVDEctHr/KWQBqmt0YdgoKdqMi+ZsIZkCKLmsfgwdZhN1H+tX0
         jD0L7nNev3dRQkKR/8T2cevfb/MzJlAcE0OCNKoCaODZ80U8uJiITfScmEjdvMCkPBib
         Kujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516572; x=1753121372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Vze6RhlSTESRUYOf4wcKBQGRaLuvTgL6/CGzGYUzwU=;
        b=sUmZlU8iPnr2ArCTGPGaSTAj0pOsMI3N0dg+C/oH/37xCG66mPAPhUAW5ZB9kWYQfa
         jA//uZxHIsYX+MeKMPD5uSCsr7GRIAucBJAakJEXB+0QYd7tvrXX+YI62J8nuqcI4k5S
         R+2cjfkkdb8wmoQeD3da2ErMxLnI5xXF0xvUQThpIFKsCwViOlqPiMQLrW4jaHWEbkhd
         m6cQKysX68Mz5S5m66cxCVdCXPFsX6lWtgAll43YO3rTxQFSBtQu+a1Bp8hHZadcT4Xc
         0NiHNzsod3BNORmxyQWIVibjicFzJaJ8rtqt+HLE9/GNozFiUIdetfecBrLFV4b0DovW
         y0ag==
X-Forwarded-Encrypted: i=1; AJvYcCV2Itx4mkU5e+tAvfs6/mx/RFJymSRsS45cl7Hi0mb71G/iEtKh9oPT5FdQ1AR78Muh2xI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyISshkb8rawBHlBfP3Tn6QTW/pPfCJFmhWI7trJOz3q+4331Xj
	D2WB9QoGDUGHe+v2PcRP7gck3YrnlpG7SeA76kZYmMLpDsI/PdphSPhBSZt2lP/Hga2uEADT3hA
	o+j3p
X-Gm-Gg: ASbGncvtVnTVB0yzr/TjxcnCJEh2UYPathpau6EnMnZlKTyb22PdzU8CxmS3zNAXwu7
	ov2Y+2uHhVApjJJlQ+CuuyH/M9+AXd2lCdtIQ0rXvwFPV3UTKgCwURtdRjrMQO3avdhZMAp82n1
	GfeA6HEhmQm9Q+oelA2IQK2GrvBd4bkQjmsQKVtdLo92yHCdarTNN9kT47feCIILapwHhJYxZE3
	BHZCwhDdGdSyTQVbEZV97pP9Rr6Lf7UOfYPVPLtf9+HV26sLxW8CqpDKhcs5KBJgKull0SVhzxs
	RqOAmDkem0VxDAU3jF64apct0Ai7Gs9+qRMWGRFsosn+gCaA3OvDzqUCd6Zr/cNAwK5b7FCrtNq
	HGvoEDwr9Vw==
X-Google-Smtp-Source: AGHT+IHUtsoxeqc4E1NXv0Tk0U4AObGZu4efLGutIc8Q8IY3aqta4/3IBVseooMh5ODQxZNV/b+gXg==
X-Received: by 2002:a17:902:ea11:b0:235:225d:308f with SMTP id d9443c01a7336-23dede2d1bamr87518045ad.4.1752516571965;
        Mon, 14 Jul 2025 11:09:31 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:84d3:3b84:b221:e691])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm98126405ad.78.2025.07.14.11.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:09:31 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 04/12] bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch items
Date: Mon, 14 Jul 2025 11:09:08 -0700
Message-ID: <20250714180919.127192-5-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714180919.127192-1-jordan@jrife.io>
References: <20250714180919.127192-1-jordan@jrife.io>
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


