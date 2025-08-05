Return-Path: <bpf+bounces-65084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE272B1B995
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 19:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C777ABC29
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970BE293C58;
	Tue,  5 Aug 2025 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dGyqXx4D"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABEB295504
	for <bpf@vger.kernel.org>; Tue,  5 Aug 2025 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754415972; cv=none; b=aK4SQFkPmEKwUHAXwQYP8MQrrv9hUyMI+NnvZ2ZO3BNoVWbNTcVFocI4TZXoADi1deONlOOkF8RlysNPZn5Mnx95rXx0HAz+zRXKLOHfxJPJZeQgea3Gb0be0A5BVwxxR3ap4exYa9meZmg3Ae0dpDa9sJpdkgltxR0L5WO+/w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754415972; c=relaxed/simple;
	bh=TAtqdH6g+0GPQAE6XOPxZfUxVtK3bhrslMB7vMoFjHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tluouLdjpkTgptaNc+2S8HDHFIHzKaBH/YWlPs3M3tlgdxUH5IIaswcRNezFO+5VvGbgyh1YEVvXuoCiRalm7TGL/CXvfPPMuFwd5fcWSNrwxbb8MaHjm/z8WVCB2+gX7kXryBGyXdw1E6wEMZDc3LwokTHq2/92LWRW5R+bu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dGyqXx4D; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <401418b7-248c-42a3-ba74-9b2b2959e36c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754415958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3rfMSumMtyl2b10v3W+AWdRsEKtJ/myNuGbCChJRY8=;
	b=dGyqXx4DRjy4GMTborzjJWZldSqsxzsvKcWNm0+3sP5MbUbpQxWR/+uZ2xQSSgJwQbyhHC
	n2LVmxOHMC1IjY0qTr0wCIev3MdiNLaBilsG+3BFQLcZ7MEX0wRRUPqLplf81HWm+9Rw2u
	HnV6UBwK0rdr/bRsC00eIJc777ZrdIU=
Date: Tue, 5 Aug 2025 10:45:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/1] bpf: Allow fall back to interpreter for
 programs with stack size <= 512
Content-Language: en-GB
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mrpre@163.com, mannkafai@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
References: <20250805115513.4018532-1-kafai.wan@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250805115513.4018532-1-kafai.wan@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/5/25 4:55 AM, KaFai Wan wrote:
> OpenWRT users reported regression on ARMv6 devices after updating to latest
> HEAD, where tcpdump filter:
>
> tcpdump -i mon1 \
> "not wlan addr3 3c37121a2b3c and not wlan addr2 184ecbca2a3a \
> and not wlan addr2 14130b4d3f47 and not wlan addr2 f0f61cf440b7 \
> and not wlan addr3 a84b4dedf471 and not wlan addr3 d022be17e1d7 \
> and not wlan addr3 5c497967208b and not wlan addr2 706655784d5b"
>
> fails with warning: "Kernel filter failed: No error information"
> when using config:
>   # CONFIG_BPF_JIT_ALWAYS_ON is not set
>   CONFIG_BPF_JIT_DEFAULT_ON=y
>
> The issue arises because commits:
> 1. "bpf: Fix array bounds error with may_goto" changed default runtime to
>     __bpf_prog_ret0_warn when jit_requested = 1
> 2. "bpf: Avoid __bpf_prog_ret0_warn when jit fails" returns error when
>     jit_requested = 1 but jit fails
>
> This change restores interpreter fallback capability for BPF programs with
> stack size <= 512 bytes when jit fails.
>
> Reported-by: Felix Fietkau <nbd@nbd.name>
> Closes: https://lore.kernel.org/bpf/2e267b4b-0540-45d8-9310-e127bf95fc63@nbd.name/
> Fixes: 6ebc5030e0c5 ("bpf: Fix array bounds error with may_goto")
> Fixes: 86bc9c742426 ("bpf: Avoid __bpf_prog_ret0_warn when jit fails")
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---
>   kernel/bpf/core.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 5d1650af899d..2d86bd4b0b97 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2366,8 +2366,8 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
>   					 const struct bpf_insn *insn)
>   {
>   	/* If this handler ever gets executed, then BPF_JIT_ALWAYS_ON
> -	 * is not working properly, or interpreter is being used when
> -	 * prog->jit_requested is not 0, so warn about it!
> +	 * or may_goto may cause stack size > 512 is not working properly,
> +	 * so warn about it!
>   	 */
>   	WARN_ON_ONCE(1);
>   	return 0;
> @@ -2478,10 +2478,10 @@ static void bpf_prog_select_func(struct bpf_prog *fp)
>   	 * But for non-JITed programs, we don't need bpf_func, so no bounds
>   	 * check needed.
>   	 */
> -	if (!fp->jit_requested &&
> -	    !WARN_ON_ONCE(idx >= ARRAY_SIZE(interpreters))) {
> +	if (idx < ARRAY_SIZE(interpreters)) {
>   		fp->bpf_func = interpreters[idx];
>   	} else {
> +		WARN_ON_ONCE(!fp->jit_requested);
>   		fp->bpf_func = __bpf_prog_ret0_warn;
>   	}

Your logic here is to do interpreter even if fp->jit_requested is true.
This is different from the current implementation.

Also see below code:

static unsigned int __bpf_prog_ret0_warn(const void *ctx,
                                          const struct bpf_insn *insn)
{
         /* If this handler ever gets executed, then BPF_JIT_ALWAYS_ON
          * is not working properly, or interpreter is being used when
          * prog->jit_requested is not 0, so warn about it!
          */
         WARN_ON_ONCE(1);
         return 0;
}

It mentions to warn if the interpreter is being used when
prog->jit_requested is not 0.

So if prog->jit_requested is not 0, it is expected not to use interpreter.


>   #else
> @@ -2505,7 +2505,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>   	/* In case of BPF to BPF calls, verifier did all the prep
>   	 * work with regards to JITing, etc.
>   	 */
> -	bool jit_needed = fp->jit_requested;
> +	bool jit_needed = false;
>   
>   	if (fp->bpf_func)
>   		goto finalize;
> @@ -2515,6 +2515,8 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>   		jit_needed = true;
>   
>   	bpf_prog_select_func(fp);
> +	if (fp->bpf_func == __bpf_prog_ret0_warn)
> +		jit_needed = true;
>   
>   	/* eBPF JITs can rewrite the program in case constant
>   	 * blinding is active. However, in case of error during


