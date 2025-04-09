Return-Path: <bpf+bounces-55559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 465D7A82D87
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 19:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3396461F73
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7811276053;
	Wed,  9 Apr 2025 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YM4ERz/N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31DD270EDD;
	Wed,  9 Apr 2025 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744219454; cv=none; b=sDWz+W2qMrFTUlhCRvbRqUVE1A6eRFGaZXYyn6jfZqV0LzvUJyjRxst5StOC02Wnz6bJg8cPiPWCmMPSHPvjX8DqDFrnn4xWNTTGsZ/iXzR/kQY1JVVLeGJdEegfD2k2vg1PV0g9Gs0mCwrCH+fH5FkTi1KQVcYlrk6NNGEv3xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744219454; c=relaxed/simple;
	bh=Rwe8Y5EY05DaVr5ui2bXVFwv20PZbqJqTEzIsURCcWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0obyshKdipmqxJB0t8bFD2hE6WBD1gG7lYo+Kyz4/aCAzO4QjCsoyG9Vf4F607IxbtPhnao+glTr7zu65SYsA8CkmUY/Zt04DZWQzo4pyOAPSa9sSZfEqCAmD/pXs5jNOpWPh1NKbZtXYsLRQ1KN3x6XsQpDmnkqeYPh/zBQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YM4ERz/N; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af9065f0fc0so4891407a12.2;
        Wed, 09 Apr 2025 10:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744219452; x=1744824252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xd6xaUI5nv9NKBM15KV37XOGcT5rm8Sii0IDXetnYDU=;
        b=YM4ERz/N4iiWyfXFSwRuCJamm6ZmD5oTqHQkiC1oVhjDPC1apcHC+WWgVSCFxI3leS
         kBronCs7SXWwNTEBixCgHPRgA16ZDqeqryRdD8yBrecdVjdGexjt8IGakYsZO5dS1xAd
         GT/si86FZO4pYkjNdk6ZfZH6n2s4SI6QTppAI/L3mLr03R+txDZ+hIYoDanyn36Ms84H
         dGvD2KwdJZOKENu99P0liMSYDi/dSL3hLxGyvtTYtBMJsHhYPpAFVpZ/3Mu/NI2xg2/h
         9wRN0pC0YorB241KFOq7IbbVBJ6jGmb6MsWAae95ir1j5HpYfiIgz004IWM9e+BxsnxW
         6uTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744219452; x=1744824252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xd6xaUI5nv9NKBM15KV37XOGcT5rm8Sii0IDXetnYDU=;
        b=IRmZ/G46khvwF2kiQ33+3MbP7c8Mqf2prn3u1h9+wZ5TCv0kHIM7jRzisq6Ot+dYEF
         A1lgV8RA8fOKA5nBg3HsI8BpJu/rFsoEovrMoM0t3lKr96nDak/Tn5XbiFhfDFC2wCD2
         DCsVcvqETdsue+nDO8z8n4QlQxwuYIW+HEHEZfhJgRNMbenscoSeKRJ3PFfqjUiBHHeK
         3T7O1yGyl7Rku1uyXex9at87rBTQrAPhsN1MzHOYKzjQXwSWaklfBJxSMFaWj17nW8/P
         bKfUiRIcspdBlZclLkTKpbopACswpOVUCvDSHcitITmyKAJaj/Zo0rqxEucLrCDXoU2u
         7F5A==
X-Forwarded-Encrypted: i=1; AJvYcCV7SgshekNJiWthWrChV98Og98l5MmDMy7cii7AkcehpoOXMUOmyowuYS5YN3KYQqJGxN9SX4j79EdcM9/q@vger.kernel.org, AJvYcCVRaqIx0eUxrH3oP6wshX4slH31z4W/4jTO7afpExXxykV6ph5ca55eyDLdYExQhL1JGp2DHDNHoYM6K2c=@vger.kernel.org, AJvYcCVztw9ZynDLEqXuXl3aGPDPeuLti9gxQbIWoKUek3pHNi747jjbCh5KzdgH6S/XHgxzzS4=@vger.kernel.org, AJvYcCWJ2ufTIjaoWOMIhmHdil5v7sjWf/tdmWTiqmL2G+Rq5U4XCJ6RrCogzdYIJbL+Ggas+417/0f+RCgKEJle@vger.kernel.org, AJvYcCWmkb2+lc5ElaP+GDfCo7IQYK/lXMmX/y7W1MrJQl1j+Rc4ovK4OrkOmIMuPf/rS1clCc4/TF9EnhgGaKM=@vger.kernel.org, AJvYcCWsjMWS1wfFft4ZuUiA0daKJOy/4h1VVqaf7tTXZuoFemnfwQxSpl2XtNmQPF7EOdQoD5p6VyCb@vger.kernel.org, AJvYcCXfyv7SegsjPNDO4jryPe+okL+XIQ4Md0gUvMGcpAOo3eLM+aQNfntuOR80z3tBpCf7JSbfEtaafr5eKHc=@vger.kernel.org, AJvYcCXtpBH852Libf2Dm07oYdkjvZQwzh6TEZwyyxPNmkZLA73l52cAFYj/p21FZq4FcXtZkk4rD/DhfingVbQAXqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/joGAohHW5EQGkIO5R0QEfKeL5PUYKf/YfKdwSbxhl5qZpZbp
	3x7yy/4TXx9WJ6RM8waK6cpPv/u8ec18DMX1+6Op7ZDHCoj5xwy9
