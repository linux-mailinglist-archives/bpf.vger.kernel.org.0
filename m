Return-Path: <bpf+bounces-22046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EE585589B
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 02:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875751C2868D
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 01:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA15EDE;
	Thu, 15 Feb 2024 01:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdU3PnCT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E8AEC7
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 01:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707959472; cv=none; b=mel2XG+YLh8s0ykBCtby5KbRub1N3BNw+c/4QoStlosEYk9jSBVHtsOhAyAIlPUEw/4ikKExwyasfJf7Owv9m1X3Jf5TRU3EA2xxwKC8RrMuHYSKMGXEKaro/SZzawy58VrmC3W8ZWCJ/cklKwOW9DyOyFRKGlzDW5kXCxheDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707959472; c=relaxed/simple;
	bh=+3xQiO6KfDdDnw4aZAL0wLS6+rVlNQSjGhJRaU34BTA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FKQOohaeqh/wgMrn5ekfjgKMhCfRwVAVCujsqTNEAGmXxkDD2dzXtMdhshHbdNDzvcvG9ULhlv3H9bkLI53RK1ttmfVofy5WNjFX0BBfKyzxmLDKopPJtgkc+HTksLcVDnxZAjuy6NAgp+YpEWYg5uziLm1U6sloXqCPzeWuX9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdU3PnCT; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so3791101fa.3
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 17:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707959469; x=1708564269; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yGGahmpMvrNNr1Ro655sUkgaREK+6ji7IeilOMwTz3Y=;
        b=MdU3PnCTMINVNqq4rgOrwq+0HGn8JHQVWdvPhQUdyn+9Dc9HPX0Lej8cu2Brx/24KZ
         KbEs9mEvwMvU9YmNoTlZzdEm5BfPBT/LDjEx9owGkk9EzNsV1c26k46BSL4Yfl8oo4F9
         wjno+MgD1ey9jxW/YosdX7yCFcAFdSxHLoPTMW8Zr49aREiQAJ+2hmbdEg8pwPjMGWan
         DJNCEJxQDBvxYlAvUcWJVQiJbEiMS6j62lQ28LwM+mDmCLXwkVw+MJPlCUiOJRkBNH/a
         9DVR2k5I3xcvh4e/j/F7PwpIzXhDSRuzsZIaRPqMHmOdaLlkvT7M2YQeoR1JEWe+i0qF
         IbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707959469; x=1708564269;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGGahmpMvrNNr1Ro655sUkgaREK+6ji7IeilOMwTz3Y=;
        b=ScyFaqWjti2GZ40FtCQYTAXT/wEg2WklO0koLv5Zn3McpNSAiLj3+LiLLHEvtIVFJJ
         j5ygqHb8ocz5T/E8jo7qiAvJJIeORhEKBDCX1EWZhVc8eyDKnwfE/8JDXxGgoDmQ8UkI
         1JeS/c/T4+qBwTQW5OQh7/3DwkggZ4Dy5rTrZy4fN0PWSSDisEo0RytDxmhHxOVtNrHr
         0ne0iLa5s8adwTLQ/HJB3Fas9cTwNVlsvOkigfi5jBAREejB5QU0/QIcJcUIDc54UME6
         L9SEG1pAl5gRi+ztf/kh6+EGHpOsAyF+BzWoG2OmfCMub2XMXZiKYQP4XLRi4dfGFZYz
         1c2g==
X-Forwarded-Encrypted: i=1; AJvYcCX7yT9yjzL23NLmcP3i2aDJ8kiAs97AstvbTMNqJidwX09sQH4JQlcVSIEI8RF0ZJqArk9hPpSm1IdWtH8kWDxIFKU8
X-Gm-Message-State: AOJu0YwmayK/XsGRsmDxW0xLenAqTU6MUDhGrjIhE0FBx35C5rNfitN3
	WLz8cG9Oe9vvQi6KsEyraYb34ZZortZvZM6mOnkkKEwLZwDsKPU+
X-Google-Smtp-Source: AGHT+IHHdiy/HIgKTcqY/VZlDJEKl/WXK6eMchm1qNJXiq2xgVv4hgfxvS1UeJK3rcfC7q94iJZW2w==
X-Received: by 2002:a2e:a717:0:b0:2d0:a9a4:10ec with SMTP id s23-20020a2ea717000000b002d0a9a410ecmr172525lje.45.1707959468958;
        Wed, 14 Feb 2024 17:11:08 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q8-20020aa7da88000000b005638a4f935dsm73518eds.4.2024.02.14.17.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 17:11:08 -0800 (PST)
Message-ID: <95ec346d0b294e9d72b524d07af02c987aa59460.camel@gmail.com>
Subject: Re: [RFC PATCH v1 04/14] bpf: Refactor check_pseudo_btf_id's BTF
 reference bump
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>,  Tejun Heo
 <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>,
 Rishabh Iyer <rishabh.iyer@epfl.ch>, Sanidhya Kashyap
 <sanidhya.kashyap@epfl.ch>
Date: Thu, 15 Feb 2024 03:11:06 +0200
In-Reply-To: <20240201042109.1150490-5-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
	 <20240201042109.1150490-5-memxor@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-01 at 04:20 +0000, Kumar Kartikeya Dwivedi wrote:
> Refactor check_pseudo_btf_id's code which adds a new BTF reference to
> the used_btfs into a separate helper function called add_used_btfs. This
> will be later useful in exception frame generation to take BTF
> references with their modules, so that we can keep the modules alive
> whose functions may be required to unwind a given BPF program when it
> eventually throws an exception.

[...]

> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +static int add_used_btf(struct bpf_verifier_env *env, struct btf *btf)

[...]

> +	if (env->used_btf_cnt >=3D MAX_USED_BTFS) {
> +		err =3D -E2BIG;
> +		goto err;

Nit: could be "return -E2BIG"

> +	}
> +
> +	btf_mod =3D &env->used_btfs[env->used_btf_cnt];
> +	btf_mod->btf =3D btf;
> +	btf_mod->module =3D NULL;
> +
> +	/* if we reference variables from kernel module, bump its refcount */
> +	if (btf_is_module(btf)) {
> +		btf_mod->module =3D btf_try_get_module(btf);
> +		if (!btf_mod->module) {
> +			err =3D -ENXIO;
> +			goto err;

Nit: could be "return -ENXIO"

> +		}
> +	}
> +	env->used_btf_cnt++;
> +	return 0;
> +err:
> +	return err;
> +}
> +



