Return-Path: <bpf+bounces-69659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AC0B9D594
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 05:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9434A7288
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 03:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E892E03E6;
	Thu, 25 Sep 2025 03:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WcZH+J4d"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA22E7631
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 03:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758772777; cv=none; b=gnxEK5u+RraNKLI3yFpsFhawh55GjF+yRWZM3ib9QySyyOrU+ZY66iN3c9G2tvyj/AXxwUPrWzwbM+eNerBdYrXX2MxUjW278NTRofcI9U2MZdLJIyPS2P+QvaegKjxfLjznZGvT0I9GioHoSIEQARqXvhMbC9g9LDedbG4o7CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758772777; c=relaxed/simple;
	bh=ePsaRNAeU6Xr6umqa5d+ci1pHN6nOzsF/9/qmOkJ3pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ozqfx3oxSrDfjUQ7cPSjRjwiqOaImdufYy9zuxFMssl2U2R941CFguOcFGobffD/b9KE4W+v4dQlHw2Yrq2MokCkfYSTE5gWIQFcn/ZTjCmuS8JbZHT7LNuehnK5bIRq1nOVIZsh6ofApq6oTUdMbuHk/ts6X8I+DgdKw5ReN5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WcZH+J4d; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a7f28918-7eda-42e9-ae41-446b7a2d9759@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758772772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPRyhmW5HLnkAnQTp0om7bXwksvc0OFNthNGDCOxHs8=;
	b=WcZH+J4d7cFDX1qJfeczpAARaAzFB/97y3hyZXiY8ETU/+qax9aoQL15HACsKQk1YAd+Cf
	2O1I9sreC6IfLmkts6LsqluHi45n7vT32aNLMPJySRw9p0SJbFcUbZeR5eTI8YtAjqvU5M
	sKAHj3zGEf75lG+/sMWzqW7MgIU4o+Y=
Date: Wed, 24 Sep 2025 20:59:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v1 2/2] btf_encoder: implement
 KF_IMPLICIT_PROG_AUX_ARG kfunc flag handling
To: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org,
 alan.maguire@oracle.com, acme@kernel.org, andrii <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org, tj@kernel.org, kernel-team@meta.com
References: <20250924211512.1287298-1-ihor.solodrai@linux.dev>
 <20250924211512.1287298-3-ihor.solodrai@linux.dev>
 <4fb8a812fdd01f115a99317c8e46ad055b5bf102.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <4fb8a812fdd01f115a99317c8e46ad055b5bf102.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 9/24/25 6:22 PM, Eduard Zingerman wrote:
> On Wed, 2025-09-24 at 14:15 -0700, Ihor Solodrai wrote:
>> When a kfunc is marked with KF_IMPLICIT_PROG_AUX_ARG, do not emit the
>> last parameter of this function to BTF.
> 
> [...]
> 
>> @@ -887,6 +923,12 @@ static int32_t btf_encoder__add_func_proto_for_state(struct btf_encoder *encoder
>>  	nr_params = state->nr_parms;
>>  	type_id = state->ret_type_id;
>>  
>> +	if (is_kfunc_state(state) && KF_IMPLICIT_PROG_AUX_ARG & state->elf->kfunc_flags) {
>> +		if (validate_kfunc_with_implicit_prog_aux_arg(state))
>> +			return -1;
>> +		nr_params--;
>> +	}
>> +
>>  	id = btf_encoder__emit_func_proto(encoder, type_id, nr_params);
>>  	if (id < 0)
>>  		return id;
> 
> This change hides the fact that function accepts one more parameter
> both from kernel BTF and from program BTF (via vmlinux.h).

Right, this is intentional.

> Do we anticipate other implicit parameter types?

It's very plausible, but I don't know of specific examples.

> Because if we do, it seems like having some generic KF_IMPLICIT_ARG
> and hiding it only from vmlinux.h seem more flexible.

I'm not sure how generic KF_IMPLICIT_ARG would even work.

Any *implicit* parameter requires a very concrete implementation in
the verifier: an actual pointer of a particular type is injected after
the verification. So we have to do a type check on pahole side to
catch invalid kfunc declarations. And the verifier of course must be
very strict about where it can pass pointers to kernel objects.

From a couple of discussions with Andrii, my impression is that it
would be beneficial to have some kind of generic "execution context"
available to BPF programs and/or kfuncs to cover all potential
implicit arguments. But that's a separate big discussion.

Supporting bpf_prog_aux specifically is a pragmatic improvement to the
current inconvenience that sched_ext has to deal with [1].

[1] https://lore.kernel.org/bpf/20250920005931.2753828-42-tj@kernel.org/


