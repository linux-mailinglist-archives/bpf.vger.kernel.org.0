Return-Path: <bpf+bounces-55767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EF9A864D6
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 19:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4857460785
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 17:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404C723957C;
	Fri, 11 Apr 2025 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Oup4nqO/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F86521CA12
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392973; cv=none; b=t2uxEEWJuIdgtQc54Qm+2NFvPESfWA0RWqWQ0k9KMeHxg1XrloYwjB15gPyPTXeTHYibhRuWcn3obD9udcUqpAr/R6PuBeK/d9Aw1vv0IRRiahgrfpLruZiyToxRJ4fTZp8GuMtuY4zDe73MKHyMDVGvjHSCabpJgF62CxtmRsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392973; c=relaxed/simple;
	bh=bBRkJaCSuMWkVF9hzpwGn1Rr0qyQlb34f2yGCYtWI1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2jTh2+B/O1eVkeG7QQK9gdxv3Fpa23Lj4BsjKw86a+VMNChXukqJMiOPThKH4GkjVTLqhlx04SM6yKEAj616bJwMrqRO44O5bPBMLCJj6pUukZ7EN+2g2q/FLGDrCQbvAU4/kyVN1jjwe+7mufh4I0e7XE62iyNitRcxuv4pvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Oup4nqO/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224104a9230so3006865ad.1
        for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 10:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744392971; x=1744997771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCR+P0ZfnivUu6SBxTtPSbaVBhLoQDTN9ukIFnKzIcM=;
        b=Oup4nqO/DULWChteeeFnva3/xz1VcBTxCIdZRos5UEa1j+7aZpnElBtY8SLDydtUiA
         po4hWr3Pc7HFPPTonpsPRsGSjk6m02A2I0HT41Jtz1+Y5R7lMrD9fSWh7Ib8CYd1hzvj
         6D0TOKOzTDrhcEGgKMzBeWnhmeYzX63CHJKEbaghpvVdw9PdWXe2VGwPsBBia6XW8EpB
         2QEiq9wdPU1zW70b8Xlo6ffjIeG6tpHwMIPsqnEmFOEGIL+c+fQjhRKUNgSgCybDo+a1
         NSSamzyebn53XZv2ygfOQWNxquMO9Sr6pSNrNeNLesZQ2wa7JBJJFkyilBfaSvO+RGMS
         RNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744392971; x=1744997771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCR+P0ZfnivUu6SBxTtPSbaVBhLoQDTN9ukIFnKzIcM=;
        b=gbrnXQiJ7vy0ri8ETgZYfMFlmaPG3WrYyjlXFi/vtQX3imms7KG9kBv4rJOhT4BsH4
         cM4Y8u/YTY+anQ3owsNcUaj5aisXXjdjbl684YzMHtgjG/zwrn85WC/EntSD9iueqWxc
         MsM5pf0f1kYabH53sBGj/qeWy+m5we2Y5DYmKFSejWAL61l2YFVzJum9FK5aYdRWzCkH
         Vu590Phng0ao1+QgEkJ5tF99woe2EtdGCBSuXt+MGP2YQXGqh33XPSdy5or90mFMY6Op
         3iX6gWw92uSWqL72PPxGvMVg9RLL3CmCDnuqKwE0TVcxH8Cf5F49T7eu2uAHA4T3pvvL
         4mSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrEO2BvWCBkgncJ2SxrjRdOzaQDb0z2JnRA4RjDBXPztrzdtTc+zg4NBf9Zp3tgd5xQxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/UBQbxwEPBGb2HV0eYHPjsTDr52r1Rk+ZDWmb6oOmvhrHcoyz
	v8jSGQ42BeoOCqB+kQw5u79zURTkqOrG2CyPrK2yf7QXh5xNsM/6sIDX271fE26iiC65YcE59o1
	Brkc=
