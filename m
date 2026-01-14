Return-Path: <bpf+bounces-78886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2E4D1EAF1
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 13:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B2E2302AF95
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 12:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C5239527B;
	Wed, 14 Jan 2026 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKcTQk+w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2DD396D2D
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768392982; cv=none; b=N0xC0x8vzNjFHMp3pC9RTBcjyJD4fWzgSmPpiT4//mvOcCbJxYgbTwb2vGss6z4j28sWbd2xLUPTbfvzNeks4Rg+EDpS28Zv4m8fsvRUeM3Nojw/qFQcFGM+HToPV32MtfdUYsvCfdZmaBMhvTH/m7feZQ0kjIoz+i7GL/KoNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768392982; c=relaxed/simple;
	bh=h6plHtyEJAPnW/kOTSxq98sPn9FmPl/GZrJ82KaBJYI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yc0L3oGnmS2bqB3YotReBkbmmI1jElC1G+P5wQbKugPFE880MpTbSFn4ZK+MAwsJfYv+rHiBi55JgDJTE6iJ7nlE2talEHn6dSF9yNgBYmhYn8n9sT1zq2C0m2CmjQk7fqR+uILnYxviNAKMNL8aFY4jwFnMFVPgURfjmyerj/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKcTQk+w; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6505cac9879so14619870a12.1
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 04:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768392978; x=1768997778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCiPEDKhbT9vYnjTMwPD8QcnwrqfQdSqnwbBZs41EKI=;
        b=nKcTQk+w1K4EHxWLv/6NB+0PPPTCTknZfHNGbSGP/cIVOFasynWhW8laQwH574rgLs
         euiWPgUw5RsMjZeunjtqW7Y4l+2igFX3cfQm3vxzDvzwxyLXR1IH4GqalKgGeBY57OMz
         v/ihjNLLUHHSp4Ff4xLSywKqmucGrvAnQ85+T5Lkrv63U8CXW/CkgK4ybALZBbDCRm9T
         yDZlDRpyDcj7Exh0iqyyO9jizqWPpTwMKMmWfHh0V3sxZ+ZKB1FgSgy0fjPIMv0NEcHL
         SThtutZofRd+L99o3NkX782LzGmZbGkJGSXCMxD1LLzA300/02fz3f4JNI2IBWD//6eM
         hx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768392978; x=1768997778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YCiPEDKhbT9vYnjTMwPD8QcnwrqfQdSqnwbBZs41EKI=;
        b=DjogCo+uOYiD2DfGMInB+lGBMPLIKue3D+plwZ2e8wNpX7elF50Hv51KTXGiL8WXN+
         yZKh/gsIg2dl+Czs8S/1sbXl3XxJly3lvP/E8qECN2/Uy1vq34B5QCHvjmSeZ3wQdzUa
         c9j73rKxiBYh6+8sodr/JT6rFw09blxrOMZJq5GH/ynhVQ1jSkJ6kusb5A8mj7vxqWY6
         ooniwHwyYfj8IudDC/bYYABOpR97+YzEWYeL0Gs62y/1gOupi7YMyOmPU/gpFOyUCauf
         GqE64rHE5EFdK+qP8oq+YkdzChxllm4BmoLp3C2J5Vwxw1gRfKcthepMasIWh+r9QmcC
         aDOg==
X-Gm-Message-State: AOJu0YwjwYRuGlBg7A0dddG4T5aOWV9LSR34kfp+rIjW9VuBn6qLa3YF
	T5eSyQBnTTH3XcmUOdMc9AK3+wZf0vBmpbzkj89DWm5hFFHBGPdHQO3lPfYKsA==
X-Gm-Gg: AY/fxX7SsA+LY5BOyAkI8ginY4TMaR4R+FWwjvXTRxrePaJXfOsv8GZAEk0XAvB64le
	QEyW3NtnXZNkuEinv/HI9S/U1rokr5/1IFVcoygyqK7aeWV2esrkiWle8pg5hvHop1QHFRSlnLW
	pKb/YwXdnH3kYLKaP3D6sYRMi8D0AMTIjKS9miQq8ycDyff7fxjvxFJ7KR2e9J3+mlF8OE9Wlfp
	MPyjfELEqb8Zi1gAXfEHXKRo6dmQYTsqy5x9FlohMdqmCAl+6TXvVFqsy2/uuG03a1KHsSfkBqC
	3PyAQrlABHz57cEl23nI9CUO1ae2UwlDY9vFX5yu2IbPYv8dCNWkVsjbhq9LzV8/UDf6dWPMG6O
	DDVZgWDtEiA/9sisAHv53zmafxoDNfCGygsdxy0tfZRjwZXlMhdTEUBzcVBRPfdFTXzwAKoDg6P
	2ne0BX0jc4xfanfDkEdeFGzrj1BDvDaMY=
X-Received: by 2002:a05:6402:3592:b0:640:cdad:d2c0 with SMTP id 4fb4d7f45d1cf-653ee1b1c24mr1589890a12.25.1768392977605;
        Wed, 14 Jan 2026 04:16:17 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d4acsm23063416a12.30.2026.01.14.04.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 04:16:16 -0800 (PST)
Date: Wed, 14 Jan 2026 12:24:03 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Extend live regs tests with
 a test for gotox
Message-ID: <aWeK41yKzQXAZs81@mail.gmail.com>
References: <20260114113314.32649-1-a.s.protopopov@gmail.com>
 <20260114113314.32649-3-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114113314.32649-3-a.s.protopopov@gmail.com>

On 26/01/14 11:33AM, Anton Protopopov wrote:
> Add a test which checks that the destination register of a gotox
> instruction is marked as used and that the union of jump targets
> is considered as live.
> 
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  .../bpf/progs/compute_live_registers.c        | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
> index 6884ab99a421..fad91c599095 100644
> --- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
> +++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
> @@ -431,6 +431,43 @@ __naked void subprog1(void)
>  		::: __clobber_all);
>  }
>  
> +SEC("socket")
> +__log_level(2)
> +__msg("2: .1........ (07) r1 += 8")
> +__msg("3: .1........ (79) r2 = *(u64 *)(r1 +0)")
> +__msg("4: ..2....... (b7) r3 = 1")
> +__msg("5: ..23...... (b7) r4 = 2")
> +__msg("6: ..234..... (0d) gotox r2")
> +__msg("7: ...3...... (bf) r0 = r3")
> +__msg("8: 0......... (95) exit")
> +__msg("9: ....4..... (bf) r0 = r4")
> +__msg("10: 0......... (95) exit")
> +__naked
> +void gotox(void)
> +{
> +	asm volatile (
> +	".pushsection .jumptables,\"\",@progbits;"
> +"jt0_%=: .quad l0_%= - socket;"
> +	".quad l1_%= - socket;"
> +	".size jt0_%=, 16;"
> +	".global jt0_%=;"
> +	".popsection;"
> +
> +	"r1 = jt0_%= ll;"
> +	"r1 += 8;"
> +	"r2 = *(u64 *)(r1 + 0);"
> +	"r3 = 1;"
> +	"r4 = 2;"
> +	".8byte %[gotox_r2];"
> +"l0_%=:  r0 = r3;"
> +	"exit;"
> +"l1_%=:  r0 = r4;"
> +	"exit;"
> +	:
> +	: __imm_insn(gotox_r2, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_2, BPF_REG_0, 0, 0))
> +	: __clobber_all);
> +}
> +
>  /* to retain debug info for BTF generation */
>  void kfunc_root(void)
>  {
> -- 
> 2.34.1
> 

Ah, this fails on s390x. I will send a fix later today.

