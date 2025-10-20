Return-Path: <bpf+bounces-71361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D25BEFE44
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 10:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47F23E638A
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 08:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EB32EA729;
	Mon, 20 Oct 2025 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncnia1ej"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB7E2EA49E
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948377; cv=none; b=A6VMq/0CNCyoMVaPwiXPXEIvStC1xIw5HaMiAWS96KSSvVt9TO0ZH8bneWeE2fVeHm19racxMLVVhrWMGfdGvgiBK501S/0v9j256B8CvSCimifoAxbaXEQatJ+RnFssyCbzlqPX8mdolyhwVXvU5enJDPNccLFElI/JtPH8Q0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948377; c=relaxed/simple;
	bh=dRWXfEC0xTJRSDH0laop22EviOdJHMRGgqbpL7o/Nfc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOtleo9GOkbkrnZijM8Oxjlewy/YyR/Mh2lHyIcND4iSSkuUrvnE9K6D80UkdmZOTA+t5hP9ZUPYqP/H1yvpIUnW+BIyMWlxXQjRCfdN+nZVCBTvcslyPKGb1UEwZSSbipwdTj7cgkvHxQ5PqR17C1jSlQhcTqJZAQtYQnmQbMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncnia1ej; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46b303f7469so31125765e9.1
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 01:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760948374; x=1761553174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wu1seAuHBCMknQQxCUTYBtZscbydnbBYQKqotBsvZIk=;
        b=ncnia1ejP8CJJlHdtfI/TT9LG5Wxh+GyY4WDjy8NqaExtircZKxajf8NEDSiNHtwSz
         +RTQv9hpLYoDjU6I3escnVZtMUw1NN8XTf5UhmEfBWA9izADPd98o+lxNKp4LlIM9SZl
         ODIMoTdzIWS85LXkyEaIhHhzb/AttEFTt3osrqwgZCsEt028lNemtwqBof97eGrfn/0H
         JpzGbFSK5UXJ0NNyeR3nCiht5uY1JKvxN1CVIGbyIiP0NbjxIVb2A499eUD5zA9MHriD
         qZXzB15huGp1m8cNQToBS6l8v4PwzCY2IfxGH/J0aHNxW7poxhx6YFvVlAB0LzhMj3km
         s9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948374; x=1761553174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wu1seAuHBCMknQQxCUTYBtZscbydnbBYQKqotBsvZIk=;
        b=pT0XYAiD0iGOkz+i3D2EqmtxmiDseWsqmknH2oHs9Wjk2hBQSYL6zYF8X1uAiq39Il
         D62dkxTQuaLiYrnULrWpVyw2d19fA8o4wILGzq9GTiseyIMHPdnLWL8hvLSXydeRigql
         TxfFu0+ZdGbt/7ZAZ6lStVWMt1+hKH/FPaVV7lkEqjybb//WHubnDkr1QCvMsacUPuoT
         5juD258lCFpkOZ3+EAx9w0+X4l+gksAiHcGlVqC35ul82qPBzphXcJUs5I664TxJIElN
         Odo/eXXfop6p89wxlBLP3Cq/5Qtx4XCgtCMu0z+DR1UMLQW/JDu8iF6YudGkcoBbDA0L
         TmYw==
X-Forwarded-Encrypted: i=1; AJvYcCUrr1pGWiPm/CdZvKQoiM0DV7eTlmR4d4ujJC3Kq5BJSOlFM2IkaSdvhKCcg5YPUdJtcT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2AH6tONLz4qt+GBxzlOuEovAIhmM7mXU3zPACTxdwlICKPwH3
	9vyV3YwEH+E6hY+DNVQ9juUF9OSkpikMpuOUI/C98QvAJqVCSBdFCYCT
