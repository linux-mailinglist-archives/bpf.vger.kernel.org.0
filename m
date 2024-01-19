Return-Path: <bpf+bounces-19903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7212D832F0D
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 19:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CCA31C20FAC
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 18:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0E9433CB;
	Fri, 19 Jan 2024 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoQUjFyu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576361D53A
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705689784; cv=none; b=A50MVFvIX3G9jf6Hae+YFxMrDv2YUbaJQJiYQBYpNsDlunxKu2I5duzVBhmp2jZ+/Yp3Ab17uaBoF9s6Xt87Yu5ZqVeoRNz0H4YHWjPGOPHOTcYOAGAdWx0GtIQu74HqDh04S3NaQrOQSijoFYihq3g5L64XEXQK4HIBMp1osso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705689784; c=relaxed/simple;
	bh=joaCkUqvPoHWcbBHDUk18eHeYcw+hcPTpoly+aq/Xyk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DPcZiXkCsxSB+9bQj9cwltepeNt8a/XxUszrET8C93BdlC7N6cxIlfjEnBB2fw6tCljvyx2XScsnPiohyq3Y/WkVm+47j/uT6aLulrffUPlNOdbpoxq7SrywV75PTUWtYiKI437nMGhJ/3omXKOWi6eXHA8JLN/EGniHaSKDpac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoQUjFyu; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5ebca94cf74so10894497b3.0
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 10:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705689782; x=1706294582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQrjbHerSMAZg4jXXs3Lw91uDFa2jgswe4OfAAYbdLs=;
        b=hoQUjFyugvJEnHKAGKaf1SKUCMRKcW1hYVvryQo5JiuqGYpZKGlaPsQUznod0rhNUV
         EZx8zZLHW1QNISMChvV9kzaAHAX48ojRxEHEaLUdOI7qIaw/MixEwml9TiaIJftvxzzr
         mSJvTUG2toZVbtuUeRVTDb+3z9Le32PJnJmgZEZNlmukZa37HLWnx1FVq8xewi6HHsFP
         ib1UZGwxLeJC9X/cibtPeGe3FOjHX7v1RSPIvbe7WyI6oyGtfRvedlSluHAs4LtLnRoz
         dSz6nz828/IszTI5qkXS5iEa429Kkvcwn2XNrq5VVQD3Vnt/unFXudFGhMDt2oU6pBhz
         l11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705689782; x=1706294582;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQrjbHerSMAZg4jXXs3Lw91uDFa2jgswe4OfAAYbdLs=;
        b=vBOOmzv6w0/5XeyIBWVa/bx4yBe2F5/Si3bfXMTbqdHv+i8kD+/3/L2RlKH/uElSHd
         OV1N+c1wqlFDWqxyQAe1AOoJwsWB1lQWC3qy38ERvelBBxNqRZxSZTldsFnMPUVHYhZ+
         ATQSQ7o/JtbjScX/HogPkKKUs4cHSvufZSqz/+CbILhi5ajcZczLvST7ToxkdzSNRMkB
         qARzgSmkzKcCtyH+UjrChhj/NqakJnGmt6pufdQ1tJ79LdOzzmdvfmjOVVSdjWnnpXQx
         se8DVjX3PZoEAgRFvmFm1u9FFxwsexL+f0YD+hdcNlpF0uCTleKSxhH8zOoa7h1ji9tx
         9z4Q==
X-Gm-Message-State: AOJu0Yy2unGD4HpICAQd7lP6kuomq5QTeVRJfAAmbI+z5Wxe2LknHZWp
	aOP02sOJtbM74yi6Qp5k5WLa8suLyWdv3OsYvP0sLog0W0ea3DZ7
X-Google-Smtp-Source: AGHT+IHA+sWS4M1etjy5jYWKTHgLAR5x5NU5AN5QNlZZRd4T9PEiHhEE98RzXdCW5au7FFqvSEK1vg==
X-Received: by 2002:a0d:e742:0:b0:5fb:9947:6bfd with SMTP id q63-20020a0de742000000b005fb99476bfdmr310058ywe.85.1705689782241;
        Fri, 19 Jan 2024 10:43:02 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:c63b:9436:82f0:e71a? ([2600:1700:6cf8:1240:c63b:9436:82f0:e71a])
        by smtp.gmail.com with ESMTPSA id z19-20020a81c213000000b005ff7f3a9c0dsm1722254ywc.119.2024.01.19.10.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 10:43:01 -0800 (PST)
Message-ID: <d27d0f88-1fa9-485d-ba1e-1c5c72c8460b@gmail.com>
Date: Fri, 19 Jan 2024 10:43:00 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v16 08/14] bpf: pass attached BTF to the
 bpf_struct_ops subsystem
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20240118014930.1992551-1-thinker.li@gmail.com>
 <20240118014930.1992551-9-thinker.li@gmail.com>
 <c8ff1275-fbc2-4117-9f40-59072e129426@linux.dev>
 <cce556a9-ca52-4dcb-8d3f-46f363162cac@gmail.com>
In-Reply-To: <cce556a9-ca52-4dcb-8d3f-46f363162cac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/19/24 10:05, Kui-Feng Lee wrote:
> 
> 
> On 1/18/24 13:56, Martin KaFai Lau wrote:
>> On 1/17/24 5:49 PM, thinker.li@gmail.com wrote:
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 0744a1f194fa..ff41f7736618 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -20234,6 +20234,7 @@ static int check_struct_ops_btf_id(struct 
>>> bpf_verifier_env *env)
>>>       const struct btf_member *member;
>>>       struct bpf_prog *prog = env->prog;
>>>       u32 btf_id, member_idx;
>>> +    struct btf *btf;
>>>       const char *mname;
>>>       if (!prog->gpl_compatible) {
>>> @@ -20241,8 +20242,10 @@ static int check_struct_ops_btf_id(struct 
>>> bpf_verifier_env *env)
>>>           return -EINVAL;
>>>       }
>>> +    btf = prog->aux->attach_btf ?: bpf_get_btf_vmlinux();
>>> +
>>
>> just "btf = prog->aux->attach_btf;" which was assigned to 
>> bpf_get_btf_vmlinux() for the non-module case. Take a look at 
>> bpf_prog_load() in syscall.c
> 
> You are right. I have been too protective here.

Just try to remove it. The test case libbpf_probe_prog_types crashes
the kernel for attach_btf is null. It sets neither attach_btf_id nor 
attach_prog_fd.


