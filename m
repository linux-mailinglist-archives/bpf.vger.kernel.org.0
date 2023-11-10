Return-Path: <bpf+bounces-14800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A197E84E2
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 22:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A4E2812CC
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 21:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D20F3C097;
	Fri, 10 Nov 2023 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SfxLwdGF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBBB3B7A5
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 21:03:13 +0000 (UTC)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [IPv6:2001:41d0:203:375::b0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25829133
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 13:03:09 -0800 (PST)
Message-ID: <4e79cf07-cfd0-4662-82cc-cfb0c9f39f4c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699650186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4YtGBOP2wt4s/AzLZa4K8lpbxPEwW7TsGINgBiHBG20=;
	b=SfxLwdGF3cCW+P6ykHoGScIisqK5rKK8rzyCPjigCIeIiVVBh6RraboH/hYkxxzToW2tfp
	hP0aQKKT/BTqKJlKUEUqVRRxLYSYoQhgu0TyRQbvr33di+nPf2RDiK6IQjklGfMkAhRZbc
	mEP7ZO+iu1Nzm89cUnJWTgGDH3zeYcI=
Date: Fri, 10 Nov 2023 13:03:01 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix pyperf180 compilation
 failure with clang18
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20231110193644.3130906-1-yonghong.song@linux.dev>
 <CAEf4BzbAfXiqWCp4yZHqtxsQqje7kuRVODatG4E_a4_zqAK5CQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzbAfXiqWCp4yZHqtxsQqje7kuRVODatG4E_a4_zqAK5CQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/10/23 11:45 AM, Andrii Nakryiko wrote:
> On Fri, Nov 10, 2023 at 11:37 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> With latest clang18 (main branch of llvm-project repo), when building bpf selftests,
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
>> are changed in clang18.
>>
>> To workaround the issue, previously all 180 loop iterations are fully unrolled.
>> The bpf macro __BPF_CPU_VERSION__ (implemented in clang18 recently) is used to avoid
>> unrolling changes if cpu=v4. If __BPF_CPU_VERSION__ is not available and the
>> compiler is clang18, the unrollng amount is unconditionally reduced.
>>
>>    [1] https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b5720c607313a566eebb16e
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/testing/selftests/bpf/progs/pyperf180.c | 22 +++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/pyperf180.c b/tools/testing/selftests/bpf/progs/pyperf180.c
>> index c39f559d3100..42c4a8b62e36 100644
>> --- a/tools/testing/selftests/bpf/progs/pyperf180.c
>> +++ b/tools/testing/selftests/bpf/progs/pyperf180.c
>> @@ -1,4 +1,26 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   // Copyright (c) 2019 Facebook
>>   #define STACK_MAX_LEN 180
>> +
>> +/* llvm upstream commit at clang18
>> + *   https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b5720c607313a566eebb16e
>> + * changed inlining behavior and caused compilation failure as some branch
>> + * target distance exceeded 16bit representation which is the maximum for
>> + * cpu v1/v2/v3. Macro __BPF_CPU_VERSION__ is later implemented in clang18
>> + * to specify which cpu version is used for compilation. So a smaller
>> + * unroll_count can be set if __BPF_CPU_VERSION__ is less than 4, which
>> + * reduced some branch target distances and resolved the compilation failure.
>> + *
>> + * To capture the case where a developer/ci uses clang18 but the corresponding
>> + * repo checkpoint does not have __BPF_CPU_VERSION__, a smaller unroll_count
>> + * will be set as well to prevent potential compilation failures.
>> + */
>> +#ifdef __BPF_CPU_VERSION__
>> +#if __BPF_CPU_VERSION__ < 4
>> +#define UNROLL_COUNT 90
>> +#endif
>> +#elif __clang_major__ == 18
>> +#define UNROLL_COUNT 90
>> +#endif
>> +
> can it be written as one if?
>
> #if (defined(__BPF_CPU_VERSION__) && __BPF_CPU_VERSION__ < 4) ||
> __clang_major >= 18
>
>
> ?

This won't work. For example, using latest upstream clang18, __BPF_CPU_VERSION__ does exist,
and user use cpu v4, in this case we do not want to do unrolling but with the above:
   
(defined(__BPF_CPU_VERSION__) && __BPF_CPU_VERSION__ < 4) is false
__clang_major >= 18 is true

so we do unrolling but we do not need to do since user uses cpu v4.



>
>>   #include "pyperf.h"
>> --
>> 2.34.1
>>
>>

