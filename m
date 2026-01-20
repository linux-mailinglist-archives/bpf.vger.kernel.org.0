Return-Path: <bpf+bounces-79668-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM2NDbHHb2mgMQAAu9opvQ
	(envelope-from <bpf+bounces-79668-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:21:37 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73768495BC
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF1C75EE514
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 18:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056DE3A89D0;
	Tue, 20 Jan 2026 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jguZVexX"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C1E243968
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932729; cv=none; b=AdN7nYRyQFhuEJOXSa3Qx8fUzDl+4sTIcH99Twk2M2GqoqTLpsDGPzX3h0ddxmc5OlD5tCP7/klpgCZgy44QjBxQuq80WmE59j88QuELUBd5nYsoAsKdwgy0kX7Wo3oHb6VoK+i2DcSmn3XmwP8r9E8D7j2WjsOYMa1Zxmg8iIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932729; c=relaxed/simple;
	bh=wMvjb7uGlD8skGR/Hg8ZzNi+b+oc2JILZC4N94oUwGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYfQs/4sd6Rctaz4Jel0Sm6A4F6/3lKIus5eoui3oDbLoF+3u3h4AvrtISGnDvfJsBCqUm31m8SzmDXlYcQg95YC+aUcGp2ry8RQJcQt9K99F3HOjPi7e2KGOuXRIICPZ1PVI9xJo3S72FM8BEEz6oIuDEyDq2EIi1lsZS5isLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jguZVexX; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fe471a8c-4238-432b-9507-e2039f7fa9d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768932715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jt1rta3i0jdO0SFphx1vHDbYfk1cAz9j92vCGA38i4k=;
	b=jguZVexXeMCBrDXR5IBKzV6OhhcW8hK5rJ7Uj7mDT1waVg3wYOecHvufbaaFNQb4TS7LIg
	Fe1r0lU40pDzg1MUXLr+Uh43PbXaZgyLzsJPc37eE15IyVq5w+VxDbd9qbkgVG5PuUTgan
	NwrL4UDegWTnc/TN9wk13Za6ny5A8F4=
Date: Tue, 20 Jan 2026 10:11:47 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 04/13] resolve_btfids: Introduce
 finalize_btf() step
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 sched-ext@lists.linux.dev
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
 <20260116201700.864797-5-ihor.solodrai@linux.dev>
 <c404446ab6d344338592dfa44f5a7e1b95492564.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <c404446ab6d344338592dfa44f5a7e1b95492564.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79668-lists,bpf=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev];
	FREEMAIL_CC(0.00)[meta.com,kernel.org,oracle.com,gmail.com,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ihor.solodrai@linux.dev,bpf@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[bpf];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 73768495BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/19/26 4:13 PM, Eduard Zingerman wrote:
> On Fri, 2026-01-16 at 12:16 -0800, Ihor Solodrai wrote:
>> Since recently [1][2] resolve_btfids executes final adjustments to the
>> kernel/module BTF before it's embedded into the target binary.
>>
>> To keep the implementation simple, a clear and stable "pipeline" of
>> how BTF data flows through resolve_btfids would be helpful. Some BTF
>> modifications may change the ids of the types, so it is important to
>> maintain correct order of operations with respect to .BTF_ids
>> resolution too.
>>
>> This patch refactors the BTF handling to establish the following
>> sequence:
>>   - load target ELF sections
>>   - load .BTF_ids symbols
>>     - this will be a dependency of btf2btf transformations in
>>       subsequent patches
>>   - load BTF and its base as is
>>   - (*) btf2btf transformations will happen here
>>   - finalize_btf(), introduced in this patch
>>     - does distill base and sort BTF
>>   - resolve and patch .BTF_ids
>>
>> This approach helps to avoid fixups in .BTF_ids data in case the ids
>> change at any point of BTF processing, because symbol resolution
>> happens on the finalized, ready to dump, BTF data.
>>
>> This also gives flexibility in BTF transformations, because they will
>> happen on BTF that is not distilled and/or sorted yet, allowing to
>> freely add, remove and modify BTF types.
>>
>> [1] https://lore.kernel.org/bpf/20251219181321.1283664-1-ihor.solodrai@linux.dev/
>> [2] https://lore.kernel.org/bpf/20260109130003.3313716-1-dolinux.peng@gmail.com/
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
>> @@ -1099,12 +1116,22 @@ int main(int argc, const char **argv)
>>  	if (obj.efile.idlist_shndx == -1 ||
>>  	    obj.efile.symbols_shndx == -1) {
>>  		pr_debug("Cannot find .BTF_ids or symbols sections, skip symbols resolution\n");
>> -		goto dump_btf;
>> +		resolve_btfids = false;
>>  	}
>>  
>> -	if (symbols_collect(&obj))
>> +	if (resolve_btfids)
>> +		if (symbols_collect(&obj))
>> +			goto out;
> 
> Nit: check obj.efile.idlist_shndx and obj.efile.symbols_shndx inside symbols_collect()?
>      To avoid resolve_btfids flag and the `goto dump_btf;` below.

Hi Eduard, thank you for review.

The issue is that in case of .BTF_ids section absent we have to skip
some of the steps, specifically:
  - symbols_collect()
  - sequence between symbols_resolve() and dump_raw_btf_ids()

It's not an exit condition, we still have to do load/dump of the BTF.

I tried in symbols_collect():

	if (obj.efile.idlist_shndx == -1 || obj.efile.symbols_shndx == -1)
		return 0;

But then, we either have to do the same check in symbols_resolve() and
co, or maybe store a flag in the struct object.  So I decided it's
better to have an explicit flag in the main control flow, instead of
hiding it.

lmk if you had something else in mind


> 
>> +
>> +	if (load_btf(&obj))
>>  		goto out;
>>  
>> +	if (finalize_btf(&obj))
>> +		goto out;
>> +
>> +	if (!resolve_btfids)
>> +		goto dump_btf;
>> +
>>  	if (symbols_resolve(&obj))
>>  		goto out;
>>  


