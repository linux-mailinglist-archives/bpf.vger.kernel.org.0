Return-Path: <bpf+bounces-55748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E755A8635A
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 18:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF918189F8C0
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 16:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826CE21D3FB;
	Fri, 11 Apr 2025 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVc59QP6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0EC1DE2DB;
	Fri, 11 Apr 2025 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389278; cv=none; b=XB330HtAdLO6RDBz87rDlJYK5FSdchBJ0CTg/bqzHTpmUiT/WwGaaUJ6XDnzC6bqbxDjmYf3+XLLD4LqMKVD79jx7btKjTX36et0zSo/22Gtf7wcFlbkQYbMZXx0SbIJKqD/booBu48awxB2ds/OTYVWTihqMwSJr7S+M0GjbIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389278; c=relaxed/simple;
	bh=TPsDNdO0J5tFY3gM6ug4IFFbTqGLVdNs3Fa7k4whx34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFNnwUi87wgH6V5KAHM03eH//r8Qjb5urhQvHuATDmqhMn3chA8qDb/LCfH1LxxLN1FTSVmxBDk0wGepHRbQKv/0Dyi9t4EL8vJEvGMJe1WtuDS7SDSbemWIFWH6IbJdAXc48X2XTP5QBrYo1p/AYt5AhCW9tgmnqr/A1pUdW0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVc59QP6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736c062b1f5so1937487b3a.0;
        Fri, 11 Apr 2025 09:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744389275; x=1744994075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i2OP7V+QE6E9gg3GbdLcYE8UHgSFfj9Jnjg73a7+53s=;
        b=gVc59QP68gF8RNguvnLf7TKxOBGzr11uH3fLOvbaypk4RDbI1QIl1E4bzXB3HdjwVx
         EV8Wf7D1EK9HPYtfSdq9Z+6ZGA9iw26/r8eft9zkFNrtFfFJRmz5K3UHaIO9SXz5XkyO
         NIpohQMHLrsnTCK5xkzF2swRkbhQXBwsjGpbZT2GsdSVebSPu7VjgtI73pqC4LM6e04o
         dkRo7uFs4Jr+G13i2PSY2r2+3LEW1RAstPvuUKg07s7wUR5Bxc8parJ6drQ5MEChbcr1
         Dfk/Mhd/nPLnT+yVPVdZW1cs6BU9M8qlUO46z5bm3mo/xkwMmokmmgzb3p4iIrXDSS7U
         jPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744389275; x=1744994075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2OP7V+QE6E9gg3GbdLcYE8UHgSFfj9Jnjg73a7+53s=;
        b=BCb9oXPoz9pR/aDamY9cPBXQWw5/SlfEJ7MZjCMkc4lr4HCMsi/Kv9X2POmlQOjJ/b
         PhPZjdJFmtrEN3Ni0/Cri6P+fHZQkpwp3/rJnrGeiQK/bA/oPJuPGjPZ/e8AsLgwf4Gw
         Tv8J3XYpcFhwIUX8bQfJP0daL7OR+CQYWPpuatT0Q9ju8Ntqum7j66B0gja+gzPE5vls
         ID2cwt0KLmR85UiMtxK3ANawackkwdWrDdakUVkVB67LhGcn8XoFz1sddnw+jshwhOca
         Ttw1QW4ETrn74JgkDPSvMJjWyZD8pfvkFvk0D7fEP+4yqFSt7RTC7mkQ6Qen97ch4eWN
         3i6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUI/KgDsiA7f1xI/TLG89EhaMlm5LSvw1r3eptdg9GmswiQsTyJeu/k2jthm0eL2GUz4mz0vM9vspaw/xtu@vger.kernel.org, AJvYcCVYW1IVwPrSoAKWxWsB/nCClGs8N9UipmpsxTiAaw3uokVL58SzQDieLAq3cP1NlgI8/Y3OEcm5@vger.kernel.org, AJvYcCVaZTs7YG2x09BmjaeTk0Tq3LlAYSsnwCnREYML77r8kion6DO6CnXNOMmYzmOlEnKZuNf2/Gfm33ZlIUgN@vger.kernel.org, AJvYcCVuQsZ9R0Lw8PzgERdOAv4+Ih8vPHkyiCBisJlWmYUbAIDCVmUu0nWaJHy2cm4b42Q6CfIl6NT1rKlO2OI=@vger.kernel.org, AJvYcCWaOeSbAsVTtan1M6+6LyANIRi9uQeyLPjsohdKVDzbw4kg4dAy3C0BO5rHzsLifrQ/ZqI=@vger.kernel.org, AJvYcCXM4ju2CzYOvAiZ5MVTwns1PhkCGYB3TyKeBQmf7lA6M2EZ/ySd+C6Y12YIB27QXOwoDGZ49AvfsAp1nQA=@vger.kernel.org, AJvYcCXhou8VB7YSa8JszAHGL2KihBSBJ2dRM5OvRiCXxLzITQuTJDCIBogQqRycazOjOh66Bvb8ukZT8F2K6tyNyUE=@vger.kernel.org, AJvYcCXzp8Hc1t3QFwawh4FjZ0ynBUCTmASriqXeohL5gT9ywOUcuE/gTf29Kh13BklxOdmDcaVP3NtLXAJ/ZVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAuY+DxJFbyJwgkSdLPfqqF8OoEzszrXJCdRVpRznz4lPwgmhY
	30ezz7BWFBeGcRAtiodZsrke2DJa9PM4vO50s37L3hldJaqb7dM1
