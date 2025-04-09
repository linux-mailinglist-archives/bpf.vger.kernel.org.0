Return-Path: <bpf+bounces-55581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D310A8305A
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 21:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BCA1B668CB
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 19:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E7C1E5207;
	Wed,  9 Apr 2025 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3sPKuA3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5841DFDB8;
	Wed,  9 Apr 2025 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226495; cv=none; b=GUY112XvahcANclonCFVHctAQDgKyBmlpt2Wm+PsJUNWCQ1LF2KfWQpYXldlFMtKJiXBKaY2WwPplQrp+DwY3c1TAmaU0ENRWT+5045ikyvl/mh22rHfdV0P6sCbpiH5oZp3QroT59BYbTyiHAi5WbdbGdQD5wpZRuZXKthmh5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226495; c=relaxed/simple;
	bh=Hin3jaoZD2UKks89Cwi9KM4qtpbZXTlLg+tKDL12RxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2Kw7u+gzpfHQG0cYD7i/+CriBUa/Lng+16oIWhLN1nYxSyew52h/fk1pWAEHGhdOWrucRs2jq+qr4csWqHY96I+i4hKubcNOzsCvkxyWrRQQ/6hTfHVKvUl7Bkrq8DSN6A9j4PeviVC2qqosKsgnRJTL2209uvI7wW8cQ6sIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3sPKuA3; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736b0c68092so6023092b3a.0;
        Wed, 09 Apr 2025 12:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744226493; x=1744831293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+fSnm+LAeRoIOsICdxC6XJUJVWVyIvXXXOFvA8oRabs=;
        b=j3sPKuA3dp323p5m7tCsJu6KS0+ukLTzkbLwvbJt+SIzLJIM8xFy9lEPUaoeX/A3Ff
         V2LysCyfefoeb17ECJVo3GqJX416if/Qj+1NcHZI/fVKDUGujoi9aJfCdzD0nhuTzp3B
         /2Q2cxfWzjRLo8Rflw3IjNbQfJfXF1F0UNGuVKplG4IzSEei/SfBTX2v9O9al6aEhXxK
         ccJsbOd0BhuidFdPOCvUg5zo0D+VmFlT6CpjlH+mii0vB+itYHA/StvsPWLOxP3t59nx
         PHw8aJ0ozBbs9jtS2GKTg9lqCuPNGWeTFgHIDiFrgCgBuRgX8ARxBNegytagkEGqpdiX
         qgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744226493; x=1744831293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fSnm+LAeRoIOsICdxC6XJUJVWVyIvXXXOFvA8oRabs=;
        b=S8pDzd/6gbbnIcEX6AgbjVSZ/+59P3NbTq807q5Z4nce5GlpXwuLX0h8X1YXnNVcdg
         5vxcSEF6JFcx/ToCM9gbrR6y3q/mDBodvXqg6nUt/xWmFQbH99j2/vYEIObzfB6Kdfr6
         murTm3aXwzT5P4RWnAbXZ/IwPk+w8KmHR6Obj/l09HR1NCrvX5O7DcFJpvvuLGvay3EG
         SvAL1CNgUa73kg0EHDBXn1EulaXQUr9OiwtnIOImhEiO0lowS2FdFkqwW5IMBOZCLD/g
         4oV/v2896AI7U8VDXcyFtUcBRef72psctu7bkWW2+op/fc3Uo904+qV38TbibgdV1B/6
         Yk3g==