X-Gm-Gg: ASbGncsBYo2Qc/RdVK1qOcIaC0Xe2fMxyNVA9izg+NrK7tO8OB/4OZ21W55S/QbZ1Gl
	/GRkAk+dnnrKzHGVayueeE68LnaEfkafKDc+Ro8mqp2FJi4JCPVZTYxqy7ttfn/7+QNbD/l9LAI
	H+ITA3pT40MK99nHmcRKdK8VyDGQQtybdtZxJ+UEQghnPRCpUgkyCPF7d0NFo/ulBHXpNG7DXac
	4+UqI5FGoB69OEryM2qD3+32/ftzoBsAeG/kU5il1gAhCYcrBpPlqNUq2PmX9fWoIXKWZAmOlTv
	wPhKCiXwPSdbtgcW3ECw0RtVRwTnVj+x9yCMw+HxEPDuLry646PWvQyC4cWTyVYdBm2e0eQc2/M
	9NLJ6ecHjbkEC/+k670ESQAJpRFY0k4LXzHKoZcHwpCpzcbI3ow==
X-Google-Smtp-Source: AGHT+IGo1h4skDOY0gnPLoWISFUW5QAgaJqv6OnKZUGGuJuaXpCB4f6qGyZgMzr2CQkmgdVZ+Q6xMQ==
X-Received: by 2002:a05:600c:674a:b0:46f:b327:31c5 with SMTP id 5b1f17b1804b1-471177ba398mr87335545e9.0.1760948374422;
        Mon, 20 Oct 2025 01:19:34 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce3e2sm14060552f8f.47.2025.10.20.01.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:19:34 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 20 Oct 2025 10:19:32 +0200
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, mattbobrowski@google.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, leon.hwang@linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 3/5] bpf,x86: add tracing session supporting
 for x86_64
Message-ID: <aPXwlJ57B9egtr8x@krava>
References: <20251018142124.783206-1-dongml2@chinatelecom.cn>
 <20251018142124.783206-4-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018142124.783206-4-dongml2@chinatelecom.cn>

On Sat, Oct 18, 2025 at 10:21:22PM +0800, Menglong Dong wrote:

SNIP

>  /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
>  #define LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack)	\
>  	__LOAD_TCC_PTR(-round_up(stack, 8) - 8)
> @@ -3179,8 +3270,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>  					 void *func_addr)
>  {
>  	int i, ret, nr_regs = m->nr_args, stack_size = 0;
> -	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
> +	int regs_off, nregs_off, session_off, ip_off, run_ctx_off,
> +	    arg_stack_off, rbx_off;
>  	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
> +	struct bpf_tramp_links *session = &tlinks[BPF_TRAMP_SESSION];
>  	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>  	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
>  	void *orig_call = func_addr;
> @@ -3222,6 +3315,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>  	 *
>  	 * RBP - nregs_off [ regs count	     ]  always
>  	 *
> +	 * RBP - session_off [ session flags ] tracing session
> +	 *
>  	 * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
>  	 *
>  	 * RBP - rbx_off   [ rbx value       ]  always
> @@ -3246,6 +3341,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>  	/* regs count  */
>  	stack_size += 8;
>  	nregs_off = stack_size;
> +	stack_size += 8;
> +	session_off = stack_size;

should this depend on session->nr_links ?

jirka

>  
>  	if (flags & BPF_TRAMP_F_IP_ARG)
>  		stack_size += 8; /* room for IP address argument */
> @@ -3345,6 +3442,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>  			return -EINVAL;
>  	}
>  
> +	if (session->nr_links) {
> +		if (invoke_bpf_session_entry(m, &prog, session, regs_off,
> +					     run_ctx_off, session_off,
> +					     image, rw_image))
> +			return -EINVAL;
> +	}
> +
>  	if (fmod_ret->nr_links) {
>  		branches = kcalloc(fmod_ret->nr_links, sizeof(u8 *),
>  				   GFP_KERNEL);
> @@ -3409,6 +3513,15 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>  		}
>  	}
>  
> +	if (session->nr_links) {
> +		if (invoke_bpf_session_exit(m, &prog, session, regs_off,
> +					    run_ctx_off, session_off,
> +					    image, rw_image)) {
> +			ret = -EINVAL;
> +			goto cleanup;
> +		}
> +	}
> +
>  	if (flags & BPF_TRAMP_F_RESTORE_REGS)
>  		restore_regs(m, &prog, regs_off);
>  
> -- 
> 2.51.0
> 

