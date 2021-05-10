Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC5A379555
	for <lists+bpf@lfdr.de>; Mon, 10 May 2021 19:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhEJRYE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 May 2021 13:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbhEJRYB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 May 2021 13:24:01 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C45EC061574;
        Mon, 10 May 2021 10:22:56 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id n22so12481464qtk.9;
        Mon, 10 May 2021 10:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S3H1MKatlWs/RWUFpqfMQpbLnuBmCuiGE/4Hzpw7XHo=;
        b=LSvm4JmenlTgTqXPivcVDQxRFrWcVsDIBT5fITjJ5v2H4oPLAbuD1f9KghUbKjMPYO
         lS+8au7eN3yGeR62565CG4dnYF36JPcywd7fexpNiUlTrnUO554KGZaGlQLhtQVprS4H
         dhf3sq5ftMnur2FZtj3XEiTZ3GlaqeWtj37AwxOZPNo0KL7BCdkcbuwETG6LocKwNnix
         vysKVZwaEIcUXnuaO5YDZNt2MOlmwKkBWH0X1/0heO7jdsHu/Hgjybra4CWWiFFPB/zf
         C0Tj7pBa6WO4YUJ9g01KJt4s4rfnDQuY1rdIGezbZV0iEPufUeYq+1tIFC/uEwRMxRe8
         38xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3H1MKatlWs/RWUFpqfMQpbLnuBmCuiGE/4Hzpw7XHo=;
        b=pU2cVOig4e/644MW/E1DRrp9wy5r8Guh0SPyYQO+qSZxa/3VvVcl8vOFFBDklOEK41
         VbSCUdn+kT9LhIrNl6BoGCI1HZCCAPAMQlIrHN+G3UKST62vRlWW7SRIkOPnd+4cAoxj
         J7dh63VbB5ESHxfQqv40aPrjyU2ydWVY+i7Gzmrl3xyEfWLM72NsBvflRDdS+HSK3KPq
         ziQaa7UwGCBO3xoBHSftoEWFQNfUAicA9QNJwkGKE1MMEVgmTFrK3te83ldjS8PyeeT9
         eGTTEB7heiWUyUA+Bu6pIo6DbXGvtZBkz9mr+0wiLqDhbUqtWPnkhYq051LJz1KZ4IkC
         88MA==
X-Gm-Message-State: AOAM531w5wEDQmlMdFdphgoMHMhLaNZ/3BL+BohCgp17AZZI3IFlIZRc
        wnn+af5B8utsOj8SM2quHMGVxBc0F3nFPf1Q
X-Google-Smtp-Source: ABdhPJycRWcjUpuZ52KTXSXhdNZY6mWVEQgFvlDgy0LEsr2K9B4p7cnaCspU40G/sQgjpjmbnTxiKA==
X-Received: by 2002:ac8:118d:: with SMTP id d13mr22835807qtj.294.1620667375667;
        Mon, 10 May 2021 10:22:55 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id q7sm11924367qki.17.2021.05.10.10.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:22:55 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux.dev, bpf@vger.kernel.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Austin Kuo <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Subject: [RFC PATCH bpf-next seccomp 02/12] bpf, seccomp: Add eBPF filter capabilities
Date:   Mon, 10 May 2021 12:22:39 -0500
Message-Id: <f587d6ac57c23c928a9ef02dbc1190b66aca32ef.1620499942.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620499942.git.yifeifz2@illinois.edu>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Sargun Dhillon <sargun@sargun.me>

This introduces the BPF_PROG_TYPE_SECCOMP bpf program type. It is meant
to be used for seccomp filters as an alternative to cBPF filters. The
program type has relatively limited capabilities in terms of helpers,
but that can be extended later on.

The eBPF code loading is separated from attachment of the filter, so
a privileged user can load the filter, and pass it back to an
unprivileged user who can attach it and use it at a later time.

In order to attach the filter itself, you need to supply a flag to the
seccomp syscall indicating that a eBPF filter is being attached, as
opposed to a cBPF one. Verification occurs at program load time,
so the user should only receive errors related to attachment.

The behavior of eBPF filters with bitmap cache is that they will
totally negate the bitmap acceleration. Static analysis of eBPF to
create a bitmap could be a potential future work. [YiFei Zhu]

