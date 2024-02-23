Return-Path: <bpf+bounces-22610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40627861C43
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 20:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7168B1C22B65
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 19:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACC71420C1;
	Fri, 23 Feb 2024 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vl/IoNxo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7A31F176
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708715137; cv=none; b=l5nUNM+v8lqjOOpioh+L7vVByMlPsPNZoKOr1+I8184LXxuMaQx6Ung7wBGdTlYtYocfWyrkUW8ScptoPT8ROqk/v7B1e2hsLjjCTw+h6tIrJO0Qheyk5SdNe2U5nyfW5xFFBKZNOxLWTa+8E8qxKcSiQxY/afKJoVyeQcaQjT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708715137; c=relaxed/simple;
	bh=QiSuQU9OUOXKGFmc/otezWdowTBZVxizHrF9+EsiW3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5aChCk1mukyb1ewztHP7shdi/aD1laZv7/df8dMM09G/CPrc60+iCKekgXFKCQoxLzVy+3XY8fRnegmz6JthgP5Emr5IbjnK97rVLS7IgXh1t6ZBk9henFvEmNr6j2G55diT6LVrPuJ3M+Xh4McGwyLYklawN5OB83m9loC5Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vl/IoNxo; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-608ceccb5f4so662607b3.3
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 11:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708715135; x=1709319935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eGPR91nZoa7tVS1EBEScyNLKIJSxk0MXscPE71LEkhE=;
        b=Vl/IoNxoF8wQ4KV/wNH4nY9R3uFPpH5sccyZe46zLkWWKlvHO9kx2+BELmQTyne9uq
         qo6UXuw9Tl1/GBj32EGj3LIap9urFd1B/XqllKYEam+YxJo497LxC9zjy8/nSw5EePp+
         +eTBKZdmGQfr6geX7wUMhT4CCCD3mO7jiQymfe+Lmunb33rcE8zgPjAcd50/buLdrdQQ
         9bnsL5XtUBw4F9Fi6tyedO5EQrPi+A5aPqBZPdOy2b1+Ff3KsS3PFzO+Kx9NCH9Pbb1c
         WoTEXunxrarGdYOxcenZSwkjqUc3ErXIt8fD2HMYtGVwPvRSF4vc/2N+BHw58sySAYIH
         JwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708715135; x=1709319935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGPR91nZoa7tVS1EBEScyNLKIJSxk0MXscPE71LEkhE=;
        b=r5vUlRPNFYU5dv3kL9aK3tJtEMAzcm5eBvJkHo/ukx2mR1OYRIM/QKlVM9on2d2AfD
         4hkZ9p5odJlAC0PV45HSAIRaRN5DbRhVQKD7A/FecvKOwzOBNTf/NfWg9RqdJoDprmgY
         K2Jo5eVTjV6rmxAdM+zWlSJLqSUd5y8it04one0CjH9F88daOwYAbjcuGjSInM1pDA6H
         7Kb2sqdgafczqRGyY5bQz85moggTNbwEi5Z/gNl5/LXGSGpqBiLOEUgOQPfZge07+oOS
         I5qGvjOvgju4J4N5WK6y0Bnk8yQ7BlA5qzdslkwx8c2nt8kh2oBTI3ocRFBWndcRekQr
         gOTw==
X-Forwarded-Encrypted: i=1; AJvYcCUe3mLJDCBz+Jx1gjA/QlRteJ7py7yewv3zVWQZUwKu7p9qfx17TGWYbXXjok44RHupxZFxLlSMFbeO2dxPQIcxyGlf
X-Gm-Message-State: AOJu0Yzr0IEnYMSNG8xwS4SPV7e3ZaV0rZcEkaoEXmhJcG3Trq1ARmkE
	jd+Q7OOqNNFsR9uFyjoZLQ2HnG6bU4ThUmv9uKJRgfr6HtD1O9mx
