Return-Path: <bpf+bounces-47079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 413C59F4070
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 03:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9100161D49
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 02:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0636130A73;
	Tue, 17 Dec 2024 02:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7nwUv3u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8502595;
	Tue, 17 Dec 2024 02:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734401681; cv=none; b=nwVSNLMxOZaVPB53JmO7Dv6yY/6vTCyrFYn/B+O/h2HghxuS9hsrXJPJCn1Veox2k+XY8OytIuI2FCmdn4tIjsNjOa6VMNC7m7HmLwLtUejKL+Nu1ewbjdPmDn6xKa1SqNgHzdmQifi0zMhHyIODn17D4W3tMblF1lAcwTYa8dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734401681; c=relaxed/simple;
	bh=Bx3hpwAqno+JYEe4iIHUbG4o0aqmqPVDfqrI+j7vexg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J0uwYOotI/BXLVsg/1Mk1UmEGXyH3OS/xpksCmPBWsjVsmDDkdHv4keISuoC62QeYJcxexIFTE6W9D+gWe57RtzH/PosNwmSK/nQHfpT72KUkiUkDkOWXeOJaOjOPTv0OQRk+KfpgEk8pG5/UFF5+KaURF9xWYZxoaHouWhI4JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7nwUv3u; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2efa806acfdso3651289a91.2;
        Mon, 16 Dec 2024 18:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734401679; x=1735006479; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xjl+xQejjKp1J7IlIm0VLSGYWQRGbDJdIu5zyr4gMLc=;
        b=m7nwUv3ujz/penJHy5jHKefes5AcE9s0VRlz9N8eesnZl0qKfo4Zcr4Ss+MdA4yVtN
         xji9DmIXYjbjixye8zMz2hPt5qukcZbDob1llRLH8MsbSClpZok6CWAO54yycZdyozo5
         i53By2jocEp0JqXaCYOpMDDjsCwfleVvjnCnhmlScaj1Ud+i8EdZT47q4HOFFS410k9k
         2Fj9FmBygparQPd0nIffC9ADF2Z+r68riNk+utBX9M36mQwaFgj24Z4rziroxnCHwkGi
         vEn1rg/S4c5zvwcYzwLsldMauSGW3/Rrn7knvWsme1w0HrUJs3xLlOaUKbb5nZBdRzv8
         0PsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734401679; x=1735006479;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xjl+xQejjKp1J7IlIm0VLSGYWQRGbDJdIu5zyr4gMLc=;
        b=qgGFnQI2yGzMDuMBDCaElFtHf4BixGvA+CP7sh9bayXYxzuRRoZU5KwydiDeN5dpDp
         Pbk+mCZW5OO3p2uaM+JNlMhYZErzc+OGfCtP/n9S9TXIwj0asPzl/931H0DCy+wtZv8g
         dJL+majj5+yD5WWw66jY4tinLSoK8j/wzIb9fu37eOnZmOhDc1eF0RFw+sW+uUenQ39M
         Iy4ssUtV5lfGwM72f3Gq+97CAJaFooQN0jOVKxNR7UQjX8BA9dRvUPsOIL5mSUHyTw21
         KJ3ICJyP+r/vfP9JWogEIuONpAFkkkAkxtZizjulGJO+JaW8Qx14QAzLHQA96M4dlNgo
         KlFA==
X-Forwarded-Encrypted: i=1; AJvYcCWV5HplSBP2cHuUAM5YY61hCuuvt/YgP5/tAX/xPjVL0vhCG/93bfR1cVlHKlXHgC9oj7e/eayPmA==@vger.kernel.org, AJvYcCXr0L067xe59HAoys2qgukumLTR2Nm03xs8yPK83xvqUCUoBMSp0RwpeNyxTNEEMZDumDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4wUtp/r1fq+ydMjikKtt90ueaFBF6pGahVMiEuVdxG7kzjY6I
	xrl8YZBczWZXYE4sjfCcoc2CX1WX4MVJq8przyeR1wCIg0EtkYU1
X-Gm-Gg: ASbGncthPOpXxx2HjQfGD7FKB2301o/3smtPw3Bcs0qL+Qmzo8otnk8QzTZqXiTCJ3k
	H8lBTb+THiq9phiPn/mP5oWMcU9u5mNCoM3P/MuO5JSq6vYpEQ8HamwXNRGLNidE4Vnx1mpUUEz
	j5yH/gPEk6bGpV1+3p6ozdcBvsLuljAUWlv+SQDRAL8nq9HAbcLaXkCdZlglB+vur6trk2R4/qu
	5RO/t/Q17z+QH6woRvlymHzpBFc77hPK49jN6IELOcmmixmLVb2Lw==
X-Google-Smtp-Source: AGHT+IHHAxLWRl7sOQJIIZqCsBMJSZXll2sDSxcOj+iMCMI8A953dWZFBrolqGQfczFc4+mEwBqBKQ==
X-Received: by 2002:a17:90b:3c02:b0:2ee:c9d8:d01a with SMTP id 98e67ed59e1d1-2f28fb63bf1mr20191597a91.11.1734401679360;
        Mon, 16 Dec 2024 18:14:39 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a2434adesm6135849a91.38.2024.12.16.18.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 18:14:38 -0800 (PST)
Message-ID: <5d790414bcd38fd1b389a1708495fe7964a614c3.camel@gmail.com>
Subject: Re: [PATCH dwarves v2 10/10] dwarf_loader: multithreading with a
 job/worker model
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org,
 mykolal@fb.com, 	bpf@vger.kernel.org
Date: Mon, 16 Dec 2024 18:14:34 -0800
In-Reply-To: <20241213223641.564002-11-ihor.solodrai@pm.me>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
	 <20241213223641.564002-11-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-13 at 22:37 +0000, Ihor Solodrai wrote:

Also a small nit.
Aside from my previous email, I think this is a good simplification.

[...]

> @@ -3250,24 +3250,20 @@ static void cu__sort_types_by_offset(struct cu *c=
u, struct conf_load *conf)
>  	cu__for_all_tags(cu, type__sort_by_offset, conf);
>  }
> =20
> -static int cu__finalize(struct cu *cu, struct cus *cus, struct conf_load=
 *conf, void *thr_data)
> +static void cu__finalize(struct cu *cu, struct cus *cus, struct conf_loa=
d *conf)
>  {
>  	cu__for_all_tags(cu, class_member__cache_byte_size, conf);
> =20
>  	if (cu__language_reorders_offsets(cu))
>  		cu__sort_types_by_offset(cu, conf);
> -
> -	cus__set_cu_state(cus, cu, CU__LOADED);
> -
> -	if (conf && conf->steal) {
> -		return conf->steal(cu, conf, thr_data);
> -	}
> -	return LSK__KEEPIT;
>  }
> =20
> -static int cus__finalize(struct cus *cus, struct cu *cu, struct conf_loa=
d *conf, void *thr_data)
> +static int cus__steal_now(struct cus *cus, struct cu *cu, struct conf_lo=
ad *conf)
>  {
> -	int lsk =3D cu__finalize(cu, cus, conf, thr_data);
> +	if (!conf || !conf->steal)
> +		return 0;

Nit: the function returns either 0 or an enum literal,
     but 0 is a valid literal value for that enum.
     This is a bit confusing.

> +
> +	int lsk =3D conf->steal(cu, conf);
>  	switch (lsk) {
>  	case LSK__DELETE:
>  		cus__remove(cus, cu);

[...]


