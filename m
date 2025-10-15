Return-Path: <bpf+bounces-71059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92270BE0E9D
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 00:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055B11A22168
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 22:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC70305E20;
	Wed, 15 Oct 2025 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P20jppkm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730A0305979
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760566450; cv=none; b=shYRNcXfJU489HQfsorZaFXUW483kPQ9JmBpZO/mIORNPGtiQd8lpMD7Zt5z42Skr+ASsEg15/o0gxzKYJbdEIBKL99wZbfe6qnr+M7//l3XXG5jJ4eAT2uo+a0/xAPnPQvNiiXolU2tk4xfQXSWmTMszlMxHZhu2PRc6ptsOPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760566450; c=relaxed/simple;
	bh=QhWp36Q8MPbVNuLGrIZwLy2BPFr6ZeDJ10exnVtDMxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yzsu3KXzqmsiMstfX9zpVy9oRH1xj4DVwktHNxlhIKXpQmSwve4hFofW2BtBLfARFo5PvchI1bE1X0Qnvds4dpM5L/X62jr/pkZVUMyYYKm4jloo9jksGqQWz5x0vcM05m36CaZeWOXyAkrD6i3mk/Nq9h9cPN9DClWWeMnwf2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P20jppkm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so542915e9.3
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 15:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760566447; x=1761171247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXgYnBIDs93rD1ihfK5M9dc17oR9kjAD0Bp4klXdaDg=;
        b=P20jppkm8F47FO5D2/Oj4iY33EWJT+g8HeGOVx15eQiOhbyyhD3ias9QhyXc3eM2vk
         kTSjbg+KKX5DyFXWbLoDs4woUYxeu4YaSEtLyaHEUFTu9c8fm8/2nOOUC9xAd0FYspl3
         j5uz6YbvSVqHQ+uGMbrkfLGeWVMEcPQqRSPPqY33MpM+2FSzlhYT6fL5Jvgr4WpgpQwv
         q5hQ58fUXjoqMS10scLlBi388BXEMFncRrGQEahemyPqVkrMll9vpo4VbM186C3+Ncse
         KsoXalAl8XiYdyGxG+7yJDfNTNM1x58B31MF3HkoPwc/Aw9+mOyzvpC2c5+YAdz2f65k
         DtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760566447; x=1761171247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXgYnBIDs93rD1ihfK5M9dc17oR9kjAD0Bp4klXdaDg=;
        b=X+k/w/FV+MKplpQjH9QpK8sEHkxaQZ7arX+6OGMAm4sOhKuPftpgvrUOxmtiqby5P/
         xJyA0pai341/w78jM9Gubz4VvmGRgyHWL9cWs/sTPhD0nEHxgoFwexmplnJQi3xt6KI6
         YYF6J9KBScm3ewt6RO6JOmYnayavaT2GLkN88e5EjEJno5G8MG02eJkTXWHbCkLZuIlr
         lDNSdmJi4HqXdNBaaduEmq26wO+ib+JN115/RJEVSCYk84uwC6GzC1l6DdjRfkNEdqrA
         u011LKUmrkHFte66FGqyG71v6/Edg12XL0Zz+mVnDcT6Wjr6wA6xBYK3+TgN//UnKbri
         djmA==
X-Forwarded-Encrypted: i=1; AJvYcCVj8HNzWLEP1SJiMxhF7S7ZnlRMqZBfUpFbWUZKnj50RcDYPEmSLVPcbFl2Sf513prGdQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymPhJiSgrs+6y+l4bOfD3IxUgqG6zfQsVBvFJ5ZOrRnG+tlRW+
	rSvQ8xeCJMi9/T8vSuo4d1kKSiR8F2Dx4gThOfS5Tp2pu7M+vhpBG0cZ
X-Gm-Gg: ASbGnctJFLNzLUbNcn6kWtv50TFNQS4gb/E5gAcNP62qhD224ZWmrtHCRzsXwwYQ8Y5
	9xzSzqvbjMRt+ELqDoaVMdyjX7nSJ5Q2MdE/TuIeJ/YsdZnroM0z5j1EtaENnSNXoxmP61oAFdw
	QRh6AD7mORrLOwj4EbzjALQSYMc4HnicO0ImBzbFiPKnIt2ZWSgQHaELemCeDXGQoLH69NNQIhG
	L2TQdYWMOne8IY6gCoXjPfvCTek8WhNDyXuO4OokZZU3c6wcvVoD4XRhQYNHuGszKAQqOuRg7i6
	hoW8qvW3KrYIk64F4PPArhwri73yAF1LCtMSv02Rj/cmB56xK51D8+TvpotEOsEjHh5/fKtMuRI
	hJRFBFAYdedvDUpzhxETJef6JiDCRVyVaeXZDPL1mWwSRQ5s4rXJlopW5MqScMaxlm1p/Zb1S2P
	mbquOb6QmQbxko/cOREIdYXQZNcwzhh2nBmzgWXN+wa75ZqleMbSwvC8CKthUUhWszr9Lav76mn
	GI=
