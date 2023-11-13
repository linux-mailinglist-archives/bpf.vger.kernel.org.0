Return-Path: <bpf+bounces-14982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6A37E998C
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 10:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2415280C1E
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 09:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491A81BDCB;
	Mon, 13 Nov 2023 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNICD2Jp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06CC1A59A;
	Mon, 13 Nov 2023 09:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62206C433C7;
	Mon, 13 Nov 2023 09:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699869468;
	bh=n5ux6YXPEShtl7XOKMNnB1OSCcDM1DXuYI6CRJ1ietQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNICD2JpzPuMByr0lfaJCL7yz7VTGT2s1MLCdpdHUUSuXkkN/S/oyEfndBrHgQpLw
	 y+UwO8uzRfeTkTAqcTenFD8qJoX+zYYqUVLnH+BiA3ngGR9uYdbncUc9Z1CcqYGDF/
	 691AIcjT6GlbsaQlLdWH3d3UMqRILxpAo+AuE5G2UCZxOnqJ34bYII6I05bypPFwhW
	 szenpU5OpRuq2RScoLIf6KrNZYWS6xws/dsdQzzxerWfIpVSKS/xltAB/IfNQkZR+j
	 JFqTSjr773rk2q0TkRbTgWKdiGruCP176Xo1UtHRO/yOcOsD0iYeClklzpleyqOCxK
	 6dxmDt7u5KQyw==
Date: Mon, 13 Nov 2023 09:57:44 +0000
From: Simon Horman <horms@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@kernel.org, kuba@kernel.org, razor@blackwall.org,
	sdf@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH bpf v2 2/8] net: Move {l,t,d}stats allocation to core and
 convert veth & vrf
Message-ID: <20231113095744.GN705326@kernel.org>
References: <20231112203009.26073-1-daniel@iogearbox.net>
 <20231112203009.26073-3-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112203009.26073-3-daniel@iogearbox.net>

On Sun, Nov 12, 2023 at 09:30:03PM +0100, Daniel Borkmann wrote:
> Move {l,t,d}stats allocation to the core and let netdevs pick the stats
> type they need. That way the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc) - all happening in the core.
> 
> Co-developed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David Ahern <dsahern@kernel.org>

...

> @@ -2354,6 +2361,7 @@ struct net_device {
>  	void				*ml_priv;
>  	enum netdev_ml_priv_type	ml_priv_type;
>  
> +	enum netdev_stat_type		pcpu_stat_type:8;

Hi Daniel,

nit: Please consider adding documentation for this new field to
     the kernel doc for net_device.

...

