Return-Path: <bpf+bounces-55316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC72A7B932
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 10:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B68173C7B
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 08:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5151B1B3950;
	Fri,  4 Apr 2025 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WS0Jj/WI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365651A238E;
	Fri,  4 Apr 2025 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743756409; cv=none; b=L4i7m/APlXM+8/5rw+OeT4oJPVaTjMdtkYQwHilsz8S+tK1n1yh80VeeIuE4Ugrf/uZNeF84ZH1adm+Y0iwYH7tbVQj2Gj2dRNsln3oZy8/bUeoRV9Ji+OuViUHYYKXcZ1RZTaRVJLgThbFD8NQaxCzF8NehvuRFDCWS/dGcSNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743756409; c=relaxed/simple;
	bh=E2lc2A+7vFvspOZs4wP9g6ue5EEm94LtW39cVKvUsXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFWN7V1EuPFEO+BYSSg6xxG2mQ1fjP0rukA5l2pEM8ya2htr+mBWNAViW/E/ikE0rFDq9glU9LU7YW81OtjwDAmvbpJZI3dV20mq78XnAWVwL4YbVoltdx3hS2iFamH3U5LydbDiGfqbOIZ3tUHOhAvLzHVmN63x/qyEmdrXedM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WS0Jj/WI; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so1589794b3a.1;
        Fri, 04 Apr 2025 01:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743756407; x=1744361207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XEr/lesTAhWcQcf7iA9OshZymqi1lesrw8RKfhNHVDw=;
        b=WS0Jj/WIMfjvE+Ems1F5CF/UzxGixVeue8oC1ZN3PMlUsHZNUiLYR+PzHZc0VdlPZ7
         MfdWCByMK3/+fnLnMNXEL1x+U5EVd1xsi059XRuM2i8svGCN2LADmKKITurRS90BzaXj
         nbOONk8A8gRh1cWZHJtbIhe2PrPVnd/GVAThbCT7oQl7aLSFS+Q1I0M8VcnBO4uiQXYP
         NM6mczyl1c/xmRlr7wNCKkegOmx+NTsu7W31QS3YwxD5qXlUF/h9UTov/oQBY52pNVnb
         rfwU0FG4Sl0G2Ju7ex+w6h9DJj5tsFXm+sT8KXii0Ekgo03eTCgDshX/tMdgh2FwJGsS
         uXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743756407; x=1744361207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEr/lesTAhWcQcf7iA9OshZymqi1lesrw8RKfhNHVDw=;
        b=sW6cDM6nQOdfcivbGUid1jFtI/SWjkebfzw3ndC85UVEIktwI0FKsXxoLJO6C10+1J
         j0T7p0OAkLvuTpDMQ2+KWlD0/UAygO9/lIJLkaiYr4PMZGI3j9NtKPLv9wfahH44Nikf
         O45H6dGw/AL8qEIt8c8B+IAqSATDH1cpiKHfk2d/3XP7+ewhpE/0Z9/aYvLHQw3NOpjI
         K5+59IW5MCDoa8m9jivVXBt9k/U9Df4LLOY5xWFAA2M2oQ0E6zYApE2eISZnJnUuv7k7
         WckZA5IV760mj4VnFWz/yWdCjz/H2Uu09lTubfj0lzo+do/Yte18G8CD7bAY4mFSw3Hk
         DqZg==
X-Forwarded-Encrypted: i=1; AJvYcCUW8LqmqkWj/gfaYjiuXQfalAf212n5z1YcD8Oedy7nOosY9e8IxxFqs1gPndA17ZvaNV0VhYKo@vger.kernel.org, AJvYcCUnuOkHc1jfdrlaYdynh37tSEKapDvxDpW783+Hg0+ZLQPWF/yHcxEdNfGW3r61gPNAG9VYtPas6lksZkkF@vger.kernel.org, AJvYcCVbLNCTSQPGtfSlOlISUwKacoZn+5S4GJVr64gtkEdVyD34dYIRtEe1mLEm0XTznlncA+U=@vger.kernel.org, AJvYcCW4aonmU0Xg2tMOW0xb01EY2mRBiLK+LTQzVEv7XV8kcTlPsY7Je7Uv4h6Y9kOb0Byr86BMX6uCB0iHK8Q=@vger.kernel.org, AJvYcCWRGq0KFlKjzzeXN/sCF/k99JTZHh02u7+VrOnwV0iEVtctQu48wc573EQxHEomcaFv5X+yy3kS7xM/0cA=@vger.kernel.org, AJvYcCXDa/2UE9HlvzUxKyFwQ2BaqRNPt+Rx1p6ph4N1BPxzNL57FsYIlkTJHQOnNVGL4kEPhnTy58WXKXukhEbD@vger.kernel.org, AJvYcCXI3Imsd9LMiSJ9rZxKVRbNoNFUEZtHj4ajkSrqYClAX74gE3QMaUwO+1MWWSM3pxwfGNzSyEXM1HrYe683FUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEOwdLC7SZ3wHLr+XKDyTh1A1IA8PJ9q4gGaOHy2XeqAV+haRV
	nc1YaLzk9zaoYeFDlBekWFRs6aa7+7/zznrgCSsO3g3op7l8u7Bf
