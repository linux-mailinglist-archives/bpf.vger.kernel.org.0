Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FC5596F6C
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 15:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239682AbiHQNJz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 09:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239715AbiHQNJb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 09:09:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCF862C2
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 06:08:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k16so959488wrx.11
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 06:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=yZJd/ZKQ9mlwmL6Q+KyC3+p6JDQdyYFK//6TmktPmuw=;
        b=HERUzvZz3x8ABix1FIP+TbJTfGTZSruRspdVloO6vi7RWmlGqoJmzN70Ij2hspbPJT
         c5ruJI2w1d72QpHUIQzNapLkpbd8W+R5kUpQq8OZy/xpjSxyFxwUjqUq4Ll0aNS62fLX
         Hp5m43Zhd4CWh+N0k3+kP+yqyekOnt+SSewVnnNM9rBGfWRwvG4tRgfzOzRIZCMu0COE
         0Mc3H0y+J1cNy349Zq0uBntKkGLFXnrQTUe3DoIpBRuSgua891UW+ZP5P8M2fODV9MGb
         RVlTmADNsfLN3L2Z/67fCbGQfG6IMOinMxBcHwqCVpI6AVRgvqgXcWKDLolIgbSbcjHc
         TdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=yZJd/ZKQ9mlwmL6Q+KyC3+p6JDQdyYFK//6TmktPmuw=;
        b=ULgWo7RRpncGd2X3M45ZSnMiv3oIRR8xTZP/mJkt6QeSlE/HHykEPjLbuXKI6Rs3tn
         xbpy8IZzIAit6pYH3dE3BeWiLYO5x4Fx6gUL09IPlkpq16rPwM8uwuIS00FRbS6IrDxb
         x89l/ZMenRqDUBYV0SLEFmJ1cL/6K1eHRJhnI+3OnrXAg5VuDmbnhYT/evBqiNbZvgM6
         mZE+Vn94o7pQcQYSABy5MgxgclDD8cxEArVYnFWectqWtuuL6WbK7d0Bg6yqEoiaeIPg
         4nyBeOA+bD/F3Qzq5SnUs7ZBogcAhWTqStBSrB1kV1XvdlHuDXXZ/Tn607ttO5KY05xh
         JVDw==
X-Gm-Message-State: ACgBeo3LAmQCDMU+kJUomqpS3wC1BZEnMWNxG/uRnqYiAjv23w62jGGD
        t5DDXNfG/zr3lH/mfJaD197Vtw==
X-Google-Smtp-Source: AA6agR7Bz9c08dnhsKjG95ErmPIkScVNcf3tP2jSx1acZbBbcuGlSunXlydBesdvB/bT9w9X0zBFsQ==
X-Received: by 2002:adf:e710:0:b0:225:109d:456d with SMTP id c16-20020adfe710000000b00225109d456dmr5510742wrm.589.1660741695800;
        Wed, 17 Aug 2022 06:08:15 -0700 (PDT)
Received: from localhost ([109.180.234.208])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b003a5ce167a68sm2198796wms.7.2022.08.17.06.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 06:08:14 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     ast@kernel.org
Cc:     Punit Agrawal <punit.agrawal@bytedance.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhoufeng.zf@bytedance.com,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, jolsa@kernel.org
Subject: [PATCH] bpf: Simplify code by using for_each_cpu_wrap()
Date:   Wed, 17 Aug 2022 14:08:07 +0100
Message-Id: <20220817130807.68279-1-punit.agrawal@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In the percpu freelist code, it is a common pattern to iterate over
the possible CPUs mask starting with the current CPU. The pattern is
implemented using a hand rolled while loop with the loop variable
increment being open-coded.

Simplify the code by replacing the while() loops with
for_each_cpu_wrap() helper to iterate over the possible cpus starting
with the current CPU. As a result, some of the special-casing in the
loop also gets simplified.

No functional change intended.

Signed-off-by: Punit Agrawal <punit.agrawal@bytedance.com>
---
Hi,

I noticed an opportunity for simplifying the code while reviewing a
backport for one of the commits in this area.

Please consider merging.

