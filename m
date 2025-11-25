Return-Path: <bpf+bounces-75440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2F7C84B3B
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 12:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02B93B0D22
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 11:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E751314B86;
	Tue, 25 Nov 2025 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+WoOOhe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18EA26CE3B
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069635; cv=none; b=kIuEQpbs5bTj7JxBCcgNovvnwDDtendsis4dpm8x/NRyZ9IXqCQgdiT5HwHBdMdX2eoCYOhslVxvQKaq3ZgaEXH23oQ1/Gi/C6Sms4KYHExPg1zm/6LcjUMejwtZS+a/hS9BjjB0JlS4FJaIga1/cXMZkQQQfCT5el5Sdu+xFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069635; c=relaxed/simple;
	bh=a4+h+unp3TP1oyr0yJ3XjFYwuxew3KdwZUR593H/1O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgaEchmPGfdz4sS3pAsJ9tThnfImad3nbLIPbTITdjoCwV6e4OlSNrofsohbnbqIjAXUm5LHcbuuW2pnJvVpOXK1CPZlHd8dbnBWck+w793uKKUbQ0SGVEHpXvBwzcttqFG3qAaIMkRVCHBpWLhJs5r2jdQbJRd5K6f1wjjcnrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+WoOOhe; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7c66822dd6dso1751975b3a.0
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 03:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764069632; x=1764674432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVhOQpkFhqqTf3BtOV6vobGzp0Wpfer3ElYSjbBrdyo=;
        b=j+WoOOhe0UpTZ/8/sOF3ccO+YV+LpBsOELWZTOEeNIwMYCCPkVUmN6xd47eqM4RPA8
         AsR+eIG2+0fheyMrJkzTKLEGNsGDXPj0xwLyfXIjmfNl2rtRDUH1lxqlL1+SUjMB1T3F
         RorpWQQ9LsHnS3Vu5i3xdITgVzT9AF7lFBBJyGopVwSRTury1sS0jz31suLT6fBmT6/0
         enuYL/j/FrUckry8sTJcLPQOma3+L1BHzOVUGRsI4GpD736UQzABXZiF6vmf8Kq5EnnE
         MLco88n8zLTvecRvttmUb9f232prbTo3aM/NyheIHVYxiPCsp6/gl5Fym+v0p/kaUCV1
         +7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764069632; x=1764674432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVhOQpkFhqqTf3BtOV6vobGzp0Wpfer3ElYSjbBrdyo=;
        b=HfzdTALaINXgQSfHamgnorNXW2g6oaHmZSRW0QnqMbaGr9KNGvOiOVAjUE4EMbdlun
         kPqojLGbp/XT2ROTTzL7KIxZ/UFlboLdLzqpyCdz73ZCXDTsA+wcBLP2kAmm5q+voWVD
         k0fVy8DEyf8yISabFw+3HenE2YKB/0yPERgBCxlTe0T+qw7CFMmuLPnBDjCCpDdzztJH
         IVw8Hqze8D2wnD+XsaPXj840bX1wZmreunFaN3Lyx09Q143q0JveUSNT/oTLrk6Z+OgP
         2wZu87JSFUNeyQ5XMpkkuRioyWpxJe4DB0CAGJxyQJ6Xl2XFGpbOkqcPZ5H9intToams
         E9tA==
X-Forwarded-Encrypted: i=1; AJvYcCWSvlj6O/rHOQ8eCbZtCCqMPlATgNa7LVvZ9Uvcqrzk5Zl1WXuRTd6uRhgY94IcdyRAk1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyojlYUdqiiFwaI3OAI/MQYMbUTeNfppaPmcbaF12rS0XpHT1z1
	maeUZ11PBqN4U1MSsWph8Uv5WyEjZ5uK9bJHusfepgKoOEeKpRbFfjJ2
