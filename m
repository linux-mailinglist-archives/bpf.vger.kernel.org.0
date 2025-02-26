Return-Path: <bpf+bounces-52699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E2FA46E95
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 23:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DBC188283D
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 22:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317E025D918;
	Wed, 26 Feb 2025 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAPGceqs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0732725D8ED;
	Wed, 26 Feb 2025 22:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608958; cv=none; b=lWohgfoJArUcboHq0hdk0hgwxlceF/J5w0qx/O/aDagwtH5GNjOHl30IjYfbHAj9nY5SnAtx8o3Lxew+FWIld0Ok78Ml+Ml4cEuWU90GfDElQZl0GlChdvQeHKP0EdpF7fVv688Ofx0T1GY6BN/NJUd+FFYCmOtdqc02S5/BKDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608958; c=relaxed/simple;
	bh=WHPKx1WninINjpWP2dwg3Iq53rxsjrVAY5O3XcMBM0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCEYrYsqLT8Hqns0k9L+Qq5BVoBaVSOr/DdcEtZxrdW7zVILO6NbxQ6D6ipHYpptalhi7lygcvtZ/UkSiJz98KkMic7KVf9WxT8eIGIM/AN0bL8apJeN/isctvcz6UGqO8fCTgFrjJNyMbwV9++YRzhqaeG+LotA/DyuFT20nH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAPGceqs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43996e95114so2115805e9.3;
        Wed, 26 Feb 2025 14:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740608954; x=1741213754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfWwQBkEse5FRQekJZuNar17CRdvAyTkX7+fO0J+m/4=;
        b=mAPGceqsRiBwro2u6mE4tdLIvHypC6x3rq8R2BkrIw9c08g6CT61YYdRX8LwVYl9a0
         L23sG7MFeKtUvpU8ulTO7a2GjLEeB0lTzfP69l9shHuvZV/TCbp/GWMcOhIYVXaSusfM
         G2wAJnjVzcq9dz3EWpJO9WmsMUPddKBc9j4zmePlsssROu+zQpIVDPW9arFQW6EM2mN4
         Pf0vPX3HLdJIOCU7HfXAjiVbGlpQ7MJO8FJsnk7slUv1lkA+Pbv8mvQ6QeYGlmxeCQKg
         9xRVdnBxt33dJiMvQff136CAnYsVk1Mp38soium3nTkU3dk+Z7U3eX8P0K5SCVKa7Zo/
         VJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740608954; x=1741213754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfWwQBkEse5FRQekJZuNar17CRdvAyTkX7+fO0J+m/4=;
        b=Ab864Cp894avTWcJ0fEIv6snhEK2B0xsnhvBcmSS74hmdUOEKL3QOhX0oopbeneKpD
         0opR5ELUr9xQjNOboSDcMqxZrO/0/MxLxT9pUDqN0g6hMVw3uCwCwCFzDOf5g3vt43Zo
         ZLRWQqNDB3VRh36+Y4Cf4vUCToEm0/7fhh0dy9BpLnB0k0y3IfqRpio+Yz2glKNwOZDx
         jvFNXwBlezZE/ykkTJZ2VTnrPG/DvA/KCMio6g3VPFQt1ZSxyJLqej2B2tCEWXjgt5ZY
         gxMR72dPtJvKlG9nCjoBTdwEvB1XEOA5Kzblg9vxvqmxYG8HL1vfapCYaLlBU6lKH2mJ
         BEVA==
X-Forwarded-Encrypted: i=1; AJvYcCUcNfx1uaYKScnWlN3fUKjtfkSh6WNQ5rCAh51/NsztiySMXF3DD8Ux3BJsU5AkBl7fqj//FNFZ0QjmBnFi@vger.kernel.org, AJvYcCUg/+sayvUqWupvNgCrW9vceXG5h6dS0pnktB/+xQVDmoKfKxvpn9WBoHEumtO+qcR5fpQToQjnE31phr03uGw=@vger.kernel.org, AJvYcCUz4sAkVRKqKQnkjhzaMn+KS+V1umQkMTE79pq0f1Kb3ikfYS1Td/egN3dSLaZDeXoCVpcx2XQPzYuyhwU=@vger.kernel.org, AJvYcCVXJFaF6Rs5LBKhU5QuEjAwBINQiGW35ytnwXMOaL+ETzBFAMNfb2euxP3sGNmE2grcrn1+crkTv5FwNx0=@vger.kernel.org, AJvYcCWKGrdFEboUQaLDqPjCbECF6naJuvrYV5/ayy8XI2qLcjfpzU/DG4xFHTWinEObilVH2rdPtop83WBj6hu9@vger.kernel.org, AJvYcCX52jR8VfIQrbEtx3spW+rzY/CX3RmwjvBNWepLZDB+LTKytULXOfE45EulhRI24AyuZQM=@vger.kernel.org, AJvYcCXrKKUYGU91ltUYwlvveMm0jPs8QY79pD+PPbrbGxFoEdQ6/7nogrzHz8oJFHVmg3W/SkYdS5xd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy71pFyZNLU6R36Qe4VCP9tZLuYS/idH5gV8GnmKhBOz6tAGo0Q
	0yybyVlA4xga7vUpG339ZUvvc5Z08CWBSWt0x6EUtrKwE5/QP7Wl
