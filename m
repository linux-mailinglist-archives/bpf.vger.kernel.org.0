Return-Path: <bpf+bounces-55582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F11A83075
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 21:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6811B1B65F36
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 19:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BA31E5B97;
	Wed,  9 Apr 2025 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfo6LFeI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F5F1DFDB8;
	Wed,  9 Apr 2025 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226609; cv=none; b=Fs6PGl2C7tJNwpVzK/PuHUxjoGcM1coOa0y1dYzesObtnWSCeKpoX1FjCbyDAJsxdcm/cKe0jRcD6jGzxTlPBA+5d4E5VELvryywMg+/hCyQ77Ixth6iMwoE0UKFHC4vRlCHMZD26tPv4aTKJ01aFA11Y7hgvlw1f5mOPC4nZ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226609; c=relaxed/simple;
	bh=MZIqM2S8zhyCBa4HvVVVDg+twBlAXyb63bh7XrtIEx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVJgkRHD5GsidLHAG5VNcjKO9KSopqseqUfEqgLyiLbIbJWDWBToi+P4qYOxhsGrhfvfU8A8ejEJ4hVIFtoz0VCSBVE8tkmY4ljc/bpr5Er0ahwF72I4yGOuqpoy1bAhMALiVlLTvrB5fuAJ/IxZeQmCFL9zR5luvVNha1S2BUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfo6LFeI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-227cf12df27so679715ad.0;
        Wed, 09 Apr 2025 12:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744226607; x=1744831407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8RibaRu5VBtVELK4VwEix973B2UxxmX58KGstf9uOmk=;
        b=gfo6LFeIOxTi1GHs4pbAxTfxSQtuQ1bK7v4Pjm1065cLAC3zGCZvdJwQiCH/WZZ6pF
         2cUdcHYwm7vStKnqshMwdIqxIdgE3zMk+GcTO82wnEla2mhkP2I5NTmB50SgsYqgIDxf
         kl2ROaSXUIHSy12+6PfPJ6LJIlu8JH/K2TFh3z2c3UiHt123ZB76y06y5QG4iyCcEBow
         7A0Mh3CwuPc8R1PYk3makSvCsgmm49Mv6TLt+cVxaUP4KHIZBYEj/deWjUNmGUL3izOk
         vKapIRnnTEQhNcTY3g27WTaBaaypaekeOFMiK6SMRXO+sEQ8DeZsAWiU3o7XVPvxVpuR
         t7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744226607; x=1744831407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RibaRu5VBtVELK4VwEix973B2UxxmX58KGstf9uOmk=;
        b=O/MKDva/fpJzMD1tAN59PNkusI4LYxa+Ts/BX5k1KFTCbJ74tOQaxBKRvEQxoo6FfE
         HquEMSLbUcdl5ekMiE8YEBrdVTkjSoTI3m0kknueFf4AKF53XjnaJXg2wS+R1TeRaT1d
         Hb31ZDNx2mE7aXw7LZfn3VNyj0SYcTPdaCV58GjPXF/odIbbHXMOzho7bfu76NJtogUT
         fkLn5h2SmbtBVSvdSf8WlSa9tK2v6NqB+QgmZLPpVd2V23VigHyBTb0jbEbPJBnbd+Zf
         gbNo13zYxffuItULWRl7lJfD34sVc1fEIXlZqlRMMJAAxFNr6ehN6ycz7iUOc6nhZT5W
         avaA==
