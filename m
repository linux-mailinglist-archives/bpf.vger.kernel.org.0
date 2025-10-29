Return-Path: <bpf+bounces-72922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F48C1D9CC
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 23:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EDD33B83E0
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 22:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58022D8390;
	Wed, 29 Oct 2025 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vi79FU2i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4442718C008;
	Wed, 29 Oct 2025 22:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761778053; cv=none; b=RpmGrXWko17UYRuBUMUPCKs2HQZRtuZCbamJfQ2uhan7HmAXgaadWH7Kad69R3jN8Zyg4IXic/p/dd8tzYwvTf2JJJgny8lDgsmLGcPC/Egz0pboHfhmNdG0Mw+efuffIoHtzipziPPdV5+DG/1V5NnViLOIMLeAqNCmLSrfz6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761778053; c=relaxed/simple;
	bh=ryjH8DOV/UmGWhG3rwsW4BNeO6byJ5BvmSUiIvYDcxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKdH40e07nUlGU8BnXgr9AkKP2yfufJ4kWKfVcKfL1En1Nrh6e1fED9eVEj2zXJzP2XHjuyv2u84eIa1yHW8y5V0+Q9UmpFu475kofPWyZDZGbWSfQJNj+MZ+0uPbWqCOEJ+FTU45Ien3jVAWCVXV2AVKG2tgwc7aPoo0N03bmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vi79FU2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082E5C4CEF7;
	Wed, 29 Oct 2025 22:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761778052;
	bh=ryjH8DOV/UmGWhG3rwsW4BNeO6byJ5BvmSUiIvYDcxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vi79FU2i8AcbFIOZGQWwroM7FBAzHDeyG2cKBQ5zsi0fWF13IV7T1BURw539oSim4
	 ljvU8Q0SFFmBACxI97p4+ye9lVcjFho6/5FfbIwNOXRPdyQ31C6MbYkarpcy7eWhCm
	 rnYjRIgUeVGTvY32IM8ZRI2OlUB3CefPN++Xfue3fwSQP6iPzEtiIi4XF7p/0J5WOB
	 t05jgj0SXsxx3GnoyBEreoqK9SuIqDXmj5YWu9v6hTsfuCUcPaKanvjBHKIKITkLbA
	 kwVywBjbSL13xUVWHo69EpKNHFaaQcXuWsacAcigk4kH+Gb8Dl659f4hyBBNAMuFfs
	 lymW2EL8ONerA==
Date: Wed, 29 Oct 2025 15:47:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net, razor@blackwall.org,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v3 03/15] net: Add peer info to queue-get
 response
Message-ID: <20251029154730.1a0ac990@kernel.org>
In-Reply-To: <b6b3cef5-195c-40cc-8c37-cebdee05a5bd@davidwei.uk>
References: <20251020162355.136118-1-daniel@iogearbox.net>
	<20251020162355.136118-4-daniel@iogearbox.net>
	<20251023193333.751b686a@kernel.org>
	<17f5b871-9bd9-4313-b123-67afa0f69272@iogearbox.net>
	<20251024161832.2ff28238@kernel.org>
	<b6b3cef5-195c-40cc-8c37-cebdee05a5bd@davidwei.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 19:08:10 -0700 David Wei wrote:
> >> I think up to us which side we want to show. My thinking was to allow user
> >> introspection from both, but we don't have to. Right now the above example
> >> was from the container side, but technically it could be either side depending
> >> in which netns the phys dev would be located.
> >>
> >> The user knows which is which based on the ifindex passed to the queue-get
> >> query: if the ifindex is from a virtual device (e.g. netkit type), then the
> >> 'peer' section shows the phys dev, and vice versa, if the ifindex is from a
> >> phys device (say, mlx5), then the 'peer' section shows the virtual one.
> >>
> >> Maybe I'll provide a better more in-depth example with both sides and above
> >> explanation in the commit msg for v4..  
> > 
> > Yes, FWIW my mental model is that "leaking" host information into the
> > container is best avoided. Not a problem, but shouldn't be done without
> > a clear reason.
> > Typical debug scenario can be covered from the host side (container X
> > is having issues with queue Y, dump all the queues, find out which one
> > is bound to X/Y).  
> 
> Makes sense, I didn't consider leaking host info in a container. Happy
> to remove the introspection from the container side, leaving it only on
> the host side when queues are dumped.
> 
> Like Daniel mentioned, I didn't add 'src/real' or 'dst/virtual' because
> I believed this information is implicit to the user when querying a
> netdev based on its type. Do you find this to be confusing? Happy to add
> a clarifying field in the nested struct.

In veth/netkit we call "peer" the other side of an equal pipe. Same for
ndo_get_peer_dev. Queue is not a peering situation, but rather an attachment
/ delegation of a sub-object from one netdev to another.

I'd use a term like delegation or grant when talking about the HW
queue. And assignment in context of virtual.

