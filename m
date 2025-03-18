Return-Path: <bpf+bounces-54286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C5CA66ECC
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 09:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C303B508E
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 08:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB7E2036FA;
	Tue, 18 Mar 2025 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GcRIzjgT"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6421F9416
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287519; cv=none; b=so+2v7EaiQTHEoufCTrzHdRysuM6BzTg756AudRGpfXwW2LR0/YcLh4A148d8Cl6HYv5aOiCA1sV8szmV3zZc1T6ZNmjRBIFUmg4/pErK9DY/njkfd2R6oA/Dhv4lya0gsbjgjUWy2sagtjTYFUVClGen0aX8zKsPyPWUFvbiaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287519; c=relaxed/simple;
	bh=YrsCAeFnmMDkMfef832NmuDNZ7nSUINQ3sYt/n6CGYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKp+c5zO1Lf6Ao7/Xz2JcqdTa4BgecjAUFejs+ns3DIJYSNmZ5SqPnnSnXOLkBNoBTM6YTaczPvaBWtMHxVAsSRY85g8orBX1Vy0/Zvxwi1ttmRjdV0JxSrmJaBmmG1tzxrvo+taNNzul2l6azNdUbEoC9JShWfo8ZwQgOMabQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GcRIzjgT; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <58ebfd15-3cd9-4f73-a185-a572c52f08c3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742287515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ugSHQkLbo8Om3uB79hj9ukf15dpfjV2L0RxE76RQ0A=;
	b=GcRIzjgTsddIcb0CeoOBxTLvqdtuNGJLoMVpMmJMB8g3JBSswm7s1OPvPGjZ37g3/JIscn
	n1pWkuQLP2EfN2mqee8KjMVROkwWNmTtnJWm3+hH+0dyjGiQwKvAF/z2wM+F2A+37takAu
	ySkG20PNWula6WIrd946V+mRtilTaCE=
Date: Tue, 18 Mar 2025 08:45:13 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 3/4] selftests/bpf: add selftest to check
 bpf_get_cpu_time_counter jit
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Vadim Fedorenko <vadfed@meta.com>
Cc: Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Yonghong Song <yonghong.song@linux.dev>, Mykola Lysenko <mykolal@fb.com>,
 X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Martin KaFai Lau <martin.lau@linux.dev>
References: <20250317224932.1894918-1-vadfed@meta.com>
 <20250317224932.1894918-4-vadfed@meta.com>
 <CAADnVQKzXjC2-24V_dYiq_cCf8Df-Sm0Kf=keiyBrLKZ0yXeVg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAADnVQKzXjC2-24V_dYiq_cCf8Df-Sm0Kf=keiyBrLKZ0yXeVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 18/03/2025 00:30, Alexei Starovoitov wrote:
> On Mon, Mar 17, 2025 at 3:50 PM Vadim Fedorenko <vadfed@meta.com> wrote:
>>
>> bpf_get_cpu_time_counter() is replaced with rdtsc instruction on x86_64.
>> Add tests to check that JIT works as expected.
>>
>> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   .../selftests/bpf/prog_tests/verifier.c       |   2 +
>>   .../selftests/bpf/progs/verifier_cpu_cycles.c | 104 ++++++++++++++++++
>>   2 files changed, 106 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
>> index e66a57970d28..d5e7e302a344 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
>> @@ -102,6 +102,7 @@
>>   #include "verifier_xdp_direct_packet_access.skel.h"
>>   #include "verifier_bits_iter.skel.h"
>>   #include "verifier_lsm.skel.h"
>> +#include "verifier_cpu_cycles.skel.h"
>>   #include "irq.skel.h"
>>
>>   #define MAX_ENTRIES 11
>> @@ -236,6 +237,7 @@ void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
>>   void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
>>   void test_irq(void)                          { RUN(irq); }
>>   void test_verifier_mtu(void)                 { RUN(verifier_mtu); }
>> +void test_verifier_cpu_cycles(void)          { RUN(verifier_cpu_cycles); }
>>
>>   static int init_test_val_map(struct bpf_object *obj, char *map_name)
>>   {
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c b/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c
>> new file mode 100644
>> index 000000000000..5b62e3690362
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c
>> @@ -0,0 +1,104 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2022 Meta Inc. */
> 
> botched copy paste.

Ouch.

