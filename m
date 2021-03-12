Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555933382CC
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 01:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhCLAuQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 19:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhCLAtn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Mar 2021 19:49:43 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E93CC061761
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 16:49:43 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id m35so7149654qtd.11
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 16:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Mjpx22b6GuQLoGn4NzDCeA9C1v5eOn+//WEZjXFxGag=;
        b=p1YJgca/l7E3iFpL3NEl23p9rq3uH3cCDpSNLobzpaRdN94bWmg2TLWliG4OTlDgNF
         b20mw7m0miBH3TC5NiTSrjOvpsxd/EdcZEMNofKjul69T290228EfMRqi263sZ7ZcaJy
         z2WDWEy/jTh6Vd9HVohxsoV9lhuJlYgs7JX6zxyvJVOc46TYiMufhQFP5HjsfNJNllhZ
         x42Xb3kCdRnLN7XJ1Ai7S9r8k9w7c9TnY3ZIZBGaRP2A6WNp1d5UesIsRKD8bTflljM+
         ApPAV1OH/Bn5BUKlPk/oyAren6W77UIuvmnx4NkfwgRZxTrZ2vrS8diyGNcOaxyVNLg4
         QIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Mjpx22b6GuQLoGn4NzDCeA9C1v5eOn+//WEZjXFxGag=;
        b=dBlY8Aj0s9gZ935q4RBE2p3f94DkFxO7kH/CaLFXvbcqk/EzPeW8xEOuo0U0Das1BZ
         AIaAzl1tYdsmj4RfySUrBfKAOtfAuryxlnLzGUCAljnjbMGAzsmaEk9Y2bmepTyi/R2B
         2rH9Elsg9nCiPsCii+aQWBDI1+9UDHeMPHwpuJn+LN3sBLan0i8apMiUk/blBPy3bT4B
         vrmIQuz/IUC3ZXjyIx+mdELEOGhbHQLpRqtDCIwRcfHpD6ZmfmanDzyfYFaz3x+L926G
         8Pozkk2hG8b6uy+i/qFspfkcJgLTzRPbn4kFs+y02mmZy1B8SQw6rYrsWH3oxEXk7gC+
         TqOA==
X-Gm-Message-State: AOAM532yo7JlP2e16ICIcSel2pys3Rwjp2aTfvcmpNQWlzaaGHGBkA+q
        mRPg3NMZrK5lNmf33d7VmOIowTrmFWwYwAqLeuI=
X-Google-Smtp-Source: ABdhPJwmy8g4J1Glwh+9/Qdeqiq2sG1+WJpaNKE+Qhd9e3mgm3N1f00E1AniVKdzTbmiO2hHWYG9eMucONFWzKoR1oM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c86b:8269:af92:55a])
 (user=samitolvanen job=sendgmr) by 2002:ad4:4745:: with SMTP id
 c5mr10451143qvx.39.1615510182313; Thu, 11 Mar 2021 16:49:42 -0800 (PST)
Date:   Thu, 11 Mar 2021 16:49:13 -0800
In-Reply-To: <20210312004919.669614-1-samitolvanen@google.com>
Message-Id: <20210312004919.669614-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 11/17] psci: use __pa_function for cpu_resume
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler replaces function pointers with
jump table addresses, which results in __pa_symbol returning the
physical address of the jump table entry. As the jump table contains
an immediate jump to an EL1 virtual address, this typically won't
work as intended. Use __pa_function instead to get the address to
cpu_resume.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 drivers/firmware/psci/psci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index f5fc429cae3f..facd3cce3244 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -326,7 +326,7 @@ static int psci_suspend_finisher(unsigned long state)
 {
 	u32 power_state = state;
 
-	return psci_ops.cpu_suspend(power_state, __pa_symbol(cpu_resume));
+	return psci_ops.cpu_suspend(power_state, __pa_function(cpu_resume));
 }
 
 int psci_cpu_suspend_enter(u32 state)
@@ -345,7 +345,7 @@ int psci_cpu_suspend_enter(u32 state)
 static int psci_system_suspend(unsigned long unused)
 {
 	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
-			      __pa_symbol(cpu_resume), 0, 0);
+			      __pa_function(cpu_resume), 0, 0);
 }
 
 static int psci_system_suspend_enter(suspend_state_t state)
-- 
2.31.0.rc2.261.g7f71774620-goog

