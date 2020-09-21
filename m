Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0C5271A6B
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 07:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgIUFfl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 01:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgIUFfl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 01:35:41 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F9CC061755
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2020 22:35:40 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id j2so14119406ioj.7
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2020 22:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Wc8Z1KYCcAuZ91aOoXOoYnVpxCJ/RupYtBU5oGvkt0=;
        b=K+7oInokwUiTRmodtvifYob4PI1eDLNpaNf1SBaHOBQvZFhBP77/sH4pcJrR0QUMgX
         zFhCbuTs+HqV1HSy+8D0d7ahU/CpS+KJ6U2RYNCAPjsHMOEqHD4z5faRzA3SSUtYlxpg
         xXa0Ebx/yWa0zGyTIgxnNo9s0myql/YXjrHzg+E7f1OdDPlVJpx3BXhYmFt4rSLhZ4AE
         LaGx3oyS+1VzatAddSHUPlcYVE5bKFLPVzHvqCOWY7FYkg9x/Hgj0ZkhsyFDP2NfS2un
         0avgdij9easJZhw+p69mgaZBLTGeIlSfQsGY7K/WPBtRs1TkWyYWuJIv5kX3V0knT432
         03ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Wc8Z1KYCcAuZ91aOoXOoYnVpxCJ/RupYtBU5oGvkt0=;
        b=RcgBjsru5HAH14kJLbycb7Y+++DFbMaLSPWidh3FBF1UeOrB4CrDJORXVo+AFeZZSd
         4iZyUltwryywpSqFJMTaIe7ibQpNIVH2fEZNvC0eHORpOFWzPssrfAsHq+35i6LMv9yu
         Ji3eEfQEEe0HMOR86cEFuip6csJS29hITo4JpV0t3CkIVhiAOdy7u8bGHpAoXny5Cjal
         ZMd6hIlWJfQmig/7eqNgBU6tV3HbSAhrGCSJfMYvHhqHs4CzrvJpgD7d9by+wKuacSPG
         5D0i26I0wrzWqL4o+PDINUWxeJFZgsd1OdDgvpPoY/fzNRmCmVWHuOxtTqcl4mNnnup/
         xcbA==
X-Gm-Message-State: AOAM532k7jJLhlPcYdl/s0+6RzfmTVgN3i82NQ6LcTy5agjE9pA8r04l
        1J2iJEGCEkgLd7OL9g7vXcg=
X-Google-Smtp-Source: ABdhPJyV9OAZ1dzVGuSHDHgrGTi35gxD+a+xYM+loRklI1PdJfSBZ8KjaTaePlVaSIMiURuZP5fcNA==
X-Received: by 2002:a5d:8846:: with SMTP id t6mr37147824ios.123.1600666539946;
        Sun, 20 Sep 2020 22:35:39 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id i9sm6644962ilj.71.2020.09.20.22.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 22:35:39 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux-foundation.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>, bpf@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Valentin Rothberg <vrothber@redhat.com>
Subject: [RFC PATCH seccomp 1/2] seccomp/cache: Add "emulator" to check if filter is arg-dependent
Date:   Mon, 21 Sep 2020 00:35:17 -0500
Message-Id: <6af89348c08a4820039e614a090d35aa1583acff.1600661419.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600661418.git.yifeifz2@illinois.edu>
References: <cover.1600661418.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <yifeifz2@illinois.edu>

SECCOMP_CACHE_NR_ONLY will only operate on syscalls that do not
access any syscall arguments or instruction pointer. To facilitate
this we need a static analyser to know whether a filter will
access. This is implemented here with a pseudo-emulator, and
stored in a per-filter bitmap. Each seccomp cBPF instruction,
aside from ALU (which should rarely be used in seccomp), gets a
naive best-effort emulation for each syscall number.

The emulator works by following all possible (without SAT solving)
paths the filter can take. Every cBPF register / memory position
records whether that is a constant, and of so, the value of the
constant. Loading from struct seccomp_data is considered constant
if it is a syscall number, else it is an unknown. For each
conditional jump, if the both arguments can be resolved to a
constant, the jump is followed after computing the result of the
condition; else both directions are followed, by pushing one of
the next states to a linked list of next states to process. We
keep a finite number of pending states to process.

