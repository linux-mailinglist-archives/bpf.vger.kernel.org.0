Return-Path: <bpf+bounces-3624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B897407F7
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 03:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954F82811D5
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 01:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76303539C;
	Wed, 28 Jun 2023 01:57:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC5C538F;
	Wed, 28 Jun 2023 01:57:08 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2210910CF;
	Tue, 27 Jun 2023 18:57:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b82bf265b2so6605075ad.0;
        Tue, 27 Jun 2023 18:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687917422; x=1690509422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yiCh2NOg1GET2wwPA915j6lNxuG7zRImtB/G87hSZo=;
        b=mdjBjrwezIjld21zCcPaEkDZGclcbpwxEi0vDWD/C4YOoZinmr1x9E/VAX5gyETWsd
         haep6r9uKHp2qrT8MmmpQeoIPwLMqiw3Nom1Zi8Rjy1jOj5ZR9T9pPCbFSflUd7DOssB
         h48nzfMdRogHDVsLUZlE6wEAyhuLtCP5cmYrKB3ihYQyFcxgFz7169Z8I2FY6ule7bsF
         gANdkT9mD2jyH4omqyYcDPXF8lCrD9VcvFGiRADl/8s1gs6QmkvdSu8vZWeI10PBLimJ
         57af2GpAzf4fmXBl/IyZJTj6nvQGwa4VRChy3XE4fY6Vox6eDR9axcqZfG3IDO8frbd+
         0KlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687917422; x=1690509422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yiCh2NOg1GET2wwPA915j6lNxuG7zRImtB/G87hSZo=;
        b=O6yaweroK/e4sCYq5HOfH9PD8GRpP/81ZR41NhSEjftlGiftgsNQbVQozDMjP5Qfw4
         +VNA8be5MFIUzAxr7nkzh6NlaOvoiRglYBl8V7XSAeZ4rGZbuE4eaEE8h3wwSbc8N5/u
         MdZR2wZIuR6qfdjhLLVSWpZLSvGXgKaKsZvPdVoc9ZOQTfHmcwovNQy0sye982E9bdoL
         ri9LOxLjvFRO44P9UpPGjBTKYBEeISO0iY2D7lqyQ1G18rS937ho2ZYzM8gll9OWa0Jr
         I5kJKoZ6iMSxnpcG+nQEGxdH9ZiuTZrhK7Q29Mtd51+hm96tUiI7TdzMGeVRdyJ2Au16
         XUUQ==
X-Gm-Message-State: AC+VfDzXXiHHBG5fdzNjIj1TyGk6D30lP8o1xNk2oeVSiNTNbvOWZm+R
	tcCPu0ek+zRyAku9hcfE0WI=
X-Google-Smtp-Source: ACHHUZ50WzOjNJJVhYT8L/8Htvd7ty4p6GrMv2sh9RQ3Dix0/rCWC9NAnckgzpTvkvsNA9JSdeJoog==
X-Received: by 2002:a17:90a:9316:b0:262:e909:d7fd with SMTP id p22-20020a17090a931600b00262e909d7fdmr5565329pjo.14.1687917422547;
        Tue, 27 Jun 2023 18:57:02 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:6420])
        by smtp.gmail.com with ESMTPSA id qi5-20020a17090b274500b00262e5449dbcsm5074914pjb.24.2023.06.27.18.57.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Jun 2023 18:57:02 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 06/13] bpf: Further refactor alloc_bulk().
Date: Tue, 27 Jun 2023 18:56:27 -0700
Message-Id: <20230628015634.33193-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
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

In certain scenarios alloc_bulk() migth be taking free objects mainly from
free_by_rcu_ttrace list. In such case get_memcg() and set_active_memcg() are
redundant, but they show up in perf profile. Split the loop and only set memcg
when allocating from slab. No performance difference in this patch alone, but
it helps in combination with further patches.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
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


