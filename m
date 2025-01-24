Return-Path: <bpf+bounces-49639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6D7A1AED9
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 03:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D23416B691
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 02:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1BB1D54EF;
	Fri, 24 Jan 2025 02:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXgoiQEG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF528EA;
	Fri, 24 Jan 2025 02:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737686963; cv=none; b=WT1kzulmE+a2Fwd9D4OMK9y8SPL0ufnw75N6n6SiK7JeyEV4xYPcLa01pvFJRAeCcsHg2kW0HcCiNWflMnC4bGAoE3IqM774lIbXODoU3fr8xCQLh5R9/L1LbBJkYtIE/GBd8WTyQjPRRWbcNCfLaox+ng37yVQqA1Q5CdwOUgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737686963; c=relaxed/simple;
	bh=uTaJvVZEyS41kDvx4qBjwEfBb3HfIje2Mg9A3OEiXdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cmAfpQCxKOBBjxf73qDwrqMr5Wnt2LJegRtvglFC4ohsUq+SIX94iGMbOj3XGbIvBHZVdq4lEa2kfsOz/YZSZjrbnDb4VHYxejJ5gaDYkuoQ8iAXQf4VPSaVmciCLEO/Ev8JdLI8kRI0uuuR7PLl4zYHpMc+vVAZOSUP9CqVYxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXgoiQEG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2166f1e589cso39425115ad.3;
        Thu, 23 Jan 2025 18:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737686962; x=1738291762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+P7BfKeGcBPfCTs4gJli3q0Ab4Tw87izmoTl0CsKCbE=;
        b=eXgoiQEGI+1kBdt3Zz+wAuzcBH5hb5H8XYXasLp323BdJFO7OAuat3WFYPyFnVrjV5
         Agi5KzLjceQveBE+wTBC5mLMBTI2OeZ9HIpXjodVeuLrxzfkyZy6v2cXFMj8MH17MmG+
         JoxAjAsfBc3f1Rq7xyKTCFDl+N7fpdcpdcrxSg9n6cyIZquhLnMgfeHROUR1m6wylob7
         OK1rPqH73eFU7uwwWLgXan3oF39PpVW4ynBMZedgBMaRNLjzXogRN1Ov0vIL7bVEetwZ
         +Jx2C76cf5+4hM1ZRA/cPcUz7LWbDfYjBE8+B465wFqi9OAplnYHa/pdy94sZWXjbcBb
         HZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737686962; x=1738291762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+P7BfKeGcBPfCTs4gJli3q0Ab4Tw87izmoTl0CsKCbE=;
        b=KGlY/SargcHgVvuYwY2jl65FjYzefZ9WcKDvBZ9LLbzYf9u8CPMCmIX03+xqFzIjRr
         vKLZITxvxI6so7Yuezey4JIh9q+jF3Cvb14OAxueqVQBRRLJhFSr8BBhyE0nR37s2+O3
         oAQ0zLIPgiVOWLY+6tna6Ykibn+5ClYXuv3nSjGjPfNge3pwbiHsR4XCM0v7ge0Obg9J
         aewG7zI1qYuTY6dmsJQnyD0g3ZZ95jng1AWFXzW2a2og1bsGUW2NXfdP93pM8MALebnE
         7ppNq0t+iLAmHB+Rt7zen2ah2Spk+qqOtwaVrM13IZuxrnpMHhb5kIKP7HzfTf3H4oPa
         qtGw==
X-Forwarded-Encrypted: i=1; AJvYcCXwxNqAcX2L88VQ3ccQtphUhL7eaGy9j0vtGkFaECENNqnsZ9X/28jv8bC6GiswzGib/4PrEfdBIcU0yjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4/nLfwDjZdq2bVcdrO5QqeoNbU0ojeOfpniKP9BZTHNqxKCtl
	Dc5w+EN+Q7ofTJpdearYhilhfNxe2fpof5tJnVe8RwZKvsRihffB
