Return-Path: <bpf+bounces-42527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1699A539D
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 13:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2EB9282D0E
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 11:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEDF190486;
	Sun, 20 Oct 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dRk58tIv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAA9188A3B
	for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729422277; cv=none; b=Ps1xn6vyCCVhdUQHnagjSAwER3Gy0Tq3E9GBFW2uExFYo++5JSm9XYUfZCa5aFTieAhUEjrV3O3PVBibmxzzhAHP+ySHcKEzqWJVqZIFYewYWXPGGU6WCweW9C1tCDC/QnZ418ytfEtbJT1TxLGfqinCZgrjwBN8e6o2GYHw2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729422277; c=relaxed/simple;
	bh=BH9aK3Bdg8WCQ2gQiVerd0CjJMZEBTPkI4XIQehsWe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ccfaw+EFiEiUvWpFTl4uquUwtwwYRUsVpm5HDovn7WMqKk1xQCS8CRS6NLiRjCkgpNDsKGsCVneCeoOV1MQGafI5sTs62+uxQLc/ozSuE3OTki4jXxUs55G+MJJ8OxIReeP9w/ciSmlT4nW6VDT/tH35TSCnG8tTYemFUC3LZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dRk58tIv; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6c5acb785f2so19921276d6.0
        for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 04:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729422274; x=1730027074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXovnw1hpcieH40jA+UiXwQGUAj7DcN4pSnqNYMpqhQ=;
        b=dRk58tIvOw4vsScjmEVlBEya0L2UjGzuK484l6lQ9xhuTr2KCafBhkw2AoEtf5LJ1m
         Ts/zf2mrR7DAw3xCOp5GzKfvoiI37BKC2uLUtGHUsagdDeXdC9TnYA7CNGLMDrZp1uNU
         tcCfaepSeS0Yb1HPPDmVibTBEomHW/SXeiCsYrSF7EMrWHCAArfYisN0ORrZjmqdTbWF
         xcV6XAB5v/rmcsHi+W2Eix5wlRR2t0Lf1STUxypn8gMVY0nMTAtBtdodfP0N/EvIYWPj
         0xzzJwvJRTzeAOaIMDI656c3j7FDyQz66C+ZGnQyGK9k8GPsNLTisflixqqGpEvzPFWa
         e1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729422274; x=1730027074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXovnw1hpcieH40jA+UiXwQGUAj7DcN4pSnqNYMpqhQ=;
        b=EpG090cGhVebV3A6GQqLetGcpdbUkSniwXvqKE+kIrdx08DLZ1pmhdCK1IWae00WpE
         o5d8psr95Uy9r+IbAnN9IIgvebLuuUyitmvH9+g0zJ48BlPnQGDooBcHNcuzW3D7JMhs
         y/0F1InXd9mHDwSj4PoBaDdFamOIqmhgOGjEYUEEgwWiFAeQe9mF2tGB5CGPwLk8A9GU
         pA9r2N3NpKQU8UvVC7BiOZ9ktoMbdyCgsJcekaHua3bsfEbr63y6l8nhhZ5ySnhgu+KP
         BEJCgeyBFOP6j16KxdP8Mq0G19p3nJIu9U7WAVj2T9/8XRtfn9VViPT4zDaUfsUKWt5r
         yHKQ==
X-Gm-Message-State: AOJu0Yx89CnEKJiHCj5HRe5x6lfFjv6Z/GqqzFqxntmJwbekzJNWssqI
	XJdxa745meYSklXjNZqUuMAfF82G1OgVQBDMfmfDNYIIoN8grbf15yfT8LGJzOvxuSH/ZMIjskP
	g
X-Google-Smtp-Source: AGHT+IFGiWcDzwhgb7IE+bSyqBaskBisy8FHav2v4jTRvSqgfUlTVbnNaSUhs1HKhLolvH2C+/OO7Q==
X-Received: by 2002:a05:6214:488e:b0:6c5:8a85:19fe with SMTP id 6a1803df08f44-6cde165082cmr116579386d6.51.1729422273967;
        Sun, 20 Oct 2024 04:04:33 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce00700c0csm6715216d6.0.2024.10.20.04.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 04:04:32 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	jakub@cloudflare.com,
	liujian56@huawei.com,
	zijianzhang@bytedance.com,
	cong.wang@bytedance.com
Subject: [PATCH bpf 7/8] bpf, sockmap: Several fixes to bpf_msg_pop_data
Date: Sun, 20 Oct 2024 11:03:44 +0000
Message-Id: <20241020110345.1468595-8-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241020110345.1468595-1-zijianzhang@bytedance.com>
References: <20241020110345.1468595-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Several fixes to bpf_msg_pop_data,
1. In sk_msg_shift_left, we should put_page
2. if (len == 0), return early is better
3. pop the entire sk_msg (last == msg->sg.size) should be supported
4. Fix for the value of variable a and sge->length
5. In sk_msg_shift_left, after shifting, i has already pointed to the next
element. Addtional sk_msg_iter_var_next may result in BUG.

Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 net/core/filter.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4fae427aa5ca..8e1a8a8d8d55 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2919,8 +2919,10 @@ static const struct bpf_func_proto bpf_msg_push_data_proto = {
 
 static void sk_msg_shift_left(struct sk_msg *msg, int i)
 {
+	struct scatterlist *sge = sk_msg_elem(msg, i);
 	int prev;
 
+	put_page(sg_page(sge));
 	do {
 		prev = i;
 		sk_msg_iter_var_next(i);
@@ -2957,6 +2959,9 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	if (unlikely(flags))
 		return -EINVAL;
 
+	if (unlikely(len == 0))
+		return 0;
+
 	/* First find the starting scatterlist element */
 	i = msg->sg.start;
 	do {
@@ -2969,7 +2974,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	} while (i != msg->sg.end);
 
 	/* Bounds checks: start and pop must be inside message */
-	if (start >= offset + l || last >= msg->sg.size)
+	if (start >= offset + l || last > msg->sg.size)
 		return -EINVAL;
 
 	space = MAX_MSG_FRAGS - sk_msg_elem_used(msg);
@@ -2998,12 +3003,12 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	 */
 	if (start != offset) {
 		struct scatterlist *nsge, *sge = sk_msg_elem(msg, i);
-		int a = start;
+		int a = start - offset;
 		int b = sge->length - pop - a;
 
 		sk_msg_iter_var_next(i);
 
-		if (pop < sge->length - a) {
+		if (b > 0) {
 			if (space) {
 				sge->length = a;
 				sk_msg_shift_right(msg, i);
@@ -3022,7 +3027,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				if (unlikely(!page))
 					return -ENOMEM;
 
-				sge->length = a;
+				sge->length = a + b;
 				orig = sg_page(sge);
 				from = sg_virt(sge);
 				to = page_address(page);
@@ -3032,7 +3037,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				put_page(orig);
 			}
 			pop = 0;
-		} else if (pop >= sge->length - a) {
+		} else {
 			pop -= (sge->length - a);
 			sge->length = a;
 		}
@@ -3066,7 +3071,6 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 			pop -= sge->length;
 			sk_msg_shift_left(msg, i);
 		}
-		sk_msg_iter_var_next(i);
 	}
 
 	sk_mem_uncharge(msg->sk, len - pop);
-- 
2.20.1


