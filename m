Return-Path: <bpf+bounces-28915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0CC8BEACA
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99547285899
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 17:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F4516D300;
	Tue,  7 May 2024 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8iFoOyI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29DC168AF5;
	Tue,  7 May 2024 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104083; cv=none; b=pMK4k20+b0tcFS0mjeOeBTkKoF+05//6qmvYyFxLJ693qLPrksqBkFGsjY/+BGOLJ0/JqdZ6L2MyZaQvFb++jTGMhaznTt4qoG0Lxwt6eZiIEn/EyOm3nP/EvTdSzHMSTvAY147zrulrUi/EQ9W6vfna53GyvnJeB+4JEy/JEGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104083; c=relaxed/simple;
	bh=1GYe8vJ/q/lJREi+XvoAG9h5MbSbTk4JcK/eBrXGRQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LGjA57nju4PerwAeBYElYR00NJenHKVfVRqLq+WoG3uWzfn7MYdkMy/ImQ+aeFIIaJfNyjqkbIIHDgeJJoqCp1fZow/ryMWaNarG8dniaLDyI04n1KpkCkR2Pc09qohCWalLwfm8mEd4GQ6Rrwxw1aurDl667tzDTa5w4fuW7VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8iFoOyI; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f0812c4500so1048117a34.0;
        Tue, 07 May 2024 10:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715104081; x=1715708881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTwi1uf3IMxodfokkx4FoU+4557jdgjAbeZcWcBw0N0=;
        b=Y8iFoOyIgb2V03x1//qjz3oRIgER1Ddddci228J8TB+kozEnls6d11zH3ZGJMX43en
         5PdjYrNPyliUWEWlfJhA9x9ekFknzsjhBPRWhK4H/Y59VjbODuysHl0bAyrnZ5Q+g6Ui
         uvFQGxBVTc1kGS7ZXs7PVQI79viAPmyFL3bNj5zfMhEqMSnpRPIv4OA3igUhkYTyYoI1
         1lshf0aXnGybWArk2zO4CjhQ77E9EMHpBe9cAA5y/O/xpo4tS7zefYYrifL2MDX/WotM
         jKtLRQODY5MCUW6iSOel54MwG+990cwpEQxQptDDk/gghPDYWjzqMOkWAWgqKoqizzPf
         koQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715104081; x=1715708881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTwi1uf3IMxodfokkx4FoU+4557jdgjAbeZcWcBw0N0=;
        b=UeD9gJ/J6uGhNXGrW/yl0tSZ86bOQriS4PHGRtbjYPHTSbrWe2xvqNS383PNQ2UhVr
         6O598jALr2qZQepK9FDcBwry1IZm8/1OphEVSUVZP98oDzGLpVO99HmbA2J3H2rsGbW1
         e9wvr/acAlzg0yYFE7Caq30CJKWwzSeA52gXMgFn5TbuUdAWm4rSaSscXlhY2bblgzQ1
         eZZzSR3Ewjvyrd7yfIU09qy0EH/lAzKxOlUNOSVC0MVSlB2Eg2x5GHVCP33aU2I1WLBS
         Z1XQHXxP4qwvkmoki9vHl03Kzlx7NvIWshsZXa1U+DKOSRm2MhojAZSrETvstrJTDj3l
         4z6g==
X-Forwarded-Encrypted: i=1; AJvYcCX9K0rvsRAvoyMZ41RyJ7vuMjLkudeXE1o1s8RT72oH+70lCYMGPVOliBycMsFn5UFHZkZiFR8STXzkaJuolegHAN2wKdyp
X-Gm-Message-State: AOJu0YxE346dxBuvlNi/6O1rXO9H7Kv0cu/VUwM7pfyT9LdiTq9hpYAV
	T9n8wrY5X+7Dzx/VCrR8PxWMA7t6JqJftFoPNRQpMFxWHR4esa4h
X-Google-Smtp-Source: AGHT+IHCafJuIl/JQEqnJxZLXpz3KsG1IJlOPWj2sPzxxOX4nAYr6YALlxf3T23/hwCZfeGnvCS/Xw==
X-Received: by 2002:a05:6358:24aa:b0:192:9834:7975 with SMTP id e5c5f4694b2df-192d2e54ca8mr48864655d.11.1715104080844;
        Tue, 07 May 2024 10:48:00 -0700 (PDT)
Received: from john.. ([98.97.42.227])
        by smtp.gmail.com with ESMTPSA id u34-20020a631422000000b00600d20da76esm9958611pgl.60.2024.05.07.10.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 10:48:00 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dhowells@redhat.com,
	kuba@kernel.org
Subject: [PATCH stable, 6.1 2/2] tcp_bpf, smc, tls, espintcp, siw: Reduce MSG_SENDPAGE_NOTLAST usage
Date: Tue,  7 May 2024 10:47:57 -0700
Message-Id: <20240507174757.260478-3-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240507174757.260478-1-john.fastabend@gmail.com>
References: <20240507174757.260478-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit f8dd95b29d7ef08c19ec9720564acf72243ddcf6]

As MSG_SENDPAGE_NOTLAST is being phased out along with sendpage(), don't
use it further in than the sendpage methods, but rather translate it to
MSG_MORE and use that instead.

Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
cc: Bernard Metzler <bmt@zurich.ibm.com>
cc: Jason Gunthorpe <jgg@ziepe.ca>
cc: Leon Romanovsky <leon@kernel.org>
cc: John Fastabend <john.fastabend@gmail.com>
cc: Jakub Sitnicki <jakub@cloudflare.com>
cc: David Ahern <dsahern@kernel.org>
cc: Karsten Graul <kgraul@linux.ibm.com>
cc: Wenjia Zhang <wenjia@linux.ibm.com>
cc: Jan Karcher <jaka@linux.ibm.com>
cc: "D. Wythe" <alibuda@linux.alibaba.com>
cc: Tony Lu <tonylu@linux.alibaba.com>
cc: Wen Gu <guwen@linux.alibaba.com>
cc: Boris Pismenny <borisp@nvidia.com>
cc: Steffen Klassert <steffen.klassert@secunet.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lore.kernel.org/r/20230623225513.2732256-2-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ipv4/tcp_bpf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index f3def363b971..cd6648aaf570 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -88,9 +88,9 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 			int flags, bool uncharge)
 {
+	struct msghdr msghdr = {};
 	bool apply = apply_bytes;
 	struct scatterlist *sge;
-	struct msghdr msghdr = { .msg_flags = flags | MSG_SPLICE_PAGES, };
 	struct page *page;
 	int size, ret = 0;
 	u32 off;
@@ -107,11 +107,12 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 
 		tcp_rate_check_app_limited(sk);
 retry:
+		msghdr.msg_flags = flags | MSG_SPLICE_PAGES;
 		has_tx_ulp = tls_sw_has_ctx_tx(sk);
 		if (has_tx_ulp)
 			msghdr.msg_flags |= MSG_SENDPAGE_NOPOLICY;
 
-		if (flags & MSG_SENDPAGE_NOTLAST)
+		if (size < sge->length && msg->sg.start != msg->sg.end)
 			msghdr.msg_flags |= MSG_MORE;
 
 		bvec_set_page(&bvec, page, size, off);
-- 
2.33.0


