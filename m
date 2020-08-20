Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAFC24C391
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 18:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgHTQsP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 12:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730312AbgHTQsF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Aug 2020 12:48:05 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57A8C061385
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 09:48:04 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k20so2193904wmi.5
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oxmz0NDVIOsG9YgC8QPtNaiWi6rrmT2HCpKolU9eu/U=;
        b=EQFAHYcBjnpXbZ99PYgtgmkMP/pAfGRfbRQ/U+zEANP1QBI4hLmqIXyCbvTRWhffhx
         NrjJ+2gI7Zg30fyblg2NnVySzhE9wYNamOARSrQgh1Gq53kXpoEU/6xzVWPo8COgDzjm
         r8ZqE04Ce3SYBTWlQRHuURIwaesAl8edHrq1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oxmz0NDVIOsG9YgC8QPtNaiWi6rrmT2HCpKolU9eu/U=;
        b=f60zrkaiYfgupzwFEEA4boJt/OJ7vLkPl9nY17FSHKViOztpIBkc3t/r0OegB7nTuK
         JU66dfeNzudJ3f7k3M2ajWEfQehQAl5fq5vjQ4JzwtRVs437UYs9hjb1hjqculn7Fz/G
         Qttn4kryQY5FdM/MIeQjTzvEl/rHs1CCLuRgOZmcrNPqlb4x9je/YKhQ8jkOmEd7dqRo
         a+hdfUjFw023qVUwj8KfvwDPOMHE7xMRx9MxJq3+K0K9HoGhKOLoQXyXa2CXGCvhA8Ib
         gRQir1cH/lMnb2MoYX6q/kpM2LFTsf2AvX+UHUDVF2bMk+AagkDCP+JifOcX8nP9xq06
         CCCA==
X-Gm-Message-State: AOAM532apaTCDek66A9U8SdQpinQRHUtsQZoxN2WyQIxjvMTRjhdFgAm
        wkWCyUCfkKQeuiQsd0GWpf9hOQ==
X-Google-Smtp-Source: ABdhPJwEaWVVEG7rRRU6uJ6G42gYJeH/hHrq6GXMRNV4/IhwaApHEdWvr0p1FnKJv55hB3iEdAFjjw==
X-Received: by 2002:a1c:a70c:: with SMTP id q12mr575372wme.89.1597942083365;
        Thu, 20 Aug 2020 09:48:03 -0700 (PDT)
Received: from localhost ([2a00:79e0:42:204:1ea0:b8ff:fe80:839])
        by smtp.gmail.com with ESMTPSA id 6sm5366196wmf.4.2020.08.20.09.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 09:48:02 -0700 (PDT)
From:   Brendan Jackman <jackmanb@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Paul Renauld <renauld@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, pjt@google.com,
        jannh@google.com, peterz@infradead.org, rafael.j.wysocki@intel.com,
        keescook@chromium.org, thgarnie@chromium.org, kpsingh@google.com,
        paul.renauld.epfl@gmail.com, Brendan Jackman <jackmanb@google.com>
Subject: [RFC] security: replace indirect calls with static calls
Date:   Thu, 20 Aug 2020 18:47:53 +0200
Message-Id: <20200820164753.3256899-1-jackmanb@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Paul Renauld <renauld@google.com>

LSMs have high overhead due to indirect function calls through
retpolines. This RPC proposes to replace these with static calls [1]
instead.

This overhead is especially significant for the "bpf" LSM which supports
the implementation of LSM hooks with eBPF programs (security/bpf)[2]. In
order to facilitate this, the "bpf" LSM provides a default nop callback for
all LSM hooks. When enabled, the "bpf", LSM incurs an unnecessary /
avoidable indirect call to this nop callback.

The performance impact on a simple syscall eventfd_write (which triggers
the file_permission hook) was measured with and without "bpf" LSM
enabled. Activating the LSM resulted in an overhead of 4% [3].

This overhead prevents the adoption of bpf LSM on performance critical
systems, and also, in general, slows down all LSMs.

