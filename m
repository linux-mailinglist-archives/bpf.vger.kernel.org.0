Return-Path: <bpf+bounces-14876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC2B7E8A29
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 11:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A217B20AF3
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 10:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F9F125D8;
	Sat, 11 Nov 2023 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA9D11731
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 10:11:42 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC6B385B
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:11:39 -0800 (PST)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3ABABcet036629;
	Sat, 11 Nov 2023 19:11:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Sat, 11 Nov 2023 19:11:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3ABA7mvb035781
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 11 Nov 2023 19:11:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <39f27c5d-2c41-4f7b-a6e9-740a6af4b364@I-love.SAKURA.ne.jp>
Date: Sat, 11 Nov 2023 19:11:38 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/5] LSM: Add a LSM module which handles dynamically
 appendable LSM hooks.
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

TOMOYO security module will use this functionality.

By the way, I was surprised to see /proc/kallsyms containing many hundreds
of symbols due to assigning "number of LSM hooks" * "number of built-in
LSMs" for static call slots. Since the motivation of converting from
linked list to static calls was that indirect function calls are slow,
I expect that overhead of testing whether the list is empty is negligible.

Should this LSM module occupy one set of static call slots (so that
list_for_each_entry() is called only when this LSM module is enabled) ?
If the overhead of testing list_for_each_entry() on an empty list is
negligible, this module does not need to occupy one set of static call
slots? I don't have a native hardware that is suitable for performance
measurement...

Also, since LSM hook assignment is handled by a macro, we could somehow
let the hook assignment macro define one static call slot and call the
next LSM hook (i.e. move static_call() from security/security.c to
individual LSM modules). Then, loop unrolling won't be needed, and
total number of symbols reserved for static calls will be reduced to
"number of LSM hooks" + "sum of all LSM callbacks which are built-into
vmlinux". Side effect of such approach is that kernel stack usage
increases due to nested static calls. But since nest level of static
calls is very small, kernel stack usage won't become a real problem...

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/lsm_count.h |   2 +-
 include/linux/lsm_hooks.h |  16 ++++++
 include/uapi/linux/lsm.h  |   1 +
 security/Makefile         |   2 +-
 security/mod_lsm.c        | 100 ++++++++++++++++++++++++++++++++++++++
 security/security.c       |   2 +-
 6 files changed, 120 insertions(+), 3 deletions(-)
 create mode 100644 security/mod_lsm.c

diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
index dbb3c8573959..de8db3c77169 100644
--- a/include/linux/lsm_count.h
+++ b/include/linux/lsm_count.h
@@ -19,7 +19,7 @@
  * Capabilities is enabled when CONFIG_SECURITY is enabled.
  */
 #if IS_ENABLED(CONFIG_SECURITY)
-#define CAPABILITIES_ENABLED 1,
+#define CAPABILITIES_ENABLED 1, 1,
 #else
 #define CAPABILITIES_ENABLED
 #endif
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 135b3f58f8d2..669ee9406a62 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -215,4 +215,20 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 extern int lsm_inode_alloc(struct inode *inode);
 extern struct lsm_static_calls_table static_calls_table __ro_after_init;
 
