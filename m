Return-Path: <bpf+bounces-57246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC85DAA76F7
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 18:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EDF21C07639
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 16:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCF4266581;
	Fri,  2 May 2025 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="1jed54CJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD349261585
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202545; cv=none; b=aFq4FPVqQeGA1s86LG5V+MgqwoBpWpUuINRLAaINYMzYnC/F6Mqyth+Vyd68sweWnFBvbFFsFonsc6hMAp9p4R5TCygUHmEgIM7Cr1Sv4pwOmZjLnW3S7oIfR0DOB4TY5oriNHbOaarb1Qfmon3gftemqMV4anfOIvFMRt2zXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202545; c=relaxed/simple;
	bh=KY4Cw5ihKAFMWoXre2OH4em1PTOcbTWtPqrY9Ig38Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrSzZYeHHhi5oHx+OM1FBFBN/ZS/uG8aI3B1XbslxtiioceYT7aNIkaZpM0BeAo8n210mHC60MCN1jt50SuOuvWoLEn3uhUM0APd0cboaue2HuMjP/gVx0pLSey2NpezU4ViV8tSsVAHblhzHMS7WrvjOcynHY59jtFYl0XVCwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=1jed54CJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224104a9230so3674255ad.1
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1746202541; x=1746807341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oLrkBS/MFxwOBtPgNR2/nJuzoKrBomRLm7k25owaCQ=;
        b=1jed54CJfpafuHDnM8Yl13A3RAbnqP6sIGEqYaa+zBkvOzTPQT+Omu1OEo1Qeif2FE
         6gGmPJoFhgYMyTPjNWtVnW8wpKNQvU88sR3Tmu4jokWfDPt3V67vkCdxQ89GBsp0Uzhm
         F9jRTFQ6efJI1jVY8Ey4THuB6M6vWcJ+QV1twqBGUE3FYy3wODXoqxanXvBCDTCRj11j
         9vj9d06N1srvgDNVH5ZsgiT5tfsA6cEymaBOyvW6A44ykwhn6m6nKvu6Iy7T+n9G9Y8Y
         eyTkLP9mNGYzkbdYQweqlptq4oxQ9ZHxi1lCDHR5bKHGi1oO5lQGZTks5JSmMFhkbN6N
         gApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746202541; x=1746807341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oLrkBS/MFxwOBtPgNR2/nJuzoKrBomRLm7k25owaCQ=;
        b=eoogNKZ8bXMl/AL6vpv+NryJny6zra7JyCrKv/mGo6qtx5kFXfcdgBpNOUB6UvcOPt
         YN5qtyf4fd2Nkl+MNWzJFMTJ7lgYRYIjvHCoM2tAZDxJZi1aXfeamTZ4dp5PV2qvYoY/
         1XxmvXgMI/9Leyldaj/S2I/Sz/Q5NjRtvbBwlvA3Kil+Ld0G9OTky0y0S5nvluYl/xSI
         n3JEy9YWtsnjIWh3CptR7VPoF+0+6PbDc5S1YStWDTwQX6mMEMcg4EF4p/1WG2Rc+C1P
         0jBpoa/OuMJokLPkhj0/qGxwBkC+KEhe6xlxh/hNI3JrO6DDhUfESbgrbipvyuS81rMK
         W3eA==
X-Forwarded-Encrypted: i=1; AJvYcCX1Bx2gErwKNMuBpYodZBFTWmyggByDmnwKVlqp9ikSinWPZ3JpF0hyB4LSVuuX7b/3+CY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa7TzB2aHOvdOt2aieMbZXPbXUo3lmIKkZQta4GTlnQRJknePX
	EWITg5kFwqAh+S8q91IpLOXCUbSzfBwZQQK2D51gxnh3TogLkmYha9/tdlxZe0Y=
