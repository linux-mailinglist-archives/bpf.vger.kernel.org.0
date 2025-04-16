Return-Path: <bpf+bounces-56075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBA2A90FAD
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 01:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E043BB025
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 23:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062CF24A06F;
	Wed, 16 Apr 2025 23:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="fBUT0Nc+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1314E238D3B
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744846598; cv=none; b=LTik5VlH5NugkERaEjxP+PgqTwaXFcYcjA8kahabXtfcxG73KZXiYiVpeYlSJ82DZkm6+/IraDhCWeJ/bGn6afrX2z8/tJRCS0odSjLCq8LberkBh1TJVyqjfRLNM2jkdnc+OWRARTLOnmtBISo/c40B2oBl+F8eaO2SqEY13gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744846598; c=relaxed/simple;
	bh=KvvIWgxv3s3xE/5AQwoMFofmI1CsY1mFQe9hDQS+7Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R26P5lBTQVD6dtr8yqSfj7bnrZoZhB8QLIYUwVlIFXRzZFdGniv2cYLpwkagcg0AYSkmA7cNj5+slkQwJdqUgzJrsgrdQ4wVqDQRBbVlwasWhGumqkq7ZLt25bhQh+Rokg8NR3md81BDh1wGRZGNp82nGTUurpJlsjgcWoOJImc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=fBUT0Nc+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223fd44daf8so400135ad.2
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 16:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744846596; x=1745451396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l38A+kfKiBznAOFQxGDyaUmwG8yyIm3KCv0gC2I/U+U=;
        b=fBUT0Nc+QL2iNV97vC5tt0BOVkzIODWFCuTW52M5n1CoQIalGCZD9tYJYJHKeNW0vd
         R+Wc/4CMz3iw7sQeuDkGE7VkLHDrE0g/zCQQWT3uM7hVPU92qZtsvHvVc6uA08y9JIyV
         vp8/sWgSGUCOeLA/mOeY4iyWCIQpZajWxSgDC6Yy+O7mxFRAAQyH17p/vNpFsPGlSNXb
         vFEjGIDzH86hU0unbeOQzLVMhDF1a38I16M8/vnOpmqXmZ/Y9HCbSaLQRkESce+7boXd
         8vp0HCoSNJ6mBJMLgvkre2lUfEGJApJyVsK8hrI9uUUW3p3pbzpT9fYho0XlHvEwx5b7
         cEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744846596; x=1745451396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l38A+kfKiBznAOFQxGDyaUmwG8yyIm3KCv0gC2I/U+U=;
        b=kv/SLTYoc9db0+MyzGh7WhwHJnvtVJa2QTPdaZXOR5jqz8beVqtXLf3H0rZMna8Wnb
         e26mvPdpg1u4rK5OwLfXkNgBD9ouwSP/i28dzwsAnKGIIrQHr4VTHAeAjoEmcyprknv3
         5fLH1O02qbQnog+1Q2KTgaRaQgj9eDpb7+SGsrxB2ToPs+wdkBYE9Hsv2vXEuxN6prOn
         S121TnI2g9INWMvRdGj/NCrLXQvI6JSxTYggyYBJ121ETpM8yT1YHlYMOweR5bYsPpT6
         OzIs01+yx5ehBvZTuWCoofRRb0B/dEJ88CcxiT/+xBsIlHZtpYTHo2P9+S2jsb0MCARP
         4laA==
X-Forwarded-Encrypted: i=1; AJvYcCXTADynz8zBkemQziCgCNas55yDXeY+MLdTxZ0BVPKDj8sRntTBhijq+2noJBpG2ESjASA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGci9qC0ob7eJAFIvurKMV/ML+rYOvcvghxO4SVTAdWf+RGdaW
	t5eNyskTrXkLooUprIqtNN6ln+0GgIzKZ9q66EUhu52VSDbDIOTd1xV3Xv6H18A=
X-Gm-Gg: ASbGnct3D7irTePQD3R/fksWQOIOs1Ff0Ny5FoAxp4CF7UgLg69xrkX1FR9Drq6FyY9
	Chytnz3UURaNqe0Od5UgsszUw4ke7Sw6Se8BwxS3HSUQvCJPq+EdTAcHAS6OrWg+cPEYjLycvlY
	r4eJdbTPi3pm7aQxJXxW5mEPeiONACUT/ZvWe5edXPVnT90ClUz3+drmEptqbOlPEdrK1XzAwLO
	eR/Cuoy/ale9ZGnk6ehYqJ9Fc5v9cAVOn6Uif97nMWm714v7IuRKunAOWkxisofTcK5xWzPFcUt
	Hklk+5scKjdDEggI9NALCK1Dij/431Licl4qKLR+
X-Google-Smtp-Source: AGHT+IHTkXiguznErw50OU6KJAKk3cHRFD6nf8Oh/mRUgH0iT/11xftzybo7vJMwxq2Y7xsN8rpe2Q==
X-Received: by 2002:a17:903:3ba4:b0:21d:cdb7:876c with SMTP id d9443c01a7336-22c3f9ad469mr8572595ad.3.1744846596319;
        Wed, 16 Apr 2025 16:36:36 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:b7fc:bdc8:4289:858f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308611d6166sm2269251a91.7.2025.04.16.16.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 16:36:35 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v3 bpf-next 1/6] bpf: udp: Make mem flags configurable through bpf_iter_udp_realloc_batch
Date: Wed, 16 Apr 2025 16:36:16 -0700
Message-ID: <20250416233622.1212256-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416233622.1212256-1-jordan@jrife.io>
References: <20250416233622.1212256-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the next two patches which need to be able to choose either
GFP_USER or GFP_ATOMIC for calls to bpf_iter_udp_realloc_batch by making
memory flags configurable.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/ipv4/udp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index d0bffcfa56d8..0ac31dec339a 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3395,7 +3395,7 @@ struct bpf_udp_iter_state {
 };
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
-				      unsigned int new_batch_sz);
+				      unsigned int new_batch_sz, int flags);
 static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 {
 	struct bpf_udp_iter_state *iter = seq->private;
@@ -3471,7 +3471,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		iter->st_bucket_done = true;
 		goto done;
 	}
-	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
+	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2,
+						    GFP_USER)) {
 		resized = true;
 		/* After allocating a larger batch, retry one more time to grab
 		 * the whole bucket.
@@ -3825,12 +3826,12 @@ DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
 		     struct udp_sock *udp_sk, uid_t uid, int bucket)
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
-				      unsigned int new_batch_sz)
+				      unsigned int new_batch_sz, int flags)
 {
 	struct sock **new_batch;
 
 	new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
-				   GFP_USER | __GFP_NOWARN);
+				   flags | __GFP_NOWARN);
 	if (!new_batch)
 		return -ENOMEM;
 
@@ -3853,7 +3854,7 @@ static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
 	if (ret)
 		return ret;
 
-	ret = bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ);
+	ret = bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ, GFP_USER);
 	if (ret)
 		bpf_iter_fini_seq_net(priv_data);
 
-- 
2.43.0


