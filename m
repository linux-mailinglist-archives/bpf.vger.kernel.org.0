Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311D76BC366
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 02:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjCPBl2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 21:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCPBl2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 21:41:28 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2436BAB080;
        Wed, 15 Mar 2023 18:41:27 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id t9so267390qtx.8;
        Wed, 15 Mar 2023 18:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678930886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmYJO+iIXCovawotEcIt4TeAe1rA/wKRkg1b4WWjtqo=;
        b=k02aeUMyEIDSiaISUUew1Pm80Sr21sa1WkgpEnh8QfN6tmURi5iJJIAHnCyRU9nPy7
         f32sLb5SNjPSiWJzTjnxGcgLecazi/YgI4jfCDFxZ9u48DChaXf4TDw1nfE2TrWoYFj/
         GGiL+bmGOUQqotvIh0lnH6TGdFCCGm0OsjcS707t29zWCkq059CTMwiGmIqh9DitoGBK
         3e6M6MxaT0NMdrUubnAoltd4YDf0Pk+uaJAmtxO0bl8ke2Vg2dxFW98zPLJr64gbhLQi
         9IuFRZuYWFAsb7EVfGzNs4FGxBTDOEzNoMvcc3gj7ZH/gWq9TyAKXHLRfjPi9Y0GsdgZ
         wRIQ==
X-Gm-Message-State: AO0yUKWMrfU0Rm9/m2cs7sdZX/nG6YfwVH1T/+3cceOeEgFhS5SO+1IO
        4HVVi9W21uq2wsWRNZcU6dKRN9UN5941VYl/
X-Google-Smtp-Source: AK7set/tePkpx+xqSL3Fa44zFtsjJiZ1mY595ah/w/GGapXjUAczBIgrfnSHIPfdccQaAlsvhA4wiA==
X-Received: by 2002:a05:622a:1449:b0:3b8:6c8e:4f85 with SMTP id v9-20020a05622a144900b003b86c8e4f85mr3085144qtx.43.1678930885853;
        Wed, 15 Mar 2023 18:41:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:5c58])
        by smtp.gmail.com with ESMTPSA id f33-20020a05622a1a2100b003bfb5fd72a7sm5048670qtb.86.2023.03.15.18.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 18:41:25 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 1/5] bpf: Free struct bpf_cpumask in call_rcu handler
Date:   Wed, 15 Mar 2023 20:41:18 -0500
Message-Id: <20230316014122.678082-2-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230316014122.678082-1-void@manifault.com>
References: <20230316014122.678082-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The struct bpf_cpumask type uses the bpf_mem_cache_{alloc,free}() APIs
to allocate and free its cpumasks. The bpf_mem allocator may currently
immediately reuse some memory when its freed, without waiting for an RCU
read cycle to elapse. We want to be able to treat struct bpf_cpumask
objects as completely RCU safe.

This is necessary for two reasons:

1. bpf_cpumask_kptr_get() currently does an RCU-protected
   refcnt_inc_not_zero(). This of course assumes that the underlying
   memory is not reused, and is therefore unsafe in its current form.

2. We want to be able to get rid of bpf_cpumask_kptr_get() entirely, and
   intead use the superior kptr RCU semantics now afforded by the
   verifier.

This patch fixes (1), and enables (2), by making struct bpf_cpumask RCU
safe. A subsequent patch will update the verifier to allow struct
bpf_cpumask * pointers to be passed to KF_RCU kfuncs, and then a latter
patch will remove bpf_cpumask_kptr_get().

Fixes: 516f4d3397c9 ("bpf: Enable cpumasks to be queried and used as kptrs")
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/cpumask.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index b6587ec40f1b..9ab462c5848a 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -24,6 +24,7 @@
  */
 struct bpf_cpumask {
 	cpumask_t cpumask;
+	struct rcu_head rcu;
 	refcount_t usage;
 };
 
@@ -108,6 +109,16 @@ __bpf_kfunc struct bpf_cpumask *bpf_cpumask_kptr_get(struct bpf_cpumask **cpumas
 	return cpumask;
 }
 
+static void cpumask_free_cb(struct rcu_head *head)
+{
+	struct bpf_cpumask *cpumask;
+
+	cpumask = container_of(head, struct bpf_cpumask, rcu);
+	migrate_disable();
+	bpf_mem_cache_free(&bpf_cpumask_ma, cpumask);
+	migrate_enable();
+}
+
 /**
  * bpf_cpumask_release() - Release a previously acquired BPF cpumask.
  * @cpumask: The cpumask being released.
@@ -121,11 +132,8 @@ __bpf_kfunc void bpf_cpumask_release(struct bpf_cpumask *cpumask)
 	if (!cpumask)
 		return;
 
-	if (refcount_dec_and_test(&cpumask->usage)) {
-		migrate_disable();
-		bpf_mem_cache_free(&bpf_cpumask_ma, cpumask);
-		migrate_enable();
-	}
+	if (refcount_dec_and_test(&cpumask->usage))
+		call_rcu(&cpumask->rcu, cpumask_free_cb);
 }
 
 /**
-- 
2.39.0

