Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6CE2B1393
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 01:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgKMA7k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 19:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKMA7k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 19:59:40 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489B6C0613D1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 16:59:40 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so7926243wrc.8
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 16:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y/pIWRqvv7LXVrr/ONkTBwvlU81JRWTV+qn8MBABH7c=;
        b=mdwUiIfb06UeCn+DO//NkSbvTv76B8IKz4LTBji8Do2tU4//+1IPG3ByZnOn/T3/4q
         7v6C+gGZkkEYKLQIqfXkIB5zSJfLrDo3LENx6tHiZjrsoJCXRBK8M/bo/nAuU5eYE1OP
         jalOzFtZXY+pNIOoom4z6M10r/1cr59grtGiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/pIWRqvv7LXVrr/ONkTBwvlU81JRWTV+qn8MBABH7c=;
        b=dpzRaKxJyrW0Rkw3Ieu3UtyUdbgRjJFAh8ztthQAKhWyAzO/4nXCGktUsCsMOuRT6A
         0o66lCEqy0WhQ6nEYTA0KbphmhjTlABB9gJvqTHxazFOoZQWFDestsNUlmtd8a2ysk0T
         ToEU1qb2Duobq84qbO45seJQyiL6ovgAng4JA9OeXu06M9AFBE/ulznO77gRC5Otqdk3
         S/aWQellghiciFLKfgolDgnQXPYZ5gp/pitZgV9WiwU4vTM+h9wvVsP7BEd015GRXqgu
         CFMESue4cOWejxcFTE6OA8F78RLarsPSYDOP14cZ5ugks7dpqBFji7dFx6rXEz29z8WD
         dIcg==
X-Gm-Message-State: AOAM532lkIoJaZgQ9fJMJ8656hiu6skHJnTaat0wYxhPBLsb+vrQjSlM
        vGobb7J3lJILj1SE2GtaDdCAuw==
X-Google-Smtp-Source: ABdhPJxnu8sly2gvcahojKS5Pz76KEeqsnXsNQqz1gML5pn6oCNvNj5rGxzAi+XabzdjJ8Feo02zmA==
X-Received: by 2002:adf:eacb:: with SMTP id o11mr2698154wrn.208.1605229178959;
        Thu, 12 Nov 2020 16:59:38 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id m3sm4508104wrv.6.2020.11.12.16.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 16:59:38 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v3 1/2] bpf: Augment the set of sleepable LSM hooks
Date:   Fri, 13 Nov 2020 00:59:29 +0000
Message-Id: <20201113005930.541956-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201113005930.541956-1-kpsingh@chromium.org>
References: <20201113005930.541956-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Update the set of sleepable hooks with the ones that do not trigger
a warning with might_fault() when exercised with the correct kernel
config options enabled, i.e.

	DEBUG_ATOMIC_SLEEP=y
	LOCKDEP=y
	PROVE_LOCKING=y

This means that a sleepable LSM eBPF program can be attached to these
LSM hooks. A new helper method bpf_lsm_is_sleepable_hook is added and
the set is maintained locally in bpf_lsm.c

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf_lsm.h |  7 ++++
 kernel/bpf/bpf_lsm.c    | 81 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c   | 16 +-------
 3 files changed, 89 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 73226181b744..0d1c33ace398 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -27,6 +27,8 @@ extern struct lsm_blob_sizes bpf_lsm_blob_sizes;
 int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 			const struct bpf_prog *prog);
 
+bool bpf_lsm_is_sleepable_hook(u32 btf_id);
+
 static inline struct bpf_storage_blob *bpf_inode(
 	const struct inode *inode)
 {
@@ -54,6 +56,11 @@ void bpf_task_storage_free(struct task_struct *task);
 
 #else /* !CONFIG_BPF_LSM */
 
+static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
+{
+	return false;
+}
+
 static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 				      const struct bpf_prog *prog)
 {
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index e92c51bebb47..aed74b853415 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -13,6 +13,7 @@
 #include <linux/bpf_verifier.h>
 #include <net/bpf_sk_storage.h>
 #include <linux/bpf_local_storage.h>
+#include <linux/btf_ids.h>
 
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached.
@@ -72,6 +73,86 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	}
 }
 
