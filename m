Return-Path: <bpf+bounces-17843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8596381353B
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 16:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437A8282BB8
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 15:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890085D913;
	Thu, 14 Dec 2023 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LB/guP7H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADB355784;
	Thu, 14 Dec 2023 15:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B4D6C433C9;
	Thu, 14 Dec 2023 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702569025;
	bh=Iq8kyJNKL8EsBXQNMtORwvAPCkpQnVLEfrzy0pbicpc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LB/guP7H20lc0+0rjUvIRoP0tAcsVezsaWCQ9sofJvhl9J1WGabMu/ynNpuRRruh8
	 ZkyUo5V5TP8PMvRW71HBtLXi0lKkglVkuZE8phzEQ80SJf64Zz7j1Fj1JpOMzzpyNF
	 hVVtCkm14XhFKAPTO8MiBodDJGRAdbzTXOS/zgSgwgggbMBStmY0TfF01KbYsX04ZS
	 PvT2eo4gkU+HR4XiD+f4/M8in/jCq/DtWaClKxNgm2ZXiOB/bp4pMctEKUUBNKEvi6
	 idt4zUugoH9xll17WjupnrYKE4pvEojABoQbBBK3MFLzmoOUsUlY+qIz+vgpFjlKsH
	 OryIqkkQhlnxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64BEBDD4EF9;
	Thu, 14 Dec 2023 15:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net, xdp: correct grammar
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170256902540.17867.3583568290757816832.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 15:50:25 +0000
References: <20231213043735.30208-1-rdunlap@infradead.org>
In-Reply-To: <20231213043735.30208-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 12 Dec 2023 20:37:35 -0800 you wrote:
> Use the correct verb form in 2 places.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: bpf@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - net, xdp: correct grammar
    https://git.kernel.org/bpf/bpf-next/c/04d25ccea2b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



