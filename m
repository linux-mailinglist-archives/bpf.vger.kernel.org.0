Return-Path: <bpf+bounces-4825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B5E74FDBF
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 05:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A9A1C20EF1
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 03:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DB21FD6;
	Wed, 12 Jul 2023 03:30:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10BEA34;
	Wed, 12 Jul 2023 03:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B2D4C433C9;
	Wed, 12 Jul 2023 03:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689132621;
	bh=F5OHTJmsvWsPBg+s9YyEg55V9UBjn5vIWY2oXUbvAEw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LFCdBy3SzsUx5B4A9P8Ux7idfyGF0ELTFUjTtmYv3TpymD1Omwxv7YFQar4jKAVgL
	 8Cl2Gtn8f93a/LvlYXGRy4k0LAtwrXgV+bap1wpxIXcf4eFntXVmk2/VBOsSisChEG
	 ywN3NISTjwArsuUvAf4MPDGgEHfiEpbGKwX7r5gzKJGwtkXuO3/JUPLTxiSMhqIOs1
	 ovYN3ODnRj84Znbfver/TApoHT8oOfcDivsSM8n/Hxg04vvt3y9qS6/yupsnwTQ7mP
	 doAylzVfiAC2O/eE4bXrZKw+xE9CzVEfOgY81uSQIQFLqmMMFIXGgdGLtiTpMnjTAh
	 TpxqQeNmuUU2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D632E29F44;
	Wed, 12 Jul 2023 03:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] docs: netdev: update the URL of the status page
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168913262124.27250.13393462797556521653.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jul 2023 03:30:21 +0000
References: <20230710174636.1174684-1-kuba@kernel.org>
In-Reply-To: <20230710174636.1174684-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, bpf@vger.kernel.org, linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Jul 2023 10:46:36 -0700 you wrote:
> Move the status page from vger to the same server as mailbot.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> BPF folks, I see a mention of the status page in your FAQ, too,
> but I'm leaving it to you to update, cause I'm not sure how
> up to date that section is.
> 
> [...]

Here is the summary with links:
  - [net] docs: netdev: update the URL of the status page
    https://git.kernel.org/netdev/net/c/cf28792facaa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



