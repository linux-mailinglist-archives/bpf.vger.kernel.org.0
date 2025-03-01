Return-Path: <bpf+bounces-52962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFB4A4A9A4
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 09:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EDD1754BA
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 08:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7011C460A;
	Sat,  1 Mar 2025 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJuryqgM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E38915624D
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 08:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740816778; cv=none; b=SpFTaoymkJ+aChdlrSeCKryyvOcDKKQCGPw3LR6SrOZi6YsYZP1qsQDnN9Jw9KtGf0erDw5tfS18pww/pNcn3PO7ApG8oRNqyTI8k+cpjlgd8E9ZfiOGDGf9wKfDpIDFUlEBER5NrFOsKHEP83ywpngfJDG+BC8GZis752ZLAEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740816778; c=relaxed/simple;
	bh=u2g1U/IBPz5kKXeBXOnsYn4nqQsVhaN+lpjc3AGjnww=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UVCujsYiIJ6I5V+HWPLu7nWYubqEgQh/kCbs5lkXntE3ci8pj/73aJdnxOh/XYkuvgDb3dhAyE3TP3VLmK0dyDoSTui94+FAZUPQpfbaDT9jm/jGDpW4BKCcIEywFPEtWWQenld4xNI0dcQm8iF5l58UdsMyYLXRj3+tnqc9l2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJuryqgM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22356471820so46617005ad.0
        for <bpf@vger.kernel.org>; Sat, 01 Mar 2025 00:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740816776; x=1741421576; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y0l0cOK+O7ZxDorXFTK7IGs2XMx/CYdNbb0uwKia/G0=;
        b=cJuryqgMLv2XLWRhdfRVQ7QSCNwsW12FQhIR8jlcYptSuLvNwfbBt5bLpK0Lh6Si8w
         2FbrbFeHs/JZjmIB9SSSKsiGCUfdIhb7E2+1WTra1EZrrmU3FhZyXxUasiA2DhIZU3PS
         /7jqajwibC0XFMe6f81qFr5beEHz45NV6LrncIGhA8U4VWylBnSjoimZX0xBEOfrdg8J
         9JV0S36bous11tvMiduGD1SNL6Al8rRMOZAEZQYOv64eSrdZd7qWUmoEMSuvRH7qlvOt
         77qS0G94AT3ECgtG03cgSimVksBHJTFmD1vv8pPDcL+hYKWpV+1cH8SSDDWNJz870H2r
         YTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740816776; x=1741421576;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y0l0cOK+O7ZxDorXFTK7IGs2XMx/CYdNbb0uwKia/G0=;
        b=OTVGfnZjaqZNmuzlXMRQpT+QNge68dbB9QcqmzESLMVKZiRPo42Uny735c2B9bNIvj
         N5Vb5e+P+9XQw+mLCcCcde4QE+Mp1L6NJKEmaiTg9QXH66836HYQ7tb48k23xDnlJXJr
         bQ/UCIAlyl0Il/KhsjJd3J3u5bmBtaK23+uANjplkU66xtnFMj0sZCWx8pT1FO45Ry3b
         YxGAescK6Z9nAQpSvdB2teuULqXaZ24XwzeNRQZlR8aXYLDdjlQ0uIg1a9arv1T4/jJr
         G3vI8i1gxwXKx1eSlUE/uxI/MRUY6u9AEBgQWA9fiAnfMSQ/XQh7RbXmGOFKjnxhKGkI
         hskw==
X-Forwarded-Encrypted: i=1; AJvYcCU8sa7NAzzSopWi3U7YvZmuC6tIHdAk0uD7UtsR3FIeWlKXQiqi9krXc49zfphzfQzG+8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdeyTgxz/7Byt+Xt0qgGs5amUAuDNfkB6oNLgJiNjlsKKuIWUF
	S6Vr1S1gufaVTObVVN0TuzPq8+b7ivQTv/JvksZ36JjTC1jkfcn1
X-Gm-Gg: ASbGnctbBeX4rezP9UUEoGyknnT0tBr6AUN29Z1Lg4ukncvmjmyS7Ztf6FisXAEkQyt
	CkQ3nee6by1Cy9SC1LIlW4u5NBMOst4spas6fyc678qT7GRk8g7ohsTRQ0O75IrCr1S8cNcw/oU
	MRPvVaICZRGASvvaYtTjRA5bHD9V+FNY50vk9LOHvTFn0jYTU6IgyXf0JJvWhjtFmTG5j4cjgcZ
	Sle3vUUR6a79oFbY0g+4bUe+Hue2gsGcfPefqIUeGmXkasKZT6Dz/uyYCjkgVE7VZFYKj+lAy4c
	lAW0YNN6xbKZ0zHYT9HIt+aAJJKTBIs2sY/sr2HIug==
X-Google-Smtp-Source: AGHT+IGUpfZYJW4OhtFBRzFffhi+YF+siQYR2qIkase2piEPWSYpAIEcfRD4EOOyiV/BrL+3mhdocw==
X-Received: by 2002:a05:6a20:1590:b0:1ee:ba5d:3d55 with SMTP id adf61e73a8af0-1f2f4e01cf8mr11598080637.38.1740816776581;
        Sat, 01 Mar 2025 00:12:56 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73632105ae9sm1253285b3a.61.2025.03.01.00.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 00:12:56 -0800 (PST)
Message-ID: <5d7fb7202625b999cb77a1e010ba6f7099dbb561.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] libbpf: split bpf object load into
 prepare/load
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Sat, 01 Mar 2025 00:12:52 -0800
In-Reply-To: <20250228175255.254009-3-mykyta.yatsenko5@gmail.com>
References: <20250228175255.254009-1-mykyta.yatsenko5@gmail.com>
	 <20250228175255.254009-3-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-28 at 17:52 +0000, Mykyta Yatsenko wrote:

[...]

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 9ced1ce2334c..dd2f64903c3b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4858,7 +4858,7 @@ bool bpf_map__autocreate(const struct bpf_map *map)
> =20
>  int bpf_map__set_autocreate(struct bpf_map *map, bool autocreate)
>  {
> -	if (map->obj->state >=3D OBJ_LOADED)
> +	if (map->obj->state >=3D OBJ_PREPARED)
>  		return libbpf_err(-EBUSY);

I looked through logic in patches #1 and #2 and changes look correct.
Running tests under valgrind does not show issues with this feature.
The only ask from my side is to consider doing =3D=3D/!=3D comparisons in
cases like above. E.g. it seems that `map->obj->state !=3D OBJ_OPENED`
is a bit simpler to understand when reading condition above.
Or maybe that's just me.

>  	map->autocreate =3D autocreate;

[...]


