Return-Path: <bpf+bounces-55570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E422A82E93
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 20:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE31A461232
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 18:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D85D277802;
	Wed,  9 Apr 2025 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfCjsbVc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAB221129A;
	Wed,  9 Apr 2025 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744223002; cv=none; b=CghZv6QJ2ndYnfmZ8WMVM5lmgKz0uyhiF2jSnahZWh2Bgf7LilorFP7y2AzqdNIksebO5swgNEHyfR1ZRoulo9E1BYnv8umWma+kgT6Wn72kATpk2l1+cuV5QTANMfCioF0XSgnGjnnnScE/GSvAhCbRz6f/O6WyhZwZQEuV1uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744223002; c=relaxed/simple;
	bh=Y9V6lanhSq3xKkI3cq5cXSbzBJnJbbBkpk0mUILhY3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKqn0m4UmgMaHmgRuXyMipNEp4b2PDxCUxML6+LH28lEdbmPjTaWz9sU+0Ju8GqozrWxkNYgg8Ol/i4h4TrjrcCzFobHabUsnHhvw67ewDzMfp3HerQSfXB78vly9KKZfPnz2qot6KyigKts2YydUYS4A63gDCoSAcqoqehc5Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfCjsbVc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22435603572so71198555ad.1;
        Wed, 09 Apr 2025 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744223000; x=1744827800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WYzoH1Uwhcqg2+qDINtEMV7dZsf/NWh1BI5tm3o/1uQ=;
        b=kfCjsbVc7iLolc9sXHGweoevKsYSGHNsUy6IF8TvEwcR3F25aoP7zncBcWiK8URVF/
         0SVmKaauJ0GjsSmc//rYpz8yKjNh6WROPQWdY/3WyCngPxARWX2xqm9b/WdP1lGJzGY5
         ZoCuthIFBLehdwpGyWToUGJWs11IH3uQ8sZ/ne+mpxmuebR/xRjxql/Tb/RWoLtWpVdN
         IapZxdRjG3sd52/7anmDvIhU4n5bSho5UN6qNKTX1GqFA+bh434FOT9IbWymsKeDZFv1
         0W0JYvLiKLxFdj9s0q2pZZNlyziuTS5kGgWoOGmUAsIKziOqaZEfq6yKJS5JgnDDq92V
         UYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744223000; x=1744827800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYzoH1Uwhcqg2+qDINtEMV7dZsf/NWh1BI5tm3o/1uQ=;
        b=cfESCGjLU3OXrhrXuj4Dghn07swcoMPhkZJHp8ghFka58/CucpXGjtIKZcXxRu46pe
         7b8bTM56LV+a1Yb7KVzRWsDrMtO5lwqIxvIDqvQ1c56Bh8/1GA/M3u79BCTnOO+Sj1eJ
         sB38KALy3yqT7cY8O1A0EHtU3yFmyFh3yQT4Jr3MJG4yHZYgqIYRhJ58BhwxYRq2zvfC
         jDPYcGkZ4h/nqrmNAptlMeinNi5HsLisZ7ZUG/00fPwnkz7V2U6T38cxMLiWpSUaxmjC
         UFB1w1z4GyuuMnj6USwZo3Iq8EY5OYxH+V7Etyu4IMPq0cG2EhLjoa0qPq2roNfoa5wp
         odtg==
X-Forwarded-Encrypted: i=1; AJvYcCV7FpQ+X4FvH5DTJX4TevF17KJfbkudXo845xRbjvTlo7EU5TPa1o4gj2jg48qe7E+c0A5BLil5@vger.kernel.org, AJvYcCVs2XjDp5D7v/hLTSJXxX9rfvsA0MrJIPcCf5O6AlzT1HzcDhrUa7blwnzIYCvtTeCtMLnISESyr6uCJ58=@vger.kernel.org, AJvYcCWKR+V1IuDIv3/e81qhpfvQmFPBJNFxMtzU11Q/keRmYiXES2TKKIV3f0tTuts8CZSnX/vJqP1YdTKYkKwI@vger.kernel.org, AJvYcCWZDyiIs/fVCGzXXcpwuwrY2NMu1gxdFlvPD2AJ44UTvDFaRBy6Tyb+hs6Y4C+iYVrCNoUpClmAsOCsmJ64@vger.kernel.org, AJvYcCWhUIqjSxMbYGh5dhwG8sR43OTcZMcygVmQr9W5yswbuaTS5G5zvGnpgdJAt2BsjjybZEBWVpbhtbu7Bws=@vger.kernel.org, AJvYcCWjsl8gdmdsavs4EnDroLIoty5B7OQmtNUJxK7nZNPMRtDCj8Kf6Sc3Hg94zCTLkQySPzg=@vger.kernel.org, AJvYcCX05yjWMwTPrbz2bZgQv8ZVt9F1wg/Dd1zsesCOy3vZnI5a2kg18TfY/8uASfb3/fDRhlzbe/dn7DQmiYg=@vger.kernel.org, AJvYcCX2eyCU+NPU+GZkiAc0TeWm0sN37gvpzAwhthLe2lmxwHCyaGUv3Cx10ESRuW6hHQn0ByS+EIQJ45Pu466LOUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6R1vGl+J/Z4mNIi0BFbHcfVmyt+qkfQcWgLoTwC01TaUNL9ae
	hCnevURGj14FVjUQCKN4bq7dzMUMdmpSGzyKZ1rtjuknKpanZElU
