Return-Path: <bpf+bounces-30406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D54EA8CD8CF
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 19:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75DF61F22F02
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 17:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B0346542;
	Thu, 23 May 2024 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK9wc3II"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502736B17
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716483599; cv=none; b=pU5gDF8gVzkBAJJA9iUh2P2YiBq5ZCWY/i+n6lTYdpE8TjUYrwk+wZTlTWnXj/wiQAuTJCQ+h25ArfKLLSGwpRdb0QVMtILQyW8IYib/d9NiStnOq/4fgAYF5NQO9wTMm/PyAbwRU2usQgf1RkNiYKmWR2MTfZbYWOA+DF9XDyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716483599; c=relaxed/simple;
	bh=gOgOmTkkIJy6lqHvzga+6F6zpf2lfS67kxr4EJU3ZE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fb3VWULwf38Eav+QUl03RlRZIRZVTcO9kMOaoWZo3FHh/2eES1ckPi372pr0+dGxh53CooCMv4MyyR4CqdUSnB5cASxkbR7FtQoKX7g7KueWOvWWibU3D1JFMF4VmW+mUXEC8fDQRi8BXVbaP0sPV9yV+WnydhBmg+MRXnjZwec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GK9wc3II; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-627ebbefd85so22727967b3.3
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716483597; x=1717088397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MdEjA0wtjx2J9kToVBrsZrk21/Xho10Ws3Ob2hRmyg8=;
        b=GK9wc3II6lYMLPjF8Bp1B38OLSiBqbn53r2qRjANxwHXsLfPDtIn8iptep/vWA45MY
         qGtvlO5GqhtH7if3uX0Qw/pPbkeLo8T3n1ieNsvBzsqiWwcr/15wgclLj2qp97fYdkhu
         dOep61M8NoKYdhywpdRFU9Z25O7R6HMlMSo4cndudZAAxoBQXmEoP6m2KFKINAA16fbU
         jgySOhBmgbQGoBLv9HtWBBTFrCAr6rM4tB7ZxIIVtdsjGkGY8ZvPTZMSYoZLHprcmnf7
         ZgusMEpllcbA2oULH8DrmY7y1pVQuE5SwJ23sNMJl0vCmAjG2XD1CIvLdZtGo1DDixQ9
         4vYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716483597; x=1717088397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdEjA0wtjx2J9kToVBrsZrk21/Xho10Ws3Ob2hRmyg8=;
        b=w0tHanKdCugEnOhsJq+phJC1+jzuS37eLH4c7NslcHdWEYSAXXt2RRTXYmK5G+R3Ut
         TJVacKChzGvhIm9JoLUYjzAcACeuaTWkYQ4ukkh+EHm3z0/+Ows6QG2b1IPNnkciPNBO
         9Ym2RF/t4q4NVqb4bzfdm9peu9ps+s4srGJzMNXAFx8XDF9m0nLFOHore3oAmMF2jZJn
         1hIDnPYvyIF9EclCfauwuJUebU/mBCExtb1pn4ZMyXLPzGdU9ZGsFR/v7Fp4wgggUxYp
         Vns3PDEq0dFoTwDPQz6fWZTMOg7xZrOUaa13hnzbEf7q5EC5Qg39KJZ8HafNFQNLDTFd
         Jxvg==
X-Forwarded-Encrypted: i=1; AJvYcCV0Uo250YEQk/wQyPBYyHSyR6nz2Vux8L0XXkTaPQCa8ZqkHj8qVIouHrOr52HUrMFnxcJsz4LN/laYvK7bYNR/48YD
X-Gm-Message-State: AOJu0YyoWpnBeyzrBvPyoBME/7eY9Sg1XFA3FWdH9AV77p6rdSOBh0yh
	bhzUVpItkr7oOXY6+u6VgZzWjIfBWxsRzRYAF/oSuUybeUnFEfuq
X-Google-Smtp-Source: AGHT+IHzHVtm7R23igAeORmoFPSm2dmoH3V4z1XbwWKGwW9unEW5ldkHOxTp/RsD4Z7hbv3IN/RuAg==
X-Received: by 2002:a81:6057:0:b0:61a:e856:85f1 with SMTP id 00721157ae682-627e46b2289mr51876357b3.13.1716483597346;
        Thu, 23 May 2024 09:59:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:a2b5:fcfb:857c:2908? ([2600:1700:6cf8:1240:a2b5:fcfb:857c:2908])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-627ecfa545csm5742697b3.4.2024.05.23.09.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 09:59:56 -0700 (PDT)
Message-ID: <717622d5-0005-495b-8f06-85009e223429@gmail.com>
Date: Thu, 23 May 2024 09:59:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 5/9] bpf: look into the types of the fields of
 a struct type recursively.
To: Eduard Zingerman <eddyz87@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240520204018.884515-1-thinker.li@gmail.com>
 <20240520204018.884515-6-thinker.li@gmail.com>
 <6266baf6b48afb63df4789cb932dfee713029988.camel@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <6266baf6b48afb63df4789cb932dfee713029988.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/21/24 11:12, Eduard Zingerman wrote:
> On Mon, 2024-05-20 at 13:40 -0700, Kui-Feng Lee wrote:
>> The verifier has field information for specific special types, such as
>> kptr, rbtree root, and list head. These types are handled
>> differently. However, we did not previously examine the types of fields of
>> a struct type variable. Field information records were not generated for
>> the kptrs, rbtree roots, and linked_list heads that are not located at the
>> outermost struct type of a variable.
>>
>> For example,
>>
>>    struct A {
>>      struct task_struct __kptr * task;
>>    };
>>
>>    struct B {
>>      struct A mem_a;
>>    }
>>
>>    struct B var_b;
>>
>> It did not examine "struct A" so as not to generate field information for
>> the kptr in "struct A" for "var_b".
>>
>> This patch enables BPF programs to define fields of these special types in
>> a struct type other than the direct type of a variable or in a struct type
>> that is the type of a field in the value type of a map.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]
> 
>> +	/* Look into variables of struct types */
>> +	if ((field_type == BPF_KPTR_REF || !field_type) &&
>> +	    __btf_type_is_struct(var_type)) {
> 
> This code would have looked nicer (handled inside the same switch as
> all other branches) if we had BPF_NESTED_FIELD in `btf_field_type` or
> something like that. But that's probably be an overkill.

After thinking twice, I will change btf_get_field_type() to return 
BPF_KPTR_REF only if the type is not struct.

> 
>> +		sz = var_type->size;
>> +		if (expected_size && expected_size != sz * nelems)
>> +			return 0;
>> +		ret = btf_find_nested_struct(btf, var_type, off, nelems, field_mask,
>> +					     &info[0], info_cnt);
>> +		return ret;
>> +	}
> 
> [...]

