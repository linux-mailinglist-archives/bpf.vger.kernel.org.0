Return-Path: <bpf+bounces-12872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060EA7D18CA
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 00:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02FE4B215AF
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 22:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F05321B0;
	Fri, 20 Oct 2023 22:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="GLA14+fb"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48B62FE09
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 22:02:34 +0000 (UTC)
Received: from smtp5.epfl.ch (smtp5.epfl.ch [IPv6:2001:620:618:1e0:1:80b2:e034:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AB9D52
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 15:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1697839347;
      h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Content-Type;
      bh=spzh79TVE/k8kd+8ZYhaeOZCPuUEPSlfw+NJGWna0uU=;
      b=GLA14+fbyqbiDw/n5EgC2niDIR3DVoUtk7uoIVTqlOfAUyTnl4yCmboVYxZHDO7lX
        hIgpitbXyZZPGn8nZn9ikwblGay0XYGpW+Uv68xTJ3+RD78svrN5af4G6RVWntEQZ
        c1GyUckTKXKzcJc2OX0QsmqaJ8aoIGHuT27HYHidU=
Received: (qmail 30588 invoked by uid 107); 20 Oct 2023 22:02:27 -0000
Received: from ax-snat-224-178.epfl.ch (HELO ewa07.intranet.epfl.ch) (192.168.224.178) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Sat, 21 Oct 2023 00:02:27 +0200
X-EPFL-Auth: XjnzMUAuGC+9lWDvEvyVvVeUSbUWNNTSRYRtS7moNwUDKGFyO0g=
Received: from rs3labsrv2.iccluster.epfl.ch (10.90.46.62) by
 ewa07.intranet.epfl.ch (128.178.224.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.31; Sat, 21 Oct 2023 00:02:27 +0200
From: Tao Lyu <tao.lyu@epfl.ch>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>
CC: <bpf@vger.kernel.org>, <sanidhya.kashyap@epfl.ch>,
	<mathias.payer@nebelwelt.net>, <meng.xu.cs@uwaterloo.ca>, <tao.lyu@epfl.ch>
Subject: [PATCH] Accept program in priv mode when returning from subprog with r10 marked as precise
Date: Sat, 21 Oct 2023 00:02:16 +0200
Message-ID: <20231020220216.263948-1-tao.lyu@epfl.ch>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <https://lore.kernel.org/bpf/20231020155842.130257-1-tao.lyu@epfl.ch/T/#u>
References: <https://lore.kernel.org/bpf/20231020155842.130257-1-tao.lyu@epfl.ch/T/#u>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.46.62]
X-ClientProxiedBy: ewa11.intranet.epfl.ch (128.178.224.186) To
 ewa07.intranet.epfl.ch (128.178.224.178)

There is another issue about the backtracking.
When uploading the following program under privilege mode,
the verifier reports a "verifier backtracking bug".

0: R1=ctx(off=0,imm=0) R10=fp0
0: (85) call pc+2
caller:
 R10=fp0
callee:
 frame1: R1=ctx(off=0,imm=0) R10=fp0
3: frame1:
3: (bf) r3 = r10                      ; frame1: R3_w=fp0 R10=fp0
4: (bc) w0 = w10                      ; frame1: R0_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0
5: (0f) r3 += r0
mark_precise: frame1: last_idx 5 first_idx 0 subseq_idx -1
mark_precise: frame1: regs=r0 stack= before 4: (bc) w0 = w10
mark_precise: frame1: regs=r10 stack= before 3: (bf) r3 = r10
mark_precise: frame1: regs=r10 stack= before 0: (85) call pc+2
BUG regs 400

This bug is manifested by the following check:

if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
    verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
    WARN_ONCE(1, "verifier backtracking bug");
    return -EFAULT;
}

Since the verifier allows add operation on stack pointers,
it shouldn't show this WARNING and reject the program.

I fixed it by skipping the warning if it's privilege mode and only r10 is marked as precise.

Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
---
 kernel/bpf/verifier.c                            |  4 +++-
 .../bpf/verifier/ret-without-checing-r10.c       | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/ret-without-checing-r10.c

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e777f50401b6..1ce80cdc4f1d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3495,6 +3495,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 	u32 dreg = insn->dst_reg;
 	u32 sreg = insn->src_reg;
 	u32 spi, i;
+	u32 reg_mask;
 
 	if (insn->code == 0)
 		return 0;
@@ -3621,7 +3622,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				 * precise, r0 and r6-r10 or any stack slot in
 				 * the current frame should be zero by now
 				 */
-				if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
+				reg_mask = bt_reg_mask(bt) & ~BPF_REGMASK_ARGS;
+				if (reg_mask && !((reg_mask == 1 << BPF_REG_10) && env->allow_ptr_leaks)) {
 					verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
 					WARN_ONCE(1, "verifier backtracking bug");
 					return -EFAULT;
diff --git a/tools/testing/selftests/bpf/verifier/ret-without-checing-r10.c b/tools/testing/selftests/bpf/verifier/ret-without-checing-r10.c
new file mode 100644
index 000000000000..56e529cf922b
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/ret-without-checing-r10.c
@@ -0,0 +1,16 @@
+{
+  "pointer arithmetic: when returning from subprog in priv, do not checking r10",
+  .insns = {
+	BPF_CALL_REL(2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
+	BPF_MOV32_REG(BPF_REG_0, BPF_REG_10),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+  },
+  .result  = ACCEPT,
+  .result_unpriv = REJECT,
+  .errstr_unpriv = "loading/calling other bpf or kernel functions are allowed for CAP_BPF and CAP_SYS_ADMIN",
+},
-- 
2.25.1


