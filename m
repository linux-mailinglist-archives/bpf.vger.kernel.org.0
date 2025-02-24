Return-Path: <bpf+bounces-52387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADF2A428D5
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC423BF292
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 17:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7063A264A76;
	Mon, 24 Feb 2025 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEZhAAqz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10711266599;
	Mon, 24 Feb 2025 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416204; cv=none; b=DoUmvSGWWM3iYnbYAR9/EO1jLSJ0DIYvvQ9O9o7y4LpTo6mN05cMH5n86ufTjtTsFo73p53FKIeiRHmkQqHVg7uuPW+RS5ZGHao9uJqm1mrMoLYhJefKvCIqlJpWebd7n4oCfa2RaB+7Yuct/h679HdPR1O1KDL2dB69SJQG+L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416204; c=relaxed/simple;
	bh=5G5oGYh1CaRHc2d1pU1YAOARWQsm2s7Z+o+/b8xWRQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQbbtxpCnUwiFym8551S2GhQX4biMNstcQhnTeiQNkcLMDjOzhop9eZR8wupPaxtkz2/slpu8ZvKbZ9dMQqpuT1CcUF1neb/q47RL4WmHM1MpCRA8aG27TWLr7a7eujWPRuyYCqwMQGaEqAYAM4MSly4SUibo0iAXMfDBMXqEr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEZhAAqz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-221057b6ac4so89038365ad.2;
        Mon, 24 Feb 2025 08:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740416202; x=1741021002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uiOFRZn2H6lerxDkJoj1wxqiGhkAtJgTGIELTuQhums=;
        b=cEZhAAqzCsAWehsy2m8SvMlKBj6e4Rf3fkqkxHM+Euy8xATo2R35GQ0bt9RwE/fcFh
         y1uvBeeGvg0ujDplELvufLpbMYQwU/6n3mhQ8zPfGkDewFXyaD0l5IcoSZ1C2tfgLFk+
         d5CRXcmqVXitlh58Fn7FOwh2agJ10BJiSH9Qb2ZyO/cM9I6Hy/KuVAA0i0Wt9hNLixf5
         iZ4FjI8LjgsxGExu5FP5ZBJg9agTe0SElmgqHcM+rPKaYuEkfTyREygd4cMQ6CjO8dm6
         v4kKEz/L1B2mgK0vivaUclcfl5nqBBmNc110t13DKAB1O0TCJyY+bWT3n+VJkh80zm6k
         90vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416202; x=1741021002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiOFRZn2H6lerxDkJoj1wxqiGhkAtJgTGIELTuQhums=;
        b=l8f/NsfAuAR3PReXRRsuYVzQOHEv4/3KaZ5VT/jkV4SxrwPxHGcZpZyJRDV3kMHhZE
         kbhNUvrPGziCrWQKRPvLsVOVbONTyAULPWmZmXxxtu2JRzOqOJFv45nj3xAkV+SV6uDX
         TIJ3A5N63E219Q/djhRPDiugxyPbNMDMw6Kfx2uZIpY1ax6PxT04NnT2/IEJJZNIZyC4
         T4TxHmiCKSabZqQXDRUSFGf28DtOEq8v75FltwjAh6PFqTyVpOi9QjfN9xBM/b5HB+Ko
         gJP/O3xe7EZwjtPm71yQWTFka6+dJueoSX2fI/mWEeVv4SyyFXhBcgxrAruXxNWI3DN5
         paMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCgCbaBzq9fKe6FKJEYKAcFFTrnZx2udHzb0F0vYdJVmp1XYzhiuNM24084X/zy+rNSCKkmX8ywoe4lcU7@vger.kernel.org, AJvYcCUOVpPu6Lh3dBC5DqE79mqP3AhLLqDHhWoG/wcytDKp62p1pTpkIFHzHIn4hw6vfmuPw2L3vbR8MxkgK4IXIpQ=@vger.kernel.org, AJvYcCV6eaHqzGSYhiIyN9ZMKon+gXyFH/SV4278oVJcwgrEBHk38hhTaEQWWqJAb7DNAtb9545OWAKYkLIJ9LSi@vger.kernel.org, AJvYcCVIyEQUQD1rTXw+I4IgViyWIs0Wb0LLRTymfULJ13/d6lJsO6oWynO2v0CGiSEe0IEaaxM=@vger.kernel.org, AJvYcCVyt57IAKQv77uOT39maNHKVXX3xc34itm7bFrRG/zYsxVWoUfrI7nhoDdKBv43Qq7aQ7vmwDit38pVw+o=@vger.kernel.org, AJvYcCXeOGlUtvEujBwq+2eLJo6hRE396LATNA+O+tx4lN7LoJ8JEjV09KjJT55dqFjnCDOO1YcH/Mpf@vger.kernel.org, AJvYcCXfSi1yw1ly9s5TovwmcdXKdmtRSs+zzFvwOde9jNRkPd1UzflW8iBBDFMT9xu1cCD04HiF/gI7klADCLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK+XKClVqyfk/K9SEIcrKr77+7160Fj2D6o7Ap6NM3e1bASkue
	aHFVkF+dC7ukofjnyCpCBHUQfvfLcEl+w7RWF5CDE2ja3IzsJaWl
