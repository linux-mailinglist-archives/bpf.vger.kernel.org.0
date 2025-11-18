Return-Path: <bpf+bounces-75006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F136CC6BCC1
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 23:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 1194C2AD2B
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 22:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC142F28EA;
	Tue, 18 Nov 2025 22:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klUd2EZY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B53F26A1B9
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763503324; cv=none; b=cLa+CbX/8vK9ITneZhHTO1uGcfDhmGpuno6xbvFK0x2Xc+CeE2d1dGfsZf6/nEvJstuI4Qo5hkWbPRwJ361gskuz9BdVHUkKPZji5yoIYXHIuMYCeS3gdT0PrRD9cwDNE7KZ6l3f0JSw+0ItPg5nd6tlsq1+WAtQp9KtoCcG8IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763503324; c=relaxed/simple;
	bh=ntvVGR4qtfpL8K6iEH3IM2PbXNyI4dcwND/L0wZFGQc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOjWU3IzwshZH4ub0I8nL03QqdCEG1hB3o7GLMsBg1yCsasmRJq8+qXndnheNKJsbAr2BFLKzLEyFNu3J2zRZ3B/JWxe3delIrpuUyVELs2l/5XrBjKwSqB3k37jla6QWpNPYFKbO1/5SYanFsMNYZVwrtRLZASk6v0B/rdMotE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klUd2EZY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775895d69cso32272505e9.0
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 14:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763503320; x=1764108120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EV5ZlV/r4PmNeNEl8WOn4Jz8XFUkWFRulyEcsSdt9nA=;
        b=klUd2EZYq3HTS6I6pv4U7ilV/SqD0L1zd0G0eKd8VtPW6BwuPJ1FfUUzpTRwm0l9mZ
         liRv0TZavrzX6abX4GEC77dHx76gBPqCiOYOxlH2PrKapGqC1LcPdf8qoW5o89s8g+Eo
         7Xt3P+1x3CeVWQaUnlAhGn47ml/g0pDlRjcxE1a0U1ulVfNgQ+yKGOhrA4UWzxESw1zg
         E3uTqXY5ucOvMSJitUHlaoMD4BDSfj1SMBEkS1AUtgDyfC5J0UPZDT0PR6eV09T2WlIZ
         B50iZO49ZLJappSn/mn7WYEUAPjOVyBHE1pjBJO+OQm3OxJd6xtwIy+VRTu1sPPpstY4
         mmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763503320; x=1764108120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EV5ZlV/r4PmNeNEl8WOn4Jz8XFUkWFRulyEcsSdt9nA=;
        b=kjwRtVQ73PO6YEBFKf37YhSmnYGTze6f7N4xuY6ranzgHPg8iShvGEmXqfl5+/DBF1
         F9ZEpqH8HYHtmKsa9ew7UrsrbkJqUpsLzE60scP7mnI9dFUP//MqLeYv+Hc8gYpTsbU+
         R7vSH0zgebY4czd3xjjcV38kQ1h5jj/ATouUcUvyDBXNHXSQ2aKYm9RR7dszpFIYorpf
         TFNB7UqPqOijqM2oTKHaCssFAc9f4xxTfHlFn85gYoSKRFhcltg2EJyMDt7xNgcjXBdS
         l+e0mK6eloCkkSFptQ21aGjxwn1U+iyGpA/PpHs+Votk2D2CxOO4VexEeYUlPCAY6rCp
         UP6w==
X-Forwarded-Encrypted: i=1; AJvYcCVXFwJSm6Zgg8AgpmfuhjZJBGIsN9CdJ7evIm7xKSySK96VeA3ehckBGbC/A45iQPGPQHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSXRpWtiGaPjzik9QFkLV5l8dO/NfgvIO7ZSTXJcjTHIiXcEt8
	0NctJ4sQrL/f8tFyiyzBs7v8ZyCZ/9d41Awydbryo1L+EckE1hZuPj+y
