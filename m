Return-Path: <bpf+bounces-56734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740F1A9D3C6
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 23:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F869C3D53
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 21:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A1621E086;
	Fri, 25 Apr 2025 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUeNE4rZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3A020E710
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745614993; cv=none; b=fiNhSDwIhC9jMXgxR+lpfPi7mo4Shyf/XCqw75qp5xvraXO1ofOWlc/IMJbMAiuQST70P5OH4+vuvZPnAHwJq6P8oEAtv/kiP3J6bY5RWT8DXq6/gyWtqimsPWg9jGNbdAs/yIiIlNazmBvQX3NR6cpcwLpcRuhE1QWYkpaNzsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745614993; c=relaxed/simple;
	bh=Yy8BW95WFfRhpcavQ9oRCdBPtm4ebERxPhr1rO/Kqjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKfEi6+fMwlb1cUg3uh8Z3eWYseXjYrTRSNh3oERCSal4rlcJMR3l3FDijg3aNU1NddRqTirhXFMALADuwe5xGEExGpHQ+lkWgJ4zY/0Cd4u6PObwBVc5P2XYcp3JmPzKrjJ9qm3gbLoJmSwlLW8AeDnWoOZuATf+WjQR9sgjtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUeNE4rZ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5f62ef3c383so5113496a12.2
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 14:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745614988; x=1746219788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SNTEeX6DPBZRIn/ZzBonF2xns5W9UBXy7LugHu3uk70=;
        b=DUeNE4rZZbDN5k9nl45xIcyHuEV/LGpgy3qhaHQG35nHRHPqW1Skh47xPyVaDpjXZY
         PtE/sndtci+IP6nIjoCnWsti3oI5ujP/Xv25tgNSBGZmR4rW4PfY9ASd9jSZjAdvY+9K
         qGXMP141S/nO+q/n3XvSlyCa6ApO8QF1qayp1JBuOAiMGS9tkfAxD8LGLgUzlUA2xnAh
         CqYqWpXPRPKQg7ONXvWU/mldy1GZu3JQslYYDe272VfxqQp9b3SRDh87Huzs06TxwhNl
         QZmEzIW1Dd61mjnRBW71GXWV4xix4Yb4ByiPpEMqDinneWTKvHaqLu0ncFZUrtOyqkeS
         BBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745614988; x=1746219788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNTEeX6DPBZRIn/ZzBonF2xns5W9UBXy7LugHu3uk70=;
        b=NOC2Pi1EC/6un4WfsU8sFg8gY0i6T62uoWSr0J3KAaVfP43BmF7KKVO1gL727MeRCa
         U6R/l3BPvrQ7ZTVoqxLfVdW+4MshZdMAN4K/Km82WJpu33NYCCnOmLpTVd9v27Xa7tzn
         YoS/oYOZQuiHLRE+WEk1DgcHoxSUp1EWNPlabszCVyR/NyViqM7Cdb5qARqUPtVtKEaD
         el2S14MMz2p+5Xo1MMJSoh/nJ+Lbqum5zoatAOotTlXRNU5Bkfh/08fzKro4k4k+s7EA
         t9dTzN50rmYIZbW8aHXtyrZHl52xnY4n3aZZHcVXBEHBM+jvdEGAPjZnh2VvZC8363Rh
         b7Ww==
X-Gm-Message-State: AOJu0YzQA2qw/nSOw7yxOxEa9HcNgz6Y5Djosf2aUyNBb3GQOBswP0Kx
	Qi8vJwyjuZ3QMGxJkGi0jLYdRbxNkQfCCCO23gHQGtgWpP8RcmZP
X-Gm-Gg: ASbGncsoVuCo4c7/J+VqVK/a1sJlmt2Io9s9lIm+w74qLMWD8eXScqdccD+qI1313aV
	/EDCogjWhdpqPtI5YZeFGmREikHD7k4Uh6lTMg2HhYC/mCrj82Kx107txLOm1/jK5j474CRmeSW
	icu6h0c8GOL8PYyij5oyTOcNsU+E9ecTEURGvHXAc3XSyo6ZlF3fQwj6Ggtb6GMGqfrt2FIsyR7
	HnTNbJrlQ0IPaGdxJww2wXGRd6xasqr/uvcY17BRfCUqpYJI5j6Xwya4qLCdT1me6m71/lZYkIP
	41nJLLMBC7t5XdP+jBdzzgPtVuPt+sr6iZ6QLooKTQ0rVj2DO4v/mWlVzxg=
