Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CF72CDABC
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 17:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbgLCQEx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 11:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731188AbgLCQEx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 11:04:53 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422D8C08E9AA
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 08:03:25 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id n12so1904146qta.9
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 08:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+urGfu1jFSm4aWjVX73KCX3G8rm9BJtSYy38Di6nXZQ=;
        b=KtwMf49PHhFZmPeQCcqfZgpKP2dzfqwqAl7gMO9KRchJRL9kIJBvJDFgz1M5ui7d3H
         zpzD5G9nxrmej8bVQspRlFhYeAXLJxt1uZs+6iCh/BpQZu0cDAxIE8zZfk7OWBAUARQj
         k6ObBLrdflwAXYYK8fjSTzpX5p9rt4YRZt3EGdBK9Bf3cGqI8eNenoLT0L4qHjUQkiYd
         8qel8hlEKnW25zA1BC+bGmtFGD0HheGCD26QhE6JUPFSTSDQjIixSyEJsUxZcJYLnPI/
         lGn/o0rvSe92FIHhmA+ygxLKEv3u011ha2DkJ7GBNz08YzMJYKg5eJnmFacMnqr4/NUH
         TOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+urGfu1jFSm4aWjVX73KCX3G8rm9BJtSYy38Di6nXZQ=;
        b=eOq2zwnidfXr0Wj7FvFu0WBx9DoyAvM1e1hBBFh6FGXOWOjIBobPa6XrnY0ElpY2e9
         GLz5hkz+pe7fEa/CRcnPT7G3D4RpFUjHZxLCdVbXPs12Nofec6r9eRRkkEw90D91q1Ly
         TB6i8l+JPDqp3/sUsRG89cHzJo6kEFnw02O5SD9qhMXaIGRxyGxnLgXd/OnHvaOUZNz3
         Un1Gzg8ObN/lppI7cKbXjRgd+IWB3j0j7cZQVNeJ0SU2vfpwhMwnwYqcdlL3/tBxUc1A
         DeBm75g0jls8IAMpeoGm9emNws/M4MWKqGcoh0nuxRutT+obE9TStSA3cIEdtMZZtQhM
         l6Wg==
X-Gm-Message-State: AOAM531J9ZfXACXGmikmeMe3LXrQoO+3bYDO27tIYQ+SqeF8T4blkc7z
        WBGonMYwl/hlhxsnij5nzrblBNgeyLAIZhIqOBYjiON58Z2/zRK5XCzNfnTmd3AqF0FrGufmrW0
        PX5vINzNitLO2C003P7uqNAq9QPezs7EIjLc4n+f58xUVlDwz/wQ8FAgJEsBlxaE=
X-Google-Smtp-Source: ABdhPJzCzU67tYkFgCTnBOrucVOisGfrzO2T/lkc6n63Gth7ECSwRyVfghL9QSq3A8ANNyd8P136GnNTmpyIpg==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6214:493:: with SMTP id
 ay19mr3889957qvb.36.1607011404394; Thu, 03 Dec 2020 08:03:24 -0800 (PST)
Date:   Thu,  3 Dec 2020 16:02:38 +0000
In-Reply-To: <20201203160245.1014867-1-jackmanb@google.com>
Message-Id: <20201203160245.1014867-8-jackmanb@google.com>
Mime-Version: 1.0
References: <20201203160245.1014867-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next v3 07/14] bpf: Add BPF_FETCH field / create
 atomic_fetch_add instruction
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This value can be set in bpf_insn.imm, for BPF_ATOMIC instructions,
in order to have the previous value of the atomically-modified memory
location loaded into the src register after an atomic op is carried
out.

Suggested-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
Change-Id: I649ad48edb565a32ccdf72924ffe96a8c8da57ad
---
 arch/x86/net/bpf_jit_comp.c    |  4 ++++
 include/linux/filter.h         |  9 +++++++++
 include/uapi/linux/bpf.h       |  3 +++
 kernel/bpf/core.c              | 13 +++++++++++++
 kernel/bpf/disasm.c            |  7 +++++++
 kernel/bpf/verifier.c          | 35 ++++++++++++++++++++++++----------
 tools/include/linux/filter.h   | 10 ++++++++++
 tools/include/uapi/linux/bpf.h |  3 +++
 8 files changed, 74 insertions(+), 10 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5e5a132b3d52..88cb09fa3bfb 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -827,6 +827,10 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
 		/* lock *(u32/u64*)(dst_reg + off) <op>= src_reg */
 		EMIT1(simple_alu_opcodes[atomic_op]);
 		break;
+	case BPF_ADD | BPF_FETCH:
+		/* src_reg = atomic_fetch_add(*(dst_reg + off), src_reg); */
+		EMIT2(0x0F, 0xC1);
+		break;
 	default:
 		pr_err("bpf_jit: unknown atomic opcode %02x\n", atomic_op);
 		return -EFAULT;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index ce19988fb312..4e04d0fc454f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -270,6 +270,15 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 		.imm   = BPF_ADD })
 #define BPF_STX_XADD BPF_ATOMIC_ADD /* alias */
 
+/* Atomic memory add with fetch, src_reg = atomic_fetch_add(*(dst_reg + off), src_reg); */
+
+#define BPF_ATOMIC_FETCH_ADD(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_ADD | BPF_FETCH })
 
 /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d0adc48db43c..025e377e7229 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -44,6 +44,9 @@
 #define BPF_CALL	0x80	/* function call */
 #define BPF_EXIT	0x90	/* function return */
 
