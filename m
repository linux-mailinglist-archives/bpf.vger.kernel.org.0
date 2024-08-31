Return-Path: <bpf+bounces-38654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77805966F3A
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 06:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280C31F237B1
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 04:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2194E13958C;
	Sat, 31 Aug 2024 04:16:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052462745D;
	Sat, 31 Aug 2024 04:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725077817; cv=none; b=BEXKcZdEHaJZtUV+USYpFsgV9mRU4q9gi4pPRUOXL0YZeo8L8Stbgk7DUrEaCmez5AtDCqLQ6GfNXnJa3HySAGBtyODiWTWK6FXMj5u3XLNc/cfohDTclvT4LUAIHb+FKJv24eVD9yHu7poAEWXPzzgj3DqixiDJjxhOBZNx8WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725077817; c=relaxed/simple;
	bh=Iu5hae1Zdqma31dX/QczhQ+cz5RaDDIPQWZryF1ozds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EzxuSRtYqG7Qb7a64jdSIqTmrPcMUCQFjf06xSOCEnfhA4sIDLIiUgq4QDAaZZl1Mb5gkV8GzXGtZxVCs4QEQQxNfGGlasoj+RbIJSeo6FaRD0fDoN/nFLXy/5N947B3E1iJJhECSsdc50kdA//jz+4yYAStjM3L26ormxnVkR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WwhY66Q9Yz4f3jkX;
	Sat, 31 Aug 2024 12:16:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 036221A07B6;
	Sat, 31 Aug 2024 12:16:53 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgBnT74ymdJmoSHHDA--.65422S5;
	Sat, 31 Aug 2024 12:16:52 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
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
Subject: [PATCH bpf-next v3 3/4] selftests/bpf: Enable test_bpf_syscall_macro:syscall_arg1 on s390 and arm64
Date: Sat, 31 Aug 2024 04:19:33 +0000
Message-Id: <20240831041934.1629216-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240831041934.1629216-1-pulehui@huaweicloud.com>
References: <20240831041934.1629216-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnT74ymdJmoSHHDA--.65422S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr13ZF4UWF1xKF1rtF18Xwb_yoW8tr1fp3
	4kJa4jyF1fWr47tryxWr47WF1rJrsrXrWrJF1fJrW3uF4DXry8tr1IgFWUJ3ZI9rZY9ws3
	Zwnakr95Xa1xZFUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jx
	CztUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Considering that CO-RE direct read access to the first system call
argument is already available on s390 and arm64, let's enable
test_bpf_syscall_macro:syscall_arg1 on these architectures.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 .../testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c | 4 ----
 tools/testing/selftests/bpf/progs/bpf_syscall_macro.c         | 2 --
 2 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
index 2900c5e9a016..1750c29b94f8 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
@@ -38,11 +38,7 @@ void test_bpf_syscall_macro(void)
 	/* check whether args of syscall are copied correctly */
 	prctl(exp_arg1, exp_arg2, exp_arg3, exp_arg4, exp_arg5);
 
-#if defined(__aarch64__) || defined(__s390__)
-	ASSERT_NEQ(skel->bss->arg1, exp_arg1, "syscall_arg1");
-#else
 	ASSERT_EQ(skel->bss->arg1, exp_arg1, "syscall_arg1");
-#endif
 	ASSERT_EQ(skel->bss->arg2, exp_arg2, "syscall_arg2");
 	ASSERT_EQ(skel->bss->arg3, exp_arg3, "syscall_arg3");
 	/* it cannot copy arg4 when uses PT_REGS_PARM4 on x86_64 */
diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
index 1a476d8ed354..9e7d9674ce2a 100644
--- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
@@ -43,9 +43,7 @@ int BPF_KPROBE(handle_sys_prctl)
 
 	/* test for PT_REGS_PARM */
 
-#if !defined(bpf_target_arm64) && !defined(bpf_target_s390)
 	bpf_probe_read_kernel(&tmp, sizeof(tmp), &PT_REGS_PARM1_SYSCALL(real_regs));
-#endif
 	arg1 = tmp;
 	bpf_probe_read_kernel(&arg2, sizeof(arg2), &PT_REGS_PARM2_SYSCALL(real_regs));
 	bpf_probe_read_kernel(&arg3, sizeof(arg3), &PT_REGS_PARM3_SYSCALL(real_regs));
-- 
2.34.1


