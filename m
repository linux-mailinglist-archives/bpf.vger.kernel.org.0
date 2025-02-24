Return-Path: <bpf+bounces-52342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949C7A42100
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D5A3B2622
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 13:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B1124889C;
	Mon, 24 Feb 2025 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3Vnd94C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DAD2192EB;
	Mon, 24 Feb 2025 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404079; cv=none; b=D61tis13biS1TpE05nLBy9dEs5CXrIiGtlZ+RB6lDOiF2t0HlGAzcvbeiVVGVU2CCGejA628nYJJoCFFlVCsg+DgkinHf+6Eq242eDtu/ECVSStIxb/bWA+3TiOtzpWs5P18PG4hHyS2UCzNFiPfVwVofqaAvl8cyBYdjw4eE2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404079; c=relaxed/simple;
	bh=qKTv7i9UlJGQGohAN6G2hXNKurAdQm5fSABB4QmmjxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IF/24xrDwahvUNO1mHuVVWMecjjBORmBCjLZDpM31m0nWcmBV830caIJ574+HABb1v/h8zQ77R9BL7/g2uCT3iSlYmAXV2ClBVyWY7BDzKEj2mm8AVb9cMAiv6kWSU0GRsIBjrDkFIPaO80o5yqfx7wB40gpv3YvbT5BraGuCjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3Vnd94C; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso2261532f8f.3;
        Mon, 24 Feb 2025 05:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740404076; x=1741008876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAg+3nWpCX28gp0yop3cTi7eprtgpHgYieQoEXp/Zxw=;
        b=b3Vnd94Czp22iPPbmF1QjAipNC/mjrMwD0kY/y1TN9tkLtO545t+gXG6bkecLBW3YV
         X+oDZlaP6Xl5R6b9DWG903WYIw1CPl7l+TSzM2uisR+yNB1iP0PQAQRJoMU6B0nN2HKH
         J/tfQ0el5pOnj1G4UCDCOkHar23j3z5sVjZixuZSQWPMeSJENfAsLuygifsEUxD5YlQH
         srNUC+fEpKmlLEQXS5vTZEZU/jHvyShwtg9j124Gs2uSpmtCoR8SpxtOlFF+007WZAK9
         uqC2ygnjY/ZG8hz7N6Ch4yi2gor/VV8T6e3tJv+Ph2J6mxXIuewSWzdoTEL/7nl5M0Uq
         ugag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740404076; x=1741008876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAg+3nWpCX28gp0yop3cTi7eprtgpHgYieQoEXp/Zxw=;
        b=e7cKMhGpwcE+ZC+iJioT9judghM38yENB+tI2zRs0ywJ3yVuoZuDsZhlneRho6Q7wz
         8+5CzdPPWjVby35SJNAu0BPMqQfVDZtfqFsRp83AyqJxdQK9V9S6vjR8TNWfJTa4MlWS
         Vtuq2g3gcybgQcFWQbvMJGrUkvEMQZP5Mb7+G/QXdrlIwDX7wvlwYgYYjZy4HGoe+jHq
         PGwq2f8c6aayDJaHS9D3arcZ/M9sSBVOPjrqasPHn1moGV5pDINkF8I1l4KbM8a6KLat
         AeMSb9hMYGgekWt0E/V7Zu62Pk2vpoV6Fqv4B4jc5Udj3eNQ5u1lhFdzQtiRocXqJr3l
         NF9w==
X-Forwarded-Encrypted: i=1; AJvYcCUSZHMamAxdObwlu+553UP0KoAx7qxf2HCtPF3WXXIlucsY75TLUYwIradYXlznVATN5TPKJIfX@vger.kernel.org, AJvYcCUVUpYCVCWR5y0LWZKmtP5yLuJ6FOk8M7kpqlJ1sU6TLR7c/i/sMs25qKXmOS/OeqqBrSwEpxVmGHoeYCY=@vger.kernel.org, AJvYcCV0WvZdj+PhPEl3168XSO0ERTZLZLmi3jK8JH7N+QRlA3xQUSVI3OmU+1bbuQ/5VzgPFZDTt4mJhStelrc=@vger.kernel.org, AJvYcCVTiw83QFXvut+KB0EEZ+ElPZk/tPiCeUrOlgW9jIj2hBTCHiF0nIyte3DuZcS0fCQzCz5ssXZmK+Z5CyCQ@vger.kernel.org, AJvYcCVtZPuaHfEcTEKkKI+0jQyDK1Bkg/GHrJ/S1EyBY1oLRDN0e5BQ+Bq6EAawWjUGmygPDBjlUgY+M3rBYtnduDs=@vger.kernel.org, AJvYcCWS6FaGPdavjkXGQIo5JeOxFxiY1a1T5Iy3MWlRjDitY/fkalmRDKfQI8OUONbyoN8Xn5eZyhadjnC1YGFm@vger.kernel.org, AJvYcCWj5D78JXhBDANAVeQrJgSmEEO72bhG2TYl3JM6RrySaED8574udSkyVliMu/gbFG/y2vA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx60hqBGYKOnp+F+DK9f19+6OCEDNpvBy0vFBmyujKLHd/mJIUV
	WmOf7Ll7qSQ0ZScbclUcclZxPEaHOo09G+Ivnsnwhs7iCrMklbxy
