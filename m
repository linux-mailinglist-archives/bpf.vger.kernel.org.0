Return-Path: <bpf+bounces-71055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E577BE0DD2
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 23:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85BEA1887D93
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 21:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9256630276A;
	Wed, 15 Oct 2025 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlN9q98c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1E72D4B7F
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760564907; cv=none; b=ZMuoBtNBbYSqNxEiW36jovyrR64MMEgh7Usu4aRTHNXIXC9Taeizhjn7OEGqmOU8LHw6qMVK1XJJT2dDYNV4Pw8h6/t8tMEqbVq61SNTZKREGWMIJn572JWbLS6X4iZKQn9IiiIjEOQikP8rYj62401QhQJjRqju8ZfJpeIZecs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760564907; c=relaxed/simple;
	bh=R4j4YpQejsselhzJBydexKq4412T7FqojVdRGt5iF7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4OtHabnOfBuZ7ji4OYgW3VLj9Vo3diu2ylUlY+wp+A0PNoCt0kB8E3VTr3KpW1MO12yE+Rhid3O4QEfeB3RV4fUzHOUv+N0jTgNq+k/25nYMuV31FOiB9GXIOCyPRNBCaDYmB6669DDnZOb+W3Ju9fTyBaE4grDgxLN2MAR5yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlN9q98c; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso474815e9.0
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 14:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760564903; x=1761169703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fN+sx3bhmZPJ05a/Y0eqio7hh2ulnhX75uScgspBoMI=;
        b=HlN9q98c/dRlowZsqz0fIQSgWTk5JAajVUGCtqd0jOp0jXX/GHza2Vsy92VrT1FjmK
         /ifV4p62O6/eVp3WUxIjOAhazVhlnvjBVvji7f44PuBTnEUORZHiJtdMPG/vkvL5XwgB
         aP9sLadpN+kslGOt+/RWnp64caOLzHrIeOI75JuTy6cXQXdidqTpMQrPyynrWTwIOIET
         Ff5FTKn/WQqT0gXEL9H5vMCcokOHEpASkHyayU9ml9t2sBNkX10NGtH7T2RVVndT/Kgq
         56zH5IVXB7qq80Cb7SLJk7XYBRzkFoe0v9e6BTW6E2zHRm2/pZymhS4CQcc0AB1hhEpn
         x2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760564903; x=1761169703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fN+sx3bhmZPJ05a/Y0eqio7hh2ulnhX75uScgspBoMI=;
        b=B4AVuXrISY5dSigW9kTi3ZfeXtLVN3Lr55HgRpMyJn3nDRSPVB3JzlFk0EgwAp+S0W
         kabtxUlznfahO0r0d/kJzlHqC6ft2GIA+ZOK5V4t3NlYZ1/EgG/va4zYJbG7HIB2PKw9
         bISEm4+8xf44Ml/r03kCgGiYFYrgrVrnMlqxSKfzStCt/Pr7FUgiixts0n1E7F7x6BCu
         PqBhtrRPeCj7ZZ4Qt5RWqx1F1/dn+EfHv04KibLmwVrMjKYUwNhh6FMAYjfPN8OweNiY
         Ty6hLGcKvvktL7d1jyziPc74QvQX7XfvPhZr9GLJ2IICgkdkO42m/qRq32LzqZ5179mY
         uLqg==
X-Forwarded-Encrypted: i=1; AJvYcCUEPOs8QB12ePk5/tEZZfI/aqSrKY/84xb+fYMjHmplHdEcIw1gYr2o5PzGcu13DSjomm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykTiPSFf369YRlbhv+j7xF/TpkpGKxCq/+U4m6OIrNnvSXekoP
	BkctW3nCoEeqKGCw8NuSF8ThcGQcErO1HbxOh5aVsicYwoty5qN8WtoY
