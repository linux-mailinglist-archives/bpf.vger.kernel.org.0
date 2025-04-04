Return-Path: <bpf+bounces-55302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57630A7B5F8
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 04:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D998189A9D0
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 02:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B895D86348;
	Fri,  4 Apr 2025 02:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="cECX35JO"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9670A79D2;
	Fri,  4 Apr 2025 02:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735135; cv=none; b=WDnVBNQ1n29HiyYFahCTHdlC419ap+10DrpIDFF/2obZ50IsuLXW9VhtzyaNl2OofBb5PvjhO8beBg14U6bth2L2xLu4N6345NdsLcB3DNQ8vm3YXo88ajDLWBSFr51KgRFPA21UQaBEDJ/qY/fgTU4wY/HyWQHQ2DMyS69y+nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735135; c=relaxed/simple;
	bh=bD316i6CC1/1PO6OVutB+NKMwcDuOGm8uB+gBAMy1aY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K7BGAXgRJBaYgy882XwyrAGUE7OjA/N4hFsX9ey+kymaBRjwO3yN6l4dRLGfjrA97YpKku27AfnqjIRh8vTOIfQcVUFjd31XetXHelOeHeOO50AOT3W3khcAjZFDDMWpo4LzLclk2EARQZB9mbONUSW1/4bR72ziS8FO1eUhawI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=cECX35JO; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1743735129;
	bh=bD316i6CC1/1PO6OVutB+NKMwcDuOGm8uB+gBAMy1aY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cECX35JOUju7Gk7KN9dGvxDxapcSnbwiA6dOiSg+vBhsG/elnQAFs/XdV5+g6WWt6
	 SLCnm/Ucw8BBGVyk5Ijw+fksySSB6WceeM1CY3gFBmJT9wI6tsBebEb6+o92tkuHS5
	 W86JYzh62/EpgW4D48keOw4sg7Ga/HdeNdrRLxuxYO34VtQbiLDviSnDbvtFpckqcj
	 TGdMnQGS1Jnjggap/FvXRhM0sVlGzBGbEYD9iWoiIUwTri9g8KO5FCGJ0q8N8pRRps
	 Oit9X8P5fuYFOcEsQWRIudq6HVF68PYjzIGIF6CP6n5FfeUTK/dStmQfFMHikk8lv2
	 VEX5mekmjKhpA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZTNRc5mVdz4wyh;
	Fri,  4 Apr 2025 13:51:56 +1100 (AEDT)
Message-ID: <3ebd280e6697790da55f88a5e9e87b4cab407253.camel@ozlabs.org>
Subject: Re: [PATCH v3 00/16] Introduce and use generic parity16/32/64 helper
From: Jeremy Kerr <jk@ozlabs.org>
To: Yury Norov <yury.norov@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, David Laight
 <david.laight.linux@gmail.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
 Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
 akpm@linux-foundation.org,  alistair@popple.id.au, andrew+netdev@lunn.ch,
 andrzej.hajda@intel.com,  arend.vanspriel@broadcom.com,
 awalls@md.metrocast.net, bp@alien8.de,  bpf@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com,  brcm80211@lists.linux.dev,
 dave.hansen@linux.intel.com, davem@davemloft.net, 
 dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org, 
 eajames@linux.ibm.com, edumazet@google.com, eleanor15x@gmail.com, 
 gregkh@linuxfoundation.org, hverkuil@xs4all.nl, jernej.skrabec@gmail.com, 
 jirislaby@kernel.org, joel@jms.id.au, johannes@sipsolutions.net,
 jonas@kwiboo.se,  jserv@ccns.ncku.edu.tw, kuba@kernel.org,
 linux-fsi@lists.ozlabs.org,  linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-media@vger.kernel.org,
 linux-mtd@lists.infradead.org,  linux-serial@vger.kernel.org,
 linux-wireless@vger.kernel.org,  linux@rasmusvillemoes.dk,
 louis.peens@corigine.com,  maarten.lankhorst@linux.intel.com,
 mchehab@kernel.org, mingo@redhat.com,  miquel.raynal@bootlin.com,
 mripard@kernel.org, neil.armstrong@linaro.org,  netdev@vger.kernel.org,
 oss-drivers@corigine.com, pabeni@redhat.com, 
 parthiban.veerasooran@microchip.com, rfoss@kernel.org, richard@nod.at, 
 simona@ffwll.ch, tglx@linutronix.de, tzimmermann@suse.de, vigneshr@ti.com, 
 x86@kernel.org
Date: Fri, 04 Apr 2025 10:51:55 +0800
In-Reply-To: <Z-6zzP2O-Q7zvTLt@thinkpad>
References: <EB85C3C1-8A0D-4CB9-B501-BFEABDF3E977@zytor.com>
	 <Z824SgB9Dt5zdWYc@visitorckw-System-Product-Name>
	 <Z9CyuowYsZyez36c@thinkpad>
	 <80771542-476C-493E-858A-D2AF6A355CC1@zytor.com>
	 <Z9GtcNJie8TRKywZ@thinkpad>
	 <Z9G2Tyypb3iLoBjn@visitorckw-System-Product-Name>
	 <Z9KMKwnZXA2mkD2s@visitorckw-System-Product-Name>
	 <Z+AlyB461xwMxMtG@visitorckw-System-Product-Name>
	 <eec0dfd7-5e4f-4a08-928c-b7714dbc4a17@zytor.com>
	 <Z+6dh1ZVIKWWOKaP@visitorckw-System-Product-Name>
	 <Z-6zzP2O-Q7zvTLt@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Yuri & Kuan-Wei:

> Thank you for sharing your opinion on this fixed parity(). Your
> arguments may or may not be important, depending on what existing
> users actually need. Unfortunately, Kuan-Wei didn't collect
> performance numbers and opinions from those proposed users.

For the fsi-i2c side: this isn't a performance-critical path, and any
reasonable common approach would likely perform better that the current
per-bit implementation.

Our common targets for this driver would be arm and powerpc64le. In case
it's useful as a reference, using the kernel compilers I have to hand, a
__builtin_parity() is a library call on the former, and a two-instruction
sequence for the latter.

Cheers,


Jeremy

