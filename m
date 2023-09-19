Return-Path: <bpf+bounces-10340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FB37A5831
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 05:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996311C20862
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 03:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FD1341B9;
	Tue, 19 Sep 2023 03:57:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB78489;
	Tue, 19 Sep 2023 03:57:00 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BABB102;
	Mon, 18 Sep 2023 20:56:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RqSXK0DLXz4f3khm;
	Tue, 19 Sep 2023 11:56:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP4 (Coremail) with SMTP id gCh0CgBH09IDHAlldnxXAw--.51651S5;
	Tue, 19 Sep 2023 11:56:53 +0800 (CST)
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
	Conor Dooley <conor@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next 3/4] riscv, bpf: Add RV_TAILCALL_OFFSET macro to format tailcall offset
Date: Tue, 19 Sep 2023 11:57:10 +0800
Message-Id: <20230919035711.3297256-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230919035711.3297256-1-pulehui@huaweicloud.com>
References: <20230919035711.3297256-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBH09IDHAlldnxXAw--.51651S5
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWrAFyxJr4rGw1UtF1rCrg_yoW8Ww4xpF
	4UCwn3CF9Yqr18CryxAF4DW3Wakrn0qFsrGrWakrW3G3ZF9rykGa1DK3yYqry5uFy8Jry8
	Zryqvw13ua4kZrDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7VUbpwZ7UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Pu Lehui <pulehui@huawei.com>

Add RV_TAILCALL_OFFSET macro to format tailcall offset, and correct the
relevant comments.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 57535cfe1..f2ded1151 100644
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
@@ -243,8 +245,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
 	if (!is_tail_call)
 		emit_mv(RV_REG_A0, RV_REG_A5, ctx);
 	emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
-		  is_tail_call ? (RV_FENTRY_NINSNS + 1) * 4 : 0, /* skip reserved nops and TCC init */
-		  ctx);
+		  is_tail_call ? RV_TAILCALL_OFFSET : 0, ctx);
 }
 
 static void emit_bcc(u8 cond, u8 rd, u8 rs, int rvoff,
@@ -371,7 +372,7 @@ static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
 	off = ninsns_rvoff(tc_ninsn - (ctx->ninsns - start_insn));
 	emit_branch(BPF_JEQ, RV_REG_T2, RV_REG_ZERO, off, ctx);
 
-	/* goto *(prog->bpf_func + 4); */
+	/* goto *(prog->bpf_func + RV_TAILCALL_OFFSET); */
 	off = offsetof(struct bpf_prog, bpf_func);
 	if (is_12b_check(off, insn))
 		return -1;
-- 
2.25.1


