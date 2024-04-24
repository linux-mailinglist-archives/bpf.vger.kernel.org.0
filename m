Return-Path: <bpf+bounces-27765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E821A8B171F
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 01:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254B11C21096
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 23:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F99416F0EF;
	Wed, 24 Apr 2024 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNGdYPC3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C4E157467;
	Wed, 24 Apr 2024 23:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714001611; cv=none; b=amDzGLBGjSWTXOsFNA5E1K69IBTwzKDnsgF6LlhhffKnp9VyVGElwQ9p44OgOoTkVfXyICjCuydYVtYFQ0TXRIcHj/n2btLHJ0EHoJDCdvmgV8lMbfhscQB7hha9zznIkd3kT73y54WQMQUTJBHlg0TNlUOKUKoXzSc+qV26gvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714001611; c=relaxed/simple;
	bh=e+aCLPbcPlDLfPUYayoRXVY0kNFxuHQq2VVN1J3ih7s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A1u1vOo4K842vbIzZDJhbiXrOJbbccpxhxIaXUpv6/aGeHWw7TQKYv9rnd94otfXYcAsmSGHAxfOW85DVyTdc79jhZWHKCohpRXf+5iUNBe2BIWOII0Sy8NP5gPJ0D+PzF00ZmzsHYi+uXuYcbnKrig8WyWmYEIk57jzXlUuC2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNGdYPC3; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d3907ff128so339048a12.3;
        Wed, 24 Apr 2024 16:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714001609; x=1714606409; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I7NiIAhTpcmiU3yqLyIwWWgKXM9g6jW61ojyM0IUSi8=;
        b=JNGdYPC3agpFzIkryeOalQSBAvTUfCTDlfX6kl3MuVWGMrf8DijfCOS+x8GqqNqB9/
         ymsP5amsEZmdSe3tAytXg95FZWZVsgZFzm0UsGJRZRw7Xkxp5yv+LDq+ydWu/uv7jmE1
         D02/hF5mTuC5ZNZZqQzbqe4rYB0fVstlYp8x7vYa7wGYWKbqMvBYRWgktz6dA7dJg/Wa
         MllhkZe4zqrnQYRYDR9B1YY1LW1wUdY1pfrPHVG4rljZTFD/AqqRGz+f3yF+bNHWdtFg
         cLuyfuMu6KM02S2CgNQ1bw+7apl8BsO+2+/TIKwBUamjCMFGB1fq4kDsZ4TcqnDYeflK
         yUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714001609; x=1714606409;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7NiIAhTpcmiU3yqLyIwWWgKXM9g6jW61ojyM0IUSi8=;
        b=LpmUWR7lAf/0+C9xoHA3bHYZ5LkPYfqbqmHkMr9D/LDtTcNVjIAXp00h/O/Mu9MhKQ
         OvB+YfySQSPvKfgBA61DG+/fzsB8miLBlZ8isNC5K4Q803P2sb0g6lWrQJyY+x9j7yUU
         sPMTW8Jc4CVxkM7j8k0ZuPOq3WCdg15xDbeQoMJhva99JMA2XBNkbBcYGxwEh+s1p9Qb
         c5BlSF6GzXsyjP/p78MhkxjdmkDQEt+2vhSN64/+/f5FdrFNaJl3+A+0+avweXt5hLwZ
         0gNnDpvBvvOd+yoz5QKcuEhFv2fHMD2TYN5of8zv+7S72b7HHgFJqVgswKpW1TFSfuiZ
         T98g==
X-Forwarded-Encrypted: i=1; AJvYcCVruZMa1NuIfo8CW2L55rXHHU8o8PV2QWQODM/LHIk+hE7VZnNajyKCU6Un8vfJaWRktsc4/rBihKQTSxdMgpWx9BIvbli/4RoN97ov0O+p2eK4LNYYXKpHHSLcJ+cNWc0b
X-Gm-Message-State: AOJu0Yym9RrvZmh18Gpw5Yn7pMwjHrhB0oxx4jQTHxe0CwG+b9Q5B5AC
	TtaAqzTGQfp7Oc6Yyoh7BcleuR+Jg1LNSQKJHn0iTLKKRFxZk+nx
