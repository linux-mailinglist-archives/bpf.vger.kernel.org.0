Return-Path: <bpf+bounces-60965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD3DADF297
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C151BC345F
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2879F2F19B5;
	Wed, 18 Jun 2025 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="HW3XMvyq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7F72F0C6C
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263954; cv=none; b=dkURb+2paidNuhb7Am9ZE4IMICuHb6JCpQxJrqRboxvZIvYPN+p0vHRNbp+U18btKvTQO5Z1hzejqM8o2Va1KhrEDKjSbqssd62CXyvy6Yr1X/yn+stHovPxLwnCRZvlJCKLPremoRiXbop9qT/Mo45CeGsHhiThjQh0Ubj7C4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263954; c=relaxed/simple;
	bh=9DDxlxWCKSSenOqhiGVM2x6aQ69gEERQnVNmIkzJj0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZ7bfsq7MfJzSu1tUvGWNcLLMgqUsnTOkhFwfFAhR+TKSd0j/KVy4GsOhgRKhbBUiQRw6sZ/0nZbxZiKFQyvd6jywp55htY06/Myc6om3JA18E9uPNmTjJq/7zRnIcFDQClGcJITBhjKaU3L+6OzTeuMYMon6k+DvFul1hox0JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=HW3XMvyq; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31308f52248so1246701a91.2
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 09:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1750263952; x=1750868752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZD2VNu6uejAEqZZTUts1NgZ1BwG6tL+V2jQ1JGQmlsk=;
        b=HW3XMvyqvpDZrtdd2Rh3a7Xo1BmLJryCNMosdxhqBWkrx10o0PzTvEpBcAAogzFYv1
         IAf7JGpQlDjbwrFAfP82su213W0S8jX65q6O/kfq3qycqjKiZj6Xdddt+Nc9N6yG4CkY
         30fWMMXAon07So4u1nnPLKUVjWRi38YwqVcCCWjbiLqqlKmiEnHY3RsFSXyZTSu+dMm8
         DqUKTKmYrqwLynil5vihNDviGnBAWmYNc2tLxknk8Pz7QQBxlF0XAYCAKIi2s18tSbE4
         qDSfe/gg361CdFKzySnxJMNncoDpWcl+hdCxKvXrBgJG0lt6NJj4PhwzESJUBoZ89ovr
         YPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263952; x=1750868752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZD2VNu6uejAEqZZTUts1NgZ1BwG6tL+V2jQ1JGQmlsk=;
        b=PFJIExt34VxL88o24OotnjUO47igrnFQoK4y6t42JlMPY7Nia239FUSBKgi+dX1tmE
         GV1iXtnM9W+GakJTVc8V5H+EDy+XYOzYKq9IjENZir6KCJOlRbFAe2/y6U7c/UBKRhA7
         HeL6rif/Tg+rlr/DC7vZiuMytMXvcYXoSBQ/87fKytQ/stOPsSZr9wv2GiFzrpHo6LRh
         eHvqNQ8Mw2w4NyS2Ofyt49PG4ZsZYNV8enZfs1hDs+dlaZpSCtd8JIXQr+dw1RZQotbX
         zh6tDLUpwo2hS/GPzWNqUoDw63wn+lSk+w5cs28h7JCPrcnqv8Bo55lmkhAhbXlBsaNR
         lWjg==
X-Forwarded-Encrypted: i=1; AJvYcCXSrad6vop99qXko1XzXMb9u/mCWzM0JFoUKl6nw/fAX7+W0fon2jMOOj1VKV286dXM9as=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQprXY1IXaVFZCAyzAmt94VxtQnYC/WyTIGhXcoG2szLc5OWmh
	Dwwf2b1uDDv83hZsm3Qvsjl35eidwJIEPXWoaJB0YkLnj1HfKuz/anu02t/NG29bE6D68GXJil0
	OZEDV73s=
X-Gm-Gg: ASbGncuufKccAxNQhWEgRETLysx4KAih6G6dkQwHeHT/GPBEfLdQRvI2ubU19Q4NVl7
	ZrrSs0cyLR12kRSPU45+peTOgUe7M7Qdj/3pMTFUkGLOdUX4xzE8MdMPfU+4Sc4NOBnfETiN8VV
	qh9glGuSVLPWAO1e74H7QiYMIpD9EEYSCONKEENTTs7mMBmWHjWssNQuaQokcF7odxodoDyvKDX
	5fhWEsbhCXgHqXhfFUTXvHCLQ6zliiRbuW0FOTo61oBjHcCuAA+gE5VtnQd8WWhghmOh1OK3UaC
	Dvw789jQ1rBnU0z9ZGpe5k70Y69notcO6Db8ZOKB8MtmEIJVt+229OOEu+mi1w==
X-Google-Smtp-Source: AGHT+IEw6W9AsUE77NEHaLSd91ZkqkVkaSJuKydeeXkSvQV7I069q+NQQsbcOLozCQVp/98mbiA3MA==
X-Received: by 2002:a17:90b:1e07:b0:312:25dd:1c8a with SMTP id 98e67ed59e1d1-313f1ca7763mr10704555a91.2.1750263952182;
        Wed, 18 Jun 2025 09:25:52 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d683:8e90:dec5:4c47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2768c6sm137475a91.44.2025.06.18.09.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:25:51 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RESEND PATCH v2 bpf-next 03/12] bpf: tcp: Get rid of st_bucket_done
Date: Wed, 18 Jun 2025 09:25:34 -0700
Message-ID: <20250618162545.15633-4-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618162545.15633-1-jordan@jrife.io>
References: <20250618162545.15633-1-jordan@jrife.io>
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


