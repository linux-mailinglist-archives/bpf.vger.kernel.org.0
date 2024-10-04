Return-Path: <bpf+bounces-41035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD85991346
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 01:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914281F23D62
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 23:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C012D1547DA;
	Fri,  4 Oct 2024 23:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDeK6R3r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89CD231C98;
	Fri,  4 Oct 2024 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085546; cv=none; b=dNkuYp6DaII9Oo3tNi6mBa8k0bWrIiRsDxUPNKvcFDHMDsXXTgyRU7ku0g5MAUlooe+JPkVkFsnfzapsVpuZUTBQtwWptiA1Oh9b+ddR0ihg7G8gXkwsEDVRP8iwuJVBCu8MgNrzN0eAgNsxsUzLWnhi+Vc5HeGxV3BRNx9Y7gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085546; c=relaxed/simple;
	bh=WCYq4onlUmkHwQxDjbw/Mnj6CQNM0qhi8XCIeUSz6i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nse8RA0ri1SLpprkIiy0bKsjJVNFNbyd6dcmIin/+x1soLb6kSFibdzajAJGPzVRSdE0NDIH6NIZGWM8uNyt5gy3uhUicxIqN5lDC2Exxa8y0cNWv1q6rD4UiX8O2+6sxXFzBrrdEMuhwULR0dL0s0bJZckolLjHGHgt4zkLvv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDeK6R3r; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53994aadb66so2555538e87.2;
        Fri, 04 Oct 2024 16:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728085543; x=1728690343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKcY6x98VwBIZfuYWE0CTgk1MQhMRRZsUKeLS0TDxsM=;
        b=fDeK6R3rdiRA21ldDn4Li3pCDwcotjTi5FGivTmWgjNSWBK3dVmB/kWnB9agDcs+lm
         Iv7gzF5osvF1xi3vSTiNjafTR3s3L5vftwOIsN1OezZ+6JjT6GC/RvYypwX992gELFkr
         8Y9YWZ8RGUy0z4HfmHyGb/OkGEJvJMThPH9t/H+qRbLtZje1NLO+VRwIuu4bP66JSBPz
         PGluJNu97FBscQS//ywbnH+gd9K54Bumi47MFHODvl4yZKcvzsOEllimOBNtRGN5n1Pf
         g70XfBa5U6/U98H7VjeXIaH4cvHmsrw2JPEznRaxDNo6g0JapymWL2CrGk1sqDJ5h5ZM
         cFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085543; x=1728690343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKcY6x98VwBIZfuYWE0CTgk1MQhMRRZsUKeLS0TDxsM=;
        b=sY5lGzn9K9NRBjZMIbIvXrvNKDiytIZSCafTn7Y+qaCVeqgGtzU8WMfWP7AAfzPLFv
         deXS9KsO2r8lOGbBtQR9qNyx5KloYU0RElxd3zrYSadB17o8VQX87ZdJHslczdYY9rVU
         T0mf/erHnXP+L8J8gssSUz7IDF5I6XMGfiREOFzBWB1dVtaolME28kxGHZsWwi7suISD
         Yri8HGWNqaL7J/4GqIlp+5N2LlTErUngJrluwiOsYSiz9QBh2HdYNZQOr73aLS6hCIoY
         Lwrw6ovJ2H3ZuPNF+l9HloN+1XXguMAQcVOd6e9/HGtIQPErSfim21tz7A122W6RnnJ0
         XGzw==
X-Forwarded-Encrypted: i=1; AJvYcCWL2Kwji7tWH0na3OI63sPTzSuTV0t/7SZ8GipRVI1VBjyAPbmKLK5LvQI9263SKDrId1s=@vger.kernel.org, AJvYcCWdjRzO4YPU/PTlJprpAM60dPk9+HUd4crLUQ7y7ZZr3ljBeFhITFx8v23gR7E/yp1FenjWaZz5VbDnn+cB@vger.kernel.org
X-Gm-Message-State: AOJu0YxqFflBV5iACoG9cCfh7hbqdCrdokPixFajjQcEbaLCPx0FmAdb
	qAd6Q5D/9rHK5jy5EElDS1+rLb2p/D6WTRvo8NFhaUL0TsRiquom
X-Google-Smtp-Source: AGHT+IE2/OgCUxjr2/KKwuTZKAbji33Fn0uKCa1pwUQ9KxL72/DlYPR5DFLQKq2bl+asGEq37rYhoA==
X-Received: by 2002:a05:6512:68d:b0:539:9064:9d04 with SMTP id 2adb3069b0e04-539ab873f77mr2528871e87.33.1728085542646;
        Fri, 04 Oct 2024 16:45:42 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff1d152sm84080e87.149.2024.10.04.16.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 16:45:41 -0700 (PDT)
Date: Sat, 5 Oct 2024 02:45:37 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk, ahalaney@redhat.com, 
	xiaolei.wang@windriver.com, rohan.g.thomas@intel.com, Jianheng.Zhang@synopsys.com, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, linux@armlinux.org.uk, 
	horms@kernel.org, florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v5 2/5] net: stmmac: Add basic dw25gmac support
 in stmmac core
Message-ID: <js6s2vwcpqlykbmeqwp4c6ikmb5ctfz6klzxob3qao2mybboox@sz3s3f7qdv57>
References: <20240904054815.1341712-1-jitendra.vegiraju@broadcom.com>
 <20240904054815.1341712-3-jitendra.vegiraju@broadcom.com>
 <mhfssgiv7unjlpve45rznyzr72llvchcwzk4f7obnvp5edijqc@ilmxqr5gaktb>
 <CAMdnO-+CcCAezDXLwTe7fEZPQH6_B1zLD2g1J6uWiKi12vOxzg@mail.gmail.com>
 <CAMdnO-JZ2crBaOEtvgMupQs7nTZ8r0_7TTQdX3B3n6F_owAMZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdnO-JZ2crBaOEtvgMupQs7nTZ8r0_7TTQdX3B3n6F_owAMZA@mail.gmail.com>

Hi Jitendra

On Fri, Oct 04, 2024 at 09:05:36AM GMT, Jitendra Vegiraju wrote:

> 
> When you get a chance, I would like to get your input on the approach we need
> to take to incrementally add dw25gmac support.
> 

Sorry for the delay with response. I've been quite busy lately. I'll
get back to this patch set review early next week and give you my
thoughts regarding all your questions.

-Serge(y)

