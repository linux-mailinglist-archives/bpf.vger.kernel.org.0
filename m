Return-Path: <bpf+bounces-45844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7D59DBD44
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 22:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B8E7B219D4
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 21:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33EB1C3F28;
	Thu, 28 Nov 2024 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVQB2sn/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC121C3030;
	Thu, 28 Nov 2024 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732828463; cv=none; b=YOPiyt9H5y0Qqrb+Nir8/04T+FlFxxvqZOQdKypW53qcerYHU+WxNtZsuqFBK+fu4o6s6WvNo72IlPrf0Pp6SybqjHt58WxYxaKLsQQ7XK+hraRcuR908Nuvvpeqg6FTC2MqRAGoYw0Ymdgmd+K2PVXLYuWizLFm/la949y8mpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732828463; c=relaxed/simple;
	bh=ND9Gq6ZGNeW2vcNU8xnP2lZBtMBUfTNg29u4IOwX41g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UpEY5hNGIlIEm9PZRT1NkCdg7/weMmTe3m7jK3/RP+4+5ia+C57M/ubMVStgnd0HUmjAsF03VW6UVhhR4ClRdcdlZ5ZQ9B9INNFhxXr128/h1M/7iO10m9N68MGx/9Rlhdc/6bicB8b0owcnDOCimIzpbGTo8RacLcDndBpWZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVQB2sn/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-724f1ce1732so957780b3a.1;
        Thu, 28 Nov 2024 13:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732828461; x=1733433261; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RS0EbWTss8fpdFLdCs16gyg79m8YB6IFuzkbs6f2Mrc=;
        b=gVQB2sn/ea/xL52OWkJG7OewO7JWyWaJZ3fL8MdmuKsMuxJho6TS8rYu6fFpDRcnB7
         uV7NBA1lDYiUCwFDwAX5fq4xYBD1l8WGE8RYz1NKnZoYqpZpA5exo+S7/k6RXoTOwA2U
         Kc0N4vE+CCdK5LiVFfcug3dQIuPoN1q0Zr15P1JPm8EyhfsK6LfQZ0T+XNH2e3pI+FOe
         Sn8fInfvoxVHtvzTUgIWc9HM6CDdT2f/iQpOAZ1m/jnARCbajSQvj2V7R2B8ZwKozc3u
         pZk+unQN+gkeiyuG/AvferRbuU2Z2raaFR7DYuYYNBi50jiBBz7CcbmsRldvXLpJ7LSe
         U88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732828461; x=1733433261;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RS0EbWTss8fpdFLdCs16gyg79m8YB6IFuzkbs6f2Mrc=;
        b=Znq2IFxsOX4ZH29JzQTKQ3dM/jO9F8V8921dltYbqA6egyyG5syJvEg/Ikht2tX8vq
         Cng5kI1uyn0BFN1JO+R4b02SB1qZuEFEm51NbPOm8axm+AB1vk6rCLLqSYYXD/LwVsgs
         KEAUuABCY3Fkt3nL+/jqnzoDNYLMl1ClAaOJdqF2rR6kgvoocjuyDH34Thpn12Yz7uNc
         NczQJF2ce+qhwf+8UXTmPlfx1xMmL2DGkz1xioxfozgtpyVyDS2q4dYluqf73I5Idw0c
         /uzTjXdsTh0Y2K/cc6GgneiIylMjOGO8pvLxepIeQDHjypmBVvQ+81oJeAaG49TlgqIB
         6xkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXXHhQgOX4AV8On2O+iQbCVZ/1If7cVUO7WHPGE8lawMgnUCeW7jILSPdZJMslqzm4tLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ywa36IPRs5DW3dwxdXatz49/v354OEYFOAa6C8+iuvBI6Yon
	GQdLDNfWj1Wi5cuTSKb64BnD/yVBMmlPmXm+6EhkBGn2QER2I89z
X-Gm-Gg: ASbGnct3L4fS2uw7SNM7ytEXwd1Ougrp/vIswXb34wy58GxEEhrs5EjvIW0EqYUzQfC
	d8zOtWaJZ37ajZCZoXzuD13mfynCnfgHpe6gW8fyU9VRbXcx3rbAKlJJq2DkP6mBb7MdcTD61CN
	zIM8eDJa6pIPmaM2cu9UkJeiROVxNZJBTryXubm/Rr/SYDPNoIQ7NMvs4Nd2ps/MDJv156A6VtF
	Y+e5CN6pdkeS2zs57qlDQ8niq7QJQ3BI1XbdOVx8dvADB713DM0ZdxMmHQGT6GCxAP7eeZ4PepK
X-Google-Smtp-Source: AGHT+IFyb5jVBX5bTzKGmAu8lYogbuyELNvLrOSKaQuhA/9ZDk/kf1T0qnZ5sgzWWIMMN6Tj/Vc3dQ==
X-Received: by 2002:a05:6a00:1396:b0:725:e6e:53f3 with SMTP id d2e1a72fcca58-7253003fb8bmr11505025b3a.12.1732828461309;
        Thu, 28 Nov 2024 13:14:21 -0800 (PST)
Received: from ?IPv6:2620:10d:c096:14a:7df9:9622:d4fb:2186? ([2620:10d:c090:600::1:ad3f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176f44esm2096705b3a.69.2024.11.28.13.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 13:14:20 -0800 (PST)
Message-ID: <5671a816c5f6f9672e96793de757733b2c592442.camel@gmail.com>
Subject: Re: [PATCH dwarves v3 1/1] btf_encoder: handle .BTF_ids section
 endianness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Vadim Fedorenko
	 <vadim.fedorenko@linux.dev>
Cc: dwarves@vger.kernel.org, arnaldo.melo@gmail.com, bpf@vger.kernel.org, 
 kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org,  yonghong.song@linux.dev, Alan Maguire
 <alan.maguire@oracle.com>, Daniel Xu <dxu@dxuuu.xyz>, Jiri Olsa
 <olsajiri@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 28 Nov 2024 13:14:17 -0800
In-Reply-To: <Z0jSDShhOneLuPxc@x1>
References: <20241127015006.2013050-1-eddyz87@gmail.com>
	 <20241127015006.2013050-2-eddyz87@gmail.com>
	 <35f1dcb0-f577-4861-a82d-c3083dafabd4@linux.dev> <Z0jSDShhOneLuPxc@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-28 at 17:26 -0300, Arnaldo Carvalho de Melo wrote:

[...]

> Tested:
>=20
> acme@number:~/git/pahole$ tests/tests
>   1: Validation of BTF encoding of functions; this may take some time: Ok
>   2: Default BTF on a system without BTF: Ok
>   3: Flexible arrays accounting: Ok
>   4: Pretty printing of files using DWARF type information: Ok
>   5: Parallel reproducible DWARF Loading/Serial BTF encoding: Ok
> /home/acme/git/pahole
> acme@number:~/git/pahole$
>=20
> And applied.

Great, thank you!

