Return-Path: <bpf+bounces-65641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E08D7B265FB
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 14:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FFB1C87DE2
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 12:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A909E2FB977;
	Thu, 14 Aug 2025 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EK/8dMTO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0B5286436
	for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176133; cv=none; b=PPQ+0DqNa6KH62PZP61m/nmf0ep+jIKPvl9zdn4jkE4TV6CuK1ch0fVciUoA3BKp44Rz4Zvs2X5/q3Nria+PUCwSYvFLIU/oqDxFvIgwo7Tn5ZWY2AjZRkP9CYYppEi2ilGekLFGe7pvxFtbGAbN3ZLLGeRbJKlzJRwuM6rs8jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176133; c=relaxed/simple;
	bh=UjlpuvH4ZqGlpfxfCAoE/zcZqQre2BrpYV/OO0kD8dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=susLmvGs1OlXZMlCAwEeRKG8P7zDftWiI6oUcBPzRTU36AZFZz+6WNUeGdJ4+aKre1T4gNf+o08eaqEjnftHXbdfleMhVspi8Ip/r4BjMvmBlDok45CADoFCzx5tRHsITBzwIg1kn5c7Qm09KSU7UG3K0FcdPo9AsEfsO6lsuEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EK/8dMTO; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9d41bea3cso795018f8f.0
        for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 05:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755176129; x=1755780929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bi6fTIx20MnlBqkuG0GegtygLPIym9mFwcGoaI7KOqY=;
        b=EK/8dMTO/4/eWVDuWfc6R8svYomZVPnmjKK+U0Dgn0h9SO2kkST4fY+BBKIGfnd2hf
         vNyHMXtbweRPbXLjo1mU5I6z7qUMR6oWiT5pFKyc0Hh7MrWHstDJRULFi5cMyjKfN9zr
         KyaGjJItp5EadM8UzxjpTwJ5xIF0ZAzlur/fFO3jM1jgohwF2LOGp6b3tRqY441SWYkN
         mAou6CEhBc4QXGhvEpkZh4nx0bwR7HQJEu3kG7MKSctYjiS8Rxa951h07g1wK8Jq1H5J
         QUNvgWpmy3/nsuABn/g7UzFFtAM0K0cRVpfutehYbDbC1e2pADN6aSoh7wNiJFlWfArf
         ug8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755176129; x=1755780929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bi6fTIx20MnlBqkuG0GegtygLPIym9mFwcGoaI7KOqY=;
        b=GFOp1EwBDeOJo0OZCDVnQxvpCUdyf9V9TLHLx+eQoXW7WRVCZGW+RoWR7Z6RQ0nKiC
         jnYypJ64DkvjcL7I+wrx3nUiIrbGEUr2aXnNexjSMZlUsu2MaWfyoJxKJ6IbislsxuTD
         4Sd2ridsXJ2xJkQHCMJH9s+lGf4Dsy/NOQRUAOeLthCUPyOLnldZJftBMva7vKJ0P+8J
         Hqn9P3Sn9poDql03v8XQRA3xEyIZcrsGVgE5k3LIa1fOby+prGq+2b4pdxDysPd6bqeA
         6WSZiA11Z+I5aCn3gMdm5wDz7KfIXPa6+QByJW8B6gsnmmgaLx43UCpz+1IZLznwMvTV
         LTNA==
X-Gm-Message-State: AOJu0YzI+uOnUxZ6NwIxFLYHXjc+SAaeSH/rqniGx1v7Ju1orMePfSyl
	hAjTleGm+h5exhifU4fBcTnr9rvjj+t/IhfLh0mJilgxfiLQv2rnoyGAIXYaUbqqy0g=
X-Gm-Gg: ASbGncspHCisSD5YqI0MVPKOHlf//ygpDAsqyXg//VB9wAzKrUC3mYRQQ8+bKcNfrxa
	khWkUz8nB7CdaztMdNvwHezNsmGge0RgXzyKG2Rid5QXgIDTZ2NwKHcxSDsXyrgg2kU/m17sJFq
	fMTR1eNZ4OQZXrv1OsvwxZNYDEFbM4rJewfQAr0EdwMcxN5Om3HLelnQD1t0XHjoiOHCzJyT9V2
	RPIubL/vCokR7a3mdWT8rUCpbkXmE0xGOdn/8iZDxuWTswbook6kSl0QELTB5tuQ7932Op3kI/8
	v59xA5noD2VTR4h9rc8nnxJRFV1F560cZrwedNPq3w27At4uKhNyBdogtKsJwbJGclzg877kHRk
	7goIEjTs/Hc3Zp4EcTyDJHZ2k+RrbuU0w95UNaiHxvqU=
X-Google-Smtp-Source: AGHT+IGRgNa2IPCcBOFayZkep1sLyA+Z4am6zCoJVDoRu6Sv1DaF3oepcT58Gd0OPZBAedn09zdjIQ==
X-Received: by 2002:a05:6000:2481:b0:3b7:9aff:ef22 with SMTP id ffacd0b85a97d-3b9edf39e9fmr2727989f8f.27.1755176129276;
        Thu, 14 Aug 2025 05:55:29 -0700 (PDT)
