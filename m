Return-Path: <bpf+bounces-26606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 075988A2389
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 04:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752181F235F6
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 02:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510BD522A;
	Fri, 12 Apr 2024 02:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgxOBYG8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF4E5C82
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 02:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712887219; cv=none; b=NoMJUm3kPXiaTC0d46A9YderqzfGzJVv8CnioEOFazyEYSp/p+9/veIrh+VVx4ku7aWNpSVh4WIf2OBD+g1FlRhb0+sgPjzToX44zqtRlAngHECEggVzpY9gDQeeDJW3wz3mTgyoYEd7olR+DfD+YrFzzf4/MJRC8cQ9rCbnD9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712887219; c=relaxed/simple;
	bh=Q96wnfKGlMzf0iTN7Jw+6d9092JFnZwYlRFXCrSxWbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVrpQJ8QsdlV9cbjgRxzXANfZzOTe51cBF/DK4FPZHalGrZ9msGbbxsU5te67H2/gWHEMAUkULfnXs8PYyzcnjlY3sYpDnkeYsSrzbRVCdwbILRcyw+Rcifv8fnZJ4AJ5ImMoz6J9BHYzDgO+Goou0ixiye52JGIOc+xiNuRWTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgxOBYG8; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-617f8a59a24so3522647b3.1
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 19:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712887217; x=1713492017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CAphrgmlYOKLDvp+0mQ/rsxPMVdO0zSigLpJ+c5t62Q=;
        b=IgxOBYG8Y518P+Rp36O93Yzb1Iw0ItV3YOQKdTu9kqrZNqvc3NoBiHNh4cPjC4GzAY
         2OICVypxYYFPA+ZTueUhrMbyLvBIH0sD/Orn6dwfwlnuy6CH9iszKtv4ambs65yWg/a0
         1SQZVgJgZqOH1phuzK91/A39ddQtQzVmDzK3sBTpcQlkZKZn6eHGjZsNkCGUr5213iXq
         NemcxDpZ5LqAC/W7kTWvXIUfH9kN7aEIxYeByCBUsuwFkwPlCpDN331HEvBa02vJrIoN
         ONzaEOrCLnbFYqsizxljOKSaLyZC+hUcAlGNYe/gLhIAJLakM+fLJIt5pfa80RmUB++N
         VPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712887217; x=1713492017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAphrgmlYOKLDvp+0mQ/rsxPMVdO0zSigLpJ+c5t62Q=;
        b=OS4JIg9h3QfSBBlSCZbRuBf/ybk2Zy4qTbM/rGdRUmej+MyUgAhPhmuHN8Kia1EBMm
         BWoEuF02F+BYcErjBAYQvqYi50ykHmXLHdTLbLzrPyV0MY5J3Wuuq6pR7Ni1Jl3CYuoE
         aUOU/5qJ56Iob4lTTNKmMH5lnIdgtvOMGaNP2BNkaV6Jdh0Bgf8CDjSX+f9aD4tqfaaY
         JbKetllrGea7+eQXXAgKPoLpFWP+UnCCrgkSFD0+xw4pAZ2AVdqguEBfxuJFsTMCTmz1
         sTGy5e4n+qRc/zBvmwlTDs1dZgk77QHsn5qCGWGKaSH9cyUBFnNBlSp7eFBLLI7hRWxp
         Ng/g==
X-Forwarded-Encrypted: i=1; AJvYcCX1rtsdDCl7r5gkhDg2LfZr2rWeXxQ5o3W9xE8p9IvTxZnHp1nTv+NZ43KHJ+cXovKcQsNrBxJiJfa60UTgmrYr6BlX
X-Gm-Message-State: AOJu0Yw/fNOeVdV4Z7vu1kA/STwLUxGlolQIu6usBbtv3LXMdB/phUSN
	STlwFTHRKP94iQ6lysyVK9G0wScaDM8JGVyHEAQfsqnkzLNAp4Kd
