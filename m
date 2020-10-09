Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A4028900B
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 19:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbgJIRQ3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 13:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731509AbgJIRPh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 13:15:37 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5103C0613D2;
        Fri,  9 Oct 2020 10:15:35 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b1so6043344iot.4;
        Fri, 09 Oct 2020 10:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fp+QEq+G0DYx9BDPqAT5zZ3rasyyVU93CxYOBQ8bLUE=;
        b=R5vql2U59tRFN4d+fxjJrLgN0misEj9IU0I2TB0d4lumPbih8wiSBKKkReYUOe+90G
         6s+NF/ruVpUNh2LoNUNQSxsfH1vCOUJDNeYLaFxVabGf+ZViaGgmmPFrDZHhJTUU8ShH
         bDqXcQ3nvPB6vv9Z+m9MTNoI1p+13d6MB2SuLeKshrG5sEJcAcQRuN2kDsTKgf7Klk7p
         fX3cp3qZz7Lkuh3FU3+PuqNjNF/7k8MTMb7liemu/a74ECvWC+LM/P9VIpvo+cH5Ho9x
         AAa5TixTVzHGbkdXkACCuJwWG9pyLRjyaqxWzVnTdeJbUcEEgd7vrf5PS+BmWTtgFIhC
         Y8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fp+QEq+G0DYx9BDPqAT5zZ3rasyyVU93CxYOBQ8bLUE=;
        b=PyEDu0205h8TBLGCjx0mI4dmS2oX1XUjE603bz7+898B4IpZBL3iaBb/ENg11WFFeB
         NnfaMahU7RVWlrf9xm/Zg3KIau8PrmU6YjeZZYHK7wInsIiLIVqvUj4+7AwskaOgEZyF
         TXqDSxS9WhzZqu7y6XUwwjKeWI/knl5/TPbcJKW8e8/iNgbxULRWr0NhwafEeGRztwXq
         +21aw1KN1xxC0mtS2iP2R5q1RYCO+27cR/Xt22pCiVxB0/gYkQP9bQZeFWjoV3f3p7J4
         PgW8bEkzZQ1nV0Zj3jRDvWlASHynkK9uCwREcHkIVeoIhYyBqnq+pKZr9wEAPhfwLEm8
         6sTA==
X-Gm-Message-State: AOAM532uxPsMQ+9h2oj+rscEmIS3C37AHlIWde2PmYbiPNeH+/7OsLFP
        1Zufd4ZUkz+R7b+E5y0hERw=
X-Google-Smtp-Source: ABdhPJyFXl7949q3WjGIDvlLpb40UMyHA6JkHLE9d3Pc8k7uvlkeD9TNUGcdS64Qhb2F9betrqU8Cw==
X-Received: by 2002:a5d:8755:: with SMTP id k21mr10360067iol.142.1602263735201;
        Fri, 09 Oct 2020 10:15:35 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id c2sm3762830iot.52.2020.10.09.10.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 10:15:34 -0700 (PDT)
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
Subject: [PATCH v4 seccomp 2/5] seccomp/cache: Add "emulator" to check if filter is constant allow
Date:   Fri,  9 Oct 2020 12:14:30 -0500
Message-Id: <1a40458d081ce0d5423eb0282210055496e28774.1602263422.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1602263422.git.yifeifz2@illinois.edu>
References: <cover.1602263422.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <yifeifz2@illinois.edu>

SECCOMP_CACHE will only operate on syscalls that do not access
any syscall arguments or instruction pointer. To facilitate
this we need a static analyser to know whether a filter will
return allow regardless of syscall arguments for a given
architecture number / syscall number pair. This is implemented
here with a pseudo-emulator, and stored in a per-filter bitmap.

In order to build this bitmap at filter attach time, each filter is
emulated for every syscall (under each possible architecture), and
checked for any accesses of struct seccomp_data that are not the "arch"
nor "nr" (syscall) members. If only "arch" and "nr" are examined, and
the program returns allow, then we can be sure that the filter must
return allow independent from syscall arguments.

Nearly all seccomp filters are built from these cBPF instructions:

