Return-Path: <bpf+bounces-14329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078FF7E2EF8
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 22:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381CE1C208D8
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 21:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329CB2E65F;
	Mon,  6 Nov 2023 21:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gcd+DYdJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BBA2C859;
	Mon,  6 Nov 2023 21:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0F1C433C8;
	Mon,  6 Nov 2023 21:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699306371;
	bh=tmBKKGig8qdVRnoOGeW867wxNHPECJMhCPnD8lHBNsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gcd+DYdJRYTb719UTHhAdf+Wa7ixVNguYDB1bQFvjEFoPjT72pPqEy9NKdU3Qb5Q3
	 7Gfr+ig+cVAONP0KOvjQqrQmdsRS2xltUc65i0eOuX9OawWzqNv3N2TNLeO+kjPuCz
	 EvsimOv4e51QmI9gN2RdD32xs2taw1Gz2ARYDnRhHxSdi5q7IMHlPdrWvSuoKHLQNQ
	 2y8uuLElMIcbfgi6AG68+9enJ2xYcPd+xuMoqUHb1/kQ5Q8JLJgAQq0Bqm0ohxl5Ly
	 DJvoJ4ST6kiq0LZmLRB4YhnTlL+beOr0MFouUEnOfzW5VhkW8Vsi00FcEPiurE9/WR
	 Opbp9YDgNdsLA==
Date: Mon, 6 Nov 2023 13:32:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH bpf 4/6] bpf, netkit: Add indirect call wrapper for
 fetching peer dev
Message-ID: <20231106133250.0d49a487@kernel.org>
In-Reply-To: <20231103222748.12551-5-daniel@iogearbox.net>
References: <20231103222748.12551-1-daniel@iogearbox.net>
	<20231103222748.12551-5-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Nov 2023 23:27:46 +0100 Daniel Borkmann wrote:
> ndo_get_peer_dev is used in tcx BPF fast path, therefore make use of
> indirect call wrapper and therefore optimize the bpf_redirect_peer()
> internal handling a bit. Add a small skb_get_peer_dev() wrapper which
> utilizes the INDIRECT_CALL_1() macro instead of open coding.

Why don't we kill the ndo and put the pointer in struct net_device?

