Return-Path: <bpf+bounces-58571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35739ABDE71
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 17:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32884E2994
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45AF24EF6B;
	Tue, 20 May 2025 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="3RMVdWUu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F247724A04F
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752682; cv=none; b=qKgAbKOS8YvJkIOosGJVQJYsX5BQ4JhjIvLYVIsu2HGzvxWTt2gSA17O9YgFiYgjqqf9iQBqj+XKq+1H1pJzCPf7Cj5DvaZdiGWsiSJ4aK5VBX/OGCKj+S4QkN/rixqEDJfjy+9tThV66P/3dIVWLSA6rBdOy6tlbWYgcUxheJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752682; c=relaxed/simple;
	bh=+hBo/IkWSWFqFhMutydRQ/Xv7uTn6jqF/C/mC6oJrWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/Maq1YV9hGUuzJ7r1IidEfMfcyRJ5dPx9cPX4deiUYOXGlIIAyGoEUlP6fXmC0UeWLwQmvBzcrWCFnJtsEC0KvQjXd+h7CfldBsR9o/vigyD/Qga2coKK5EoEcQKwgGSBxWZux3YYrNaL3uEKPFbbhJ5d13M0u1CIC9wRPPNW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=3RMVdWUu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-73de140046eso750256b3a.1
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 07:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747752680; x=1748357480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4//aK8+XKK5vCTEAV2yl6dInd+5ycJk4+NPxygp2cg=;
        b=3RMVdWUuzII8XLJO3uowXkdsGRLVkSEQLIEfPHHuPZJz9hWI1isOP9fw69dtmiAzCX
         gfOc+TMu6z4zKVfnwnbKLSAEViyAKWI9I62Szq4MSZigPtq0V0CxhP1h5QmYVNRstc9A
         VfVlZEAi/Ske66pGf9OTUtZgSlrzVZWdUodEI876R40x8tSpY6zGvCuDzGVVZhZDF2ZZ
         mFza6AfD9QCBE+xnRI9vfYVc058HzO1nH9AWux8zAvuKcQZEUxtzjaiDs3gLdTG6Ywnu
         KCHqskNgVDtpaUqngm28zA8U+XOWPrMMlQKYPVBYe9CoQfGXjm1EqaPc3e99o+tx6/7S
         A6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752680; x=1748357480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4//aK8+XKK5vCTEAV2yl6dInd+5ycJk4+NPxygp2cg=;
        b=IPhMoZn2MFwNdqplZNOvlk3neYbsnvxB1t1Fknwgw+4HuGcvzrUdHBnb0nwUXy/ef2
         urqtmm12+7Lvjas1zgn9gLtmaTddm5ZqFBPqZfTuk2OmHdlnprGiRpObAFJuGI9gftHI
         U4HaN8wqDX45oQIaRc5OhC+F+l/H2uV8EEykw3jxVDpJP9PQoryWDzsKatwM55tS0q/B
         P+O8lhDSda6i5Zl6MDr7/mrODacCTkMcKDCG/lpk/3Mqkzi1UFweUOClKkSsGSlcXvJy
         0okNI7gta/BnAxRI/rTKWb23tJWj0M/5VgiH3RPM9+Wmyp+23MWJhpox0qPQbruT6QZg
         TQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCUrI0Ah+/7CG2dvej2viVWj5mrbWnqwgujI/rhxLDYDhrM0liN8+kDrUhhZOB0gh3MgL+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy24G6W9dIB2zKAHBqn3yetlLyH/V55qDaK2h8O8SUX3JFq+ywQ
	X9Uc02fzE1BBmhmEkhWTB6lWTCqkfXvVSq1r7a63PShWwNeFV95OwRxHyNNQkYApfEw=
X-Gm-Gg: ASbGncvSpDl5LLKrJlrwrtdVb6cfhgDvvEUyIucxBHxPp90dO+Z16rwRNEVb9znexCY
	yY+5SLhAtkQdyv5ggYSSze0JJey8W3sGDCi3EzJ5jy9KTtA7SpBS5RtKc/SYHIDmHxfSCnOQeRe
	FkMqGUYw3mfyVEiO2MNeeoVuuFGTazZKUtw06/ZxZ4hA/3Ym7QTV8lOhcL7EFQ1E7pJyUu8ctgw
	bty38cWzbt0ZmFBIebvBqV8TRrw/Eaut9YZyAgMAokWFHCEtoAmwld5mPCZBOKrfFuucCqZ2R9m
	MdFDAqhZkYWdLFwsMuqR9qXq5VnurYHwbWGuUSWs
X-Google-Smtp-Source: AGHT+IGGgxgIuAUVTCgCbdHoO2rKx41h8KFpkOBgVzgoq12tUS1u9Czy2Qps6bf3U3TxkHCG3NRahA==
X-Received: by 2002:a05:6a21:350f:b0:1f3:4855:5b46 with SMTP id adf61e73a8af0-216219b2553mr9470434637.7.1747752680104;
        Tue, 20 May 2025 07:51:20 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:276d:b09e:9f33:af8d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829bb3sm8242993b3a.100.2025.05.20.07.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:51:19 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v1 bpf-next 03/10] bpf: tcp: Get rid of st_bucket_done
Date: Tue, 20 May 2025 07:50:50 -0700
Message-ID: <20250520145059.1773738-4-jordan@jrife.io>
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

Get rid of the st_bucket_done field to simplify TCP iterator state and
logic. Before, st_bucket_done could be false if bpf_iter_tcp_batch
returned a partial batch; however, with the last patch ("bpf: tcp: Make
sure iter->batch always contains a full bucket snapshot"),
st_bucket_done == true is equivalent to iter->cur_sk == iter->end_sk.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/ipv4/tcp_ipv4.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 27022018194a..20730723a02c 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3020,7 +3020,6 @@ struct bpf_tcp_iter_state {
 	unsigned int end_sk;
 	unsigned int max_sk;
 	struct sock **batch;
-	bool st_bucket_done;
 };
 
 struct bpf_iter__tcp {
@@ -3043,8 +3042,10 @@ static int tcp_prog_seq_show(struct bpf_prog *prog, struct bpf_iter_meta *meta,
 
 static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
 {
-	while (iter->cur_sk < iter->end_sk)
-		sock_gen_put(iter->batch[iter->cur_sk++]);
+	unsigned int cur_sk = iter->cur_sk;
+
+	while (cur_sk < iter->end_sk)
+		sock_gen_put(iter->batch[cur_sk++]);
 }
 
 static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
@@ -3154,7 +3155,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	 * one by one in the current bucket and eventually find out
 	 * it has to advance to the next bucket.
 	 */
-	if (iter->st_bucket_done) {
+	if (iter->end_sk && iter->cur_sk == iter->end_sk) {
 		st->offset = 0;
 		st->bucket++;
 		if (st->state == TCP_SEQ_STATE_LISTENING &&
@@ -3168,7 +3169,6 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	/* Get a new batch */
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
-	iter->st_bucket_done = true;
 
 	prev_bucket = st->bucket;
 	prev_state = st->state;
@@ -3316,10 +3316,8 @@ static void bpf_iter_tcp_seq_stop(struct seq_file *seq, void *v)
 			(void)tcp_prog_seq_show(prog, &meta, v, 0);
 	}
 
-	if (iter->cur_sk < iter->end_sk) {
+	if (iter->cur_sk < iter->end_sk)
 		bpf_iter_tcp_put_batch(iter);
-		iter->st_bucket_done = false;
-	}
 }
 
 static const struct seq_operations bpf_iter_tcp_seq_ops = {
-- 
2.43.0