X-Gm-Gg: ASbGncsFufCa1KHv59coqIT4kIwy10FUKS6ZmnCe908AO0EJ37yK9zyRuEgAyySdz2T
	h6Xt2mOn/5JulXy7WVF7CqJoatb9DLvgjyRp1zWko2TV0IWNakC2r3gjgDglk+vhJaiLlrUylVA
	pRMhj1CSShhmtKyLG9zIZP+Xy+kaVyKukxZgSPvFRq+pkToykR2VaEResVv/JkyCLtSIV8+O4kB
	LFP61iGnavhcC9Go/Iy4OiWV/btY/HY5eOl1UnwQxirKwmq8qKKl//0y7k18Nqd0Yv6E84s0c9o
	IR4CmWWihJzkFYyd0n3bLBeabqw3
X-Google-Smtp-Source: AGHT+IFVgQBLmZYFNL+ZV4HrxXg4lZgXZnXGnGr0U7DF5esCoQcIST0NuWk3m7oQnTUJjc9HIW9Ozw==
X-Received: by 2002:a17:902:d492:b0:220:c63b:d93c with SMTP id d9443c01a7336-221a11b9493mr230835105ad.44.1740416201946;
        Mon, 24 Feb 2025 08:56:41 -0800 (PST)
Received: from eleanor-wkdl ([140.116.96.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534afadsm185140065ad.26.2025.02.24.08.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 08:56:41 -0800 (PST)
Date: Tue, 25 Feb 2025 00:56:29 +0800
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org,
	joel@jms.id.au, eajames@linux.ibm.com, andrzej.hajda@intel.com,
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
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 02/17] bitops: Add generic parity calculation for u64
Message-ID: <Z7ykvf1g03XDLXKc@eleanor-wkdl>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
 <20250223164217.2139331-3-visitorckw@gmail.com>
 <bde62fee-4617-4db7-b92c-59fb958c4ca6@kernel.org>
 <20250224133431.2c38213f@pumpkin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224133431.2c38213f@pumpkin>

On Mon, Feb 24, 2025 at 01:34:31PM +0000, David Laight wrote:
> On Mon, 24 Feb 2025 08:09:43 +0100
> Jiri Slaby <jirislaby@kernel.org> wrote:
> 
> > On 23. 02. 25, 17:42, Kuan-Wei Chiu wrote:
> > > Several parts of the kernel open-code parity calculations using
> > > different methods. Add a generic parity64() helper implemented with the
> > > same efficient approach as parity8().
> > > 
> > > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > ---
> > >   include/linux/bitops.h | 22 ++++++++++++++++++++++
> > >   1 file changed, 22 insertions(+)
> > > 
> > > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > > index fb13dedad7aa..67677057f5e2 100644
> > > --- a/include/linux/bitops.h
> > > +++ b/include/linux/bitops.h
> > > @@ -281,6 +281,28 @@ static inline int parity32(u32 val)
> > >   	return (0x6996 >> (val & 0xf)) & 1;
> > >   }
> > >   
> > > +/**
> > > + * parity64 - get the parity of an u64 value
> > > + * @value: the value to be examined
> > > + *
> > > + * Determine the parity of the u64 argument.
> > > + *
> > > + * Returns:
> > > + * 0 for even parity, 1 for odd parity
> > > + */
> > > +static inline int parity64(u64 val)
> > > +{
> > > +	/*
> > > +	 * One explanation of this algorithm:
> > > +	 * https://funloop.org/codex/problem/parity/README.html
> > > +	 */
> > > +	val ^= val >> 32;  
> > 
> > Do we need all these implementations? Can't we simply use parity64() for 
> > any 8, 16 and 32-bit values too? I.e. have one parity().
> 
> I'm not sure you can guarantee that the compiler will optimise away
> the unnecessary operations.

Hi Jiri and David,

Unless we can be certain about the compiler's optimization behavior, we
prefer to follow an approach similar to hweight, distinguishing
implementations based on different bit sizes.

> 
> But:
> static inline int parity64(u64 val)
> {
> 	return parity32(val ^ (val >> 32))
> }
> 
> should be ok.

We will adopt this approach, as it is indeed more concise.

Thank you all for your feedback.

Best regards,

Yu-Chun Lin

> It will also work on x86-32 where parity32() can just check the parity flag.
> Although you are unlikely to manage to use the the PF the xor sets.
> 
> 	David
> 
> > 
> > > +	val ^= val >> 16;
> > > +	val ^= val >> 8;
> > > +	val ^= val >> 4;
> > > +	return (0x6996 >> (val & 0xf)) & 1;
> > > +}
> > > +
> > >   /**
> > >    * __ffs64 - find first set bit in a 64 bit word
> > >    * @word: The 64 bit word  
> > 
> > 
> 