All standard BPF helper calls are supported. If the loader has
CAP_BPF and CAP_PERFMON, all tracing BPF helper calls are also
supported. The reason for this is that, this adds no new attack
vectors I (YiFei) can tell. Standard helpers are already accessible
via BPF_PROG_TYPE_SOCKET_FILTER from an unprivileged loader. Any
policies that can be set through seccomp-eBPF can already be set
via seccomp user notifier, if the user uses this feature to implement
a policy. If a user okay with such advanced features, they may
implement an LSM policy to restrict this. This LSM hook is added in
a later patch. [YiFei Zhu]

rcu_read_lock is also held because maps like BPF_MAP_TYPE_LRU_HASH
requires them. For simplicity, this also affects cBPF filters.
[YiFei Zhu]

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Link: https://lists.linux-foundation.org/pipermail/containers/2018-February/038572.html
Co-developed-by: Jinghao Jia <jinghao7@illinois.edu>
Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
Co-developed-by: YiFei Zhu <yifeifz2@illinois.edu>
Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/Kconfig                   |   7 ++
 include/linux/bpf_types.h      |   4 +
 include/linux/seccomp.h        |   3 +-
 include/uapi/linux/bpf.h       |   1 +
 include/uapi/linux/seccomp.h   |   1 +
 kernel/bpf/syscall.c           |   1 +
 kernel/seccomp.c               | 151 +++++++++++++++++++++++++++++----
 tools/include/uapi/linux/bpf.h |   1 +
 8 files changed, 153 insertions(+), 16 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 5bc98d28a6e0..d1180fedcfea 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -519,6 +519,13 @@ config SECCOMP_CACHE_DEBUG
 
 	  If unsure, say N.
 
+config SECCOMP_FILTER_EXTENDED
+	bool "Extended BPF seccomp filters"
+	depends on SECCOMP_FILTER && BPF_SYSCALL
+	help
+	  Enables seccomp filters to be written in eBPF, as opposed
+	  to just cBPF filters.
+
 config HAVE_ARCH_STACKLEAK
 	bool
 	help
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index f883f01a5061..92d2126c72a6 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -78,6 +78,10 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_LSM, lsm,
 #endif /* CONFIG_BPF_LSM */
 #endif
 
+#ifdef CONFIG_SECCOMP_FILTER_EXTENDED
+BPF_PROG_TYPE(BPF_PROG_TYPE_SECCOMP, seccomp, void *, void *)
+#endif
+
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_ARRAY, percpu_array_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PROG_ARRAY, prog_array_map_ops)
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 0c564e5d40ff..c0750dc05de5 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -8,7 +8,8 @@
 					 SECCOMP_FILTER_FLAG_LOG | \
 					 SECCOMP_FILTER_FLAG_SPEC_ALLOW | \
 					 SECCOMP_FILTER_FLAG_NEW_LISTENER | \
-					 SECCOMP_FILTER_FLAG_TSYNC_ESRCH)
+					 SECCOMP_FILTER_FLAG_TSYNC_ESRCH | \
+					 SECCOMP_FILTER_FLAG_EXTENDED)
 
 /* sizeof() the first published struct seccomp_notif_addfd */
 #define SECCOMP_NOTIFY_ADDFD_SIZE_VER0 24
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ec6d85a81744..b78d5c9fbb4b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -937,6 +937,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_EXT,
 	BPF_PROG_TYPE_LSM,
 	BPF_PROG_TYPE_SK_LOOKUP,
