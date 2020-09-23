Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A46F27648F
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 01:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgIWXbx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 19:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgIWX33 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 19:29:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBE1C0613CE
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 16:29:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id bw23so584523pjb.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 16:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tjQcJgxkky4Q5tL6fI5yShZ9VEKJUWBe4Oa7zhVXG8=;
        b=TIMKD+uYvr1YdPLTyJHHVcZYjQEqHy0tYbelapcjRZOHTZmAY0natT6ajDzivxjqj0
         d299ZNX8bo0prRnqHPaoQWmTB3QxOMSQUltgTLVgC9Q6lPVc3huZ3ArX+ynawPF0/Q14
         qzbrM9jQOYsMsxWgjCGVivEWrJHkrGpS1EtOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tjQcJgxkky4Q5tL6fI5yShZ9VEKJUWBe4Oa7zhVXG8=;
        b=S5f4SLP4ZyJ0Rk08PoSf74EW+0/2Z2Hb1ZTrcMog4Yi+lUDdlo8q5M4AZOO5GQU5hh
         d20WKocwjMTU/Sy2wE7USwlM2KXSuMIJ7V2Dp2OiDorbHPoP+ayzdusXUZ03AICjiLDC
         MShZ7AG4D19NCSKT8KFlRRCut6PUClgJUVJtRh+xt2Ac51aoZfc8R9vWTYM1COd1d4kT
         FypuYuu11QkDBcQ/RNmKAlltSRKwXpuw6K+EZI11eLeXopKHO6MoF7KHNEf1yN7CmvMf
         jWwaNzGX6M4Meu5sLexyDpOqAj+Pj2OYD5AWxHEbiFP8Psy+8phtKaKcQ+AFPInu3sb/
         gNvQ==
X-Gm-Message-State: AOAM5321vEaoyUJXbsPSI3KgIvz58r6B90Z9v6xtsaRZFGzGPD7Y4pTD
        MXDIjIenljzZ3IwO6evytObx/A==
X-Google-Smtp-Source: ABdhPJzLUGIsXfVbpAr9Ol7X8IFNcdiV/Cvmi2IKpWqmpxO2CSLDl74T/4D2rNKxV1OQwP7WhREFXQ==
X-Received: by 2002:a17:90a:6848:: with SMTP id e8mr1361792pjm.221.1600903769404;
        Wed, 23 Sep 2020 16:29:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j13sm492649pjn.14.2020.09.23.16.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 16:29:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <yifeifz2@illinois.edu>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] seccomp: Introduce SECCOMP_PIN_ARCHITECTURE
Date:   Wed, 23 Sep 2020 16:29:18 -0700
Message-Id: <20200923232923.3142503-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200923232923.3142503-1-keescook@chromium.org>
References: <20200923232923.3142503-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For systems that provide multiple syscall maps based on audit
architectures (e.g. AUDIT_ARCH_X86_64 and AUDIT_ARCH_I386 via
CONFIG_COMPAT) or via syscall masks (e.g. x86_x32), allow a fast way
to pin the process to a specific syscall table, instead of needing
to generate all filters with an architecture check as the first filter
action.

This creates the internal representation that seccomp itself can use
(which is separate from the filters, which need to stay runtime
agnostic). Additionally paves the way for constant-action bitmaps.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/seccomp.h                       |  9 +++
 include/uapi/linux/seccomp.h                  |  1 +
 kernel/seccomp.c                              | 79 ++++++++++++++++++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 33 ++++++++
 4 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 02aef2844c38..0be20bc81ea9 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -20,12 +20,18 @@
 #include <linux/atomic.h>
 #include <asm/seccomp.h>
 
+#define SECCOMP_ARCH_IS_NATIVE		1
+#define SECCOMP_ARCH_IS_COMPAT		2
+#define SECCOMP_ARCH_IS_MULTIPLEX	3
+#define SECCOMP_ARCH_IS_UNKNOWN		0xff
+
 struct seccomp_filter;
 /**
  * struct seccomp - the state of a seccomp'ed process
  *
  * @mode:  indicates one of the valid values above for controlled
  *         system calls available to a process.
+ * @arch: seccomp's internal architecture identifier (not seccomp_data->arch)
  * @filter: must always point to a valid seccomp-filter or NULL as it is
  *          accessed without locking during system call entry.
  *
@@ -34,6 +40,9 @@ struct seccomp_filter;
  */
 struct seccomp {
 	int mode;
+#ifdef SECCOMP_ARCH
+	u8 arch;
+#endif
 	atomic_t filter_count;
 	struct seccomp_filter *filter;
 };
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index 6ba18b82a02e..f4d134ebfa7e 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -16,6 +16,7 @@
 #define SECCOMP_SET_MODE_FILTER		1
 #define SECCOMP_GET_ACTION_AVAIL	2
 #define SECCOMP_GET_NOTIF_SIZES		3
+#define SECCOMP_PIN_ARCHITECTURE	4
 
 /* Valid flags for SECCOMP_SET_MODE_FILTER */
 #define SECCOMP_FILTER_FLAG_TSYNC		(1UL << 0)
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index ae6b40cc39f4..0a3ff8eb8aea 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -298,6 +298,47 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
 	return 0;
 }
 
