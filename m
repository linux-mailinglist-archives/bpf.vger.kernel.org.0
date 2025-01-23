Return-Path: <bpf+bounces-49560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C174AA19D02
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 03:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1512B16128C
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 02:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E06B22F19;
	Thu, 23 Jan 2025 02:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWTD8/FH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32803320B
	for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737600327; cv=none; b=uc3d4kmlv2gZdJUv23WyZNTyROWnMWwNWDvNVZre8inz1RBtv4/MYlee7Z7j1Bypq4znR4vW03df7i8pBk+AJ9INdMCB664lN+cUtA8y/clz6oOZ8c9eRXqryjd4WfrIoAXGizE6G3xoUg/SMPTFVDl4hLqF4jNSnoj5qXjPa9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737600327; c=relaxed/simple;
	bh=d4fU6RgVIJRQE8xPXhIVKnMFpFSFamSjPrnOtjx5OTk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GRrVlAADVZY/pLucLU9ynheevvAFO3tc92NkiuJqkJjOvbHMVXEiwYpmFzK+Fz+Rij0w5ieF+xSsOvX+AFWluhuzeccksuXmzOwiuO0cp6sMVHv4+Ok0HyPb2BkNaGsPvTaizjSwBeqsrrBKOikjE7lzI95gJ7rlnWO98Sro/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWTD8/FH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21649a7bcdcso6232415ad.1
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 18:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737600325; x=1738205125; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Al9twcMSN03A/RPPLqgbcRq1uLfuAR3eswmhKNcpFd4=;
        b=JWTD8/FH2pM/74Sz7NlxxqmKuYftg9TPKNOo4RiktZssT63XUZdYXZBEkA4ePIADdc
         lsYvmtKfoDww0rfQDkSZwHurU8AEqnEllRoJpD8fAGEBOCG764CfODpzpk7ZrT/6EyVg
         MaAzpuSIngq7KnW/tcoh9Vf0uR9ymkY+uJiqr6zJ8YOnVfcyvteN8Vcnns9oK7TYaTB4
         Td+0O32opk2doRR7/nE5OeY8D95v01QVSYYeQSc3D13GZOOjeLtPXzXwvxuCo2RLIuwM
         FASr/8DPrpmik65iqWuf+ziFk87vOpVobO1X6geS0vljbQmOiYKRHjT+KJnxBthj6lfM
         ertA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737600325; x=1738205125;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Al9twcMSN03A/RPPLqgbcRq1uLfuAR3eswmhKNcpFd4=;
        b=vaMMlqhc+r5SkWoUX4Ik+tRbnJJ6iBdkWclOg0t6YKrhCE9ri2LYn30OM2yDDY4m8Z
         kvgEwx8nzkDkScCVLjB3biS1AwMNnQKXXleWkIA0qlUsIvKLMpqsGcDmWWiNqBtfj8dJ
         KCKOi1gyHfUiWDCQL9eHHvW3nN0Yb2K5XFm76Lf32rg18NsktAyCCH8+NDX7LIW/k6ut
         3p1g9EB1Jb9xkjXON0d8xKXSuMGd+XuVFGme1qaEpz6vErdyRZeSyAqe0X/Uhen5dkG7
         2Jsc2zqnzPcMf8TOUgY4W2EdbqqD9osc1pJjo0+2A0rRKyIHGpCc6E5cPKc89EjBgCpa
         dQwA==
X-Forwarded-Encrypted: i=1; AJvYcCU3pZOSD2xDwrFxO4ZsVvnFYuhiuwVRNOjxbRa1N8G6OugS+PzNpyaMabag8U8DKTBJgEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyheo43MULN3a+CzA9XwFMspQRJw0z2ev/7un48CWWnb1C0mtZA
	2NqIbqctanklVOt8jMka9wpe+Uq4HFRdcDVCh2Kd45PSQis62du1
X-Gm-Gg: ASbGncvHKRPFQ2AuUkjgKoTdlWCC7UihMHKkO8opWOvtBu3HVAZKWvaiLFhb4TbvqQD
	j6+SVGvztsD0nismwhXekKtgWj7WwDObPqr6X8O+syPSSFHsk3Es8m5XA3Qe1ab/ggJ/RyH96gE
	7zAajQtIpOpUaibLf299o0bovGg5qtiO8S0B+jmtoG/1lRmSpp8mxe9vOx8gII+F6R0axxN1d/3
	jdeqAPV0epX4SjVVwNwscy9e2GZx8dzZCNIOq7o4essKI43oH7lw86InD/ri3miIz2xjUDZyTdb
	0Q==
X-Google-Smtp-Source: AGHT+IFBhxPLtE/XFOO1K+BJKFX3XroeJ9mJEQpwHRrlVL5TWQN5grOfN8k3oSYGqcLuzDp2XmcFzA==
X-Received: by 2002:a17:903:186:b0:216:1ad4:d8fd with SMTP id d9443c01a7336-21c352de48cmr302367145ad.8.1737600325278;
        Wed, 22 Jan 2025 18:45:25 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3a8543sm101995285ad.124.2025.01.22.18.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 18:45:24 -0800 (PST)
Message-ID: <28b232406e80922c882bacb553e160b3f5ffb32a.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: add a btf_dump test for
 type_tags
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com,
 	jose.marchesi@oracle.com
Date: Wed, 22 Jan 2025 18:45:19 -0800
In-Reply-To: <20250122025308.2717553-4-ihor.solodrai@pm.me>
References: <20250122025308.2717553-1-ihor.solodrai@pm.me>
	 <20250122025308.2717553-4-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-22 at 02:53 +0000, Ihor Solodrai wrote:
> Factor out common routines handling custom BTF from
> test_btf_dump_incremental. Then use them in the
> test_btf_dump_type_tags.
>=20
> test_btf_dump_type_tags verifies that a type tag is dumped correctly
> with respect to its kflag.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  .../selftests/bpf/prog_tests/btf_dump.c       | 148 +++++++++++++-----
>  1 file changed, 111 insertions(+), 37 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/te=
sting/selftests/bpf/prog_tests/btf_dump.c
> index b293b8501fd6..690cf8cef7d2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> @@ -126,26 +126,70 @@ static int test_btf_dump_case(int n, struct btf_dum=
p_test_case *t)
>  	return err;
>  }
> =20
> -static char *dump_buf;
> -static size_t dump_buf_sz;
> -static FILE *dump_buf_file;
> +struct btf_dump__custom_btf_test {

Nit: since there would be a v2, I'd give this thing a shorter name,
     e.g. test_ctx.

> +	struct btf *btf;
> +	struct btf_dump *d;
> +	char *dump_buf;
> +	size_t dump_buf_sz;
> +	FILE *dump_buf_file;
> +};

[...]

> +static void test_btf_dump_incremental(void)
> +{
> +	struct btf_dump__custom_btf_test t;

Nit: this should be 'struct btf_dump__custom_btf_test t =3D {};'
     otherwise btf_dump__custom_btf_test__init() would read
     garbage in the error cases.

> +	struct btf *btf;
> +	int id, err;
> +
> +	if (btf_dump__custom_btf_test__init(&t))
> +		return;
> +
> +	btf =3D t.btf;
> +
>  	/* First, generate BTF corresponding to the following C code:
>  	 *
>  	 * enum x;

[...]


