Return-Path: <bpf+bounces-29842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1738C72CE
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 10:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA1C1F21BCA
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 08:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D54513699E;
	Thu, 16 May 2024 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVM2U5GL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1980031;
	Thu, 16 May 2024 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848080; cv=none; b=k1CV4LQalYa8Oo5Q/xrjXv+IzVTfItlTSLUdgmT7FzecOwi4JVI4CxJpvx/tbf7jM4M7Byqe2dfAwSjFPzCi1VGPrztIe90YSGFbQ55BHyg1Ucf8fy+5QfBu6dWwSug27ocrNaE99Alz+2CyT33UVNduTgfPDCdzSW61KtHQdVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848080; c=relaxed/simple;
	bh=K6LjZar4C+lKcaUcvKF9CUktTgIY/qpM6WOPF5lY1uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBa+KIiQZyzRCSF+zORxI5gpJbPaCvIn9ZgWtySFH37mkRqy7jtdS8YZrVFHrBsoAytNV5XdMzyfqdEMaJimVE22M404qgXNkzez+vVTfQkUdvs6R3ROj1cCXMpVOP1lmdPrMIbQK4aRWJHJ1NIYM0vZpfPNJuryBReEufQdSDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVM2U5GL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C04C113CC;
	Thu, 16 May 2024 08:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715848080;
	bh=K6LjZar4C+lKcaUcvKF9CUktTgIY/qpM6WOPF5lY1uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IVM2U5GL41lJTUzuQNHCDzbJ+lZ1NsJiUnnwHsjBArxf3Mu3rushEXOEiGkSlD744
	 ei3h/xt4Jw3/iEtIvTsF7imzCrsQ6E9BMT/EkCahgBOMpl085ZVphA05HiT1AnFAIh
	 0tY9NIFSMskjH/g8z1vuBFhVSE4e2HwRcdkMmwQB4BnFpZuhpmvZFM6TfvaCGEYHI/
	 AUBxKyZGlJjB4ndP/dggyUP+2mC5HEVfCxhczi92o0NzrwSWSpYaSlBQc9lQnAYOds
	 ew7Sy2fRPYk1ygWnnQ0V8axIeRde63H0zPvIKUNJgaY/awJFPweqdhj4NPfj4vzYgL
	 sQgI4500BrPZA==
Date: Thu, 16 May 2024 09:27:54 +0100
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
Subject: Re: [PATCH iwl-net 1/3] ice: remove af_xdp_zc_qps bitmap
Message-ID: <20240516082754.GE179178@kernel.org>
References: <20240515160246.5181-1-larysa.zaremba@intel.com>
 <20240515160246.5181-2-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515160246.5181-2-larysa.zaremba@intel.com>

On Wed, May 15, 2024 at 06:02:14PM +0200, Larysa Zaremba wrote:
> Referenced commit has introduced a bitmap to distinguish between ZC and
> copy-mode AF_XDP queues, because xsk_get_pool_from_qid() does not do this
> for us.
> 
> The bitmap would be especially useful when restoring previous state after
> rebuild, if only it was not reallocated in the process. This leads to e.g.
> xdpsock dying after changing number of queues.
> 
> Instead of preserving the bitmap during the rebuild, remove it completely
> and distinguish between ZC and copy-mode queues based on the presence of
> a device associated with the pool.
> 
> Fixes: e102db780e1c ("ice: track AF_XDP ZC enabled queues in bitmap")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


