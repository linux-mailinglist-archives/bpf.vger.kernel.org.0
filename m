Return-Path: <bpf+bounces-46808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96F79F02C7
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 03:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3C4286177
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 02:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B39713A26D;
	Fri, 13 Dec 2024 02:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfXjMGvL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BC6BFC0;
	Fri, 13 Dec 2024 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734058218; cv=none; b=fJ6NA+yYHT6uwUra1usH2CIx0rnz+IgnLlrVwK0mwiS+Poh1ANtPtKbENrf+a1a8vLrIO3XWNEm6l7IImk9nuNyiX0nGTPx1e0Ok06MWnmb4oudJEp2/WL9QzC9TUGFMjVJYYyZIbKr1Cdj+6Dt7UxFnhn2s9XRay3M2DqnrHPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734058218; c=relaxed/simple;
	bh=USF7+U0trWyA2gN7isJIs25+Ht1uQL9/zoEzOJkdHpM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BVzpL6kSUyLDjg87IbgC9wPFP4StPeSpo4BdICI8LJPTHoBzPwrVjybXCVIqzNQ3JrfcwRzFb0jGEoUFbaGrDSdLrkYSY0KoG6QDHuq+QlIFAMkeU/BETgkMppE2aApMVi+ewYCLEfVkMFJ5gddV8Jo4hpnJerrpbPRIoa8QFFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfXjMGvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD84C4CED7;
	Fri, 13 Dec 2024 02:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734058218;
	bh=USF7+U0trWyA2gN7isJIs25+Ht1uQL9/zoEzOJkdHpM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RfXjMGvLvKMDlsT/HSmcGiUfMwwsr/bp2jimZA5vI9dXiDtM63tN/WyHH836oYSkV
	 z2ormscre21QF8zHKCuBMrE8vLN629H2hDAMHvzKQNHCcegMxfTOgfl1dRatPdjqgx
	 /BvUPOubtv+awKMxbZsDdsW49g9W02lxoJ7Od5dPz0johqBgEGv6i0XyOcvJX/m3Jv
	 4FTLbONj8Lwz55C9DJCxriWUYivzXK/VMeslOYJv+/pjkwAXcFL9jmRVQJwPfyOfvp
	 hk5YLVkQV5ySR2gJ1ehJ7uh2FS6f9WqA/eYRqy4xf46q/mhkAytcLxbtsN6Z6wS2XZ
	 IkD3lnh/XvkRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEF6380A959;
	Fri, 13 Dec 2024 02:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/12] xdp: a fistful of generic changes pt. II
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173405823427.2517381.8533114389826490675.git-patchwork-notify@kernel.org>
Date: Fri, 13 Dec 2024 02:50:34 +0000
References: <20241211172649.761483-1-aleksander.lobakin@intel.com>
In-Reply-To: <20241211172649.761483-1-aleksander.lobakin@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, peterz@infradead.org,
 jpoimboe@kernel.org, jose.marchesi@oracle.com, toke@redhat.com,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 przemyslaw.kitszel@intel.com, jbaron@akamai.com, casey@schaufler-ca.com,
 nathan@kernel.org, nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Dec 2024 18:26:37 +0100 you wrote:
> XDP for idpf is currently 5.5 chapters:
> * convert Rx to libeth;
> * convert Tx and stats to libeth;
> * generic XDP and XSk code changes;
> * generic XDP and XSk code additions (you are here);
> * actual XDP for idpf via new libeth_xdp;
> * XSk for idpf (via ^).
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] page_pool: allow mixing PPs within one bulk
    https://git.kernel.org/netdev/net-next/c/fcc680a647ba
  - [net-next,02/12] xdp: get rid of xdp_frame::mem.id
    (no matching commit)
  - [net-next,03/12] xdp: make __xdp_return() MP-agnostic
    https://git.kernel.org/netdev/net-next/c/207ff83cecae
  - [net-next,04/12] xdp: add generic xdp_buff_add_frag()
    (no matching commit)
  - [net-next,05/12] xdp: add generic xdp_build_skb_from_buff()
    (no matching commit)
  - [net-next,06/12] xsk: make xsk_buff_add_frag really add the frag via __xdp_buff_add_frag()
    (no matching commit)
  - [net-next,07/12] xsk: add generic XSk &xdp_buff -> skb conversion
    (no matching commit)
  - [net-next,08/12] xsk: add helper to get &xdp_desc's DMA and meta pointer in one go
    (no matching commit)
  - [net-next,09/12] page_pool: add a couple of netmem counterparts
    (no matching commit)
  - [net-next,10/12] skbuff: allow 2-4-argument skb_frag_dma_map()
    https://git.kernel.org/netdev/net-next/c/0dffdb3b3366
  - [net-next,11/12] jump_label: export static_key_slow_{inc,dec}_cpuslocked()
    (no matching commit)
  - [net-next,12/12] unroll: add generic loop unroll helpers
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



