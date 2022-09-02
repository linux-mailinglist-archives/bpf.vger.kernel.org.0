Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E065AB9EF
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 23:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiIBVLw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 17:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiIBVLv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 17:11:51 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A34DB7C5
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 14:11:50 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y127so3078446pfy.5
        for <bpf@vger.kernel.org>; Fri, 02 Sep 2022 14:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7zZUv+wUiLTbSdfVlnRTA9LoEPz96HdCoAnAM60zCkc=;
        b=NwS+9ZK2eKTx+aaMOQ7GdHd0ONySpdNTqKHMSj9KKgWrBRR8iXt8Df/fwP/LvFm+10
         D1EWQA+KOVMQrFsTbYkppw0sjJqjbiJ8xgDT/caLNdqxKR3ulJItoGLuoFfkewGl4GVj
         WooLniQWrCHe2zNrOzblGJtjrYvUfDWJTZG1kajIikXP6grHGph1/wguaa33stHepzJ+
         L2ZiXeHpJwK8aDdwIawyaJ8Ex9mjGH+9bWT/TAU3ij0sM/l57nR4efX65CHBrZzq/NiT
         6ZDREUOVgpQFhfiMnmg/RieFkpIfvfPUn9Bw2snvhhpFPoUHuljnJnBJuQFM1RWMjNxA
         19EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7zZUv+wUiLTbSdfVlnRTA9LoEPz96HdCoAnAM60zCkc=;
        b=TldccwNyKZg+Iz/ycMkP1a8pTaUz/gVAdW9e/tvpLMz5MriO77pNVIKH7s2M39YrJT
         nVX3B+hZjvETsqo6+RBVhA4G6S/JTsgr8KXkQg+9g9VQwwmwN6U3RYzF8SqEhgCswY3S
         fzzoaGc2fwS+3JMdyUE2qpWHnQSyqa4Tdgtln3pdq7fC3ql7cPjlbOG+uha2pw5ag+fC
         2eZ6695AeXbvMf86SjTjO2yKcTWs/tYukBbVYvuSR/kZbNrdgRKzTQWZOjEpSPCeCA3C
         gkh0cZ5qJSFXsD+E+dQg2Ep2RU2zMO3BbnydI9NbvnYaOwzv0443YRG/3wpCYIuJmG5v
         BTvg==
X-Gm-Message-State: ACgBeo31Udi+OV63iEb66E1GYR5gTUbKUj5GtSLM+eZxCzQo3+laVzmC
        ZFx4g3pVmjOjiFe9Fv0um7k=
X-Google-Smtp-Source: AA6agR5uPuVHb59iNf+oddnsd3ubEx/z1NYbz1Rk4wngjEXEteRwU+dblj5OPnu6zTdC6eXF++2rNA==
X-Received: by 2002:a63:2048:0:b0:41c:daad:450d with SMTP id r8-20020a632048000000b0041cdaad450dmr31330653pgm.240.1662153110141;
        Fri, 02 Sep 2022 14:11:50 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::c978])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902d49200b0017315b11bb8sm2124526plg.213.2022.09.02.14.11.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Sep 2022 14:11:49 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 13/16] bpf: Prepare bpf_mem_alloc to be used by sleepable bpf programs.
Date:   Fri,  2 Sep 2022 14:10:55 -0700
Message-Id: <20220902211058.60789-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220902211058.60789-1-alexei.starovoitov@gmail.com>
References: <20220902211058.60789-1-alexei.starovoitov@gmail.com>
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
 kernel/bpf/memalloc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index f7b07787581b..8895c016dcdb 100644
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
@@ -471,6 +483,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 		}
 		if (c->objcg)
 			obj_cgroup_put(c->objcg);
+		rcu_barrier_tasks_trace();
 		rcu_barrier();
 		free_percpu(ma->caches);
 		ma->caches = NULL;
-- 
2.30.2

