Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60C88166571
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2020 18:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgBTRx1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Feb 2020 12:53:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53653 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgBTRxC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Feb 2020 12:53:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id s10so2977917wmh.3
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2020 09:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iSMj63gTFkl6QNNUKNg/Zkq8prJATW6HCmVIlhHEtWU=;
        b=SCS879P9XqLTwgYYr1ehUQ/eEazVWHreNLobsXZXHnNAzrRMWo+sqDmz+RVEqf3a6A
         hbbD/VTXHadWdD/BZhTMv5nwF1d3nMMb43KiuFCt3mhj5Zgf1+MD4sJmTMrCKSXrezup
         d1J4bOqnoM0ObzdMyRQ3tZOtYhUevSNqSlS2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iSMj63gTFkl6QNNUKNg/Zkq8prJATW6HCmVIlhHEtWU=;
        b=q/Z3nltqvBt+28mbeWVtQfImra96R2EumKoj2bWWDd6U7V/tv+shHUhpqC9rWm2h6j
         QqCRKCT3XhUglFhz6u4KND0fqsLo526byssBz+lJoNZ5yQufPYLlLtxyZhDNaNDxfrvT
         QQAYXqZ3IAD3LH4tL46qp999Dsx3bnjAV6xnPFfOJLHAq45cTLHEZeWZTbMejjbzhe43
         zwj0TTc9FhFGAY0GRGbuorzZsRNdlI0v7jdzp/eHdHLeccVIi5+In/w7ZB01bMEab65Y
         5i84f4UQ/Twjpo0nVcqrhKxvKVqghunVtk3KNwjaXO6r1T6CAWInzQkjXmVorVwDXlQU
         n0qQ==
X-Gm-Message-State: APjAAAUlkEe45qiaMJeW/+HHN15/paHJTZxegWEksz+voGKQyMFa0fzr
        00VUe7i+4gYZGOjnLHEFZ+7A3u2OSWo=
X-Google-Smtp-Source: APXvYqwYlSbh3EOXeSBEYq7z7yXrer2jfVkbMaDTXKHJFsAUdGLLHCHuPj/2odunhoh5W/PfHu09DQ==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr5655980wmb.0.1582221179939;
        Thu, 20 Feb 2020 09:52:59 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:d960:542a:a1d:648a])
        by smtp.gmail.com with ESMTPSA id r5sm363059wrt.43.2020.02.20.09.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:52:59 -0800 (PST)
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
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v4 5/8] bpf: lsm: Implement attach, detach and execution
Date:   Thu, 20 Feb 2020 18:52:47 +0100
Message-Id: <20200220175250.10795-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220175250.10795-1-kpsingh@chromium.org>
References: <20200220175250.10795-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

JITed BPF programs are dynamically attached to the LSM hooks
using fexit trampolines. The trampoline prologue generates code to handle
conversion of the signature of the hook to the BPF context and the newly
introduced BPF_TRAMP_F_OVERRIDE_RETURN allows the fexit trampoline
to override the return value of the function it is attached to.

The allocated fexit trampolines are attached to the nop function added
at the appropriate places and are executed if all the statically defined
LSM hooks allow the action.

The BPF_PROG_TYPE_LSM programs must have a GPL compatible license and
the following permissions are required to attach a program to a
hook:

- CAP_SYS_ADMIN to load the program
- CAP_MAC_ADMIN to attach it (i.e. to update the security policy)

When the program is loaded (BPF_PROG_LOAD):

* The verifier validates if the program is trying to attach to a valid
  security hook and updates the prog->aux->attach_func_proto.
* The verifier then further verifies the program for memory accesses by
  using the BTF information. (It also ensures that no memory is being
  written to).
* An fexit trampoline is initialized (if not present in the lookup
  table).

When an attachment (BPF_PROG_ATTACH) is requested:

* The fexit trampoline is updated to use the program being attached.
* The static key of the LSM hook is toggled if this is the first program
  being attached to this hook. (and not a replacement).

