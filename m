Return-Path: <bpf+bounces-58671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508A4ABFD1D
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 21:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA6D7B300A
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 19:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD4F230BE1;
	Wed, 21 May 2025 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em6N0JJI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A16DDDD2
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747854138; cv=none; b=Rcl/i1fJKx0Rs6PDKAWA95HekZ/bnUNptiMVi/+cH71IjrdfaZvUABz31XqHNrxa8INv0L06r7ft4gJz4n6Z5ubxLETtwp8dCfU95JiBtkFixh4w/bc5+lHn9j3gQ70zImyD3QDw04xV8xgB/z3eD+n4HvfMZWx9YCmOSkFMhoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747854138; c=relaxed/simple;
	bh=y+v6KgOpxOSWkPLBBvXxdpqaPk1WXo7MQBN0ca0iwpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwRzGtl1VCE9BBSB7gsyPridfmBK6irE9DFLlUyYhfqgWOnK/ey3EoKHLsLSKxJ1VQmtMV8hG438KxQlAQWx7WT2hwjACDK05+fw8Dq6fNSIZ46p/LJpmPVKEuSQa8dk3zy7y4k7wez5/xF9n0qe1sa2IaGFZkLIj7Cl6glcyEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=em6N0JJI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso6756427b3a.2
        for <bpf@vger.kernel.org>; Wed, 21 May 2025 12:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747854137; x=1748458937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJnpP+B5SU0HhSHZsITnsIHK5nyl25rKiHYXhhgPlfc=;
        b=em6N0JJIHcpJ7YAObPDOXh+EvxzVh1GaKZryZ5JISpwiP4gzGQYHoR1LZ/MsaRRuDh
         caSusOEej0ghOeOuuDTSh1nrRnCbO1el9udtzSo1mWAqkPSrRnwWoDjQHBv5mrJofPqo
         C01J6vJahidI0iUyt75CxbSXkgnDPUa6ZJEKfux+aCJFL6LDc7GhjZCx2OUSh1bkIxJM
         vBodhmDcTUzwl4U7pWGldwgL9zRM4rg9T/O6DJV47o9i5IBt0Aw0t+zDXxEhksrI8ziJ
         +TY1MAmUUeObqZC91pPeLV9ONW5uveECDo55S4I+3XkwiyWrZ5hm/oqyA1R7h0GqEQDB
         nd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747854137; x=1748458937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJnpP+B5SU0HhSHZsITnsIHK5nyl25rKiHYXhhgPlfc=;
        b=nE17VNgEHCYvVLbnBFmufB8ZJKLjLkmzEs6lQik0lpQ83ovUSwxWREPJ1WqwsCOuf2
         clMaLUIEtKNfuYriFkhu+L5cQjiA24Dp0Vyk06bUAnPMo8WpG8rqvJ+WlR7PBVgQLhsw
         k+wtEjf2QfvjU2jgUlmlB+SG+M7+We1PaqL42b2UESV1SPd65tbsOHH2mwVAMX/USbct
         gExzTfFOwangiMjK0Myzxh+bwh62pE0l72GKwia4t3tuTmySWcyljr/P+C5Y3Tsxa0fL
         AvJF0iPGtfdeUvNEvo+Brhe41Zr+fu3IPCB2OWmRqQo+vAAqmPEpacuhkko7R9dmIXeP
         Ykjg==
X-Forwarded-Encrypted: i=1; AJvYcCWxtLozu6NRT/2EKeUOTpuuTIiwZ7UzYSN9edmDYz6QBtZ7EC1BXmKg6wI+Izl0kBzllO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVsmRUyoF+H5T5gn8iYBzfaZ/0lS0CHxB59tMT0rmQbr2odvQ1
	S7yfx2xUf3jD7peIHPp9pu/Qf+br4VSIsSAFPI2wZgBgt/EREdwzzJiMDo85h+g+
X-Gm-Gg: ASbGncvFaXvHNh6kcQsty2oEOGWqTboObaMTpO27fPkLw5ZPG4FpToq7xaSAPwdwYCT
	08CGsxvMaoZkTSmkUKZ1N8Xzt2wEYOdTQxXGq7AovwrExPCquBamKj28c6hjGIe22E3wn72JD6n
	dFeGfe1qLDVeDOCKIc+SmUQe3D2Y6XvEAU1S801TzmBMVAJ+f/DLnkuRMoQRPG+By09MBHJN4mc
	a4VdcV4Tw7bzUHS6Zyg6fu82xSTW70wsU5QOnc19kj/yySJ5exxcYa8bR3IWmaY39Qq5Y7KHrL4
	7hzX+C0zHjloc2TnO1jB7TJw3J5W81NE3b8kaZko97BSvl8tg0sSdJlqlmR1fj4f5+jgJ90+KJZ
	oVy2pIrZStBgzTLEu
