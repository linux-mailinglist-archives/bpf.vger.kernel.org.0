Return-Path: <bpf+bounces-55750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD59DA8637C
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 18:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A903A5BBE
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 16:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84D322127B;
	Fri, 11 Apr 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQtwrvNo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6E82C80;
	Fri, 11 Apr 2025 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389456; cv=none; b=DY4TL3AneT6fi4XzU07EqFDhEI5filGoMRe/IEUwHV1nVA4fo/oHh1hxykG0laybe+PjVbdOJXZfxLo4SMYILhVrvHH/8dtds3OBo6wuZPUZJ1bDn+97E3XYnv4K9EQJkli3/0mvAAxVOl7QdLYd4c5+ijCZqk3meezKggUO2eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389456; c=relaxed/simple;
	bh=QDqqnNFS8H3+6xvxJhKf4PlhsdEl3XTPqWR+CfGmy6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPyHxbtMe7EcYRlkJsKJEO6WdOnVr1ABFPbNVxlVYJy9RONrBHWeccYGygvv9PYQBb9iORpqIko4L88hYfi2bNaoseFy9ZJV6elW7WpcWaAKtpZt0m1VAP9woZbaVqQBDSgBN7D3mqTR67ydxYI3/NcLXvHolbo/v4ksSTU5k84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQtwrvNo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224341bbc1dso22347485ad.3;
        Fri, 11 Apr 2025 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744389454; x=1744994254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MjzA0YnYKabpFVnU6SCdVYbRaI+R9P9oLUcK7MMUODI=;
        b=JQtwrvNo+jIx9Xl8BHM+rnc0umYf8ySAhAMGgWbwtNeynrH4OI0opesEOUFYP5VRMK
         D9s1zvrKvQcUPvEc1ZLaaacklGiXV2hqLJMILTpl22UnDLuScfSxsLocptN+kpqFsbsH
         +FI8D5AJRkh3VM5RJwAbY2geHr4+lgS1TCvaygbxJSAqzPWv83OLay9lP0FvUPMIY3ZD
         yQymKjYpK18JXWPBCyh3ArWQRWwCVNnQ5OZn4d6fxqY4kfs96dp4fO+bfd9sNFbu05iU
         kHecRxW+yGewVrLf7h4St8p7q/9mS+Cc9RQa3aLNR1jCY6bgZTzKw6Bsgjr1kOlabCDi
         bA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744389454; x=1744994254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjzA0YnYKabpFVnU6SCdVYbRaI+R9P9oLUcK7MMUODI=;
        b=Z3CgqOLDbj+o5yltZl3fjFje4iKyXXIfQo91+MNvtfOUzHfRqD+tIYPaMQAhhbOMdV
         klgSvaYG/cMaMKAkVYA/ehx2sURatAocNtz0+9XtWMiIovwBGoNxU020sXAUkz0iluiH
         kxoxBWve/OSPpgjbWKZiTSE3YAh8gkYxNqe62qOIEsyQxqRgtByA5DYXo1z2d3JdD5RV
         f+t0zkZ0XloA0/xCITSACdDVgCWcY8sG3zq/aqdvIqpVdlvE/gqcXt41hzxUl6G1fT5J
         LNVDOOJxAYC3rXpYgynvXp5YxQtZW4nxXQUropOeX8feXm8sqxI8Ch40+3G7SEO+tWVv
         JbcA==
