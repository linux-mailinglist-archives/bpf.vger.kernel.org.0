Return-Path: <bpf+bounces-78864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3E6D1E032
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 11:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 929EE3042FF5
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 10:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3545F38A280;
	Wed, 14 Jan 2026 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+AgMnvU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E75D2FC006
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386127; cv=none; b=S1J6+NoMXx/vQ9e6XmSFNXr6IfRQCfrlrlNwsfnI9A3uqfARPh+keUrA/mAcN3IFFGSxu4V6eMuH2ygeJ0y/7W/MQllaMoTmpGZSyTaXVJMKgDNSVjD6DJxDPp03Q6qNGauRXjWB3qKV7A80+SAStxZbHJn60eNWMfPhN2iAz0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386127; c=relaxed/simple;
	bh=qFjyHEoSPa/oVe6y4HK8GkTglyZRyMJMCVgOKQbXCD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U122IvWs3Na7qFcvXo53dpaFF9JXNWSoaOu0bVdCsD2KSIFX9k4K2e4/OX1DeaJF5Wy0w2pTnnbxt8XpmcbA88czm6uwNme8aBdA74p+g4XCOxFxEY+IWQGOYiaXNfW8uMAbwnEAwO7OGZs0syDgx958dCbteIkz/aXcOwi6ZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+AgMnvU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64dfb22c7e4so1273547a12.1
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 02:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768386118; x=1768990918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hGsBnBGnrh5GWqFiAd50Xj6Kf9Z4MbPCxq5OgC98qGU=;
        b=h+AgMnvU/AkrBRgNJ7ipySM7bdfJwMbRKFSs7RQ0450t64pvtnchHhKgBNlYdcCY6k
         xpNiFG/gysjWg2i4YKX47J2sJEONOCb0a5/aliUsH8LGT6Sdtktfc0+68f70dzhAd9zM
         ehjNycNgLAJ7RP0Rteq6JdVL5lr79pW3YECHe/H6fhvJnVHCwBQd0RdrjBNOC/1rvzVt
         RVouI7X/wZjgEBJ4FeGHYSBk6EiaBoz90h5OgQP1rxoHKDxTGla+UWDyV9vz4O3XL7kQ
         CeW3atktPBbSBurjIYmF5Ve6CNa8au87UisWzkhXSQMxpiBWstchvftXFJXOOML3VS7f
         mA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768386118; x=1768990918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGsBnBGnrh5GWqFiAd50Xj6Kf9Z4MbPCxq5OgC98qGU=;
        b=xBkYsf+lSMsK9ZsN6XFvHeLOsf1Wmyu1tFcNqR+KX6ML7cGzutyegfqBaDoLnSlf7u
         v/9EjzLlbbV8RiocHfPpDMcULZWUwx82L23TXXnRL9qmZugyC5bGfyg8bkn5uvq0aB43
         iOZdFNVLkBaXcLnvTyTDcWd9N9wyziA+bpdWNOdagnFA2NZQmiBOCjLdzGn17lfQZn+h
         2PyQ5JMNTN1PYnCoMto3bWewq7eOHW7xyYyYL8JGmdq2vFKB0224nYW+YxJkYjZHan6s
         3A84hWkz1C6JKd4wBkB/0xDXN0uW7Nrp32yzQIAOULr1gjdAW5TgrlbIRzfh+ZjL2iZH
         2IYw==
X-Gm-Message-State: AOJu0YydE1Vm4xKp1RWy3OSMQ1kjchHwYnsZZUhYQLB4bJur8ldjZAcQ
	qpulsSX+/l1gNfPmqMBhFxWAw2ND6dOUGA3/gxbXJelNgH3yS6Hi+2/9
X-Gm-Gg: AY/fxX7uecGPNA+lFL490C+Een7CD1MxDHjr8TrJP052jGL6WyS43ffWIGLPluVq7MU
	xxBpzbzj9sRjfJoAyeDmU1lRsBTQiZIxgCylcYDw6yX+2MNOQT662wp4QAKXgb4bBVO7ZWRFyBP
	VlorI9zgBAtGtos4NPpAVClSFnrWmoV9vdGS3o7ULyzl4393WAwqBwcL2F7Y1u36m9g9L7ZryTP
	AQUnHgqu+Rt37VeaZKTDJ+2/LlM9FbzZux+ZAizvfCmP37680lQN4M7sZ9/ztQjGq9OxFhC+ALR
	J0tIMRQFLjdyxgJ6d+4J/HhdpkSPyHC3sYVVsRZtnvDuBpd2Buj5wAIJdeXzRgicJVY8yMGsHYo
	kw3nGSoarOK0VqgREJM1w0y0gy+lcTy274aLNqr8sH311iMnvpWoq8mOUKKpEefTQBa9+V7W6Ix
	oPOwqNq2Kz9G3a/Dhil3oSvC/qE/0YVf4=
X-Received: by 2002:a05:6402:3487:b0:636:2699:3812 with SMTP id 4fb4d7f45d1cf-653ebedc568mr1854657a12.0.1768386118153;
        Wed, 14 Jan 2026 02:21:58 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d5e0sm22281306a12.31.2026.01.14.02.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 02:21:57 -0800 (PST)
Date: Wed, 14 Jan 2026 10:29:44 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Fix an off-by-one error in
 check_indirect_jump
Message-ID: <aWdwGKLsL7G7IQ3z@mail.gmail.com>
References: <20260114093914.2403982-1-xukuohai@huaweicloud.com>
 <20260114093914.2403982-2-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114093914.2403982-2-xukuohai@huaweicloud.com>

On 26/01/14 05:39PM, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> Fix an off-by-one error in check_indirect_jump() that skips the last
> element returned by copy_insn_array_uniq().
> 
> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index faa1ecc1fe9d..22605d9e0ffa 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20336,7 +20336,7 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
>  		return -EINVAL;
>  	}
>  
> -	for (i = 0; i < n - 1; i++) {
> +	for (i = 0; i < n; i++) {
>  		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
>  					  env->insn_idx, env->cur_state->speculative);
>  		if (IS_ERR(other_branch))
> -- 
> 2.47.3

Nack, the last state doesn't require a push_stack() call, it is
verified directly under this loop. Instead of this patch, just
add another call to mark_indirect_target().

