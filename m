Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCEE27EC6C
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 17:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbgI3PUp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 11:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgI3PUZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 11:20:25 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F276C061755;
        Wed, 30 Sep 2020 08:20:25 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id v8so2193206iom.6;
        Wed, 30 Sep 2020 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mv4ii8zAP+OnnhUrvn84xAFhnizL7MtbdUx+GH7PQaM=;
        b=faLp8XRWWZBJTGcWmfT4Onxq+2qJR2ZNvRXCr5h8BPn4Uc5zUe5sKpa3bU2zZx/UoH
         oPN7V7n4HUbMwcESTej9CA3ep+EYCoXa2JynNjku8sN3Cv/DmbQWmdkkFnA5OLd9YJNp
         +pZnXwWT10vJsEK/RknN+QI7HU13OGEyKwR05Y5/7TLZpW7+f4EfzY5YQhGerKNUOCwq
         6h8vlrYz7QRAwC68dMtgihsPR8nnakqyn0u/6V5iLnsx0LNbddmPxxRuBnykd+7Y1K6Q
         cJ65cIAW1Q4d+xOQUqKCyCQVix4it5tExeZvGIsDatvLDDuKJ8MaA+ndRb8QVLO1yuCx
         NaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mv4ii8zAP+OnnhUrvn84xAFhnizL7MtbdUx+GH7PQaM=;
        b=iNt9ZJxx2qfMKKUFuFFnrUXLgDRICZ3uMd05Ygl7KvboyutBeffyTkjOCVtDiFueuF
         bCKKBoa3lvlpAo70FB60S/lpqFWFOUIncMZ4hyc25eWU5GTmraBK/FxMd3t5lcFlHMXG
         Lqk4f1DO4gyRaTnQ+7CRw8LmzL0X0Jq0XtEi/iM2i2eyBleAKR5b2RZJdtz0EGXyq4oa
         oFmgE6vsox4qfwb83XK+2yGcBFpThsnNdw6sJ9GpBgqsJv1LtrSqnxwJF4zt1KxYGgHD
         zGWdWlCXRxG7kB4xwfgpqnKilUF7JQbqtDVfx7EGz8PmifdXXmezPm/e0qEv59cXaYUM
         wQRQ==
X-Gm-Message-State: AOAM533ZgpISUOSgPEv+jacaupiHjsg1HEE9cJbSZwG7hMoagx9z42cT
        JS817GPaG8vJ/vHE2XXl+ds=
X-Google-Smtp-Source: ABdhPJwjIxz2zEuBhqj0fQKlXjCbvbF3OmJHQpSM1hO02ApFZSa4yKPPp5z7QVD9U1wWVPWWnSoEhA==
X-Received: by 2002:a5d:9693:: with SMTP id m19mr2082274ion.161.1601479224812;
        Wed, 30 Sep 2020 08:20:24 -0700 (PDT)
Received: from localhost.localdomain (ip-99-203-15-156.pools.cgn.spcsdns.net. [99.203.15.156])
        by smtp.gmail.com with ESMTPSA id t10sm770788iog.49.2020.09.30.08.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:20:24 -0700 (PDT)
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
Subject: [PATCH v3 seccomp 1/5] x86: Enable seccomp architecture tracking
Date:   Wed, 30 Sep 2020 10:19:12 -0500
Message-Id: <484392624b475cc25d90a787525ede70df9f7d51.1601478774.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1601478774.git.yifeifz2@illinois.edu>
References: <cover.1601478774.git.yifeifz2@illinois.edu>
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
[YiFei: Removed x32, added macro for nr_syscalls]
Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/x86/include/asm/seccomp.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
index 2bd1338de236..7b3a58271656 100644
--- a/arch/x86/include/asm/seccomp.h
+++ b/arch/x86/include/asm/seccomp.h
@@ -16,6 +16,18 @@
 #define __NR_seccomp_sigreturn_32	__NR_ia32_sigreturn
 #endif
 
+#ifdef CONFIG_X86_64
+# define SECCOMP_ARCH_DEFAULT			AUDIT_ARCH_X86_64
+# define SECCOMP_ARCH_DEFAULT_NR		NR_syscalls
+# ifdef CONFIG_COMPAT
+#  define SECCOMP_ARCH_COMPAT			AUDIT_ARCH_I386
+#  define SECCOMP_ARCH_COMPAT_NR		IA32_NR_syscalls
+# endif
+#else /* !CONFIG_X86_64 */
+# define SECCOMP_ARCH_DEFAULT		AUDIT_ARCH_I386
+# define SECCOMP_ARCH_DEFAULT_NR	NR_syscalls
+#endif
+
 #include <asm-generic/seccomp.h>
 
 #endif /* _ASM_X86_SECCOMP_H */
-- 
2.28.0