X-Google-Smtp-Source: AGHT+IGjS1AkaywMuTk8INr992MOp6/3JDOJhGJ45idzXcYMXKIJAvKwVB9oG/riCExFEBKTHP6P6Q==
X-Received: by 2002:a0d:db10:0:b0:607:ec66:36b3 with SMTP id d16-20020a0ddb10000000b00607ec6636b3mr693223ywe.19.1708715135042;
        Fri, 23 Feb 2024 11:05:35 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:3e23:8885:4bfd:23ef? ([2600:1700:6cf8:1240:3e23:8885:4bfd:23ef])
        by smtp.gmail.com with ESMTPSA id w22-20020a814916000000b0060895f49c8asm1029727ywa.120.2024.02.23.11.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 11:05:34 -0800 (PST)
Message-ID: <30ffb867-ee0e-4573-b9e7-9fc0f4430adb@gmail.com>
Date: Fri, 23 Feb 2024 11:05:33 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] bpf: struct_ops supports more than one
 page for trampolines.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240221225911.757861-1-thinker.li@gmail.com>
 <20240221225911.757861-3-thinker.li@gmail.com>
 <c59cc446-531b-4b4a-897d-3b298ac72dd2@linux.dev>
 <3e4cc350-34c9-42c1-944f-303a466022d2@gmail.com>
 <7402facf-5f2e-4506-a381-6a84fe1ba841@linux.dev>
 <25982f53-732e-4ce8-bbb2-3354f5684296@gmail.com>
 <b8bac273-27c7-485a-8e45-8825251d6d5a@linux.dev>
 <33c2317c-fde0-4503-991b-314f20d9e7f7@gmail.com>
 <c938c3b1-8cce-4563-930d-7e8150365117@gmail.com>
 <ded8001c-2437-48f4-88ff-4c0633f1da7c@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ded8001c-2437-48f4-88ff-4c0633f1da7c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 2/23/24 10:42, Martin KaFai Lau wrote:
> On 2/23/24 10:29 AM, Kui-Feng Lee wrote:
>> One thing I forgot to mention is that bpf_dummy_ops has to call
>> bpf_jit_uncharge_modmem(PAGE_SIZE) as well. The other option is to move
>> bpf_jit_charge_modmem() out of bpf_struct_ops_prepare_trampoline(),
>> meaning bpf_struct_ops_map_update_elem() should handle the case that the
>> allocation in bpf_struct_ops_prepare_trampoline() successes, but
>> bpf_jit_charge_modmem() fails.
> 
> Keep the charge/uncharge in bpf_struct_ops_prepare_trampoline().
> 
> It is fine to have bpf_dummy_ops charge and then uncharge a PAGE_SIZE. 
> There is no need to optimize for bpf_dummy_ops. Use 
> bpf_struct_ops_free_trampoline() in bpf_dummy_ops to uncharge and free.


Then, I don't get the point here.
I agree with moving the allocation into
bpf_struct_ops_prepare_trampoline() to avoid duplication of the code
about flags and tlinks. It really simplifies the code with the fact
that bpf_dummy_ops is still there. So, I tried to pass a st_map to
bpf_struct_ops_prepare_trampoline() to keep page managements code
together. But, you said to simplify the code of bpf_dummy_ops by
allocating pages in bpf_struct_ops_prepare_trampoline(), do bookkeeping
in bpf_struct_ops_map_update_elem(), so bpf_dummy_ops doesn't have to
allocate memory. But, we have to move a bpf_jit_uncharge_modmem() to
bpf_dummy_ops. For me, this trade-off that include removing an
allocation and adding a bpf_jit_uncharge_modmem() make no sense.

> 
> 
>>>> void bpf_struct_ops_free_trampoline(void *image)
>>>> {
>>>>      bpf_jit_uncharge_modmem(PAGE_SIZE);
>>>>      arch_free_bpf_trampoline(image, PAGE_SIZE);
>>>> }
>>>>
> 