Received: from u94a (1-174-0-44.dynamic-ip.hinet.net. [1.174.0.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330f9163asm1771789a91.3.2025.08.14.05.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 05:55:28 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:55:22 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 1/2] bpf: Use tnums for JEQ/JNE is_branch_taken
 logic
Message-ID: <hxshkvnzsyrmnty25ainifbei732oco3ss6y76iez2cdsxa77q@cdnvjuhsp6c2>
References: <ba9baf9f73d51d9bce9ef13778bd39408d67db79.1755098817.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba9baf9f73d51d9bce9ef13778bd39408d67db79.1755098817.git.paul.chaignon@gmail.com>

On Wed, Aug 13, 2025 at 05:34:08PM +0200, Paul Chaignon wrote:
> In the following toy program (reg states minimized for readability), R0
> and R1 always have different values at instruction 6. This is obvious
> when reading the program but cannot be guessed from ranges alone as
> they overlap (R0 in [0; 0xc0000000], R1 in [1024; 0xc0000400]).
> 
>   0: call bpf_get_prandom_u32#7  ; R0_w=scalar()
>   1: w0 = w0                     ; R0_w=scalar(var_off=(0x0; 0xffffffff))
>   2: r0 >>= 30                   ; R0_w=scalar(var_off=(0x0; 0x3))
>   3: r0 <<= 30                   ; R0_w=scalar(var_off=(0x0; 0xc0000000))
>   4: r1 = r0                     ; R1_w=scalar(var_off=(0x0; 0xc0000000))
>   5: r1 += 1024                  ; R1_w=scalar(var_off=(0x400; 0xc0000000))
>   6: if r1 != r0 goto pc+1
> 
> Looking at tnums however, we can deduce that R1 is always different from
> R0 because their tnums don't agree on known bits. This patch uses this
> logic to improve is_scalar_branch_taken in case of BPF_JEQ and BPF_JNE.
> 
> This change has a tiny impact on complexity, which was measured with
> the Cilium complexity CI test. That test covers 72 programs with
> various build and load time configurations for a total of 970 test
> cases. For 80% of test cases, the patch has no impact. On the other
> test cases, the patch decreases complexity by only 0.08% on average. In
> the best case, the verifier needs to walk 3% less instructions and, in
> the worst case, 1.5% more. Overall, the patch has a small positive
> impact, especially for our largest programs.
> 
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>  include/linux/tnum.h  | 3 +++
>  kernel/bpf/tnum.c     | 8 ++++++++
>  kernel/bpf/verifier.c | 4 ++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/include/linux/tnum.h b/include/linux/tnum.h
> index 57ed3035cc30..06a41d070e75 100644
> --- a/include/linux/tnum.h
> +++ b/include/linux/tnum.h
> @@ -51,6 +51,9 @@ struct tnum tnum_xor(struct tnum a, struct tnum b);
>  /* Multiply two tnums, return @a * @b */
>  struct tnum tnum_mul(struct tnum a, struct tnum b);
>  
> +/* Return true if the known bits of both tnums have the same value */
> +bool tnum_agree(struct tnum a, struct tnum b);
> +
>  /* Return a tnum representing numbers satisfying both @a and @b */
>  struct tnum tnum_intersect(struct tnum a, struct tnum b);
>  
> diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> index fa353c5d550f..8cb73d35196e 100644
> --- a/kernel/bpf/tnum.c
> +++ b/kernel/bpf/tnum.c
> @@ -143,6 +143,14 @@ struct tnum tnum_mul(struct tnum a, struct tnum b)
>  	return tnum_add(TNUM(acc_v, 0), acc_m);
>  }
>  
> +bool tnum_agree(struct tnum a, struct tnum b)
> +{
> +	u64 mu;
> +
> +	mu = ~a.mask & ~b.mask;
> +	return (a.value & mu) == (b.value & mu);
> +}

Nit: I finding the naming a bit unconventional compared to other tnum
helpers we have, with are either usually named after a BPF instruction
or set operation. tnum_overlap() would be my choice for the name of such
new helper.

One more comment below.

>  /* Note that if a and b disagree - i.e. one has a 'known 1' where the other has
>   * a 'known 0' - this will return a 'known 1' for that bit.
>   */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3a3982fe20d4..fa86833254e3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15891,6 +15891,8 @@ static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_sta
>  			return 0;
>  		if (smin1 > smax2 || smax1 < smin2)
>  			return 0;
> +		if (!tnum_agree(t1, t2))
> +			return 0;

Could we reuse tnum_xor() here instead?

If xor of two register cannot be 0, then the two can never hold the same
value. Also we can use the tnum_xor() result in place of tnum_is_const()
checks.

case BPF_JEQ:
    t = tnum_xor(t1, t2);
    if (!t.mask) /* Equvalent of tnum_is_const(t1) && tnum_is_const(t2) */
        return t.value == 0;
    if (umin1 > umax2 || umax1 < umin2)
        return 0;
    if (smin1 > smax2 || smax1 < smin2)
        return 0;
    if (!t.value) /* Equvalent of !tnum_agree(t1, t2) */
      return 0;
    ...
case BPF_JNE:
    t = tnum_xor(t1, t2);
    if (!t.mask) /* Equvalent of tnum_is_const(t1) && tnum_is_const(t2) */
        return t.value != 0;
    /* non-overlapping ranges */
    if (umin1 > umax2 || umax1 < umin2)
        return 1;
    if (smin1 > smax2 || smax1 < smin2)
        return 1;
    if (!t.value) /* Equvalent of !tnum_agree(t1, t2) */
        return 1;

Looks slighly less readable though.

