Return-Path: <bpf+bounces-19047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B4D82477E
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 18:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C632879FD
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 17:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E503286B1;
	Thu,  4 Jan 2024 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DlxtnQRo"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0192228DAB
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f3dd9d80-3fab-4676-b589-1d4667431287@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704389518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/MgIcwgbufD+K7MphBKN+ZekKtDYhLfSrww5v51YLg=;
	b=DlxtnQRovdZpb0rtMaC7tg2Xak8kiBCgOywO4W+JoXHUm9dE8IpEupVc0M8hmX5ljIteCy
	aP/rglzTtwovZyKQoTbJajQZ5eqfV+l2IBIprHLbB9HJJ08F1zVUlpSKxeQdbY5h9T+cxm
	jngvY2DYeiA2X9acjc2qgYwjknNKHFU=
Date: Thu, 4 Jan 2024 09:31:52 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add inline assembly
 helpers to access array elements
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>, Barret Rhoden <brho@google.com>,
 Eddy Z <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 mattbobrowski@google.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240103185403.610641-1-brho@google.com>
 <20240103185403.610641-3-brho@google.com> <ZZa1668ft4Npd1DA@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZZa1668ft4Npd1DA@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

cc Eduard.

On 1/4/24 5:43 AM, Jiri Olsa wrote:
> On Wed, Jan 03, 2024 at 01:53:59PM -0500, Barret Rhoden wrote:
>
> SNIP
>
>> +
>> +
>> +/* Test that attempting to load a bad program fails. */
>> +#define test_bad(PROG) ({						\
>> +	struct array_elem_test *skel;					\
>> +	int err;							\
>> +	skel = array_elem_test__open();					\
>> +	if (!ASSERT_OK_PTR(skel, "array_elem_test open"))		\
>> +		return;							\
>> +	bpf_program__set_autoload(skel->progs.x_bad_ ## PROG, true); 	\
>> +	err = array_elem_test__load(skel);				\
>> +	ASSERT_ERR(err, "array_elem_test load " # PROG);		\
>> +	array_elem_test__destroy(skel);					\
>> +})
> I wonder we could use the existing RUN_TESTS macro and use tags
> in programs like we do for example in progs/test_global_func1.c:
>
>    SEC("tc")
>    __failure __msg("combined stack size of 4 calls is 544")
>    int global_func1(struct __sk_buff *skb)
>
> jirka
>
>
>> +
>> +void test_test_array_elem(void)
>> +{
>> +	if (test__start_subtest("array_elem_access_all"))
>> +		test_access_all();
>> +	if (test__start_subtest("array_elem_oob_access"))
>> +		test_oob_access();
>> +	if (test__start_subtest("array_elem_access_array_map_infer_sz"))
>> +		test_access_array_map_infer_sz();
>> +	if (test__start_subtest("array_elem_bad_map_array_access"))
>> +		test_bad(map_array_access);
>> +	if (test__start_subtest("array_elem_bad_bss_array_access"))
>> +		test_bad(bss_array_access);
>> +
[...]
>> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
>> index 2fd59970c43a..002bab44cde2 100644
>> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
>> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
>> @@ -135,4 +135,47 @@
>>   /* make it look to compiler like value is read and written */
>>   #define __sink(expr) asm volatile("" : "+g"(expr))
>>   
>> +/*
>> + * Access an array element within a bound, such that the verifier knows the
>> + * access is safe.
>> + *
>> + * This macro asm is the equivalent of:
>> + *
>> + *	if (!arr)
>> + *		return NULL;
>> + *	if (idx >= arr_sz)
>> + *		return NULL;
>> + *	return &arr[idx];
>> + *
>> + * The index (___idx below) needs to be a u64, at least for certain versions of
>> + * the BPF ISA, since there aren't u32 conditional jumps.
>> + */
>> +#define bpf_array_elem(arr, arr_sz, idx) ({				\
>> +	typeof(&(arr)[0]) ___arr = arr;					\
>> +	__u64 ___idx = idx;						\
>> +	if (___arr) {							\
>> +		asm volatile("if %[__idx] >= %[__bound] goto 1f;	\
>> +			      %[__idx] *= %[__size];		\
>> +			      %[__arr] += %[__idx];		\
>> +			      goto 2f;				\
>> +			      1:;				\
>> +			      %[__arr] = 0;			\
>> +			      2:				\
>> +			      "						\
>> +			     : [__arr]"+r"(___arr), [__idx]"+r"(___idx)	\
>> +			     : [__bound]"r"((arr_sz)),		        \
>> +			       [__size]"i"(sizeof(typeof((arr)[0])))	\
>> +			     : "cc");					\
>> +	}								\
>> +	___arr;								\
>> +})

The LLVM bpf backend has made some improvement to handle the case like
   r1 = ...
   r2 = r1 + 1
   if (r2 < num) ...
   using r1
by preventing generating the above code pattern.

The implementation is a pattern matching style so surely it won't be
able to cover all cases.

Do you have specific examples which has verification failure due to
false array out of bound access?

>> +
>> +/*
>> + * Convenience wrapper for bpf_array_elem(), where we compute the size of the
>> + * array.  Be sure to use an actual array, and not a pointer, just like with the
>> + * ARRAY_SIZE macro.
>> + */
>> +#define bpf_array_sz_elem(arr, idx) \
>> +	bpf_array_elem(arr, sizeof(arr) / sizeof((arr)[0]), idx)
>> +
>>   #endif
>> -- 
>> 2.43.0.472.g3155946c3a-goog
>>
>>

