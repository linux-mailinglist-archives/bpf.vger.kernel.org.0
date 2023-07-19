Return-Path: <bpf+bounces-5344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B5B759C0B
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 19:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703A22819B4
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 17:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10801FB44;
	Wed, 19 Jul 2023 17:10:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA920800;
	Wed, 19 Jul 2023 17:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54A0AC433C7;
	Wed, 19 Jul 2023 17:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689786626;
	bh=bOaXy+PGLlJn8I0K7pnq5buiHn4QTxMQ16ptcuUNH2s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KeqNzkIW///HE/FRmZ9+yPoghaScd42TAazSvn54WdlVowhRtC+jObGgs3V3S8UPI
	 kuyWahpOKJ7+BZ9gzrlwE1Mlg0Xbhx+7ypYCiP7ezM8DG9p4lepJu1ulrQt7tPgA1G
	 hBT9XU1szunwxtoQ0vXqVijJQjN2kLw1B1l7lMBJhRvpxzlGWSp+mgK6beDx/PKeE9
	 PloX6BKr3l2QFrZ5dsX4lEP2V93ELsuWLZdq5OcZzn9/zk5bZCj41Ekh/OvP9kJdm2
	 xIvdAKok/WFL6ikuTCN2P7HKQIhNsK6PFox7Hybr0yzXyeqpPl+p6m7codAA/3aIOC
	 kReywcCIb2BeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26435E21EFA;
	Wed, 19 Jul 2023 17:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 bpf-next 00/24] xsk: multi-buffer support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168978662615.29125.14969531440674735433.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 17:10:26 +0000
References: <20230719132421.584801-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20230719132421.584801-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 bjorn@kernel.org, toke@kernel.org, kuba@kernel.org, horms@kernel.org,
 tirthendu.sarkar@intel.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 19 Jul 2023 15:23:57 +0200 you wrote:
> v6->v7:
> - rebase...[Alexei]
> 
> v5->v6:
> - update bpf_xdp_query_opts__last_field in patch 10 [Alexei]
> 
> v4->v5:
> - align options argument size to match options from xdp_desc [Benjamin]
> - cleanup skb from xdp_sock on socket termination [Toke]
> - introduce new netlink attribute for letting user space know about Tx
>   frag limit; this substitutes xdp_features flag previously dedicated
>   for setting ZC multi-buffer support [Toke, Jakub]
> - include i40e ZC multi-buffer support
> - enable TOO_MANY_FRAGS for ZC on xskxceiver; this is now possible due
>   to netlink attribute mentioned two bullets above
> 
> [...]

Here is the summary with links:
  - [v7,bpf-next,01/24] xsk: prepare 'options' in xdp_desc for multi-buffer use
    https://git.kernel.org/bpf/bpf-next/c/63a64a56bc3f
  - [v7,bpf-next,02/24] xsk: introduce XSK_USE_SG bind flag for xsk socket
    https://git.kernel.org/bpf/bpf-next/c/81470b5c3c66
  - [v7,bpf-next,03/24] xsk: prepare both copy and zero-copy modes to co-exist
    https://git.kernel.org/bpf/bpf-next/c/556444c4e683
  - [v7,bpf-next,04/24] xsk: move xdp_buff's data length check to xsk_rcv_check
    https://git.kernel.org/bpf/bpf-next/c/faa91b839b09
  - [v7,bpf-next,05/24] xsk: add support for AF_XDP multi-buffer on Rx path
    https://git.kernel.org/bpf/bpf-next/c/804627751b42
  - [v7,bpf-next,06/24] xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path
    https://git.kernel.org/bpf/bpf-next/c/b7f72a30e9ac
  - [v7,bpf-next,07/24] xsk: allow core/drivers to test EOP bit
    https://git.kernel.org/bpf/bpf-next/c/1b725b0c8163
  - [v7,bpf-next,08/24] xsk: add support for AF_XDP multi-buffer on Tx path
    https://git.kernel.org/bpf/bpf-next/c/cf24f5a5feea
  - [v7,bpf-next,09/24] xsk: discard zero length descriptors in Tx path
    https://git.kernel.org/bpf/bpf-next/c/07428da9e25a
  - [v7,bpf-next,10/24] xsk: add new netlink attribute dedicated for ZC max frags
    https://git.kernel.org/bpf/bpf-next/c/13ce2daa259a
  - [v7,bpf-next,11/24] xsk: support mbuf on ZC RX
    https://git.kernel.org/bpf/bpf-next/c/24ea50127ecf
  - [v7,bpf-next,12/24] ice: xsk: add RX multi-buffer support
    https://git.kernel.org/bpf/bpf-next/c/1bbc04de607b
  - [v7,bpf-next,13/24] i40e: xsk: add RX multi-buffer support
    https://git.kernel.org/bpf/bpf-next/c/1c9ba9c14658
  - [v7,bpf-next,14/24] xsk: support ZC Tx multi-buffer in batch API
    https://git.kernel.org/bpf/bpf-next/c/d5581966040f
  - [v7,bpf-next,15/24] ice: xsk: Tx multi-buffer support
    https://git.kernel.org/bpf/bpf-next/c/eeb2b5381038
  - [v7,bpf-next,16/24] i40e: xsk: add TX multi-buffer support
    https://git.kernel.org/bpf/bpf-next/c/a92b96c4ae10
  - [v7,bpf-next,17/24] xsk: add multi-buffer documentation
    https://git.kernel.org/bpf/bpf-next/c/49ca37d0d825
  - [v7,bpf-next,18/24] selftests/xsk: transmit and receive multi-buffer packets
    https://git.kernel.org/bpf/bpf-next/c/17f1034dd76d
  - [v7,bpf-next,19/24] selftests/xsk: add basic multi-buffer test
    https://git.kernel.org/bpf/bpf-next/c/f540d44e05cf
  - [v7,bpf-next,20/24] selftests/xsk: add unaligned mode test for multi-buffer
    https://git.kernel.org/bpf/bpf-next/c/1005a226da9a
  - [v7,bpf-next,21/24] selftests/xsk: add invalid descriptor test for multi-buffer
    https://git.kernel.org/bpf/bpf-next/c/697604492b64
  - [v7,bpf-next,22/24] selftests/xsk: add metadata copy test for multi-buff
    https://git.kernel.org/bpf/bpf-next/c/f80ddbec4762
  - [v7,bpf-next,23/24] selftests/xsk: add test for too many frags
    https://git.kernel.org/bpf/bpf-next/c/807bf4da2049
  - [v7,bpf-next,24/24] selftests/xsk: reset NIC settings to default after running test suite
    https://git.kernel.org/bpf/bpf-next/c/3666bccab43a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



