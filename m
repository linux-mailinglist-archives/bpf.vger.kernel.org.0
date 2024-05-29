Return-Path: <bpf+bounces-30880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D388D4175
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 00:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6D71C22FF9
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 22:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4F6177998;
	Wed, 29 May 2024 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QoDBUIzE"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CCD169ADC
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717022297; cv=none; b=aoRj1m6NpMHpAjnUMLslaTojODpe5XQdXdGhDU/wTxTlHeXGBYuepXj1xEXbseojowAqcLa52rlAUlrwCJ0LsQyMre7zKElKSA8U1kzeMREeOcn9fGI5RX5Qh+psHbuV6T1maVAltNJM3eIYloik1pYttvSmXTGJo/v7fMWUOBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717022297; c=relaxed/simple;
	bh=T0nsYQdYi06i17PUtvNiMQMXna9aV21HPTkbL4fJBW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYxnhqBH6FWO/8oPVAileCNVwOXA5YP0pUHJtTiVU98DT5fU8emCmlo/YuRqbKGZDH4D9wH3AIOHb/zLv18esaVbTv4EkT67gcSSqrUh/qjQLVjTi8CWBmbO7VBPI4ClfOj5YpBM5APPNqNlxuIHDvpy+rxhUajt4onMLU7X9V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QoDBUIzE; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: sinquersw@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717022293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMdz1JfmU+ROKUnjwXsSJjOLlFNxmHy3mKP38M0jty8=;
	b=QoDBUIzEc8b1xpdZO56y5v+Yp8LGp/rykSuVhiUkWLqdq3hSTG6E8/CVce+51BnoVBFbiV
	zjnIPTfGOJYPinM7LeWdZqtBdhpqGuWMAsoXkzrG5o+fhqyCg5x645v6+TJpDAt4H9rQ1i
	wL4SqElG/4tVPwBkC+/AZSXyK+BwUGA=
X-Envelope-To: thinker.li@gmail.com
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: song@kernel.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: andrii@kernel.org
X-Envelope-To: kuifeng@meta.com
Message-ID: <c995be4c-eac8-490c-a220-7f19794c3420@linux.dev>
Date: Wed, 29 May 2024 15:38:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 2/8] bpf: enable detaching links of struct_ops
 objects.
To: Kuifeng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240524223036.318800-1-thinker.li@gmail.com>
 <20240524223036.318800-3-thinker.li@gmail.com>
 <20b1a16e-2614-4022-9389-c28b332a29fb@linux.dev>
 <CAHE2DV1R8VwbVfZgcmzvJWdtnAaHyzC_KboUO_LynT8_-z71ZQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAHE2DV1R8VwbVfZgcmzvJWdtnAaHyzC_KboUO_LynT8_-z71ZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/29/24 8:04 AM, Kuifeng Lee wrote:
> On Tue, May 28, 2024 at 11:17 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 5/24/24 3:30 PM, Kui-Feng Lee wrote:
>>> +static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
>>> +{
>>> +     struct bpf_struct_ops_link *st_link = container_of(link, struct bpf_struct_ops_link, link);
>>> +     struct bpf_struct_ops_map *st_map;
>>> +     struct bpf_map *map;
>>> +
>>> +     mutex_lock(&update_mutex);
>>
>> update_mutex is needed to detach.
>>
>>> +
>>> +     map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
>>> +     if (!map) {
>>> +             mutex_unlock(&update_mutex);
>>> +             return 0;
>>> +     }
>>> +     st_map = container_of(map, struct bpf_struct_ops_map, map);
>>> +
>>> +     st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
>>> +
>>> +     rcu_assign_pointer(st_link->map, NULL);
>>> +     /* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
>>> +      * bpf_map_inc() in bpf_struct_ops_map_link_update().
>>> +      */
>>> +     bpf_map_put(&st_map->map);
>>> +
>>> +     mutex_unlock(&update_mutex);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>    static const struct bpf_link_ops bpf_struct_ops_map_lops = {
>>>        .dealloc = bpf_struct_ops_map_link_dealloc,
>>> +     .detach = bpf_struct_ops_map_link_detach,
>>>        .show_fdinfo = bpf_struct_ops_map_link_show_fdinfo,
>>>        .fill_link_info = bpf_struct_ops_map_link_fill_link_info,
>>>        .update_map = bpf_struct_ops_map_link_update,
>>> @@ -1176,13 +1208,22 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>>>        if (err)
>>>                goto err_out;
>>>
>>> +     /* Init link->map before calling reg() in case being detached
>>> +      * immediately.
>>> +      */
>>
>> With update_mutex held in link_create here, the parallel detach can still happen
>> before the link is fully initialized (the link->map pointer here in particular)?
>>
>>> +     RCU_INIT_POINTER(link->map, map);
>>> +
>>> +     mutex_lock(&update_mutex);
>>>        err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, &link->link);
>>>        if (err) {
>>> +             RCU_INIT_POINTER(link->map, NULL);
>>
>> I was hoping by holding the the update_mutex, it can avoid this link->map init
>> dance, like RCU_INIT_POINTER(link->map, map) above and then resetting here on
>> the error case.
>>
>>> +             mutex_unlock(&update_mutex);
>>>                bpf_link_cleanup(&link_primer);
>>> +             /* The link has been free by bpf_link_cleanup() */
>>>                link = NULL;
>>>                goto err_out;
>>>        }
>>> -     RCU_INIT_POINTER(link->map, map);
>>
>> If only init link->map once here like the existing code (and the init is
>> protected by the update_mutex), the subsystem should not be able to detach until
>> the link->map is fully initialized.
>>
>> or I am missing something obvious. Can you explain why this link->map init dance
>> is still needed?
> 
> Ok, I get what you mean.
> 
> I will move RCU_INIT_POINTER() back to its original place, and move the check
> on the value of "err" to the place after mutext_unlock().
The RCU_INIT_POINTER(link->map, map) needs to be done with update_mutex held and
it should be init after the err check, so the err check needs to be inside
update_mutex lock also.

Something like this (untested):

	mutex_lock(&update_mutex);

	err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, &link->link);
	if (err) {
		mutex_unlock(&update_mutex);
		bpf_link_cleanup(&link_primer);
		link = NULL;
		goto err_out;
	}
	RCU_INIT_POINTER(link->map, map);

	mutex_unlock(&update_mutex);


> 
>>
>>> +     mutex_unlock(&update_mutex);
>>


