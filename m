Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C349C2B0B24
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 18:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgKLRTO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 12:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgKLRTN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 12:19:13 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97041C0613D1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 09:19:13 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c16so6199239wmd.2
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 09:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hIiYtW7qR/FH/roxvWWhkElJqW/Xs92ieMcgmOyLJXE=;
        b=np6aFa3JX05HEeNVxZ9yFK963UJ5w+jShVPRnmRtQb6mMOATwBf0NrDdSoGiCtBkog
         WkzeN4gCfPaE7zY/v0ouNC9rvtCFTddzFKm5ey3WqvgpS1NPvrH3mer7uxVPe4uv/CQo
         Af2/9mF/6oh91smrJvYu60KM2Csur9SMcEK6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hIiYtW7qR/FH/roxvWWhkElJqW/Xs92ieMcgmOyLJXE=;
        b=hjM3oea42r+BbbfWrE0mJK9UxMHdRKILpUKypUXv51NJb/leyl6uOPfg9uLvctrH1Y
         5DRyMiZBwE+rO2n4agtACWBLrbshN3ufq0HK+JVu7u62lpcP3X2/uNk25E1j5AXPVCFX
         NBHMtsxZOLssUrGZEC91ntBCH5hhj3CWLJM+jvMq6lMMynmrxOaii5UyjgWPp9yz4N/I
         89RB65/CabXzwQ2AdPf7cOL/QbVOQ7KN134sufP1KqTEQiVpd8mI0gWdmASRXviN/wwX
         RWHtvTl+y2r+qgcCs9hCxR9vmhaC9XHsXVl+b/3UpHJXbxom43QtG9Dvveu0fomAZ0HL
         1BLw==
X-Gm-Message-State: AOAM530uFdCHcFOjtgtGEl9e1Kl/us6552pmK5/RuWcWXxf0r586iwHR
        M+ieNqMrT0+lvFz5Dgb96wzVUQ==
X-Google-Smtp-Source: ABdhPJyiICO0JugA8cA1xgA/IJ7w6P8XB8hqZUg8JSZg7iBsbJVJYwqydAQ9unVxFBpj5cg3WqQC0Q==
X-Received: by 2002:a1c:7d12:: with SMTP id y18mr638701wmc.103.1605201551637;
        Thu, 12 Nov 2020 09:19:11 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id m18sm5574938wru.37.2020.11.12.09.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 09:19:10 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next 1/2] bpf: Augment the set of sleepable LSM hooks
Date:   Thu, 12 Nov 2020 17:19:06 +0000
Message-Id: <20201112171907.373433-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
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

This means that a sleepable LSM eBPF prorgam can be attached to these
LSM hooks. A new helper method bpf_lsm_is_sleepable_hook is added and
the set is maintained locally in bpf_lsm.c

A comment is added about the list of LSM hooks that have been observed
to be called from softirqs, atomic contexts, or the ones that can
trigger pagefaults and thus should not be added to this list.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf_lsm.h |   7 +++
 kernel/bpf/bpf_lsm.c    | 120 ++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c   |  16 +-----
 3 files changed, 128 insertions(+), 15 deletions(-)

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
index e92c51bebb47..3a6e927485c2 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -13,6 +13,7 @@
 #include <linux/bpf_verifier.h>
 #include <net/bpf_sk_storage.h>
 #include <linux/bpf_local_storage.h>
+#include <linux/btf_ids.h>
 
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached.
@@ -72,6 +73,125 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	}
 }
 
+/* The set of hooks which are called without pagefaults disabled and are allowed
+ * to "sleep and thus can be used for sleeable BPF programs.
+ *
+ * There are some hooks which have been observed to be called from a
+ * non-sleepable context and should not be added to this set:
+ *
+ *  bpf_lsm_bpf_prog_free_security
+ *  bpf_lsm_capable
+ *  bpf_lsm_cred_free
+ *  bpf_lsm_d_instantiate
+ *  bpf_lsm_file_alloc_security
+ *  bpf_lsm_file_mprotect
+ *  bpf_lsm_file_send_sigiotask
+ *  bpf_lsm_inet_conn_request
+ *  bpf_lsm_inet_csk_clone
+ *  bpf_lsm_inode_alloc_security
+ *  bpf_lsm_inode_follow_link
+ *  bpf_lsm_inode_permission
+ *  bpf_lsm_key_permission
+ *  bpf_lsm_locked_down
+ *  bpf_lsm_mmap_addr
+ *  bpf_lsm_perf_event_read
+ *  bpf_lsm_ptrace_access_check
+ *  bpf_lsm_req_classify_flow
+ *  bpf_lsm_sb_free_security
+ *  bpf_lsm_sk_alloc_security
+ *  bpf_lsm_sk_clone_security
+ *  bpf_lsm_sk_free_security
+ *  bpf_lsm_sk_getsecid
+ *  bpf_lsm_socket_sock_rcv_skb
+ *  bpf_lsm_sock_graft
+ *  bpf_lsm_task_free
+ *  bpf_lsm_task_getioprio
+ *  bpf_lsm_task_getscheduler
+ *  bpf_lsm_task_kill
+ *  bpf_lsm_task_setioprio
+ *  bpf_lsm_task_setnice
+ *  bpf_lsm_task_setpgid
+ *  bpf_lsm_task_setrlimit
+ *  bpf_lsm_unix_may_send
+ *  bpf_lsm_unix_stream_connect
+ *  bpf_lsm_vm_enough_memory
+ */
+BTF_SET_START(sleepable_lsm_hooks)BTF_ID(func, bpf_lsm_bpf)
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
2.29.2.222.g5d2a92d10f8-goog

