Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E93340B61
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 18:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhCRRMU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 13:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbhCRRLw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 13:11:52 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6765AC061762
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 10:11:52 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id m5so23003462pgu.21
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 10:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WZ2fsTX5FLJhX01BulIdj9aVU+u+1SaaqVDcWrlk7vo=;
        b=p/MDs2PDjsFiD6r2Ts6jM6BFyv2fovLwrbhh8l+TmOVc+XN/ujL2rtlnXKiP30RH8t
         S6UgRxg5+yaZATMiFP0V7CZXbXRNJuWO2POyPyc/+mNIGwUkdBn8lGC2KIC6cz2hh6sv
         CJDbF1wva6NSYjwFp6yOZ5B/8Wi6p/+1TbqSDvFzeJTm5qNOjQDlJzu+az351Kb6k01L
         8H9aN9DLPhNUJmU3pg9aSJhzVGaGFQW4kJ4pkEcD6+oA15BQDjpnmOHp8Myq3XE58psG
         csbaakT5tvQ7HUsKigBvtgqMzAnRmEwTfvnkEOj9XxC1ys8T6tR9JZXH1i/okjccLokC
         xvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WZ2fsTX5FLJhX01BulIdj9aVU+u+1SaaqVDcWrlk7vo=;
        b=NPiOmnYFvWOym2904wGUHgxkaBacc/g2+fFgL3omFrG0CyYEY9Vo5fIsD0fX+iC4vP
         /M08ooPefeIllBTSIk8xGOT8Q5HUsRw9G/hmvgeZdjvn4J0Vql4SLhkW0FQ20/HzNbMu
         Ih4MSM95IrmEcR3/KaZ5s+ybEjg0zP1RDPdFhQXwmBqLuaFoHdAStY0VTl98XIBIbYdJ
         4trC8wvjJqVA/V8U7/1laCh26vPS32L55Jj4XvgvFIswKu9GC+qzOg19xdTr+/wRrvCq
         IV6sa1E6Pu4D1+bSR8PMbG15sOshUaxuwKS605sMEPkoCXyZsm1kvxd+Sa/IoI9UyMNo
         PFKw==
X-Gm-Message-State: AOAM533f7ukkiS2QrH6gwkoJLzC5+96RdEkh9crfIBfaS4k1y449e0cQ
        gJiNk+mfRrBfJNLhz1u1k/V/uIjbCZ5lZpDI/BQ=
X-Google-Smtp-Source: ABdhPJwVhIeJ7eN/c102kC0C0PDipbzyJDdK32hnyHrtAGB4zJkWiAPX1yDL/oR7lqAn8+vlGW94yr5eZySyWBFd8bM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c0d7:a7ba:fb41:a35a])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:aa8a:b029:e6:64bd:e29d with
 SMTP id d10-20020a170902aa8ab02900e664bde29dmr10716922plr.24.1616087511958;
 Thu, 18 Mar 2021 10:11:51 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:11:11 -0700
In-Reply-To: <20210318171111.706303-1-samitolvanen@google.com>
Message-Id: <20210318171111.706303-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 17/17] arm64: allow CONFIG_CFI_CLANG to be selected
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5656e7aacd69..2eefdbc3e3c9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -75,6 +75,7 @@ config ARM64
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
 	select ARCH_SUPPORTS_LTO_CLANG if CPU_LITTLE_ENDIAN
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
+	select ARCH_SUPPORTS_CFI_CLANG
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && (GCC_VERSION >= 50000 || CC_IS_CLANG)
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.31.0.291.g576ba9dcdaf-goog

