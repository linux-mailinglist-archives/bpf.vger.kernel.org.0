Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED1D69C232
	for <lists+bpf@lfdr.de>; Sun, 19 Feb 2023 21:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjBSUEp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Feb 2023 15:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjBSUEo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Feb 2023 15:04:44 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4E617144
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 12:04:41 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id en26so3881996edb.13
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 12:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CwmcQT3bBeBudlfFt0gftQdK1RY3N3uTlhK4HCW0Q4=;
        b=dCJ9f4GPvCoLnTPk8ip8U2vBeOdagujxklxHqZR1dOD0KhwyJEahNnn2G0JPuSe1cG
         G4mWTheZwUR32ShDccKsxIsA+09r/LY5O9lQkfxcpMEWf6RsGEhcKHZ088/1/VXOpLmY
         oWIpFC8cb7yFOr+1o6IKe0rkzq+pCp1WxZnPsf6lxs26QAtvlt6XD0ArmxBIiKlyG+GN
         0m6EUwMbqVqmxgc71Vs694CJGrnBZ4s+E6nk+i2TQTh+0wwPF3VpKyJopBtM9AYKHENs
         ivokk+OzAX3euSgj3ZST76MHxi0eb8e9k5cqj4OzH5T27iLptY5T1YLPbCesARwcu3qM
         i74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CwmcQT3bBeBudlfFt0gftQdK1RY3N3uTlhK4HCW0Q4=;
        b=sCUpIyubcXI4ZFsFVLb9a754EWGPOalApB6qGjvbQ5g4ETQNwG6y/YzkAVsqCLLyqt
         SslZOJFGzLHBvYYTdUKvlWKD4mWiW0C16NuX5Bm3NG9CsChu3tVqHg2dCc92KTClk82x
         ZQEL59HZBeBItMzZyKJQos/ffxHCEq3rZCiHO8XsKlv4yt05k57ji2LKQqHc5qlaCE86
         zo1WwpFepyTVAHbBZFgRRLhxkxgqbr5lQKylzCI5+zE4+1Usrn+UIMGrKTX1W51stbi/
         HOk10wZjKkPB/VAn2AGQeSZxttZ3bTQhHHtPTBIv+br3d6nFly5W2oqJpDJeXFukOzpC
         V8cg==
X-Gm-Message-State: AO0yUKV9lwV72ehh5NXKGjy0YRziqTKI+VCudrWPtG5VIY743kiEnUVG
        8GXRMYOiNLwSWXOSkUGxQO+UmPpEU5PlHw==
X-Google-Smtp-Source: AK7set/E6XySMC8lhOqI6PvLsihgE5QyLIoIUXEkTUrk48xfZn8LGBEBqER4DsciJvbrK3xgRt1JgA==
X-Received: by 2002:a17:907:ea2:b0:888:b764:54e5 with SMTP id ho34-20020a1709070ea200b00888b76454e5mr7802043ejc.71.1676837079315;
        Sun, 19 Feb 2023 12:04:39 -0800 (PST)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090629cf00b008caaae1f1e1sm1124035eje.110.2023.02.19.12.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 12:04:38 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Allow reads from uninit stack
Date:   Sun, 19 Feb 2023 22:04:26 +0200
Message-Id: <20230219200427.606541-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230219200427.606541-1-eddyz87@gmail.com>
References: <20230219200427.606541-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commits updates the following functions to allow reads from
uninitialized stack locations when env->allow_uninit_stack option is
enabled:
- check_stack_read_fixed_off()
- check_stack_range_initialized(), called from:
  - check_stack_read_var_off()
  - check_helper_mem_access()

Such change allows to relax logic in stacksafe() to treat STACK_MISC
and STACK_INVALID in a same way and make the following stack slot
configurations equivalent:

  |  Cached state    |  Current state   |
  |   stack slot     |   stack slot     |
  |------------------+------------------|
  | STACK_INVALID or | STACK_INVALID or |
  | STACK_MISC       | STACK_SPILL   or |
  |                  | STACK_MISC    or |
  |                  | STACK_ZERO    or |
  |                  | STACK_DYNPTR     |

This leads to significant verification speed gains (see below).

The idea was suggested by Andrii Nakryiko [1] and initial patch was
created by Alexei Starovoitov [2].

Currently the env->allow_uninit_stack is allowed for programs loaded
by users with CAP_PERFMON or CAP_SYS_ADMIN capabilities.

