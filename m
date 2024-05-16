Return-Path: <bpf+bounces-29849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D5A8C7589
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 13:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3251C2126E
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 11:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35519145B04;
	Thu, 16 May 2024 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtpd81Dv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3026AD0;
	Thu, 16 May 2024 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715860788; cv=none; b=hfuTQm02Lqcwy7tkLNbdThkDJnr8VEa6RqHiA4W98PA1x6jN3EZGsOyc5RjjeYnx/sDylhSthlrd11yA/seOwFORAjzIowkTRpNrCJ29GjAWfegTnh+5bLH1F0SUDWzjIat6/f5oU66JY+uqL558sHlR/yDNSLDzF/OcEKIias0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715860788; c=relaxed/simple;
	bh=jsj/eofNjP8sdAjFMeOlBKjV9ZvXIiu5BqPSaWoUy+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwSin3UFPo0bNy7iGys1+iER1JFVI34ZNua7/lGU2l62McRql9moCJueeobukgjsN50GQ62p6OTcmlrSEQGPSMgO2xb3v2Pw8irHMzvwJzDLNutDpzhGUKAQhWCGA3WqVi+mOJbuJhR0VyCFwx3Ytuartb5n9lnBlPx8w04ZUYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtpd81Dv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48F8C113CC;
	Thu, 16 May 2024 11:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715860788;
	bh=jsj/eofNjP8sdAjFMeOlBKjV9ZvXIiu5BqPSaWoUy+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtpd81Dvtk3pD15dyALA+g2al7nPqswFU22XDpkzZ3WGVh/vJgKYO4g6EjY9tt6r0
	 5lXBu1sZVqF8RNiIX671IQH0GIDMsu1j+Txw8riCjWuly1WjfgoPAmtfFD+JrNekYW
	 tN1mj5ak5CBe9RUmBjP0AZRrWsOXS09E7d+GTDeA7KbmO1AqeDHoS527s8rTC+mZKy
	 K2udUbMesf7Vs+/dKbzCNf+q17xzRhNH0T9VTFvP4rg/q9n6D8wQ65Nu/mMT6XtugO
	 hpUwwiqvkGTCzkzaEE/TE5cFgJ5LqMewNWWkj+3a9Yj6flq+6ODHn9Z1gj7fv13xKQ
	 nsHotV+a1eSaQ==
Date: Thu, 16 May 2024 12:59:42 +0100
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
Subject: Re: [PATCH iwl-net 3/3] ice: map XDP queues to vectors in
 ice_vsi_map_rings_to_vectors()
Message-ID: <20240516115942.GA443134@kernel.org>
References: <20240515160246.5181-1-larysa.zaremba@intel.com>
 <20240515160246.5181-4-larysa.zaremba@intel.com>
 <20240516082713.GC179178@kernel.org>
 <ZkXxVp3hFvczWr8r@lzaremba-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkXxVp3hFvczWr8r@lzaremba-mobl.ger.corp.intel.com>

On Thu, May 16, 2024 at 01:43:18PM +0200, Larysa Zaremba wrote:
> On Thu, May 16, 2024 at 09:27:13AM +0100, Simon Horman wrote:
> > On Wed, May 15, 2024 at 06:02:16PM +0200, Larysa Zaremba wrote:
> > > ice_pf_dcb_recfg() re-maps queues to vectors with
> > > ice_vsi_map_rings_to_vectors(), which does not restore the previous
> > > state for XDP queues. This leads to no AF_XDP traffic after rebuild.
> > > 
> > > Map XDP queues to vectors in ice_vsi_map_rings_to_vectors().
> > > Also, move the code around, so XDP queues are mapped independently only
> > > through .ndo_bpf().
> > 
> > Hi Larysa,
> > 
> > I take it the last sentence refers to the placement of ice_map_xdp_rings()
> > in ice_prepare_xdp_rings() after rather than before the
> > (cfg_type == ICE_XDP_CFG_PART) condition.
> > 
> > If so, I see that it is a small change. But I do wonder if it is separate
> > from fixing the issue described in the first paragraph. And thus would
> > be better as a separate patch.
> 
> This is not neccessary for the fix to work, but I think this is intergral to
> making the change properly. I mean, before the change in the rebuild path we map
> XDP rings to vectors only once and after the change we do this only once, just
> previously it was in ice_prepare_xdp_rings() and now it is in
> ice_vsi_map_rings_to_vectors().
> 
> > 
> > Also, (I'm raising a separate issue :) breaking out logic into
> > ice_xdp_ring_from_qid() seems very nice.  But I wonder if this ought to be
> > part of a cleanup-patch for 'iwl' rather than a fixes patch for 'iwl-next'.
> >
> 
> I have separated this into a separate function, because 2 lines exceeded 80 
> characters, which is not in line with our current style for drivers.
> And I do not think that this small function creates any more additional 
> potentian applying problems for this patch. And the change is small enough to 
> see that the logic stays the same.
> 
> > OTOH, I do see that breaking out ice_map_xdp_rings() makes sense in the
> > context of this fix as the same logic is to be called in two places.
> > 
> > Splitting patches aside, the resulting code looks good to me.
> > 
> > ...

Hi Larysa,

Thanks for your explanation, this all seems reasonable to me.

Reviewed-by: Simon Horman <horms@kernel.org>