+	BPF_PROG_TYPE_SECCOMP,
 };
 
 enum bpf_attach_type {
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index 6ba18b82a02e..5f98cc44df56 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -23,6 +23,7 @@
 #define SECCOMP_FILTER_FLAG_SPEC_ALLOW		(1UL << 2)
 #define SECCOMP_FILTER_FLAG_NEW_LISTENER	(1UL << 3)
 #define SECCOMP_FILTER_FLAG_TSYNC_ESRCH		(1UL << 4)
+#define SECCOMP_FILTER_FLAG_EXTENDED	(1UL << 5)
 
 /*
  * All BPF programs must return a 32-bit value.
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 941ca06d9dfa..f3007e7329aa 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2113,6 +2113,7 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 		return -E2BIG;
 	if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
 	    type != BPF_PROG_TYPE_CGROUP_SKB &&
+	    type != BPF_PROG_TYPE_SECCOMP &&
 	    !bpf_capable())
 		return -EPERM;
 
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 6e5ac0d686a1..1ef26a5bf93f 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -43,6 +43,7 @@
 #include <linux/uaccess.h>
 #include <linux/anon_inodes.h>
 #include <linux/lockdep.h>
+#include <linux/bpf.h>
 
 /*
  * When SECCOMP_IOCTL_NOTIF_ID_VALID was first introduced, it had the
@@ -408,7 +409,11 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
 	 * value always takes priority (ignoring the DATA).
 	 */
 	for (; f; f = f->prev) {
-		u32 cur_ret = bpf_prog_run_pin_on_cpu(f->prog, sd);
+		u32 cur_ret;
+
+		rcu_read_lock();
+		cur_ret = bpf_prog_run_pin_on_cpu(f->prog, sd);
+		rcu_read_unlock();
 
 		if (ACTION_ONLY(cur_ret) < ACTION_ONLY(ret)) {
 			ret = cur_ret;
@@ -508,7 +513,10 @@ static inline pid_t seccomp_can_sync_threads(void)
 static inline void seccomp_filter_free(struct seccomp_filter *filter)
 {
 	if (filter) {
-		bpf_prog_destroy(filter->prog);
+		if (bpf_prog_was_classic(filter->prog))
+			bpf_prog_destroy(filter->prog);
+		else
+			bpf_prog_put(filter->prog);
 		kfree(filter);
 	}
 }
@@ -690,6 +698,52 @@ seccomp_prepare_user_filter(const char __user *user_filter)
 	return filter;
 }
 
+#ifdef CONFIG_SECCOMP_FILTER_EXTENDED
+/**
+ * seccomp_prepare_extended_filter - prepares a user-supplied eBPF fd
+ * @user_filter: pointer to the user data containing an fd.
+ *
+ * Returns 0 on success and non-zero otherwise.
+ */
+static struct seccomp_filter *
+seccomp_prepare_extended_filter(const int __user *user_fd)
+{
+	struct seccomp_filter *sfilter;
+	struct bpf_prog *fp;
+	int fd;
+
+	/* Fetch the fd from userspace */
+	if (get_user(fd, user_fd))
+		return ERR_PTR(-EFAULT);
+
+	/* Allocate a new seccomp_filter */
+	sfilter = kzalloc(sizeof(*sfilter), GFP_KERNEL | __GFP_NOWARN);
+	if (!sfilter)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&sfilter->notify_lock);
+	fp = bpf_prog_get_type(fd, BPF_PROG_TYPE_SECCOMP);
+
+	if (IS_ERR(fp)) {
+		kfree(sfilter);
+		return ERR_CAST(fp);
+	}
+
+	sfilter->prog = fp;
+	refcount_set(&sfilter->refs, 1);
+	refcount_set(&sfilter->users, 1);
+	init_waitqueue_head(&sfilter->wqh);
+
+	return sfilter;
+}
+#else
+static struct seccomp_filter *
+seccomp_prepare_extended_filter(const int __user *filter_fd)
+{
+	return ERR_PTR(-EINVAL);
+}
+#endif
+
 #ifdef SECCOMP_ARCH_NATIVE
 /**
  * seccomp_is_const_allow - check if filter is constant allow with given data
@@ -778,7 +832,10 @@ static void seccomp_cache_prepare_bitmap(struct seccomp_filter *sfilter,
 	struct seccomp_data sd;
 	int nr;
 
-	if (bitmap_prev) {
+	if (!bpf_prog_was_classic(sfilter->prog)) {
+		/* eBPF program, no caching. */
+		bitmap_zero(bitmap, bitmap_size);
+	} else if (bitmap_prev) {
 		/* The new filter must be as restrictive as the last. */
 		bitmap_copy(bitmap, bitmap_prev, bitmap_size);
 	} else {
@@ -1766,9 +1823,10 @@ static bool has_duplicate_listener(struct seccomp_filter *new_child)
  * Returns 0 on success or -EINVAL on failure.
  */
 static long seccomp_set_mode_filter(unsigned int flags,
-				    const char __user *filter)
+				    const void __user *filter)
 {
-	const unsigned long seccomp_mode = SECCOMP_MODE_FILTER;
+	/* We use SECCOMP_MODE_FILTER for both eBPF and cBPF filters */
+	const unsigned long filter_mode = SECCOMP_MODE_FILTER;
 	struct seccomp_filter *prepared = NULL;
 	long ret = -EINVAL;
 	int listener = -1;
@@ -1791,7 +1849,11 @@ static long seccomp_set_mode_filter(unsigned int flags,
 		return -EINVAL;
 
 	/* Prepare the new filter before holding any locks. */
-	prepared = seccomp_prepare_user_filter(filter);
+	if (flags & SECCOMP_FILTER_FLAG_EXTENDED)
+		prepared = seccomp_prepare_extended_filter(filter);
+	else
+		prepared = seccomp_prepare_user_filter(filter);
+
 	if (IS_ERR(prepared))
 		return PTR_ERR(prepared);
 
@@ -1836,7 +1898,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
 
 	spin_lock_irq(&current->sighand->siglock);
 
-	if (!seccomp_may_assign_mode(seccomp_mode))
+	if (!seccomp_may_assign_mode(filter_mode))
 		goto out;
 
 	if (has_duplicate_listener(prepared)) {
@@ -1850,7 +1912,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	/* Do not free the successfully attached filter. */
 	prepared = NULL;
 
-	seccomp_assign_mode(current, seccomp_mode, flags);
+	seccomp_assign_mode(current, filter_mode, flags);
 out:
 	spin_unlock_irq(&current->sighand->siglock);
 	if (flags & SECCOMP_FILTER_FLAG_TSYNC)
@@ -2046,15 +2108,17 @@ long seccomp_get_filter(struct task_struct *task, unsigned long filter_off,
 	if (IS_ERR(filter))
 		return PTR_ERR(filter);
 
+	/* This must be a new non-cBPF filter, since we save
+	 * every cBPF filter's orig_prog above when
+	 * CONFIG_CHECKPOINT_RESTORE is enabled.
+	 */
+	ret = -EMEDIUMTYPE;
+
 	fprog = filter->prog->orig_prog;
-	if (!fprog) {
-		/* This must be a new non-cBPF filter, since we save
-		 * every cBPF filter's orig_prog above when
-		 * CONFIG_CHECKPOINT_RESTORE is enabled.
-		 */
-		ret = -EMEDIUMTYPE;
+	if (!fprog)
+		goto out;
+	if (!bpf_prog_was_classic(filter->prog))
 		goto out;
-	}
 
 	ret = fprog->len;
 	if (!data)
@@ -2307,6 +2371,63 @@ static int seccomp_actions_logged_handler(struct ctl_table *ro_table, int write,
 	return ret;
 }
 
+#ifdef CONFIG_SECCOMP_FILTER_EXTENDED
+static bool seccomp_is_valid_access(int off, int size,
+				    enum bpf_access_type type,
+					const struct bpf_prog *prog,
+				    struct bpf_insn_access_aux *info)
+{
+	if (type != BPF_READ)
+		return false;
+
+	if (off < 0 || off + size > sizeof(struct seccomp_data))
+		return false;
+
+	if (off % size != 0)
+		return false;
+
+	switch (off) {
+	case bpf_ctx_range_till(struct seccomp_data, args[0], args[5]):
+		return (size == sizeof(__u64));
+	case bpf_ctx_range(struct seccomp_data, nr):
+		return (size == sizeof_field(struct seccomp_data, nr));
+	case bpf_ctx_range(struct seccomp_data, arch):
+		return (size == sizeof_field(struct seccomp_data, arch));
+	case bpf_ctx_range(struct seccomp_data, instruction_pointer):
+		return (size == sizeof_field(struct seccomp_data,
+					     instruction_pointer));
+	default:
+		return false;
+	}
+}
+
+static const struct bpf_func_proto *
+seccomp_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_get_current_uid_gid:
+		return &bpf_get_current_uid_gid_proto;
+	case BPF_FUNC_get_current_pid_tgid:
+		return &bpf_get_current_pid_tgid_proto;
+	default:
+		break;
+	}
+
+	if (bpf_capable() && perfmon_capable())
+		return bpf_tracing_func_proto(func_id, prog);
+	else
+		return bpf_base_func_proto(func_id);
+}
+
+const struct bpf_prog_ops seccomp_prog_ops = {
+};
+
+const struct bpf_verifier_ops seccomp_verifier_ops = {
+	.get_func_proto		= seccomp_func_proto,
+	.is_valid_access	= seccomp_is_valid_access,
+};
+#endif /* CONFIG_SECCOMP_FILTER_EXTENDED */
+
 static struct ctl_path seccomp_sysctl_path[] = {
 	{ .procname = "kernel", },
 	{ .procname = "seccomp", },
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ec6d85a81744..b78d5c9fbb4b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -937,6 +937,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_EXT,
 	BPF_PROG_TYPE_LSM,
 	BPF_PROG_TYPE_SK_LOOKUP,
+	BPF_PROG_TYPE_SECCOMP,
 };
 
 enum bpf_attach_type {
-- 
2.31.1