X-Gm-Gg: ASbGncvNFPpbRKPjaHvwHoLKT2muKrx87qlxKwy+B8tkix1lBUeFzHM/qB99Vv0Xlic
	Kk+sTDI1Tlet7lbNCgKN6AISzVwIrD81z8pZ4wJhNg0MZ/W5ORObt/Gnkvk49v8U2WkMQfEHDLZ
	MpTDls94znAlJ4U51/S6js9j/KNkVI3xGWw+kIFkdU3Fp15BqKaD+F0uq7X4FRV+sJXHGH/RSr0
	1ojYoMap8bf7wG4YimOO6GJGiPCnxoRQTOw2et1BUraXTdGS/DD+CleHmWnmg9gUiaVrpJiCtTn
	BdUPJqzM+P3v8i8o1BF9wlLaG4OWIZmadoKkiib2+3qA+LR+SyA1HJEXaPiPPP3f70Lz1MMtHK4
	lvuU=
X-Google-Smtp-Source: AGHT+IEYqWSvO9nmRhuvu9Nod5I62ZHK0q1nd8Adc2Nrxqu798p8njg5jLN2TKIb2S4uFWzFr2oiJA==
X-Received: by 2002:a05:6a20:d503:b0:1f5:902e:1e97 with SMTP id adf61e73a8af0-2017998c2d3mr6583017637.41.1744389275369;
        Fri, 11 Apr 2025 09:34:35 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b06161333a8sm258713a12.7.2025.04.11.09.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 09:34:34 -0700 (PDT)
Date: Sat, 12 Apr 2025 00:34:24 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
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
	linux@roeck-us.net, alexandre.belloni@bootlin.com, pgaj@cadence.com,
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
Subject: Re: [PATCH v4 00/13] Introduce parity_odd() and refactor redundant
 parity code
Message-ID: <Z/lEkDwefWvw4ZA3@visitorckw-System-Product-Name>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <Z_amQp3gK5Dm8Qz3@yury>
 <Z/a5Qh/OeLT8JBS4@visitorckw-System-Product-Name>
 <Z_a9YpE46Xf8581l@yury>
 <e97a83a2-dabd-4dc3-b69a-840ca17d70b5@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e97a83a2-dabd-4dc3-b69a-840ca17d70b5@zytor.com>

