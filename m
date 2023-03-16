Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9533F6BC5C2
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 06:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCPFkk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 01:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCPFki (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 01:40:38 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F335A1B1;
        Wed, 15 Mar 2023 22:40:37 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id x8so555597qvr.9;
        Wed, 15 Mar 2023 22:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678945237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqdX1QaRwIooZT8c9LoVfwKnRXDO5nO+/Pj89wdMEuk=;
        b=uhG3Z31MYUExDONsAkQsL4axFQe4FDkcwSnde04edN1C7CH8k9GE2xK67BRLBMTY17
         W8afpqQBw7FbOh1b4e9QamcBYhbgG4Xit2cNX2hPWqnr8xwhgcWS4VXhKTDT30EN7AEa
         AJXEJZV+PlsY/5fpSeaeKmlxA9IeJCXEa3boQx/xNlUbyxAiOP3CCpCZILL58QZT7gh3
         2SwTFtYi9gr5+FVVTPc2lkCJ2TNFCb53GKB2MJiu+neWHdvxI/BHSDUIcbrjiZa4p5SZ
         149Y+StTEcZICRr/iWMSFeMsY8Hslo9ZH2QwZyJSalBi3ZStgjkXlVW4jnRxdRAOzdne
         jotA==
X-Gm-Message-State: AO0yUKXlGLapgcBSSUJtJKXndqmvNnrODN2Zhp31ujtpQOKtYAZ7JLtm
        imKCSfSqf6/b7th/sAUXTiYx2rO0BS4tUY0r
X-Google-Smtp-Source: AK7set/efTvVWm71l12hfzdyvLilNhTEqIyWrk1Pjc/PsSHMFmUcnWAjCkMK4OwM5AMYH7AIgnmvIw==
X-Received: by 2002:a05:6214:1c81:b0:577:4ea5:243f with SMTP id ib1-20020a0562141c8100b005774ea5243fmr29565976qvb.7.1678945236627;
        Wed, 15 Mar 2023 22:40:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:7f57])
        by smtp.gmail.com with ESMTPSA id r8-20020ae9d608000000b0073b7f2a0bcbsm5199468qkk.36.2023.03.15.22.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 22:40:36 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/5] bpf: Free struct bpf_cpumask in call_rcu handler
Date:   Thu, 16 Mar 2023 00:40:24 -0500
Message-Id: <20230316054028.88924-2-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230316054028.88924-1-void@manifault.com>
References: <20230316054028.88924-1-void@manifault.com>
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
 kernel/bpf/cpumask.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index b6587ec40f1b..98eea62b6b7b 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -9,6 +9,7 @@
 /**
  * struct bpf_cpumask - refcounted BPF cpumask wrapper structure
  * @cpumask:	The actual cpumask embedded in the struct.
+ * @rcu:	The RCU head used to free the cpumask with RCU safety.
  * @usage:	Object reference counter. When the refcount goes to 0, the
  *		memory is released back to the BPF allocator, which provides
  *		RCU safety.
@@ -24,6 +25,7 @@
  */
 struct bpf_cpumask {
 	cpumask_t cpumask;
+	struct rcu_head rcu;
 	refcount_t usage;
 };
 
@@ -108,6 +110,16 @@ __bpf_kfunc struct bpf_cpumask *bpf_cpumask_kptr_get(struct bpf_cpumask **cpumas
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
@@ -121,11 +133,8 @@ __bpf_kfunc void bpf_cpumask_release(struct bpf_cpumask *cpumask)
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