X-Gm-Gg: ASbGnctUhvD24SoA3Rhdke22bMB/3qpAotgXntZG7PX/2Of4Z+4jPPvn2K0vNXx6rtt
	2cLhCd596CTlpk2cIxihmSS4gd1CenKVoD757VSc+GYiUUyo4jqnhwbRYkFb6vsvcgg5KypmIA7
	9R6aMj7owGiIYVC1tiwtBTbQ4ULdGQwfpaLpPqBFufQGx8y3JEoI1MuUKvWan54qTqW6SZbqc2+
	zPzQO1LnLBYGuUxPzOoP/Opmeycbf3ojEmpQ4gfXysacdN405XoLeCJJnce3thFS9TxpCTXxIcY
	hbih546jmE4vFa9dI3QfB2p3LoOjXOS1AmMBBWYM3hGuxu/1xT8YjDFpIPa2rJMzR1lLkg01
X-Google-Smtp-Source: AGHT+IGnBuGwhOqlkhsoqT0zhJln64liGpkRA7l3PCCq0BqnYRQF3lpkwuYz5g4xSoDa+vLjvXq3Yw==
X-Received: by 2002:a05:6a21:483:b0:1fe:61a4:71d8 with SMTP id adf61e73a8af0-20104666844mr3980332637.22.1743756407334;
        Fri, 04 Apr 2025 01:46:47 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc34ec32sm2448099a12.35.2025.04.04.01.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 01:46:46 -0700 (PDT)
Date: Fri, 4 Apr 2025 16:46:37 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Jeremy Kerr <jk@ozlabs.org>
Cc: Yury Norov <yury.norov@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	David Laight <david.laight.linux@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
	akpm@linux-foundation.org, alistair@popple.id.au,
	andrew+netdev@lunn.ch, andrzej.hajda@intel.com,
	arend.vanspriel@broadcom.com, awalls@md.metrocast.net, bp@alien8.de,
	bpf@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev, dave.hansen@linux.intel.com,
	davem@davemloft.net, dmitry.torokhov@gmail.com,
	dri-devel@lists.freedesktop.org, eajames@linux.ibm.com,
	edumazet@google.com, eleanor15x@gmail.com,
	gregkh@linuxfoundation.org, hverkuil@xs4all.nl,
	jernej.skrabec@gmail.com, jirislaby@kernel.org, joel@jms.id.au,
	johannes@sipsolutions.net, jonas@kwiboo.se, jserv@ccns.ncku.edu.tw,
	kuba@kernel.org, linux-fsi@lists.ozlabs.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-serial@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux@rasmusvillemoes.dk, louis.peens@corigine.com,
	maarten.lankhorst@linux.intel.com, mchehab@kernel.org,
	mingo@redhat.com, miquel.raynal@bootlin.com, mripard@kernel.org,
	neil.armstrong@linaro.org, netdev@vger.kernel.org,
	oss-drivers@corigine.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, rfoss@kernel.org,
	richard@nod.at, simona@ffwll.ch, tglx@linutronix.de,
	tzimmermann@suse.de, vigneshr@ti.com, x86@kernel.org
Subject: Re: [PATCH v3 00/16] Introduce and use generic parity16/32/64 helper
Message-ID: <Z++cbTTp8leOJ5O+@visitorckw-System-Product-Name>
References: <Z9CyuowYsZyez36c@thinkpad>
 <80771542-476C-493E-858A-D2AF6A355CC1@zytor.com>
 <Z9GtcNJie8TRKywZ@thinkpad>
 <Z9G2Tyypb3iLoBjn@visitorckw-System-Product-Name>
 <Z9KMKwnZXA2mkD2s@visitorckw-System-Product-Name>
 <Z+AlyB461xwMxMtG@visitorckw-System-Product-Name>
 <eec0dfd7-5e4f-4a08-928c-b7714dbc4a17@zytor.com>
 <Z+6dh1ZVIKWWOKaP@visitorckw-System-Product-Name>
 <Z-6zzP2O-Q7zvTLt@thinkpad>
 <3ebd280e6697790da55f88a5e9e87b4cab407253.camel@ozlabs.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ebd280e6697790da55f88a5e9e87b4cab407253.camel@ozlabs.org>

Hi Jeremy,

On Fri, Apr 04, 2025 at 10:51:55AM +0800, Jeremy Kerr wrote:
> Hi Yuri & Kuan-Wei:
> 
> > Thank you for sharing your opinion on this fixed parity(). Your
> > arguments may or may not be important, depending on what existing
> > users actually need. Unfortunately, Kuan-Wei didn't collect
> > performance numbers and opinions from those proposed users.
> 
> For the fsi-i2c side: this isn't a performance-critical path, and any
> reasonable common approach would likely perform better that the current
> per-bit implementation.
> 
> Our common targets for this driver would be arm and powerpc64le. In case
> it's useful as a reference, using the kernel compilers I have to hand, a
> __builtin_parity() is a library call on the former, and a two-instruction
> sequence for the latter.
> 
Thanks for your feedback.

IIUC, from the fsi-i2c perspective, parity efficiency isn't a major
concern, but you still prefer optimizing with methods like
__builtin_parity(). I'm just unsure if this aligns with Yury's point
about needing "evidence that performance and/or code generation is
important here."

Regards,
Kuna-Wei

