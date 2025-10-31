Return-Path: <bpf+bounces-73091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9E8C22DCF
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 02:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 649354EBD16
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 01:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871A723BD1A;
	Fri, 31 Oct 2025 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/UYPJtf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2B91F75A6;
	Fri, 31 Oct 2025 01:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761873774; cv=none; b=JcXWFo/DM9ZKiloX3vJu6f7DSBwpztpbiFQ9KpgIK9xl7pTnXenjP7CvACwcLui4MjnqUIOcfTIfAqmYFCuPIhjXHeDhMUBHVlrRkm5SQzV3hXI6sFUWs3R0uHUfsWwLipEaD+N1oN1dVcxAN8QXUMm+Yd9REE5eZkUbZCFF+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761873774; c=relaxed/simple;
	bh=9kqRBBhxTiCVms34Q7h7HZkf9jgZ4CP6eL2/03+oqFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ca49sgslc7bgOC+Niu7PfSS5dmD5o7yZoIbFGbtKKh0vhvejEPFtxV6IS81kR13vPSkdzR8kmxrvNgkpipxSfaIKRKr+Yzn4mlGnRJTjkX4PDdcGoxuPUcM3QnX1m6T8MmQqqGMJQQRkiadxhGFIq9qMySX3L7r/WbkHbo2f5lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/UYPJtf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B40C4CEF1;
	Fri, 31 Oct 2025 01:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761873773;
	bh=9kqRBBhxTiCVms34Q7h7HZkf9jgZ4CP6eL2/03+oqFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V/UYPJtf9hLSYjdJIdpd1O1jlMYO1W/9+zCwgv7fsGzwETcFCcvKOJxutCYqAtIgc
	 8G4Cc6AkTSxV1waFKiAc6F0/7F27lFqpV3owB7txLDZPmOmJmxaSqScTyis5G7xLfs
	 RPhU1ZHgjgWgunhChAW1YE4IKTN05pskWzsnIGUh1JumCsl3IbJcIvWyOJF8Ptwf/2
	 ERlcAYbvARCw4FP2rzU/m6q4F3iiD1dj+T1pd5sqNchYcGS8cA5L/gTXctO1klpqnL
	 Owx7ZHyc8HdgRVNLXyRUoJsODglQBf1vTf9mzbonypu1utaKxc4iaeZ2LUpafxcKYe
	 JkZTefNtDmYwg==
Date: Thu, 30 Oct 2025 18:22:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Documentation <linux-doc@vger.kernel.org>, Linux Networking
 <netdev@vger.kernel.org>, Linux BPF <bpf@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next] net: Reorganize networking documentation
 toctree
Message-ID: <20251030182251.60e01849@kernel.org>
In-Reply-To: <aQQM0Likqs1RFNQ1@archie.me>
References: <20251028113923.41932-2-bagasdotme@gmail.com>
	<20251030175018.01eda2a5@kernel.org>
	<aQQM0Likqs1RFNQ1@archie.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 08:11:44 +0700 Bagas Sanjaya wrote:
> On Thu, Oct 30, 2025 at 05:50:18PM -0700, Jakub Kicinski wrote:
> > On Tue, 28 Oct 2025 18:39:24 +0700 Bagas Sanjaya wrote:  
> > > Current netdev docs has one large, unorganized toctree that makes
> > > finding relevant docs harder like a needle in a haystack. Split the
> > > toctree into four categories: networking core; protocols; devices; and
> > > assorted miscellaneous.
> > > 
> > > While at it, also sort the toctree entries and reduce toctree depth.  
> > 
> > Looking at the outcome -- I'm not sure we're achieving sufficient
> > categorization here. It's a hard problem to group these things.
> > What ends up under Networking devices and Miscellaneous seems
> > pretty random. Bunch of the entries under there should be in protocols
> > or core. And at the end of the day if we don't have a very intuitive
> > categorization the reader has to search anyway. So no point..  
> 
> Do you have any categorization suggestions then?

No.

