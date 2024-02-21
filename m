Return-Path: <bpf+bounces-22474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D1E85ED0E
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 00:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266D01C22850
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 23:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F65126F37;
	Wed, 21 Feb 2024 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RHt6CT4D"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465F1E485
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 23:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558460; cv=none; b=qvMw8n4Hi0WVulSxI/090WIVB8RYqOVZahn0a8QfjQ/ot63gyw7OCrO7vaJJnIMguw4tj1yzUuBbA/7oGu3+ekMe5YdBkqiWz0bU25lu282JWluw2d0jb6GkgGkH5KBqJul+ga/PF9SHGUUIUG+NQLKncQmKGM0VLc5i3ehecbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558460; c=relaxed/simple;
	bh=Ytw/aZue3qNJwidoA07bHxITlQ0KC8w/Zs2Km2wyYhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVha2Vz3ADeLTG17CoO3OUA5t8O09vH1dO9Xs7nA/tL1LRjd9FiOPQfDQPT+s8s0/3DRoP9LGaBqBVGjEUOE1N2F7VHe9asiGGmGld0j5aTbJBg1cUPs4jE2a8zfvY6pOyaCkrjtnmXdzTi/j0nX1V39yAcCF1ILew3mUBWXHF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RHt6CT4D; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7ef09893-c990-420d-8e0d-ff7be38c7fa2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708558453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYfFKyFA9B+j4MnpKp0xT4MIDgg2Aba0lFMCr5PmaiI=;
	b=RHt6CT4D8jtTUzwEsNs6q+pjgyUZ5CQs114pQgbbAJyUuTF4A1ANVlY5Eu3j342bxCco/r
	2FqAqn23pTQUEVfkPNgCYPjj5pC9jz+kQljBozS+6ZoZ6RmiMnWmOOxDeCxWav1UqUyn6I
	S0e5v+pqjz3hm/BDMcdTINTC4ivPO04=
Date: Wed, 21 Feb 2024 15:33:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: clarify batch lookup semantics
Content-Language: en-GB
To: Martin Kelly <martin.kelly@crowdstrike.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
References: <20240221211838.1241578-1-martin.kelly@crowdstrike.com>
 <a382f71d-3677-4545-a4e2-4e93f0ae3864@crowdstrike.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a382f71d-3677-4545-a4e2-4e93f0ae3864@crowdstrike.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/21/24 1:38 PM, Martin Kelly wrote:
> On 2/21/24 13:18, Martin Kelly wrote:
>> The batch lookup and lookup_and_delete APIs have two parameters,
>> in_batch and out_batch, to facilitate iterative
>> lookup/lookup_and_deletion operations for supported maps. Except NULL
>> for in_batch at the start of these two batch operations, both parameters
>> need to point to memory equal or larger than the respective map key
>> size, except for various hashmaps (hash, percpu_hash, lru_hash,
>> lru_percpu_hash) where the in_batch/out_batch memory size should be
>> at least 4 bytes.
>>
>> Document these semantics to clarify the API.
>>
>> Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
>> ---
>>   include/uapi/linux/bpf.h       |  6 +++++-
>>   tools/include/uapi/linux/bpf.h |  6 +++++-
>>   tools/lib/bpf/bpf.h            | 17 ++++++++++++-----
>>   3 files changed, 22 insertions(+), 7 deletions(-)
>
> Yonghong, looks like I missed your comment to change from "clarify 
> batch lookup semantics" to "Clarify batch lookup/lookup_and_delete 
> semantics"; sorry about that. Feel free to change it if you merge 
> this, or I can include it in a v3 if needed.

Ok, LGTM except the subject. I guess it is up to maintainers who will either change the subject
or asking for another revision if more change is needed. From my part,

Acked-by: Yonghong Song <yonghong.song@linux.dev>