X-Forwarded-Encrypted: i=1; AJvYcCUMYLNi19Bs+6cShiZH+Z+i9sIdfjjC8WXtwiZrT1mGRjOE3wYnuOud5bER0gc4rw7wdTVeIbCOxjUyN/U=@vger.kernel.org, AJvYcCUZzijAlzEin6mK+cSpFwSGEM5FSprnZgf+RpfRVc+I0FpYSXMH5futdadr6Rc4y6DvxUYnhHO4mJlZ1V5N@vger.kernel.org, AJvYcCUx10lTu9vhYe6vspQUeWitWxM3FUIAuI+ZA4GD8l+Kegb/T1U8/R+4YIkCEfbSIi4rABeb/ejBCopUl/ak1ao=@vger.kernel.org, AJvYcCVj9SzZsyVlwRkryPHKSoV10/QqHa45WBxHtIrfaJCbh+Ng+mBA2f9rlxYDPa1O85SHfuIXwV3v3HAdWMM=@vger.kernel.org, AJvYcCW8vfZHZmuOdICqExhIWxio/tN9zQxi7/qxFYJj+h4pfEq/z2S/WCTr8OKSZLEMRWsQFxkekVGe@vger.kernel.org, AJvYcCWueVuI5+7BJC0/ykpkWOFUHhWfQN5HdEQlCktjiyZYntVGY2emlrshGJQISbwjKkbRfP6GPmDFAxT0EQsm@vger.kernel.org, AJvYcCWxPWbjZ/31pilfge+MjwFUWq31YJu9hYjSx2zKbUBUZQWkSoMTMWvWmetFAniLKFBIhrA=@vger.kernel.org, AJvYcCXeRn4tp4Wejulgg6A8XHi8MCTP6NuleeALfno0HQHoh6YNRCZgPVvRBc5Si3gGWXQAQaMUTkQj0eBNvzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUj5WOO6UrNJZ7sjw+rSzCjLaeW7Af61TgzkUzLlbPd53Yme1z
	GmyKME+gqdtkF9jBUpBu9bLRru2R5Mgddve0n35L6Ap+FkWkKPes
X-Gm-Gg: ASbGncv0C3NjN5TNLd3E+2VC/taBdjFf+W4+Z/HP6ardZIfVrcrJ+StyW9cfAj5v2Yk
	7Q8tzzZ4Vu3XPBP9hLSC//lpMhlfqrvS5hZmK4nAAZpGWSFri8CiEOiAHDq0N/s1zLZov9iLYrG
	KJr4wZfjNEzSFbRiXxQoFZ12rUSncJoe2AMUSdKCVrBGYi5EI6zTB2xDIAONTg65OW2OYbVjzyY
	g6HMpDW5oy5qJ4v9Yq9Mw2EWLgjL792mWN+0JTa3yG4KJ7x9/XId3ynTJWuEdxU93bGzOkt5bJ8
	6KN20HnKk121WNG/rVxzmSTQmz1rufdIeTZi21oG2xynnXZ9LTZDq6FG7+TApd/55QIe
X-Google-Smtp-Source: AGHT+IHAXQm8yqDVRx3hUkKcG0uQQDMrqQOD2SeunqXbiHMcL37CayQuCVkU18t9V7SBUxyy5kmIoQ==
X-Received: by 2002:a05:6a20:9c89:b0:1f5:873b:3d32 with SMTP id adf61e73a8af0-201695fb36dmr272504637.39.1744226492588;
        Wed, 09 Apr 2025 12:21:32 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e69376sm1726443b3a.165.2025.04.09.12.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 12:21:32 -0700 (PDT)
Date: Thu, 10 Apr 2025 03:21:21 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, Yury Norov <yury.norov@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	jk@ozlabs.org, joel@jms.id.au, eajames@linux.ibm.com,
	andrzej.hajda@intel.com, neil.armstrong@linaro.org,
	rfoss@kernel.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, dmitry.torokhov@gmail.com, mchehab@kernel.org,
	awalls@md.metrocast.net, hverkuil@xs4all.nl,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	louis.peens@corigine.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
	johannes@sipsolutions.net, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, akpm@linux-foundation.org, jdelvare@suse.com,
	alexandre.belloni@bootlin.com, pgaj@cadence.com, hpa@zytor.com,
	alistair@popple.id.au, linux@rasmusvillemoes.dk,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw, Frank.Li@nxp.com,
	linux-hwmon@vger.kernel.org, linux-i3c@lists.infradead.org,
	david.laight.linux@gmail.com, andrew.cooper3@citrix.com,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v4 01/13] bitops: Change parity8() to parity_odd() with
 u64 input and bool return type