The attached programs can override the return value of the fexit
trampoline to indicate a MAC Policy decision.

When multiple programs aree attached to the hook, each program receives
the return value from the previous program on the stack and the last
program provides the return value to the LSM hook.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 arch/x86/net/bpf_jit_comp.c | 21 +++++++++++++----
 include/linux/bpf.h         |  4 ++++
 include/linux/bpf_lsm.h     |  8 +++++++
 kernel/bpf/bpf_lsm.c        | 27 +++++++++++++++++++++
 kernel/bpf/btf.c            |  3 ++-
 kernel/bpf/syscall.c        | 47 ++++++++++++++++++++++++++++++-------
 kernel/bpf/trampoline.c     | 24 +++++++++++++++----
 kernel/bpf/verifier.c       | 19 +++++++++++----
 8 files changed, 131 insertions(+), 22 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9ba08e9abc09..b710abfe06c4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1362,7 +1362,8 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
 }
 
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
-		      struct bpf_prog **progs, int prog_cnt, int stack_size)
+		      struct bpf_prog **progs, int prog_cnt, int stack_size,
+		      bool override_return)
 {
 	u8 *prog = *pprog;
 	int cnt = 0, i;
@@ -1384,6 +1385,14 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 		if (emit_call(&prog, progs[i]->bpf_func, prog))
 			return -EINVAL;
 
+
+		/* If BPF_TRAMP_F_OVERRIDE_RETURN is set, fexit trampolines can
+		 * override the return value of the previous trampoline which is
+		 * then passed on the stack to the next BPF program.
+		 */
+		if (override_return)
+			emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
+
 		/* arg1: mov rdi, progs[i] */
 		emit_mov_imm64(&prog, BPF_REG_1, (long) progs[i] >> 32,
 			       (u32) (long) progs[i]);
@@ -1462,6 +1471,7 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 				struct bpf_prog **fexit_progs, int fexit_cnt,
 				void *orig_call)
 {
+	bool override_return = flags & BPF_TRAMP_F_OVERRIDE_RETURN;
 	int cnt = 0, nr_args = m->nr_args;
 	int stack_size = nr_args * 8;
 	u8 *prog;
@@ -1493,7 +1503,8 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 	save_regs(m, &prog, nr_args, stack_size);
 
 	if (fentry_cnt)
-		if (invoke_bpf(m, &prog, fentry_progs, fentry_cnt, stack_size))
+		if (invoke_bpf(m, &prog, fentry_progs, fentry_cnt, stack_size,
+			       false))
 			return -EINVAL;
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
@@ -1503,18 +1514,20 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 		/* call original function */
 		if (emit_call(&prog, orig_call, prog))
 			return -EINVAL;
+
 		/* remember return value in a stack for bpf prog to access */
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 	}
 
 	if (fexit_cnt)
-		if (invoke_bpf(m, &prog, fexit_progs, fexit_cnt, stack_size))
+		if (invoke_bpf(m, &prog, fexit_progs, fexit_cnt, stack_size,
+			       override_return))
 			return -EINVAL;
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
 		restore_regs(m, &prog, nr_args, stack_size);
 
-	if (flags & BPF_TRAMP_F_CALL_ORIG)
+	if (flags & BPF_TRAMP_F_CALL_ORIG && !override_return)
 		/* restore original return value back into RAX */
 		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c647cef3f4c1..e63caadbaef3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -432,6 +432,10 @@ struct btf_func_model {
  * programs only. Should not be used with normal calls and indirect calls.
  */
 #define BPF_TRAMP_F_SKIP_FRAME		BIT(2)
+/* Override the return value of the original function. This flag only makes
+ * sense for fexit trampolines.
+ */
+#define BPF_TRAMP_F_OVERRIDE_RETURN     BIT(3)
 
 /* Different use cases for BPF trampoline:
  * 1. replace nop at the function entry (kprobe equivalent)
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 53dcda8ace01..8f114affe5c6 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -41,6 +41,8 @@ void bpf_lsm_##NAME##_set_enabled(bool value);
 })
 
 int bpf_lsm_set_enabled(const char *name, bool value);
+int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
+			const struct bpf_prog *prog);
 
 #else /* !CONFIG_BPF_LSM */
 
@@ -53,6 +55,12 @@ static inline int bpf_lsm_set_enabled(const char *name, bool value)
 	return -EOPNOTSUPP;
 }
 
