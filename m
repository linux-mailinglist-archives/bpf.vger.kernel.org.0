Return-Path: <bpf+bounces-77690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA892CEEE3F
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 16:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8397430109B1
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 15:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3713275B15;
	Fri,  2 Jan 2026 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J2c9SRA/"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F7E25A33A
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767368326; cv=none; b=f4MDcg7F88Grfpqc0WS8IJP3XKAuur10hzQh5Bk/Tyx0MCGwaVols7LRxAvHshh1C3b270rO7FBx3mlxXYC1KcxXPh3uDG6q5/nzactJ5KOCUnRb3lvEcZcW6DEhetmR1rmLv+lDaL3Z7JFKw+a24yUJ5S4+P0F/CCFJKz29PWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767368326; c=relaxed/simple;
	bh=+iYz7m2D8U8EwGz1kSidRtFmtpogOaFyOnPfxjbl6zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sj9/TpsOayZUEBMOboucg0+xVn+aGgzS4OLFgGFKJih6TdTjetvzoYkhqF45tGH1UgEYNu7ZZDpALT8eAG6knPo1i7jsRJHGm7fHD/cBW8LljNzb6twD1guE5kaG1ocHUjiyIB7i0E/qwg3ZGjQgGhew/EwV1GTXK1YZrdDjDA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J2c9SRA/; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <883a21af-750c-49df-88c6-47bd642e03d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767368320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=taD8t+CRYZkYr8f56OzWxn0Ld4xi2x2xvqJmet4VYKk=;
	b=J2c9SRA/ZhbRgjOYPehVBB39V1rco1clZMAUidT4LuwgHuP8gvVpBo+rR3q/m91jrmXejR
	VkeWIS/+7E64XyXQfUsgt7kCFxlA4wd/JurUBVXSVh0WqktjV3xAXihcoQl/6qwP39dXq9
	P9PAoRpEfFR5S4QDwFvEBJ/EU7V1kV8=
Date: Fri, 2 Jan 2026 23:38:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/4] bpf: tailcall: Introduce
 bpf_arch_tail_call_prologue_offset
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org,
 xukuohai@huaweicloud.com, catalin.marinas@arm.com, will@kernel.org,
 davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, akpm@linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kernel-patches-bot@fb.com, martin.lau@kernel.org,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260102150032.53106-2-leon.hwang@linux.dev>
 <45f1e1978b7dc28e522dcc0a72954d892b37a85220749bd027c7395edb01d991@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <45f1e1978b7dc28e522dcc0a72954d892b37a85220749bd027c7395edb01d991@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/2 23:21, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>> index 1eeb31c5b317..beedd1281c22 100644
>> --- a/kernel/bpf/arraymap.c
>> +++ b/kernel/bpf/arraymap.c
>> @@ -127,6 +127,9 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
>>  			array_size += (u64) max_entries * elem_size;
>>  		}
>>  	}
>> +	if (attr->map_type == BPF_MAP_TYPE_PROG_ARRAY && bpf_arch_tail_call_prologue_offset())
>> +		/* Store tailcall targets */
>> +		array_size += (u64) max_entries * sizeof(void *);
> 
> Should array_map_mem_usage() also account for this additional space?
> Currently array_map_mem_usage() handles special cases for percpu arrays
> and mmapable arrays, but has no corresponding check for PROG_ARRAY maps
> when bpf_arch_tail_call_prologue_offset() is non-zero. This would cause
> the reported memory usage to be lower than the actual allocation when
> an architecture implements this function (e.g., x86_64 and arm64 in the
> subsequent patches of this series).
> 
> [ ... ]
> 

You are right, array_map_mem_usage() needs to stay in sync with the
allocation logic to avoid under-reporting memory.

I will include this fix in the next revision after I’ve collected more
feedback.

Thanks,
Leon