A number of test cases from verifier/*.c were expecting uninitialized
stack access to be an error. These test cases were updated to execute
in unprivileged mode (thus preserving the tests).

The test progs/test_global_func10.c expected "invalid indirect read
from stack" error message because of the access to uninitialized
memory region. This error is no longer possible in privileged mode.
The test is updated to provoke an error "invalid indirect access to
stack" because of access to invalid stack address (such error is not
verified by progs/test_global_func*.c series of tests).

The following tests had to be removed because these can't be made
unprivileged:
- verifier/sock.c:
  - "sk_storage_get(map, skb->sk, &stack_value, 1): partially init
  stack_value"
  BPF_PROG_TYPE_SCHED_CLS programs are not executed in unprivileged mode.
- verifier/var_off.c:
  - "indirect variable-offset stack access, max_off+size > max_initialized"
  - "indirect variable-offset stack access, uninitialized"
  These tests verify that access to uninitialized stack values is
  detected when stack offset is not a constant. However, variable
  stack access is prohibited in unprivileged mode, thus these tests
  are no longer valid.

 * * *

Here is veristat log comparing this patch with current master on a
set of selftest binaries listed in tools/testing/selftests/bpf/veristat.cfg
and cilium BPF binaries (see [3]):

$ ./veristat -e file,prog,states -C -f 'states_pct<-30' master.log current.log
File                        Program                     States (A)  States (B)  States    (DIFF)
--------------------------  --------------------------  ----------  ----------  ----------------
bpf_host.o                  tail_handle_ipv6_from_host         349         244    -105 (-30.09%)
bpf_host.o                  tail_handle_nat_fwd_ipv4          1320         895    -425 (-32.20%)
bpf_lxc.o                   tail_handle_nat_fwd_ipv4          1320         895    -425 (-32.20%)
bpf_sock.o                  cil_sock4_connect                   70          48     -22 (-31.43%)
bpf_sock.o                  cil_sock4_sendmsg                   68          46     -22 (-32.35%)
bpf_xdp.o                   tail_handle_nat_fwd_ipv4          1554         803    -751 (-48.33%)
bpf_xdp.o                   tail_lb_ipv4                      6457        2473   -3984 (-61.70%)
bpf_xdp.o                   tail_lb_ipv6                      7249        3908   -3341 (-46.09%)
pyperf600_bpf_loop.bpf.o    on_event                           287         145    -142 (-49.48%)
strobemeta.bpf.o            on_event                         15915        4772  -11143 (-70.02%)
strobemeta_nounroll2.bpf.o  on_event                         17087        3820  -13267 (-77.64%)
xdp_synproxy_kern.bpf.o     syncookie_tc                     21271        6635  -14636 (-68.81%)
xdp_synproxy_kern.bpf.o     syncookie_xdp                    23122        6024  -17098 (-73.95%)
--------------------------  --------------------------  ----------  ----------  ----------------

Note: I limited selection by states_pct<-30%.

Inspection of differences in pyperf600_bpf_loop behavior shows that
the following patch for the test removes almost all differences:

    - a/tools/testing/selftests/bpf/progs/pyperf.h
    + b/tools/testing/selftests/bpf/progs/pyperf.h
    @ -266,8 +266,8 @ int __on_event(struct bpf_raw_tracepoint_args *ctx)
            }

            if (event->pthread_match || !pidData->use_tls) {
    -               void* frame_ptr;
    -               FrameData frame;
    +               void* frame_ptr = 0;
    +               FrameData frame = {};
                    Symbol sym = {};
                    int cur_cpu = bpf_get_smp_processor_id();

W/o this patch the difference comes from the following pattern
(for different variables):

    static bool get_frame_data(... FrameData *frame ...)
    {
        ...
        bpf_probe_read_user(&frame->f_code, ...);
        if (!frame->f_code)
            return false;
        ...
        bpf_probe_read_user(&frame->co_name, ...);
        if (frame->co_name)
            ...;
    }

    int __on_event(struct bpf_raw_tracepoint_args *ctx)
    {
        FrameData frame;
        ...
        get_frame_data(... &frame ...) // indirectly via a bpf_loop & callback
        ...
    }

    SEC("raw_tracepoint/kfree_skb")
    int on_event(struct bpf_raw_tracepoint_args* ctx)
    {
        ...
        ret |= __on_event(ctx);
        ret |= __on_event(ctx);
        ...
    }

With regards to value `frame->co_name` the following is important:
- Because of the conditional `if (!frame->f_code)` each call to
  __on_event() produces two states, one with `frame->co_name` marked
  as STACK_MISC, another with it as is (and marked STACK_INVALID on a
  first call).
- The call to bpf_probe_read_user() does not mark stack slots
  corresponding to `&frame->co_name` as REG_LIVE_WRITTEN but it marks
  these slots as BPF_MISC, this happens because of the following loop
  in the check_helper_call():

	for (i = 0; i < meta.access_size; i++) {
		err = check_mem_access(env, insn_idx, meta.regno, i, BPF_B,
				       BPF_WRITE, -1, false);
		if (err)
			return err;
	}

  Note the size of the write, it is a one byte write for each byte
  touched by a helper. The BPF_B write does not lead to write marks
  for the target stack slot.
- Which means that w/o this patch when second __on_event() call is
  verified `if (frame->co_name)` will propagate read marks first to a
  stack slot with STACK_MISC marks and second to a stack slot with
  STACK_INVALID marks and these states would be considered different.

[1] https://lore.kernel.org/bpf/CAEf4BzY3e+ZuC6HUa8dCiUovQRg2SzEk7M-dSkqNZyn=xEmnPA@mail.gmail.com/
[2] https://lore.kernel.org/bpf/CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com/
[3] git@github.com:anakryiko/cilium.git

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Co-developed-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c                         |  11 +-
 .../selftests/bpf/progs/test_global_func10.c  |   8 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  13 ++-
 .../bpf/verifier/helper_access_var_len.c      | 104 ++++++++++++------
 .../testing/selftests/bpf/verifier/int_ptr.c  |   9 +-
 .../selftests/bpf/verifier/search_pruning.c   |  13 ++-
 tools/testing/selftests/bpf/verifier/sock.c   |  27 -----
 .../selftests/bpf/verifier/spill_fill.c       |   7 +-
 .../testing/selftests/bpf/verifier/var_off.c  |  52 ---------
 9 files changed, 108 insertions(+), 136 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 272563a0b770..d517d13878cf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3826,6 +3826,8 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 						continue;
 					if (type == STACK_MISC)
 						continue;
+					if (type == STACK_INVALID && env->allow_uninit_stack)
+						continue;
 					verbose(env, "invalid read from stack off %d+%d size %d\n",
 						off, i, size);
 					return -EACCES;
@@ -3863,6 +3865,8 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				continue;
 			if (type == STACK_ZERO)
 				continue;
+			if (type == STACK_INVALID && env->allow_uninit_stack)
+				continue;
 			verbose(env, "invalid read from stack off %d+%d size %d\n",
 				off, i, size);
 			return -EACCES;
@@ -5754,7 +5758,8 @@ static int check_stack_range_initialized(
 		stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
 		if (*stype == STACK_MISC)
 			goto mark;
-		if (*stype == STACK_ZERO) {
+		if ((*stype == STACK_ZERO) ||
+		    (*stype == STACK_INVALID && env->allow_uninit_stack)) {
 			if (clobber) {
 				/* helper can write anything into the stack */
 				*stype = STACK_MISC;
