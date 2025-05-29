Return-Path: <bpf+bounces-59222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F7CAC7511
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 02:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DC257B1F36
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 00:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE0628399;
	Thu, 29 May 2025 00:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stku6XPU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8628FF;
	Thu, 29 May 2025 00:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748478188; cv=none; b=ees6qbAZCob0Zxx4IalBr96U+/WJyyUX34x11oeeakXCAL5TRb8RRBLlNfCRL8QEqjh8tZqWNrBLjnr3AgB7Yy5gibbRMwc3PF1LJJU7S4objkC1CzSTpvTujqxX/bKerDHj0chy1WqKio8fNRkkxdH2JTyjFHnL6tyHE84JnfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748478188; c=relaxed/simple;
	bh=YL/MCDVOQdyzpgzoixJs0Qwj1/oOVGX+VAX6mD/kWLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9Xz9p4osyoLxQUR7bXEjsI4ZTIntAk0mdW3MNft0ikws1KTmStQczUsxccjBMWa6UZyF1vmV8I81n88XPg8BGReOVKrts15bb/uoY7Ew1XdiTyXX99LoHjJDJC3ZyRAXZmbaOSJWpzFEPhpx9orFGl0qbR6D5zjOnLKHVgmTTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stku6XPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8B6C4CEE3;
	Thu, 29 May 2025 00:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748478188;
	bh=YL/MCDVOQdyzpgzoixJs0Qwj1/oOVGX+VAX6mD/kWLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=stku6XPURgSvdEIz+xuO8mtU9B7POoboSNDw9e8fmEAQxwAlgv95hAm9g0GoXdl4B
	 F3b0wotb8jouCZT/ILHSeSnz1i5Q3cw3cWv3vukyDUq/cD8ayhqQFjuTw9H2gAH6cL
	 oGCjFoX4t1FRB41yBoMYAVgQQ9VdPuaKb+p/xKpFkMhPxqxwSKoTKJTb/Qt1yW9kn5
	 61KtCcYeFVSxRfxWlvL15LnFYfGuXt6dtzZmvCE8NQIinoL3KaSrb09gPpkzoUCB/D
	 pZXWgo3lVLYsHT4wls9tIDbokGSzUPYRBXDdAo8pfjJmVjpbmZKsxY6W+88TK9LfmB
	 9YPqXN67tX8OQ==
Date: Wed, 28 May 2025 17:23:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 michal.kubiak@intel.com, przemyslaw.kitszel@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 horms@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 01/16] libeth: convert to netmem
Message-ID: <20250528172306.18c1482a@kernel.org>
In-Reply-To: <CAHS8izPope_UOF7saHHxaJSgqHWJWZvEKmp=0x6sB2OJAghqUw@mail.gmail.com>
References: <20250520205920.2134829-1-anthony.l.nguyen@intel.com>
	<20250520205920.2134829-2-anthony.l.nguyen@intel.com>
	<20250527185749.5053f557@kernel.org>
	<CAHS8izPope_UOF7saHHxaJSgqHWJWZvEKmp=0x6sB2OJAghqUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2025 20:49:33 -0700 Mina Almasry wrote:
> > If you don't want to have to validate the low bit during netmem -> page
> > conversions - you need to clearly maintain the separation between
> > the two in the driver. These __netmem_to_page() calls are too much of
> > a liability.  
> 
> Would it make sense to add a DEBUG_NET_WARN_ON_ONCE to
> __netmem_to_page to catch misuse in a driver independent way? Or is
> that not good enough because there may be latent issues only hit in
> production where the debug is disabled.

Yes, DEBUG_NET_WARN_ON_ONCE() is not ideal. The condition may trigger
pretty rarely, and what are we saving? A single branch per packet on
a HW-GRO capable device?

Isn't the netmem vs page confusion here primarily because we want to
use the same struct to hold head and payload pages?

