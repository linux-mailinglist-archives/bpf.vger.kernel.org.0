Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA222E7577
	for <lists+bpf@lfdr.de>; Wed, 30 Dec 2020 02:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgL3BXR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Dec 2020 20:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgL3BXR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Dec 2020 20:23:17 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F0FC061799
        for <bpf@vger.kernel.org>; Tue, 29 Dec 2020 17:22:36 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id z11so12907746qkj.7
        for <bpf@vger.kernel.org>; Tue, 29 Dec 2020 17:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EQDcr/w+TVVsSKk2BvVXmIj4bO9lUtYhEcDD9hYtcYE=;
        b=P6U53s/P+LcCuuzFpOtr7Aa77xlc+NlBrrHi/FLIuX+69Rk+J6BOiVj0LyfGxcxVBe
         2KKl2ffbuWBzWgGN/eckrB9uskWgR+CQKCnU52qIHop6KmoIol9v4w+vj6N+Q0eykRk9
         l1kCTmJ2erk7VH/fmmzj8k7EFSlg36osYkRZO+OSHcnjk9us/9V8kwbIG6xn9VsxtDDg
         dhFx9kwfGfLYHx62HP4DAzdUJFZ0UA54/6cRHV4hnLGp9/A1EkoIEdeO0AfZ07rr52S9
         0mVvFMZBiQpRVADFnNzg+f6zwgxvzxGiRqRjQYL7Z1um52wawu9QBHU4K9Y8BEXGA6yX
         gRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EQDcr/w+TVVsSKk2BvVXmIj4bO9lUtYhEcDD9hYtcYE=;
        b=gqJoYXD0p7ELaNZnvw6LC8mtfN9anilbb+iCOCwCMt9LEg59/SMpBJhKP9fu+6L7wy
         q4GibkqorAuxVob5M+0Z2m6G3wXOPIGu/T18/rhIfWOBq9TmAM+PjwY3CzVf+j+6HPFo
         4LRohDim0YDDbrnSJBwgGucohb73OKt5lclBxVdHgp2/dAR2HUk3vqTV7GAEcyWp9yum
         zNwQMiA0lBTazaNQElUdmcHT4dW0bHNtTir8KuaVLeD6cx2+8u9/o73scvgM3iUqlm9a
         XYVc2gnJgQqdmBYCLx1GjYEp7pTYkZcmAcoqZvF4EK1vaHCBv3KWtlFdGASZPVqqMLVs
         2+cg==
X-Gm-Message-State: AOAM530OiIaCYU5p7zB51dJ03ZPUqRLPynq4kVwp8PX20igwqFvupVEX
        PQcyWAIUVOjR1GfAC7K3ZrITh5UjDuZwrA==
X-Google-Smtp-Source: ABdhPJypFgdXvDYGvPE3h4IeG/ycwl/5OAiJ9imRCuJ8qYFyC7LH4766yHGcBW6XOI5Nbm50B8yVQA==
X-Received: by 2002:a37:416:: with SMTP id 22mr49967045qke.480.1609291354877;
        Tue, 29 Dec 2020 17:22:34 -0800 (PST)
Received: from localhost (pool-96-239-57-246.nycmny.fios.verizon.net. [96.239.57.246])
        by smtp.gmail.com with ESMTPSA id m13sm26659331qtu.93.2020.12.29.17.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 17:22:34 -0800 (PST)
From:   Andrei Matei <andreimatei1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next] bpf: allow variable-offset stack reads
Date:   Tue, 29 Dec 2020 20:22:31 -0500
Message-Id: <20201230012231.1324633-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Before this patch, variable offset access to the stack was dissalowed
for regular instructions, but was allowed for "indirect" accesses (i.e.
helpers). This patch narrows the restriction, allowing reading the stack
through pointers with variable offsets. This makes stack-allocated
buffers more usable in programs, and brings stack pointers closer to
other types of pointers.

All register spilled in stack slots that might be read are marked as
having been read, however reads through such pointers don't do register
filling; the target register will always be either a scalar or a
constant zero.

Notes:
- Writes with variable offsets are still dissallowed; this patch only
  deals with reads.
- All the stack slots in the variable range needs to be initialized,
  otherwise the read is rejected.
- Variable offset direct reads remain dissallowed for non-priviledged
  programs; they were already dissalowed for "indirect" accesses.