Currently, the LSM hook callbacks are stored in a linked list and
dispatched as indirect calls. Using static calls can remove this overhead
by replacing all indirect calls with direct calls.

During the discussion of the "bpf" LSM patch-set it was proposed to special
case BPF LSM to avoid the overhead by using static keys. This was however
not accepted and it was decided to [4]:

- Not special-case the "bpf" LSM.
- Implement a general solution benefitting the whole LSM framework.

This is based on the static call branch [5].

For each LSM hook, a table of static calls is defined (referred to as
"static slots", or "slots"). When all the LSMs are initialized and linked
lists are filled, the hook callbacks are copied to the appropriate static
slot. The callbacks are continuously added at the end of the table, and the
index of the first slot that is non empty is stored.  Then, when a LSM hook
is called (macro call_[int/void]_hook), the execution jumps to this first
non-empty slot and all of the subsequent static slots are executed.

The static calls are re-initialized every time the linked list is modified,
i.e. after the early LSM init, and the LSM init.

Let's say, there are 5 static slots per LSM hook, and 3 LSMs implement some
hook with the callbacks A, B, C.

Previously, the code for this hook would have looked like this:

	ret = DEFAULT_RET;

        for each cb in [A, B, C]:
                ret = cb(args); <--- costly indirect call here
                if ret != 0:
                        break;

        return ret;

Static calls are defined at build time and are initially empty (NOP
instructions). When the LSMs are initialized, the slots are filled as
follows:

 slot idx     content
           |-----------|
    0      |           |
           |-----------|
    1      |           |
           |-----------|
    2      |   call A  | <-- base_slot_idx = 2
           |-----------|
    3      |   call B  |
           |-----------|
    4      |   call C  |
           |-----------|

The generated code will unroll the foreach loop to have a static call for
each possible LSM:

        ret = DEFAULT_RET;
        switch(base_slot_idx):

                case 0:
                        NOP
                        if ret != 0:
                                break;
                        // fallthrough
                case 1:
                        NOP
                        if ret != 0:
                                break;
                        // fallthrough
                case 2:
                        ret = A(args); <--- direct call, no retpoline
                        if ret != 0:
                                break;
                        // fallthrough
                case 3:
                        ret = B(args); <--- direct call, no retpoline
                        if ret != 0:
                                break;
                        // fallthrough

                [...]

                default:
                        break;

        return ret;

A similar logic is applied for void hooks.

Why this trick with a switch statement? The table of static call is defined
at compile time. The number of hook callbacks that will be defined is
unknown at that time, and the table cannot be resized at runtime.  Static
calls do not define a conditional execution for a non-void function, so the
executed slots must be non-empty.  With this use of the table and the
switch, it is possible to jump directly to the first used slot and execute
all of the slots after. This essentially makes the entry point of the table
dynamic. Instead, it would also be possible to start from 0 and break after
the final populated slot, but that would require an additional conditional
after each slot.

This macro is used to generate the code for each static slot, (e.g. each
case statement in the previous example). This will expand into a call to
MACRO for each static slot defined. For example, if with again 5 slots:

SECURITY_FOREACH_STATIC_SLOT(MACRO, x, y) ->

	MACRO(0, x, y)
	MACRO(1, x, y)
	MACRO(2, x, y)
	MACRO(3, x, y)
	MACRO(4, x, y)

This is used in conjunction with LSM_HOOK definitions in
linux/lsm_hook_defs.h to execute a macro for each static slot of each LSM
hook.

The patches for static calls [6] are not upstreamed yet.

The number of available slots for each LSM hook is currently fixed at
11 (the number of LSMs in the kernel). Ideally, it should automatically
adapt to the number of LSMs compiled into the kernel.

If there’s no practical way to implement such automatic adaptation, an
option instead would be to remove the panic call by falling-back to the old
linked-list mechanism, which is still present anyway (see below).

A few special cases of LSM don't use the macro call_[int/void]_hook but
have their own calling logic. The linked-lists are kept as a possible slow
path fallback for them.

Before:

