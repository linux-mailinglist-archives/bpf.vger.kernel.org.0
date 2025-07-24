Return-Path: <bpf+bounces-64309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E928B113FA
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 00:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832C9AE2D60
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 22:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A629C242D7F;
	Thu, 24 Jul 2025 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1qurIDdg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB53B23D2A8
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396356; cv=none; b=KuPOCdk0TCP8reaZb/REtXk6XxbwWNI8JRlVn6VM3gxKsZ+9RVk1EYXIKxCN4SZbAXUwTxqFSMFXjXIRV2x1rP5qtpPvxqUhATDJX6sQ8HOxKbT8rXvXnB0Vgn9vm0AZ/tmRHD2nmbroOP/PkPHx7XxMZtcMOwv1XNbLHWUI3O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396356; c=relaxed/simple;
	bh=HdyMAFjZbu02whUTePCpE5p+N23Zl14tyqBKb8V/jYA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PV4m88kDk2jZIW9nGeDjFolCnjo7W3JuMvvKWU1/qpmAHRWfNwmGPlSd3mBOO+X6hB0v81lmI9reB5+LLyfz/nvoH4u4d8qgHoQjo0XOsqYaqufFivaEmS9cexX3SQS8mwePNOvuVAXtpH8zJsNvjKTbTVYaVwuNpafW+q6GKUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1qurIDdg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23632fd6248so14502935ad.3
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 15:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753396354; x=1754001154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oLn0DiL3hOFcQhckESIdE+NOImyGoMwrsGYgAXL6v7w=;
        b=1qurIDdgzjK6wVts9X7KFmDYYx3sGOiCIa3xcPbEU02UgLwo/e69nY4ZN74ST9NEZZ
         XZlMhefHrw7iOTuSddSxYM4BTUVN71r6abgSIBGcNO2aFW3k5XPho1ZZr1AlY48A1u1e
         +ykwX/MWr2TFzJrxXq0iRgY7ZfC7GsvjCiGpWTQN06vTVheY2v276VQB10JIOyvoSL5N
         NemMvmjiRArkOAe/FT2nBwwDeLFS9/DYsi+CyZUGwZqXRDaHLqmMmVqYjBbjtG10uOso
         Ms1lWv53RF8oVInA1qkpe6tMOv6Sy52k2KXmy/ZKSLp3j1WoOF5KErv8uD+qS5WMZsVD
         B/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753396354; x=1754001154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLn0DiL3hOFcQhckESIdE+NOImyGoMwrsGYgAXL6v7w=;
        b=SQ7bdMIn2jmA/Zn8Cgz1zlwIA55QsIRlLfuIQFRl9dfrgctytaklwJXS2nNIderuus
         4J5W/4eZ65jU6SEyRNTHv9gik11n88qGziLRAEWBo8ZRA6OkCTwDUF66MhbD3/iGdN8s
         mOTIM2DZN8IAmyNqsTidu9rwR5G8nfXMjnb3z6u+G5UGJ7AE2MavT7CsDSBl+AJMVB5Y
         InVVRA/xzerEWu5kmC7AGjmbf786HZ2LSuvzdTwSYRJY+iR/ScFqeIRcUpyUsx5unqJC
         hXkv6hg9R39A9X79rquEgbuGk//34McyCWvf3c14SUjODQFZr5gFKcDk924OqzhPamOJ
         W4tA==
X-Gm-Message-State: AOJu0YzGuRH/cVzKw/1G6LTNGxJyvsaxb/unfT21AL9zdGHu0X8WZTXw
	qrE7GuhfVcUBPBmCUd+l/7MjxCtZs11IU56RUyAnCt5L1rHOBE9EhAI1m3Rz8yt9inyRSh4iw0J
	UvCO7vuGBpR5PRDVdWDQ2PGsGfk+8LGCSIHaL1XIIeK6x9pBJxv9zmXhwAs1WL/e9p4xT6cEs+k
	W50UFK0wW0KOHUB90movi62gSWB4QBdIdAi7+90xkhtngc+g0/5xscz2SvKzI2ZeE2
X-Google-Smtp-Source: AGHT+IE/QhfK7fSPgf6hdUxRmb8vKHKetBGCtQfilh+Wr3qz/NoJP6cIGl1MPxzdX5KENkA2B5R5VHLZrK0UZU3hIFw=
X-Received: from pjtu6.prod.google.com ([2002:a17:90a:c886:b0:311:d79d:e432])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c409:b0:234:c8f6:1b05 with SMTP id d9443c01a7336-23f9824cb15mr100337625ad.52.1753396354017;
 Thu, 24 Jul 2025 15:32:34 -0700 (PDT)
Date: Thu, 24 Jul 2025 22:32:28 +0000
In-Reply-To: <20250724223225.1481960-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724223225.1481960-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=samitolvanen@google.com;
 h=from:subject; bh=HdyMAFjZbu02whUTePCpE5p+N23Zl14tyqBKb8V/jYA=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBlNW6rOiG77U+Q9PzPkhfjcr1Hn7wj82L5m+XXflWq5j
 omxuy6s6yhlYRDjYpAVU2Rp+bp66+7vTqmvPhdJwMxhZQIZwsDFKQATcexk+J9+jq/5nuOKW/N4
 pq9cNNmp3ffeizPy/2vy9fYfUOZ+0PeKkWGmiPvGYntji0k8U093njbInM8oeOolo9ypeYwl+ov Dz3EDAA==
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250724223225.1481960-8-samitolvanen@google.com>
Subject: [PATCH bpf-next 2/4] bpf: net_sched: Use the correct destructor kfunc type
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

With CONFIG_CFI_CLANG enabled, the kernel strictly enforces that
indirect function calls use a function pointer type that matches
the target function. As bpf_kfree_skb() signature differs from the
btf_dtor_kfunc_t pointer type used for the destructor calls in
bpf_obj_free_fields(), add a stub function with the correct type to
fix the type mismatch.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 net/sched/bpf_qdisc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index adcb618a2bfc..4558f5c01ed5 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -202,6 +202,11 @@ __bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
+__bpf_kfunc void __bpf_kfree_skb(void *skb)
+{
+	bpf_kfree_skb(skb);
+}
+
 /* bpf_qdisc_skb_drop - Drop an skb by adding it to a deferred free list.
  * @skb: The skb whose reference to be released and dropped.
  * @to_free_list: The list of skbs to be dropped.
@@ -449,7 +454,7 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 	.owner = THIS_MODULE,
 };
 
-BTF_ID_LIST_SINGLE(bpf_sk_buff_dtor_ids, func, bpf_kfree_skb)
+BTF_ID_LIST_SINGLE(bpf_sk_buff_dtor_ids, func, __bpf_kfree_skb)
 
 static int __init bpf_qdisc_kfunc_init(void)
 {
-- 
2.50.1.470.g6ba607880d-goog


