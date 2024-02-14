Return-Path: <bpf+bounces-21991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD24F854EAF
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E44BB2638C
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 16:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1586B2E3FD;
	Wed, 14 Feb 2024 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deVA/aB4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA15605C1
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928316; cv=none; b=fQSiIcjYusq5z5LoayP83swMDG6BD1aTTo8Yawk5ibmqG6xD1Z3sAUF3vfYygh3p1NvUcVWrG2LNmewEbPfdKY9LcQvUM/W9CtQwimuPqF3UylmSX4A2H+QmWlwaJqk4eIwiOlhQWYwN6iLwgtjN2qMRY7ewxCOW+vYESn09ozE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928316; c=relaxed/simple;
	bh=g19PM8cRPoJtueKez5DmlLoJx1Y5hgGH7svgfpK8/AY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gyokZI7qYoMEIk2YiHI2yCkxODOsL634ewYWR4OKcer8TrQ2vmJ8vlDB9t6NkdAHInUbNg1mZ/0ciGtdSKRdF4ukNyXMFRKuQkWVFPldYmr25dpBrCALVx6DhlyCuZH7UMmxn96GsAJR7DKmoNOmqAANie4cIY/TWahbcqL3lMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deVA/aB4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d731314e67so16027425ad.1
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 08:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707928314; x=1708533114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2oboW/CKHPpAg2XQdudA+becB7j3eGZaZJZmFQFVVnI=;
        b=deVA/aB4j4mdDy+ftpTaDspprQ1DGXYY4NYOPCdLENY7MfmK+T9i/uoL+oNpvloLBb
         ri74egvnYMUjBqH/N6K45nbWXPGlpBiHy0tE/2i/jOVXlxN5uNL14CiOpUyqyyCR0xCT
         Q2BDrYxvmOmwb6e6pn8Ca2TzoVBzMDWxmi6KAvckmGar6wGet4pZ7efqgjaGus5UsE/X
         tsLJaTK0rOlmhU01qPUUTGZbWbrMRHHq6n0B+E0Io6D4pOOZf1QYxzkpUbAqxdT8I3nn
         fRhFnfNmmrwFSa8hWLjiKheiAC5Id79E3Rj5Kqlxs6orhMkoDoqRngzyMdw5VpwLW5yl
         +LmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707928314; x=1708533114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2oboW/CKHPpAg2XQdudA+becB7j3eGZaZJZmFQFVVnI=;
        b=ZWte1eUXdyxRKwQxIMPFVPPuo43wTgTb8JHpF+/iJUNwkr8ejyknTTmjx2mNxxcD2G
         lIpipol1nTqVNL5KPpoef9tomQmjxuZYlbu84chHKyqwxLMwx6KJ8RQkdOJKMTrOQkvN
         wDUaPQnx7mo+fRJM894UdcQ7VtWdTeNZ46BQKRXt/uAflSz44EQsWoedG6ba6wbljWmO
         PWFg9eLrtV0VpvCS5FiLl9PPP2XsvjjKKaX792zFTYL86oJqs/LNVM47GdXmJBrGqZNj
         2TjkRfeShaA8izBTa1bXI6dgR261Ii+c00y6/WSpGONFjxi61pBb9x6n6/ZsOfVYDsr6
         Jywg==
X-Forwarded-Encrypted: i=1; AJvYcCUz+G8zFL/mlM7yyb0xuKuOn2u0wvlCxRjjp9e4jcZMSC7v2LEkY3mZQWC8rEHWHEFgmHjkXLpvRcQtrHuZcHUZXsSE
X-Gm-Message-State: AOJu0YwKuk2760nRgLJrYJXf7c5/Fn49Gx3/WifHIfHzAU5Eb8wKlw3T
	oYWmtoMJiZ7a1GHTR9c7IBDDDmwiMoynmwbG1UnNx9J3avhjrArP
X-Google-Smtp-Source: AGHT+IE0xe7R1FiMFYA0pqvkqIa8p09adRd3mPSF6wSkirpGI+t/h+yz7Yp61yiOusWhKcB7921d6g==
X-Received: by 2002:a17:902:e5d1:b0:1d9:713f:6224 with SMTP id u17-20020a170902e5d100b001d9713f6224mr3341358plf.11.1707928314378;
        Wed, 14 Feb 2024 08:31:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWX4y8OF+A5oYaJKdm3PtaB/dHWtP4XYRchTAPX5i5GPR4ZgdbE3gls2ik2x4UJQ1PMDy1gaTtAPFnTjE8reFKMwNcRDslIFA1cfIA+GCvBBaDI5NxA5pyh0ft4hWrUgyn2h2URI+GqwCXcatDsEuH5IWI8UNKbfqsN3qsWJ5JVCUmx7UxsIxiJmxocZBJLRHNdg+41ggOM+enFcpuLPtKlMDxUvJww/gTjVdu6K+h/lkBo/0FqY/ExRoFUnolyjmROxW5/siXYRP/WRv0yoelCFyuvvpjrxw==
Received: from [172.20.10.5] ([111.65.57.23])
        by smtp.gmail.com with ESMTPSA id iz21-20020a170902ef9500b001db499c5c12sm2175555plb.143.2024.02.14.08.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 08:31:53 -0800 (PST)
Message-ID: <0fe43df3-ca22-46ae-b7b8-ed64144e8c3f@gmail.com>
Date: Thu, 15 Feb 2024 00:31:31 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/4] bpf, x64: Fix tailcall hierarchy
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
References: <20240104142226.87869-1-hffilwlqm@gmail.com>
 <20240104142226.87869-3-hffilwlqm@gmail.com>
 <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com>
 <7af3f9c6-d25a-4ca5-9e15-c1699adcf7ab@gmail.com> <ZcyjENeiN1/7KyHl@boxer>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <ZcyjENeiN1/7KyHl@boxer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/2/14 19:25, Maciej Fijalkowski wrote:
> On Wed, Feb 14, 2024 at 01:47:45PM +0800, Leon Hwang wrote:
>>
>>
>> On 2024/1/5 12:15, Alexei Starovoitov wrote:
>>> On Thu, Jan 4, 2024 at 6:23 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>>>
>>>>
>>>
>>> Other alternatives?
>>
>> I've finish the POC of an alternative, which passed all tailcall
>> selftests including these tailcall hierarchy ones.
>>
>> In this alternative, I use a new bpf_prog_run_ctx to wrap the original
>> ctx and the tcc_ptr, then get the tcc_ptr and recover the original ctx
>> in JIT.
>>
>> Then, to avoid breaking runtime with tailcall on other arch, I add an
>> arch-related check bpf_jit_supports_tail_call_cnt_ptr() to determin
>> whether to use bpf_prog_run_ctx.
>>
>> Here's the diff:
> 
> This is diff against your previous proposed solution, would be good to see

The previous proposed solution is buggy, when I have a deep analysis.

> how it currently looks being put together (this diff on top of your
> patch), would save us some effort to dig the patch up and include diff.
> 

But, we can not apply this patch with this diff. It's because it breaks
the runtime with tailcall of bpf progs, whose runtime entry is not
__bpf_prog_run(), e.g. trampoline-based fentry/fexit/fmod_ret.

So, is there any other bpf prog types whose runtime entry is not either
__bpf_prog_run() or trampoline?

I'd like to fix them in PATCH v2.

Thanks,
Leon

