Return-Path: <bpf+bounces-55793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD50BA86737
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 22:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE53467322
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 20:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A44A293479;
	Fri, 11 Apr 2025 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K3NVb9Cq"
X-Original-To: bpf@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B2E283C8A;
	Fri, 11 Apr 2025 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403552; cv=none; b=cSXwS3ePB5PbtehNJ5ovidiEMvbGl3ze4Knqc4YcANqIV/lL0vlKu8MYiqtVkVJ6rhlNhwyiJkoORFO+F+WYKBBp9azDNWDRBmP8WahysAfxVlmNgAf2zS/Y3YHES89Lw46O6zKVEG+xKldAYXLR5/IVJOoyGr1J5fe1z6Die/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403552; c=relaxed/simple;
	bh=wxnQ0ttI+gxkqntD0fF99Mhv0sfuyDUXwOM1qxLQaXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MSNtWKWqZXr0J68Suc+ytoQpK9+OO3eWk4wsufbDde94qwlBgF4R3hagG5zBxZAELLNe0rHmc7C1j+mq9Elwy8JRVfXDnsHuE+GzeADBRzcimQEih7b77TdfyzB/UJaX5A2KI9tJqbu6wDNo0Kt7M9CT8JZSbG/zVM977oXPCVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K3NVb9Cq; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA9D5439EE;
	Fri, 11 Apr 2025 20:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744403542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ec28mwfnSBXDui4uhcD+4fTqV49TTiQGTbLP7ywekj0=;
	b=K3NVb9CqxwIVa5GBFmmnfNIejUKa7TPH67HXLOQbeIMGv/nyA8hAPhYvtX4u788aqOprmI
	7IPQ53KmzL4KEO35oQ7Pw1EinQfPoZmXsm/7NVRf0yzEMHh/zcXBUTeSAGbbjnH5ftKt9C
	lyTgu52YADl265PVzGvkqAMmRyg76Ojabkw4dDxFo0xu0E976brSf5mBbk2z6zZQd+v6BW
	WnrxPjlxcdh9c8naQTUrw+DCFAwQdeRpRFiA6LoVF4etSovHNUabLmLeQv98gtFdnmzA6N
	W/45Ybb4Md3QnP+ykRalkxm9n+vrin5L01HRT3aCzRYKRxH3T4UaAyvyhzyLNQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Fri, 11 Apr 2025 22:32:11 +0200
Subject: [PATCH RFC bpf-next 2/4] bpf, arm64: Support up to 12 function
 arguments
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-many_args_arm64-v1-2-0a32fe72339e@bootlin.com>
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
In-Reply-To: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Florent Revest <revest@chromium.org>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>, 
 Xu Kuohai <xukuohai@huawei.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddvjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeghfetffeuhfehkeekleffffdvuefggfevjefftddvffduheettdeiveetteenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplgduledvrdduieekrddurdduleejngdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedupdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhmvgdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopeiguhhkuhhohhgriheshhhurgifvghitghlohhuugdrtghomhdprhgtphhtthhopehjohhlshgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgihis
 hdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehmhihkohhlrghlsehfsgdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgtohhquhgvlhhinhdrshhtmhefvdesghhmrghilhdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

From: Xu Kuohai <xukuohai@huawei.com>

Currently ARM64 bpf trampoline supports up to 8 function arguments.
According to the statistics from commit
473e3150e30a ("bpf, x86: allow function arguments up to 12 for TRACING"),
there are about 200 functions accept 9 to 12 arguments, so adding support
for up to 12 function arguments.

Due to bpf only supporting function arguments up to 16 bytes, according to
AAPCS64, starting from the first argument, each argument is first
attempted to be loaded to 1 or 2 smallest registers from x0-x7, if there
are no enough registers to hold the entire argument, then all remaining
arguments starting from this one are pushed to the stack for passing.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Co-developed-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 arch/arm64/net/bpf_jit_comp.c | 235 ++++++++++++++++++++++++++++++++----------
 1 file changed, 182 insertions(+), 53 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 70d7c89d3ac907798e86e0051e7b472c252c1412..3618f42b1a0019590d47db0ec0fce1f9f51b01af 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2064,7 +2064,7 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 }
 
 static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
-			    int args_off, int retval_off, int run_ctx_off,
+			    int bargs_off, int retval_off, int run_ctx_off,
 			    bool save_ret)
 {
 	__le32 *branch;
@@ -2106,7 +2106,7 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 	branch = ctx->image + ctx->idx;
 	emit(A64_NOP, ctx);
 
-	emit(A64_ADD_I(1, A64_R(0), A64_SP, args_off), ctx);
+	emit(A64_ADD_I(1, A64_R(0), A64_SP, bargs_off), ctx);
 	if (!p->jited)
 		emit_addr_mov_i64(A64_R(1), (const u64)p->insnsi, ctx);
 
@@ -2131,7 +2131,7 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 }
 
 static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
