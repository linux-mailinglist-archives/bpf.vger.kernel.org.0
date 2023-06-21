Return-Path: <bpf+bounces-2972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E55737936
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 04:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21816281429
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 02:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE08779E0;
	Wed, 21 Jun 2023 02:33:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE7C6FA9;
	Wed, 21 Jun 2023 02:33:08 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17074B4;
	Tue, 20 Jun 2023 19:33:07 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso4418131a12.1;
        Tue, 20 Jun 2023 19:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687314786; x=1689906786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NzUeillbcneAmPlmWD6PS2VoyHI/+zawYBd3/Cla9Q=;
        b=oebQFylccU4jWEWLnxkRUk56nl8VU9C2KWa8XekBFBjZ7Ht0bGlle76tlI2nUR3qrt
         ipNnqCShC6pD0D+ztVD7enocqdJk2BeSpEgXzBFmFQCUW3vrn1w/GV/mBvYTGfqF+BIk
         +pLE5yKY9EJ5mp1140Yx4phKq97mc0C8b460rhdofJbDl7Rxy615mvngpScxRLZpSjpx
         9R4I4vmQ+aVpnL6mYyAAfYH6sA1tLWnAg5x9KLhTYW/DrCHIRDGhxA4CHKQEp0qt9b3X
         KMrvweOPFsLewe9pcfNRrALjPTVLhEwsb7LLLzjKnvjUkzAXtaLcZhqvCXO+gftGbIau
         wwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687314786; x=1689906786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NzUeillbcneAmPlmWD6PS2VoyHI/+zawYBd3/Cla9Q=;
        b=CgMZmXQe1hjpzLW/hcMsscWoLNZg9K/AK0nlcCCNQE8zHivb9wyHMIb8bF9GIdHWqg
         vJ4Vu6EaPGTlq3eua5vH/UQM3FV5Hjk1WOLyDoSL24AkoOEg+pCS4HrvfpqCtEGE/WQd
         2zL/zCbzGdQZVNRRh1iTRtNcesvrBYTQwvbBDl0hDNSnxVWvujVb3q7nEGyhaXvn5gsZ
         KB+Hx5lo3iRu6l4gVJWkzbmze8i2vCeREitdBsfIDwlOViq2MdLtDJYfQ2GiINoRAu9s
         YjZh9i8bPJj0jvXasDNktd+/6kEZce5nWqCusBt0wlLnu7DLv3lqhDBZ402A1Ye9RBEi
         /wUQ==
X-Gm-Message-State: AC+VfDwiDN74nLWWMrL/Oc8Ug+KyI4BGG9ZaOhirkq+SU8jcjdZkrSQE
	7Oou1wKkEtISmIZZAt/ZVUGefTkM2gM=
X-Google-Smtp-Source: ACHHUZ6MghIpaSWcxZ0YjyTh0Kq6YNJA3vZlCjUoXi8J9U30MtmSP6y3Je02GtvlrHrxemSHe7Ey1w==
X-Received: by 2002:a05:6a20:3d27:b0:121:5c4b:45bc with SMTP id y39-20020a056a203d2700b001215c4b45bcmr11210645pzi.58.1687314786466;
        Tue, 20 Jun 2023 19:33:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:e719])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78742000000b0064f46570bb7sm1878808pfo.167.2023.06.20.19.33.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Jun 2023 19:33:06 -0700 (PDT)
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
Subject: [PATCH bpf-next 06/12] bpf: Optimize moving objects from free_by_rcu_ttrace to waiting_for_gp_ttrace.
Date: Tue, 20 Jun 2023 19:32:32 -0700
Message-Id: <20230621023238.87079-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
References: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
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


