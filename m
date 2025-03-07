Return-Path: <bpf+bounces-53607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445D5A57287
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 20:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B011755DF
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 19:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6958B253B43;
	Fri,  7 Mar 2025 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kb5jl3f7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540361A4F3C;
	Fri,  7 Mar 2025 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741377197; cv=none; b=DWrLWxwZQlqP0YMemrRUK85voiMjnbgac68d5dA6x57YT4QMiAKIU40gYuyHLqaUBpdKQiImKVr/SrA6XubUdzIbHBHYs4rgHPlECDwiERAvm6wBH1GrCrQ4fAsI4K1vq1Wi0lVSuX98AjTCdMKEH4EiJ1RA43AwiDOu5OTQnoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741377197; c=relaxed/simple;
	bh=LNHS/O5qk8V3R4mU1dNCTKTGoEiRwLqi9UP8XhBs1YI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8pErDizUMC8DDxjx4Mvsk30Onu2iDjel45rHtk+6pc6bRX2miV+LlZwuDTt1NKiQlOm6zXzRd1SxKN2jgNWmZvaXSFW4QZEU1A96K1cpudV9C10PX0sceaP4PCucNfg8eAcwYLDAYG62ByyLSg6L4uEqz7lRwSzGQRa2IxEgG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kb5jl3f7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-438a39e659cso13250065e9.2;
        Fri, 07 Mar 2025 11:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741377194; x=1741981994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFjCWoFVVseHqDKPyVju+l4iTZxEMM/BbzUS5g6rWQg=;
        b=kb5jl3f7XFMcjOTPKOzvk+iJs5Pb5+mKTp9Jyt2MyRfgGGfAPnW81BqWlx+n29EnB5
         HC/oHdZB9Keqf+rN1ACTB1pNTf37gWpfcE/7uaGzxifp5+50dXAxgk4ixrKutgx4o6Nz
         CP1wzm5+ZgkxGG5NGzUuW23jgf45WmG4AYyzPgvcJ1jf5cg1pTiwMk1LriCxGqXwKd6e
         PeExadqaVN57vYQdN21528j1nA+oa8FG5olSGGd+3GKsBR2Szwp+3eYZwJLbTdMtQqzR
         oTFtz/32/jj/VcQdaqr1S9xRaO3Kwj1SxoEDR5MmtpYBn49CMyz6l3c/xa30XNxceYbP
         ndvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741377194; x=1741981994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFjCWoFVVseHqDKPyVju+l4iTZxEMM/BbzUS5g6rWQg=;
        b=e4N/cFXpuy7TUqN1tFk+sYWwE9tza69iiCxt+FTi/ZuzVoU73cGRpolPwDdtRFn3P4
         YzSpLbxPjSKN0wgjyEcBruRpo42996EoXZKq5+t57XgRZ4zO5xSXY1VqDvjMjCTWCNvd
         Lt4xQQ/PAipcCs2vfb5WJeyzbPJkT9mb6lYrVpy8N9Fvwjx3NH8F2BzoEWdXnWYEEnkq
         nz9uGSC008nR3FjmMtWT/7kzuKKuZO+9wM//Zf/togdwxe6NU70uusFY3cuTgvuMltkj
         W4kLC9oC4p14c+fwfW7tpc1cIsfzvJeUo9q7w0CoogIWANX5dQ6TnuwVs+ZTps0gO60F
         WBRw==
X-Forwarded-Encrypted: i=1; AJvYcCV1KNS1Wfx5vnaVLLWgCA5a9GYPk1hEDwm6r6pqFHTQk+hMC8ziw+HrDCdRC7adBhmrdj0=@vger.kernel.org, AJvYcCV486pIEFjoKrrvnbJk6kZqOWGY2TEtfIhMlE04LoQEPOJiC8WKapWXCpmT2B8R3XDVzrWjg9wz1eHyHJHX@vger.kernel.org, AJvYcCVSWviZas7P2ndmQzi4ig4Xqul7atnTVgIAmK0EhfsXYIzh1pHLIxOqOk3ErKToQtRJ+xJPsfdOz1RjMIzAQd8=@vger.kernel.org, AJvYcCWb9966QWA7Mt1ol+84XzJyiy3IZ3ApsVkBQ0+gSHLHdFJ3HxZR2Sf9izxFnxyL65YEIhhmzxTlammMbpE=@vger.kernel.org, AJvYcCXa1zqEsfBnK6+tMru9h1ls8GgLtYzi/dBfnGJZk2JNVG/d8PKmiRw/2tHsGVELAfSVU4cEq0r6vh7i+cE=@vger.kernel.org, AJvYcCXcoIxzCONdTPmph2yADDUx/oIGOd5+BMeb+3983oxJWCOjmyRMcikQbPlujiag21i8WGQ7dzBH@vger.kernel.org, AJvYcCXeX1aGXcQWLcuQ/j34AlF3VAK+1yFECddR0b1Xq/Iw7clPhVxlA/i/sfT/pNS3s43K86SFPaIQ2azYr9+q@vger.kernel.org
X-Gm-Message-State: AOJu0YzCeDQ3XOefdeNwWOyWlt8WAGG2k0lZeOZ5qhkdsj9HSBm8hrpq
	tcON1DYFTyaqwrYn2iAJG5XfI+0Kz5PVgc5slaNvsHu2iqK8ABQE
