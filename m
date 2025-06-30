Return-Path: <bpf+bounces-61882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A7AAEE6D2
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 20:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D64E189EE84
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 18:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA562E613F;
	Mon, 30 Jun 2025 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA6Q1KDO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1062F4A;
	Mon, 30 Jun 2025 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751308453; cv=none; b=sDIWn27I/E9ThUfE6AJGvMq3O5gs8cMMuLC78wVujmEFEo9naJSPNBxk+338Psg0SAAhyMpvKYCzdvjHhfzkw+niAI53Ik4v8xlBkcUhhkdA6eqdQP7nzdynGfwP3U+xozM1xWL64y1fJUSLs1clIGN8EBg5g4fUwq5K/o66lG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751308453; c=relaxed/simple;
	bh=ih8iTMpbDzJ3F4bW6sFEJ7ApC3ntKOHMHgfTprO4R9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbtiegmsQ0S8K0CeW28dEL6bBTxTQ+LGRhv1eE+TRqu8UolNf8U/qkI5AfPztQBfs7oWkABK5y/AmRC6S2qwtE7bjVdWbVdJBV3B6auh3QLDsElftvZ1hk5Zuf24mYc15WNlJfcvcvXZ6B6BBffuqNUR7H/E3pNNVjJ3Y+Pp83U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aA6Q1KDO; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so2656118a12.3;
        Mon, 30 Jun 2025 11:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751308451; x=1751913251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BuEgfhvA7mRC41z4//iQfNuYd37ion0pUZNkHwOfLC0=;
        b=aA6Q1KDO73th3VE4KeiLZrBazgjBU74fYMAzkoRALH09g7savakYk9Z74/uMttGyeG
         SD3JjL5SDvswAKVwvFmfkcsG7h94EesoKa0qOwviYrMnw8NP6D1CgTGGy+KXJ2QN2T3h
         WOaZYY+bUXB2ooEJM8/yelu6ml1CIjC7QhFKGJN461R6ICGTDCRTc8XV2pyDuKfYDRPV
         zMU1JY1wKsXGSeQcH2YEEtixP/E4jb5xVkDlfDBSrY0XHfu2jTE0+8aeq63Bjt+taHxg
         U5JZqJAkc4XvDnnllpxhz6Vm0CcKZNitNUiWT5ZBo0hmk7txgfyP4qLwHpqdscW7zkpk
         f79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751308451; x=1751913251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuEgfhvA7mRC41z4//iQfNuYd37ion0pUZNkHwOfLC0=;
        b=UPP8ChIkt3gVBzrzrPNFaqPOFj4/i2oNeAN6WymcVRcw/Yv1kl0DvpW/ey19Y0ziKn
         PYQsxYpxus+dhXSF+pVXfJ6MfoeIl4cEm3OBLOkIPH0ChRAXAk6BL+2ZKoRizeVgw1+V
         Nj4Ddll07p7civZ3qlleEloeFQITSysVd9a6b8RWKSBobV51NjFqSzwU+arXMbI1Y/uR
         juPFejR7pxhZe7PY6gDhdHoLwkqNJh8DqJ8cMU00HkV2MKYzGs8vi+hfmbM1jbm11WFm
         t5Euj+19OnR5Ht2HQ+gISO1n+KGcH4i3P3oDplySWgcR2NkOr+pxb0k3+nFspPYe0NaP
         MHDA==
X-Forwarded-Encrypted: i=1; AJvYcCVUbONIIEAohNsPtIrQ73WwUvmCnkYhYVcA7a9ukhwhQHNLBocY4byp4dH2qaXXxxKx288=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRwUW6KwQU+U7ss7vGeQ1OqixqsfUuTBPQ6Ese5X9dk+tRC+HX
	PbmFoegNbHUTva1sGmuDFOK1lTnlxluU1ZhXjQfov/bSV9A+r/JDOfU=
X-Gm-Gg: ASbGnctJKRyv2DIOhFtP93ze8TNykHJeOLe+d5veMUTnZxDxU5oe5JtTt4qpAgdNz2j
	V74vM+l5J9Kr9Z3eiVX3BPZ1pq1izmiDw8LUx89O1cCETTAJIAg+SVJ3SB85V2I5YoYQ9/auOqn
	nntDs4TGH/b6nL8IF/0dHT3ORFYfpjvWVa81TOWLUsWgAUTDxEPsWYfBoNxWgVW358s9Js9d3XC
	vL4gyqqlOvO4S2dGbrFxlvSgGH7Lu33FxM1i5pe0DCLa5jIXSQnFonqykiTmN2LDyo5hUWu+DLL
	uCq/zqfCugFJFR8jBbOS4tQIO9NSwDInaxWqNP2vO1K+WWBkFP1xZNWeGzGPxuQhYYQsbNjv9Y4
	xz+ffp/lQy4hFEWWnb7lR0wU=
X-Google-Smtp-Source: AGHT+IGVUF8SoAe8eXvAYiVauUsfsOhtdRUT4A5A+OZGO1y7TdKNBPJ5PypvN36fW1MW/+b1EiE0iw==
X-Received: by 2002:a05:6a21:6d8c:b0:21f:e9be:7c3f with SMTP id adf61e73a8af0-220a1277225mr20548149637.11.1751308450905;
        Mon, 30 Jun 2025 11:34:10 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b35016ee1e0sm4799757a12.54.2025.06.30.11.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:34:10 -0700 (PDT)
Date: Mon, 30 Jun 2025 11:34:09 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jordan Rife <jordan@jrife.io>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v3 bpf-next 08/12] selftests/bpf: Allow for iteration
 over multiple states
Message-ID: <aGLYoSIEWtmWieLM@mini-arch>
References: <20250630171709.113813-1-jordan@jrife.io>
 <20250630171709.113813-9-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630171709.113813-9-jordan@jrife.io>

On 06/30, Jordan Rife wrote:
> Add parentheses around loopback address check to fix up logic and make
> the socket state filter configurable for the TCP socket iterators.
> Iterators can skip the socket state check by setting ss to 0.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> ---
>  .../selftests/bpf/prog_tests/sock_iter_batch.c        |  2 ++
>  tools/testing/selftests/bpf/progs/sock_iter_batch.c   | 11 ++++++-----
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
> index 0d0f1b4debff..afe0f55ead75 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
> @@ -433,6 +433,7 @@ static void do_resume_test(struct test_case *tc)
>  	skel->rodata->ports[0] = 0;
>  	skel->rodata->ports[1] = 0;
>  	skel->rodata->sf = tc->family;
> +	skel->rodata->ss = 0;
>  
>  	err = sock_iter_batch__load(skel);
>  	if (!ASSERT_OK(err, "sock_iter_batch__load"))
> @@ -498,6 +499,7 @@ static void do_test(int sock_type, bool onebyone)
>  		skel->rodata->ports[i] = ntohs(local_port);
>  	}
>  	skel->rodata->sf = AF_INET6;

[..]

> +	skel->rodata->ss = TCP_LISTEN;

nit: let's maybe add `if (sock_type == SOCK_STREAM)` here? I see that you're
adding ss check only to the tcp prog, but let's also clearly state
the intent here..