@@ -13936,6 +13941,10 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_INVALID)
 			continue;
 
+		if (env->allow_uninit_stack &&
+		    old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_MISC)
+			continue;
+
 		/* explored stack has more populated slots than current stack
 		 * and these slots were used
 		 */
diff --git a/tools/testing/selftests/bpf/progs/test_global_func10.c b/tools/testing/selftests/bpf/progs/test_global_func10.c
index 98327bdbbfd2..8fba3f3649e2 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func10.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func10.c
@@ -5,12 +5,12 @@
 #include "bpf_misc.h"
 
 struct Small {
-	int x;
+	long x;
 };
 
 struct Big {
-	int x;
-	int y;
+	long x;
+	long y;
 };
 
 __noinline int foo(const struct Big *big)
@@ -22,7 +22,7 @@ __noinline int foo(const struct Big *big)
 }
 
 SEC("cgroup_skb/ingress")
-__failure __msg("invalid indirect read from stack")
+__failure __msg("invalid indirect access to stack")
 int global_func10(struct __sk_buff *skb)
 {
 	const struct Small small = {.x = skb->len };
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 9d993926bf0e..289ed202ec66 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -2221,19 +2221,22 @@
 	 * that fp-8 stack slot was unused in the fall-through
 	 * branch and will accept the program incorrectly
 	 */
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_1, 2, 2),
+	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
+	BPF_JMP_IMM(BPF_JGT, BPF_REG_0, 2, 2),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_48b = { 6 },
-	.errstr = "invalid indirect read from stack R2 off -8+0 size 8",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_XDP,
+	.fixup_map_hash_48b = { 7 },
+	.errstr_unpriv = "invalid indirect read from stack R2 off -8+0 size 8",
+	.result_unpriv = REJECT,
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"calls: ctx read at start of subprog",
diff --git a/tools/testing/selftests/bpf/verifier/helper_access_var_len.c b/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
index a6c869a7319c..9c4885885aba 100644
--- a/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
+++ b/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
@@ -29,19 +29,30 @@
 {
 	"helper access to variable memory: stack, bitwise AND, zero included",
 	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 64),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
