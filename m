Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C08146CA2
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 16:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgAWPZV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 10:25:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41354 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbgAWPZU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 10:25:20 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so1536609pgk.8
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 07:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yRQPK+ErwR62ENDEwKrLDZnrNqgB8fU43Xlgi4Wz254=;
        b=Q0Pwjd/j/Pvfb7l9eOBT+nuCSWOksH8U23QiPd2sDEuspiNE61xJk9UGC216pG81Pe
         i0rMy12ReveuZXvkPIQyukVlwA82asQCUwuxu+LNHuF50ZsNHOsgLTmgFXNNyU2zeRZh
         EceLfFay/e4PSXJ2ZAcUo0QhBwkd6w0bxgRS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRQPK+ErwR62ENDEwKrLDZnrNqgB8fU43Xlgi4Wz254=;
        b=SpcCWc/0RwhnX0ZtatpggNunoN6Ly+3Z6Obeiy6IdYh7ujvPp4EuYpiu5l83a3q87m
         rxKo1dH92oVVOd3PGXJ+29EO+fgAkv4uwgbJFnguIDi0nIf+tjwBq189ESUIaJUMejIs
         wyhHIBDcTB19yc4dXzUiA1aSfe7vlqVYBoLct9vX0O58CmzfJec8p/NTq/Ggj+V13a0W
         5cKOgP7Qp+MZjBInBg9BMzD2FufmY7CJf5bh5QdPOMTsEir3kweiELBuTtvHBsIW9mYs
         pz8KKF7tJK45yhK41fMn3Z/Ho9zyrtCMgEf0HKVsmYPsHQI04WcPNlB17NeO5ZQ0L57n
         4rdQ==
X-Gm-Message-State: APjAAAWkidgfytuEzR+MGPHIPChHJmYAku6JrujQyVxtH1anVb6EDpA3
        bX+AVWWjs9NlcbTYgr/CzQudSw==
X-Google-Smtp-Source: APXvYqx6pfj4LYFEF2cxmhWolxS/T9YXjBp7zkpotHBvyd1ETePwK7ffeEsh1Zu1kAsMWit/AD91ZA==
X-Received: by 2002:aa7:9629:: with SMTP id r9mr7973110pfg.51.1579793119240;
        Thu, 23 Jan 2020 07:25:19 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:122:bd8d:3f7b:87f7:16d1])
        by smtp.gmail.com with ESMTPSA id v5sm3108118pfn.122.2020.01.23.07.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 07:25:18 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v3 06/10] bpf: lsm: Implement attach, detach and execution
Date:   Thu, 23 Jan 2020 07:24:36 -0800
Message-Id: <20200123152440.28956-7-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123152440.28956-1-kpsingh@chromium.org>
References: <20200123152440.28956-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

JITed BPF programs are used by the BPF LSM as dynamically allocated
security hooks. arch_bpf_prepare_trampoline generates code to handle
conversion of the signature of the hook to the BPF context and allows
the BPF program to be called directly as a C function.

The BPF_PROG_TYPE_LSM programs must have a GPL compatible license and
the following permissions are required to attach a program to a
hook:

- CAP_SYS_ADMIN to load the program
- CAP_MAC_ADMIN to attach it (i.e. to update the security policy)

When the program is loaded (BPF_PROG_LOAD), the verifier receives the
index of the member in the security_hook_heads struct in the
prog->aux->lsm_hook_idx and uses the BTF API provided by the LSM to:

- Populate the name of the hook in prog->aux->attach_func_name and
  the prototype in prog->aux->attach_func_proto.
- Verify if the offset is valid for a type struct hlist_head.
- The program is verified for accesses based on the attach_func_proto
  similar to raw_tp BPF programs.

When an attachment (BPF_PROG_ATTACH) is requested:

- The information required to set-up of a callback is populated in the
  struct bpf_lsm_list.
