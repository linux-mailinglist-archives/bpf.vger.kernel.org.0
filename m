Return-Path: <bpf+bounces-38402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00D59646C4
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 15:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E30B2809C6
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 13:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C12515AD9E;
	Thu, 29 Aug 2024 13:32:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8062A1B2ED4;
	Thu, 29 Aug 2024 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938336; cv=none; b=WAgq9+g/0PU7vIvBq05AI72b4rfS94QckYAlO93coeEZDXYfvR7Sphg4njQEMp82V5mbXcIth4GmnSJ/wcsilf4K3ui4YYheyObcZMEED2dK7Plf0OMeYVsrqfl/tlNVyQrWLbK7vvQUuZJDfL+L2GV71u2a8A5bnx1Jp/YaWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938336; c=relaxed/simple;
	bh=YHTyHdRGt40WtHfZLnz3JAFzv5RrDSs4Irp3L6f1FgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cxtgahN5ZbzVk5KJ/PN7buysD1QNQKTp9SEIWx514WQ9vL1xfGPIKtjjShDjsufE+xsodbwp94VnLiDBFoU+8NBh4d5yizCR9fz/Wj/rITePaOkA5jDjaVaIJ6C0DpbzIQ/Zr9FlwNmkAu/9FLiVCSLOk25G66ezLFOvz+u9vOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wvhyj17Mbz4f3jdG;
	Thu, 29 Aug 2024 21:31:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id CB2AA1A07B6;
	Thu, 29 Aug 2024 21:32:11 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgBXurhbeNBmFVXQCw--.7237S3;
	Thu, 29 Aug 2024 21:32:11 +0800 (CST)
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
Date: Thu, 29 Aug 2024 13:34:52 +0000
Message-Id: <20240829133453.882259-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829133453.882259-1-pulehui@huaweicloud.com>
References: <20240829133453.882259-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXurhbeNBmFVXQCw--.7237S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr43ArWfCw1Dur47Zry3CFg_yoW8ZF4DpF
	W5Ca47Kr18Wr4Ig3s7KF4aqa13Kr15JrsrJF93Ww4S9FW8t39aqa429390yrsIqrW8J3y5
	ZFZrKw1rWry7ZwUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUnTa
	0DUUUUU==
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


