Return-Path: <bpf+bounces-56687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E953A9C3DD
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 11:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359F14A749A
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03A723BD04;
	Fri, 25 Apr 2025 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkvRKdCv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA6238177;
	Fri, 25 Apr 2025 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745573622; cv=none; b=WBKDCLPn28p3aVlQp14FkrSmN/IYU5/eVPdhkHXVPrPqW4Wq7sTgIIJrQ/foPyG5LA4dqIawevVyhV+U01qObTWa58zfbr3GtbS7Ja5gXeMuN0pbFhaeo6N22nHkGRgHWIM2q4CPrzF6+/elMAvNpEYJvFcAIVkYhe0bwebAVc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745573622; c=relaxed/simple;
	bh=GjHc7ixuVSqzJXlGE7UjvjBIhwA7ag0KF2uYJxG5nVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvrfOFxMkUViIu4rLvPHdMRQOVv0cQEbQc7JXCZsJiISd7PgVSZlHxnP6OH6kpZR4QyJ19iovgzIOc5NFdrxJfBS8LGk00PcAlUBgR3MuMyJ9KIdq0IFKvFzodd+2KkRAup5eCRgBbUQW4p0UlpPwX3UN0rFFmPWna+hQdQH3HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkvRKdCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD0BC4CEEB;
	Fri, 25 Apr 2025 09:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745573621;
	bh=GjHc7ixuVSqzJXlGE7UjvjBIhwA7ag0KF2uYJxG5nVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qkvRKdCvrV1c9D6w/igw/owk/FfV/zgraHyAvdQP9QOjTnCTw2hgaZ4xTsANfVLbC
	 ggY0bn6rDLQPagDugfGKAeZBED/e1SmLZAKDw+Ypi0afXYpGlAZStc2WG33T8iPISc
	 c8kxncn/XRYnHWJFSG3HvpQNqlTJIQEqtOABdIXSHJ6Ne9+w4Sp09/yMozAKH8dQqP
	 5FID9Zhfw4c4HhIHcqPoh2w2h8ijM+GWQB795hhAKs5O0zPytTUD0IYiMBC85hg4iC
	 +Q4dQGwC9V6zXYM4VL2LOsvBWlSR1wUH0qM/CdOvcBznWdVQryxDNqp0BeNptgw1YV
	 AhHtxeHEZNazg==
Date: Fri, 25 Apr 2025 10:33:37 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Sauber <andrew.sauber@isovalent.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	William Tu <witu@nvidia.com>, Martin Zaharinov <micron10@gmail.com>,
	Ronak Doshi <ronak.doshi@broadcom.com>
Subject: Re: [PATCH net] vmxnet3: Fix malformed packet sizing in
 vmxnet3_process_xdp
Message-ID: <20250425093337.GN3042781@horms.kernel.org>
References: <20250423133600.176689-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423133600.176689-1-daniel@iogearbox.net>

On Wed, Apr 23, 2025 at 03:36:00PM +0200, Daniel Borkmann wrote:
> vmxnet3 driver's XDP handling is buggy for packet sizes using ring0 (that
> is, packet sizes between 128 - 3k bytes).
> 
> We noticed MTU-related connectivity issues with Cilium's service load-
> balancing in case of vmxnet3 as NIC underneath. A simple curl to a HTTP
> backend service where the XDP LB was doing IPIP encap led to overly large
> packet sizes but only for *some* of the packets (e.g. HTTP GET request)
> while others (e.g. the prior TCP 3WHS) looked completely fine on the wire.
> 
> In fact, the pcap recording on the backend node actually revealed that the
> node with the XDP LB was leaking uninitialized kernel data onto the wire
> for the affected packets, for example, while the packets should have been
> 152 bytes their actual size was 1482 bytes, so the remainder after 152 bytes
> was padded with whatever other data was in that page at the time (e.g. we
> saw user/payload data from prior processed packets).
> 
> We only noticed this through an MTU issue, e.g. when the XDP LB node and
> the backend node both had the same MTU (e.g. 1500) then the curl request
> got dropped on the backend node's NIC given the packet was too large even
> though the IPIP-encapped packet normally would never even come close to
> the MTU limit. Lowering the MTU on the XDP LB (e.g. 1480) allowed to let
> the curl request succeed (which also indicates that the kernel ignored the
> padding, and thus the issue wasn't very user-visible).
> 
> Commit e127ce7699c1 ("vmxnet3: Fix missing reserved tailroom") was too eager
> to also switch xdp_prepare_buff() from rcd->len to rbi->len. It really needs
> to stick to rcd->len which is the actual packet length from the descriptor.
> The latter we also feed into vmxnet3_process_xdp_small(), by the way, and
> it indicates the correct length needed to initialize the xdp->{data,data_end}
> parts. For e127ce7699c1 ("vmxnet3: Fix missing reserved tailroom") the
> relevant part was adapting xdp_init_buff() to address the warning given the
> xdp_data_hard_end() depends on xdp->frame_sz. With that fixed, traffic on
> the wire looks good again.
> 
> Fixes: e127ce7699c1 ("vmxnet3: Fix missing reserved tailroom")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Tested-by: Andrew Sauber <andrew.sauber@isovalent.com>
> Cc: Anton Protopopov <aspsk@isovalent.com>
> Cc: William Tu <witu@nvidia.com>
> Cc: Martin Zaharinov <micron10@gmail.com>
> Cc: Ronak Doshi <ronak.doshi@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


