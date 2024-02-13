Return-Path: <bpf+bounces-21887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD9A853C3C
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 21:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177C71F2744C
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 20:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAC660B99;
	Tue, 13 Feb 2024 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xbAk65d0"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0135E60BA5
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856108; cv=none; b=IfDn+KVg9NZN0ChjyMujQKRKbDTBXpTXB8Z1edDpmdvwwKhnU4O6vv/aBZaCA79CZtwwyowGb5csdNeM2COE3e+6KtuyWSW/bA/W8M46Hsqqtu21ULYYUIzGHmCtMKLLU7hSMEssoAnRDtXkzVytEQTIwR2moALmFUDVyvscu4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856108; c=relaxed/simple;
	bh=vdUdjuGs8mGBYwaz9jB/qqJM7NwMi4q5Pt1ppbNnGO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQZsj5ZPvkjb2qS5Q0+TbBiPfqMbgVnTuVotTUYda5llUGWovGpqa2puOw98oBa1Z3YklIs2xvSQuvyv/b2+ycOC70OrV4fDBQlraGLfvYJkS2yPGhFvu9PtMGTM/uG0O5i/WE64yRB8+bj72fUWKGW4H/Nk6ZblImzmy6Z5/v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xbAk65d0; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <21aab482-18f3-43a1-b3ca-44b2a1a447ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707856105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2eW6w9PO+ff+HraoJAyuFU8SfzHBGvXXxDwg5Qho7w0=;
	b=xbAk65d0GDBFUUXWoIzei68c2sBGvc+6V11MtMPEkPQnVO45f674vZG8mRhVJYKuv/nRJn
	zorDdZffj42FSkzkzww2XXO87uItOn4g8Cd8Ak7JVscFU4OIzRP3zKjIA0MXm5keeZAkf9
	1jKA2FgUcLORgyAu2Xs5bzclnr+ho34=
Date: Tue, 13 Feb 2024 12:28:18 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add a negative test for
 stack accounting in jit mode
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240208215422.110920-1-yonghong.song@linux.dev>
 <20240208215427.111319-1-yonghong.song@linux.dev>
 <CAEf4BzamGPs45fFTDW4P_Ymm3bZ+Z0yP4JBPZHgefYbc5DgapA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzamGPs45fFTDW4P_Ymm3bZ+Z0yP4JBPZHgefYbc5DgapA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/13/24 11:40 AM, Andrii Nakryiko wrote:
> On Thu, Feb 8, 2024 at 1:54 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> The new test is very similar to test_global_func1.c, but
>> is modified to fail on jit mode.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   .../bpf/prog_tests/test_global_funcs.c        |  3 ++
>>   .../selftests/bpf/progs/test_global_func18.c  | 44 +++++++++++++++++++
>>   2 files changed, 47 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/progs/test_global_func18.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
>> index a3a41680b38e..dccbf2213135 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
>> @@ -18,6 +18,7 @@
>>   #include "test_global_func15.skel.h"
>>   #include "test_global_func16.skel.h"
>>   #include "test_global_func17.skel.h"
>> +#include "test_global_func18.skel.h"
>>   #include "test_global_func_ctx_args.skel.h"
>>
>>   #include "bpf/libbpf_internal.h"
>> @@ -140,6 +141,8 @@ void test_test_global_funcs(void)
>>   {
>>          if (!env.jit_enabled) {
>>                  RUN_TESTS(test_global_func1);
>> +       } else {
>> +               RUN_TESTS(test_global_func18);
>>          }
>>
>>          RUN_TESTS(test_global_func2);
>> diff --git a/tools/testing/selftests/bpf/progs/test_global_func18.c b/tools/testing/selftests/bpf/progs/test_global_func18.c
>> new file mode 100644
>> index 000000000000..d1aa3b2c68fe
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_global_func18.c
>> @@ -0,0 +1,44 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
>> +#include <stddef.h>
>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +
>> +#define MAX_STACK1 (512 - 3 * 32 + 8)
>> +#define MAX_STACK2 (3 * 32)
>> +
>> +__attribute__ ((noinline))
> nit: we have __noinline defined, let's use it as a less verbose option?

A copy-paste issue. In v4, I will drop this patch
since I will increase the stack size to accommodate
both jit and !jit cases.

>
>> +int f1(struct __sk_buff *skb)
>> +{
>> +       return skb->len;
>> +}
>> +
>> +int f3(int, struct __sk_buff *skb, int);
>> +
>> +__attribute__ ((noinline))
>> +int f2(int val, struct __sk_buff *skb)
>> +{
>> +       volatile char buf[MAX_STACK1] = {};
>> +
>> +       __sink(buf[MAX_STACK1 - 1]);
>> +
>> +       return f1(skb) + f3(val, skb, 1);
>> +}
>> +
>> +__attribute__ ((noinline))
>> +int f3(int val, struct __sk_buff *skb, int var)
>> +{
>> +       volatile char buf[MAX_STACK2] = {};
>> +
>> +       __sink(buf[MAX_STACK2 - 1]);
>> +
>> +       return skb->ifindex * val * var;
>> +}
>> +
>> +SEC("tc")
>> +__failure __msg("combined stack size of 3 calls is 528")
>> +int global_func18(struct __sk_buff *skb)
>> +{
>> +       return f1(skb) + f2(2, skb) + f3(3, skb, 4);
>> +}
>> --
>> 2.39.3
>>
>>