The emulation is halted if it reaches a return, or if it reaches a
read from struct seccomp_data that reads an offset that is neither
syscall number or architecture number. In the latter case, we mark
the syscall number as not okay for seccomp to cache. If a filter
depends on more filters, then if its dependee cannot process the
syscall then the depender is also marked not to process the syscall.

We also do a single pass on the entire filter instructions before
performing emulation. If none of the filter instructions load from
the troublesome offsets, then the filter is considered "trivial",
and all syscalls are marked okay for seccomp to cache.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/x86/Kconfig |  27 ++++
 kernel/seccomp.c | 323 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 349 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7101ac64bb20..9e6891812053 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1984,6 +1984,33 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+choice
+	prompt "Seccomp filter cache"
+	default SECCOMP_CACHE_NONE
+	depends on SECCOMP
+	depends on SECCOMP_FILTER
+	help
+	  Seccomp filters can potentially incur large overhead for each
+	  system call. This can alleviate some of the overhead.
+
+	  If in doubt, select 'none'.
+
+config SECCOMP_CACHE_NONE
+	bool "None"
+	help
+	  No caching is done. Seccomp filters will be called each time
+	  a system call occurs in a seccomp-guarded task.
+
+config SECCOMP_CACHE_NR_ONLY
+	bool "Syscall number only"
+	help
+	  This is enables a bitmap to cache the results of seccomp
+	  filters, if the filter allows the syscall and is independent
+	  of the syscall arguments. This requires around 60 bytes per
+	  filter and 70 bytes per task.
+
+endchoice
+
 source "kernel/Kconfig.hz"
 
 config KEXEC
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 3ee59ce0a323..d8c30901face 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -143,6 +143,27 @@ struct notification {
 	struct list_head notifications;
 };
 
+#ifdef CONFIG_SECCOMP_CACHE_NR_ONLY
+/**
+ * struct seccomp_cache_filter_data - container for cache's per-filter data
+ *
+ * @syscall_ok: A bitmap where each bit represent whether seccomp is allowed to
+ *	        cache the results of this syscall.
+ */
+struct seccomp_cache_filter_data {
+	DECLARE_BITMAP(syscall_ok, NR_syscalls);
+};
+
+#define SECCOMP_EMU_MAX_PENDING_STATES 64
+#else
+struct seccomp_cache_filter_data { };
+
+static inline int seccomp_cache_prepare(struct seccomp_filter *sfilter)
+{
+	return 0;
+}
+#endif /* CONFIG_SECCOMP_CACHE_NR_ONLY */
+
 /**
  * struct seccomp_filter - container for seccomp BPF programs
  *
@@ -185,6 +206,7 @@ struct seccomp_filter {
 	struct notification *notif;
 	struct mutex notify_lock;
 	wait_queue_head_t wqh;
+	struct seccomp_cache_filter_data cache;
 };
 
 /* Limit any path through the tree to 256KB worth of instructions. */
@@ -530,6 +552,297 @@ static inline void seccomp_sync_threads(unsigned long flags)
 	}
 }
 
