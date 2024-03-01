Return-Path: <bpf+bounces-23155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA9D86E5F0
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 17:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7FB1C22DC1
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 16:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7263D996;
	Fri,  1 Mar 2024 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3YIQ5ysi"
X-Original-To: bpf@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730203D3A5;
	Fri,  1 Mar 2024 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311132; cv=none; b=bH7v/8yhu3KTQb8vHdtywovflEhSxlqGpcZXW+mdrPN3K9XxRG3NLUfqzdmZdcV855EAHX4jWXIONaXEIsJFhzAYfXEdChVjKx6K84+t8H7IOjVcQPNHm0B/WXXXta+P/gx3coGkIU4mugGvFGVfesk6pL8lF+Z8Ysjnt5QZNbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311132; c=relaxed/simple;
	bh=eL5TPpLNmcEF7z0b5oJm33J07+5avJ6cc/lCJ6PzZho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF30BKT9jHpIxMXyOcdQ8XQwzg3Y0F/DkOr/w4jT9qg/caR5Jerw1d/tQZAsQbxVJ0afV7qbycBagn8QdzSjUMMEdX2UCJ0midJ/39DE2RfSl96YQ8PmNWDktPAYsppkepYzCMowfmcC3ML4MURHTgziYcvVykNfiNnZTmA/NPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3YIQ5ysi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xF6ky7oGAXgVDPcd5CPKgoDjtno54lJ8yY7B4W/SIV0=; b=3YIQ5ysiupGcrc8xo42VBnaT79
	x4yFp4+0mNY9jAn2RkFxS5FMXLbF27o+73niCZhgoHwbKhuyStc1I5vwGAcNBq99krOB7wfV6eeBx
	DKIPEHDZTnnSOPUXdB0kztGSw+DDhdqjL/jpQYK67rqOqnOcAFEbvocSpreTUBFv2uH0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rg5uS-0099W4-Ff; Fri, 01 Mar 2024 17:38:56 +0100
Date: Fri, 1 Mar 2024 17:38:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Julien Panis <jpanis@baylibre.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 2/2] net: ethernet: ti: am65-cpsw: Add minimal XDP
 support
Message-ID: <356f4dd4-eb0e-49fa-a9eb-4dffbe5c7e7c@lunn.ch>
References: <20240223-am65-cpsw-xdp-basic-v2-0-01c6caacabb6@baylibre.com>
 <20240223-am65-cpsw-xdp-basic-v2-2-01c6caacabb6@baylibre.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v2-2-01c6caacabb6@baylibre.com>

On Fri, Mar 01, 2024 at 04:02:53PM +0100, Julien Panis wrote:
> This patch adds XDP (eXpress Data Path) support to TI AM65 CPSW
> Ethernet driver. The following features are implemented:
> - NETDEV_XDP_ACT_BASIC (XDP_PASS, XDP_TX, XDP_DROP, XDP_ABORTED)
> - NETDEV_XDP_ACT_REDIRECT (XDP_REDIRECT)
> - NETDEV_XDP_ACT_NDO_XMIT (ndo_xdp_xmit callback)
> 
> The page pool memory model is used to get better performance.

Do you have any benchmark numbers? It should help with none XDP
traffic as well. So maybe iperf numbers before and after?

	Andrew

