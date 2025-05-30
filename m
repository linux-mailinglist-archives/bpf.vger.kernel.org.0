Return-Path: <bpf+bounces-59380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6E2AC9718
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 23:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A344D3AB293
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 21:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484FD28314D;
	Fri, 30 May 2025 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="JyJtlqk+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D284211A27
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640689; cv=none; b=kt9lrZoCVHSrmyqVBCt2kdrdPXUTLtrxE7o6uBxLkZBKXpMCewlNr1tMrY1vgXCHB2TeTcF6YxhPC7YcuMNOAC+2KFNqyNCptDk466gtUsbX/Lv2mze46sTn+iuZJMD7W6q4dP0+EPwrjtyGer7nDN20f1gSzSjVVDbWoAwOHQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640689; c=relaxed/simple;
	bh=9DDxlxWCKSSenOqhiGVM2x6aQ69gEERQnVNmIkzJj0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwxga0vnw7whFbqUdfLMCKXPxxojf3pz8elAEYnOBneaUzwdCbHKzvVQZhcOzH/kFT+ohcK0zK3WON3akUeTJp12bOZnYwFPPMofdULW6iDssVek2oOJYEPUcrw8cAE0E80Py/DQLBCu7Ev6ubxNtXayMt8b9DlFdNwodJIY0v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=JyJtlqk+; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b2705e3810cso272001a12.0
        for <bpf@vger.kernel.org>; Fri, 30 May 2025 14:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748640687; x=1749245487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZD2VNu6uejAEqZZTUts1NgZ1BwG6tL+V2jQ1JGQmlsk=;
        b=JyJtlqk+NtOIgf2g8vtIed2AaMMNJaDL+mBSr/TH7+nAwzwwoBkzF14AWlhqCthbGr
         Xii3fhg5+fwilBW3PI075GgPnf56O4/QuHl8tar5+Dh2ed0u6pcTckFYzn0W9m1Bn3kx
         xIIFCyk9S2TlrBm3HVtRGplQNOehn0XtwMm084T9kBkEpXQFuhMe6dE0443l/iI6tk17
         SRHaXmPNojnvKtJVldt1l4L0KXG1SvNWAz2+TSqTHYLlkScVQROwyLA1l31fiuw4WmfE
         jxf5+UQTJSM9ECuYKWv2j/gM8zGRmJHkqy4OPOZQyDMsqIRqiOVRWzC1RZHJM+fqeIyz
         50dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748640687; x=1749245487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZD2VNu6uejAEqZZTUts1NgZ1BwG6tL+V2jQ1JGQmlsk=;
        b=ZY1rRpKLtzHoIR+XfdEJlJqExviDyqn34YiM8HYeF0JpbtkJ/MocOrsra25d4/KosI
         wp5m2WbT8OV5jGYtVQDj4Yj1kP2I+zJH8IxAKzmS80HdqGeHgyAzLDlPXuCqdWZCr/sr
         X6fbWWAVyyX0sZ8c7yeXNADDsQDMR4OsXBNiH+t/nZLvDG+2WR7p+9vONzZMYIzH+YmO
         ysgeZUNVXbovns6R2jvDH4q/bjsg1cCWWHBT2qZv9i8y/pDbj/JeQw+AZ8zPm+ZxxREJ
         4jyJu8LZmiseXex0s2M/MFYfPf1XcNhJ31ncHnRqoSPw0zGm4x83vGi89PbeFOq4lMwf
         UYNg==
X-Forwarded-Encrypted: i=1; AJvYcCXFKYhr1KEssj1UGavqfGg9RIU8Rsf+f9qZbaVCbn6acBQirtuziN0Sebs4zMC1XjuiYZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlEVP33pJ9AWlzKiEO3bV1NS/yk29eO9d2z3m9mYQ1yD6HTLCy
	ykjUcx3WBsOuvWKnIZ2+R/2U8vjBb7+0gnNDWkOpR+OEniX5psbg2qeU5jBZNEcsfpM=
X-Gm-Gg: ASbGnctgVJxdCQOkGQsbRWwpGAFFail1HutZjkmKdjp3Amgrvk3gW3QNq1HSxQUCkNZ
	f/7Yt0cw8EuJQS6fdCX9qT5q34LapLco6aNrrRMCq6GWbOHKroPZsR/L2v/D7cPDb3lRJRokZEo
	e3FrdUhKw0hTDVaURUg7bqKeyR4+1H+L1Zv5F4bIjxKbP91oGr1QS9t9mnEgK+1LsZircsK1Wwc
	XMdh9Ej6z201zm63gsphfvY+z4qRv/xwY4mlQb5n0nf0EvJhMrcuVc/JFSNCgS0Dn2w+9dmfhGD
	5EQmVK8ALTeLlvhMq3pvBfLN/AwfLexQk5eU574c
X-Google-Smtp-Source: AGHT+IHmWawHFF3mTsBHJhgKMNxJFagQgPvKjbNMLIiIY0QYn0Fzh6aIojepFd2gyy6eYDzSIAmoNQ==
X-Received: by 2002:a05:6a00:3d4f:b0:736:fefa:b579 with SMTP id d2e1a72fcca58-747bda6d963mr2732772b3a.7.1748640687636;
        Fri, 30 May 2025 14:31:27 -0700 (PDT)
Received: from t14.. ([2607:fb91:20c7:44b2:2a24:2057:271e:f269])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed4399sm3496763b3a.77.2025.05.30.14.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 14:31:27 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 bpf-next 03/12] bpf: tcp: Get rid of st_bucket_done
Date: Fri, 30 May 2025 14:30:45 -0700
Message-ID: <20250530213059.3156216-4-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530213059.3156216-1-jordan@jrife.io>
References: <20250530213059.3156216-1-jordan@jrife.io>
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
index 69c976a07434..ac00015d5e7a 100644
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


