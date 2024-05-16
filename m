Return-Path: <bpf+bounces-29840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B5C8C72BE
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 10:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB7C281526
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 08:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DB912DD82;
	Thu, 16 May 2024 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+e1arsP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAF938F86;
	Thu, 16 May 2024 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848040; cv=none; b=BxKfDeMBKFm5Hqsw/5JweiYKHf+qXrcpEEA68fumCfU31GvRehq602rp16yN/gGJdXxCOKFNCkcMN5m2pUGZ+LePMziaZvWYYbUpg/hF7zSgnRNK23fYlBEi4EDVxzi0Zxjun3RDbJg/eV33YgAD4BwRB7fPXR7vC5odfFllVn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848040; c=relaxed/simple;
	bh=XS+c13dsUKZqV4fhUJ4NseTT8YN+F9dJ7nFDGFXcNrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHpZ2QwYrmozH0w1E4f39ZHzGrqbXQ3JJgTi3el6NNUGGjmhT2xgWYXwbJidFH/EdTzCTmO9qTQsmUUVjyDwtsTmaRt2fFttntjDGm5TzXQ5b8XncRB8M4MyS997OFnY3cPnpc6zOoIn3Q9hZidVodpnZaoqJN6YlestYWk5Ul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+e1arsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48018C113CC;
	Thu, 16 May 2024 08:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715848039;
	bh=XS+c13dsUKZqV4fhUJ4NseTT8YN+F9dJ7nFDGFXcNrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+e1arsPk3v9M3A8EeaJpe0Z8uAAfgVylWc7wCMixoFpsYxiO9MFuM1ocFVQWmAeR
	 KXFZOav5FfjYm03+McmjOpIdXEii1bxqkQ7/8xTAZEo2U8XQP2rBp6ipgo4uPalkuV
	 pI3G5UHIJFYjL0qdyyW6ncIlnV77pQwjI/oV4GeDMHeZ7LFeQvodFEnlwh6ocDojZr
	 Rhs+0VJzxcuD+TJmk93Zdt4cUvlMlwGtl17UBaYbgqvPjPtKbodCgnDVOZUE/yT/c6
	 S0rmmeB4QipQDwpYo8jNBtAQs0cXym7XCM1RjrkdHC2gnkNB/buheVMKzkKahzGDYt
	 IN9+Y3ltxHvdA==
Date: Thu, 16 May 2024 09:27:13 +0100
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
Message-ID: <20240516082713.GC179178@kernel.org>
References: <20240515160246.5181-1-larysa.zaremba@intel.com>
 <20240515160246.5181-4-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515160246.5181-4-larysa.zaremba@intel.com>

On Wed, May 15, 2024 at 06:02:16PM +0200, Larysa Zaremba wrote:
> ice_pf_dcb_recfg() re-maps queues to vectors with
> ice_vsi_map_rings_to_vectors(), which does not restore the previous
> state for XDP queues. This leads to no AF_XDP traffic after rebuild.
> 
> Map XDP queues to vectors in ice_vsi_map_rings_to_vectors().
> Also, move the code around, so XDP queues are mapped independently only
> through .ndo_bpf().

Hi Larysa,

I take it the last sentence refers to the placement of ice_map_xdp_rings()
in ice_prepare_xdp_rings() after rather than before the
(cfg_type == ICE_XDP_CFG_PART) condition.

If so, I see that it is a small change. But I do wonder if it is separate
from fixing the issue described in the first paragraph. And thus would
be better as a separate patch.

Also, (I'm raising a separate issue :) breaking out logic into
ice_xdp_ring_from_qid() seems very nice.  But I wonder if this ought to be
part of a cleanup-patch for 'iwl' rather than a fixes patch for 'iwl-next'.

OTOH, I do see that breaking out ice_map_xdp_rings() makes sense in the
context of this fix as the same logic is to be called in two places.

Splitting patches aside, the resulting code looks good to me.

...

