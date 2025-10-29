Return-Path: <bpf+bounces-72895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ADDC1D492
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 21:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78564000E9
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 20:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091F42FF171;
	Wed, 29 Oct 2025 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xio+SCDx"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B8F2EDD52
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770969; cv=none; b=Q0zPZoVN9K9N9FrfQYkPK4I8Hlq74cmvRooylxoQ1Nr4mDqUcfwQdYSgA1IteocNmrJFvoGuTt09syq163IXMp/6aBJ+ys9RLrjjNBM7ZALwj8LXBn6ly7GkinSmv5wp3GgAwXQ/Ww6InFUfVyNl8XCxhYeKoFeett9Y0/zXwNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770969; c=relaxed/simple;
	bh=Ne6N52DmWPfwpe8MA0V4Vbi7U9EnIOX89Tn/yyGBwpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEieHiahVvxrobHqjd8TcvM8D6VcWpFTNjb9eM8wSmq54s9Xd4wxIgbW3d6oRfyvf2O2pLCxvh9CZNraxgC09DFJpHIV2U/QaaSzAHI814tLc3BEu4nyaNqELK/3l/Uc1KfxkYAp2ECTDWybm2aZEA1bVOb8s7EWyW0ZmMxmSNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xio+SCDx; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c974f5ed-b6d2-4716-a119-7efab07e2e8e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761770953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MAKz5OOMYGoJBDkuis9FSO26FtkXgNsy1VkFfK6LLdo=;
	b=xio+SCDxXBrourJ1ohaByqH3ZxBNykhGg0AUQeUhGQlbArzU+41E6kSuKbZBi2na/x1sbm
	+pTriLhJbiRzZSrRAexnZjXgPF8UlPW8w7AbpBpMcOUb1WLEJMbw0uTyldDaOKg1jaebam
	bsx2mCkg5pCGu3v4+eODf5dVkzDeOsw=
Date: Wed, 29 Oct 2025 13:49:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Support for kfuncs with
 KF_MAGIC_ARGS
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org,
 eddyz87@gmail.com, tj@kernel.org, kernel-team@meta.com,
 daniel@iogearbox.net, martin.lau@kernel.org, yonghong.song@linux.dev,
 clm@meta.com
References: <20251029190113.3323406-4-ihor.solodrai@linux.dev>
 <39bb0d21fffe3855c246dd85b2e69524c8e31bc9d84b441b063f365e5cbf220c@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <39bb0d21fffe3855c246dd85b2e69524c8e31bc9d84b441b063f365e5cbf220c@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/29/25 12:41 PM, bot+bpf-ci@kernel.org wrote:
> 
> ```
> commit 974828216758f5fff2d9783439b8daa20188ce8c
> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> bpf: Support for kfuncs with KF_MAGIC_ARGS
> 
> This patch adds infrastructure for magic kfuncs, which have two BTF
> representations: one for BPF programs and one for kernel implementation.
> The verifier resolves these through a lookup table.
> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index cb1b483be..fcf0872b9 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -3263,17 +3263,68 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
>>  	return btf_vmlinux ?: ERR_PTR(-ENOENT);
>>  }
>>
>> +/*
>> + * magic_kfuncs is used as a list of (foo, foo_impl) pairs
>> + */
>> +BTF_ID_LIST(magic_kfuncs)
>> +BTF_ID_UNUSED
>> +BTF_ID_LIST_END(magic_kfuncs)
>> +
>> +static s32 magic_kfunc_by_impl(s32 impl_func_id)
>> +{
>> +	int i;
>> +
>> +	for (i = 1; i < BTF_ID_LIST_SIZE(magic_kfuncs); i += 2) {
>> +		if (magic_kfuncs[i] == impl_func_id)
>> +			return magic_kfuncs[i - 1];
>> +	}
>> +	return -ENOENT;
>> +}
>> +
>> +static s32 impl_by_magic_kfunc(s32 func_id)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < BTF_ID_LIST_SIZE(magic_kfuncs); i += 2) {
>> +		if (magic_kfuncs[i] == func_id)
>> +			return magic_kfuncs[i + 1];
>                                     ^^^^^^^^^^^^^^^^^
> 
> Can impl_by_magic_kfunc() overflow magic_kfuncs[]? With the current
> initialization using BTF_ID_UNUSED, BTF_ID_LIST_SIZE(magic_kfuncs)
> equals 1. The loop condition checks i < 1, so when i=0 it executes and
> accesses magic_kfuncs[i+1], which is magic_kfuncs[1]. This is outside
> the array bounds.

Hmm... Given we do i += 2, this can't happen if magic_kfuncs table is
defined correctly. Also if BTF_ID_UNUSED is passed in here, we have
bigger problems.

I guess changing the loop condition to size-1 wouldn't hurt.

> 
> The same issue applies generally: the loop checks i < size but accesses
> i+1, so it should check i+1 < size instead.
> 
>> +	}
>> +	return -ENOENT;
>> +}
> 
> [ ... ]
> 
> 
> ```
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> In-Reply-To-Subject: `bpf: Support for kfuncs with KF_MAGIC_ARGS`
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18919699520


