Return-Path: <bpf+bounces-61864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E189DAEE57D
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 19:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E5F3BC719
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 17:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB7E295DB5;
	Mon, 30 Jun 2025 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="vFQimYCk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C50328DB5E
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303853; cv=none; b=CRI8AZ7p/pXdjQlyTmFDwN6KtSr97S9JyatZmEjWjYArIOFItjFKcEIzKztXcICbL5q40QXIou2cXD0STCjHPI5Q1035y+E2/cR4pzh50i4Kw1+cHiYVPvVCxRPtqnzmAP3mSYDnEGoy/7MMV1TE2699wHEqrdoTsNPUPCUm770=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303853; c=relaxed/simple;
	bh=e8mBfD/Mf3WsGUcN/cZCls6eAizCzOkMUL7ooN31tjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEJP7vryKEd71CxhRynNkZXbraybGmwLdDFTPOGasReJCTfHXlxENTZPRAy+6rvO7tncTWDyc+YxBeZeHuce/E738lx6qMruTmmUvsyp8vhdg8b6U8Epj8i3BSfWAvTr4TfBOP4HU5BEnEgyNn9jjfze6w6qY9McqJTbw99i/jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=vFQimYCk; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74b013aefbdso237848b3a.3
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 10:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751303851; x=1751908651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RahNzvE7Os+o3No4Ak4PR/YrMMvz2u9H0FwyM+5TYQY=;
        b=vFQimYCk5dLap2P4wsfAVEL7VZZrSAtdozcBrwf5vV+xoX8RBh8PniMC9DvuDEno0F
         HDrnhs7AuKAB6CEDpRlc8aJOUuHr7V6HMQMqiRA3/tv7hx7Cec7/L2TJ5Ur4k9MqopVH
         +oMmLGmLcXMTLEFZa38jl4ewdF3Mbr9Sj8jiVCFjZ9AXQ7Y7jDy1DUm3mq3UAQfSxNzA
         0zz2P8APmzyvG7OU/tJAHxLy3mRbqrbcm1XnmPW5uDdMEbNiHJOgBfk4dayawqZG7hP8
         lQ5pu6ZBOqoqRTWxgCQ84Cx+/27H3L/OcOFd3br2tiFo6SKvKi7AjBksTTRV7ojIgrjh
         D+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303851; x=1751908651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RahNzvE7Os+o3No4Ak4PR/YrMMvz2u9H0FwyM+5TYQY=;
        b=WAzf+iEl0ZPCBl5MqqlewaKy1LiCx1VDEwwAdM3yGdmoHftCU7UF2V6FslSwtovX8g
         I16oAme4T1xjBTMDGKtLGpZN0SxhZsYeOxwIP1DW9L8ZSo7/+8kHcpmeJH7ReN63F7KB
         VBXEmxSa6AbilBPCmT9//NKSKXcOj28VKPSrdNPvy3/0Dq95aALcZWqChIQhb2o+OQrJ
         6wSnDM8X8kv+M2QuvsqOSOXqUZ4dtYk84Qb8OOQKr0oyaUvbl2hRkDUOd/pfFGQR8EaY
         YEXOu9lYyD13siE4Ww6o+/2x+X+tV6hLE+fWSONQ0UNdgXuu7bDcGDL/ytgkmvX58tDe
         dVaA==
X-Forwarded-Encrypted: i=1; AJvYcCVAtFQKNwQvQ1MdArdGt5hBVHVIMokmSl6ynoLH46QqodeAbSfpjQoHL0wF5dAzNTRc8tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzggBGtyYuMjR5oKL0/6xTSbV+xbUEclMeEx8MauzmvKhBFyva5
	aGh3vHhP+XZCWp4gfW/84LoQKDsBm/QKei/S2MIj2CK9H6Jarzq8ZzeqME/gqXfXWik=
X-Gm-Gg: ASbGncvINUZiIMdJ7tcd9Ofk05ZcJMc4/pKLVTwsyOMLrstdhXGOr1i9Wx3b9lQJXxz
	c4/YtjsxSe10HwMLP38AEHkchVZVoQE38T3fKkFsmksu9XyvmYSQHTwI8cig0Uv9cAg3BJxasZk
	ul4HM83hcgEGbAC+4crjjqbwa5UyOcMjhsm1Un2VorCtkL0jEkqFFFJmvvTkP0rf3jOsBEg9T1h
	fgSkpUVZK0jKtMDYF3JkmeMqnRJXMUxThoLC1SR4yvEZzjwCkipirGAQ8cNq72bt8Oq2UG0rD28
	m7cxnivvbwXddj0lvGVtf23W1ZdgjnDW3OXgWjeHm4npd1WzFg==
X-Google-Smtp-Source: AGHT+IFGNjjJIhVkPG/QQMfVQcXOd/Ojx6HLdpOsBFHvjK1apNAW3lIOzGfCBb8CFbFyZqj2wR3NIQ==
X-Received: by 2002:a05:6a00:340d:b0:732:18b2:948 with SMTP id d2e1a72fcca58-74b0a4ed5f8mr4967622b3a.1.1751303850681;
        Mon, 30 Jun 2025 10:17:30 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:9ab8:319d:a54b:9f64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a846sm9229232b3a.31.2025.06.30.10.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:17:30 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 03/12] bpf: tcp: Get rid of st_bucket_done
Date: Mon, 30 Jun 2025 10:16:56 -0700
Message-ID: <20250630171709.113813-4-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630171709.113813-1-jordan@jrife.io>
References: <20250630171709.113813-1-jordan@jrife.io>
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
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_ipv4.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 565afaa1ea2f..8a1fd64d8891 100644
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
@@ -3161,7 +3162,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	 * one by one in the current bucket and eventually find out
 	 * it has to advance to the next bucket.
 	 */
-	if (iter->st_bucket_done) {
+	if (iter->end_sk && iter->cur_sk == iter->end_sk) {
 		st->offset = 0;
 		st->bucket++;
 		if (st->state == TCP_SEQ_STATE_LISTENING &&
@@ -3173,7 +3174,6 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 
 	iter->cur_sk = 0;
 	iter->end_sk = 0;
-	iter->st_bucket_done = true;
 
 	sk = tcp_seek_last_pos(seq);
 	if (!sk)
@@ -3321,10 +3321,8 @@ static void bpf_iter_tcp_seq_stop(struct seq_file *seq, void *v)
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