+/* The set of hooks which are called without pagefaults disabled and are allowed
+ * to "sleep" and thus can be used for sleeable BPF programs.
+ */
+BTF_SET_START(sleepable_lsm_hooks)
+BTF_ID(func, bpf_lsm_bpf)
+BTF_ID(func, bpf_lsm_bpf_map)
+BTF_ID(func, bpf_lsm_bpf_map_alloc_security)
+BTF_ID(func, bpf_lsm_bpf_map_free_security)
+BTF_ID(func, bpf_lsm_bpf_prog)
+BTF_ID(func, bpf_lsm_bprm_check_security)
+BTF_ID(func, bpf_lsm_bprm_committed_creds)
+BTF_ID(func, bpf_lsm_bprm_committing_creds)
+BTF_ID(func, bpf_lsm_bprm_creds_for_exec)
+BTF_ID(func, bpf_lsm_bprm_creds_from_file)
+BTF_ID(func, bpf_lsm_capget)
+BTF_ID(func, bpf_lsm_capset)
+BTF_ID(func, bpf_lsm_cred_prepare)
+BTF_ID(func, bpf_lsm_file_ioctl)
+BTF_ID(func, bpf_lsm_file_lock)
+BTF_ID(func, bpf_lsm_file_open)
+BTF_ID(func, bpf_lsm_file_receive)
+BTF_ID(func, bpf_lsm_inet_conn_established)
+BTF_ID(func, bpf_lsm_inode_create)
+BTF_ID(func, bpf_lsm_inode_free_security)
+BTF_ID(func, bpf_lsm_inode_getattr)
+BTF_ID(func, bpf_lsm_inode_getxattr)
+BTF_ID(func, bpf_lsm_inode_mknod)
+BTF_ID(func, bpf_lsm_inode_need_killpriv)
+BTF_ID(func, bpf_lsm_inode_post_setxattr)
+BTF_ID(func, bpf_lsm_inode_readlink)
+BTF_ID(func, bpf_lsm_inode_rename)
+BTF_ID(func, bpf_lsm_inode_rmdir)
+BTF_ID(func, bpf_lsm_inode_setattr)
+BTF_ID(func, bpf_lsm_inode_setxattr)
+BTF_ID(func, bpf_lsm_inode_symlink)
+BTF_ID(func, bpf_lsm_inode_unlink)
+BTF_ID(func, bpf_lsm_kernel_module_request)
+BTF_ID(func, bpf_lsm_kernfs_init_security)
+BTF_ID(func, bpf_lsm_key_free)
+BTF_ID(func, bpf_lsm_mmap_file)
+BTF_ID(func, bpf_lsm_netlink_send)
+BTF_ID(func, bpf_lsm_path_notify)
+BTF_ID(func, bpf_lsm_release_secctx)
+BTF_ID(func, bpf_lsm_sb_alloc_security)
+BTF_ID(func, bpf_lsm_sb_eat_lsm_opts)
+BTF_ID(func, bpf_lsm_sb_kern_mount)
+BTF_ID(func, bpf_lsm_sb_mount)
+BTF_ID(func, bpf_lsm_sb_remount)
+BTF_ID(func, bpf_lsm_sb_set_mnt_opts)
+BTF_ID(func, bpf_lsm_sb_show_options)
+BTF_ID(func, bpf_lsm_sb_statfs)
+BTF_ID(func, bpf_lsm_sb_umount)
+BTF_ID(func, bpf_lsm_settime)
+BTF_ID(func, bpf_lsm_socket_accept)
+BTF_ID(func, bpf_lsm_socket_bind)
+BTF_ID(func, bpf_lsm_socket_connect)
+BTF_ID(func, bpf_lsm_socket_create)
+BTF_ID(func, bpf_lsm_socket_getpeername)
+BTF_ID(func, bpf_lsm_socket_getpeersec_dgram)
+BTF_ID(func, bpf_lsm_socket_getsockname)
+BTF_ID(func, bpf_lsm_socket_getsockopt)
+BTF_ID(func, bpf_lsm_socket_listen)
+BTF_ID(func, bpf_lsm_socket_post_create)
+BTF_ID(func, bpf_lsm_socket_recvmsg)
+BTF_ID(func, bpf_lsm_socket_sendmsg)
+BTF_ID(func, bpf_lsm_socket_shutdown)
+BTF_ID(func, bpf_lsm_socket_socketpair)
+BTF_ID(func, bpf_lsm_syslog)
+BTF_ID(func, bpf_lsm_task_alloc)
+BTF_ID(func, bpf_lsm_task_getsecid)
+BTF_ID(func, bpf_lsm_task_prctl)
+BTF_ID(func, bpf_lsm_task_setscheduler)
+BTF_ID(func, bpf_lsm_task_to_inode)
+BTF_SET_END(sleepable_lsm_hooks)
+
+bool bpf_lsm_is_sleepable_hook(u32 btf_id)
+{
+	return btf_id_set_contains(&sleepable_lsm_hooks, btf_id);
+}
+
 const struct bpf_prog_ops lsm_prog_ops = {
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 10da26e55130..364ec1958c85 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11477,20 +11477,6 @@ static int check_attach_modify_return(unsigned long addr, const char *func_name)
 	return -EINVAL;
 }
 
-/* non exhaustive list of sleepable bpf_lsm_*() functions */
-BTF_SET_START(btf_sleepable_lsm_hooks)
-#ifdef CONFIG_BPF_LSM
-BTF_ID(func, bpf_lsm_bprm_committed_creds)
-#else
-BTF_ID_UNUSED
-#endif
-BTF_SET_END(btf_sleepable_lsm_hooks)
-
-static int check_sleepable_lsm_hook(u32 btf_id)
-{
-	return btf_id_set_contains(&btf_sleepable_lsm_hooks, btf_id);
-}
-
 /* list of non-sleepable functions that are otherwise on
  * ALLOW_ERROR_INJECTION list
  */
@@ -11712,7 +11698,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 				/* LSM progs check that they are attached to bpf_lsm_*() funcs.
 				 * Only some of them are sleepable.
 				 */
-				if (check_sleepable_lsm_hook(btf_id))
+				if (bpf_lsm_is_sleepable_hook(btf_id))
 					ret = 0;
 				break;
 			default:
-- 
2.29.2.299.gdc1121823c-goog

