Return-Path: <bpf+bounces-53054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D96A4C085
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 13:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9088D1893F7A
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 12:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA28B20FA96;
	Mon,  3 Mar 2025 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCh0EpN5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AF51E5B78;
	Mon,  3 Mar 2025 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005694; cv=none; b=Dw0ibGYs2XtKDMioWiHlDZjEC5HIcQHs9h3zvZIkiWteCqdQ+f/06n0c/imzNfriB/ykPnWz0GRMJIOUYNq75ufyKFQ8xRa8miaTL7zGKvedw3Yst6hZqphfZfnBxuTgsihhVNmR7iEECvV41HPkGiaHH3CP/GN5vV1KzYlu/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005694; c=relaxed/simple;
	bh=tieKiWfa1sevnfvQv3qDEqr93B2c4NJALDpA5GWbCFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I9tw+JZF2rscdkWaVqj47IzotWLifJ5COseuJi0T2opfmhcM3jYrSjr16GW6NQbkBSl3rHxt4xyU3EMLYYzO6LJQ+P7Y8ahqqKSYuLnGvFOHxvFmqqfGeHYsL9RtLjIky4+/X0lwvAdr/EbBQn5vvF6DY0WToKUna7HiBjts2kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCh0EpN5; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e538388dd1so1593547a12.1;
        Mon, 03 Mar 2025 04:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741005691; x=1741610491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLW0AYaLwkO6JC1piDU5qS15yDYOQslsP1SvNrbEZfE=;
        b=BCh0EpN5tIK1oBLaioFtekgI+vxaIGegQHb4FLsuNTy7QlQAmJ1LupdH20WO/5g9+f
         fNkEhCCgSvAl5AgpflQmlc61Wvh1ajd2aUrEcA3kizps54FP7N/geoZ1GuvbK9Y+XJN6
         MiHj5VbDeUb+HbY2YswCcaL3BJ8b294jxoE1JEjItqpytK/MDPAqtDJ35RM6iZjm5INa
         ICAfeCmpZy/PoTsbRFSIupNcnkYCNkQOkcA7rCD5Sk70wOBwH/NgV/pKSznzTx3kB6r1
         UcjV6S1bDfoLb3cKblFpxulvNurwjMRdRxuWBFcQM/gK01tGkH6wEEpcucgR2F01o/nB
         j9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741005691; x=1741610491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLW0AYaLwkO6JC1piDU5qS15yDYOQslsP1SvNrbEZfE=;
        b=pgujbgtbMAMF+CHR4wOsKyno5jVrvWWBdLmc7FcvWPLNzzr01hr/MvZ297NAAhmxlO
         yF3IULHLF9KeS88JYyzPggDFJvAzihbmU+v6waqL5Fs2enjsYpFX0RTqcvWWWyZY8GZ8
         O/mxHIj24io2GQBh8778AmyZItPm5owngLLCmpBovxwfcCflZRV46IwFR3U6XuZgRdx2
         GPjP4eOvy58YehIwdR5gvH72/iZRqzWwPk78AMAjA81+eX/Cqo3FmWjb2y+dyges5Mkq
         Djqcs3ts/CzTT/dYcy07NuGSGMdWOLtclYlQx58qtEgvoCgRH6TGgiUW9YO6qHNeHOH/
         jVcA==
X-Forwarded-Encrypted: i=1; AJvYcCUCr0hV2nZoej47LtHdw2SxV5dg56c0Tc7nvkTDoZMDyaIAt4KpTYclumZY4sI4AE4iRpi86TxXU79RWnE=@vger.kernel.org, AJvYcCUpIUzvpFGNeHJZi3m8X1HFZhMVBsOa27P3jRjdX8kwA6gI5KQzxcRptQyYrv7dNlHOuwwlWCDlVzjPZmMK@vger.kernel.org, AJvYcCV1qr0F+utL90FsmZkKo+zQu/o6RwEAwGOeM9hmMXJxNodGW+ASqTqwABlXxPPaV/5W+JrDlLrUMcXgRIfhY2U=@vger.kernel.org, AJvYcCW38iV904+Lt0CpE+AKGpvJo5B4tHgDDXnF/FWj7azbcOseBzKfzpRcY/axlvKNzlZl4BVsKPqbDJEWAPNA@vger.kernel.org, AJvYcCWSE4cuRW8QWqsh2MdxaPKQc72nAy3FYO8JT9qE8b2aO1qPe5NZ/TbvA11I1LdSwlvn04Db847sd3yn61s=@vger.kernel.org, AJvYcCWSF2SZ2kWxhNh3j5OBrj8GeWgyA3s8FCWu9MsuxsfULvQi56LIxwQq3rXKEBjNoxe0AdWmEpqD@vger.kernel.org, AJvYcCWvN5oOleyvgMaVZvjx9gpyfoafFJOXG5ZLZyRVKUKqKd02b57B3ns8dX5BHyP2YhU3uXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpXdOPRgDv5ltNkdlpqMTfpweyQ/twLowJfO6DKU9anmxnL43q
	pzOc/fUFjXu1X6QpDJ5qwCyZF/g9NC3aSosfLGp4CkR1tdDtKe84
X-Gm-Gg: ASbGnctkqxAryEx+16m4xz25P4L2oTOP2KyycrntiiR67FD1CaPB/SskqofVe1wWXs8
	yvcN8XTDxjEGdTiqMa/124Mgg07cpDYQE5Vw2Ntpw0YTtX6tyi1ZvAUKoBmShe5pab8t/L1LFeA
	eWKPDSht3DqI09XZPWI2F3A8GhZvmM6wxF26xurgxiMV2Z919fI5890LEDMMMG/nT5nUJpqRg+/
	/M3MiKxAguSyKmGwC7HIjvfFjAuj7HXx3wDNFUZNleh4xYP0DtC0Qjhvf4A3bW7KK6xYgdK/ljH
	UKfUP9epbYmIOig1tZCX5h1lYXslYOqf1QMAfvS9uQDvZ5v+bX1nsI5ijSHF4YCy/VOzamv4Ucb
	wJugEqNk=
