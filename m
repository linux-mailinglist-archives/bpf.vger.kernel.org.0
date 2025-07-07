Return-Path: <bpf+bounces-62526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A90AFB7F8
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2DB3A6C0C
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 15:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6165F217719;
	Mon,  7 Jul 2025 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="T0TiAFeL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E02215767
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903474; cv=none; b=RoES3Gi/xKuiOfvO+0cTDWNOQ3rRpimVx51wvSw3h2VQdsPQcWxyEryQ2ZEtF++NK45pF3mlxaAEurvNIldBPfnq0gHv5YOaf0LaGGF1mdbNNHFi3pAsruWJ2ll3jP2Wax+eN8VVXW7RKe8YY4lQ32wM8J9rOIZWH1KOqB1Abrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903474; c=relaxed/simple;
	bh=1IzGHn+BTM6yQpzOWnyED3u7ZROoOCyUmCVD/qp2/eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+k4eG9sphN2EvEjpqsMHceWrJ4T8doDV2Fc+o15P/0YFbRponJvimSIc+7gcCGE95BHthv//IHguQofv6s4W+oA4ps1bVYi8dpwOmlDjiMpNyItjvkqn3oNR+NaX1q+oLl5OFcXUR1WnqM3TAMr8C6b4t3uHwf9tRDDXNRmua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=T0TiAFeL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2369dd5839dso4792165ad.3
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 08:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751903473; x=1752508273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voEHSxfM7pe9T+qAHz1hneeq/Ybf6HPk2JyjjjkAA6E=;
        b=T0TiAFeLeHRqwI5r77e3x5yCSm8U1Zy3KVX20LaDmdduBmkk0d2sGr1eYANy/V5NuZ
         jkivMLrBeNZ9fhJnu5R5pgZ2jgjAbzpjqt9Htr7Im6kuNGYqpEwHNHKem4DV4FxetVrN
         aWC8T/AVQ6ruwCf4PWgqWN79fft9kann60uys2mxZhZWocQI8sqw2vk6m/GMfceR3anI
         oTdm6CTWsge7CZCwKe0WO6uVmw5aXQORSNqG45EcMvK6Gfrmvsee6nf4O2zzV88NwIhA
         GRITk9rn/adH0ujrOZ6ELSKWBrC55NSwnie+Kq/C3sCtGz3Dj8/fmoUfGwWbO++qNec0
         cr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903473; x=1752508273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voEHSxfM7pe9T+qAHz1hneeq/Ybf6HPk2JyjjjkAA6E=;
        b=WCXJND+haSYFZY8GQhwDgL5m0NJ2c71Fzrvr3zYlxk817bETUn9VrdAZHwWZJx+CST
         f0I9IYzje3TFia0wlKBFlbYhru44wc5zztybBFuB2EuTxgshpWajwZ0wJ4Uqdcnt/Hxm
         ZGdZjnGSF3X6m82T/iPiUahire6SjbkIZ52v0x+V6XouqrR+aXO2LyK3njAC+jNmWvyD
         EZUP/b98QKr3fgkTWk1NPfftKlD5nIrBvxzVhs+/MmSu6MEJ56ZkdmDX2hsWScVUOX9e
         Aq0a6DA14PrqH+0UVaGzKyajKzEvbj2Qiq6SmuRRAXPSXqia0r5wHQQTgiTvgk23geyR
         OMzw==
X-Forwarded-Encrypted: i=1; AJvYcCW/hQvGLqpCWG1twNHAgIpBX1LZbCiwBysBHcb74HkxEsP5nMDXjwq6h9a2YoTSegwi4+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4cEE2bvFJD/BD7SF2dsFB7gFs4OdLb5SWvzcGSdd2TWaQ3l2M
	jG8Dp/CzoMrABEgENOo36fXES1ZA6a3Qrjoznpsf9vLvoSMmNdCUFRcGr6R32zoKul4=
X-Gm-Gg: ASbGnctWkOFsvflrjrw1Gjjgw494tyF9Wc0KWfMwApre81zYVGivjmUV6V3LNYjP5AH
	y7njY4/TblIFos/VMH8S3LMbYKLSHIQZ3zvzgvqn6QH4I66gksLnlZzFGRrC1XPgK3XwHBAE4CE
	cxv7Pf1nTW9adN3vd8Qm6f1IhZJkyL0ZIo0SlHpbvdTb1pF8+yhwVsdPJ+2SLUkVIUrcGVn78nl
	3jkB1swjTwoFsn1nTmLLfduvwP80UxBdMOmtMPgDRU+U9RCB+4+M+ST8oz8JAGjAEemCtlzbLfh
	WHA41zTk/puicjQO1vpxMuDfEhhwxxc16Lf6zdN2mQRbpsYfGdw5CUsymx2wTA==
X-Google-Smtp-Source: AGHT+IFJDCZJTbI/ObP5Tql2cW1mboSw6Slzs8jMsm91uT/Gc6tN/3dEhtBwmntvl+92ZnYMsEkRpg==
X-Received: by 2002:a17:903:1a67:b0:235:225d:308f with SMTP id d9443c01a7336-23c87265c7fmr62564855ad.4.1751903472761;
        Mon, 07 Jul 2025 08:51:12 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:e505:eb21:1277:21f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455eb3bsm95772065ad.115.2025.07.07.08.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:51:12 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 04/12] bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch items
Date: Mon,  7 Jul 2025 08:50:52 -0700
Message-ID: <20250707155102.672692-5-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707155102.672692-1-jordan@jrife.io>
References: <20250707155102.672692-1-jordan@jrife.io>
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


