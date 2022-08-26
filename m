Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87585A1F13
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 04:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244877AbiHZCpc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 22:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244903AbiHZCp0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 22:45:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C398F3CBE8
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:45:25 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so270980pji.1
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=v7ijpUUJZb/iDPXwwv+nfCSTFfI8M4d6OICZ7qDTZBE=;
        b=cn76eGXganlgoSYlgV2oR77vIYIassdgrhDQYBNoAST9ehRnVjOr2Y1A6JjG/Tsy5I
         Ppz8xlSx8zrByejMn2V9lfaHXu/5H6GWFlN90v05qIDJ9PKnV21lywriUSObeiwqEBdr
         YMT3umMkrY/zkFJS+KFqUA7Aomj/mZVs2FyFwatqOsy0dNbG2Z58T90p4Me2mvTNJGSw
         uo2qaUJELJZ9ZmI92gG80VbIqCPbpCes0ti9wNMqQFSYaEuRSkgFGVkENkvc5HEvLPKP
         pqjBConTXnhwHmVFJ5cN+k+UvEbjAmcPq7MSnBR2wjL632w0jNq/EG/UghBGxwzwUz8p
         W3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=v7ijpUUJZb/iDPXwwv+nfCSTFfI8M4d6OICZ7qDTZBE=;
        b=aIPnv7ZervQCGUXL5wxHeqoGJYk3qwoxqP4Yc/+1cFqdg8SlR3rQFTWTz7AgXCmWie
         7HjlawTect3io9wn/rx7HjH22jpNj3Bj6QnUIcVTD3XZFz9JWXNkyY0AvBDU/+r0gNc0
         +fjG1zd1htFqHZD0X8sMaBVI8iRAapxzp4K+H3TmVZ9eb718Q6l0QMMl27xKtmZSTUoP
         9u+fbF1SWLEc3OSPIdMhwchb8nOFXCAihwLV/V3YarfoV0QthcjvhK7PNPacTtqOw81x
         945JegLlNt/xU7EVoTkjQe8IsVXM9lMFSuJ2TiPj4zhKX5eMj7m9Rsg14Nk1xKB2B9F8
         P3Mw==
X-Gm-Message-State: ACgBeo2/RnHs3CYwtZv9aRA3CHZDXac+ST3Hf+37Y1Fes6XMpnOeCBeB
        7OGMOab1rrjs7gLyYB30Fq0GEW0Pnco=
X-Google-Smtp-Source: AA6agR4yPXRgq0g4xyroom/XnM5eNSLLTGaNkOmL/K+bgD8y2UnupRj5bBLPVT83fXmgj1fvSWheRQ==
X-Received: by 2002:a17:90b:483:b0:1fb:137e:4bb9 with SMTP id bh3-20020a17090b048300b001fb137e4bb9mr2064418pjb.188.1661481925121;
        Thu, 25 Aug 2022 19:45:25 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:15dc])
        by smtp.gmail.com with ESMTPSA id s6-20020a170902a50600b0016dbe37cebdsm259186plq.246.2022.08.25.19.45.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Aug 2022 19:45:24 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 13/15] bpf: Prepare bpf_mem_alloc to be used by sleepable bpf programs.
Date:   Thu, 25 Aug 2022 19:44:28 -0700
Message-Id: <20220826024430.84565-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
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
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 54455a64699b..9caeeaaf9bcb 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -225,6 +225,13 @@ static void __free_rcu(struct rcu_head *head)
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
@@ -250,7 +257,11 @@ static void do_call_rcu(struct bpf_mem_cache *c)
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
@@ -453,6 +464,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 		/* c->waiting_for_gp list was drained, but __free_rcu might
 		 * still execute. Wait for it now before we free 'c'.
 		 */
+		rcu_barrier_tasks_trace();
 		rcu_barrier();
 		free_percpu(ma->cache);
 		ma->cache = NULL;
-- 
2.30.2