Thanks,
Punit

 kernel/bpf/percpu_freelist.c | 42 ++++++++++--------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
index 00b874c8e889..9dd9201c6f07 100644
--- a/kernel/bpf/percpu_freelist.c
+++ b/kernel/bpf/percpu_freelist.c
@@ -56,10 +56,9 @@ static inline bool pcpu_freelist_try_push_extra(struct pcpu_freelist *s,
 static inline void ___pcpu_freelist_push_nmi(struct pcpu_freelist *s,
 					     struct pcpu_freelist_node *node)
 {
-	int cpu, orig_cpu;
+	int cpu;
 
-	orig_cpu = cpu = raw_smp_processor_id();
-	while (1) {
+	for_each_cpu_wrap(cpu, cpu_possible_mask, raw_smp_processor_id()) {
 		struct pcpu_freelist_head *head;
 
 		head = per_cpu_ptr(s->freelist, cpu);
@@ -68,15 +67,10 @@ static inline void ___pcpu_freelist_push_nmi(struct pcpu_freelist *s,
 			raw_spin_unlock(&head->lock);
 			return;
 		}
-		cpu = cpumask_next(cpu, cpu_possible_mask);
-		if (cpu >= nr_cpu_ids)
-			cpu = 0;
-
-		/* cannot lock any per cpu lock, try extralist */
-		if (cpu == orig_cpu &&
-		    pcpu_freelist_try_push_extra(s, node))
-			return;
 	}
+
+	/* cannot lock any per cpu lock, try extralist */
+	pcpu_freelist_try_push_extra(s, node);
 }
 
 void __pcpu_freelist_push(struct pcpu_freelist *s,
@@ -125,13 +119,12 @@ static struct pcpu_freelist_node *___pcpu_freelist_pop(struct pcpu_freelist *s)
 {
 	struct pcpu_freelist_head *head;
 	struct pcpu_freelist_node *node;
-	int orig_cpu, cpu;
+	int cpu;
 
-	orig_cpu = cpu = raw_smp_processor_id();
-	while (1) {
+	for_each_cpu_wrap(cpu, cpu_possible_mask, raw_smp_processor_id()) {
 		head = per_cpu_ptr(s->freelist, cpu);
 		if (!READ_ONCE(head->first))
-			goto next_cpu;
+			continue;
 		raw_spin_lock(&head->lock);
 		node = head->first;
 		if (node) {
@@ -140,12 +133,6 @@ static struct pcpu_freelist_node *___pcpu_freelist_pop(struct pcpu_freelist *s)
 			return node;
 		}
 		raw_spin_unlock(&head->lock);
-next_cpu:
-		cpu = cpumask_next(cpu, cpu_possible_mask);
-		if (cpu >= nr_cpu_ids)
-			cpu = 0;
-		if (cpu == orig_cpu)
-			break;
 	}
 
 	/* per cpu lists are all empty, try extralist */
@@ -164,13 +151,12 @@ ___pcpu_freelist_pop_nmi(struct pcpu_freelist *s)
 {
 	struct pcpu_freelist_head *head;
 	struct pcpu_freelist_node *node;
-	int orig_cpu, cpu;
+	int cpu;
 
-	orig_cpu = cpu = raw_smp_processor_id();
-	while (1) {
+	for_each_cpu_wrap(cpu, cpu_possible_mask, raw_smp_processor_id()) {
 		head = per_cpu_ptr(s->freelist, cpu);
 		if (!READ_ONCE(head->first))
-			goto next_cpu;
+			continue;
 		if (raw_spin_trylock(&head->lock)) {
 			node = head->first;
 			if (node) {
@@ -180,12 +166,6 @@ ___pcpu_freelist_pop_nmi(struct pcpu_freelist *s)
 			}
 			raw_spin_unlock(&head->lock);
 		}
-next_cpu:
-		cpu = cpumask_next(cpu, cpu_possible_mask);
-		if (cpu >= nr_cpu_ids)
-			cpu = 0;
-		if (cpu == orig_cpu)
-			break;
 	}
 
 	/* cannot pop from per cpu lists, try extralist */
-- 
2.35.1