X-Google-Smtp-Source: AGHT+IEra6fKeChfPGHN7McwVRueAMrqdfxDMjJdTUOkg6c/GSxPPScmZ9DnEVL9dPZEVMDxSAI+xw==
X-Received: by 2002:a05:6a20:244d:b0:1a9:11e4:72b6 with SMTP id t13-20020a056a20244d00b001a911e472b6mr5307015pzc.57.1714001608824;
        Wed, 24 Apr 2024 16:33:28 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:4d59:11ad:4924:e022? ([2604:3d08:9880:5900:4d59:11ad:4924:e022])
        by smtp.gmail.com with ESMTPSA id u26-20020aa7839a000000b006e53cc789c3sm12028230pfm.107.2024.04.24.16.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:33:28 -0700 (PDT)
Message-ID: <b49224dbc89bd304a5c20eef4430dfea40f4b6a5.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next] libbpf: print character arrays as strings
 if possible
From: Eduard Zingerman <eddyz87@gmail.com>
To: Quentin Deslandes <qde@naccy.de>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 linux-kernel@vger.kernel.org,  kernel-team@meta.com
Date: Wed, 24 Apr 2024 16:33:27 -0700
In-Reply-To: <20240413213904.146261-1-qde@naccy.de>
References: <20240413213904.146261-1-qde@naccy.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-13 at 23:39 +0200, Quentin Deslandes wrote:
> Introduce the new print_strings flag in btf_dump_type_data_opts. If
> enabled, libbpf will print character arrays as strings if they meet the
> following conditions:
> - Contains a nul-termination character ('\0')
> - Contains only printable characters before the nul-termination character
>=20
> If print_strings is set to false (default value), the existing
> behavior remains unchanged.
>=20
> With print_strings=3Dfalse:
> .str_array =3D (__u8[14])[
>     'H',
>     'e',
>     'l',
>     'l',
>     'o',
> ],
>=20
> With print_strings=3Dtrue:
> .str_array =3D (__u8[14])"Hello",
>=20
> Signed-off-by: Quentin Deslandes <qde@naccy.de>
> ---

Hi Quentin,

Thank you for this patch, sorry for the delay reviewing it.
Could you please also add a few tests in
tools/testing/selftests/bpf/prog_tests/btf_dump.c ?

[...]

> @@ -2021,6 +2022,21 @@ static int btf_dump_var_data(struct btf_dump *d,
>  	return btf_dump_dump_type_data(d, NULL, t, type_id, data, 0, 0);
>  }
>=20
> +static bool btf_dump_isprint_str(const char *data, unsigned int len)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < len; ++i) {
> +		if (data[i] =3D=3D '\0')
> +			return true;
> +
> +		if (!isprint(data[i]))
> +			return false;

Would it make sense to use isprint_l() and specify something like C locale?=
=20

> +	}
> +
> +	return false;
> +}
> +
>  static int btf_dump_array_data(struct btf_dump *d,
>  			       const struct btf_type *t,
>  			       __u32 id,
> @@ -2047,8 +2063,14 @@ static int btf_dump_array_data(struct btf_dump *d,
>  		 * char arrays, so if size is 1 and element is
>  		 * printable as a char, we'll do that.
>  		 */
> -		if (elem_size =3D=3D 1)
> +		if (elem_size =3D=3D 1) {
>  			d->typed_dump->is_array_char =3D true;
> +			if (d->typed_dump->print_strings &&
> +					btf_dump_isprint_str(data, array->nelems)) {
> +				btf_dump_type_values(d, "\"%s\"", data);

Note: this would have to deal with escape sequences,
otherwise strings containing '\' would be printed incorrectly.

> +				return 0;
> +			}
> +		}
>  	}
>=20
>  	/* note that we increment depth before calling btf_dump_print() below;

[...]

