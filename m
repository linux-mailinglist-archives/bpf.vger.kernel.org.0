Return-Path: <bpf+bounces-58572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B71CABDE2B
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 17:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265724E35B6
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384732505A9;
	Tue, 20 May 2025 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="WIBEWeGX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4024EA81
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752683; cv=none; b=X/Jpozpfncvv1/v3IFvW3cpvPuZiWrep8GkSldzjMZ8zfLx1ct2xlN5Cg55f6R5UtN1wk773lhivm2+170+D/8eB2CPuDaAMWxbgSyDilV3tS51wd3+kvJbkcP0FGQYD+jl6n7dyxiE06TbE5SMV5/j4YnyYkUJdEwstWvvpj4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752683; c=relaxed/simple;
	bh=ynwETJpAQXdvHO4YIxALq2Qy8Io8I2yE+v757vC54JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoMSAFefq2bLAkJqaxmcUaLjHR1+CuCGvZto7P1RkYBYngGXP+UxOjCUWv5qgd6Y7aXJU3TY2VYwUXxw5uUECASt76TAeVK+KVwLeFm/hWHuK+rDGEwKvG4nmcTq2yUxePXVSHkV+LNd28r9P/huSrJX8sF+DrGxkkvE1MiaO1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=WIBEWeGX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742cabe1825so136584b3a.2
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 07:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747752681; x=1748357481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vqk5rW2rBw4c0vS6MV0Sw5MeQBuB3Pl99Ow2SgXtEs=;
        b=WIBEWeGX+mWiSycbnCd04Ub/hQJpwF1r8NmvMiuoVKPwdeFwBaDRmg7WwMObmeDxPV
         LbtJ6E7yIiQMhfF59Mqwr+ZtI+iHCPAfUfUDiVx/IP9pGjymqKO73Uto8YWm75otMNHg
         WVtilO1Ca9M1L9wHWNkHJ0015nprOCIy0bNps8dDOVvazvj9PPSrbs3607YZfv6Hz7Pr
         7ogP1U1rZrOycnEdVRvgwA24FF1glk1AhPbRWU27MzEe2FWp1EP52NQt4r4BNsDqk4qy
         C/foqOeeJzsdoXyqarrccIpUVvwL4It9p+3xe5hNaz7G27Q1iQyN/39jVpdB4NNiFYaY
         snxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752681; x=1748357481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vqk5rW2rBw4c0vS6MV0Sw5MeQBuB3Pl99Ow2SgXtEs=;
        b=SGF4/gwLJ4Sb8ATdd4MNLT+8JLWqOH4CYjKXqaJ+33cSUlalGXRy0HvD6Hbp3dQ1SH
         +qVbEEaJtWKWOirdca5epF8glUkFiMkTutfzpL7UCM2ZvCeeCUwRnJNJsnii6BXzBkhc
         av0Y0Oj97d9SRN+Y5NR2Z0fb/E9HuNEaDlAI7RyVtlgl1p5Ftno6MMzvsiUrAZVkvlyl
         rsmVIQhynVW3C57SMZW7PhLpLirK3HIjEYyGuChBSQ5gNvV5YSr5mM7erKP24h6Yk2/e
         kvgMT15WxHxXex2jrcAzleyKsSHx+7Ibw5hGCayLzuVwYi+nWrBsAwdcs0AtHpzDFh4c
         izyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg9jhF7sHJENVlXvjF1n1QHhZI020mbvRCV0RqAQGR+UQZNyZ0gBeyg6nhQTSClJyuy4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YysvZq9q/kHg/QVfaP8QOtdsRHs2P8YkBqw5AlKGWB+yBTXdlfv
	/8xoQQzrR7xZ90+jRDA07qqtXKjOzoU0X2z/cJ4or0O3OUp75GqIqN3h77OYGy8KXj8=
X-Gm-Gg: ASbGnctl29DToYKBmhjJMwkuLO2XpydsU/Rjs8X4k28KDbTnJy0DBcvwBWGkT2eloIR
	JQxJKotP0Sj3lDdOy5bpwQdYmgWVnue4rKEHHjp/LecDm8Opw8sv1aG5PNvbPzxRHdxsqw/veu3
	bDkvoKboWZgefuU9EB9QK1SvWgwh3+cf2RBNuiGs1x2TUQwQTejRhiqINdzpmPs22CKJ4AqkMyE
	63SucD8q2JHAIIArcko057EtaHdGd51Qlx5nHzSP1v24MYuyduGESWR+jAiERf97yxjgVFia3CF
	cq1U8VIbTqweSQo3TyJUWL1g7OvgcX+zPb9izDmx
