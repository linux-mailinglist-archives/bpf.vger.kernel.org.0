Return-Path: <bpf+bounces-56857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B2CA9F7E0
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 20:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D1017BCE9
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 18:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3768296158;
	Mon, 28 Apr 2025 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="B/oGqmLN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D72957D2
	for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863254; cv=none; b=mqqSPZLA7ps47m7bnvsHvapc4m4kTkY5G9LqPVhjT5UiWeuQk6O/JSlPcHLfFGD+YUKkdd3PidTZKRSO7TZhg9gUOaetZYrIbtvsrk1yYUY9aQsSKWsykPvaDEn1dZXYCjCflmZFnjBHA2ScnB1Cp2k1biNzV2ZE3Rife5WAR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863254; c=relaxed/simple;
	bh=/F3yqqMzCU5bH5/D12wYGRh+yJF+IBqELQlRUllZ0r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIIyy+53P3bKJftnfiWSb/JsegNS6MRbaN4bZ2AYjapL5V2HWa8M5U2OTlKEmBfzP6EQtu0hMYOjJm5gfImYrVNzOl14ylhtM8CkgGPTqBUH1tWmYjF2fS68ZJYksRchliLC1vSqYqCnolmw3x9vh/GtUU7LAdSauGTBZ5brfqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=B/oGqmLN; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b01d8d976faso431104a12.0
        for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 11:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745863252; x=1746468052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C95FnMTfV1qMiVrhx1xJqjNUnbfjrYoOP43A6bV/8xA=;
        b=B/oGqmLNBs/V/exbCsmhOCv+HbJ/fD5H1jz92RIHyb22IJ0bhYiA0/2sMfnNr8w55o
         1EStC0DfHdYJrikGYVt4rUpzxq+3xZCmd+8pFo5Ouudhtkz8vB/KCU032jcT3wmAwugJ
         XkV/24Y5J5rLlVMw1J72yat2Clidur2rxdqOtSLBDqtNtMAIIeP0+pAa4VPcP1LcdCd2
         ez5gePvQxuKjEbA+aW+Al5tYCL5Wnp8doglJckxp/C45n37t2E9ev1PW1ecHkg3y0GDt
         mSOLz8STxmEmQ2fypascDoYfwiW4elOcXpVhq3vi7GCjmtCy76J1ZYBZjlJMpxP+US7z
         H4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745863252; x=1746468052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C95FnMTfV1qMiVrhx1xJqjNUnbfjrYoOP43A6bV/8xA=;
        b=o9MOcFhgZNT8UJucdNtiVZg8SUkVB1AiAbpyYyNZoizBC6UGhV+/+NF/OhooKzFm9O
         Jz5Ney+LugOFMvNZ6J3nhvLpbttj9qCz5EE1asZoF4Lbo9h+joudlznPpu9J6vqIeCYE
         XsRp8lwKSjcLL6B5BHhUaX0YOkRwWyJq2CiOM721kw1crEIIDhAznjq808sVGxjZjF0Q
         2GMO/lONJ5L58Hjofp98UwokRo7oPI0Z7GlVXAyUOVf1eULsVHOIysEY3aqHQ4dz1y5R
         EzyiOsfQzB1164Vv4DgyKaI76QRA+NBq63yiUt+KWvRq4p9rQrSn2kUdo1NZ/KDwkE4O
         jNhg==
X-Forwarded-Encrypted: i=1; AJvYcCW9HVaFdkTURtRmsDlqHbgIcA9xvpAGphRiYGKcz1Bq74NbOLzQ4yIA3SZfpS5R/B6W76Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ZGqiZ5ovGMxRUQm4Np4pIlNk/AWHL1UsV1WwX6Dt4+2h6eR2
	8Ho6ivGRG2+FEODpxWI9aX9gHSbiFSj9xXKHIofNemqhNbpinc2DhDY2k06uOVjNGoKiCzZAIUr
	2+zs=
X-Gm-Gg: ASbGncuFsVwTw/jHxOadXCsOccClyMtlg00YQSqoQopy1ihkX02n1VH5p4Fb5Wq4GG3
	PxkoaRzUBy/LvNAjNOYvrzTRGn46r7kEIS3JYkIVduEyam3eAGJdV8RLOTsqosEsObHJL6i+L/O
	seKYpQfxzmWjlc1us2eBhnuyDJ7ODV3ueLVTYNZUtqWtW5yjtxTFLexecqWgxq/wzNxd8/E0NSm
	OD6Mu+CbgySW6C0BfG/GTEo6EczePJ/ykXYfIfyprU0rMnl6H5msdRCo16fq6fhUle6VVd+tL87
	QnqC/lYFdrSr8XIFOD/pNoWrdA==
X-Google-Smtp-Source: AGHT+IFSypysstaWxmv0T0klNclVTjsYJUKz+bG3Pjcu5N9+tgi/x8M9eygkzrh/QftQYpz8JCMiiw==
X-Received: by 2002:a17:903:2ec7:b0:220:cddb:5918 with SMTP id d9443c01a7336-22dbf63db59mr67529095ad.9.1745863252272;
        Mon, 28 Apr 2025 11:00:52 -0700 (PDT)
Received: from t14.. ([104.133.9.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52214ebsm86204235ad.246.2025.04.28.11.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 11:00:51 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 4/7] bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch items
Date: Mon, 28 Apr 2025 11:00:28 -0700
Message-ID: <20250428180036.369192-5-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428180036.369192-1-jordan@jrife.io>
References: <20250428180036.369192-1-jordan@jrife.io>
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
index 57ac84a77e3d..866ad29e15bb 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3390,13 +3390,17 @@ struct bpf_iter__udp {
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
 };
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
@@ -3457,7 +3461,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 				}
 				if (iter->end_sk < iter->max_sk) {
 					sock_hold(sk);
-					iter->batch[iter->end_sk++] = sk;
+					iter->batch[iter->end_sk++].sock = sk;
 				}
 				batch_sks++;
 			}
@@ -3493,7 +3497,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 			}
 
 			/* Pick up where we left off. */
-			sk = iter->batch[iter->end_sk - 1];
+			sk = iter->batch[iter->end_sk - 1].sock;
 			sk = hlist_entry_safe(sk->__sk_common.skc_portaddr_node.next,
 					      struct sock,
 					      __sk_common.skc_portaddr_node);
@@ -3510,7 +3514,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	}
 
 	WARN_ON_ONCE(iter->end_sk != batch_sks);
-	return iter->end_sk ? iter->batch[0] : NULL;
+	return iter->end_sk ? iter->batch[0].sock : NULL;
 }
 
 static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -3522,7 +3526,7 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	 * done with seq_show(), so unref the iter->cur_sk.
 	 */
 	if (iter->cur_sk < iter->end_sk) {
-		sock_put(iter->batch[iter->cur_sk++]);
+		sock_put(iter->batch[iter->cur_sk++].sock);
 		++iter->offset;
 	}
 
@@ -3530,7 +3534,7 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	 * available in the current bucket batch.
 	 */
 	if (iter->cur_sk < iter->end_sk)
-		sk = iter->batch[iter->cur_sk];
+		sk = iter->batch[iter->cur_sk].sock;
 	else
 		/* Prepare a new batch. */
 		sk = bpf_iter_udp_batch(seq);
@@ -3596,8 +3600,8 @@ static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
 {
 	unsigned int cur_sk = iter->cur_sk;
 
-	while (cur_sk < iter->end_sk)
-		sock_put(iter->batch[cur_sk++]);
+	while (iter->cur_sk < iter->end_sk)
+		sock_put(iter->batch[cur_sk++].sock);
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


