Return-Path: <bpf+bounces-56952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC56AA0E83
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 16:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5BA166D9F
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 14:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF992D3A69;
	Tue, 29 Apr 2025 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQb0K+2m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837EB2D1F47
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745936186; cv=none; b=RLvToZlp/tqG/qvH/m0PAqFWowNe8VTRA/bYB0LYVy5G0eDPJ72XpPcstJrB8WkNKWcXI7QOvNCQ8pZgKfaoADvuKMTVyAeFtAUzusOR5DbJtPO12ujcm4bKe8aJKfpOvSfmEqOQK4Xj5fQlWDE2c7hRBIBcZNqYWMDKSse2T/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745936186; c=relaxed/simple;
	bh=ZNs1zOvZJOKyw+r9I4YKQ1F8rtMz7mFdcK/fvE0MreY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lw+TuFTQj336RmqskqwBM07yMZcXhAw2qlmwcmWCEeOFquv12bHh/B9KqF1p3Sv3xwJyNhX+rzJHzqtUIma4lKM7umiShmDndqD/Nusx/Z/8mxM30U4vXeGJtFPHF/FjQtjnb3RFpkr49beG4PU2PWGPaPt+58pqSRa6r/cqGYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQb0K+2m; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aca99fc253bso923003966b.0
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745936182; x=1746540982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RNReBSzM40k5vcDqkaOVbMw30EkP6It3JeuLaLn1z/Y=;
        b=GQb0K+2mDO239lFnScmu0pfzWgkyADF4POxpb+S0VdYpCpD5ratXBmKM8qFrID2NjI
         hUexh/F4K0aArnBc3e1TpTlntT/ncn6YVHc/16MO5FuH4CkihIz4LldBPLlsymL8AY+a
         VHrBfq8H2vlqrErHSH5IjJI13pCJU+f6ufxQq7EEXOmfa/jeHRmqqe6Iv0HFI0Hyiph0
         pk6Th9GcsGusESWcs2D/cvsd4XvjfT2RAWyGV2jkI2XWuvHgkZh0ifQ9yvicqkV9IZ0W
         wdgSbw5wRyehd8XAbTey2ycyGyAuqZGlTQZ9hE8IzTkbX/gOWVxlqyXRWZ5aX9NND6aC
         5r3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745936182; x=1746540982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNReBSzM40k5vcDqkaOVbMw30EkP6It3JeuLaLn1z/Y=;
        b=JLf/kd4gVCefxvsTs+EA3y358/G/BiIh7SLYqW1ctTB6mD8lkMOdPcty1E1PLqpA0p
         rH0neE8jHRx91mcL2WcIYKMO2Ec65gpG5UpO5hyurX4YnBhkbWuSNScYp4P4kP/r5+Pf
         y7LDTdmv24FmYOSemI/r4ygck6cB1tqSBBuOE569XCUAu2pNlk485MZxbNy6A+evs2hC
         KqBbiRlU1GNDiPtfP90J++r+H97pFnxPbrkZMQJh4kW6gA3OhkHm8lRCZG0AAf8RNgp1
         Pbl8cNeZzpmGVjtSvCqig3URHRwJpcWa2QwS6GYkeyvj7BxKLhJ1G2K49xZiFmNe6AJF
         QOAA==
X-Gm-Message-State: AOJu0Yz2IWz8xZU1UtZT7YY1HeiZf1crkE0xm6p/sJxetztHm+g0W7yL
	62nZxCvNCD5Qi14XyiT8ahBhLEmAAGfPTOTbTPyHjiR0FopYE8Jkq/gc1g==
X-Gm-Gg: ASbGncu0uFSTjftMKLvfsEAb1nOH3TJkUQLtOAODR29tBsbY/HI4fWKqWPGGDclGY8E
	PQGT8n1yM6ColS5MRRtW+riWtJ0Cx/YwR9vnVFJxTwWfDVFt7qIotxkFz81myi2IG5RJmXxEXOV
	yr4Xxb4AMLO9F95JaRRzsQEKGJWETVktQqCqOFi7Ys+9s627i2NP6ny32yxmBpib0uHH67tkcl8
	5IgYWmV1+bFAopxOL47uJmzyR83b7O/3VnsFLPiY1GCCSzNdA8Xn1zf3f/S5K12IjQIEGH2AECG
	En9XnUisjC8Gh9duxpjizI9MZgdnWg6nDQraHpl/Fyo/dSg88AQ=
