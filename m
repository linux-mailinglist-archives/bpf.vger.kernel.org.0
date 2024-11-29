Return-Path: <bpf+bounces-45893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE969DED40
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 23:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657C4163916
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 22:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C2119D064;
	Fri, 29 Nov 2024 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjUfqVIH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C68D2C18C;
	Fri, 29 Nov 2024 22:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732919724; cv=none; b=TgLhE+KUoB7hnC6vEto0aOGhtwMLuiA4+1ufd9VWzN2YO0Eo5IyBpUeDcHcecdgCRCmo+mnAD0aItxmueekv340MTpY4O8aJaG2MwxGwowUW6CSTSEiympO1R4IrTIEIYuB1ChRjMKGHYgjqW7Yl7HkUngau28ukbTmRJ1FjAu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732919724; c=relaxed/simple;
	bh=mu0DkiZGXnD6C5cAY1jYSN3PsYZgmYhDFG4XbBlxFGk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h6iNfm1FOi2MQKntEPpvmrs/bSfXpyNv6vDreNfaZCb4pLNj6MhNXmsm7p+U3lRVvHheLO1WZeeoUl9pLkZQ3+4ARJDWv4FkhqmH/XepleY2hdHCCJF9mqullsKAEATto5GiRhsMRYUUS8uSnLbBBuWkoUMjg2KSpph0eRvD9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjUfqVIH; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso1173489a12.3;
        Fri, 29 Nov 2024 14:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732919723; x=1733524523; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BgP6DHAJWIOX48v8Lk9orGfycZvbJJM11pIksQ0I9a4=;
        b=gjUfqVIH5kmYB9nZy5n9ZPGTAiRrg3AW4eOFnMll5UgceZYDtnqi4WJVwIcLF1Mf1V
         hpn/lri1FAIcGOtpb7x0jKiXT3Rwz4VC1XWGGd9lT8uI3AcgU3CHSJQDaS7GZrbGo0a0
         jAsfNo2uWk+qZ34B4Dcpurg8RHzDGasPu5qGzjniCixce3UBoHmZUMzxS5jsOWVhXG0e
         JxbeoHXg4PQN7aw+BW4G8e1sKROBbqn/RKw5oxwuIhDjGryl6JsOXPLVyEcdtyuoXfHU
         aA+efonh+dOyC/Apot0CzyuNeF8+ziLX3vvVJWfgUwlXpNdDBU71v1F3mr1wY5ydDFIF
         uFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732919723; x=1733524523;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BgP6DHAJWIOX48v8Lk9orGfycZvbJJM11pIksQ0I9a4=;
        b=hBkiQBKoJHWKO5sqP4dc80voyhy8jNv0O6eSB8SgLADoSEk6YtGdINgwFoNQ6rViXy
         SCqoYxyRScl69xS6ZPAwyaBUq8qQ8tCk59Se4x1ojooXSDngbjCgQ/C2U8KzJ3SYee60
         DGsWHRkF6PqDSSMmGpp1drUbBP3LmdCFeTht7IwkeP497cyM9kPIMtwizUFiFb0k+OIZ
         zqW9MSYjMKY5sWffX/lD4uHzMmTPgcFb9KrI07QbwbTcQaIFIWONTPtjkZWRqtQWEV5S
         DCWRG3M2iq2Unj4Ntvjo7Or78l+wtz3iD+muSojVegiWym7rsT57bQVZm7Fh0+X+os7f
         YZFw==
X-Forwarded-Encrypted: i=1; AJvYcCUw/EiCPyidlMno7qhUZX1zN28dPmvKcKLvjHfGsWJOodj20gW8gf505b7AxytI3BoUNZ76ZWgW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ZQPd7HDvQpebEHhdtGWVa0/a3xYWSf+yaAKNFXrSjcYDN7hI
	0glVotFi9zqYySSj2piRPsaoZUJpMKajNBFYKWJsiVeEQa0ITAAo
X-Gm-Gg: ASbGnct+OMGBjPFsWsPlHRoWVIvEtLKwSFw12MGvBKODE+x1AMx9kAGEP9d4gFJCFkg
	JWk+OxCwZTEXOIpGE6BfhtIm5hz/vfZVystp2B1mkB2LQQ9uQR6zcGaWMp+EPghMHFKygw7SKKr
	g6+5Azbyn506JpXSJ0qf1OVG4sQAXIW4x3qBTvOayMgrkZSOud1PVYcGQCGaaI2BT0p1KCYg7Oi
	E6dMro4B/DNopoJPJXr/Hc36DcRZg1LmwiZY5Z2sCiCDpQ=
X-Google-Smtp-Source: AGHT+IGW9SfmYaZ6cU3gM63T7PJM4tA5nZWSCg+MdJvE7XWEj7cbZuZSFuqvKonJ1bxzmP3tgrtJdQ==
X-Received: by 2002:a05:6a20:6a09:b0:1e0:cb94:d3b4 with SMTP id adf61e73a8af0-1e0e0beb9b1mr22494596637.45.1732919722744;
        Fri, 29 Nov 2024 14:35:22 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541770786sm3994712b3a.79.2024.11.29.14.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 14:35:22 -0800 (PST)
Message-ID: <3a012e7797907f466ce56a103e5b1d96ae564428.camel@gmail.com>
Subject: Re: [RFC PATCH 7/9] btf_encoder: switch to shared elf_functions
 table
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org, 
	acme@kernel.org
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com, andrii@kernel.org, 
	mykolal@fb.com
Date: Fri, 29 Nov 2024 14:35:17 -0800
In-Reply-To: <20241128012341.4081072-8-ihor.solodrai@pm.me>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
	 <20241128012341.4081072-8-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-28 at 01:24 +0000, Ihor Solodrai wrote:
> Do not collect functions from ELF for each new btf_encoder, and
> instead set a pointer to a shared elf_functions table, built
> beforehand by btf_encoder__pre_cus__load_module().
>=20
> Do not call btf_encoder__add_saved_funcs() on every
> btf_encoder__add_encoder(). Instead, for non-reproducible
> multi-threaded case do that in pahole_threads_collect(), and for
> single-threaded or reproducible_build do that right before
> btf_encoder__encode().
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/pahole.c b/pahole.c
> index 1f8cf4b..b5aea56 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -3185,12 +3185,16 @@ static int pahole_threads_collect(struct conf_loa=
d *conf, int nr_threads, void *
>  	if (error)
>  		goto out;
> =20
> +	err =3D btf_encoder__add_saved_funcs(btf_encoder);
> +	if (err < 0)
> +		goto out;
> +
>  	for (i =3D 0; i < nr_threads; i++) {
>  		/*
>  		 * Merge content of the btf instances of worker threads to the btf
>  		 * instance of the primary btf_encoder.
>                  */
> -		if (!threads[i]->btf)
> +		if (!threads[i]->encoder || !threads[i]->btf)
>  			continue;

When can 'threads[i]->encoder' be NULL? In case if worker thread exits with=
 error?

>  		err =3D btf_encoder__add_encoder(btf_encoder, threads[i]->encoder);
>  		if (err < 0)

[...]


