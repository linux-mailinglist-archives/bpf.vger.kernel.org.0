Return-Path: <bpf+bounces-16891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 960D7807474
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 17:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4E8281ECD
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 16:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A1446454;
	Wed,  6 Dec 2023 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J29pp0lg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF06546442;
	Wed,  6 Dec 2023 16:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD65DC433C8;
	Wed,  6 Dec 2023 16:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701878615;
	bh=vObJhLoKALa74LDdbO34u/eNDIMLI/8gkU8atqCzgN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J29pp0lgof+Ag0+mouVgNwPS5wInBeWGhP6g8kK4c69UOezk9GVEaQOIUHel7IDiK
	 kydy0qP0gayMGlX/sYeNN50Yl+19Fot/D7cvkqCOizilnzQSufbgRIK5ZtA1inyWlL
	 6/DOBxKilQDgbf2FZX/GtJaXt5kLC4BcnMRLf5NFGp2myW/3i4Vb9uFecaNPwbUI0l
	 7HQhWHotTaBZlBzC7UF/A5JKZFr+k/eCi62ock4fTMey786KVfIq2lev3yPlg01rZN
	 Lrf5JuvtNLrNdNptTv0dBRStCedA/Lnf15kn5csvnfl/umzis2+W6hBogUWxDi6g0K
	 ehZPg30y4pHYQ==
Date: Wed, 6 Dec 2023 08:03:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, aleksander.lobakin@intel.com,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, lorenzo.bianconi@redhat.com, bpf@vger.kernel.org,
 toke@redhat.com, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 sdf@google.com
Subject: Re: [PATCH v3 net-next 2/2] xdp: add multi-buff support for xdp
 running in generic mode
Message-ID: <20231206080333.0aa23754@kernel.org>
In-Reply-To: <4b9804e2-42f0-4aed-b191-2abe24390e37@kernel.org>
References: <cover.1701437961.git.lorenzo@kernel.org>
	<c9ee1db92c8baa7806f8949186b43ffc13fa01ca.1701437962.git.lorenzo@kernel.org>
	<20231201194829.428a96da@kernel.org>
	<ZW3zvEbI6o4ydM_N@lore-desk>
	<20231204120153.0d51729a@kernel.org>
	<ZW-tX9EAnbw9a2lF@lore-desk>
	<20231205155849.49af176c@kernel.org>
	<4b9804e2-42f0-4aed-b191-2abe24390e37@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Dec 2023 13:41:49 +0100 Jesper Dangaard Brouer wrote:
> BUT then I realized that PP have a weakness, which is the return/free
> path that need to take a normal spin_lock, as that can be called from
> any CPU (unlike the RX/alloc case).  Thus, I fear that making multiple
> devices share a page_pool via softnet_data, increase the chance of lock
> contention when packets are "freed" returned/recycled.

I was thinking we can add a pcpu CPU ID to page pool so that
napi_pp_put_page() has a chance to realize that its on the "right CPU"
and feed the cache directly.

