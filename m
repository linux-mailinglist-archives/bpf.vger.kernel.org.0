Return-Path: <bpf+bounces-8374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8576B785B8B
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 17:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F981281368
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 15:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A21D52F;
	Wed, 23 Aug 2023 15:07:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B77CA7E;
	Wed, 23 Aug 2023 15:07:01 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F7C10D;
	Wed, 23 Aug 2023 08:06:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RW8gp3y3Qz4f3lJv;
	Wed, 23 Aug 2023 23:06:46 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgAn_qCIIOZksUWeBQ--.39856S9;
	Wed, 23 Aug 2023 23:06:49 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Xu Kuohai <xukuohai@huawei.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next 7/7] selftests/bpf: Enable cpu v4 tests for RV64
Date: Wed, 23 Aug 2023 23:10:59 +0000
Message-Id: <20230823231059.3363698-8-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230823231059.3363698-1-pulehui@huaweicloud.com>
References: <20230823231059.3363698-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAn_qCIIOZksUWeBQ--.39856S9
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1DJryUCr4UJw4UXrW5Wrg_yoW7Jr1rp3
	WkuasIy3WxKF1a9F1fAF4jvFWrGrs7ZrWUAFW0vr4Du3ZrJrWIqr92kr45JrZ0grZYvrs5
	Zw1IgwnxZr48Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
	AGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRiHq2tUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Pu Lehui <pulehui@huawei.com>

Enable cpu v4 tests for RV64, and the relevant tests have passed.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/progs/test_ldsx_insn.c | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_bswap.c | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_gotol.c | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_ldsx.c  | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_movsx.c | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_sdiv.c  | 3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
index 916d9435f12c..67c14ba1e87b 100644
--- a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
+++ b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
@@ -5,7 +5,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
-#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86)) && __clang_major__ >= 18
+#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
 const volatile int skip = 0;
 #else
 const volatile int skip = 1;
diff --git a/tools/testing/selftests/bpf/progs/verifier_bswap.c b/tools/testing/selftests/bpf/progs/verifier_bswap.c
index 770f9d882542..8893094725f0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bswap.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bswap.c
@@ -4,7 +4,8 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
-#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86)) && __clang_major__ >= 18
+#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
 
 SEC("socket")
 __description("BSWAP, 16")
diff --git a/tools/testing/selftests/bpf/progs/verifier_gotol.c b/tools/testing/selftests/bpf/progs/verifier_gotol.c
index 17319a505e87..2dae5322a18e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotol.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotol.c
@@ -4,7 +4,8 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
-#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86)) && __clang_major__ >= 18
+#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
 
 SEC("socket")
 __description("gotol, small_imm")
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index 4a2b567c0f69..0c638f45aaf1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -4,7 +4,8 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
-#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86)) && __clang_major__ >= 18
+#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
 
 SEC("socket")
 __description("LDSX, S8")
diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index d9528d578bd9..3c8ac2c57b1b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -4,7 +4,8 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
-#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86)) && __clang_major__ >= 18
+#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
 
 SEC("socket")
 __description("MOV32SX, S8")
diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
index fa3945930e93..0990f8825675 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
@@ -4,7 +4,8 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
-#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86)) && __clang_major__ >= 18
+#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
 
 SEC("socket")
 __description("SDIV32, non-zero imm divisor, check 1")
-- 
2.39.2