X-Gm-Gg: ASbGncuBGeaaAd9/IYWSzr54jlnuJPuYmPlV9B9UZFcwv3S/2wCSz7sF4mlHpaTLjeD
	fpNCwMLcNbZ6sr/6DIxryt8qNJplbM1yE/cEtVIW0JBzIPGT4IG73LWr9+U6Z06Xcx20jo8gWN/
	q/Q54qeROVhpAkZWjca9Jx1K6NDv2B2kcQfjguf/eH0hHsz5kqJzSwD0ND63PXPRk3AE79feK+4
	Iit1kC7TIp6AKI7NeLF8GgBK0lrU8tN/YLjKDo/Uw1YSpH3uAH4+1BP3OKnO7gQERWcdHhytGgT
	b5LBXqByolD3zvPLzpftUJrdMIGvWi7R/aIUPc91EYUCgILtPGgfVnV1XG6VYVeHNRZfB0jLCJZ
	5Mo2xRdybzHoNTThdz9vCcR/PMqnZzPABzTzNmTfNtUxlGRBNp4I0tKqOQUFxhNX957qaBO8xAF
	+naLYSlCuWVQ==
X-Google-Smtp-Source: AGHT+IF/OhkurrwdOZ6kPNeXhKWxi8ctcdf4yOCE/6q75hLzkXUfFrkHbSkcxerxH8L/9+nbFF3bSw==
X-Received: by 2002:a05:600c:1d19:b0:46e:5100:326e with SMTP id 5b1f17b1804b1-4778fea835dmr160650775e9.23.1763503319442;
        Tue, 18 Nov 2025 14:01:59 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9d198a0sm26974015e9.1.2025.11.18.14.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:01:58 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 18 Nov 2025 23:01:56 +0100
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, rostedt@goodmis.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, jiang.biao@linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 2/6] x86/ftrace: implement
 DYNAMIC_FTRACE_WITH_JMP
Message-ID: <aRzs1GGLCm5svW5_@krava>
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
 <20251118123639.688444-3-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118123639.688444-3-dongml2@chinatelecom.cn>

On Tue, Nov 18, 2025 at 08:36:30PM +0800, Menglong Dong wrote:
> Implement the DYNAMIC_FTRACE_WITH_JMP for x86_64. In ftrace_call_replace,
> we will use JMP32_INSN_OPCODE instead of CALL_INSN_OPCODE if the address
> should use "jmp".
> 
> Meanwhile, adjust the direct call in the ftrace_regs_caller. The RSB is
> balanced in the "jmp" mode. Take the function "foo" for example:
> 
>  original_caller:
>  call foo -> foo:
>          call fentry -> fentry:
>                  [do ftrace callbacks ]
>                  move tramp_addr to stack
>                  RET -> tramp_addr
>                          tramp_addr:
>                          [..]
>                          call foo_body -> foo_body:
>                                  [..]
>                                  RET -> back to tramp_addr
>                          [..]
>                          RET -> back to original_caller
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  arch/x86/Kconfig            |  1 +
>  arch/x86/kernel/ftrace.c    |  7 ++++++-
>  arch/x86/kernel/ftrace_64.S | 12 +++++++++++-
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index fa3b616af03a..462250a20311 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -230,6 +230,7 @@ config X86
>  	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if X86_64
>  	select HAVE_FTRACE_REGS_HAVING_PT_REGS	if X86_64
>  	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> +	select HAVE_DYNAMIC_FTRACE_WITH_JMP	if X86_64
>  	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
>  	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
>  	select HAVE_EBPF_JIT
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 4450acec9390..0543b57f54ee 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -74,7 +74,12 @@ static const char *ftrace_call_replace(unsigned long ip, unsigned long addr)
>  	 * No need to translate into a callthunk. The trampoline does
>  	 * the depth accounting itself.
>  	 */
> -	return text_gen_insn(CALL_INSN_OPCODE, (void *)ip, (void *)addr);
> +	if (ftrace_is_jmp(addr)) {
> +		addr = ftrace_jmp_get(addr);
> +		return text_gen_insn(JMP32_INSN_OPCODE, (void *)ip, (void *)addr);
> +	} else {
> +		return text_gen_insn(CALL_INSN_OPCODE, (void *)ip, (void *)addr);
> +	}
>  }
>  
>  static int ftrace_verify_code(unsigned long ip, const char *old_code)
> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index 823dbdd0eb41..a132608265f6 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -285,8 +285,18 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
>  	ANNOTATE_NOENDBR
>  	RET
>  
> +1:
> +	testb	$1, %al
> +	jz	2f
> +	andq $0xfffffffffffffffe, %rax
> +	movq %rax, MCOUNT_REG_SIZE+8(%rsp)
> +	restore_mcount_regs
> +	/* Restore flags */
> +	popfq
> +	RET

is this hunk the reason for the 0x1 jmp-bit you set in the address?

I wonder if we introduced new flag in dyn_ftrace::flags for this,
then we'd need to have extra ftrace trampoline for jmp ftrace_ops

jirka