X-Google-Smtp-Source: AGHT+IE3NZx+MRAg/JNveAgJsvHelt4ZSXpE8AjzP9q8R2E2tdb9CtRfaa+wo5sHEa5fzexgbI0HFw==
X-Received: by 2002:a17:907:3ea2:b0:acb:8492:fe with SMTP id a640c23a62f3a-ace84af631bmr1174930266b.52.1745936182148;
        Tue, 29 Apr 2025 07:16:22 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb0becsm779464966b.167.2025.04.29.07.16.21
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 07:16:21 -0700 (PDT)
Date: Tue, 29 Apr 2025 14:21:11 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next] bpf: fix uninitialized values in
 BPF_{CORE,PROBE}_READ
Message-ID: <aBDgV2AqikHFbG5K@mail.gmail.com>
References: <20250429130809.1811713-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429130809.1811713-1-a.s.protopopov@gmail.com>

On 25/04/29 01:08PM, Anton Protopopov wrote:
> With the latest LLVM bpf selftests build will fail:
> 
>     progs/profiler.inc.h:710:31: error: default initialization of an object of type 'typeof ((parent_task)->real_cred->uid.val)' (aka 'const unsigned int') leaves the object uninitialized and is incompatible with C++ [-Werror,-Wdefault-const-init-unsafe]
>       710 |         proc_exec_data->parent_uid = BPF_CORE_READ(parent_task, real_cred, uid.val);
>           |                                      ^
>     tools/testing/selftests/bpf/tools/include/bpf/bpf_core_read.h:520:35: note: expanded from macro 'BPF_CORE_READ'
>       520 |         ___type((src), a, ##__VA_ARGS__) __r;                               \
>           |                                          ^
> 
> Fix this by declaring __r to be an array of __u8 of a proper size.
> 
> Fixes: 792001f4f7aa ("libbpf: Add user-space variants of BPF_CORE_READ() family of macros")
> Fixes: a4b09a9ef945 ("libbpf: Add non-CO-RE variants of BPF_CORE_READ() macro family")
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  tools/lib/bpf/bpf_core_read.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
> index c0e13cdf9660..be556ccdc002 100644
> --- a/tools/lib/bpf/bpf_core_read.h
> +++ b/tools/lib/bpf/bpf_core_read.h
> @@ -517,9 +517,9 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
>   * than enough for any practical purpose.
>   */
>  #define BPF_CORE_READ(src, a, ...) ({					    \
> -	___type((src), a, ##__VA_ARGS__) __r;				    \
> -	BPF_CORE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);		    \
> -	__r;								    \
> +	__u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];		    \
> +	BPF_CORE_READ_INTO(__r, (src), a, ##__VA_ARGS__);		    \

And, of course, this breaks things. The line above should have stayed
with &. I will send v2.

> +	*(___type((src), a, ##__VA_ARGS__) *)__r;			    \
>  })
>  
>  /*
> @@ -533,16 +533,16 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
>   * input argument.
>   */
>  #define BPF_CORE_READ_USER(src, a, ...) ({				    \
> -	___type((src), a, ##__VA_ARGS__) __r;				    \
> -	BPF_CORE_READ_USER_INTO(&__r, (src), a, ##__VA_ARGS__);		    \
> -	__r;								    \
> +	__u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];		    \
> +	BPF_CORE_READ_USER_INTO(__r, (src), a, ##__VA_ARGS__);		    \
> +	*(___type((src), a, ##__VA_ARGS__) *)__r;			    \
>  })
>  
>  /* Non-CO-RE variant of BPF_CORE_READ() */
>  #define BPF_PROBE_READ(src, a, ...) ({					    \
> -	___type((src), a, ##__VA_ARGS__) __r;				    \
> -	BPF_PROBE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);		    \
> -	__r;								    \
> +	__u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];		    \
> +	BPF_PROBE_READ_INTO(__r, (src), a, ##__VA_ARGS__);		    \
> +	*(___type((src), a, ##__VA_ARGS__) *)__r;			    \
>  })
>  
>  /*
> @@ -552,9 +552,9 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
>   * not restricted to kernel types only.
>   */
>  #define BPF_PROBE_READ_USER(src, a, ...) ({				    \
> -	___type((src), a, ##__VA_ARGS__) __r;				    \
> -	BPF_PROBE_READ_USER_INTO(&__r, (src), a, ##__VA_ARGS__);	    \
> -	__r;								    \
> +	__u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];		    \
> +	BPF_PROBE_READ_USER_INTO(__r, (src), a, ##__VA_ARGS__);		    \
> +	*(___type((src), a, ##__VA_ARGS__) *)__r;			    \
>  })
>  
>  #endif
> -- 
> 2.34.1
> 

