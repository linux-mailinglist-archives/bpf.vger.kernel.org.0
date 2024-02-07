Return-Path: <bpf+bounces-21435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8C584D382
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 22:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B9C7B25F3E
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 21:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AEA127B4A;
	Wed,  7 Feb 2024 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKttW8u4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A25127B74
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340323; cv=none; b=i3n7xtIv9jMrFpC1C3NdkAm0gfdOVj5c0v7BGKd6r9PcH9uYrG11vSNo9e17B187tbIRiRHqkGS8Cjk63Dv946Bx5e88Z1XhPmwU41Q2EyTpAS/coPC3O0S4MV+a1JEGtvhA8RHQOqjqF/CdnXSfBNV3S35GYktXJE+oOYTPbto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340323; c=relaxed/simple;
	bh=MfEwyQBXnuCixH9qnNP15RPJb2WGz1jcwnfEFf+eDHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXn+slg+n8NZKKN189sAlMhlKUpjbTbSesDC7bKINOLvhwX20RlriBbYYuo14rmoHxkVUiJ6u/PhsBfROyTmHoRZJNRUjViOAkbrngnomydtYe7s1BiJkQ7cxZJO5D2Lw4w1Np7g243J986hG6CuS2QYR3LuvEbUbv5SBWAtIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MKttW8u4; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60485382886so13150037b3.3
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 13:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707340321; x=1707945121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqMpxCMRy5Coq5eE/aEefJ3saG5Z7PDxj7OPSM7FPn4=;
        b=MKttW8u41oTZBs0IoeP/GMXGviOtqg1Qrx40e9EqVZg9n6/WojC0ap7wAlu3bK8Zz6
         jBSIymYGxNj2ywzxbkGgcyfjfReUJXd7zwqNI3Q0+d1AsAr5gkqq4pi0Em1JU1HlXFTu
         tVfqgJvFPmchQG32yCHmlSic9GWbvchqPiFdd8Kaj6VAV7CIXEH1SaAc2tBvHWj9UCnJ
         H2YI2jHLbo2tYa02LmDwfRviNLd4PzewQBMuYCFHgzhhfO9CgN6KJvjzYjAuygNX0y8s
         7VOzD2VyXlC7BAZ9Di7m9kNiqoSh9DxF2zEOaDmsDYCMnTcVWRKRqB3b/eVrDhtKvkPD
         ZAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340321; x=1707945121;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqMpxCMRy5Coq5eE/aEefJ3saG5Z7PDxj7OPSM7FPn4=;
        b=Ac9ynRLXUX1b3NzlicbkwskVD6g+come84MbL9Atp83Dv2cnaWykiBoAE5DVEgxTU/
         rEwzk1dqqfuZWHhxVMMzYFzWlfB79+HdpURYVpCvZXgR9KxyMEn6leYWCHBgauJ2QJeV
         HwZUtfdTrXcZu7Xas5hd4gUWv+KolLBFuubT7mxETBNdalzINpYaRu9WOGN/Tj+XXiv5
         HSo07jxjbs3ku9jGJkaQ1sBjQte1IBGUPg2bCd2uOx5p0Yco7C3NQDU/w1Fq927WloZ3
         thrrBU6PCqC+wC2rmp2IVX3jwJZqR8p8o5zC93mxjG3X7JoNvzYwQwe2iqBxZYOMF0LP
         324Q==
X-Gm-Message-State: AOJu0YyUEXyblXs7MFvlg8X+uXDG8BuEdTMQ4Og/CA33UC4OcZAy8xhh
	EXwWOzG800A28CmhriDCghiNQS5KKtNns/nfCf5t5F0BBskMStgKgxgmbEeV6g==
X-Google-Smtp-Source: AGHT+IFHY/L7LajnQyl3FmFVsREkfgRxgvspXpqp/807bBbw3d3WtoWLRLwpwW/9yrU7FYXDdGymOw==
X-Received: by 2002:a5b:4a:0:b0:dbe:eae4:286a with SMTP id e10-20020a5b004a000000b00dbeeae4286amr6099231ybp.51.1707340320837;
        Wed, 07 Feb 2024 13:12:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHgOEgFuAdxA/av1FTy2dtDGmfnGlLZyrNmxVqzcaseswC3SwSVHlHJFDEN2uCi6q2r8Z+9SMNBblEdc5oOJvPmkV60H9QHga0YC84/nUa4facl+BddF6oqldqvJdCCQhVTmXmzP7R6xXgFmTDWM/pF/o5QeDw98V5H/zwiSRPvhh+zRPMPil3PDMCk2f4WU4zXi3hL2NOn9i2g7PwHz6K4LDou6Hnxaxe2DqJxw6/lByqBF+Sd/OAv630gm0PPKi918noO69R9elHwf4CQKcWwiQYJZQWZJAI4bBTs6s=
Received: from [192.168.1.8] (c-73-238-17-243.hsd1.ma.comcast.net. [73.238.17.243])
        by smtp.gmail.com with ESMTPSA id u21-20020a05620a455500b00783e1590ebasm849136qkp.82.2024.02.07.13.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 13:12:00 -0800 (PST)
Message-ID: <d4024acf-97c9-4a16-ac70-739d0bf81a45@google.com>
Date: Wed, 7 Feb 2024 16:11:58 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 04/16] bpf: Introduce bpf_arena.
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>,
 Kernel Team <kernel-team@fb.com>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-5-alexei.starovoitov@gmail.com>
 <c9001d70-a6ae-46b1-b20e-1aaf4a06ffd1@google.com>
 <CAADnVQJJ7M+OHnygbuN4qapCS8_r-mimM6CLw5oee8ixvmqg4Q@mail.gmail.com>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <CAADnVQJJ7M+OHnygbuN4qapCS8_r-mimM6CLw5oee8ixvmqg4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/24 15:55, Alexei Starovoitov wrote:
>> instead of uaddr, can you change this to take an address relative to the
>> arena ("arena virtual address"?)?  the caller of this is in BPF, and
>> they don't easily know the user virtual address.  maybe even just pgoff
>> directly.
> I thought about it, but it doesn't quite make sense.
> bpf prog only sees user addresses.
> All load/store returns them. If it bpf_printk-s an address it will be
> user address.
> bpf_arena_alloc_pages() also returns a user address.

Yeah, makes sense to keep them all in the same address space.

> 
> Kernel addresses are not seen by bpf prog at all.
> kern_vm_base is completely hidden.
> Only at JIT time, it's added to pointers.
> So passing uaddr to arena_alloc_pages() matches mmap style.
> 
> uaddr = bpf_arena_alloc_pages(... uaddr ...)
> uaddr = mmap(uaddr, ...MAP_FIXED)
> 
> Passing pgoff would be weird.
> Also note that there is no extra flag for bpf_arena_alloc_pages().
> uaddr == full 64-bit of zeros is not a valid addr to use.

The problem I had with uaddr was that when I'm writing a BPF program, I 
don't know which address to use for a given page, e.g. the beginning of 
the arena.  I needed some way to tell me the user address "base" of the 
arena.  Though now that I can specify the user_vm_start through the 
map_extra, I think I'm ok.

Specifically, say I want to break up my arena into two, 2GB chunks, one 
for each numa node, and I want to bump-allocate from each chunk.  When I 
want to allocate the first page from either segment, I'll need to know 
what user address is offset 0 or offset 2GB.

Since I know the user_start_vm at compile time, I can just hardcode that 
to convert from "arena address" (e.g. pgoff) to the user address space.

thanks,

barret



