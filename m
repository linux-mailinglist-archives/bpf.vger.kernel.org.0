Return-Path: <bpf+bounces-26608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E737B8A2496
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 05:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CE9FB2129F
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 03:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA12817BCE;
	Fri, 12 Apr 2024 03:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZitH2uCW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73E179A7
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 03:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712894205; cv=none; b=DbOcP4wOcqGNDHysDtLsang57K9s6WcNVowU07kVASKlY+WE6PQtseEl7sdG6B3yMZya3KjT46d0EI7zgqI0QShaAU4igXbKQ8kTORyD2NSyBCB6h7Yk6hntB8z8g4cmh/pdvTP6lMDrUk7cqC1uxyOgDdNzJ7nH2E+r+/V3IsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712894205; c=relaxed/simple;
	bh=MJLXf4rVIryWQ8zeHN9E8pSAuT+3LPr0FGCGFhATNTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6I+dckxfxFLIkea/AJutboVIZxL69oikNlsFjKdhV9vx6dXFJft8dRShTpN91oOvjKIw5FE70xLa3IWuF4xZ1zhGb7KtiGD/BEXnd837LqCG6Z216sCK0V0HeSMmh1Okip949hesi6X5wBWMy1ekpJsRdC0G4x6WIwmlazZDaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZitH2uCW; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso449970276.3
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 20:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712894203; x=1713499003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8o1/F2CarPecW4mj+llQnwrE/VURUNcb4qebPVcqU8=;
        b=ZitH2uCWFSwYm8pKAo7rDmpEh+HXqmXZcgjM/y91MWeEEvuQo5iX1cGVLLg6GjkzLt
         ++tn0DDxN8tCVjsztSwrc8OCHmBwWQd9euplV23HL8ZADLxI6+ZaK9gf/HJ5XsZ1WM82
         c/Fa5r3PI4uOjA0+4n43q4dmgVBci2F1rtv6o5GC0+UIARU+8ATsCyZYG1rxiEnQm5Zg
         xJqVdJSjdoSXRHBJiLixnQD9hIw40gvucgZAuSu6Pd9ChHR5cLzEwpuq28zA/APInKAN
         EXEfAAQGkyStNTvniOwmS2jICAfzbz97px4Wqdbh4Hi5aA1TjaC7nyEhzyg42hB8Vckj
         oqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712894203; x=1713499003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8o1/F2CarPecW4mj+llQnwrE/VURUNcb4qebPVcqU8=;
        b=qYCmZUljSC7Do+GXNxMXEeCm/40HiDGpvRPwGG6R08teCOuu/84Iv1dO2PfG+J7vUk
         nnBGCfc/puRXC/WyvUDV2s0jYSzi4GLRt+VN9Wuy+kjV0ZtulHqHztAwtAcIKNsyceCx
         /BnfsIUH3aLfAz2tzJkXd/aS3q8aL+f/r7XOsvIbw6YR4iCTSdgJ3UjceCtY3tHphpw2
         jjs2U4FuvlP6zZ6zWshzYA719leMqK/sJRVd1hAndy3s0G388/yRVTry9mKE82HrAW72
         a6imM4Q5xOmU0PgxzeWrdas/K0RZsPJRqNQoyZRStvbllOc0NObv4HNbOZ48BqUSdMsW
         0hPg==
X-Forwarded-Encrypted: i=1; AJvYcCX87ceckUg5RtPCmrlgtBjRmdusp9UYWn7W+SqagHqTYV6FqLaRk9DRNtD/TQIQY7cbn8KsmfklcLVXwpAE27p7U99g
X-Gm-Message-State: AOJu0YwdUZWO1G92AEV2R7zYYRcxw/NtJzsCbdduzVI+MIoQgo7UPk3j
	cUzD9aXWiAw4TqRXC5zefTzIPQrGcaep3/yM+EWJurKbqqRg7bV0
X-Google-Smtp-Source: AGHT+IFnqZ6QeBlxPeIuYs8rcaAe5ICOsm5MjVmUOQ8WEtRS1aAtueRJ9dWwsH0E5ArJt/gr5JqhIg==
X-Received: by 2002:a25:1903:0:b0:dcc:d694:b4a6 with SMTP id 3-20020a251903000000b00dccd694b4a6mr1373927ybz.15.1712894203035;
        Thu, 11 Apr 2024 20:56:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:d7:be37:7e5d:7c78? ([2600:1700:6cf8:1240:d7:be37:7e5d:7c78])
        by smtp.gmail.com with ESMTPSA id g17-20020a5b0711000000b00dccdf447047sm581079ybq.65.2024.04.11.20.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 20:56:42 -0700 (PDT)
Message-ID: <f1957694-13c3-4b4f-96f1-451b8acedc4b@gmail.com>
Date: Thu, 11 Apr 2024 20:56:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 05/11] bpf: initialize/free array of
 btf_field(s).
To: Eduard Zingerman <eddyz87@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240410004150.2917641-1-thinker.li@gmail.com>
 <20240410004150.2917641-6-thinker.li@gmail.com>
 <57d016ec8ccb9cbc454f318d74b6d657de59ffcd.camel@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <57d016ec8ccb9cbc454f318d74b6d657de59ffcd.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/11/24 15:13, Eduard Zingerman wrote:
> On Tue, 2024-04-09 at 17:41 -0700, Kui-Feng Lee wrote:
> [...]
> 
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index f397ccdc6d4b..ee53dcd14bd4 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -390,6 +390,9 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
>>   
>>   static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
>>   {
>> +	u32 elem_size;
>> +	int i;
>> +
>>   	memset(addr, 0, field->size);
>>   
>>   	switch (field->type) {
>> @@ -400,6 +403,10 @@ static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
>>   		RB_CLEAR_NODE((struct rb_node *)addr);
>>   		break;
>>   	case BPF_LIST_HEAD:
>> +		elem_size = field->size / field->nelems;
>> +		for (i = 0; i < field->nelems; i++, addr += elem_size)
>> +			INIT_LIST_HEAD((struct list_head *)addr);
>> +		break;
> 
> In btf_find_datasec_var() nelem > 1 is allowed for the following types:
> - BPF_LIST_{NODE,HEAD}
> - BPF_KPTR_{REF,UNREF,PERCPU}:
> - BPF_RB_{NODE,ROOT}
> 
> Of these types bpf_obj_init_field() handles in a special way
> BPF_RB_NODE, BPF_LIST_HEAD and BPF_LIST_NODE.
> However, only BPF_LIST_HEAD handling is adjusted in this patch.
> Is there a reason to omit BPF_RB_NODE and BPF_LIST_NODE?

Declaring arrays of list nodes or rbtree nodes seems to be not useful
since they don't contain any useful information. Let me explain below.

We usually declare node fields in other struct types. I guess declaring
arrays of struct types containing node fields is what we actually want.
For example,

   struct foo {
      struct bpf_list_node node;
      ...
   };

   struct foo all_nodes[64];

However, the verifier doesn't look into fields of a outer struct type
except array fields handling by this patchset. In this case, a data
section, it doesn't look into foo even we declare a global variable of
struct foo. For example,

   struct foo gFoo;

gFoo would not work since the verifier doesn't follow gFoo and look into
struct foo.

So, I decided not to support rbtree nodes and list nodes.

However, there are a discussion about looking into fields of struct
types in an outer struct type. So, we will have another patchset to
implement it. Once we have it, we can support the case of gFoo and
all_nodes described earlier.


> 
>>   	case BPF_LIST_NODE:
>>   		INIT_LIST_HEAD((struct list_head *)addr);
>>   		break;
> 
> [...]
> 

