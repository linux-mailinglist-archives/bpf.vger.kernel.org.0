Return-Path: <bpf+bounces-56856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BADCA9F7E1
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 20:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68C73AC417
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 18:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAF52951DC;
	Mon, 28 Apr 2025 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="OnpqG/EW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B08E2957B1
	for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863253; cv=none; b=tDFzmx+32Cz9efA0h9eY2Q3RJXl46FE9EPAadx6Yg3eqr3k3cQ5Mu6Z5mebMTDD4MU4Diuy6nD3hsjLQdzGFBsU8f9kwRiVdiD2KNmSjja3fLoMOh1sQSgbwKGY+bgqez5CkyKMW6sW3JD5mF9eYIXHfctKzsSchdOaIf3BmWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863253; c=relaxed/simple;
	bh=hVcaTKt+iszIasco79l44dPfxtLmpHpJm+A1tw9CwD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxP/L7V1b3dj+yBjZFF1Nn7OjcT/yjZKT83Mz3OY4nSsDEdkuZrBo+hUbMO/+YoYMV91MgDAtgM/TuwM5BgwJXtfzTC6aZj9nHnf2ozto/tP9wAMgwqPspX+gn5OKrvveoWcvlWgzgvhfLN9PbN1H07z+pAQuQrk1VOCu4QYxxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=OnpqG/EW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22403c99457so11828885ad.3
        for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745863251; x=1746468051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lXIvd+Bwv1ZCEE4NHcc/W0ZeyVCwUwS6L0uza6G9I8=;
        b=OnpqG/EWV5Fzis/W59/C27EJUn4QEQlJV/lpnQvvUfCKOpxhqyMrHHj+ZaPCscltP1
         sl85OKdtBbzePebSxXRgXScn6MMzwj7Oczer886/jpFKfR/y50/No9uyjs9FYx9lXudl
         Srn1H67e3/nn0kS+LcC5bNaXlS8L3wu9/gPzhDB6cRzqXuWY/zUAhTguFih7B4+zcvNk
         +dQU8FmWZpCnimQbAQJa/1YZJAAC4XZsiE8Q1nrOpO1714UurpjNwCnPj/Zj5dDRWLMC
         zc0fjFhVbbJG/cDAsf5iwzkwlB08okcGycwsnnPQ8JkMLrGpB8gRtpM1ukADzszedilM
         rJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745863251; x=1746468051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lXIvd+Bwv1ZCEE4NHcc/W0ZeyVCwUwS6L0uza6G9I8=;
        b=bcH3vtYDwWRz1jDd9rpwW3/33oAFXpW7B4EqysOITb2zZBBaCuuBFF9IjgwOfmaVWS
         K03/O5oeE2fEhDZva2N+LmV+5/JI5fHevH2HgiRVl8M0YnACxmKsTu+HWO/zZIWfb7k4
         SVSzG5K/6Z8Bd3fDcuygIe+mXuYMPlVGN3sYsb2AwmEm0bVlbbGPszOCqLvdRkcolecL
         Ve+tGoWPMLpisfFe0PS+y6YgdIdaJa3Jn0NGVkujANzzOcDMjwVJOgTRDhM6Rj7fPFQw
         AJ23Fqm8NTxLJ/jSEP7WBNKrnYA7xcI4yDmlXSQoX8sUu4gwU3Ss7X8P6H3n+7YmvVAn
         RdDg==
X-Forwarded-Encrypted: i=1; AJvYcCW04dePOZd3TGQFzPbcwnnwCZydU+ZUhAu2maT7dClf6Jb5pGpodddLFoaSa5R/TRLjVl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDnu6a3/vlFvsNF4vOMDFfX4X2+5fXFzSPqPsd4BAAaAU2UpRa
	tJL87tjvZ6f9QrIF9jgh9oZ4saYSTK6oMX3kHlRrDjfh79XIIdKyaiq0P4GF9+o=
X-Gm-Gg: ASbGnctrwG1dSTUSSWlGl2UQH15QfV69PcD0Fi6KSvChLTF82XrXpz1b63Uz6iY2oRN
	s6kzZGe+jsQTDJi/hBg4bZsDhIIMPvuEZPOHyli/H+rgsWFSw9IrpI4JaVTK0V/6vAMtmTO0TFR
	b3tbXOs0CUoIBwYxXS4DGa/AksSLCtfKtk2/35O0v49y46L6CXw2Nr5d7u5qSjDnEZpYPTbXsqc
	K6xh1BoXLRfCaVpvxoWWMSGzffJOneZW/RlRuMmP4Y9crYZg0tIffvSzNmgFOsf3PhZDZy/rBZH
	mQicPFY98gXFBPfazDNJd8CXdA==
X-Google-Smtp-Source: AGHT+IFwuJ39QFgHSmK1OhTb5CX+GoomUkhaYSki6PhJF2vvcS+aeS/GLoglU6ZlWSgttkUtdICyqw==
X-Received: by 2002:a17:902:c40e:b0:21f:1365:8bcf with SMTP id d9443c01a7336-22de6edcecbmr209585ad.10.1745863250737;
        Mon, 28 Apr 2025 11:00:50 -0700 (PDT)
Received: from t14.. ([104.133.9.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52214ebsm86204235ad.246.2025.04.28.11.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 11:00:50 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 3/7] bpf: udp: Get rid of st_bucket_done
Date: Mon, 28 Apr 2025 11:00:27 -0700
Message-ID: <20250428180036.369192-4-jordan@jrife.io>
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

Get rid of the st_bucket_done field to simplify UDP iterator state and
logic. Before, st_bucket_done could be false if bpf_iter_udp_batch
returned a partial batch; however, with the last patch ("bpf: udp: Make
sure iter->batch always contains a full bucket snapshot"),
st_bucket_done == true is equivalent to iter->cur_sk == iter->end_sk.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/ipv4/udp.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 5fe22f4f43d7..57ac84a77e3d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3397,7 +3397,6 @@ struct bpf_udp_iter_state {
 	unsigned int max_sk;
 	int offset;
 	struct sock **batch;
-	bool st_bucket_done;
 };
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
@@ -3418,7 +3417,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	resume_offset = iter->offset;
 
 	/* The current batch is done, so advance the bucket. */
-	if (iter->st_bucket_done)
+	if (iter->cur_sk == iter->end_sk)
 		state->bucket++;
 
 	udptable = udp_get_table_seq(seq, net);
@@ -3433,7 +3432,6 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	 */
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
-	iter->st_bucket_done = true;
 	batch_sks = 0;
 
 	for (; state->bucket <= udptable->mask; state->bucket++) {
@@ -3596,8 +3594,10 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
 
 static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
 {
-	while (iter->cur_sk < iter->end_sk)
-		sock_put(iter->batch[iter->cur_sk++]);
+	unsigned int cur_sk = iter->cur_sk;
+
+	while (cur_sk < iter->end_sk)
+		sock_put(iter->batch[cur_sk++]);
 }
 
 static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
@@ -3613,10 +3613,8 @@ static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
 			(void)udp_prog_seq_show(prog, &meta, v, 0, 0);
 	}
 
-	if (iter->cur_sk < iter->end_sk) {
+	if (iter->cur_sk < iter->end_sk)
 		bpf_iter_udp_put_batch(iter);
-		iter->st_bucket_done = false;
-	}
 }
 
 static const struct seq_operations bpf_iter_udp_seq_ops = {
-- 
2.43.0


