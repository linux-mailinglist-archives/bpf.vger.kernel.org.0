Return-Path: <bpf+bounces-27100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEA78A9089
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 03:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5020B1C21B44
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 01:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C0F8F59;
	Thu, 18 Apr 2024 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZzkrlj9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47F93BB3D;
	Thu, 18 Apr 2024 01:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713403056; cv=none; b=MWiaO+2TMaURsf0Lc5VcJ35IY1SvEiqEMekyPTgb88xm87nFPJlH2kqkjTnVhQVWHme7KfXO/Wh48QXujtKzkFpGUuhEX/LRUu203duwhyEjg0Tb7HBgpIQXLKZislcipv0FGL/9LvscUvYq0okgqUJAe6cvjDsRSTm6A8hOvDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713403056; c=relaxed/simple;
	bh=hdVD2zmDhEeyC9WhL+5xWGr2WwLsDZg2E07WnEotBVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwoBgvqXuBOMZIAaABGHz1/bCZk1Wd6AbSeDxdJiDJ0SvPc++hyxbPCUM8nq4m+y2DSwK7OkdQP2f+68wb7STeQq5Yjoz10mnhQ8RFerieX8p5jNOpr7OpBfSCm+TIq/ro54SHXsGj/KuvqqXUyfEGS30jJ9Xd/emWnRlKNcDFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZzkrlj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5B1C072AA;
	Thu, 18 Apr 2024 01:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713403056;
	bh=hdVD2zmDhEeyC9WhL+5xWGr2WwLsDZg2E07WnEotBVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uZzkrlj997OCf0jAfiVQA8ukfS+TJla4TktiJ+SHNn05x0DrvMxax8TTc8H5cDetX
	 m0d1HhErMSoIe9B+JkZSrQLHeXDJf7+lUETuEZiUupJ1NrHvptYOfxhepUM+O+RsLp
	 tw32M2fLQImd5vfisT4+6assR7YxEQjInGq90/dWwUSFiWJAGIe3UA0ua4w1i84Tar
	 YQ314BrKPS+U8ysgR0HPE2fEx6s1ppLbPHW4Q9875l4jndKFi5tHOS9F677Fchscvc
	 0Zi1hBRHny/3m6C5teIkcRt9g2LdZo+KWK8+Vm5/kO23MyJDhs9wZS4etB4ZptOjRk
	 EBhLUhF/kfMeQ==
Date: Wed, 17 Apr 2024 18:17:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Camelia Groza <camelia.groza@nxp.com>, David Gouarin
 <dgouarin@gmail.com>, david.gouarin@thalesgroup.com, Madalin Bucur
 <madalin.bucur@nxp.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v4] dpaa_eth: fix XDP queue index
Message-ID: <20240417181734.7ebc844f@kernel.org>
In-Reply-To: <20240411113433.ulnnink3trehi44b@skbuf>
References: <20240410194055.2bc89eeb@kernel.org>
	<20240411113433.ulnnink3trehi44b@skbuf>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 14:34:33 +0300 Vladimir Oltean wrote:
> On Wed, Apr 10, 2024 at 07:40:55PM -0700, Jakub Kicinski wrote:
> > On Tue,  9 Apr 2024 11:30:46 +0200 David Gouarin wrote:  
> > > Make it possible to bind a XDP socket to a queue id.
> > > The DPAA FQ Id was passed to the XDP program in the
> > > xdp_rxq_info->queue_index instead of the Ethernet device queue number,
> > > which made it unusable with bpf_map_redirect.
> > > Instead of the DPAA FQ Id, initialise the XDP rx queue with the queue number.  
> > 
> > Camelia, looks good?  
> 
> Please allow me some time to prepare a response, even if this means the
> patch misses this week's 'net' pull request.

We're getting close to the 'net' pull request of the following week :)
The bug has been around for a while so no huge rush, but would be nice
to get rid of this from patchwork. If you don't have time - would you
be willing to repost it once you found the time to investigate?

