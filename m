Return-Path: <bpf+bounces-72169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278C0C08490
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 01:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F533B01A0
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 23:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03592303CB7;
	Fri, 24 Oct 2025 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j892gAnj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F052367A2;
	Fri, 24 Oct 2025 23:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761347914; cv=none; b=PKTqI4LD9XbRhfMooyhhRwG4ipcnSoCGpGJ9xHHO+spfhZVWtvjf4FB0awBK2wuc34XUSR62ZSHg/oBciWxrZ03t3gMsKxz1wi8NWhnJwbnPXUUaXT7Z/4PaFSBgI5WrbyfVd5eL0T1jlRvTh9Qrl+KSjhEB1QpzGIIJJnoAMok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761347914; c=relaxed/simple;
	bh=RN4xKOmcogBVduP5jR903GRyz8uCvrLfKzMjVo3Fc4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qS7eo9lr2uWiVNHr6UlFZWSQrZa0tKU13rjelPo1Ok+ZAzT8XImxUCGer4nL3Tj7p1C8aIVEEivSKQ/U8eY5MFUPEwy1N51BWvGVSDksvEY6YyxazQthhy5DC1JB99/G+H5UzhCqHWlBFyUH228iy5AsAs9jQoOUJlF/50p6EKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j892gAnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3800EC4CEF1;
	Fri, 24 Oct 2025 23:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761347913;
	bh=RN4xKOmcogBVduP5jR903GRyz8uCvrLfKzMjVo3Fc4A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j892gAnjHH4IqlZUciWweFzm42d+ANehG3PmfHoDXkYuRBaZ/UcGfRq9GDhHQK0/P
	 GcHE9LTGuOG/IkFL+Isx1yqpFtnUpmWnkdb6GCiW4KKM1NQ4ObYUnArvqGZP3MDu+Q
	 fC21FabsIoXp3/MSMIhM6tNKxlZs048zz99bpOuB23QuDcFoF+FOxw1xbthYnBFjFc
	 7VtKK9uhMNz7TwzouPl2UleF8/deX0wDLU7wMLW3ek+Hs0zH7OMSsJYKDACVDSkDbB
	 nAoh3W+OHL7JFwG/sRTSj5no6utW7EdJ6Ucey5TEaei8O7jtS5dpEpHaQIH3zcMqEi
	 NyQ8Bov5cOZkA==
Date: Fri, 24 Oct 2025 16:18:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v3 03/15] net: Add peer info to queue-get
 response
Message-ID: <20251024161832.2ff28238@kernel.org>
In-Reply-To: <17f5b871-9bd9-4313-b123-67afa0f69272@iogearbox.net>
References: <20251020162355.136118-1-daniel@iogearbox.net>
	<20251020162355.136118-4-daniel@iogearbox.net>
	<20251023193333.751b686a@kernel.org>
	<17f5b871-9bd9-4313-b123-67afa0f69272@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 14:59:39 +0200 Daniel Borkmann wrote:
> On 10/24/25 4:33 AM, Jakub Kicinski wrote:
> > On Mon, 20 Oct 2025 18:23:43 +0200 Daniel Borkmann wrote:  
> >> Add a nested peer field to the queue-get response that returns the peered
> >> ifindex and queue id.
> >>
> >> Example with ynl client:
> >>
> >>    # ip netns exec foo ./pyynl/cli.py \
> >>        --spec ~/netlink/specs/netdev.yaml \
> >>        --do queue-get \
> >>        --json '{"ifindex": 3, "id": 1, "type": "rx"}'
> >>    {'id': 1, 'ifindex': 3, 'peer': {'id': 15, 'ifindex': 4, 'netns-id': 21}, 'type': 'rx'}  
> > 
> > I'm struggling with the roles of what is src and dst and peer :(
> > No great suggestion off the top of my head but better terms would
> > make this much easier to review.
> > 
> > The example seems to be from the container side. Do we need to show peer
> > info on the container side? Not just on the host side?  
> 
> I think up to us which side we want to show. My thinking was to allow user
> introspection from both, but we don't have to. Right now the above example
> was from the container side, but technically it could be either side depending
> in which netns the phys dev would be located.
> 
> The user knows which is which based on the ifindex passed to the queue-get
> query: if the ifindex is from a virtual device (e.g. netkit type), then the
> 'peer' section shows the phys dev, and vice versa, if the ifindex is from a
> phys device (say, mlx5), then the 'peer' section shows the virtual one.
> 
> Maybe I'll provide a better more in-depth example with both sides and above
> explanation in the commit msg for v4..

Yes, FWIW my mental model is that "leaking" host information into the
container is best avoided. Not a problem, but shouldn't be done without
a clear reason.
Typical debug scenario can be covered from the host side (container X
is having issues with queue Y, dump all the queues, find out which one
is bound to X/Y).

