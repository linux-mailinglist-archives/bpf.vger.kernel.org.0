Return-Path: <bpf+bounces-29841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BE18C72C7
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 10:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DB3281C30
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA6B134411;
	Thu, 16 May 2024 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mU5Wpl8f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD40C76C76;
	Thu, 16 May 2024 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848060; cv=none; b=RvDc4oqlSnjVlynd59jXYHHQiaW5ixBahfTodPni30cmxMd5lemJEkZUv91RisdvnOpdNzajj9tzOkCeVV3Eo9w6Ir/UPNnElkVFa/0IhAb642YrF53f7SKm/Hu/XJ41YeFhmE3rl9Ql5rGB6/t8wuoTnHE7HL2YRgtOcBy6HCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848060; c=relaxed/simple;
	bh=9LRNAuur+huZKRDmejnPug6GuKAfA0xgXvFKeLB4wLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3MY8r2X+bApFrF5Ii19k48KLfSWVgdYZsmxBwjqRgpjDC4G2whS2/PfHZZpE7pBo1V+Uw1DRSctGwyZpWgwws7adlCMvmMaRWlu+6EBwG24KBOooAu3PV7LdR+ZunUUuFP12mcVgQGTQCSyzTBpuuVb20gAQgCcYqLXm3hiP8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mU5Wpl8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40375C32789;
	Thu, 16 May 2024 08:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715848059;
	bh=9LRNAuur+huZKRDmejnPug6GuKAfA0xgXvFKeLB4wLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mU5Wpl8fCqZC6kZltsIgQeTYGjz4QB/WYbrXvz7R/+YdO0nxnKnRx2KdNJnYxLCs0
	 zCLxREkNgG/FkZ1VQ84uTCOBuPLL0tGIH5PADs083gnXzlTc/MQKYaT9nyzs/iLGeY
	 i0OiRL7ef/29o/JLkpJxgFJak0dQpyhCVpXjaDyNEyJebiTFeHVBSIHzt9tZAR71CC
	 KQAithRyMZ+Qza+XemZzid9Is1m3GSkn2/8cpzwnuY9yxQbxH9O39ABXJ+S/a7vgQp
	 W1iLGegicc2MvRaHMRaGhRkRTRUw24wzkArSJLTSR/4CcB8m/BboT57kW3qAty8UNi
	 mavlwMDJmJAMQ==
Date: Thu, 16 May 2024 09:27:33 +0100
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	maciej.fijalkowski@intel.com,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	igor.bagnucki@intel.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-net 2/3] ice: add flag to distinguish reset from
 .ndo_bpf in XDP rings config
Message-ID: <20240516082733.GD179178@kernel.org>
References: <20240515160246.5181-1-larysa.zaremba@intel.com>
 <20240515160246.5181-3-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515160246.5181-3-larysa.zaremba@intel.com>

On Wed, May 15, 2024 at 06:02:15PM +0200, Larysa Zaremba wrote:
> Commit 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
> has placed ice_vsi_free_q_vectors() after ice_destroy_xdp_rings() in
> the rebuild process. The behaviour of the XDP rings config functions is
> context-dependent, so the change of order has led to
> ice_destroy_xdp_rings() doing additional work and removing XDP prog, when
> it was supposed to be preserved.
> 
> Also, dependency on the PF state reset flags creates an additional,
> fortunately less common problem:
> 
> * PFR is requested e.g. by tx_timeout handler
> * .ndo_bpf() is asked to delete the program, calls ice_destroy_xdp_rings(),
>   but reset flag is set, so rings are destroyed without deleting the
>   program
> * ice_vsi_rebuild tries to delete non-existent XDP rings, because the
>   program is still on the VSI
> * system crashes
> 
> With a similar race, when requested to attach a program,
> ice_prepare_xdp_rings() can actually skip setting the program in the VSI
> and nevertheless report success.
> 
> Instead of reverting to the old order of function calls, add an enum
> argument to both ice_prepare_xdp_rings() and ice_destroy_xdp_rings() in
> order to distinguish between calls from rebuild and .ndo_bpf().
> 
> Fixes: efc2214b6047 ("ice: Add support for XDP")
> Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


