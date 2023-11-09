Return-Path: <bpf+bounces-14630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740CB7E727D
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 20:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18ADD28102A
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 19:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCD137171;
	Thu,  9 Nov 2023 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A29Tj6c2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF4335DB
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 19:55:05 +0000 (UTC)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bd])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFE73C05
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 11:55:04 -0800 (PST)
Message-ID: <8576d3dd-28af-45c2-b72c-30105a451da9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699559702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZkYP8SiNfQF8Jmdomj9wCTyoulvvbU50M5EBkSThVU=;
	b=A29Tj6c2Luc/gaYlhrz0YMLKlDdavOWRC+HD7X1L3fz+2N16WDXG+/ouGqo5zTX9wqMNqj
	TJnlrrB+uOKczEpiUWyzg4E79TDNIExTAJYAeZ3J4R2rpiw+iTIfzSJQK5LG/rg4dzRr1F
	u1MgiEjUbtxFvdRxDznRBeCyU5VSKmw=
Date: Thu, 9 Nov 2023 11:54:55 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix pyperf180 compilation failure
 with llvm18
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231109053029.1403552-1-yonghong.song@linux.dev>
 <6bf022a8cfd8c821ec0a8370fa85bcfd806c8be7.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <6bf022a8cfd8c821ec0a8370fa85bcfd806c8be7.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/9/23 3:47 AM, Eduard Zingerman wrote:
> On Wed, 2023-11-08 at 21:30 -0800, Yonghong Song wrote:
>> With latest llvm18 (main branch of llvm-project repo), when building bpf selftests,
>>      [~/work/bpf-next (master)]$ make -C tools/testing/selftests/bpf LLVM=1 -j
>>
>> The following compilation error happens:
>>      fatal error: error in backend: Branch target out of insn range
>>      ...
>>      Stack dump:
>>      0.      Program arguments: clang -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian
>>        -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include
>>        -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf -I/home/yhs/work/bpf-next/tools/include/uapi
>>        -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/include -idirafter
>>        /home/yhs/work/llvm-project/llvm/build.18/install/lib/clang/18/include -idirafter /usr/local/include
>>        -idirafter /usr/include -Wno-compare-distinct-pointer-types -DENABLE_ATOMICS_TESTS -O2 --target=bpf
>>        -c progs/pyperf180.c -mcpu=v3 -o /home/yhs/work/bpf-next/tools/testing/selftests/bpf/pyperf180.bpf.o
>>      1.      <eof> parser at end of file
>>      2.      Code generation
>>      ...
>>
>> The compilation failure only happens to cpu=v2 and cpu=v3. cpu=v4 is okay
>> since cpu=v4 supports 32-bit branch target offset.
>>
>> The above failure is due to upstream llvm patch [1] where some inlining behavior
>> are changed in llvm18.
>>
>> To workaround the issue, previously all 180 loop iterations are fully unrolled.
>> Now, the fully unrolling count is changed to 90 for llvm18 and later. This reduced
>> some otherwise long branch target distance, and fixed the compilation failure.
>>
>>    [1] https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b5720c607313a566eebb16e
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> Can confirm, the issue is present on clang main w/o this patch and
> disappears after this patch.
>
> Yonghong, is there a way to keep original UNROLL_COUNT if cpuv4 is used?

I thought about this but a little bit lazy so not giving it enough throught.
But since you mentioned this, I think adding a macro to indicate cpu version
by llvm is a good idea. This will give bpf developers some flexibility to
add new features (new cpu variant) or workaround bugs (for a particular cpu variant
but not impacting others if they are fine), etc.

So here is the llvm patch: https://github.com/llvm/llvm-project/pull/71856

With the above llvm patch, the following code change should work:

diff --git a/tools/testing/selftests/bpf/progs/pyperf180.c b/tools/testing/selftests/bpf/progs/pyperf180.c
index c39f559d3100..2473845d1ee2 100644
--- a/tools/testing/selftests/bpf/progs/pyperf180.c
+++ b/tools/testing/selftests/bpf/progs/pyperf180.c
@@ -1,4 +1,18 @@
  // SPDX-License-Identifier: GPL-2.0
  // Copyright (c) 2019 Facebook
  #define STACK_MAX_LEN 180
+
+/* llvm upstream commit at llvm18
+ *   https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b5720c607313a566eebb16e
+ * changed inlining behavior and caused compilation failure as some branch
+ * target distance exceeded 16bit representation which is the maximum for
+ * cpu v1/v2/v3. Macro __bpf_cpu_version__ is implemented in llvm18 to specify
+ * which cpu version is used for compilation. So we can set a smaller
+ * unroll_count if __bpf_cpu_version__ is less than 4, which reduced
+ * some branch target distances and resolved the compilation failure.
+ */
+#if defined(__bpf_cpu_version__) && __bpf_cpu_version__ < 4
+#define UNROLL_COUNT 90
+#endif
+
  #include "pyperf.h"


>
> Tested-by: Eduard Zingerman <eddyz87@gmail.com>

