Return-Path: <bpf+bounces-20063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22842838593
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 03:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B6B284D21
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 02:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8D351C5F;
	Tue, 23 Jan 2024 02:31:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBB951C49;
	Tue, 23 Jan 2024 02:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705977094; cv=none; b=hMHhVL3dX9BhIE5vputvGVAhU4zumuvP/Zk+wMHxAfUrY+YJWEqbIc2+5HMLnKYhc9XqVX+yeet33EI41t3XMhO7SC6+oj2pH1oZXsU6Hj3EO0ZO5NGrMtzxcSlNFEX3oDVxDEZBMvsDz6ZyCdf0tqj40N5ccREB5GVA+AySKt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705977094; c=relaxed/simple;
	bh=qQoBK/yPG3qUttEb8gVNV9skWBiCb1iM8nAruNyeQnw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KmuywYfQ+935kLv92b3MD7Gve+nGuHUg451/K8tcuVddNVGWV789tijane2/ZWEzxYMC4dObYudCWdPx05vwuWUSyYyeTSgZ/CNqhbwvScTAK8KaMLZ4FZpIaE2UI0DPtRxb07QgNWszPwfUxfbkytdS4Me5BFFXS8uy26uB7zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TJrgc0cznz4f3kFC;
	Tue, 23 Jan 2024 10:31:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id F33541A0199;
	Tue, 23 Jan 2024 10:31:27 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgCHqg3+JK9lkTDZBg--.54023S2;
	Tue, 23 Jan 2024 10:31:27 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf] riscv, bpf: Fix unpredictable kernel crash about RV64 struct_ops
Date: Tue, 23 Jan 2024 02:32:07 +0000
Message-Id: <20240123023207.1917284-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHqg3+JK9lkTDZBg--.54023S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1rWrW3Zw4kXFy5ZryUGFg_yoW5tF48pF
	15Gr15CF48XrnrGF1kXF4UXr13t3yqva47GFy7Gr4F9a45Wry8Ar18tayjyry5KFn09r17
	JF1qvw1ktr18A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	fUOmhFUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

We encountered a kernel crash triggered by the bpf_tcp_ca testcase as
show below:

Unable to handle kernel paging request at virtual address ff60000088554500
Oops [#1]
...
CPU: 3 PID: 458 Comm: test_progs Tainted: G           OE      6.8.0-rc1-kselftest_plain #1
Hardware name: riscv-virtio,qemu (DT)
epc : 0xff60000088554500
 ra : tcp_ack+0x288/0x1232
epc : ff60000088554500 ra : ffffffff80cc7166 sp : ff2000000117ba50
 gp : ffffffff82587b60 tp : ff60000087be0040 t0 : ff60000088554500
 t1 : ffffffff801ed24e t2 : 0000000000000000 s0 : ff2000000117bbc0
 s1 : 0000000000000500 a0 : ff20000000691000 a1 : 0000000000000018
 a2 : 0000000000000001 a3 : ff60000087be03a0 a4 : 0000000000000000
 a5 : 0000000000000000 a6 : 0000000000000021 a7 : ffffffff8263f880
 s2 : 000000004ac3c13b s3 : 000000004ac3c13a s4 : 0000000000008200
 s5 : 0000000000000001 s6 : 0000000000000104 s7 : ff2000000117bb00
 s8 : ff600000885544c0 s9 : 0000000000000000 s10: ff60000086ff0b80
 s11: 000055557983a9c0 t3 : 0000000000000000 t4 : 000000000000ffc4
 t5 : ffffffff8154f170 t6 : 0000000000000030
status: 0000000200000120 badaddr: ff60000088554500 cause: 000000000000000c
Code: c796 67d7 0000 0000 0052 0002 c13b 4ac3 0000 0000 (0001) 0000
---[ end trace 0000000000000000 ]---

The reason is that commit 2cd3e3772e41 ("x86/cfi,bpf: Fix bpf_struct_ops
CFI") changes the func_addr of arch_prepare_bpf_trampoline in struct_ops
from NULL to non-NULL, while we use func_addr on RV64 to differentiate
between struct_ops and regular trampoline. When the struct_ops testcase
is triggered, it emits wrong prologue and epilogue, and lead to
unpredictable issues. After commit 2cd3e3772e41, we can use
BPF_TRAMP_F_INDIRECT to distinguish them as it always be set in
struct_ops.

Fixes: 2cd3e3772e41 ("x86/cfi,bpf: Fix bpf_struct_ops CFI")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
Acked-by: Björn Töpel <bjorn@kernel.org>
---
 arch/riscv/net/bpf_jit_comp64.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 58dc64dd94a8..719a97e7edb2 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -795,6 +795,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
+	bool is_struct_ops = flags & BPF_TRAMP_F_INDIRECT;
 	void *orig_call = func_addr;
 	bool save_ret;
 	u32 insn;
@@ -878,7 +879,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 	stack_size = round_up(stack_size, 16);
 
-	if (func_addr) {
+	if (!is_struct_ops) {
 		/* For the trampoline called from function entry,
 		 * the frame of traced function and the frame of
 		 * trampoline need to be considered.
@@ -998,7 +999,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
 
-	if (func_addr) {
+	if (!is_struct_ops) {
 		/* trampoline called from function entry */
 		emit_ld(RV_REG_T0, stack_size - 8, RV_REG_SP, ctx);
 		emit_ld(RV_REG_FP, stack_size - 16, RV_REG_SP, ctx);
-- 
2.34.1


