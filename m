Return-Path: <bpf+bounces-36310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6B994638B
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 21:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7661C21101
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 19:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ADF1547FD;
	Fri,  2 Aug 2024 19:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtZf45iJ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A081547EB
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722625356; cv=none; b=uH7I4WWzk/CoNFgiPOxtxub9DrwlPBpuEGFVER/ThUUmFDI0Wc2CLx2t0TKcEnc0+hjI561JE1u4/sqGcpXELiQPtw6GyOAmk3W9Xd2D7FsebJrHMopE67DfzmDp5uuLMOmAldVVkq6GiyQb3BAPP0SgyCrfiU48x65lTqCm+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722625356; c=relaxed/simple;
	bh=XwnlLTMdPliINTV5vAsANgmZhdN+2IjBYhQ9jtQVvcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8SmZmSnbUMqomPxtJ+2M2xThdlTCJEATNs4l6/aZkZzxjCJ2DyTn3PYYt/qPlG51j/aYniie/nKPR5tNzKIjU0Bt17sLrevvTFgk1PnqQLtZRyCizS/sHuGRzIm3BUIN49i7GuTBlxnzXmqNHfNXjZX8SaqCPbb0dluoAiTJTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtZf45iJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722625354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3mGGPNMYW+PwVsxgLN/1XKLLl4dJIQ78l9NLO9EBmCQ=;
	b=dtZf45iJhdhgGkWuJfjTdax6y6XqPpgL20cfxcDwwvcaMrtBnCnBOiFpywasXaEnOYPOjI
	mzRdkXKd/ea7uUYHtuzroxlX6sUfl8VSWG8gOJ/pAmO2XcCzxXrqgnRFYSAhShh72n3h4P
	UrdL6OJI3fI4Ht4pSFET3vjWSOz2Xgo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-BuEiVfxWMIiTgKloNWGy7A-1; Fri, 02 Aug 2024 15:02:29 -0400
X-MC-Unique: BuEiVfxWMIiTgKloNWGy7A-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a1d9a712bcso67126085a.1
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2024 12:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722625349; x=1723230149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mGGPNMYW+PwVsxgLN/1XKLLl4dJIQ78l9NLO9EBmCQ=;
        b=uJS+YOpj5Abb1nY7GtMLRY+n83Xb58ZmX5SIgs78BMcYMYA4kn9fQ+qL8FMbgt0Cw1
         TfQCrwr3V3VSjZeExN6yKWZgNnN582OQY9vT/xDaxklsuuh8FFUMeBhUpGArJHBeIrO+
         3GdXDZbLtniEmHk3qelFaIafxVn66X+40shT1/i0mXOrnsQr5yUZynPTe+VDdXC/chMh
         IEWAUh+6Y39MpsStLWtQoMEOs2mHMuRjA6tVE7atAP02J5HtGhxoDKVEQeZTYKpoZ9Ay
         mPiFm7PL5A0Nt1mEkiVxzqKD7mx2+SUE4OCrIKahyy9q8Wb79PTbbTdYwox7i9iOiICg
         9cmg==
X-Forwarded-Encrypted: i=1; AJvYcCVPazbzvAib/rBMQVHQ85W/xEHPyOxsuiGUxM9sPS18nIhDzOS9wgUvQHYdVp8fMNoemt0Eb8aM6Rg2w7bI4t6pG2Qa
X-Gm-Message-State: AOJu0YyPH8YEtBfCY1krrrnAfVV8sl3sJ4otnYJuCr8GqBDu0D6d+Ohu
	OJGjaj8NX2VxtxKcsM7MjTnrXAAx2or2/TzxdkoSFDm13fKznOqONcw1EW1mYyKA+wkRRpPkUai
	+CVM+VPOUHQWkfRfKVFS3GwpfjLcw5EdTW44h+FSqT5EUSfXF8w==
X-Received: by 2002:a05:620a:3904:b0:7a1:df8e:3266 with SMTP id af79cd13be357-7a34c06899cmr982695085a.16.1722625348934;
        Fri, 02 Aug 2024 12:02:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfNmVNiVUXQYiFVSaa9qpl6QZ/E/1LfvB87rHqYLChQThUb1cOPW5N5oeiv7xY8fOXZ6JvXw==
X-Received: by 2002:a05:620a:3904:b0:7a1:df8e:3266 with SMTP id af79cd13be357-7a34c06899cmr982691085a.16.1722625348564;
        Fri, 02 Aug 2024 12:02:28 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6e7d6esm111860785a.36.2024.08.02.12.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:02:28 -0700 (PDT)
Date: Fri, 2 Aug 2024 14:02:25 -0500
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
Subject: Re: [PATCH net-next 13/14] net: stmmac: remove obsolete pcs methods
 and associated code
Message-ID: <ij562xfhvgxmvpgh2l6rhsvcpi43yvvkvef4wgpjupwusi6uwy@cpnkopeu7cpc>
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
 <E1sZpoq-000eHy-GR@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sZpoq-000eHy-GR@rmk-PC.armlinux.org.uk>

On Fri, Aug 02, 2024 at 11:47:32AM GMT, Russell King (Oracle) wrote:
> The pcs_ctrl_ane() method is no longer required as this will be handled
> by the mac_pcs phylink_pcs instance. Remove these methods, their common
> implementation, the pcs_link, pcs_duplex and pcs_speed members of
> struct stmmac_extra_stats, and stmmac_has_mac_phylink_select_pcs().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 3c8ae3753205..799af80024d2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -321,48 +321,6 @@ static int stmmac_ethtool_get_link_ksettings(struct net_device *dev,
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  
> -	if (!(priv->plat->flags & STMMAC_FLAG_HAS_INTEGRATED_PCS) &&

This change effectively makes the INTEGRATED_PCS flag useless, I think
we should remove it entirely.

Thanks,
Andrew


