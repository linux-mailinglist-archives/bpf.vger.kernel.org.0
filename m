Return-Path: <bpf+bounces-60740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FA6ADB848
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 19:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91E9176870
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 17:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2759C28937D;
	Mon, 16 Jun 2025 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yAPlr+kl"
X-Original-To: bpf@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C9289364;
	Mon, 16 Jun 2025 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750096532; cv=none; b=G19lIr70ysVZNZmE83u02WiNKtUyRxjNFFzn/tRCklhDuD+c10LuYm8v8oRNGFoG7paPtopV1wLka9VvMWXzpjb2WD4qDOWoGjabwezAUx7g1HGAYh6q9e9zvehMyex72E3MJuVDZltv1LFKeLgu9OrtbTy9oxsS5GbNn5WBwh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750096532; c=relaxed/simple;
	bh=ETltWqzLgl/gGq5DSA9Qh1OzqOVZ9m9CvVQjWLVCqjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXX7nk6f8UKqfpNrZgx9SoottUAjeRSpDDw1cDEsWdz+nJnSClNXqm+oGq90HP3gs0jvU5DQPhn4flF8u8nwTQJbkGR+NrfpEiAl5Sixj6ool5vJpaRhngwurk5rc00qOdERQE9SS9YVMlcuqEhq3NUXF96g2Fl36QqOxNp5QmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yAPlr+kl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BcRhhx5dTEuRo7XGCUmzhFAayyoMnb2ih2YZjt2sEiM=; b=yAPlr+klWyZ635cfgEbu+zwi9X
	km4KVSIyoJSyZ/95n8TCxREkaa6+xdTfskFRLhlG67kVKaoJ6LzCz+Pg1sqfUctMBQadV0nSyyR43
	c0+qRbALrHHvoaFhpTtMoJHvu2cB8uUR3Yp/G6acyCJazL/rKCM3vOoJC+AEzGThUr4g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uRE3F-00G4ZV-WF; Mon, 16 Jun 2025 19:55:22 +0200
Date: Mon, 16 Jun 2025 19:55:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Cross <quantumcross@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: fix external smi for mv88e6176
Message-ID: <3c5a8746-4d57-49d5-8a3d-5af7514c46b3@lunn.ch>
References: <20250616162023.2795566-1-quantumcross@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616162023.2795566-1-quantumcross@gmail.com>

On Mon, Jun 16, 2025 at 12:20:25PM -0400, Robert Cross wrote:
> (Sorry this is my second attempt, I fixed my email client)
> 
> I was trying to enable external SMI on a mv88e6176.

        MV88E6XXX_FAMILY_6352,  /* 6172 6176 6240 6352 */

So it is part of the 6352 family. That family does not have an
internal and external MDIO bus. It has a single bus which is both
internal and external.

It is only the 6390 family and above which has two MDIO busses.

    Andrew

---
pw-bot: cr

