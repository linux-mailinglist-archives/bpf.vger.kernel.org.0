Return-Path: <bpf+bounces-30953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C17A58D5185
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 19:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AE0DB22522
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 17:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B71747A40;
	Thu, 30 May 2024 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e6prGzJa"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A7219FD
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717091608; cv=none; b=hq5zC95iJ0sSeFp6H3vT2rY4tE4RkCoIg7BJyjd2GdOhsAP7EYflL+hsA3wH3IDQ1vUwc1BJ2PoTh5v7mWftn159nZQ17JTyQCk1QesrrECCpV97fgRLOruSF8zgVZjyTeSdtpxQ888Z/VXnim5T/QI6LBQkBkVUvFDnEJ3OK+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717091608; c=relaxed/simple;
	bh=9xO8qwDHsnXsyZiM7uC0Z3qRbVj/TsXP/wAY+IFQJT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Y12mm5AxAMlo8KvZAa57ZkKkq2Z0GfKC/pRAHaLNMAdukgiEomT/QiKvhERnuLiC9aPIehX4N3LpQBVru0fnys1ihC6LkCcdKVYUkP6AnloHBRXQ6id6EiVWlF+1acp/TBewi9iiyKwgI+CM8nsFpRDaPcJv1WE+HnSyN6p/BNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e6prGzJa; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: sinquersw@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717091604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8dc84CPtUbQBaF/JoypnFxNdD+HfkLN4zkbQouQu22c=;
	b=e6prGzJaSXFg7hTY9AAyFhxOHsjBxorFxxhmx1qgIty0j6BuWGMfu1Bs+oFwtcR+Q1S4R6
	2WHJOjIL17C2VBIIz6kRob6jJF9rVP+6Q8dumZ1wj0JeR7ylxU1Ylf+9YzPRFgqrZi0W/O
	AlLgcUC15hDUc9XbJdrZIuTqLwSew/o=
X-Envelope-To: thinker.li@gmail.com
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: song@kernel.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: andrii@kernel.org
X-Envelope-To: kuifeng@meta.com
Message-ID: <8818eaa4-b32c-41a6-82c9-6230d635e89f@linux.dev>
Date: Thu, 30 May 2024 10:53:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 6/8] selftests/bpf: detach a struct_ops link
 from the subsystem managing it.
To: Kuifeng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>
References: <20240524223036.318800-1-thinker.li@gmail.com>
 <20240524223036.318800-7-thinker.li@gmail.com>
 <f0b0e283-9312-4f11-9636-2ea690262180@linux.dev>
 <CAHE2DV0RBf9JbkmngsdKdER5F2KmUXwY_JH44Z09DsY0VNa37A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, Kui-Feng Lee <kuifeng@meta.com>
In-Reply-To: <CAHE2DV0RBf9JbkmngsdKdER5F2KmUXwY_JH44Z09DsY0VNa37A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

[ The mailing list got dropped in your reply, so CC back the list ]

On 5/29/24 11:05 PM, Kuifeng Lee wrote:
> On Wed, May 29, 2024 at 2:51 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 5/24/24 3:30 PM, Kui-Feng Lee wrote:
>>> @@ -832,11 +865,20 @@ static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
>>>        if (ops->test_2)
>>>                ops->test_2(4, ops->data);
>>>
>>> +     spin_lock(&detach_lock);
>>> +     if (!link_to_detach)
>>> +             link_to_detach = link;
>>
>> bpf_testmod_ops is used in a few different tests now. Can you check if
>> "./test_progs -j <num_of_parallel_workers>" will work considering link_to_detach
>> here is the very first registered link.
> 
> Yes, it works.  Since the test in test_struct_ops_modules.c is serial,
> no other test will
> be run simultaneously. And its subtests are run one after another.

just did a quick search on "bpf_map__attach_struct_ops", how about the other 
tests like struct_ops_autocreate.c and test_struct_ops_multi_pages.c ?


> 
>>
>>> +     spin_unlock(&detach_lock);
>>> +
>>>        return 0;
>>>    }
>>