X-Gm-Gg: ASbGncuYovFFRIMTvNye+5O4t8HtbsvwcOV7aZBKGHMUuNI0S7arX/NBDv4jEakwdES
	tVc6C5da+FeoagmuG2Zxh90G4nDb6apcySp4qeccRVIUMHM3FHyWQHcPI9icpIZ8f/hN301+9vo
	ZRJrrYVk77sSK/JzB1Xmt/A/W1O0h8ctruCOquCsf6xpacg670cwkYA0c0udSQU6oipLCmrs0SY
	lLqho6Vudr6Z9e0ESna5bF0l8IHXUqBPe2hPDXNxzPO83+OxPVm90BDEvvBGuTqYjQKVaVlYu3T
	DUksI8ay5ZcKUo30kE/0Uu93u2bmSxwmfH5hJSQk73lWWoCoUJexXJZqxatkgjP7xo/8NZ2Gg7M
	Zh2VuAm4bSMc+CWWqgEDp2fl0zLNBmk9DwBcLDcIRvKCtl/mLZkoB3gMPApJuEfgcHloWAQfg7M
	Ea7V6+es4+RSlLY/EerxdI1htvmadR2tqhnlgekAEEkvSbRBcR2TUQ8l2csCPYUKGzbPlaxquYo
	N3tYjU9c/GFyOBj
X-Google-Smtp-Source: AGHT+IHceA3bqsPjmyCa2TPF6zTj0bq2CPgSfhCVMko2nEB7fZ8pj+ZsS/cB9USjHK3Gmjz3R3UxLg==
X-Received: by 2002:a05:6a21:99a5:b0:35f:31bb:5a5d with SMTP id adf61e73a8af0-3614f227b8fmr16367798637.2.1764069631818;
        Tue, 25 Nov 2025 03:20:31 -0800 (PST)
Received: from [172.16.132.48] ([119.161.98.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ecf7d70asm17822575b3a.13.2025.11.25.03.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 03:20:31 -0800 (PST)
Message-ID: <8e1ff2f1-b45e-4b1f-b545-d433e277607f@gmail.com>
Date: Tue, 25 Nov 2025 16:50:23 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/seccomp: fix pointer type mismatch in UPROBE
 test
To: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, llvm@lists.linux.dev, khalid@kernel.org,
 david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Jiri Olsa <olsajiri@gmail.com>, sam@gentoo.org
References: <aP0-k3vlEEWNUtF8@krava>
 <20251026091232.166638-2-nirbhay.lkd@gmail.com>
Content-Language: en-US
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
In-Reply-To: <20251026091232.166638-2-nirbhay.lkd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/25 2:42 PM, Nirbhay Sharma wrote:
> Fix compilation error in UPROBE_setup caused by pointer type mismatch
> in the ternary expression when compiled with -fcf-protection. The
> probed_uprobe function pointer has the __attribute__((nocf_check))
> attribute, which causes the conditional operator to fail when combined
> with the regular probed_uretprobe function pointer:
> 
>    seccomp_bpf.c:5175:74: error: pointer type mismatch in conditional
>    expression [-Wincompatible-pointer-types]
> 
> Cast both function pointers to 'const void *' to match the expected
> parameter type of get_uprobe_offset(), resolving the type mismatch
> while preserving the function selection logic.
> 
> This error appears with compilers that enable Control Flow Integrity
> (CFI) protection via -fcf-protection, such as Clang 19.1.2 (default
> on Fedora).
> 
> Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
> ---
>   tools/testing/selftests/seccomp/seccomp_bpf.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 874f17763536..e13ffe18ef95 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -5172,7 +5172,8 @@ FIXTURE_SETUP(UPROBE)
>   		ASSERT_GE(bit, 0);
>   	}
>   
> -	offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
> +	offset = get_uprobe_offset(variant->uretprobe ?
> +		(const void *)probed_uretprobe : (const void *)probed_uprobe);
>   	ASSERT_GE(offset, 0);
>   
>   	if (variant->uretprobe)

Hi all,

I'm following up on this patch that fixes the pointer type mismatch in
UPROBE_setup when building with -fcf-protection. It resolves the
incompatible-pointer-types error seen with Clang 19.

Please let me know if there are any comments or some changes needed.

Thanks,
Nirbhay Sharma