https://gist.githubusercontent.com/PaulRenauld/fe3ee7b51121556e03c181432c8b3dd5/raw/62437b1416829ca0e8a0ed9101530bc90fd42d69/lsm-performance.png

After:

https://gist.githubusercontent.com/PaulRenauld/fe3ee7b51121556e03c181432c8b3dd5/raw/00e414b73e0c38c2eae8f05d5363a745179ba285/faster-lsm-results.png

With this implementation, any overhead of the indirect call in the LSM
framework is completely mitigated (performance results: [7]). This
facilitates the adoption of "bpf" LSM on production machines and also
benefits all other LSMs.

[1]: https://lwn.net/ml/linux-kernel/20200710133831.943894387@infradead.org/
[2]: https://lwn.net/Articles/798157/
[3] measurements: https://gist.githubusercontent.com/PaulRenauld/fe3ee7b51121556e03c181432c8b3dd5/raw/62437b1416829ca0e8a0ed9101530bc90fd42d69/lsm-performance.png
protocol: https://gist.github.com/PaulRenauld/fe3ee7b51121556e03c181432c8b3dd5#file-measurement-protocol-md
[4]: https://lwn.net/Articles/813261/
[5]: git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/static_call
[6]: https://lwn.net/ml/linux-kernel/20200710133831.943894387@infradead.org/#t
[7]: https://gist.githubusercontent.com/PaulRenauld/fe3ee7b51121556e03c181432c8b3dd5/raw/00e414b73e0c38c2eae8f05d5363a745179ba285/faster-lsm-results.png

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: James Morris <jmorris@namei.org>
Cc: pjt@google.com
Cc: jannh@google.com
Cc: peterz@infradead.org
Cc: rafael.j.wysocki@intel.com
Cc: keescook@chromium.org
Cc: thgarnie@chromium.org
Cc: kpsingh@google.com
Cc: paul.renauld.epfl@gmail.com

