Return-Path: <bpf+bounces-56854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 752C3A9F7DA
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 20:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD371A83555
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 18:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6473B2951DF;
	Mon, 28 Apr 2025 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="IjzI0z3f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8507C2949F8
	for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863249; cv=none; b=hyUZ9h5P8/G3U74b2Guax3zGUBNbek7zzF/QtpHlCB5gD1VsdRF29hQp09R6SZYazAlwGNlXk7Bb7mQeYcc7StA86zn8hjmZRI/LDmzPt1fKe+/KgHWSRPPolO54Iw72/F7tCyNOvKPOXJDzNifA5lEAPYA0ZSnleMfOE1QW74w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863249; c=relaxed/simple;
	bh=FE4N9q4IrPGuc5oTUxK2galKDV4gY01q9sMpfWfCE8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpfTJcu1HT/mbj5fI8RIN+BA4CiBXceylYeg3jea2AgqVKInCcUSbxzOJjsLR70sr0FZSmDKvCl/PhNMuypJ3BlNd9VCXjpKlB0r8ZKruCarfxQbygNwdIDiife4zXkWfWqFoLY+SW0QUMg79dsz0FKhHA4dw1RBXTeb6QA3Fxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=IjzI0z3f; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2241c95619eso10104015ad.0
        for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745863248; x=1746468048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/v9cZZawYO8IzuXBE+ZYLFioHdu6gAmN1PnK662kQA=;
        b=IjzI0z3fKjglNIuN7gT9tw+roDITakINyy1ET4WjVtrkfXwBUlvKXJj1gEKM0QJJoo
         gv7Is5Gpbxv1AFWMHhV8iy/xmcH2KcGDTRSzoENbAu9YTqJc2/C7mxfmsKItGg7fW2PN
         QIv58qbMBJPDB1w1WRLChBfyCh3cjmdmn9Qw7lSUBQv278ZuPVRdBcQBI/NrNiACUpJL
         inganawETFhYkwwXS4SUKRMkZ25nWhYnnr+hvnepSz/2K3yFqsIUYF5+gOlNl1fkKyI2
         OPJ5UL2wqU53RtiZq0CVoxk9Ll4n23kZS4rxGLb3mszyFCyrySsu0uMUqZk7sYF6Zh8N
         vWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745863248; x=1746468048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/v9cZZawYO8IzuXBE+ZYLFioHdu6gAmN1PnK662kQA=;
        b=exn499Jo0WuT+EsFU+E3g27TUj246g2Q1H1+zi3GWwOT0xOLz8Roga1m6RPeeSUIoo
         vzZr9tqDhLIL7t2SxfnXbdooX3jfFsQPOle0g9ZkBqqF21BaZEshyuRSpm3A9eOqHqO+
         X0ItVucfv1rprcYtOWybhdIdUW3hwc0QSIIG9OXRYzpi7aphhliVU6Fy1/U+7pF1OPj4
         ZqfkhVOuRiPiBpHzYFE/FkxZT2D3tf1yHxt9gT1ZYSQP7O9Wl+lZpIe3y/BHqdeeKIyS
         2tfaWVwZwcuaOPttdaYhFrr9L8aa8VcmEX3Hsd9hZZXI75XV0wPXkVtZdf39/+NdIeK6
         ca6g==
X-Forwarded-Encrypted: i=1; AJvYcCU7pDqQk8KTodTwbBpI06E7H+Mh69cnhv+CgT7NUbFrdPRTBsSP3c28MNpjsQE+RfoWzPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyq+dUeh8KHzmstA7DSs+JO7wDjHCl9Ofrt64UDRnPV5lgWw7F
	C2oj0BiPzeXiH6fGNgQ7zx37ULnCxrWpbPQr5zShOnVSW+x0vmJpfOzQQ+2m5bU=
X-Gm-Gg: ASbGnctmwx7YDfUGQPOjAPfpVbmojH6R/+kEnL7+g1KoGpREr3X3oNbSc+7U7Ae67Tx
	ugZsF6+UZq4gGh1BP3DeNVWLcWnwyxIIoAuSzNd15S+A/w/l59HffV32ctshtiRugipDf9MYag7
	zXxDjAiZyWdga7Z/UzoENqAQzjGLSkUN+JF04lx5npP1GpXh6Sxu3C/X3CCtA5EdUL1gQJr96pv
	joO/i4k08NZtKjZE1PncyLvCFqCwLNG1feReY2h2yP4YPHBhH8I3Id9QatRVP8vdCPOchgZHbqI
	gfFminD+axcvC1Fchf1G/W6h1g==
X-Google-Smtp-Source: AGHT+IGjufvM1H55aaaDht34xKNWU1wC+Lu5KCcr4QZ6tKCyck7RQfZWfrwVW8hJE58JGJ9iCYsUVQ==
X-Received: by 2002:a17:902:f684:b0:22a:bbea:6ab8 with SMTP id d9443c01a7336-22de6f214c6mr170615ad.12.1745863246966;
        Mon, 28 Apr 2025 11:00:46 -0700 (PDT)
Received: from t14.. ([104.133.9.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52214ebsm86204235ad.246.2025.04.28.11.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 11:00:46 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 1/7] bpf: udp: Make mem flags configurable through bpf_iter_udp_realloc_batch
Date: Mon, 28 Apr 2025 11:00:25 -0700
Message-ID: <20250428180036.369192-2-jordan@jrife.io>
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

Prepare for the next patch which needs to be able to choose either
GFP_USER or GFP_ATOMIC for calls to bpf_iter_udp_realloc_batch.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/udp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 2742cc7602bb..6a3c351aa06e 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3401,7 +3401,7 @@ struct bpf_udp_iter_state {
 };
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
-				      unsigned int new_batch_sz);
+				      unsigned int new_batch_sz, int flags);
 static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 {
 	struct bpf_udp_iter_state *iter = seq->private;
@@ -3477,7 +3477,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		iter->st_bucket_done = true;
 		goto done;
 	}
-	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
+	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2,
+						    GFP_USER)) {
 		resized = true;
 		/* After allocating a larger batch, retry one more time to grab
 		 * the whole bucket.
@@ -3831,12 +3832,12 @@ DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
 		     struct udp_sock *udp_sk, uid_t uid, int bucket)
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
-				      unsigned int new_batch_sz)
+				      unsigned int new_batch_sz, int flags)
 {
 	struct sock **new_batch;
 
 	new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
-				   GFP_USER | __GFP_NOWARN);
+				   flags | __GFP_NOWARN);
 	if (!new_batch)
 		return -ENOMEM;
 
@@ -3859,7 +3860,7 @@ static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
 	if (ret)
 		return ret;
 
-	ret = bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ);
+	ret = bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ, GFP_USER);
 	if (ret)
 		bpf_iter_fini_seq_net(priv_data);
 
-- 
2.43.0