- The code for checking variable-offset reads is somewhat shared with
  the code for checking helper accesses. The fit is not quite perfect
  as check_stack_boundary() assumes that the helpers clobber the stack
  (which is not the case for a direct read).

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 include/linux/bpf_verifier.h                  |   2 +-
 kernel/bpf/verifier.c                         | 250 +++++++++++++-----
 tools/testing/selftests/bpf/test_verifier.c   |  13 +-
 .../testing/selftests/bpf/verifier/var_off.c  |  52 +++-
 4 files changed, 241 insertions(+), 76 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e941fe1484e5..76b2fce7e012 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -195,7 +195,7 @@ struct bpf_func_state {
 	 * 0 = main function, 1 = first callee.
 	 */
 	u32 frameno;
-	/* subprog number == index within subprog_stack_depth
+	/* subprog number == index within subprog_info
 	 * zero == main subprog
 	 */
 	u32 subprogno;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 17270b8404f1..dd0436623f2e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2400,9 +2400,63 @@ static int check_stack_write(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static int check_stack_read(struct bpf_verifier_env *env,
-			    struct bpf_func_state *reg_state /* func where register points to */,
-			    int off, int size, int value_regno)
+/* When register 'regno' is assigned some values from stack[min_off, max_off),
+ * we set the register's type according to the types of the respective stack
+ * slots. If all the stack values are known to be zeros, then so is the
+ * destination reg. Otherwise, the register is considered to be SCALAR. This
+ * function does not deal with register filling; the caller must ensure that
+ * all spilled registers in the stack range have been marked as read.
+ */
+static void mark_reg_stack_read(struct bpf_verifier_env *env,
+				/* func where src register points to */
+				struct bpf_func_state *reg_state,
+				int min_off, int max_off, int regno)
+{
+	struct bpf_verifier_state *vstate = env->cur_state;
+	struct bpf_func_state *state = vstate->frame[vstate->curframe];
+	int i, slot, spi;
+	u8 *stype;
+	int zeros = 0;
+
+	for (i = min_off; i < max_off; i++) {
+		slot = -i - 1;
+		spi = slot / BPF_REG_SIZE;
+		stype = reg_state->stack[spi].slot_type;
+		if (stype[slot % BPF_REG_SIZE] != STACK_ZERO)
+			break;
+		zeros++;
+	}
+	if (zeros == (max_off - min_off)) {
+		/* any access_size read into register is zero extended,
+		 * so the whole register == const_zero
+		 */
+		__mark_reg_const_zero(&state->regs[regno]);
+		/* backtracking doesn't support STACK_ZERO yet,
+		 * so mark it precise here, so that later
+		 * backtracking can stop here.
+		 * Backtracking may not need this if this register
+		 * doesn't participate in pointer adjustment.
+		 * Forward propagation of precise flag is not
+		 * necessary either. This mark is only to stop
+		 * backtracking. Any register that contributed
+		 * to const 0 was marked precise before spill.
+		 */
+		state->regs[regno].precise = true;
+	} else {
+		/* have read misc data from the stack */
+		mark_reg_unknown(env, state->regs, regno);
+	}
+	state->regs[regno].live |= REG_LIVE_WRITTEN;
+}
+
+/* Read the stack at 'off' and put the results into the register indicated by
+ * 'value_regno'. It handles reg filling if the addressed stack slot is a
+ * spilled reg.
+ */
+static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
+				      /* func where src register points to */
+				      struct bpf_func_state *reg_state,
+				      int off, int size, int value_regno)
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
@@ -2460,54 +2514,91 @@ static int check_stack_read(struct bpf_verifier_env *env,
 		}
 		mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
 	} else {
-		int zeros = 0;
-
+		u8 type;
 		for (i = 0; i < size; i++) {
-			if (stype[(slot - i) % BPF_REG_SIZE] == STACK_MISC)
+			type = stype[(slot - i) % BPF_REG_SIZE];
+			if (type == STACK_MISC)
 				continue;
-			if (stype[(slot - i) % BPF_REG_SIZE] == STACK_ZERO) {
-				zeros++;
+			if (type == STACK_ZERO)
 				continue;
-			}
 			verbose(env, "invalid read from stack off %d+%d size %d\n",
 				off, i, size);
 			return -EACCES;
 		}
 		mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
-		if (value_regno >= 0) {
-			if (zeros == size) {
-				/* any size read into register is zero extended,
-				 * so the whole register == const_zero
-				 */
-				__mark_reg_const_zero(&state->regs[value_regno]);
-				/* backtracking doesn't support STACK_ZERO yet,
-				 * so mark it precise here, so that later
-				 * backtracking can stop here.
-				 * Backtracking may not need this if this register
-				 * doesn't participate in pointer adjustment.
-				 * Forward propagation of precise flag is not
-				 * necessary either. This mark is only to stop
-				 * backtracking. Any register that contributed
-				 * to const 0 was marked precise before spill.
-				 */
-				state->regs[value_regno].precise = true;
-			} else {
-				/* have read misc data from the stack */
-				mark_reg_unknown(env, state->regs, value_regno);
-			}
-			state->regs[value_regno].live |= REG_LIVE_WRITTEN;
-		}
+		if (value_regno >= 0)
+			mark_reg_stack_read(env, reg_state, off, off + size, value_regno);
 	}
 	return 0;
 }
 
