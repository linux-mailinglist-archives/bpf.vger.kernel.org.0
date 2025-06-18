Return-Path: <bpf+bounces-60966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF182ADF298
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FC24A31F5
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6D22F2342;
	Wed, 18 Jun 2025 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="ky02dm6i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10252F198F
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263955; cv=none; b=TGsxSKHKKAL6p/q860wIVyb8aB+0+EWPl0W+LveJapEXrCnCXRZvhr9QK7G1gONB3X5r4FNyKxdfONSrsLvRE3LVbJkpOhmnHCkDC67R6pOwAnbvTZ+cjWEelqNvULdmBzmYyNKgAi9wI2E953+TrunygvFFMwblEbJaO5RFzvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263955; c=relaxed/simple;
	bh=J9WHRyvRODERSUE/XtH3ualLiF0NfpgkyfMoaf1Ef5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rW1kFGfHX1jAOPW+syuB6BWNDF7tYcexxyV07B/rVZgmq8zMyYSOIHYt3JKgw9xrhugtG/uuWX0+JZJwAQE5wKecHApd3oB1BI02LpGHBqe5f+CV571ix/EvrvSWIBkGsU+Z9CL9SyINIa41hgv7Nxw104ap5LLdrQka/76DRjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=ky02dm6i; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31306794b30so1214070a91.2
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 09:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1750263953; x=1750868753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrPFMR4OHikyTVTJ8EtBy3d62qMwlWrkmeEZ+t0fDVs=;
        b=ky02dm6iKwI2MbfAwDBK2XlPO+J2CPs7MCXUFxju/3vbbRi3aDS9TB2sH8Oompclu+
         4vM6E8lw6y9xBxsgC8eMtdDd4SNlh/lN7q9612pjobeHMSmmCydI/nhcZ5AaVXwPQSko
         4jUEEmIaqyFe3FOk0KoYXK51nSAA/5egj61DfI3Gb56xrCDvHuPEepDs8UAKSnTJ1QIS
         feHYu6A8Z5v6esoQK4X2+gZjS92V49k87Ely+Sv9yDWzJV1UN6R/O7MYm+/e9BT8DNuo
         sGKwASSvViDJDq7T6FtEFgT9XmJiyQN7WeQvMZN8bse3J8yrPsLvv58H0X547Y1VTxrd
         FMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263953; x=1750868753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrPFMR4OHikyTVTJ8EtBy3d62qMwlWrkmeEZ+t0fDVs=;
        b=ug3ET3p2WeuiUUB86faUSqG6P84c8z6Pnj6eIOhDaCsA/MbS3MGva6Z4oJyAAlpBQK
         JuQUJ9YnZvIqYtZRaEGF/2fxUS+krcn4imKSZKYK5Yb04pra7yMMwx2Q0BfSStjTrcZH
         giCkVbPthKXQxwo6bLckWz1b8JZnCZNxELczdClCa8aCcfkJkCoIQMnVdyb4+ZxwQuAw
         Crd3muUVumnWwfNXiOWp4nuOf6+uTsB5ciYRB69YE3JnlCQZl7Kgr6kLANK16QpWbeiP
         B4+haA2wlRwp72Z3+kiWjAM2clHCqN1w2ijnxczejK3G9Rjt1eyQIoRScjFhDsMCY2+U
         gWgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAqQcClxOmlSobPEdVAixgu8In+Rs9rOZNr/fYD9iYF5TJtK/ixNzlAtArDqmHbBBbwGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpTp09Mn3fuuNqYQ5ZyifePSX6Fezkx8NOT7hM+ixZonFu/3WB
	4dVLtUYtMIxBIZ8FU7Gq8GW+CZQjyBnnlfKpDWKnWUlhEOREPNwlWoJmxEhwi7QOx98=
X-Gm-Gg: ASbGncu7sVflHSn91DWPsRfGkJbPv5rX7piCDkDQf5rFHW9jK78y39+/LeAwsOJCl3V
	rzFGZAB2Qzh/sUrtsET+Bq+KsiXDhRh4GSztS0QRVWsaHFtXJmbznhHEKlAqADUdzBSEJvuYLQT
	jsxxki6NmSLRLUmK+KETtC3nBwzLCZaTwFkqipodwLhAyUcOFFtYm+8tfDIxMDcmXvrsuGzhyRM
	vmVooBLxAaSb+EjgCIkwnTn5H2RRayH6kiZ3eXjm/LPbuKepLFfFykESFT/hGqjLEP3JMGLC+qd
	LFHkTwRMhKP9oCIZ05FHKJWD6U9LW9zzC/L9X7vpwM/JhxciD9c=
X-Google-Smtp-Source: AGHT+IFfz5NWkmA306zMPwyKmgeO9W/lp9eWwUeAvb/XlE+/5luTn5poY7/XQCO0bnjUbk+NB/c/kw==
X-Received: by 2002:a17:90b:2fc6:b0:2ff:7970:d2b6 with SMTP id 98e67ed59e1d1-31425b01d78mr4323189a91.5.1750263953197;
        Wed, 18 Jun 2025 09:25:53 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d683:8e90:dec5:4c47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2768c6sm137475a91.44.2025.06.18.09.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:25:52 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RESEND PATCH v2 bpf-next 04/12] bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch items
Date: Wed, 18 Jun 2025 09:25:35 -0700
Message-ID: <20250618162545.15633-5-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618162545.15633-1-jordan@jrife.io>
References: <20250618162545.15633-1-jordan@jrife.io>
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
index ac00015d5e7a..c51ac10fc351 100644
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
@@ -3078,7 +3082,7 @@ static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
 	struct sock *sk;
 
 	sock_hold(*start_sk);
-	iter->batch[iter->end_sk++] = *start_sk;
+	iter->batch[iter->end_sk++].sk = *start_sk;
 
 	sk = sk_nulls_next(*start_sk);
 	*start_sk = NULL;
@@ -3086,7 +3090,7 @@ static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
-				iter->batch[iter->end_sk++] = sk;
+				iter->batch[iter->end_sk++].sk = sk;
 			} else if (!*start_sk) {
 				/* Remember where we left off. */
 				*start_sk = sk;
@@ -3107,7 +3111,7 @@ static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
 	struct sock *sk;
 
 	sock_hold(*start_sk);
-	iter->batch[iter->end_sk++] = *start_sk;
+	iter->batch[iter->end_sk++].sk = *start_sk;
 
 	sk = sk_nulls_next(*start_sk);
 	*start_sk = NULL;
@@ -3115,7 +3119,7 @@ static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
-				iter->batch[iter->end_sk++] = sk;
+				iter->batch[iter->end_sk++].sk = sk;
 			} else if (!*start_sk) {
 				/* Remember where we left off. */
 				*start_sk = sk;
@@ -3211,7 +3215,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	bpf_iter_tcp_unlock_bucket(seq);
 
 	WARN_ON_ONCE(iter->end_sk != expected);
-	return iter->batch[0];
+	return iter->batch[0].sk;
 }
 
 static void *bpf_iter_tcp_seq_start(struct seq_file *seq, loff_t *pos)
@@ -3246,11 +3250,11 @@ static void *bpf_iter_tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
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


