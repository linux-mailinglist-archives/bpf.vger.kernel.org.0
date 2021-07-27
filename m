Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42ABA3D7838
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 16:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbhG0OMp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 10:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbhG0OMo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 10:12:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB77C061765
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 07:12:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f14-20020a05600c154eb02902519e4abe10so1965517wmg.4
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 07:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qh2D1P9GbylvB9WoMcMMTns7dk4r496odHfS4e44Lvg=;
        b=dZJmp177mREM10LfYUmdsmKymvqT9zX8M9d5RPLo0iJkNjXevLNRLGN2N3SaMXmwG0
         vMLcK3Egi3Dx/TofYjBPkZVs7gZomoKadG+grDxLH/zhPIVWshiOWPbIRlOnhI23xx2V
         8JU1Y/mZQpn/iSv0KXvTHP3kgMnFZsLIzPMcGPaDUfIPkmo/OjpDGiYVIXj37ZxwMHCw
         GSdXIX+TYtZnqwoZQcK3nfX9Pk53gGJlNtMzXWBMdFWCxYb0uBNYFx233cwHTgvTkXz+
         bCVsfLtAaE4uD5SIZKMVIA5/cIvjop2of7YyRCNS3Z08nVO9dXrgqQQ15ovFDDCOHsXP
         nNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qh2D1P9GbylvB9WoMcMMTns7dk4r496odHfS4e44Lvg=;
        b=F7rpDDAO/B4w3WWdy5tENEYZICv7Bc4atTeyVWDSsvotk9+l6HpBJTHEhQ5gXAiQUw
         zUoe4o5cAbYL97A3WXvde4R0RRi1p12IhSkHrHadh7KP7g6Hfz6E7gmMbEcVsktYv1Sa
         Cvf8m7nWhR06Ni2liCwR+Cs4gmFu+s5/N9ynjGBqir+Ztou38nnxrqIm57WBWfYOfcbe
         /7/To7kduX/iD92lM10FOjIJqTfnH0jCLR0IQl51AUk10QdBpeRWgbSyVBHqM/AtXzf7
         EPvEX0SWXluslfqhz0snobxcFGXzRjgK3BGfnSU8rylz42eExmJEIn8XpG/YI7WyMJqv
         6Rag==
X-Gm-Message-State: AOAM531005ztD2fYpeCK9a/KD1sg0CNh3kHmzBVkjVyhvnXCAXYJtyBh
        z7bywF83VirfNGCGlkzbYPjd/w==
X-Google-Smtp-Source: ABdhPJwxw8NT0xdiy200Yml8rZafYGmbp6+07m5Rczyx8Rmsxg2J5fenyyka4XSwb6wfG6tz1ibW8g==
X-Received: by 2002:a05:600c:2907:: with SMTP id i7mr4369027wmd.184.1627395162452;
        Tue, 27 Jul 2021 07:12:42 -0700 (PDT)
Received: from localhost.localdomain ([89.18.44.40])
        by smtp.gmail.com with ESMTPSA id t1sm3403912wrm.42.2021.07.27.07.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 07:12:42 -0700 (PDT)
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
Subject: [PATCH 1/3] arm: include: asm: swab: mask rev16 instruction for clang
Date:   Tue, 27 Jul 2021 16:11:17 +0200
Message-Id: <20210727141119.19812-2-pavo.banicevic@sartura.hr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210727141119.19812-1-pavo.banicevic@sartura.hr>
References: <20210727141119.19812-1-pavo.banicevic@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

The samples/bpf with clang -emit-llvm reuses linux headers to build
bpf samples, and this w/a only for samples (samples/bpf/Makefile
CLANG-bpf).

It allows to build samples/bpf for arm bpf using clang.
In another way clang -emit-llvm generates errors like:

CLANG-bpf  samples/bpf/tc_l2_redirect_kern.o
<inline asm>:1:2: error: invalid register/token name
rev16 r3, r0

This decision is arguable, probably there is another way, but
it doesn't have impact on samples/bpf, so it's easier just ignore
it for clang, at least for now.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 arch/arm/include/asm/swab.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/swab.h b/arch/arm/include/asm/swab.h
index c6051823048b..a9fd9cd33d5e 100644
--- a/arch/arm/include/asm/swab.h
+++ b/arch/arm/include/asm/swab.h
@@ -25,8 +25,11 @@ static inline __attribute_const__ __u32 __arch_swahb32(__u32 x)
 	__asm__ ("rev16 %0, %1" : "=r" (x) : "r" (x));
 	return x;
 }
+
+#ifndef __clang__
 #define __arch_swahb32 __arch_swahb32
 #define __arch_swab16(x) ((__u16)__arch_swahb32(x))
+#endif
 
 static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
 {
-- 
2.32.0