Signed-off-by: Paul Renauld <renauld@google.com>
Signed-off-by: KP Singh <kpsingh@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/lsm_hooks.h       |   1 +
 include/linux/lsm_static_call.h | 134 ++++++++++++++++++++
 security/security.c             | 217 ++++++++++++++++++++++++++++----
 3 files changed, 331 insertions(+), 21 deletions(-)
 create mode 100644 include/linux/lsm_static_call.h

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 95b7c1d32062..d11e116b588e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1524,6 +1524,7 @@ union security_list_options {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
 	#include "lsm_hook_defs.h"
 	#undef LSM_HOOK
+	void *generic_func;
 };
 
 struct security_hook_heads {
diff --git a/include/linux/lsm_static_call.h b/include/linux/lsm_static_call.h
new file mode 100644
index 000000000000..f5f5698292e0
--- /dev/null
+++ b/include/linux/lsm_static_call.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2020 Google LLC.
+ */
+
+#ifndef __LINUX_LSM_STATIC_CALL_H
+#define __LINUX_LSM_STATIC_CALL_H
+
+/*
+ * Static slots are used in security/security.c to avoid costly
+ * indirect calls by replacing them with static calls.
+ * The number of static calls for each LSM hook is fixed.
+ */
+#define SECURITY_STATIC_SLOT_COUNT 11
+
+/*
+ * Identifier for the LSM static slots.
+ * HOOK is an LSM hook as defined in linux/lsm_hookdefs.h
+ * IDX is the index of the slot. 0 <= NUM < SECURITY_STATIC_SLOT_COUNT
+ */
+#define STATIC_SLOT(HOOK, IDX) security_static_slot_##HOOK##_##IDX
+
+/*
+ * Call the macro M for each LSM hook slot.
+ * M should take as first argument the index and then
+ * the same __VA_ARGS__
+ * Essentially, this will expand to:
+ *	M(0, ...)
+ *	M(1, ...)
+ *	M(2, ...)
+ *	...
+ * Note that no trailing semicolon is placed so M should be defined
+ * accordingly.
+ * This adapts to a change to SECURITY_STATIC_SLOT_COUNT.
+ */
+#define SECURITY_FOREACH_STATIC_SLOT(M, ...)		\
+	UNROLL_MACRO_LOOP(SECURITY_STATIC_SLOT_COUNT, M, __VA_ARGS__)
+
+/*
+ * Intermediate macros to expand SECURITY_STATIC_SLOT_COUNT
+ */
+#define UNROLL_MACRO_LOOP(N, MACRO, ...)		\
+	_UNROLL_MACRO_LOOP(N, MACRO, __VA_ARGS__)
+
+#define _UNROLL_MACRO_LOOP(N, MACRO, ...)		\
+	__UNROLL_MACRO_LOOP(N, MACRO, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP(N, MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_##N(MACRO, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_0(MACRO, ...)
+
+#define __UNROLL_MACRO_LOOP_1(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_0(MACRO, __VA_ARGS__)	\
+	MACRO(0, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_2(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_1(MACRO, __VA_ARGS__)	\
+	MACRO(1, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_3(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_2(MACRO, __VA_ARGS__)	\
+	MACRO(2, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_4(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_3(MACRO, __VA_ARGS__)	\
+	MACRO(3, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_5(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_4(MACRO, __VA_ARGS__)	\
+	MACRO(4, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_6(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_5(MACRO, __VA_ARGS__)	\
+	MACRO(5, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_7(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_6(MACRO, __VA_ARGS__)	\
+	MACRO(6, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_8(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_7(MACRO, __VA_ARGS__)	\
+	MACRO(7, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_9(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_8(MACRO, __VA_ARGS__)	\
+	MACRO(8, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_10(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_9(MACRO, __VA_ARGS__)	\
+	MACRO(9, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_11(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_10(MACRO, __VA_ARGS__)	\
+	MACRO(10, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_12(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_11(MACRO, __VA_ARGS__)	\
+	MACRO(11, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_13(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_12(MACRO, __VA_ARGS__)	\
+	MACRO(12, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_14(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_13(MACRO, __VA_ARGS__)	\
+	MACRO(13, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_15(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_14(MACRO, __VA_ARGS__)	\
+	MACRO(14, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_16(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_15(MACRO, __VA_ARGS__)	\
+	MACRO(15, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_17(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_16(MACRO, __VA_ARGS__)	\
+	MACRO(16, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_18(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_17(MACRO, __VA_ARGS__)	\
+	MACRO(17, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_19(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_18(MACRO, __VA_ARGS__)	\
+	MACRO(18, __VA_ARGS__)
+
+#define __UNROLL_MACRO_LOOP_20(MACRO, ...)		\
+	__UNROLL_MACRO_LOOP_19(MACRO, __VA_ARGS__)	\
+	MACRO(19, __VA_ARGS__)
+
+#endif /* __LINUX_LSM_STATIC_CALL_H */
diff --git a/security/security.c b/security/security.c
index 70a7ad357bc6..15026bc716f2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,6 +28,8 @@
 #include <linux/string.h>
 #include <linux/msg.h>
 #include <net/flow.h>
+#include <linux/static_call.h>
+#include <linux/lsm_static_call.h>
 
 #define MAX_LSM_EVM_XATTR	2
 
@@ -86,6 +88,128 @@ static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
 static __initdata struct lsm_info **ordered_lsms;
 static __initdata struct lsm_info *exclusive;
 
+/*
+ * Necessary information about a static
+ * slot to call __static_call_update
+ */
+struct static_slot {
+	/* static call key as defined by STATIC_CALL_KEY */
+	struct static_call_key *key;
+	/* static call trampoline as defined by STATIC_CALL_TRAMP */
+	void *trampoline;
+};
+
+/*
+ * Table of the static calls for each LSM hook.
+ * Once the LSMs are initialized, their callbacks will be copied to these
+ * tables such that the slots are filled backwards (from last to first).
+ * This way, we can jump directly to the first used slot, and execute
+ * all of them after. This essentially makes the entry point point
+ * dynamic to adapt the number of slot to the number of callbacks.
+ */
+struct static_slot_list {
+	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
+		struct static_slot NAME[SECURITY_STATIC_SLOT_COUNT];
+	#include <linux/lsm_hook_defs.h>
+	#undef LSM_HOOK
+} __randomize_layout;
+
+/*
+ * Index of the first used static call for each LSM hook
+ * in the corresponding static_slot_list table.
+ * All slots with greater indices are used.
+ * If no slot is used, the default value is INT_MAX.
+ */
+struct base_slot_idx {
+	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
+		int NAME;
+	#include <linux/lsm_hook_defs.h>
+	#undef LSM_HOOK
+} __randomize_layout;
+
+/*
+ * Create the static slots for each LSM hook, initially empty.
+ * This will expand to:
+ *
+ * [...]
+ *
+ * DEFINE_STATIC_CALL_NULL(security_static_slot_file_permission_0,
+ *			   *((int(*)(struct file *file, int mask)))NULL);
+ * DEFINE_STATIC_CALL_NULL(security_static_slot_file_permission_1, ...);
+ *
+ * [...]
+ */
+#define CREATE_STATIC_SLOT(NUM, NAME, RET, ...)				\
+	DEFINE_STATIC_CALL_NULL(STATIC_SLOT(NAME, NUM),			\
+				*((RET(*)(__VA_ARGS__))NULL));
+
+#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
+	SECURITY_FOREACH_STATIC_SLOT(CREATE_STATIC_SLOT, NAME, RET, __VA_ARGS__)
+#include <linux/lsm_hook_defs.h>
+#undef LSM_HOOK
+#undef CREATE_STATIC_SLOT
+
+/*
+ * Initialise a table of static slots for each LSM hook.
+ * When defined with DEFINE_STATIC_CALL_NULL as above, a static call is
+ * a key and a trampoline. Both are needed to use __static_call_update.
+ * This will expand to:
+ * struct static_slot_list static_slots = {
+ *	[...]
+ *	.file_permission = {
+ *		(struct static_slot) {
+ *			.key = &STATIC_CALL_KEY(
+ *				security_static_slot_file_permission_0),
+ *			.trampoline = &STATIC_CALL_TRAMP(
+ *				security_static_slot_file_permission_0)
+ *		},
+ *		(struct static_slot) {
+ *			.key = &STATIC_CALL_KEY(
+ *				security_static_slot_file_permission_1),
+ *			.trampoline = &STATIC_CALL_TRAMP(
+ *				security_static_slot_file_permission_1)
+ *		},
+ *		[...]
+ *	},
+ *	.file_alloc_security = {
+ *		[...]
+ *	},
+ *	[...]
+ * }
+ */
+static struct static_slot_list static_slots __initdata = {
+#define DEFINE_SLOT(NUM, NAME)						\
+	(struct static_slot) {					\
+		.key = &STATIC_CALL_KEY(STATIC_SLOT(NAME, NUM)),	\
+		.trampoline = &STATIC_CALL_TRAMP(STATIC_SLOT(NAME, NUM))\
+	},
+#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
+	.NAME = {							\
+		SECURITY_FOREACH_STATIC_SLOT(DEFINE_SLOT, NAME)		\
+	},
+#include <linux/lsm_hook_defs.h>
+#undef LSM_HOOK
+#undef DEFINE_SLOT
+};
+
+/*
+ * The base slot index for each is initially INT_MAX, which means
+ * that no slot is used yet.
+ * When expanded, this results in:
+ * struct base_slot_idx base_slot_idx = {
+ *	[...]
+ *	.file_permission = INT_MAX,
+ *	.file_alloc_security = INT_MAX,
+ *	[...]
+ * }
+ */
+static struct base_slot_idx base_slot_idx __lsm_ro_after_init = {
+#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
+	.NAME = INT_MAX,
+#include <linux/lsm_hook_defs.h>
+#undef LSM_HOOK
+};
+
 static __initdata bool debug;
 #define init_debug(...)						\
 	do {							\
@@ -307,6 +431,46 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	kfree(sep);
 }
 
+static void __init lsm_init_hook_static_slot(struct static_slot *slots,
+					     struct hlist_head *head,
+					     int *first_slot_idx)
+{
+	struct security_hook_list *pos;
+	struct static_slot *slot;
+	int slot_cnt;
+
+	slot_cnt = 0;
+	hlist_for_each_entry_rcu(pos, head, list)
+		slot_cnt++;
+
+	if (slot_cnt > SECURITY_STATIC_SLOT_COUNT)
+		panic("%s - No static hook slot remaining to add LSM hook.\n",
+		      __func__);
+
+	if (slot_cnt == 0) {
+		*first_slot_idx = INT_MAX;
+		return;
+	}
+
+	*first_slot_idx = SECURITY_STATIC_SLOT_COUNT - slot_cnt;
+	slot = slots + *first_slot_idx;
+	hlist_for_each_entry_rcu(pos, head, list) {
+		__static_call_update(slot->key, slot->trampoline,
+				     pos->hook.generic_func);
+		slot++;
+	}
+}
+
+static void __init lsm_init_static_slots(void)
+{
+#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
+	lsm_init_hook_static_slot(static_slots.NAME,			\
+				  &security_hook_heads.NAME,		\
+				  &base_slot_idx.NAME);
+#include <linux/lsm_hook_defs.h>
+#undef LSM_HOOK
+}
+
 static void __init lsm_early_cred(struct cred *cred);
 static void __init lsm_early_task(struct task_struct *task);
 
@@ -354,6 +518,7 @@ static void __init ordered_lsm_init(void)
 	lsm_early_task(current);
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		initialize_lsm(*lsm);
+	lsm_init_static_slots();
 
 	kfree(ordered_lsms);
 }
@@ -374,6 +539,7 @@ int __init early_security_init(void)
 		prepare_lsm(lsm);
 		initialize_lsm(lsm);
 	}
+	lsm_init_static_slots();
 
 	return 0;
 }
@@ -696,27 +862,36 @@ static void __init lsm_early_task(struct task_struct *task)
  * call_int_hook:
  *	This is a hook that returns a value.
  */
-
-#define call_void_hook(FUNC, ...)				\
-	do {							\
-		struct security_hook_list *P;			\
-								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
-			P->hook.FUNC(__VA_ARGS__);		\
-	} while (0)
-
-#define call_int_hook(FUNC, IRC, ...) ({			\
-	int RC = IRC;						\
-	do {							\
-		struct security_hook_list *P;			\
-								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
-			RC = P->hook.FUNC(__VA_ARGS__);		\
-			if (RC != 0)				\
-				break;				\
-		}						\
-	} while (0);						\
-	RC;							\
+#define __CASE_CALL_STATIC_VOID(NUM, HOOK, ...)				\
+	case NUM:							\
+		static_call(STATIC_SLOT(HOOK, NUM))(__VA_ARGS__);	\
+		fallthrough;
+
+#define call_void_hook(FUNC, ...) do {					\
+	switch (base_slot_idx.FUNC) {					\
+	SECURITY_FOREACH_STATIC_SLOT(__CASE_CALL_STATIC_VOID,		\
+				     FUNC, __VA_ARGS__)			\
+	default :							\
+		break;							\
+	}								\
+} while (0)
+
+#define __CASE_CALL_STATIC_INT(NUM, R, HOOK, ...)			\
+	case NUM:							\
+		R = static_call(STATIC_SLOT(HOOK, NUM))(__VA_ARGS__);	\
+		if (R != 0)						\
+			break;						\
+		fallthrough;
+
+#define call_int_hook(FUNC, IRC, ...) ({				\
+	int RC = IRC;							\
+	switch (base_slot_idx.FUNC) {					\
+	SECURITY_FOREACH_STATIC_SLOT(__CASE_CALL_STATIC_INT,		\
+				     RC, FUNC, __VA_ARGS__)		\
+	default :							\
+		break;							\
+	}								\
+	RC;								\
 })
 
 /* Security operations */
-- 
2.28.0.297.g1956fa8f8d-goog

