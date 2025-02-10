Return-Path: <bpf+bounces-51001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA90A2F3D2
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224E31887261
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 16:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A7B243967;
	Mon, 10 Feb 2025 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpHkfzIh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F241F462E;
	Mon, 10 Feb 2025 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205695; cv=none; b=OGZciaR4ttUQxxp/Y8P+nl/HvVCUq7ZPGQFdf0216lOdLIeWPbmtMvpHfI5HSynnc2uostTmpRO7ynAbvKyyT8nkvqkSa21YeM1/hrNcUJ06+FfCzIT0ei63yXl/eyvqYTTdqoQ3JxwNYKatR9doY+ZT5i66faOWrCNVLgATYGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205695; c=relaxed/simple;
	bh=uAyfkHEewWlOYk9WBIv7qJzqDqE+h83eCP+cS6RAJIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1OlZU3fC0EJ52k+mhupUnlzeFZ33Q5Povf7r1/qN5V4QH5hB9ewdgnChLQhnOY9++/4L+e/UY7mxXtW0iccYpNI1Lj40I8xK/fUi0NEGrZOfRzJCUQh618Wo4BhrHnOlwRYeCfAWBDFFYuFyjfAofsLbBEEQcuMLxX+GMNzu98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpHkfzIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CE4C4CED1;
	Mon, 10 Feb 2025 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739205694;
	bh=uAyfkHEewWlOYk9WBIv7qJzqDqE+h83eCP+cS6RAJIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QpHkfzIhoCH0NwwuU7ojFAjSWRhE4Vrag9yp5NLAcXhMJPGpBUOCCzaSZUUyTC5OW
	 pVLHL6GgbBNPtKcjyy+TufUunEqZ9zhEBVSt9kNYAY5MrD30ZkwcsyzaOQavGEvLgI
	 4n+ct6G509MoAlQigJ4pgdycA8ObxkcMKvTH3AplbfXv6R8rp0vwLfQ1oYEeGDcQE2
	 nsPHNHd3NTdPDnwAt/yxBvAgumqcr9qyiPUjzn0R9q7L+E16j7oS3JNqVGe2G6cai4
	 Zxnp2prbQDKo+c+9QulZdWGbJp+OtxS/HEVzUq1InCaVmp0k5kEjM2F+uTMwbmIkWN
	 wGEHuphvNt+AQ==
Date: Mon, 10 Feb 2025 16:41:28 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lcherian@marvell.com,
	jerinj@marvell.com, john.fastabend@gmail.com, bbhushan2@marvell.com,
	hawk@kernel.org, andrew+netdev@lunn.ch, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org, larysa.zaremba@intel.com
Subject: Re: [net-next PATCH v5 2/6] octeontx2-pf: Add AF_XDP non-zero copy
 support
Message-ID: <20250210164128.GG554665@kernel.org>
References: <20250206085034.1978172-1-sumang@marvell.com>
 <20250206085034.1978172-3-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206085034.1978172-3-sumang@marvell.com>

On Thu, Feb 06, 2025 at 02:20:30PM +0530, Suman Ghosh wrote:
> Set xdp rx ring memory type as MEM_TYPE_PAGE_POOL for
> af-xdp to work. This is needed since xdp_return_frame
> internally will use page pools.
> 
> Fixes: 06059a1a9a4a ("octeontx2-pf: Add XDP support to netdev PF")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

Hi Suman,

If this is a bug fix then it should be targeted at net, which
implies splitting it out of this patch-set.

If, on the other hand, it is not a fix then it should not have a Fixes tag.
In that case you can cite a commit using this syntax:

commit 06059a1a9a4a ("octeontx2-pf: Add XDP support to netdev PF")

Unlike a Fixes tag it:
* Should be in the body of the patch description,
  rather than part of the tags at the bottom of the patch description
* May be line wrapped
* Can me included in a sentence

