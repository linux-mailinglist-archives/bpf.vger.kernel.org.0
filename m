Return-Path: <bpf+bounces-30715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863658D1B0B
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 14:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4D91F236ED
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 12:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B340516D4FD;
	Tue, 28 May 2024 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiWP9to7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A013E74409;
	Tue, 28 May 2024 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898967; cv=none; b=mdFuct3OPkXk8hu5OBKAcGmCWymaS67GRkTw9ruA+QLmugpPINe4QiFxA3Sz53O2tfpfxfkdYf2wPxVd+Nu7muZYBNo4X+y0aWyTarQlkA+/VwZw4ejw0/jDAnLkQ3OEC7FDBUF8ZqXqNzR66j3dpkj8wartGs6xwhCd99Azctc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898967; c=relaxed/simple;
	bh=1bxpJkJTAuic/fEmME52PUTrYmhkNBSpSDXr2ojsc7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnTPmw8YojPaamICGBVj9NOcTwy7RhzUEWNkLbgoiZlLdNj2YWj5IReuik3tvkr6BFYKg/qFmTYG9MaP1hLnBUmhN6AbZYKZqIOrASj1WjcuO5Z9FuwZZCOD3qWGcsMCQ47ef0poJav78bwOVf/u1znA/pmsJiTN+5K3PJqdXCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiWP9to7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-529661f2552so969003e87.2;
        Tue, 28 May 2024 05:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716898964; x=1717503764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=30d0TTe0qu/2T+a0CP2Ht/sekYc/5hfNw/7/ZEtYxu8=;
        b=XiWP9to7IFMPMEwMVWyuNamCW2AhljULMH0OE+mg44H7qr4kpYnUL08Tp+FXTE8Lbp
         B+1Y4SEEG+UlBlUORgIf7onkSfpLIjQrGPh8HHjmfmM0dNefHmQvnZH3nwji55WaLBAf
         +Oipm+gNzKC6c503rRe1C96Y4EfpHJ5OqCAcdlpF/mEuFmTv8UKNZodz4u0BZ2xfecfq
         8eaEGHh8RQrC0hRXRJgGbZx3YdBVnKhdxr1HUuTuJ+y1wpzyGm0ex1llAMqh669qJqhF
         //MbFxY4EgNUEoQ8LuFoVHPBBrNdKQTrGsvEGnk8gxnG6+AvRNiTJj6Me+S4e9tpv7c9
         zI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716898964; x=1717503764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30d0TTe0qu/2T+a0CP2Ht/sekYc/5hfNw/7/ZEtYxu8=;
        b=gmNgGZ7wZRvi6A+m+m9CGZWDd9n+TcY21SWNWLyD/oQC03M9oL5AEHjVvDAhAsWPUu
         8MXJjXn5/PtIF+kLVI70I9G7+PsbYAM7f4Euq+5vkWAmHAbEGvCnnOeSuzjVA4n7ML7N
         kSlMTIcP4eWDhRBZUMhLqxqhtxZaP6X2Netm9wBJBlT8dSdtSaVStLaYfdvPE8ZjIU9q
         mSrWpUsuqL7Eb+FmCZWu2vVIVVE4Yo4ZZf6PmsMvpUm7KgmQtQ1l5EVim6jgFArlMcZg
         BMfcpXnqkQ87G0QYbQ1K8FI2vUyDe+4MO9fojwQ+pipsX9TU7zLdPHLj8OOq11yI9ymf
         9iyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn3zJE10QsQoGBesvH4wriei/+TDF/3AsG6hSSeZ9Hda3CBaGW8egTjkixFtpCa+VRERTnYGTBOfFfxjiP6wnKYacETDi2Llwv0n/PfLMUO/5TuYF+zfVKYhiKGzcgBwRrWmM+ORXE1EG+eYWdNSC+nPq/znfZxint
X-Gm-Message-State: AOJu0YwI3+frBebg8wUClyNI3SCs/7LNl8JM0KNKTLB8O+etbD2+Fn6u
	G5AryOLLA3Rt25I4leysEZ6WsT88ndDGbOC6S4ZxGMvs0vd+R3tO
