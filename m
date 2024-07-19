Return-Path: <bpf+bounces-35077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519709376E2
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 12:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581611C21607
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 10:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A7812C544;
	Fri, 19 Jul 2024 10:55:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBAB84A46;
	Fri, 19 Jul 2024 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721386558; cv=none; b=n1qQFg5ouoERProNZEPN+iMxkgRzxYoE+uqM1g6fxvwUOY1bqHIAXilay0xD28xskA2VXKv27Afef9f3jcsdAwPoAw4aJ2ibiZDZ9E4eTre6z1YZfrOHaDVMtskmeyx8FsNQgr8A0xrPSrQ8ditb3jBzK53RJAyK+6QQgcfr5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721386558; c=relaxed/simple;
	bh=d2Ah1d9arkHmIdug+puU2JhYyInQUMKL1HRqyvjBT2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MzC5+j0EHYhPC1l3OSvkNK0ShcmiVW470NX+xVOSrd7tcsMUqzI+VbZAwYY3nf+26qOQoiIB9T36yLmI82EAw2bpW9ijCIXPe077H7pwpBKQunEzhCUcpAZkV/Tsr9cKiA1GBUMrEWLhFfDp+GbqNgtbpqyh3EdcaCYuUDN1ZXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WQRRP1Kykz4f3jYp;
	Fri, 19 Jul 2024 18:55:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4366A1A0568;
	Fri, 19 Jul 2024 18:55:53 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP3 (Coremail) with SMTP id _Ch0CgD3BVE0RppmM3cvAg--.11767S11;
	Fri, 19 Jul 2024 18:55:52 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Florent Revest <revest@google.com>
Subject: [PATCH bpf-next v2 9/9] selftests/bpf: Add verifier tests for bpf lsm
Date: Fri, 19 Jul 2024 19:00:59 +0800
Message-Id: <20240719110059.797546-10-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240719110059.797546-1-xukuohai@huaweicloud.com>
References: <20240719110059.797546-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgD3BVE0RppmM3cvAg--.11767S11
X-Coremail-Antispam: 1UD129KBjvJXoWxKrWrAr17JFy7Gr47tFWfAFb_yoW7Zw15pF
	9Fk34DGFs5Ary3WFyxCFW7ZF1fGFZ2qFyrXF40vr1YyFs3J3s7XryxW3WUX3s3J3Z5uw4Y
	vFZIkayakr1UC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add verifier tests to check bpf lsm return values and disabled hooks.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_lsm.c        | 178 ++++++++++++++++++
 2 files changed, 180 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_lsm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 9dc3687bc406..ff1c7da1d06e 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -88,6 +88,7 @@
 #include "verifier_xdp.skel.h"
 #include "verifier_xdp_direct_packet_access.skel.h"
 #include "verifier_bits_iter.skel.h"
+#include "verifier_lsm.skel.h"
 
 #define MAX_ENTRIES 11
 
@@ -206,6 +207,7 @@ void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
 void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
 void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
 void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
+void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm.c b/tools/testing/selftests/bpf/progs/verifier_lsm.c
new file mode 100644
index 000000000000..08251c517154
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_lsm.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("lsm/file_alloc_security")
+__description("lsm bpf prog with -4095~0 retval. test 1")
+__success
+__naked int errno_zero_retval_test1(void *ctx)
+{
+	asm volatile (
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/file_alloc_security")
+__description("lsm bpf prog with -4095~0 retval. test 2")
+__success
+__naked int errno_zero_retval_test2(void *ctx)
+{
+	asm volatile (
+	"r0 = -4095;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/file_alloc_security")
+__description("lsm bpf prog with -4095~0 retval. test 3")
+__success
+__naked int errno_zero_retval_test3(void *ctx)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r0 <<= 63;"
+	"r0 s>>= 63;"
+	"r0 &= -13;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("lsm/file_mprotect")
+__description("lsm bpf prog with -4095~0 retval. test 4")
+__failure __msg("R0 has smin=-4096 smax=-4096 should have been in [-4095, 0]")
+__naked int errno_zero_retval_test4(void *ctx)
+{
+	asm volatile (
+	"r0 = -4096;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/file_mprotect")
+__description("lsm bpf prog with -4095~0 retval. test 5")
+__failure __msg("R0 has smin=4096 smax=4096 should have been in [-4095, 0]")
+__naked int errno_zero_retval_test5(void *ctx)
+{
+	asm volatile (
+	"r0 = 4096;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/file_mprotect")
+__description("lsm bpf prog with -4095~0 retval. test 6")
+__failure __msg("R0 has smin=1 smax=1 should have been in [-4095, 0]")
+__naked int errno_zero_retval_test6(void *ctx)
+{
+	asm volatile (
+	"r0 = 1;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/audit_rule_known")
+__description("lsm bpf prog with bool retval. test 1")
+__success
+__naked int bool_retval_test1(void *ctx)
+{
+	asm volatile (
+	"r0 = 1;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/audit_rule_known")
+__description("lsm bpf prog with bool retval. test 2")
+__success
+__success
+__naked int bool_retval_test2(void *ctx)
+{
+	asm volatile (
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/audit_rule_known")
+__description("lsm bpf prog with bool retval. test 3")
+__failure __msg("R0 has smin=-1 smax=-1 should have been in [0, 1]")
+__naked int bool_retval_test3(void *ctx)
+{
+	asm volatile (
+	"r0 = -1;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/audit_rule_known")
+__description("lsm bpf prog with bool retval. test 4")
+__failure __msg("R0 has smin=2 smax=2 should have been in [0, 1]")
+__naked int bool_retval_test4(void *ctx)
+{
+	asm volatile (
+	"r0 = 2;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/file_free_security")
+__success
+__description("lsm bpf prog with void retval. test 1")
+__naked int void_retval_test1(void *ctx)
+{
+	asm volatile (
+	"r0 = -4096;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/file_free_security")
+__success
+__description("lsm bpf prog with void retval. test 2")
+__naked int void_retval_test2(void *ctx)
+{
+	asm volatile (
+	"r0 = 4096;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/getprocattr")
+__description("lsm disabled hook: getprocattr")
+__failure __msg("points to disabled hook")
+__naked int disabled_hook_test1(void *ctx)
+{
+	asm volatile (
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/setprocattr")
+__description("lsm disabled hook: setprocattr")
+__failure __msg("points to disabled hook")
+__naked int disabled_hook_test2(void *ctx)
+{
+	asm volatile (
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm/ismaclabel")
+__description("lsm disabled hook: ismaclabel")
+__failure __msg("points to disabled hook")
+__naked int disabled_hook_test3(void *ctx)
+{
+	asm volatile (
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.2


