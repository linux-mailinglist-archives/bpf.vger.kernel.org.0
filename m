Return-Path: <bpf+bounces-15998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1E27FAA93
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 20:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789C0B20FBE
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE2E405F9;
	Mon, 27 Nov 2023 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cBnLyRTl"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [IPv6:2001:41d0:203:375::b3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A933B8
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:49:12 -0800 (PST)
Message-ID: <f25da05e-0a93-449b-a683-526641c7acf6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701114548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W2xyc3bczQKjD8Ol+8w/yaoX1aqzk7PaaSu2pYKAhqw=;
	b=cBnLyRTlYeXHcur1bmUe0d2zQgLqXM2KFlMpooz5YXuDhtNC7N5skMhm5mBhnisoxFBGBK
	eOaqyZfsKgT5icGJ4oJ1sjtkh5wa+Le8XdKo5ZIh87GS9V8WRDSNl72vQQ50C/9tsCuTp3
	9qcY2nJ9G9cBIXx2vSqiU1p1QFuhw0E=
Date: Mon, 27 Nov 2023 11:49:03 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Fix a few selftest failures due to llvm18
 change
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20231127050342.1945270-1-yonghong.song@linux.dev>
 <CAEf4BzZYydzYLCyPYxsUQ1OhMnnHw7f+mmErzNQFXubZCj8t9w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZYydzYLCyPYxsUQ1OhMnnHw7f+mmErzNQFXubZCj8t9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/27/23 1:49 PM, Andrii Nakryiko wrote:
> On Sun, Nov 26, 2023 at 9:04 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> With latest upstream llvm18, the following test cases failed:
>>    $ ./test_progs -j
>>    #13/2    bpf_cookie/multi_kprobe_link_api:FAIL
>>    #13/3    bpf_cookie/multi_kprobe_attach_api:FAIL
>>    #13      bpf_cookie:FAIL
>>    #77      fentry_fexit:FAIL
>>    #78/1    fentry_test/fentry:FAIL
>>    #78      fentry_test:FAIL
>>    #82/1    fexit_test/fexit:FAIL
>>    #82      fexit_test:FAIL
>>    #112/1   kprobe_multi_test/skel_api:FAIL
>>    #112/2   kprobe_multi_test/link_api_addrs:FAIL
>>    ...
>>    #112     kprobe_multi_test:FAIL
>>    #356/17  test_global_funcs/global_func17:FAIL
>>    #356     test_global_funcs:FAIL
>>
>> Further analysis shows llvm upstream patch [1] is responsible
>> for the above failures. For example, for function bpf_fentry_test7()
>> in net/bpf/test_run.c, without [1], the asm code is:
>>    0000000000000400 <bpf_fentry_test7>:
>>       400: f3 0f 1e fa                   endbr64
>>       404: e8 00 00 00 00                callq   0x409 <bpf_fentry_test7+0x9>
>>       409: 48 89 f8                      movq    %rdi, %rax
>>       40c: c3                            retq
>>       40d: 0f 1f 00                      nopl    (%rax)
>> and with [1], the asm code is:
>>    0000000000005d20 <bpf_fentry_test7.specialized.1>:
>>      5d20: e8 00 00 00 00                callq   0x5d25 <bpf_fentry_test7.specialized.1+0x5>
>>      5d25: c3                            retq
>> and <bpf_fentry_test7.specialized.1> is called instead of <bpf_fentry_test7>
>> and this caused test failures for #13/#77 etc. except #356.
>>
>> For test case #356/17, with [1] (progs/test_global_func17.c)),
>> the main prog looks like:
>>    0000000000000000 <global_func17>:
>>         0:       b4 00 00 00 2a 00 00 00 w0 = 0x2a
>>         1:       95 00 00 00 00 00 00 00 exit
>> which passed verification while the test itself expects a verification
>> failure.
>>
>> Let us add 'barrier_var' style asm code in both places to prevent
>> function specialization which caused selftests failure.
>>
>>    [1] https://github.com/llvm/llvm-project/pull/72903
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   net/bpf/test_run.c                                     | 2 +-
>>   tools/testing/selftests/bpf/progs/test_global_func17.c | 1 +
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>> index c9fdcc5cdce1..711cf5d59816 100644
>> --- a/net/bpf/test_run.c
>> +++ b/net/bpf/test_run.c
>> @@ -542,7 +542,7 @@ struct bpf_fentry_test_t {
>>
>>   int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
>>   {
>> -       asm volatile ("");
>> +       asm volatile ("": "+r"(arg));
>>          return (long)arg;
>>   }
>>
>> diff --git a/tools/testing/selftests/bpf/progs/test_global_func17.c b/tools/testing/selftests/bpf/progs/test_global_func17.c
>> index a32e11c7d933..5de44b09e8ec 100644
>> --- a/tools/testing/selftests/bpf/progs/test_global_func17.c
>> +++ b/tools/testing/selftests/bpf/progs/test_global_func17.c
>> @@ -5,6 +5,7 @@
>>
>>   __noinline int foo(int *p)
>>   {
>> +       barrier_var(p);
>>          return p ? (*p = 42) : 0;
>>   }
>>
> I recently stumbled upon no_clone ([0]) and no_ipa ([1]) attributes.
> Should we consider using those here instead?
>
>    [0] https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noclone-function-attribute
>    [1] https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noipa-function-attribute

noipa attribute might help here. But sadly, noclone and noipa are gcc specific
and clang does not support either of them.

>
>
>> --
>> 2.34.1
>>