BPF_LD  | BPF_W    | BPF_ABS
BPF_JMP | BPF_JEQ  | BPF_K
BPF_JMP | BPF_JGE  | BPF_K
BPF_JMP | BPF_JGT  | BPF_K
BPF_JMP | BPF_JSET | BPF_K
BPF_JMP | BPF_JA
BPF_RET | BPF_K
BPF_ALU | BPF_AND  | BPF_K

Each of these instructions are emulated. Any weirdness or loading
from a syscall argument will cause the emulator to bail.

The emulation is also halted if it reaches a return. In that case,
if it returns an SECCOMP_RET_ALLOW, the syscall is marked as good.

Emulator structure and comments are from Kees [1] and Jann [2].

Emulation is done at attach time. If a filter depends on more
filters, and if the dependee does not guarantee to allow the
syscall, then we skip the emulation of this syscall.

[1] https://lore.kernel.org/lkml/20200923232923.3142503-5-keescook@chromium.org/
[2] https://lore.kernel.org/lkml/CAG48ez1p=dR_2ikKq=xVxkoGg0fYpTBpkhJSv1w-6BG=76PAvw@mail.gmail.com/

Suggested-by: Jann Horn <jannh@google.com>
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 kernel/seccomp.c | 158 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 73f6b6e9a3b0..51032b41fe59 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -169,6 +169,10 @@ static inline bool seccomp_cache_check_allow(const struct seccomp_filter *sfilte
 {
 	return false;
 }
+
+static inline void seccomp_cache_prepare(struct seccomp_filter *sfilter)
+{
+}
 #endif /* SECCOMP_ARCH_NATIVE */
 
 /**
@@ -187,6 +191,7 @@ static inline bool seccomp_cache_check_allow(const struct seccomp_filter *sfilte
  *	   this filter after reaching 0. The @users count is always smaller
  *	   or equal to @refs. Hence, reaching 0 for @users does not mean
  *	   the filter can be freed.
+ * @cache: cache of arch/syscall mappings to actions
  * @log: true if all actions except for SECCOMP_RET_ALLOW should be logged
  * @prev: points to a previously installed, or inherited, filter
  * @prog: the BPF program to evaluate
@@ -208,6 +213,7 @@ struct seccomp_filter {
 	refcount_t refs;
 	refcount_t users;
 	bool log;
+	struct action_cache cache;
 	struct seccomp_filter *prev;
 	struct bpf_prog *prog;
 	struct notification *notif;
@@ -616,7 +622,12 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
 {
 	struct seccomp_filter *sfilter;
 	int ret;
-	const bool save_orig = IS_ENABLED(CONFIG_CHECKPOINT_RESTORE);
+	const bool save_orig =
+#if defined(CONFIG_CHECKPOINT_RESTORE) || defined(SECCOMP_ARCH_NATIVE)
+		true;
+#else
+		false;
+#endif
 
 	if (fprog->len == 0 || fprog->len > BPF_MAXINSNS)
 		return ERR_PTR(-EINVAL);
@@ -682,6 +693,150 @@ seccomp_prepare_user_filter(const char __user *user_filter)
 	return filter;
 }
 
+#ifdef SECCOMP_ARCH_NATIVE
+/**
+ * seccomp_is_const_allow - check if filter is constant allow with given data
+ * @fprog: The BPF programs
+ * @sd: The seccomp data to check against, only syscall number are arch
+ *      number are considered constant.
+ */
+static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
+				   struct seccomp_data *sd)
+{
+	unsigned int insns;
+	unsigned int reg_value = 0;
+	unsigned int pc;
+	bool op_res;
+
+	if (WARN_ON_ONCE(!fprog))
+		return false;
+
+	insns = bpf_classic_proglen(fprog);
+	for (pc = 0; pc < insns; pc++) {
+		struct sock_filter *insn = &fprog->filter[pc];
+		u16 code = insn->code;
+		u32 k = insn->k;
+
+		switch (code) {
+		case BPF_LD | BPF_W | BPF_ABS:
+			switch (k) {
+			case offsetof(struct seccomp_data, nr):
+				reg_value = sd->nr;
+				break;
+			case offsetof(struct seccomp_data, arch):
+				reg_value = sd->arch;
+				break;
+			default:
+				/* can't optimize (non-constant value load) */
+				return false;
+			}
+			break;
+		case BPF_RET | BPF_K:
+			/* reached return with constant values only, check allow */
+			return k == SECCOMP_RET_ALLOW;
+		case BPF_JMP | BPF_JA:
+			pc += insn->k;
+			break;
+		case BPF_JMP | BPF_JEQ | BPF_K:
+		case BPF_JMP | BPF_JGE | BPF_K:
+		case BPF_JMP | BPF_JGT | BPF_K:
+		case BPF_JMP | BPF_JSET | BPF_K:
+			switch (BPF_OP(code)) {
+			case BPF_JEQ:
+				op_res = reg_value == k;
+				break;
+			case BPF_JGE:
+				op_res = reg_value >= k;
+				break;
+			case BPF_JGT:
+				op_res = reg_value > k;
+				break;
+			case BPF_JSET:
+				op_res = !!(reg_value & k);
+				break;
+			default:
+				/* can't optimize (unknown jump) */
+				return false;
+			}
+
+			pc += op_res ? insn->jt : insn->jf;
+			break;
+		case BPF_ALU | BPF_AND | BPF_K:
+			reg_value &= k;
+			break;
+		default:
+			/* can't optimize (unknown insn) */
+			return false;
+		}
+	}
+
+	/* ran off the end of the filter?! */
+	WARN_ON(1);
+	return false;
+}
+
+static void seccomp_cache_prepare_bitmap(struct seccomp_filter *sfilter,
+					 void *bitmap, const void *bitmap_prev,
+					 size_t bitmap_size, int arch)
+{
+	struct sock_fprog_kern *fprog = sfilter->prog->orig_prog;
+	struct seccomp_data sd;
+	int nr;
+
+	if (bitmap_prev) {
+		/* The new filter must be as restrictive as the last. */
+		bitmap_copy(bitmap, bitmap_prev, bitmap_size);
+	} else {
+		/* Before any filters, all syscalls are always allowed. */
+		bitmap_fill(bitmap, bitmap_size);
+	}
+
+	for (nr = 0; nr < bitmap_size; nr++) {
+		/* No bitmap change: not a cacheable action. */
+		if (!test_bit(nr, bitmap))
+			continue;
+
+		sd.nr = nr;
+		sd.arch = arch;
+
+		/* No bitmap change: continue to always allow. */
+		if (seccomp_is_const_allow(fprog, &sd))
+			continue;
+
+		/*
+		 * Not a cacheable action: always run filters.
+		 * atomic clear_bit() not needed, filter not visible yet.
+		 */
+		__clear_bit(nr, bitmap);
+	}
+}
+
+/**
+ * seccomp_cache_prepare - emulate the filter to find cachable syscalls
+ * @sfilter: The seccomp filter
+ *
+ * Returns 0 if successful or -errno if error occurred.
+ */
+static void seccomp_cache_prepare(struct seccomp_filter *sfilter)
+{
+	struct action_cache *cache = &sfilter->cache;
+	const struct action_cache *cache_prev =
+		sfilter->prev ? &sfilter->prev->cache : NULL;
+
+	seccomp_cache_prepare_bitmap(sfilter, cache->allow_native,
+				     cache_prev ? cache_prev->allow_native : NULL,
+				     SECCOMP_ARCH_NATIVE_NR,
+				     SECCOMP_ARCH_NATIVE);
+
+#ifdef SECCOMP_ARCH_COMPAT
+	seccomp_cache_prepare_bitmap(sfilter, cache->allow_compat,
+				     cache_prev ? cache_prev->allow_compat : NULL,
+				     SECCOMP_ARCH_COMPAT_NR,
+				     SECCOMP_ARCH_COMPAT);
+#endif /* SECCOMP_ARCH_COMPAT */
+}
+#endif /* SECCOMP_ARCH_NATIVE */
+
 /**
  * seccomp_attach_filter: validate and attach filter
  * @flags:  flags to change filter behavior
@@ -731,6 +886,7 @@ static long seccomp_attach_filter(unsigned int flags,
 	 * task reference.
 	 */
 	filter->prev = current->seccomp.filter;
+	seccomp_cache_prepare(filter);
 	current->seccomp.filter = filter;
 	atomic_inc(&current->seccomp.filter_count);
 
-- 
2.28.0

