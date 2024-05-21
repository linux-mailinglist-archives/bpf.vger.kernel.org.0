Return-Path: <bpf+bounces-30144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A4E8CB34F
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 20:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 588D8B22565
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 18:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1396C38FB0;
	Tue, 21 May 2024 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l4iB8xUe"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159A523775
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314982; cv=none; b=U5Ia5aPTR/SVA/1cOqttrp+GFOeRhTTExnv201WftGrNCJCpDRLOMXCLOow9YE7xDyAJpAy00aiIZnepzSBr5K8xBWsKM2zkR1aMMVcHL4tSxvSWuFszaSX+MFoBSZE71qnpGAC219jU8EPE5ghvzsTCugNCJqzq5jZ4bfl96R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314982; c=relaxed/simple;
	bh=HXB9bvCRQoU2CvcaxYy4Si+3bc+EecgVArhxlP83M0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVQ3wRRO0EPP9oG36Hfu9V0c71wu0HMse9i7365vS0jxGoH/lfnmAFdYaROjDvSbHHMSQ2EA/RqUwZuJV2U4AZ4z4k+eC3jOy3kFfWeKAxPij+nRI64uxdcIPkwDO4E0O0gTAoMQ4bOgcfC3Q/G0v5IrBG58WHjdaFH7Hd/poDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l4iB8xUe; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: sinquersw@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716314978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9OOKFg29b0fnvxFwoN+Bbjrb2pS+SviXFVb0sVGhOqk=;
	b=l4iB8xUeKnOxj2tv6inubmpAG52Hf6/9y3t2n//xoISPSjjYSFU1v8UsQYGLHXzTE8ouDt
	Rh96yu7vdX7fDCrUCM6TqpsobdgwGUEpT73KEGXY4cLL4GqhXXiU3b8aGVz4W6hjpHaUUI
	5iT3jXuFJu1y7z8ZsCytL6GcXkqFZC0=
X-Envelope-To: thinker.li@gmail.com
X-Envelope-To: kuifeng@meta.com
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: song@kernel.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: andrii@kernel.org
Message-ID: <ebd98bb8-a3c5-4c03-8812-2f64a36dd737@linux.dev>
Date: Tue, 21 May 2024 11:09:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/7] bpf: enable detaching links of struct_ops
 objects.
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240510002942.1253354-1-thinker.li@gmail.com>
 <20240510002942.1253354-3-thinker.li@gmail.com>
 <fcae9370-82ab-4c2f-90f5-e3a704f6d11c@linux.dev>
 <58dcc859-45c6-4493-8760-61e469ba2e69@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <58dcc859-45c6-4493-8760-61e469ba2e69@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/21/24 12:30 AM, Kui-Feng Lee wrote:
> 
> 
> On 5/20/24 18:22, Martin KaFai Lau wrote:
>> On 5/9/24 5:29 PM, Kui-Feng Lee wrote:
>>> +static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
>>> +{
>>> +    struct bpf_struct_ops_link *st_link = container_of(link, struct 
>>> bpf_struct_ops_link, link);
>>> +    struct bpf_struct_ops_map *st_map;
>>> +    struct bpf_map *map;
>>> +
>>> +    mutex_lock(&update_mutex);
>>> +
>>> +    map = rcu_dereference_protected(st_link->map, 
>>> lockdep_is_held(&update_mutex));
>>> +    if (!map) {
>>> +        mutex_unlock(&update_mutex);
>>> +        return -EINVAL;
>>> +    }
>>> +    st_map = container_of(map, struct bpf_struct_ops_map, map);
>>> +
>>> +    st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
>>> +
>>> +    rcu_assign_pointer(st_link->map, NULL);
>>> +    /* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
>>> +     * bpf_map_inc() in bpf_struct_ops_map_link_update().
>>> +     */
>>> +    bpf_map_put(&st_map->map);
>>> +
>>> +    mutex_unlock(&update_mutex);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static const struct bpf_link_ops bpf_struct_ops_map_lops = {
>>>       .dealloc = bpf_struct_ops_map_link_dealloc,
>>> +    .detach = bpf_struct_ops_map_link_detach,
>>>       .show_fdinfo = bpf_struct_ops_map_link_show_fdinfo,
>>>       .fill_link_info = bpf_struct_ops_map_link_fill_link_info,
>>>       .update_map = bpf_struct_ops_map_link_update,
>>> @@ -1176,13 +1208,19 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>>>       if (err)
>>>           goto err_out;
>>> +    /* Init link->map before calling reg() in case being detached
>>> +     * immediately.
>>> +     */
>>
>> It is not obvious in the patch how this (immediate detach by subsystem after 
>> reg) may work without race, so I think it is easier to ask.
>>
>> [ I put back the err_out context at the end ]
>>
>>> +    RCU_INIT_POINTER(link->map, map);
>>> +
>>>       err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, &link->link);
>>>       if (err) {
>>> +        RCU_INIT_POINTER(link->map, NULL);
>>
>> In the bpf_struct_ops_map_link_detach() above, the update to link->map is 
>> protected by the update_mutex. Could you explain how the link->map update to 
>> NULL is safe here without holding the update_mutex?
> 
> If err is not zero, it means the subsystem rejects the pair of the
> object and the link passing in. So, it has no reasonable to call
> bpf_struct_ops_map_link_detach() for this link.
> 
> Does it make sense to you?
> 
>>
>>>           bpf_link_cleanup(&link_primer);
>>> +        /* The link has been free by bpf_link_cleanup() */
>>>           link = NULL;
>>>           goto err_out;
>>>       }
> 
> At this point, we don't change the content of the link anymore except
> changing link->fd in bpf_link_settle(). So, it should be safe to call
> bpf_struct_ops_map_link_detach() from the subsystem.
> 
> Should I explain it in a comment if you think it makes sense to you?

It makes sense and will be useful to get this details in the comment.

> 
>>> -    RCU_INIT_POINTER(link->map, map);
>>>       return bpf_link_settle(&link_primer);
>>>
>>
>> err_out:
>>      bpf_map_put(map);
>>      kfree(link);
>>      return err;
>> }
>>
>>