X-Gm-Gg: ASbGncvB0+y8GWDg2jdy2TpXj+sxAopY3CYUSjtsMOa8SgqE/RoghUL+spc/DbkcBoO
	HfUM5kPWiaQJmRfM+qP/X/rWYoHeThQ62RSOkHeGDjbkGNI7YY5jnHslYZ0iph3Kq6eS9R93lOf
	rfkDzc8+lIX82i7Qy3E6mE8k5EDmQEOJqLtLqKIQ00I3bUy7B+mZ0+JYWz725/FxUa9P+CbcWib
	22QIoGKC8lewgbUMxLWFPcv+6rCpf+4fYpQmqQDj1b+tlEZlVHL9WnQklApDuY7KRcz7A4tA7H6
	Kkwrq1d4uhktFCWpVG81XjFTNFhyGfYCm6FwhhXxTY+ZzB4gnAeNCMHi/kms8R426sRB2hRQ/Ut
	05RaJTuw=
X-Google-Smtp-Source: AGHT+IFtUYsYiNnYKhfvrcaN1ioOhGevW7gRyAbgDR19AZMXszweQZgGUKeQX4mOm4dqyM9BgE29Gg==
X-Received: by 2002:a05:6000:18ab:b0:391:122c:8aa with SMTP id ffacd0b85a97d-39132d96079mr3226538f8f.30.1741377194381;
        Fri, 07 Mar 2025 11:53:14 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01d2cdsm6394936f8f.57.2025.03.07.11.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:53:13 -0800 (PST)
Date: Fri, 7 Mar 2025 19:53:10 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
 Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
 akpm@linux-foundation.org, alistair@popple.id.au, andrew+netdev@lunn.ch,
 andrzej.hajda@intel.com, arend.vanspriel@broadcom.com,
 awalls@md.metrocast.net, bp@alien8.de, bpf@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 dave.hansen@linux.intel.com, davem@davemloft.net,
 dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org,
 eajames@linux.ibm.com, edumazet@google.com, eleanor15x@gmail.com,
 gregkh@linuxfoundation.org, hverkuil@xs4all.nl, jernej.skrabec@gmail.com,
 jirislaby@kernel.org, jk@ozlabs.org, joel@jms.id.au,
 johannes@sipsolutions.net, jonas@kwiboo.se, jserv@ccns.ncku.edu.tw,
 kuba@kernel.org, linux-fsi@lists.ozlabs.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux@rasmusvillemoes.dk,
 louis.peens@corigine.com, maarten.lankhorst@linux.intel.com,
 mchehab@kernel.org, mingo@redhat.com, miquel.raynal@bootlin.com,
 mripard@kernel.org, neil.armstrong@linaro.org, netdev@vger.kernel.org,
 oss-drivers@corigine.com, pabeni@redhat.com,
 parthiban.veerasooran@microchip.com, rfoss@kernel.org, richard@nod.at,
 simona@ffwll.ch, tglx@linutronix.de, tzimmermann@suse.de, vigneshr@ti.com,
 visitorckw@gmail.com, x86@kernel.org, yury.norov@gmail.com
Subject: Re: [PATCH v3 00/16] Introduce and use generic parity16/32/64
 helper
Message-ID: <20250307195310.58abff8c@pumpkin>
In-Reply-To: <5A790652-1B22-4D13-AAC5-5D9931E90903@zytor.com>
References: <4732F6F6-1D41-4E3F-BE24-E54489BC699C@zytor.com>
	<efc2ee9d-5382-457f-b471-f3c44b81a190@citrix.com>
	<5A790652-1B22-4D13-AAC5-5D9931E90903@zytor.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Mar 2025 11:30:35 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> On March 7, 2025 10:49:56 AM PST, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> >> (int)true most definitely is guaranteed to be 1.  
> >
> >That's not technically correct any more.
> >
> >GCC has introduced hardened bools that intentionally have bit patterns
> >other than 0 and 1.
> >
> >https://gcc.gnu.org/gcc-14/changes.html
> >
> >~Andrew  
> 
> Bit patterns in memory maybe (not that I can see the Linux kernel using them) but
> for compiler-generated conversations that's still a given, or the manager isn't C
> or anything even remotely like it.
> 

The whole idea of 'bool' is pretty much broken by design.
The underlying problem is that values other than 'true' and 'false' can
always get into 'bool' variables.

Once that has happened it is all fubar.

Trying to sanitise a value with (say):
int f(bool v)
{
	return (int)v & 1;
}    
just doesn't work (see https://www.godbolt.org/z/MEndP3q9j)

I really don't see how using (say) 0xaa and 0x55 helps.
What happens if the value is wrong? a trap or exception?, good luck recovering
from that.

	David

