Return-Path: <bpf+bounces-57866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44193AB19A0
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 18:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DACC1C46E5A
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 16:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A5E23816C;
	Fri,  9 May 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5trM1HW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F5923717C
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806190; cv=none; b=rv/jBmmV6/zjsaoWLT8o8ypo7AXQxaHz61fNkFu3n+d3yuaXiFiwt7r5jlNonW0SrX1tm2bB0SbeoDffCbZwUjCqZ1nBFM4QrRAasxiz+U1pKATuRz2Pt7c2Udfux5pX9SaC/lS/1ihUb+k71IndjLG7KKIk+1t2oU01BhjuXGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806190; c=relaxed/simple;
	bh=toQ0izLjd3KoLHQ1nb5euO8tlhB0Y7zwJdW6OtL+y/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJqkvwCGq7RWyYxxObpl24qDdtXDc6KM/ZCL1jqO+f+W43oGGeUwRD8rW1pDOCSINTxCBJtp3r4fQivc5GtJ639d4Np8boEhsZbpbNuwq8/XT8gWPlBQm4S9qOC9U5Gsa1KI2xPVedaly9DssPaNmPGoRyqA/TmtBS4fG+RZcRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5trM1HW; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so16090935e9.2
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 08:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746806187; x=1747410987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ij6ZxnWBkNZ65kXSvVfAED///U7FgxvxQwASSJ74PCY=;
        b=O5trM1HWEvmRPb6a7NUkgYKEg9hJr3ND+MofTGrMLTyMYf49LWfrKZ0I3z6zj+qcWo
         IOIR39QxWd6snCxACuCJe5/DBzeCiJoOKmqk3/2lJBFD0jTH9Z0fWSH7PRKXjF5nX+2Y
         eGAqnPlShqBcC9P4pr1Cs79YeMQNUqE1W7n0RW4s6qieBSiMqGLLSY8qzFZVcwk5UUlJ
         dK4AkUarDBhM8x8n7dm7Ux/U5CU/8PoXIhF9AcCs2x+yAAznQWtBhI7ewVcLYH6lhoOJ
         zISzswG+T8s0olx+GY+JfFbHJDwOqZsfDnsWfv6EThIuNY5QZi0VCIAjLF1ugw5PEF+o
         8/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746806187; x=1747410987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij6ZxnWBkNZ65kXSvVfAED///U7FgxvxQwASSJ74PCY=;
        b=J2LBJl4un2cI8v0xMrxi13fLssbbJvInQEbtXy3dibB3W8L8TSjEaXj0VvuNWT9BMF
         JuNVq0plEsXn0IgwowLeH6wS8ci4qEYjjha4NbqVvNRy6iOWUed5dZ+qkB+g/2kNT/vl
         63fPmptyt3VT5lm3LArJY2f7tRYRQE3IwN+cYxo5Ke2Wiffpk70tg5gPfzWF3PaA4GDC
         GCM/PMquac9a3W853cQM7fKFO5zh+O/YEZLMaR2DSK4fKPunAcOcUtweia2GtOGvPYzu
         tPFeXrWYAw+ObAWI2PSr1pCkfQ7CMlIz2U6mZuzOl538M8FWOka+bq2000w/J8QliocC
         rqXA==
X-Gm-Message-State: AOJu0Yy6lz604gVBLRE805L6VPuYO2mHE6aeGYOOFbVVWncXZSjmnG09
	8Ys2C2irdhuraBpHwEtqyQfLXPijj/7zDrPwDzJ6qF27wfaxPEGN
X-Gm-Gg: ASbGncvH7rLmkPj6NXBoBJRj0Mg/1sroE9oRZOA3mqRkLqQE7DwTYIXyv9W6J1l6Ylo
	PMN37I6hvcsEmQppT2r9RP3H8q2IjfZVlqMHGwIZTHEDPKnxLoUf3MJJUqnSz26180S2kiIJZR+
	YsgqCqAmSbqBgoFq1Zn+PbCmmFcCvuZsvnFPHw8enVEupIIy7ptfAdT72HqwK9eB0gUIcHoPCTP
	H/iwzw4byfB7xjanfIwdJUT5DyusNzlqdcULzjlJD5h/6lrZzlj5lpKIIiBN/xNOFa/7/MHGGVT
	0c9EScuFsb2MxZGmoCHcF55hEkh3R7zvnhgIquR/ZiyTy2tyQsnmuJNJ61IcYU1KWSEUVMTS6/j
	DUjqAOHbCbt1O+3/i1+sc0A==
X-Google-Smtp-Source: AGHT+IFrysN4zf2y07hsD+cPQOSvFTR2zf9bCpW+T8+2hUglQXzoFeX/KxY/e6wbT8Hmkjt92M3HtA==
X-Received: by 2002:a05:600c:3482:b0:43d:7588:6688 with SMTP id 5b1f17b1804b1-442d6d1fb46mr39441005e9.12.1746806187000;
        Fri, 09 May 2025 08:56:27 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10? ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd34bd79sm75297465e9.23.2025.05.09.08.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 08:56:26 -0700 (PDT)
Message-ID: <fafb2a02-effb-4099-ae9d-eba68375ca40@gmail.com>
Date: Fri, 9 May 2025 16:56:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/3] bpf: implement dynptr copy kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250508220624.255537-1-mykyta.yatsenko5@gmail.com>
 <20250508220624.255537-3-mykyta.yatsenko5@gmail.com>
 <CAADnVQK3oXfVtKR-SM07N3+-AtoU+Khcvu_HLv6QXkO6hthgvg@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQK3oXfVtKR-SM07N3+-AtoU+Khcvu_HLv6QXkO6hthgvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/9/25 16:50, Alexei Starovoitov wrote:
> On Thu, May 8, 2025 at 3:06 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> +static __always_inline int __bpf_dynptr_copy_str(struct bpf_dynptr *dptr, u32 doff, u32 size,
>> +                                                const void __user *unsafe_src,
>> +                                                copy_fn_t str_copy_fn,
>> +                                                struct task_struct *tsk)
>> +{
> ...
>> +__bpf_kfunc int bpf_copy_from_user_task_str_dynptr(struct bpf_dynptr *dptr, u32 off,
>> +                                                  u32 size, const void *unsafe_ptr__ign,
>> +                                                  struct task_struct *tsk)
>> +{
>> +       return __bpf_dynptr_copy_str(dptr, off, size, unsafe_ptr__ign,
>> +                                    copy_user_str_sleepable, tsk);
>> +}
> CI is not happy about implicit cast that changes address spaces:
>
> ../kernel/trace/bpf_trace.c:3702:55: warning: incorrect type in
> argument 4 (different address spaces)
> ../kernel/trace/bpf_trace.c:3702:55:    expected void const [noderef]
> __user *unsafe_src
> ../kernel/trace/bpf_trace.c:3702:55:    got void const *unsafe_ptr__ign
>
> Please use gcc 14 or higher or sparse to see them.
>
> Probably __bpf_dynptr_copy_str() shouldn't have __user qualifier,
> but bpf_copy_from_user_task_str_dynptr() should have __user next to
> unsafe_ptr__ign,
> and everywhere we kfunc has __user it can case to (const void *) before
> calling __bpf_dynptr_copy_str().
I'll check it, thanks.



