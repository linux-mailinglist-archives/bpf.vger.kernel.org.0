Return-Path: <bpf+bounces-58248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0CCAB77EC
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 23:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E3016809C
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 21:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E05296D27;
	Wed, 14 May 2025 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M6hEuVsk"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D67235C01
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747258004; cv=none; b=fnxF41m77STt+6djLFcXAASTDRfjWgNNcDecOGuoZtSFk+CPJpCa3hQUgJTjZHjJ2ATnsErIVzZX9gpyrI9DeGJ+wd/rsP+QcwsaGsW1xRN/zupw4vNOn/8cAHwf5j3bazBp97wvlUnRXhqKfVb0oUhwECtXTaUADUlpnVgAP+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747258004; c=relaxed/simple;
	bh=hgMuj11rOVtUZ4pdaD+eUZQlQZM5AsaOz0R+NeXIiQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEJbcpO4v8/FB1loIuIhWF5o//X7Co8SWAWTTIYwoiyvWLrgg0ZGur+tjw+crzzGI0wu+Q2dI5KVkIJ376+Y2B/FHRRbGbuI79dLBDtEa3gNzc5M1kPYiWCgX5ctfeHZKqTmFHSVt3iV8gHPe2RkCiQGpWZLkEwVOsuL/mHmKwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M6hEuVsk; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ab1d5047-7926-43ae-9dd7-0824b75af8b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747257998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zwv6aq+V9iioQUI2Y3sV3yr3/1+Ps91hWUk1quQUozg=;
	b=M6hEuVsksDKKJYZE0ChgmbrnWbeRTUTly23MQxK0VnE9BHzBEaKtsv05IGHdQZplfUs1f7
	zKjLa3qMD+fSsl2e62wx8QNSonrM9UUf2lxaIKZxammVsoLKiOvyPYTXLbkoppbVRsntbc
	LmYXViW8vragBDp2SYXIsMo23U0ujmo=
Date: Wed, 14 May 2025 14:26:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Pass the same orig_call value to
 trampoline functions
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250512221911.61314-1-iii@linux.ibm.com>
 <20250512221911.61314-2-iii@linux.ibm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250512221911.61314-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/12/25 1:57 PM, Ilya Leoshkevich wrote:
> There is currently some confusion in the s390x JIT regarding whether
> orig_call can be NULL and what that means. Originally the NULL value
> was used to distinguish the struct_ops case, but this was superseded by
> BPF_TRAMP_F_INDIRECT (see commit 0c970ed2f87c ("s390/bpf: Fix indirect
> trampoline generation").
> 
> The remaining reason to have this check is that NULL can actually be
> passed to the arch_bpf_trampoline_size() call - but not to the
> respective arch_prepare_bpf_trampoline()! call - by
> bpf_struct_ops_prepare_trampoline().
> 
> Remove this asymmetry by passing stub_func to both functions, so that
> JITs may rely on orig_call never being NULL.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   kernel/bpf/bpf_struct_ops.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index db13ee70d94d..96113633e391 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -601,7 +601,7 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
>   	if (model->ret_size > 0)
>   		flags |= BPF_TRAMP_F_RET_FENTRY_RET;
>   
> -	size = arch_bpf_trampoline_size(model, flags, tlinks, NULL);
> +	size = arch_bpf_trampoline_size(model, flags, tlinks, stub_func);

The change looks ok but not sure why it is needed.

I can see why stub_func is needed to generate the final image in 
arch_prepare_bpf_trampoline() in x86. The "arch_bpf_trampoline_size()" here is 
generating a temporary image, so NULL or not doesn't seem to matter.

Does the s390 jit need to use the actual stub_func address somewhere in the 
temporary and/or final image?


