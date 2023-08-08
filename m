Return-Path: <bpf+bounces-7275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E1B774F36
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 01:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB12A1C210B3
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 23:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3241BB53;
	Tue,  8 Aug 2023 23:17:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EA9198A9
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 23:17:30 +0000 (UTC)
Received: from out-83.mta0.migadu.com (out-83.mta0.migadu.com [91.218.175.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A981BE2
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 16:17:20 -0700 (PDT)
Message-ID: <31762f4d-7760-5e32-053e-d176d1b8f0a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691536638; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YL1FRLUYu38fRodxiFlkQ8HETcqwLWb+BOzqndjAZQ8=;
	b=L4SL6ulHap7of5zedo+ufQzLyD6RQrF+w4JZhB+t8oV3g5EmYDtU+987Gs8qtAtEF5IW9P
	GCxQQdFZHcuycBaDMCFLzp/PTrJzOlf9raI95ghbX1GIwk+7QyjoelmrB8DUNJ7zEkcgyD
	kCFQ2OnVaN5as7nUNXRbkFpDbtJy+F4=
Date: Tue, 8 Aug 2023 16:17:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] selftests/bpf: relax expected log messages to
 allow emitting BPF_ST
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com
References: <20230808162755.392606-1-eddyz87@gmail.com>
 <cb227598-650b-28c1-1d58-b4d1eefb6492@linux.dev>
 <bf8af3bf700a9781b187e3f0457d264b93931325.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <bf8af3bf700a9781b187e3f0457d264b93931325.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/8/23 4:04 PM, Eduard Zingerman wrote:
> On Tue, 2023-08-08 at 15:51 -0700, Yonghong Song wrote:
>>
>> On 8/8/23 9:27 AM, Eduard Zingerman wrote:
>>> Update [1] to LLVM BPF backend seeks to enable generation of BPF_ST
>>> instruction when CPUv4 is selected. This affects expected log messages
>>> for the following selftests:
>>> - log_fixup/missing_map
>>> - spin_lock/lock_id_mapval_preserve
>>> - spin_lock/lock_id_innermapval_preserve
>>>
>>> Expected messages in these tests hard-code instruction numbers for BPF
>>> programs compiled from C. These instruction numbers change when
>>> BPF_ST is allowed because single BPF_ST instruction replaces a pair of
>>> BPF_MOV/BPF_STX instructions, e.g.:
>>>
>>>       r1 = 42;
>>>       *(u32 *)(r10 - 8) = r1;  --->  *(u32 *)(r10 - 8) = 42;
>>>
>>> This commit updates expected log messages to avoid matching specific
>>> instruction numbers (program position still could be uniquely
>>> identified).
>>>
>>> [1] https://reviews.llvm.org/D140804
>>>       "[BPF] support for BPF_ST instruction in codegen"
>>>
>>> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>>> ---
>>>    .../selftests/bpf/prog_tests/log_fixup.c      |  2 +-
>>>    .../selftests/bpf/prog_tests/spin_lock.c      | 37 ++++++++++++++++---
>>>    2 files changed, 33 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/log_fixup.c b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
>>> index dba71d98a227..effd78b2a657 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/log_fixup.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
>>> @@ -124,7 +124,7 @@ static void missing_map(void)
>>>    	ASSERT_FALSE(bpf_map__autocreate(skel->maps.missing_map), "missing_map_autocreate");
>>>    
>>>    	ASSERT_HAS_SUBSTR(log_buf,
>>> -			  "8: <invalid BPF map reference>\n"
>>> +			  ": <invalid BPF map reference>\n"
>>>    			  "BPF map 'missing_map' is referenced but wasn't created\n",
>>>    			  "log_buf");
>>>    
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
>>> index d9270bd3d920..f29c08d93beb 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
>>> @@ -1,4 +1,5 @@
>>>    // SPDX-License-Identifier: GPL-2.0
>>> +#include <regex.h>
>>>    #include <test_progs.h>
>>>    #include <network_helpers.h>
>>>    
>>> @@ -19,12 +20,16 @@ static struct {
>>>    	  "; R1_w=map_value(off=0,ks=4,vs=4,imm=0)\n2: (85) call bpf_this_cpu_ptr#154\n"
>>>    	  "R1 type=map_value expected=percpu_ptr_" },
>>>    	{ "lock_id_mapval_preserve",
>>> -	  "8: (bf) r1 = r0                       ; R0_w=map_value(id=1,off=0,ks=4,vs=8,imm=0) "
>>> -	  "R1_w=map_value(id=1,off=0,ks=4,vs=8,imm=0)\n9: (85) call bpf_this_cpu_ptr#154\n"
>>> +	  "[0-9]\\+: (bf) r1 = r0                       ;"
>>> +	  " R0_w=map_value(id=1,off=0,ks=4,vs=8,imm=0)"
>>> +	  " R1_w=map_value(id=1,off=0,ks=4,vs=8,imm=0)\n"
>>> +	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
>>>    	  "R1 type=map_value expected=percpu_ptr_" },
>>>    	{ "lock_id_innermapval_preserve",
>>> -	  "13: (bf) r1 = r0                      ; R0=map_value(id=2,off=0,ks=4,vs=8,imm=0) "
>>> -	  "R1_w=map_value(id=2,off=0,ks=4,vs=8,imm=0)\n14: (85) call bpf_this_cpu_ptr#154\n"
>>> +	  "[0-9]\\+: (bf) r1 = r0                      ;"
>>> +	  " R0=map_value(id=2,off=0,ks=4,vs=8,imm=0)"
>>> +	  " R1_w=map_value(id=2,off=0,ks=4,vs=8,imm=0)\n"
>>> +	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
>>>    	  "R1 type=map_value expected=percpu_ptr_" },
>>>    	{ "lock_id_mismatch_kptr_kptr", "bpf_spin_unlock of different lock" },
>>>    	{ "lock_id_mismatch_kptr_global", "bpf_spin_unlock of different lock" },
>>> @@ -45,6 +50,24 @@ static struct {
>>>    	{ "lock_id_mismatch_innermapval_mapval", "bpf_spin_unlock of different lock" },
>>>    };
>>>    
>>> +static int match_regex(const char *pattern, const char *string)
>>> +{
>>> +	int err, rc;
>>> +	regex_t re;
>>> +
>>> +	err = regcomp(&re, pattern, REG_NOSUB);
>>> +	if (err) {
>>> +		char errbuf[512];
>>> +
>>> +		regerror(err, &re, errbuf, sizeof(errbuf));
>>> +		PRINT_FAIL("Can't compile regex: %s\n", errbuf);
>>> +		return -1;
>>> +	}
>>> +	rc = regexec(&re, string, 0, NULL, 0);
>>> +	regfree(&re);
>>> +	return rc == 0 ? 1 : 0;
>>> +}
>>> +
>>>    static void test_spin_lock_fail_prog(const char *prog_name, const char *err_msg)
>>>    {
>>>    	LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_buf = log_buf,
>>> @@ -74,7 +97,11 @@ static void test_spin_lock_fail_prog(const char *prog_name, const char *err_msg)
>>>    		goto end;
>>>    	}
>>>    
>>> -	if (!ASSERT_OK_PTR(strstr(log_buf, err_msg), "expected error message")) {
>>> +	ret = match_regex(err_msg, log_buf);
>>> +	if (!ASSERT_GE(ret, 0, "match_regex"))
>>
>> Should this be ASSERT_GT(ret, 0) or ASSERT_EQ(ret, 1)?
>> If IIUC, regexec return 0 means a successful match.
>> So in 'match_regex', a successful match will return 1, right?
> 
> Right `match_regex` has three possible return values:
> . -1 if regex could not be compiled
> .  0 if regex is ok but match fails
> .  1 if regex is ok and match is found
> 
> I check for -1 in this ASSERT_GE, and for 1 in the ASSERT_TRUE right
> below in order to have two separate error messages.
> 
> But maybe that is not necessary as I already have PRINT_FAIL in the
> match_regex for -1 exit. So it would be possible to figure out what
> failed: regcomp or regexec even if I replace ASSERT_GE/ASSERT_TRUE
> with a single ASSERT_TRUE (or ASSERT_EQ(ret, 1)) as you suggest.

Sorry, I think I missed the below change. It looks original intention
is to print out expected/actual in case of failure. So your patch
looks good to me.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> 
>>
>>> +		goto end;
>>> +
>>> +	if (!ASSERT_TRUE(ret, "no match for expected error message")) {
>>>    		fprintf(stderr, "Expected: %s\n", err_msg);
>>>    		fprintf(stderr, "Verifier: %s\n", log_buf);
>>>    	}
> 