+static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
+				      const struct bpf_prog *prog)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index d7c44433c003..edeb4ded1d3e 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -10,6 +10,7 @@
 #include <linux/bpf_lsm.h>
 #include <linux/jump_label.h>
 #include <linux/kallsyms.h>
+#include <linux/bpf_verifier.h>
 
 #define LSM_HOOK(RET, NAME, ...)					\
 	DEFINE_STATIC_KEY_FALSE(bpf_lsm_key_##NAME);			\
@@ -52,6 +53,32 @@ int bpf_lsm_set_enabled(const char *name, bool value)
 	return 0;
 }
 
+#define BPF_LSM_SYM_PREFX  "bpf_lsm_"
+
+int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
+			const struct bpf_prog *prog)
+{
+	/* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
+	 */
+	if (!capable(CAP_MAC_ADMIN))
+		return -EPERM;
+
+	if (!prog->gpl_compatible) {
+		bpf_log(vlog,
+			"LSM programs must have a GPL compatible license\n");
+		return -EINVAL;
+	}
+
+	if (strncmp(BPF_LSM_SYM_PREFX, prog->aux->attach_func_name,
+		    strlen(BPF_LSM_SYM_PREFX))) {
+		bpf_log(vlog, "attach_btf_id %u points to wrong type name %s\n",
+			prog->aux->attach_btf_id, prog->aux->attach_func_name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 const struct bpf_prog_ops lsm_prog_ops = {
 };
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 805c43b083e9..0e4cad3c810b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3710,7 +3710,8 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		nr_args--;
 	}
 
-	if (prog->expected_attach_type == BPF_TRACE_FEXIT &&
+	if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
+	     prog->expected_attach_type == BPF_LSM_MAC) &&
 	    arg == nr_args) {
 		if (!t)
 			/* Default prog with 5 args. 6th arg is retval. */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a91ad518c050..e10e216463ad 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -25,6 +25,7 @@
 #include <linux/nospec.h>
 #include <linux/audit.h>
 #include <uapi/linux/btf.h>
+#include <linux/bpf_lsm.h>
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
@@ -1931,6 +1932,7 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 
 		switch (prog_type) {
 		case BPF_PROG_TYPE_TRACING:
+		case BPF_PROG_TYPE_LSM:
 		case BPF_PROG_TYPE_STRUCT_OPS:
 		case BPF_PROG_TYPE_EXT:
 			break;
@@ -2169,28 +2171,53 @@ static int bpf_obj_get(const union bpf_attr *attr)
 				attr->file_flags);
 }
 
-static int bpf_tracing_prog_release(struct inode *inode, struct file *filp)
+static int bpf_tramp_prog_release(struct inode *inode, struct file *filp)
 {
 	struct bpf_prog *prog = filp->private_data;
 
+	/* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
+	 */
+	if (prog->type == BPF_PROG_TYPE_LSM && !capable(CAP_MAC_ADMIN))
+		return -EPERM;
+
 	WARN_ON_ONCE(bpf_trampoline_unlink_prog(prog));
 	bpf_prog_put(prog);
 	return 0;
 }
 
-static const struct file_operations bpf_tracing_prog_fops = {
-	.release	= bpf_tracing_prog_release,
+static const struct file_operations bpf_tramp_prog_fops = {
+	.release	= bpf_tramp_prog_release,
 	.read		= bpf_dummy_read,
 	.write		= bpf_dummy_write,
 };
 
-static int bpf_tracing_prog_attach(struct bpf_prog *prog)
+static int bpf_tramp_prog_attach(struct bpf_prog *prog)
 {
 	int tr_fd, err;
 
-	if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
-	    prog->expected_attach_type != BPF_TRACE_FEXIT &&
-	    prog->type != BPF_PROG_TYPE_EXT) {
+	switch (prog->type) {
+	case BPF_PROG_TYPE_TRACING:
+		if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
+		    prog->expected_attach_type != BPF_TRACE_FEXIT &&
+		    prog->type != BPF_PROG_TYPE_EXT) {
+			err = -EINVAL;
+			goto out_put_prog;
+		}
+		break;
+	case BPF_PROG_TYPE_LSM:
+		if (prog->expected_attach_type != BPF_LSM_MAC) {
+			err = -EINVAL;
+			goto out_put_prog;
+		}
+		/* Only CAP_MAC_ADMIN users are allowed to make changes to LSM
+		 * hooks.
+		 */
+		if (!capable(CAP_MAC_ADMIN)) {
+			err = -EPERM;
+			goto out_put_prog;
+		}
+		break;
+	default:
 		err = -EINVAL;
 		goto out_put_prog;
 	}
@@ -2199,7 +2226,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog)
 	if (err)
 		goto out_put_prog;
 
-	tr_fd = anon_inode_getfd("bpf-tracing-prog", &bpf_tracing_prog_fops,
+	tr_fd = anon_inode_getfd("bpf-tramp-prog", &bpf_tramp_prog_fops,
 				 prog, O_CLOEXEC);
 	if (tr_fd < 0) {
 		WARN_ON_ONCE(bpf_trampoline_unlink_prog(prog));
@@ -2258,12 +2285,14 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 	if (prog->type != BPF_PROG_TYPE_RAW_TRACEPOINT &&
 	    prog->type != BPF_PROG_TYPE_TRACING &&
 	    prog->type != BPF_PROG_TYPE_EXT &&
+	    prog->type != BPF_PROG_TYPE_LSM &&
 	    prog->type != BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE) {
 		err = -EINVAL;
 		goto out_put_prog;
 	}
 
 	if (prog->type == BPF_PROG_TYPE_TRACING ||
+	    prog->type == BPF_PROG_TYPE_LSM ||
 	    prog->type == BPF_PROG_TYPE_EXT) {
 		if (attr->raw_tracepoint.name) {
 			/* The attach point for this category of programs
@@ -2275,7 +2304,7 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 		if (prog->expected_attach_type == BPF_TRACE_RAW_TP)
 			tp_name = prog->aux->attach_func_name;
 		else
-			return bpf_tracing_prog_attach(prog);
+			return bpf_tramp_prog_attach(prog);
 	} else {
 		if (strncpy_from_user(buf,
 				      u64_to_user_ptr(attr->raw_tracepoint.name),
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 6b264a92064b..4974c14258a9 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -5,6 +5,7 @@
 #include <linux/filter.h>
 #include <linux/ftrace.h>
 #include <linux/rbtree_latch.h>
+#include <linux/bpf_lsm.h>
 
 /* dummy _ops. The verifier will operate on target program's ops. */
 const struct bpf_verifier_ops bpf_extension_verifier_ops = {
@@ -195,8 +196,9 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
  */
 #define BPF_MAX_TRAMP_PROGS 40
 
-static int bpf_trampoline_update(struct bpf_trampoline *tr)
+static int bpf_trampoline_update(struct bpf_prog *prog)
 {
+	struct bpf_trampoline *tr = prog->aux->trampoline;
 	void *old_image = tr->image + ((tr->selector + 1) & 1) * BPF_IMAGE_SIZE/2;
 	void *new_image = tr->image + (tr->selector & 1) * BPF_IMAGE_SIZE/2;
 	struct bpf_prog *progs_to_run[BPF_MAX_TRAMP_PROGS];
@@ -223,8 +225,11 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
 	hlist_for_each_entry(aux, &tr->progs_hlist[BPF_TRAMP_FEXIT], tramp_hlist)
 		*progs++ = aux->prog;
 
-	if (fexit_cnt)
+	if (fexit_cnt) {
 		flags = BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_SKIP_FRAME;
+		if (prog->type == BPF_PROG_TYPE_LSM)
+			flags |= BPF_TRAMP_F_OVERRIDE_RETURN;
+	}
 
 	/* Though the second half of trampoline page is unused a task could be
 	 * preempted in the middle of the first half of trampoline and two
@@ -261,6 +266,7 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(enum bpf_attach_type t)
 	case BPF_TRACE_FENTRY:
 		return BPF_TRAMP_FENTRY;
 	case BPF_TRACE_FEXIT:
+	case BPF_LSM_MAC:
 		return BPF_TRAMP_FEXIT;
 	default:
 		return BPF_TRAMP_REPLACE;
@@ -307,11 +313,17 @@ int bpf_trampoline_link_prog(struct bpf_prog *prog)
 	}
 	hlist_add_head(&prog->aux->tramp_hlist, &tr->progs_hlist[kind]);
 	tr->progs_cnt[kind]++;
-	err = bpf_trampoline_update(prog->aux->trampoline);
+	err = bpf_trampoline_update(prog);
 	if (err) {
 		hlist_del(&prog->aux->tramp_hlist);
 		tr->progs_cnt[kind]--;
 	}
+
+	/* This is the first program to be attached to the LSM hook, the hook
+	 * needs to be enabled.
+	 */
+	if (prog->type == BPF_PROG_TYPE_LSM && tr->progs_cnt[kind] == 1)
+		err = bpf_lsm_set_enabled(prog->aux->attach_func_name, true);
 out:
 	mutex_unlock(&tr->mutex);
 	return err;
@@ -336,7 +348,11 @@ int bpf_trampoline_unlink_prog(struct bpf_prog *prog)
 	}
 	hlist_del(&prog->aux->tramp_hlist);
 	tr->progs_cnt[kind]--;
-	err = bpf_trampoline_update(prog->aux->trampoline);
+	err = bpf_trampoline_update(prog);
+
+	/* There are no more LSM programs, the hook should be disabled */
+	if (prog->type == BPF_PROG_TYPE_LSM && tr->progs_cnt[kind] == 0)
+		err = bpf_lsm_set_enabled(prog->aux->attach_func_name, false);
 out:
 	mutex_unlock(&tr->mutex);
 	return err;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1cc945daa9c8..6be11889678b 100644
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
 
@@ -9794,7 +9796,9 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
 		return check_struct_ops_btf_id(env);
 
-	if (prog->type != BPF_PROG_TYPE_TRACING && !prog_extension)
+	if (prog->type != BPF_PROG_TYPE_TRACING &&
+	    prog->type != BPF_PROG_TYPE_LSM &&
+	    !prog_extension)
 		return 0;
 
 	if (!btf_id) {
@@ -9924,8 +9928,16 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		if (!prog_extension)
 			return -EINVAL;
 		/* fallthrough */
+	case BPF_LSM_MAC:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+		prog->aux->attach_func_name = tname;
+		if (prog->type == BPF_PROG_TYPE_LSM) {
+			ret = bpf_lsm_verify_prog(&env->log, prog);
+			if (ret < 0)
+				return ret;
+		}
+
 		if (!btf_type_is_func(t)) {
 			verbose(env, "attach_btf_id %u is not a function\n",
 				btf_id);
@@ -9940,7 +9952,6 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		tr = bpf_trampoline_lookup(key);
 		if (!tr)
 			return -ENOMEM;
-		prog->aux->attach_func_name = tname;
 		/* t is either vmlinux type or another program's type */
 		prog->aux->attach_func_proto = t;
 		mutex_lock(&tr->mutex);
-- 
2.20.1