X-Google-Smtp-Source: AGHT+IGmsdmZpDuU64/zBFVRQ3e/o9vGnleqAFoX6F+q7Lw2p71TWS5SPeiWtsRpxGv/SLlt+kfa+w==
X-Received: by 2002:a05:6402:2808:b0:5e4:d2d4:b4f3 with SMTP id 4fb4d7f45d1cf-5e4d6af1582mr13492784a12.14.1741005688031;
        Mon, 03 Mar 2025 04:41:28 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb4384sm6903702a12.49.2025.03.03.04.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 04:41:27 -0800 (PST)
Date: Mon, 3 Mar 2025 12:41:25 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org,
 joel@jms.id.au, eajames@linux.ibm.com, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dmitry.torokhov@gmail.com,
 mchehab@kernel.org, awalls@md.metrocast.net, hverkuil@xs4all.nl,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 louis.peens@corigine.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com,
 parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
 johannes@sipsolutions.net, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, akpm@linux-foundation.org, hpa@zytor.com,
 alistair@popple.id.au, linux@rasmusvillemoes.dk,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsi@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mtd@lists.infradead.org, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-serial@vger.kernel.org, bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
 andrew.cooper3@citrix.com, Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v2 01/18] lib/parity: Add __builtin_parity() fallback
 implementations
Message-ID: <20250303124125.4975afdc@pumpkin>
In-Reply-To: <Z8UYOD2tyjS25gIc@visitorckw-System-Product-Name>
References: <20250301142409.2513835-1-visitorckw@gmail.com>
	<20250301142409.2513835-2-visitorckw@gmail.com>
	<Z8PMHLYHOkCZJpOh@thinkpad>
	<Z8QUsgpCB0m2qKJR@visitorckw-System-Product-Name>
	<Z8SBBM_81wyHfvC0@thinkpad>
	<Z8SVb4xD4tTiMEpL@visitorckw-System-Product-Name>
	<20250302190954.2d7e068f@pumpkin>
	<Z8UYOD2tyjS25gIc@visitorckw-System-Product-Name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 10:47:20 +0800
Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> On Sun, Mar 02, 2025 at 07:09:54PM +0000, David Laight wrote:
> > On Mon, 3 Mar 2025 01:29:19 +0800
> > Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >   
> > > Hi Yury,
> > > 
...
> > > #define parity(val)					\
> > > ({							\
> > > 	__auto_type __v = (val);			\
> > > 	bool __ret;					\
> > > 	switch (BITS_PER_TYPE(val)) {			\
> > > 	case 64:					\
> > > 		__v ^= __v >> 16 >> 16;			\
> > > 		fallthrough;				\
> > > 	case 32:					\
> > > 		__v ^= __v >> 16;			\
> > > 		fallthrough;				\
> > > 	case 16:					\
> > > 		__v ^= __v >> 8;			\
> > > 		fallthrough;				\
> > > 	case 8:						\
> > > 		__v ^= __v >> 4;			\
> > > 		__ret =  (0x6996 >> (__v & 0xf)) & 1;	\
> > > 		break;					\
> > > 	default:					\
> > > 		BUILD_BUG();				\
> > > 	}						\
> > > 	__ret;						\
> > > })  
> > 
> > I'm seeing double-register shifts for 64bit values on 32bit systems.
> > And gcc is doing 64bit double-register maths all the way down.
> > 
> > That is fixed by changing the top of the define to
> > #define parity(val)					\
> > ({							\
> > 	unsigned int __v = (val);			\
> > 	bool __ret;					\
> > 	switch (BITS_PER_TYPE(val)) {			\
> > 	case 64:					\
> > 		__v ^= val >> 16 >> 16;			\
> > 		fallthrough;				\
> > 
> > But it's need changing to only expand 'val' once.
> > Perhaps:
> > 	auto_type _val = (val);
> > 	u32 __ret = val;
> > and (mostly) s/__v/__ret/g
> >  
> I'm happy to make this change, though I'm a bit confused about how much
> we care about the code generated by gcc. So this is the macro expected
> in v3:

There is 'good', 'bad' and 'ugly' - it was in the 'bad' to 'ugly' area.

> 
> #define parity(val)					\
> ({							\
> 	__auto_type __v = (val);			\
> 	u32 __ret = val;				\
> 	switch (BITS_PER_TYPE(val)) {			\
> 	case 64:					\
>                 __ret ^= __v >> 16 >> 16;		\
> 		fallthrough;				\
> 	case 32:					\
> 		__ret ^= __ret >> 16;			\
> 		fallthrough;				\
> 	case 16:					\
> 		__ret ^= __ret >> 8;			\
> 		fallthrough;				\
> 	case 8:						\
> 		__ret ^= __ret >> 4;			\
> 		__ret = (0x6996 >> (__ret & 0xf)) & 1;	\
> 		break;					\
> 	default:					\
> 		BUILD_BUG();				\
> 	}						\
> 	__ret;						\
> })

That looks like it will avoid double-register shifts on 32bit archs.
arm64 can do slightly better (a couple of instructions) because of its
barrel shifter.
x86 can do a lot better because of the cpu 'parity' flag.
But maybe it is never used anywhere that really matters.

	David



