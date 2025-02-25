Return-Path: <bpf+bounces-52519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A01A4444C
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 16:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C54717370C
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 15:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F5F26BDB0;
	Tue, 25 Feb 2025 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BUMWjRPI"
X-Original-To: bpf@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07AF26AA93;
	Tue, 25 Feb 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497155; cv=none; b=FgKGX2w8FVCwnEtQjKAqHL9QJKYEFt+h8s6+Q+/O1Wzw2Ac7fZsgNLY0Q7nLwAvN23eEQy1pdTWWcS+cWUnLCwKR8c2kHrFO80WZ863bpXYdUEMdLjsF42fAicL+fUQQ+vu0CZy+y+mZWHcenUxbpoePwaxETpoKGfLK7Zg8Vg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497155; c=relaxed/simple;
	bh=kZ993xbPUrqxt9evRYhTDaW4rgAsxIjUaJ0fumHopmc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=UJEEvAHGDgFA5ZAu4awRbGShzs9DCxFIHBRjcC0Q/mx9jZxP+ORd/SNL4WNrqMIbRdpOhiVnoOI23puORRiZyRCA//kvDTtGVSWlyWFMecW3vTZik8TrZNl6KZiQmj/yiztmlFbNBwThgflUW2HyD8jhV74zgDTTcNhZIpHrs3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=BUMWjRPI; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51PFLeJx1321966
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 25 Feb 2025 07:21:41 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51PFLeJx1321966
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740496908;
	bh=IFxVykDS0g8xLLyPz9dDn1sgxptbnK+YyCXg+3CY3aM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BUMWjRPIFaLk9eEljQvZOhLwrBHl5WiOz4myJbzxM1DiE4BYZIZywLpG+8lH6L2Ld
	 bFtraaKU3/cK4+FeRWQF5FbFz83DA8Z/AQnawksvD4yyCe21dX2Z0rgdJKhBBHLj1z
	 s4I9gcurp+Edn27zjQimLT1osW8ygdQmmUepB5mDrHI/BX4Xi6bUBzkmawhEaTO/H0
	 x2/DVO+Y+FeNzDFJllD1SIrMR4JwTWu/5UrL2K1pJJDRRfeaeW4lVKsfyboLsLCJ0g
	 GbLOzT769Ufnz8kospEBAiCZ1QDPJbYxD0w9NG/sbS9pBQyDxcESpuh28quuCen1V2
	 4+wvwE+cqOncg==
Date: Tue, 25 Feb 2025 07:21:38 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Laight <david.laight.linux@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>
CC: Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        jk@ozlabs.org, joel@jms.id.au, eajames@linux.ibm.com,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
        dmitry.torokhov@gmail.com, mchehab@kernel.org, awalls@md.metrocast.net,
        hverkuil@xs4all.nl, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, louis.peens@corigine.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
        johannes@sipsolutions.net, gregkh@linuxfoundation.org,
        yury.norov@gmail.com, akpm@linux-foundation.org, alistair@popple.id.au,
        linux@rasmusvillemoes.dk, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
        oss-drivers@corigine.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
        brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
        bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
        Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH 02/17] bitops: Add generic parity calculation for u64
User-Agent: K-9 Mail for Android
In-Reply-To: <20250224133431.2c38213f@pumpkin>
References: <20250223164217.2139331-1-visitorckw@gmail.com> <20250223164217.2139331-3-visitorckw@gmail.com> <bde62fee-4617-4db7-b92c-59fb958c4ca6@kernel.org> <20250224133431.2c38213f@pumpkin>
Message-ID: <949B0809-3BB9-4E18-8FA1-A12BD47F2843@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 24, 2025 5:34:31 AM PST, David Laight <david=2Elaight=2Elinux@g=
mail=2Ecom> wrote:
>On Mon, 24 Feb 2025 08:09:43 +0100
>Jiri Slaby <jirislaby@kernel=2Eorg> wrote:
>
>> On 23=2E 02=2E 25, 17:42, Kuan-Wei Chiu wrote:
>> > Several parts of the kernel open-code parity calculations using
>> > different methods=2E Add a generic parity64() helper implemented with=
 the
>> > same efficient approach as parity8()=2E
>> >=20
>> > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail=2Ecom>
>> > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail=2Ecom>
>> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail=2Ecom>
>> > ---
>> >   include/linux/bitops=2Eh | 22 ++++++++++++++++++++++
>> >   1 file changed, 22 insertions(+)
>> >=20
>> > diff --git a/include/linux/bitops=2Eh b/include/linux/bitops=2Eh
>> > index fb13dedad7aa=2E=2E67677057f5e2 100644
>> > --- a/include/linux/bitops=2Eh
>> > +++ b/include/linux/bitops=2Eh
>> > @@ -281,6 +281,28 @@ static inline int parity32(u32 val)
>> >   	return (0x6996 >> (val & 0xf)) & 1;
>> >   }
>> >  =20
>> > +/**
>> > + * parity64 - get the parity of an u64 value
>> > + * @value: the value to be examined
>> > + *
>> > + * Determine the parity of the u64 argument=2E
>> > + *
>> > + * Returns:
>> > + * 0 for even parity, 1 for odd parity
>> > + */
>> > +static inline int parity64(u64 val)
>> > +{
>> > +	/*
>> > +	 * One explanation of this algorithm:
>> > +	 * https://funloop=2Eorg/codex/problem/parity/README=2Ehtml
>> > +	 */
>> > +	val ^=3D val >> 32; =20
>>=20
>> Do we need all these implementations? Can't we simply use parity64() fo=
r=20
>> any 8, 16 and 32-bit values too? I=2Ee=2E have one parity()=2E
>
>I'm not sure you can guarantee that the compiler will optimise away
>the unnecessary operations=2E
>
>But:
>static inline int parity64(u64 val)
>{
>	return parity32(val ^ (val >> 32))
>}
>
>should be ok=2E
>It will also work on x86-32 where parity32() can just check the parity fl=
ag=2E
>Although you are unlikely to manage to use the the PF the xor sets=2E
>
>	David
>
>>=20
>> > +	val ^=3D val >> 16;
>> > +	val ^=3D val >> 8;
>> > +	val ^=3D val >> 4;
>> > +	return (0x6996 >> (val & 0xf)) & 1;
>> > +}
>> > +
>> >   /**
>> >    * __ffs64 - find first set bit in a 64 bit word
>> >    * @word: The 64 bit word =20
>>=20
>>=20
>

Sure you can; you do need an 8- and a 16-bit arch implementation though (t=
he 16 bit one being xor %rh,%rl)

