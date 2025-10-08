Return-Path: <bpf+bounces-70565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A0CBC3137
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 02:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00023C7641
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 00:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72972857EF;
	Wed,  8 Oct 2025 00:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6wMeIHG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33CE1FA859
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 00:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759883967; cv=none; b=rp8i7a7z9Cbikmvm0fXZtSqm2CCLDBPrB7kQm1OZzxrjNgApYk8CLjSEGGuOabRFXdyGl4UfFO7eKZNaXeC1XVaj8M0IPrU7qrKHa8rp/6mHIBSrOm6+HiAvyVaIfzRhX6vun7N73IIMnvNL/oZRmH+Fo2UIPyFEIF9oKg2g0kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759883967; c=relaxed/simple;
	bh=Hb3YC3pVlICgZbkxUh8se7UmgQYPEJxUKACrm08IMj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bb2XTMQZyzV0A0k5dz/zExfMY4/3tAYvoAeO3ZXG6g3aJ5ep070Mjm06yh5x31I5MNQebUhcIpaX+sIni3xyWGyOEtMgIFERHpZSXcu7h61i3ryiyhX45aVmXUQUH2abV2Ze6j1mKbDWWc38rXevkPHi9p4YDa/FVJE8Mv5LtVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6wMeIHG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46faa5b0372so2026045e9.1
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 17:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759883964; x=1760488764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z2ZVzTTMxUkqjmeWq7yuBsU2RqRiIYMjtMHlyASuVyE=;
        b=e6wMeIHGhnOji/9j3GHZ1uyZrwm2d2Aj7J35hPP3UIibh/hK38SyU6bf3obJAxbsMO
         1O4Y6WX9tEnqN8H6Jr9tHmPdlbTiGmklnWbFjhIa7VDFt8vVNe+TxbxOeVP+oAPE6Nmu
         eMUW74dfH+SIh6LCi216Vlk/DGwmOgtRFhoE4Y1qttXq5nK6ypqFO+rrX+eXrYLbYb8L
         rLQXK8l2tCG2k9qzr3xpJGqy/35qa3u2bfwG8jGnq8el9V91OzRnQL0oYmK4nLDl6Dgs
         GBKkoTpA0pHGbayEqUpp/1CLV4m9AsvJi0ID5zClB3lj/9krmsWzLg5qOqGz0NISFXH+
         ozig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759883964; x=1760488764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2ZVzTTMxUkqjmeWq7yuBsU2RqRiIYMjtMHlyASuVyE=;
        b=n0vZLqMRUVKnWqXwrinUj+ap1Jw0moQQ8a2asge4/k1QVGFo0Bmr5vVO2sbpEEz0/1
         zgxVJ3K/OK2NZ+KQ5YY33Mwk06CBQELinUnM3EGzhfTscsfAgd4i9OF/PrOAZ53RuGIC
         0VlUwMoUCCzvkbgxjE3xEr+8gYTCCKW3/YYfctlC6+ZLVwZS5q8qvXzgW/mhNBg/YKxD
         8WbElngGrTzy+I9cDdFnqCVyzHe4woNOTfhyBQWc3PH6mMTaYpuXqoMDm+GJgsUIuSRc
         HJjR1vm8I/AM5RVVdyr8+MRcp95BhPqt+UIJSci9Q0RUJxojNtQqTzf0bGtSEKFC3obU
         z1Bg==
X-Forwarded-Encrypted: i=1; AJvYcCU3Qu3+13asovlfW+l8L730v1rBtbUVZl2Jnt2u7LYdOTW3lYoH6guksurWD+1VONet/B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHTWn/GDb7vq3nNDBXseNqHz8XsdFMMIBuM2tiXCgqkU803WKO
	CFaJj0242UnHzuvy2EJa01SbJnc7KOCphyK5lSJmNLT7SBmQfGVjS4SM
X-Gm-Gg: ASbGncsHpUgvE1sbYxduDT3DDslL5WCA4XdcTMJm2AipJFyg3TTp9WgS0FbsWaSYTU2
	vcc3C0qP/eH8lYiqxQEE5TOtgPp7Mmb2Pb1xkn62CG/Yjjy9j0Qkiqrqz3zNYS0yjX0/aVWK/xP
	5ihiRH7HdMPKpmUeeO4YHNtFB1O3hfJ+rpUBcVHWx090KCTDUACyXnLvOmwt+ERFJykiNKcr3li
	n8lyQgOuh8F/HjKjFg1fDwjp+97prid3kt66y/Oq8dnLZSKB69SmJPElfzhuh2rtEfxufm9XU6e
	CrDD8n8oBqTGtF4Mu6u3VuPWtOdNBtZVWXxqKM0MLvWUD9p7skP0x9/iJ/aV7z4kgdu+h71v4aw
	UQ3cNBp2ZmRSBx8KvrwiQw02hOKDXE+BbldmM+XpM3AgpOrS45vkxk6+Lj0S7lE9gYDyBaS86Ju
	j2DMDPBSqDVeLPhTOAHiAeU6ErrlACo7Y=
X-Google-Smtp-Source: AGHT+IGKEKe5RusIwGOYAYnyozcQuPFdiLphDcgLWUOcY7nQVzkc+Bof9kv7pv8pfiMkhPErX/DP/Q==
X-Received: by 2002:a05:600c:4f08:b0:46e:206a:78cc with SMTP id 5b1f17b1804b1-46fa9b1062dmr6931595e9.28.1759883963973;
        Tue, 07 Oct 2025 17:39:23 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9d6fb41sm13321105e9.17.2025.10.07.17.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 17:39:22 -0700 (PDT)
Message-ID: <1f2276d9-88d4-43ad-8ce1-f92ebd86a3a8@gmail.com>
Date: Wed, 8 Oct 2025 01:39:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 10/10] selftests/bpf: add file dynptr tests
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
 <20251003160416.585080-11-mykyta.yatsenko5@gmail.com>
 <47e2812f633ad990f6d1a38234d99bc1e6c3bd87.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <47e2812f633ad990f6d1a38234d99bc1e6c3bd87.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/3/25 23:24, Eduard Zingerman wrote:
> On Fri, 2025-10-03 at 17:04 +0100, Mykyta Yatsenko wrote:
>
> [...]
>
>> diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/testing/selftests/bpf/progs/file_reader.c
>> new file mode 100644
>> index 000000000000..9dd9a68f3563
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/file_reader.c
> Do we really need an example of ELF parsing in selftests?
> Maybe just stick to smaller test cases, exercising specific behaviors?
>
> [...]
>
>> diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
>> new file mode 100644
>> index 000000000000..449c4f9a1c74
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
> [...]
>
>> +static long process_vma_unreleased_ref(struct task_struct *task, struct vm_area_struct *vma,
>> +				       void *data)
>> +{
>> +	struct bpf_dynptr dynptr;
>> +
>> +	if (!vma->vm_file)
>> +		return 1;
>> +
>> +	err = bpf_dynptr_from_file(vma->vm_file, 0, &dynptr);
>> +	return err ? 1 : 0;
>> +}
>> +
>> +SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
>> +__failure __msg("Unreleased reference id=") int on_nanosleep_unreleased_ref(void *ctx)
>> +{
>> +	struct task_struct *task = bpf_get_current_task_btf();
>> +
>> +	bpf_find_vma(task, (unsigned long)user_ptr, process_vma_unreleased_ref, NULL, 0);
> Why testing this via callback?
I did not find another way to obtain pointer to file,
  now I see there is task vma iterator, which is a little bit better for 
this.
>
>> +	return 0;
>> +}
> [...]


