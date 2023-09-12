Return-Path: <bpf+bounces-9755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA6A79D3EB
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 16:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16178281B00
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7B918AE3;
	Tue, 12 Sep 2023 14:40:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956E72F21;
	Tue, 12 Sep 2023 14:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03148C433CA;
	Tue, 12 Sep 2023 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694529626;
	bh=bp90RXvGEYNKRmENjrRMrhsaEwI6XXV5XVFyveBoDvo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hQf9x+eO36wspBZ2ZeQm+kFFwqYEvnSn7owRzpVEp/TPig6Gf0hFZALfrWFhi8M1K
	 BEOmMpTb0HMtja33xN9qArrVjicViIWJqBt/xEtLUMIkSuPiWP9r1we+lqoR+Wfvl8
	 SAkr/8E6Ra6r3pt9VijlAdGL0uUM1UDCTCgFVkau21dkRM3MlyAZHfLnbVKuuzV2Wz
	 Tgbc1l/iqtBgYNTQGrYYpbRUQmhUQoU+vuK4UDT5MMMdhNRoK3+uczIW0dJC9fT/mf
	 DGrSUcy6jUU4XOIchKpBOi7hi7YYTnByJfo4JG75/9m8zg2Ddkj7zKLTy+9T2SMU/Z
	 /g8TFDn5tSMYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1011C04DD9;
	Tue, 12 Sep 2023 14:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] veth: Update XDP feature set when bringing up device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169452962591.21788.1197426295551689934.git-patchwork-notify@kernel.org>
Date: Tue, 12 Sep 2023 14:40:25 +0000
References: <20230911135826.722295-1-toke@redhat.com>
In-Reply-To: <20230911135826.722295-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, lorenzo@kernel.org, memxor@gmail.com,
 sdf@google.com, gerhard@engleder-embedded.com, horms@kernel.org,
 alardam@gmail.com, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 11 Sep 2023 15:58:25 +0200 you wrote:
> There's an early return in veth_set_features() if the device is in a down
> state, which leads to the XDP feature flags not being updated when enabling
> GRO while the device is down. Which in turn leads to XDP_REDIRECT not
> working, because the redirect code now checks the flags.
> 
> Fix this by updating the feature flags after bringing the device up.
> 
> [...]

Here is the summary with links:
  - [net] veth: Update XDP feature set when bringing up device
    https://git.kernel.org/netdev/net/c/7a6102aa6df0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



