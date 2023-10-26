Return-Path: <bpf+bounces-13340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF477D8710
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 18:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C230128211A
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 16:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D722537C85;
	Thu, 26 Oct 2023 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="epgmVIR5"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC5F2D78B
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 16:54:30 +0000 (UTC)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730731A1
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 09:54:28 -0700 (PDT)
Message-ID: <4f3f8433-e7e7-4b31-856c-b47de43d0af5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698339264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQz4N87msCqtfsQPri8TyJXzjkxfX6dqe57CGapr5qw=;
	b=epgmVIR5LOhtrZRvqlhCpAWxPqi23834B6X8rUtzTPKK1m/juOkEcqpKXZcCEKS9Svhh7v
	mDLUmguvbNAKNjha/8AsXiBwRGPbl7Uj0y98JwQB0ynInM6yv+BQokMYHlWPtBMryFqVib
	PuNOkyVFJNeck6wDgxAV16q9XfOhx0Q=
Date: Thu, 26 Oct 2023 09:54:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: Fix selftests broken by
 mitigations=off
To: Daniel Borkmann <daniel@iogearbox.net>, Yafang Shao
 <laoar.shao@gmail.com>, alexei.starovoitov@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 gerhorst@cs.fau.de, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, martin.lau@linux.dev, sdf@google.com,
 song@kernel.org
References: <CAADnVQKUBJqg+hHtbLeeC2jhoJAWqnmRAzXW3hmUCNSV9kx4sQ@mail.gmail.com>
 <20231025031144.5508-1-laoar.shao@gmail.com>
 <e6c950d7-bb81-4265-bbbe-0201694280b3@linux.dev>
 <3f47542a-ec0f-c33c-4300-36b54858a79c@iogearbox.net>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <3f47542a-ec0f-c33c-4300-36b54858a79c@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/26/23 6:46 AM, Daniel Borkmann wrote:
> On 10/25/23 6:56 AM, Yonghong Song wrote:
>> On 10/24/23 8:11 PM, Yafang Shao wrote:
>>> When we configure the kernel command line with 'mitigations=off' and 
>>> set
>>> the sysctl knob 'kernel.unprivileged_bpf_disabled' to 0, the commit
>>> bc5bc309db45 ("bpf: Inherit system settings for CPU security 
>>> mitigations")
>>> causes issues in the execution of `test_progs -t verifier`. This is 
>>> because
>>> 'mitigations=off' bypasses Spectre v1 and Spectre v4 protections.
>>>
>>> Currently, when a program requests to run in unprivileged mode
>>> (kernel.unprivileged_bpf_disabled = 0), the BPF verifier may prevent it
>>> from running due to the following conditions not being enabled:
>>>
>>>    - bypass_spec_v1
>>>    - bypass_spec_v4
>>>    - allow_ptr_leaks
>>>    - allow_uninit_stack
>>>
>>> While 'mitigations=off' enables the first two conditions, it does not
>>> enable the latter two. As a result, some test cases in
>>> 'test_progs -t verifier' that were expected to fail to run may run
>>> successfully, while others still fail but with different error 
>>> messages.
>>> This makes it challenging to address them comprehensively.
>>>
>>> Moreover, in the future, we may introduce more fine-grained control 
>>> over
>>> CPU mitigations, such as enabling only bypass_spec_v1 or 
>>> bypass_spec_v4.
>>>
>>> Given the complexity of the situation, rather than fixing each 
>>> broken test
>>> case individually, it's preferable to skip them when 
>>> 'mitigations=off' is
>>> in effect and introduce specific test cases for the new 
>>> 'mitigations=off'
>>> scenario. For instance, we can introduce new BTF declaration tags like
>>> '__failure__nospec', '__failure_nospecv1' and '__failure_nospecv4'.
>>>
>>> In this patch, the approach is to simply skip the broken test cases 
>>> when
>>> 'mitigations=off' is enabled. The result of `test_progs -t verifier` as
>>> follows after this commit,
>>>
>>> Before this commit
>>> ==================
>>> - without 'mitigations=off'
>>>    - kernel.unprivileged_bpf_disabled = 2
>>>      Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
>>>    - kernel.unprivileged_bpf_disabled = 0
>>>      Summary: 74/1336 PASSED, 0 SKIPPED, 0 FAILED <<<<
>>> - with 'mitigations=off'
>>>    - kernel.unprivileged_bpf_disabled = 2
>>>      Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
>>>    - kernel.unprivileged_bpf_disabled = 0
>>>      Summary: 63/1276 PASSED, 0 SKIPPED, 11 FAILED <<<< 11 FAILED
>>>
>>> After this commit
>>> =================
>>> - without 'mitigations=off'
>>>    - kernel.unprivileged_bpf_disabled = 2
>>>      Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
>>>    - kernel.unprivileged_bpf_disabled = 0
>>>      Summary: 74/1336 PASSED, 0 SKIPPED, 0 FAILED <<<<
>>> - with this patch, with 'mitigations=off'
>>>    - kernel.unprivileged_bpf_disabled = 2
>>>      Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
>>>    - kernel.unprivileged_bpf_disabled = 0
>>>      Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED <<<< SKIPPED
>>>
>>> Fixes: bc5bc309db45 ("bpf: Inherit system settings for CPU security 
>>> mitigations")
>>> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>>> Closes: 
>>> https://lore.kernel.org/bpf/CAADnVQKUBJqg+hHtbLeeC2jhoJAWqnmRAzXW3hmUCNSV9kx4sQ@mail.gmail.com
>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>
>> Ack with a nit below.
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>
> [...]
>>>       }
>>> -    return disabled;
>>> +    return disabled ? true : get_mitigations_off();
>>
>> Above code is correct. But you could slightly simplify it with
>>      return disabled ? : get_mitigations_off();
>>
>> I guess maintainer can decide whether simplification is needed
>> or not.
>
> Turns out if you omit, then compiler will complain with a warning :)
>
>   [...]
>   GEN      vmlinux.h
> unpriv_helpers.c: In function ‘get_unpriv_disabled’:
> unpriv_helpers.c:56:27: error: the omitted middle operand in ‘?:’ will 
> always be ‘true’, suggest explicit middle operand [-Werror=parentheses]
>    56 |         return disabled ? : get_mitigations_off();
>       |                           ^
> cc1: all warnings being treated as errors
> make: *** [Makefile:615: 
> /root/linux/tools/testing/selftests/bpf/unpriv_helpers.o] Error 1

clang compiler is okay with '?:' change while gcc compiler issued errors. So yes,
existing code is good for both compilers. Thanks!


>
> So it's okay as is, applied, thanks!
>

