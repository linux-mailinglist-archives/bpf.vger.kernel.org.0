Return-Path: <bpf+bounces-41524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 938B8997A4D
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 03:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CFA1F23F5F
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 01:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84E02BD0E;
	Thu, 10 Oct 2024 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="On4m5qdO"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743C5BE6F
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728525389; cv=none; b=ttRDDf8dXDMaz1m4KSi88mXjdEO2QcSt3sDBdgWHsFYoW44hTVmm3cr0F+220vAHlHF68cJki74Wb2VVlu98SGvuMZIAr1k6N3OxleFB+JGuiL3rae141GccsStdGX4Ff30wWAHmsbHj7+KJjaN65AAM/C+6bsyJvpsSr7ySZzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728525389; c=relaxed/simple;
	bh=uiXQpM+63IEjIZRe2f0UJhYK7+O4bX2U4FAVbK/8EdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oAX39FZRinnus+ZWj6FveWUQYalvZ/sOhCONPAd63GNdP3qXszSZcVMFkQXJlfLnEeVL2uu52GDzM+WPnWyA3n7ejSUAD8CfGWQgLm9AXLNL988KB7UqpXlX+kaM6jnM3BF08kagPZ7wceRFKPxlxBKLwnA2RwYj+anQYQX3EYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=On4m5qdO; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <af80095c-0869-481d-9f26-86d584206931@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728525384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsK74XMa4vUrEA2GFJ940qycFc1A3mIzd+WDSmeyeEQ=;
	b=On4m5qdONbGtF+bOa3MW7qH2nfs0CaWW1iCe1EpE//xIwo284pbOPGQ4DWN96nR9eKxEpx
	uCmps4n8WIdogKKtBDWUq9qCR4cfkZQIB7qjK5KSIhx9bkk0HSmwBuicJPcLOodETit1Vb
	z+0C9AZsZxseDsN0a6h3eOrbVu4rLCs=
Date: Thu, 10 Oct 2024 09:56:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 3/3] selftests/bpf: Add cases to test tailcall
 in freplace
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?=
 =?UTF-8?Q?sen?= <toke@redhat.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com,
 kbuild test robot <lkp@intel.com>
References: <20241008161333.33469-1-leon.hwang@linux.dev>
 <20241008161333.33469-4-leon.hwang@linux.dev>
 <e8ca8f6d618a446a3e7ab28f4f36ab7e1e814432.camel@gmail.com>
 <0b803ca1-bf7d-4ecd-8585-aac3b97b6167@linux.dev>
 <CAADnVQK2SP0JeL+kRMEvLQGjq4GgBAUtUyVjjzDJ0dRSqWeDFA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQK2SP0JeL+kRMEvLQGjq4GgBAUtUyVjjzDJ0dRSqWeDFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/10/24 08:59, Alexei Starovoitov wrote:
> On Tue, Oct 8, 2024 at 11:05 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 9/10/24 13:04, Eduard Zingerman wrote:
>>> On Wed, 2024-10-09 at 00:13 +0800, Leon Hwang wrote:
>>>> cd tools/testing/selftests/bpf; ./test_progs -t tailcalls
>>>> 335/27  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_1:OK
>>>> 335/28  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_2:OK
>>>> 335     tailcalls:OK
>>>> Summary: 1/28 PASSED, 0 SKIPPED, 0 FAILED
>>>>
>>>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>>>> ---
>>>
>>> Tbh, I don't think these tests are necessary.
>>> Patch #2 already covers changes in patch #1.
>>>
>>> [...]
>>>
>>
>> You are right.
>>
>> I should provide the commit message to tell the reason why to add these
>> two test cases:
>>
>> In order to confirm tailcall in freplace is OK and won't be broken by
>> patch of preventing tailcall infinite loop caused by freplace or other
>> patches in the future, add two test cases to confirm that freplace is OK
>> to tail call itself or other freplace prog, even if the target prog of
>> freplace is a subprog and the subprog is called many times in its caller.
> 
> Not following.
> What's the point of adding more tests when patch 2 covers the cases already?

It's to test cases about tailcall in freplace.

But it seems unnecessary to add them. I'll drop this patch.

Thanks,
Leon


