Return-Path: <bpf+bounces-52319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0BFA416C1
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 08:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B75C1895D96
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 07:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE58241680;
	Mon, 24 Feb 2025 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="ims34gfQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786EE23F262;
	Mon, 24 Feb 2025 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740383955; cv=none; b=Jo1Wf697rz058wDGL6vBSiGhYMWPeACRyPrqmuID+wqcpBp/zy++qwXyMGj0CEo4XJprKMmuRQmmdkuWVCSx9vTQ0/1U4KUcItyJougaFelPcS+5EFjl2HysyZlfpxWjlr7aDIwCARK+3ZdbArwQwy5OWaONBOp2WANhCuliajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740383955; c=relaxed/simple;
	bh=KH7gHdSS1itQHQoP3z+uj401oB/rX1ncYfhBdSQWuUg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rxNAG4XkEKg8SXwtLnENY2koC7N6BtJ06hNOVDduKyLxSFtnhNFNtPzY/UgsZDeqxFpfFT+QQE722EWDPKP7lXePBaiwvWFD8V4dFX4SlKexB5HGedPDu0TLMGjlMe0Sq8P3p7dQQODUXVhfCqa/1uLD7hHQ+OI6uSHS8lTwfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=ims34gfQ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1740383950;
	bh=KH7gHdSS1itQHQoP3z+uj401oB/rX1ncYfhBdSQWuUg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ims34gfQA1vb1TN04LB3UWi8oHvR4gxRnPiIctjK103CyZjimW58U3jEvwGUiodUv
	 Za6iGn3q5AdLIxYyGTz781CdTkRRuzvuzvB+jqoRCFNgqP3roPHIeinGtWFwJEKkks
	 APqv1lGjpK23uVFnzo7nVVS6b3xXCg06P8jTIx1RlPQEEsIl6RAASM53YXWxfxgCPT
	 YuWYvczKQgqWnAIi87XjLoll+9D2dsL+De6hgIcZaT1OeN4O1e1mvYID5Q0/x192AI
	 cIKrTswlatGOS2XEjLU/PxGrM3nDGtjSOtqs2L52iQ/z9EMvUaOHQjKU3ndigQC8xz
	 42ZoJR/u2NoBg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits))
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Z1Y5l5GVTz4wby;
	Mon, 24 Feb 2025 18:58:51 +1100 (AEDT)
Message-ID: <1cebfebb9c205a1ebc5722ca7e3b87339ceb3c79.camel@ozlabs.org>
Subject: Re: [PATCH 00/17] Introduce and use generic parity32/64 helper
From: Jeremy Kerr <jk@ozlabs.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de,
 mingo@redhat.com,  bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, joel@jms.id.au,  eajames@linux.ibm.com,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,  rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dmitry.torokhov@gmail.com,  mchehab@kernel.org, awalls@md.metrocast.net,
 hverkuil@xs4all.nl,  miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com,  louis.peens@corigine.com, andrew+netdev@lunn.ch,
 davem@davemloft.net,  edumazet@google.com, pabeni@redhat.com,
 parthiban.veerasooran@microchip.com,  arend.vanspriel@broadcom.com,
 johannes@sipsolutions.net,  gregkh@linuxfoundation.org,
 jirislaby@kernel.org, yury.norov@gmail.com,  akpm@linux-foundation.org
Cc: hpa@zytor.com, alistair@popple.id.au, linux@rasmusvillemoes.dk, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com,  kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsi@lists.ozlabs.org,  dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org,  linux-media@vger.kernel.org,
 linux-mtd@lists.infradead.org,  oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 linux-serial@vger.kernel.org, bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw, 
 Yu-Chun Lin <eleanor15x@gmail.com>
Date: Mon, 24 Feb 2025 15:58:49 +0800
In-Reply-To: <20250223164217.2139331-1-visitorckw@gmail.com>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Kuan-Wei,

> Several parts of the kernel contain redundant implementations of parity
> calculations for 32-bit and 64-bit values. Introduces generic
> parity32() and parity64() helpers in bitops.h, providing a standardized
> and optimized implementation.=C2=A0=20

More so than __builtin_parity() ?

I'm all for reducing the duplication, but the compiler may well have a
better parity approach than the xor-folding implementation here. Looks
like we can get this to two instructions on powerpc64, for example.

Cheers,


Jeremy

