Return-Path: <bpf+bounces-76191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F80CA9965
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 00:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71BD230249FB
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 23:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93EF2980A8;
	Fri,  5 Dec 2025 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b/YI44TB"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2273521FF3B
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764976339; cv=none; b=a3ba1ExSsjMFNWtijrtMHQrGBt8MzhzbQxGRoXk0240AeUIKO7GzSUK7wJDopvSS8tN7rvG4zkWAfL6le7EK4TsQ5fUy0doreP/gKbmxGCpEAhjC+pm/GYk89ZXS43sa2OsTRifYA5YqYENsyCZgPrCwsycvGuYUW9JUQlVQxCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764976339; c=relaxed/simple;
	bh=jo3EcaFDbGYBlo3fqN/7e1jTrk1EwKAiT8S92LEdlSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnTRBySLSuj2SMAnHj/uAAfhx3nAIzl8BBaYFt8MbBsCozYV4UqyMTWCK5qqs28KIWzG8MRYJz65XvDUZykC5pOE+7eIJOuA02PXg56DBeHZ8Y0Q8EkAPzPvUG52ugfqkDYDp+UIT7L54Ocb0ZOQsOJgAdbgBe50lOoirDR8KA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b/YI44TB; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fb8c16dc-07ee-48bb-a370-0a4931dbba08@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764976334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/MYzAehkFQDpJ78ICQhSZnmM6tqkD8eXdkHrAUbgkQ=;
	b=b/YI44TBJcc1qJaLolT80ON1SvaUjaBRthAJmZ4EDH0aGrUV1Wm/UIiu1SnlxwdjGKF9hc
	JAFoaDi3PvlGyO/VL3+LjdQwtObbqce7xMmZO8cYSqRC7H31oBDAqeLRo/9SXSgbSBY7/0
	Wo6/4I00FYrUNRII3QJ5/ruTQ1qeWBo=
Date: Fri, 5 Dec 2025 15:12:01 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/6] resolve_btfids: Factor out load_btf()
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 akpm@linux-foundation.org, nathan@kernel.org, nsc@kernel.org, tj@kernel.org,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 shuah@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, alan.maguire@oracle.com, dolinux.peng@gmail.com
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 martin.lau@kernel.org, clm@meta.com
References: <20251205223046.4155870-3-ihor.solodrai@linux.dev>
 <e7478657b0308d8c4c16f5f412e92a3dbf565b0777424bd6d163d1d8288cf10a@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <e7478657b0308d8c4c16f5f412e92a3dbf565b0777424bd6d163d1d8288cf10a@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/5/25 2:57 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index 164f0c941f04..b4caae1170dd 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
> 
> [ ... ]
> 
>> @@ -529,16 +532,10 @@ static int symbols_collect(struct object *obj)
>>  	return 0;
>>  }
>>
>> -static int symbols_resolve(struct object *obj)
>> +static int load_btf(struct object *obj)
>>  {
>> -	int nr_typedefs = obj->nr_typedefs;
>> -	int nr_structs  = obj->nr_structs;
>> -	int nr_unions   = obj->nr_unions;
>> -	int nr_funcs    = obj->nr_funcs;
>> -	struct btf *base_btf = NULL;
>> -	int err, type_id;
>> -	struct btf *btf;
>> -	__u32 nr_types;
>> +	struct btf *base_btf = NULL, *btf = NULL;
>> +	int err;
>>
>>  	if (obj->base_btf_path) {
>>  		base_btf = btf__parse(obj->base_btf_path, NULL);
>>  		err = libbpf_get_error(base_btf);
>>  		if (err) {
>>  			pr_err("FAILED: load base BTF from %s: %s\n",
>>  			       obj->base_btf_path, strerror(-err));
>> -			return -1;
>> +			goto out_err;
>>  		}
>>  	}
>>
>>  	btf = btf__parse_split(obj->btf_path ?: obj->path, base_btf);
>>  	err = libbpf_get_error(btf);
>>  	if (err) {
>>  		pr_err("FAILED: load BTF from %s: %s\n",
>>  			obj->btf_path ?: obj->path, strerror(-err));
>> -		goto out;
>> +		goto out_err;
>>  	}
>>
>> +	obj->base_btf = base_btf;
>> +	obj->btf = btf;
>> +
>> +	return 0;
>> +
>> +out_err:
>> +	btf__free(base_btf);
>> +	btf__free(btf);
>> +	return err;
> 
> Can btf__free() safely handle ERR_PTR values here?
> 
> When btf__parse() fails on line 541, it returns ERR_PTR(-err), and
> libbpf_get_error() extracts the error code, but base_btf still holds
> the ERR_PTR value. The error path then calls btf__free(base_btf)
> where base_btf is ERR_PTR rather than NULL or a valid pointer.
> 
> The same issue occurs if btf__parse_split() fails on line 550, where
> btf contains ERR_PTR when btf__free(btf) is called.
> 
> In the old code at symbols_resolve(), if base_btf was ERR_PTR, the
> function would return -1 immediately without calling btf__free(),
> avoiding this issue. The new error handling with goto out_err changes
> this behavior.

That's a good observation. Interesting that AI noticed this only on
third try, probably due to changes in prompts.

btf__free() checks for error values [1], so this is not an issue.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/bpf/btf.c?h=v6.18#n968

> 
>> +}
>> +
>> +static int symbols_resolve(struct object *obj)
>> +{
>> +	int nr_typedefs = obj->nr_typedefs;
>> +	int nr_structs  = obj->nr_structs;
>> +	int nr_unions   = obj->nr_unions;
>> +	int nr_funcs    = obj->nr_funcs;
>> +	struct btf *btf = obj->btf;
>> +	int err, type_id;
>> +	__u32 nr_types;
>> +
>>  	err = -1;
>>  	nr_types = btf__type_cnt(btf);
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19978081551


