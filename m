Return-Path: <bpf+bounces-78760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C34D1B815
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 22:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3124E301331F
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 21:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C93B35294A;
	Tue, 13 Jan 2026 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9RH8xyH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E52350D49
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341588; cv=none; b=SEs0VgOVtxIBB2PcmVRH2x/UZ9aVWh7qT51sPL6Izby7aFgFwFsHAQBkN4vCdvIShfkL0/9UaSPRGwN2rDJtL5feisCKux/GZZnjD/tYd1BobitEyv8g+XeD6tOP//DK1YmEaYj2O6xyqZr5Oo3+S1olCP0gqxphucU3hrVpVjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341588; c=relaxed/simple;
	bh=JMKPIWgq8b9DBCFSMppOOhRohcyexWNss6iyCclDIgo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sKPTFiA4BmBq9BvldLqqZdhQm+xl/ld5Tr4Nz3hgyqfIFzZlgq5hcQ3+p7ILaeK1H5ja1HQTJwDo8lMDQIhg8TdpKh75MImmidGAYWGPFYle2vVyDnRfC9KBrYZ55fxC/mmp7TU9QWBk+jU4eEtjdry+kEz5TBmfJHxi0P1adwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9RH8xyH; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c5e051a47ddso122448a12.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 13:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768341587; x=1768946387; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JTlRjbsQTQjHMPHLzcQF6C84Ga9JaD/ogkGGtY0cAkU=;
        b=Z9RH8xyH2sm7aH7YqwaAaxnwhUbjgwMdMuT9dk/anRy8cfvnKPQQjd5UKB2CS+Lpc8
         NFG+NkUnaGn5QiMuU2Z6PqctYPtelOkqXXjQQuJBG2FqQuMv1atXsxQ76j5pkb8dClkH
         I4ZEpCwiLh1O3CCvBCz6yn+dFIcBgSPyQsJRL4lNGbJguq+aMhHvEV/lD9GbjR1uKj0C
         L3aVmfrxVcfEjTdHuGzQ3dm4PkbuLjCBmCQpNO7yqOI4Dn9qVuXcqTo2mVAwum/CI8PN
         d2kser1YMMIMbEWX+o0wO1lKk6pytpNTHdPcXaTKvgVrAFVcAuALhCqs0oKRZoQuKunt
         Vywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768341587; x=1768946387;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTlRjbsQTQjHMPHLzcQF6C84Ga9JaD/ogkGGtY0cAkU=;
        b=jw6/Iwli5XIYWz5EP4K05ihDP5lAEGS7WOGMZM8xOhXSZ7YoGOP56HjYWPydOQ/T7g
         mDhAE452Lwlf3fdZfbxJFEU1ReO4UFRZ+VxHFz0PN1kgo8637cZXUxnglGNEJ5AgbU0t
         BkL8xHwXpIUv6tlYaqhflMyZjd8B+bbODu6KEwm8mGt3uSPmWuEz/J8m93KgJ7na4ST2
         ZXGEZNODw5T8kWuH8IYcY6xRr7TAzyLbeGNu3Lkmt8Y8ylBx3xdjqR8jlhfJyYBj86pN
         fwXGGGuaoGeaKfAul06qmDAXYwwLraCLy70u+V0yq2icmHQg9NfoJH4q0KQ+XeZqsA3f
         +nGw==
X-Forwarded-Encrypted: i=1; AJvYcCW7/JDE9f6MYky2qvjFDnxXmIOkuu9doz9yM0S6Gcn4nRyOMue9jDefpDg9DdATGIeo9wU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2bmu4ZbFm1QaKe5UkH41hPybjQTyYBgB6BPoIHIVBgnyJZ7E+
	kiw7po7qMBalL02uZE/uG/AzQbeRMArnPJVV79MNMagZCzUNj5ck7wbM
X-Gm-Gg: AY/fxX4tS2i/y6zWlEFUcVp3+5H1NUSUmBLEX/VWs1yxuAvyCsLMjqIlJ40k+iUbsih
	gOnBJqa0sd70API+j+b4MHBAcNhfm0ad7LqBSQnEJwwmAuAwNDJ4kyMo3XPqX+R8p10mm2eHM1L
	awBD0rD7OHEPUv9kVeTcoBea0aDPZWGOh7+gDUkTXKpm/NrDfKt7RbYfHgmIlZVV6ZPWJxOxHLy
	NKEGYT4mxHvH3ZTMxoR0REkUXIPLi7HU/QSFU+vE0z2HG2meiL4j75hES3qsu8Xo34R+cmDqZeA
	zs4MZNzbDt407moakan2ZxYZJcP6A+VQkDtLFPU7sR8TgM23LFa1lPUHVQOo1fuidiFDMOscQpP
	EHkZo940E3J7WUCKfns+YGLh2oW1kBvXYFTbeCqW4FNnSWKkgA7APIjFr+aWsAyjFuRIP198/Cu
	e4IIvBcN+PK1k00ncf6J3H9zARSUVX5Uc+psWharmWHevl1khZPN0=
X-Received: by 2002:a05:6a20:2445:b0:384:f573:42bf with SMTP id adf61e73a8af0-38bed1c96b9mr512725637.53.1768341586883;
        Tue, 13 Jan 2026 13:59:46 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc05cd87asm20802106a12.15.2026.01.13.13.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 13:59:46 -0800 (PST)
Message-ID: <18d9b15319bf8d71a3cd5b08239529505714dc96.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 03/10] bpf: Verifier support for
 KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-input@vger.kernel.org,
 sched-ext@lists.linux.dev
Date: Tue, 13 Jan 2026 13:59:43 -0800
In-Reply-To: <20260109184852.1089786-4-ihor.solodrai@linux.dev>
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
	 <20260109184852.1089786-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-09 at 10:48 -0800, Ihor Solodrai wrote:

[...]

> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3271,6 +3271,38 @@ static struct btf *find_kfunc_desc_btf(struct bpf_=
verifier_env *env, s16 offset)
>  	return btf_vmlinux ?: ERR_PTR(-ENOENT);
>  }
> =20
> +#define KF_IMPL_SUFFIX "_impl"
> +
> +static const struct btf_type *find_kfunc_impl_proto(struct bpf_verifier_=
env *env,
> +						    struct btf *btf,
> +						    const char *func_name)
> +{
> +	char impl_name[KSYM_SYMBOL_LEN];

Oh, as we discussed already, this should use env->tmp_str_buf.

> +	const struct btf_type *func;
> +	s32 impl_id;
> +	int len;
> +
> +	len =3D snprintf(impl_name, sizeof(impl_name), "%s%s", func_name, KF_IM=
PL_SUFFIX);
> +	if (len < 0 || len >=3D sizeof(impl_name)) {
> +		verbose(env, "function name %s%s is too long\n", func_name, KF_IMPL_SU=
FFIX);
> +		return NULL;
> +	}

[...]

