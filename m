Return-Path: <bpf+bounces-45436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB54E9D56CD
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 01:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526391F22A87
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 00:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7E86FC5;
	Fri, 22 Nov 2024 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlbV2ERH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD814A0C;
	Fri, 22 Nov 2024 00:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732236071; cv=none; b=sRduoQMoPBMMRF7glFRT0cg0MWuM7xRLWJ0XH3AUk8FV8hU25cy2tp/VYWqoKF+qlhWaQ7UG3LSbENDOMoeIaLulcf4gH1j929RGAQfbsfMWYIXE5izslmL8cbohJhNaAokWBWgdcYSwy2LRjIioll8p2aELPE7ASnqntJ1wIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732236071; c=relaxed/simple;
	bh=z9dF6Emhtspyw3VwGifMj3kprIqiID/ABO92TYKcqwM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CRpekzuIf5q5fnZuNz32FDb321ZEk5NPqm9Vxh4u8yyxriK9fSEP73iZdR+sKvexMyD4xwmtVRXQLVWX6VHPNyh/jRabwVGBHaD5W5EzkMFEYyGOJLxJ1zxCrv10sRl/OQgTn6Yv5vKWSvIHsaGzaD8e9dvS/+oDFNPzv9IQB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlbV2ERH; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-83a9cd37a11so58839639f.3;
        Thu, 21 Nov 2024 16:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732236069; x=1732840869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04MVoN+OIvJr2YdZQzPbMEP15dXCFEy6P+SherFyn/8=;
        b=MlbV2ERHDx6tj2pkkODaTPi8WddbuBeH7JkqxhkIaV/bcn+dDQfr0SuXZX/oRRNnih
         TTTeRHwnsxXO9kc3Z6ag9+iCIvN8Rj7c8spXliJ/nkfbKJh+mLD7zbqr9d6gNGx4FtaJ
         2VeHqXYsmsTS+p4ECOJqiPj0Q5OVDiVs5nDXm3AnYZUgEC7JYS+VLurnJqYUSIv7+VP1
         9fSAiYnBxdH/vHsfWQaQjafO1jR6B3/sus+vYuKT2MdtlHqf5amQud3IVIZzGBaQVpBO
         /h71o8QwSh5mKy5fd2wQd1X+Bcr15XBhcGcHDYQzr2Yq8EmY7JaAErxDG7ku2ptKzJU2
         Kqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732236069; x=1732840869;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=04MVoN+OIvJr2YdZQzPbMEP15dXCFEy6P+SherFyn/8=;
        b=luuHYvat9Panr9C20pjat2rVX2rw6c6UBalT6MXO82MFY/a7mJFS9MoQzlHaDHqoUk
         005hSAbVOiDgG7UoxPixO0nqvrcs8GoY18N5lwJkqfmGHK/kV5m1XwGby7QVt6o8hHZc
         PiIDa1UVV0rxUNEYevUZY6A/t2tO8iezyz2jy8F9BPbv6n5Wh8Zm5qZx54GykJ6KC0W2
         AgzOqH6Xo3d/sK4o9PLO3NtX8Tx4zYZAHgRdZOQNwE39pMsesSQRSc1qJsunK/PyoqLs
         WMCWvP/t88ddYQadLfFfyI+KiPk75woyeUVzvWlFgGJxwBRVWM0Bs2Mxwn9npAP3wVzw
         NfPg==
X-Forwarded-Encrypted: i=1; AJvYcCUItiGUnhyarUHOLB/hsWHAJcG5K0B1YmeD28XlCqIwhqkttLy5ECL3M3TaI9rAkZWyTo4=@vger.kernel.org, AJvYcCWpDnQENbSkcEZ23LA/hGs28r441NRwj0B8I3JWpAO4x0kej39mVpdSAKFEGavZOtRP7DiymaNKfKlTwfm/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4FhMnUEu6gA7uE1rvuLFEqtAMEEx+2ZRh45C/fqvLpXLTer5y
	PcOSdiEc1jYnQpxnWN3RiPJMQ8RxHfCXZApd17RD7taikvOpTpjnlqU2LQ==