X-Google-Smtp-Source: AGHT+IEFpxm72+ZufBEpOzTdYaIOWqK1qFRYEzUeMkVy/VVpK/unVesitw9GPmLNPR4IWW5XCaPpGg==
X-Received: by 2002:a19:5e04:0:b0:51a:f84d:1188 with SMTP id 2adb3069b0e04-52964e93a0dmr7396162e87.19.1716898963461;
        Tue, 28 May 2024 05:22:43 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5296e888b33sm920102e87.8.2024.05.28.05.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 05:22:43 -0700 (PDT)
Date: Tue, 28 May 2024 15:22:40 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Byungho An <bh74.an@samsung.com>, Giuseppe CAVALLARO <peppe.cavallaro@st.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 2/3] net: stmmac: Activate Inband/PCS flag
 based on the selected iface
Message-ID: <mflda2pvhiilceh4qkyq43jedgx3fxeo7mbs2cfa5c44veygg2@muhwd4gj5mth>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
 <20240524210304.9164-1-fancer.lancer@gmail.com>
 <20240524210304.9164-2-fancer.lancer@gmail.com>
 <ZlNoLHoHjt3BsFde@shell.armlinux.org.uk>
 <fvjrnunu4lriegq3z7xkefsts6ybn2vkxmve6xzi73krjgvcj6@bhf4b4xx3x72>
 <ZlWwMzMZrwb5fscN@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlWwMzMZrwb5fscN@shell.armlinux.org.uk>

On Tue, May 28, 2024 at 11:21:39AM +0100, Russell King (Oracle) wrote:
> On Mon, May 27, 2024 at 12:57:02AM +0300, Serge Semin wrote:
> > On Sun, May 26, 2024 at 05:49:48PM +0100, Russell King (Oracle) wrote:
> > > On Sat, May 25, 2024 at 12:02:58AM +0300, Serge Semin wrote:
> > > > The HWFEATURE.PCSSEL flag is set if the PCS block has been synthesized
> > > > into the DW GMAC controller. It's always done if the controller supports
> > > > at least one of the SGMII, TBI, RTBI PHY interfaces. If none of these
> > > > interfaces support was activated during the IP-core synthesize the PCS
> > > > block won't be activated either and the HWFEATURE.PCSSEL flag won't be
> > > > set. Based on that the RGMII in-band status detection procedure
> > > > implemented in the driver hasn't been working for the devices with the
> > > > RGMII interface support and with none of the SGMII, TBI, RTBI PHY
> > > > interfaces available in the device.
> > > > 
> > > > Fix that just by dropping the dma_cap.pcs flag check from the conditional
> > > > statement responsible for the In-band/PCS functionality activation. If the
> > > > RGMII interface is supported by the device then the in-band link status
> > > > detection will be also supported automatically (it's always embedded into
> > > > the RGMII RTL code). If the SGMII interface is supported by the device
> > > > then the PCS block will be supported too (it's unconditionally synthesized
> > > > into the controller). The later is also correct for the TBI/RTBI PHY
> > > > interfaces.
> > > > 
> > > > Note while at it drop the netdev_dbg() calls since at the moment of the
> > > > stmmac_check_pcs_mode() invocation the network device isn't registered. So
> > > > the debug prints will be for the unknown/NULL device.
> > > 
> > 
> > > Thanks. As this is a fix, shouldn't it be submitted for the net tree as
> > > it seems to be fixing a bug in the driver as it stands today?
> > 
> > From one point of view it could be submitted for the net tree indeed,
> > but on the second thought are you sure we should be doing that seeing
> > it will activate the RGMII-inband detection and the code with the
> > netif-carrier toggling behind the phylink back? Who knows what new
> > regressions the activated PCS-code can cause?..
> 
> If it's not a fix that is suitable without the remainder of the patch
> set, this should be stated in the commit description and it shouldn't
> have a Fixes: tag.
> 
> The reason is because it wouldn't be stable kernel material without the
> other patches - if stable picks it up without the other patches then
> it could end up being applied without the other patches resulting in
> the situation you mention above.
> 
> Shall I remove the Fixes: tag?

Let's drop it then, so not to cause confusion for the maintainers.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

