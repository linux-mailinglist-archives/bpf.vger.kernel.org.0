Return-Path: <bpf+bounces-32515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A8290EE17
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 15:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80AD81F210E7
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 13:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF31147C7B;
	Wed, 19 Jun 2024 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBxOc3rk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E64143757;
	Wed, 19 Jun 2024 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803529; cv=none; b=XghMO7CKivUSK/DHleEqb1i4TfSKeVMDBW0vsIwMhWc4k0lvatJFvsCTVMSWjZIeGSB+BQF2/iBHf4WeSDX6Hv/panJuh4i0oyjs7BK6+e706VNrEWzG/8CYymn2NQ3wq7xELvcCKaZovvKYE21HwVgyWbtMuiL8Mc8zNO5VMss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803529; c=relaxed/simple;
	bh=CBl//lO4qFOL4+qF/5/XncehXiBwSbzhWClESpKygHg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p4ZesNmUfUUhc1h5bKgeQt8Z6eHUw8U1XM8URpnEcah99rbu+XEvTpWfxV/w2P3WFeyW1WFBQSbpoM0xBilkkYw0TSL6C0kCa4TAtVPLzGgummWdOpRW33jU+uHLFDLNNHu75H9C6VyUDoD/2tnd1Er0Z1MfDrDjLWtd3l4OsBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBxOc3rk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD87C2BBFC;
	Wed, 19 Jun 2024 13:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718803529;
	bh=CBl//lO4qFOL4+qF/5/XncehXiBwSbzhWClESpKygHg=;
	h=From:To:Cc:Subject:Date:From;
	b=KBxOc3rkLulVYUS/yi38GbU5HIewXsHaByRSrRPHh4yD1hEQfbs73Lyywsrqisjul
	 W2K6j6Uuw6e23/aU60P5Wc7HUy5tYMxtfhKAL3mqj+NNOy3ilzxZXDKYa/c2yPQRvv
	 mEaBUxPHk0hFbICXafyWFywDcHayO/W8QyDdIpjUVPJtyo8Qr397ZxjzRQIP0XN5Y9
	 rtd6y2odW8P79RMndQ2WOeLLnhADrgXTkj5pgvtiahSENj044Psi88bgy7qomroEuX
	 kQNlJIjY8ir0Q11Vq0b19w8G6xjEdctxL0qYBuVoxeHm33Tt3G7+h2WZjZnOkL8+id
	 o6Fkfd9adLmRg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH] bpf, arm64: inline bpf_get_current_task/_btf() helpers
Date: Wed, 19 Jun 2024 13:13:34 +0000
Message-Id: <20240619131334.4297-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On ARM64, the pointer to task_struct is always available in the sp_el0
register and therefore the calls to bpf_get_current_task() and
bpf_get_current_task_btf() can be inlined into a single MRS instruction.

Here is the difference before and after this change:

Before:

; struct task_struct *task = bpf_get_current_task_btf();
  54:   mov     x10, #0xffffffffffff7978        // #-34440
  58:   movk    x10, #0x802b, lsl #16
  5c:   movk    x10, #0x8000, lsl #32
  60:   blr     x10          -------------->    0xffff8000802b7978 <+0>:     mrs     x0, sp_el0
  64:   add     x7, x0, #0x0 <--------------    0xffff8000802b797c <+4>:     ret

After:

; struct task_struct *task = bpf_get_current_task_btf();
  54:   mrs     x7, sp_el0

This shows around 1% performance improvement in artificial microbenchmark.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 720336d28856..b838dab3bd26 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1244,6 +1244,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			break;
 		}
 
+		/* Implement helper call to bpf_get_current_task/_btf() inline */
+		if (insn->src_reg == 0 && (insn->imm == BPF_FUNC_get_current_task ||
+					   insn->imm == BPF_FUNC_get_current_task_btf)) {
+			emit(A64_MRS_SP_EL0(r0), ctx);
+			break;
+		}
+
 		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
 					    &func_addr, &func_addr_fixed);
 		if (ret < 0)
@@ -2581,6 +2588,8 @@ bool bpf_jit_inlines_helper_call(s32 imm)
 {
 	switch (imm) {
 	case BPF_FUNC_get_smp_processor_id:
+	case BPF_FUNC_get_current_task:
+	case BPF_FUNC_get_current_task_btf:
 		return true;
 	default:
 		return false;
-- 
2.40.1


