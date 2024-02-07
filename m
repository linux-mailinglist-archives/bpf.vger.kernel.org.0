Return-Path: <bpf+bounces-21406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0942D84CB9A
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 14:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC410B273F1
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 13:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E5876C9F;
	Wed,  7 Feb 2024 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5ptKL97"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723B87762E
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312828; cv=none; b=A7/Z0kxO8U2OgEL+6kLjkb49wjC0i4toGgqQoP6j6lzKzKwPS2TzrWUGysE7nqT2EkhoQncHYEsUuEy43WF9eibqVDAPQc2EkiH3tcb04r8WvHTOC+w+CwbgZwbiw0x2ZqOhDOaAR74UlbiQZ2qELcz5MOezCIo0+nZBjLAKj/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312828; c=relaxed/simple;
	bh=XRojAL7H4xEdLn3gpAo8+Z2cm6nowXdvd8SW5S1MpIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6qyWwm9U0KjTo7c1fYXmYAazSVEGdIW+X7OVoI7HG1NeyOoO1pto/dSpDcbvKYBQIQJ/kpQB7Zj1UqL1Ihl7IocZMo64tFj48iN26XU1YDnh/RMHAK9e/47gALTT1hc+1xZwl4BETTNf10YJSs3ytCPdiGvNP8zylF99OBUOD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5ptKL97; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6818f3cf00aso3822686d6.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 05:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707312825; x=1707917625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ClRRsnreAQAmzChpNpHdXijt7xDlDPCVlkBWfOdqK0I=;
        b=i5ptKL97KoKO3w4wQ0dHq9DfsSldnCn7lzXAL71j6iaQ757wG054+Ioc/3U5YlH0fS
         S4OMi0ux169NIqTBAYd1j/6zFh5YOivs9r9PlpBDcuU6caffEUn2K/u0YccYiCz1F/FR
         6LvjtX5XgFQNWcXNoXUyXn3YfNGwRnMrimEqqYmidzd0+E62hG7VerkvljAMDeewi8PE
         B/54zbvmw7s4u7L2rknb/OltQqRiS1Sm8FDRxFn81pSb7leH9J3nsg+ioKPg3shcouSU
         JQxLzf5tt7zs5QI/yMgV1VI+RanojMyrylUrM4/hxs0HOARaGeBCMji8IQjKDO3r+gvR
         2/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707312825; x=1707917625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ClRRsnreAQAmzChpNpHdXijt7xDlDPCVlkBWfOdqK0I=;
        b=jRGjWhok5FkbovmXOeZcvkDlkqL/TaD2RxQwEga6RtqG1F0BORjav14jE/PB612rvM
         547Mbusa3qcicOQBRqSs+WKDMIYyMyOcMBKYubQKerWPmD0x2NEOU6HMlQXz0+RhKC/O
         vUvMofQgGewybkN2JgiY5LE/FoNlodRilNImyBYnSIKE2E2/MA1e0ZAYnXzc9ZbXTITa
         UoUokbGDfNqo6hC3wSRNqExD/IZL548c3/YYejLAq0mjDDmSJjshGtTX81f5erV4+xGT
         7znmkr1Frm9GwQt7jlt4qMTkYBisCrghspI7NyhE/XAQXxGEp8jnmMtv0TZk5GTOUkk2
         c7xA==
X-Gm-Message-State: AOJu0YyHi+Tq7qAtjL0gSNbYDWUuDIBKFc7he5YDVGwxibKu7gY0abmH
	8JzTi7M99lsvZG+VTS7Vyll2QTVZHR/jv+HhhPH1v6ygSR801H6lBF03ZYA+nQ==