+#ifdef SECCOMP_ARCH
+static inline u8 seccomp_get_arch(u32 syscall_arch, u32 syscall_nr)
+{
+	u8 seccomp_arch;
+
+	switch (syscall_arch) {
+	case SECCOMP_ARCH:
+		seccomp_arch = SECCOMP_ARCH_IS_NATIVE;
+		break;
+#ifdef CONFIG_COMPAT
+	case SECCOMP_ARCH_COMPAT:
+		seccomp_arch = SECCOMP_ARCH_IS_COMPAT;
+		break;
+#endif
+	default:
+		seccomp_arch = SECCOMP_ARCH_IS_UNKNOWN;
+	}
+
+#ifdef SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH
+	if (syscall_arch == SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH) {
+		seccomp_arch |= (sd->nr & SECCOMP_MULTIPLEXED_SYSCALL_TABLE_MASK) >>
+				SECCOMP_MULTIPLEXED_SYSCALL_TABLE_SHIFT;
+	}
+#endif
+
+	return seccomp_arch;
+}
+#endif
+
+static inline bool seccomp_arch_mismatch(struct seccomp *seccomp,
+					 const struct seccomp_data *sd)
+{
+#ifdef SECCOMP_ARCH
+	/* Block mismatched architectures. */
+	if (seccomp->arch && seccomp->arch != seccomp_get_arch(sd->arch, sd->nr))
+		return true;
+#endif
+
+	return false;
+}
+
 /**
  * seccomp_run_filters - evaluates all seccomp filters against @sd
  * @sd: optional seccomp data to be passed to filters
@@ -312,9 +353,14 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
 			       struct seccomp_filter **match)
 {
 	u32 ret = SECCOMP_RET_ALLOW;
+	struct seccomp_filter *f;
+	struct seccomp *seccomp = &current->seccomp;
+
+	if (seccomp_arch_mismatch(seccomp, sd))
+		return SECCOMP_RET_KILL_PROCESS;
+
 	/* Make sure cross-thread synced filter points somewhere sane. */
-	struct seccomp_filter *f =
-			READ_ONCE(current->seccomp.filter);
+	f = READ_ONCE(seccomp->filter);
 
 	/* Ensure unexpected behavior doesn't result in failing open. */
 	if (WARN_ON(f == NULL))
@@ -522,6 +568,11 @@ static inline void seccomp_sync_threads(unsigned long flags)
 		if (task_no_new_privs(caller))
 			task_set_no_new_privs(thread);
 
+#ifdef SECCOMP_ARCH
+		/* Copy any pinned architecture. */
+		thread->seccomp.arch = caller->seccomp.arch;
+#endif
+
 		/*
 		 * Opt the other thread into seccomp if needed.
 		 * As threads are considered to be trust-realm
@@ -1652,6 +1703,23 @@ static long seccomp_get_notif_sizes(void __user *usizes)
 	return 0;
 }
 
+static long seccomp_pin_architecture(void)
+{
+#ifdef SECCOMP_ARCH
+	struct task_struct *task = current;
+
+	u8 arch = seccomp_get_arch(syscall_get_arch(task),
+				   syscall_get_nr(task, task_pt_regs(task)));
+
+	/* How did you even get here? */
+	if (task->seccomp.arch && task->seccomp.arch != arch)
+		return -EBUSY;
+
+	task->seccomp.arch = arch;
+#endif
+	return 0;
+}
+
 /* Common entry point for both prctl and syscall. */
 static long do_seccomp(unsigned int op, unsigned int flags,
 		       void __user *uargs)
@@ -1673,6 +1741,13 @@ static long do_seccomp(unsigned int op, unsigned int flags,
 			return -EINVAL;
 
 		return seccomp_get_notif_sizes(uargs);
+	case SECCOMP_PIN_ARCHITECTURE:
+		if (flags != 0)
+			return -EINVAL;
+		if (uargs != NULL)
+			return -EINVAL;
+
+		return seccomp_pin_architecture();
 	default:
 		return -EINVAL;
 	}
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 9c398768553b..d90551e0385e 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -157,6 +157,10 @@ struct seccomp_data {
 #define SECCOMP_GET_NOTIF_SIZES 3
 #endif
 
+#ifndef SECCOMP_PIN_ARCHITECTURE
+#define SECCOMP_PIN_ARCHITECTURE 4
+#endif
+
 #ifndef SECCOMP_FILTER_FLAG_TSYNC
 #define SECCOMP_FILTER_FLAG_TSYNC (1UL << 0)
 #endif
@@ -2221,6 +2225,35 @@ TEST_F_SIGNAL(TRACE_syscall, kill_after, SIGSYS)
 	EXPECT_NE(self->mypid, syscall(__NR_getpid));
 }
 
+TEST(seccomp_architecture_pin)
+{
+	long ret;
+
+	ret = seccomp(SECCOMP_PIN_ARCHITECTURE, 0, NULL);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support SECCOMP_PIN_ARCHITECTURE!");
+	}
+
+	/* Make sure unexpected arguments are rejected. */
+	ret = seccomp(SECCOMP_PIN_ARCHITECTURE, 1, NULL);
+	ASSERT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno) {
+		TH_LOG("Did not reject SECCOMP_PIN_ARCHITECTURE with flags!");
+	}
+
+	ret = seccomp(SECCOMP_PIN_ARCHITECTURE, 0, &ret);
+	ASSERT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno) {
+		TH_LOG("Did not reject SECCOMP_PIN_ARCHITECTURE with address!");
+	}
+
+	ret = seccomp(SECCOMP_PIN_ARCHITECTURE, 1, &ret);
+	ASSERT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno) {
+		TH_LOG("Did not reject SECCOMP_PIN_ARCHITECTURE with flags and address!");
+	}
+}
+
 TEST(seccomp_syscall)
 {
 	struct sock_filter filter[] = {
-- 
2.25.1

