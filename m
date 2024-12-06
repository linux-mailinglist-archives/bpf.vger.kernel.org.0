Return-Path: <bpf+bounces-46190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6230A9E618D
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 01:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E89B18854E6
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 00:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455181D47BB;
	Fri,  6 Dec 2024 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKLOtALS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B4014A90
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443230; cv=none; b=uyowzjlytQffui4/txvKfDdfHPegrvhaewQA2QDrC2iqFFKMYrbpO/zDbrbvpRV9FguD1V7fTq65tsl8Z+jYq1kneAChWLNzcNZaqmf3XSv3VFwK4H8cKqcfj4/noqNA7KlOY/AR5UnGhVEwWVLIXB6uHy9IdMCFH6+2XKsg6LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443230; c=relaxed/simple;
	bh=cda4LLhEvgW5Gtj1nPaLeOb5Euzc6/casN2LA6lEIkQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cEJyOKycrhTdOrrv4tEL8swU/HKgokc8TvRZf03VwLfSUuKbmtW+JOhfTLhoBGDvmoPVpvtqVaou8gOlxVBlvbxxIcsON2Lue7H5lXN+gJNA3QlkAGq+GNnza7kwH8rMXk6qBs2lpDE5XoIZTLeyWHaJi8U4vLpJtLtlTVE+390=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKLOtALS; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-724d57a9f7cso1402109b3a.3
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 16:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733443228; x=1734048028; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QvMWhpTob/pqLNSYccfrCn0naZtr5iEP0XUIaULDaos=;
        b=hKLOtALSLF2z91vQSgRy7189Fg1sNk4/BSPVB9q638B6MRchFyLQv1LeA93Bow06KN
         swepvh2wF0xu4iD5xMjUaRld/49pnIopZ0x/EKtM2xGRGGUbQT9wmpwVzA987yX9jnsh
         HVGkzZ8A9nkq43j5wLA/H7y7tPNlwko/OF6eWG1QC4eJe8sjGXoHWS4NZVh2dD7QXMuT
         clTN+DT+XfYDZHE8brz72AbnlUM020WnJ+M9FedBv6687v6fb9trg8h6Vz/MrTSUqCRO
         dkhGUKefDVrJQpB3xSc3HsZcMOom5DDwTzvjbL7q9ztl7Z1QwtRyUM9oTNVNxeH8ZUM3
         DaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443228; x=1734048028;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QvMWhpTob/pqLNSYccfrCn0naZtr5iEP0XUIaULDaos=;
        b=wl3SCpp+owjh8zRKgUN5QJMsElh066vOunqAm12HRkKhQboXEphc7SmidJKznQyejT
         pN1lIEq/AADtcnv4f4ooHEpMAoPUkyHsu3gxWkn6WmfGB4QLoaQEmK0BNt8BN23ciMws
         Qgr6pilor7m5itDansKSvy0aUACogCLYqz4CoG8fLJJlHe36TbVabxCJh2wdorbveKKZ
         O2If3FFfJExXVIdMy43/Zi8PbjWglYI/tOFeZ3Q/r5xfRB7jr2xG/7PIj5kt0iNBLj7B
         LU9AMvXeFmoc+BV9Bdc43P8nmIIIJr+XyyjgDFuKDYGCg/bFeDR/5+MGV+hADsKtoKZP
         90AA==
X-Forwarded-Encrypted: i=1; AJvYcCWX622S7MCoMFwusAYE1P+0GiBMEE5OoF81a9v1RLbZBEjvdsbIDbykTPaeDxOEGqJV4YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLrwflvX8wnXbXRWKCFRYSpMbEgkC86+kjqB1QAZSVYh6HH22Z
	NthJN3+w6wirXAvtC4ID7hvSAHpMq8Eegt6g4ZOtfGeSf9VZilOV
X-Gm-Gg: ASbGncvC9Bsn0BAjsv07RusdO5phLinZuna9E9j4kwBTIM2mJM3bCLKRbXwSj/RTz4x
	sJp3zEzmQagHm4Smrj64EvnRXeNW2YQUiIsXgu1h7X3hSmx7jnMUsJw1DUbSDUHBvG7zn+XHWCw
	dTHHzUt2OfcLgodSsE0NXZp/+NwPlI+/f9xecHfp3loYXxHIAuq9xR89lpwmErBixuhIL+47PWN
	QAJCee4RqtAJd9MwlkCCIZvqHRRBcCSpaVFeMFdLQH0PSA=
X-Google-Smtp-Source: AGHT+IHOGu2fSZPd2VJ+rFikjpJYT9RMfDsb9nIxudWiBQ+w2/yBPJZFYT5qaUWiTCtr7KIjgnhP2A==
X-Received: by 2002:a05:6a00:b46:b0:71e:1722:d019 with SMTP id d2e1a72fcca58-725b81f81a2mr1691024b3a.22.1733443226976;
        Thu, 05 Dec 2024 16:00:26 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29ebdacsm1822019b3a.74.2024.12.05.16.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 16:00:26 -0800 (PST)
Message-ID: <e991f994d9e24b146526b57ae038d7abd5fa1239.camel@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Suppress warning for non-zero off
 raw_tp arg NULL check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Manu Bretelle <chantra@meta.com>, Alexei Starovoitov
	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
	 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	kernel-team@fb.com
Date: Thu, 05 Dec 2024 16:00:21 -0800
In-Reply-To: <20241205223152.2434683-2-memxor@gmail.com>
References: <20241205223152.2434683-1-memxor@gmail.com>
	 <20241205223152.2434683-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-05 at 14:31 -0800, Kumar Kartikeya Dwivedi wrote:

[...]

> Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
> Reported-by: Manu Bretelle <chantra@meta.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

I think this should work.
Although, I'm not sure if we should delay generic fix and do this in two st=
eps.

>  kernel/bpf/verifier.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2fd35465d650..dea92cac2522 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15340,7 +15340,8 @@ static int reg_set_min_max(struct bpf_verifier_en=
v *env,
>  	return err;
>  }
> =20
> -static void mark_ptr_or_null_reg(struct bpf_func_state *state,
> +static void mark_ptr_or_null_reg(struct bpf_verifier_env *env,
> +				 struct bpf_func_state *state,
>  				 struct bpf_reg_state *reg, u32 id,
>  				 bool is_null)
>  {
> @@ -15357,8 +15358,8 @@ static void mark_ptr_or_null_reg(struct bpf_func_=
state *state,
>  		 */
>  		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_co=
nst(reg->var_off, 0)))
>  			return;
> -		if (!(type_is_ptr_alloc_obj(reg->type) || type_is_non_owning_ref(reg->=
type)) &&
> -		    WARN_ON_ONCE(reg->off))
> +		if (!(type_is_ptr_alloc_obj(reg->type) || type_is_non_owning_ref(reg->=
type) ||
> +		    mask_raw_tp_reg_cond(env, reg)) && WARN_ON_ONCE(reg->off))

Nit: the condition is a bit hard to read, maybe rewrite it as follows:

		if (!type_is_ptr_alloc_obj(reg->type) &&
		    !type_is_non_owning_ref(reg->type) &&
		    !mask_raw_tp_reg_cond(env, reg) &&
		    WARN_ON_ONCE(reg->off))
			return;

     ?

>  			return;
> =20
>  		if (is_null) {

[...]