X-Gm-Gg: ASbGncu4KOpJYTW6w8+crEAMbINgJOEz0I2rgFL1dVXgXUYiErDPQnu7QWR6TpJk9rY
	ALaCMk2eN6yUxoVpFt5+AyFSSJzCGdmPnW0jt0GEXm5YYCF7bOftpQ5CguNSU46wPIgO8RRqnh7
	x4sUJ3/jCw+10JZC3x1wVqw8bUfPUmDV0T1nyzdllzqqIrfsSEvQA5jGu3ZkhNyqXb+K3vLsibS
	MbDIh79NL2wN5ZfVHylaSGI4d7Ho8oMKiMZgvZg17Nmbwqh9FpqY1TXSVFCtSdULWd2mkNItCGN
	EjE/f5P/meTo2xmAVHuK0KrD+eCYaOIYHXIgRwGfnlz5M19dTWX2zAsaxcXXgXIm
X-Google-Smtp-Source: AGHT+IGOLpw4Ro1gZlLbKLPuJeugBpGxKDyhpAzWxjxf7AIm0WuOoMev7XCdFdyak+Spbs3OpN2AOA==
X-Received: by 2002:a05:600c:4f47:b0:439:9828:c42c with SMTP id 5b1f17b1804b1-439aebc27cfmr188697005e9.23.1740608953906;
        Wed, 26 Feb 2025 14:29:13 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab37403cfsm55655745e9.1.2025.02.26.14.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 14:29:13 -0800 (PST)
Date: Wed, 26 Feb 2025 22:29:11 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, jk@ozlabs.org, joel@jms.id.au, eajames@linux.ibm.com,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dmitry.torokhov@gmail.com,
 mchehab@kernel.org, awalls@md.metrocast.net, hverkuil@xs4all.nl,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 louis.peens@corigine.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com,
 parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
 johannes@sipsolutions.net, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, akpm@linux-foundation.org, hpa@zytor.com,
 alistair@popple.id.au, linux@rasmusvillemoes.dk,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsi@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mtd@lists.infradead.org, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-serial@vger.kernel.org, bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
 Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH 02/17] bitops: Add generic parity calculation for u64
Message-ID: <20250226222911.22cb0c18@pumpkin>
In-Reply-To: <Z7zIBwH4aUA7G9MY@thinkpad>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
	<20250223164217.2139331-3-visitorckw@gmail.com>
	<Z7zIBwH4aUA7G9MY@thinkpad>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 14:27:03 -0500
Yury Norov <yury.norov@gmail.com> wrote:
....
> +#define parity(val)					\
> +({							\
> +	u64 __v = (val);				\
> +	int __ret;					\
> +	switch (BITS_PER_TYPE(val)) {			\
> +	case 64:					\
> +		__v ^= __v >> 32;			\
> +		fallthrough;				\
> +	case 32:					\
> +		__v ^= __v >> 16;			\
> +		fallthrough;				\
> +	case 16:					\
> +		__v ^= __v >> 8;			\
> +		fallthrough;				\
> +	case 8:						\
> +		__v ^= __v >> 4;			\
> +		__ret =  (0x6996 >> (__v & 0xf)) & 1;	\
> +		break;					\
> +	default:					\
> +		BUILD_BUG();				\
> +	}						\
> +	__ret;						\
> +})
> +

You really don't want to do that!
gcc makes a right hash of it for x86 (32bit).
See https://www.godbolt.org/z/jG8dv3cvs

You do better using a __v32 after the 64bit xor.

Even the 64bit version is probably sub-optimal (both gcc and clang).
The whole lot ends up being a bit single register dependency chain.
You want to do:
	mov %eax, %edx
	shrl $n, %eax
	xor %edx, %eax
so that the 'mov' and 'shrl' can happen in the same clock
(without relying on the register-register move being optimised out).

I dropped in the arm64 for an example of where the magic shift of 6996
just adds an extra instruction.

	David



