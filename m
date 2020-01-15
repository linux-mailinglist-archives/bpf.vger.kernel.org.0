Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1691613CAA1
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 18:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgAORNv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 12:13:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38029 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbgAORNa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jan 2020 12:13:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so16541430wrh.5
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2020 09:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TKI5amT2na9Il6KONhJbeMpaYalV+M2OyoEG7nNgKVk=;
        b=UAqE1k/Bumb0lpHC6d/UGds9by6q1/Uq3m8yWT2DkVDlQTsJ1WCz8nfyLXOMYspxWY
         dDpKtm7YafGL/hwkj594NtcbnG0L4KwY1hWk6lsmmjaaUap2q/Ar75AAC7vMdohl3ysg
         4ZVg/YccybcKfCSyajMG8GI4/g9IIfwZdi2Wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKI5amT2na9Il6KONhJbeMpaYalV+M2OyoEG7nNgKVk=;
        b=E1PDYq0ejZRgXUjYWVKkxoO07+b7v91rpS12HH3ro/A+lewI3W+tSQIdH6noJ3dd44
         OOsG25vXi2BQFt2+Z/LQZu1BdNMvkjvLmPVWtEbh7lOhdlThqOqt8+ebmiM+3x92z3SD
         2YXEWu3OjOtMvN7OcC57QyxpWY3Fw7CgbxCIclNMW7DIeBqQfuy3VjOFAV4rCRp6fpe+
         6OIVdDlOKwu0rP0okD8sX1XRiDTSDubJHmiO3k/LG1/8210xDJwUlE61zVICazvoeZ3E
         hxNC0lBgSxp8jA01enDK52ODA0TgiHJ9v1qM91crzNlkGp8xvO8x5+rZh4m2ocuA/wYD
         w5FA==
X-Gm-Message-State: APjAAAVA/sdkWBQZscPinCCinCdiKDiktMcn1f5ybZYwVne1STEjA4gp
        9nTgxQQV6j8TsDM1ybOnsAVuxw==
X-Google-Smtp-Source: APXvYqwhCLwnUOFpVlhM9nzQ0g74CrDkSrQ2pmzYatqz9AK9bnwO108JmkCxA1m2IVOaOlLngh1QXQ==
X-Received: by 2002:a5d:6652:: with SMTP id f18mr15639432wrw.246.1579108407570;
        Wed, 15 Jan 2020 09:13:27 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:84f3:4331:4ae9:c5f1])
        by smtp.gmail.com with ESMTPSA id d16sm26943227wrg.27.2020.01.15.09.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 09:13:27 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v2 06/10] bpf: lsm: Implement attach, detach and execution
Date:   Wed, 15 Jan 2020 18:13:29 +0100
Message-Id: <20200115171333.28811-7-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200115171333.28811-1-kpsingh@chromium.org>
References: <20200115171333.28811-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

JITed BPF programs are used by the BPF LSM as dynamically allocated
security hooks. arch_bpf_prepare_trampoline handles the
arch_bpf_prepare_trampoline generates code to handle conversion of the
signature of the hook to the BPF context and allows the BPF program to
be called directly as a C function.

The following permissions are required to attach a program to a hook:

- CAP_SYS_ADMIN to load the program
- CAP_MAC_ADMIN to attach it (i.e. to update the security policy)

