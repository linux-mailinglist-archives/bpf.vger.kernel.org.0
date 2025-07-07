Return-Path: <bpf+bounces-62525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B70DAFB7F2
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE53C1896EC4
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 15:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29492215F4B;
	Mon,  7 Jul 2025 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="tk9RBVoZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A3E213E89
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903473; cv=none; b=IprzHZZbP/y3ziKcwd6Ux348g132w+DgYop8Wr7hrnGdr2mFc/kESlxAgvaqxxmEHAfYvHU9aeCxC1THU6p5UthPBhKNE8AGLRIsDPonZJn3ML+WNHRhs6n6WhuezfmVOYkynpSHGn00lPUrAlWRrWoPoNL7mgw2QXIyKTugwnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903473; c=relaxed/simple;
	bh=e8mBfD/Mf3WsGUcN/cZCls6eAizCzOkMUL7ooN31tjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9POaL8JtKh26afwuPHISgCa02wLNO+PoyAdOqnmuFSnmiPobVLZ3WdXoCDxXLLT6FDseAMyHfODv/vGDiDYTZmjM6FBLmuHA9/k8Id53kHaBpJMYS96DuNewU1Ai3RTXIVOmqRD1h74O74Q9dgL0QJrZ3eArIbpBqWGhC9Zlsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=tk9RBVoZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2369dd5839dso4792115ad.3
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751903471; x=1752508271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RahNzvE7Os+o3No4Ak4PR/YrMMvz2u9H0FwyM+5TYQY=;
        b=tk9RBVoZQxFUzQ7vdNduEblfbCUOAODt3f5jUDYBlHKoLFZRMFHZqVvMPhuJLgGq+c
         db40oVOrUEDa11YIoECPHuBCLc+TvIPWarzKWYobKgzie3m6P0p33KpY/lgAqaR5gBD7
         W9SMSJYz52t4fp5YgsRTiZX9CjKZQTFjRSNlIVMGfw+9Uu3x/9/EZGw0XWod9ScsRyCX
         0/lBzAImVnQuAjCkDCmkgKxgH4qbQBRdV/WaXmM/9Of7Qkco23bU72ZQxZ9zAi68IXbO
         reuoKnl7cUjyVayJXzuZ9VrQlSZUIAVJf24iJKq+d4/g8Ui/ouuGARqIuidSj2R9AAm3
         incA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903472; x=1752508272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RahNzvE7Os+o3No4Ak4PR/YrMMvz2u9H0FwyM+5TYQY=;
        b=FdEDlp8pROBDIwSzMmcjM8MmlBOLjaZeITLGeKspmwiQb+Ve+99IwNjYgOpInRhlg7
         yJmYmyryjSSgXgRyfPONE0229SzbrX6hOXlPlWSUl8V6ejZQ8pnGiVtxtASWcwegXDfh
         rUVeT/puyT23K862XKpn6JvoOAT5Wrhs1ORktL+Qz8QQ3M6QLDRKWgEBo59maijbkWNL
         mNaA3yuPOLXQzxtMcGTgglVxBbqOWd/Uci64BgNMXz0XhrSz2bw6KdghtGVJkkD1Kqa7
         7N0q79WNx4x2uqsMVrjIeyI4OinX90Lkr9voBCnXu4LowuedWdIR9um/mbkrnmTE44Nw
         d5Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWiuBinWAiqpEy1p4URXb8+kUXuqs6bN20hDUNvdPdrp1+UmrHR9y89df1id2e3Jd+O7I8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2pTQiRMUkJqoygSNFWipps53OK2iksmU7lAAlCfkCI8i8mfmS
	el7gmiJN3jZ2/jV448klMgLFreW2Wk4OUCuHVS4lSMSF1VFdhju+EDPj5X7uElpBUVM=
X-Gm-Gg: ASbGncspjdREZFlM2mzV+umlBzzCkI8FnXVgO+6nGdNEeE9Qy9z35rRNwhxMID4Pf59
	pHlZZ+pNAmEDOGJb5KUCiLS6kvLghmwubeaZ83+OhrEPC7GJ+sTmWbBdu8ZaddXd7mOt/doC5YW
	/KvgiZV2mKhlBb7pcRb8L7HaLOOgfLSMH5NadCoj8l3+HnSvOfSBoyzF4KediNjk6KIi35PAfAW
	exxg6maKMS87OSkMFTQl9EgQzhn1wujRfWbabDTW7epx9ZRu5KDHkLOBsX6dtsV/bgzRIZlgJeN
	kVt2Dh0+ERFtgCJ7W26tU/CNQs8UDGJBiZx+4Njz6MRcZ8uXya0=
X-Google-Smtp-Source: AGHT+IH6IkZ61Q4RdWlbcMoS/QrTX2L0cUPDRjHCnUFiQTwiLkIu8zdDVNY8MTVLkGFEtfPP3jFRsQ==
X-Received: by 2002:a17:903:2302:b0:234:bfcb:5c0a with SMTP id d9443c01a7336-23c8726fe7emr74216665ad.5.1751903471664;
        Mon, 07 Jul 2025 08:51:11 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:e505:eb21:1277:21f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455eb3bsm95772065ad.115.2025.07.07.08.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:51:11 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 03/12] bpf: tcp: Get rid of st_bucket_done
Date: Mon,  7 Jul 2025 08:50:51 -0700
Message-ID: <20250707155102.672692-4-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707155102.672692-1-jordan@jrife.io>
References: <20250707155102.672692-1-jordan@jrife.io>
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


