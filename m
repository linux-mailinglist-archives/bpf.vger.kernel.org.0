Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89346D859A
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 20:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbjDESEK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 14:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjDESDy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 14:03:54 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9147672A9
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 11:03:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n9-20020a05600c4f8900b003f05f617f3cso3347003wmq.2
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 11:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680717779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCRr5H3+UuYPyZozTZ61KEaaCsnzGj0McQyaAuLox6Y=;
        b=VRGLF6jYpqlAUjlImbNGc9MAbL+CwYzIVyjcpCvSfXD6sQX9PKy+4myAOoc4WbAbkW
         D+KltU67z9hJ+/GOxp6DrjoYihchae67PJR3xjST8iAKcNjCodZ15EgPWNvXbCCblr5b
         zYr2eOXongK1hoZvSmIoEoGWnCFuVT/ZDbl1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680717779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCRr5H3+UuYPyZozTZ61KEaaCsnzGj0McQyaAuLox6Y=;
        b=X2Hada02G0RQBaBh/xLiX9jQ2YuI1ejgDLjNKy3H85NIUclNIgcD+nRpfvduy/rSC7
         Ph+dO/1z/y+lSfXA9sQu+XmqB7cspNkOgXjEMokOM+MsoJzxWLyo+6gP4SmzREQld2IN
         0z3r7bCihE3z2ua9d17EkBI1+Zikff4Ep4Hn91THkSfWtjPyYOTo5kvRhUyMuPhHDSRm
         nybHkeW+KCgbbCTABoW7BVZDza0xRHnP9TPPzqv2+cur1kYLOWnitXMlEYwFkESk9TMO
         Y9qa9npiEUSo2D3kWyi28TUz7EzVqw+xYy/Q6pf7eCpNLbQGk4R2tGUXvz/6ViLklpFH
         WYCw==
X-Gm-Message-State: AAQBX9e2NZF7h4CSvnqcpzbYD92c1XSTYy8kmaoVVR+ET7kXBUF4DeFO
        6/8etioCrP/QgDeIndUqEG6yyA==
X-Google-Smtp-Source: AKy350bceighfDjd/DZgGBjsH+Kb8HCWWBPSbtjJxKcBSXp/7bD2cQK/+06fC/OP05iTqgJ5Bh0azg==
X-Received: by 2002:a7b:cc98:0:b0:3ed:8079:27d7 with SMTP id p24-20020a7bcc98000000b003ed807927d7mr5232746wma.40.1680717778801;
        Wed, 05 Apr 2023 11:02:58 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:cf6a:9ae6:15f1:4213])
        by smtp.gmail.com with ESMTPSA id bd5-20020a05600c1f0500b003f0472ffc7csm2913233wmb.11.2023.04.05.11.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 11:02:58 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v6 3/5] samples: ftrace: Save required argument registers in sample trampolines
Date:   Wed,  5 Apr 2023 20:02:48 +0200
Message-Id: <20230405180250.2046566-4-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230405180250.2046566-1-revest@chromium.org>
References: <20230405180250.2046566-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The ftrace-direct-too sample traces the handle_mm_fault function whose
signature changed since the introduction of the sample. Since:
commit bce617edecad ("mm: do page fault accounting in handle_mm_fault")
handle_mm_fault now has 4 arguments. Therefore, the sample trampoline
should save 4 argument registers.

s390 saves all argument registers already so it does not need a change
but x86_64 needs an extra push and pop.

This also evolves the signature of the tracing function to make it
mirror the signature of the traced function.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 samples/ftrace/ftrace-direct-too.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index f28e7b99840f..71ed4ee8cb4a 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -5,14 +5,14 @@
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
 
-extern void my_direct_func(struct vm_area_struct *vma,
-			   unsigned long address, unsigned int flags);
+extern void my_direct_func(struct vm_area_struct *vma, unsigned long address,
+			   unsigned int flags, struct pt_regs *regs);
 
-void my_direct_func(struct vm_area_struct *vma,
-			unsigned long address, unsigned int flags)
+void my_direct_func(struct vm_area_struct *vma, unsigned long address,
+		    unsigned int flags, struct pt_regs *regs)
 {
-	trace_printk("handle mm fault vma=%p address=%lx flags=%x\n",
-		     vma, address, flags);
+	trace_printk("handle mm fault vma=%p address=%lx flags=%x regs=%p\n",
+		     vma, address, flags, regs);
 }
 
 extern void my_tramp(void *);
@@ -34,7 +34,9 @@ asm (
 "	pushq %rdi\n"
 "	pushq %rsi\n"
 "	pushq %rdx\n"
+"	pushq %rcx\n"
 "	call my_direct_func\n"
+"	popq %rcx\n"
 "	popq %rdx\n"
 "	popq %rsi\n"
 "	popq %rdi\n"
-- 
2.40.0.577.gac1e443424-goog

