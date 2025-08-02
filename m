Return-Path: <bpf+bounces-64961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B6DB18FB3
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 20:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A3017C4F7
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 18:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B65D250C18;
	Sat,  2 Aug 2025 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYBwfnNt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB58CC13B;
	Sat,  2 Aug 2025 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754160764; cv=none; b=DZneWyR/iBqCx7RiemHOP7y1wGNNZAwLifrPDfY6iX6rRo8Xyufo4LiXLdIczMdC7j4jxPe4W0788KXqEdMewRug1OMsUfDX/N8AJhEiJ1YcouC1eGZHUd4n+ZrHw3jPFEoKrGV0O/ngI+jtnjJKkeRmyW0012tp6J4VzZ9tEQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754160764; c=relaxed/simple;
	bh=oKJ4o+84X2gZrWbVCPsj5JL/+cPPXG/1i+v6w3VXMC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4OVXseBCKejkVH/nMIVkwDrc4kejYYddfQ9deF1SV3NevZSjkBa5UvP2ah7crOnyR3ZLsG/GRg+RXilQpSELqC4kzW/YiTGpr36yZMJrtmibtn0/tB8Dd/MOrfodA7LZfgRAePRMUSvHZSwHVKsdhNPh36g8BS3rSEDj8Z9IN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYBwfnNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482AEC4CEEF;
	Sat,  2 Aug 2025 18:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754160764;
	bh=oKJ4o+84X2gZrWbVCPsj5JL/+cPPXG/1i+v6w3VXMC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IYBwfnNtT4MqM4tAxSAR/QjCr7jN/hWRSOJgtIEv0cqySxNbaTHzmL9697+/+clTy
	 0lXodjB2ALTL7KFhGrf+dOPaEl9UbiFS54b7fa4RPCFJKSLnMw3+lHXIhVFcfql4tk
	 EreD2tbkCoyLDzoRzkgqjrUMwcRQvCio3Ls6fBtqgVXJztGW2LWZASS2RrIBIkD7AT
	 c0zVOsLH8KRoGneQL/KaueDbzCGBKwbg6bdBvo/bGvF4O2p2+F2sWmwdT4Kdop5vt5
	 HrEf3c+GE+zleyRAtl8EMibSGfp7N92FZFvklyyggz/EWUz2WkS9klmheE01e7SxVA
	 eneqE0XK/GfVg==
Date: Sat, 2 Aug 2025 11:52:44 -0700
From: Kees Cook <kees@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
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
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH iwl-next v3 16/18] idpf: add support for XDP on Rx
Message-ID: <202508021152.AD1850CD2@keescook>
References: <20250730160717.28976-1-aleksander.lobakin@intel.com>
 <20250730160717.28976-17-aleksander.lobakin@intel.com>
 <20250731123734.GA8494@horms.kernel.org>
 <202507310955.03E47CFA4@keescook>
 <8c085ba0-29a3-492a-b9f1-e7d02b5fb558@intel.com>
 <ff10e2a3-bd97-4c96-b7bd-f47289c9b0e4@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff10e2a3-bd97-4c96-b7bd-f47289c9b0e4@intel.com>

On Fri, Aug 01, 2025 at 03:17:42PM +0200, Alexander Lobakin wrote:
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Date: Fri, 1 Aug 2025 15:12:43 +0200
> 
> > From: Kees Cook <kees@kernel.org>
> > Date: Thu, 31 Jul 2025 10:05:47 -0700
> > 
> >> On Thu, Jul 31, 2025 at 01:37:34PM +0100, Simon Horman wrote:
> >>> While I appreciate the desire for improved performance and nicer code
> >>> generation. I think the idea of writing 64 bits of data to the
> >>> address of a 32 bit member of a structure goes against the direction
> >>> of hardening work by Kees and others.
> >>
> >> Agreed: it's better to avoid obscuring these details from the compiler
> >> so it can have an "actual" view of the object sizes involved.
> >>
> >>> Indeed, it seems to me this is the kind of thing that struct_group()
> >>> aims to avoid.
> >>>
> >>> In this case struct group() doesn't seem like the best option,
> >>> because it would provide a 64-bit buffer that we can memcpy into.
> >>> But it seems altogether better to simply assign u64 value to a u64 member.
> >>
> >> Agreed: with struct_group you get a sized pointer, and while you can
> >> provide a struct tag to make it an assignable object, it doesn't make
> >> too much sense here.
> >>
> >>> So I'm wondering if an approach along the following lines is appropriate
> >>> (Very lightly compile tested only!).
> >>>
> >>> And yes, there is room for improvement of the wording of the comment
> >>> I included below.
> >>>
> >>> diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
> >>> index f4880b50e804..a7d3d8e44aa6 100644
> >>> --- a/include/net/libeth/xdp.h
> >>> +++ b/include/net/libeth/xdp.h
> >>> @@ -1283,11 +1283,7 @@ static inline void libeth_xdp_prepare_buff(struct libeth_xdp_buff *xdp,
> >>>  	const struct page *page = __netmem_to_page(fqe->netmem);
> >>>  
> >>>  #ifdef __LIBETH_WORD_ACCESS
> >>> -	static_assert(offsetofend(typeof(xdp->base), flags) -
> >>> -		      offsetof(typeof(xdp->base), frame_sz) ==
> >>> -		      sizeof(u64));
> >>> -
> >>> -	*(u64 *)&xdp->base.frame_sz = fqe->truesize;
> >>> +	xdp->base.frame_sz_le_qword = fqe->truesize;
> >>>  #else
> >>>  	xdp_init_buff(&xdp->base, fqe->truesize, xdp->base.rxq);
> >>>  #endif
> >>> diff --git a/include/net/xdp.h b/include/net/xdp.h
> >>> index b40f1f96cb11..b5eedeb82c9b 100644
> >>> --- a/include/net/xdp.h
> >>> +++ b/include/net/xdp.h
> >>> @@ -85,8 +85,19 @@ struct xdp_buff {
> >>>  	void *data_hard_start;
> >>>  	struct xdp_rxq_info *rxq;
> >>>  	struct xdp_txq_info *txq;
> >>> -	u32 frame_sz; /* frame size to deduce data_hard_end/reserved tailroom*/
> >>> -	u32 flags; /* supported values defined in xdp_buff_flags */
> >>> +	union {
> >>> +		/* Allow setting frame_sz and flags as a single u64 on
> >>> +		 * little endian systems. This may may give optimal
> >>> +		 * performance. */
> >>> +		u64 frame_sz_le_qword;
> >>> +		struct {
> >>> +			/* Frame size to deduce data_hard_end/reserved
> >>> +			 * tailroom. */
> >>> +			u32 frame_sz;
> >>> +			/* Supported values defined in xdp_buff_flags. */
> >>> +			u32 flags;
> >>> +		};
> >>> +	};
> >>>  };
> >>
> >> Yeah, this looks like a nice way to express this, and is way more
> >> descriptive than "(u64 *)&xdp->base.frame_sz" :)
> > 
> > Sounds good to me!
> > 
> > Let me send v4 where I'll fix this.
> 
> Note: would it be okay if I send v4 with this fix when the window opens,
> while our validation will retest v3 from Tony's tree in meantine? It's a
> cosmetic change anyway and does not involve any functional changes.

If this is directed at me, yeah, I don't see any high urgency here.

-- 
Kees Cook