+/* Definition of all modular callbacks. */
+struct security_hook_mappings {
+#define LSM_HOOK(RET, DEFAULT, NAME, ...)	\
+	struct static_call_key *key_##NAME;	\
+	RET (*NAME)(__VA_ARGS__);
+#include <linux/lsm_hook_defs.h>
+} /* __randomize_layout is useless here, for this is a "const __initdata" struct. */;
+
+/* Type of individual modular callback. */
+struct security_hook_list2 {
+	struct list_head list;
+	union security_list_options hook;
+} __randomize_layout;
+
+extern int mod_lsm_add_hooks(const struct security_hook_mappings *maps);
+
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index f0386880a78e..d458b9a123d1 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -61,6 +61,7 @@ struct lsm_ctx {
 #define LSM_ID_LOCKDOWN		108
 #define LSM_ID_BPF		109
 #define LSM_ID_LANDLOCK		110
+#define LSM_ID_MOD_LSM		111
 
 /*
  * LSM_ATTR_XXX definitions identify different LSM attributes
diff --git a/security/Makefile b/security/Makefile
index 59f238490665..250b7ba23502 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_SECURITY) 			+= lsm_syscalls.o
 obj-$(CONFIG_MMU)			+= min_addr.o
 
 # Object file lists
-obj-$(CONFIG_SECURITY)			+= security.o
+obj-$(CONFIG_SECURITY)			+= security.o mod_lsm.o
 obj-$(CONFIG_SECURITYFS)		+= inode.o
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
 obj-$(CONFIG_SECURITY_SMACK)		+= smack/
diff --git a/security/mod_lsm.c b/security/mod_lsm.c
new file mode 100644
index 000000000000..f148323b724b
--- /dev/null
+++ b/security/mod_lsm.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/lsm_hooks.h>
+
+/* List of registered modular callbacks. */
+static struct {
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) struct list_head NAME;
+#include <linux/lsm_hook_defs.h>
+} mod_lsm_dynamic_hooks;
+
+/* Get LSM_CALL_ARGS_xxx definitions. */
+#include <linux/lsm_hook_args.h>
+/* A built-in callback for calling modular "int" callbacks. */
+#define LSM_INT_HOOK(RET, DEFAULT, NAME, ...)				\
+	static RET mod_lsm_##NAME(__VA_ARGS__) {			\
+		int RC = DEFAULT;					\
+		struct security_hook_list2 *P;				\
+									\
+		pr_info_once("Called %s\n", __func__);			\
+		list_for_each_entry(P, &mod_lsm_dynamic_hooks.NAME, list) { \
+			RC = P->hook.NAME(LSM_CALL_ARGS_##NAME);	\
+			if (RC != 0)					\
+				break;					\
+		}							\
+		return RC;						\
+	}
+/* A built-in callback for calling modular "void" callbacks. */
+#define LSM_VOID_HOOK(RET, DEFAULT, NAME, ...)				\
+	static RET mod_lsm_##NAME(__VA_ARGS__) {			\
+		struct security_hook_list2 *P;				\
+									\
+		pr_info_once("Called %s\n", __func__);			\
+		list_for_each_entry(P, &mod_lsm_dynamic_hooks.NAME, list) { \
+			P->hook.NAME(LSM_CALL_ARGS_##NAME);		\
+		}							\
+	}
+/* Generate all built-in callbacks here. */
+#include <linux/lsm_hook_defs.h>
+
+/* Initialize all built-in callbacks here. */
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) LSM_HOOK_INIT(NAME, mod_lsm_##NAME),
+static struct security_hook_list mod_lsm_builtin_hooks[] __ro_after_init = {
+#include <linux/lsm_hook_defs.h>
+};
+
+static int mod_lsm_enabled __ro_after_init = 1;
+static struct lsm_blob_sizes mod_lsm_blob_sizes __ro_after_init = { };
+static const struct lsm_id mod_lsm_lsmid = {
+	.name = "mod_lsm",
+	.id = LSM_ID_MOD_LSM,
+};
+
+static int __init mod_lsm_init(void)
+{
+	/* Initialize modular callbacks list. */
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) INIT_LIST_HEAD(&mod_lsm_dynamic_hooks.NAME);
+#include <linux/lsm_hook_defs.h>
+	/* Register built-in callbacks. */
+	security_add_hooks(mod_lsm_builtin_hooks, ARRAY_SIZE(mod_lsm_builtin_hooks), &mod_lsm_lsmid);
+	return 0;
+}
+
+DEFINE_LSM(mod_lsm) = {
+	.name = "mod_lsm",
+	.enabled = &mod_lsm_enabled,
+	.flags = 0,
+	.blobs = &mod_lsm_blob_sizes,
+	.init = mod_lsm_init,
+};
+
+/* The only exported function for registering modular callbacks. */
+int mod_lsm_add_hooks(const struct security_hook_mappings *maps)
+{
+	struct security_hook_list2 *entry;
+	int count = 0;
+
+	if (!mod_lsm_enabled) {
+		pr_info_once("Loadable LSM support is not enabled.\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* Count how meny callbacks are implemented. */
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) do { if (maps->NAME) count++; } while (0);
+#include <linux/lsm_hook_defs.h>
+	if (!count)
+		return -EINVAL;
+	/* Allocate memory for registering implemented callbacks. */
+	entry = kmalloc_array(count, sizeof(struct security_hook_list2), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+	/* Registering imdividual callbacks. */
+	count = 0;
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) do { if (maps->NAME) {	\
+			entry[count].hook.NAME = maps->NAME;		\
+			list_add_tail(&entry[count].list, &mod_lsm_dynamic_hooks.NAME); \
+			count++;					\
+		} } while (0);
+#include <linux/lsm_hook_defs.h>
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mod_lsm_add_hooks);
diff --git a/security/security.c b/security/security.c
index 986aa5e6e29d..a34530fa042a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -42,7 +42,7 @@
  * The capability module is accounted for by CONFIG_SECURITY
  */
 #define LSM_CONFIG_COUNT ( \
-	(IS_ENABLED(CONFIG_SECURITY) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY) ? 2 : 0) + \
 	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
-- 
2.34.1



