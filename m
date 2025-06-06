Return-Path: <bpf+bounces-59839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F80ACFC54
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 08:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 952F27A45EA
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 05:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43D1242930;
	Fri,  6 Jun 2025 06:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cinwqVeV"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1459F2417C8
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 06:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749189625; cv=none; b=nanX7H/JxnIvjXnPb6FRZ8B3wgUUlSTkW3yFMuvIsNvjGVFtq1iibY0X5nks8z+yvdHqrWcL06qUv9hPEQhUZb74IM/KoFaV544D10ajJnEY8eo1GslzxBjcK6EhAWrM+JtHovCuuoUtQk10HAArfcW0UFgM1VbNRuNrxhg2/D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749189625; c=relaxed/simple;
	bh=0RJcQq9aIpcZjLYtdJ/j1Rs6jeDH6DKoRW5a8f364Ws=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WNKCEvgeJMedA6q4Zf+1+Q4/eZGkYUUTRTmUPEZSbv6Lg3deTlN8X/GJuOdmCYIPXxs9JeFhvAMUNyau5xuOaXu+R7xCyp+4pb2C+QbkqTBcA0A89ePSV5/391RUWM/rEaY1a/1LnQw6b2IKZ/yv86T8Uk2kopL0wb6ihhalV/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cinwqVeV; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0e1160e2-5d62-467e-8eb7-b2e95c904bd8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749189620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BDoxShwpov2IyeknKKnXDK91cdZPy+oE0MIWpBt9ebs=;
	b=cinwqVeVZS+bNZgjDTdafFjtgn2XShlsZo1Eq4Tv2C3q7DnM3ME611XQyWogkZxXdpVj3v
	cugHH+XS/Poa1idXryBF8Wg9PYM5sFPogx3q1E8u1TzHepeznjinpYNnHh2lbpvXjjXiDO
	yI6/xPKO3H7ukcYaWu0+eW7SwTxgGgs=
Date: Thu, 5 Jun 2025 23:00:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Fix a user_ringbuf failure
 with arm64 64KB page size
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20250606032309.444401-1-yonghong.song@linux.dev>
 <20250606032330.446016-1-yonghong.song@linux.dev>
 <22e00248-0b0a-457e-8516-d19d38ac15f9@linux.dev>
In-Reply-To: <22e00248-0b0a-457e-8516-d19d38ac15f9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/5/25 10:52 PM, Yonghong Song wrote:
>
>
> On 6/5/25 8:23 PM, Yonghong Song wrote:
>> The ringbuf max_entries must be PAGE_ALIGNED. See kernel function
>> ringbuf_map_alloc(). So for arm64 64KB page size, adjust max_entries
>> properly.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/user_ringbuf.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c 
>> b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
>> index d424e7ecbd12..f50aa8e7f6c2 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
>> @@ -21,8 +21,7 @@
>>   #include "../progs/test_user_ringbuf.h"
>>     static const long c_sample_size = sizeof(struct sample) + 
>> BPF_RINGBUF_HDR_SZ;
>> -static const long c_ringbuf_size = 1 << 12; /* 1 small page */
>> -static const long c_max_entries = c_ringbuf_size / c_sample_size;
>> +static long c_ringbuf_size, c_max_entries;
>>     static void drain_current_samples(void)
>>   {
>> @@ -686,6 +685,9 @@ void test_user_ringbuf(void)
>>   {
>>       int i;
>>   +    c_ringbuf_size = getpagesize(); /* 1 page */
>> +    c_max_entries = c_ringbuf_size / c_sample_size;
>> +
>>       for (i = 0; i < ARRAY_SIZE(success_tests); i++) {
>>           if (!test__start_subtest(success_tests[i].test_name))
>>               continue;
>
> CI reports a build failure error:
>
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c:426:2: 
> error: call to '__compiletime_assert_0' declared with 'error' 
> attribute: BUILD_BUG_ON failed: total_samples <= c_max_entries   426 | 
> BUILD_BUG_ON(total_samples <= c_max_entries     |
>
> /tmp/work/bpf/bpf/tools/include/linux/build_bug.h:50:2: note: expanded 
> from macro 'BUILD_BUG_ON' 50 | BUILD_BUG_ON_MSG(condition, 
> "BUILD_BUG_ON failed: " #condition) | ^ 
> /tmp/work/bpf/bpf/tools/include/linux/build_bug.h:39:37: note: 
> expanded from macro 'BUILD_BUG_ON_MSG' 39 | #define 
> BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg) | ^ 
> /tmp/work/bpf/bpf/tools/include/linux/compiler.h:37:2: note: expanded 
> from macro 'compiletime_assert' 37 | _compiletime_assert(condition, 
> msg, __compiletime_assert_, __COUNTER__) | ^ 
> /tmp/work/bpf/bpf/tools/include/linux/compiler.h:25:2: note: expanded 
> from macro '_compiletime_assert' 25 | __compiletime_assert(condition, 
> msg, prefix, suffix) | ^ 
> /tmp/work/bpf/bpf/tools/include/linux/compiler.h:18:4: note: expanded 
> from macro '__compiletime_assert' 18 | prefix ## suffix(); \ | ^ 
> <scratch space>:60:1: note: expanded from here 60 | 
> __compiletime_assert_0
>
> | ^ This happens for the release build (RELEASE=1 in build command 
> line where -O2 is used in stead of -O0). Converting the BUILD_BUG_ON 
> to ASSERT can fix the problem. diff --git 
> a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c 
> b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c index 
> f50aa8e7f6c2..467b5b8beecc 100644 --- 
> a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c +++ 
> b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c @@ -423,7 
> +423,9 @@ static void test_user_ringbuf_loop(void) uint32_t 
> remaining_samples = total_samples; int err; - 
> BUILD_BUG_ON(total_samples <= c_max_entries); + if 
> (!ASSERT_LE(total_samples, c_max_entries, "compare_c_max_entries")) + 
> return; + err = load_skel_create_user_ringbuf(&skel, &ringbuf); I will 
> wait for some further comments before posting v2.


Sorry for mess up. Basically, need to replace a BUILD_BUG_ON with a ASSERT...
I already tried to format the code properly but somehow still messed up.
Will debug/double-check this next time.



