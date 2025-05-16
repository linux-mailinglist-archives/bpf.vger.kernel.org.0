Return-Path: <bpf+bounces-58411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA39ABA0BD
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 18:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D427E3B5F76
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 16:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F408F1A5BBA;
	Fri, 16 May 2025 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tQfYZris"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3771FAA
	for <bpf@vger.kernel.org>; Fri, 16 May 2025 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747412603; cv=none; b=OPJ0jHEwNcLVgroJtAh5gsx5oJkSZlyKxTggJ48LVV8nOU6oaRZ/BMLiiZnp3D1CyEsBniWjOvoQWxDIiH7rKnxjQKwOajYSgiUAwtF71SAOtpVrhhqTVNb7lpxmCEztcUWU1PwPSHgAtxhNJKwWQqeKhaLNTrA0IRK5ElnVG98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747412603; c=relaxed/simple;
	bh=qXTxjCHj/2lzWf7qwiTZyzujqaMK+sHJnYu03Ttw298=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YB0Iw9bPb8AE1oFx8T9neA0NNRaD1UOFcnYDgMk6OEViqyfqc9Puvy9kk5KvX3nR4BJaBaj5cp4okYkfmfL6/Z4bQHPS0CGJj8zx3z1X4RJCBxErfJ4Fp01KXZHNwAJSejr6wed9Uqz4CUwJGd/AtI78vDnP+PoU5vmcEeYuHTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tQfYZris; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <055d3224-360b-4db1-bb51-6945a1cceca0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747412593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABTy/7ER+yerTkz/lZnhLLhELNIMLRIyEcxGokIaMBg=;
	b=tQfYZrisiaDvHYVMoKXkobUj+egowkyq5BmCXeH19EAKGuMS5xxTdnDsLv9juQp9Ynlgp4
	wSqRI9M24yeg9cM+wTcSGssK/B9mjImMt6YF4Ed+5o+fG8cA9snGQt73wVjSvZmMX1Uw1q
	cuahsLwOnSlefhbp4q8z9UBp1cS0GQI=
Date: Fri, 16 May 2025 09:23:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix
 dynptr/test_probe_read_user_str_dynptr test failure
Content-Language: en-GB
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250515195145.3127492-1-yonghong.song@linux.dev>
 <d2368b21-2e45-4601-be04-fc2e51ccf91f@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <d2368b21-2e45-4601-be04-fc2e51ccf91f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/16/25 12:03 AM, Mykyta Yatsenko wrote:
> On 5/15/25 20:51, Yonghong Song wrote:
>> When running bpf selftests with llvm18 compiler, I hit the following
>> test failure:
>>
>>    verify_success:PASS:dynptr_success__open 0 nsec
>>    verify_success:PASS:bpf_object__find_program_by_name 0 nsec
>>    verify_success:PASS:dynptr_success__load 0 nsec
>>    verify_success:PASS:test_run 0 nsec
>>    verify_success:FAIL:err unexpected err: actual 1 != expected 0
>>    #91/19   dynptr/test_probe_read_user_str_dynptr:FAIL
>>    #91      dynptr:FAIL
>>
>> I did some analysis and found that the test failure is related to
>> lib/strncpy_from_user.c function do_strncpy_from_user():
>>
>>    ...
>>    byte_at_a_time:
>>          while (max) {
>>                  char c;
>>
>>                  unsafe_get_user(c,src+res, efault);
>>                  dst[res] = c;
>>                  if (!c)
>>                          return res;
>>                  res++;
>>                  max--;
>>          }
>>    ...
>>
>> Depending on whether the character 'c' is '\0' or not, the
>> return value 'res' could be different.
>>
>> In prog_tests/dynptr.c, we have
>>    char user_data[384] = {[0 ... 382] = 'a', '\0'};
>> the user_data[383] is '\0'. This will cause the following
>> error in progs/dynptr_success.c:
>>
>>    test_dynptr_probe_str_xdp:
>>    ...
>>          bpf_for(i, 0, ARRAY_SIZE(test_len)) {
>>                  __u32 len = test_len[i];
>>
>>                  cnt = bpf_read_dynptr_fn(&ptr_xdp, off, len, ptr);
>>                  if (cnt != len)
>>                          err = 1; <=== error happens here
>>    ...
>>
>> In the above particular case, len is 384 and cnt is 383.
>>
>> If user_data[384] is changed to
>>    char user_data[384] = {[0 ... 383] = 'a'};
>>
>> The above error will not happen and the test will run successfully.
>>
>> Cc: Mykyta Yatsenko <yatsenko@meta.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/dynptr.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c 
>> b/tools/testing/selftests/bpf/prog_tests/dynptr.c
>> index 62e7ec775f24..4cc61afa63b4 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
>> @@ -45,7 +45,7 @@ static struct {
>>     static void verify_success(const char *prog_name, enum 
>> test_setup_type setup_type)
>>   {
>> -    char user_data[384] = {[0 ... 382] = 'a', '\0'};
>> +    char user_data[384] = {[0 ... 383] = 'a'};
>>       struct dynptr_success *skel;
>>       struct bpf_program *prog;
>>       struct bpf_link *link;
> This test is disabled in the DENYLIST and the fix was submitted to 
> another tree:
> https://patchwork.kernel.org/project/linux-mm/patch/20250422131449.57177-1-mykyta.yatsenko5@gmail.com/ 
>
> It's a little bit different problem.

Okay. This works too. I thought about this earlier during investigation but decided not to change core kernel code...