+/* atomic op type fields (stored in immediate) */
+#define BPF_FETCH	0x01	/* fetch previous value into src reg */
+
 /* Register numbers */
 enum {
 	BPF_REG_0 = 0,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3abc6b250b18..61e93eb7d363 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1624,16 +1624,29 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 			/* lock xadd *(u32 *)(dst_reg + off16) += src_reg */
 			atomic_add((u32) SRC, (atomic_t *)(unsigned long)
 				   (DST + insn->off));
+			break;
+		case BPF_ADD | BPF_FETCH:
+			SRC = (u32) atomic_fetch_add(
+				(u32) SRC,
+				(atomic_t *)(unsigned long) (DST + insn->off));
+			break;
 		default:
 			goto default_label;
 		}
 		CONT;
+
 	STX_ATOMIC_DW:
 		switch (IMM) {
 		case BPF_ADD:
 			/* lock xadd *(u64 *)(dst_reg + off16) += src_reg */
 			atomic64_add((u64) SRC, (atomic64_t *)(unsigned long)
 				     (DST + insn->off));
+			break;
+		case BPF_ADD | BPF_FETCH:
+			SRC = (u64) atomic64_fetch_add(
+				(u64) SRC,
+				(atomic64_t *)(s64) (DST + insn->off));
+			break;
 		default:
 			goto default_label;
 		}
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 37c8d6e9b4cc..3ee2246a52ef 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -160,6 +160,13 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off,
 				insn->src_reg);
+		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+			   insn->imm == (BPF_ADD | BPF_FETCH)) {
+			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_add(*(%s *)(r%d %+d), r%d)\n",
+				insn->code, insn->src_reg,
+				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
+				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+				insn->dst_reg, insn->off, insn->src_reg);
 		} else {
 			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e8b41ccdfb90..a68adbcee370 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3602,7 +3602,11 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 {
 	int err;
 
-	if (insn->imm != BPF_ADD) {
+	switch (insn->imm) {
+	case BPF_ADD:
+	case BPF_ADD | BPF_FETCH:
+		break;
+	default:
 		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
 		return -EINVAL;
 	}
@@ -3631,7 +3635,7 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	    is_pkt_reg(env, insn->dst_reg) ||
 	    is_flow_key_reg(env, insn->dst_reg) ||
 	    is_sk_reg(env, insn->dst_reg)) {
-		verbose(env, "atomic stores into R%d %s is not allowed\n",
+		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
 			insn->dst_reg,
 			reg_type_str[reg_state(env, insn->dst_reg)->type]);
 		return -EACCES;
@@ -3644,8 +3648,20 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 		return err;
 
 	/* check whether we can write into the same memory */
-	return check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-				BPF_SIZE(insn->code), BPF_WRITE, -1, true);
+	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
+			       BPF_SIZE(insn->code), BPF_WRITE, -1, true);
+	if (err)
+		return err;
+
+	if (!(insn->imm & BPF_FETCH))
+		return 0;
+
+	/* check and record load of old value into src reg  */
+	err = check_reg_arg(env, insn->src_reg, DST_OP);
+	if (err)
+		return err;
+
+	return 0;
 }
 
 static int __check_stack_boundary(struct bpf_verifier_env *env, u32 regno,
@@ -9501,12 +9517,6 @@ static int do_check(struct bpf_verifier_env *env)
 		} else if (class == BPF_STX) {
 			enum bpf_reg_type *prev_dst_type, dst_reg_type;
 
-			if (((BPF_MODE(insn->code) != BPF_MEM &&
-			      BPF_MODE(insn->code) != BPF_ATOMIC) || insn->imm != 0)) {
-				verbose(env, "BPF_STX uses reserved fields\n");
-				return -EINVAL;
-			}
-
 			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
 				err = check_atomic(env, env->insn_idx, insn);
 				if (err)
@@ -9515,6 +9525,11 @@ static int do_check(struct bpf_verifier_env *env)
 				continue;
 			}
 
+			if (BPF_MODE(insn->code) != BPF_MEM || insn->imm != 0) {
+				verbose(env, "BPF_STX uses reserved fields\n");
+				return -EINVAL;
+			}
+
 			/* check src1 operand */
 			err = check_reg_arg(env, insn->src_reg, SRC_OP);
 			if (err)
diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index 95ff51d97f25..ac7701678e1a 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -180,6 +180,16 @@
 		.imm   = BPF_ADD })
 #define BPF_STX_XADD BPF_ATOMIC_ADD /* alias */
 
+/* Atomic memory add with fetch, src_reg = atomic_fetch_add(*(dst_reg + off), src_reg); */
+
+#define BPF_ATOMIC_FETCH_ADD(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_ADD | BPF_FETCH })
+
 /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
 
 #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d0adc48db43c..025e377e7229 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -44,6 +44,9 @@
 #define BPF_CALL	0x80	/* function call */
 #define BPF_EXIT	0x90	/* function return */
 
+/* atomic op type fields (stored in immediate) */
+#define BPF_FETCH	0x01	/* fetch previous value into src reg */
+
 /* Register numbers */
 enum {
 	BPF_REG_0 = 0,
-- 
2.29.2.454.gaff20da3a2-goog

