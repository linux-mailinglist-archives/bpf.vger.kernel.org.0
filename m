Return-Path: <bpf+bounces-78374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EB5D0C158
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 20:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 060133025DB3
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 19:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC0730DEB8;
	Fri,  9 Jan 2026 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U4tjFHp2"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9BE3398A;
	Fri,  9 Jan 2026 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767987298; cv=none; b=Fj+kH+3wJmlf7iEb8k1BO4odEKXS4H15y0D5x66W1ZVbPBRMKVsgo8kBPKX+NppZAFE1E5OC6sTdKq4Fjq+QVV9BhiamFj8yffVbqOwAuHg2H5cos6nGGzdANjG5Rt/Bu3dXcZvcFbGJ6aswa5ybyRwytikKFwwGwWU/jmVfXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767987298; c=relaxed/simple;
	bh=1LYPlAuuSKe87kSWcWwfw07rnIjC7+5DOoOpWTyd90g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myJW6upPwH6IzVN5YRnBLoNagiUoIJXVU5RYtXSUZjnzGUeZ+ExMcqbu1ahbU1TU7IM1bfyl6bnTIRlJJkfDnHXsKIrQnuY5dVxC7Ib6a1UGq40KGvAOuscJZTcptzKLTKJI0S4H4aggJQ0X9IRgXLtsbcqKwouHBISVR4TNqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U4tjFHp2; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <959cbc0f-6ec9-440e-96cb-64bb2cc26817@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767987294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRQAvj0Fe38gDGKQiHCGy2Q/83lfJaDQOBTGVSZfwDc=;
	b=U4tjFHp2WMerzMT4jif1pQ99jKZ/hjfBapw4rsscbVAAkvf8I9Ox7wwZMo+vTwMPf9zHnV
	FtNejbXyzUF016CL7YMxN+GGdgBHN4XH4Y9YQqDYNasDD/MjQa6t01EfZ0KOq2biI4yYIl
	zhmlVjhxd43u+DAVWc3F3a7ETD+MSOU=
Date: Fri, 9 Jan 2026 11:34:46 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 04/10] resolve_btfids: Support for
 KF_IMPLICIT_ARGS
To: bot+bpf-ci@kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com
Cc: yatsenko@meta.com, tj@kernel.org, alan.maguire@oracle.com,
 bentiss@kernel.org, jikos@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 sched-ext@lists.linux.dev, martin.lau@kernel.org, yonghong.song@linux.dev,
 clm@meta.com
References: <20260109184852.1089786-5-ihor.solodrai@linux.dev>
 <614a1ac62ade1a2c93f3669dea78d37d1fba159f1f00e79c5e8047047a772d75@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <614a1ac62ade1a2c93f3669dea78d37d1fba159f1f00e79c5e8047047a772d75@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/9/26 11:15 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index df39982f51df..b361e726fa36 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
> 
> [ ... ]
> 
>> +static s64 btf__collect_decl_tags(const struct btf *btf, s32 *decl_tags, u32 decl_tags_sz)
>> +{
>> +	const u32 type_cnt = btf__type_cnt(btf);
>> +	const struct btf_type *t;
>> +	s64 nr_decl_tags = 0;
>> +
>> +	for (u32 id = 1; id < type_cnt; id++) {
>> +		t = btf__type_by_id(btf, id);
>> +		if (!btf_is_decl_tag(t))
>> +			continue;
>> +		if (nr_decl_tags >= decl_tags_sz) {
>> +			pr_err("ERROR: resolve_btfids: too many decl tags in BTF - limit %s\n",
>> +				decl_tags_sz);
>                                 ^^^^^^^^^^^^^^^^^
> 
> Should this be %u instead of %s? The decl_tags_sz parameter is a u32, but
> the format specifier %s expects a string pointer. When the error path is
> triggered (more than MAX_DECL_TAGS decl tags in BTF), this will cause
> undefined behavior as printf tries to interpret the integer value as a
> memory address to read a string from.

Correct, it should be %u or %d.

> 
>> +			return -E2BIG;
>> +		}
>> +		decl_tags[nr_decl_tags++] = id;
>> +	}
>> +
>> +	return nr_decl_tags;
>> +}
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20862592244


