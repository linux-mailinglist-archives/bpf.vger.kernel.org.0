Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF566BA617
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 05:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCOESB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 00:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjCOESA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 00:18:00 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2652853DB5;
        Tue, 14 Mar 2023 21:17:53 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x11so18730352pln.12;
        Tue, 14 Mar 2023 21:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678853872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fQOGI1xHXx3wVnEpIPq+gxCoMEi4dDb7/a37kcVsMCc=;
        b=GELukM4bxf4+X7l4yVQxtipaL96nAvr5gg+pOnEOKEnvW8dxudSi+eWz3DfT7tkvzb
         1264oHqTZGQ/wWgXp/k62xEKebeLZvJGk/C3zRtN+SU4n3RHP0uRrDtNSRpItDAFijHX
         +FOunZGl20E9LF2qDpcpruq3dpq666VgPukvt6DaDHl4BoaKm6ETqUha/sexEVqGMPQ+
         dVBenQTDRkjTyGLDJpWOWdgPm3JFZ7Bwyt1/s7OtHam4vkMgU4hH5kpWJidt5x6iJcVh
         GSgfnFhP4olyF/DfHrLBN4tC7LRzp7NBwLp8te2rDYYoJgbwR6izkeBAvA4oL0AO/QNv
         /+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678853872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQOGI1xHXx3wVnEpIPq+gxCoMEi4dDb7/a37kcVsMCc=;
        b=aAV1kyeeTy50wlgORyx9K1Bjrh/aNrSFFFJYDP6EPGw9F+dIZY1qFY1I0oqx2n10cl
         hOxNH6hbHMI2PjRjJTUNqpojBAOgRI9Lpf7LmLvJqnMGZmWYBplEqMzPqZaXCejdAWeB
         Ol0bbH4OwNWrLgQri9JiePI2EU2qhHIdU4x9kq0/ylzu7tltFJjCe8enYEgtQbsnlCbi
         lKMH237f+dJoCnkDstx5rthhZ90wF+Ro7or8ZfiQ/WeCo00ZSCOnU011TEMPJl/I1Hlk
         2VWIMq9eLonfbgESRsvhrdsEg18TfTEkpj4pm+MUFhwks0vUj+i/hhk2qzO4plE2LsnX
         ekcg==
X-Gm-Message-State: AO0yUKXERCMYg2e1RjeRkHbrWopq55KzAr+LayTMMKedNg5oVzVNYD2X
        fUqQuRKL5qDTq7j+a9gnx8gOZia1jJMWCQ==
X-Google-Smtp-Source: AK7set/lZ6aK423UYK0VbvPUvHDZxvpdrIxNagH7/NuRUXbYykLhLGnBItdwVzYczO/FmcaJnzvnUA==
X-Received: by 2002:a05:6a20:47d6:b0:d3:84ca:11b with SMTP id ey22-20020a056a2047d600b000d384ca011bmr11396088pzb.40.1678853872515;
        Tue, 14 Mar 2023 21:17:52 -0700 (PDT)
Received: from localhost.localdomain ([106.39.42.26])
        by smtp.gmail.com with ESMTPSA id q21-20020a63e955000000b004fb997a0bd8sm2320359pgj.30.2023.03.14.21.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 21:17:51 -0700 (PDT)
From:   starmiku1207184332@gmail.com
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@outlook.com, Teng Qi <starmiku1207184332@gmail.com>
Subject: [PATCH] kernel: bpf: stackmap: fix a possible sleep-in-atomic bug in bpf_mmap_unlock_get_irq_work()
Date:   Wed, 15 Mar 2023 04:17:21 +0000
Message-Id: <20230315041721.1034794-1-starmiku1207184332@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Teng Qi <starmiku1207184332@gmail.com>

bpf_mmap_unlock_get_irq_work() and bpf_mmap_unlock_mm() cooperate to safely
acquire mm->mmap_lock safely. The code in bpf_mmap_unlock_get_irq_work():
 struct mmap_unlock_irq_work *work = NULL;
 bool irq_work_busy = false;
 if (irqs_disabled()) {
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		work = this_cpu_ptr(&mmap_unlock_work);
 		if (irq_work_is_busy(&work->irq_work)) {
 			irq_work_busy = true;
 		}
 	} else {
 		irq_work_busy = true;
 	}
 }
 *work_ptr = work;

shows that the pointer of struct mmap_unlock_irq_work "work" is not NULL if
irqs_disabled() == true and IS_ENABLED(CONFIG_PREEMPT_RT) == false or NULL in
other cases. The "work" will be passed to bpf_mmap_unlock_mm() as the argument.
The code in bpf_mmap_unlock_mm():
 if (!work) {
 	mmap_read_unlock(mm);
 } else {
 	work->mm = mm;
 	rwsem_release(&mm->mmap_lock.dep_map, _RET_IP_);
 	irq_work_queue(&work->irq_work);
 }

shows that mm->mmap_lock is released directly if "work" is NULL. Otherwise,
irq_work_queue is called to avoid calling mmap_read_unlock() in an irq disabled
context because of its possible sleep operation. However, mmap_read_unlock()
is unsafely called in a preempt disabled context when spin_lock() or
rcu_read_lock() has been called.

We found that some ebpf helpers that call these two functions may be invoked in
preempt disabled contexts through various hooks. We can give an example:
 SEC("kprobe/kmem_cache_free")
 int bpf_prog1(struct pt_regs *ctx)
 {
 	char buff[50];
 	bpf_get_stack(ctx, buff, sizeof(struct bpf_stack_build_id),
	              BPF_F_USER_BUILD_ID | BPF_F_USER_STACK);
 	return 0;
 }

The hook "kprobe/kmem_cache_free" is often called in preempt disabled contexts
by many modules. To fix this possible bug, we add in_atomic() in
bpf_mmap_unlock_get_irq_work().


Signed-off-by: Teng Qi <starmiku1207184332@gmail.com>
---
 kernel/bpf/mmap_unlock_work.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/mmap_unlock_work.h b/kernel/bpf/mmap_unlock_work.h
index 5d18d7d85bef..3d472d24d88f 100644
--- a/kernel/bpf/mmap_unlock_work.h
+++ b/kernel/bpf/mmap_unlock_work.h
@@ -26,7 +26,7 @@ static inline bool bpf_mmap_unlock_get_irq_work(struct mmap_unlock_irq_work **wo
 	struct mmap_unlock_irq_work *work = NULL;
 	bool irq_work_busy = false;
 
-	if (irqs_disabled()) {
+	if (in_atomic() || irqs_disabled()) {
 		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			work = this_cpu_ptr(&mmap_unlock_work);
 			if (irq_work_is_busy(&work->irq_work)) {
-- 
2.25.1