X-Gm-Gg: ASbGncvzsi/0Elll62eRpOkbT6/ZAiZvfWrHZY5peENnd1B1q+JhIb2ALf6kObhPPSG
	E/zjq/N8vvuGdZLCTkjSyL3jbPOBI9JkPer76xLR7CcJJfM+dqBl6NpG5wL1kXF/309+2g2+bpy
	QIxbk4jk2WOIDEFhERvxBZlAnU9hNYV+jxpsN1bd7lRMk7mMdSZapGo5YhOO0NqJzY6QtjnFbTB
	245RnWHSSFlghpmBpSHx7JeSdBUF810SP1qd2ufaB4crQySCPc755wcfc/Acb2dBWadx3ZMGNXJ
	hzfJ+hxQbcN8AMAVehJxZyqN1Q90Bw==
X-Google-Smtp-Source: AGHT+IFVkDfM9TCbygf3tqQLMYs1Ng0jJDC79lAvuX2vjlCFpgeuQl3akgUzihHxil1rAoUvFGxEZw==
X-Received: by 2002:a17:903:238a:b0:21f:519:6bc6 with SMTP id d9443c01a7336-22bea50019emr20326325ad.9.1744392971437;
        Fri, 11 Apr 2025 10:36:11 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:fd98:4c7f:39fa:a5c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb6a50sm52317725ad.205.2025.04.11.10.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:36:11 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v2 bpf-next 1/5] bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch items
Date: Fri, 11 Apr 2025 10:35:41 -0700
Message-ID: <20250411173551.772577-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411173551.772577-1-jordan@jrife.io>
References: <20250411173551.772577-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the commit that tracks cookies between iterations by
converting struct sock **batch to union bpf_udp_iter_batch_item *batch
inside struct bpf_udp_iter_state.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/udp.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index d0bffcfa56d8..59c3281962b9 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3384,13 +3384,17 @@ struct bpf_iter__udp {
 	int bucket __aligned(8);
 };
 
+union bpf_udp_iter_batch_item {
+	struct sock *sock;
+};
+
 struct bpf_udp_iter_state {
 	struct udp_iter_state state;
 	unsigned int cur_sk;
 	unsigned int end_sk;
 	unsigned int max_sk;
 	int offset;
-	struct sock **batch;
+	union bpf_udp_iter_batch_item *batch;
 	bool st_bucket_done;
 };
 
@@ -3449,7 +3453,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 				}
 				if (iter->end_sk < iter->max_sk) {
 					sock_hold(sk);
-					iter->batch[iter->end_sk++] = sk;
+					iter->batch[iter->end_sk++].sock = sk;
 				}
 				batch_sks++;
 			}
@@ -3479,7 +3483,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		goto again;
 	}
 done:
-	return iter->batch[0];
+	return iter->batch[0].sock;
 }
 
 static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -3491,7 +3495,7 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	 * done with seq_show(), so unref the iter->cur_sk.
 	 */
 	if (iter->cur_sk < iter->end_sk) {
-		sock_put(iter->batch[iter->cur_sk++]);
+		sock_put(iter->batch[iter->cur_sk++].sock);
 		++iter->offset;
 	}
 
@@ -3499,7 +3503,7 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	 * available in the current bucket batch.
 	 */
 	if (iter->cur_sk < iter->end_sk)
-		sk = iter->batch[iter->cur_sk];
+		sk = iter->batch[iter->cur_sk].sock;
 	else
 		/* Prepare a new batch. */
 		sk = bpf_iter_udp_batch(seq);
@@ -3564,7 +3568,7 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
 static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
 {
 	while (iter->cur_sk < iter->end_sk)
-		sock_put(iter->batch[iter->cur_sk++]);
+		sock_put(iter->batch[iter->cur_sk++].sock);
 }
 
 static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
@@ -3827,7 +3831,7 @@ DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
 				      unsigned int new_batch_sz)
 {
-	struct sock **new_batch;
+	union bpf_udp_iter_batch_item *new_batch;
 
 	new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
 				   GFP_USER | __GFP_NOWARN);
-- 
2.43.0