X-Gm-Gg: ASbGncvQy47LH+SbbLhOODmJpf9KqAjnX1uJjE0R2CGyCui6gbbvobvukvN4lr1ZHNG
	zbfjtjAvGaLs2rAYIoY8ZN/nFX0NFwLbvxtnn5vyGATnc5ilyZKqH69xl9gDOkcawWMA52RUMpr
	ykbuoo4gQu7N3YlE5gyR/b6D8Zu42QjATa20v3ZpM//dYYyvvcs2lXZtV1CU/ODfKQLkjYBrSO1
	FpTHKWYiobXVsCzUU4/A0czM8lf1YQshThOSDiHzPMmIWDLyU/44eszH9UxS7CYpbNf/5V45Ai3
	zDUFs17LtjQfYOPX+x035SUXAZDWnS2oMb6XmThZ
X-Google-Smtp-Source: AGHT+IELcovaPBJxMo6VlfeeTod3PlQVQYXafQRyaLUWNqmSnypRNDEVNTbdlgjgS5FV2ZA5ueCy6w==
X-Received: by 2002:a17:90b:6ce:b0:301:1d03:93cd with SMTP id 98e67ed59e1d1-306dd556630mr5093919a91.24.1744219451960;
        Wed, 09 Apr 2025 10:24:11 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd12b4d5sm2098089a91.25.2025.04.09.10.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 10:24:11 -0700 (PDT)
Date: Wed, 9 Apr 2025 13:24:08 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
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
Subject: Re: [PATCH v4 05/13] serial: max3100: Replace open-coded parity
 calculation with parity_odd()
Message-ID: <Z_atODqZDkff5sjj@yury>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <20250409154356.423512-6-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409154356.423512-6-visitorckw@gmail.com>

On Wed, Apr 09, 2025 at 11:43:48PM +0800, Kuan-Wei Chiu wrote:
> Refactor parity calculations to use the standard parity_odd() helper.
> This change eliminates redundant implementations.
> 
> Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  drivers/tty/serial/max3100.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
> index f2dd83692b2c..36ed41eef7b1 100644
> --- a/drivers/tty/serial/max3100.c
> +++ b/drivers/tty/serial/max3100.c
> @@ -16,6 +16,7 @@
>  /* 4 MAX3100s should be enough for everyone */
>  #define MAX_MAX3100 4
>  
> +#include <linux/bitops.h>
>  #include <linux/container_of.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> @@ -133,7 +134,7 @@ static int max3100_do_parity(struct max3100_port *s, u16 c)
>  	else
>  		c &= 0xff;
>  
> -	parity = parity ^ (hweight8(c) & 1);
> +	parity = parity ^ parity_odd(c);

This can be simplified for more unless I misunderstand something...

From: Yury Norov <yury.norov@gmail.com>
Date:   Wed Apr 9 13:22:04 2025 -0400

serial: max3100: Replace open-coded parity

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index f2dd83692b2c..07d332b8e87d 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -121,20 +121,12 @@ static DEFINE_MUTEX(max3100s_lock);		   /* race on probe */
 
 static int max3100_do_parity(struct max3100_port *s, u16 c)
 {
-	int parity;
-
-	if (s->parity & MAX3100_PARITY_ODD)
-		parity = 1;
-	else
-		parity = 0;
-
 	if (s->parity & MAX3100_7BIT)
 		c &= 0x7f;
 	else
 		c &= 0xff;
 
-	parity = parity ^ (hweight8(c) & 1);
-	return parity;
+	return s->parity & MAX3100_PARITY_ODD ? !parity(c) : parity(c);
 }
 
 static int max3100_check_parity(struct max3100_port *s, u16 c)

