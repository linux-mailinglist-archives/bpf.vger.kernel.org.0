Return-Path: <bpf+bounces-46343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 046769E7D8D
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 01:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D341629C2
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 00:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39BD2F5B;
	Sat,  7 Dec 2024 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e8cw2yRH"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5F17FE
	for <bpf@vger.kernel.org>; Sat,  7 Dec 2024 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733531779; cv=none; b=O2mOetBD9AliQdwyd7rXWv+H0z4KXFfzmlUVEKDemrqIGJm5G992pEeFXbT2x0tLXrQQ6YePMRid6+dXGr9UeQjrKFo1hpCAuUi3SKiUeeczxtDUlzGdX+L/FPbEWw80qyT7D+pIKqize4L0aAtIvnEmWnBNl+Gc2ooG391eyKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733531779; c=relaxed/simple;
	bh=1wFOuu4n/44971v6f+bJoUslCNAuao7KJtqC+jsRLCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0M8NMfzArXEv/3WU4y2YdCbpzof7zAe+FcV52i78pXXUJkjIXulRCF1yRTeNzP9JV3OH8Oy8Sh5y6fDfz8gdHThtn3Xk+vQidw11GbFl0Lx6Htp01p3rKgq9jBi+0Sjr6jGFyewSNLNzjuzGdco+qjkEev18tBnxd80SM3Ld6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e8cw2yRH; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <176ad1b2-034b-4b10-93cd-f03391820e24@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733531773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N0PVqLqyjylH0R4FsHb+teVerjXoRao7AEBRwARpTjA=;
	b=e8cw2yRHnq7J29j7oUI0WtD4VvWaRMRvsy+dK0KJFdG260gjs8W1ojB/3E9xsbTVIfzmtm
	dNFv2pdu5/1uKpBrZ0bBpjbeWdFV8e50+49XkHrkzCPCAABgk331woDhJ2fB2gGGfImgD9
	cl8AfBdyoUC64EkTY049TO7H6iHCN6Y=
Date: Fri, 6 Dec 2024 16:36:03 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [External] Storing sk_buffs as kptrs in map
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Amery Hung <amery.hung@bytedance.com>, bpf@vger.kernel.org,
 magnus.karlsson@intel.com, sreedevi.joshi@intel.com, ast@kernel.org
References: <Z0X/9PhIhvQwsgfW@boxer>
 <CAONe225n=HosL1vBOOkzaOnG9jTYpQwDH6hwyQRAu0Cb=NBymA@mail.gmail.com>
 <d854688a-9d2d-4fed-9cb8-3e5c4498f165@linux.dev> <Z0dt/wZZhigcgGPI@boxer>
 <d1e95498-4613-43e0-bc6b-6f6157802649@linux.dev> <Z09uQ48lKEsORsS1@boxer>
 <ecd47c2c-7b34-4649-ad97-3988c7644317@linux.dev> <Z1MlVa3OXQJw0VXm@boxer>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <Z1MlVa3OXQJw0VXm@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/6/24 8:24 AM, Maciej Fijalkowski wrote:
>> I think we can remove the projection_of call from the
>> bpf_is_prog_ctx_type() such that it honors the exact argument
>> type written in the kernel source code. Add this particular projection_of
>> check (renamed to bpf_is_kern_ctx in the diff) to the other callers for
>> backward compat such that the caller can selectively translate
>> the argument of a subprog to the corresponding prog ctx type.
>>
>> Lightly tested only:
> I tried the kernel diff on my side and it addressed my needs. Will you
> send a patch?

There is no real kfunc taking the "struct sk_buff *" now. It is better to make 
this change together with your skb acquire/release kfunc introduction. You can 
include this patch in your future set.

> 
>> diff --git i/kernel/bpf/btf.c w/kernel/bpf/btf.c
>> index e7a59e6462a9..2d39f91617fb 100644
>> --- i/kernel/bpf/btf.c
>> +++ w/kernel/bpf/btf.c
>> @@ -5914,6 +5914,26 @@ bool btf_is_projection_of(const char *pname, const char *tname)
>>   	return false;
>>   }
>> +static bool btf_is_kern_ctx(const struct btf *btf,
>> +			    const struct btf_type *t,
>> +			    enum bpf_prog_type prog_type)
>> +{
>> +	const struct btf_type *ctx_type;
>> +	const char *tname, *ctx_tname;
>> +
>> +	t = btf_type_skip_modifiers(btf, t->type, NULL);
>> +	if (!btf_type_is_struct(t))
>> +		return false;
>> +
>> +	tname = btf_name_by_offset(btf, t->name_off);
>> +	if (!tname)
>> +		return false;
>> +
>> +	ctx_type = find_canonical_prog_ctx_type(prog_type);
>> +	ctx_tname = btf_name_by_offset(btf_vmlinux, ctx_type->name_off);
>> +	return btf_is_projection_of(ctx_tname, tname);
> We're sort of doubling the work that btf_is_prog_ctx_type() is doing also,
> maybe add a flag to btf_is_prog_ctx_type() that will allow us to skip
> btf_is_projection_of() call when needed? e.g. in get_kfunc_ptr_arg_type().

It is pretty cheap to do the btf_is_kern_ctx().

I don't have a strong opinion on either way. may be a "bool check_kern_ctx".

