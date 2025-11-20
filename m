Return-Path: <bpf+bounces-75133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 518AEC71CF4
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 03:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E164348C8E
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 02:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8618C2BE7A6;
	Thu, 20 Nov 2025 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hho8oJsb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B6B21C9E5;
	Thu, 20 Nov 2025 02:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763605214; cv=none; b=CB/noGZm3M0KiHzuhb24jhZhtaYHfWnE2zukjx74isVJZ14mpzvURiemD6MeoYKRyS3uagjXbf4gb6aqGRO1sVqy2WKyJW7bWm63BTvEGXH5jvxDx3eMwn/oXAfxOym68lSVoIo4WsQcD2cdfypgH+rmycv4wsCcW/uKcGZDd7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763605214; c=relaxed/simple;
	bh=9ldWXPvGDb9VCTpzMQ0QVWN29Qlq0RaScpULALAtPQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSFMGJQiK9phzAF4iYhBMgGdJFVq+PH0LXyCakVFG5UseXCQSWOYgXy8Y9f/uZsPC48ITSOSo2tWTt+uoK1+h243owekgn7Zz46jP6P48VU61PZp4q+evtPnn6dt7Yz66GHB1k9Woy8cFnHCpxwGUOhkIXCT/vrm1gr49I1SxOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hho8oJsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA02C4CEF5;
	Thu, 20 Nov 2025 02:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763605213;
	bh=9ldWXPvGDb9VCTpzMQ0QVWN29Qlq0RaScpULALAtPQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hho8oJsbwfrFeNav/ZQZISwurCDSDwbmYxWmDy+fwCUdSFczGZ/ljxdPCS7UdkGgA
	 0xlINAQ91oOrYqe1Et7IV8ZYkBUQPR5RxAaKuBbKv9DUpsguLOknq07Wr+UVtPoz8P
	 EUHHQHvWhmeQTxazIswcAUiUJOdQjr4OpQd2fjQHX0Q8VwkLjwk3UEILy/XX1sY5Mc
	 KBZRGnsZwomgJF2k0Shtz9WeRVr0ZIz/oIHn8s43IuYQMYd09xKj6Pm4p3kIOUk/0y
	 ZcBVAgvFFl5RZvVAdrRkRRuvnRS6mDAZ7/NaSq5PrFX07UX6EzZLg3pT6sMEJ/ozDs
	 jAcUT733IaYDQ==
Date: Wed, 19 Nov 2025 18:20:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v4 01/14] net: Add bind-queue operation
Message-ID: <20251119182011.36003fdb@kernel.org>
In-Reply-To: <2372a3b8-9bb2-4c53-9029-9bd03f56b98a@iogearbox.net>
References: <20251031212103.310683-1-daniel@iogearbox.net>
	<20251031212103.310683-2-daniel@iogearbox.net>
	<20251106163948.0d0d7d54@kernel.org>
	<2372a3b8-9bb2-4c53-9029-9bd03f56b98a@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 15:57:29 +0100 Daniel Borkmann wrote:
> >> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> >> index e00d3fa1c152..1e24c7f76de0 100644
> >> --- a/Documentation/netlink/specs/netdev.yaml
> >> +++ b/Documentation/netlink/specs/netdev.yaml
> >> @@ -561,6 +561,46 @@ attribute-sets:
> >>           type: u32
> >>           checks:
> >>             min: 1
> >> +  -
> >> +    name: queue-pair
> >> +    attributes:  
> > 
> > No need to create a "real" attribute set for this.
> > 
> > Once the attrs are wrapped in a "lease" nest you'll need a single
> > triplet, so make this a subset-of: queue (see the queue-id set).
> > name: ifc-queue-id ?  
> 
> Does the below rework look reasonable to you in terms of netdev spec?

LGTM!

