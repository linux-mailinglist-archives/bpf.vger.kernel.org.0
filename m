Return-Path: <bpf+bounces-60743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686A9ADB8FF
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 20:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564A717320F
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 18:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C90328983C;
	Mon, 16 Jun 2025 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hbaXuxdL"
X-Original-To: bpf@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48202BF01B;
	Mon, 16 Jun 2025 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750099403; cv=none; b=hc5zk93ahYJ/UlAoogN1l2o1olotnCUlCr9mgbUV5UOWwN2gJRewz0bTW87CWRN72P5jxiw6tVoFCd+/Zqtb1exaPd88sTFiiDVB7uHRN9IhA/0uwG5Y9V/DE94amvTDLRN1O3U+pRfalmuovBHcwcUxkfyMSf39/Z+p9O1llHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750099403; c=relaxed/simple;
	bh=hyz4UlQOVcpnYwhNY50GmQyB7XsFaFwF4djvKGlJ+Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAlHX/mNwf7HbFiOl/IEltXX6beDOU2oLbcn/kUlMkIVdSzW3ClwLRLXlYd5ST9p3RMlXh0sggWgcJr6VnuBN9MCE6vdAPf0uiqteK8/vB9A+23UvHmjdvbezWQVljkkDnUFRFBfaoUM5hD9RN6qa/Pf1boFGAYYDc/DTri0egQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hbaXuxdL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IiEwlTScU5cid6i9CD5yIyW5q27HQ/F9m+9xZgXpzoc=; b=hbaXuxdLYqAbSuiu5l13fe+2mC
	kJcYI1TCeUZ4QVINdYmIz0WwVYHFbNfq0EZspPvz/tsSahNRGfEWcFzYuhQJKCveWNHzqGMyf4Hyt
	GxQI+83KVUk9Ycca7/Sk7viY36HjocOe09pYA8+yg4LOjTKOtms7l83oxc1T1Bly/l80=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uREna-00G4rf-2c; Mon, 16 Jun 2025 20:43:14 +0200
Date: Mon, 16 Jun 2025 20:43:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Cross <quantumcross@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: fix external smi for mv88e6176
Message-ID: <ad17b701-f260-473f-b96f-0668ce052e75@lunn.ch>
References: <20250616162023.2795566-1-quantumcross@gmail.com>
 <3c5a8746-4d57-49d5-8a3d-5af7514c46b3@lunn.ch>
 <CAATNC474tcoDeDaGg1GKbSAkb8QBT9rcHrHrszycWpQwzU+6XA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAATNC474tcoDeDaGg1GKbSAkb8QBT9rcHrHrszycWpQwzU+6XA@mail.gmail.com>

On Mon, Jun 16, 2025 at 02:22:43PM -0400, Robert Cross wrote:
> According to the documents I'm looking at, the 88E6172 and
> 88E6176 both have external MDIO buses. I have brought up
> a board with two connected 88E6176 chips, each with a PHY
> that can only be managed with the MDC/MDIO_PHY pins of
> the 88E6176s.
> 
> After applying this patch I was able to successfully manage
> and control these external PHYs without issue. I'm not sure
> if you have access to the 88E6176 datasheet specifically,
> but this chip absolutely does have an external MDIO.

You are not understanding what i'm saying. This family has a single
MDIO bus controller. That controller is used by both the internal PHY
devices, plus there are two pins on the chip for external PHYs.

All the PHYs will appear on that one MDIO bus controller.

The MV88E6390_G2_SMI_PHY_CMD_FUNC_EXTERNAL bit is reserved on the 6352
family.

	Andrew

