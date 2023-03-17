Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91466BF443
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjCQVgH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjCQVfy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:35:54 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB902F049;
        Fri, 17 Mar 2023 14:35:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso10590225pjb.0;
        Fri, 17 Mar 2023 14:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAoxgWK3CFgz0aTuA8BNCG0HD1YgZYimkX7KWNGAibg=;
        b=TZidGMi9uz5AczAn70op7sGAvjY19LclymC/wY9OfEByuRYWwzv4OrsI985z9/fjt8
         sX/Pp4O4WbHkKT2WBLzY5An1LDEcAWzSixHr6Bic54cTb/YK3rlGcpXY1MATNFtc0tVH
         e2cIFHytnWkuy04GmIdsxnX/T9Z4ZfBTTjPW5DuyZumM/LZGnhF83mHEeLcRBCdUrbih
         mox9SlD/21AgGmqMoVwgCedymRO81Worr/mZgGvxj3aKwf/OBAHmhok1t30IPttCAEKJ
         qBf9mPf6Vmsei0i/8+uXmLM8MT489PG4ykSFEZUfy4T1Wrk+m84pPY8d5FQAsl398W3y
         oQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nAoxgWK3CFgz0aTuA8BNCG0HD1YgZYimkX7KWNGAibg=;
        b=z+hnQbBSgEHB/Kr4Zi3Kbz4mEb3cIxL6UbMzn+K3OPL4cOIfA08fpNDzR9ueEZyIuT
         z7VwHIk1zdIzEV4nihkYwl0ziHu6tOHFfe09tOCv7uvkF3e3wC10uh7AFTZXYxfZ9tkI
         4U3kFgHo1t5yiaER05IqKIaV4T6hxU9o5aaPZe4NItnLnEiZOFfgkjZJxtXE0ve8uKkJ
         3NC/tVnsVUQ5i5AZQt3mLjy4B98xDum5K9+Qqn0tlCJardxBUttshE0jxWueEDXhbl/s
         gU+1a6Of2LxR3e5v7hW5+4Bzni80RPOQWBWCsdHfwH2ukIRRMN2ewu5ckNeAGTi9gAuX
         LXzw==
X-Gm-Message-State: AO0yUKW1jzv0ZXACei1K1o9a11IisG3OuVsoPvf9XVOeDkpEmcc7glHx
        NBUVZ0kuHESZTUK7lXFlvSg=
X-Google-Smtp-Source: AK7set86/h6ziTkK0pAspNoconBVMYYTPv67WsHRZfqva69Cn4BU9SpzZjGCrVZIj302+XwRg0aO0Q==
X-Received: by 2002:a17:902:db0e:b0:19a:b869:f2f8 with SMTP id m14-20020a170902db0e00b0019ab869f2f8mr10501930plx.21.1679088828634;
        Fri, 17 Mar 2023 14:33:48 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709026b4600b001a19cf1b37esm1988777plt.40.2023.03.17.14.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:33:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/32] sched: Restructure sched_class order sanity checks in sched_init()
Date:   Fri, 17 Mar 2023 11:33:04 -1000
Message-Id: <20230317213333.2174969-4-tj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317213333.2174969-1-tj@kernel.org>
References: <20230317213333.2174969-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, sched_init() checks that the sched_class'es are in the expected
order by testing each adjacency which is a bit brittle and makes it
cumbersome to add optional sched_class'es. Instead, let's verify whether
they're in the expected order using sched_class_above() which is what
matters.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: David Vernet <dvernet@meta.com>
---
 kernel/sched/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fb080ca54d80..efac96fd6cfd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9794,12 +9794,12 @@ void __init sched_init(void)
 	int i;
 
 	/* Make sure the linker didn't screw up */
-	BUG_ON(&idle_sched_class != &fair_sched_class + 1 ||
-	       &fair_sched_class != &rt_sched_class + 1 ||
-	       &rt_sched_class   != &dl_sched_class + 1);
 #ifdef CONFIG_SMP
-	BUG_ON(&dl_sched_class != &stop_sched_class + 1);
+	BUG_ON(!sched_class_above(&stop_sched_class, &dl_sched_class));
 #endif
+	BUG_ON(!sched_class_above(&dl_sched_class, &rt_sched_class));
+	BUG_ON(!sched_class_above(&rt_sched_class, &fair_sched_class));
+	BUG_ON(!sched_class_above(&fair_sched_class, &idle_sched_class));
 
 	wait_bit_init();
 
-- 
2.39.2