X-Google-Smtp-Source: AGHT+IHTYOou3W1wXvewXZQ8XrQdKmogYK06qNeNNVwyUeA857VsYjS4LP8fJKEXuP1UKX3UNWkKiA==
X-Received: by 2002:a05:600c:3e87:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-46fa9b17df1mr252877585e9.34.1760566446615;
        Wed, 15 Oct 2025 15:14:06 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710cd4480fsm3324695e9.1.2025.10.15.15.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 15:14:05 -0700 (PDT)
Message-ID: <66fb7be5-002b-44a8-8887-33abf2a1b05f@gmail.com>
Date: Wed, 15 Oct 2025 23:14:04 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 06/11] bpf: mark vm_area_struct as trusted
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
 <20251015161155.120148-7-mykyta.yatsenko5@gmail.com>
 <1cde9d18eaa6ae135c2c6b03c3e97c4d00293aa5.camel@gmail.com>
 <6f7028a7-4cdf-4800-b43d-985019c02983@gmail.com>
 <5ac4f6ed88c9e62fd8ca516e506ac8ab332f7417.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <5ac4f6ed88c9e62fd8ca516e506ac8ab332f7417.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/25 23:07, Eduard Zingerman wrote:
> On Wed, 2025-10-15 at 22:48 +0100, Mykyta Yatsenko wrote:
>> On 10/15/25 20:36, Eduard Zingerman wrote:
>>> On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
>>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>>
>>>> Mark vm_area_struct in bpf_find_vma callback as trusted, also mark its
>>>> field struct file *vm_file as trusted or NULL.
>>> This is because this struct is only returned by:
>>>
>>>     BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)
>>>
>>> and task iterator is RCU protected:
>>>
>>>     BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW | KF_RCU)
>>>
>>> or passed to a callback inside bpf_find_vma with a lock being held,
>>>
>>> right?
>>>
>>> [...]
>>>
>>>> @@ -7133,6 +7137,7 @@ static bool type_is_trusted(struct bpf_verifier_env *env,
>>>>    	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task));
>>>>    	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct linux_binprm));
>>>>    	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct file));
>>>> +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct vm_area_struct));
>>>>
>>>>    	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_trusted");
>>>>    }
>>>> @@ -7143,6 +7148,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
>>>>    {
>>>>    	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
>>>>    	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
>>>> +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
>>>>
>>>>    	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
>>>>    					  "__safe_trusted_or_null");
>>> Why changing both type_is_trusted() and type_is_trusted_or_null()?
>>> The only place where type_is_trusted_or_null() is called is here:
>> this is because type_is_trusted_or_null() check is only executed when:
>> ```
>> else if (is_trusted_reg(reg) || is_rcu_reg(reg)) {
>> ```
>> condition is hit. I understand this code as vm_area_struct has to be a
>> trusted,
>> so that its field can be trusted or null (It did not work without adding
>> vm_area_struct to trusted).
>>   From verifier log I can see that the type for vm_file is correctly set
>> by the verifier:
>> ```
>> ; struct file *file = vma->vm_file; @ file_reader.c:117
>> 48: (79) r1 = *(u64 *)(r2 +88)        ; frame1:
>> R1=trusted_ptr_or_null_file(id=1) R2=trusted_ptr_vm_area_struct() cb
>> ```
> The test cases still verify, if I remove `vm_area_struct` from
> type_is_trusted():
Ack, you are right, this line should be removed.
>
>    --- a/kernel/bpf/verifier.c
>    +++ b/kernel/bpf/verifier.c
>    @@ -7143,7 +7143,7 @@ static bool type_is_trusted(struct bpf_verifier_env *env,
>            BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task));
>            BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct linux_binprm));
>            BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct file));
>    -       BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct vm_area_struct));
>    +       //BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct vm_area_struct));
>
>            return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_trusted");
>     }
>
>
>>>     static int check_ptr_to_btf_access(...)
>>>     {
>>> 		...
>>>                   if (type_is_trusted(env, reg, field_name, btf_id)) {
>>>                           flag |= PTR_TRUSTED;
>>>                   } else if (type_is_trusted_or_null(env, reg, field_name, btf_id)) {
>>>                           flag |= PTR_TRUSTED | PTR_MAYBE_NULL;
>>> 		...
>>>     }
>>>
>>> So, it seems that type_is_trusted() will always return true before
>>> type_is_trusted_or_null() is called.
>>>
>>> [...]


