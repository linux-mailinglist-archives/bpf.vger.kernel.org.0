Return-Path: <bpf+bounces-68883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72783B87AE9
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA914E7924
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7BC2512DE;
	Fri, 19 Sep 2025 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F4/cBJfq"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6376123E334
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 02:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247351; cv=none; b=YzUt/GqveWTi77kTzipipAF8+Al7D3nwWYOWCoJ0jVX3lRVAU/r9hVh7Ve0QIqfqmqPxMER8TPHeGISS9c5dVkn2UFkCJ2Vc8DblYmVJypHXR2A2Rn0IkFHx9xmvZwgp/LjmrQgctlq309NmdAW048C6ZHxNUUvry+RXiUgaQLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247351; c=relaxed/simple;
	bh=czB3OBNupJGBVl1J7sAT0nni9wuTaORmtCjhauycnjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdSUbGpQWK4Qgl/mcj6bcoJVb504zOSo6MIxYtQ0ZaIGodJKpBYuaO9Ffk9Q7hDyWx9/Aa3OFwi4BC1sGyM3GoC5zGWaB4RNwLLAIdhPixOXU4KVkp3NIKkvI+oxvYEYqyUeR3vnanwW1Q0a8enjMnmwGZsVieGv2NukU4eLIJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F4/cBJfq; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a5d2fb43-9b2d-4172-b8f0-071c810e63e4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758247344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zVSrAK1Yv2vPbcKG+6F8mNIDu+rHp+xvNKs5QnQh5B0=;
	b=F4/cBJfq9z7yqz5VtL9Q4HmgHT1wprCQTJVT5qNQmk5A89OfBLqHhQXbWw+tmCgOQ74oQZ
	sz5RRiBoqqdIEZ+ykbXH/s9JNWRnrc8IXCyL4kr8UYvmNLiMVXZb+x+yG3vPgFapl1iZ4R
	CQABlzj/kAsXI2WeHfiz1Q48duj+Ga8=
Date: Fri, 19 Sep 2025 10:01:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Add union argument tests
 using fexit programs
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tao Chen <chen.dylane@linux.dev>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Mykyta Yatsenko <yatsenko@meta.com>, Puranjay Mohan <puranjay@kernel.org>,
 davidzalman.101@gmail.com, cheick.traore@foss.st.com,
 mika.westerberg@linux.intel.com, Amery Hung <ameryhung@gmail.com>,
 Menglong Dong <menglong8.dong@gmail.com>, kernel-patches-bot@fb.com
References: <20250916155211.61083-1-leon.hwang@linux.dev>
 <20250916155211.61083-4-leon.hwang@linux.dev>
 <dbea9a14-e010-4e2f-a34d-4e2fd14a31f6@linux.dev>
 <bd40f8ce-37ed-48b0-b2ad-69eff76a4c20@linux.dev>
 <CAADnVQJNA7YvfDx1Go+ga+6HmwdLKnwuLz3duVZ=s7eNpNr8VQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQJNA7YvfDx1Go+ga+6HmwdLKnwuLz3duVZ=s7eNpNr8VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 19/9/25 09:53, Alexei Starovoitov wrote:
> On Thu, Sep 18, 2025 at 6:47 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 19/9/25 00:09, Tao Chen wrote:
>>> 在 2025/9/16 23:52, Leon Hwang 写道:
>>>> By referencing
>>>> commit 1642a3945e223 ("selftests/bpf: Add struct argument tests with
>>>> fentry/fexit programs."),
>>>> test the following cases for union argument support:
>>>>
>>>
>>> Can we use ‘commit 1642a3945e22’ with 12 chars, maybe it's minor nit
>>> anyways or not.
>>>
>> Thank you for pointing this out.
>>
>> I’ll update my script to generate the commit information in the proper
>> format.
> 
> Since you're going to respin please rewrite the whole commit log
> in both patches.
> There is no need to talk about patch 1642a3945e223 at all.
> It doesn't matter what you used to get inspiration from.
> Also don't say things like:
> 
> cd tools/testing/selftests/bpf
> ./test_progs -t tracing_struct/union_args
> 472/3   tracing_struct/union_args:OK
> 472     tracing_struct:OK
> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> 
> of course they suppose to pass. Above is not useful in the commit log.
> 
> Instead describe what the test is for and what it's doing.
> > Similar in patch 1 trim bpftrace output.
> Only mention the relevant parts. The command line and the error.
> Things like:
> 
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> 
> are not useful.

Got it.

I’ll respin with updated commit logs:

* Patch #1: trim bpftrace output to only include the relevant command
  line and error.
* Patch #2: drop references to commit 1642a3945e223 and test output, and
  instead describe what the test is for and what it does.

Thanks,
Leon


