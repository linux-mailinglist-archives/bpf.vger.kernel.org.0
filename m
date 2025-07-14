Return-Path: <bpf+bounces-63226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFE0B0472E
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 20:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A71B1A61414
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 18:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B6F26D4D7;
	Mon, 14 Jul 2025 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="2XlkrjZa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E9C26CE09
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516573; cv=none; b=rkpO6YiV0aWUAcoajlojELaws7oGjL2U5baA9P81zh79vu+1HuseW+MnwdirvoWYaoZ5VFBMJ0CCouwH+gP4aQIqY/+0s02jd8BVki4tFI9oaZAWlw5vngbod4vZ4FYsMhSGT7pVBmdt1djbBE/f3rlHPYSrFH3iFFIeR0MTC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516573; c=relaxed/simple;
	bh=+RKf0LxsahCX0ru/helpwnqrzojewAmbV20fE5ht/Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGOUvww9DNWZHX+4G8+kgIr+ucBJekP9piU2jwDtpqfY45l8ztMxuk3+MAavAIo86oczycURYegBpv2kFIJQ9O5lTdUAvc3yMO+LJzWlkZLO0ZtDhKJmUtknovcPLUdnRHua4A+m+dhJLZmfdVGu37tuXiyEEc4EWVItUdoRZmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=2XlkrjZa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23c8f163476so3651875ad.2
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 11:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752516571; x=1753121371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAN5AN0xB7TXy/kniPi44+90iocjGvN8izS4op7BZfg=;
        b=2XlkrjZayJJU1LMdUuGvmhToX1Sf++XCI5iQujp2ANINZJ95ieS5J9mij/io0/b3aq
         TaZJvwXUHWD4F64VCvUiKprgQ+LoxY68DjZ2RyPL0fny3BloF9RN3fSPeiCfUcfVmH+W
         KXFBcv7531ZpxQXvIG0c4kN5AaEFffzjud27NnjgkVIVnDNmeOLxjra/GNJlgD2Zqy4O
         EbztMtrzyYL+cQbxl/QcWmHHkOUJCJhUagAoBW+qXbBbMU0+Q/wdN9+o6CmoULcm7Zis
         urdni6DAlyo7mtlxqdInNsqAAXIdG4QIG89inCTYvDabl9LgpwyEZlpjyD1kAptL56jx
         VKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516571; x=1753121371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAN5AN0xB7TXy/kniPi44+90iocjGvN8izS4op7BZfg=;
        b=c/5XdrW+cgPZcXIjIieZVLJiHBI5EfNdSDrUPjuaLe2nQ7E4Y5phhloFbd8WHtrGEA
         COVIwhO5QN/++i5IqSRVf3aRJUoWryZuTlYtbLa59/BWtTgF9fieBVQNlnFSAtw9Ht8p
         rsWV3e0HzWqlrgkY8CmX++ZnlV2PsTFZIoEfBfKw3oS8mrw11oC0i474+5W2e9Ht4PJT
         YzsuanDf2lOSzWzq/NKnTe1ct1JEStxX9AUSiDnIN8qWo1lAsJGk0s1rYiAll7xWANEY
         SuSjjkI69VUchratZCuYaYbZd7YrhaaoDDNPC0MqWduuKo7G3CvTUAykHL3vYT87CRpL
         wmnw==
X-Forwarded-Encrypted: i=1; AJvYcCW4CUPY23y0AZ7tNwE800qiTZCLA94gmTPqQIef1eV+fSw4cyOLrc/xWbZLO53yADkcYaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIMe4BQ6VhBZ7ke4CuoWT1Ci7/SYkjFMqPWGprfmA+TpLspJaA
	qL2XbrAWU5wWTQx+hkxjvtXHnJU3qX0cFK5JoM3syrfFAvUiIv10myAl4TwY/PFK8+g=
X-Gm-Gg: ASbGncvauQte94mL66HNVyfb+AtWluGv3kZUxidAg3A2cNOIBVkFnCFpTggilULjEB/
	Dz2ERR39srd0SgVG0/Eyt/HtzDbxeg0ujPlCdsErorUSwNQqHCcbjc7C0VygeLy1yZfARbGJ0vP
	d1ZWQU/lkS7vqOXdyUMFQuuyol+jjfnL21zdU6B8g6MdiCr9oZpzrZATCk+eYs9EsJnPEksWnoE
	RZebBpi9Ih+4iPzuBJ51rrsvuo0mgvcziWVirX9r/CuDj6+z9ofb8S3Z8UVGPNuLpZBvwTHyuta
	cFGUtdtXyudEFCFmS/5+5UiVzcL1Ut6G123riPWEOYeVrt8kV52T0RN/6sFS/JehG+2qrucdU7x
	VR7GshdIKGg==
X-Google-Smtp-Source: AGHT+IEIUNu2yQWp1c+rwcTYXm3EveQBiLSX+CaRm74lfj21g0/JJjjjItMKcG/CVoL0G8j+e5P4Jg==
X-Received: by 2002:a17:902:ec8e:b0:235:ed02:2866 with SMTP id d9443c01a7336-23def8e443dmr77543945ad.4.1752516570755;
        Mon, 14 Jul 2025 11:09:30 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:84d3:3b84:b221:e691])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm98126405ad.78.2025.07.14.11.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:09:30 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 03/12] bpf: tcp: Get rid of st_bucket_done
Date: Mon, 14 Jul 2025 11:09:07 -0700
Message-ID: <20250714180919.127192-4-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714180919.127192-1-jordan@jrife.io>
References: <20250714180919.127192-1-jordan@jrife.io>
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


