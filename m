Return-Path: <bpf+bounces-53615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4177A572C3
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 21:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0684C169D56
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 20:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E092C2561DF;
	Fri,  7 Mar 2025 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="F3IB7iSH"
X-Original-To: bpf@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67DB21CC4A;
	Fri,  7 Mar 2025 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378242; cv=none; b=K1A9j0EshKLQ444Ixh8DKgK4tyaZv4W/gv27o/h+5mgeWo5mgFxyHLYBECwBGqCcgKQEePCfQLirRjyoWtQFHzBXrUUyOLCVatPCJRP33I2MOTw8j8oyDHRNIo69nAeqrEYCSPYcDNql029GPzqBJsJTv5H9FiPaJS/bpD/A0iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378242; c=relaxed/simple;
	bh=z8uaY0FEvDXDyRuTUQIK7YT1It04TyjrpCzzUcauDks=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ERIyRtVGRBShXTUMW6BKbqqehzHe1KYqPk1mBjSQNNUzdsdJxEBLbf7fq1ov6OoXUfD3H1YdMU5YP2EOCBmOm3v+86Rnz0VWihYlxsbfXXSsBVJMgOEwhjQZs3lxnDw30uaPkv8VzTBbzAdJ5wFxIWuteewQv5QFfxTebvQ5W6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=F3IB7iSH; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPv6:::1] ([172.56.209.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 527K79aI409264
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 7 Mar 2025 12:07:10 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 527K79aI409264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741378034;
	bh=labYh6dS183ez/ccMGDewAeypbKIJUEZ63NUVodYP9Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=F3IB7iSHYEvDT6RxcaTUE+HY1uOaC4VnUwxKdSJcbsJ/VGwP8hnKFJom4bWfM8OtP
	 AchryuBqXBGLSXDbZ+MsV5uKdxioAoL64EB2Hr82VgdPIiuWZvSICUQIsfj5WGpBgd
	 KriIaJc3fhV0nS1OF/J9ovKepTrInAm9zRKeY8fu9KnjjC1cA61PvXNcMr8KPpE2Si
	 6ZtEA98YPUR4DMGJMmEfr7slViCtz+0KmVEla3+d3bqWKNRc+yfSLHHLIoMfgw95oG
	 SN+4dF7fYBU8DZVgqTjvri3AONNiYtVQqGQhFLjE5E+swQ4mWdQWMCk66SRGgQ/FHU
	 OiSkGpohg9mHw==
Date: Fri, 07 Mar 2025 12:07:02 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Laight <david.laight.linux@gmail.com>
CC: Andrew Cooper <andrew.cooper3@citrix.com>,
        Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
        akpm@linux-foundation.org, alistair@popple.id.au,
        andrew+netdev@lunn.ch, andrzej.hajda@intel.com,
        arend.vanspriel@broadcom.com, awalls@md.metrocast.net, bp@alien8.de,
        bpf@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        brcm80211@lists.linux.dev, dave.hansen@linux.intel.com,
        davem@davemloft.net, dmitry.torokhov@gmail.com,
        dri-devel@lists.freedesktop.org, eajames@linux.ibm.com,
        edumazet@google.com, eleanor15x@gmail.com, gregkh@linuxfoundation.org,
        hverkuil@xs4all.nl, jernej.skrabec@gmail.com, jirislaby@kernel.org,
        jk@ozlabs.org, joel@jms.id.au, johannes@sipsolutions.net,
        jonas@kwiboo.se, jserv@ccns.ncku.edu.tw, kuba@kernel.org,
        linux-fsi@lists.ozlabs.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux@rasmusvillemoes.dk,
        louis.peens@corigine.com, maarten.lankhorst@linux.intel.com,
        mchehab@kernel.org, mingo@redhat.com, miquel.raynal@bootlin.com,
        mripard@kernel.org, neil.armstrong@linaro.org, netdev@vger.kernel.org,
        oss-drivers@corigine.com, pabeni@redhat.com,
        parthiban.veerasooran@microchip.com, rfoss@kernel.org, richard@nod.at,
        simona@ffwll.ch, tglx@linutronix.de, tzimmermann@suse.de,
        vigneshr@ti.com, visitorckw@gmail.com, x86@kernel.org,
        yury.norov@gmail.com
Subject: Re: [PATCH v3 00/16] Introduce and use generic parity16/32/64 helper
User-Agent: K-9 Mail for Android
In-Reply-To: <20250307195310.58abff8c@pumpkin>
References: <4732F6F6-1D41-4E3F-BE24-E54489BC699C@zytor.com> <efc2ee9d-5382-457f-b471-f3c44b81a190@citrix.com> <5A790652-1B22-4D13-AAC5-5D9931E90903@zytor.com> <20250307195310.58abff8c@pumpkin>
Message-ID: <EB85C3C1-8A0D-4CB9-B501-BFEABDF3E977@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 7, 2025 11:53:10 AM PST, David Laight <david=2Elaight=2Elinux@gmai=
l=2Ecom> wrote:
>On Fri, 07 Mar 2025 11:30:35 -0800
>"H=2E Peter Anvin" <hpa@zytor=2Ecom> wrote:
>
>> On March 7, 2025 10:49:56 AM PST, Andrew Cooper <andrew=2Ecooper3@citri=
x=2Ecom> wrote:
>> >> (int)true most definitely is guaranteed to be 1=2E =20
>> >
>> >That's not technically correct any more=2E
>> >
>> >GCC has introduced hardened bools that intentionally have bit patterns
>> >other than 0 and 1=2E
>> >
>> >https://gcc=2Egnu=2Eorg/gcc-14/changes=2Ehtml
>> >
>> >~Andrew =20
>>=20
>> Bit patterns in memory maybe (not that I can see the Linux kernel using=
 them) but
>> for compiler-generated conversations that's still a given, or the manag=
er isn't C
>> or anything even remotely like it=2E
>>=20
>
>The whole idea of 'bool' is pretty much broken by design=2E
>The underlying problem is that values other than 'true' and 'false' can
>always get into 'bool' variables=2E
>
>Once that has happened it is all fubar=2E
>
>Trying to sanitise a value with (say):
>int f(bool v)
>{
>	return (int)v & 1;
>}   =20
>just doesn't work (see https://www=2Egodbolt=2Eorg/z/MEndP3q9j)
>
>I really don't see how using (say) 0xaa and 0x55 helps=2E
>What happens if the value is wrong? a trap or exception?, good luck recov=
ering
>from that=2E
>
>	David

Did you just discover GIGO?

