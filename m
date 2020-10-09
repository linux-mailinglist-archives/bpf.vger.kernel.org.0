Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EECD289020
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 19:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbgJIRQ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 13:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731546AbgJIRPh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 13:15:37 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB88FC0613D5;
        Fri,  9 Oct 2020 10:15:36 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id n6so10788224ioc.12;
        Fri, 09 Oct 2020 10:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6QWwJmFq8+B51i1Dnz1FEveL5hiUIq3knnDImjqdYNQ=;
        b=OvglK0ql2T5Rj2i89d2RG31J78gpJ11Kt+B8r5vsiTrs+HEDZgIUJGR2hEDVJ9czqq
         AsrD9LLA31F/wV30sQ22To8RML0HHtbcU3W/qrggGVSqI7sjxvzkJfgkwNoKUftieHZT
         e7onGJZm3lTHaEtUNcjUePx0wrarPZMx/aTfNeS/Rg/VzUJH++9s6FSuySVjLYGEz71P
         jtDJ+s2JYvwqsBhW0FY46isRatRVLjmQi4ZokfWKagzVeNSkAmREQy1UwutWhkvZPhxU
         2NIq2fE4uCBQxYJL0d0sJkT1n08/0tmul2VeF92SVDtXGybyRgk7mcYeeldfQy8VfdP8
         aYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6QWwJmFq8+B51i1Dnz1FEveL5hiUIq3knnDImjqdYNQ=;
        b=NE0+Ol2AI/yP21py/YeBMt5dNbY8MeoHzh26+IPiDaGtx0WRxkAVItoaTMAb/VorA8
         JcPUtZt+wezpoEkz/hnZ2wOi2J28WXtU27XWfCQO++WemjEjc2ABMvWx6vi4KVgy4SuJ
         etulvRw9MI4x2IjDInm9+jovfRnHYPiP6Dk9pOpVtexvzACdhntOC1VsDp4WiVfq93z7
         8m1AgNBNV5IRIvxjU0J//pudu3FQDVIVScPiR2uSRw7MAvieFRLcXHIy3qP5TV3HZkWO
         O/xVzlvht5N6qOUy16X8EzNsgBXqAJzsOuNyKl520Ivg3Xzle/XGH3MvLLXjvRpkjWQ/
         Om5Q==
X-Gm-Message-State: AOAM5336K09nXQMqWF26PEHazSMM4Nc8PVbcaIy09bdb7HzaYtFb6j3N
        qWGse2Lcd1zVK3y7UCOLOtg=
X-Google-Smtp-Source: ABdhPJxoslx7HpNUVVcX2E2QarHbz/ANgA1kszpMKfOEp/x3H7i7qPRq/i/SzlUct3hiYaLvVG3nMw==
X-Received: by 2002:a02:c611:: with SMTP id i17mr11902592jan.28.1602263736233;
        Fri, 09 Oct 2020 10:15:36 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id c2sm3762830iot.52.2020.10.09.10.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 10:15:35 -0700 (PDT)
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
Subject: [PATCH v4 seccomp 3/5] x86: Enable seccomp architecture tracking
Date:   Fri,  9 Oct 2020 12:14:31 -0500
Message-Id: <122e3e70cf775e461ebdfadb5fbb4b6813cca3dd.1602263422.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1602263422.git.yifeifz2@illinois.edu>
References: <cover.1602263422.git.yifeifz2@illinois.edu>
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
 arch/x86/include/asm/seccomp.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
index 2bd1338de236..03365af6165d 100644
--- a/arch/x86/include/asm/seccomp.h
+++ b/arch/x86/include/asm/seccomp.h
@@ -16,6 +16,18 @@
 #define __NR_seccomp_sigreturn_32	__NR_ia32_sigreturn
 #endif
 
+#ifdef CONFIG_X86_64
+# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_X86_64
+# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+# ifdef CONFIG_COMPAT
+#  define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_I386
+#  define SECCOMP_ARCH_COMPAT_NR	IA32_NR_syscalls
+# endif
+#else /* !CONFIG_X86_64 */
+# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_I386
+# define SECCOMP_ARCH_NATIVE_NR	        NR_syscalls
+#endif
+
 #include <asm-generic/seccomp.h>
 
 #endif /* _ASM_X86_SECCOMP_H */
-- 
2.28.0

