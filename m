Return-Path: <bpf+bounces-4163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CA2749469
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 05:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65283281244
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E32DA922;
	Thu,  6 Jul 2023 03:35:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E32947D;
	Thu,  6 Jul 2023 03:35:50 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332621BEC;
	Wed,  5 Jul 2023 20:35:43 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1b078b34df5so363765fac.2;
        Wed, 05 Jul 2023 20:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688614542; x=1691206542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smMeUc5DmNi2lwy4EGV+uTKZDtjMFbrXIGNYOVUZ5Gs=;
        b=eJ1M9zYGUcdMJB7lXouxeTk9Ls641bP0IouDn0A9CBSTo3oG6S/NqyLNH9bDknlopZ
         8+J18JxP/uf+sgh+iyHrUTHkp94UHxbVeeseO4uWUJ5ayHbRT6UrJ8j/OvU5GCHdCa/w
         +twF9SE57vlPfK7mxv9lDM4BYGVE1Szmo2STs6Bst4dzKP84udssMAWR9E1P5rACeaZb
         KQKm5I81qqWRtunT991UrGXhCewI0defdMKRSSjrjFq6lqmD5fNsUQtaEZWxLTpkVbLo
         CvwxN76Tn4uP1gt8K2LO0u6JEkypDwmpNc7DQaSR/Yt90RysZdk96fO2QJTe0CbBfzVt
         txhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614542; x=1691206542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smMeUc5DmNi2lwy4EGV+uTKZDtjMFbrXIGNYOVUZ5Gs=;
        b=SPe/RWyxmn7Rr5Ix4NnMwLgIuV2tfAyP9mqNR1SYZn2HN+x1FGWKe/lrEUPKApGhzV
         Zi5PyP8Oqlv9iU3Mlj4V6Qpy26T/KEwmlR7qc5eBSlIx1JEKzyEN4odfZ5eY3G41FryI
         YfShxCQ+VudqS6heMZJ9yaBJfXiKt+JdoNsnU6oPvlr+T+bS4kJJaQ6QlhdDKSzwu750
         nBrP5z1rOE5swUzHWnqSC6BUbGCmHIB6EDR0v1fd/G1EyZLWAA9TNG0zq21UqTSQUaIs
         DYqelmhy7YqB5zqb8OELboPdMNpuHGkgnCbVp6q3RaV+RR/Ir0jfz7iZw7Wek6Kt3q3m
         agtg==
X-Gm-Message-State: ABy/qLavJTOWGQKnAGmvts+38lOtEdl0FaNbE9PUhhWHtE5L0spzepfE
	5ksnTaxTmV6/xoLOfo+34C4=
X-Google-Smtp-Source: APBJJlFimwDBMQBG/8L9mUiaQHodZaxNwiOKJG+xdULukv56qVDE2yKPt7+nFdfs5Gosd4e3Pn6qnw==
X-Received: by 2002:a05:6870:a2c7:b0:1b0:151c:9b19 with SMTP id w7-20020a056870a2c700b001b0151c9b19mr1039388oak.18.1688614542468;
        Wed, 05 Jul 2023 20:35:42 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:f715])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b001ab39cd875csm220092plg.133.2023.07.05.20.35.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Jul 2023 20:35:42 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 13/14] bpf: Convert bpf_cpumask to bpf_mem_cache_free_rcu.
Date: Wed,  5 Jul 2023 20:34:46 -0700
Message-Id: <20230706033447.54696-14-alexei.starovoitov@gmail.com>
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

Convert bpf_cpumask to bpf_mem_cache_free_rcu.
Note that migrate_disable() in bpf_cpumask_release() is still necessary, since
bpf_cpumask_release() is a dtor. bpf_obj_free_fields() can be converted to do
migrate_disable() there in a follow up.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: David Vernet <void@manifault.com>
---
 kernel/bpf/cpumask.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 938a60ff4295..6983af8e093c 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -9,7 +9,6 @@
 /**
  * struct bpf_cpumask - refcounted BPF cpumask wrapper structure
  * @cpumask:	The actual cpumask embedded in the struct.
- * @rcu:	The RCU head used to free the cpumask with RCU safety.
  * @usage:	Object reference counter. When the refcount goes to 0, the
  *		memory is released back to the BPF allocator, which provides
  *		RCU safety.
@@ -25,7 +24,6 @@
  */
 struct bpf_cpumask {
 	cpumask_t cpumask;
-	struct rcu_head rcu;
 	refcount_t usage;
 };
 
@@ -82,16 +80,6 @@ __bpf_kfunc struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask)
 	return cpumask;
 }
 
-static void cpumask_free_cb(struct rcu_head *head)
-{
-	struct bpf_cpumask *cpumask;
-
-	cpumask = container_of(head, struct bpf_cpumask, rcu);
-	migrate_disable();
-	bpf_mem_cache_free(&bpf_cpumask_ma, cpumask);
-	migrate_enable();
-}
-
 /**
  * bpf_cpumask_release() - Release a previously acquired BPF cpumask.
  * @cpumask: The cpumask being released.
@@ -102,8 +90,12 @@ static void cpumask_free_cb(struct rcu_head *head)
  */
 __bpf_kfunc void bpf_cpumask_release(struct bpf_cpumask *cpumask)
 {
-	if (refcount_dec_and_test(&cpumask->usage))
-		call_rcu(&cpumask->rcu, cpumask_free_cb);
+	if (!refcount_dec_and_test(&cpumask->usage))
+		return;
+
+	migrate_disable();
+	bpf_mem_cache_free_rcu(&bpf_cpumask_ma, cpumask);
+	migrate_enable();
 }
 
 /**
-- 
2.34.1


