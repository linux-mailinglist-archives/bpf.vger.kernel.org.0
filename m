Return-Path: <bpf+bounces-20445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E5383E819
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 01:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A07286F12
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 00:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C4E38A;
	Sat, 27 Jan 2024 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPxIpRF5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCAB18E
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314542; cv=none; b=JRYbG1nPONh2BiCz1Z1vumwzZs1Fxd19xP66vICKADZy2IT/bdie8BGB2yfiqdzyWBfvywp8D3ehrXu25IovVgAYU6sEbaVugr+3wIv+yzVIcLFXpwlo0xb/D0DfO2bxeHLhIEhipYSA1y9gyykH8QyzIF9uuEQK3AeRKR6RjBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314542; c=relaxed/simple;
	bh=1+DGpH5AgXpH6KPlfQx7HRDdPmQ5b9yfEn5O7XlHHyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2dCqyABpBwivSxVnYg27q1kTayd0ZsdZZ38iW55DBjhZMn1w4fdnnK8go1WOU9vF7R+ay4gWU35D2lsOJtm2ZW6wt8zR6OarlcltG5JE2tBGcqbvZ+Cm+tkVamfw3cwCV4Joo2H2jNqbvcnP0N8LXWBMyflNaP4FVKMjsfmKng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPxIpRF5; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ff847429d4so14527357b3.1
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 16:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706314539; x=1706919339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JfA8d6yuWUrSX86fX6HRtFszdOR8uZBd959W1R9q+E=;
        b=mPxIpRF56leu7NIrtZ8WBTn9neHZEIwEuZ4bsr8q+wlIjjBI/W8nbp55K377MZfAW9
         6Sq8uIrbojGwb2Z60biT0ac5l6lYc/gTFvsZnAakmiT54IqB+QK5bapfBH6/WNKIR/75
         7Te7zJUR6hTzV6QAbwnY0nrBTpkSG8SmHWxPn+EbDEDeb0KYzMEM6LKvMkjG3HKmi8tA
         Z8SKfrmVwAQDSpj/hrf44se7ZdmkYfrbM3V7TeSX/VNq4GgiMhbckdS8y04dHx7Ogc6H
         dT6AfcrmRgBNIYReWo84xDXbYRiLEbsl0AHtfK5dUil4jWDslgTwxsbB7ZUbfmNXJYdm
         QWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706314539; x=1706919339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JfA8d6yuWUrSX86fX6HRtFszdOR8uZBd959W1R9q+E=;
        b=VC0pDoBeQ+2WzySVAJ4hMSGEcH7TE5talqMXplRU1luoEAIlf+j+M4L100SSu1heal
         4rsCtdL0C6Y5BC9Uo8e5ZdGgUvVhe5kEMqICr4bFKcHFLysQySJQGxAgUqZ3MxEfe1Hx
         t9QsE8b89Gb4QTphgY+FTT1qUCauS82yRTEIoip33QSOwszwwqumZhcy+IGUr6yNL/ve
         PByv7Ak3D0vZkDrx6GQpOKEY+h6z8TVP8UsTMoph7ZzZOziUcUx+jBDV0hKx0DJS1F/b
         14zpYbTc605jClLcCkfu2WgXd4yOOIh0QPvmCbDEzVmHsudgc4/WM7lOyWY/0uZPdhpa
         jTgQ==
X-Gm-Message-State: AOJu0YyFtP83GM7st+UABPv5NZW64FiBE2J04OcW+LaY4qBjhUoPAWsY
	3IKxKu/HRzIPuwQkUgr7r5yiNWHEGqjs79PyKIOf2yicNh3wWIhc
