Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAFF3382DB
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 01:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhCLAuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 19:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhCLAtx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Mar 2021 19:49:53 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E860C061764
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 16:49:52 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id k15so16855310qtx.15
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 16:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sXIP93k7c8DVrjXtTxj/fkzV3wLZlyNPf+yLEPo7wRE=;
        b=mtaO9P67TJP45ojSK27tXo13IqOLlDN5Do+q8NG4//IHMLdFX+TlJ0yAD85OgHDHft
         IV/qU1Fk/J6kVcbC65lo7Ay/XsODQomhEe1LZO8JVY91xpxbEWn7mnMF6ozdBE6gtxeG
         TVP5gwBfy6iSfOJ3WccgbTihVCrZtVtkL4U7o1ZFGTcb7dn62ug4AzvIwiinUpTkWeQz
         t91K/KwGP7ANbPLFV1Lg1+3R8mXKS6B5NSjRBUh+zIRMcPA+0EWH40iXDGlfFI1N0+v9
         s2cZP8RMW4pYDgDNvF+rrzN/fT5uHPXzQ803CSr1JXQP08IdhB8gye8ibnO8y9/FsYuL
         b3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sXIP93k7c8DVrjXtTxj/fkzV3wLZlyNPf+yLEPo7wRE=;
        b=PPnNZ4fWnPbHQWlwfq7d4FafiH2Vs9xOdxdQJTuteZtStME7WX+stDIaFDnQPo88KD
         9YWeL+9wjhUlY8WjT+TXfYNkD45mG4gDZSQsY7q9UHMAZR2jYYdvcnsXIRITO+mkai3+
         DJqwxEW/nuz472Ypnhbbg22p1DvuWmOR8LqPXOnbXj0WhmLwto0+sKudDWyM/mUInYB+
         c2y/qpaZ8rD9p91GdT1T3oM5vYKDnyY8b+FNy1yzbxAQKWknxn0sG6NlxDX3nEu9r80+
         lUrH/Dqu0gZxI0PU4CapoHBhxrSreeukNFNiSEZes26vjhsQA4IWxdZcqBvCCgjayeWt
         oyTw==
X-Gm-Message-State: AOAM530OwPdaDyCfxX88Hz17eyB36ta0AYHUklhVko414jCDOLYIDEac
        Ubvg96hBMaUh5R7SFeUZwVUhtLa5DcG1EHOplKM=
X-Google-Smtp-Source: ABdhPJzXMuYXkgN2WuqAdQ1salNLwv1mgxPH25fvp7ZocNaBgCeLvuP/MBua0CMHO5On1yO8RvH+zhV5TNT/H5rMXt0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c86b:8269:af92:55a])
 (user=samitolvanen job=sendgmr) by 2002:ad4:4c83:: with SMTP id
 bs3mr10040851qvb.41.1615510191555; Thu, 11 Mar 2021 16:49:51 -0800 (PST)
Date:   Thu, 11 Mar 2021 16:49:18 -0800
In-Reply-To: <20210312004919.669614-1-samitolvanen@google.com>
Message-Id: <20210312004919.669614-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 16/17] KVM: arm64: Disable CFI for nVHE
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

Disable CFI for the nVHE code to avoid address space confusion.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
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
2.31.0.rc2.261.g7f71774620-goog

