Return-Path: <bpf+bounces-16274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08B77FF2CC
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 15:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92F45B20FAF
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F524879F;
	Thu, 30 Nov 2023 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYI84ZE7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA7D93
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 06:47:23 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9fa2714e828so144682566b.1
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 06:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701355642; x=1701960442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Hl1/fISzWTmcDIWaAhQv7y3OdrjyjzxR0aSI3jUOxw=;
        b=KYI84ZE7yvciEiIR8EOZZ19jWtzeG6i4n4uKHlWyXwYDv1xt5k0au8VOaMsvdwDi9e
         F2Jq+BcStL4RvQtJCIjdA/Ebb0gzh5/dOFSajaV5HDeaRzHz5iYYi8QPtiZ/prz7SPPf
         G2q6ZcqSHzHPr4GZ9wQEDhjHwuA/treU4ODKC7Y2b/5ekgO7DrDX2tlH+1Gy9qI5oOnX
         OO9dFaUeZvhMAaRjWfyWGyx7m4hlT0Ch1m/RZFRba4sHCuQiRDjNQ9DvpGiFtlZxczKe
         eVz0vEkV2ca3MUsN8gPfus+LqUo11HHA/U7Kv91RtZAAx4rIKYBAiVzSKcY71vvzQELk
         bNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701355642; x=1701960442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Hl1/fISzWTmcDIWaAhQv7y3OdrjyjzxR0aSI3jUOxw=;
        b=oJaPibAj4fojgF9iPKMs2aRAjmVXIIh3XR0apsCMEI1aAAMk3xPIvQP9llYdwNmaQp
         NzmCH79ruPdbzv9ZcYoFmpNQ6MWnZJsf8qDpdqxF0hbM51xw4ekUTcTVQlewmeX+C1Rg
         KOJotBd6WNagNdraxvRj0eZZN+fBkVuHUNLQ/SVd3UuFyjhypQ0VZY6Eo70tiJaG/3Am
         EonZB8koqqQui6Fba/qiX8pyHM+H/4QX+gqhP1CI6ycm3p11EfWOgWY144IHBfBuzVzH
         oagmocgWf62RiW8qFeQriQWWFPiSIOnMeJ1T1++L5mIZK4uGO+TSHIhWv/BFF139lvK4
         w/GA==
X-Gm-Message-State: AOJu0YxO8TaDzc6z6DOZYCV7GFLpWOlqBV8cPQYM4b04Ap/lpO0w00e6
	ZfV6nEIt67A9lXJoUFEY2rQ=
X-Google-Smtp-Source: AGHT+IFiECc/xKHRrzVKlFYi50ilO7eAMX2DTZZMw1eZC2CqL37jniGC1wmPKVFZOm2TosExzXc0BA==
X-Received: by 2002:a17:906:7e0c:b0:a02:5ebc:ea81 with SMTP id e12-20020a1709067e0c00b00a025ebcea81mr16336001ejr.45.1701355641633;
        Thu, 30 Nov 2023 06:47:21 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906715500b00a1185ad53c6sm748273ejj.199.2023.11.30.06.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:47:21 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 30 Nov 2023 15:47:19 +0100
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	olsajiri@gmail.com
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: Add test for recursive
 attachment of tracing progs
Message-ID: <ZWigd7sMA2nVM0rf@krava>
References: <20231129195240.19091-1-9erthalion6@gmail.com>
 <20231129195240.19091-3-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129195240.19091-3-9erthalion6@gmail.com>

On Wed, Nov 29, 2023 at 08:52:37PM +0100, Dmitrii Dolgov wrote:

SNIP

> +void test_recursive_fentry_attach(void)
> +{
> +	struct fentry_recursive_target *target_skel = NULL;
> +	struct fentry_recursive *tracing_chain[ATTACH_DEPTH + 1] = {};
> +	struct bpf_program *prog;
> +	int prev_fd, err;
> +
> +	target_skel = fentry_recursive_target__open_and_load();
> +	if (!ASSERT_OK_PTR(target_skel, "fentry_recursive_target__open_and_load"))
> +		goto close_prog;
> +
> +	/* This is going to be the start of the chain */
> +	tracing_chain[0] = fentry_recursive__open();
> +	if (!ASSERT_OK_PTR(tracing_chain[0], "fentry_recursive__open"))
> +		goto close_prog;
> +
> +	prog = tracing_chain[0]->progs.recursive_attach;
> +	prev_fd = bpf_program__fd(target_skel->progs.test1);
> +	err = bpf_program__set_attach_target(prog, prev_fd, "test1");
> +	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
> +		goto close_prog;
> +
> +	err = fentry_recursive__load(tracing_chain[0]);
> +	if (!ASSERT_OK(err, "fentry_recursive__load"))
> +		goto close_prog;

should you call fentry_recursive__attach in here as well?

> +
> +	/* Create an attachment chain to exhaust the limit */
> +	for (int i = 1; i < ATTACH_DEPTH; i++) {
> +		tracing_chain[i] = fentry_recursive__open();
> +		if (!ASSERT_OK_PTR(tracing_chain[i], "fentry_recursive__open"))
> +			goto close_prog;
> +
> +		prog = tracing_chain[i]->progs.recursive_attach;
> +		prev_fd = bpf_program__fd(tracing_chain[i-1]->progs.recursive_attach);

or maybe better brach here for (i == 0) and call

  bpf_program__set_attach_target(prog, prev_fd, "test1");


> +		err = bpf_program__set_attach_target(prog, prev_fd, "recursive_attach");
> +		if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
> +			goto close_prog;
> +
> +		err = fentry_recursive__load(tracing_chain[i]);
> +		if (!ASSERT_OK(err, "fentry_recursive__load"))
> +			goto close_prog;
> +
> +		err = fentry_recursive__attach(tracing_chain[i]);
> +		if (!ASSERT_OK(err, "fentry_recursive__attach"))
> +			goto close_prog;
> +	}
> +
> +	/* The next attachment would fail */
> +	tracing_chain[ATTACH_DEPTH] = fentry_recursive__open();
> +	if (!ASSERT_OK_PTR(tracing_chain[ATTACH_DEPTH], "last fentry_recursive__open"))
> +		goto close_prog;
> +
> +	prog = tracing_chain[ATTACH_DEPTH]->progs.recursive_attach;
> +	prev_fd = bpf_program__fd(tracing_chain[ATTACH_DEPTH - 1]->progs.recursive_attach);
> +	err = bpf_program__set_attach_target(prog, prev_fd, "recursive_attach");
> +	if (!ASSERT_OK(err, "last bpf_program__set_attach_target"))
> +		goto close_prog;
> +
> +	err = fentry_recursive__load(tracing_chain[ATTACH_DEPTH]);
> +	if (!ASSERT_ERR(err, "last fentry_recursive__load"))
> +		goto close_prog;
> +
> +close_prog:
> +	fentry_recursive_target__destroy(target_skel);
> +	for (int i = 1; i < ATTACH_DEPTH + 1; i++) {

i = 0 ?

jirka

> +		if (tracing_chain[i])
> +			fentry_recursive__destroy(tracing_chain[i]);
> +	}
> +}

SNIP