X-Google-Smtp-Source: AGHT+IHKYsERXqFIFnmRTB9HdpxdCVznZuR0r54tBLBD/w5d3iDv2lHC1JpGk2QK6OpyDf9sZ/+tFw==
X-Received: by 2002:a81:af5f:0:b0:5ff:6016:ecf with SMTP id x31-20020a81af5f000000b005ff60160ecfmr969887ywj.29.1706314539550;
        Fri, 26 Jan 2024 16:15:39 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:8f61:3de:99e1:36a? ([2600:1700:6cf8:1240:8f61:3de:99e1:36a])
        by smtp.gmail.com with ESMTPSA id y192-20020a81a1c9000000b00602ab11425csm735781ywg.81.2024.01.26.16.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 16:15:39 -0800 (PST)
Message-ID: <d8bedd40-cab8-4270-b4a4-1681c8d0e393@gmail.com>
Date: Fri, 26 Jan 2024 16:15:37 -0800
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
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 davemarchevsky@meta.com, dvernet@meta.com, kuifeng@meta.com
References: <20240122212217.1391878-1-thinker.li@gmail.com>
 <CAEf4BzbQJXGw3w0RnjuUg=RRMDE9jGgOYxVcA9q9hbYnvFBHhg@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzbQJXGw3w0RnjuUg=RRMDE9jGgOYxVcA9q9hbYnvFBHhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/26/24 15:21, Andrii Nakryiko wrote:
> On Mon, Jan 22, 2024 at 1:22 PM <thinker.li@gmail.com> wrote:
>>
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Allow passing a null pointer to the operators provided by a struct_ops
>> object. This is an RFC to collect feedbacks/opinions.
>>
>> The previous discussions against v1 came to the conclusion that the
>> developer should did it in ".is_valid_access". However, recently, kCFI for
>> struct_ops has been landed. We found it is possible to provide a generic
>> way to annotate arguments by adding a suffix after argument names of stub
>> functions. So, this RFC is resent to present the new idea.
>>
>> The function pointers that are passed to struct_ops operators (the function
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
>>
>> For nullable arguments, this patch sets an arg_info to label them with
>> PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL. This enforces the verifier to
>> check programs and ensure that they properly check the pointer. The
>> programs should check if the pointer is null before reading/writing the
>> pointed memory.
>>
>> The implementer of a struct_ops should annotate the arguments that can be
>> null. The implementer should define a stub function (empty) as a
>> placeholder for each defined operator. The name of a stub function should
>> be in the pattern "<st_op_type>_stub_<operator name>". For example, for
>> test_maybe_null of struct bpf_testmod_ops, it's stub function name should
>> be "bpf_testmod_ops_stub_test_maybe_null". You mark an argument nullable by
>> suffixing the argument name with "__nullable" at the stub function.  Here
>> is the example in bpf_testmod.c.
>>
>>    static int bpf_testmod_ops_stub_test_maybe_null(int dummy, struct
>>                  task_struct *task__nullable)
> 
> let's keep this consistent with __arg_nullable/__arg_maybe_null? ([0])
> I'd very much prefer __arg_nullable and __nullable vs
> __arg_maybe_null/__maybe_null, but Alexei didn't like the naming when
> I posted v1.
> 
> But in any case, I think it helps to keep similar concepts named
> similarly, right?
> 
>    [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240125205510.3642094-6-andrii@kernel.org/

Let me paraphrase it. "__arg_maybe_null" is prefered for the case here.

> 
>>    {
>>            return 0;
>>    }
>>
>> This means that the argument 1 (2nd) of bpf_testmod_ops->test_maybe_null,
>> which is a function pointer that can be null. With this annotation, the
>> verifier will understand how to check programs using this arguments.  A BPF
>> program that implement test_maybe_null should check the pointer to make
>> sure it is not null before using it. For example,
>>
>>    if (task__nullable)
>>        save_tgid = task__nullable->tgid
>>
>> Without the check, the verifier will reject the program.
>>
>> Since we already has stub functions for kCFI, we just reuse these stub
>> functions with the naming convention mentioned earlier. These stub
>> functions with the naming convention is only required if there are nullable
>> arguments to annotate. For functions without nullable arguments, stub
>> functions are not necessary for the purpose of this patch.
>>
>> ---
>>
> 
> [...]