-			       int args_off, int retval_off, int run_ctx_off,
+			       int bargs_off, int retval_off, int run_ctx_off,
 			       __le32 **branches)
 {
 	int i;
@@ -2141,7 +2141,7 @@ static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
 	 */
 	emit(A64_STR64I(A64_ZR, A64_SP, retval_off), ctx);
 	for (i = 0; i < tl->nr_links; i++) {
-		invoke_bpf_prog(ctx, tl->links[i], args_off, retval_off,
+		invoke_bpf_prog(ctx, tl->links[i], bargs_off, retval_off,
 				run_ctx_off, true);
 		/* if (*(u64 *)(sp + retval_off) !=  0)
 		 *	goto do_fexit;
@@ -2155,23 +2155,142 @@ static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
 	}
 }
 
-static void save_args(struct jit_ctx *ctx, int args_off, int nregs)
+struct arg_aux {
+	/* how many args are passed through registers, the rest of the args are
+	 * passed through stack
+	 */
+	int args_in_regs;
+	/* how many registers are used to pass arguments */
+	int regs_for_args;
+	/* how much stack is used for additional args passed to bpf program
+	 * that did not fit in original function registers
+	 **/
+	int bstack_for_args;
+	/* home much stack is used for additional args passed to the
+	 * original function when called from trampoline (this one needs
+	 * arguments to be properly aligned)
+	 */
+	int ostack_for_args;
+	u8 arg_align[MAX_BPF_FUNC_ARGS];
+};
+
+static u8 calc_arg_align(const struct btf_func_model *m, int i)
+{
+	if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
+		return max(8, m->arg_largest_member_size[i]);
+	return max(8, m->arg_size[i]);
+}
+
+static void calc_arg_aux(const struct btf_func_model *m,
+			 struct arg_aux *a)
 {
 	int i;
+	int nregs;
+	int slots;
+	int stack_slots;
+
+	for (i = 0; i < m->nr_args; i++)
+		a->arg_align[i] = calc_arg_align(m, i);
+
+	/* verifier ensures m->nr_args <= MAX_BPF_FUNC_ARGS */
+	for (i = 0, nregs = 0; i < m->nr_args; i++) {
+		slots = (m->arg_size[i] + 7) / 8;
+		if (nregs + slots <= 8) /* passed through register ? */
+			nregs += slots;
+		else
+			break;
+	}
 
-	for (i = 0; i < nregs; i++) {
-		emit(A64_STR64I(i, A64_SP, args_off), ctx);
-		args_off += 8;
+	a->args_in_regs = i;
+	a->regs_for_args = nregs;
+	a->ostack_for_args = 0;
+
+	/* the rest arguments are passed through stack */
+	for (a->ostack_for_args = 0, a->bstack_for_args = 0;
+	     i < m->nr_args; i++) {
+		stack_slots = (m->arg_size[i] + 7) / 8;
+		/* AAPCS 64 C.14: arguments passed on stack must be aligned to
+		 * max(8, arg_natural_alignment)
+		 */
+		a->bstack_for_args += stack_slots * 8;
+		a->ostack_for_args = round_up(a->ostack_for_args +
+				stack_slots * 8, a->arg_align[i]);
+	}
+}
+
+static void clear_garbage(struct jit_ctx *ctx, int reg, int effective_bytes)
+{
+	if (effective_bytes) {
+		int garbage_bits = 64 - 8 * effective_bytes;
+#ifdef CONFIG_CPU_BIG_ENDIAN
+		/* garbage bits are at the right end */
+		emit(A64_LSR(1, reg, reg, garbage_bits), ctx);
+		emit(A64_LSL(1, reg, reg, garbage_bits), ctx);
+#else
+		/* garbage bits are at the left end */
+		emit(A64_LSL(1, reg, reg, garbage_bits), ctx);
+		emit(A64_LSR(1, reg, reg, garbage_bits), ctx);
+#endif
 	}
 }
 
-static void restore_args(struct jit_ctx *ctx, int args_off, int nregs)
+static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
+		      const struct btf_func_model *m,
+		      const struct arg_aux *a,
+		      bool for_call_origin)
 {
 	int i;
+	int reg;
+	int doff;
+	int soff;
+	int slots;
+	u8 tmp = bpf2a64[TMP_REG_1];
+
+	/* store arguments to the stack for the bpf program, or restore
+	 * arguments from stack for the original function
+	 */
+	for (reg = 0; reg < a->regs_for_args; reg++) {
+		emit(for_call_origin ?
+		     A64_LDR64I(reg, A64_SP, bargs_off) :
+		     A64_STR64I(reg, A64_SP, bargs_off),
+		     ctx);
+		bargs_off += 8;
+	}
+
+	soff = 32; /* on stack arguments start from FP + 32 */
+	doff = (for_call_origin ? oargs_off : bargs_off);
+
+	/* save on stack arguments */
+	for (i = a->args_in_regs; i < m->nr_args; i++) {
+		slots = (m->arg_size[i] + 7) / 8;
+		/* AAPCS C.14: additional arguments on stack must be
+		 * aligned on max(8, arg_natural_alignment)
+		 */
+		soff = round_up(soff, a->arg_align[i]);
+		if (for_call_origin)
+			doff =  round_up(doff, a->arg_align[i]);
+		/* verifier ensures arg_size <= 16, so slots equals 1 or 2 */
+		while (slots-- > 0) {
+			emit(A64_LDR64I(tmp, A64_FP, soff), ctx);
+			/* if there is unused space in the last slot, clear
+			 * the garbage contained in the space.
+			 */
+			if (slots == 0 && !for_call_origin)
+				clear_garbage(ctx, tmp, m->arg_size[i] % 8);
+			emit(A64_STR64I(tmp, A64_SP, doff), ctx);
+			soff += 8;
+			doff += 8;
+		}
+	}
+}
 
-	for (i = 0; i < nregs; i++) {
-		emit(A64_LDR64I(i, A64_SP, args_off), ctx);
-		args_off += 8;
+static void restore_args(struct jit_ctx *ctx, int bargs_off, int nregs)
+{
+	int reg;
+
+	for (reg = 0; reg < nregs; reg++) {
+		emit(A64_LDR64I(reg, A64_SP, bargs_off), ctx);
+		bargs_off += 8;
 	}
 }
 
@@ -2194,17 +2313,21 @@ static bool is_struct_ops_tramp(const struct bpf_tramp_links *fentry_links)
  */
 static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 			      struct bpf_tramp_links *tlinks, void *func_addr,
-			      int nregs, u32 flags)
+			      const struct btf_func_model *m,
+			      const struct arg_aux *a,
+			      u32 flags)
 {
 	int i;
 	int stack_size;
 	int retaddr_off;
 	int regs_off;
 	int retval_off;
-	int args_off;
-	int nregs_off;
+	int bargs_off;
+	int nfuncargs_off;
 	int ip_off;
 	int run_ctx_off;
+	int oargs_off;
+	int nfuncargs;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
@@ -2213,31 +2336,38 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	bool is_struct_ops = is_struct_ops_tramp(fentry);
 
 	/* trampoline stack layout:
-	 *                  [ parent ip         ]
-	 *                  [ FP                ]
-	 * SP + retaddr_off [ self ip           ]
-	 *                  [ FP                ]
+	 *                    [ parent ip         ]
+	 *                    [ FP                ]
+	 * SP + retaddr_off   [ self ip           ]
+	 *                    [ FP                ]
 	 *
-	 *                  [ padding           ] align SP to multiples of 16
+	 *                    [ padding           ] align SP to multiples of 16
 	 *
-	 *                  [ x20               ] callee saved reg x20
-	 * SP + regs_off    [ x19               ] callee saved reg x19
+	 *                    [ x20               ] callee saved reg x20
+	 * SP + regs_off      [ x19               ] callee saved reg x19
 	 *
-	 * SP + retval_off  [ return value      ] BPF_TRAMP_F_CALL_ORIG or
-	 *                                        BPF_TRAMP_F_RET_FENTRY_RET
+	 * SP + retval_off    [ return value      ] BPF_TRAMP_F_CALL_ORIG or
+	 *                                          BPF_TRAMP_F_RET_FENTRY_RET
+	 *                    [ arg reg N         ]
+	 *                    [ ...               ]
+	 * SP + bargs_off     [ arg reg 1         ] for bpf
 	 *
-	 *                  [ arg reg N         ]
-	 *                  [ ...               ]
-	 * SP + args_off    [ arg reg 1         ]
+	 * SP + nfuncargs_off [ arg regs count    ]
 	 *
-	 * SP + nregs_off   [ arg regs count    ]
+	 * SP + ip_off        [ traced function   ] BPF_TRAMP_F_IP_ARG flag
 	 *
-	 * SP + ip_off      [ traced function   ] BPF_TRAMP_F_IP_ARG flag
+	 * SP + run_ctx_off   [ bpf_tramp_run_ctx ]
 	 *
-	 * SP + run_ctx_off [ bpf_tramp_run_ctx ]
+	 *                    [ stack arg N       ]
+	 *                    [ ...               ]
+	 * SP + oargs_off     [ stack arg 1       ] for original func
 	 */
 
 	stack_size = 0;
+	oargs_off = stack_size;
+	if (flags & BPF_TRAMP_F_CALL_ORIG)
+		stack_size +=  a->ostack_for_args;
+
 	run_ctx_off = stack_size;
 	/* room for bpf_tramp_run_ctx */
 	stack_size += round_up(sizeof(struct bpf_tramp_run_ctx), 8);
@@ -2247,13 +2377,14 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	if (flags & BPF_TRAMP_F_IP_ARG)
 		stack_size += 8;
 
-	nregs_off = stack_size;
+	nfuncargs_off = stack_size;
 	/* room for args count */
 	stack_size += 8;
 
-	args_off = stack_size;
+	bargs_off = stack_size;
 	/* room for args */
-	stack_size += nregs * 8;
+	nfuncargs = a->regs_for_args + a->bstack_for_args / 8;
+	stack_size += 8 * nfuncargs;
 
 	/* room for return value */
 	retval_off = stack_size;
@@ -2300,11 +2431,11 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	/* save arg regs count*/
-	emit(A64_MOVZ(1, A64_R(10), nregs, 0), ctx);
-	emit(A64_STR64I(A64_R(10), A64_SP, nregs_off), ctx);
+	emit(A64_MOVZ(1, A64_R(10), nfuncargs, 0), ctx);
+	emit(A64_STR64I(A64_R(10), A64_SP, nfuncargs_off), ctx);
 
-	/* save arg regs */
-	save_args(ctx, args_off, nregs);
+	/* save args for bpf */
+	save_args(ctx, bargs_off, oargs_off, m, a, false);
 
 	/* save callee saved registers */
 	emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
@@ -2320,7 +2451,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	for (i = 0; i < fentry->nr_links; i++)
-		invoke_bpf_prog(ctx, fentry->links[i], args_off,
+		invoke_bpf_prog(ctx, fentry->links[i], bargs_off,
 				retval_off, run_ctx_off,
 				flags & BPF_TRAMP_F_RET_FENTRY_RET);
 
@@ -2330,12 +2461,13 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 		if (!branches)
 			return -ENOMEM;
 
-		invoke_bpf_mod_ret(ctx, fmod_ret, args_off, retval_off,
+		invoke_bpf_mod_ret(ctx, fmod_ret, bargs_off, retval_off,
 				   run_ctx_off, branches);
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_args(ctx, args_off, nregs);
+		/* save args for original func */
+		save_args(ctx, bargs_off, oargs_off, m, a, true);
 		/* call original func */
 		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
 		emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);
@@ -2354,7 +2486,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	for (i = 0; i < fexit->nr_links; i++)
-		invoke_bpf_prog(ctx, fexit->links[i], args_off, retval_off,
+		invoke_bpf_prog(ctx, fexit->links[i], bargs_off, retval_off,
 				run_ctx_off, false);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
@@ -2368,7 +2500,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_args(ctx, args_off, nregs);
+		restore_args(ctx, bargs_off, a->regs_for_args);
 
 	/* restore callee saved register x19 and x20 */
 	emit(A64_LDR64I(A64_R(19), A64_SP, regs_off), ctx);
@@ -2428,14 +2560,13 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 		.idx = 0,
 	};
 	struct bpf_tramp_image im;
+	struct arg_aux  aaux;
 	int nregs, ret;
 
 	nregs = btf_func_model_nregs(m);
-	/* the first 8 registers are used for arguments */
-	if (nregs > 8)
-		return -ENOTSUPP;
 
-	ret = prepare_trampoline(&ctx, &im, tlinks, func_addr, nregs, flags);
+	calc_arg_aux(m, &aaux);
+	ret = prepare_trampoline(&ctx, &im, tlinks, func_addr, m, &aaux, flags);
 	if (ret < 0)
 		return ret;
 
@@ -2462,9 +2593,10 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 				u32 flags, struct bpf_tramp_links *tlinks,
 				void *func_addr)
 {
-	int ret, nregs;
-	void *image, *tmp;
 	u32 size = ro_image_end - ro_image;
+	struct arg_aux aaux;
+	void *image, *tmp;
+	int ret;
 
 	/* image doesn't need to be in module memory range, so we can
 	 * use kvmalloc.
@@ -2480,13 +2612,10 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 		.write = true,
 	};
 
-	nregs = btf_func_model_nregs(m);
-	/* the first 8 registers are used for arguments */
-	if (nregs > 8)
-		return -ENOTSUPP;
 
 	jit_fill_hole(image, (unsigned int)(ro_image_end - ro_image));
-	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
+	calc_arg_aux(m, &aaux);
+	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, m, &aaux, flags);
 
 	if (ret > 0 && validate_code(&ctx) < 0) {
 		ret = -EINVAL;

-- 
2.49.0