X-Gm-Gg: ASbGnctruNde8/08ga/06jGFkdx7AJWaUdKn6btl4MLjstxJ+urZ+bWm8220ZMW3rmz
	8AwKid7DC+47AgSJQwcqGaLBrXrgnj0kczrXRajpBBpHFIaM4yAIGZsaGp7OHyTRBVedRgQsqap
	IBI8NJaRkIU1eTMu6b+PWtfKNW1giOwpsOwRdHDgOOGjKkMItORoYO4hhxpfBoSwOOsBe9Zn07/
	y+fUt0ZvwIrJLy3zLppzwlGEcBP3KtGIZJjt2wfNGLqo9x3Kt2i/hVvn9KzQrjzn2vhDJTB1lP/
	AjYcoZxFJcDNc4Otf+O0MlkbhM7yf3t7hUDriaPcQ7A+QR58PjqQRduczMmi5O2uU7QauuymhJ2
	X9EqK9xOCIJmPI1/+mcXZmU5gYJ8hFE2e2QRTA+6x3t0105qWajmJ/aqTVwZFgDLCruKHH91iU8
	tBG2hbEM75QQRNeAfvYTGRL8j5T5M9k1nRmbr8/NLcwq5gmPzmdskRRgAW/a2P98Yj
X-Google-Smtp-Source: AGHT+IEInYPB/aoYv41PLi+scS6GGFm1EZOsK9tqM36/lCC/uMET8ma8ybHJbO9KDMIiNThUWwWssA==
X-Received: by 2002:a05:600d:18:b0:46f:b43a:aeed with SMTP id 5b1f17b1804b1-46fb43aaf3cmr125269805e9.40.1760564903435;
        Wed, 15 Oct 2025 14:48:23 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101c3b05csm49388965e9.16.2025.10.15.14.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 14:48:23 -0700 (PDT)
Message-ID: <6f7028a7-4cdf-4800-b43d-985019c02983@gmail.com>
Date: Wed, 15 Oct 2025 22:48:22 +0100
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
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <1cde9d18eaa6ae135c2c6b03c3e97c4d00293aa5.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/25 20:36, Eduard Zingerman wrote:
> On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Mark vm_area_struct in bpf_find_vma callback as trusted, also mark its
>> field struct file *vm_file as trusted or NULL.
> This is because this struct is only returned by:
>
>    BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)
>
> and task iterator is RCU protected:
>
>    BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW | KF_RCU)
>
> or passed to a callback inside bpf_find_vma with a lock being held,
>
> right?
>
> [...]
>
>> @@ -7133,6 +7137,7 @@ static bool type_is_trusted(struct bpf_verifier_env *env,
>>   	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task));
>>   	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct linux_binprm));
>>   	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct file));
>> +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct vm_area_struct));
>>
>>   	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_trusted");
>>   }
>> @@ -7143,6 +7148,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
>>   {
>>   	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
>>   	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
>> +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
>>
>>   	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
>>   					  "__safe_trusted_or_null");
> Why changing both type_is_trusted() and type_is_trusted_or_null()?
> The only place where type_is_trusted_or_null() is called is here:
this is because type_is_trusted_or_null() check is only executed when:
```
else if (is_trusted_reg(reg) || is_rcu_reg(reg)) {
```
condition is hit. I understand this code as vm_area_struct has to be a 
trusted,
so that its field can be trusted or null (It did not work without adding 
vm_area_struct to trusted).
 From verifier log I can see that the type for vm_file is correctly set 
by the verifier:
```
; struct file *file = vma->vm_file; @ file_reader.c:117
48: (79) r1 = *(u64 *)(r2 +88)        ; frame1: 
R1=trusted_ptr_or_null_file(id=1) R2=trusted_ptr_vm_area_struct() cb
```
>
>    static int check_ptr_to_btf_access(...)
>    {
> 		...
>                  if (type_is_trusted(env, reg, field_name, btf_id)) {
>                          flag |= PTR_TRUSTED;
>                  } else if (type_is_trusted_or_null(env, reg, field_name, btf_id)) {
>                          flag |= PTR_TRUSTED | PTR_MAYBE_NULL;
> 		...
>    }
>
> So, it seems that type_is_trusted() will always return true before
> type_is_trusted_or_null() is called.
>
> [...]


