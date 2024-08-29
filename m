Return-Path: <bpf+bounces-38400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B389646BE
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 15:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305AC1C23875
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F171B1D6A;
	Thu, 29 Aug 2024 13:30:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D44196D81;
	Thu, 29 Aug 2024 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938220; cv=none; b=ITX9UH2atoXX2nR7wm+T67RwPim8F/185gSL5iTJKAW1TSh/D2Bf2EKpq4m8dP05lINJaB7J7BnlmcWmCvkQqbMQtEXr6fDlgwG1YAg5Wkm9Ku9ggrnLLtvL18p3cN/Jzo3q8+5z+Mr/TtoinIqrChFfoSLmd/iKZ4zyXsqEsMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938220; c=relaxed/simple;
	bh=YHTyHdRGt40WtHfZLnz3JAFzv5RrDSs4Irp3L6f1FgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J6LmQqBQa1enkM/jyyIIB7ti+ITDyjKEGePg98WtXpzZwnK+1VrOW+D/GdQRpapfVZdqp1d8BiZq1SmyMv8sJvGbp+qlN2zfzOYLFTpJ7u6vGsQjdrgZnPYNNl3Dycke1SSz7gRK5kvHTSGC4rRATwF/YTOjd4oAY39v9DL467I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WvhwR3DGhz4f3n5q;
	Thu, 29 Aug 2024 21:29:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F263A1A018D;
	Thu, 29 Aug 2024 21:30:14 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with SMTP id cCh0CgDHHE_jd9Bm48_bCw--.51956S3;
	Thu, 29 Aug 2024 21:30:14 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
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
	Puranjay Mohan <puranjay@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next 1/2] libbpf: Fix accessing first syscall argument on RV64
Date: Thu, 29 Aug 2024 13:32:51 +0000
Message-Id: <20240829133253.882133-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829133253.882133-1-pulehui@huaweicloud.com>
References: <20240829133253.882133-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHHE_jd9Bm48_bCw--.51956S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr43ArWfCw1Dur47Zry3CFg_yoW8ZF4DpF
	W5Ca47Kr18Wr4Ig3s7KF4aqa13Kr15JrsrJF93Ww4S9FW8t39aqa429390yrsIqrW8J3y5
	ZFZrKw1rWry7ZwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	W8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jqYL9U
	UUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

On RV64, as Ilya mentioned before [0], the first syscall parameter should be
accessed through orig_a0 (see arch/riscv64/include/asm/syscall.h),
otherwise it will cause selftests like bpf_syscall_macro, vmlinux,
test_lsm, etc. to fail on RV64. Let's fix it by using the struct pt_regs
style to provide access to it only through PT_REGS_PARM1_CORE_SYSCALL().

Link: https://lore.kernel.org/bpf/20220209021745.2215452-1-iii@linux.ibm.com [0]
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/lib/bpf/bpf_tracing.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 9314fa95f04e..388f30cf7914 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -351,6 +351,10 @@ struct pt_regs___arm64 {
  * https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-cc.adoc#risc-v-calling-conventions
  */
 
+struct pt_regs___riscv {
+	unsigned long orig_a0;
+};
+
 /* riscv provides struct user_regs_struct instead of struct pt_regs to userspace */
 #define __PT_REGS_CAST(x) ((const struct user_regs_struct *)(x))
 #define __PT_PARM1_REG a0
@@ -362,12 +366,15 @@ struct pt_regs___arm64 {
 #define __PT_PARM7_REG a6
 #define __PT_PARM8_REG a7
 
-#define __PT_PARM1_SYSCALL_REG __PT_PARM1_REG
+#define __PT_PARM1_SYSCALL_REG orig_a0
 #define __PT_PARM2_SYSCALL_REG __PT_PARM2_REG
 #define __PT_PARM3_SYSCALL_REG __PT_PARM3_REG
 #define __PT_PARM4_SYSCALL_REG __PT_PARM4_REG
 #define __PT_PARM5_SYSCALL_REG __PT_PARM5_REG
 #define __PT_PARM6_SYSCALL_REG __PT_PARM6_REG
+#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1_CORE_SYSCALL(x)
+#define PT_REGS_PARM1_CORE_SYSCALL(x) \
+	BPF_CORE_READ((const struct pt_regs___riscv *)(x), __PT_PARM1_SYSCALL_REG)
 
 #define __PT_RET_REG ra
 #define __PT_FP_REG s0
-- 
2.34.1


