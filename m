Return-Path: <bpf+bounces-64588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB994B146E0
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 05:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300A63A8D20
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 03:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662C1221F08;
	Tue, 29 Jul 2025 03:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iQoJ3jnn"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E99221704
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 03:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753759734; cv=none; b=YUxekEo1fIFVxfGLXfSfK5OeWAqkZqO+taBiry4v6UdbTsJ02F9CQV19gsqQKm2W9y15AV9qRS4B8LzteKHlJTBYSLvOnFgR4dsfX/zyitB4HtDHdnEBk0Pz3XD+kjU+1D3FKpPe0KwwF53i317csjR7rOV3WsAikKMpegu4NNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753759734; c=relaxed/simple;
	bh=ogg7CnBMeunRJeRrwS55VcPVfe8s/3DjZOP4wmYAZ3c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=smjRp3jGrnkHCTP/ikTlVuv0ivUHOhGWm/jg+YdkCwt8mHpgVWHrqheT0KsHBay67W7Ay/pGVkGVmeSVIYjXfF/wmQf4Z7yDX4ejhl2J9TTX2SBLxZxdH7SHtvjdQFBMEotJ1xZDD0ZcktnjnH1jcMjNyE+LdaN7v0/J9dQEYkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iQoJ3jnn; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4f6507f9-b405-4e4a-91cf-100e10e5078f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753759729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXEvrjYfLkowtLMnYkTjsJg39YqEjvVVm1dcI8MtMvc=;
	b=iQoJ3jnn6odCubUjFoOpiqXgTRB2fh4HNBQesjZzLOg6FBL1yJUQFRQK3eN8DliCUli6u1
	il1WodB28S6JOkcXoph5dt0IpKAMpY2YXbmd3l784hVyatJX8riAewM4ij7Te7yzKWhcta
	qJseFnZzQUxOh7hwadCR8cJzxuVBymI=
Date: Mon, 28 Jul 2025 20:28:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v2] btf_encoder: group all function ELF syms by
 function name
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: alan.maguire@oracle.com, olsajiri@gmail.com, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, acme@kernel.org, andrii@kernel.org, ast@kernel.org,
 eddyz87@gmail.com, menglong8.dong@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kernel-team@meta.com
References: <20250729020308.103139-1-isolodrai@meta.com>
 <f7553b3f-5827-4f50-81a9-9bd0802734b9@linux.dev>
Content-Language: en-US
In-Reply-To: <f7553b3f-5827-4f50-81a9-9bd0802734b9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/28/25 8:19 PM, Ihor Solodrai wrote:
> On 7/28/25 7:03 PM, Ihor Solodrai wrote:
>> btf_encoder collects function ELF symbols into a table, which is later
>> used for processing DWARF data and determining whether a function can
>> be added to BTF.
>>
>> So far the ELF symbol name was used as a key for search in this table,
>> and a search by prefix match was attempted in cases when ELF symbol
>> name has a compiler-generated suffix.
>>
>> This implementation has bugs [1][2], causing some functions to be
>> inappropriately excluded from (or included into) BTF.
>>
>> Rework the implementation of the ELF functions table. Use a name of a
>> function without any suffix - symbol name before the first occurrence
>> of '.' - as a key. This way btf_encoder__find_function() always
>> returns a valid elf_function object (or NULL).
>>
>> Collect an array of symbol name + address pairs from GElf_Sym for each
>> elf_function when building the elf_functions table.
>>
>> Introduce ambiguous_addr flag to the btf_encoder_func_state. It is set
>> when the function is saved by examining the array of ELF symbols in
>> elf_function__has_ambiguous_address(). It tests whether there is only
>> one unique address for this function name, taking into account that
>> some addresses associated with it are not relevant:
>>    * ".cold" suffix indicates a piece of hot/cold split
>>    * ".part" suffix indicates a piece of partial inline
>>
>> When inspecting symbol name we have to search for any occurrence of
>> the target suffix, as opposed to testing the entire suffix, or the end
>> of a string. This is because suffixes may be combined by the compiler,
>> for example producing ".isra0.cold", and the conclusion will be
>> incorrect.
>>
>> In saved_functions_combine() check ambiguous_addr when deciding
>> whether a function should be included in BTF.
>>
>> Successful CI run: https://github.com/acmel/dwarves/pull/68/checks
>>
>> I manually spot checked some of the ~200 functions from vmlinux (BPF
>> CI-like kconfig) that are now excluded: all of those that I checked
>> had multiple addresses, and some where static functions from different
>> files with the same name.
>>
>> [1] https://lore.kernel.org/bpf/2f8c792e-9675-4385- 
>> b1cb-10266c72bd45@linux.dev/
>> [2] https://lore.kernel.org/ 
>> dwarves/6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev/
>>
>> v1: https://lore.kernel.org/ 
>> dwarves/98f41eaf6dd364745013650d58c5f254a592221c@linux.dev/
>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>> [...]
> 
> Not sure what's wrong, but it appears this message can't reach
> vger.kernel.org, or maybe is spam filtered.
> 
> I sent to vger.kernel.org from @meta.com email in the past w/o issues.
> 
> Any suggestions?..
> 

Never mind, I think it's some security rules on Meta side.

Alan, please let me know if you received the patch, or if I should
resend again. Thanks.

