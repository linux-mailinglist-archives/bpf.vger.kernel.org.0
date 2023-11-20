Return-Path: <bpf+bounces-15355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6987F1465
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 14:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B30A1C21658
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 13:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89461A71B;
	Mon, 20 Nov 2023 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B7BD2
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 05:28:20 -0800 (PST)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3AKDSJZv045904;
	Mon, 20 Nov 2023 22:28:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Mon, 20 Nov 2023 22:28:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3AKDRaAK045731
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 20 Nov 2023 22:28:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ba64c849-88ca-4890-8c05-d6fc268f14d4@I-love.SAKURA.ne.jp>
Date: Mon, 20 Nov 2023 22:28:15 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/4] LSM: Auto-undef LSM_HOOK macro.
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-security-module <linux-security-module@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>, song@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, renauld@google.com,
        Paolo Abeni <pabeni@redhat.com>
References: <93b5e861-c1ec-417c-b21e-56d0c4a3ae79@I-love.SAKURA.ne.jp>
In-Reply-To: <93b5e861-c1ec-417c-b21e-56d0c4a3ae79@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Since all users are doing "#undef LSM_HOOK" immediately after
"#include <linux/lsm_hook_defs.h>" line, let lsm_hook_defs.h do it.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/bpf_lsm.h       | 1 -
 include/linux/lsm_hook_defs.h | 3 ++-
 include/linux/lsm_hooks.h     | 2 --
 kernel/bpf/bpf_lsm.c          | 3 ---
 security/bpf/hooks.c          | 1 -
 security/security.c           | 3 ---
 6 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 1de7ece5d36d..01b7a2913cb1 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -16,7 +16,6 @@
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	RET bpf_lsm_##NAME(__VA_ARGS__);
 #include <linux/lsm_hook_defs.h>
-#undef LSM_HOOK
 
 struct bpf_storage_blob {
 	struct bpf_local_storage __rcu *storage;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ff217a5ce552..3febbe4ef87c 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -23,7 +23,6 @@
  * struct security_hook_heads {
  *   #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
  *   #include <linux/lsm_hook_defs.h>
- *   #undef LSM_HOOK
  * };
  */
 LSM_HOOK(int, 0, binder_set_context_mgr, const struct cred *mgr)
@@ -419,3 +418,5 @@ LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
 LSM_HOOK(int, 0, uring_sqpoll, void)
 LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
 #endif /* CONFIG_IO_URING */
+
+#undef LSM_HOOK
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index dcb5e5b5eb13..4ba1aedc7901 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -33,13 +33,11 @@
 union security_list_options {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
 	#include "lsm_hook_defs.h"
-	#undef LSM_HOOK
 };
 
 struct security_hook_heads {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
 	#include "lsm_hook_defs.h"
-	#undef LSM_HOOK
 } __randomize_layout;
 
 /*
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index e14c822f8911..025d05c30f11 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -26,14 +26,11 @@ noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
 {						\
 	return DEFAULT;				\
 }
-
 #include <linux/lsm_hook_defs.h>
-#undef LSM_HOOK
 
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
 BTF_SET_START(bpf_lsm_hooks)
 #include <linux/lsm_hook_defs.h>
-#undef LSM_HOOK
 BTF_SET_END(bpf_lsm_hooks)
 
 /* List of LSM hooks that should operate on 'current' cgroup regardless
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index cfaf1d0e6a5f..93bd9b2cf8fc 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -10,7 +10,6 @@ static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
 	#include <linux/lsm_hook_defs.h>
-	#undef LSM_HOOK
 	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
 	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
 };
diff --git a/security/security.c b/security/security.c
index dcb3e7014f9b..d35d50b218c6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -407,7 +407,6 @@ int __init early_security_init(void)
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	INIT_HLIST_HEAD(&security_hook_heads.NAME);
 #include "linux/lsm_hook_defs.h"
-#undef LSM_HOOK
 
 	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
 		if (!lsm->enabled)
@@ -749,9 +748,7 @@ static int lsm_superblock_alloc(struct super_block *sb)
 	static const int __maybe_unused LSM_RET_DEFAULT(NAME) = (DEFAULT);
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
-
 #include <linux/lsm_hook_defs.h>
-#undef LSM_HOOK
 
 /*
  * Hook list operation macros.
-- 
2.34.1