- A new callback and a bpf_lsm_hook is allocated and the address of
  the hook is set to the be the address of the allocated callback.
- The attachment returns an anonymous O_CLOEXEC fd which detaches the
  program on close.

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
---
 include/linux/bpf.h            |   4 +
 include/linux/bpf_lsm.h        |  15 +++
 include/uapi/linux/bpf.h       |   4 +
 kernel/bpf/syscall.c           |  47 +++++++-
 kernel/bpf/verifier.c          |  73 ++++++++++--
 security/bpf/Kconfig           |   1 +
 security/bpf/hooks.c           | 201 +++++++++++++++++++++++++++++++++
 security/bpf/include/bpf_lsm.h |  49 ++++++++
 security/bpf/lsm.c             |  19 ++++
 security/bpf/ops.c             |   2 +
 tools/include/uapi/linux/bpf.h |   4 +
 11 files changed, 408 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a9687861fd7e..6d6653a375f6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -614,6 +614,10 @@ struct bpf_prog_aux {
 	u32 func_cnt; /* used by non-func prog as the number of func progs */
 	u32 func_idx; /* 0 for non-func prog, the index in func array for func prog */
 	u32 attach_btf_id; /* in-kernel BTF type id to attach to */
+	/* Index of the hlist_head in security_hook_heads to which the program
+	 * must be attached.
+	 */
+	u32 lsm_hook_idx;
 	struct bpf_prog *linked_prog;
 	bool verifier_zext; /* Zero extensions has been inserted by verifier. */
 	bool offload_requested;
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 5e61c0736001..b6daa0875c8d 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -19,8 +19,11 @@ extern struct security_hook_heads bpf_lsm_hook_heads;
 
 int bpf_lsm_srcu_read_lock(void);
 void bpf_lsm_srcu_read_unlock(int idx);
+int bpf_lsm_verify_prog(const struct bpf_prog *prog);
 const struct btf_type *bpf_lsm_type_by_idx(struct btf *btf, u32 offset);
 const struct btf_member *bpf_lsm_head_by_idx(struct btf *btf, u32 idx);
+int bpf_lsm_attach(struct bpf_prog *prog);
+int bpf_lsm_detach(struct bpf_prog *prog);
 
 #define CALL_BPF_LSM_VOID_HOOKS(FUNC, ...)			\
 	do {							\
@@ -68,6 +71,10 @@ static inline int bpf_lsm_srcu_read_lock(void)
 	return 0;
 }
 static inline void bpf_lsm_srcu_read_unlock(int idx) {}
+static inline int bpf_lsm_verify_prog(const struct bpf_prog *prog)
+{
+	return -EOPNOTSUPP;
+}
 static inline const struct btf_type *bpf_lsm_type_by_idx(
 	struct btf *btf, u32 idx)
 {
@@ -78,6 +85,14 @@ static inline const struct btf_member *bpf_lsm_head_by_idx(
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+static inline int bpf_lsm_attach(struct bpf_prog *prog)
+{
+	return -EOPNOTSUPP;
+}
+static inline int bpf_lsm_detach(struct bpf_prog *prog)
+{
+	return -EOPNOTSUPP;
+}
 
 #endif /* CONFIG_SECURITY_BPF */
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2f1e24a8c4a4..a3206de23db9 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -470,6 +470,10 @@ union bpf_attr {
 		__u32		line_info_cnt;	/* number of bpf_line_info records */
 		__u32		attach_btf_id;	/* in-kernel BTF type id to attach to */
 		__u32		attach_prog_fd; /* 0 to attach to vmlinux */
+		/* Index of the hlist_head in security_hook_heads to which the
+		 * program must be attached.
+		 */
+		__u32		lsm_hook_idx;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index eab4a36ee889..851ca97120ac 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4,6 +4,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/bpf_lirc.h>
+#include <linux/bpf_lsm.h>
 #include <linux/btf.h>
 #include <linux/syscalls.h>
 #include <linux/slab.h>
@@ -1993,7 +1994,7 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 }
 
 /* last field in 'union bpf_attr' used by this command */
-#define	BPF_PROG_LOAD_LAST_FIELD attach_prog_fd
+#define	BPF_PROG_LOAD_LAST_FIELD lsm_hook_idx
 
 static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 {
@@ -2047,6 +2048,10 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 
 	prog->expected_attach_type = attr->expected_attach_type;
 	prog->aux->attach_btf_id = attr->attach_btf_id;
+
+	if (type == BPF_PROG_TYPE_LSM)
+		prog->aux->lsm_hook_idx = attr->lsm_hook_idx;
+
 	if (attr->attach_prog_fd) {
 		struct bpf_prog *tgt_prog;
 
@@ -2213,6 +2218,44 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog)
 	return err;
 }
 
+static int bpf_lsm_prog_release(struct inode *inode, struct file *filp)
+{
+	struct bpf_prog *prog = filp->private_data;
+
+	WARN_ON_ONCE(bpf_lsm_detach(prog));
+	bpf_prog_put(prog);
+	return 0;
+}
+
+static const struct file_operations bpf_lsm_prog_fops = {
+	.release	= bpf_lsm_prog_release,
+	.read		= bpf_dummy_read,
+	.write		= bpf_dummy_write,
+};
+
+static int bpf_lsm_prog_attach(struct bpf_prog *prog)
+{
+	int ret;
+
+	if (prog->expected_attach_type != BPF_LSM_MAC)
+		return -EINVAL;
+
+	/* The attach increments the references to the program which is
+	 * decremented on detach as a part of bpf_lsm_hook_free.
+	 */
+	ret = bpf_lsm_attach(prog);
+	if (ret)
+		return ret;
+
+	ret = anon_inode_getfd("bpf-lsm-prog", &bpf_lsm_prog_fops,
+				prog, O_CLOEXEC);
+	if (ret < 0) {
+		bpf_lsm_detach(prog);
+		return ret;
+	}
+	return 0;
+}
+
 struct bpf_raw_tracepoint {
 	struct bpf_raw_event_map *btp;
 	struct bpf_prog *prog;
@@ -2431,7 +2474,7 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 		ret = lirc_prog_attach(attr, prog);
 		break;
 	case BPF_PROG_TYPE_LSM:
-		ret = -EOPNOTSUPP;
+		ret = bpf_lsm_prog_attach(prog);
 		break;
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 		ret = skb_flow_dissector_bpf_prog_attach(attr, prog);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1cc945daa9c8..1a4013c68afa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19,6 +19,7 @@
 #include <linux/sort.h>
 #include <linux/perf_event.h>
 #include <linux/ctype.h>
+#include <linux/bpf_lsm.h>
 
 #include "disasm.h"
 
@@ -6405,8 +6406,9 @@ static int check_return_code(struct bpf_verifier_env *env)
 	struct tnum range = tnum_range(0, 1);
 	int err;
 
-	/* The struct_ops func-ptr's return type could be "void" */
-	if (env->prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
+	/* LSM and struct_ops func-ptr's return type could be "void" */
+	if ((env->prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
+	     env->prog->type == BPF_PROG_TYPE_LSM) &&
 	    !prog->aux->attach_func_proto->type)
 		return 0;
 
@@ -9775,7 +9777,49 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	return 0;
 }
 
-static int check_attach_btf_id(struct bpf_verifier_env *env)
+/* BPF_PROG_TYPE_LSM programs pass the member index of the LSM hook in the
+ * security_hook_heads as the lsm_hook_idx. The verifier determines the
+ * name and the prototype for the LSM hook using the information in
+ * security_list_options and validates if the offset is a valid hlist_head.
+ */
+static inline int check_attach_btf_id_lsm(struct bpf_verifier_env *env)
+{
+	struct bpf_prog *prog = env->prog;
+	u32 idx = prog->aux->lsm_hook_idx;
+	const struct btf_member *head;
+	const struct btf_type *t;
+	const char *tname;
+	int ret;
+
+	ret = bpf_lsm_verify_prog(prog);
+	if (ret < 0)
+		return -EINVAL;
+
+	t = bpf_lsm_type_by_idx(btf_vmlinux, idx);
+	if (IS_ERR(t)) {
+		verbose(env, "unable to find security_list_option for idx %u in security_hook_heads\n", idx);
+		return -EINVAL;
+	}
+
+	if (!btf_type_is_func_proto(t))
+		return -EINVAL;
+
+	head = bpf_lsm_head_by_idx(btf_vmlinux, idx);
+	if (IS_ERR(head)) {
+		verbose(env, "no security_hook_heads index = %u\n", idx);
+		return PTR_ERR(head);
+	}
+
+	tname = btf_name_by_offset(btf_vmlinux, head->name_off);
+	if (!tname || !tname[0])
+		return -EINVAL;
+
+	prog->aux->attach_func_name = tname;
+	prog->aux->attach_func_proto = t;
+	return 0;
+}
+
+static int check_attach_btf_id_tracing(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog = env->prog;
 	bool prog_extension = prog->type == BPF_PROG_TYPE_EXT;
@@ -9791,12 +9835,6 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	long addr;
 	u64 key;
 
-	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
-		return check_struct_ops_btf_id(env);
-
-	if (prog->type != BPF_PROG_TYPE_TRACING && !prog_extension)
-		return 0;
-
 	if (!btf_id) {
 		verbose(env, "Tracing programs must provide btf_id\n");
 		return -EINVAL;
@@ -9981,6 +10019,23 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 }
 
+static int check_attach_btf_id(struct bpf_verifier_env *env)
+{
+	struct bpf_prog *prog = env->prog;
+
+	switch (prog->type) {
+	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_EXT:
+		return check_attach_btf_id_tracing(env);
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		return check_struct_ops_btf_id(env);
+	case BPF_PROG_TYPE_LSM:
+		return check_attach_btf_id_lsm(env);
+	default:
+		return 0;
+	}
+}
+
 int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 	      union bpf_attr __user *uattr)
 {
diff --git a/security/bpf/Kconfig b/security/bpf/Kconfig
index 9438d899b618..a915c549f4b8 100644
--- a/security/bpf/Kconfig
+++ b/security/bpf/Kconfig
@@ -8,6 +8,7 @@ config SECURITY_BPF
 	depends on BPF_SYSCALL
 	depends on SRCU
 	depends on DEBUG_INFO_BTF
+	depends on BPF_JIT && HAVE_EBPF_JIT
 	help
 	  This enables instrumentation of the security hooks with
 	  eBPF programs.
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index e9dc6933b6fa..f1d4fdcdb20e 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -6,11 +6,14 @@
 
 #include <linux/bpf_lsm.h>
 #include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
 #include <linux/btf.h>
 #include <linux/srcu.h>
 
 #include "bpf_lsm.h"
 
+#define SECURITY_LIST_HEAD(off) ((void *)&bpf_lsm_hook_heads + off)
+
 DEFINE_STATIC_SRCU(security_hook_srcu);
 
 int bpf_lsm_srcu_read_lock(void)
@@ -41,6 +44,27 @@ static inline int validate_hlist_head(struct btf *btf,
 	return 0;
 }
 
+int bpf_lsm_verify_prog(const struct bpf_prog *prog)
+{
+	u32 num_hooks = btf_type_vlen(bpf_lsm_info.btf_hook_heads);
+	u32 idx = prog->aux->lsm_hook_idx;
+	struct bpf_verifier_log log = {};
+
+	if (!prog->gpl_compatible) {
+		bpf_log(&log,
+			"LSM programs must have a GPL compatible license\n");
+		return -EINVAL;
+	}
+
+	if (idx >= num_hooks) {
+		bpf_log(&log, "lsm_hook_idx should be between 0 and %u\n",
+			num_hooks - 1);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* Find the BTF representation of the security_hook_heads member for a member
  * with a given index in struct security_hook_heads.
  */
@@ -93,3 +117,180 @@ const struct btf_type *bpf_lsm_type_by_idx(struct btf *btf, u32 idx)
 
 	return ERR_PTR(-ESRCH);
 }
+
+static void *bpf_lsm_get_func_addr(struct security_hook_list *s,
+				   const char *name)
+{
+	const struct btf_member *member;
+	s32 i;
+
+	for_each_member(i, bpf_lsm_info.btf_hook_types, member)
+		if (!strncmp(btf_name_by_offset(btf_vmlinux, member->name_off),
+			     name, strlen(name) + 1))
+			return (void *)&s->hook + member->offset / 8;
+
+	return ERR_PTR(-ESRCH);
+}
+
+static struct bpf_lsm_list *bpf_lsm_list_lookup(struct bpf_prog *prog)
+{
+	struct bpf_verifier_log bpf_log = {};
+	u32 idx = prog->aux->lsm_hook_idx;
+	const struct btf_member *head;
+	struct bpf_lsm_list *list;
+	int ret = 0;
+
+	list = &bpf_lsm_info.hook_lists[idx];
+
+	mutex_lock(&list->mutex);
+
+	if (list->initialized)
+		goto unlock;
+
+	list->attach_type = prog->aux->attach_func_proto;
+
+	ret = btf_distill_func_proto(&bpf_log, btf_vmlinux, list->attach_type,
+				     prog->aux->attach_func_name,
+				     &list->func_model);
+	if (ret)
+		goto unlock;
+
+	head = bpf_lsm_head_by_idx(btf_vmlinux, idx);
+	if (IS_ERR(head)) {
+		ret = PTR_ERR(head);
+		goto unlock;
+	}
+
+	list->security_list_head = SECURITY_LIST_HEAD(head->offset / 8);
+	list->initialized = true;
+unlock:
+	mutex_unlock(&list->mutex);
+	if (ret)
+		return ERR_PTR(ret);
+	return list;
+}
+
+static struct bpf_lsm_hook *bpf_lsm_hook_alloc(struct bpf_lsm_list *list,
+					       struct bpf_prog *prog)
+{
+	struct bpf_lsm_hook *hook;
+	void *image;
+	int ret = 0;
+
+	image = bpf_jit_alloc_exec(PAGE_SIZE);
+	if (!image)
+		return ERR_PTR(-ENOMEM);
+
+	set_vm_flush_reset_perms(image);
+
+	ret = arch_prepare_bpf_trampoline(image, image + PAGE_SIZE,
+		&list->func_model, 0, &prog, 1, NULL, 0, NULL);
+	if (ret < 0) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	hook = kzalloc(sizeof(struct bpf_lsm_hook), GFP_KERNEL);
+	if (!hook) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	hook->image = image;
+	hook->prog = prog;
+	bpf_prog_inc(prog);
+	return hook;
+error:
+	bpf_jit_free_exec(image);
+	return ERR_PTR(ret);
+}
+
+static void bpf_lsm_hook_free(struct bpf_lsm_hook *tr)
+{
+	if (!tr)
+		return;
+
+	if (tr->prog)
+		bpf_prog_put(tr->prog);
+
+	bpf_jit_free_exec(tr->image);
+	kfree(tr);
+}
+
+int bpf_lsm_attach(struct bpf_prog *prog)
+{
+	struct bpf_lsm_hook *hook;
+	struct bpf_lsm_list *list;
+	void **addr;
+	int ret = 0;
+
+	/* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
+	 */
+	if (!capable(CAP_MAC_ADMIN))
+		return -EPERM;
+
+	if (!bpf_lsm_info.initialized)
+		return -EBUSY;
+
+	list = bpf_lsm_list_lookup(prog);
+	if (IS_ERR(list))
+		return PTR_ERR(list);
+
+	hook = bpf_lsm_hook_alloc(list, prog);
+	if (IS_ERR(hook))
+		return PTR_ERR(hook);
+
+	hook->sec_hook.head = list->security_list_head;
+	addr = bpf_lsm_get_func_addr(&hook->sec_hook,
+				     prog->aux->attach_func_name);
+	if (IS_ERR(addr)) {
+		ret = PTR_ERR(addr);
+		goto error;
+	}
+
+	*addr = hook->image;
+
+	mutex_lock(&list->mutex);
+	hlist_add_tail_rcu(&hook->sec_hook.list, hook->sec_hook.head);
+	mutex_unlock(&list->mutex);
+	return 0;
+
+error:
+	bpf_lsm_hook_free(hook);
+	return ret;
+}
+
+int bpf_lsm_detach(struct bpf_prog *prog)
+{
+	struct security_hook_list *sec_hook;
+	struct bpf_lsm_hook *hook = NULL;
+	struct bpf_lsm_list *list;
+	struct hlist_node *n;
+
+	/* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
+	 */
+	if (!capable(CAP_MAC_ADMIN))
+		return -EPERM;
+
+	if (!bpf_lsm_info.initialized)
+		return -EBUSY;
+
+	list = &bpf_lsm_info.hook_lists[prog->aux->lsm_hook_idx];
+
+	mutex_lock(&list->mutex);
+	hlist_for_each_entry_safe(sec_hook, n, list->security_list_head, list) {
+		hook = container_of(sec_hook, struct bpf_lsm_hook, sec_hook);
+		if (hook->prog == prog) {
+			hlist_del_rcu(&hook->sec_hook.list);
+			break;
+		}
+	}
+	mutex_unlock(&list->mutex);
+	/* call_rcu is not used directly as module_memfree cannot run from an
+	 * softirq context. The best way would be to schedule this on a work
+	 * queue.
+	 */
+	synchronize_srcu(&security_hook_srcu);
+	bpf_lsm_hook_free(hook);
+	return 0;
+}
diff --git a/security/bpf/include/bpf_lsm.h b/security/bpf/include/bpf_lsm.h
index f142596d97bd..4c51ce4d29e7 100644
--- a/security/bpf/include/bpf_lsm.h
+++ b/security/bpf/include/bpf_lsm.h
@@ -4,9 +4,50 @@
 #define _BPF_LSM_H
 
 #include <linux/filter.h>
+#include <linux/lsm_hooks.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
 
+struct bpf_lsm_hook {
+	/* The security_hook_list is initialized dynamically. These are
+	 * initialized in static LSMs by LSM_HOOK_INIT.
+	 */
+	struct security_hook_list sec_hook;
+	/* The BPF program for which this hook was allocated, this is used upon
+	 * detachment to find the hook corresponding to a program.
+	 */
+	struct bpf_prog *prog;
+	/* The address of the allocated function */
+	void *image;
+};
+
+/* The list represents the list of hooks attached to a particular
+ * security_list_head and contains information required for attaching and
+ * detaching BPF Programs.
+ */
+struct bpf_lsm_list {
+	/* Used on the first attached BPF program to populate the remaining
+	 * information
+	 */
+	bool initialized;
+	/* This mutex is used to serialize accesses to all the fields in
+	 * this structure.
+	 */
+	struct mutex mutex;
+	/* The BTF type for this hook.
+	 */
+	const struct btf_type *attach_type;
+	/* func_model for the setup of the callback.
+	 */
+	struct btf_func_model func_model;
+	/* The list of functions currently associated with the LSM hook.
+	 */
+	struct list_head callback_list;
+	/* The head to which the allocated hooks must be attached to.
+	 */
+	struct hlist_head *security_list_head;
+};
+
 struct bpf_lsm_info {
 	/* BTF type for security_hook_heads populated at init.
 	 */
@@ -14,6 +55,14 @@ struct bpf_lsm_info {
 	/* BTF type for security_list_options populated at init.
 	 */
 	const struct btf_type *btf_hook_types;
+	/* Dynamic Hooks can only be attached after the LSM is initialized.
+	 */
+	bool initialized;
+	/* The hook_lists is allocated during __init and mutexes for each
+	 * bpf_lsm_list are initialized on __init, the remaining initialization
+	 * happens when a BPF program is attached to the list.
+	 */
+	struct bpf_lsm_list *hook_lists;
 };
 
 extern struct bpf_lsm_info bpf_lsm_info;
diff --git a/security/bpf/lsm.c b/security/bpf/lsm.c
index 736e0ee3f926..8555879af8c8 100644
--- a/security/bpf/lsm.c
+++ b/security/bpf/lsm.c
@@ -26,6 +26,8 @@ struct bpf_lsm_info bpf_lsm_info;
 static __init int bpf_lsm_info_init(void)
 {
 	const struct btf_type *t;
+	u32 num_hooks;
+	int i;
 
 	if (!btf_vmlinux)
 		/* No need to grab any locks because we are still in init */
@@ -42,6 +44,7 @@ static __init int bpf_lsm_info_init(void)
 		return PTR_ERR(t);
 
 	bpf_lsm_info.btf_hook_heads = t;
+	num_hooks = btf_type_vlen(t);
 
 	t = btf_type_by_name_kind(btf_vmlinux, "security_list_options",
 				  BTF_KIND_UNION);
@@ -49,6 +52,22 @@ static __init int bpf_lsm_info_init(void)
 		return PTR_ERR(t);
 
 	bpf_lsm_info.btf_hook_types = t;
+
+	bpf_lsm_info.hook_lists = kcalloc(num_hooks,
+					  sizeof(struct bpf_lsm_list),
+					  GFP_KERNEL);
+	if (!bpf_lsm_info.hook_lists)
+		return -ENOMEM;
+
+	/* The mutex needs to be initialized at init as it must be held
+	 * when mutating the list. The rest of the information in the list
+	 * is populated lazily when the first LSM hook callback is appeneded
+	 * to the list.
+	 */
+	for (i = 0; i < num_hooks; i++)
+		mutex_init(&bpf_lsm_info.hook_lists[i].mutex);
+
+	bpf_lsm_info.initialized = true;
 	return 0;
 }
 
diff --git a/security/bpf/ops.c b/security/bpf/ops.c
index 81c2bd9c0495..9a26633ac6f3 100644
--- a/security/bpf/ops.c
+++ b/security/bpf/ops.c
@@ -6,6 +6,7 @@
 
 #include <linux/filter.h>
 #include <linux/bpf.h>
+#include <linux/btf.h>
 
 const struct bpf_prog_ops lsm_prog_ops = {
 };
@@ -25,4 +26,5 @@ static const struct bpf_func_proto *get_bpf_func_proto(
 
 const struct bpf_verifier_ops lsm_verifier_ops = {
 	.get_func_proto = get_bpf_func_proto,
+	.is_valid_access = btf_ctx_access,
 };
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2f1e24a8c4a4..a3206de23db9 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -470,6 +470,10 @@ union bpf_attr {
 		__u32		line_info_cnt;	/* number of bpf_line_info records */
 		__u32		attach_btf_id;	/* in-kernel BTF type id to attach to */
 		__u32		attach_prog_fd; /* 0 to attach to vmlinux */
+		/* Index of the hlist_head in security_hook_heads to which the
+		 * program must be attached.
+		 */
+		__u32		lsm_hook_idx;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
-- 
2.20.1

