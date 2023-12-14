Return-Path: <bpf+bounces-17750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 551CB8123E7
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 01:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9EC1F21A8D
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C18644;
	Thu, 14 Dec 2023 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bmz6VBbo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E6A389;
	Thu, 14 Dec 2023 00:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 577F0C433C9;
	Thu, 14 Dec 2023 00:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702513831;
	bh=9g6Jw7jQMW4DBMMjTRFcmVDsDjXvxNPEQuKPf9QHE2k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bmz6VBboWEHTtU3pVIM7dxNdGivW22/D19THN3Jb0T4aFgyfl1cIr185XqhFcxyGo
	 I6P6Qure3ZkiGC1YbTc+sL54SNMj17gyXkd3BLeMr58mBvQh6conSsbmjWGJ5MOlId
	 XiXOXvk4L228blyxTrXrlJ86qrfe+i80y476FCDgK5/pxScDKtw6VNmXetJBR0EImr
	 QvbMW1RRouilgLGyG+2s9RxbIW6/Wpn2j+I3uxkt0zbiWf6MP97oIApq7eHXHEFa7l
	 gfKQcNw/qtZX8hb9Ni0GPlQcIQEvsMUFjFb48j2/2n+GqSVUIsVMn8v6orgqZNZ96o
	 QmSFHSGHposkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 377AFC4314C;
	Thu, 14 Dec 2023 00:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v8 00/18] XDP metadata via kfuncs for ice + VLAN hint
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170251383122.31876.14972412954023662585.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 00:30:31 +0000
References: <20231205210847.28460-1-larysa.zaremba@intel.com>
In-Reply-To: <20231205210847.28460-1-larysa.zaremba@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, dsahern@gmail.com, kuba@kernel.org,
 willemb@google.com, hawk@kernel.org, anatoly.burakov@intel.com,
 alexandr.lobakin@intel.com, magnus.karlsson@gmail.com, mtahhan@redhat.com,
 xdp-hints@xdp-project.net, netdev@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, alexei.starovoitov@gmail.com,
 tariqt@mellanox.com, saeedm@mellanox.com, maciej.fijalkowski@intel.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  5 Dec 2023 22:08:29 +0100 you wrote:
> This series introduces XDP hints via kfuncs [0] to the ice driver.
> 
> Series brings the following existing hints to the ice driver:
>  - HW timestamp
>  - RX hash with type
> 
> Series also introduces VLAN tag with protocol XDP hint, it now be accessed by
> XDP and userspace (AF_XDP) programs. They can also be checked with xdp_metadata
> test and xdp_hw_metadata program.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v8,01/18] ice: make RX hash reading code more reusable
    https://git.kernel.org/bpf/bpf-next/c/9244384e811e
  - [bpf-next,v8,02/18] ice: make RX HW timestamp reading code more reusable
    https://git.kernel.org/bpf/bpf-next/c/3310aad20def
  - [bpf-next,v8,03/18] ice: Make ptype internal to descriptor info processing
    https://git.kernel.org/bpf/bpf-next/c/6b62a4214903
  - [bpf-next,v8,04/18] ice: Introduce ice_xdp_buff
    https://git.kernel.org/bpf/bpf-next/c/d951c14ad237
  - [bpf-next,v8,05/18] ice: Support HW timestamp hint
    https://git.kernel.org/bpf/bpf-next/c/9031d5f491b9
  - [bpf-next,v8,06/18] ice: Support RX hash XDP hint
    https://git.kernel.org/bpf/bpf-next/c/0e6a7b095970
  - [bpf-next,v8,07/18] xsk: add functions to fill control buffer
    https://git.kernel.org/bpf/bpf-next/c/b4e352ff1169
  - [bpf-next,v8,08/18] ice: Support XDP hints in AF_XDP ZC mode
    https://git.kernel.org/bpf/bpf-next/c/d68d707dcbbf
  - [bpf-next,v8,09/18] xdp: Add VLAN tag hint
    https://git.kernel.org/bpf/bpf-next/c/e6795330f88b
  - [bpf-next,v8,10/18] ice: Implement VLAN tag hint
    https://git.kernel.org/bpf/bpf-next/c/714ed949c6f3
  - [bpf-next,v8,11/18] ice: use VLAN proto from ring packet context in skb path
    https://git.kernel.org/bpf/bpf-next/c/b591137c4ec3
  - [bpf-next,v8,12/18] veth: Implement VLAN tag XDP hint
    https://git.kernel.org/bpf/bpf-next/c/fca783799f64
  - [bpf-next,v8,13/18] net: make vlan_get_tag() return -ENODATA instead of -EINVAL
    https://git.kernel.org/bpf/bpf-next/c/537fec0733c4
  - [bpf-next,v8,14/18] mlx5: implement VLAN tag XDP hint
    https://git.kernel.org/bpf/bpf-next/c/7978bad4b6b9
  - [bpf-next,v8,15/18] selftests/bpf: Allow VLAN packets in xdp_hw_metadata
    https://git.kernel.org/bpf/bpf-next/c/e71a9fa7fdb2
  - [bpf-next,v8,16/18] selftests/bpf: Add flags and VLAN hint to xdp_hw_metadata
    https://git.kernel.org/bpf/bpf-next/c/8e68a4beba94
  - [bpf-next,v8,17/18] selftests/bpf: Add AF_INET packet generation to xdp_metadata
    https://git.kernel.org/bpf/bpf-next/c/a3850af4ea25
  - [bpf-next,v8,18/18] selftests/bpf: Check VLAN tag and proto in xdp_metadata
    https://git.kernel.org/bpf/bpf-next/c/4c6612f6100c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



