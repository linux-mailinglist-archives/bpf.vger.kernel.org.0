Return-Path: <bpf+bounces-20444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9989383E7F5
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 01:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0D61C231C5
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 00:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BCE639;
	Sat, 27 Jan 2024 00:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URTO2iNB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB08F67C48
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 00:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314101; cv=none; b=G1xIeBR7TmG38kw/6qrfMguqP0c/WU7Rn6Ol/kw4Y84Dn09KXOO7eS19+2V8pz1x4VEJwk7pyylj7rWR8TmqaQ30IpQQ2mReP318HMgiNCTBT62deEbgfK5m+zuOdZ4goWdS6HbRv9/TviJYf+JTQNyMFebA9EPeXPPG+CzOV8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314101; c=relaxed/simple;
	bh=ZsXbABCEXuFIPIRO6Vubf+rkVEVk3s+epIP1dCs5zVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwLUuKl6qIZDwRoTLwxnKvexSBlutAQzQWTn+kEDRVrhwZerhlcLNJCxy2GTT1J2t5BNW9mjtXtS3kfPl72KZxf8kWOf/K9d1aUBttCwPctpPpP0Rox8IkwxP6rI5/0GHj75Np/dwTZKRYX1KYNHbz+z3akN+3sxXzq8rwotdN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URTO2iNB; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5ff7ec8772dso13856517b3.0
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 16:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706314099; x=1706918899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1KYklfnpQKq/UTF0ATOmfMGhss8WrjSWrpoMFP/JX4=;
        b=URTO2iNBGMvTq9wIQBQH+j36waQBIBE4sGhXz1QIn7gmzKQn5RcuqPHwMazJdq58me
         WpYHVoOG2vJAfg5dTHK5k6usIjMDXTxAGaG2m8gTLUAJ4jEaFHJEu27jsBoBnG/whMv8
         Xfoec3tJYJDeFVkkATlNqrFzlX0u53POW2qWhFZ8eFyvNnwoR1DCv4UfSdVp71KFWSbB
         jLhYXJMALHr+9rN066R/ngb7QMm/FdwMfNBYDEZRBKSmYPSvrJhoXk1VGT90eX7Tdo1s
         Nw8GSzJDx4z21Sk46/8+fOsvWe4CiNuLmxwIC6mWjKMkc0BDPJ4JO4yrT3yLXYLGY8lV
         VMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706314099; x=1706918899;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1KYklfnpQKq/UTF0ATOmfMGhss8WrjSWrpoMFP/JX4=;
        b=I2iKlHmq3ROT8ogW1HHxa70t0P25zAIPma4MlpUEffPLYnKJ1oIe9E3ubnSqnJmZ5L
         aH25lZ+yW+gLpCzN5+ISOWr5Sw6j2EMnvrUwwHJUPCDMeQclUYTKwOp1AM5Q904mcADq
         YsFK+hc9CC8QC8ouBbmA3sd16EBohOVZR/nFj60fxDbeJ0gRvHsTkqmz5/bV4JTVRyQL
         jq1cmi84tJOfvXlLZou2mtilVkB2M/OA2jewd4/lNSlP0RcnCmPbo0WTzEkX9vQGa9d2
         zvgRFc5g9iBm/EFpx2r3pjmVgmfGNy1+bj+IKpYGVdcHW0me7QyMFwXYRPZlidaz7haJ
         f3Qg==
X-Gm-Message-State: AOJu0YwJy8jEwa7FxQgDbIo3x70mYLQEwdNwZBkatLvBKCncxr4WwfRE
	Zp/3L3+YAzHCmRR3Js28DOQTO8c5NQhsysRRux2V5WufdacL/+JA
X-Google-Smtp-Source: AGHT+IGPt0qNxNn6gpGlKstQ7FdNWF517hKHohjgt37uD00xJUDYxxsUrOPrOqviwggrmU2oBFDHnw==
X-Received: by 2002:a81:4e54:0:b0:5d7:1941:ab4 with SMTP id c81-20020a814e54000000b005d719410ab4mr655319ywb.79.1706314098735;
        Fri, 26 Jan 2024 16:08:18 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:8f61:3de:99e1:36a? ([2600:1700:6cf8:1240:8f61:3de:99e1:36a])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05690c031600b005ff9c1373ddsm718818ywb.88.2024.01.26.16.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 16:07:47 -0800 (PST)
Message-ID: <21bc447a-9ab6-4233-8bf4-09441b83203b@gmail.com>
Date: Fri, 26 Jan 2024 16:07:27 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next v3] bpf, selftests/bpf: Support PTR_MAYBE_NULL for
 struct_ops arguments.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, davemarchevsky@meta.com,
 dvernet@meta.com
References: <20240122212217.1391878-1-thinker.li@gmail.com>
 <c62b94dc-cc23-4fd2-b86a-ca30786854ba@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <c62b94dc-cc23-4fd2-b86a-ca30786854ba@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/26/24 15:05, Martin KaFai Lau wrote:
> On 1/22/24 1:22 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Allow passing a null pointer to the operators provided by a struct_ops
>> object. This is an RFC to collect feedbacks/opinions.
>>
>> The previous discussions against v1 came to the conclusion that the
>> developer should did it in ".is_valid_access". However, recently, kCFI 
>> for
>> struct_ops has been landed. We found it is possible to provide a generic
>> way to annotate arguments by adding a suffix after argument names of stub
>> functions. So, this RFC is resent to present the new idea.
>>
>> The function pointers that are passed to struct_ops operators (the 
>> function
>> pointers) are always considered reliable until now. They cannot be
>> null. However, in certain scenarios, it should be possible to pass null
>> pointers to these operators. For instance, sched_ext may pass a null
>> pointer in the struct task type to an operator that is provided by its
>> struct_ops objects.
>>
>> The proposed solution here is to add PTR_MAYBE_NULL annotations to
>> arguments and create instances of struct bpf_ctx_arg_aux (arg_info) for
>> these arguments. These arg_infos will be installed at
>> prog->aux->ctx_arg_info and will be checked by the BPF verifier when
>> loading the programs. When a struct_ops program accesses arguments in the
>> ctx, the verifier will call btf_ctx_access() (through
>> bpf_verifier_ops->is_valid_access) to verify the access. btf_ctx_access()
>> will check arg_info and use the information of the matched arg_info to
>> properly set reg_type.
> 
> 
> 
>>
>> For nullable arguments, this patch sets an arg_info to label them with
>> PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL. This enforces the 
>> verifier to
>> check programs and ensure that they properly check the pointer. The
>> programs should check if the pointer is null before reading/writing the
>> pointed memory.
>>
>> The implementer of a struct_ops should annotate the arguments that can be
>> null. The implementer should define a stub function (empty) as a
>> placeholder for each defined operator. The name of a stub function should
>> be in the pattern "<st_op_type>_stub_<operator name>". For example, for
>> test_maybe_null of struct bpf_testmod_ops, it's stub function name should
>> be "bpf_testmod_ops_stub_test_maybe_null". You mark an argument 
>> nullable by
>> suffixing the argument name with "__nullable" at the stub function.  Here
>> is the example in bpf_testmod.c.
> 
> Neat idea to reuse the cfi stub. Some high level comments.
> 
> bpf_struct_ops_desc_init is also collecting the details of each 
> func_proto member. Check if this "__nullable" collection can be done in 
> the same loop.

It is a good idea.

> 
> Simplify the implementation of the member_arg_info allocations. There is 
> no need to compact everything in one continuous memory.
> 

Sure

