Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2413A3523FC
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 01:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbhDAXeJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 19:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbhDAXdx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Apr 2021 19:33:53 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85F2C05BD19
        for <bpf@vger.kernel.org>; Thu,  1 Apr 2021 16:32:55 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id ev19so4290750qvb.7
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 16:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CIBsMUAzqVBKJMC//YF4MdkZzSoA2eT4NBvrPysyfhQ=;
        b=BFiANp0pMWHC/IyuQ9DGSiKV70Aw33MNbDtGFQZCptIZJl11fKLLDwlPfO4BrNVOJp
         xzRqfWKuwuvy9O8TfYc7fcGPZWCdHHqTS3flzLSd3zVxDLZBElZvtCaoUsohNJ42lKS+
         7yY0vSiJ4daBjV9yrkjy1OXNtCCbOBPV5KYjE1jSVn2d02AszzrZlgXf0dFPaZ9Up5To
         eq4R0xU+5yBj0s5fhti8O+UcraNwDXGjf0cZET5W6nlaaVo/DY6UE56DTVPCdAsmBb27
         Qg0VzjbU12KqVP1onYHpSPh4rX6We4KOqxllBqzjOZeRf3DS2g8QdGnZX5lmwOzR6vrP
         SHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CIBsMUAzqVBKJMC//YF4MdkZzSoA2eT4NBvrPysyfhQ=;
        b=Zp6EimOuOEQfO5q48jJrH2PD46SwomwFXfa7Gon6KngkGPrFwqNKC8bO8kFXJcfJ1Q
         guImCVcpps7unFF6IfiBM7zEOZWiiiYrFrcaCxIw5EvKLlgpMn94UMQWLZvPU13dJKMP
         +yZo0xkOZXTz0DlmT34iMVjZsDc5Y16n4axrAdrXdkrHrLquA5TTFe/8f2e7nASPpD2w
         oiMiW+jSbNHuPDPE2372lHRPgg5I28lCaYGQdolXAx9S1/ywGj7eVRdBPDiC3sSHDbCv
         pbvRQoM0mUgFN6NzvCBfw/w7u7dyZ6ANlhZ6dfH983Img0g5vfz3zDSuRxh5dCi9nBth
         cxEQ==
X-Gm-Message-State: AOAM530soUHgty2xSoi8hJO/pIOwkdratxfantmU6iuvc2EorPPWe0Ur
        oHE6cjCL5sLbMhOKA3iS6wfpqLfqaBylkCTW7BU=
X-Google-Smtp-Source: ABdhPJwrLvJN4iFq87bXxxrX4+4K8e7wEfk2totPF6AIrVykX4E6RMB+YDXBq4nStyRioTba7CPxK2ZVTVGbLw7Xcks=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a0c:f7d1:: with SMTP id
 f17mr10229433qvo.38.1617319974835; Thu, 01 Apr 2021 16:32:54 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:15 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 17/18] KVM: arm64: Disable CFI for nVHE
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Disable CFI for the nVHE code to avoid address space confusion.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index a6707df4f6c0..fb24a0f022ad 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -75,9 +75,9 @@ quiet_cmd_hyprel = HYPREL  $@
 quiet_cmd_hypcopy = HYPCOPY $@
       cmd_hypcopy = $(OBJCOPY) --prefix-symbols=__kvm_nvhe_ $< $@
 
-# Remove ftrace and Shadow Call Stack CFLAGS.
-# This is equivalent to the 'notrace' and '__noscs' annotations.
-KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# Remove ftrace, Shadow Call Stack, and CFI CFLAGS.
+# This is equivalent to the 'notrace', '__noscs', and '__nocfi' annotations.
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
 
 # KVM nVHE code is run at a different exception code with a different map, so
 # compiler instrumentation that inserts callbacks or checks into the code may
-- 
2.31.0.208.g409f899ff0-goog

