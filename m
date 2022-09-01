Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A32A5A9CE5
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 18:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiIAQQm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 12:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbiIAQQl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 12:16:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79404201AC
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 09:16:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so2878886pja.4
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 09:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=42e36wx7XXKoNRKIF9mVOArDC422WoW66dv9/nAsqMQ=;
        b=mEyjFDXtAvOlKfUWKYjrinEOWqFoQlAn3j+ZAMCU0tYmuUaQh3eq4Gze2eLJ369IRz
         nyeIQmdP7+dprrgfnAvrx30leEeMSmCN4Lrneqq7t7lEk8doeNLsV5xpp0HGxTkmBFvp
         CNUGH8KNInPDESJ6RdgFJpSf/sUycGWv1RZZ4oljJuad1tZlbQSi32D9Qs1IUzGHTEJi
         Ww9Thux9nyc+ke7zAO7lkLoEelNDn+ZE5t2wt70H4U/zFMcpfc9blv7tHJIcoVn35zCY
         qEl1SOf3Drg+71f+mYeZkmi+HueO9olNdFACZ/kYvl6KjAUT4S0K5mx+ogSzqcUww2XK
         l9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=42e36wx7XXKoNRKIF9mVOArDC422WoW66dv9/nAsqMQ=;
        b=Nan9MrHvkA8XazRtbQDkP5/Uan4BlUybhim4/KPy8PSwIWMgC1ZRyRbciee0ZW5l49
         CzvHJFfdZqqcLnPFA4xSFPuJ9uA9wju5pAxcWZtzZYgVwMA6wixP8+ZIeRGAnW8Ejy30
         +PAAyn6Qn4aOooFm3W6bNhvJXtT5NXV0rKkeZ7ZZhPjxlQERI0AAAa2fijq/gxo6kev5
         LAedempdaq2987K+XaxQRTl72aRwtCHFW8T2oh2U/35oY2r467tJccX4KN/9AZMNoEqg
         4Qoj58ZQEXKi0uwnMzlnIR73a1CKMjYNvnXfmU6yRc7zKe89RczTPPqHrwTFXkwRphvr
         29HQ==
X-Gm-Message-State: ACgBeo1tNr1QYbs0y7eytMvratANiAlEy7XFTgx06MDpBqbRdy6bh0oN
        QO2mnLaopY1cZrPFRUoBLWc=
X-Google-Smtp-Source: AA6agR78xK3PbbrN1He9C+ueQ4NagXOAMJTErV01ObA/z2a5A07FWyxOdPTRRTZfgo4z9Aj3X3A58Q==
X-Received: by 2002:a17:903:32cc:b0:174:e627:4909 with SMTP id i12-20020a17090332cc00b00174e6274909mr17798812plr.67.1662048999937;
        Thu, 01 Sep 2022 09:16:39 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::3:4dc5])
        by smtp.gmail.com with ESMTPSA id mh16-20020a17090b4ad000b001f8aee0d826sm3498191pjb.53.2022.09.01.09.16.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Sep 2022 09:16:39 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 13/15] bpf: Prepare bpf_mem_alloc to be used by sleepable bpf programs.
Date:   Thu,  1 Sep 2022 09:15:45 -0700
Message-Id: <20220901161547.57722-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901161547.57722-1-alexei.starovoitov@gmail.com>
References: <20220901161547.57722-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
Then use call_rcu() to wait for normal progs to finish
and finally do free_one() on each element when freeing objects
into global memory pool.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 967ccd02ecb8..a66bca8caddf 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -230,6 +230,13 @@ static void __free_rcu(struct rcu_head *head)
 	atomic_set(&c->call_rcu_in_progress, 0);
 }
 
+static void __free_rcu_tasks_trace(struct rcu_head *head)
+{
+	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
+
+	call_rcu(&c->rcu, __free_rcu);
+}
+
 static void enque_to_free(struct bpf_mem_cache *c, void *obj)
 {
 	struct llist_node *llnode = obj;
@@ -255,7 +262,11 @@ static void do_call_rcu(struct bpf_mem_cache *c)
 		 * from __free_rcu() and from drain_mem_cache().
 		 */
 		__llist_add(llnode, &c->waiting_for_gp);
-	call_rcu(&c->rcu, __free_rcu);
+	/* Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
+	 * Then use call_rcu() to wait for normal progs to finish
+	 * and finally do free_one() on each element.
+	 */
+	call_rcu_tasks_trace(&c->rcu, __free_rcu_tasks_trace);
 }
 
 static void free_bulk(struct bpf_mem_cache *c)
@@ -457,6 +468,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 		/* c->waiting_for_gp list was drained, but __free_rcu might
 		 * still execute. Wait for it now before we free 'c'.
 		 */
+		rcu_barrier_tasks_trace();
 		rcu_barrier();
 		free_percpu(ma->cache);
 		ma->cache = NULL;
-- 
2.30.2

