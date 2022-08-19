Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8143059A7F5
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 23:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbiHSVn1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 17:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237749AbiHSVnZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 17:43:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9803311A0B
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:43:23 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c2so5166341plo.3
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5M011h9hGg1xDHL/wlpIOyvMja4lICeITJBWcCRlji4=;
        b=AVNDNwVR26ADMyXqQdvKmTsJ2WGpvzN+dngyNzHqfLplmjNWJqTmLst3NChyK67sN9
         fqxXyzs/06uFzhwexRSeSHQnrcSMT7Jpv7SbYM1vijQu9XY1gHvWJRCqRpjszUFQjyQL
         5KExSAuxa4mBSZP9GN1LpNwXjQDeg/KvomeUe01OMG3zHHeshspvUjU1otMnSFLyB2sG
         61amaQBTgBYMQ/wAwSa29D4BjRdEaCFSurKIkNVA6A4/+qy+3nLxloAmTo2wcq2xMoFj
         i9ubuV4S5RjjTqlvaIrgJi6RrKY7aG9XLM1Nq51Umn6IWth3rmCGlEhZ+CplWUvcIxpP
         bUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5M011h9hGg1xDHL/wlpIOyvMja4lICeITJBWcCRlji4=;
        b=5daSyOXX4ayqNrazZ7tOOXsrq5ixRKVMg6/rYKo36ZvHBdmq5vNhVOJIKWr6dnssh9
         VmdjSil/K5WtoIa+ppiyu7DKlTZeDVJP3XMKbJhy+h5qlseEbLaBwKNIqk2B0Nqjw3gS
         HF0eBX+xYB45vgFEA8m4IcgLR87BpMBOl+6K4p2gbRnIlvnlhJrs+bdFjsQoDJ/tnHBl
         ib42b2Kg5sxHT+Hz5Hzz8VtB9/nGRwOXOe2Y7252XfGEmOqsBvbXt6MHhTgO3Z3uZF+4
         EfQ7usqFY0df6nqH3W7UhM0H2WtRP5pv2gZA7J1Af9Mgnce13bgOX5U8MXAo60F2QCOT
         TEDA==
X-Gm-Message-State: ACgBeo1NN2X7kUtzqcV8blTrqt6sF7cmkM9yApUTRzhi7Fx+tS6F0K8M
        KjvHRKzE5SvFs2DHlkHn6w0=
X-Google-Smtp-Source: AA6agR4BY/cxIN0Y0cw8+3sADm8k8hA8ZoCpOczqfNw4A0fjtlT+RFhRwtJYbWAFPYYhHRriqsv1RA==
X-Received: by 2002:a17:902:e80e:b0:16f:14ea:897b with SMTP id u14-20020a170902e80e00b0016f14ea897bmr9361460plg.6.1660945402633;
        Fri, 19 Aug 2022 14:43:22 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:c4b1])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902f68b00b001709aea1516sm3624376plg.276.2022.08.19.14.43.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Aug 2022 14:43:22 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 13/15] bpf: Prepare bpf_mem_alloc to be used by sleepable bpf programs.
Date:   Fri, 19 Aug 2022 14:42:30 -0700
Message-Id: <20220819214232.18784-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
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

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 9e5ad7dc4dc7..d34383dc12d9 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -224,6 +224,13 @@ static void __free_rcu(struct rcu_head *head)
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
@@ -249,7 +256,11 @@ static void do_call_rcu(struct bpf_mem_cache *c)
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
@@ -452,6 +463,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 		/* c->waiting_for_gp list was drained, but __free_rcu might
 		 * still execute. Wait for it now before we free 'c'.
 		 */
+		rcu_barrier_tasks_trace();
 		rcu_barrier();
 		free_percpu(ma->cache);
 		ma->cache = NULL;
-- 
2.30.2

