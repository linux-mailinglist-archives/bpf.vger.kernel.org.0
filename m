Return-Path: <bpf+bounces-42550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0709A5700
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 23:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B4B1C20CB1
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 21:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3367198838;
	Sun, 20 Oct 2024 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RND9UDLR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFAABA33
	for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729461555; cv=none; b=oFwrmtYveb9322NUchoUKWLTtlobqhjdz/NYxsB8TMMuM5QR5Xh2a44Odnqm/Nat+Bhwf39UVGu973jtvlTWh8Ktaom7HFDZusDV9a59zyd8j/7qZSLe0qg5Z27HadsdFeZ8YHaDoylKD2qNXgOIuPLHbsYhEhgPo4v1nWOLM6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729461555; c=relaxed/simple;
	bh=1sJ2g0XzfY1Cs+XFHiQ/l8Sr054MtdIFxi59z+wcUrA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INZ/rNcbq8Sk9cQ65Zl2vTN5HBioNLcNHOrklsBlt7fBrhh/YpF3sX2qDPOqRbbW48+byk49qgAPdM4DIn4XtYibyRV0rKgvVP4l3db87aAmvjA2c9kIT78kfsXAPo61jhInK1RkMBypJ7Afq+SdEkhxAaABFciWtDJI+pO+T4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RND9UDLR; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso8332150a12.0
        for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 14:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729461551; x=1730066351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D7VqpDceVg8xL0GCYGwzlQm8IgxQZ6X5NDUE+R5S6XM=;
        b=RND9UDLRBsUEW2eT+X/v/uGo3nZKHxoPYDgsEQ4yWWoUDt+55VdA+33Ubliy1TStAO
         IkOVOkLBHbNOWCvs7C//3AwmYt4/6BIPTctyqn1X7nQyHdWZhYQh7Y1BF8SyMdKsmxUC
         qPwtpnhAnGB9BXwudJj2gbyk5eg9wOS34cnRw9zYEP3c82kyQo7SPyRwc441biyOv/ON
         9LdxhUEF9dSdzEXHSDOgyaUvy3lNp+P3ein3/xLmVzQh8R4uBAo2Clu99tA+u0PSeb28
         7zLAuR0ydua8LHMbdhaVAAshbuguQ4VTjMbAd/kozM8pL7O00rUOx1jlRFdY2gWZTM0q
         y44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729461551; x=1730066351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7VqpDceVg8xL0GCYGwzlQm8IgxQZ6X5NDUE+R5S6XM=;
        b=vazmlm4+WqR5ROZoCfSq3a/RgMknjroYw5JGcVhoKKHfZxjQE5OEHqgV8sFBk79zV+
         yFIx8lpswTtVl8uWBkRyy0A3mr6UwdnkI4ypd+86CrURsKSlL48vibS1SvQo+yuEgfiO
         3MQXdU3nYCWdzf9rua9PbOKBqL4q8gOwzk/q9dN7S/+kNW7A3OUHhWlxShlmHgtSLWwO
         Wys07+y15vHaK9qKAUz4xXkpeaqU9wtHeEHQZdwhcZpL9bTIOiXupOR+Q52oglKeJkFo
         2O8yCHfJg7JmSHfuuhxswsgg7jVwUCXM/Te7mxQH6P5j3c7b/O+pXzFGxjcHf8vVEudS
         BXtA==
X-Gm-Message-State: AOJu0Yxq03VXXII0qpGLk+ShledFGUKP8c8ncD/QXRVlb+rOAgBCTuoW
	pfxPLqGWvaZPmFBKZaaaFqrUlKrinELrkAiFMjhuZJ1oBBMA/to+
X-Google-Smtp-Source: AGHT+IHNC5aSNlW75uXzT7Y1/ek8x4T3AapTmI2Nubkfy3AVOCI612+kxNnHy71ZWCZqJ9LAfEtKGA==
X-Received: by 2002:a05:6402:370a:b0:5c9:1cdf:bbae with SMTP id 4fb4d7f45d1cf-5ca0b0d01demr8177408a12.11.1729461551239;
        Sun, 20 Oct 2024 14:59:11 -0700 (PDT)
Received: from krava (85-193-35-5.rib.o2.cz. [85.193.35.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a654c4sm1274334a12.31.2024.10.20.14.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 14:59:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 20 Oct 2024 23:59:05 +0200
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v6 8/9] selftests/bpf: Add tracing prog private
 stack tests
Message-ID: <ZxV9KUHDcRPC5s9_@krava>
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
 <20241020191431.2108197-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020191431.2108197-1-yonghong.song@linux.dev>

On Sun, Oct 20, 2024 at 12:14:31PM -0700, Yonghong Song wrote:

SNIP

> +__naked __noinline __used
> +static unsigned long loop_callback(void)
> +{
> +	asm volatile (
> +	"call %[bpf_get_prandom_u32];"
> +	"r1 = 42;"
> +	"*(u64 *)(r10 - 512) = r1;"
> +	"call cumulative_stack_depth_subprog;"
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_common);
> +}
> +
> +SEC("raw_tp")
> +__description("Private stack, callback")
> +__success
> +__arch_x86_64
> +/* for func loop_callback */
> +__jited("func #1")
> +__jited("	endbr64")

this should fail if CONFIG_X86_KERNEL_IBT is not enabled, right?

hm, but I can see that also in other tests, so I guess it's fine,
should we add it to config.x86_64 ?

jirka

