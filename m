Return-Path: <bpf+bounces-55598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159C6A833F3
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 00:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1AB44072B
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 22:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED59321ABA0;
	Wed,  9 Apr 2025 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="asCopqs3"
X-Original-To: bpf@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF48E1E5713;
	Wed,  9 Apr 2025 22:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744236420; cv=none; b=rKM1E6jCB2nX0xUqOoyP2JFWjvAPiFifbovOqGiqo5SHjSopJWHAx1knMrNtbmV6f05WKlEOO/lhqQesgfL9Qh0IX356p77N1KpYgNt7F04wGT2wWxzaU6sBodOKSbrpEyjMERCtvdxiNNJDnpJ2u+6gvq8nuDR2mrVW4zUImzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744236420; c=relaxed/simple;
	bh=LqPIp6+OYr6Lu05eZr+DtxFsHBUkh7pN3E33NAMprsU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e0nvIUAfJqx28fjf8CHbZqN9riDgTHQ9xLE/Iw8Qxwc4utA97pdH4bhG89xSU3nicgC0uzUM+wJTppmbIshTMxM4ViFAO0o1bNyloVVPahoLg8lbeh+HsLnZ+pV+W8DBD0UadpKse9E8Tag79mLuZNRJTnUzJ3NGMWlgd9FJduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=asCopqs3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MXaJb6rqjO6k6hC8GGRd9Nz5/YI2plyuUrbJ5reUjDs=;
	t=1744236419; x=1745446019; b=asCopqs3XyqFrtO3t8wVBRwG3MlLTFRVdgVfSnVL4Iz61u6
	vXhM1KbVeFuXEPTY5sMCGxuwXol6WzA0rAzYRuxR6RpD0VhQuPqSgn43Tf/lqvOOMhmwRtcYtsfyB
	aahgpjeCxTcP/eKvl3kq8bgDLvMl146mioXEJGCK7hmgiIWgwOhN0fMQtwbCjRnSkAHVoKdqXkJyr
	nS5kVmxAmOBXsVkTCG4vaEk8C3IjMrAVOL+C2Dptw6SjsZE19btV3KOinaLqydwanvSphjYuYIBf+
	xr4VjceodEemzupHcJCEfQq2Hy/JwdUI4fF97rjjtMAy68TxEpvBwk/H9JrBbeFQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u2dYb-00000005Jap-0lrk;
	Thu, 10 Apr 2025 00:06:05 +0200
Message-ID: <740c7de894d39249665c6333aa3175762cfb13c6.camel@sipsolutions.net>
Subject: Re: [PATCH v4 03/13] media: pci: cx18-av-vbi: Replace open-coded
 parity calculation with parity_odd()
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Kuan-Wei Chiu	
 <visitorckw@gmail.com>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 	dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org,
 joel@jms.id.au, 	eajames@linux.ibm.com, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, 	rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dmitry.torokhov@gmail.com, 	mchehab@kernel.org, awalls@md.metrocast.net,
 hverkuil@xs4all.nl, 	miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, 	louis.peens@corigine.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, 	edumazet@google.com, pabeni@redhat.com,
 parthiban.veerasooran@microchip.com, 	gregkh@linuxfoundation.org,
 jirislaby@kernel.org, yury.norov@gmail.com, 	akpm@linux-foundation.org,
 jdelvare@suse.com, linux@roeck-us.net, 	alexandre.belloni@bootlin.com,
 pgaj@cadence.com
Cc: hpa@zytor.com, alistair@popple.id.au, linux@rasmusvillemoes.dk, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, 	kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsi@lists.ozlabs.org, 	dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, 	linux-media@vger.kernel.org,
 linux-mtd@lists.infradead.org, 	oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	linux-serial@vger.kernel.org, bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw, 
	Frank.Li@nxp.com, linux-hwmon@vger.kernel.org,
 linux-i3c@lists.infradead.org, 	david.laight.linux@gmail.com,
 andrew.cooper3@citrix.com, Yu-Chun Lin	 <eleanor15x@gmail.com>
Date: Thu, 10 Apr 2025 00:06:03 +0200
In-Reply-To: <25b7888d-f704-493b-a2d7-c5e8fff9cfb4@broadcom.com>
References: <20250409154356.423512-1-visitorckw@gmail.com>
	 <20250409154356.423512-4-visitorckw@gmail.com>
	 <25b7888d-f704-493b-a2d7-c5e8fff9cfb4@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-04-09 at 20:43 +0200, Arend van Spriel wrote:
>=20
> This is orthogonal to the change to parity_odd() though. More specific=
=20
> to the new parity_odd() you can now do following as parity_odd()=20
> argument is u64:
>=20
> 		err =3D !parity_odd(*(u16 *)p);
>=20

Can it though? Need to be careful with alignment with that, I'd think.

johannes

