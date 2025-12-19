Return-Path: <bpf+bounces-77093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2757CCCE267
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 02:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDC7430249E8
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C782D1F5834;
	Fri, 19 Dec 2025 01:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fu2vm2Sg"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD01F94A
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 01:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766108253; cv=none; b=ddcUnNV3QcYLEcC+nXuQfGwKflogzu14xSB08wQacv2xQhcX//1piKTL1Bdm22kdkqP7qsTYARKTq8aCKUUCBRnvFh+PaSIJ+W5wQLRKTiW5Oj0x4iFWawAPQeJOej9KTt7IoZrqwBmgIQzZoRuayE44fGQAuIxLoWOEDKTYsKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766108253; c=relaxed/simple;
	bh=2OjqvjnDMF22+ZyNKWm190d8Gq6HJza0XosaeCmd1fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOoEpOLH3oR9mT6yH5+cRmirqDYftpeYGXCPltegQ2X+ybUMfRvNwBu0homiprqIUHoEnLLp67tpADpYBAPLwF6qd8tpDiDdNiirXx26hZAkCtBF4Re9U+5Nt09n8wGen/NFxXocjpX9Ycly9sZA/H16DSN+ZVl4ohsq7GyOS2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fu2vm2Sg; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d023c8bb-1053-46ca-9236-f7e1e6bee52f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766108244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQzKvNOg/YRR9JxTw6aHrhcwLz0yvmB4i/8mZqSWKPI=;
	b=Fu2vm2SgrOSwEuWnTJA+1fkvMkB1rh5xjBCV3kAiUQMDrfhyKj6YKOVORuRVc4IDwYldKn
	Rh4T2ksb5ejKIfTRl7mItfLwIOjx40looP1eDSIaMTaVoiUWH2MybgtCItnXYbaVBSyQ/a
	BVHGo+W9/XxdlLblz4uZrDAH4lx/pXM=
Date: Thu, 18 Dec 2025 17:37:13 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 8/8] resolve_btfids: Change in-place update
 with raw binary output
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 akpm@linux-foundation.org, nathan@kernel.org, nsc@kernel.org,
 corbet@lwn.net, tj@kernel.org, void@manifault.com, arighi@nvidia.com,
 changwoo@igalia.com, shuah@kernel.org, nick.desaulniers+lkml@gmail.com,
 morbo@google.com, justinstitt@google.com, alan.maguire@oracle.com,
 dolinux.peng@gmail.com
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 sched-ext@lists.linux.dev, martin.lau@kernel.org, clm@meta.com
References: <20251219003147.587098-9-ihor.solodrai@linux.dev>
 <e269870b8db409800045ee0061fc02d21721e0efadd99ca83960b48f8db7b3f3@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <e269870b8db409800045ee0061fc02d21721e0efadd99ca83960b48f8db7b3f3@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/18/25 4:53 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index e721e20a2bbd..7127396c5f50 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
> 
> [ ... ]
> 
>> @@ -587,6 +563,19 @@ static int load_btf(struct object *obj)
>>  	obj->base_btf = base_btf;
>>  	obj->btf = btf;
>>
>> +	if (obj->base_btf && obj->distill_base) {
>> +		err = btf__distill_base(obj->btf, &base_btf, &btf);
>> +		if (err) {
>> +			pr_err("FAILED to distill base BTF: %s\n", strerror(errno));
>> +			goto out_err;
>> +		}
>> +
>> +		btf__free(obj->btf);
>> +		btf__free(obj->base_btf);
>> +		obj->btf = btf;
>> +		obj->base_btf = base_btf;
>> +	}
>> +
>>  	return 0;
>>
>>  out_err:
>> +	btf__free(base_btf);
>> +	btf__free(btf);
>>  	return err;
>>  }
> 
> Can this lead to a double free if btf__distill_base() fails?
> 
> At the point of calling btf__distill_base(), the local variables base_btf
> and btf have already been assigned to obj->base_btf and obj->btf. If
> btf__distill_base() fails, it does not modify its output parameters, so
> base_btf and btf still point to the same memory as obj->base_btf and
> obj->btf.
> 
> The out_err path then frees base_btf and btf (the original BTF objects).
> But obj->base_btf and obj->btf still point to this freed memory. When
> load_btf() returns an error to main(), the cleanup at the out: label
> calls btf__free(obj.base_btf) and btf__free(obj.btf), which would free
> the same memory a second time.
> 
> The execution path would be:
>   main() -> load_btf() -> btf__distill_base() fails
>   -> out_err frees base_btf and btf
>   -> return err to main()
>   -> main() goto out
>   -> btf__free(obj.base_btf) and btf__free(obj.btf) -> double free
> 
> Perhaps the out_err path should set obj->base_btf = NULL and obj->btf =
> NULL after freeing, or load_btf() should clear obj->base_btf/obj->btf
> before going to out_err?

I confirmed this is indeed a double free, although in a corner case.

I agree, we should set obj->btf and obj->btf_base to NULL at out_err.

Sending a v6 in a bit.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20355860150


