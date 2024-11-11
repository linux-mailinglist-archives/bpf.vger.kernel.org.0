Return-Path: <bpf+bounces-44528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8932E9C4285
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 17:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E5E1F23E48
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56FD1A071C;
	Mon, 11 Nov 2024 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a4+7fOH8"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A96954728
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731342118; cv=none; b=YfO8k8i3w24SIjhWcVsFxPFJdSQxGf0yc2LW5MijQWn/e7H/xp0IJu5X4n49N7hjVidpCB631Cd4UuPUOE5Gtv1HDm9p1Kxzz3QS3JughngPMPxguxnuPmRywN6ZdPXTeAl7BSqXgWes/YSuGWurvS8ZpaSbttnSQvUxvYsP9CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731342118; c=relaxed/simple;
	bh=XulLSXLOSWzhZwJrpywVHrCwfeA088N5ljiB+NZtPBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+2p1N1u84mWJPDx4NGqpcsvObZFXR5KAMvxzPTJcYiMBTIqZOh8uLiG/5kX9QmpTkq+o+3VxAH/8Yoy32vV38gG9v8QrCIsGmglEy+WAW0MERsJeW/n+3X9XIj9iKez3buPywXR47v9Oivc8MKjZQmPRLkpK8rh61xMwJE3IPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a4+7fOH8; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e6d27adb-151c-46c1-9668-1cd2b492321b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731342114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZT3RbCRXBHxXEQlTTWxDvrCJixuMw29drHdutEN1wOY=;
	b=a4+7fOH804lPTA220vTLYn82ssbezjKcuvoxaCZnrsUz8vLy2jU/L1kqdH4nwu5b1grSg7
	DwYzqyD1nuugc1jG3+6818g7QpZo07rcNJtDPWxR+esd6eMk0SfbYbtKEYq1MB8AcXU81m
	NnB+w9yOyFINwxUfCv6HJwrFFgBlEp0=
Date: Mon, 11 Nov 2024 16:21:47 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ARC: bpf_jit_arcv2: Remove redundant condition check
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
 ast@kernel.org, andrii@kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shahab Vahedi <list+bpf@vahedi.org>,
 Vineet Gupta <vgupta@kernel.org>, bpf@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241111142028.67708-1-hardevsinh.palaniya@siliconsignals.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241111142028.67708-1-hardevsinh.palaniya@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/11/2024 14:19, Hardevsinh Palaniya wrote:
> The condition 'if (ARC_CC_AL)' is always true, as ARC_CC_AL is a constant
> integer. This makes the check redundant, so it is safe to remove.
> 
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> ---
>   arch/arc/net/bpf_jit_arcv2.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/arc/net/bpf_jit_arcv2.c b/arch/arc/net/bpf_jit_arcv2.c
> index 4458e409ca0a..19792ce952be 100644
> --- a/arch/arc/net/bpf_jit_arcv2.c
> +++ b/arch/arc/net/bpf_jit_arcv2.c
> @@ -2916,10 +2916,7 @@ bool check_jmp_32(u32 curr_off, u32 targ_off, u8 cond)
>   	addendum = (cond == ARC_CC_AL) ? 0 : INSN_len_normal;
>   	disp = get_displacement(curr_off + addendum, targ_off);
>   
> -	if (ARC_CC_AL)
> -		return is_valid_far_disp(disp);
> -	else
> -		return is_valid_near_disp(disp);
> +	return is_valid_far_disp(disp);
>   }
>   
>   /*

The original code is obviously optimized out, but the intention, I
believe, was to check if the jump is conditional or not.

So the proper fix should change the code to check cond:

-	if (ARC_CC_AL)
+	if (cond == ARC_CC_AL)



