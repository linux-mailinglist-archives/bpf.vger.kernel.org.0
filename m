Return-Path: <bpf+bounces-5234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADD0758B29
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 04:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B79C1C20EDF
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 02:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3560B1844;
	Wed, 19 Jul 2023 02:10:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4E817D0;
	Wed, 19 Jul 2023 02:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A211C433C9;
	Wed, 19 Jul 2023 02:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689732620;
	bh=poVVHrUBMd8F9huC+xKBbnOmhxNE0g5urHIShi5ba3Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jcWeVluxVXSyxrXIyblyuz2xdNaHHd+oFSVIpBrg6GMia1fUJ4WR1l8ESNFR4HYe4
	 uJzYLxA5Ib3pfFy03QiXGB9YnlcJFailDpHhCGltYt81oFjA7ERmZGRy4gJxuT0O35
	 f5d5AYBHViw+Gcbv4REJ/HGEWxM6sIEnosFWdFHwlNOSCiANd8VmpifAY/80fg4PeH
	 AiVX2qGg5WhKm0AiGy6QjE07VlG+0hnGfzJnktXb5LK189AatMgRBz0IEYlUozfy34
	 VOH4m6AiLvxajNlXLdjk4uYRMNx+OtE70EGULJd78A4pVTCH8eF5seJbA/CZge2w90
	 etWVfn1jqnANQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F118DE22AE5;
	Wed, 19 Jul 2023 02:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] igc: Prevent garbled TX queue with XDP ZEROCOPY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168973261998.24960.5359702731824253813.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 02:10:19 +0000
References: <20230717175444.3217831-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230717175444.3217831-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, florian.kauer@linutronix.de,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, sasha.neftin@intel.com, kurt@linutronix.de,
 vinicius.gomes@intel.com, simon.horman@corigine.com,
 naamax.meir@linux.intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jul 2023 10:54:44 -0700 you wrote:
> From: Florian Kauer <florian.kauer@linutronix.de>
> 
> In normal operation, each populated queue item has
> next_to_watch pointing to the last TX desc of the packet,
> while each cleaned item has it set to 0. In particular,
> next_to_use that points to the next (necessarily clean)
> item to use has next_to_watch set to 0.
> 
> [...]

Here is the summary with links:
  - [net] igc: Prevent garbled TX queue with XDP ZEROCOPY
    https://git.kernel.org/netdev/net/c/78adb4bcf99e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



