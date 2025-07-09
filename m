Return-Path: <bpf+bounces-62850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA1CAFF526
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 01:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9124B58733C
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 23:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA22248F77;
	Wed,  9 Jul 2025 23:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="exFOUH79"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E0247294
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 23:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102225; cv=none; b=u7P0RgYUBw/kyr3lvhd0kHcKtJHwD4+AeO0h9/sGnSyXsDWNBG6sjroVbBDi+b+0zMhA1dfuQ/LqkEEiJr5YqYKpizu8HFVbimtjkSQGBti/sKTPwXMJ+h9SPcbMXomw+y5eUIVl0DRHBwVmOsjWGjNUlVtg9UteH1rDdeid+wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102225; c=relaxed/simple;
	bh=+RKf0LxsahCX0ru/helpwnqrzojewAmbV20fE5ht/Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFLj7+vnIlMkwaF/qYdn6UupW4VbNNWP2hUelqbbsbORnU4ppCjNUDIIUOH0CSij1uPcNAOFXbj6Gyg+sru7Q5KS+9VHdvu9yXSUtn9M3rqiVz96tE29HfNt50etrvdciHCpbias7hqhOLqGQoLGqVTuqFegAGUBv+umtiFjg3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=exFOUH79; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3138e64fc73so95747a91.2
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 16:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752102222; x=1752707022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAN5AN0xB7TXy/kniPi44+90iocjGvN8izS4op7BZfg=;
        b=exFOUH79PgryF662b4qpEdWmg+J66q3686VukBs99XE//51g2QQYyB2Qksz6FDeLze
         x2YPvrSpCN3Sm17DbJ08cqGN048Wvw5F+EGyki/DzsarrgHJmRai8k3sSkes3gotmAz0
         J9MGP6Nk9jVa3jCJYB5hkwqB9ujJP6F591MhrpaEdeJxO77clA1HUokh/a75qCPloceE
         yu5MBAuIcONTFW7wlZd/nj9d8j3uyW/KJ0H3/x4J5JjT8S0GsZTzd5JOS2v5/9h3qeWe
         qoBRj4POYi+6KV/Y0Im3kI4TXPT56B/MY+dVkleHeKLGkAtOoSxfEZwpvAmx7H8o8J8i
         7L2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102222; x=1752707022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAN5AN0xB7TXy/kniPi44+90iocjGvN8izS4op7BZfg=;
        b=O2+8tRHhjhPNl+DaK5dbhE+QZdevzUUQXhG9qPB52VjS54EDpLdD6wBqrOPzukOqnm
         dOHppQ00POJf6Cvg7r+Bk3YZA8lJ7R13bn0/rn6lLIzQl7M2813MQ8v+ZKtOMxB3ywHs
         KCKsoWlhFgP3QOLB9MwUE68tAEmQ193h0B9+PHh0pDz7VJyxHlm0y/WZUSpa/yGyDD4s
         b+CTVPQEOmWmYCi2F00Ch25t4wa9qxoS2M+s92VVZS8++pNurcl2EIEVymfUB8fpoiuy
         gPyWh7njAAYBTvNPNHFxDN8+D1QYtam9J34rekznbBAxQtf9kIor+u3epNCYfJl8Jw3a
         pP1w==
X-Forwarded-Encrypted: i=1; AJvYcCULevNHyGt+O3N/8xcU26oNlG/2g1b8MwXPwQCLeKcBG6qDdi5nYlpj70j4ZzIhiKeZ4tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoT5YPIOzgzGuJUDOrTmxfNnkLihyZYdWO/XN4T1rbIqvXQVwQ
	vBB3tRew3XawqPj3ovOtOdlWoVWAYKhCQrfRrbso49jlzL+cirGaMOxQHtS4mAvX4/4=
X-Gm-Gg: ASbGncvyktNG2gfM9U1IzytMgnDKlseoAWlU/ea8CHSnXMUfr8nWlp0gDTuVLpuIXqF
	DhPOnwgseGLWQbQTYwiZ+zgaWYsrYCmz7UTC3y7gEcbFDgtRL1y8qCAN25Z4tJAE2PNokpD1qYp
	uFdYYwqbYxd0hJLSQvC46qunwW+I7v9d7JYly4H/UvqkpHom82N69s9cZOyOSL13R0QxGH2Vn13
	obxkpZDBzd2xNfbc630DHb4PnjqVZEjedZfYl6qdtmqaQ8nIB48XBBrO8mLOOBlWc58lBh620H7
	mPBGfjTZ7tNthbiZnbiaMoDfjKnd9c4TlLvXOsm8h7ctVO79YCI=
X-Google-Smtp-Source: AGHT+IHSoJwzENzTIfZhllIBHiecT93lNyBcFcvHruQHLyq7n/zbrP8I5l/7X8R5Y/tmlUtHXMQgCw==
X-Received: by 2002:a17:902:f543:b0:23c:8f17:5e2f with SMTP id d9443c01a7336-23ddb1a6058mr26803935ad.4.1752102221585;
        Wed, 09 Jul 2025 16:03:41 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad212sm2679015ad.80.2025.07.09.16.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 16:03:41 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 03/12] bpf: tcp: Get rid of st_bucket_done
Date: Wed,  9 Jul 2025 16:03:23 -0700
Message-ID: <20250709230333.926222-4-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709230333.926222-1-jordan@jrife.io>
References: <20250709230333.926222-1-jordan@jrife.io>
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
index 8dfb87be422e..50ef605dfa01 100644
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


