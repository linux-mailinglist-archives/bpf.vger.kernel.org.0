Return-Path: <bpf+bounces-74805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CF4C664D7
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 22:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5124E361C9C
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 21:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159CE332EB1;
	Mon, 17 Nov 2025 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qcg86rnt"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842BD326D67
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 21:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763415612; cv=none; b=gBUEkwpgEcl0GKpbjpl30O0WjhxZTtaxHQ+rLqxe9zARLJF7Su14hUIdF3w/fX1khc82wZVW3dYEXu1FfwTJhwdbwWKsUDNmT0+1BVY5LY745zlqXbW3yRrYsHrJBBMkxo7jKybPcRzbAW1S/5Da2cHMBjGuAX0de6d9EiGmhhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763415612; c=relaxed/simple;
	bh=6vnEE9ump1OA/j67GsUhl/mp3FIXpsw3Aw0nK/AW9OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/zLDG6Xv3IASitJj9K+XAlWA5z6LDlYOoEWOETGe2D/F29Hye9BtZLaWeYZM0ZCqj8+m8xci2Qtr87mG5j5pgBW4HgEBKa5woTYitXMN+ZI5yCxHNumTJ6UitKNaFCVujCWnzIU8aKgT3kNlhBbf2XC2kze6zaerzqU8yVlhZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qcg86rnt; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c891d752-33cc-413d-8311-dcf8afbf339d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763415598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3psy+YMGd649VQ8h9SgRyQqGiP9VgpHxVPEjHcJMhgk=;
	b=Qcg86rntG8F+eD2cBwMrRokeWNQoE9MJiverjUZdcdVzmYdVv82HCRSktyGrpF52lSABh8
	VsZvQrzINkYiUMpcU+1ddS0I/m+6OPJ8BuQJ+aOPEF0u9tNDbhqFCKB4xOVtwNnSuZ/Jvo
	9ExOLsMIGF640CGHxi7QMy1jpAyI3yg=
Date: Mon, 17 Nov 2025 13:39:44 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 2/6] bpf: Support associating BPF program with
 struct_ops
To: ameryhung@gmail.com
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org,
 kernel-team@meta.com, ast@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev,
 bpf@vger.kernel.org, bot+bpf-ci@kernel.org
References: <20251114221741.317631-3-ameryhung@gmail.com>
 <16d43cdc90504cad5143df62b3d40f325a271aeca0adc521c6fef711023f90ef@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <16d43cdc90504cad5143df62b3d40f325a271aeca0adc521c6fef711023f90ef@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/14/25 2:51 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index a41e6730e..626aa9197 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
> 
> [ ... ]
> 
>> @@ -811,6 +822,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>   		bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS,
>>   			      &bpf_struct_ops_link_lops, prog, prog->expected_attach_type);
>>   		*plink++ = &link->link;
>> +
>> +		err = bpf_prog_assoc_struct_ops(prog, &st_map->map);
>> +		if (err) {
>> +			bpf_prog_put(prog);
>> +			goto reset_unlock;
>> +		}
> 
> Can this double-put the prog reference? In bpf_struct_ops_map_update_elem:
> 
>    prog = bpf_prog_get(prog_fd);              // refcnt = 1
>    bpf_link_init(..., prog, ...);             // link takes ownership
>    *plink++ = &link->link;                    // link stored in st_map
>    err = bpf_prog_assoc_struct_ops(prog, ...);
>    if (err) {
>      bpf_prog_put(prog);                      // refcnt = 0, prog freed
>      goto reset_unlock;
>    }
> 
> Then at reset_unlock:
> 
>    bpf_struct_ops_map_put_progs(st_map);      // calls bpf_link_put(link)
> 
> The bpf_link_put will eventually call bpf_link_dealloc()->bpf_prog_put(link->prog),
> attempting to put the already-freed prog reference. This looks like a use-after-free
> if bpf_prog_assoc_struct_ops fails (which can happen when a non-struct_ops program
> is already associated and returns -EBUSY).

The ai-review should be correct in general on the double bpf_prog_put.

> 
> Should the error path skip the bpf_prog_put and let bpf_struct_ops_map_put_progs
> handle the cleanup via the link?

bpf_prog_assoc_struct_ops will never return error for 
BPF_PROG_TYPE_STRUCT_OPS. If that is the case, maybe completely remove 
the err check.