X-Gm-Gg: ASbGnctIGbJSUnvCRMtxsR9mlD42miJJPdnu/OwMpciHDvwlnaX33CaHsnu0wt1L391
	SzvVh/nzXBW9BQE6I7vp3hXCeJS9B5KvnsTXcTqyfy/RIhBTazFoeaya43c1FmIdW9Rj1/jc6sF
	qOS8Th5eCPXS3WuRCNBzWYZ3GsdMgxYjgKO/7fsRoEwycqQ1bRONDmEfg+20uOvNDqMZdB01ltJ
	vT2OWybZdkGMhtpr7LMlDK5V/rT2R2H0kk1iqY/B4rb3gsyl5TRjo4sPLznFodY//q1Gxbe1rL2
	PrxdhLufpVBbwr4o8K8wlmalXQnE10fRycdeegxk6Khr6M2a+BAgDqfDHO0yu1cS6SH+
X-Google-Smtp-Source: AGHT+IFJTXcO6iff2D3m6F14Oejj60CpisJRfAo2/LdtyKFQF1rTvBeD9sWDrAGl2dH2tL/2lZXd/A==
X-Received: by 2002:a17:903:2441:b0:223:2361:e855 with SMTP id d9443c01a7336-22ac2a1aefemr59522875ad.39.1744223000437;
        Wed, 09 Apr 2025 11:23:20 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e6b8ebsm1679194b3a.180.2025.04.09.11.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:23:19 -0700 (PDT)
Date: Thu, 10 Apr 2025 02:23:09 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
	jirislaby@kernel.org, akpm@linux-foundation.org, jdelvare@suse.com,
	linux@roeck-us.net, alexandre.belloni@bootlin.com, pgaj@cadence.com,
	hpa@zytor.com, alistair@popple.id.au, linux@rasmusvillemoes.dk,
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
Subject: Re: [PATCH v4 02/13] media: media/test_drivers: Replace open-coded
 parity calculation with parity_odd()
Message-ID: <Z/a7DecDljuLtKeS@visitorckw-System-Product-Name>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <20250409154356.423512-3-visitorckw@gmail.com>
 <Z_aobrK3t7zdwZRK@yury>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_aobrK3t7zdwZRK@yury>

On Wed, Apr 09, 2025 at 01:03:42PM -0400, Yury Norov wrote:
> On Wed, Apr 09, 2025 at 11:43:45PM +0800, Kuan-Wei Chiu wrote:
> > Refactor parity calculations to use the standard parity_odd() helper.
> > This change eliminates redundant implementations.
> > 
> > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> >  drivers/media/test-drivers/vivid/vivid-vbi-gen.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/media/test-drivers/vivid/vivid-vbi-gen.c b/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
> > index 70a4024d461e..5e1b7b1742e4 100644
> > --- a/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
> > +++ b/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
> > @@ -5,6 +5,7 @@
> >   * Copyright 2014 Cisco Systems, Inc. and/or its affiliates. All rights reserved.
> >   */
> >  
> > +#include <linux/bitops.h>
> >  #include <linux/errno.h>
> >  #include <linux/kernel.h>
> >  #include <linux/ktime.h>
> > @@ -165,12 +166,7 @@ static const u8 vivid_cc_sequence2[30] = {
> >  
> >  static u8 calc_parity(u8 val)
> >  {
> > -	unsigned i;
> > -	unsigned tot = 0;
> > -
> > -	for (i = 0; i < 7; i++)
> > -		tot += (val & (1 << i)) ? 1 : 0;
> > -	return val | ((tot & 1) ? 0 : 0x80);
> > +	return val | (parity_odd(val) ? 0 : 0x80);
> 
> So, if val == 0 than parity_odd(val) is also 0, and this can be
> simplified just to:
>         return parity(val) ? 0 : 0x80;
> Or I miss something?
>
If val == 0x01, the return value of calc_parity() will remain 0x01.
If changed to return parity_odd(val) ? 0 : 0x80;, the return value will
be changed to 0x00.

Regards,
Kuan-Wei

> >  }
> >  
> >  static void vivid_vbi_gen_set_time_of_day(u8 *packet)
> > -- 
> > 2.34.1

