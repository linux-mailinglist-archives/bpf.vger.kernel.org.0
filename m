Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBE428A82A
	for <lists+bpf@lfdr.de>; Sun, 11 Oct 2020 18:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387403AbgJKPs7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Oct 2020 11:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgJKPsG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Oct 2020 11:48:06 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55E5C0613CE;
        Sun, 11 Oct 2020 08:48:06 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id l8so15127839ioh.11;
        Sun, 11 Oct 2020 08:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NdICCiJraRHzlT+shrlQ2ox4NanUe1EsDd/0wzpfp6g=;
        b=pCLoZRRhds9vi6SBVAP3pSOCxU0BqJ1L2+W/18oD+ZasMZicZ+4qjE4BKOOqu2l7qv
         1om0VlaENYACA8E6sjmaWGTdogw/AxD0qjb8cuOMgjvy02cweR3skI5lxatDPUT8gx5R
         dUtbdgvupX4kqXdXMeW6YPZC51jaB1YGDa+SypEA6xH2swR7doey1gtRLn633t4/XMxk
         9Y5KYyj7RXHMXcqDtjLLHgQitpYxE46fzoaL3O54Mu485o78GpTA8KEXM/2bY/0OHwvZ
         jclZD4LfGrdwrwk8bZgDoHGkoxM4yurYOj+txdoZtN9zDjz+pZFK4eisWjhM+zHvWCBo
         qx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NdICCiJraRHzlT+shrlQ2ox4NanUe1EsDd/0wzpfp6g=;
        b=Sxay5KM/281IWF8qcurCpFckTJX/8D68T/RjIbk//JlxI1K5jznB4qfqH1SWQ2MEIF
         hXGtm1i1JN136gOCdVByTqnQpFVh4vlekO1yu+EwVkA2HyGhIYkWBIb87ycsIQKXfEXu
         jdprT8STdhfynhM49JZwDe8LJA8EuuANVfk0huVXkE3gxrQx9UiSKHh4LWcNzbnF9Gem
         osoIvQCRGj3JWgpyEHOinayouF4ZkM752g83k86Tlbs9OUr3Rda1gt32ydABb/oEFB+O
         F2zogA7Yd7AXEhkYWJe8eJyXpuNIL3+u5fa+p17o1KEFJwJvr1XdFgHGLbPgxuiiRI3D
         Eg9A==
X-Gm-Message-State: AOAM531tTftiyiX3ylb25m1u0BEHduGHuOUcS93kr9nZrhboPRI5gVY9
        HvQyNDtY3Jp64KSJPBkgcoghl1u5Ua1iAw==
X-Google-Smtp-Source: ABdhPJy6s8MaNpY/lLNiMavLqpu7OwodBZRcMWXKVRBS4m5cl8sYiA3MPC+7hfyJognrI7oogQB4/g==
X-Received: by 2002:a05:6638:10e9:: with SMTP id g9mr16394645jae.139.1602431285237;
        Sun, 11 Oct 2020 08:48:05 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id q16sm7502881ilj.71.2020.10.11.08.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 08:48:04 -0700 (PDT)
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
Subject: [PATCH v5 seccomp 2/5] seccomp/cache: Add "emulator" to check if filter is constant allow
Date:   Sun, 11 Oct 2020 10:47:43 -0500
Message-Id: <71c7be2db5ee08905f41c3be5c1ad6e2601ce88f.1602431034.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1602431034.git.yifeifz2@illinois.edu>
References: <cover.1602431034.git.yifeifz2@illinois.edu>
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
 kernel/seccomp.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index d67a8b61f2bf..236e7b367d4e 100644
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
@@ -621,7 +627,12 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
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
@@ -687,6 +698,148 @@ seccomp_prepare_user_filter(const char __user *user_filter)
 	return filter;
 }
 
+#ifdef SECCOMP_ARCH_NATIVE
+/**
+ * seccomp_is_const_allow - check if filter is constant allow with given data
+ * @fprog: The BPF programs
+ * @sd: The seccomp data to check against, only syscall number and arch
+ *      number are considered constant.
+ */
+static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
+				   struct seccomp_data *sd)
+{
+	unsigned int reg_value = 0;
+	unsigned int pc;
+	bool op_res;
+
+	if (WARN_ON_ONCE(!fprog))
+		return false;
+
+	for (pc = 0; pc < fprog->len; pc++) {
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
@@ -736,6 +889,7 @@ static long seccomp_attach_filter(unsigned int flags,
 	 * task reference.
 	 */
 	filter->prev = current->seccomp.filter;
+	seccomp_cache_prepare(filter);
 	current->seccomp.filter = filter;
 	atomic_inc(&current->seccomp.filter_count);
 
-- 
2.28.0