X-Google-Smtp-Source: AGHT+IH5NuCGKW5QH/Fm49NN0ZMuobDqYvtcCjE+rh+9oNME3lMr7fT3ueFYtrLVI+tjlGSwcT998g==
X-Received: by 2002:a05:690c:fc6:b0:615:1511:7f7d with SMTP id dg6-20020a05690c0fc600b0061515117f7dmr1557850ywb.41.1712887217449;
        Thu, 11 Apr 2024 19:00:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:9d24:c434:b27b:e59f? ([2600:1700:6cf8:1240:9d24:c434:b27b:e59f])
        by smtp.gmail.com with ESMTPSA id c9-20020a81e549000000b00617ca37b612sm596839ywm.91.2024.04.11.19.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 19:00:17 -0700 (PDT)
Message-ID: <4754fd2d-e351-4f77-afd7-df13bf6e2479@gmail.com>
Date: Thu, 11 Apr 2024 19:00:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 06/11] bpf: Find btf_field with the knowledge of
 arrays.
To: Eduard Zingerman <eddyz87@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240410004150.2917641-1-thinker.li@gmail.com>
 <20240410004150.2917641-7-thinker.li@gmail.com>
 <3ccb7e3c1b71bfe63606565d0a1b418876b45535.camel@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <3ccb7e3c1b71bfe63606565d0a1b418876b45535.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/11/24 15:14, Eduard Zingerman wrote:
> On Tue, 2024-04-09 at 17:41 -0700, Kui-Feng Lee wrote:
>> Make btf_record_find() find the btf_field for an offset by comparing the
>> offset with the offset of each element, rather than the offset of the
>> entire array, if a btf_field represents an array. It is important to have
>> support for btf_field arrays in the future.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   kernel/bpf/syscall.c | 19 +++++++++++++++----
>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 543ff0d944e8..1a37731e632a 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -516,11 +516,18 @@ int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
>>   static int btf_field_cmp(const void *a, const void *b)
>>   {
>>   	const struct btf_field *f1 = a, *f2 = b;
>> +	int gt = 1, lt = -1;
>>   
>> +	if (f2->nelems == 0) {
>> +		swap(f1, f2);
>> +		swap(gt, lt);
>> +	}
>>   	if (f1->offset < f2->offset)
>> -		return -1;
>> -	else if (f1->offset > f2->offset)
>> -		return 1;
>> +		return lt;
>> +	else if (f1->offset >= f2->offset + f2->size)
>> +		return gt;
>> +	if ((f1->offset - f2->offset) % (f2->size / f2->nelems))
>> +		return gt;
> 
> Binary search requires elements to be sorted in non-decreasing order,
> however usage of '%' breaks this requirement. E.g. consider an array
> with element size equal to 3:
> 
>     |  elem #0  |  elem #1  |
>     | 0 | 1 | 2 | 3 | 4 | 5 |
>     ^         ^   ^
>     '         '   '
>     f2        f1  f1'
>     
> Here f1 > f2, but f1' == f2, while f1' > f1.
> Depending on whether or not fields can overlap this might not be a problem,
> but I suggest to rework the comparison function to avoid this confusion.
> (E.g., find the leftmost field that overlaps with offset being searched for).

Ok! It will match the leftmost one overlapping with the offset. And
check if the offset aligning with one of the elements in btf_record_find().

> 
>>   	return 0;
>>   }
>>   
>> @@ -528,10 +535,14 @@ struct btf_field *btf_record_find(const struct btf_record *rec, u32 offset,
>>   				  u32 field_mask)
>>   {
>>   	struct btf_field *field;
>> +	struct btf_field key = {
>> +		.offset = offset,
>> +		.size = 0,	/* as a label for this key */
>> +	};
>>   
>>   	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & field_mask))
>>   		return NULL;
>> -	field = bsearch(&offset, rec->fields, rec->cnt, sizeof(rec->fields[0]), btf_field_cmp);
>> +	field = bsearch(&key, rec->fields, rec->cnt, sizeof(rec->fields[0]), btf_field_cmp);
>>   	if (!field || !(field->type & field_mask))
>>   		return NULL;
>>   	return field;
> 
> 

