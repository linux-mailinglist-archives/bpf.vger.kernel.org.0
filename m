Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747AA28A82B
	for <lists+bpf@lfdr.de>; Sun, 11 Oct 2020 18:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgJKPs6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Oct 2020 11:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbgJKPsH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Oct 2020 11:48:07 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BCFC0613D0;
        Sun, 11 Oct 2020 08:48:06 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id o18so13683554ill.2;
        Sun, 11 Oct 2020 08:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SiGgaoVfTiGKzLu8iQvphsAHQCnyBXcNFjoytO86qNs=;
        b=EqnDbMv2+QH/bUYXjHA4oEFiZK/SRlkK98epO2CpOCdeI35huS4KGSZHrIMOznMTkD
         FWi3vpmXZAXyc0BUsI7owhCPG2s2RNBLUbIFHiBlP88+c1FMPJxQGUzkrCiigh7o2ChL
         D3j8hXs6QJdJ9wb6VaDyAE7jnGzPgxEx70Jbm7FgUAYrx4yzY00uqs75PjUQNKcOtJCX
         H46fu2LSySIbNObwinw/JsvHKjMnd0pf725X8hPyY0ekpohIIia+uiiSOg2aZDKf/+Oi
         nq7r3NCLfyWCZ/Gej/QMixoUeWBHpFblB0xWi38uwQqamdnrO6ukjzrPaOJ3brK/204C
         6V3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SiGgaoVfTiGKzLu8iQvphsAHQCnyBXcNFjoytO86qNs=;
        b=eBsJEQC3UYAksWTs7pJpktaFZocqkQ6fP/dwUaYVaWOmntROBEk/lVru+5r/WiaQE/
         EEwnKP8eJ1I59bu1EZRjLRcbgl5M/fTMnWvQNTZ02Y9CFEbEtSL7diqVQOGjNWMtK8D7
         I9bVuf+JpamR0kcGDbH3zgg5C3A7KTxTfI8Q74P/JoW261zPm1QX99GxADtP1nQUI1M0
         UB89p02Mwiag7V/elaUEIQzwIA+HHBGIdYexqAMF1DIk89iKMYeMGiBe1kJ8XetcyxTp
         twTByFBmzIBv14XUYo4o2HKXnRL6xQYPk4FyxE0H5B5rkGN24nrb1m0ttQR70o/V+ctN
         GsZQ==
X-Gm-Message-State: AOAM5320rx0x0mfxkfETglCgDTaTmG6j7pjosVS3xrwUWfUH+F04nfkW
        LEo4Ze9zOwFbLPIrTdc3gwV/MiBcNNxELw==
X-Google-Smtp-Source: ABdhPJwsueePrWHqTFapaqqcMnwJ8FxqNGPbJVOHjC2fERfGsGcZc/BqHzeMuOdlOqW6gRg6DofM+g==
X-Received: by 2002:a92:6811:: with SMTP id d17mr16188550ilc.145.1602431286122;
        Sun, 11 Oct 2020 08:48:06 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id q16sm7502881ilj.71.2020.10.11.08.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 08:48:05 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux-foundation.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: [PATCH v5 seccomp 3/5] x86: Enable seccomp architecture tracking
Date:   Sun, 11 Oct 2020 10:47:44 -0500
Message-Id: <da58c3733d95c4f2115dd94225dfbe2573ba4d87.1602431034.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1602431034.git.yifeifz2@illinois.edu>
References: <cover.1602431034.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

Provide seccomp internals with the details to calculate which syscall
table the running kernel is expecting to deal with. This allows for
efficient architecture pinning and paves the way for constant-action
bitmaps.

Signed-off-by: Kees Cook <keescook@chromium.org>
Co-developed-by: YiFei Zhu <yifeifz2@illinois.edu>
Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/x86/include/asm/seccomp.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
index 2bd1338de236..b17d037c72ce 100644
--- a/arch/x86/include/asm/seccomp.h
+++ b/arch/x86/include/asm/seccomp.h
@@ -16,6 +16,23 @@
 #define __NR_seccomp_sigreturn_32	__NR_ia32_sigreturn
 #endif
 
+#ifdef CONFIG_X86_64
+# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_X86_64
+# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+# ifdef CONFIG_COMPAT
+#  define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_I386
+#  define SECCOMP_ARCH_COMPAT_NR	IA32_NR_syscalls
+# endif
+/*
+ * x32 will have __X32_SYSCALL_BIT set in syscall number. We don't support
+ * caching them and they are treated as out of range syscalls, which will
+ * always pass through the BPF filter.
+ */
+#else /* !CONFIG_X86_64 */
+# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_I386
+# define SECCOMP_ARCH_NATIVE_NR	        NR_syscalls
+#endif
+
 #include <asm-generic/seccomp.h>
 
 #endif /* _ASM_X86_SECCOMP_H */
-- 
2.28.0

