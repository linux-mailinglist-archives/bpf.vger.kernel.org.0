Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D617357D27C
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 19:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiGUR2j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 13:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiGUR2W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 13:28:22 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2666D8AB03
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 10:28:17 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10cf9f5b500so3318464fac.2
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 10:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oSkp5XL8evSozcL3p6dp5pf7REvcEIJL7/dJNXUU/iU=;
        b=RTsFkn4w9Q+1HCvSArxhpw/M593UnODTkZBs5Hm875j+xZWAZK2wghDB3V5snivDg4
         tzHaqxbKYm6pxwHgiND9geYCossCSEx8bRK0ORYhiwb1saYA/q0uDPWsU3k9njgcxZlw
         ScwEL0YCfwv6neSRlCeBxuwSJu1QYy7+NV1lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oSkp5XL8evSozcL3p6dp5pf7REvcEIJL7/dJNXUU/iU=;
        b=ziwUCPy99rPzA6RXyXy+G5Xq1r9TYOo2203iI/BSLBUBUO5vu9KJHhuf3UXzX3txpF
         WvBTBhn+rQNzEulQu41FIint78Yy6DL8+QzRqt6PwbuIeioIq0ql1PkFpWLT4IGPeyBS
         28VA24wqjR8rkNShHUEkJkfTS8an8rFGGsFqYCNaPevQZvnLWWHVRsxk5LwYeqVxkxg5
         Hp9x6qkyvyVBldyHICYzrJvesuMk3rpWTvba5GpFUh6sLvXNzCqsX9aGHnn/3LvNPilQ
         dn8UogulaxUVU7OrdW5zD0p4ZYQpBAYWk4mEi5g7eER9mgFgVVWrpSx7VqnIApWY46JO
         ZwVQ==
X-Gm-Message-State: AJIora+m5B1o3g5fenmsQFRLB+4U+gIB/SMqUo/myJX9V3rGVZgTg9Zz
        sdn3WsFXLq0K8cGy9wG3W87wrA==
X-Google-Smtp-Source: AGRyM1vn8iYdneqMQSfU5E7rKtCDDTFXE6gJ/E+orOgcQYDydQBDRlFTXDgzTF2YYM6Rsw5HvyJSJg==
X-Received: by 2002:a05:6870:c353:b0:101:e7e4:9388 with SMTP id e19-20020a056870c35300b00101e7e49388mr5620686oak.45.1658424496479;
        Thu, 21 Jul 2022 10:28:16 -0700 (PDT)
Received: from localhost.localdomain ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id du24-20020a0568703a1800b00101c83352c6sm1106207oab.34.2022.07.21.10.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:28:16 -0700 (PDT)
From:   Frederick Lawler <fred@cloudflare.com>
To:     kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, shuah@kernel.org, brauner@kernel.org,
        casey@schaufler-ca.com, ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, cgzones@googlemail.com,
        karl@bigbadwolfsecurity.com, Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v3 1/4] security, lsm: Introduce security_create_user_ns()
Date:   Thu, 21 Jul 2022 12:28:05 -0500
Message-Id: <20220721172808.585539-2-fred@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721172808.585539-1-fred@cloudflare.com>
References: <20220721172808.585539-1-fred@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Preventing user namespace (privileged or otherwise) creation comes in a
few of forms in order of granularity:

        1. /proc/sys/user/max_user_namespaces sysctl
        2. OS specific patch(es)
        3. CONFIG_USER_NS

To block a task based on its attributes, the LSM hook cred_prepare is a
good candidate for use because it provides more granular control, and
it is called before create_user_ns():

        cred = prepare_creds()
                security_prepare_creds()
                        call_int_hook(cred_prepare, ...
        if (cred)
                create_user_ns(cred)

Since security_prepare_creds() is meant for LSMs to copy and prepare
credentials, access control is an unintended use of the hook. Therefore
introduce a new function security_create_user_ns() with an accompanying
userns_create LSM hook.

This hook takes the prepared creds for LSM authors to write policy
against. On success, the new namespace is applied to credentials,
otherwise an error is returned.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>

---
Changes since v2:
- Rename create_user_ns hook to userns_create
Changes since v1:
- Changed commit wording
- Moved execution to be after id mapping check
- Changed signature to only accept a const struct cred *
---
 include/linux/lsm_hook_defs.h | 1 +
 include/linux/lsm_hooks.h     | 4 ++++
 include/linux/security.h      | 6 ++++++
 kernel/user_namespace.c       | 5 +++++
 security/security.c           | 5 +++++
 5 files changed, 21 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index eafa1d2489fd..7ff93cb8ca8d 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -223,6 +223,7 @@ LSM_HOOK(int, -ENOSYS, task_prctl, int option, unsigned long arg2,
 	 unsigned long arg3, unsigned long arg4, unsigned long arg5)
 LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
 	 struct inode *inode)
+LSM_HOOK(int, 0, userns_create, const struct cred *cred)
 LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
 LSM_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp,
 	 u32 *secid)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 91c8146649f5..54fe534d0e01 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -799,6 +799,10 @@
  *	security attributes, e.g. for /proc/pid inodes.
  *	@p contains the task_struct for the task.
  *	@inode contains the inode structure for the inode.
+ * @userns_create:
+ *	Check permission prior to creating a new user namespace.
+ *	@cred points to prepared creds.
+ *	Return 0 if successful, otherwise < 0 error code.
  *
  * Security hooks for Netlink messaging.
  *
diff --git a/include/linux/security.h b/include/linux/security.h
index 7fc4e9f49f54..a195bf33246a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -435,6 +435,7 @@ int security_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
+int security_create_user_ns(const struct cred *cred);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
 void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
 int security_msg_msg_alloc(struct msg_msg *msg);
@@ -1185,6 +1186,11 @@ static inline int security_task_prctl(int option, unsigned long arg2,
 static inline void security_task_to_inode(struct task_struct *p, struct inode *inode)
 { }
 
+static inline int security_create_user_ns(const struct cred *cred)
+{
+	return 0;
+}
+
 static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 					  short flag)
 {
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 5481ba44a8d6..3f464bbda0e9 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -9,6 +9,7 @@
 #include <linux/highuid.h>
 #include <linux/cred.h>
 #include <linux/securebits.h>
+#include <linux/security.h>
 #include <linux/keyctl.h>
 #include <linux/key-type.h>
 #include <keys/user-type.h>
@@ -113,6 +114,10 @@ int create_user_ns(struct cred *new)
 	    !kgid_has_mapping(parent_ns, group))
 		goto fail_dec;
 
+	ret = security_create_user_ns(new);
+	if (ret < 0)
+		goto fail_dec;
+
 	ret = -ENOMEM;
 	ns = kmem_cache_zalloc(user_ns_cachep, GFP_KERNEL);
 	if (!ns)
diff --git a/security/security.c b/security/security.c
index 188b8f782220..ec9b4696e86c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1903,6 +1903,11 @@ void security_task_to_inode(struct task_struct *p, struct inode *inode)
 	call_void_hook(task_to_inode, p, inode);
 }
 
+int security_create_user_ns(const struct cred *cred)
+{
+	return call_int_hook(userns_create, 0, cred);
+}
+
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 {
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
-- 
2.30.2

