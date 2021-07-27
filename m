Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822753D783C
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 16:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbhG0OMw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 10:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbhG0OMv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 10:12:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1031C061764
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 07:12:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l4so15395468wrs.4
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 07:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QR9jJL/Uvm+62LnA1ziwlgBrfvBLKf5QTJFduM8WRLQ=;
        b=uLpt/P7SkjsqhJX0t0OKhTNfWtkTuuNKxwTa4ggmLti9bIm5TWevV39qkTnl5v9H1b
         wnLXg8RW5gJxarh083ckdVB4ipK70go02tx1WPbg5kgGO4Zg6s9gZ30k6vuCLQc1Gi3z
         SoVTssc3aZwhpayiwuj7abx2Y5LrvVkXlI3SCoxxRXfnWUs7I8pEYS/fM0yJPxcBG8m7
         svjrl21zl6B3w+4pNJv+O84zW2WysxKr8d8qDfxVhP4SONotsZf981JC/bRBi+9FTxpV
         tKSFckvkRjZzdkSUBpjUcnpHuQUfgIifJjUz+9IXjX7xQJZ2OaqJoO2gS2YFN4biFvDG
         /7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QR9jJL/Uvm+62LnA1ziwlgBrfvBLKf5QTJFduM8WRLQ=;
        b=M2FPxHD0GcCzNdXsGfyspqprYSW/fb0NsYp0/8Z+42sQsA759O4pIqwFwtJ0C7/tQP
         yKRFpIpGhkL6fJ3A+rmsekAzUKuQS2WkuUaVFJB3lqK+/6szWVcfzq7wRd8ADCM1NIZj
         lx1uKdlQnmgsQ0LHUfAILv18d5WCKzsjHkdaDB3oOPu+znjNRDRAN1K7h86OJxyuHs1D
         6vbs5PYfFExEGlj8nPpqGjT8e858LcswgogYpWV8UrKSPrOMXdhPpFtBgOUpzDcsVbGd
         6XBwWiOZ4z4RV3lts8lxPC9bZfdZ9ulybBnlc3IRZXKt+6VNsAA7FavL1Xi9j96y9+ta
         SaEQ==
X-Gm-Message-State: AOAM531tMQ4ibL3qcs+9vo3Lt9dX5omhdKqpuHymKCSAbVqpFLBDmvi2
        m2ZJBoZNvX8nrv03GtsK0xsjpg==
X-Google-Smtp-Source: ABdhPJxBASDSr17bprwY/Kaz2o4B+YEA4sd08CyoWXmUqJU5LSqIdLMb+OjdAW3akqLNxuPX7GNA9Q==
X-Received: by 2002:adf:c3c5:: with SMTP id d5mr17081357wrg.76.1627395169375;
        Tue, 27 Jul 2021 07:12:49 -0700 (PDT)
Received: from localhost.localdomain ([89.18.44.40])
        by smtp.gmail.com with ESMTPSA id t1sm3403912wrm.42.2021.07.27.07.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 07:12:49 -0700 (PDT)
From:   Pavo Banicevic <pavo.banicevic@sartura.hr>
To:     linux@armlinux.org.uk, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, ivan.khoronzhuk@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com, matt.redfearn@mips.com,
        mingo@kernel.org, dvlasenk@redhat.com, juraj.vijtiuk@sartura.hr,
        robert.marko@sartura.hr, luka.perkov@sartura.hr,
        jakov.petrina@sartura.hr
Subject: [PATCH 2/3] arm: include: asm: unified: mask .syntax unified for clang
Date:   Tue, 27 Jul 2021 16:11:18 +0200
Message-Id: <20210727141119.19812-3-pavo.banicevic@sartura.hr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210727141119.19812-1-pavo.banicevic@sartura.hr>
References: <20210727141119.19812-1-pavo.banicevic@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

The samples/bpf reuses linux headers, with clang -emit-llvm,
so this w/a is only for samples/bpf (samples/bpf/Makefile CLANG-bpf).

It allows to build samples/bpf for arm on target board.
In another way clang -emit-llvm generates errors like:

<inline asm>:1:1: error: unknown directive
.syntax unified

I have verified it on clang 5, 6, 7, 8, 9, 10
as on native platform as for cross-compiling. This decision is
arguable, but it doesn't have impact on samples/bpf so it's easier
just ignore it for clang, at least for now...

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 arch/arm/include/asm/unified.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
index 1e2c3eb04353..8718f313e7c4 100644
--- a/arch/arm/include/asm/unified.h
+++ b/arch/arm/include/asm/unified.h
@@ -11,7 +11,9 @@
 #if defined(__ASSEMBLY__)
 	.syntax unified
 #else
-__asm__(".syntax unified");
+
+#ifndef __clang__
+	__asm__(".syntax unified");
 #endif
 
 #ifdef CONFIG_CPU_V7M
-- 
2.32.0

