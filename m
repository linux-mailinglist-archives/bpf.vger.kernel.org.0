Return-Path: <bpf+bounces-5536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4E375B8E1
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 22:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329B11C214CD
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 20:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18481642A;
	Thu, 20 Jul 2023 20:45:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99403156FE
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 20:45:30 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4391737
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 13:45:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-cf0bc5604eeso1015386276.2
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689885928; x=1690490728;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OX7MsRVD+DrLWmxc9YNqkVe8yprAE1lB6eHus85qPh0=;
        b=BfLT1yBbhqWXTmxhuZXcDMHWGGezD5rbTDxxOn0T3oq13LBksvw/Kz7guKP7ZbMNsh
         6dR+Ght42WRUt6wnaWH3d2vjnK6z3oJmNQkYM6Zk2lMEftIW9AWOZIizBM5+l4LwOtFL
         EfhBD0IgmSu/SoPkrntI2FN1pdnjSWSC6/dFYjjVNKc2KoqbwgsjgW5iX0R2pEK0euS+
         5n6cPzvais8AZIlR6oLoZ499COm/b5IDbF9O79/yOg9pFpU1jmJTbKB5HUhiYwJP3tKT
         FD+SG37WKBPe5eaPkcTiR3kpHdxR28D8uIFICVsyrmlQM9rV4yb/baicmPBMUuvToY2L
         qCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689885928; x=1690490728;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OX7MsRVD+DrLWmxc9YNqkVe8yprAE1lB6eHus85qPh0=;
        b=kq1mHzdVVVi3DnEHRvjCNaiKqwl/OzkpOKppmsInapU4pmbAiL0FJah8SRMTkgKPNX
         TGXjQG3Uq4qSSqtWDeUZiN+pCOJcRHzrtgepKlJxgCRi+gzdrlXRN+38CO9shVUrzqNN
         WxqWGo6nh7cp51vxHQS3jgrf5XWaYpsvDzZ7C/jDg2GceQPxZDUp3gxbS1mmv51E0Muf
         6Q9kyU88zSkqamrjDmdeARY1Lo47JLPllbvS+ZeQX9rciLa/CyI0vkgQLTDjiRfMIfrK
         h+sfgKehfyj/3Uc/j7tXho4i+/gmX/euCqy7V5ILyVPlMkBlA/R/iT8/TkuReMgEA6xj
         8Pzw==
X-Gm-Message-State: ABy/qLayLQmxfQ+O9MWjt38TfC5lV8ggQUhZBN+rLPFoo6gD7sM4i96k
	306inDfF0d2tkYESJ0LAWqHNr6IP/oIs3U/ud1RJ8P4UPk4jJUYG6zWscbhaltUMVKp6PIqgiuo
	+CMq3xp4XCeFztkpIIRbB+J9MGLoXZ4i2Rrh0hiViO3dC7oPOuoj1DOKOl9rTH8E=
X-Google-Smtp-Source: APBJJlEAUS3K/xMS1fnAYnsJLn87L8vZUdFz9CS0ZgUUwfpvOpxjwE9mpryfsOSFkA4Qs9BDALtIfXmFP/m8hA==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a25:8e12:0:b0:cfe:e8ca:7323 with SMTP id
 p18-20020a258e12000000b00cfee8ca7323mr620ybl.4.1689885928457; Thu, 20 Jul
 2023 13:45:28 -0700 (PDT)
Date: Thu, 20 Jul 2023 20:44:54 +0000
In-Reply-To: <cover.1689885610.git.zhuyifei@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1689885610.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <d47f7d1c80b0eabfee89a0fc9ef75bbe3d1eced7.1689885610.git.zhuyifei@google.com>
Subject: [PATCH bpf 1/2] bpf/memalloc: Non-atomically allocate freelist during prefill
From: YiFei Zhu <zhuyifei@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Stanislav Fomichev <sdf@google.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sometimes during prefill all precpu chunks are full and atomic
__alloc_percpu_gfp would not allocate new chunks. This will cause
-ENOMEM immediately upon next unit_alloc.

Prefill phase does not actually run in atomic context, so we can
use this fact to allocate non-atomically with GFP_KERNEL instead
of GFP_NOWAIT. This avoids the immediate -ENOMEM. Unfortunately
unit_alloc runs in atomic context, even from map item allocation in
syscalls, due to rcu_read_lock, so we can't do non-atomic
workarounds in unit_alloc.

Fixes: 4ab67149f3c6 ("bpf: Add percpu allocation support to bpf_mem_alloc.")
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 kernel/bpf/memalloc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 0668bcd7c926..016249672b43 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -154,13 +154,17 @@ static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
 }
 
 /* Mostly runs from irq_work except __init phase. */
-static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
+static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
 {
 	struct mem_cgroup *memcg = NULL, *old_memcg;
 	unsigned long flags;
+	gfp_t gfp;
 	void *obj;
 	int i;
 
+	gfp = __GFP_NOWARN | __GFP_ACCOUNT;
+	gfp |= atomic ? GFP_NOWAIT : GFP_KERNEL;
+
 	memcg = get_memcg(c);
 	old_memcg = set_active_memcg(memcg);
 	for (i = 0; i < cnt; i++) {
@@ -183,7 +187,7 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 			 * will allocate from the current numa node which is what we
 			 * want here.
 			 */
-			obj = __alloc(c, node, GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT);
+			obj = __alloc(c, node, gfp);
 			if (!obj)
 				break;
 		}
@@ -321,7 +325,7 @@ static void bpf_mem_refill(struct irq_work *work)
 		/* irq_work runs on this cpu and kmalloc will allocate
 		 * from the current numa node which is what we want here.
 		 */
-		alloc_bulk(c, c->batch, NUMA_NO_NODE);
+		alloc_bulk(c, c->batch, NUMA_NO_NODE, true);
 	else if (cnt > c->high_watermark)
 		free_bulk(c);
 }
@@ -367,7 +371,7 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
 	 * prog won't be doing more than 4 map_update_elem from
 	 * irq disabled region
 	 */
-	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu));
+	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu), false);
 }
 
 /* When size != 0 bpf_mem_cache for each cpu.
-- 
2.41.0.487.g6d72f3e995-goog


