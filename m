Return-Path: <bpf+bounces-19655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A7582F92C
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 22:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE3A1F2510E
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 21:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDD82C6B5;
	Tue, 16 Jan 2024 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFSJEZ5Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC74B2C6AB;
	Tue, 16 Jan 2024 19:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434921; cv=none; b=c4ZbicC7GSdEQy+Jos01CPjuOoc9IGLIBm5VtIenSltSjXNAt64OQSQfEnN39YjInPu8u3SjB1PG2U5M6dAXdzbCy9ZXxgHtLC99QWSbAJWQnNJOcUaNSViM6HSnPVRf9CY4iGXEws9SU+eEKeUOVwKsdSL4mkAcAFRerKwDQj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434921; c=relaxed/simple;
	bh=hORw/LjtmLslIhMW3hB1p5s4EeH7XhY/u0cxo++nrUU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=bLUf5WoI8FlpbBUCnvud1xJ3ZmR8qWg03xNjXEHNZn9JW8PgUPTb3jLg/5Czvd0H9jc8Dhq5hFS6h1pc7fmCOvLncbtHeGTvP2YRFXiHF71RtPY2f9O4+swjO73sUyfgaVm4jCphbAm0VTbJTBXicuckeinyQm86L/DBXlZMiQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFSJEZ5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2215C433C7;
	Tue, 16 Jan 2024 19:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434921;
	bh=hORw/LjtmLslIhMW3hB1p5s4EeH7XhY/u0cxo++nrUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFSJEZ5ZzAM3uofM2y9LGVD6DvaesW2VOIsXRg96c8SIr81Hi7zKfHTmzEhpsgGCn
	 7uYc2i/4nQhUyhzHlZ2zYApQjEk5Ao67BU/0k0nLul4gM2X2VXIVpygOcMtX4kTl3b
	 HJXcf3+M70GE6g3z+yo21p7wF/A2lTQaRbbAJBVGTG+iM7n5FxcpaA/H4ZBXlUbuGf
	 LL5kV0cPvXm160a1GA35ltOdBD7bfGcaE90/DULo3ROMnyKNCBOwLk3oR3ws8PZABe
	 jiEKNYg6QE++UoHeEtZiOAuuBPr1PZ24CvcTpRv4UGsuM6GAIwyXeBV2ILeHpHwamM
	 bh5dkG/JWzEBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	shuah@kernel.org,
	nathan@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 03/68] selftests/bpf: Fix pyperf180 compilation failure with clang18
Date: Tue, 16 Jan 2024 14:53:02 -0500
Message-ID: <20240116195511.255854-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 100888fb6d8a185866b1520031ee7e3182b173de ]

With latest clang18 (main branch of llvm-project repo), when building bpf selftests,
    [~/work/bpf-next (master)]$ make -C tools/testing/selftests/bpf LLVM=1 -j

The following compilation error happens:
    fatal error: error in backend: Branch target out of insn range
    ...
    Stack dump:
    0.      Program arguments: clang -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian
      -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include
      -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf -I/home/yhs/work/bpf-next/tools/include/uapi
      -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/include -idirafter
      /home/yhs/work/llvm-project/llvm/build.18/install/lib/clang/18/include -idirafter /usr/local/include
      -idirafter /usr/include -Wno-compare-distinct-pointer-types -DENABLE_ATOMICS_TESTS -O2 --target=bpf
      -c progs/pyperf180.c -mcpu=v3 -o /home/yhs/work/bpf-next/tools/testing/selftests/bpf/pyperf180.bpf.o
    1.      <eof> parser at end of file
    2.      Code generation
    ...

The compilation failure only happens to cpu=v2 and cpu=v3. cpu=v4 is okay
since cpu=v4 supports 32-bit branch target offset.

The above failure is due to upstream llvm patch [1] where some inlining behavior
are changed in clang18.

To workaround the issue, previously all 180 loop iterations are fully unrolled.
The bpf macro __BPF_CPU_VERSION__ (implemented in clang18 recently) is used to avoid
unrolling changes if cpu=v4. If __BPF_CPU_VERSION__ is not available and the
compiler is clang18, the unrollng amount is unconditionally reduced.

  [1] https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b5720c607313a566eebb16e

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Alan Maguire <alan.maguire@oracle.com>
Link: https://lore.kernel.org/bpf/20231110193644.3130906-1-yonghong.song@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/progs/pyperf180.c | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/pyperf180.c b/tools/testing/selftests/bpf/progs/pyperf180.c
index c39f559d3100..42c4a8b62e36 100644
--- a/tools/testing/selftests/bpf/progs/pyperf180.c
+++ b/tools/testing/selftests/bpf/progs/pyperf180.c
@@ -1,4 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
 #define STACK_MAX_LEN 180
+
+/* llvm upstream commit at clang18
+ *   https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b5720c607313a566eebb16e
+ * changed inlining behavior and caused compilation failure as some branch
+ * target distance exceeded 16bit representation which is the maximum for
+ * cpu v1/v2/v3. Macro __BPF_CPU_VERSION__ is later implemented in clang18
+ * to specify which cpu version is used for compilation. So a smaller
+ * unroll_count can be set if __BPF_CPU_VERSION__ is less than 4, which
+ * reduced some branch target distances and resolved the compilation failure.
+ *
+ * To capture the case where a developer/ci uses clang18 but the corresponding
+ * repo checkpoint does not have __BPF_CPU_VERSION__, a smaller unroll_count
+ * will be set as well to prevent potential compilation failures.
+ */
+#ifdef __BPF_CPU_VERSION__
+#if __BPF_CPU_VERSION__ < 4
+#define UNROLL_COUNT 90
+#endif
+#elif __clang_major__ == 18
+#define UNROLL_COUNT 90
+#endif
+
 #include "pyperf.h"
-- 
2.43.0


