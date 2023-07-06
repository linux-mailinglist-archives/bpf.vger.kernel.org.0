Return-Path: <bpf+bounces-4156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A5274945A
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 05:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6941C20C6F
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A4713077;
	Thu,  6 Jul 2023 03:35:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6C20F3;
	Thu,  6 Jul 2023 03:35:18 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828CB1BCB;
	Wed,  5 Jul 2023 20:35:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666e64e97e2so212097b3a.1;
        Wed, 05 Jul 2023 20:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688614515; x=1691206515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2OQn7u8qk7CwTWC1dwQlpoJqxJbcJEgwvja+T4+A5c=;
        b=SjfDf38U3NJ6GR34LWjxD86lOZ5TMYyrnjrf1khx3T7KXD/xPWuqDCu0WFtPKI6Txe
         OiZKgwpPqbITx+55hkv9PwNpF3xQsc1M4fz74vN8nVHGp2fhXeo5QW802aiu2Z+pyY5A
         APorq/3G3t9WtiRzwp2cH/bG2BNd6gUS06JCq4CbYL7AWZ+vjP8SI2UctZwvKzPd9s11
         O2eFZ9lEBs2pdAvzsi6q4ut3KE9z2ShkgQ2LK0WAevsvUtVq+6qKu8iMX67Q2zmvqxGL
         T7qR+7k48oEQTezJv+HwCXZOz+z0qi40Po4YffUIXvCdaxp0dK8ZlmL/vwI21DA7nAoG
         yLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614515; x=1691206515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2OQn7u8qk7CwTWC1dwQlpoJqxJbcJEgwvja+T4+A5c=;
        b=chWM4VqMGTanJ2yd6cQVwooMLUBtPT+HtYsDrUdb1JmRksDzuoUrl1Yu9fT85RZvb0
         z2B9dmvVEMtIMYBukFXSYfrSMxgd0Puue0mjgPvc02vvyAJabemaFHl2qT6jCBBHHpJ/
         WSMwwnCVHsStmnwHcf6oGxo/G53ue+iA5TVMdav/TWoFV4/UQzXQSn8fH0QR+jNxxWCb
         ceKxJL61Yx3QpBfiFpNEETULt/6dOQCdqZ+IGJd1dRlfNZIcm/UARs6b64D03mGFhvYY
         VC4Ca02dbNlJS1WczQd6TPu6GcUxjnpj9NVnaqhAAnb8OGJ6fs/2Xy1Kiv/wh+R0Fgjr
         F5Dw==
X-Gm-Message-State: ABy/qLbFwIu6p6BKjllHXX0Rf12GtjBoTe115x5Yi5+RvDPJX84kMA9X
	YV4InYzKDiYrll3g4YMshZU=
X-Google-Smtp-Source: APBJJlHC7KpOFYfVUDMOMHsFuCtZz/EE3l6YqBwEqSkQvMkvESbDsiz4Vf91+WraVqedGo8m7/TkPw==
X-Received: by 2002:a05:6a00:1acb:b0:66a:5466:25c6 with SMTP id f11-20020a056a001acb00b0066a546625c6mr524076pfv.18.1688614514898;
        Wed, 05 Jul 2023 20:35:14 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:f715])
        by smtp.gmail.com with ESMTPSA id 10-20020aa7924a000000b0066a31111cc5sm232228pfp.152.2023.07.05.20.35.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Jul 2023 20:35:14 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: daniel@iogearbox.net,
	andrii@kernel.org,
	void@manifault.com,
	houtao@huaweicloud.com,
	paulmck@kernel.org
Cc: tj@kernel.org,
	rcu@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 bpf-next 06/14] bpf: Further refactor alloc_bulk().
Date: Wed,  5 Jul 2023 20:34:39 -0700
Message-Id: <20230706033447.54696-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alexei Starovoitov <ast@kernel.org>

In certain scenarios alloc_bulk() might be taking free objects mainly from
free_by_rcu_ttrace list. In such case get_memcg() and set_active_memcg() are
redundant, but they show up in perf profile. Split the loop and only set memcg
when allocating from slab. No performance difference in this patch alone, but
it helps in combination with further patches.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 052fc801fb9f..0ee566a7719a 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -196,8 +196,6 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 	void *obj;
 	int i;
 
-	memcg = get_memcg(c);
-	old_memcg = set_active_memcg(memcg);
 	for (i = 0; i < cnt; i++) {
 		/*
 		 * free_by_rcu_ttrace is only manipulated by irq work refill_work().
@@ -212,16 +210,24 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 		 * numa node and it is not a guarantee.
 		 */
 		obj = __llist_del_first(&c->free_by_rcu_ttrace);
-		if (!obj) {
-			/* Allocate, but don't deplete atomic reserves that typical
-			 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
-			 * will allocate from the current numa node which is what we
-			 * want here.
-			 */
-			obj = __alloc(c, node, GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT);
-			if (!obj)
-				break;
-		}
+		if (!obj)
+			break;
+		add_obj_to_free_list(c, obj);
+	}
+	if (i >= cnt)
+		return;
+
+	memcg = get_memcg(c);
+	old_memcg = set_active_memcg(memcg);
+	for (; i < cnt; i++) {
+		/* Allocate, but don't deplete atomic reserves that typical
+		 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
+		 * will allocate from the current numa node which is what we
+		 * want here.
+		 */
+		obj = __alloc(c, node, GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT);
+		if (!obj)
+			break;
 		add_obj_to_free_list(c, obj);
 	}
 	set_active_memcg(old_memcg);
-- 
2.34.1