X-Forwarded-Encrypted: i=1; AJvYcCU0WHkGg1tMtecEWJ0c0eVTQARCgAzzX4ndq0GWu33LPnqTcTcq6iIkf32L7oqTWzn8e7jC6WjVg5s308nw16g=@vger.kernel.org, AJvYcCU7Wm/8WJvt0f8bJ9MMNqoczI87nPJTwhGOjuvUce1xhbrHI0eKDXNpJyMhnzPGZh/folUs/5x8LeKC3B0=@vger.kernel.org, AJvYcCVRsAvRAR/u/5fqQLU9poa+f7O/PiUdqDx+i3CV1e7b8z7Ad53FgV0rzWngjN0KybBBi1O+rvDJV5Va8Oyo@vger.kernel.org, AJvYcCVxV+mkbLBWm3A4Qxnm3wA8kHvu2Cyyo4/UXcq03VM93w09WnJcWYDUi168M6nZZmoX1DY=@vger.kernel.org, AJvYcCWoQJnsbt1/liPkqu5Ui9K5JEcjqFvnJT7WM/9poSYYnDDeR9J1M8og2pPwTRUPr9GlU0N1JFcMjynCsbo9@vger.kernel.org, AJvYcCWy5WuMghbnFyAWiE8/5TLs7jmpMrkFxMeDyBSjkVGPM5JuLych8MaCF0yfmAt2v82G2r0y/Cwifi1aHYY=@vger.kernel.org, AJvYcCWz4rpY/jIFM+ldz00lewptQsMd3vUbIOWuyCBSW1sRP1LeLTbxtfcwglvBrEex2lutV22tbigr@vger.kernel.org, AJvYcCXVI8rZL6s/CpxxgyunS00xGv0E9bEWZ0EY8jf3gwGxSRnuKIwP13nwPTpNqwaiq7Tx/q9/p8sdn4VN8SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyGk5Y2q2PGdOVFIJsrk/YAJgRThPIMUUJCfN0FcJNh0sgjCQE
	Mc8l5MsY3u+j6lBaE575xKHb0jkbJYamlsn6hp9TveMthxv3pBTB
X-Gm-Gg: ASbGncv1TDXe+IWhLJS4WV49wEh2720e2AdBvJ7XBZNpuOOW6UHgXbVjOVCXmGcNero
	9VlCfuglJkMtFBbuyBxZtJ3ZsbaT8VAOtPAGidOy47P0TFPhK+OEEYY3drxZkDqJOKpYZzoJ4p/
	/PppB4P6u7+vnSLZsqKnMDzU+orMd32+ykQN61dkKPXY9gZZBEr7byeb8qrRPKBOLZd+FNPcN0Z
	7kv77BV33Zj4jFVymJC9LFvtD9b0DiyW5DHTNmmJzfhG6DREI85C2G8PSuOCrIDNnM25XjKNsdq
	SWtQhEvRmmnzHWlf9oJmdIbkukEpHzNxrfenxZ9rNA==
X-Google-Smtp-Source: AGHT+IFL3XhQxmETFJky3U8LpnPa3gTvoNA7bcU/WI3ailvxU34USadXflyfbHs0+s3uYjppXMMUHw==
X-Received: by 2002:a17:903:90d:b0:224:7a4:b31 with SMTP id d9443c01a7336-22acfe92581mr8187825ad.6.1744226606945;
        Wed, 09 Apr 2025 12:23:26 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:cff4:8871:54bb:4c97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cbdfe7sm15862175ad.207.2025.04.09.12.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 12:23:26 -0700 (PDT)
Date: Wed, 9 Apr 2025 12:23:21 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org, joel@jms.id.au, 
	eajames@linux.ibm.com, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	rfoss@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, mchehab@kernel.org, 
	awalls@md.metrocast.net, hverkuil@xs4all.nl, miquel.raynal@bootlin.com, richard@nod.at, 
	vigneshr@ti.com, louis.peens@corigine.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com, johannes@sipsolutions.net, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, yury.norov@gmail.com, 
	akpm@linux-foundation.org, jdelvare@suse.com, linux@roeck-us.net, 
	alexandre.belloni@bootlin.com, pgaj@cadence.com, hpa@zytor.com, alistair@popple.id.au, 
	linux@rasmusvillemoes.dk, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org, oss-drivers@corigine.com, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org, bpf@vger.kernel.org, 
	jserv@ccns.ncku.edu.tw, Frank.Li@nxp.com, linux-hwmon@vger.kernel.org, 
	linux-i3c@lists.infradead.org, david.laight.linux@gmail.com, andrew.cooper3@citrix.com, 
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v4 07/13] Input: joystick - Replace open-coded parity
 calculation with parity_odd()
Message-ID: <mustacwfqzgmrrtxj23apezwp2ieavnmfa4myylvnojnpf2alm@enruxjpzr46i>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <20250409154356.423512-8-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409154356.423512-8-visitorckw@gmail.com>

On Wed, Apr 09, 2025 at 11:43:50PM +0800, Kuan-Wei Chiu wrote:
> Refactor parity calculations to use the standard parity_odd() helper.
> This change eliminates redundant implementations.
> 
> Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry

