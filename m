Return-Path: <bpf+bounces-60963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FE2ADF293
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920194A310C
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBB92F198C;
	Wed, 18 Jun 2025 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="ANU3+UJY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0F92EF9CF
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263953; cv=none; b=PZxFwDi8cWDz/5XLoctn/zD34JDDeN74MTMFN8D//q9PMnkHlBwuBGzXQYzGuXG0b4nBvjnhwfd4NPTkkXi/F6CliohLNsZsJA2Q3OSf6DRD6XMomUc6TZWmmOT0QTd+kILFP2Ch1Pe029frPtDqvHloQOTqo4ERN7VPoYIMBTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263953; c=relaxed/simple;
	bh=P2TM48kjMxPSr7YwvwYsCNfh+euwlg0K2KRkqviR9cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmRdT5t/K5v62/D3muac4imjl0TrN9qtKMLLoy5RbiXoeDJJF7gVh6RcJTSzE2dbxo2H9U/SXq53EbB85uwvxLxHDS6lh0D6vkitnetwtTSx1CqAMR58TxSxEwSXnPLjd18/OTm2EI6f8Nf8c0fASEuIrOnTnPUQXoR3SdkpIj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=ANU3+UJY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2355360ea88so9467355ad.2
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1750263950; x=1750868750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=ANU3+UJYNTxRBY3+jhnVmgrpz0+cLKPnWKQNYCog7ChxF63L/4lZP22y7Mkl9LQ2r0
         yol/RaNxgaqQV46mfagTKT9c/kRmJEiUhxCQgbmbyj9o36331lebjN7tTqZNirJdI9PP
         2nqoDoSg+09VelHWjYhL8M5sfiJ3mYT6JhCrl+r+6nxBo7vKTS4f1ZXfug+9UIbVsofQ
         YLwV3Tz6vkIXxrsaFmh9hS1lWHsntZwVU3VveBLGInaWmBe8fOb4pHvOqNLyFS3pJyhl
         JjtIMN1eQmyrrApCeN7obgg7MIc7aOHZHAb1mIMsHHDw8DeVW36LkA/PKu8sIGGQx3OX
         F4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263950; x=1750868750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=lqm1B7/6cmizInhNcs1/5qRXInl2tQKO8TsHFsYnQPzEU68b97E3BWgifaVbUIkjOS
         dM53H45JvTZHBreuvijWlzndhC7caVo9m4P5/B1Khv8KtQmo4T/g1UhFIYPmForUb3OZ
         vKkjzDG89Dm4+37zfoeY/Wv6imqjzdks73yHD8JZks7r9/djqKcTetD4BzG7LZ0r6pGe
         4TWSjqyuRAgTtjK7IHMp+25p4pfXb4ifwPsRC31UkG6TmTSca/ooyLQ7vge8YQO3138Y
         zVVtWvdOhCwKamtahk1DBPN8ieCu7zg9Q0A7fpj5UOjsOnFpFHMz2aIWt1bT3z7XyyOl
         ZQ9A==
X-Forwarded-Encrypted: i=1; AJvYcCWpJsS+lQRyk6wAbJOXRliqkW/1gdw/BeI2c9spztUbCD6Iz2Z8YOC3lLQI8bFVTYAFSRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/mHUzsXNsvFHH2rsXEXOpOYNxJ9WMke/5gzN79k/wT+FxIG/5
	9NDOOd1WKHESVE4CbHJ4S4xc12XkY2LYn6KQPT+dd5QxITlXKNBqAQ5vYuRWmt1I36Y=
X-Gm-Gg: ASbGncs+bcmI4xTofxmgPUD+Y6Cp5By89e/v4+gDJ8zQTf8vQVjBxWOcwCV5wEtgYSf
	pyEiKKQzRve9QSr887I1zOjTPIptoVNQf8V/T3jpedazBcaD1wwcGZ/ikwhyMp31Y0jS5dLi1u6
	7unTMhAhbvoMpW5sfXPWG3tp9ysDOAOAdKSqdUcoZMN69ffuHkV4+t09m6OyRQINk168Vh4SH2k
	jCcUDbxS5JL9fjlsHZjsQfrScMaoDpgH6b6+YYLCTi5jIp6NPlZf5BKJ/GI+JEweFJEHfhen3/5
	63mafaovKsiH8QCnim6OXhPiGUIPeABQrewjpu3d7e0sHZyqHpc=
X-Google-Smtp-Source: AGHT+IHBnBzJv+dzgpv/IuYTGHbecuVl5lsIV9fwbs0EUNNaa/Op/2bayR7I9w9fVA/TzuUlwT9wMw==
X-Received: by 2002:a17:903:32c3:b0:234:ed31:fc97 with SMTP id d9443c01a7336-237cc112182mr542725ad.12.1750263950166;
        Wed, 18 Jun 2025 09:25:50 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d683:8e90:dec5:4c47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2768c6sm137475a91.44.2025.06.18.09.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:25:49 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RESEND PATCH v2 bpf-next 01/12] bpf: tcp: Make mem flags configurable through bpf_iter_tcp_realloc_batch
Date: Wed, 18 Jun 2025 09:25:32 -0700
Message-ID: <20250618162545.15633-2-jordan@jrife.io>
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

Prepare for the next patch which needs to be able to choose either
GFP_USER or GFP_NOWAIT for calls to bpf_iter_tcp_realloc_batch.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_ipv4.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6a14f9e6fef6..2e40af6aff37 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3048,12 +3048,12 @@ static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
 }
 
 static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
-				      unsigned int new_batch_sz)
+				      unsigned int new_batch_sz, gfp_t flags)
 {
 	struct sock **new_batch;
 
 	new_batch = kvmalloc(sizeof(*new_batch) * new_batch_sz,
-			     GFP_USER | __GFP_NOWARN);
+			     flags | __GFP_NOWARN);
 	if (!new_batch)
 		return -ENOMEM;
 
@@ -3165,7 +3165,8 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 		return sk;
 	}
 
-	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2)) {
+	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
+						    GFP_USER)) {
 		resized = true;
 		goto again;
 	}
@@ -3596,7 +3597,7 @@ static int bpf_iter_init_tcp(void *priv_data, struct bpf_iter_aux_info *aux)
 	if (err)
 		return err;
 
-	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ);
+	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ, GFP_USER);
 	if (err) {
 		bpf_iter_fini_seq_net(priv_data);
 		return err;
-- 
2.43.0


