Return-Path: <bpf+bounces-29552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C3A8C2C96
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 00:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29A51F232B8
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 22:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC8713D24D;
	Fri, 10 May 2024 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ylo4E2x2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BBC13CFBC
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379961; cv=none; b=BrfjGk1pjicCp6qQ/p0Nm3JOWtD+HXaBX7MZfVHrJbjSMWm2apid2n8D1te4CdsKQ6k4o8LU9Dw9DEB8H5K92Sg98DlWQS7Nn7BzWRhXwG/jsd8hWKeIwmALxS31a0D17EecdoXEDCl/vDleuDVGqzNci4pUMMdDAi+7Ywaha+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379961; c=relaxed/simple;
	bh=Ol0dNeh34tRcqJ50H6YfXszEAP6Uz39t4tUhbbcPqKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGoT5csHc45EhE2ImzS3zgn7w+1iWxULmcaGD7UsySxSudOX7Z05MogqgYGtDnzTYjd5JW0TnauKJXcDFZOmch5L3bEED9NAiO+FZZJPNvx9rQDRS40yE5hvosp1jTeJLuRJpHiKI/aBpga+0DRZqdcp5fepmMmPsfoIaXn2wQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ylo4E2x2; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-23dd4dca5dbso980365fac.0
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 15:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715379959; x=1715984759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=brhYJRu6U4qjY5njd8xSk5CnZ+fqHH5gd7NqtWQ9MXQ=;
        b=Ylo4E2x25YmRtLDDNs0rDbMpBnE3MV2ShUWyZH3dkXH8ERFtfThsJ5rahZuZAo8r+k
         XJu8KITUkX7CFyTEP35pgWkZ+8KMtn0BYnBB+bacRRJJf84DujSwac+++68Nr83yHB/Z
         Q8uwKpoAhTcoyBwYxN5hRdBhAwyCASJLf+/Qiaf0bvBKOFAj5xSBSTV8UqPi0AYSPSmt
         Q8gUdDZicGzM1lrpNk24l/0YHrJ8c3D4LUwr7s57g/jMlEor31SnLCxxr6KLlSB0mZ/m
         0E3ScM0rvxaZpxThzh5ogqkICy7eEOftYOx2DbIXGZk/B08LxoDk93hqIUV0sQEn58X7
         Dmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715379959; x=1715984759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brhYJRu6U4qjY5njd8xSk5CnZ+fqHH5gd7NqtWQ9MXQ=;
        b=gMC0qpmz+kZzH+XVeb/zkkEZVMWxvMSPjwZ7qVPFsF4e3S3IgsvmkAnIkRJjUCfNZ4
         2w+vqBMMUTCbuGU/I5cbS/u0jsycI11QUeyjvllH8lHG4hc34mVS36TA8sZkt0dWWQIN
         69jBQMKeDKL2IKqAFcPbO49zwkIDOAvpdgJJJyWqk/qb7wRM73EvgqhLooj2llK5xxjO
         gRguIST8d497pDgzzbm1DKWY6Uf3cOcoHxBeZwJnajpFEbaQhRvG3abr8J0AnZqVJRiz
         vlfSWferCAyNNTkI69K4heJEUtjbG+oawXKnzexBwAJu8XR4GF9czZK8KYb739wwa0UY
         69hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXqKvH/u3kZsS/9JfPnXJ2IV01YN3dqozylJUbr+dJQMRh6Ov7PUkrtsk9iBg6ycfqg+4I7iEk3ZFsg/FYw42OjEv2
X-Gm-Message-State: AOJu0YyR3HQcXmV1K407/LndQegie/EEH9dNFNbPp7znq+hXZHfwKQVp
	KCf3nHFE9xyPbDmy1ffSiCBAepvnF/hM3D5/mdca3SCM2AdGttxS
X-Google-Smtp-Source: AGHT+IFNGxIulhVRZIR1U26eOjncB2TFBlkeFlMzjyUpUIoRZIgZgj2GUY60pqZmBogxH1JP5ojf+A==
X-Received: by 2002:a05:6870:15d6:b0:23e:b5a4:d3f8 with SMTP id 586e51a60fabf-2417173019bmr2105908fac.2.1715379959004;
        Fri, 10 May 2024 15:25:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:20fd:6927:f7be:d222? ([2600:1700:6cf8:1240:20fd:6927:f7be:d222])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412a62053asm1030158fac.21.2024.05.10.15.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 15:25:58 -0700 (PDT)
Message-ID: <aa0cb7c8-f057-4f51-84c4-2cc9bc4e2edb@gmail.com>
Date: Fri, 10 May 2024 15:25:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 7/9] selftests/bpf: Test kptr arrays and kptrs
 in nested struct fields.
To: Eduard Zingerman <eddyz87@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240510011312.1488046-1-thinker.li@gmail.com>
 <20240510011312.1488046-8-thinker.li@gmail.com>
 <d8f2fa21a9af5bfcb2acb1addecea435285c40e6.camel@gmail.com>
 <d2b9a943-ca26-404d-899a-c7651ce18a42@gmail.com>
 <62a51fcaddbf5eb8552a96e6a24ded83f8f9fa49.camel@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <62a51fcaddbf5eb8552a96e6a24ded83f8f9fa49.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/10/24 15:08, Eduard Zingerman wrote:
> On Fri, 2024-05-10 at 14:59 -0700, Kui-Feng Lee wrote:
>>
>> For the sake of completeness, would it be possible to create a test
>>> case where there are several struct arrays following each other?
>>> E.g. as below:
>>>
>>> struct foo {
>>>     ... __kptr *a;
>>>     ... __kptr *b;
>>> }
>>>
>>> struct bar {
>>>     ... __kptr *c;
>>> }
>>>
>>> struct {
>>>     struct foo foos[3];
>>>     struct bar bars[2];
>>> }
>>>
>>> Just to check that offset is propagated correctly.
>>
>> Sure!
> 
> Great, thank you
> 
>>> Also, in the tests below you check that a pointer to some object could
>>> be put into an array at different indexes. Tbh, I find it not very
>>> interesting if we want to check that offsets are correct.
>>> Would it be possible to create an array of object kptrs,
>>> put specific references at specific indexes and somehow check which
>>> object ended up where? (not necessarily 'bpf_cpumask').
>>
>> Do you mean checking index in the way like the following code?
>>
>>    if (array[0] != ref0 || array[1] != ref1 || array[2] != ref2 ....)
>>      return err;
> 
> Probably, but I'd need your help here.
> There goal is to verify that offsets of __kptr's in the 'info' array
> had been set correctly. Where is this information is used later on?
> E.g. I'd like to trigger some action that "touches" __kptr at index N
> and verify that all others had not been "touched".
> But this "touch" action has to use offset stored in the 'info'.


They are used for verifying the offset of instructions.
Let's assume we have an array of size 10.
Then, we have 10 infos with 10 different offsets.
And, we have a program includes one instruction for each element, 10 in
total, to access the corresponding element.
Each instruction has an offset different from others, generated by the 
compiler. That means the verifier will fail to find an info for some of
instructions if there is one or more info having wrong offset.



> 
> [...]

