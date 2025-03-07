Return-Path: <bpf+bounces-53565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715C6A566E9
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 12:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 922667A7FDE
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 11:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18791217F36;
	Fri,  7 Mar 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLmlxbVx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7798420764E;
	Fri,  7 Mar 2025 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347553; cv=none; b=WMCcri5HSW8kLpRQ+9LI2UjqbYyRrnRekyrtn2hLmrDeqc8QkM5pF8Jn2CIHrXuAECovjnsiCEwnFMSCFzdl7XgnkyiDcPNe26vSHJsGIYcw8X1PFA4jxDeumLEMi1KzWpHUMnP8uZcAxAuBI5ojxU3RXfAf8EtkVp3wm36y1Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347553; c=relaxed/simple;
	bh=3/sdXJVj7KtnSE85cKxaG8wUs9rqjrFuOU79jRxJq1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMZ4WgPuYPaVQex0QzQL4tPOxIJOXt2Xf7HMSIbiNJ2amU1FXpO61SgrvbEYEykDJoHj0fwMMFs47P4pjencJMGazDgBvRYPKr3Wc0EoQmIAGYEDQnAPAWVaRcP66mSWUJkrpdmisEjAyBb4X6RS4RL4PGJC/wR4zoSsc+PWRgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLmlxbVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED54C4CED1;
	Fri,  7 Mar 2025 11:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347552;
	bh=3/sdXJVj7KtnSE85cKxaG8wUs9rqjrFuOU79jRxJq1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YLmlxbVxqEup0anPAlcb+dTa8FE8yj+y8ZZ0PST3YP2elqVhKYbGBRuANPKgYm1pV
	 NGn7rb39E++lc1xbYoS5OhozY8nndia47/v8Sa5rqGO0Bu8MCd8jDX4s/rl8jnc9KS
	 /Zw1dAykvcP3jA1LZJezkeY71xfpNocgXG5ZY1+5Iclozb/CN7EK86u7FruZPbQxgj
	 O/EL7tcNhW8jLL10yopA5JzxQSg3yqC7XySzB7uBdYZaoLo+uDBWnCmh/MI/mDyW7C
	 DnKxEvglJ/VC5FCGBR5poufWGtRL6VWA6EpoY09yZ3F8omD0L+wJBxziuE5Y36X3fT
	 t3EHCJ+yuPtdQ==
Date: Fri, 7 Mar 2025 12:38:58 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, jk@ozlabs.org, joel@jms.id.au,
	eajames@linux.ibm.com, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dmitry.torokhov@gmail.com, mchehab@kernel.org,
	awalls@md.metrocast.net, hverkuil@xs4all.nl,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	louis.peens@corigine.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
	johannes@sipsolutions.net, gregkh@linuxfoundation.org,
	yury.norov@gmail.com, akpm@linux-foundation.org, hpa@zytor.com,
	alistair@popple.id.au, linux@rasmusvillemoes.dk,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v3 01/16] bitops: Change parity8() return type to bool
Message-ID: <Z8ra0s9uRoS35brb@gmail.com>
References: <20250306162541.2633025-1-visitorckw@gmail.com>
 <20250306162541.2633025-2-visitorckw@gmail.com>
 <9d4b77da-18c5-4551-ae94-a2b9fe78489a@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d4b77da-18c5-4551-ae94-a2b9fe78489a@kernel.org>


* Jiri Slaby <jirislaby@kernel.org> wrote:

> On 06. 03. 25, 17:25, Kuan-Wei Chiu wrote:
> > Change return type to bool for better clarity. Update the kernel doc
> > comment accordingly, including fixing "@value" to "@val" and adjusting
> > examples. Also mark the function with __attribute_const__ to allow
> > potential compiler optimizations.
> > 
> > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> >   include/linux/bitops.h | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > index c1cb53cf2f0f..44e5765b8bec 100644
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -231,26 +231,26 @@ static inline int get_count_order_long(unsigned long l)
> >   /**
> >    * parity8 - get the parity of an u8 value
> > - * @value: the value to be examined
> > + * @val: the value to be examined
> >    *
> >    * Determine the parity of the u8 argument.
> >    *
> >    * Returns:
> > - * 0 for even parity, 1 for odd parity
> > + * false for even parity, true for odd parity
> 
> This occurs somehow inverted to me. When something is in parity means that
> it has equal number of 1s and 0s. I.e. return true for even distribution.
> Dunno what others think? Or perhaps this should be dubbed odd_parity() when
> bool is returned? Then you'd return true for odd.

OTOH:

 - '0' is an even number and is returned for even parity,
 - '1' is an odd  number and is returned for odd  parity.

Thanks,

	Ingo

