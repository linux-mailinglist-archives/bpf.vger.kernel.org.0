Return-Path: <bpf+bounces-13658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8C77DC50F
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 04:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79271C20BBB
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 03:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36784568D;
	Tue, 31 Oct 2023 03:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gl038/ta"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C255672
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 03:59:05 +0000 (UTC)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF265B4
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 20:59:03 -0700 (PDT)
Message-ID: <3e3a8a30-dde0-43a1-981e-2274962780ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698724741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Gzo92HM1JW7eaVEFUP9z8BpqRX6Y38puL9UEUvHV74Y=;
	b=gl038/tacFlL+wfIPD4WGGuA0wLlkNPfGWE5PWAycSaD+2GM7XhJqqlJ/ryBesvxYZDevR
	vwx//35Sv2wI+q9TkSZB4DSsSosKHA4kSEaLEm7YGSEDn/fXB95iBLs9gMpBWvnDW6aep/
	fncU5NIlmYDiYIgc9J+iTGjUzWBFb50=
Date: Mon, 30 Oct 2023 20:58:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: bpf <bpf@vger.kernel.org>
Cc: Eddy Z <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
Subject: bpf selftest pyperf180.c compilation failure with latest last llvm18
 (in development)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

With latest llvm18 (main branch of llvm-project repo), when building bpf selftests,
    [~/work/bpf-next (master)]$ make -C tools/testing/selftests/bpf LLVM=1 -j

The following compilation error happens:
    fatal error: error in backend: Branch target out of insn range
    PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace, preprocessed source, and associated run script.
    Stack dump:
    0.      Program arguments: clang -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include -I/home/yhs
    /work/bpf-next/tools/testing/selftests/bpf -I/home/yhs/work/bpf-next/tools/include/uapi -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/include -idirafter /hom
    e/yhs/work/llvm-project/llvm/build.18/install/lib/clang/18/include -idirafter /usr/local/include -idirafter /usr/include -Wno-compare-distinct-pointer-types -DENABLE
    _ATOMICS_TESTS -O2 --target=bpf -c progs/pyperf180.c -mcpu=v3 -o /home/yhs/work/bpf-next/tools/testing/selftests/bpf/pyperf180.bpf.o
    1.      <eof> parser at end of file
    2.      Code generation
    .....

The compilation failure only happens to cpu=v2 and cpu=v3. cpu=v4 is okay
since cpu=v4 supports 32-bit branch target offset.

The above failure is due to upstream llvm patch
    https://reviews.llvm.org/D143624
where some inlining ordering are changed in the compiler.
The following change can temporarily work around the issue:

diff --git a/tools/testing/selftests/bpf/progs/pyperf180.c b/tools/testing/selftests/bpf/progs/pyperf180.c
index c39f559d3100..db0bfaaf480c 100644
--- a/tools/testing/selftests/bpf/progs/pyperf180.c
+++ b/tools/testing/selftests/bpf/progs/pyperf180.c
@@ -1,4 +1,9 @@
  // SPDX-License-Identifier: GPL-2.0
  // Copyright (c) 2019 Facebook
+#if __clang_major__ >= 18
+#define STACK_MAX_LEN 150
+#else
  #define STACK_MAX_LEN 180
+#endif
+
  #include "pyperf.h"

We will do some more investigation to see whether we could do
anything in llvm side to mitigate the issue, or if not, will
provide a proper patch to fix the issue.