X-Gm-Gg: ASbGncvrm6qJtXQ7O98GmvWT3Jxb2AzdfzON4JcPT9PugoA+6hIlALZk8gNRxc9KoOd
	HTdSXnTJQkVUPcA9U8uymyOY3qqlVROKrOMsPi9uh8+oBFKkL7FrcqajP/SsPKVlAeEoiJyUWoO
	rjczy0UILyhrOAhL0rIv6wdiDOsUlfuIwspaoOdxUX/o5tjNi+PfoXamwNxJRCzfgy0mbF3kGfS
	ZT5Eff1xBk7pSLBcWQ6ecKCzVQ+hBfwEVIA/4HF666sVbLoKltofCrrMybFK4lupCG76BPVaYXY
	Tn9nhlUKcVOq9OQAWXIUr89S
X-Google-Smtp-Source: AGHT+IE5ERuR9TbMnrMgVeeGMQAf0G2KUtyxEolz/khgT0F28xyPAbF07OQdlhxx9SwDtSf7bp3c5A==
X-Received: by 2002:a17:903:22d0:b0:215:63a0:b58c with SMTP id d9443c01a7336-21c356780cfmr380494655ad.46.1737686961412;
        Thu, 23 Jan 2025 18:49:21 -0800 (PST)
Received: from [172.23.160.121] ([183.134.211.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414d9e9sm5918865ad.171.2025.01.23.18.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 18:49:20 -0800 (PST)
Message-ID: <20ad3071-2140-470e-90c0-96fc8f74ff2d@gmail.com>
Date: Fri, 24 Jan 2025 10:49:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/2] Add prog_kfunc feature probe
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, haoluo@google.com,
 jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250123170555.291896-1-chen.dylane@gmail.com>
 <3955701be6b7f068d50a5bef2bbe74b97e285621.camel@gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <3955701be6b7f068d50a5bef2bbe74b97e285621.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/1/24 08:42, Eduard Zingerman 写道:
> On Fri, 2025-01-24 at 01:05 +0800, Tao Chen wrote:
>> More and more kfunc functions are being added to the kernel.
>> Different prog types have different restrictions when using kfunc.
>> Therefore, prog_kfunc probe is added to check whether it is supported,
>> and the use of this api will be added to bpftool later.
>>
>> Change list:
>> - v1 -> v2:
>>    - check unsupported prog type like probe_bpf_helper
>>    - add off parameter for module btf
>>    - chenk verifier info when kfunc id invalid
>>
>> Revisions:
>> - v1
>>    https://lore.kernel.org/bpf/20250122171359.232791-1-chen.dylane@gmail.com
>>
>> Tao Chen (2):
>>    libbpf: Add libbpf_probe_bpf_kfunc API
>>    selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests
>>
>>   tools/lib/bpf/libbpf.h                        | 17 ++++++-
>>   tools/lib/bpf/libbpf.map                      |  1 +
>>   tools/lib/bpf/libbpf_probes.c                 | 47 +++++++++++++++++++
>>   .../selftests/bpf/prog_tests/libbpf_probes.c  | 35 ++++++++++++++
>>   4 files changed, 99 insertions(+), 1 deletion(-)
>>
> 
> Hi Tao,
> 
> Looks like something is wrong with the way the patch was generated:
> - patchwork link:
>    https://patchwork.kernel.org/project/netdevbpf/patch/20250123170555.291896-2-chen.dylane@gmail.com/
> - error message:
>    https://github.com/kernel-patches/bpf/pull/8395
> 
>      Cmd('git') failed due to: exit code(128)
>        cmdline: git am --3way
>        stdout: 'Applying: libbpf: Add libbpf_probe_bpf_kfunc API
>      Patch failed at 0001 libbpf: Add libbpf_probe_bpf_kfunc API
>      When you have resolved this problem, run "git am --continue".
>      If you prefer to skip this patch, run "git am --skip" instead.
>      To restore the original branch and stop patching, run "git am --abort".'
>        stderr: 'error: corrupt patch at line 103
>      error: could not build fake ancestor
>      hint: Use 'git am --show-current-patch=diff' to see the failed patch'
> 
> I get the same error when trying to apply locally,
> could you please double check?
> 
> Thanks,
> Eduard
> 

Hi, Eduard, thank you for your reply, i tried it out, and it turns out 
it's really my problem. I will resend it in v3.

-- 
Best Regards
Dylane Chen

