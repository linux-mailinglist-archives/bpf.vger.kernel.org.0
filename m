Return-Path: <bpf+bounces-13092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 553D67D457D
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 04:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E3AB20F8E
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 02:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12A779EF;
	Tue, 24 Oct 2023 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIjr5rhW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BF179D0;
	Tue, 24 Oct 2023 02:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7511DC433C9;
	Tue, 24 Oct 2023 02:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698114626;
	bh=uTJdGU6PVW1afxCvV2580N6vBNBEyv5C/dwm7N1xx30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tIjr5rhWhTWmiR8DtTfZ0kX00SWnR2RhmiuhhWkePpU7Iq+bvG2C8aMpbb1Wv+05h
	 RLQANx3NlAvgz73qrXAqPj5uJbtzZ103L7qwlBfWswuMqlf9FQ9VaFwHPLyr0BE5Wj
	 X0D17clSpw9Tr4WKNV1f388OxCpkYojpW3giJ8ooIqDlo07tV+vBI3bPOOZHD0bi3J
	 6hzsrrwtCltCDIATfeeUtdqWzCOrC09cvGEdS98zkIO8JnRFA69+r+ejoMdAgvcTBB
	 JkvQCLSYytS0LJIR85wziYD28S/b8IsIF5oH99q+DmOUHL64mHYvynrz13sz4fJ+YW
	 a0b6RAvW7BapA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A647E4CC1D;
	Tue, 24 Oct 2023 02:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v12 0/5] introduce page_pool_alloc() related API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169811462636.8734.17177752915706845046.git-patchwork-notify@kernel.org>
Date: Tue, 24 Oct 2023 02:30:26 +0000
References: <20231020095952.11055-1-linyunsheng@huawei.com>
In-Reply-To: <20231020095952.11055-1-linyunsheng@huawei.com>
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

On Fri, 20 Oct 2023 17:59:47 +0800 you wrote:
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
  - [net-next,v12,1/5] page_pool: unify frag_count handling in page_pool_is_last_frag()
    https://git.kernel.org/netdev/net-next/c/58d53d8f7da6
  - [net-next,v12,2/5] page_pool: remove PP_FLAG_PAGE_FRAG
    https://git.kernel.org/netdev/net-next/c/09d96ee5674a
  - [net-next,v12,3/5] page_pool: introduce page_pool_alloc() API
    https://git.kernel.org/netdev/net-next/c/de97502e16fc
  - [net-next,v12,4/5] page_pool: update document about fragment API
    https://git.kernel.org/netdev/net-next/c/8ab32fa1c794
  - [net-next,v12,5/5] net: veth: use newly added page pool API for veth with xdp
    https://git.kernel.org/netdev/net-next/c/2d0de67da51a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