When the program is loaded (BPF_PROG_LOAD), the verifier receives the
index (one-based) of the member in the security_hook_heads struct in the
prog->aux->lsm_hook_index and uses the BTF API provided by the LSM to:

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
---
 include/linux/bpf.h            |   4 +
 include/linux/bpf_lsm.h        |  15 +++
 include/uapi/linux/bpf.h       |   4 +
 kernel/bpf/syscall.c           |  47 ++++++-
 kernel/bpf/verifier.c          |  74 +++++++++--
 security/bpf/Kconfig           |   1 +
 security/bpf/Makefile          |   2 +
 security/bpf/hooks.c           | 230 +++++++++++++++++++++++++++++++--
 security/bpf/include/bpf_lsm.h |  75 +++++++++++
 security/bpf/lsm.c             |  60 +++++++++
 security/bpf/ops.c             |   2 +
 tools/include/uapi/linux/bpf.h |   4 +
 12 files changed, 494 insertions(+), 24 deletions(-)
 create mode 100644 security/bpf/include/bpf_lsm.h

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index aed2bc39d72b..5ed4780c2091 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -599,6 +599,10 @@ struct bpf_prog_aux {
 	u32 func_cnt; /* used by non-func prog as the number of func progs */
 	u32 func_idx; /* 0 for non-func prog, the index in func array for func prog */
 	u32 attach_btf_id; /* in-kernel BTF type id to attach to */
+	/* Index (one-based) of the hlist_head in security_hook_heads to which
+	 * the program must be attached.
+	 */
+	u32 lsm_hook_index;
 	struct bpf_prog *linked_prog;
 	bool verifier_zext; /* Zero extensions has been inserted by verifier. */
 	bool offload_requested;
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index a9b4f7b41c65..8c86672437f0 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -19,8 +19,11 @@ extern struct security_hook_heads bpf_lsm_hook_heads;
 
 int bpf_lsm_srcu_read_lock(void);
 void bpf_lsm_srcu_read_unlock(int idx);
+int bpf_lsm_verify_prog(const struct bpf_prog *prog);
 const struct btf_type *bpf_lsm_type_by_index(struct btf *btf, u32 offset);
 const struct btf_member *bpf_lsm_head_by_index(struct btf *btf, u32 id);
+int bpf_lsm_attach(struct bpf_prog *prog);
+int bpf_lsm_detach(struct bpf_prog *prog);
 
 #define CALL_BPF_LSM_VOID_HOOKS(FUNC, ...)			\
 	do {							\
@@ -67,6 +70,10 @@ static inline int bpf_lsm_srcu_read_lock(void)
 	return 0;
 }
 static inline void bpf_lsm_srcu_read_unlock(int idx) {}
+static inline int bpf_lsm_verify_prog(const struct bpf_prog *prog)
+{
+	return -EOPNOTSUPP;
+}
 static inline const struct btf_type *bpf_lsm_type_by_index(
 	struct btf *btf, u32 index)
 {
@@ -77,6 +84,14 @@ static inline const struct btf_member *bpf_lsm_head_by_index(
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
index b6a725a8a21d..fa5513cb3332 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -448,6 +448,10 @@ union bpf_attr {
 		__u32		line_info_cnt;	/* number of bpf_line_info records */
 		__u32		attach_btf_id;	/* in-kernel BTF type id to attach to */
 		__u32		attach_prog_fd; /* 0 to attach to vmlinux */
+		/* Index (one-based) of the hlist_head in security_hook_heads to
+		 * which the program must be attached.
+		 */
+		__u32		lsm_hook_index;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2945739618c9..a54eb1032fdd 100644
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
@@ -1751,7 +1752,7 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 }
 
 /* last field in 'union bpf_attr' used by this command */
-#define	BPF_PROG_LOAD_LAST_FIELD attach_prog_fd
+#define	BPF_PROG_LOAD_LAST_FIELD lsm_hook_index
 
 static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 {
@@ -1805,6 +1806,10 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 
 	prog->expected_attach_type = attr->expected_attach_type;
 	prog->aux->attach_btf_id = attr->attach_btf_id;
+
+	if (type == BPF_PROG_TYPE_LSM)
+		prog->aux->lsm_hook_index = attr->lsm_hook_index;
+
 	if (attr->attach_prog_fd) {
 		struct bpf_prog *tgt_prog;
 
@@ -1970,6 +1975,44 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog)
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
@@ -2186,7 +2229,7 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 		ret = lirc_prog_attach(attr, prog);
 		break;
 	case BPF_PROG_TYPE_LSM:
-		ret = -EINVAL;
+		ret = bpf_lsm_prog_attach(prog);
 		break;
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 		ret = skb_flow_dissector_bpf_prog_attach(attr, prog);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ca17dccc17ba..10f44c3b15ec 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19,6 +19,7 @@
 #include <linux/sort.h>
 #include <linux/perf_event.h>
 #include <linux/ctype.h>
+#include <linux/bpf_lsm.h>
 
 #include "disasm.h"
 
@@ -6393,8 +6394,9 @@ static int check_return_code(struct bpf_verifier_env *env)
 	struct tnum range = tnum_range(0, 1);
 	int err;
 
-	/* The struct_ops func-ptr's return type could be "void" */
-	if (env->prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
+	/* LSM and struct_ops func-ptr's return type could be "void" */
+	if ((env->prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
+	     env->prog->type == BPF_PROG_TYPE_LSM) &&
 	    !prog->aux->attach_func_proto->type)
 		return 0;
 
@@ -9734,7 +9736,51 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	return 0;
 }
 
-static int check_attach_btf_id(struct bpf_verifier_env *env)
+/* BPF_PROG_TYPE_LSM programs pass the member index of the LSM hook in the
+ * security_hook_heads as the lsm_hook_index. The verifier determines the
+ * name and the prototype for the LSM hook using the information in
+ * security_list_options, validates if the offset is a valid hlist_head, and
+ * updates the attach_btf_id to the byte offset in the security_hook_heads
+ * struct.
+ */
+static inline int check_attach_btf_id_lsm(struct bpf_verifier_env *env)
+{
+	struct bpf_prog *prog = env->prog;
+	u32 index = prog->aux->lsm_hook_index;
+	const struct btf_member *head;
+	const struct btf_type *t;
+	const char *tname;
+	int ret;
+
+	ret = bpf_lsm_verify_prog(prog);
+	if (ret < 0)
+		return -EINVAL;
+
+	t = bpf_lsm_type_by_index(btf_vmlinux, index);
+	if (!t) {
+		verbose(env, "unable to find security_list_option for index %u in security_hook_heads\n", index);
+		return -EINVAL;
+	}
+
+	if (!btf_type_is_func_proto(t))
+		return -EINVAL;
+
+	head = bpf_lsm_head_by_index(btf_vmlinux, index);
+	if (IS_ERR(head)) {
+		verbose(env, "no security_hook_heads index = %u\n", index);
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
 	struct bpf_prog *tgt_prog = prog->aux->linked_prog;
@@ -9749,12 +9795,6 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	long addr;
 	u64 key;
 
-	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
-		return check_struct_ops_btf_id(env);
-
-	if (prog->type != BPF_PROG_TYPE_TRACING)
-		return 0;
-
 	if (!btf_id) {
 		verbose(env, "Tracing programs must provide btf_id\n");
 		return -EINVAL;
@@ -9895,6 +9935,22 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 }
 
+static int check_attach_btf_id(struct bpf_verifier_env *env)
+{
+	struct bpf_prog *prog = env->prog;
+
+	switch (prog->type) {
+	case BPF_PROG_TYPE_TRACING:
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
diff --git a/security/bpf/Makefile b/security/bpf/Makefile
index c526927c337d..748b9b7d4bc7 100644
--- a/security/bpf/Makefile
+++ b/security/bpf/Makefile
@@ -3,3 +3,5 @@
 # Copyright 2019 Google LLC.
 
 obj-$(CONFIG_SECURITY_BPF) := lsm.o ops.o hooks.o
+
+ccflags-y := -I$(srctree)/security/bpf -I$(srctree)/security/bpf/include
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 82725611693d..4e71da0e8e9e 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -6,9 +6,14 @@
 
 #include <linux/bpf_lsm.h>
 #include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
 #include <linux/btf.h>
 #include <linux/srcu.h>
 
+#include "bpf_lsm.h"
+
+#define SECURITY_LIST_HEAD(off) ((void *)&bpf_lsm_hook_heads + off)
+
 DEFINE_STATIC_SRCU(security_hook_srcu);
 
 int bpf_lsm_srcu_read_lock(void)
@@ -32,21 +37,36 @@ static inline int validate_hlist_head(struct btf *btf, u32 type_id)
 	return 0;
 }
 
+int bpf_lsm_verify_prog(const struct bpf_prog *prog)
+{
+	u32 index = prog->aux->lsm_hook_index;
+	struct bpf_verifier_log log = {};
+
+	if (!prog->gpl_compatible) {
+		bpf_log(&log,
+			"LSM programs must have a GPL compatible license\n");
+		return -EINVAL;
+	}
+
+	if (index < 1 || index > bpf_lsm_info.num_hooks) {
+		bpf_log(&log, "lsm_hook_index should be between 1 and %lu\n",
+			bpf_lsm_info.num_hooks);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* Find the BTF representation of the security_hook_heads member for a member
  * with a given index in struct security_hook_heads.
  */
 const struct btf_member *bpf_lsm_head_by_index(struct btf *btf, u32 index)
 {
 	const struct btf_member *member;
-	const struct btf_type *t;
 	u32 off, i;
 	int ret;
 
-	t = btf_type_by_name_kind(btf, "security_hook_heads", BTF_KIND_STRUCT);
-	if (WARN_ON_ONCE(IS_ERR(t)))
-		return ERR_CAST(t);
-
-	for_each_member(i, t, member) {
+	for_each_member(i, bpf_lsm_info.btf_hook_heads, member) {
 		/* We've found the id requested and need to check the
 		 * the following:
 		 *
@@ -54,8 +74,9 @@ const struct btf_member *bpf_lsm_head_by_index(struct btf *btf, u32 index)
 		 *
 		 * - Is it a valid hlist_head struct?
 		 */
-		if (index == i) {
-			off = btf_member_bit_offset(t, member);
+		if (index == i + 1) {
+			off = btf_member_bit_offset(
+				bpf_lsm_info.btf_hook_heads, member);
 			if (off % 8)
 				/* valid c code cannot generate such btf */
 				return ERR_PTR(-EINVAL);
@@ -90,11 +111,7 @@ const struct btf_type *bpf_lsm_type_by_index(struct btf *btf, u32 index)
 	if (IS_ERR(hook_head))
 		return ERR_PTR(PTR_ERR(hook_head));
 
-	t = btf_type_by_name_kind(btf, "security_list_options", BTF_KIND_UNION);
-	if (WARN_ON_ONCE(IS_ERR(t)))
-		return ERR_CAST(t);
-
-	for_each_member(i, t, member) {
+	for_each_member(i, bpf_lsm_info.btf_hook_types, member) {
 		if (hook_head->name_off == member->name_off) {
 			/* There should be only one member with the same name
 			 * as the LSM hook. This should never really happen
@@ -122,3 +139,190 @@ const struct btf_type *bpf_lsm_type_by_index(struct btf *btf, u32 index)
 
 	return t;
 }
+
+static void *bpf_lsm_get_func_addr(struct security_hook_list *s,
+				   const char *name)
+{
+	const struct btf_member *member;
+	void *addr = NULL;
+	s32 i;
+
+	for_each_member(i, bpf_lsm_info.btf_hook_types, member) {
+		if (!strncmp(btf_name_by_offset(btf_vmlinux, member->name_off),
+				name, strlen(name) + 1)) {
+			/* There should be only one member with the same name
+			 * as the LSM hook.
+			 */
+			if (WARN_ON(addr))
+				return ERR_PTR(-EINVAL);
+			addr = (void *)&s->hook + member->offset / 8;
+		}
+	}
+
+	if (!addr)
+		return ERR_PTR(-ENOENT);
+	return addr;
+}
+
+static struct bpf_lsm_list *bpf_lsm_list_lookup(struct bpf_prog *prog)
+{
+	u32 index = prog->aux->lsm_hook_index;
+	struct bpf_verifier_log bpf_log = {};
+	const struct btf_member *head;
+	struct bpf_lsm_list *list;
+	int ret = 0;
+
+	list = &bpf_lsm_info.hook_lists[index - 1];
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
+	head = bpf_lsm_head_by_index(btf_vmlinux, index);
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
+static struct bpf_lsm_hook *bpf_lsm_hook_alloc(
+	struct bpf_lsm_list *list, struct bpf_prog *prog)
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
+	list = &bpf_lsm_info.hook_lists[prog->aux->lsm_hook_index - 1];
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
new file mode 100644
index 000000000000..849f7f64d7f2
--- /dev/null
+++ b/security/bpf/include/bpf_lsm.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _BPF_LSM_H
+#define _BPF_LSM_H
+
+#include <linux/filter.h>
+#include <linux/lsm_hooks.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+
+
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
+struct bpf_lsm_info {
+	/* Dynamic Hooks can only be attached after the LSM is initialized.
+	 */
+	bool initialized;
+	/* The number of hooks is calculated at runtime using the BTF
+	 * information of the struct security_hook_heads.
+	 */
+	size_t num_hooks;
+	/* The hook_lists is allocated during __init and mutexes for each
+	 * allocated on __init, the remaining initialization happens when a
+	 * BPF program is attached to the list.
+	 */
+	struct bpf_lsm_list *hook_lists;
+	/* BTF type for security_hook_heads populated at init.
+	 */
+	const struct btf_type *btf_hook_heads;
+	/* BTF type for security_list_options populated at init.
+	 */
+	const struct btf_type *btf_hook_types;
+};
+
+extern struct bpf_lsm_info bpf_lsm_info;
+
+#endif /* _BPF_LSM_H */
diff --git a/security/bpf/lsm.c b/security/bpf/lsm.c
index d4ea6aa9ddb8..3bab187e7574 100644
--- a/security/bpf/lsm.c
+++ b/security/bpf/lsm.c
@@ -7,6 +7,8 @@
 #include <linux/bpf_lsm.h>
 #include <linux/lsm_hooks.h>
 
+#include "bpf_lsm.h"
+
 /* This is only for internal hooks, always statically shipped as part of the
  * BPF LSM. Statically defined hooks are appended to the security_hook_heads
  * which is common for LSMs and R/O after init.
@@ -19,6 +21,64 @@ static struct security_hook_list lsm_hooks[] __lsm_ro_after_init = {};
  */
 struct security_hook_heads bpf_lsm_hook_heads;
 
+/* Security hooks registered dynamically by the BPF LSM and must be accessed
+ * by holding bpf_lsm_srcu_read_lock and bpf_lsm_srcu_read_unlock.
+ */
+struct bpf_lsm_info bpf_lsm_info;
+
+static __init int init_lsm_info(void)
+{
+	const struct btf_type *t;
+	size_t num_hooks;
+	int i;
+
+	if (!btf_vmlinux)
+		/* No need to grab any locks because we are still in init */
+		btf_vmlinux = btf_parse_vmlinux();
+
+	if (IS_ERR(btf_vmlinux)) {
+		pr_err("btf_vmlinux is malformed\n");
+		return PTR_ERR(btf_vmlinux);
+	}
+
+	t = btf_type_by_name_kind(btf_vmlinux, "security_hook_heads",
+				  BTF_KIND_STRUCT);
+	if (WARN_ON(IS_ERR(t)))
+		return PTR_ERR(t);
+
+	num_hooks = btf_type_vlen(t);
+	if (num_hooks <= 0)
+		return -EINVAL;
+
+	bpf_lsm_info.num_hooks = num_hooks;
+	bpf_lsm_info.btf_hook_heads = t;
+
+	t = btf_type_by_name_kind(btf_vmlinux, "security_list_options",
+				  BTF_KIND_UNION);
+	if (WARN_ON(IS_ERR(t)))
+		return PTR_ERR(t);
+
+	bpf_lsm_info.btf_hook_types = t;
+
+	bpf_lsm_info.hook_lists = kcalloc(num_hooks,
+		sizeof(struct bpf_lsm_list), GFP_KERNEL);
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
+	return 0;
+}
+
+late_initcall(init_lsm_info);
+
 static int __init lsm_init(void)
 {
 	security_add_hooks(lsm_hooks, ARRAY_SIZE(lsm_hooks), "bpf");
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
index b6a725a8a21d..fa5513cb3332 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -448,6 +448,10 @@ union bpf_attr {
 		__u32		line_info_cnt;	/* number of bpf_line_info records */
 		__u32		attach_btf_id;	/* in-kernel BTF type id to attach to */
 		__u32		attach_prog_fd; /* 0 to attach to vmlinux */
+		/* Index (one-based) of the hlist_head in security_hook_heads to
+		 * which the program must be attached.
+		 */
+		__u32		lsm_hook_index;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
-- 
2.20.1

