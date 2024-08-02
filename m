Return-Path: <bpf+bounces-36305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA58C946339
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 20:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6321C21AEA
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 18:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B44A165F10;
	Fri,  2 Aug 2024 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJpUlwSc"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8321ABECC
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722623231; cv=none; b=nCDi4DUh9NbrfOp95XNAz7BnD7U7t3rku8jML2YvoTp1oV/njqv2BwFzMqEIrGsn3nsshdnygLYtPVREjYEZRSl4as8q+uKywJH/B0Nsw6Lu/XU062xLUXysZ3c+mVdqzMwxI8YUfGbh5Gcg6MOKicMgbZDZf/LKpAKL2NBh+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722623231; c=relaxed/simple;
	bh=YYjY5R5YhqqO7O1jMvVd6hh9M86KxW+gfxX5F9N78FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmwGUmi6B7ckB5VBXHMIB+3oSGGnN9Prg8ICNNTLvDTqQ1ns5Lcw+6JTwsK3y28ZarLMZ9VzK7d3wUaf0PZcsJ0DR3KlcPRO1QDfPkvK4IrW4f+36KTKgLqnvmsXmmjDrK/T7hSRt62fVSYObpgudEpgHpJ5ePhfBkqz8fD6sY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJpUlwSc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722623229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I5miG/LYykrFB6MuC6ZGvL0Cnhqv4tIkWzf6SQErnGI=;
	b=aJpUlwScMMyzxAWPtohXZ0iNbMxzBLtmBQ/4SLVTOqcjKgilUs2SYEJtZ1nKsURSC7FFcT
	27R+l6LlP9raKhH+8TmRWxLvAFDip31eZm0gsbRtqlqGXSC6chuDnO98l/yk4U9nSuk1FM
	nyoM64QNYNhjMpnoI/spZQrVIdEWua8=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-uimXXJu5P6uUzBp0XuuDnw-1; Fri, 02 Aug 2024 14:27:07 -0400
X-MC-Unique: uimXXJu5P6uUzBp0XuuDnw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-709399c7828so12957606a34.3
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2024 11:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722623227; x=1723228027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5miG/LYykrFB6MuC6ZGvL0Cnhqv4tIkWzf6SQErnGI=;
        b=KqOJwDlP3iSAAqGwUOCbUo5B6t9KKYejXxD1cgeqGSFihDk6zJs+lMfoTWvWCHar49
         smnwx4mZUCYA4ZRGpXp0Orc3obAyrhnExtAT7gYZYdNQuXvf21ifqJMt7QsXjsKDyuWZ
         8bNdrL4SaQyoKkiR5nEu/44bIC+aIXndVYxRNZcQNsdj0HQcuZA0bGUK0wEeBZcxD4wj
         z9hm6+GEn9cCPJp0qZcFjbCxkYiGg9S6dMqfI3jQqphhQpqPLzCumoyyUSoHRQfhTxK+
         +c3ORKgX4T8nmhQ3cr5gwUJsGxHaMFkrcvpO0EDVXMXSazNdbKuy8iHbukWBngYCCoWh
         NjYw==
X-Forwarded-Encrypted: i=1; AJvYcCVeZ8twI9oLnV6eLXCjbmaLF6tXasCxv3CI3FBCIQlmt0Oq+XDClARwANJGuzbx11Kbe1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2XHZ1yb64lnDjOjv+7borMSLf6z2ZsOGCZBXrESFfyuES8bBf
	uXRhu3Y5/rwpW1RBfAF5sXbneV4rhNJh5mWaJv371x6UcARh9CBKqWljpzDs17KHZ+n30gXr6qO
	gn2xZaKRJzBv6NxfT6oqr02rt5/RiHCzdZh8SQyvGPAKTc2z+cQ==
X-Received: by 2002:a05:6358:5294:b0:1ac:552:2431 with SMTP id e5c5f4694b2df-1af3ba3b11cmr518709655d.12.1722623227220;
        Fri, 02 Aug 2024 11:27:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH62CCTEL5p+nOIXsMZGz2pIZuf2KqO6SJ7rPhz4HTOaYP+tFTvOeriXu99Z27gU8aDZw+bnw==
X-Received: by 2002:a05:6358:5294:b0:1ac:552:2431 with SMTP id e5c5f4694b2df-1af3ba3b11cmr518707855d.12.1722623226898;
        Fri, 02 Aug 2024 11:27:06 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7972eesm9253626d6.41.2024.08.02.11.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 11:27:06 -0700 (PDT)
Date: Fri, 2 Aug 2024 13:27:04 -0500
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
Subject: Re: [PATCH net-next 04/14] net: stmmac: add infrastructure for hwifs
 to provide PCS
Message-ID: <tffqhorela6brffruxx3rq4cksabzzjrg6zosudqddplv7v6hd@2knfbquqsrmi>
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
 <E1sZpo6-000eH7-Aa@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sZpo6-000eH7-Aa@rmk-PC.armlinux.org.uk>

On Fri, Aug 02, 2024 at 11:46:46AM GMT, Russell King (Oracle) wrote:
> Allow hwifs to provide a phylink_select_pcs() implementation via struct
> stmmac_ops, which can be used to provide a phylink PCS.
> 
> Code analysis shows that when STMMAC_FLAG_HAS_INTEGRATED_PCS is set,
> then:
> 
> 	stmmac_common_interrupt()
> 	stmmac_ethtool_set_link_ksettings()
> 	stmmac_ethtool_get_link_ksettings()
> 
> will all ignore the presence of the PCS. The latter two will pass the
> ethtool commands to phylink. The former will avoid manipulating the
> netif carrier state behind phylink's back based on the PCS status.
> 
> This flag is only set by the ethqos driver. From what I can tell,
> amongst the current kernel DT files that use the ethqos driver, only
> sa8775p-ride.dts enables ethernet, and this defines a SGMII-mode link
> to its PHYs without the "managed" property. Thus, phylink will be
> operating in MLO_AN_PHY mode, and inband mode will not be used.

"only sa8775p-ride.dts enables ethernet" is making this paragraph
confuse me a bit. I think you mean that only sa8775p-ride.dts is the
only device that is upstream and would use the flag?

There's a few other Qualcomm platforms that use the driver, but none of
them are SGMII (and none of them use the flag mentioned).

Otherwise I think this looks good to me.

Thanks,
Andrew