>
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index d96708380e52..d2e6c5fcec01 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -617,7 +617,11 @@ union bpf_iter_link_info {
>>    *        to NULL to begin the batched operation. After each 
>> subsequent
>>    *        **BPF_MAP_LOOKUP_BATCH**, the caller should pass the 
>> resultant
>>    *        *out_batch* as the *in_batch* for the next operation to
>> - *        continue iteration from the current point.
>> + *        continue iteration from the current point. Both *in_batch* 
>> and
>> + *        *out_batch* must point to memory large enough to hold a key,
>> + *        except for maps of type **BPF_MAP_TYPE_{HASH, PERCPU_HASH,
>> + *        LRU_HASH, LRU_PERCPU_HASH}**, for which batch parameters
>> + *        must be at least 4 bytes wide regardless of key size.
>>    *
>>    *        The *keys* and *values* are output parameters which must 
>> point
>>    *        to memory large enough to hold *count* items based on the 
>> key
>> diff --git a/tools/include/uapi/linux/bpf.h 
>> b/tools/include/uapi/linux/bpf.h
>> index d96708380e52..d2e6c5fcec01 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -617,7 +617,11 @@ union bpf_iter_link_info {
>>    *        to NULL to begin the batched operation. After each 
>> subsequent
>>    *        **BPF_MAP_LOOKUP_BATCH**, the caller should pass the 
>> resultant
>>    *        *out_batch* as the *in_batch* for the next operation to
>> - *        continue iteration from the current point.
>> + *        continue iteration from the current point. Both *in_batch* 
>> and
>> + *        *out_batch* must point to memory large enough to hold a key,
>> + *        except for maps of type **BPF_MAP_TYPE_{HASH, PERCPU_HASH,
>> + *        LRU_HASH, LRU_PERCPU_HASH}**, for which batch parameters
>> + *        must be at least 4 bytes wide regardless of key size.
>>    *
>>    *        The *keys* and *values* are output parameters which must 
>> point
>>    *        to memory large enough to hold *count* items based on the 
>> key
>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>> index ab2570d28aec..df0db2f0cdb7 100644
>> --- a/tools/lib/bpf/bpf.h
>> +++ b/tools/lib/bpf/bpf.h
>> @@ -190,10 +190,14 @@ LIBBPF_API int bpf_map_delete_batch(int fd, 
>> const void *keys,
>>   /**
>>    * @brief **bpf_map_lookup_batch()** allows for batch lookup of BPF 
>> map elements.
>>    *
>> - * The parameter *in_batch* is the address of the first element in 
>> the batch to read.
>> - * *out_batch* is an output parameter that should be passed as 
>> *in_batch* to subsequent
>> - * calls to **bpf_map_lookup_batch()**. NULL can be passed for 
>> *in_batch* to indicate
>> - * that the batched lookup starts from the beginning of the map.
>> + * The parameter *in_batch* is the address of the first element in 
>> the batch to
>> + * read. *out_batch* is an output parameter that should be passed as 
>> *in_batch*
>> + * to subsequent calls to **bpf_map_lookup_batch()**. NULL can be 
>> passed for
>> + * *in_batch* to indicate that the batched lookup starts from the 
>> beginning of
>> + * the map. Both *in_batch* and *out_batch* must point to memory 
>> large enough to
>> + * hold a single key, except for maps of type **BPF_MAP_TYPE_{HASH, 
>> PERCPU_HASH,
>> + * LRU_HASH, LRU_PERCPU_HASH}**, for which the memory size must be at
>> + * least 4 bytes wide regardless of key size.
>>    *
>>    * The *keys* and *values* are output parameters which must point 
>> to memory large enough to
>>    * hold *count* items based on the key and value size of the map 
>> *map_fd*. The *keys*
>> @@ -226,7 +230,10 @@ LIBBPF_API int bpf_map_lookup_batch(int fd, void 
>> *in_batch, void *out_batch,
>>    *
>>    * @param fd BPF map file descriptor
>>    * @param in_batch address of the first element in batch to read, 
>> can pass NULL to
>> - * get address of the first element in *out_batch*
>> + * get address of the first element in *out_batch*. If not NULL, 
>> must be large
>> + * enough to hold a key. For **BPF_MAP_TYPE_{HASH, PERCPU_HASH, 
>> LRU_HASH,
>> + * LRU_PERCPU_HASH}**, the memory size must be at least 4 bytes wide 
>> regardless
>> + * of key size.
>>    * @param out_batch output parameter that should be passed to next 
>> call as *in_batch*
>>    * @param keys pointer to an array of *count* keys
>>    * @param values pointer to an array large enough for *count* values

