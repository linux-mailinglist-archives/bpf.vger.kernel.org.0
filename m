Return-Path: <bpf+bounces-19301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A4D8291AF
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 02:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DCA1F26A2D
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 01:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196691375;
	Wed, 10 Jan 2024 01:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OPz5YvOd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B42D1370
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 01:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bc09844f29so3171420b6e.0
        for <bpf@vger.kernel.org>; Tue, 09 Jan 2024 17:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704848538; x=1705453338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y1fzYemH9fFciZRIvh4hleplwmDRBtVTD60UfU5JDgM=;
        b=OPz5YvOdpy9JmjYAzRj7g9Y+6L93pPSkjkcRmQnySFncKR7I1P1EOxJGz3kEze/kH1
         3gY/8tze06RCJun3qrwZkSrXqqdMIfQNWzFOKXXQjz6p9B2GmjQKYEQqxm6KAVNB8+BB
         3w3ie3bFCBwbkXvOPxqZDuqSktWS4+UXlscQ87b2F0HREUvEww9kWUwiPBK51RYXri2u
         WVAfnJZ0Ym0BZKR87QKi+I8xUYK67K6lCSPJKiPJ1tLFp4/9o3HervsjeDDpu+hxYbFz
         Ii1tffbXj/gTKOgq648X4hT7qLocISzju54IPTjBVPM/8yfWFGzgfOpJAQtUihDd3R2K
         N6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704848538; x=1705453338;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1fzYemH9fFciZRIvh4hleplwmDRBtVTD60UfU5JDgM=;
        b=cDoMKcSBkX/u8auxvEC/89V4tuWhNc/nAulhnQUoKK+OMXemQiC3mouDxN/QF5pi+C
         2RuAljf5IsCTbAStnthlAYvlwRXGZyUdYjJ2y2HXkwWBXJ7CaN35YykCnr5PnO8yhoV1
         z0QfXCiUIvPTX51eidKKdKZmTIy+eg7VWTqSw8NRe8h3C+Bb++v58dEnfOVhJTO76Eeg
         F2eX7EJ/u6u8JkDEhxghJyeus0E4Z7qr58yXGM8uZz1VBlBdqP2r+c+iMsB6BnDKj3bB
         eCVd0BrhgVN5GSaCAezN/44zWK0JgyZZP7r0CeOqB5dKE2LfiTUqKnNnzBKAFJENTZ0X
         9/lw==
X-Gm-Message-State: AOJu0Yz17V19848IUlXV4an9Jk0moyVfj/31O/O/FKBGYYc0yix2tGK/
	2Di5tizKIC8UhvPzQU3oMSO9TAIRNtmO
X-Google-Smtp-Source: AGHT+IFdj4lMnQfLOflL7KI8L/s5vapJrYGJD1GResrjGMHSg+OsMCYr4z4A/VwDd+zNa3SKCFjf1g==
X-Received: by 2002:a05:6808:1815:b0:3bd:4640:37aa with SMTP id bh21-20020a056808181500b003bd464037aamr341794oib.91.1704848538233;
        Tue, 09 Jan 2024 17:02:18 -0800 (PST)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id b10-20020a0ce88a000000b00680aed3b8ddsm1315542qvo.107.2024.01.09.17.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 17:02:17 -0800 (PST)
Message-ID: <781a86b1-c02b-4bb8-bc79-bfbd4f2ff146@google.com>
Date: Tue, 9 Jan 2024 20:02:16 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add inline assembly
 helpers to access array elements
Content-Language: en-US
From: Barret Rhoden <brho@google.com>
To: Yonghong Song <yonghong.song@linux.dev>, Eddy Z <eddyz87@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, mattbobrowski@google.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240103185403.610641-1-brho@google.com>
 <20240103185403.610641-3-brho@google.com> <ZZa1668ft4Npd1DA@krava>
 <f3dd9d80-3fab-4676-b589-1d4667431287@linux.dev>
 <e5e52e0a-7494-47bb-8a6a-9819b0c93bd8@google.com>
In-Reply-To: <e5e52e0a-7494-47bb-8a6a-9819b0c93bd8@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/4/24 16:30, Barret Rhoden wrote:
[snip]
>>
>> The LLVM bpf backend has made some improvement to handle the case like
>>    r1 = ...
>>    r2 = r1 + 1
>>    if (r2 < num) ...
>>    using r1
>> by preventing generating the above code pattern.
>>
>> The implementation is a pattern matching style so surely it won't be
>> able to cover all cases.
>>
>> Do you have specific examples which has verification failure due to
>> false array out of bound access?
> 
[ snip ]

> 
> I'll play around and see if I can come up with a selftest that can run 
> into any of these "you did the check, but threw the check away" scenarios.

I got an example for this, and will include it in my next patch version, 
which I'll CC you on.

If we can get the compiler to spill the register r1 to the stack (L11 in 
the asm below), it might spill it before doing the bounds check.  Then 
it checks the register (L12), but the verifier doesn't know that applies 
to the stack variable too.  Later, we refill r1 from the stack (L21).

The reason for the spill was that I made another bpf_map_lookup_elem() 
call (L19), which needed r1 as an argument.

11: (63) *(u32 *)(r10 -8) = r1        ; 
R1=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R10=fp0 
fp-8=????scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))

12: (35) if r1 >= 0x64 goto pc+13     ; 
R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=99,var_off=(0x0; 0x7f))

13: (b4) w1 = 0                       ; R1_w=0

14: (63) *(u32 *)(r10 -4) = r1        ; R1_w=0 R10=fp0 fp-8=0000mmmm

15: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0

16: (07) r2 += -4                     ; R2_w=fp-4

17: (18) r1 = 0xffffc9000011edf0      ; 
R1_w=map_ptr(map=arraymap,ks=4,vs=400)

19: (85) call bpf_map_lookup_elem#1   ; 
R0_w=map_value_or_null(id=2,map=arraymap,ks=4,vs=400)

20: (15) if r0 == 0x0 goto pc+5       ; 
R0_w=map_value(map=arraymap,ks=4,vs=400)

21: (61) r1 = *(u32 *)(r10 -8)        ; 
R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) 
R10=fp0 fp-8=mmmmmmmm


Thanks,
Barret



