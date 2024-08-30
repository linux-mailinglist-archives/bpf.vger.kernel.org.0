Return-Path: <bpf+bounces-38512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C16496550E
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 04:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF90CB2392C
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 02:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F8613D60E;
	Fri, 30 Aug 2024 02:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmKHox9V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3167A27473;
	Fri, 30 Aug 2024 02:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983449; cv=none; b=aKIbjvKEphXJIJqUKagDgoJq4DmavfW43GudlpewSYaFarUvVuDGpBnZldYIAz6+8SG4pPVQVnK7dIOnk8S5giXgKE0xk+CSTjC0FwCuQpON3cP4d10L8yavoE8eLV7GTT+j4mcPMismcTWchY7ztCOibCUZs08wQ5W1vTJLw+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983449; c=relaxed/simple;
	bh=Y3hMusF4liDwrYLRnZukIfN3F7nT4dN+Q5Rop8q4Vlk=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=hvXUox+Rhu969SnMm0lZP2I1fdZ+h81bYDY9BkSbui58ksogJawfoP2voSHyr3D++BFP8x6pSCiESV2UO3gJDlVS2RLaaJLqnovnfBkve6n7GijJytxWiwlMD0DW1lWZyly65d9fzxgOgM3qE5nDR7Rw+dIlIgGGaXSwaMqd8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmKHox9V; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-716609a0e2bso291303b3a.0;
        Thu, 29 Aug 2024 19:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724983447; x=1725588247; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3u7MEHbTS5aIEdhqu3cNoa9W9oSTziOnMc5kpFlW668=;
        b=PmKHox9V3B/cIDbEvv9ZlXDdY56KyNFgwuMzECbRQNqGQ2sFJyQs3kpfi2+Gi+8WG4
         Y36HOHWHkqEbUI3ArLWBn5FZQqopGAGejg220seKrrknG7pVjZ+Xm/wJxXQp6pP+joiV
         YMcK/2kT9SYJqjsaYhR+PDkg0n28ugJAnizvLUR1StugmT7SVvtWD9RoRNrmUOVHO4ju
         CE3dEqc4FvpYHMLVw/MlgQ8QXcxzoNBOmh3VVbqe+kqg90Ed/KmV4ZdhLEvOiXs/NFO7
         yKleqotlkAWoLmCePzx8tvysfLUtKlJF3p4QzLEZBJXEUQhIHP99ETF5Xe3mdsQc+a5n
         6ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983447; x=1725588247;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3u7MEHbTS5aIEdhqu3cNoa9W9oSTziOnMc5kpFlW668=;
        b=O8Vk3n20nTH2S/Q6MY8LaVKW84t16Ya9zMIuKNANjaYQRIn51viInqfPwE9wHMIEmF
         ak04kpkJRi61QBF7ieNNgB46S/b7HOpmmRkHCCnDdGlabmbx4xIVllNFxFIyCLkOHDLd
         /h2b1X0Bq0ZHOVvMvV3m+iHXyWGSaLP1ZF+0ZAEeKaqKT4g9gXvO0HxCTrhvhMpOPANl
         kiq67bAVQrN+OlxR7RlyaK8r0yLT7H0XgJoSTT5ow+FeKKlDgK6l9RLxTx8H+8tvjLRK
         BFOBmey2LJsFCZnAfIeSSE9CG9yg8Osgz6h4FU9So6RgGYjUL8a/J0rNMhYx6SwlNMN7
         Iv4A==
X-Forwarded-Encrypted: i=1; AJvYcCUDKh93e9rE9KX3PeRkSELJjFXvFJwVdNkkPftObct26LQDr7iVlP7sGSg+bisxuqG+hWQ=@vger.kernel.org, AJvYcCVbb1f7jWZB6GEbXhl9OZaeFHJ3RjNp9txDIEJPTCVef8LJzxEB3vpW3nd4QSORRLTUGj43is1ej9hqlviD@vger.kernel.org
X-Gm-Message-State: AOJu0YwHwCR7qxVwDn4xbXNUwuWqVyM7wxdCMJ9oyuFM8emNtXGp0X2R
	7Q+MZt1elcFkR4wyjL8ietOer7/4jQY2v0pNwidOZX5g43PfTsuO
X-Google-Smtp-Source: AGHT+IGHl7cemBtoX5qsT9N4v16xPV1yX2TOLZXitRI1QU88g9SCvxMpqVFWtfp3UkXmgk0SXrsj6Q==
X-Received: by 2002:a05:6a20:2d24:b0:1c4:818c:2986 with SMTP id adf61e73a8af0-1cce100e21emr4887015637.13.1724983447328;
        Thu, 29 Aug 2024 19:04:07 -0700 (PDT)
Received: from smtpclient.apple ([2001:e60:a014:2acf:bd3a:95a:cb6b:9c04])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515550badsm17508025ad.241.2024.08.29.19.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 19:04:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Jeongjun Park <aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH bpf] bpf: add check for invalid name in btf_name_valid_section()
Date: Fri, 30 Aug 2024 11:03:54 +0900
Message-Id: <07EBE3E5-61A7-4F64-92BA-24A1DCA9583B@gmail.com>
References: <3a48e38f29cc8c73e36a6d3339b9303571d522a8.camel@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 song@kernel.org, yonghong.song@linux.dev
In-Reply-To: <3a48e38f29cc8c73e36a6d3339b9303571d522a8.camel@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
X-Mailer: iPhone Mail (21F90)



> Eduard Zingerman wrote:
>=20
> =EF=BB=BFOn Wed, 2024-08-28 at 22:45 -0700, Eduard Zingerman wrote:
>=20
> [...]
>=20
>> I will prepare a test case.
>> Probably tomorrow.
>=20
> Please find test in the attachment. This test triggers KASAN error
> report as in another attachment. (I enabled CONFIG_KASAN using
> menuconfig on top of regular selftest config).
>=20

Thank you for writing the selftest for me.

> On Fri, Aug 23, 2024 at 3:43=E2=80=AFAM Jeongjun Park <aha310510@gmail.com=
> wrote:
>=20
> [...]
>=20
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 520f49f422fe..5c24ea1a65a4 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -823,6 +823,9 @@ static bool btf_name_valid_section(const struct btf *=
btf, u32 offset)
>>        const char *src =3D btf_str_by_offset(btf, offset);
>>        const char *src_limit;
>>=20
>> +       if (!*src)
>> +               return false;
>> +
>=20
> I think that correct fix would be as follows:
>=20
> ---
>=20
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index edad152cee8e..d583d76fcace 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -820,7 +820,6 @@ static bool btf_name_valid_section(const struct btf *b=
tf, u32 offset)
>=20
>        /* set a limit on identifier length */
>        src_limit =3D src + KSYM_NAME_LEN;
> -       src++;
>        while (*src && src < src_limit) {
>                if (!isprint(*src))
>                        return false;

However, this patch is logically flawed.=20
It will return true for invalid names with=20
length 1 and src[0] being NULL. So I think=20
it's better to stick with the original patch.

>=20
> <bad-name-test.patch>
> <bad-name-kasan-report.txt>

