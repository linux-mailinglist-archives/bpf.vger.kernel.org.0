Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7BC67F2DD
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjA1ARA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjA1AQ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:16:59 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F977B40C;
        Fri, 27 Jan 2023 16:16:58 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id j5so6123002pjn.5;
        Fri, 27 Jan 2023 16:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rv/Uvu6EIXemVLIIVSqALTZG9BUUBydUSWzFLjEsx9Q=;
        b=LKnAW9kbk6fSzGjKiTmZQwsTmnSrS+oZ9BtMVJkwkeOpm9dgSgoKqp8mDg7qin9Owz
         iwNZ/3tU2uAJfzTsBa9p97wcSufjZ6NeizVN/nRD4LsRCyX6592NaWhKMUHZzFQ2g8AU
         NMEEf08EBE3300salRJMVuYj73w27QqZySqFazJKi3/4ekFmx8hUv0hgRYOQ8HXi9DvI
         w2aWyGkWqqv8Bazn89LJQnZsv8Rv2cl2lW1FMmL6OWO1SS/h9Jmr9I4BXIOoSU+47MY4
         g7gJb9UQIMRf4syiLmlC8Xeg+H8YTyf4w6XM9ruwmOs+CQ4Am/+JuRpygMaQQhhAHIt3
         GsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rv/Uvu6EIXemVLIIVSqALTZG9BUUBydUSWzFLjEsx9Q=;
        b=ZFJRna3KHbswrl1Yw32voTkCtBT6/5jvv8U5ShwnQYGohwJtN03eNhGz0k7W83wxkh
         ilnLfOiSk+sY6vrjenDUnx2ZTWXaGjMwE69LV29cP2O1D/dIxkaZE2L4mEi6BB6iOeJj
         eGw/drcISIXbCzG+oHqdgp9aVdTO6kWiM1rUgD/g++L99mIXI6DgSyrgVvViMciuesQY
         1zVaxSFucYlaD5uzlqiKaAiZ1KZ5cqi4cam+1/SUxgemh4iSr2hjMOan95wMHjRWbU/5
         8KB02DAqqLBVPmwgwl2zAbUUP6MFNi+VsHtabQORT0xKuAPV1urak5utiOa6ClZ2YGLy
         zcrQ==
X-Gm-Message-State: AFqh2kopRg419zEkmrl3/TCz3NC0F78hueN0JP79+W7642Iqaf1+5iij
        G+ITm4k7iAKszkXo90YFCnU=
X-Google-Smtp-Source: AMrXdXuDbEZYk/r9/lUgsj4m90FAYld3xbjORnaamrPrJgOOCV49qdsiTYysJnM5Msc/44bwjcJh2A==
X-Received: by 2002:a17:902:9b97:b0:194:a1f6:65ae with SMTP id y23-20020a1709029b9700b00194a1f665aemr37365357plp.12.1674865017926;
        Fri, 27 Jan 2023 16:16:57 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902d50700b0017f74cab9eesm3428123plg.128.2023.01.27.16.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:16:57 -0800 (PST)
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
Subject: [PATCH 03/30] sched: Restructure sched_class order sanity checks in sched_init()
Date:   Fri, 27 Jan 2023 14:16:12 -1000
Message-Id: <20230128001639.3510083-4-tj@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128001639.3510083-1-tj@kernel.org>
References: <20230128001639.3510083-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
index bfc3312f305a..65f21f8bf738 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9721,12 +9721,12 @@ void __init sched_init(void)
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
2.39.1

