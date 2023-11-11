Return-Path: <bpf+bounces-14873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A377D7E8A23
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 11:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50906281035
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 10:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3AD125C8;
	Sat, 11 Nov 2023 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD98125A6
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 10:08:53 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214A53AA6
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:08:52 -0800 (PST)
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3ABA8oXm035971;
	Sat, 11 Nov 2023 19:08:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Sat, 11 Nov 2023 19:08:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3ABA7mvY035781
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 11 Nov 2023 19:08:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2c8eae29-63da-461c-849f-3b08cf5fc7d1@I-love.SAKURA.ne.jp>
Date: Sat, 11 Nov 2023 19:08:50 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/5] LSM: Auto-undef LSM_HOOK macro.
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-security-module <linux-security-module@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>, song@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, renauld@google.com,
        Paolo Abeni <pabeni@redhat.com>
References: <38b318a5-0a16-4cc2-878e-4efa632236f3@I-love.SAKURA.ne.jp>
In-Reply-To: <38b318a5-0a16-4cc2-878e-4efa632236f3@I-love.SAKURA.ne.jp>
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
 security/security.c           | 4 ----
 6 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 5bbc31ac948c..11544b098c06 100644
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
index 6ea529e4d9be..4229dee73eba 100644
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
@@ -423,3 +422,5 @@ LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
 LSM_HOOK(int, 0, uring_sqpoll, void)
 LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
 #endif /* CONFIG_IO_URING */
+
+#undef LSM_HOOK
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b646f6746147..135b3f58f8d2 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -57,7 +57,6 @@ do {						\
 union security_list_options {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
 	#include "lsm_hook_defs.h"
-	#undef LSM_HOOK
 	void *lsm_callback;
 };
 
@@ -87,7 +86,6 @@ struct lsm_static_calls_table {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 		struct lsm_static_call NAME[MAX_LSM_COUNT];
 	#include <linux/lsm_hook_defs.h>
-	#undef LSM_HOOK
 } __randomize_layout;
 
 /**
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
index 61433633d235..294d9d152fb0 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -11,7 +11,6 @@ static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	LSM_HOOK_INIT_DISABLED(NAME, bpf_lsm_##NAME),
 	#include <linux/lsm_hook_defs.h>
-	#undef LSM_HOOK
 	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
 	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
 };
diff --git a/security/security.c b/security/security.c
index 5f4e5e6d0989..986aa5e6e29d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -131,7 +131,6 @@ static __initdata struct lsm_info *exclusive;
 #define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
 	LSM_DEFINE_UNROLL(DEFINE_LSM_STATIC_CALL, NAME, RET, __VA_ARGS__)
 #include <linux/lsm_hook_defs.h>
-#undef LSM_HOOK
 #undef DEFINE_LSM_STATIC_CALL
 
 /*
@@ -152,7 +151,6 @@ struct lsm_static_calls_table static_calls_table __ro_after_init = {
 		LSM_DEFINE_UNROLL(INIT_LSM_STATIC_CALL, NAME)		\
 	},
 #include <linux/lsm_hook_defs.h>
-#undef LSM_HOOK
 #undef INIT_LSM_STATIC_CALL
 };
 
@@ -894,9 +892,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
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



