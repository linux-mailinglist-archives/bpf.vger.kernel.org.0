Return-Path: <bpf+bounces-29358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C91B8C1A9F
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA9A1C22444
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788C484A4B;
	Fri, 10 May 2024 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZMv4CE1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5852C6166E
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299797; cv=none; b=uPizM44mHsm5amTgFWUByDcbBE2tmc7Yrrg5DFY9nfL+fPB1cDLX3b2chkMBc7Nkx4wcwFmmevzB8s1KasligHQbuJHOT07tGe+dt1m6AYk/Z+VjhKwtLEZKUOeXvlkdb3S+bBwRoBA1oOzB2aSJoJj8uWZwIPcJzNrv1SFcBco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299797; c=relaxed/simple;
	bh=CRyVyadP3ZU1CdFK1za0d7DYYm3XBt0zVrXPowbXrUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1w2pQbz+Y0yAncfi4a6Z3pz24hBi78m+qcxW/eekSPi/wNdzwzO73qvPkua69cLSCccq8w8HTTZs6uc93gM36JYwnrtwIEBi0F1aFdx8YaBF+8CaZmBL7puhiPn4kyJ6IqcCzjbwvE7QvxzFwREgZbsKE9owK/bpUsIo5cQdCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZMv4CE1; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de462979e00so1601039276.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715299794; x=1715904594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHcDzABRTPbRjY4D0g8zctIjEcKfq/Bknw189QrYauE=;
        b=aZMv4CE1PdXsOFqFYmeILF/23XMPAZXC2ZMdRrYumzr6UQTYqPN1sruWRV0YmvUq0w
         gttJGXcvpaeqnlPBKuaXUTjlB4IKMzjGWgTED5+5bKElNrHzYYnHrA1Dj/blbOPl9Fix
         CbgSoqveMOkho2UaCQ42WnrVSOMDk+ig/Hqr5fVRWyA7kQ1PLrK/lwY28vfihybdxuMN
         paYxOoFViivGPXYxY9YwR1U7ROBvML6n28Om7iZBk6PVHlpQF4lZVzfIwqKDjUJqg6ly
         OjHoNnkR2jL6m9BX42y+WjfrCEjlRCNunCBPQC8vMvnein70qbePJ3nF5PEJvdfuShHy
         v49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299794; x=1715904594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHcDzABRTPbRjY4D0g8zctIjEcKfq/Bknw189QrYauE=;
        b=atfMMfY6lj9KRd1ctM+M5wWU/xBd8wf7IiMmmNPvABSlgkybAw6TSB9gNn+AKCyG02
         bPxcIbUigOGA6li+f6vY3gvYJaiAsKYpbGEynyniis5aAKbl+2KqZyqGIMMOvTjbpvjv
         XHNFCm6u41CTBADJAM9VtGiLH/9KAqnqOoQ6frMn5721d3kKV8EXigQLKJTtbZsW6LyV
         QSwxhn4xG1qmj5t/UXjPtxjdcqFFpNHvMo6DCc9Ai0FmkGZ07uB3cVVTP4vHT+zuOUlq
         DreC2+sQRqPKiCfsPPgTmuAFKcTICfD8zDfHtK+BcS3SJbW0tVVN8Dx5wHd1Hma4HhR0
         BZpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn6F1OK7lv6nUIMsE+pihDSofBRqx6KtrrnV4sytimsiEcVxeq+mLZa2FX/vDMfT6rYfhg6ilPYtgwEJlQ6WA9kPUL
X-Gm-Message-State: AOJu0YzdYnt/pOHCPQNm0TSIcMY+9FlwszVZBWR7I3tIM/yYfCqNBfrm
	ZksQmDSNUg/zhofRG7KA1AYsn4T4qIb7ULppFypIVXVCD4X3CXAB
X-Google-Smtp-Source: AGHT+IH+0mJJTXjsMz0YgkuQOuhK8Y8YxmNfvCQHi+tzuGfqITMVd+FarFXYc2xsC+LA5o0GzLeDVQ==
X-Received: by 2002:a25:d0d7:0:b0:de6:d19:837a with SMTP id 3f1490d57ef6-dee4f33a0d4mr1155837276.34.1715299794132;
        Thu, 09 May 2024 17:09:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:66fe:82c7:2d03:7176? ([2600:1700:6cf8:1240:66fe:82c7:2d03:7176])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd374406asm547991276.29.2024.05.09.17.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 17:09:53 -0700 (PDT)
Message-ID: <f13a1965-15d7-4809-ae15-ad42ca0b336e@gmail.com>
Date: Thu, 9 May 2024 17:09:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 4/9] bpf: create repeated fields for arrays.
To: Eduard Zingerman <eddyz87@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240508063218.2806447-1-thinker.li@gmail.com>
 <20240508063218.2806447-5-thinker.li@gmail.com>
 <61b492f9bc12f92b64bf5ce06363087ec828e991.camel@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <61b492f9bc12f92b64bf5ce06363087ec828e991.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/9/24 16:13, Eduard Zingerman wrote:
> On Tue, 2024-05-07 at 23:32 -0700, Kui-Feng Lee wrote:
>> The verifier uses field information for certain special types, such as
>> kptr, rbtree root, and list head. These types are treated
>> differently. However, we did not previously support these types in
>> arrays. This update examines arrays and duplicates field information the
>> same number of times as the length of the array if the element type is one
>> of the special types.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]
> 
>> @@ -3504,6 +3539,19 @@ static int btf_find_field_one(const struct btf *btf,
>>   {
>>   	int ret, align, sz, field_type;
>>   	struct btf_field_info tmp;
>> +	const struct btf_array *array;
>> +	u32 i, nelems = 1;
>> +
>> +	/* Walk into array types to find the element type and the number of
>> +	 * elements in the (flattened) array.
>> +	 */
>> +	for (i = 0; i < MAX_RESOLVE_DEPTH && btf_type_is_array(var_type); i++) {
>> +		array = btf_array(var_type);
>> +		nelems *= array->nelems;
>> +		var_type = btf_type_by_id(btf, array->type);
>> +	}
> 
> Nit: still think that error should be reported when i == MAX_RESOLVE_DEPTH.

Sure! I will change it.

> 
>> +	if (nelems == 0)
>> +		return 0;
>>
>>   	field_type = btf_get_field_type(__btf_name_by_offset(btf, var_type->name_off),
>>   					field_mask, seen_mask, &align, &sz);
> 
> [...]