X-Gm-Gg: ASbGncv+fy0A70iyTuK0NRXHkjkPdovCTxf/AqYeynnJ0QouAmV4Mvww+q87jJIcnXI
	4aoUQJk3Rl9yUSw2oY5WcW/Bngl/sJKL++mTqEAv7OVj/xmVfLyQibLMH4O09dvYgE5cjbuO5Y6
	RhTBeDtaiV1u0u41hKDzDZsH/pwWTn+XDuLINtHfIZcvxFk1+b1JyGBfcjv9YBJ6MYSnM0bF6JH
	MpbBTt8koNHn5zlIpu6E+S7mpZ3Xq0rwT2su2+lfTdi45u23jw=
X-Google-Smtp-Source: AGHT+IEpZv48o7EMNyfIQ2/+C0TuoNaUSVg007ysRSyWDMDywOYlRzeOC5AR7mKVUg9lOrgUPMj8Kw==
X-Received: by 2002:a05:6602:154d:b0:83a:f443:875 with SMTP id ca18e2360f4ac-83ecdd140e9mr91707739f.15.1732236068775;
        Thu, 21 Nov 2024 16:41:08 -0800 (PST)
Received: from localhost ([98.97.39.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcbfc08efsm402586a12.16.2024.11.21.16.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 16:41:08 -0800 (PST)
Date: Thu, 21 Nov 2024 16:41:06 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, 
 bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <673fd322ce3ac_1118208b3@john.notmuch>
In-Reply-To: <20241119065230.19157-1-yangtiezhu@loongson.cn>
References: <20241119065230.19157-1-yangtiezhu@loongson.cn>
Subject: RE: [PATCH] LoongArch: BPF: Sign-extend return values
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tiezhu Yang wrote:
> (1) Description of Problem:
> 
> When testing BPF JIT with the latest compiler toolchains on LoongArch,
> there exist some strange failed test cases, dmesg shows something like
> this:
> 
>   # dmesg -t | grep FAIL | head -1
>   ... ret -3 != -3 (0xfffffffd != 0xfffffffd)FAIL ...
> 
> (2) Steps to Reproduce:
> 
>   # echo 1 > /proc/sys/net/core/bpf_jit_enable
>   # modprobe test_bpf
> 
> (3) Additional Info:
> 
> There are no failed test cases compiled with the lower version of GCC
> such as 13.3.0, while the problems only appear with higher version of
> GCC such as 14.2.0.
> 
> This is because the problems were hidden by the lower version of GCC
> due to there are redundant sign extension instructions generated by
> compiler, but with optimization of higher version of GCC, the sign
> extension instructions have been removed.
> 
> (4) Root Cause Analysis:
> 
> The LoongArch architecture does not expose sub-registers, and hold all
> 32-bit values in a sign-extended format. While BPF, on the other hand,
> exposes sub-registers, and use zero-extension (similar to arm64/x86).
> 
> This has led to some subtle bugs, where a BPF JITted program has not
> sign-extended the a0 register (return value in LoongArch land), passed
> the return value up the kernel, for example:
> 
>   | int from_bpf(void);
>   |
>   | long foo(void)
>   | {
>   |    return from_bpf();
>   | }
> 
> Here, a0 would be 0xffff_ffff, instead of the expected
> 0xffff_ffff_ffff_ffff.
> 
> Internally, the LoongArch JIT uses a5 as a dedicated register for BPF
> return values. That is to say, the LoongArch BPF uses a5 for BPF return
> values, which are zero-extended, whereas the LoongArch ABI uses a0 which
> is sign-extended.
> 
> (5) Final Solution:
> 
> Keep a5 zero-extended, but explicitly sign-extend a0 (which is used
> outside BPF land). Because libbpf currently defines the return value
> of an ebpf program as a 32-bit unsigned integer, just use addi.w to
> extend bit 31 into bits 63 through 32 of a5 to a0. This is similar
> with commit 2f1b0d3d7331 ("riscv, bpf: Sign-extend return values").
> 
> Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 7dbefd4ba210..dd350cba1252 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -179,7 +179,7 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
>  
>  	if (!is_tail_call) {
>  		/* Set return value */
> -		move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]);
> +		emit_insn(ctx, addiw, LOONGARCH_GPR_A0, regmap[BPF_REG_0], 0);

Not overly familiar with this JIT but just to check this wont be used
for BPF 2 BPF calls correct?

>  		/* Return to the caller */
>  		emit_insn(ctx, jirl, LOONGARCH_GPR_RA, LOONGARCH_GPR_ZERO, 0);
>  	} else {
> -- 
> 2.42.0
> 
> 



