Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9A56BDFD2
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 04:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCQDwj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 23:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCQDwi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 23:52:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0171AB3295;
        Thu, 16 Mar 2023 20:52:36 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id ja10so3966161plb.5;
        Thu, 16 Mar 2023 20:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679025156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H18MmW70IgW5O0wrvBK2R9efjBmq092urFDIxbA45MA=;
        b=J60AiOolPaIc9ikND9TA7GyMtfUWu4GpiRGZIJ7XolcK+AgP68p8EVqRvr+ckQCJ6+
         FJoQO3Bl/dqVqTS3GKRsvd1jZv6fKfl/OhZ9X0yuLgjD9CgywbNXo/vrVrnDFhdKGoRv
         WF0PNm9uyuHcQAkqIZcGa3cdCE6LsCCRjvmA/V+K5XXV+TR77JGMjnJptnOrxIL6hmd3
         s3Arko0j9zxg9xs9kYoVEzcvr7F5N8q/6dJZdA2kE4b65WRRTGaQWJ5EhYzxe2L3f5tx
         aEp1OQMQDoDbsS0TR17hjwPWawCW94Jv64dGYoKC3VCbGxc5NdFWbEXfq1SgZLI7bAD2
         f36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679025156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H18MmW70IgW5O0wrvBK2R9efjBmq092urFDIxbA45MA=;
        b=oS9tm9DjydcwEWpb7pzJ13HjkZooNuwHUJwjq8qRf95EAMRN4fwIM9akvven2z83x1
         w2HGmmGrHNd6AtVg17xiswUPjUJmp5fXxR0dc5/xcPrqDcjqJ/peBEeTWRhv9jV5Jqh3
         SydUtnB2L6oA84VluPu1Pi9RA4hSYupuFNFT7pgh2j1ODG4r4Yp+E/SLK1KBn1ZvSrw6
         /fU0nFugz/CyhBqqtAkZNS8dmGoEgUJnZI3kLlfAZqUm66zK+kN+AA9GHRFQBAFB+fvv
         F2K55l7tDMbVmyBot+rjWylyIvbe2j3XMeJD3cZ9Ye4Eg0Q50GrYZJHcfWX22PguRPMj
         4IUA==
X-Gm-Message-State: AO0yUKVCTmjVHwvsFXqsqhg77LEQ3XE9SI2BJH1nFxJrCdhNAbN7qB6Q
        dE2TuX3PH7Tnz1dNCp8gL10=
X-Google-Smtp-Source: AK7set9fYqEbhrDsKzlgioh68yLtL9rJAbperuK3PkviSnFYXrMS7jRPGZZo3qnBrqq3ThXfjS+C1Q==
X-Received: by 2002:a17:902:d2c7:b0:19a:a520:b203 with SMTP id n7-20020a170902d2c700b0019aa520b203mr7460299plc.25.1679025156369;
        Thu, 16 Mar 2023 20:52:36 -0700 (PDT)
Received: from localhost.localdomain ([106.39.42.201])
        by smtp.gmail.com with ESMTPSA id n6-20020a634006000000b0050b19d24c3bsm408562pga.37.2023.03.16.20.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 20:52:35 -0700 (PDT)
From:   starmiku1207184332@gmail.com
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@outlook.com, Teng Qi <starmiku1207184332@gmail.com>
Subject: [PATCH v2] kernel: bpf: stackmap: fix a possible sleep-in-atomic bug in bpf_mmap_unlock_get_irq_work()
Date:   Fri, 17 Mar 2023 03:52:27 +0000
Message-Id: <20230317035227.22293-1-starmiku1207184332@gmail.com>
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
v2:
Thank for John Fastabend`s friendly response.

We are currently developing a static analysis tool to detect eBPF bugs in the
kernel. During our work, we discovered several possible bugs, including this
one. Unfortunately, we do not have enough information to provide a runnable
case (e.g. selftest case) that would trigger this bug, nor do we have a stack 
trace to offer. Going forward, we plan to improve our tool to provide necessary
information to construct a runnable case thst could reproduce this bug.

Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
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