+	/* set max stack size */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -128, 0),
+	/* set r3 to a random value */
+	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
+	/* use bitwise AND to limit r3 range to [0, 64] */
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_3, 64),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -64),
+	BPF_MOV64_IMM(BPF_REG_4, 0),
+	/* Call bpf_ringbuf_output(), it is one of a few helper functions with
+	 * ARG_CONST_SIZE_OR_ZERO parameter allowed in unpriv mode.
+	 * For unpriv this should signal an error, because memory at &fp[-64] is
+	 * not initialized.
+	 */
+	BPF_EMIT_CALL(BPF_FUNC_ringbuf_output),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid indirect read from stack R1 off -64+0 size 64",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.fixup_map_ringbuf = { 4 },
+	.errstr_unpriv = "invalid indirect read from stack R2 off -64+0 size 64",
+	.result_unpriv = REJECT,
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"helper access to variable memory: stack, bitwise AND + JMP, wrong max",
@@ -183,20 +194,31 @@
 {
 	"helper access to variable memory: stack, JMP, no min check",
 	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 64, 3),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
+	/* set max stack size */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -128, 0),
+	/* set r3 to a random value */
+	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
+	/* use JMP to limit r3 range to [0, 64] */
+	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, 64, 6),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -64),
+	BPF_MOV64_IMM(BPF_REG_4, 0),
+	/* Call bpf_ringbuf_output(), it is one of a few helper functions with
+	 * ARG_CONST_SIZE_OR_ZERO parameter allowed in unpriv mode.
+	 * For unpriv this should signal an error, because memory at &fp[-64] is
+	 * not initialized.
+	 */
+	BPF_EMIT_CALL(BPF_FUNC_ringbuf_output),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid indirect read from stack R1 off -64+0 size 64",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.fixup_map_ringbuf = { 4 },
+	.errstr_unpriv = "invalid indirect read from stack R2 off -64+0 size 64",
+	.result_unpriv = REJECT,
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"helper access to variable memory: stack, JMP (signed), no min check",
@@ -564,29 +586,41 @@
 {
 	"helper access to variable memory: 8 bytes leak",
 	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
+	/* set max stack size */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -128, 0),
+	/* set r3 to a random value */
+	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -64),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -64),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -56),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -48),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -40),
+	/* Note: fp[-32] left uninitialized */
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -24),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -128),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 63),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
+	/* Limit r3 range to [1, 64] */
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_3, 63),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 1),
+	BPF_MOV64_IMM(BPF_REG_4, 0),
+	/* Call bpf_ringbuf_output(), it is one of a few helper functions with
+	 * ARG_CONST_SIZE_OR_ZERO parameter allowed in unpriv mode.
+	 * For unpriv this should signal an error, because memory region [1, 64]
+	 * at &fp[-64] is not fully initialized.
+	 */
+	BPF_EMIT_CALL(BPF_FUNC_ringbuf_output),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid indirect read from stack R1 off -64+32 size 64",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.fixup_map_ringbuf = { 3 },
+	.errstr_unpriv = "invalid indirect read from stack R2 off -64+32 size 64",
+	.result_unpriv = REJECT,
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"helper access to variable memory: 8 bytes no leak (init memory)",
diff --git a/tools/testing/selftests/bpf/verifier/int_ptr.c b/tools/testing/selftests/bpf/verifier/int_ptr.c
index 070893fb2900..02d9e004260b 100644
--- a/tools/testing/selftests/bpf/verifier/int_ptr.c
+++ b/tools/testing/selftests/bpf/verifier/int_ptr.c
@@ -54,12 +54,13 @@
 		/* bpf_strtoul() */
 		BPF_EMIT_CALL(BPF_FUNC_strtoul),
 