X-Google-Smtp-Source: AGHT+IHJ7T7P3rBpiYTjhQA9ZNtPtXI1J+NtXhagq6AjOiXKASkvq34ZbTAX25oyUrpt0oysBza+iQ==
X-Received: by 2002:a05:6214:258b:b0:681:78cf:3920 with SMTP id fq11-20020a056214258b00b0068178cf3920mr6986214qvb.25.1707312825202;
        Wed, 07 Feb 2024 05:33:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSYueSA73EqIF32rQqgxprdXVog3n1g97wgK5m5zoIB5W+diFaRHScbGNVnc9JQ6GEiAp4SGbASX4tQChZecj6TILmR+PAIbuKWKJOs46s5L8vfa9l3y+Vstr1LHjrIpEj0Y6Tw0SYfaZZilo5ifj9QGp1r6/hsaAIdOxODmPFEqGHITHXhKgfz8K8LD/9w+OKwhEUYz14VHjgwHCgG+6Snvy0DbYXx0A3Y0itW2SOiRWL0wwyypGxvpTmERQwY8NIxug+jj0rffkUL0bBHD6/Glrz6MJEE118zc8DAnoTfhpvg6w0VZMup4sCQj3rtEroIX8=
Received: from [192.168.1.8] (c-73-238-17-243.hsd1.ma.comcast.net. [73.238.17.243])
        by smtp.gmail.com with ESMTPSA id lx13-20020a0562145f0d00b0068c39b7a7cfsm587302qvb.12.2024.02.07.05.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 05:33:44 -0800 (PST)
Message-ID: <b97c5318-ccd9-428c-95ca-7c120eb7c089@google.com>
Date: Wed, 7 Feb 2024 08:33:39 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 00/16] bpf: Introduce BPF arena.
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org, hannes@cmpxchg.org,
 linux-mm@kvack.org, kernel-team@fb.com
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <m2h6iktpv7.fsf@gmail.com>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <m2h6iktpv7.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/24 07:34, Donald Hunter wrote:
>> Use cases:
>> 1. User space mmap-s bpf_arena and uses it as a traditional mmap-ed anonymous
>>     region, like memcached or any key/value storage. The bpf program implements an
>>     in-kernel accelerator. XDP prog can search for a key in bpf_arena and return a
>>     value without going to user space.
>> 2. The bpf program builds arbitrary data structures in bpf_arena (hash tables,
>>     rb-trees, sparse arrays), while user space occasionally consumes it.
>> 3. bpf_arena is a "heap" of memory from the bpf program's point of view. It is
>>     not shared with user space.
>>
>> Initially, the kernel vm_area and user vma are not populated. User space can
>> fault in pages within the range. While servicing a page fault, bpf_arena logic
>> will insert a new page into the kernel and user vmas. The bpf program can
>> allocate pages from that region via bpf_arena_alloc_pages(). This kernel
>> function will insert pages into the kernel vm_area. The subsequent fault-in
>> from user space will populate that page into the user vma. The
>> BPF_F_SEGV_ON_FAULT flag at arena creation time can be used to prevent fault-in
>> from user space. In such a case, if a page is not allocated by the bpf program
>> and not present in the kernel vm_area, the user process will segfault. This is
>> useful for use cases 2 and 3 above.
>>
>> bpf_arena_alloc_pages() is similar to user space mmap(). It allocates pages
>> either at a specific address within the arena or allocates a range with the
>> maple tree. bpf_arena_free_pages() is analogous to munmap(), which frees pages
>> and removes the range from the kernel vm_area and from user process vmas.
>>
>> bpf_arena can be used as a bpf program "heap" of up to 4GB. The memory is not
>> shared with user space. This is use case 3. In such a case, the
>> BPF_F_NO_USER_CONV flag is recommended. It will tell the verifier to treat the
 >
> I can see_what_  this flag does but it's not clear what the consequences
> of this flag are. Perhaps it would be better named BPF_F_NO_USER_ACCESS?

i can see a use for NO_USER_CONV, but also still allowing user access. 
userspace could mmap the region, but only look at scalars within it. 
this is similar to what i do today with array maps in my BPF schedulers. 
  that's a little different than Case 3.

if i knew userspace wasn't going to follow pointers, NO_USER_CONV would 
both be a speedup and make it so i don't have to worry about mmapping to 
the same virtual address in every process that shares the arena map. 
though this latter feature isn't in the code.  right now you have to 
have it mmapped at the same user_va in all address spaces.  that's not a 
huge deal for me either way.

barret