X-Gm-Gg: ASbGncvya1YKaExg/UFr4ZM/sC2A6TyckrL/HnHbyqjZw4h5Wd1D+RB/81+LoEt/Cx/
	h0GaoqsxIff7GsoN6L/ijoiZ88O27GFaAfJUsXA0fhSa9a2mFfnVFYDDQmlyOcAPWlZvyREd9Po
	jfp9+NIC0biKjrHBJG6fmFWALDdGgQCmCSL3YDJuucg8JJIf5HRJ+dURKfAs0tjDPqdfz9u/+2o
	eybWR5zEeZ3KhLcUiJLzgWOjXqP4Fno8gVFlzYq8ueXuhpvYu+3lLq/NpXdku3Wm4xMPI3jayZ4
	nxiB9KnCHvy+Z4eKjZo8wCBo/pV1Osha5t89Q6x86d9oo4p4YkRSKzK4PZtkRZ4T
X-Google-Smtp-Source: AGHT+IHAk3Wvwyk1vqkRenvO3RPC8nmIGBVFBN9gj/vKmwdIoVhq2/WUUPGNh8lDJR1/QVDS5j7zIQ==
X-Received: by 2002:a05:6000:144a:b0:38f:4d40:358 with SMTP id ffacd0b85a97d-38f6e7587c5mr11099286f8f.9.1740404075459;
        Mon, 24 Feb 2025 05:34:35 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f74817cbdsm9492882f8f.68.2025.02.24.05.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 05:34:35 -0800 (PST)
Date: Mon, 24 Feb 2025 13:34:31 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>
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
 yury.norov@gmail.com, akpm@linux-foundation.org, hpa@zytor.com,
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
Message-ID: <20250224133431.2c38213f@pumpkin>
In-Reply-To: <bde62fee-4617-4db7-b92c-59fb958c4ca6@kernel.org>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
	<20250223164217.2139331-3-visitorckw@gmail.com>
	<bde62fee-4617-4db7-b92c-59fb958c4ca6@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 08:09:43 +0100
Jiri Slaby <jirislaby@kernel.org> wrote:

> On 23. 02. 25, 17:42, Kuan-Wei Chiu wrote:
> > Several parts of the kernel open-code parity calculations using
> > different methods. Add a generic parity64() helper implemented with the
> > same efficient approach as parity8().
> > 
> > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> >   include/linux/bitops.h | 22 ++++++++++++++++++++++
> >   1 file changed, 22 insertions(+)
> > 
> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > index fb13dedad7aa..67677057f5e2 100644
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -281,6 +281,28 @@ static inline int parity32(u32 val)
> >   	return (0x6996 >> (val & 0xf)) & 1;
> >   }
> >   
> > +/**
> > + * parity64 - get the parity of an u64 value
> > + * @value: the value to be examined
> > + *
> > + * Determine the parity of the u64 argument.
> > + *
> > + * Returns:
> > + * 0 for even parity, 1 for odd parity
> > + */
> > +static inline int parity64(u64 val)
> > +{
> > +	/*
> > +	 * One explanation of this algorithm:
> > +	 * https://funloop.org/codex/problem/parity/README.html
> > +	 */
> > +	val ^= val >> 32;  
> 
> Do we need all these implementations? Can't we simply use parity64() for 
> any 8, 16 and 32-bit values too? I.e. have one parity().

I'm not sure you can guarantee that the compiler will optimise away
the unnecessary operations.

But:
static inline int parity64(u64 val)
{
	return parity32(val ^ (val >> 32))
}

should be ok.
It will also work on x86-32 where parity32() can just check the parity flag.
Although you are unlikely to manage to use the the PF the xor sets.

	David

> 
> > +	val ^= val >> 16;
> > +	val ^= val >> 8;
> > +	val ^= val >> 4;
> > +	return (0x6996 >> (val & 0xf)) & 1;
> > +}
> > +
> >   /**
> >    * __ffs64 - find first set bit in a 64 bit word
> >    * @word: The 64 bit word  
> 
> 