Message-ID: <Z/bIsT7RT1C7rGYC@visitorckw-System-Product-Name>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <20250409154356.423512-2-visitorckw@gmail.com>
 <Z_anYpZw_E8ehN21@yury>
 <Z/a7t1yATUXn11vD@visitorckw-System-Product-Name>
 <315b4c75-a596-4509-99f7-921ebda2fed9@roeck-us.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315b4c75-a596-4509-99f7-921ebda2fed9@roeck-us.net>

On Wed, Apr 09, 2025 at 11:39:22AM -0700, Guenter Roeck wrote:
> On 4/9/25 11:25, Kuan-Wei Chiu wrote:
> > On Wed, Apr 09, 2025 at 12:59:14PM -0400, Yury Norov wrote:
> > > On Wed, Apr 09, 2025 at 11:43:44PM +0800, Kuan-Wei Chiu wrote:
> > > > Redesign the parity8() helper as parity_odd(), changing its input type
> > > > from u8 to u64 to support broader use cases and its return type from
> > > > int to bool to clearly reflect the function's binary output. The
> > > > function now returns true for odd parity and false for even parity,
> > > > making its behavior more intuitive based on the name.
> > > > 
> > > > Also mark the function with __attribute_const__ to enable better
> > > > compiler optimization, as the result depends solely on its input and
> > > > has no side effects.
> > > > 
> > > > While more efficient implementations may exist, further optimization is
> > > > postponed until a use case in performance-critical paths arises.
> > > > 
> > > > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > ---
> > > >   arch/x86/kernel/bootflag.c               |  4 ++--
> > > >   drivers/hwmon/spd5118.c                  |  2 +-
> > > >   drivers/i3c/master/dw-i3c-master.c       |  2 +-
> > > >   drivers/i3c/master/i3c-master-cdns.c     |  2 +-
> > > >   drivers/i3c/master/mipi-i3c-hci/dat_v1.c |  2 +-
> > > >   include/linux/bitops.h                   | 19 ++++++++++++-------
> > > >   6 files changed, 18 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/kernel/bootflag.c b/arch/x86/kernel/bootflag.c
> > > > index 73274d76ce16..86aae4b2bfd5 100644
> > > > --- a/arch/x86/kernel/bootflag.c
> > > > +++ b/arch/x86/kernel/bootflag.c
> > > > @@ -26,7 +26,7 @@ static void __init sbf_write(u8 v)
> > > >   	unsigned long flags;
> > > >   	if (sbf_port != -1) {
> > > > -		if (!parity8(v))
> > > > +		if (!parity_odd(v))
> 
> What is the benefit of this change all over the place instead of
> adding parity_odd() as new API and keeping the old one (just letting
> it call the new API) ?
> 
> A simple
> 
> static inline int parity8(u8 val)
> {
> 	return parity_odd(val);
> }
> 
> would have done the trick and be much less invasive.
> 
Yury has previously mentioned that adding multiple fixed-type parity
functions increases his maintenance burden. IIUC, he prefers having a
single interface in bitops.h rather than multiple ones.

He were reluctant to add three more functions like:

static inline bool parity16(u16 val)
{
    return parity8(val ^ (val >> 8));
}

static inline bool parity32(u32 val)
{
    return parity16(val ^ (val >> 16));
}

static inline bool parity64(u64 val)
{
    return parity32(val ^ (val >> 32));
}

But instead, we ended up with:

static inline bool parity(u64 val)
{
    val ^= val >> 32;
	val ^= val >> 16;
	val ^= val >> 8;
	val ^= val >> 4;
	return (0x6996 >> (val & 0xf)) & 1;
}

static inline bool parity8(u8 val)
{
    return parity_odd(val);
}

But in the end, we introduced both parity(u64) and parity8(u8), which,
IMHO, might be even more confusing than having consistent fixed-type
helpers.

Regards,
Kuan-Wei


