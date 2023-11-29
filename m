Return-Path: <bpf+bounces-16193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C023A7FE40B
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 00:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20E21C2094B
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 23:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D50247A56;
	Wed, 29 Nov 2023 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw7SoYcK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C5C46B92;
	Wed, 29 Nov 2023 23:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D9FFC433CA;
	Wed, 29 Nov 2023 23:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701299427;
	bh=rXWWdIwNwFR58FE7bBu6UPEyak7iQY9m/qfQbZm1gL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zw7SoYcKgvwjdvTT1EtRzHJMgI0Fu+o/xFcBsX70ecJYts+/rn+uYfFQ/KEEisNP5
	 oOXhRBt6so2QG6kxRum9mBUfItCp8khDERQxiqvKUN2TgdZlw+Iu18RLQ/J4gUGkRw
	 Sgk5hlFd7ovsDtpAUgOq7vjYSriwZyM/LwGhuXOH+/S6BYwZG1aWg3kQ/k8oVxRwTz
	 B728gPzA+ds+W+oiTOdSR+imJ5QoDbXk/PgoFJ29ptT8VsKQ+hdZWQXuYxRkttC6E7
	 RvOG7a+xbZ079pgyvnih1pjoIG4Bc9PVnJGZ0B1g8XcIGxUpX9pLCCQuTdMNZd3YRr
	 BKXQ5dgBtcKIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4388EDFAA84;
	Wed, 29 Nov 2023 23:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 00/13] xsk: TX metadata
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170129942727.25575.2476044025307341580.git-patchwork-notify@kernel.org>
Date: Wed, 29 Nov 2023 23:10:27 +0000
References: <20231127190319.1190813-1-sdf@google.com>
In-Reply-To: <20231127190319.1190813-1-sdf@google.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com,
 dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
 maciej.fijalkowski@intel.com, hawk@kernel.org, yoong.siang.song@intel.com,
 netdev@vger.kernel.org, xdp-hints@xdp-project.net

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 27 Nov 2023 11:03:06 -0800 you wrote:
> This series implements initial TX metadata (offloads) for AF_XDP.
> See patch #2 for the main implementation and mlx5/stmmac ones for the
> example on how to consume the metadata on the device side.
> 
> Starting with two types of offloads:
> - request TX timestamp (and write it back into the metadata area)
> - request TX checksum offload
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,01/13] xsk: Support tx_metadata_len
    https://git.kernel.org/bpf/bpf-next/c/341ac980eab9
  - [bpf-next,v6,02/13] xsk: Add TX timestamp and TX checksum offload support
    https://git.kernel.org/bpf/bpf-next/c/48eb03dd2630
  - [bpf-next,v6,03/13] tools: ynl: Print xsk-features from the sample
    https://git.kernel.org/bpf/bpf-next/c/9276009d35d3
  - [bpf-next,v6,04/13] net/mlx5e: Implement AF_XDP TX timestamp and checksum offload
    https://git.kernel.org/bpf/bpf-next/c/ec706a860eba
  - [bpf-next,v6,05/13] net: stmmac: Add Tx HWTS support to XDP ZC
    https://git.kernel.org/bpf/bpf-next/c/1347b419318d
  - [bpf-next,v6,06/13] xsk: Document tx_metadata_len layout
    https://git.kernel.org/bpf/bpf-next/c/9620e956d5b5
  - [bpf-next,v6,07/13] xsk: Validate xsk_tx_metadata flags
    https://git.kernel.org/bpf/bpf-next/c/ce59f9686e0e
  - [bpf-next,v6,08/13] xsk: Add option to calculate TX checksum in SW
    https://git.kernel.org/bpf/bpf-next/c/11614723af26
  - [bpf-next,v6,09/13] selftests/xsk: Support tx_metadata_len
    https://git.kernel.org/bpf/bpf-next/c/df3ed0003ec4
  - [bpf-next,v6,10/13] selftests/bpf: Add csum helpers
    https://git.kernel.org/bpf/bpf-next/c/f6642de0c3e9
  - [bpf-next,v6,11/13] selftests/bpf: Add TX side to xdp_metadata
    https://git.kernel.org/bpf/bpf-next/c/40808a237d9c
  - [bpf-next,v6,12/13] selftests/bpf: Convert xdp_hw_metadata to XDP_USE_NEED_WAKEUP
    https://git.kernel.org/bpf/bpf-next/c/12b4b7963d3c
  - [bpf-next,v6,13/13] selftests/bpf: Add TX side to xdp_hw_metadata
    https://git.kernel.org/bpf/bpf-next/c/60523115c1b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



