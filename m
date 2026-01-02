Return-Path: <bpf+bounces-77667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAC3CED98E
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 02:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52C2230084F0
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 01:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2414F1FDA92;
	Fri,  2 Jan 2026 01:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Z1GRH1aN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1766C1F03DE
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 01:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767318254; cv=none; b=YZqEBjTCSTrwo4aT3FNPoGWgz9gUUpfA0tyKaL2f3HMaippKpFuaS3/cNfgUamWF6GZScGozHehbdYdFjVGjyHFNpiPIVBsRVhEA5DTfGdx5UmiWxEdo7UZMreGLwZL0Z0qVaS5Plyjny9bcuA1j0YWOCH+5Qhavk7gG+mkW3sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767318254; c=relaxed/simple;
	bh=LR4tU4GXthxjE6VJs3IVB6vuMon9Khg2+xuOHREpaVY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JLwQJ/RfKN9J+djrdEhFAxABjYWwxuUawpX2gdT1cPNSiH4jJZKoQT4Bkkt1zTUBJbuJvm2f9R5fzYxQhp9wU0cnyWrd46zCIzaFGxxgp6OKdLCbeIGvulN29NXC/MEMtvfVk6fGGBFCnrOmQ9y3GDH7EExcYtaT2HPxMphHOJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Z1GRH1aN; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8888a1c50e8so159703286d6.0
        for <bpf@vger.kernel.org>; Thu, 01 Jan 2026 17:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1767318248; x=1767923048; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpXLMUfDuJ/Fu63DPPH8WP4FsiAvfGERa7hGELcZVVs=;
        b=Z1GRH1aN6q/o1/+BZgsNY9Sr23HG/H5vF4oYGo10qvhRV07KOAP5S21lLY+I9qXH0v
         BYzkcgIR+UDiu2qgUIAEiAjw9ZIefqYvUk46+az50W5OEc1qywqtb3e8EbN6Fvy0Y3mc
         F6+OiRRyIgjv2jEq50vTPbkfIuUzixk4XVMS9PbNovjCx0f5TxNeADOoxRvpU/o1xwPC
         Xe8F1msKaUf6gB7ZZk/MgOSWUIMR8EpNuvrz1Rg3QvFOGuEV5QBoximhX/vlKePHbB/N
         AN1EWs2LCFL1+lBjvcvsvBjC605iDJD5pKjIot1y8NXwT1ltDqHJbcMJqXW59FkkHrGd
         hMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767318248; x=1767923048;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HpXLMUfDuJ/Fu63DPPH8WP4FsiAvfGERa7hGELcZVVs=;
        b=MXNpVu+dSqdYAV6WI2VqT+fENCOXvMcoAwgZJbs9QHyYx53DAIsuKP+2KaJ13ALs8C
         M8Q9NT5Rwbd+ReDi43TeytqD1IWZLVaOqruUQILBwMMccy2jkU9hSZC1ke7ytU4Iu4c+
         8BOP2CpynEEyWfC6d+kG2dOeZY8J0EM9jiRtuLFdsUZe9eIdEb0OwmBavms/00Mo31Df
         +UqmnesY+S2D/j73kHQpLusPsQojYzgD8jfzao/irzEQfUgpU55twwL4t1VHUXlE7Qlj
         bVhZWesN6RCw4GzPGaJP+noZ7uBlM5oWUC7GvUepyOKe2lSmEblTcuf69qosUVFMpjPj
         MtJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEQlEzA+c73BgQzC11J6Z1GpZilYphMB7JhPl46cj+f+MmqeoymnTJ3292j2TS3riQ/DY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0fpBX7BA7AxCDQnRZCIJ0nV3KHWglqz0lRadFcgVl6+NYEiML
	jTVnXVixBtKJT4fey1Ej/Dy+Ohj513sgsFiNJ1iGt0Z/q8DoynTokWXEYhyvf7m4c3A=
X-Gm-Gg: AY/fxX4VbWHHYYRc0pEvHDEp6Fiorsa34JKT0tmFz65ulsIzCAMXTBeO30S/0vOXbQv
	BJ4oWkmJDa9qLfPAYfH9oBiVJlowIqVLeT26l2owJEafg9Fz0puuI0q79XgpjfUtHiE0H7hunC1
	1rFjwozVpJNbM1q2kCidTp9NIRVMEgQkwxD/nVfBENVIAZ3HJr+RLVTkT2zP02J8fjInpISRgf1
	xbyGJg1j6aEKOXR5aiOXbXOT4+g/th/wvYS2EUZof4Tq70fEIVey2byhisDA2DjphdtfYNRhVMT
	VyV3sneI/rGA1mWricO2bqG4tiLB6tsiahVqzfGjuMf7youXN8oVhCCmoiQgSlCPNBdWJEKPaNL
	P7ROvQZbRVeXWcjJbjnUMUfzjJqaEV8eeLLMZDIg03+FVUsiRZcmdZRgb8fsoq3IpKdeIbW02LR
	zRbrq9IUKMRCQ=
X-Google-Smtp-Source: AGHT+IFM7rR2a7UMIerWZ13cFNtq0CxUgIV7h2McOaP3Mu7lDNDLy/90iF0iYLDfV5ak0y+t5ANL4g==
X-Received: by 2002:a05:6214:1924:b0:882:63cf:396f with SMTP id 6a1803df08f44-88d845357fdmr431506666d6.43.1767318248409;
        Thu, 01 Jan 2026 17:44:08 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0971ed98dsm3116727185a.31.2026.01.01.17.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jan 2026 17:44:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Jan 2026 20:44:06 -0500
Message-Id: <DFDQ169CWJOR.2LBC0TZLY5CN6@etsalapatis.com>
Cc: "Puranjay Mohan" <puranjay12@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 6/9] selftests: bpf: fix
 test_kfunc_dynptr_param
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20251231171118.1174007-1-puranjay@kernel.org>
 <20251231171118.1174007-7-puranjay@kernel.org>
In-Reply-To: <20251231171118.1174007-7-puranjay@kernel.org>

On Wed Dec 31, 2025 at 12:08 PM EST, Puranjay Mohan wrote:
> As verifier now assumes that all kfuncs only takes trusted pointer
> arguments, passing 0 (NULL) to a kfunc that doesn't mark the argument as
> __nullable or __opt will be rejected with a failure message of: Possibly
> NULL pointer passed to trusted arg<n>
>
> Pass a non-null value to the kfunc to test the expected failure mode.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c =
b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> index 061befb004c2..d249113ed657 100644
> --- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> +++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> @@ -48,10 +48,9 @@ SEC("?lsm.s/bpf")
>  __failure __msg("arg#0 expected pointer to stack or const struct bpf_dyn=
ptr")
>  int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned i=
nt size, bool kernel)
>  {
> -	unsigned long val =3D 0;
> +	static struct bpf_dynptr val;
> =20
> -	return bpf_verify_pkcs7_signature((struct bpf_dynptr *)val,
> -					  (struct bpf_dynptr *)val, NULL);
> +	return bpf_verify_pkcs7_signature(&val, &val, NULL);
>  }
> =20
>  SEC("lsm.s/bpf")


