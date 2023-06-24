Return-Path: <bpf+bounces-3347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1377C73C676
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 05:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51A0281EFF
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 03:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0B620F0;
	Sat, 24 Jun 2023 03:14:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0A7F;
	Sat, 24 Jun 2023 03:14:02 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DD3E47;
	Fri, 23 Jun 2023 20:14:01 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666edfc50deso953958b3a.0;
        Fri, 23 Jun 2023 20:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687576440; x=1690168440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NzUeillbcneAmPlmWD6PS2VoyHI/+zawYBd3/Cla9Q=;
        b=WOvB2DoFrcCtkYpdzTee0UfRcZ88G3EyFMnIdQ/OfGfpioFFt2EI0pHnOK8QDFQcUn
         3CG002jvQgYcUtr4Wrkh269r8u+IMXFq6wpIrmUZ9lSG0DqhZVLPs1dn54JXHcNprfg+
         uQ4M269JQLLQLl5nuKBZzrov6FfiLdVmm9OXURYEC4q0kaAQCNWusoJuJEej2OYGs7g5
         sth4AvvSdZAisNZQjCDt9qzzVnJ2vrSFYrcT72zI88US1IPfinnit68ayqcCs0jWRNhN
         GGfdY8Qeg67KH6Z6V7o/3BxM1EQ5zHCCTplTcwimq33KENvOy+lOBhyrjFN0qSBiNICT
         9EtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687576440; x=1690168440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NzUeillbcneAmPlmWD6PS2VoyHI/+zawYBd3/Cla9Q=;
        b=MS4lJuKPxO3OlCKYkMhs1vIpXa3PUBWzwJ+zMZZHVcMZSNj8nbXW52woqfD0hhshB2
         jKe6gC3zqii9mBmLV10ijTQ4/Os75jMBCe/VZyDuEf/iKDPT7YzH7lVX4WV4gjCFGghP
         Ea2C+JIYh2flvO7pUtO07jZlhDjEBUev7a+zMnjTOj9V4N3CKRi/LuttWgnEJ8qJQA2V
         uC4FrwCrfqktph0Uu0sjVXibiwZSMcQdRCnw7YG1IbU4dZ0V7ZdhLnMCun1U+0f8ibdx
         JNv/PtvQfqZkNhgalSyaKCQAekMCGGGrrSQSGUyV7qy52RbtWhaaoqtZIbxYNaQdxuB0
         yrUA==
X-Gm-Message-State: AC+VfDz6sLwxbLIS+G8lVkh9y7ogExm9BW7QsIpjjFJm4y8XI1fsEuPJ
	b1bV/PSOAe5FHn0/2NYhsnY=
X-Google-Smtp-Source: ACHHUZ6YBhluqOiTsx34LSBcnnY9tu+ylZF2DnVSdPaVCqp5S44vjjm8wFeoE6xwEJObVsQtwoUJew==
X-Received: by 2002:a05:6a00:e85:b0:666:6c01:2e9e with SMTP id bo5-20020a056a000e8500b006666c012e9emr31798591pfb.15.1687576440512;
        Fri, 23 Jun 2023 20:14:00 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:b07c])
        by smtp.gmail.com with ESMTPSA id 16-20020a630f50000000b00553c09cc795sm318137pgp.50.2023.06.23.20.13.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Jun 2023 20:14:00 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 06/13] bpf: Optimize moving objects from free_by_rcu_ttrace to waiting_for_gp_ttrace.
Date: Fri, 23 Jun 2023 20:13:26 -0700
Message-Id: <20230624031333.96597-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
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

Optimize moving objects from free_by_rcu_ttrace to waiting_for_gp_ttrace
by remembering the tail.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index b07368d77343..4fd79bd51f5a 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -101,6 +101,7 @@ struct bpf_mem_cache {
 
 	/* list of objects to be freed after RCU tasks trace GP */
 	struct llist_head free_by_rcu_ttrace;
+	struct llist_node *free_by_rcu_ttrace_tail;
 	struct llist_head waiting_for_gp_ttrace;
 	struct rcu_head rcu_ttrace;
 	atomic_t call_rcu_ttrace_in_progress;
@@ -273,24 +274,27 @@ static void enque_to_free(struct bpf_mem_cache *c, void *obj)
 	/* bpf_mem_cache is a per-cpu object. Freeing happens in irq_work.
 	 * Nothing races to add to free_by_rcu_ttrace list.
 	 */
-	__llist_add(llnode, &c->free_by_rcu_ttrace);
+	if (__llist_add(llnode, &c->free_by_rcu_ttrace))
+		c->free_by_rcu_ttrace_tail = llnode;
 }
 
 static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 {
-	struct llist_node *llnode, *t;
+	struct llist_node *llnode;
 
 	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1))
 		return;
 
 	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
-	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu_ttrace))
+	llnode = __llist_del_all(&c->free_by_rcu_ttrace);
+	if (llnode)
 		/* There is no concurrent __llist_add(waiting_for_gp_ttrace) access.
 		 * It doesn't race with llist_del_all either.
 		 * But there could be two concurrent llist_del_all(waiting_for_gp_ttrace):
 		 * from __free_rcu() and from drain_mem_cache().
 		 */
-		__llist_add(llnode, &c->waiting_for_gp_ttrace);
+		__llist_add_batch(llnode, c->free_by_rcu_ttrace_tail,
+				  &c->waiting_for_gp_ttrace);
 	/* Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
 	 * If RCU Tasks Trace grace period implies RCU grace period, free
 	 * these elements directly, else use call_rcu() to wait for normal
-- 
2.34.1


