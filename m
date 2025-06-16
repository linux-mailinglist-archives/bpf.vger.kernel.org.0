Return-Path: <bpf+bounces-60771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACADFADBBD0
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 23:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59DAC173317
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 21:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393F72153D4;
	Mon, 16 Jun 2025 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ttNpKq/N"
X-Original-To: bpf@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259D82BEFED;
	Mon, 16 Jun 2025 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750108741; cv=none; b=pY9trK+Dmp4br4kJweVRPvrnzx/QINT5sZEJ+OT8hZlVfG6d9C8pclwuzy8MzHAJ9/CAPfL6S5mahQ/FgzU65IbyNTIUurWrzbQP91xNXCGNtoEeGcnheAXJdDicv/5kNgf43P1+O22frS8ytAP5xGvkFMJLuqbNZnVtoUczaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750108741; c=relaxed/simple;
	bh=EorTzHoVc3/xhNMu51TieYCCOxxDeamaIYaQQITc+TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YX8yMd5Iv71Yq7vwzsptAEreLjOzrMhzVR5X2Av0CTk4kKqMpcPRwy8/4D+s3qBu+NZcPl+WCvZQDGpondxqQaETstesaAjT/kPsQNG/PqKqL6vpQtCHX4sJI9Sjfq6GpfnASblDYw0urFUrZL8cJHDLt9ciAinOXjW6/P4koys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ttNpKq/N; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g/eTvuKctPiNU4S+YYDAoBjwAzv9ftGfxRJh7MtARmE=; b=ttNpKq/NPcesTfbq2ajefLrQkK
	41U6T1Mjc2ulBWvT4UAwkm3xkZSFH+t7P8cok05bAaZB23M4tabIjBVgmq8GzSMI8YIBWwTuiCIt3
	HVQaq/ZJjxc0zAdFI5DPeDheLzYtF2eP1Wn8RKK0I0Vv81MqhOClDa27kzB5+zY8V+8Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uRHE9-00G5cV-Be; Mon, 16 Jun 2025 23:18:49 +0200
Date: Mon, 16 Jun 2025 23:18:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Robert Cross <quantumcross@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: fix external smi for mv88e6176
Message-ID: <64029640-9c93-4019-97bc-c371cf14e91f@lunn.ch>
References: <20250616162023.2795566-1-quantumcross@gmail.com>
 <3c5a8746-4d57-49d5-8a3d-5af7514c46b3@lunn.ch>
 <CAATNC474tcoDeDaGg1GKbSAkb8QBT9rcHrHrszycWpQwzU+6XA@mail.gmail.com>
 <ad17b701-f260-473f-b96f-0668ce052e75@lunn.ch>
 <20250616205227.2qmzv2fsbx6j533t@skbuf>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616205227.2qmzv2fsbx6j533t@skbuf>

> Is there any addition to Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
> that we could make in order to clarify which switch families have a
> combined internal+external MDIO bus and which ones have them separate?
> As you're saying, this is an area where mistakes happen relatively
> frequently.

It should be possible to add a constraint. Only compatible
"marvell,mv88e6190" can use "mdio-external"

	Andrew

