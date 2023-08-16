Return-Path: <bpf+bounces-7860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A1B77D80B
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 04:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5C6280D6B
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 02:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA87523C;
	Wed, 16 Aug 2023 01:57:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335B46BE
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 01:57:57 +0000 (UTC)
Received: from out-51.mta1.migadu.com (out-51.mta1.migadu.com [IPv6:2001:41d0:203:375::33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF34212E
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 18:57:50 -0700 (PDT)
Message-ID: <2fd02263-669f-82cf-d2c0-86fb5e4ad993@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692151068; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0oLzcpuisQPOwYQEpTGqv/JCJ88xAmPPG5jHaEZptyI=;
	b=XzHoLuW24og1pQCr7dfz/7QuWvyYJ0f0m49NVASvS7VrPABQQpyCZaalDoIAHNM6L7CbxV
	Tvuse7bkgQH0sI57NWBM2+O+jGSgc24aXWGIuaW4f/4/x1cIM1oW6snb9iLTTTFtrsMRCq
	snJMjzf60o4mq8blaKXeo2yajCNt4t4=
Date: Tue, 15 Aug 2023 18:57:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: Enable cpu v4 tests for arm64
Content-Language: en-US
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Yonghong Song <yhs@fb.com>,
 Zi Shen Lim <zlim.lnx@gmail.com>
References: <20230815154158.717901-1-xukuohai@huaweicloud.com>
 <20230815154158.717901-8-xukuohai@huaweicloud.com>
 <f1b6fde2-5097-7a0f-29ad-7390a165bf16@linux.dev>
 <67212714-15f3-84e8-d5c6-84746632eedd@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <67212714-15f3-84e8-d5c6-84746632eedd@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/15/23 6:28 PM, Xu Kuohai wrote:
> On 8/16/2023 12:57 AM, Yonghong Song wrote:
>>
>>
>> On 8/15/23 8:41 AM, Xu Kuohai wrote:
>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>
>>> Enable cpu v4 instruction tests for arm64.
>>>
>>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>>
>> Thanks for adding cpu v4 support for arm64. The CI looks green as well 
>> for arm64.
>>
>> https://github.com/kernel-patches/bpf/actions/runs/5868919914/job/15912774884?pr=5525
>>
> 
> Well, it looks like the CI's clang doesn't support cpu v4 yet:
> 
>    #306/1   verifier_bswap/cpuv4 is not supported by compiler or jit, 
> use a dummy test:OK
>    #306     verifier_bswap:OK
> 
>> Ack this patch which enabled cpu v4 tests for arm64.

Ah. Sorry. Could you paste your local cpu v4 run results for
these related tests in the commit message then?

>>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>
>>> ---
>>>   tools/testing/selftests/bpf/progs/test_ldsx_insn.c | 2 +-
>>>   tools/testing/selftests/bpf/progs/verifier_bswap.c | 2 +-
>>>   tools/testing/selftests/bpf/progs/verifier_gotol.c | 2 +-
>>>   tools/testing/selftests/bpf/progs/verifier_ldsx.c  | 2 +-
>>>   tools/testing/selftests/bpf/progs/verifier_movsx.c | 2 +-
>>>   tools/testing/selftests/bpf/progs/verifier_sdiv.c  | 2 +-
>>>   6 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c 
>>> b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
>>> index 321abf862801..916d9435f12c 100644
>>> --- a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
>>> +++ b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
>>> @@ -5,7 +5,7 @@
>>>   #include <bpf/bpf_helpers.h>
>>>   #include <bpf/bpf_tracing.h>
>>> -#if defined(__TARGET_ARCH_x86) && __clang_major__ >= 18
>>> +#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86)) && 
>>> __clang_major__ >= 18
>>>   const volatile int skip = 0;
>>>   #else
>>>   const volatile int skip = 1;
>> [...]
>>
>> .
> 

