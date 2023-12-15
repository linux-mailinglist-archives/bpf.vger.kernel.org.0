Return-Path: <bpf+bounces-18001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ED6814AD3
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 15:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA3E1C23823
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 14:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB95636B0A;
	Fri, 15 Dec 2023 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vnVVp+AN"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D3B381AF
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <de0466f0-58af-4eab-bc31-0297eae744ce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702651338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k98CAhdEGxI1A7WH8BLOOqcXqzqHTgKBwSvjKVKe6cg=;
	b=vnVVp+ANLIXO14HkbzsOhcOzEGm2bH5DIt84gqXf/QAK7VykdZ8zhOQgl+Z0yo2Keq2A/e
	o6RPqi/zbOrqPYZjCbuyz+kZpRpTVBeBlv0ECppHy/K2OvxoTuHrlAPQQdsZDpsPzGwCUG
	1AApv5BOls5cPAUGgx2bhzFn6EePcRE=
Date: Fri, 15 Dec 2023 06:42:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC] bpf: Issue with bpf_fentry_test7 call
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
References: <ZXwZa_eK7bWXjJk7@krava> <ZXxhlG2gndCZ71Ox@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZXxhlG2gndCZ71Ox@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/15/23 6:24 AM, Jiri Olsa wrote:
> On Fri, Dec 15, 2023 at 10:16:27AM +0100, Jiri Olsa wrote:
>> hi,
>> The bpf CI is broken due to clang emitting 2 functions for
>> bpf_fentry_test7:
>>
>>    # cat available_filter_functions | grep bpf_fentry_test7
>>    bpf_fentry_test7
>>    bpf_fentry_test7.specialized.1
>>
>> The tests attach to 'bpf_fentry_test7' while the function with
>> '.specialized.1' suffix is executed in bpf_prog_test_run_tracing.
>>
>> It looks like clang optimalization that comes from passing 0
>> as argument and returning it directly in bpf_fentry_test7.
>>
>> I'm not sure there's a way to disable this, so far I came
>> up with solution below that passes real pointer, but I think
>> that was not the original intention for the test.
>>
>> We had issue with this function back in august:
>>    32337c0a2824 bpf: Prevent inlining of bpf_fentry_test7()
>>
>> I'm not sure why it started to show now? was clang updated for CI?
>>
>> I'll try to find out more, but any clang ideas are welcome ;-)
>>
>> thanks,
>> jirka
>
> hm, there seems to be fix in bpf-next for this one:
>
>    b16904fd9f01 bpf: Fix a few selftest failures due to llvm18 change

Maybe submit a patch to https://github.com/kernel-patches/vmtest/tree/master/ci/diffs?
That is typically the place to have temporary patches to workaround ci failures.

>
> jirka
>
>>
>> ---
>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>> index c9fdcc5cdce1..33208eec9361 100644
>> --- a/net/bpf/test_run.c
>> +++ b/net/bpf/test_run.c
>> @@ -543,7 +543,7 @@ struct bpf_fentry_test_t {
>>   int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
>>   {
>>   	asm volatile ("");
>> -	return (long)arg;
>> +	return 0;
>>   }
>>   
>>   int noinline bpf_fentry_test8(struct bpf_fentry_test_t *arg)
>> @@ -668,7 +668,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
>>   		    bpf_fentry_test4((void *)7, 8, 9, 10) != 34 ||
>>   		    bpf_fentry_test5(11, (void *)12, 13, 14, 15) != 65 ||
>>   		    bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) != 111 ||
>> -		    bpf_fentry_test7((struct bpf_fentry_test_t *)0) != 0 ||
>> +		    bpf_fentry_test7(&arg) != 0 ||
>>   		    bpf_fentry_test8(&arg) != 0 ||
>>   		    bpf_fentry_test9(&retval) != 0)
>>   			goto out;
>> diff --git a/tools/testing/selftests/bpf/progs/fentry_test.c b/tools/testing/selftests/bpf/progs/fentry_test.c
>> index 52a550d281d9..95c5c34ccaa8 100644
>> --- a/tools/testing/selftests/bpf/progs/fentry_test.c
>> +++ b/tools/testing/selftests/bpf/progs/fentry_test.c
>> @@ -64,7 +64,7 @@ __u64 test7_result = 0;
>>   SEC("fentry/bpf_fentry_test7")
>>   int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>>   {
>> -	if (!arg)
>> +	if (arg)
>>   		test7_result = 1;
>>   	return 0;
>>   }
>> diff --git a/tools/testing/selftests/bpf/progs/fexit_test.c b/tools/testing/selftests/bpf/progs/fexit_test.c
>> index 8f1ccb7302e1..ffb30236ca02 100644
>> --- a/tools/testing/selftests/bpf/progs/fexit_test.c
>> +++ b/tools/testing/selftests/bpf/progs/fexit_test.c
>> @@ -65,7 +65,7 @@ __u64 test7_result = 0;
>>   SEC("fexit/bpf_fentry_test7")
>>   int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>>   {
>> -	if (!arg)
>> +	if (arg)
>>   		test7_result = 1;
>>   	return 0;
>>   }