X-Google-Smtp-Source: AGHT+IETsJhUGhcDAQMhV1JgivmDzFPT7jgW49+FNfnMUzHBylE0VgdCUx17OdqLTjoHYVJfJGHBpg==
X-Received: by 2002:a05:6a20:7d9b:b0:1f5:8e33:c417 with SMTP id adf61e73a8af0-2170cb051b7mr33261154637.2.1747854136519;
        Wed, 21 May 2025 12:02:16 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:115c:1:cb3:38cf:dbbe:7f85? ([2620:10d:c090:500::6:8d1a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9739d06sm9979355b3a.83.2025.05.21.12.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 12:02:16 -0700 (PDT)
Message-ID: <6dd9752a-4bec-423d-8936-8757251f2b50@gmail.com>
Date: Wed, 21 May 2025 12:02:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests with stack ptr
 register in conditional jmp
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20250521170409.2772304-1-yonghong.song@linux.dev>
 <20250521170414.2773034-1-yonghong.song@linux.dev>
Content-Language: en-CA
From: Eduard Zingerman <eddyz87@gmail.com>
In-Reply-To: <20250521170414.2773034-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-05-21 10:04, Yonghong Song wrote:

[...]

> @@ -178,4 +178,57 @@ __naked int state_loop_first_last_equal(void)
>   	);
>   }
>   
> +__used __naked static void __bpf_cond_op_r10(void)
> +{
> +	asm volatile (
> +	"r2 = 2314885393468386424 ll;"
> +	"goto +0;"
> +	"if r2 <= r10 goto +3;"
> +	"if r1 >= -1835016 goto +0;"
> +	"if r2 <= 8 goto +0;"
> +	"if r3 <= 0 goto +0;"
> +	"exit;"
> +	::: __clobber_all);
> +}
> +
> +SEC("?raw_tp")
> +__success __log_level(2)
> +__msg("8: (bd) if r2 <= r10 goto pc+3")
> +__msg("9: (35) if r1 >= 0xffe3fff8 goto pc+0")
> +__msg("10: (b5) if r2 <= 0x8 goto pc+0")
> +__msg("mark_precise: frame1: last_idx 10 first_idx 0 subseq_idx -1")
> +__msg("mark_precise: frame1: regs=r2 stack= before 9: (35) if r1 >= 0xffe3fff8 goto pc+0")
> +__msg("mark_precise: frame1: regs=r2 stack= before 8: (bd) if r2 <= r10 goto pc+3")
> +__msg("mark_precise: frame1: regs=r2 stack= before 7: (05) goto pc+0")
> +__naked void bpf_cond_op_r10(void)
> +{
> +	asm volatile (
> +	"r3 = 0 ll;"
> +	"call __bpf_cond_op_r10;"
> +	"r0 = 0;"
> +	"exit;"
> +	::: __clobber_all);
> +}

This was probably a part of the repro, but I'm not sure
this test adds much compared to test below.
The changes do not interact with subprogram calls handling.

> +
> +SEC("?raw_tp")
> +__success __log_level(2)
> +__msg("3: (bf) r3 = r10")
> +__msg("4: (bd) if r3 <= r2 goto pc+1")
> +__msg("5: (b5) if r2 <= 0x8 goto pc+2")
> +__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
> +__msg("mark_precise: frame0: regs=r2 stack= before 4: (bd) if r3 <= r2 goto pc+1")
> +__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r3 = r10")
> +__naked void bpf_cond_op_not_r10(void)
> +{
> +	asm volatile (
> +	"r0 = 0;"
> +	"r2 = 2314885393468386424 ll;"
> +	"r3 = r10;"
> +	"if r3 <= r2 goto +1;"
> +	"if r2 <= 8 goto +2;"

I think it would be good to add two more cases here:
- dst register is pointer to stack
- both src and dst registers are pointers to stack

> +	"r0 = 2 ll;"
> +	"exit;"
> +	::: __clobber_all);
> +}
> +
>   char _license[] SEC("license") = "GPL";

