Return-Path: <bpf+bounces-60642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F52FAD995A
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 03:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBAB1189658D
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 01:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F8122EF5;
	Sat, 14 Jun 2025 01:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bz/vwUnT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55788836;
	Sat, 14 Jun 2025 01:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749863357; cv=none; b=Q3nh6LI7e2Lsyf7xgL78ETx0/t9IavXrHIBCYEOVRUKFx95jCD9PaKGpEO9BGji06jtTWs7n28gSO0fAzQFDpzCQ8B1JMptb1RTI1+nuNKagOYrnROiZ9dVbzs6Ka4Sd5OwwWvAN86G1sdv/Lz8NoQWmk/l/gUt7hArhQwGyWrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749863357; c=relaxed/simple;
	bh=bhtNPk++UTQ57VyxrddQMBBkJ5x/UxyRvLf25/kjd70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCyZGW2v8RirFF4qEji1nIcOmRB+NnOAeacftIWH7gHiZCdBtTsNFZ0NzBDSTfB3iHA/RqMQY2pjyi4POc5fqCKEGh0eF+q3gVbn9Hs5VbF17dT64tHy+bElHszazgRKZ8UKzOGCsQCds3Z7N0JhLJzyYpSsYHz7wxhIwh7I9nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bz/vwUnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89251C4CEE3;
	Sat, 14 Jun 2025 01:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749863355;
	bh=bhtNPk++UTQ57VyxrddQMBBkJ5x/UxyRvLf25/kjd70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bz/vwUnTuREj01l1K5Yg4O5PrHNSbSGqSUZ/j2791RYV5RdQqzU7jtKPMqT5T/LsJ
	 MPYwhXrRvnxink30KLqMS3u6ntB6hn9292WO+o1ftk99LBzHCWUzA/T4+hQ+zg4ZVK
	 iML4jVb6MtRh+gY4DTsePsy3IkKtNwaxTE321Rm8YvQiPGsXbFMNA1LCKPH/LUdmE0
	 qnBQhbTouiDveKhMPVknuBk64c/PZjv9XJ06gUNrKhHKjPxLshSrqnRj7j9qKxem1O
	 tqk8mPG8OuhooASwcPgvpjokVhX+eUxaS6mzMLhGF6iUU1z9qCGOpLeqaReSCv1oki
	 1fd7zmF96gZow==
Date: Fri, 13 Jun 2025 18:09:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: <namcao@linutronix.de>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
 <daniel@iogearbox.net>, <ast@kernel.org>, <pabeni@redhat.com>,
 <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros
 <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix packet handling for
 XDP_TX
Message-ID: <20250613180913.5e164263@kernel.org>
In-Reply-To: <20250612094523.1615719-1-m-malladi@ti.com>
References: <20250612094523.1615719-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 15:15:23 +0530 Meghana Malladi wrote:
> While transmitting XDP frames for XDP_TX, page_pool is
> used to get the DMA buffers (already mapped to the pages)
> and need to be freed/reycled once the transmission is complete.
> This need not be explicitly done by the driver as this is handled
> more gracefully by the xdp driver while returning the xdp frame.
> __xdp_return() frees the XDP memory based on its memory type,
> under which page_pool memory is also handled. This change fixes
> the transmit queue timeout while running XDP_TX.

Makes sense, but since this is a fix it needs a Fixes tag.
Please add one and repost.
-- 
pw-bot: cr