X-Google-Smtp-Source: AGHT+IFKvAlUv/XrHDuSkfRiioMYljZuHB3UAmGlHy4Zgq1cPmQD98oUHeZYySeaZ7aVXwnA00wzag==
X-Received: by 2002:a05:6402:234a:b0:5f4:d38a:ee1a with SMTP id 4fb4d7f45d1cf-5f7395f1f12mr617174a12.14.1745614988205;
        Fri, 25 Apr 2025 14:03:08 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0c3:1131::1220? ([2620:10d:c092:400::5:eb6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f703546557sm1717375a12.51.2025.04.25.14.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 14:03:07 -0700 (PDT)
Message-ID: <cf8509d8-e912-4c37-9c08-930baad630a9@gmail.com>
Date: Fri, 25 Apr 2025 22:03:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/4] bpf: implement dynptr copy kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250425125839.71346-1-mykyta.yatsenko5@gmail.com>
 <20250425125839.71346-3-mykyta.yatsenko5@gmail.com>
 <CAEf4BzZc=RORQTWdTO4T2VvXqn_7+u=WH6hxJjMR-JKTFeMnEA@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzZc=RORQTWdTO4T2VvXqn_7+u=WH6hxJjMR-JKTFeMnEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/25/25 19:20, Andrii Nakryiko wrote:
> On Fri, Apr 25, 2025 at 5:59 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> This patch introduces a new set of kfuncs for working with dynptrs in
>> BPF programs, enabling reading variable-length user or kernel data
>> into dynptr directly. To enable memory-safety, verifier allows only
>> constant-sized reads via existing bpf_probe_read_{user|kernel} etc.
>> kfuncs, dynptr-based kfuncs allow dynamically-sized reads without memory
>> safety shortcomings.
>>
>> The following kfuncs are introduced:
>> * `bpf_probe_read_kernel_dynptr()`: probes kernel-space data into a dynptr
>> * `bpf_probe_read_user_dynptr()`: probes user-space data into a dynptr
>> * `bpf_probe_read_kernel_str_dynptr()`: probes kernel-space string into
>> a dynptr
>> * `bpf_probe_read_user_str_dynptr()`: probes user-space string into a
>> dynptr
>> * `bpf_copy_from_user_dynptr()`: sleepable, copies user-space data into
>> a dynptr for the current task
>> * `bpf_copy_from_user_str_dynptr()`: sleepable, copies user-space string
>> into a dynptr for the current task
>> * `bpf_copy_from_user_task_dynptr()`: sleepable, copies user-space data
>> of the task into a dynptr
>> * `bpf_copy_from_user_task_str_dynptr()`: sleepable, copies user-space
>> string of the task into a dynptr
>>
>> The implementation is built on two generic functions:
>>   * __bpf_dynptr_copy
>>   * __bpf_dynptr_copy_str
>> These functions take function pointers as arguments, enabling the
>> copying of data from various sources, including both kernel and user
>> space. Notably, these indirect calls are typically inlined.
> you mean there are no indirect calls due to __bpf_dynptr_copy[_str]
> marked as __always_inline, right? We still call
> strncpy_from_user_nofault (as one example) as an underlying data
> reading step, right?
yes, exactly.
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   kernel/bpf/helpers.c     |   8 ++
>>   kernel/trace/bpf_trace.c | 199 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 207 insertions(+)
>>
> Logic and code structure look great, few nits around naming below, but
> LGTM overall.
>
> Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
>
>> +static __always_inline int copy_kernel_data_nofault(void *dst, const void *unsafe_src,
>> +                                                   u32 size, struct task_struct *tsk)
>> +{
>> +       if (WARN_ON_ONCE(tsk))
>> +               return -EFAULT;
>> +
>> +       return copy_from_kernel_nofault(dst, unsafe_src, size);
>> +}
>> +
>> +static __always_inline int copy_user_data_str_nofault(void *dst, const void __user *unsafe_src,
> "user_data_str" is a bit mouthful, maybe just "copy_user_str_nofault"?
>
>> +                                                     u32 size, struct task_struct *tsk)
>> +{
>> +       if (WARN_ON_ONCE(tsk))
>> +               return -EFAULT;
>> +
>> +       return strncpy_from_user_nofault(dst, unsafe_src, size);
>> +}
>> +
>> +static __always_inline int copy_user_data_str_sleepable(void *dst, const void __user *unsafe_src,
>> +                                                       u32 size, struct task_struct *tsk)
>> +{
>> +       int ret;
>> +
>> +       if (unlikely(size == 0))
>> +               return 0;
>> +
>> +       if (tsk) {
>> +               ret = copy_remote_vm_str(tsk, (unsigned long)unsafe_src, dst, size, 0);
>> +       } else {
>> +               ret = strncpy_from_user(dst, unsafe_src, size - 1);
>> +               /* strncpy_from_user does not guarantee NUL termination */
>> +               if (ret >= 0)
>> +                       ((char *)dst)[ret] = '\0';
>> +       }
>> +
>> +       if (ret < 0)
>> +               return ret;
>> +       return ret + 1;
>> +}
>> +
>> +static __always_inline int copy_kernel_data_str_nofault(void *dst, const void *unsafe_src,
>> +                                                       u32 size, struct task_struct *tsk)
> ditto here and above, "data_str" is confusing. let's use "data" for
> fixed-size reads and "str" for zero-terminated strings?
Yes, makes sense
>
>> +{
>> +       if (WARN_ON_ONCE(tsk))
>> +               return -EFAULT;
>> +
>> +       return strncpy_from_kernel_nofault(dst, unsafe_src, size);
>> +}
>> +
>>   __bpf_kfunc_start_defs();
>>
>>   __bpf_kfunc int bpf_send_signal_task(struct task_struct *task, int sig, enum pid_type type,
> [...]