X-Gm-Gg: ASbGnctN5MV37a9Bil2AFUmuGn6EW5RMZtEuP3ijWmfcoApCI16Tcb+qH4ByIh3+SWY
	BUlB0R5mxP7GCEuJjuPYzsERU3jzjRRjY7ShY8/IoJ9nTpklrXZ3dbKB2+DEzuuS/UmBoC7tlES
	p/bNER1iuD1/UkMEDysRP69tH4VyT2MJbnYUAfkr1OXJLNr+CkL93LsPop9t8amlO9yA372/LzE
	LguBfW2MV1dcQwAr4ozGYkXPMoiFDQj5hm5ib/dWZCETmuI+ZrYXbJiUt6EaT2UyadW2s+DokuB
	vwgzsxDFzS4LxnOL9yQpJeRECSOO6w==
X-Google-Smtp-Source: AGHT+IGKWidtKtldsZqI2kjp1EeoL/sag3dHaw9QWt/3Zo1VSMtI8ZiBnTqeKcwukxO6kg6+sukJ6Q==
X-Received: by 2002:a17:902:c404:b0:223:5c33:56ae with SMTP id d9443c01a7336-22e10331810mr21072345ad.11.1746202540858;
        Fri, 02 May 2025 09:15:40 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:7676:294c:90a5:2828])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e95c3sm9572135ad.68.2025.05.02.09.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 09:15:40 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v7 bpf-next 4/7] bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch items
Date: Fri,  2 May 2025 09:15:23 -0700
Message-ID: <20250502161528.264630-5-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502161528.264630-1-jordan@jrife.io>
References: <20250502161528.264630-1-jordan@jrife.io>
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
index bc93d2786843..9cbd43a69509 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3390,13 +3390,17 @@ struct bpf_iter__udp {
 	int bucket __aligned(8);
 };
 
+union bpf_udp_iter_batch_item {
+	struct sock *sk;
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
 };
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
@@ -3457,7 +3461,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 				}
 				if (iter->end_sk < iter->max_sk) {
 					sock_hold(sk);
-					iter->batch[iter->end_sk++] = sk;
+					iter->batch[iter->end_sk++].sk = sk;
 				}
 				batch_sks++;
 			}
@@ -3493,7 +3497,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 			}
 
 			/* Pick up where we left off. */
-			sk = iter->batch[iter->end_sk - 1];
+			sk = iter->batch[iter->end_sk - 1].sk;
 			sk = hlist_entry_safe(sk->__sk_common.skc_portaddr_node.next,
 					      struct sock,
 					      __sk_common.skc_portaddr_node);
@@ -3510,7 +3514,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	}
 
 	WARN_ON_ONCE(iter->end_sk != batch_sks);
-	return iter->end_sk ? iter->batch[0] : NULL;
+	return iter->end_sk ? iter->batch[0].sk : NULL;
 }
 
 static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -3522,7 +3526,7 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	 * done with seq_show(), so unref the iter->cur_sk.
 	 */
 	if (iter->cur_sk < iter->end_sk) {
-		sock_put(iter->batch[iter->cur_sk++]);
+		sock_put(iter->batch[iter->cur_sk++].sk);
 		++iter->offset;
 	}
 
@@ -3530,7 +3534,7 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	 * available in the current bucket batch.
 	 */
 	if (iter->cur_sk < iter->end_sk)
-		sk = iter->batch[iter->cur_sk];
+		sk = iter->batch[iter->cur_sk].sk;
 	else
 		/* Prepare a new batch. */
 		sk = bpf_iter_udp_batch(seq);
@@ -3596,8 +3600,8 @@ static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
 {
 	unsigned int cur_sk = iter->cur_sk;
 
-	while (cur_sk < iter->end_sk)
-		sock_put(iter->batch[cur_sk++]);
+	while (iter->cur_sk < iter->end_sk)
+		sock_put(iter->batch[cur_sk++].sk);
 }
 
 static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
@@ -3858,7 +3862,7 @@ DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
 				      unsigned int new_batch_sz, int flags)
 {
-	struct sock **new_batch;
+	union bpf_udp_iter_batch_item *new_batch;
 
 	new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
 				   flags | __GFP_NOWARN);
-- 
2.43.0


