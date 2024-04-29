Return-Path: <bpf+bounces-28107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C39E8B5D68
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA28280C2C
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 15:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71847823CC;
	Mon, 29 Apr 2024 15:18:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56F84D06
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403907; cv=none; b=PQcfbf/TfQMBpaDFEmod3Rw5xd0n6zeHwVutLmdWTHZGqEDSEf6HvPBe+nW6cFuuzoHGGhibWDpAU/nWfDxVesU+vnAN9VJFjYI7hJCUq8J0x+tyYIyKNPMq9lkkezjvK0fSY2Zd3ih7ZiY1V0MNKUZxcfhmMe9NEABvK92ALPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403907; c=relaxed/simple;
	bh=T3zY9f3mdbrBAJBgJWZvgMaZ+jCWWTgFmnhWg5s78P4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SJV1y7aSNM2BPREcNJX7i1PGBSEbFKYskEPdBYQEDFQ9gh3jepmLizXomPzKgTkXqa4GOUaSfMSom//oEjc3d2zaZqvy7zXr7dLzfxgqueoVZok7M6iXETP+hrAfZNDebni/gTk3WgOb1ercqEfRicf23tA4SSAOP9H8W64c57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VSn5f46dlz4f3k6J
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 23:18:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9923E1A0B84
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 23:18:19 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgA3h2k5ui9mf0EALg--.61812S2;
	Mon, 29 Apr 2024 23:18:18 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next] bpf: Fold LSH and ARSH pair to a single MOVSX for sign-extension
Date: Mon, 29 Apr 2024 23:20:36 +0800
Message-Id: <20240429152036.3411628-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3h2k5ui9mf0EALg--.61812S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur43Wry8Xr1kCrWUJF1DJrb_yoW5Zry3pF
	n5XFy5Gr48Aa17Ww4fZF4xCr9Iya18Ww47GFW7G34rJrWIqFn5GFWIgr4aya45tr4rWa12
	y3Wq9rWUW34UA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

As shown in the ExpandSEXTINREG function in [1], LLVM generates SRL and
SRA instruction pair to implement sign-extension. For x86 and arm64,
this instruction pair will be folded to a single instruction, but the
LLVM BPF backend does not do such folding.

For example, the following C code:

long f(int x)
{
	return x;
}

will be compiled to:

r0 = r1
r0 <<= 0x20
r0 s>>= 0x20
exit

Since 32-bit to 64-bit sign-extension is a common case and we already
have MOVSX instruction for sign-extension, this patch tries to fold
the 32-bit to 64-bit LSH and ARSH pair to a single MOVSX instruction.

[1] https://github.com/llvm/llvm-project/blob/4523a267829c807f3fc8fab8e5e9613985a51565/llvm/lib/CodeGen/SelectionDAG/LegalizeVectorOps.cpp#L1228

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/filter.h |  8 ++++++++
 kernel/bpf/verifier.c  | 46 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7a27f19bf44d..7cc90a32ed9a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -173,6 +173,14 @@ struct ctl_table_header;
 		.off   = 0,					\
 		.imm   = 0 })
 
+#define BPF_MOV64_SEXT_REG(DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_ALU64 | BPF_MOV | BPF_X,		\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = 0 })
+
 #define BPF_MOV32_REG(DST, SRC)					\
 	((struct bpf_insn) {					\
 		.code  = BPF_ALU | BPF_MOV | BPF_X,		\
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4e474ef44e9c..6bcee052d90d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20659,6 +20659,49 @@ static int optimize_bpf_loop(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static bool is_sext32(struct bpf_insn *insn1, struct bpf_insn *insn2)
+{
+	if (insn1->code != (BPF_ALU64 | BPF_K | BPF_LSH) || insn1->imm != 32)
+		return false;
+
+	if (insn2->code != (BPF_ALU64 | BPF_K | BPF_ARSH) || insn2->imm != 32)
+		return false;
+
+	if (insn1->dst_reg != insn2->dst_reg)
+		return false;
+
+	return true;
+}
+
+/* LLVM generates sign-extension with LSH and ARSH pair, replace it with MOVSX.
+ *
+ * Before:
+ * DST <<= 32
+ * DST s>>= 32
+ *
+ * After:
+ * DST = (s32)DST
+ */
+static int optimize_sext32_insns(struct bpf_verifier_env *env)
+{
+	int i, err;
+	int insn_cnt = env->prog->len;
+	struct bpf_insn *insn = env->prog->insnsi;
+
+	for (i = 0; i < insn_cnt; i++, insn++) {
+		if (i + 1 >= insn_cnt || !is_sext32(insn, insn + 1))
+			continue;
+		/* patch current insn to MOVSX */
+		*insn = BPF_MOV64_SEXT_REG(insn->dst_reg, insn->dst_reg, 32);
+		/* remove next insn */
+		err = verifier_remove_insns(env, i + 1, 1);
+		if (err)
+			return err;
+		insn_cnt--;
+	}
+	return 0;
+}
+
 static void free_states(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state_list *sl, *sln;
@@ -21577,6 +21620,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret == 0)
 		ret = optimize_bpf_loop(env);
 
+	if (ret == 0)
+		ret = optimize_sext32_insns(env);
+
 	if (is_priv) {
 		if (ret == 0)
 			opt_hard_wire_dead_code_branches(env);
-- 
2.30.2