X-Google-Smtp-Source: AGHT+IGP+iFZP2CLdnN2q9QLH4oib9KY44ikNhgPm6ahIcsfTt1IKVVI+TMIWB2LAJQ126k2qM/30Q==
X-Received: by 2002:a05:6a00:1ca7:b0:730:9a85:c931 with SMTP id d2e1a72fcca58-742a993297amr9873455b3a.7.1747752681582;
        Tue, 20 May 2025 07:51:21 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:276d:b09e:9f33:af8d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829bb3sm8242993b3a.100.2025.05.20.07.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:51:21 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v1 bpf-next 04/10] bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch items
Date: Tue, 20 May 2025 07:50:51 -0700
Message-ID: <20250520145059.1773738-5-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520145059.1773738-1-jordan@jrife.io>
References: <20250520145059.1773738-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the next patch that tracks cookies between iterations by
converting struct sock **batch to union bpf_tcp_iter_batch_item *batch
inside struct bpf_tcp_iter_state.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/ipv4/tcp_ipv4.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 20730723a02c..65569d67d8bf 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3014,12 +3014,16 @@ static int tcp4_seq_show(struct seq_file *seq, void *v)
 }
 
 #ifdef CONFIG_BPF_SYSCALL
+union bpf_tcp_iter_batch_item {
+	struct sock *sk;
+};
+
 struct bpf_tcp_iter_state {
 	struct tcp_iter_state state;
 	unsigned int cur_sk;
 	unsigned int end_sk;
 	unsigned int max_sk;
-	struct sock **batch;
+	union bpf_tcp_iter_batch_item *batch;
 };
 
 struct bpf_iter__tcp {
@@ -3045,13 +3049,13 @@ static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
 	unsigned int cur_sk = iter->cur_sk;
 
 	while (cur_sk < iter->end_sk)
-		sock_gen_put(iter->batch[cur_sk++]);
+		sock_gen_put(iter->batch[cur_sk++].sk);
 }
 
 static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
 				      unsigned int new_batch_sz, gfp_t flags)
 {
-	struct sock **new_batch;
+	union bpf_tcp_iter_batch_item *new_batch;
 
 	new_batch = kvmalloc(sizeof(*new_batch) * new_batch_sz,
 			     flags | __GFP_NOWARN);
@@ -3078,7 +3082,7 @@ static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
 	struct sock *sk;
 
 	sock_hold(*start_sk);
-	iter->batch[iter->end_sk++] = *start_sk;
+	iter->batch[iter->end_sk++].sk = *start_sk;
 
 	sk = sk_nulls_next(*start_sk);
 	*start_sk = NULL;
@@ -3086,7 +3090,7 @@ static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
-				iter->batch[iter->end_sk++] = sk;
+				iter->batch[iter->end_sk++].sk = sk;
 			} else if (!*start_sk) {
 				/* Remember where we left off. */
 				*start_sk = sk;
@@ -3107,7 +3111,7 @@ static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
 	struct sock *sk;
 
 	sock_hold(*start_sk);
-	iter->batch[iter->end_sk++] = *start_sk;
+	iter->batch[iter->end_sk++].sk = *start_sk;
 
 	sk = sk_nulls_next(*start_sk);
 	*start_sk = NULL;
@@ -3115,7 +3119,7 @@ static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
 		if (seq_sk_match(seq, sk)) {
 			if (iter->end_sk < iter->max_sk) {
 				sock_hold(sk);
-				iter->batch[iter->end_sk++] = sk;
+				iter->batch[iter->end_sk++].sk = sk;
 			} else if (!*start_sk) {
 				/* Remember where we left off. */
 				*start_sk = sk;
@@ -3211,7 +3215,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	bpf_iter_tcp_unlock_bucket(seq);
 
 	WARN_ON_ONCE(iter->end_sk != expected);
-	return iter->batch[0];
+	return iter->batch[0].sk;
 }
 
 static void *bpf_iter_tcp_seq_start(struct seq_file *seq, loff_t *pos)
@@ -3246,11 +3250,11 @@ static void *bpf_iter_tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		 * st->bucket.  See tcp_seek_last_pos().
 		 */
 		st->offset++;
-		sock_gen_put(iter->batch[iter->cur_sk++]);
+		sock_gen_put(iter->batch[iter->cur_sk++].sk);
 	}
 
 	if (iter->cur_sk < iter->end_sk)
-		sk = iter->batch[iter->cur_sk];
+		sk = iter->batch[iter->cur_sk].sk;
 	else
 		sk = bpf_iter_tcp_batch(seq);
 
-- 
2.43.0


