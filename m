Return-Path: <bpf+bounces-36307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E453946364
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 20:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B7FB22969
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 18:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6819A1547F1;
	Fri,  2 Aug 2024 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRb9hWpp"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4D51547E4
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624734; cv=none; b=vGt0+idWILnqXgupZLNCwfXlWFhmsCMPW7TlkYY8OHG74hH6EE3UE+/P07Tt+f5o6MFl3QLxaRfjl82QyegYmDM4hVXhn9+S3Ta8hyGKpW7xZqneQ6g/mHYkxkV52nC7EHIrXUhkd5+OqchusFu8KdfHjJNiaD2I3o++o2aPf1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624734; c=relaxed/simple;
	bh=Rcqjex2lBU0wKQMtNrMiM+8XWMnqbPa1RsnpSfVQEtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3Pi3gaT3wAsAAOiloMeKixqSIr59zJdDQTloY1F78tnG+eqj8qYOq9YU4qWS6rlBgv2mbbaf8Xf3DAqoDuUNKYWG931zuDsX/yPI9zhZoL8L8qJ+zHz+lpLaqS7KE0f1FZ7PnrD9XffXCSfFqSoZbgcszsyQL0bt3NyRGipYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XRb9hWpp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722624732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CG1jgLVdC2fEObYmK2QTtuJTwCPC+G97aquoLWftjeI=;
	b=XRb9hWppg383RS+ere6szAd/2/5sjb0p3EGdAkPM0TZzkY3DggHROQfzafFTCEUDQULABe
	WuYq9cqlui4tRQg/HMjQSkharfcD0nv6YYzuGoQNETOuhSPWgbMvCgqW8YSdEMTm8kXqO8
	jdCL6u06HZfzUJMPCDLVnNWmXkOn44k=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-NG3TVT7AMTqqCs5HU6vpNg-1; Fri, 02 Aug 2024 14:52:11 -0400
X-MC-Unique: NG3TVT7AMTqqCs5HU6vpNg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-44cde9ed81aso96778801cf.1
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2024 11:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722624730; x=1723229530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CG1jgLVdC2fEObYmK2QTtuJTwCPC+G97aquoLWftjeI=;
        b=kA3uAa394tVK+dlQi8dj2+GR71uZ1SmwgClUlDE72dD7LNxGM2cov9Cwe5vLFpBcWo
         5TjHyJS9wpyhGCHS4Ll9PDGeV8jvkxdq46gRK48GvIbtbRQuTfPRxmCKYtzMG8TLe1ES
         19BU2ZHQ4tsYTqQSsTz7AGboscVKsXuHJNABq/W6f7d9G6bzSosGbpGaH2HMddcgn8Av
         6BrVAifxCMhbtqSbtOonKrm9S0Mg0gL6pB8plokeZPi+JchlWz30U1nZO7WNzmpPVzKt
         YVoeuNylJ+pa7GoL5x+F+ZItLTPr/eYSJCipXaSEcAefWG21Ll0AI8kCDmsVHoJVCLt4
         s0hg==
X-Forwarded-Encrypted: i=1; AJvYcCUlXLKDh2laJnoT0+1qyM1siqqzJaf2LsP2Jcfvu93yHk48+qbrVrvwgS8YgGiArJVj8OvELfbLyTkve2cNIaAyHONd
X-Gm-Message-State: AOJu0Yw3dao0fbR6EOePvdZvOgc7R/MfW4/moZ2Ahy/oNrzmWQfqisct
	ISzlH0a1YqdhixKCq1gsDP97SPhp0c3LT/fN6fNi2I0j6rwewMNrgNiJwnnJWdv2Q7EiYoglUUe
	ya3hpU7LvLVRb1SizUNw5G9klPWgPbgr6H7391AaEa4YGbMvp/A==
X-Received: by 2002:a05:622a:34c:b0:447:d4ce:dd26 with SMTP id d75a77b69052e-451892c1523mr52041201cf.56.1722624730524;
        Fri, 02 Aug 2024 11:52:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaUYKiXGc9VmWENZJ7EtnEJAQEzZy6OYbhTn3EVsmtVqd1bg6xDc1wbjVNcpxbrWR12YCYMA==
X-Received: by 2002:a05:622a:34c:b0:447:d4ce:dd26 with SMTP id d75a77b69052e-451892c1523mr52040901cf.56.1722624730143;
        Fri, 02 Aug 2024 11:52:10 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a755579sm9510731cf.59.2024.08.02.11.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 11:52:09 -0700 (PDT)
Date: Fri, 2 Aug 2024 13:52:07 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jose Abreu <joabreu@synopsys.com>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next 11/14] net: stmmac: pass stmmac_pcs into
 dwmac_pcs_isr()
Message-ID: <eyup477eanpmbgldj63cvwwkwqjshweqrve6u2enyzodoqillw@cuzhm7u37rz7>
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
 <E1sZpog-000eHn-8r@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sZpog-000eHn-8r@rmk-PC.armlinux.org.uk>

On Fri, Aug 02, 2024 at 11:47:22AM GMT, Russell King (Oracle) wrote:
> Pass the stmmac_pcs into dwmac_pcs_isr() so that we have the base
> address of the PCS block available.

nitpicky, but I think it would be nice say something like "stmmac_pcs
already contains the base address of the PCS registers. Pass that in
instead of recalculating the base address again" if I'm following the
motivation correctly.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
> index 083128e0013c..c73a08dab7b2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
> @@ -61,18 +61,18 @@
>  
>  /**
>   * dwmac_pcs_isr - TBI, RTBI, or SGMII PHY ISR
> - * @ioaddr: IO registers pointer
> + * @spcs: pointer to &struct stmmac_pcs
>   * @reg: Base address of the AN Control Register.
>   * @intr_status: GMAC core interrupt status
>   * @x: pointer to log these events as stats
>   * Description: it is the ISR for PCS events: Auto-Negotiation Completed and
>   * Link status.
>   */
> -static inline void dwmac_pcs_isr(void __iomem *ioaddr, u32 reg,
> +static inline void dwmac_pcs_isr(struct stmmac_pcs *spcs,
>  				 unsigned int intr_status,
>  				 struct stmmac_extra_stats *x)

Please drop the reg variable from the kerneldoc, you've annihilated it!

Thanks,
Andrew


