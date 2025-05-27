Return-Path: <bpf+bounces-58984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82147AC4BE0
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 12:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C4E3B79AC
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 09:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04127255F33;
	Tue, 27 May 2025 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJKoEI3l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FCC254AF3;
	Tue, 27 May 2025 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748339999; cv=none; b=OSceZlPbG+azvnMx5bdPWbX15dDqOl2kO2d5l39C64sUrEiTthRl7qtdq7vIDIbyiVzt2TIe1A9c3TVZ8S2QKU4fNV4hAQUpEIZqK/RQJ9OubSHzm0ti3d0nMuluR72mkGRYSViz/flqo9aN3ZrQr6el5V0R5uJeZXOjrzIQFGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748339999; c=relaxed/simple;
	bh=MViKN2+i9zzdGHsc7eYtQ0YzQSzoXPV/RafepRFlVfc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HhGW8fuDpZRGfp7lIxzTILeV0onRMtVH9C2XCQ5HOatWMLwDTBrGYGmv9JKU5rtpzQyZG2ZpdinDqCsVpmjEe0Qa7FmtvPyddUCaC46JBQQ5VKeNw1ewXCrNOCLdwXjGXXCsj6/DoHaAH3js0yLF9iby/gF/jDWRiBGRYTv/bVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJKoEI3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF20FC4CEEE;
	Tue, 27 May 2025 09:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748339998;
	bh=MViKN2+i9zzdGHsc7eYtQ0YzQSzoXPV/RafepRFlVfc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sJKoEI3lf3rEFIzhUe/PWajMZRg6WJpVveJpKbuKezfqZsaJK4Ps3lE4ZR7X/6T4T
	 M4k6uuGQTp7OYNmAsymcCNaxzezWaRTva8Y1cQaMPfzQvomUsbzvBZsEOWbzkLO51j
	 1QLxH4nRTP7ttiwQol5HsIea4Ck1wPFg3sX1cQpYZSBOm4g/7ADUkcT0hiR3GPxVE2
	 iqNU2Jg0ohiSb4pUDJURyCKxm7TFuE34KRj23giZQX6HzRZbGW5PRk1kfLZqlg8P08
	 L8XxVaGsSNd6PufNH0zLlWqRL68zSYA7eDV67mjoXKHDHQm0+F3AndVCkR+YZbTB5T
	 dsUc9FHeRDGyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E4B380AAE2;
	Tue, 27 May 2025 10:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] xsk: add missing virtual address conversion for
 page
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174834003324.1237935.11428627748212887379.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 10:00:33 +0000
References: <20250522040115.5057-1-minhquangbui99@gmail.com>
In-Reply-To: <20250522040115.5057-1-minhquangbui99@gmail.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, maciej.fijalkowski@intel.com, aleksander.lobakin@intel.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 22 May 2025 11:01:15 +0700 you wrote:
> In commit 7ead4405e06f ("xsk: convert xdp_copy_frags_from_zc() to use
> page_pool_dev_alloc()"), when converting from netmem to page, I missed a
> call to page_address() around skb_frag_page(frag) to get the virtual
> address of the page. This commit uses skb_frag_address() helper to fix
> the issue.
> 
> Fixes: 7ead4405e06f ("xsk: convert xdp_copy_frags_from_zc() to use page_pool_dev_alloc()")
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] xsk: add missing virtual address conversion for page
    https://git.kernel.org/netdev/net-next/c/28fcb4b56f92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