+#ifdef CONFIG_SECCOMP_CACHE_NR_ONLY
+/**
+ * struct seccomp_emu_env - container for seccomp emulator environment
+ *
+ * @filter: The cBPF filter instructions.
+ * @next_state: The next pending state to start emulating from.
+ * @next_state_len: Length of the next state linked list. This is used to
+ *		    enforce naximum number of pending states.
+ * @nr: The syscall number we are emulating.
+ * @syscall_ok: Emulation result, whether it is okay for seccomp to cache the
+ *		syscall.
+ */
+struct seccomp_emu_env {
+	struct sock_filter *filter;
+	struct seccomp_emu_state *next_state;
+	int next_state_len;
+	int nr;
+	bool syscall_ok;
+};
+
+/**
+ * struct seccomp_emu_state - container for seccomp emulator state
+ *
+ * @next: The next pending state. This structure is a linked list.
+ * @pc: The current program counter.
+ * @reg_known: Whether each cBPF register / memory location is a constant.
+ * @reg_const: When a cBPF register / memory location is a constant, the value
+ *	       of that constant.
+ */
+struct seccomp_emu_state {
+	struct seccomp_emu_state *next;
+	int pc;
+	bool reg_known[2 + BPF_MEMWORDS];
+	u32 reg_const[2 + BPF_MEMWORDS];
+};
+
+/**
+ * seccomp_emu_step - step one instruction in the emulator
+ * @env: The emulator environment
+ * @state: The emulator state
+ *
+ * Returns 1 to halt emulation, 0 to continue, or -errno if error occurred.
+ */
+static int seccomp_emu_step(struct seccomp_emu_env *env,
+			    struct seccomp_emu_state *state)
+{
+	struct sock_filter *ftest = &env->filter[state->pc++];
+	struct seccomp_emu_state *new_state;
+	u16 code = ftest->code;
+	u32 k = ftest->k;
+	u32 operand;
+	bool compare;
+	int reg_idx;
+
+	switch (BPF_CLASS(code)) {
+	case BPF_LD:
+	case BPF_LDX:
+		reg_idx = BPF_CLASS(code) == BPF_LDX;
+
+		switch (BPF_MODE(code)) {
+		case BPF_IMM:
+			state->reg_known[reg_idx] = true;
+			state->reg_const[reg_idx] = k;
+			break;
+		case BPF_ABS:
+			if (k == offsetof(struct seccomp_data, nr)) {
+				state->reg_known[reg_idx] = true;
+				state->reg_const[reg_idx] = env->nr;
+			} else {
+				state->reg_known[reg_idx] = false;
+
+				if (k != offsetof(struct seccomp_data, arch)) {
+					env->syscall_ok = false;
+					return 1;
+				}
+			}
+
+			break;
+		case BPF_MEM:
+			state->reg_known[reg_idx] = state->reg_known[2 + k];
+			state->reg_const[reg_idx] = state->reg_const[2 + k];
+			break;
+		default:
+			state->reg_known[reg_idx] = false;
+		}
+
+		return 0;
+	case BPF_ST:
+	case BPF_STX:
+		reg_idx = BPF_CLASS(code) == BPF_STX;
+
+		state->reg_known[2 + k] = state->reg_known[reg_idx];
+		state->reg_const[2 + k] = state->reg_const[reg_idx];
+
+		return 0;
+	case BPF_ALU:
+		state->reg_known[0] = false;
+		return 0;
+	case BPF_JMP:
+		if (BPF_OP(code) == BPF_JA) {
+			state->pc += k;
+			return 0;
+		}
+
+		if (ftest->jt == ftest->jf) {
+			state->pc += ftest->jt;
+			return 0;
+		}
+
+		if (!state->reg_known[0])
+			goto both_cases;
+
+		switch (BPF_SRC(code)) {
+		case BPF_K:
+			operand = k;
+			break;
+		case BPF_X:
+			if (!state->reg_known[1])
+				goto both_cases;
+			operand = state->reg_const[1];
+			break;
+		default:
+			WARN_ON(true);
+			return -EINVAL;
+		}
+
+		switch (BPF_OP(code)) {
+		case BPF_JEQ:
+			compare = state->reg_const[0] == operand;
+			break;
+		case BPF_JGT:
+			compare = state->reg_const[0] > operand;
+			break;
+		case BPF_JGE:
+			compare = state->reg_const[0] >= operand;
+			break;
+		case BPF_JSET:
+			compare = state->reg_const[0] & operand;
+			break;
+		default:
+			WARN_ON(true);
+			return -EINVAL;
+		}
+
+		state->pc += compare ? ftest->jt : ftest->jf;
+
+		return 0;
+
+both_cases:
+		if (env->next_state_len >= SECCOMP_EMU_MAX_PENDING_STATES)
+			return -E2BIG;
+
+		new_state = kmalloc(sizeof(*new_state), GFP_KERNEL);
+		if (!new_state)
+			return -ENOMEM;
+
+		*new_state = *state;
+		new_state->next = env->next_state;
+		new_state->pc += ftest->jt;
+		env->next_state = new_state;
+		env->next_state_len++;
+
+		state->pc += ftest->jf;
+
+		return 0;
+	case BPF_RET:
+		return 1;
+	case BPF_MISC:
+		switch (BPF_MISCOP(code)) {
+		case BPF_TAX:
+			state->reg_known[1] = state->reg_known[0];
+			state->reg_const[1] = state->reg_const[0];
+			break;
+		case BPF_TXA:
+			state->reg_known[0] = state->reg_known[1];
+			state->reg_const[0] = state->reg_const[1];
+			break;
+		default:
+			WARN_ON(true);
+			return -EINVAL;
+		}
+
+		return 0;
+	default:
+		BUILD_BUG();
+		unreachable();
+	}
+}
+
+/**
+ * seccomp_cache_filter_trivial - check if the program does not load arguments.
+ * @fprog: The cBPF program code
+ *
+ * Returns true if the filter is trivial.
+ */
+static bool seccomp_cache_filter_trivial(struct sock_fprog_kern *fprog)
+{
+	int pc;
+
+	for (pc = 0; pc < fprog->len; pc++) {
+		struct sock_filter *ftest = &fprog->filter[pc];
+		u16 code = ftest->code;
+		u32 k = ftest->k;
+
+		if (BPF_CLASS(code) == BPF_LD && BPF_MODE(code) == BPF_ABS) {
+			if (k != offsetof(struct seccomp_data, nr) &&
+			    k != offsetof(struct seccomp_data, arch))
+				return false;
+		}
+	}
+
+	return true;
+}
+
+/**
+ * seccomp_cache_prepare - emulate the filter to find cachable syscalls
+ * @sfilter: The seccomp filter
+ *
+ * Returns 0 if successful or -errno if error occurred.
+ */
+static int seccomp_cache_prepare(struct seccomp_filter *sfilter)
+{
+	struct sock_fprog_kern *fprog = sfilter->prog->orig_prog;
+	struct seccomp_filter *prev = sfilter->prev;
+	struct sock_filter *filter = fprog->filter;
+	struct seccomp_emu_state *state;
+	int nr, res = 0;
+
+	if (seccomp_cache_filter_trivial(fprog)) {
+		if (prev)
+			bitmap_copy(sfilter->cache.syscall_ok,
+				    prev->cache.syscall_ok, NR_syscalls);
+		else
+			bitmap_fill(sfilter->cache.syscall_ok, NR_syscalls);
+
+		return 0;
+	}
+
+	for (nr = 0; nr < NR_syscalls; nr++) {
+		struct seccomp_emu_env env = {0};
+
+		env.syscall_ok = !prev || test_bit(nr, prev->cache.syscall_ok);
+		if (!env.syscall_ok)
+			continue;
+
+		env.filter = filter;
+		env.nr = nr;
+
+		env.next_state = kzalloc(sizeof(*env.next_state), GFP_KERNEL);
+		env.next_state_len = 1;
+		if (!env.next_state)
+			return -ENOMEM;
+
+		while (env.next_state) {
+			state = env.next_state;
+			env.next_state = state->next;
+			env.next_state_len--;
+
+			while (true) {
+				res = seccomp_emu_step(&env, state);
+
+				if (res)
+					break;
+			}
+
+			kfree(state);
+
+			if (res < 0)
+				goto free_states;
+		}
+
+free_states:
+		while (env.next_state) {
+			state = env.next_state;
+			env.next_state = state->next;
+
+			kfree(state);
+		}
+
+		if (res < 0)
+			goto out;
+
+		if (env.syscall_ok)
+			set_bit(nr, sfilter->cache.syscall_ok);
+	}
+
+out:
+	return res;
+}
+#endif /* CONFIG_SECCOMP_CACHE_NR_ONLY */
+
 /**
  * seccomp_prepare_filter: Prepares a seccomp filter for use.
  * @fprog: BPF program to install
@@ -540,7 +853,8 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
 {
 	struct seccomp_filter *sfilter;
 	int ret;
-	const bool save_orig = IS_ENABLED(CONFIG_CHECKPOINT_RESTORE);
+	const bool save_orig = IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) ||
+			       IS_ENABLED(CONFIG_SECCOMP_CACHE_NR_ONLY);
 
 	if (fprog->len == 0 || fprog->len > BPF_MAXINSNS)
 		return ERR_PTR(-EINVAL);
@@ -571,6 +885,13 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
 		return ERR_PTR(ret);
 	}
 
+	ret = seccomp_cache_prepare(sfilter);
+	if (ret < 0) {
+		bpf_prog_destroy(sfilter->prog);
+		kfree(sfilter);
+		return ERR_PTR(ret);
+	}
+
 	refcount_set(&sfilter->refs, 1);
 	refcount_set(&sfilter->users, 1);
 	init_waitqueue_head(&sfilter->wqh);
-- 
2.28.0

