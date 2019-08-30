Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8502A2BC1
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2019 02:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfH3Au5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Aug 2019 20:50:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44880 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbfH3Au4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Aug 2019 20:50:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id e24so4787757ljg.11
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2019 17:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mY025N9ZTLshq6bUASscJHYyFWN73WCKPGSueHP30TA=;
        b=Okdsp5ZxNf0c0ZS1PgudZ1/Uzcx1vh+JyUHLIBaB4gA9eHqIu0am2+/xAGRamBrEmK
         qCvznYgVkMcSDDWdiuCGk34vVj8/mP+ro1bCTjA8Ka3xrOrkCNjL5U6xgrBRNELJmuje
         tp5PnYpAOK9+P7pd2AMtrpQ2VFUiwZgdf+VjTUiXBMwwiLm0B+wHxS9J4hkKQKTR1PMo
         g5JzQdW9lrRdG4QItLYA3aqHsMKgs2n4aIc4BsxCiDVNYjJ1gBnQXG5diF7z2I2DKLba
         2UWvt484BgUsrYmmG+TmQ/bM0gM9QCmze3gdMrsQwFGwno6fmli/VeP2qEfoN4+I/6o0
         LHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mY025N9ZTLshq6bUASscJHYyFWN73WCKPGSueHP30TA=;
        b=PXMLmG5nBpePp5bRy3rnNWNw5UEmjUgFkEreBpElUE/yiT0XOGxas3s6tzsL8rtsKc
         eaU/LokEnlIm/llsh52NWiGCrg9si/0WbLZDbSCCeKySPN8tEvOmQK1AA5LPeq9OE3el
         OGacDSGQaU/h3nPgBZKZSbe4oO8oFmDcO2AbqHgJByebV2txghnSF6aWnu8JH2Uydm9W
         OcJAVa+BpsCZdmX+IOmq1axfkYOlTNDfSMBQBwa3LS67UD03cZxTa1RZVSnHKwnBYLvK
         A8/S4seHQTYRO99A2s4G7MKtA0YhC+/LdxewHy+hV0UEEuUdxcg6ASCbuNVB/O3Ka08K
         7KpA==
X-Gm-Message-State: APjAAAU0Ar2stG5TA4Rf16wgu8whAeiWRjtQZt5Mj5jd97BnSwHNtbYD
        TM44Kw6cGCZF6nDC45zb1eDckg==
X-Google-Smtp-Source: APXvYqwqImk+P6XTagmx3q1aVV2TwK0n5J/VZAS+IZlC8HW1HTeVnR0gZP11ETCdNHIKYsMWLXe3bA==
X-Received: by 2002:a2e:2bda:: with SMTP id r87mr1097319ljr.3.1567126254430;
        Thu, 29 Aug 2019 17:50:54 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id f19sm628149lfk.43.2019.08.29.17.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:50:53 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     linux@armlinux.org.uk, ast@kernel.org, daniel@iogearbox.net,
        yhs@fb.com, davem@davemloft.net, jakub.kicinski@netronome.com,
        hawk@kernel.org, john.fastabend@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH RFC bpf-next 10/10] arm: include: asm: unified: mask .syntax unified for clang
Date:   Fri, 30 Aug 2019 03:50:37 +0300
Message-Id: <20190830005037.24004-11-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
References: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The samples/bpf reuses linux headers, with clang -emit-llvm,
so this w/a is only for samples/bpf (samples/bpf/Makefile CLANG-bpf).

It allows to build samples/bpf for arm on target board.
In another way clang -emit-llvm generates errors like:

<inline asm>:1:1: error: unknown directive
.syntax unified

I have verified it on clang 5, 6 ,7, 8, 9, 10
as on native platform as for cross-compiling. This decision is
arguable, but it doesn't have impact on samples/bpf so it's easier
just ignore it for clang, at least for now...

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 arch/arm/include/asm/unified.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
index 1e2c3eb04353..3cf8757b9a14 100644
--- a/arch/arm/include/asm/unified.h
+++ b/arch/arm/include/asm/unified.h
@@ -11,7 +11,11 @@
 #if defined(__ASSEMBLY__)
 	.syntax unified
 #else
-__asm__(".syntax unified");
+
+#ifndef __clang__
+	__asm__(".syntax unified");
+#endif
+
 #endif
 
 #ifdef CONFIG_CPU_V7M
-- 
2.17.1

