Return-Path: <bpf+bounces-56556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B966DA99C47
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 01:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452A93AF8B8
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 23:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A38253359;
	Wed, 23 Apr 2025 23:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="LMG/ZC79"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFAC24337D
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 23:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745452292; cv=none; b=XLxAEJiCXGdezHQ1znqzMxuG/CAKXcMuzfN5J2ibqtAKl3l+nVsUdrFeQ6gOLzygZGUD7g6PJApCtcEQKewaZagnhmjAWvlqPeUZfCC+wzFi0TM0/x5lwakcdTRa+nTkJdKa7lGJGRW7Y9OoM1Falg9Vk2zC/svJOwgYD24aSGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745452292; c=relaxed/simple;
	bh=359FlGnn/2H7MAAvUDqHkrVGZeS/kANCFcdToO8akOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTko0cctxjCe6fN1AabV/gXw9cmxUbj4lpHG0h6LBgHpAAU6gnH92CL8liv5TF17iHRA+hxnf7wy4iXErVtZ3WLqDcllAQzHsSz/wI4JgS1P3AWzM6w7EMj2w07SAFs7G52vrMvPnVT7xuwfBtvHz1DqXp1JK1sr71ZL6PxSvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=LMG/ZC79; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-225887c7265so664625ad.0
        for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 16:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745452290; x=1746057090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vuGqhkyqLHfgo5ctkPUMHTlX5fL9nRElOHrrfeylss=;
        b=LMG/ZC79aX0QF8R1Zemd3plSpI35oFq+Ugj+h6sjYuqSWnpjXwTf+N7IWrY2090iwq
         kU5VFiaOR0LVuqA7TWLUs+t4+rO2KaLw0cWqmDkNKaGcYHSZ5YofY4F5mUF5LclFkHzS
         HYPQN+u5Mm0jLKMni2kkeRH/I/fXFcJ3Cc8oSrBiMkXGjpJqJ/pxgW/e5MQbEB8L1UPG
         yn8ja36nzbkGOu1EDUJBkTKYg7RDDY+RBDakjduCLHlBe1nZXwRk9sCMI9QLYQrYkNvQ
         x7bIC8K3PlUjI21LjZ671Mo40Wg8CQjuRrQKwVC9z8NAvMPRYTE2FE+AvTnQhSUP+Ctc
         YNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745452290; x=1746057090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vuGqhkyqLHfgo5ctkPUMHTlX5fL9nRElOHrrfeylss=;
        b=Py4zeCQsjtNJseD3Rm9ZTj0/ikQjmmUpm6t2oDGeSQ1vjTI/RJXGAW7jwyjHyYBSpJ
         /uLSCoj1v9Xok4fMArckouOviXCT3ZE06GqRAijs7Gg+2P00Wgoba/6XBDnsyaXykEKz
         NaTYWOY5FYO3IYr+gJXWabhvj2o++HqAlFQMJiaF0N+IJQr4ouym3HRXrQ/zkXE+7eN2
         F6IJvoM+HrcQ1RBHvkdu8SxWqM+XCPFYsG2tLfcGr6iJAUIdc5upmHy1hZGqmOMFIl37
         x9TtNOpmg65BDe3byBw+3oMV1wYq0/xxlPybia5+hGNS9nIr/LQtJpWqO6Yy7lm53ceu
         qmhg==
X-Forwarded-Encrypted: i=1; AJvYcCUqTn5U+cHqyJHyVJIq/d8AH+p4/vFQPAjmOIjZC1P9Or2Q6A1Rvnft+pMJbcvlw07zPT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YziNmL7iplQrrNNlj8EqGEGGK0R59viz4U5Dm/h44RO8zuJvVJG
	u9wcc0chYMZMQkd0laep6pmglY8nenOmTkDqFXqAZHYIsj+pt4vGTSEcfeXrguE=
