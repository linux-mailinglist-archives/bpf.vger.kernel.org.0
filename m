Return-Path: <bpf+bounces-57233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B57FAAA75C7
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 17:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8FA1C0067F
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 15:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7AF25744F;
	Fri,  2 May 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bzjEV31S"
X-Original-To: bpf@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4225156C63;
	Fri,  2 May 2025 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746198784; cv=none; b=rUuJX5IqnORmqRJWPVoDZ90fUGKY9I4TVuUamx7Dxn9uAAW1WOjBXwaycE0OruuisskIYDEu4WIiA3dp91xfjz8V3rvnacaG5ccdJmyTWjkJbJmc/s5ukg12I1xZfVRmaBsMMp3495UgzM0N+SCxM0f5tLyG2cRi6ESRBBixU10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746198784; c=relaxed/simple;
	bh=xmWxSbIiULa+dGRv78x048z73PCtbqfsltgmeXC2Ikk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjOp23Ab+Tg6/69tR66dnUhhLyyD0faYWjZu8A/gasCSRUe+2wovdhnE0YlC4oezDGe1pEBtsdh8xhPiwgBsxLJe3+lIcFwh1aJhlTNE+OYWjqZ8OldhTTN7H1VtHz9KnnkeWQstnhtyAal6NCCk20idcq1smu26OHjoP3F7PzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bzjEV31S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=S4QrZn7G9AyQWEUh1I8MyKnl0p8w7wxzIcJeaCxPRA0=; b=bzjEV31Scwknwcg6kWhaXCChj2
	ERZ2nGENpucdIwMgEq/RJNndyElFrYGL5PHnn/L6r1LofmILNRhbvKVbbtPIrrGfsYsro5lSGYbtf
	gUoDQJWgybSKOOP1WvJsA8m3OSk81ovtdhHkalK67EaeK6C+8BDp5hOGUZI+2oiQMLqM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uAs4F-00BQj3-VJ; Fri, 02 May 2025 17:12:47 +0200
Date: Fri, 2 May 2025 17:12:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net-next v2 1/4] net: phylink: add ability to block
 carrier up
Message-ID: <bd95b105-4cae-460e-a5ee-5a30e9558d3f@lunn.ch>
References: <aBTKOBKnhoz3rrlQ@shell.armlinux.org.uk>
 <E1uAqY7-002D3e-R3@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uAqY7-002D3e-R3@rmk-PC.armlinux.org.uk>

> +/**
> + * phylink_carrier_block() - unblock carrier state

It seems like a cut/paste error, unlock should be block ?

    Andrew

---
pw-bot: cr