-		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	},
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL,
-	.errstr = "invalid indirect read from stack R4 off -16+4 size 8",
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "invalid indirect read from stack R4 off -16+4 size 8",
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"ARG_PTR_TO_LONG misaligned",
diff --git a/tools/testing/selftests/bpf/verifier/search_pruning.c b/tools/testing/selftests/bpf/verifier/search_pruning.c
index d63fd8991b03..745d6b5842fd 100644
--- a/tools/testing/selftests/bpf/verifier/search_pruning.c
+++ b/tools/testing/selftests/bpf/verifier/search_pruning.c
@@ -128,9 +128,10 @@
 		BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 3 },
-	.errstr = "invalid read from stack off -16+0 size 8",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.errstr_unpriv = "invalid read from stack off -16+0 size 8",
+	.result_unpriv = REJECT,
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"precision tracking for u32 spill/fill",
@@ -258,6 +259,8 @@
 	BPF_EXIT_INSN(),
 	},
 	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr = "invalid read from stack off -8+1 size 8",
-	.result = REJECT,
+	.errstr_unpriv = "invalid read from stack off -8+1 size 8",
+	.result_unpriv = REJECT,
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
diff --git a/tools/testing/selftests/bpf/verifier/sock.c b/tools/testing/selftests/bpf/verifier/sock.c
index d11d0b28be41..108dd3ee1edd 100644
--- a/tools/testing/selftests/bpf/verifier/sock.c
+++ b/tools/testing/selftests/bpf/verifier/sock.c
@@ -530,33 +530,6 @@
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = ACCEPT,
 },
-{
-	"sk_storage_get(map, skb->sk, &stack_value, 1): partially init stack_value",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_2, -8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_4, 1),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -8),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_storage_get),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_sk_storage_map = { 14 },
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = REJECT,
-	.errstr = "invalid indirect read from stack",
-},
 {
 	"bpf_map_lookup_elem(smap, &key)",
 	.insns = {
diff --git a/tools/testing/selftests/bpf/verifier/spill_fill.c b/tools/testing/selftests/bpf/verifier/spill_fill.c
index 9bb302dade23..d1463bf4949a 100644
--- a/tools/testing/selftests/bpf/verifier/spill_fill.c
+++ b/tools/testing/selftests/bpf/verifier/spill_fill.c
@@ -171,9 +171,10 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.result = REJECT,
-	.errstr = "invalid read from stack off -4+0 size 4",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "invalid read from stack off -4+0 size 4",
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"Spill a u32 const scalar.  Refill as u16.  Offset to skb->data",
diff --git a/tools/testing/selftests/bpf/verifier/var_off.c b/tools/testing/selftests/bpf/verifier/var_off.c
index d37f512fad16..b183e26c03f1 100644
--- a/tools/testing/selftests/bpf/verifier/var_off.c
+++ b/tools/testing/selftests/bpf/verifier/var_off.c
@@ -212,31 +212,6 @@
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_LWT_IN,
 },
-{
-	"indirect variable-offset stack access, max_off+size > max_initialized",
-	.insns = {
-	/* Fill only the second from top 8 bytes of the stack. */
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0),
-	/* Get an unknown value. */
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
-	/* Make it small and 4-byte aligned. */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 4),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 16),
-	/* Add it to fp.  We now have either fp-12 or fp-16, but we don't know
-	 * which. fp-12 size 8 is partially uninitialized stack.
-	 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
-	/* Dereference it indirectly. */
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.errstr = "invalid indirect read from stack R2 var_off",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_LWT_IN,
-},
 {
 	"indirect variable-offset stack access, min_off < min_initialized",
 	.insns = {
@@ -289,33 +264,6 @@
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
 },
-{
-	"indirect variable-offset stack access, uninitialized",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 6),
-	BPF_MOV64_IMM(BPF_REG_3, 28),
-	/* Fill the top 16 bytes of the stack. */
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -16, 0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	/* Get an unknown value. */
-	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1, 0),
-	/* Make it small and 4-byte aligned. */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_4, 4),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_4, 16),
-	/* Add it to fp.  We now have either fp-12 or fp-16, we don't know
-	 * which, but either way it points to initialized stack.
-	 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_10),
-	BPF_MOV64_IMM(BPF_REG_5, 8),
-	/* Dereference it indirectly. */
-	BPF_EMIT_CALL(BPF_FUNC_getsockopt),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "invalid indirect read from stack R4 var_off",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SOCK_OPS,
-},
 {
 	"indirect variable-offset stack access, ok",
 	.insns = {
-- 
2.39.1

