Return-Path: <bpf+bounces-70846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A82ABD6BB1
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 01:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BF8407D94
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 23:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D882D1F40;
	Mon, 13 Oct 2025 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nROSE5Zy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7266B212568;
	Mon, 13 Oct 2025 23:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760397851; cv=none; b=hNgGcON5UyahAwm3g8YZpMLPDMfBGeoGn2RlezBZaV0x1CVZklgqv23JsmmLw2IlId7gRxJLru97vlD5yZtrOnzTwXnP53C2FzhJpgKNI8vvPvQo2nBKjqiCFWPGZZUVV/gk3C9oCuFoZgacVospUJrpp+WyWV4hUBbtw6hjgQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760397851; c=relaxed/simple;
	bh=OlgIFYFeDTBEFJyCU3V/NcNggTUnGjnS11P+1JreIQc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1KyyIvhGWfjkYMRqnmG++pWj/7/qp1u+BvG8X6sFhhuVUnNGFACpyGzrvHaq1wXRXGPPyN/tLfHuQSJhaKAgsw26KfjQiz4972/zVMZjvMxVqRqq6900u49TttBreLwc9VsuStEEFGkyYXlxCBELOl9kw4fpfIP4D0Q/rAH0i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nROSE5Zy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6860DC4CEE7;
	Mon, 13 Oct 2025 23:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760397850;
	bh=OlgIFYFeDTBEFJyCU3V/NcNggTUnGjnS11P+1JreIQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nROSE5Zyx8lMmZ+mnIYKYPJetjBT+xeVkRF+fE4mIY0IW6BSDVc/RWGIrihX4A4LE
	 XKGBA8hPRUxOz8J3PQiiwVZfP5lELRlI2ao53dDhkTdVyL0flSNxZhDWXPmk47t8VE
	 iZCAf1VjSvmwYAV+OSKW62H1AvZTpSyTMHfnAeDczXhnGdUsdi6w2HqoQhvYFizuF6
	 H1gPl0wDdi/N5eQLWcXX/iun26hcbMEiayJCiHBgdIyhw8mH12JVcfdTHZ1KGzUG/P
	 RebUGyvu1NCGzZpuxqk2WddvJsYNN0hogjV3oSTOQuRQqUb+fNg/pwduooC+KUvh+0
	 kQk3mCCO5Tjeg==
Date: Mon, 13 Oct 2025 16:24:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <toke@redhat.com>,
 <lorenzo@kernel.org>, <netdev@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <andrii@kernel.org>, <stfomichev@gmail.com>,
 <aleksander.lobakin@intel.com>
Subject: Re: [PATCH bpf 2/2] veth: update mem type in xdp_buff
Message-ID: <20251013162408.76200e17@kernel.org>
In-Reply-To: <aOY+4qpQ+tzIWS5Q@boxer>
References: <20251003140243.2534865-1-maciej.fijalkowski@intel.com>
	<20251003140243.2534865-3-maciej.fijalkowski@intel.com>
	<20251003161026.5190fcd2@kernel.org>
	<aOUqyXZvmxjhJnEe@boxer>
	<20251007181153.5bfa78f8@kernel.org>
	<aOYtUmUiplUpj2Pj@boxer>
	<aOY+4qpQ+tzIWS5Q@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Oct 2025 12:37:22 +0200 Maciej Fijalkowski wrote:
> > > I guess we're slipping into a philosophical discussion but I'd say 
> > > that the problem is that rxq stores part of what is de facto xdp buff
> > > state. It is evacuated into the xdp frame when frame is constructed,
> > > as packet is detached from driver context. We need to reconstitute it
> > > when we convert frame (skb, or anything else) back info an xdp buff.  
> > 
> > So let us have mem type per xdp_buff then. Feels clunky anyways to change
> > it on whole rxq on xdp_buff basis. Maybe then everyone will be happy?  
> 
> ...however would we be fine with taking a potential performance hit?

I'd think the perf hit will be a blocker, supposedly it's in rxq for
a reason. We are updating it per packet in the few places that are
coded up correctly (cpumap) so while it is indeed kinda weird we're
not making it any worse?

Maybe others disagree. I don't feel super strongly. My gut feeling is
what I drafted is best we can do in a fix. 

Sorry for delay, PTO.

