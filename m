Return-Path: <bpf+bounces-17021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F68808F39
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 19:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACEF28172D
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 18:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF3C4BA8D;
	Thu,  7 Dec 2023 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hV2rV9+A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6534648CC0;
	Thu,  7 Dec 2023 18:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31193C433CA;
	Thu,  7 Dec 2023 18:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701972027;
	bh=uu/RVflGmVezJjUQpsx8LNdGcFwmKQvh2wiX4JPP2YQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hV2rV9+ARMVTv7TuNL/n04VBoZHaGE5h+pcCpU7h7Yie0Xf4yzjfYcJVjLVuLJOsT
	 G78/FvanmTz/sZdlEs7s/Tf/xu0wqX7L7B+KAhFAtbnEpzIW7Fu/V4RXfdI7uK+RZP
	 5FFNxqX3+n1vKE10H1NOHF57LJZwwSQh12PcFH8HjZHYm9Kt/cMWvDfST2En5zbbGA
	 4MDi10XKHW7bSdsg3lQRbCTPK/41b+OUR+bkGboQzQWj4wCEDMyrg9FiXvaQGkjkOV
	 Z74I8GXfcg5UD7EOfVvuv+U0vFY5oSr8BnKeForeIziZG3ysT6sWvKqaPyMWAnkA9Z
	 a37yg/Fmsk+rA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19382C40C5E;
	Thu,  7 Dec 2023 18:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] fixes for ktls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170197202710.7796.9621509944364172901.git-patchwork-notify@kernel.org>
Date: Thu, 07 Dec 2023 18:00:27 +0000
References: <20231206232706.374377-1-john.fastabend@gmail.com>
In-Reply-To: <20231206232706.374377-1-john.fastabend@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: kuba@kernel.org, jannh@google.com, daniel@iogearbox.net,
 borisp@nvidia.com, bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Dec 2023 15:27:04 -0800 you wrote:
> Couple fixes for TLS and BPF interactions.
> 
> John Fastabend (2):
>   net: tls, update curr on splice as well
>   bpf: sockmap, updating the sg structure should also update curr
> 
>  net/core/filter.c | 19 +++++++++++++++++++
>  net/tls/tls_sw.c  |  2 ++
>  2 files changed, 21 insertions(+)

Here is the summary with links:
  - [net,1/2] net: tls, update curr on splice as well
    https://git.kernel.org/netdev/net/c/c5a595000e26
  - [net,2/2] bpf: sockmap, updating the sg structure should also update curr
    https://git.kernel.org/netdev/net/c/bb9aefde5bba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