-static int check_stack_access(struct bpf_verifier_env *env,
-			      const struct bpf_reg_state *reg,
-			      int off, int size)
+enum stack_access_type {
+	ACCESS_DIRECT,  /* the access is performed by an instruction */
+	ACCESS_HELPER,  /* the access is performed by a helper*/
+};
+
+static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
+				int off,
+				int access_size, bool zero_size_allowed,
+				enum stack_access_type type,
+				struct bpf_call_arg_meta *meta);
+
+/* Read the stack at 'ptr_regno + off' and put the result into the register
+ * 'dst_regno'.
+ * 'off' includes the pointer register's fixed offset(i.e. 'ptr_regno.off'),
+ * but not its variable offset.
+ * 'size' is assumed to be <= reg size and the access is assumed to be aligned.
+ *
+ * As opposed to check_stack_read_fixed_off, this function doesn't deal with
+ * filling registers (i.e. reads of spilled register cannot be detected when
+ * the offset is not fixed). We conservatively mark 'dst_regno' as containing
+ * SCALAR_VALUE. That's why we assert that the 'ptr_regno' has a variable
+ * offset; for a fixed offset 'check_stack_read_fixed_off' should be used
+ * instead.
+ */
+static int check_stack_read_var_off(struct bpf_verifier_env *env,
+				    int ptr_regno, int off, int size, int dst_regno)
 {
-	/* Stack accesses must be at a fixed offset, so that we
-	 * can determine what type of data were returned. See
-	 * check_stack_read().
+	int err;
+	int min_off, max_off;
+	struct bpf_verifier_state *vstate = env->cur_state;
+	struct bpf_func_state *state = vstate->frame[vstate->curframe];
+	struct bpf_reg_state *reg = state->regs + ptr_regno;
+
+	if (tnum_is_const(reg->var_off)) {
+		char tn_buf[48];
+
+		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
+		verbose(env, "%s: fixed stack access illegal: reg=%d var_off=%s off=%d size=%d\n",
+			__func__, ptr_regno, tn_buf, off, size);
+		return -EINVAL;
+	}
+	/* Note that we pass a NULL meta, so raw access will not be permitted. Also
+	 * note that, for simplicity, check_stack_boundary is going to pretend that
+	 * all the stack slots in range [off, off+size) will be clobbered, although
+	 * that's not the case for a stack read.
+	 */
+	err = check_stack_boundary(env, ptr_regno, off, size,
+			false, ACCESS_DIRECT, NULL);
+	if (err)
+		return err;
+
+	min_off = reg->smin_value + off;
+	max_off = reg->smax_value + off;
+	mark_reg_stack_read(env, state, min_off, max_off + size, dst_regno);
+	return 0;
+}
+
+
+// check that stack access falls within stack limits and that 'reg' doesn't
+// have a variable offset.
+// 'off' includes 'reg->off'.
+static int check_fixed_stack_access(struct bpf_verifier_env *env,
+				    const struct bpf_reg_state *reg,
+				    int off, int size)
+{
+	/* Stack accesses must be at a fixed offset for register spill tracking.
+	 * See check_stack_write().
 	 */
 	if (!tnum_is_const(reg->var_off)) {
 		char tn_buf[48];
@@ -2980,7 +3071,7 @@ static int check_ptr_alignment(struct bpf_verifier_env *env,
 	case PTR_TO_STACK:
 		pointer_desc = "stack ";
 		/* The stack spill tracking logic in check_stack_write()
-		 * and check_stack_read() relies on stack accesses being
+		 * and check_stack_read_fixed_off() relies on stack accesses being
 		 * aligned.
 		 */
 		strict = true;
@@ -3513,22 +3604,36 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		}
 
 	} else if (reg->type == PTR_TO_STACK) {
-		off += reg->var_off.value;
-		err = check_stack_access(env, reg, off, size);
-		if (err)
-			return err;
+		if ((t == BPF_WRITE)
+				/* fixed offset stack reads track reg fills */
+				|| tnum_is_const(reg->var_off)
+				/* reads that don't go to a register need extra checks about
+				 * what's being read in order to not leak pointers (see
+				 * check_stack_read_fixed_off)
+				 */
+				|| (value_regno < 0)) {
+			off += reg->var_off.value;
+			err = check_fixed_stack_access(env, reg, off, size);
+			if (err)
+				return err;
 
-		state = func(env, reg);
-		err = update_stack_depth(env, state, off);
-		if (err)
-			return err;
+			state = func(env, reg);
+			err = update_stack_depth(env, state, off);
+			if (err)
+				return err;
 
-		if (t == BPF_WRITE)
-			err = check_stack_write(env, state, off, size,
-						value_regno, insn_idx);
-		else
-			err = check_stack_read(env, state, off, size,
-					       value_regno);
+			if (t == BPF_WRITE)
+				err = check_stack_write(env, state, off, size,
+							value_regno, insn_idx);
+			else
+				err = check_stack_read_fixed_off(env, state, off, size,
+								 value_regno);
+		} else {
+			/* Variable offset stack reads need more conservative handling
+			 * than fixed offset ones. Note that value_regno >= 0 on this branch.
+			 */
+			err = check_stack_read_var_off(env, regno, off, size, value_regno);
+		}
 	} else if (reg_is_pkt_pointer(reg)) {
 		if (t == BPF_WRITE && !may_access_direct_pkt_data(env, NULL, t)) {
 			verbose(env, "cannot write into packet\n");
@@ -3676,19 +3781,24 @@ static int __check_stack_boundary(struct bpf_verifier_env *env, u32 regno,
 /* when register 'regno' is passed into function that will read 'access_size'
  * bytes from that pointer, make sure that it's within stack boundary
  * and all elements of stack are initialized.
- * Unlike most pointer bounds-checking functions, this one doesn't take an
- * 'off' argument, so it has to add in reg->off itself.
+ *
+ * 'off' includes 'regno->off'.
+ *
+ * All registers that have been spilled on the stack in the slots within the
+ * read offsets are marked as read.
  */
 static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
-				int access_size, bool zero_size_allowed,
+				int off, int access_size, bool zero_size_allowed,
+				enum stack_access_type type,
 				struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_func_state *state = func(env, reg);
 	int err, min_off, max_off, i, j, slot, spi;
+	char *err_extra = type == ACCESS_HELPER ? " indirect" : "";
 
 	if (tnum_is_const(reg->var_off)) {
-		min_off = max_off = reg->var_off.value + reg->off;
+		min_off = max_off = reg->var_off.value + off;
 		err = __check_stack_boundary(env, regno, min_off, access_size,
 					     zero_size_allowed);
 		if (err)
@@ -3703,8 +3813,8 @@ static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
 			char tn_buf[48];
 
 			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-			verbose(env, "R%d indirect variable offset stack access prohibited for !root, var_off=%s\n",
-				regno, tn_buf);
+			verbose(env, "R%d%s variable offset stack access prohibited for !root, var_off=%s\n",
+				regno, err_extra, tn_buf);
 			return -EACCES;
 		}
 		/* Only initialized buffer on stack is allowed to be accessed
@@ -3718,12 +3828,12 @@ static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
 
 		if (reg->smax_value >= BPF_MAX_VAR_OFF ||
 		    reg->smax_value <= -BPF_MAX_VAR_OFF) {
-			verbose(env, "R%d unbounded indirect variable offset stack access\n",
-				regno);
+			verbose(env, "R%d unbounded%s variable offset stack access\n",
+				regno, err_extra);
 			return -EACCES;
 		}
-		min_off = reg->smin_value + reg->off;
-		max_off = reg->smax_value + reg->off;
+		min_off = reg->smin_value + off;
+		max_off = reg->smax_value + off;
 		err = __check_stack_boundary(env, regno, min_off, access_size,
 					     zero_size_allowed);
 		if (err) {
@@ -3777,14 +3887,14 @@ static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
 
 err:
 		if (tnum_is_const(reg->var_off)) {
-			verbose(env, "invalid indirect read from stack off %d+%d size %d\n",
-				min_off, i - min_off, access_size);
+			verbose(env, "invalid%s read from stack off %d+%d size %d\n",
+				err_extra, min_off, i - min_off, access_size);
 		} else {
 			char tn_buf[48];
 
 			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-			verbose(env, "invalid indirect read from stack var_off %s+%d size %d\n",
-				tn_buf, i - min_off, access_size);
+			verbose(env, "invalid%s read from stack var_off %s+%d size %d\n",
+				err_extra, tn_buf, i - min_off, access_size);
 		}
 		return -EACCES;
 mark:
@@ -3833,8 +3943,8 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 					   "rdwr",
 					   &env->prog->aux->max_rdwr_access);
 	case PTR_TO_STACK:
-		return check_stack_boundary(env, regno, access_size,
-					    zero_size_allowed, meta);
+		return check_stack_boundary(env, regno, reg->off, access_size,
+			zero_size_allowed, ACCESS_HELPER, meta);
 	default: /* scalar_value or invalid ptr */
 		/* Allow zero-byte read from NULL, regardless of pointer type */
 		if (zero_size_allowed && access_size == 0 &&
@@ -5741,7 +5851,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 				"prohibited for !root\n", dst);
 			return -EACCES;
 		} else if (dst_reg->type == PTR_TO_STACK &&
-			   check_stack_access(env, dst_reg, dst_reg->off +
+			   check_fixed_stack_access(env, dst_reg, dst_reg->off +
 					      dst_reg->var_off.value, 1)) {
 			verbose(env, "R%d stack pointer arithmetic goes out of range, "
 				"prohibited for !root\n", dst);
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 777a81404fdb..e8f7374a6521 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -87,6 +87,9 @@ struct bpf_test {
 	int fixup_sk_storage_map[MAX_FIXUPS];
 	int fixup_map_event_output[MAX_FIXUPS];
 	int fixup_map_reuseport_array[MAX_FIXUPS];
+	/* Expected verifier log output for result REJECT or VERBOSE_ACCEPT. Can be a
+	 * tab-separated sequence of expected strings.
+	 */
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t insn_processed;
@@ -913,9 +916,11 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
 	return 0;
 }
 
+/* Returns true if every part of exp (tab-separated) appears in log, in order.
+ */
 static bool cmp_str_seq(const char *log, const char *exp)
 {
-	char needle[80];
+	char needle[200];
 	const char *p, *q;
 	int len;
 
@@ -1048,7 +1053,11 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 			printf("FAIL\nUnexpected success to load!\n");
 			goto fail_log;
 		}
-		if (!expected_err || !strstr(bpf_vlog, expected_err)) {
+		if (!expected_err) {
+			printf("FAIL\nTestcase bug; missing expected_err\n");
+			goto fail_log;
+		}
+		if ((strlen(expected_err) > 0) && !cmp_str_seq(bpf_vlog, expected_err)) {
 			printf("FAIL\nUnexpected error message!\n\tEXP: %s\n\tRES: %s\n",
 			      expected_err, bpf_vlog);
 			goto fail_log;
diff --git a/tools/testing/selftests/bpf/verifier/var_off.c b/tools/testing/selftests/bpf/verifier/var_off.c
index 8504ac937809..a1a46a6ec376 100644
--- a/tools/testing/selftests/bpf/verifier/var_off.c
+++ b/tools/testing/selftests/bpf/verifier/var_off.c
@@ -18,7 +18,7 @@
 	.prog_type = BPF_PROG_TYPE_LWT_IN,
 },
 {
-	"variable-offset stack access",
+	"variable-offset stack read",
 	.insns = {
 	/* Fill the top 8 bytes of the stack */
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
@@ -31,11 +31,57 @@
 	 * we don't know which
 	 */
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
-	/* dereference it */
+	/* dereference it for a stack read */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.result_unpriv = REJECT,
+	.errstr_unpriv =
+		"variable stack access var_off=(0xfffffffffffffff8; 0x4) off=-8 size=1\tR2 stack pointer arithmetic goes out of range, prohibited for !root",
+	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+},
+{
+	"variable-offset stack read, uninitialized",
+	.insns = {
+	/* Get an unknown value */
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
+	/* Make it small and 4-byte aligned */
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 4),
+	BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 8),
+	/* add it to fp.  We now have either fp-4 or fp-8, but
+	 * we don't know which
+	 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
+	/* dereference it for a stack read */
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "invalid read from stack var_off (0xfffffffffffffff8; 0x4)+0 size 4",
+	.prog_type = BPF_PROG_TYPE_LWT_IN,
+},
+{
+	"variable-offset stack write",
+	.insns = {
+	/* Fill the top 8 bytes of the stack */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	/* Get an unknown value */
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
+	/* Make it small and 8-byte aligned */
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 8),
+	BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 16),
+	/* add it to fp.  We now have either fp-8 or fp-16, but
+	 * we don't know which
+	 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
+	/* dereference it for a stack write */
+	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "variable stack access var_off=(0xfffffffffffffff8; 0x4)",
+	.errstr = "variable stack access var_off=(0xfffffffffffffff0; 0x8)",
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_LWT_IN,
 },
-- 
2.27.0