On Wed, Apr 09, 2025 at 07:09:28PM -0700, H. Peter Anvin wrote:
> On 4/9/25 11:33, Yury Norov wrote:
> > > > 
> > > I don't have a strong preference for the name, but if I had to guess
> > > the return value from the function prototype, I would intuitively
> > > expect an int to return "0 for even and 1 for odd," and a bool to
> > > return "true for even, false for odd." I recall Jiri and Jacob shared
> > > similar thoughts, which is why I felt adding _odd could provide better
> > > clarity.
> > 
> > I think they said they are convinced that parity should return 1 for
> > odd because of folding and __builtin_parity() arguments.
> > 
> 
> And for bool, 0 == false, and 1 == true. In fact, the *definitions* for
> false and true in C (but not C++) is:
> 
> <stdbool.h>:
> typedef _Bool bool;
> #define false	0
> #define true	1
> 
> If someone wants to make more clear, it would be better to put "typedef bool
> bit_t" in a common header, but that personally seems ridiculous to me.
>   >>>> type from u8 to u64 for broader applicability, and updates its return
> > > > > type from int to bool to make its usage and return semantics more
> > > > > intuitive-returning true for odd parity and false for even parity. It
> > > > > also adds __attribute_const__ to enable compiler optimizations.
> > > > 
> > > > That's correct and nice, but can you support it with a bloat-o-meter's
> > > > before/after and/or asm snippets? I also think it worth to be a separate
> > > > patch, preferably the last patch in the series.
> > > > 
> > > I quickly tested it with the x86 defconfig, and it appears that the
> > > generated code doesn't change. I forgot who requested the addition
> > > during the review process, but I initially thought it would either
> > > improve the generated code or leave it unchanged without significantly
> > > increasing the source code size.
> > 
> > That's what I actually expected, but was shy to guess openly. :). It's
> > hard to imagine how compiler may improve code generation in this case...
> > 
> > This attribute is used when there's an asm block, or some non-trivial
> > function call. In this case, the function is self-consistent and makes
> > no calls. And you see, const annotation raises more questions than
> > solves problems. Let's drop it.
> 
> Ah yes; one of the quirks about gcc asm is that an asm is implicitly assumed
> "const" (with no memory operands) or "pure" (with memory operands) unless
> declared volatile or given an explicit "memory" clobber.
> 
> So yes, the compiler can most definitely derive the constness from the form
> of the function even in the variable case.
> 
> I would still like to see __builtin_parity() being used as an architecture
> opt-in; it can, of course, also be unconditionally used in the constant
> case.
> 
> So in the end one of these two become my preferred implementation, and I
> really don't think it is very complicated:
> 
> #ifndef use_builtin_parity
> #define use_builtin_parity(x) __builtin_constant_p(x)
> #endif
> 
> static inline bool parity8(u8 val)
> {
> 	if (use_builtin_parity(val))
> 		return __builtin_parity(val);
> 	val ^= val >> 4;
> 	return (0x6996 >> (val & 0xf)) & 1;
> }
> 
> static inline bool parity16(u16 val)
> {
> 	if (use_builtin_parity(val))
> 		return __builtin_parity(val);
> 	return parity8(val ^ (val >> 8));
> }
> 
> static inline bool parity32(u32 val)
> {
> 	if (use_builtin_parity(val))
> 		return __builtin_parity(val);
> 	return parity16(val ^ (val >> 16));
> }
> 
> static inline bool parity64(u64 val)
> {
> 	if (use_builtin_parity(val))
> 		return __builtin_parityll(val);
> 	return parity32(val ^ (val >> 32));
> }
> 
> This means that an architecture -- in particular, x86 -- can still ask to
> use __builtin_parity*() directly. It means that architectures on which
> __builtin_parity*() produces bad code should either complain to the
> gcc/clang team and have it fixed, or we can add additional mechanism for
> them to override the implementation at that time.
> 
> The alternative is to stop worrying about overengineering, and just do it
> once and for all:
> 
> #ifndef parity8
> static inline bool parity8(u8 val)
> {
> 	val ^= val >> 4;
> 	return (0x6996 >> (val & 0xf)) & 1;
> }
> #endif
> 
> #ifndef parity16
> static inline bool parity16(u16 val)
> {
> 	return parity8(val ^ (val >> 8));
> }
> #endif
> 
> #ifndef parity32
> static inline bool parity32(u32 val)
> {
> 	return parity16(val ^ (val >> 16));
> }
> #endif
> 
> #ifndef parity64
> static inline bool parity64(u64 val)
> {
> 	return parity32(val ^ (val >> 32));
> }
> #endif
> 
> In either case, instead of packing the cascade into one function, make good
> use of it.
> 
> In the latter case, __builtin_constant_p() isn't necessary as it puts the
> onus on the architecture to separate out const and non-const cases, if it
> matters -- which it doesn't if the architecture simply wants to use
> __builtin_parity:
> 
> #define parity8(x)  ((bool) __builtin_parity((u8)(x)))
> #define parity16(x) ((bool) __builtin_parity((u16)(x)))
> #define parity32(x) ((bool) __builtin_parity((u32)(x)))
> #define parity64(x) ((bool) __builtin_parityll((u64)(x)))
> 
> As stated before, I don't really see that the parity function itself would
> be very suitable for a generic helper, but if it were to, then using the
> "standard" macro construct for it would seem to be the better option.
> 
> (And I would be very much in favor of not open-coding the helper everywhere
> but to macroize it; effectively creating a C++ template equivalent. It is
> out of scope for this project, though.)
> 
IIUC, you prefer using the parity8/16/32/64() interface with
__builtin_parity(), regardless of whether there are users on the hot
path?

If the maintainer has no concerns about maintenance burden, I also lean
toward this interface. While I don't think the implementation is
particularly complex, I'm not the maintainer, so I'd rather not argue
about the maintenance aspect. Also, to be clear, I don't think I'm the
right person to provide evidence that performance or code generation
matters to any user.

OTOH, If we do end up going with one of the two approaches, since
bitops.h is included (directly or indirectly) by many files while
parity is only used in fewer than 20, perhaps we should move the
parity-related code to a separate parity.h. It doesn't necessarily have
to be maintained by Yury - it could be someone else, or me.

Regards,
Kuan-Wei

