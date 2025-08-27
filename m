Return-Path: <bpf+bounces-66695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05022B3889C
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 19:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB8A1B629C0
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 17:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959642D73AE;
	Wed, 27 Aug 2025 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqU8HTMS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102062D6418;
	Wed, 27 Aug 2025 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315716; cv=none; b=NHxDvVnRrDsIQk/dtq3uRTT/tC7cgL7aTRPpQ794yJtHwSdqbdoPLovtA7Gni/MVmuP+Ty0vjkuO2ftgcAOoEgTIpKbs0fzKx7WkTDOm6K0cHNfryTlKujmE2hEx745lsxrBm55sUM1z2sstFLd3sJ28XwUeNUfnUkSuAqMPxQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315716; c=relaxed/simple;
	bh=UtrbolA1HHDmLzgsn3xYeflYPsigIkwUh0momqKEeHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btFvVokbSZxUuWLbSRwoWgNyDucski/lHF9pLv49hElHS4JVUqhbppVJCCFHVDVgoyoVEdXilExvWaysshsuKQqZiMQhTNmb0Fobsdvxv81/8tfRKv7AHdBqgQ8PFp88+OH2sYxSGHVWdAgvzJlePdKmoo+iYN2gNPY0hxwjCMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqU8HTMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620B1C4CEEB;
	Wed, 27 Aug 2025 17:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756315713;
	bh=UtrbolA1HHDmLzgsn3xYeflYPsigIkwUh0momqKEeHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PqU8HTMSa5I6ObcVPSD4d6fKFh1wfzdb23B3poxfHNfoGUDbJCIqkxP6+I4ROQbd2
	 Z6xA07kdpSE/mdfKDSKk+ea2P5RvKDCmcmk9GQ2e/M41195zoHe20Yc4cCoRhjrmQm
	 GN3g9T4c7il6y5uFDmLbfIqONUInMwlXcDlgfcdS5ZMSBmP/S6CmkvquFnzYZMdtHx
	 gRKpt14RcBAfZ1nR9UYvuLDLQ8L+tVLj7CopjeLh4i31juvpj2ak2NT2vwh/nUL3Wr
	 w+x0MN175xpyHRzneD8cpnC70V4KmE74o56eLhzuUlFhYrxaL0+6necozhXfn6n/V6
	 nBOgBoF20lxwg==
Date: Wed, 27 Aug 2025 18:28:28 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Michal Kubiak <michal.kubiak@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	nxne.cnse.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next v5 00/13] idpf: add XDP support
Message-ID: <20250827172828.GP10519@horms.kernel.org>
References: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826155507.2138401-1-aleksander.lobakin@intel.com>

On Tue, Aug 26, 2025 at 05:54:54PM +0200, Alexander Lobakin wrote:
> Add XDP support (w/o XSk for now) to the idpf driver using the libeth_xdp
> sublib. All possible verdicts, .ndo_xdp_xmit(), multi-buffer etc. are here.
> In general, nothing outstanding comparing to ice, except performance --
> let's say, up to 2x for .ndo_xdp_xmit() on certain platforms and
> scenarios.
> idpf doesn't support VLAN Rx offload, so only the hash hint is
> available for now.
> 
> Patches 1-7 are prereqs, without which XDP would either not work at all or
> work slower/worse/...

Hi Alexander,

I'm wondering if you could give a hash that this patch-set applies to.
Or a branch where it has been applied.

I suspect it's terribly obvious how to do this, but I'm drawing a blank here.

Thanks!

