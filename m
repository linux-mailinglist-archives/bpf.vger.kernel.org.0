Return-Path: <bpf+bounces-12374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72147CB989
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 06:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5825FB210A0
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 04:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CA3BE67;
	Tue, 17 Oct 2023 04:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhBclQ0d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA3A1FD5;
	Tue, 17 Oct 2023 04:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63058C433C9;
	Tue, 17 Oct 2023 04:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697515835;
	bh=lQAc0M6wyDc260gsVnZP65MqVVRlE4I8/AoGwjKnMNY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uhBclQ0dI0ivJwnZ3PAiWJPwa9irt4jB3y4VhfKTrwrniIo5Jcwgff+TDzZvP7bv+
	 +lztTmmLaf6dap7HLbT0KzMa4RMLVLP3tfoewfmCW2TJz54K5S6EE1OdMcjSDkKwF4
	 VHA8F/kTx9bWuStif47Ab/POnqssGvaZ1mXUSiGsxDrHdVODJw+fVztWKKtUx8sfN0
	 Q07+xEz5NvtNFJP+kpLOb/6e1SIzXiDDvSEUsibmtu7PtO1eBaFax19wh/9PXSZzVP
	 BFXxY4N3auHeY3RbxaB6X0skPRmnFfx9TTAj0b4wwTQT5PWPJfK6m0L9H/22sLj4u1
	 IjYv5p9EQejUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 264D3C4316B;
	Tue, 17 Oct 2023 04:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v11 0/6] introduce page_pool_alloc() related API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169751583515.29825.863167765608905945.git-patchwork-notify@kernel.org>
Date: Tue, 17 Oct 2023 04:10:35 +0000
References: <20231013064827.61135-1-linyunsheng@huawei.com>
In-Reply-To: <20231013064827.61135-1-linyunsheng@huawei.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Oct 2023 14:48:20 +0800 you wrote:
> In [1] & [2] & [3], there are usecases for veth and virtio_net
> to use frag support in page pool to reduce memory usage, and it
> may request different frag size depending on the head/tail
> room space for xdp_frame/shinfo and mtu/packet size. When the
> requested frag size is large enough that a single page can not
> be split into more than one frag, using frag support only have
> performance penalty because of the extra frag count handling
> for frag support.
> 
> [...]

Here is the summary with links:
  - [net-next,v11,1/6] page_pool: fragment API support for 32-bit arch with 64-bit DMA
    https://git.kernel.org/netdev/net-next/c/90de47f020db
  - [net-next,v11,2/6] page_pool: unify frag_count handling in page_pool_is_last_frag()
    (no matching commit)
  - [net-next,v11,3/6] page_pool: remove PP_FLAG_PAGE_FRAG
    (no matching commit)
  - [net-next,v11,4/6] page_pool: introduce page_pool[_cache]_alloc() API
    (no matching commit)
  - [net-next,v11,5/6] page_pool: update document about fragment API
    (no matching commit)
  - [net-next,v11,6/6] net: veth: use newly added page pool API for veth with xdp
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



