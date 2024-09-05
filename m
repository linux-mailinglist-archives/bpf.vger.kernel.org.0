Return-Path: <bpf+bounces-39074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B1E96E48E
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 23:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74E91F247B3
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 21:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB8E1A7247;
	Thu,  5 Sep 2024 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pXH6V6bc"
X-Original-To: bpf@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A6F1482E9;
	Thu,  5 Sep 2024 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725570051; cv=none; b=lOd2z29ReYhbyWZhnddIdXt0Cjr1FesQU0/WPZMszQNTi6n2VyOxAiGi5xhaNqh1HTk2JjGSVwqLymNB7heyxrSxXYO83Kpseo0YkH7VCvIQtMN1xhsrNweCTIphehrnpU0PEakg5mE79e8N54psGFHge9mPi7dwf7XxIV0d5jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725570051; c=relaxed/simple;
	bh=KlfAvtMF00YOHgTJgo5TB9HvX1pyn4mIVaQBIC8dw20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHwz7gOnmUxkZdmGtMBw83Od00+5rKXhfKQgkWfwEKOvF2wbwS5px3nUCgcVy/JYcUpkzhm9DHA1Dqh1ZAj+/vfj2UL8hRn+iRG+9FOzmEvxtIW92lmk7f2HyMbVKZY3JIaxQ4K7qJhKbM4a98C2yElbPEM0eZhTCylDZN9Oe1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pXH6V6bc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WbWr0XRpQTTDvAyFVlPD9a+Zk1UsmCoPtLyHWXYg/To=; b=pXH6V6bcN1Aq5spf9KlHa4sVr1
	6C3R/fBq9Ej4md+cXJLQvqCzCwgksA6rmp0AQU7mLGOi//ib0Qo+cunHkPyYEDYD8JpAMkOHnxUS0
	FCH8k0WAnS2/FrptJrOtrJvngwBQeGwvKgqSwPeQa/jYYqSryUPBE1wamfezqffI+v64=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smJah-006ikm-Hd; Thu, 05 Sep 2024 23:00:31 +0200
Date: Thu, 5 Sep 2024 23:00:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sneh Shah <quic_snehshah@quicinc.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RFC net-next v4 00/14] net: stmmac: convert stmmac "pcs"
 to phylink
Message-ID: <74f3f505-3781-4180-a0f3-f7beb4925b75@lunn.ch>
References: <ZrCoQZKo74zvKMhT@shell.armlinux.org.uk>
 <rq2wbrm2q3bizgxcnl6kmdiycpldjl6rllsqqgpzfhsfodnd3o@ymdfbxq2gj5j>
 <ZrM8g5KoaBi5L00b@shell.armlinux.org.uk>
 <d3yg5ammwevvcgs3zsy2fdvc45pce5ma2yujz7z2wp3vvpaim6@wgh6bb27c5tb>
 <ce42fknbcp2jxzzcx2fdjs72d3kgw2psbbasgz5zvwcvu26usi@4m4wpvo5sa77>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce42fknbcp2jxzzcx2fdjs72d3kgw2psbbasgz5zvwcvu26usi@4m4wpvo5sa77>

> Hmmm, I'll poke the bears :)

Russell is away on 'medical leave', cataract surgery. It probably
makes sense to wait until he is back.

      Andrew