X-Forwarded-Encrypted: i=1; AJvYcCUsPMvXMq8d/MeEOkgbrIwII8X7ZC9DR019zHaDTlZaLIYwBZ4ObCwIOgef6qGGKYmlbw8lyU6GKLRnvik=@vger.kernel.org, AJvYcCVSXRQI5Wt5pSJPdRBeA/4zfyra+p/rQO4mj4RCt8Ghl1960YQyuczRLv3eV4tpDTPYh8BfgbwgZYTVEJ9c@vger.kernel.org, AJvYcCW/rf62HbnpkzAjRAD5p//5o0Y+VJrOGJHG8GbDspZa6iIEs7rICu3IDJc78Hs484CBRNg0wwfmptAivD40@vger.kernel.org, AJvYcCWYvdJlV2j4cAZx3fWSZnopdANXTqI/qtLGhDwtkISv3T/JfU0YWZTFgBufnb4PIidSwL0FwS5NNLWaZulfLjI=@vger.kernel.org, AJvYcCXcc+bLD05hBLriBoqe0jYMBR+vH0q8DNHrZOQvlLiqh9SHzDb49xJ5u7/llCRAGCY3+642lNyn3Fv5isQ=@vger.kernel.org, AJvYcCXl1X7NRvpeiNEd0I2TCHyOkwNU4uLdaPD219WYSMbfCIpg0CPV/Fx6X4I9oy9GGji4C0k=@vger.kernel.org, AJvYcCXqV8GCpMirRTZHla8YAwlx2/BR2CP34aqGTPXYXCTGuKrPrKEy1JCeKDQbwL4YsYtye83weDEn0TAwZxg=@vger.kernel.org, AJvYcCXw6f466opHRKOJJhWkBEtRLSwSFsXT1tzBSSCySTJZh4SH/RdYZWppGBFESJWlWrbAOr+6IFM5@vger.kernel.org
X-Gm-Message-State: AOJu0YwR0sj86O4yA+RKJOMHhO2/tTUsdSJwMkMq8nE9Z6DTq3iJ6+17
	mjVlFy0zzrG9XE2RVKPkM2qFieQ0R62IEodLRQ7tE31VTU+4PoY/
X-Gm-Gg: ASbGncuF3lZ/gC4MHyBhpybEG8xAFvVooDFoj8MuWC5tbGqXKGv141vLCOaij4Kdosa
	eUD5NiBB/tBbZo4s6vWueFVU026/SsDwCa5srUWvB4KXQtGpvN1njxDzKAhTMmkd1xZtxvugB8I
	7WmTnom33afl+Ma5eqmZLY27au/B26Cn/1mqSFoxhcTMsV4CCRgPRoeMd8Nln++jcai0ydXg0Mz
	HJ3G7ilOVucfrLg07EdkUI1txQr4xi2I0EWhXeN3sYikA4Y/DClgulGF/d1XhdKnemFGIQ1J5xL
	X3d6jpZnrYtp8mZ2EsKTjU1yoBDrTAQyNet76p6dZXHUeFLFy614UuDzrxaxmwNgxrjM
X-Google-Smtp-Source: AGHT+IGlMlFJxwXfO1vN1lbAUVxQSfZJdWvCgXvyYRfzP61vo51gp8lcBZ4/5fk7RALG9+wgB3IUnA==
X-Received: by 2002:a17:902:d4d1:b0:223:42ca:10ef with SMTP id d9443c01a7336-22bea4fee72mr44963195ad.43.1744389454075;
        Fri, 11 Apr 2025 09:37:34 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c971fcsm51537235ad.111.2025.04.11.09.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 09:37:33 -0700 (PDT)
Date: Sat, 12 Apr 2025 00:37:23 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, jk@ozlabs.org, joel@jms.id.au,
	eajames@linux.ibm.com, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dmitry.torokhov@gmail.com, mchehab@kernel.org,
	awalls@md.metrocast.net, hverkuil@xs4all.nl,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	louis.peens@corigine.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, yury.norov@gmail.com,
	akpm@linux-foundation.org, jdelvare@suse.com, linux@roeck-us.net,
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
Subject: Re: [PATCH v4 03/13] media: pci: cx18-av-vbi: Replace open-coded
 parity calculation with parity_odd()
Message-ID: <Z/lFQ85vhSQiFDBm@visitorckw-System-Product-Name>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <20250409154356.423512-4-visitorckw@gmail.com>
 <25b7888d-f704-493b-a2d7-c5e8fff9cfb4@broadcom.com>
 <740c7de894d39249665c6333aa3175762cfb13c6.camel@sipsolutions.net>
 <1961e19ee10.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1961e19ee10.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>

On Thu, Apr 10, 2025 at 07:08:58AM +0200, Arend Van Spriel wrote:
> On April 10, 2025 12:06:52 AM Johannes Berg <johannes@sipsolutions.net> wrote:
> 
> > On Wed, 2025-04-09 at 20:43 +0200, Arend van Spriel wrote:
> > > 
> > > This is orthogonal to the change to parity_odd() though. More specific
> > > to the new parity_odd() you can now do following as parity_odd()
> > > argument is u64:
> > > 
> > > err = !parity_odd(*(u16 *)p);
> > 
> > Can it though? Need to be careful with alignment with that, I'd think.
> 
> My bad. You are absolutely right.
> 
Then maybe we can still go with:

	err = !parity_odd(p[0] ^ p[1]);

I believe this should still be a fairly safe approach?

Regards,
Kuan-Wei

