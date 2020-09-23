Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682C4276491
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 01:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIWXbw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 19:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgIWX3a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 19:29:30 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA34C0613CE
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 16:29:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x22so620390pfo.12
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 16:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o0NyB+CF/3HB86tAQOiOguwVSWnWdTv1Hd26QQ00R+I=;
        b=B4b/Q53xruwMndQgGGFIU0jfBUyHy5EQgi1/f0r6mwyOKO/7ztl4gWYA0/kKGSEk+R
         ovmQzz5wz+Yq5l50zTkIJpQm1EsVL4pEMH+K2jf71kvGq7RGRH1BnYcYt5mT9BJVDHsQ
         u3KfdiL62LyabXEmsgkTYdU8dDxCl3Rowx4PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o0NyB+CF/3HB86tAQOiOguwVSWnWdTv1Hd26QQ00R+I=;
        b=ob4LE+vcCEutAk3NlnxQQGU3VUFGr3ZGJ/NmLSoj4AglCnAOMXTLRE9B7eL81/tvIn
         a1gcZ8Sc/OALzyd9E0dHMX4w09Wk3SkJdDaDJq1OeRIF4tukHJkZk33xGpRGNStu8z7z
         8pi6PvuTRoaa5qjGx/XZAZCALpRFl0QbY4vbw1yRG5IPWZzNL1Z0aZzmelodpGQRwy0j
         Ez25xdZgqoz52v2x9smVpel9WGkQ8Fb27PjITGIXb9g9y+mMqn8Iw7/Z7n+rN/9Nke4Y
         lAsLOpBoPzdtG0kqwVfhn6I1Bdmie6SMkdkWyJ8gT+8OAAX2dNmqlAg+p8YbJD37lxcn
         j7dg==
X-Gm-Message-State: AOAM533guS1z4FLo7pu7HnsD6GOmdKa78HBfe1yhXCxyDyNX2uycpQyK
        DZc+PF6FtM/bzudIkojXBxc22g==
X-Google-Smtp-Source: ABdhPJwbxOLcCqKCUuH2utmGzYWbzsx1hZ7uPJWRuiUp4zT/wfPrMZoAz0WrrD9eZsP/GRam1aHvyA==
X-Received: by 2002:a65:6106:: with SMTP id z6mr1660589pgu.433.1600903770175;
        Wed, 23 Sep 2020 16:29:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 31sm778246pgs.59.2020.09.23.16.29.26
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
Subject: [PATCH 3/6] seccomp: Implement constant action bitmaps
Date:   Wed, 23 Sep 2020 16:29:20 -0700
Message-Id: <20200923232923.3142503-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200923232923.3142503-1-keescook@chromium.org>
References: <20200923232923.3142503-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

One of the most common pain points with seccomp filters has been dealing
with the overhead of processing the filters, especially for "always allow"
or "always reject" cases. While BPF is extremely fast[1], it will always
have overhead associated with it. Additionally, due to seccomp's design,
filters are layered, which means processing time goes up as the number
of filters attached goes up.

In the past, efforts have been focused on making filter execution complete
in a shorter amount of time. For example, filters were rewritten from
using linear if/then/else syscall search to using balanced binary trees,
or moving tests for syscalls common to the process's workload to the
front of the filter. However, there are limits to this, especially when
some processes are dealing with tens of filters[2], or when some
architectures have a less efficient BPF engine[3].

The most common use of seccomp, constructing syscall block/allow-lists,
where syscalls that are always allowed or always rejected (without regard
to any arguments), also tends to produce the most pathological runtime
problems, in that a large number of syscall checks in the filter need
to be performed to come to a determination.

In order to optimize these cases from O(n) to O(1), seccomp can
use bitmaps to immediately determine the desired action. A critical
observation in the prior paragraph bears repeating: the common case for
syscall tests do not check arguments. For any given filter, there is a
constant mapping from the combination of architecture and syscall to the
seccomp action result. (For kernels/architectures without CONFIG_COMPAT,
there is a single architecture.). As such, it is possible to construct
a mapping of arch/syscall to action, which can be updated as new filters
are attached to a process.

In order to build this mapping at filter attach time, each filter is
executed for every syscall (under each possible architecture), and
checked for any accesses of struct seccomp_data that are not the "arch"
nor "nr" (syscall) members. If only "arch" and "nr" are examined, then
there is a constant mapping for that syscall, and bitmaps can be updated
accordingly. If any accesses happen outside of those struct members,
seccomp must not bypass filter execution for that syscall, since program
state will be used to determine filter action result. (This logic comes
in the next patch.)

[1] https://lore.kernel.org/bpf/20200531171915.wsxvdjeetmhpsdv2@ast-mbp.dhcp.thefacebook.com/
[2] https://lore.kernel.org/bpf/20200601101137.GA121847@gardel-login/
[3] https://lore.kernel.org/bpf/717a06e7f35740ccb4c70470ec70fb2f@huawei.com/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/seccomp.h |  18 ++++
 kernel/seccomp.c        | 207 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 221 insertions(+), 4 deletions(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 0be20bc81ea9..96df2f899e3d 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -25,6 +25,17 @@
 #define SECCOMP_ARCH_IS_MULTIPLEX	3
 #define SECCOMP_ARCH_IS_UNKNOWN		0xff
 
+/* When no bits are set for a syscall, filters are run. */
+struct seccomp_bitmaps {
+#ifdef SECCOMP_ARCH
+	/* "allow" are initialized to set and only ever get cleared. */
+	DECLARE_BITMAP(allow, NR_syscalls);
+	/* These are initialized to clear and only ever get set. */
+	DECLARE_BITMAP(kill_thread, NR_syscalls);
+	DECLARE_BITMAP(kill_process, NR_syscalls);
+#endif
+};
+
 struct seccomp_filter;
 /**
  * struct seccomp - the state of a seccomp'ed process
@@ -45,6 +56,13 @@ struct seccomp {
 #endif
 	atomic_t filter_count;
 	struct seccomp_filter *filter;
+	struct seccomp_bitmaps native;
+#ifdef CONFIG_COMPAT
+	struct seccomp_bitmaps compat;
+#endif
+#ifdef SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH
+	struct seccomp_bitmaps multiplex;
+#endif
 };
 
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 0a3ff8eb8aea..111a238bc532 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -318,7 +318,7 @@ static inline u8 seccomp_get_arch(u32 syscall_arch, u32 syscall_nr)
 
 #ifdef SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH
 	if (syscall_arch == SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH) {
-		seccomp_arch |= (sd->nr & SECCOMP_MULTIPLEXED_SYSCALL_TABLE_MASK) >>
+		seccomp_arch |= (syscall_nr & SECCOMP_MULTIPLEXED_SYSCALL_TABLE_MASK) >>
 				SECCOMP_MULTIPLEXED_SYSCALL_TABLE_SHIFT;
 	}
 #endif
@@ -559,6 +559,21 @@ static inline void seccomp_sync_threads(unsigned long flags)
 		atomic_set(&thread->seccomp.filter_count,
 			   atomic_read(&thread->seccomp.filter_count));
 
+		/* Copy syscall filter bitmaps. */
+		memcpy(&thread->seccomp.native,
+		       &caller->seccomp.native,
+		       sizeof(caller->seccomp.native));
+#ifdef CONFIG_COMPAT
+		memcpy(&thread->seccomp.compat,
+		       &caller->seccomp.compat,
+		       sizeof(caller->seccomp.compat));
+#endif
+#ifdef SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH
+		memcpy(&thread->seccomp.multiplex,
+		       &caller->seccomp.multiplex,
+		       sizeof(caller->seccomp.multiplex));
+#endif
+
 		/*
 		 * Don't let an unprivileged task work around
 		 * the no_new_privs restriction by creating
@@ -661,6 +676,114 @@ seccomp_prepare_user_filter(const char __user *user_filter)
 	return filter;
 }
 
+static inline bool sd_touched(pte_t *ptep)
+{
+	return !!pte_young(*(READ_ONCE(ptep)));
+}
+
+#ifdef SECCOMP_ARCH
+/*
+ * We can build constant-action bitmaps only when an arch/nr combination reads
+ * nothing more that sd->nr and sd->arch, since those have a constant mapping
+ * to the syscall.
+ *
+ * This approach could also be used to test for access to sd->arch too,
+ * if we wanted to warn about compat-unsafe filters.
+ */
+static inline bool seccomp_filter_action_is_constant(struct bpf_prog *prog,
+						     struct seccomp_data *sd,
+						     u32 *action)
+{
+	/* No evaluation implementation yet. */
+	return false;
+}
+
+/*
+ * Walk everyone syscall combination for this arch/mask combo and update
+ * the bitmaps with any results.
+ */
+static void seccomp_update_bitmap(struct seccomp_filter *filter,
+				  void *pagepair, u32 arch, u32 mask,
+				  struct seccomp_bitmaps *bitmaps)
+{
+	struct seccomp_data sd = { };
+	bool constant;
+	u32 nr, ret;
+
+	/* Initialize bitmaps for first filter. */
+	if (!filter->prev)
+		bitmap_fill(bitmaps->allow, NR_syscalls);
+
+	/*
+	 * For every syscall, if we don't already know we need to run
+	 * the full filter, simulate the filter with our static values.
+	 */
+	for (nr = 0; nr < NR_syscalls; nr++) {
+		/* Are we already at the maximal rejection state? */
+		if (test_bit(nr, bitmaps->kill_process))
+			continue;
+
+		sd.nr = nr | mask;
+		sd.arch = arch;
+
+		/* Evaluate filter for this arch/syscall. */
+		constant = seccomp_filter_action_is_constant(filter->prog, &sd, &ret);
+
+		/*
+		 * If this run through the filter didn't access
+		 * beyond "arch", we know the result is a constant
+		 * mapping for arch/nr -> ret.
+		 */
+		if (constant) {
+			/* Constant evaluation. Mark appropriate bitmaps. */
+			switch (ret) {
+			case SECCOMP_RET_KILL_PROCESS:
+				set_bit(nr, bitmaps->kill_process);
+				break;
+			case SECCOMP_RET_KILL_THREAD:
+				set_bit(nr, bitmaps->kill_thread);
+				break;
+			default:
+				break;
+			case SECCOMP_RET_ALLOW:
+				/*
+				 * If we always map to allow, there are
+				 * no changes needed to the bitmaps.
+				 */
+				continue;
+			}
+		}
+
+		/*
+		 * Dynamic evaluation of syscall, or non-allow constant
+		 * mapping to something other than SECCOMP_RET_ALLOW: we
+		 * must not short-circuit-allow it anymore.
+		 */
+		clear_bit(nr, bitmaps->allow);
+	}
+}
+
+static void seccomp_update_bitmaps(struct seccomp_filter *filter,
+				   void *pagepair)
+{
+	seccomp_update_bitmap(filter, pagepair, SECCOMP_ARCH, 0,
+			      &current->seccomp.native);
+#ifdef CONFIG_COMPAT
+	seccomp_update_bitmap(filter, pagepair, SECCOMP_ARCH_COMPAT, 0,
+			      &current->seccomp.compat);
+#endif
+#ifdef SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH
+	seccomp_update_bitmap(filter, pagepair, SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH,
+			      SECCOMP_MULTIPLEXED_SYSCALL_TABLE_MASK,
+			      &current->seccomp.multiplex);
+#endif
+}
+#else
+static void seccomp_update_bitmaps(struct seccomp_filter *filter,
+				   void *pagepair)
+{ }
+#endif
+
 /**
  * seccomp_attach_filter: validate and attach filter
  * @flags:  flags to change filter behavior
@@ -674,7 +797,8 @@ seccomp_prepare_user_filter(const char __user *user_filter)
  *   - in NEW_LISTENER mode: the fd of the new listener
  */
 static long seccomp_attach_filter(unsigned int flags,
-				  struct seccomp_filter *filter)
+				  struct seccomp_filter *filter,
+				  void *pagepair)
 {
 	unsigned long total_insns;
 	struct seccomp_filter *walker;
@@ -713,6 +837,9 @@ static long seccomp_attach_filter(unsigned int flags,
 	current->seccomp.filter = filter;
 	atomic_inc(&current->seccomp.filter_count);
 
+	/* Evaluate filter for new known-outcome syscalls */
+	seccomp_update_bitmaps(filter, pagepair);
+
 	/* Now that the new filter is in place, synchronize to all threads. */
 	if (flags & SECCOMP_FILTER_FLAG_TSYNC)
 		seccomp_sync_threads(flags);
@@ -970,6 +1097,65 @@ static int seccomp_do_user_notification(int this_syscall,
 	return -1;
 }
 
+#ifdef SECCOMP_ARCH
+static inline bool __bypass_filter(struct seccomp_bitmaps *bitmaps,
+				   u32 nr, u32 *filter_ret)
+{
+	if (nr < NR_syscalls) {
+		if (test_bit(nr, bitmaps->allow)) {
+			*filter_ret = SECCOMP_RET_ALLOW;
+			return true;
+		}
+		if (test_bit(nr, bitmaps->kill_process)) {
+			*filter_ret = SECCOMP_RET_KILL_PROCESS;
+			return true;
+		}
+		if (test_bit(nr, bitmaps->kill_thread)) {
+			*filter_ret = SECCOMP_RET_KILL_THREAD;
+			return true;
+		}
+	}
+	return false;
+}
+
+static inline u32 check_syscall(const struct seccomp_data *sd,
+				struct seccomp_filter **match)
+{
+	u32 filter_ret = SECCOMP_RET_KILL_PROCESS;
+	u8 arch = seccomp_get_arch(sd->arch, sd->nr);
+
+	switch (arch) {
+	case SECCOMP_ARCH_IS_NATIVE:
+		if (__bypass_filter(&current->seccomp.native, sd->nr, &filter_ret))
+			return filter_ret;
+		break;
+#ifdef CONFIG_COMPAT
+	case SECCOMP_ARCH_IS_COMPAT:
+		if (__bypass_filter(&current->seccomp.compat, sd->nr, &filter_ret))
+			return filter_ret;
+		break;
+#endif
+#ifdef SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH
+	case SECCOMP_ARCH_IS_MULTIPLEX:
+		if (__bypass_filter(&current->seccomp.multiplex, sd->nr, &filter_ret))
+			return filter_ret;
+		break;
+#endif
+	default:
+		WARN_ON_ONCE(1);
+		return filter_ret;
+	}
+
+	return seccomp_run_filters(sd, match);
+}
+#else
+static inline u32 check_syscall(const struct seccomp_data *sd,
+				struct seccomp_filter **match)
+{
+	return seccomp_run_filters(sd, match);
+}
+#endif
+
 static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 			    const bool recheck_after_trace)
 {
@@ -989,7 +1175,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 		sd = &sd_local;
 	}
 
-	filter_ret = seccomp_run_filters(sd, &match);
+	filter_ret = check_syscall(sd, &match);
 	data = filter_ret & SECCOMP_RET_DATA;
 	action = filter_ret & SECCOMP_RET_ACTION_FULL;
 
@@ -1580,6 +1766,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	long ret = -EINVAL;
 	int listener = -1;
 	struct file *listener_f = NULL;
+	void *pagepair;
 
 	/* Validate flags. */
 	if (flags & ~SECCOMP_FILTER_FLAG_MASK)
@@ -1625,12 +1812,24 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	    mutex_lock_killable(&current->signal->cred_guard_mutex))
 		goto out_put_fd;
 
+	/*
+	 * This memory will be needed for bitmap testing, but we'll
+	 * be holding a spinlock at that point. Do the allocation
+	 * (and free) outside of the lock.
+	 *
+	 * Alternative: we could do the bitmap update before attach
+	 * to avoid spending too much time under lock.
+	 */
+	pagepair = vzalloc(PAGE_SIZE * 2);
+	if (!pagepair)
+		goto out_put_fd;
+
 	spin_lock_irq(&current->sighand->siglock);
 
 	if (!seccomp_may_assign_mode(seccomp_mode))
 		goto out;
 
-	ret = seccomp_attach_filter(flags, prepared);
+	ret = seccomp_attach_filter(flags, prepared, pagepair);
 	if (ret)
 		goto out;
 	/* Do not free the successfully attached filter. */
-- 
2.25.1

