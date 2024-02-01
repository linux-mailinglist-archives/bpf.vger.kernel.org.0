Return-Path: <bpf+bounces-20929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B04CD8452C7
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 09:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D0828AF1F
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 08:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370DD15AADA;
	Thu,  1 Feb 2024 08:33:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA251157E9E;
	Thu,  1 Feb 2024 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706776386; cv=none; b=V3affC1GVviWZFUeccUk5XJeXRqOOrICYmWOdqsH+D1YaYB40EAeqIkeMbGYKbxzcXXVoh79GY8yC6YJo58GXCkKbvXnXPq9AKBGXzl8/yb61jZ8R3uyNbPyQ2QShkaBA4cZwBZwCPRZuU9wSQ3cxV8KZuuxch6MZPIJtThqWb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706776386; c=relaxed/simple;
	bh=wI/5/UcJZ1KapYx8YjRRhRE29mK5U1H5JPGqCr5qWPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wja471jiGrgzYm/yeJbLGgAMZrnL2y9jgJXevEXytKwIxWV3OPQWCwkCGBVxyoS0RvuRDDvBFZ3AYlVN7/kpI54RVkm2BiDPB/C3afqJCEH8x+8obnEvZPU+RjpR7Po2T2MCN+YTHxoo7oo2KNEaBM2dhY2bLtDeLgi+JZDmZwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TQXGf1zLBz4f3k6C;
	Thu,  1 Feb 2024 16:32:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D53841A0283;
	Thu,  1 Feb 2024 16:33:00 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgA3PnA8V7tlRXylCg--.9426S5;
	Thu, 01 Feb 2024 16:33:00 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
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
Subject: [PATCH bpf-next v3 3/4] riscv, bpf: Add RV_TAILCALL_OFFSET macro to format tailcall offset
Date: Thu,  1 Feb 2024 08:33:50 +0000
Message-Id: <20240201083351.943121-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201083351.943121-1-pulehui@huaweicloud.com>
References: <20240201083351.943121-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3PnA8V7tlRXylCg--.9426S5
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW5JFW5uFyxXrW8ArykGrg_yoW8AF1xpF
	4UCwn3uF9Yqr18Cry7AF4DWa1YkFn0qF47GrW3CrW3G3ZF9rykG3WDK3yYvry5CFy8Jr18
	Jryq9w1fC34kArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
	1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUCXdbU
	UUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Add RV_TAILCALL_OFFSET macro to format tailcall offset, and correct the
relevant comments.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
Acked-by: Björn Töpel <bjorn@kernel.org>
---
 arch/riscv/net/bpf_jit_comp64.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 74f995abf2c2..3516d425c5eb 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -13,7 +13,9 @@
 #include <asm/patch.h>
 #include "bpf_jit.h"
 
-#define RV_FENTRY_NINSNS 2
+#define RV_FENTRY_NINSNS	2
+/* fentry and TCC init insns will be skipped on tailcall */
+#define RV_TAILCALL_OFFSET	((RV_FENTRY_NINSNS + 1) * 4)
 
 #define RV_REG_TCC RV_REG_A6
 #define RV_REG_TCC_SAVED RV_REG_S6 /* Store A6 in S6 if program do calls */
@@ -260,8 +262,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
 	if (!is_tail_call)
 		emit_addiw(RV_REG_A0, RV_REG_A5, 0, ctx);
 	emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
-		  is_tail_call ? (RV_FENTRY_NINSNS + 1) * 4 : 0, /* skip reserved nops and TCC init */
-		  ctx);
+		  is_tail_call ? RV_TAILCALL_OFFSET : 0, ctx);
 }
 
 static void emit_bcc(u8 cond, u8 rd, u8 rs, int rvoff,
@@ -382,7 +383,7 @@ static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
 	off = ninsns_rvoff(tc_ninsn - (ctx->ninsns - start_insn));
 	emit_branch(BPF_JEQ, RV_REG_T2, RV_REG_ZERO, off, ctx);
 
-	/* goto *(prog->bpf_func + 4); */
+	/* goto *(prog->bpf_func + RV_TAILCALL_OFFSET); */
 	off = offsetof(struct bpf_prog, bpf_func);
 	if (is_12b_check(off, insn))
 		return -1;
-- 
2.34.1