X-Gm-Gg: ASbGncszSKDvmvWq5A+8GbGRz0wsyQnYbqN+qTDbn825CzZZUMtFjKrK+V0mNPeJ/v1
	/vFPgXM93sMW5+dhWQ8PF5at8x8repKLQL29eKUI0AJUOaXYFB8ElZP0rhjea6CYcvQte6iOgT2
	ky2UkOMO5f+CMU2huEyZ+3+FdPrnqu5JMqsdv0DPyNEiwoCIqySXO2jyg6TnUXidShmgpOUQ/zD
	c8chovUaoIdVlE/Lc5pgi6V6bohXgDDTfchuXGuCol3eaAjYLxg32p44Qxq2luSJIoLHPdt9s6G
	tyRcCZXy5K8UCIejG+d/hsQ8zTdEpw==
X-Google-Smtp-Source: AGHT+IEcSk0/maQwj/ZK2qwdHhchEkLNwVpHIG5PbuizEO+NhmV50c/mc2EZoLYVPkq2N2m0j0lL4A==
X-Received: by 2002:a17:903:faf:b0:223:f903:aa86 with SMTP id d9443c01a7336-22db3bb6f49mr2333455ad.1.1745452290388;
        Wed, 23 Apr 2025 16:51:30 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:f4b1:8a64:c239:dca3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76cfasm499175ad.47.2025.04.23.16.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 16:51:30 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v5 bpf-next 3/6] bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch items
Date: Wed, 23 Apr 2025 16:51:11 -0700
Message-ID: <20250423235115.1885611-4-jordan@jrife.io>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250423235115.1885611-1-jordan@jrife.io>
References: <20250423235115.1885611-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the next patch that tracks cookies between iterations by
converting struct sock **batch to union bpf_udp_iter_batch_item *batch
inside struct bpf_udp_iter_state.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/udp.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0960e42f2d2c..6f1835078715 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3391,13 +3391,17 @@ struct bpf_iter__udp {
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
 
@@ -3460,7 +3464,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 				}
 				if (iter->end_sk < iter->max_sk) {
 					sock_hold(sk);
-					iter->batch[iter->end_sk++] = sk;
+					iter->batch[iter->end_sk++].sock = sk;
 				}
 				batch_sks++;
 			}
@@ -3478,7 +3482,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 				return ERR_PTR(err);
 			}
 
-			sk = iter->batch[iter->end_sk - 1];
+			sk = iter->batch[iter->end_sk - 1].sock;
 			sk = hlist_entry_safe(sk->__sk_common.skc_portaddr_node.next,
 					      struct sock,
 					      __sk_common.skc_portaddr_node);
@@ -3504,11 +3508,11 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		 * socket to be iterated from the batch.
 		 */
 		iter->st_bucket_done = true;
-		return iter->batch[0];
+		return iter->batch[0].sock;
 	}
 
 	if (WARN_ON_ONCE(resizes >= MAX_REALLOC_ATTEMPTS))
-		return iter->batch[0];
+		return iter->batch[0].sock;
 
 	err = bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2, GFP_USER);
 	if (err)
@@ -3527,7 +3531,7 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	 * done with seq_show(), so unref the iter->cur_sk.
 	 */
 	if (iter->cur_sk < iter->end_sk) {
-		sock_put(iter->batch[iter->cur_sk++]);
+		sock_put(iter->batch[iter->cur_sk++].sock);
 		++iter->offset;
 	}
 
@@ -3535,7 +3539,7 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	 * available in the current bucket batch.
 	 */
 	if (iter->cur_sk < iter->end_sk)
-		sk = iter->batch[iter->cur_sk];
+		sk = iter->batch[iter->cur_sk].sock;
 	else
 		/* Prepare a new batch. */
 		sk = bpf_iter_udp_batch(seq);
@@ -3600,7 +3604,7 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
 static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
 {
 	while (iter->cur_sk < iter->end_sk)
-		sock_put(iter->batch[iter->cur_sk++]);
+		sock_put(iter->batch[iter->cur_sk++].sock);
 }
 
 static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
@@ -3863,7 +3867,7 @@ DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
 				      unsigned int new_batch_sz, int flags)
 {
-	struct sock **new_batch;
+	union bpf_udp_iter_batch_item *new_batch;
 
 	new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
 				   flags | __GFP_NOWARN);
-- 
2.48.1


