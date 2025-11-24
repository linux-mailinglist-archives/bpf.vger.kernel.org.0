Return-Path: <bpf+bounces-75391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E93C82508
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 20:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9DB44E6C8F
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 19:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227D72E0B5C;
	Mon, 24 Nov 2025 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xPsaqV6c"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C33231836
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764012954; cv=none; b=ABNIx55CfJF4EyMuIpoKqRhwPGrzb4YW3XiuD0QgDxmtCjkI2ieVmWMpuWZcDh5lI/2FEherxKxjQBstphawgJbasudvTXsTi66j1T1SbAOEenRgMKqety+n5n1jYL789HP5XrCsgi972pTDk7GuOEuMM2/VKWt3zSmjbN2/WR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764012954; c=relaxed/simple;
	bh=VKBdGCvPTQ44oOfNmYIO+uReHmABUFF88HjXAgENRJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BN0p2cv7G8dBJMtIaKjo1Cugb+8aJdw51CsZ7a2ttLCGP0hg6v4MuXm/s1NIsPDg5PsDHeFSGeSlD3mnnjfauE1aAOX8BO3bvZ4lm+r11xABrJjSyuaFP0fEoQx8bWxUkqIznZvtK+yMxbErfug6pTZcW4dv5Wf6IAA8448Q8aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xPsaqV6c; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3a9bff10-7f55-45b1-a57c-08786a27f5ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764012949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5vT+mCPJZdwjwmx64x1wrnSRfkOWwDErOw7QJ6WO8w=;
	b=xPsaqV6caxk6dcHj8mqO0YMSwhjfaySQzydisOzY6zXcSNuju07x3iqqp6+h1t2VyyoO//
	T0oA3TVkUJxWYWRamiwtxcEnDhOWAJ9EYY7ZYrR/FbALWXXXnBPYjxPYwMJiXmWkMcx5u4
	xhuezi6L7Y57X7lCtkuiMoI+Id29x1Y=
Date: Mon, 24 Nov 2025 11:35:36 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v7 3/7] tools/resolve_btfids: Add --btf_sort option
 for BTF name sorting
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, eddyz87@gmail.com,
 zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire
 <alan.maguire@oracle.com>, Song Liu <song@kernel.org>
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
 <20251119031531.1817099-4-dolinux.peng@gmail.com>
 <854f468a-d178-40f4-aa03-e19ff82a1a35@linux.dev>
 <CAErzpmvJ+D2c_3pLG-t5ZD2cj7kDJX=JDnJ0CxNUf5pYR24a+g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAErzpmvJ+D2c_3pLG-t5ZD2cj7kDJX=JDnJ0CxNUf5pYR24a+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/21/25 7:36 AM, Donglin Peng wrote:
> On Fri, Nov 21, 2025 at 5:34 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 11/18/25 7:15 PM, Donglin Peng wrote:
>>> From: Donglin Peng <pengdonglin@xiaomi.com>
>>>
>>> This patch introduces a new --btf_sort option that leverages libbpf's
>>> btf__permute interface to reorganize BTF layout. The implementation
>>> sorts BTF types by name in ascending order, placing anonymous types at
>>> the end to enable efficient binary search lookup.
>>
>> [...]
>>
>> Hi Dongling.
>>
>> Thanks for working on this, it's a great optimization. Just want to
>> give you a heads up that I am preparing a patchset changing
>> resolve_btfids behavior.
> 
> Thanks. I'm curious about the new behavior of resolve_btfids. Does it
> replace pahole and generate the sorted .BTF data directly from the
> DWARF data? Also, does its sorting method differ from the cmp_type_names
> approach mentioned above — specifically, does it place named types
> before all anonymous types? I'm asking because the search method
> needs to be compatible with this sorting approach.

No, replacing pahole entirely isn't really feasible, and unnecessary.

TL;DR is that resolve_btfids will also do kernel-specific btf2btf
transformations. The sorting feature is independent, it's relevant
only in that it is also a btf2btf transformation and will be included
in the pipeline.

I described the approach here:
https://lore.kernel.org/dwarves/ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linux.dev/


> 
>>
>> In particular, instead of updating the .BTF_ids section (and now with
>> your and upcoming changes the .BTF section) *in-place*, resolve_btfids
>> will only emit the data for the sections. And then it'll be integrated
>> into vmlinux with objcopy and linker. We already do a similar thing
>> with .BTF for vmlinux [1].
>>
>> For your patchset it means that the parts handling ELF update will be
>> unnecessary.
>>
>> Also I think the --btf_sort flag is unnecessary. We probably want
>> kernel BTF to always be sorted in this way. And if resolve_btfids will
>> be handling more btf2btf transformation, we should avoid adding a
>> flags for every one of them.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/scripts/link-vmlinux.sh#n110
>>

